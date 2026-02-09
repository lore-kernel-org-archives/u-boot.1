Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B820CEE6B73
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35562805D7;
	Mon,  9 Feb 2026 21:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rRLNyX79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025E48341A; Mon,  9 Feb 2026 21:14:29 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01D580325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7111=AO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1770668065;
 bh=rbevsxJxz4CNlQjlteVQuDIOC+GiN5U/DX5OkB/ktWo=;
 b=rRLNyX79JA7FFOnZrJmTE4MzVAAuNOdbhUlXtoQk2/xuN3INaFmwAJtBW1NT2hf3Aoy9DcIiw
 SgQ0q/BKGzvMCwep9K2SE5xv9NIJ6c9BnU+R5sRY6MHJ28agF/heVOegAGcwjIETgjCS6N+f+gy
 BS/eXJ+qUTy0TY2FMzLIf+UGqaggVphDFavMBayWbwPjdnNN77yg18HEjx95XChm+QBj4TvPAy0
 EEW2K1JvNl3ukPaIjawSOjuAsDZ3ynzFLwtx6O/ucaDDfqJ2ePWYIKMMtxv144HDIjNwxPAgs/U
 1+ArWOi/gi4hDOflcJvNyks5Prz7FA5vmd2cyDT/7TWQ==
X-Forward-Email-ID: 698a401c6d1a89e39050280c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
Date: Mon,  9 Feb 2026 20:14:12 +0000
Message-ID: <20260209201415.303190-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

clk_get_rate() in U-Boot is documented to return clock rate on success,
0 for invalid clock and -ve error code for other errors. This differ
slightly from Linux where only >= 0 is returned from clk_get_rate().

Some clock drivers take advantage of this difference and may return -ve
error code for clocks not fully supported in U-Boot.

Use IS_ERR_VALUE() to check for an error code in addition to current
invalid clock check to fix broken and unpredicted behavior when clock
driver returns a -ve error code for the ref_clk.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6f22b9232bad..5bfca580824a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -149,7 +149,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 
 	if (dwc->ref_clk) {
 		rate = clk_get_rate(dwc->ref_clk);
-		if (!rate)
+		if (IS_ERR_VALUE(rate) || !rate)
 			return;
 		period = NSEC_PER_SEC / rate;
 	} else {
-- 
2.52.0


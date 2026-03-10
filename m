Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17204FCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432F283FC0;
	Tue, 10 Mar 2026 01:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qZ9gq/nF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD24E83F75; Tue, 10 Mar 2026 01:54:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FAB83F9B
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773104090; bh=JeZkuBgEH9HiYbKGquUy9+PjNnuo6ppCO7UeWGzP61s=;
 b=qZ9gq/nFNsls90qQ4JokBM4+IKnu7PXPLl21p4VhXU0WhxLmY4a1CHzkoCtDZ/Cfn/4FytrwC
 /q/3sWogeREo8w3WyfifuCRkYkUiaadpW3cS+i2zUnoxkunxXree6/UB8ffQwRqm+Y4+CaR5oNL
 uyHafmq4uJ6lf/lQ9oJgjV9LQEKc7FeYIthhHc4TxqOM5x2ONkQqcUmKs1ge1So4/DKyBEx+w82
 7rL8flFrHlll3CjwTMp1RcSBrZN5AYA74xvdVh+r7o/2h56UtZk9ih7t7cnFYeGUHoyA0YLAMQT
 muxVk/UMySNhBOFbOa/ZX0qVDSjcOGS+aB4ybjelz3dQ==
X-Forward-Email-ID: 69af6bd973a8189bec32777f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Xuhui Lin <xuhui.lin@rock-chips.com>
Subject: [PATCH v3 03/12] rockchip: mkimage: Add support for RK3506
Date: Tue, 10 Mar 2026 00:52:58 +0000
Message-ID: <20260310005326.606079-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005326.606079-1-jonas@kwiboo.se>
References: <20260310005326.606079-1-jonas@kwiboo.se>
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

From: Xuhui Lin <xuhui.lin@rock-chips.com>

Add support for generating Rockchip Boot Image for RK3506.

The RK3506 has 48 KiB SRAM and 4 KiB is reserved for BootROM.

Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3: Collect r-b tag
v2: Collect t-b tag
---
 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index dbc1c177843a..cb2d30bfd57a 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -148,6 +148,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
 	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
+	{ "rk3506", "RK35", 0xC000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
-- 
2.53.0


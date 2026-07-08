Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5060CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0EA84ABB;
	Thu,  9 Jul 2026 00:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="INOjZni3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4254F84ABE; Thu,  9 Jul 2026 00:06:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C602584AB7
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548360; bh=4rYruVFll6tQRzqTsHCn5KLUV6I5LrbwJDv9fgUnxT4=;
 b=INOjZni35lVpa82xmCbh5uJRmXa2zCXxKYWpuhbTReLfRpEqiAlcPajXKu+p6u8KAD6z8jf0U
 k9/OuT9m/nc86/jSkCoTa6+ICgxjKnf1GVmIOZDrRtAwlzsY4PTzHF0A/uEEBnLgCNHt9XuEBNN
 nTwl5HHtlGK8tGskYfBIAp2hT5uWXDIsZE6nbtYyZt31GPsaMAfFUuOiKfcXoFvPTS0JBpHE1ZN
 30Y5Wwuc0dY5zD5DW4QqCASYm5fml83f1SCXHVfox4M3qTNYE5zJlNQ4qQPwQYWv+B+S8VCaGze
 oGYfdErVi8DDgzdOERugzHdOWcZ3Ix4B9Rg487bN4F7w==
X-Forward-Email-ID: 6a4ec9c52402b3ca75f9046e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/11] spl: Simplify xPL_BUILD conditional guard example
Date: Wed,  8 Jul 2026 22:05:31 +0000
Message-ID: <20260708220540.3368825-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

The old meaning of the SPL_BUILD symbol has been transfered to a new
XPL_BUILD symbol, leaving the SPL_BUILD symbol only to be defined for
SPL builds, and not all xPL builds.

Change to only use the SPL_BUILD symbol in the SPL code example to
cleanup from an old SPL to XPL symbol rename.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/spl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/spl.h b/include/spl.h
index 5078d7525abb..45dd44e03d13 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -93,7 +93,7 @@ enum xpl_phase_t {
  *
  * To include code only in SPL, you might do:
  *
- *    #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+ *    #ifdef CONFIG_SPL_BUILD
  *    ...
  *    #endif
  *
-- 
2.54.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777C9C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 12:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A000087C5D;
	Sat, 17 Feb 2024 13:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TG/DWDci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBFB87C5D; Sat, 17 Feb 2024 13:09:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8567187971
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 13:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708171728;
 bh=T+AfwREMHSh0xrGGQ9/cW5Cu8/O2U+Gf7ScduHqUG8s=;
 b=TG/DWDciH8Z4ndM9mKa4G0QyqJPbgRLiWZ0iI9n5UDTNHB/WSBpbIig5jbAqYm5oIPS75n+K+
 OH7Q6vFTaYhkoC1vS7SnWI62+btrAPbB2JNkZCTryPW/gQ9FE/X099hAXdyIltnuTa2Hfo2lX35
 ed6egkbak2CDUFXyl7Mfmk1RknaCO3LJmZyQclzTBYnm5Tpo+GdPvSGa5vS+mZ9RgdN1X7FIwm/
 r80xpudYyEt2GB0OwV/WNzslJvySJ+50V+3bHvDa5U3Sn99zv7vZ+R2qXdeTNiu/TLRNfd29lTI
 3rVFW71cHRrpOSZu9/zfilDKDqzTtlr4kMeBc7BSWtjQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] pinctrl: Check pinconfig nodes pre-reloc status recursively
Date: Sat, 17 Feb 2024 12:08:40 +0000
Message-ID: <20240217120842.2381465-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d0a1cfa3bb223b40940e98
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

Pinconfig nodes normally bind recursively with PINCTRL_FULL and
PINCONF_RECURSIVE enabled. However, during U-Boot proper pre-relocation
any node marked with e.g. bootph-all will not bind unless its parent is
also marked for pre-reloc.

  group1 {
      pinconf1 {
          bootph-all;
      };
  };

This cause the following warning message to be shown during U-Boot
proper pre-reloc stage on Rockchip devices, e.g on RK3568:

  ns16550_serial serial@fe660000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

and on RK3328:

  ns16550_serial serial@ff130000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

Check pinconfig nodes pre-reloc status recursively to fix this and to
make pinconfig_post_bind work same at both U-Boot proper pre-reloc and
at TPL/SPL stage.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- No change

A recent change to fdtgrep was believed to solve this however, fdtgrep
is only applied to control fdt for xPL so this issue still exist at
U-Boot proper pre-reloc stage.

Link to v1: https://patchwork.ozlabs.org/patch/1817296/
---
 drivers/pinctrl/pinctrl-uclass.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-uclass.c
index 73dd7b1038bb..fe2ba5021a78 100644
--- a/drivers/pinctrl/pinctrl-uclass.c
+++ b/drivers/pinctrl/pinctrl-uclass.c
@@ -100,6 +100,22 @@ static int pinctrl_select_state_full(struct udevice *dev, const char *statename)
 	return 0;
 }
 
+static bool ofnode_pre_reloc_recursive(ofnode parent)
+{
+	ofnode child;
+
+	if (ofnode_pre_reloc(parent))
+		return true;
+
+	if (CONFIG_IS_ENABLED(PINCONF_RECURSIVE)) {
+		ofnode_for_each_subnode(child, parent)
+			if (ofnode_pre_reloc_recursive(child))
+				return true;
+	}
+
+	return false;
+}
+
 /**
  * pinconfig_post_bind() - post binding for PINCONFIG uclass
  * Recursively bind its children as pinconfig devices.
@@ -119,7 +135,7 @@ static int pinconfig_post_bind(struct udevice *dev)
 
 	dev_for_each_subnode(node, dev) {
 		if (pre_reloc_only &&
-		    !ofnode_pre_reloc(node))
+		    !ofnode_pre_reloc_recursive(node))
 			continue;
 		/*
 		 * If this node has "compatible" property, this is not
-- 
2.43.0


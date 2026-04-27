Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0454FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA3E841DF;
	Mon, 27 Apr 2026 17:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="Z7r4MD58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3CA8419E; Mon, 27 Apr 2026 17:04:59 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBEA98410D
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202604271504537c79a7c91e00020743 for <u-boot@lists.denx.de>;
 Mon, 27 Apr 2026 17:04:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xKfh1LqiXZWINGwprlhclp8hRf7/leQkgw70DQiJ9rM=;
 b=Z7r4MD58maQW7HarKpZK2xYQt7Hb5lhDXEdzsBnoNOHYkvY9o8jOKGH+fwWn3MqRGsAj3c
 b1BL38k8OdmtfWBO/v8aqsHh0qTwA9jjPH11zqMm+ZMeg6TqxqxDSJN7itcR8zK0lqirsLdw
 O8d0z3WHr34GZDe8Q5Lb7DJwkhBTkUhu3mH/0O8zZmGJoHSG4KOQbKeG7BnGSo3zbLYnTv0F
 Tl459I2BGroiE7oY1sUZW1/vCok787GPpBCLGsKi4WAzP6JDPMTYMLghYaYPWFbJIb+aLd5l
 4hfNuIXPYgSxoNn+qf8yuZwqERVeRnRthHFtLJgOLtmsY/0/NGlSiRnQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] image-fit-sig: require signatures
Date: Mon, 27 Apr 2026 17:03:41 +0200
Message-ID: <20260427150409.400914-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260427150409.400914-1-ludwig.nussel@siemens.com>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Signature nodes in the device tree are mandatory if u-boot is compiled
with signature verification. Allowing signature verification to pass
if those nodes are missing would leave the system fail open.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 boot/image-fit-sig.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..b89b82ee58e 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -618,7 +618,6 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	int noffset;
 	int key_node;
 	int verified = 0;
-	int reqd_sigs = 0;
 	bool reqd_policy_all = true;
 	const char *reqd_mode;
 
@@ -639,9 +638,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
-		debug("%s: No signature node found: %s\n", __func__,
-		      fdt_strerror(key_node));
-		return 0;
+		log_err("No signature node found: %s\n", fdt_strerror(key_node));
+		return -EPERM;
 	}
 
 	/* Get required-mode policy property from DTB */
@@ -668,8 +666,6 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		if (!required || strcmp(required, "conf"))
 			continue;
 
-		reqd_sigs++;
-
 		ret = fit_config_verify_key(fit, conf_noffset, key_blob,
 					    noffset);
 		if (ret) {
@@ -685,8 +681,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		}
 	}
 
-	if (reqd_sigs && !verified) {
-		printf("Failed to verify 'any' of the required signature(s)\n");
+	if (!verified) {
+		log_err("Failed to verify 'any' of the required signature(s)\n");
 		return -EPERM;
 	}
 
-- 
2.43.0

base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
branch: us-qemu-signatures

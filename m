Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3A0FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BB683693;
	Thu, 30 Apr 2026 14:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="eKjroxUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B7984653; Thu, 30 Apr 2026 14:26:49 +0200 (CEST)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1083B803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2026043012264502a97dbc6300020768 for <u-boot@lists.denx.de>;
 Thu, 30 Apr 2026 14:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jziaRR3Mg9eWFKurzeIyuFMjTQ7usuJt5DKktQIpI6k=;
 b=eKjroxUJIQ6dHagdCTBZhKD5G00ZobEQ4oRuOzsttdy0QYQ00Ood7pp487kPTtjT44vV+i
 2h0pyZLo1GFpZB+6lK5Po6MyabenJmxTLrozaBa6qhBdgYPWpZedWkvYzxsbsTHMNxrSAemr
 hU11ceg/X9/VWl98GLUPVUOiGdE7uIeyAoSc6ESo6+NwskvpIFAO0CgU2VdimnGV3Xf1lEcB
 p0b6Z/kme1AzIuudPuuvtaDNVP/+PunLRQuAYVXNZNImIMYX054Olu+WMX9V3cSiJ6ds6YBv
 pzk2pL4PH6rA8SQJj7odsXkMqXoTOR87pe/OC7nUWwpDGy5e3lOWltSQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] image-fit-sig: Optionally require signatures
Date: Thu, 30 Apr 2026 14:26:02 +0200
Message-ID: <20260430142602.v2.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260430122629.606153-1-ludwig.nussel@siemens.com>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
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

If U-Boot is built with signature verification but no keys are
included in the device tree, the boot would still continue.
Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup. The
default is enabled which may break existing setups that rely on the
insecure behavior.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

Changes in v2:
  - introduce FIT_SIGNATURE_REQUIRED

 boot/Kconfig         | 10 ++++++++++
 boot/image-fit-sig.c | 12 +++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..c90eae55a60 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -124,6 +124,16 @@ config FIT_SIGNATURE
 	  format support in this case, enable it using
 	  CONFIG_LEGACY_IMAGE_FORMAT.
 
+config FIT_SIGNATURE_REQUIRED
+	bool "Require signature verification of FIT uImages"
+	depends on FIT_SIGNATURE
+	default y
+	help
+	  This option requires that FIT uImages are signed. That
+	  means the U-Boot device tree must contain public keys for
+	  verification and all configuration sections must be signed
+	  using those keys.
+
 config FIT_SIGNATURE_MAX_SIZE
 	hex "Max size of signed FIT structures"
 	depends on FIT_SIGNATURE
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..9eabf33079b 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -639,9 +639,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
-		debug("%s: No signature node found: %s\n", __func__,
-		      fdt_strerror(key_node));
-		return 0;
+		log_err("No signature node found: %s\n", fdt_strerror(key_node));
+		if (IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED))
+			return -EPERM;
+		else
+			return 0;
 	}
 
 	/* Get required-mode policy property from DTB */
@@ -685,8 +687,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		}
 	}
 
-	if (reqd_sigs && !verified) {
-		printf("Failed to verify 'any' of the required signature(s)\n");
+	if ((reqd_sigs || IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED)) && !verified) {
+		log_err("Failed to verify 'any' of the required signature(s)\n");
 		return -EPERM;
 	}
 
-- 
2.43.0


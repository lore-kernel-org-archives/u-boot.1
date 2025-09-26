Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7857CAC5B9
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09713836A6;
	Fri, 26 Sep 2025 16:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436ED836A4; Fri, 26 Sep 2025 16:14:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 29C2E8344E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C1B82BF2;
 Fri, 26 Sep 2025 07:14:28 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.32.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1EB3F5A1;
 Fri, 26 Sep 2025 07:14:34 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 14/24] efi_loader: fwu: fwu_arm_psa: Skip accepting the
 payload after set_image()
Date: Fri, 26 Sep 2025 15:13:41 +0100
Message-ID: <20250926141351.1755829-15-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
References: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Do not update the acceptance metadata bit after updating an image

The update agent (secure world) is responsible of setting the acceptance
bit in the metadata.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>

---

Changelog of changes:
===========================

v5:

* As suggested by Ilias: Make PSA handling simpler for the acceptance logic
  (less ifs)

 lib/efi_loader/efi_capsule.c |  5 +++--
 lib/fwu_updates/fwu.c        | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 234e3c1b3c0..06b502e2c25 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -704,8 +704,9 @@ static efi_status_t efi_capsule_update_firmware(
 				goto out;
 			}
 
-			log_debug("%s the accepted bit for Image %pUs\n",
-				  fw_accept_os ? "Cleared" : "Set",
+			log_debug("%s %s the accepted bit for Image %pUs\n",
+				  IS_ENABLED(CONFIG_FWU_ARM_PSA) ? "PSA will" : "",
+				  fw_accept_os ? "clear" : "set",
 				  image_type_id);
 		}
 
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 7f085a0211f..bfbb98c16d7 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -586,6 +586,14 @@ out:
  */
 int fwu_accept_image(efi_guid_t *img_type_id, u32 bank)
 {
+	/*
+	 * In case of Arm PSA accepting images is either
+	 * at ExitBootServices() or in the OS. So, let's skip setting the
+	 * acceptance bit (not used in Arm PSA)
+	 */
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA))
+		return EFI_SUCCESS;
+
 	return fwu_clrset_image_accept(img_type_id, bank,
 				       IMAGE_ACCEPT_SET);
 }
@@ -606,6 +614,14 @@ int fwu_accept_image(efi_guid_t *img_type_id, u32 bank)
  */
 int fwu_clear_accept_image(efi_guid_t *img_type_id, u32 bank)
 {
+	/*
+	 * In case of Arm PSA accepting images is either
+	 * at ExitBootServices() or in the OS. So, let's skip clearing the
+	 * acceptance bit (not used in Arm PSA)
+	 */
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA))
+		return EFI_SUCCESS;
+
 	return fwu_clrset_image_accept(img_type_id, bank,
 				       IMAGE_ACCEPT_CLEAR);
 }
-- 
2.43.0


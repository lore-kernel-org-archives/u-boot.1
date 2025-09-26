Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E2BCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A285783678;
	Fri, 26 Sep 2025 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E3F8344E; Fri, 26 Sep 2025 16:14:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7C9BF8368E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD1AB2BCD;
 Fri, 26 Sep 2025 07:14:25 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.32.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B26F3F5A1;
 Fri, 26 Sep 2025 07:14:31 -0700 (PDT)
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
Subject: [PATCH v5 13/24] efi_loader: fwu_arm_psa: Allow keeping the FMP
 payload header
Date: Fri, 26 Sep 2025 15:13:40 +0100
Message-ID: <20250926141351.1755829-14-abdellatif.elkhlifi@arm.com>
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

Allow sending the payload with its FMP header

The Secure world needs the data provided by the payload
FMP header. So, let's allow the user to keep it in
case of FWU_ARM_PSA. This is controlled with
CONFIG_FWU_KEEP_FMP_HEADER.

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

* Add CONFIG_FWU_KEEP_FMP_HEADER to control whether
  the user wants to keep the FMP header or strip it

 lib/efi_loader/efi_firmware.c | 7 +++++--
 lib/fwu_updates/Kconfig       | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 46d500966ad..61cfa791ffa 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -510,8 +510,11 @@ static void efi_firmware_get_fw_version(const void **p_image,
 		/* FMP header is inserted above the capsule payload */
 		state->fw_version = header->fw_version;
 
-		*p_image += header->header_size;
-		*p_image_size -= header->header_size;
+		if (!IS_ENABLED(CONFIG_FWU_KEEP_FMP_HEADER)) {
+			*p_image += header->header_size;
+			*p_image_size -= header->header_size;
+		}
+
 	}
 }
 
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index cdc96109f0a..29e1d441813 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -57,6 +57,14 @@ config FWU_ARM_PSA
 	  driver that supports the Arm PSA firmware update specification as
 	  mentioned in https://developer.arm.com/documentation/den0118/a/
 
+config FWU_KEEP_FMP_HEADER
+	bool "Allow sending the FMP header with the payload"
+	depends on FWU_ARM_PSA
+	default y
+	help
+	  Select this option if you do not want to strip the FMP header
+	  of the payload
+
 config FWU_BUFFER_PAGES
 	int "Number of 4KB pages in the FWU shared buffer"
 	depends on FWU_ARM_PSA
-- 
2.43.0


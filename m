Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116D7C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E2F830B3;
	Fri, 11 Jul 2025 16:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7480E830EA; Fri, 11 Jul 2025 16:50:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 76700830CE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54F1C16F8;
 Fri, 11 Jul 2025 07:50:00 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.35.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB663F738;
 Fri, 11 Jul 2025 07:50:09 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 19/25] fwu_arm_psa: Add ExitBootService() notification
 handler
Date: Fri, 11 Jul 2025 15:49:11 +0100
Message-Id: <20250711144917.1876948-20-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
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

Provide a weak function that can be overridden

Some boards need to perform custom actions on ExitBootService()
related to FWU. This function can be overridden by the board.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 lib/fwu_updates/fwu_arm_psa.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
index 7297e724569..6a829c631b0 100644
--- a/lib/fwu_updates/fwu_arm_psa.c
+++ b/lib/fwu_updates/fwu_arm_psa.c
@@ -1252,6 +1252,21 @@ static bool fwu_all_images_accepted(const struct fwu_data *fwu_data)
 	return true;
 }
 
+/**
+ * fwu_notify_exit_boot_services() - FWU notification handler
+ *
+ * Some boards need to perform custom actions on ExitBootService()
+ * related to FWU. This function can be overridden by the board.
+ *
+ * Return:
+ *
+ * EFI_SUCCESS on success. Otherwise, failure
+ */
+efi_status_t __weak fwu_notify_exit_boot_services(void)
+{
+	return EFI_SUCCESS;
+}
+
 /**
  * fwu_accept_notify_exit_boot_services() - ExitBootServices callback
  *
@@ -1292,6 +1307,8 @@ static void EFIAPI fwu_accept_notify_exit_boot_services(struct efi_event *event,
 	}
 
 out:
+	fwu_notify_exit_boot_services();
+
 	EFI_EXIT(efi_ret);
 }
 
-- 
2.25.1


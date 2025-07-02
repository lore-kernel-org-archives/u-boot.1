Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C32DC83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BE88304F;
	Wed,  2 Jul 2025 17:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD1F18304C; Wed,  2 Jul 2025 17:26:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D218082F5D
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C6B2F34;
 Wed,  2 Jul 2025 08:25:59 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73FC63F6A8;
 Wed,  2 Jul 2025 08:26:12 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 16/25] efi_loader: fwu: fwu_arm_psa: Disable trial state
 handling
Date: Wed,  2 Jul 2025 16:25:19 +0100
Message-Id: <20250702152528.1180414-17-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
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

No need for trial state handling in U-Boot for FWU Arm PSA

In FWU Arm PSA mode, trial state is handled by Secure world.

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
 lib/efi_loader/efi_capsule.c | 7 +++++--
 lib/fwu_updates/fwu.c        | 8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 1dac691d24d..113cfe30fde 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -562,7 +562,9 @@ static efi_status_t efi_capsule_update_firmware(
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		if (fwu_empty_capsule(capsule_data)) {
 			if (fwu_empty_capsule_checks_pass()) {
-				return fwu_empty_capsule_process(capsule_data);
+				return !IS_ENABLED(CONFIG_FWU_ARM_PSA) ?
+					fwu_empty_capsule_process(capsule_data) :
+					0;
 			} else {
 				log_err("FWU empty capsule checks failed. Cannot start update\n");
 				return EFI_INVALID_PARAMETER;
@@ -1377,7 +1379,8 @@ efi_status_t efi_launch_capsules(void)
 
 	efi_capsule_scan_done();
 
-	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE) &&
+	    !IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
 		if (capsule_update == true && update_status == true) {
 			ret = fwu_post_update_process(fw_accept_os);
 		} else if (capsule_update == true && update_status == false) {
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 46b6f9356a7..7ae3dfffae2 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -345,6 +345,11 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 		if (parts_ok[i])
 			continue;
 
+		if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+			log_err("FWU metadata copy %d invalid\n", i);
+			return -ENOTSYNC;
+		}
+
 		memcpy(parts_mdata[i], parts_mdata[1 - i], mdata_size);
 		err = fwu_sync_mdata(parts_mdata[i], i ? SECONDARY_PART : PRIMARY_PART);
 		if (err) {
@@ -786,7 +791,8 @@ static int fwu_boottime_checks(void)
 
 	in_trial = in_trial_state();
 
-	ret = in_trial ? fwu_trial_count_update() : trial_counter_update(NULL);
+	ret = (in_trial && !IS_ENABLED(CONFIG_FWU_ARM_PSA)) ?
+	       fwu_trial_count_update() : trial_counter_update(NULL);
 
 	if (!ret)
 		boottime_check = 1;
-- 
2.25.1


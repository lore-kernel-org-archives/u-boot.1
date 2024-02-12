Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949F7C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089BA87E52;
	Mon, 12 Feb 2024 08:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852D787E52; Mon, 12 Feb 2024 08:48:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 84ED587EFD
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92CF6DA7;
 Sun, 11 Feb 2024 23:49:00 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A543F762;
 Sun, 11 Feb 2024 23:48:15 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 12/21] efi_firmware: fwu: do not read FWU metadata on
 sandbox
Date: Mon, 12 Feb 2024 13:17:03 +0530
Message-Id: <20240212074712.3657076-13-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

The FWU metadata is being read for populating the firmware image's
version information. The sandbox platform does not have the FWU
metadata on any of it's storage devices. Skip attempting to read the
FWU metadata on the sandbox platform.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: None

 lib/efi_loader/efi_firmware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index ba5aba098c..c742e23268 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -223,7 +223,8 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 	/* get the fw_version */
 	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
 				fw_array->image_index);
-	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+	if (!IS_ENABLED(CONFIG_SANDBOX) &&
+	    IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		ret = fwu_get_active_index(&active_index);
 		if (ret)
 			return;
@@ -391,7 +392,8 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
 				image_index);
 
-	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+	if (!IS_ENABLED(CONFIG_SANDBOX) &&
+	    IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		ret = fwu_plat_get_update_index(&update_bank);
 		if (ret)
 			return EFI_INVALID_PARAMETER;
-- 
2.34.1


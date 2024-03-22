Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D6FC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4B4881CC;
	Fri, 22 Mar 2024 11:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9B0881F3; Fri, 22 Mar 2024 11:58:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DF71B881EA
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 808971063;
 Fri, 22 Mar 2024 03:59:13 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65FF33F64C;
 Fri, 22 Mar 2024 03:58:36 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 09/20] capsule: fwu: transition the platform state on a
 successful update
Date: Fri, 22 Mar 2024 16:27:22 +0530
Message-Id: <20240322105733.203888-10-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

Transition the platform to either Trial State or Regular State on a
successful update. Do this by calling the fwu_state_machine_updates()
API function.

For version 1 of the FWU metadata, the transition to Trial State is
done by starting the Trial State counter, while for version 2, in
addition to the counter, the bank_state field of the FWU metadata is
also updated to Valid.

For transitioning the platform to Regular State, no action is needed
with version 1 of the FWU metadata structure, while for version 2, the
bank_state field is set to Accepted.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Earlier patch was catering to v2 only support. These changes support
  both versions of metadata.

 lib/efi_loader/efi_capsule.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index de0d49ebeb..0937800e58 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -480,6 +480,11 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
 		if (ret != EFI_SUCCESS)
 			log_err("Unable to set the Accept bit for the image %pUs\n",
 				image_guid);
+
+		status = fwu_state_machine_updates(0, active_idx);
+		if (status < 0)
+			ret = EFI_DEVICE_ERROR;
+
 	}
 
 	return ret;
@@ -521,11 +526,10 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
 		log_err("Failed to update FWU metadata index values\n");
 	} else {
 		log_debug("Successfully updated the active_index\n");
-		if (fw_accept_os) {
-			status = fwu_trial_state_ctr_start();
-			if (status < 0)
-				ret = EFI_DEVICE_ERROR;
-		}
+		status = fwu_state_machine_updates(fw_accept_os ? 1 : 0,
+						   update_index);
+		if (status < 0)
+			ret = EFI_DEVICE_ERROR;
 	}
 
 	return ret;
-- 
2.34.1


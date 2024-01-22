Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4699AC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710748797C;
	Mon, 22 Jan 2024 12:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91B287950; Mon, 22 Jan 2024 12:55:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D7CE487B1F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621DB1FB;
 Mon, 22 Jan 2024 03:56:26 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA14D3F73F;
 Mon, 22 Jan 2024 03:55:37 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 09/18] capsule: Accept a bank on a successful update
Date: Mon, 22 Jan 2024 17:24:30 +0530
Message-Id: <20240122115439.653871-10-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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

The version 2 of the FWU metadata maintains a bank_state field per
bank, which keeps an aggregate status of the bank. A bank can either
be in a valid, invalid, or accepted state.

Update the bank_state field of the metadata once the update has gone
through successfully(when skipping Trial State), or once the images in
the bank have been accepted.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 0e6a38b441..422bb11162 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -480,6 +480,12 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
 		if (ret != EFI_SUCCESS)
 			log_err("Unable to set the Accept bit for the image %pUs\n",
 				image_guid);
+
+		status = fwu_bank_state_update(active_idx);
+		ret = fwu_to_efi_error(status);
+		if (ret != EFI_SUCCESS)
+			log_err("Unable to update the bank_state for bank %u\n",
+				active_idx);
 	}
 
 	return ret;
@@ -525,6 +531,10 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
 			status = fwu_trial_state_start(update_index);
 			if (status < 0)
 				ret = EFI_DEVICE_ERROR;
+		} else {
+			status = fwu_bank_state_update(update_index);
+			if (status < 0)
+				ret = EFI_DEVICE_ERROR;
 		}
 	}
 
-- 
2.34.1


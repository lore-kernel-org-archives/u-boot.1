Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71839CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B6B86E4A;
	Tue, 12 Sep 2023 11:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DCGzLsa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC5386E38; Tue, 12 Sep 2023 11:47:38 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4216B86E42
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id E4251212BC1C;
 Tue, 12 Sep 2023 02:47:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4251212BC1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512052;
 bh=EGWMPARytmgjLCDyQmNcuyBQe3SpnS9jC5TN7Dm81uw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DCGzLsa29gYvu4cRaKot14d3qq7dS/COw3f9+tF0tFRwTMfyEkaBVyUpSVT1/R+5p
 FF0nFKiPxi7qjqCje8Jh4QOtGnbRiu/rDfpEMPZ+DrFAN+0lmMIRCQg1X2mJ5aB1+I
 haX5+mrvHiQrdULGXDPauQ3YD6Ee+9zN1EILI3j8=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 6/8] tpm: Fix issues relating to NV Indexes
Date: Tue, 12 Sep 2023 02:47:29 -0700
Message-Id: <20230912094731.51413-7-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Sean Edmond <seanedmond@microsoft.com>

The TPM 2.0 command reference states that "auth" (type TPM2B_AUTH)
should come before "publicInfo" (type TPM2B_NV_PUBLIC) in the
"TPM2_NV_DefineSpace" command.  Let's add an empty "auth" (size 0), so
that this can work with compliant TPMs.

Make sure that NV index used in tpm2_nv_define_space() can be used
directly in the NV read/write/lock APIs.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 lib/tpm-v2.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index c3c469eb35..d3ecf556d2 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -109,7 +109,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
 	const int platform_len = sizeof(u32);
 	const int session_hdr_len = 13;
 	const int message_len = 14;
-	uint offset = TPM2_HDR_LEN + platform_len + session_hdr_len +
+	uint offset = TPM2_HDR_LEN + platform_len + session_hdr_len + 2 +
 		message_len;
 	u8 command_v2[COMMAND_BUFFER_SIZE] = {
 		/* header 10 bytes */
@@ -127,6 +127,9 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
 		0,				/* session_attrs */
 		tpm_u16(0),			/* auth_size */
 
+		/* auth value */
+		tpm_u16(0),
+
 		/* message 14 bytes + policy */
 		tpm_u16(message_len + nv_policy_size),	/* size */
 		tpm_u32(space_index),
@@ -206,7 +209,7 @@ u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
 
 		/* handles 8 bytes */
 		tpm_u32(TPM2_RH_PLATFORM),	/* Primary platform seed */
-		tpm_u32(HR_NV_INDEX + index),	/* Password authorisation */
+		tpm_u32(index),			/* nvIndex */
 
 		/* AUTH_SESSION */
 		tpm_u32(9),			/* Authorization size */
@@ -229,9 +232,14 @@ u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
 	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
 	if (ret)
 		return log_msg_ret("read", ret);
+
+	const size_t tag_offset = 0;
+	const size_t size_offset = 2;
+	const size_t code_offset = 6;
+	const size_t data_offset = 16;
 	if (unpack_byte_string(response, response_len, "wdds",
-			       0, &tag, 2, &size, 6, &code,
-			       16, data, count))
+			       tag_offset, &tag, size_offset, &size, code_offset, &code,
+			       data_offset, data, count))
 		return TPM_LIB_ERROR;
 
 	return 0;
@@ -254,7 +262,7 @@ u32 tpm2_nv_write_value(struct udevice *dev, u32 index, const void *data,
 
 		/* handles 8 bytes */
 		tpm_u32(auth),			/* Primary platform seed */
-		tpm_u32(HR_NV_INDEX + index),	/* Password authorisation */
+		tpm_u32(index),			/* nvIndex */
 
 		/* AUTH_SESSION */
 		tpm_u32(9),			/* Authorization size */
@@ -643,7 +651,7 @@ u32 tpm2_write_lock(struct udevice *dev, u32 index)
 
 		/* handles 8 bytes */
 		tpm_u32(TPM2_RH_PLATFORM),	/* Primary platform seed */
-		tpm_u32(HR_NV_INDEX + index),	/* Password authorisation */
+		tpm_u32(index),			/* nvIndex */
 
 		/* session header 9 bytes */
 		tpm_u32(9),			/* Header size */
-- 
2.40.0


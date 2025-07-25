Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF5AC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3018211F;
	Fri, 25 Jul 2025 14:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="As2b3Mhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E60F829F5; Fri, 25 Jul 2025 14:37:07 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03F18144A
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P88niq008715
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Qac8zNXdzX0QxnbW0yYt8NmZRasRWTXSoqR
 J4nZGPmg=; b=As2b3MhysPAG6sE9Erpc7C1cv1uZKotLphvm3zcBq8A1ttZL3So
 gIvJTnb3HY1DPFsDaRmKaPFslxt0PXLGkM+zNqBH5j3qYltcr6TF+E/KeRCgfhiE
 wdOsSwyhnmw9TX4ePX504FkVimcBVwFIvjYXA2RAXnedEbhvS6v9zFNuse84by9D
 2bA/Wr5pn6BJNGsDVSkOH5eSoC7JqrhLU4JdHMbAkx4j3ad7lFdvn9eKM44Q3Zsk
 UVWTr0Ghee2571xxj8mfjp/iS3pQDZ72NfPPTWKyLNa/Lu3EycT6ExY1Z+ps2N90
 8Yo0txC8r7bgKr5IrZ2ywZydqYQTn3jPidw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4846590qg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:37:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4e2so3421815a91.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753447022; x=1754051822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qac8zNXdzX0QxnbW0yYt8NmZRasRWTXSoqRJ4nZGPmg=;
 b=K+FjU4877gsRfr3qSKQw9ggYEd9E9MSBSUYu2obi3fcqOnuDqJIzKvC4ka1Hk+g1OH
 PiXCKVaTKnV9qaS2WspFshXoBJU2kkgaXgyxzOFkMZNxejqZHVx98XiHvjpmkdYBa3GT
 MYNjSRkWFNpoUAA0NQ8DZkqkGr7LomTGzOnKEchmJxQEo6qGTrqw6+2aBMwDglANWCHD
 ZzgF42Jh/mC7hxPJYcxUsBND2FReV02tTRVMBN9n/R5bmr8Pb4sY/SMBc1UxK3VUaO1S
 AtTLRSDNTIEwV7gYYdyFHqzB6L9k8f4LVntuSNntPNFCJBl4xvm7LNlpH1h2su5vssLa
 W/Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb3wVmQg4OV1nanVbtfsoNw/TdgWD8FWEW9J1m2tJj0st7lWaUcBXRWmQiJjbXCg4aO8eRrzA=@lists.denx.de
X-Gm-Message-State: AOJu0YwWwic6IQ6iByUNT0SLoQ3Vn5zql1DJBVSWE722nf5Al6tR5NOm
 NANtWupTB+YR9EOLrFBHE9W2uhph0mHN5ekvETTdrhteSOfYwUFrBVqEs8vejXD89gjAoOIbvLU
 tpygSZ0F1AJTozXKJ3OxB0NKToFkQxhIoTIPb8l7q72e8zPrZUg8RFKwR
X-Gm-Gg: ASbGncvMTQJEgpogOWL70hf3/ai4yG9dhGYhFO05sP/TRMdf1c+66bptrodUsbujFhi
 fNrJsX1klMGPtdtdZSDJ5Sdiy7TWbgmBhx2nJvcgsy1xXpZXMnfb9v7V39ow3GF4clGTiTlHik6
 9c1RHE6OqVRsZE/ltYtgMGgoSIrEjaKmzi03Ic4Ko5N88G3QKJ5u28xZangnD/QrOaOxR8VFhoR
 7lOQX0ckegrd5DdnljgwUl04gdQDOJqqhGF/UOTb25pIm19U2x5pa9GyFA8ji5oeufSoMJpyvJI
 I/MGeYFAsjB7wvPSruKXb9aLVhFZKa+jOFDSe5HYWNDpggyo4T77HRYrMYCALTkwiOs/2YS8Jp2
 3aQDFWUXs9nLet/z6I6ubCnbOzQTWJ9QKDw4N40dsDiUgdHSkDxj+mAsyUzI=
X-Received: by 2002:a17:90b:1e4a:b0:31e:3f8b:216 with SMTP id
 98e67ed59e1d1-31e77a2f7d9mr2987041a91.11.1753447022243; 
 Fri, 25 Jul 2025 05:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZbjOH8sLgio5FCsySMX/hCuCchb7h2LI1oOH1jYC59Krh3YAJYJWJR/NNGV8FmgKx9kHCIA==
X-Received: by 2002:a17:90b:1e4a:b0:31e:3f8b:216 with SMTP id
 98e67ed59e1d1-31e77a2f7d9mr2987004a91.11.1753447021833; 
 Fri, 25 Jul 2025 05:37:01 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662e0105sm3455828a91.31.2025.07.25.05.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:37:01 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, kettenis@openbsd.org, u-boot@lists.denx.de
Subject: [PATCH v1] efi_loader: Remove authentication header in efi variable
 data
Date: Fri, 25 Jul 2025 18:06:53 +0530
Message-Id: <20250725123653.513252-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0bgiuo-SX7nei3rcRWtmcMpim_pdAfcg
X-Proofpoint-GUID: 0bgiuo-SX7nei3rcRWtmcMpim_pdAfcg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwNyBTYWx0ZWRfX/epgPMHovrva
 EEwqzq3AevkZQN1i2NdWRMVEwV8yVBpkNR8BwrXhrb3YPdiXlia6HOAcirPYf8bPzQX5U9Q6E7f
 0q16Ynn27mEFyic2ZnkYMDbmQkumS3YbZHRjNaaLnC1ylso08XOO/SR9oeksh6LAchwxy9iwXf0
 RFXER5CWSlolzVx8fnWCZDaN5BZsmvP7UjFIryGN8J6a6JPvjK4wC1dvWzb+esWf+oIS7eXlIXW
 5BqQbjg8TH9U3qc6pCVMZ3i4tUt8wt0eIbL073weS2hXjhlolRjNWcR3I3LbzDPQJ5jA94Gc4+h
 JqxvmhgK3r4BKJsqYPCXKtRQqGceooNFUiaT+cRELfkVSC20TCvrXl+XwRNWxcfP4OjKkKchIt6
 3EZmfp+bdAAAlJdt6Qi+fgfe6N7iJ7FLX+tS33nTwob6PI4ENOvcsQfgjRLzZq7jX3DhsVY/
X-Authority-Analysis: v=2.4 cv=Vo8jA/2n c=1 sm=1 tr=0 ts=68837a6f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=SGchKGV523nns16CKNQA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250107
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

efi_get_variable_mem() returned auth header along with ESL data for
authenticated variables like PK, KEK, and DB. This caused issues in
later stages where the auth header was misinterpreted as ESL data,
leading to parsing failures, the efi_get_variable_mem() is expected
to return esl data alone.
Added a check to remove the auth header if the variable has the
EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute. Now,
only the ESL data is returned from the function.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 lib/efi_loader/efi_var_mem.c | 42 +++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 31180df9e3a..f73daf8bdc9 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -309,9 +309,12 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
 		     u64 *timep, u32 mask)
 {
-	efi_uintn_t old_size;
+	efi_uintn_t old_size, var_data_size, auth_size;
 	struct efi_var_entry *var;
 	u16 *pdata;
+	void *var_data;
+	struct efi_time *timestamp;
+	struct win_certificate_uefi_guid *cert;
 
 	if (!variable_name || !vendor || !data_size)
 		return EFI_INVALID_PARAMETER;
@@ -335,19 +338,42 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 	if (!u16_strcmp(variable_name, vtf))
 		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
 
+	for (pdata = var->name; *pdata; ++pdata)
+		;
+	++pdata;
+
+	var_data = (void *)pdata;
+	var_data_size = var->length;
+
+	/* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS */
+	if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
+		if (var_data_size > sizeof(struct efi_time)) {
+			timestamp = (struct efi_time *)var_data;
+			cert = (struct win_certificate_uefi_guid *)(timestamp + 1);
+			auth_size = sizeof(struct efi_time) + cert->hdr.dwLength;
+			if (var_data_size > auth_size) {
+				var_data = (u8 *)var_data + auth_size;
+				var_data_size -= auth_size;
+			}
+		}
+	}
+	/*
+	 * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
+	 * expected for auth variables
+	 */
+	else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
+		return EFI_INVALID_PARAMETER;
+
 	old_size = *data_size;
-	*data_size = var->length;
-	if (old_size < var->length)
+	*data_size = var_data_size;
+
+	if (old_size < var_data_size)
 		return EFI_BUFFER_TOO_SMALL;
 
 	if (!data)
 		return EFI_INVALID_PARAMETER;
 
-	for (pdata = var->name; *pdata; ++pdata)
-		;
-	++pdata;
-
-	efi_memcpy_runtime(data, pdata, var->length);
+	efi_memcpy_runtime(data, var_data, var_data_size);
 
 	return EFI_SUCCESS;
 }
-- 
2.34.1


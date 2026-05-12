Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F283CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72DD83CD3;
	Tue, 12 May 2026 21:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfFToBi2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XTi6lctH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE7B83E81; Tue, 12 May 2026 21:42:21 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C6C836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CHG7tP591860
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+IcjHDOQ76fEJ/KsXiGA4sEGSkD1DG8SAkB
 qSL0R1po=; b=MfFToBi2oVvsOsX2dcLYv5BCL6VTD/i5L7Y4FkW0iJwS1P+HWYD
 luYZPncW/aoAsV+N8PoD1mLteUXpPL40fz6b3jTgWubPxS0bXDg1cogA74D6L/+8
 oOLtspR1JvnLmNVfI2KmTjnY9mJmkD8wYzvqlkWdLVLp5RBw+2Cxf2r6cnpZJAdf
 ADlX0+ElNmHteP+JkkfBvUQHkh2QU61e8ecp3FJD/Ag/1xu5o0Us+jvlWJ87k0KV
 p4hdfy8TpXqk7VcDoaBcYevfol93rJ3q/SET2oQ+DkoWsY/grD9sh+DoXWvxqe7/
 ZV35ysypSj/75ZpbGxYh3hKw+BLhHn45nmw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319t4r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:42:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-368b0dc7731so859069a91.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778614936; x=1779219736; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+IcjHDOQ76fEJ/KsXiGA4sEGSkD1DG8SAkBqSL0R1po=;
 b=XTi6lctHHKFTe7eeIrXAEeFDgZ8MVGO5dldwneyQMSPSyBxBEJ4SUOT+y/ZmszEVo7
 cWPVMR9/MfG1mw2dk+w1F1C0jiNzmcD7O09cSFuvq74JaJup62sIOEMV4OQTUxpuEXKg
 d37u1/fxhJp3EPhyVZx/D0P7P6TbUmLZixGzgMuZ0tO7iYilztcEiw7d4mLNCHSFa3fS
 UfQ89FIKr2flvkymZiPkckRthE6PIxZ/mn9MJbzg9aFPs4em6ehcPgSxjaNdgIvo83ri
 1TQcynjTddN9TEHIs6T09jY5+lWw6Ikv2KXkgY+/ZUiprwnpgDLFyk6YMLMV9jkkCqk0
 +EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614936; x=1779219736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+IcjHDOQ76fEJ/KsXiGA4sEGSkD1DG8SAkBqSL0R1po=;
 b=ElXbblb34pbA17X/q/ky3Xo7W6BWOHt6X60gwmCL47DZHzgTLjSUMsOkzwy1sLYmVu
 7+vvinA+4OEqTGYQ6jhgt5C6ius9xNBCrAjwm4r0zG83PFM65AVjqel5v/tmYX+h/NTO
 1gEgWC279P7G7vz374KfsFDKr/N15SnPOK8q353wlQJr/+ALv4cb5Y5uOdqGnfZp8zo7
 pavNtt1khF1HGslrdMH0L3jKhY+7pG9m2V7cr+ctIg+WBIfEQLn/QrgL77zqnbXCM36Z
 ejnFl4ZfIcfcejOhMLzuP2Whzq64jSrAG3VZ5R21d2Uq8wOWK3F4OgDkSLNjzhIdMRDm
 bZuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aptJ7b4atPCj3Yx26FIXYlyJvllGlfiRAZW0MH/dW2NzCEXPaphWD9XzGJiMiOhOsWYKtfyA=@lists.denx.de
X-Gm-Message-State: AOJu0YynZskBFxQnUpo6vvohI4ZiqOUAofh2vAOhSTAh7FTudsLEjznW
 QeNutp2/slrCoCAaqIHOwej3llNCZN8yhERmgO5Dilk/MlCj5wioV0Y9/vTNwKcdmqgzLzXXn7p
 B/VCu0/q5CcSj65g0H4uRI6/x5wijYNkAa0Ykj3CqOrvyyw5ILzMZiRCb
X-Gm-Gg: Acq92OFpLQqbq6MLMtyfIDUc9vMZKtzkwHryYQYpPnaYKONkagB+Mf9q4vY1u/EZDSR
 sB/hPhYm96AZG2BcrxaM3nXLiazLysnVRm2wAX7mUUBeX3oXdZlnEdBAPmDusZRf7DROVd5aCrT
 7Pqq7ZeSjaG+VEhJuUKB1mLthDV3VYBFkkfmnEFa6aigvUqe/IWiTdHqVCeqRaOg4VBDc7wK7Xm
 O50D0m/ju9D6OWVQu3CW4fZnKzwTaM8p3s/MfknvLWLkfXMj7e3vfDY2YvtMd7OnziHCm35b2GP
 18hXLDybe0f9NlcmmpgsRQXqLL7eyfKXXsSjNNdWDvg2VQBYr8wsG5NUra0RmF86VPmVOOXWu6j
 aKY3Ags11XWpdWZvrjnBxTQViHIDWlPQ1J7YnQf15QBR4TIVKmKsoihZxHa/vRsc3l7QU58kt/5
 YavK1yJ9dRqbE4hcJQgnOyEIor3LXQPTfXDVrqZI6b
X-Received: by 2002:a17:90b:4c02:b0:35d:a38a:a117 with SMTP id
 98e67ed59e1d1-368f3e6ffabmr470936a91.15.1778614936292; 
 Tue, 12 May 2026 12:42:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4c02:b0:35d:a38a:a117 with SMTP id
 98e67ed59e1d1-368f3e6ffabmr470904a91.15.1778614935789; 
 Tue, 12 May 2026 12:42:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368edf4d940sm636230a91.7.2026.05.12.12.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:42:15 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com, u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: Remove authentication header in GetVariable()
Date: Wed, 13 May 2026 01:12:05 +0530
Message-Id: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMyBTYWx0ZWRfXyseWUwIjDLzS
 C2xWov5XPg4dLB/nVNQIm2dPs1XNOoxvT1PfbFZAvt9yZpUcL98rCmWntTK+wJTja+AxmIr0M9d
 mS7cN9sTV49aDof/j9JAkBVHYZ27KjB/WSjPLOTzC/6T1r9/hedAQ3QYA21pY7nph4kJL+pN/yc
 xvreskUJRHL0OuS+HdhC0p9B+YTIFtxjl0H9FB4evDQyqAuQTDDkbPMErfVC+QL/b7FG9gDowZX
 SjYUpMn+pCOhNvJgyakmdEfCjxs1sXV+66IUlYZx4fTnpfzzuSkxFsvUFCo0l+rM1mt+9cik2fZ
 VifzQ+/nMFhcrkbmAmH+9jz2GZZIqx92tTttApB4QODKNaa4LlB1FIeC8vCYGMcVKjv1+pocDSe
 WULTPJNwx3x3Enna2l2IZmB4uTrC/NKKCVi2X89N9CJvJQz+Xm/hvgqTnGYuecwVwbPnVwTDx6Z
 qn+VXgDVjsch7w/DGRA==
X-Proofpoint-GUID: oUHDMmuddeBUx9r58dcpSTglDPmIaFLm
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a038299 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=YKpRDGN90cBrfkvr_dMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: oUHDMmuddeBUx9r58dcpSTglDPmIaFLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120203
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

Currently, efi_get_variable_mem() returns the raw stored format for
authenticated variables, which includes the EFI_VARIABLE_AUTHENTICATION_2
descriptor . This causes image authentication failures when reading
secure boot variables as callers receive wrong data containing
authentication headers instead of the actual variable payload.

The UEFI Specification Section 8.2.6(EFI_VARIABLE_AUTHENTICATION_2 descriptor)
explicitly states:
"The authentication descriptor is not part of the variable data and is
not returned by subsequent calls to GetVariable()."

This patch implements spec-compliant behavior by detecting variables with
the EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute and
stripping the authentication descriptor before returning data to callers.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Enhanced commit message with explicit UEFI spec reference
Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
---
 lib/efi_loader/efi_var_mem.c | 44 +++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 8d5f99f4870..edf4522e51f 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -336,9 +336,10 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
 		     u64 *timep, u32 mask)
 {
-	efi_uintn_t old_size;
+	efi_uintn_t old_size, var_data_size;
 	struct efi_var_entry *var;
 	u16 *pdata;
+	void *var_data;
 
 	if (!variable_name || !vendor || !data_size)
 		return EFI_INVALID_PARAMETER;
@@ -362,19 +363,46 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
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
+			struct efi_time *timestamp;
+			struct win_certificate_uefi_guid *cert;
+			efi_uintn_t auth_size;
+
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


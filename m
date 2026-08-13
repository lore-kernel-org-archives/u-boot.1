Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CEC5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA4854095F;
	Thu, 13 Aug 2026 05:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cy6q9leDAu6U; Thu, 13 Aug 2026 05:50:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C19F640958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600243;
	bh=Xe8LH2vm2a4+0qSukyBgDm7xjFXVn/OtIEAEHhuHcMA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QPpO1PyYFjKG+cydzP524T9gpacTofWmJ0AR3fjxvtNxvEbyeEojBBFUU090GdCMD
	 xrthKbqDdZ3MdAHKjwCkDRmp/fHVzISfXiGfelQFY3tDtjR9kF4HAm1uw5IV/J2CRL
	 8SThkWoTJigIpWYXocJoVEA8mvBh2YoUiccUN6oG9HUVuLIxlQhWEF4UvEMbdv9Phs
	 7HTvMVKiuN8eVInmIrLDykc4rYF3iINg42eCEtr1Z+fXDTzFmGC7l5ZWJkToRDEo2e
	 moY7C0pCe5xQp9+MeLmWaBdPHBRCJ3IhEYD+HIJFD8YdqBUtxOeuK2tXSHFHCFRk81
	 TQ05H+tTPG9MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C19F640958;
	Thu, 13 Aug 2026 05:50:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE32D109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95497605EA
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIcQ-jFi9sCp for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:50:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A23ED6084E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A23ED6084E
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A23ED6084E
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:41 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g5h21526526
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:40 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g158g8m3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb5ea36f969so1863440a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600239; x=1787205039;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xe8LH2vm2a4+0qSukyBgDm7xjFXVn/OtIEAEHhuHcMA=;
 b=QRrIMIagC9tc3U7+X7xrSowWkhw2Ohpd8lzc0BVmpChwv26vm6IPsP81PGrh24DcXU
 Zd7IS3w27dCn2HVnFOdYOG3AIhLPKe5dKNbEjf+wCEiqoBnhYPtRrwUzohYX4Ss2IS59
 oYQw/pcRZF578X/qIo9+jhjiFZ0ocXtUrZ6T4TNpMXT3MYmEpLX+vQOaDdBtqhco/iBy
 A3O+ji4iNfSw4qW7AraMtfXyZ6fCATzv2R8q+U78nBrL5uR7zSjlMrJTnJc2md+KIEPK
 WVz0z+SFpsuTpJqFCNI/+R8lT28yGWpK2OZ3RdJNYWkCibpCRCTOPh3cC261xRyMBhm/
 424g==
X-Gm-Message-State: AOJu0YwCJbURVLNiJxMMA+zXm6ZNlhAXfSioIh4+7qVgohGRPKzf1HFd
 6Jca6+a402bvcGJIddhnRTl6wPDZW/U9wROtVEJ4W/egkfUjXWNWCqRvkYGqF+JXWtZ4Vnpy4B6
 Pv+Ki1O1AZITs1N2Upu+GrTpkRo0PG7NZWDTT16acsMVOW4cwJOavBODwg2bzuE2DblptjMc=
X-Gm-Gg: AR+sD130DLAZzW0XKwvOhYGozN2Zq4kUJvmCrN9by3fNFjpaYMPcwFje1FGy7/gBeSi
 gLYF9kmdFpfGJ6zSVhRgV4bjIPMtBbnIL2jN2gq4h3IDFZp8DVKZlhFZC9iQdAuis0kD5gJjY92
 5HDBCo5XRxEi5KeIQMkTCs4kYet94nK2haeFqRQTHvkZwgbP0ScHs6Tsn1YdBSpuntSxMb3+KHw
 7LHTjsNxs3nuLuW1Zfk1MtmKkXJ56qpoz1EIS3LgVqWm1pXCZjfkOx8m4mCkMb+Kff7V/Of5ZFa
 StV6EDANPTqu6KRc49wuo1AlkqxOOy2tLAKYNGaJ+hWG9CoLH51Y+g0PNtfn1LvHJx1UHa1pppR
 oTGAUQsLxG6im9ZL3mH7XGRblby7HLz69K2PDlLRH/A88Xg+Ob2GfQ3I79OIDhq4x5ZY3DGneh/
 VHoVdoaDsnQMVXO+iRi8s47Idrlgyf
X-Received: by 2002:a05:6a20:9c86:b0:3bf:d0c8:2aa4 with SMTP id
 adf61e73a8af0-3cc54f4d0efmr5264143637.8.1786600238984; 
 Wed, 12 Aug 2026 22:50:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c86:b0:3bf:d0c8:2aa4 with SMTP id
 adf61e73a8af0-3cc54f4d0efmr5264080637.8.1786600238483; 
 Wed, 12 Aug 2026 22:50:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec022acabsm3402870eec.27.2026.08.12.22.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:50:38 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:20:18 +0530
Subject: [PATCH 2/4] efi_loader: firmware: add last attempt tracking for
 RAW capsules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-efi-esrt-last-attempt-v1-2-3be172f47d9d@oss.qualcomm.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
In-Reply-To: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600229; l=3221;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=mYdsH+82G23EPrXNyetDl1DoWN8xRp3ahZGQnQElmsA=;
 b=BQtoFj0HPwfRlx1yuNC7wSzBa+ZGayq5qhAXS/uYdX93UFgW7NYS/8d6AlRP6MILAk4fsJYbG
 e/RlWg4Kw3WAbAbvK/3u0rODIfk+2BOBTyKJ5KH2p+wkVLG/ZkDVLut
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: lsyo4-z3jAx4dqOo044miJKppnWk-Gcn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX3fbrBLPcJ/uZ
 h6uTJ5oq3Hqr/L4utQjkoKmdCIROrd3J0TkgPra6z83MfxHZcrSZxDcQx2jTFSsUSvAz18OW408
 5qz1/w82z+GmdPU6cd0Ftr+8UQ5c4ec=
X-Authority-Analysis: v=2.4 cv=G5ks1dk5 c=1 sm=1 tr=0 ts=6a7d5b30 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=gEbcPNc84vIEyjO2fk4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: lsyo4-z3jAx4dqOo044miJKppnWk-Gcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX4VcltpFUG+EV
 50ebz+57mKSjYOMR6+M/GMJneTYJPYR10ha1zXnONtNkh0cpr7URVluRNk9gU6wc/Nek/IJqUwl
 qcQJrBRmE+BSByW3E3uu1dL6M5see1pIvGYxa9FYdxTqUsWD9x7NsGImxZ1zWsiGngdWChjHyGK
 lbjJk8jpHNmsarBtvDmT2iog+9q1jZZKD87xeLw/ghhYQcH4rjrD5UO8w7qUCc+01sCdUypnvKJ
 j94r1FL4Mod6XVatfZzfsrTvCSGjnbo9CySSE4nqeDVrrJqeBmorvBKOi4qILCQTNJakkk9QnKG
 5i2XlVDiA464+U1dWH/I+XRvedJ9x3zFAyLi58Kk0ndQfcdiNeO6Xvj1IzQHNIpSp0BQG/kjCnl
 M8Wxl7wojDdWgVghGJTBP0Vx/fTreUwA/xZFLVXh9Cr35T2VIuSos/YhY6AeGcyWBd4JajSs/kX
 FBTc9tPxEizh5QNJdvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130037
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xe8LH2vm2a4+0qSukyBgDm7xjFXVn/OtIEAEHhuHcMA=; b=ZbZAkmmlPeaq2jhK
 ynytpv8aPDwEVfYeDeRS+I/BP7dfBJibTlzQAIBDNImeTt6AyI7t+7avgdjmEDyA
 YEzvAtH5o1qE4iqT+ALGm+uSQIFJkJoVR8zhFY9QdRx2A60a7TRjeQbHnyHc6Wqz
 jRM1uSYFWcmXlI5TH5fWcdxx4VqS/Z37HqC15GYQQGs1AERQzw0FIDlwaBunR/bI
 sWnznLnIatNVyfXDv0aGqLeiXHCCo6b0kPQsj4imNFI3dAPYwfQ3Wbhjzq8CKEuu
 NjrHvP0VxrrB4oo5NIdSxDfRKd3zG5ypyxUQLgLJKVCZo9mVvJkexKnMb7vP3/V+
 +hHW9w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600239; x=1787205039;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xe8LH2vm2a4+0qSukyBgDm7xjFXVn/OtIEAEHhuHcMA=;
 b=NzVI5yiSToCzCpZbJOHv7MsxQ2NSdDzK36V2bdr3BXC34QCZuU/Di4//R4eIWWiVqS
 jcLBIWPW60N20f3kJQegNTC1p1rG1Q9v6mHmPGMCNH8sUIlGb31yq9HiQPEne2tEkmpn
 6Zo8njMms9QIK47TC1C2a63W5hg3eOLXrngr9buhNsKaNXUL5izcIPQTC3hmsPIN4rHc
 mZ6TrELo93oECgN/7i9qwbqGHv/4h+Uvl/pwXSBKipnKfyC4KO1fXQ38uFrq3auoQtmQ
 9NzAoWQ+xj8oMsvtjf9fB8WfkHG6n7KVII+upziZTuDhQsc9wM54hgXKOtIrdU8pjptL
 SsxA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZbZAkmml; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NzVI5yiS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Now that the tracking helpers exist, call them from the RAW capsule
path. efi_firmware_raw_set_image() records the attempted version and
the mapped status at each point it can bail out (verification failure,
strdup/env_set errors, and a failed dfu_write_by_alt), and records
success once the write completes.

Either way it then writes the FMP state variable, so a query of ESRT
reflects the outcome of the last attempt instead of stale boot-time
values.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_firmware.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index cbe8bcd7c64..455d79a19ca 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -824,8 +824,17 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 
 	status = efi_firmware_verify_image(&image, &image_size, image_index,
 					   &state);
-	if (status != EFI_SUCCESS)
+	if (status != EFI_SUCCESS) {
+		/* Set last attempt information for failed verification */
+		efi_firmware_set_last_attempt(&state, state.fw_version,
+					      efi_firmware_map_error_to_status(status));
+		efi_firmware_set_fmp_state_var(&state, image_index);
 		return EFI_EXIT(status);
+	}
+
+	/* Set last attempt version before starting the update */
+	efi_firmware_set_last_attempt(&state, state.fw_version,
+				      LAST_ATTEMPT_STATUS_SUCCESS);
 
 	/*
 	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
@@ -850,13 +859,21 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 		orig_dfu_env = strdup(orig_dfu_env);
 		if (!orig_dfu_env) {
 			log_err("strdup() failed!\n");
-			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
+			status = EFI_OUT_OF_RESOURCES;
+			efi_firmware_set_last_attempt(&state, state.fw_version,
+						      efi_firmware_map_error_to_status(status));
+			efi_firmware_set_fmp_state_var(&state, image_index);
+			return EFI_EXIT(status);
 		}
 	}
 	if (env_set("dfu_alt_info", update_info.dfu_string)) {
 		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
 		free(orig_dfu_env);
-		return EFI_EXIT(EFI_DEVICE_ERROR);
+		status = EFI_DEVICE_ERROR;
+		efi_firmware_set_last_attempt(&state, state.fw_version,
+					      efi_firmware_map_error_to_status(status));
+		efi_firmware_set_fmp_state_var(&state, image_index);
+		return EFI_EXIT(status);
 	}
 
 	ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
@@ -867,9 +884,17 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 
 	free(orig_dfu_env);
 
-	if (ret)
-		return EFI_EXIT(EFI_DEVICE_ERROR);
+	if (ret) {
+		status = EFI_DEVICE_ERROR;
+		efi_firmware_set_last_attempt(&state, state.fw_version,
+					      efi_firmware_map_error_to_status(status));
+		efi_firmware_set_fmp_state_var(&state, image_index);
+		return EFI_EXIT(status);
+	}
 
+	/* Update successful - set success status */
+	efi_firmware_set_last_attempt(&state, state.fw_version,
+				      LAST_ATTEMPT_STATUS_SUCCESS);
 	efi_firmware_set_fmp_state_var(&state, image_index);
 
 	return EFI_EXIT(EFI_SUCCESS);

-- 
2.34.1


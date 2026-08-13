Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F5C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AF9A40944;
	Thu, 13 Aug 2026 05:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BxvVdgF07XRh; Thu, 13 Aug 2026 05:50:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A04A40932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600240;
	bh=Zhiy0fPwAJPYvF2MpLLIV1OmkBMdu++vLdtX9Yr30Fk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ldZbMiyGLUMzD+35U0TUWYFjtYd3icTV7wGuKa4A0ubp09K++VxQm3lOK6WMdOw6E
	 c3jerEVvAVkqgaEhOOl0X9JEi5+MbEC8qu7vvCgW03jGLlINcKUrKV+WgHBzyaQqpD
	 ivgrsmkXHoB00mhr6KPWgImX4gRlmlkGKN96X14LsKZ7ow+eiTWJegAiTnu8OkD4jP
	 DH8A7zz9MMhHwsRypvLNqGtkUXn4r4ng2jsrGZALBaa5MqNVijcj9l24jVCjHaPxkk
	 qdA4yAYDwe/FebGV4OGKCpazqgr/ssu6c1kOkDO/I6J+rRgDhf/o3kQe65VE8feyiK
	 EZ7EXiNZHtFzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A04A40932;
	Thu, 13 Aug 2026 05:50:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B196744
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A96240930
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F69sJXC1JZP8 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:50:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C4477408BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4477408BA
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4477408BA
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g3vf2975081
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:37 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g152m8p3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so2088544a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600236; x=1787205036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zhiy0fPwAJPYvF2MpLLIV1OmkBMdu++vLdtX9Yr30Fk=;
 b=bhQN2GF8TcM0vQK+mYtJnrLPkmZ1k4FOvXYVhqpXhpS1Lkce3A8cF7SkRITjauD5Qr
 51lg/3kIHKZSggK8li8hnYH38mzzDyKCdreO9c4ta8ym6I/e6zOcSq79Ekng8VHf9fIc
 WPh7NOnfWKHbZjFqCeXqSDiaPrRAWYqP4zaZIs+bNnyJTg+VJJzAGoA/BtPbpjJBiRg+
 YL233AtvF0XPS2EBQdyE/l+1okLzVaDMQpfga8Z/IiVUpdC/TS+nhogNw3UXRhKYMMEa
 L1QDXOnPaDvQrR9PTe7W0EfPMvcjJtTfj6GO6iEOGBqpP4CbUmWkLs9D7iig1HlH8357
 0jLw==
X-Gm-Message-State: AOJu0YyPvkKVush6zFAG4IGkPADqTH5+Q1DaMDN93D8ffWWQkBmv3r+m
 PqwYmRN9wP32CUYDe0hGWi7i3Dl3b2mRmDrUJr3Mz0tWGMWGZClU+Z7Dj9fs3Whnx3b/5vajyI5
 LdKg/pIINaqk/H9m8pZaD6b4EgkpGelQ56u3CXNob7+SNc5J5JepP1tt4MYZA73WTyUxMOfc=
X-Gm-Gg: AR+sD12f35ZaorSrwc/S2W+3+9qB7TCTdg0kxjmWgbxNN+VN0I5gplteFokL3+smwQW
 kvXGWN9/zHuNUJgSJ94nqQMfYnWn831Cb3JYIFNXM/vQq3wyE0DauP3U/hA1/L8RYNV5UpOhbax
 jBNDFC0pPHVVIHR/7+gQn+aoJmWjzIJ7QEuFwLfjf2x8KNeeBc2gmST5aTX7iQvHHTSzz5Lptb+
 5ZCDTtpWdjcUXqjnGGiwWRv88DDjHMoaLl0tnPEuHHtYlgrTGRbnpCsNvQBCO7VuhDGp/PYAaFc
 LnXd+RkhmSQPASOrNipx7zBJmP/J4ORrf1BrKrELIvmpF5oDwOeknLST2hzxEp1tQjzonP2pvz6
 khclkvUCHc/U7PfBK9d2tHUWpk5nyBC1i4l4EPxIsSxwdEXg89j7UG7bB4SMCJwtcZITUbLNm3Y
 OJXpbrYFmpWr1fvOU4exvg7AITnVL3
X-Received: by 2002:a17:90b:35cc:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3931e2ba863mr4590428a91.21.1786600235955; 
 Wed, 12 Aug 2026 22:50:35 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3931e2ba863mr4590349a91.21.1786600235373; 
 Wed, 12 Aug 2026 22:50:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec022acabsm3402870eec.27.2026.08.12.22.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:50:35 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:20:17 +0530
Subject: [PATCH 1/4] efi_loader: firmware: track last attempt status for
 ESRT reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-efi-esrt-last-attempt-v1-1-3be172f47d9d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600229; l=5380;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=sY9gH/Btss+GzeIRUNJ9T96yOMwHE4vNsyyA+AQrLtE=;
 b=69BtAIfK3SNcHrP2HoUezrmu1uRRO3s+UEHwBIf8FOWtUKB9liVgbeC3ZszMtjeT9SGbwVzEv
 QQHJOEp2wCYAYhN511hS49h0+hZdNxDpzqgrH9o4FFcEEy0w6gUIEZR
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX3kup+im/YbzH
 KDb3VSaXbZf7zO5dBYcWCyDtnsHI6dbcaLHupjDz0xgcLKk5YO+lLyEqsCCafr90m8Pm8nVE+Ok
 ACsit9n0AngdYjLL1690DG+QEQHVcqw=
X-Proofpoint-GUID: lfcbyTm1tiksj0o5wUxZ0OmpJmdO_Udp
X-Authority-Analysis: v=2.4 cv=D8R37PRj c=1 sm=1 tr=0 ts=6a7d5b2c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=j28GzTy1VcnVeXvcpBoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfXyTQZdEzL8lzO
 zJBjqPAIt6HQMdedzkydUDtkoelZoYfHsGELZuYML6pYnE6aAj0G/8gxoyhH8IrAXEDGESkNNQu
 OZgAdPl7mjJjU590/U4rCPUgKyXNsteOou228HBeSo4LAQgeNIofgdM/AQCIezDnJ4UEtb5Y0B2
 QCEEuWqVWXMb20z7K7KGiO8BqJmneR9tar780n+1bRurA7Ws7oKdRen9RYoNhWc9maibMKrSAOQ
 V5qMZUUIBIJe7Nk25ld8nrWlMyGN1SME1kiYrmreKEquaS5vlDhi124WzfwjCaT+kt/9PpaUWxQ
 4DmtQOpLgDsJPyN/UECKJOUqjjX731yOZfbGaVqF6A++4M9ZNVl+6azb7FRY4dpStfZ1aSIgf3F
 0zgK8Jh5bQNTM8rLJLwSanbCB+S115IlJW6kQ2W6nlTPBotxopolIuMrM/1PKAeBC5BndyUDdQo
 X195apPyWE65zjhkc4g==
X-Proofpoint-ORIG-GUID: lfcbyTm1tiksj0o5wUxZ0OmpJmdO_Udp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130037
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zhiy0fPwAJPYvF2MpLLIV1OmkBMdu++vLdtX9Yr30Fk=; b=l0K16DejGr2DM8IN
 u3ex+5BouW1YcTvxZ48GuXq8mj5bn5JDSNAHPGEQ7VSpPKLwfRX+zyPdNk13PKFD
 Gd6FD46Gqa0IEzO8XENGzJsCqs1yeA6kpgylZg1WsyE2nZih0l9NgLeYbtG2A8BV
 rxebkHldr/tJbUCOHscl7CwtPCVMP25ygHyHZwX1f7uJqNvpGB+O0kEVNhWuFNkn
 XEKlMbIPY5mh5BLyaftlfPExYN6S+013AbKOmmcPfdzn57S3fqESR+0Q0mtZiwa2
 Mx9MO1QFrTKSJ7b/h+oRIpYm77WBGqXBOelP1dqF5FplJDxbEjr8WD7lNttBFP0Z
 TUxYHg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600236; x=1787205036;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zhiy0fPwAJPYvF2MpLLIV1OmkBMdu++vLdtX9Yr30Fk=;
 b=kH9OqDpgQPmibjTf6QrQTsGP87VdLdNs0MJmCSpaAeJllI2Ft04aXdSVFtZfmpDVdc
 SPZvZ5IYM2j8R3+HATCi9rW59ErXifsCduii3zmS2rJyWsaMdjxMbs72JXNX+XBefRbm
 828t/Q7L1PAypAq7CJgp/SroXLWP/LSQdgqdF5T9FjPEAIny9/ckzgxG4X7NZavlTGYZ
 SDLpdKKbnYut+sItYWrhCpr3FawTsh3NwcV0kJP0Pa1eKJ6gkQtsOYIcGND6jgFvfbFb
 7J3uNRffcncJ1aK3A3tHP5NptoNXjIdip3/GTbzg15J5AWs8xNkSPaFKYGwn+bONw/bG
 DwaA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=l0K16Dej; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kH9OqDpg
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

The last_attempt_version and last_attempt_status fields in struct
fmp_state were carried but never populated, so the ESRT last-attempt
information exposed to the OS stayed at its boot-time defaults
regardless of what happened during an update.

Add the plumbing to maintain them: a helper to record the attempted
version and status, a mapping from internal efi_status_t codes to the
UEFI LAST_ATTEMPT_STATUS_* values, and reads/writes of the two fields
in efi_firmware_fill_version_info() and efi_firmware_set_fmp_state_var().
fw_version is now only advanced on a successful update so a failed
attempt no longer overwrites the recorded good version.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_firmware.c | 74 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..cbe8bcd7c64 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -52,9 +52,9 @@ struct fmp_payload_header {
  */
 struct fmp_state {
 	u32 fw_version;
-	u32 lowest_supported_version; /* not used */
-	u32 last_attempt_version; /* not used */
-	u32 last_attempt_status; /* not used */
+	u32 lowest_supported_version; /* not used - read from DTB for security */
+	u32 last_attempt_version;     /* used for esrt tracking */
+	u32 last_attempt_status;      /* used for esrt tracking */
 };
 
 /**
@@ -190,6 +190,49 @@ static void efi_firmware_get_lsv_from_dtb(u8 image_index,
 	}
 }
 
+/**
+ * efi_firmware_set_last_attempt - set last attempt information
+ * @state:		Pointer to fmp state
+ * @attempt_version:	Version that was attempted
+ * @attempt_status:	Status of the attempt
+ *
+ * Set the last attempt version and status in the fmp_state structure.
+ */
+static void efi_firmware_set_last_attempt(struct fmp_state *state,
+					  u32 attempt_version,
+					  u32 attempt_status)
+{
+	state->last_attempt_version = attempt_version;
+	state->last_attempt_status = attempt_status;
+}
+
+/**
+ * efi_firmware_map_error_to_status - map internal errors to UEFI status codes
+ * @error:	Internal error code
+ *
+ * Map U-Boot internal error codes to UEFI-compliant last attempt status codes.
+ *
+ * Return: UEFI last attempt status code
+ */
+static u32 efi_firmware_map_error_to_status(efi_status_t error)
+{
+	switch (error) {
+	case EFI_SUCCESS:
+		return LAST_ATTEMPT_STATUS_SUCCESS;
+	case EFI_OUT_OF_RESOURCES:
+		return LAST_ATTEMPT_STATUS_ERROR_INSUFFICIENT_RESOURCES;
+	case EFI_INVALID_PARAMETER:
+		return LAST_ATTEMPT_STATUS_ERROR_INCORRECT_VERSION;
+	case EFI_SECURITY_VIOLATION:
+		return LAST_ATTEMPT_STATUS_ERROR_AUTH_ERROR;
+	case EFI_UNSUPPORTED:
+		return LAST_ATTEMPT_STATUS_ERROR_INVALID_FORMAT;
+	case EFI_DEVICE_ERROR:
+	default:
+		return LAST_ATTEMPT_STATUS_ERROR_UNSUCCESSFUL;
+	}
+}
+
 /**
  * efi_firmware_fill_version_info - fill the version information
  * @image_info:		Image information
@@ -237,8 +280,15 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 
 	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
 				   NULL, &size, var_state, NULL);
-	if (ret == EFI_SUCCESS && expected_size == size)
+	if (ret == EFI_SUCCESS && expected_size == size) {
 		image_info->version = var_state[active_index].fw_version;
+		image_info->last_attempt_version = var_state[active_index].last_attempt_version;
+		image_info->last_attempt_status = var_state[active_index].last_attempt_status;
+	} else {
+		/* Default values if no previous state exists */
+		image_info->last_attempt_version = 0;
+		image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
+	}
 
 	free(var_state);
 }
@@ -427,6 +477,10 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
  * @image_index:	image index
  *
  * Update the FmpStateXXXX variable with the firmware update state.
+ * On successful update (last_attempt_status == LAST_ATTEMPT_STATUS_SUCCESS),
+ * updates fw_version to the new version.
+ * On failed update, preserves the old fw_version.
+ * Always updates last_attempt_version and last_attempt_status.
  *
  * Return:		status code
  */
@@ -471,11 +525,19 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 		memset(var_state, 0, num_banks * sizeof(*var_state));
 
 	/*
-	 * Only the fw_version is set here.
+	 * Set fw_version and last attempt information.
 	 * lowest_supported_version in FmpState variable is ignored since
 	 * it can be tampered if the file based EFI variable storage is used.
+	 *
+	 * Only update fw_version if the update succeeded.
+	 * On failure, preserve the old fw_version to maintain accurate ESRT state.
 	 */
-	var_state[update_bank].fw_version = state->fw_version;
+	if (state->last_attempt_status == LAST_ATTEMPT_STATUS_SUCCESS)
+		var_state[update_bank].fw_version = state->fw_version;
+	/* else: keep existing fw_version (don't update on failure) */
+
+	var_state[update_bank].last_attempt_version = state->last_attempt_version;
+	var_state[update_bank].last_attempt_status = state->last_attempt_status;
 
 	size = num_banks * sizeof(*var_state);
 	ret = efi_set_variable_int(varname, image_type_id,

-- 
2.34.1


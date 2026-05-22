Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938B1CD4F5B
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9EA846E1;
	Fri, 22 May 2026 08:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ScMcglR9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XxGyBHgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E66B846F1; Fri, 22 May 2026 08:09:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0BA846EB
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M004bC779220
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iH4RhGt5uXwLbjh/92wCq15cQkZTNl8SXxt4bfFTaDg=; b=ScMcglR9KsOQXuIQ
 yFaPLV/QLRukTKaYUCM8iEoHqiNeEt7GjxNhFCILVkbOLTdbKdPEikaFaJF/E+2b
 8WgjctFCCefO5ICUjKR6rXaoTfYRzqjL/3CdM3eT16o+LkbaZM56mGfLkiHNr4US
 vyb/vaYMkFxr0HfNfoaHQqQXgVsqcW+dEoL7r6cT6Spf1nsFwcj23O5u62AUCUwL
 8ZCnB9862JXU+t2EpzjcNwUg3dphaz58NKjpwxUdj8lA6qipodGd908ps7HUxqBA
 FRiKL/eumvBiFZYhh10l0HypPkAE3FSnZhgm1vZxRd4bU7P5Fc9aU+gQECw7aaiy
 6YqD+g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7as2gv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c827bda2e60so4095530a12.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779430192; x=1780034992; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iH4RhGt5uXwLbjh/92wCq15cQkZTNl8SXxt4bfFTaDg=;
 b=XxGyBHgtDHu4qEmGJOy4i5SL55AmPk97iw08Sr/qk4PDEMHdBTVlbBQuYn261CK0cY
 jOPJyf+u233UZvGMSdqe+gYgKhT6HgnlFamcJQ6bye2jS6dhwFj1xKAQrvf9YpGKlewC
 PbO4ZwJvXxcdOZudH/bL7e4psPtp3hVnOw1PSuOWqVw9+upqsHsOy6Xz8GqLLIsksFI/
 qSt9/LjLrTFYWULHHRlboygmCJ1DnxXgPd61+bWDTDZjlbQKLePYc4ZQdQdNQZyUM3My
 s68C5aDS7SsqvVY0wEDELeh48vJoYx5Gk2at8WZpFyvMof/AYe25+sE2TDXRcYfyQYIq
 sG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430192; x=1780034992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iH4RhGt5uXwLbjh/92wCq15cQkZTNl8SXxt4bfFTaDg=;
 b=h/eb+7wJNc++sgEwd1I4ySq+5P+B/lz4yHZ66DhaftOATHh/ISikdtOpUiAjBYtdeP
 V1J9f2iYa8OfWQdEOcJ9deCiUn6X9gSxHTatL3ourGL4pF9Zq3WthSTw1pM1F2N1HNvy
 ZHeOrN5I2i94EFyv+86RVcNlavMYBzZJU98a5XI0P07KUGy78m8nPKhv+jtRDhkFIDUZ
 3I4Y7J+RPnPL4R0fyiEjgKFmKnu1+T+zkFVkMdU/XLbcd4Ue1yHj50ARMwCLiaVlLdxn
 cKYdT/B1lSMUPmQVQ2ESfZXJCo3t8sfsK7OdP/VA0rEUcqWn9lw7eXfZGQ498dOizqCs
 BZfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hp55NVgGrwMkb6TusktXxxYVJfYiHfHahp7BV8Kykp+SwXq0hZ3Z8ZXkmFh9egNzeGui6Vlc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7x8+pvmxKI1mYgWZ1ctIDcS45eMFjpP4zElJUj0fBI+DEYcfB
 INezldgR4BqEWcormBlGE3sKaRqdAIPevuQ/cdMwIjf1EhL0+O8RhdOW056Ql0jFS2Altaleu3g
 UOnXPefQq1hdlXqaPl1oBiv3fGKEFG2+PJ11C1qQlkWyRAq/G8OdLmvto
X-Gm-Gg: Acq92OHoHziD9qgOC4NNBGxGw+CRSNSBR5KuL9j7vidb1aRXG/jjVQh+T3JIfgFMi8W
 /EUHGvbpFCR0kfiRBw3ASPn4CEXofmlGjHOi0G5oDKgYxxCx+TkXOBqLGl4KYkdcu7acpfBu+cy
 lz8d9H7ZxKleJ5TBve6up7KdFy1JFA7UuxKP+v1alAT831UX8DECgae3tCF+rx1Z9AEm/LcIDD9
 jXZwb7aLO0+JGjg5Q5qionnobYlFTwt443RrgSQFq9Ay7soo0JKgH/ZJMkFnDRF6JpgDLWdnHpr
 Y87geV209vnalTwaw8vImWkMby11nwO35XNa7NepYLpbCjcDJqeLfLlGY1EGdDTnVsKc+vcjMvM
 HtPmJhtgwjKMoAwX2pDQ8IPgSJQ4R1ZFixNCM0guNZJ4YcoKpkCfrTtJ85jgfy4fnXwciggprH+
 qeLDsw3g2JMYqXObQvgX3uAdippByUQ+zhQRDUJ59/5E9IRE7YLw==
X-Received: by 2002:a05:6a00:12dd:b0:82f:6640:7229 with SMTP id
 d2e1a72fcca58-8415f5a61a5mr2342989b3a.23.1779430191816; 
 Thu, 21 May 2026 23:09:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:12dd:b0:82f:6640:7229 with SMTP id
 d2e1a72fcca58-8415f5a61a5mr2342951b3a.23.1779430191224; 
 Thu, 21 May 2026 23:09:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm807951b3a.18.2026.05.21.23.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:09:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:39:31 +0530
Subject: [PATCH 3/7] efi_loader: firmware: add last attempt tracking for
 RAW capsules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-capsule-v1-3-ff0ac9978d48@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
In-Reply-To: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779430171; l=3151;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=SVmzAs8kSdinpyj1SZ8tsTl7rqMTAk7dvFwXPWu9nxE=;
 b=xAV47Yz+i7mMq+/N13ZU6Qp8hqUpjUH9X7I6IzZavaakkN8GEZ9MDv+rVilTmGVOCJd8HdZY8
 d4HSWvBJHjPAVdLqzQLjtur1g/h64hSV5ooXvDsc2oQJd044QVhyFQf
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: f4Dz0-6nD8fBWSxQLuNwLgb4arqVcqZv
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a0ff331 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=iVkKSXv_qfZeXr47oIAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: f4Dz0-6nD8fBWSxQLuNwLgb4arqVcqZv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfX+AI7PEcvwN1H
 S08ojiKhF/jbyV+nRSD5bzuuVvDenkvnbfEB9IvDlmyA6xC6tCPVKexepVMs0OhnCTfvW3DLFRn
 R/wgIGOqV9mOpZBRzc29C8W9ueD6q49nYgLZbxccYqiGD4RozeVmHooqFqxH1WMPZaJ+zb0cz3v
 bWfyjVjM1ehOK2uzX5vhDwmdsGfAhqkMHKPk2aOqlV+TfNvb0MYWy0ZbzlA2U9QFgNHWPSPYWOU
 KEcxnwJpFshxpobtghUIRWD6WbBbNb+FCGwJsMlXxmO4AIjFqwImT5bVmYIRCspsV0tpxm/xCWX
 Z/yFVjHlZQ8hOsGxX8b3Xn/kGPnN+zfbwfQVkijwI1o6LVojDtuef+C0TUmcrga5SSDEP7iwyrk
 oDfhIVOKo8nvBX2ecC8x8WzXDz+cYlNET67ilR0xElX3q+y6h6sg6gzLWVurF739zF6I+lzhxIX
 2ub0REzTkgLb3klkLKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220059
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

Add last attempt status tracking to RAW capsule updates to enable
proper ESRT reporting. This allows the OS to query firmware update
history and determine the outcome of previous update attempts.

Track last attempt information at all failure points in the update
flows. Update the FMP state variable with both success
and failure status to maintain accurate firmware state information.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_firmware.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index dff8de8cf8f..c30283cc9e4 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -869,8 +869,17 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 
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
@@ -895,13 +904,21 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
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
@@ -912,9 +929,17 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 
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


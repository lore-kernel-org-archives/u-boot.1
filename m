Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D775CD4F5B
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C8D846A7;
	Fri, 22 May 2026 08:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kdj2inSN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fzKEbNgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15C4846CF; Fri, 22 May 2026 08:09:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A3FA846A4
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M62cwB776878
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bmYawUuJvTeuqjHnWtRNYr3nEw2J3OPF0sa+HXYMg08=; b=Kdj2inSNNWW1hUNq
 bhPv9GrQcVLulfs4fRMpQzXqAXzl5Ua4MHLaITPdBK+c0gOg/Dgfxbj9qKBIc/C3
 5tbNEXVITMuVg1hA9d98+kL88bj8quu3mJCOrjhnedHsYG0sMi04dCrl/3MbNOFs
 lGnAqZzVCTsUQzjktgfLyerLkcSQ3s2ze/0cQQcMwUag+YgGhVZF1iQC9lvP0UDP
 0SnQZUNKpUTjcs3UjgeZVJ7/zfsYU3uA+TyyPksnly5TvFDp+A/PsJD4du7YeBpA
 AtjEvH9Cirvq1sXU0SsWcGgNgIykLu+vGVG6lP05mywQBb9j3M0aa1iamXqrBZJG
 tJHJeQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h1vmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-83cecc22d5fso3625156b3a.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779430187; x=1780034987; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bmYawUuJvTeuqjHnWtRNYr3nEw2J3OPF0sa+HXYMg08=;
 b=fzKEbNgBWYsM97C7cIWRPQkd6pZYkPXoWD8ZBcOuutNWu3eXqPA4ZcHzFH//cHjSuX
 +uc/8Q4xBUhLuRZsxdUf++VtLlS9FURag8BpKqDLamPx4b6mbmcYLlphl7eKmJT+x2NO
 /BS7z38M/t2h+8Nl6QdxVFD1Pd3nOlD9S/COBjsrzZltMfO3wlvYBJtBrc+NZkj7jMYk
 E7fixzwHOP4av18QzKsKICdKHjGHxKjCbZZARaR/QLhhUgyZ6hq5m6P7QkhMEP0IdZEY
 P8Ik5EFS1rRM68EV1wMQPYp9LAGVH7VqUAP52LyhMCy6Vd9vdHKRuEJC21EyayaZsmEr
 vMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430187; x=1780034987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bmYawUuJvTeuqjHnWtRNYr3nEw2J3OPF0sa+HXYMg08=;
 b=rqdoCojXtVdbEso+04U5//Lu6iHNdPRDmAIZ7gAEKOwqOLPrN32BqFhy3YbKpx9JTw
 cafUmxpijXbQF6VzVQK+v7DCC9UOAkuaX3JZ6MWQmJjvvGEmIzbDas4ebDCVfXsFlngM
 RxpY/UjjMh2NhvxmQRlo/OSQOyZQTg8JOgKpJXj8FTCDfG/+eZ7Wh7btSK5Ftbe7F0ZC
 Ys3vJP8R6GCJMqw6JyU/NUC15U4P6RFCy5IqKRNOakHIQ3qQraQyVn1rYCxpNxmqImTY
 13nTzrofiYFlLNbo7PyI2EiEKRInTIqP5ooebIOumL7cx8sh1rHx0EEnuG8mMfP1TlhH
 N7eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D4mqiO+PXCnaG4NgeCIeRSyfDG5a6HoFJ4naBFOAYzQW3KygYf+9/SxNInF5RQ9HHU4hW9g4=@lists.denx.de
X-Gm-Message-State: AOJu0YwuZMB5KDIndB3/7kajOeClyNkouKw6lT+YuSx4qXKFkaqAxPwT
 JxOp0P2/plWSILRU6yBeDHPVYtDQlHmTvGNxKmOYQBX4i99N4sA90aoNb7cDTzki+Xo7j/8GssF
 6en7C9OJmM4UykqN4IpyTu7eZj01PPMLF2ZH86AU8A8XW8W/QFR+GaJ63
X-Gm-Gg: Acq92OGMF6cRH5Bte9rTHEY22kZF8rIivann0VFgutjm/fD6dp1FFL/pZB7mDefti2I
 jpIVM8H8YxRSVTb/gLegnw28Cx1CDmAtGq+TIMJuaXJw7BOID5ASq7d7hC9l7UfPSiizw9hVWfe
 mmI1futMho66dLZBXhxdSsTmQ8MLexL9sUNbw1EO7tBwcbWNAawyeQMrHLdAPo8g6at7wvv2GJY
 qCqYRfykeCbxNXptLiAW3J3Md84OVJfCUeI7U8632dpj0b9QeGnuEyo62Z/OyWqwCfmG0br5dkA
 ugXLeV0sLopJS3qlF7rw2U46tBzN9skrzo9xu4fJF72wObCIrLaFkxLZcP6/LE47HGqXrZ/+jWr
 kw7DWGrn/cLJCoMVu7I6GnWN2bZWwRbytHV79i/cl4t4qHZuFEZYB20dQOJqaI+FFJkwwR2l1OG
 /jZJZC/1PI4D+kqMFQ1feNsVZ+IcXJkikfSVpixgPvZ1/Cw2GK2w==
X-Received: by 2002:a05:6a00:298f:b0:83e:c76c:d720 with SMTP id
 d2e1a72fcca58-8415f407bb4mr2118489b3a.30.1779430186720; 
 Thu, 21 May 2026 23:09:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:298f:b0:83e:c76c:d720 with SMTP id
 d2e1a72fcca58-8415f407bb4mr2118452b3a.30.1779430186186; 
 Thu, 21 May 2026 23:09:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm807951b3a.18.2026.05.21.23.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:09:45 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:39:30 +0530
Subject: [PATCH 2/7] efi_loader: firmware: track last attempt status for
 ESRT reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-capsule-v1-2-ff0ac9978d48@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779430171; l=8333;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ex4OtBSVAUJFIARGg1xOuQj5su9y/Vq8SsUDQl4C0dM=;
 b=DpPYk0FXuB/X5YXWfb3HQXAci+z7y3bkzglDTstbbmRZso8YPqPpnGLd9fk9ISt3n0bg5ODgM
 iCRKkmsIBUvCcWoxoT0leKdmDnvxu8NwN/YyWYjMRmS54m2vSIprwpC
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: iaPYbGT_pfmXx3WY7clSFzO8YPfGmWvX
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a0ff32b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IqIriNE8tr5goe6QUfEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: iaPYbGT_pfmXx3WY7clSFzO8YPfGmWvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfX4hNkmu2NjVGr
 F3j1FJrZKOgdlphU4hXaeVk8aA3/OG1CrR/NLwWhl9P3shNmKn3UAgrHUcW3wR4OEZqC9F9sIot
 4egOzTnAwBtZiKknJTNDPs3DLQzgTlRstieYRJQiwfjtYiSB7e6vQcQrxeFJOitWCiJFAgOKq5C
 r+UhrpRxSDLHTgkMdBGeEUcmnLaj8V94yu5NNAlV7uZBPgp+2yFgOvXvQqCuJkXmxAUxJOsvKxN
 laOkDO0Ul6vhvbNhey0BoT/d+qWhxWPZVv3AYdSCjkL1/NTFsQHSDCo6mYjlhzNfRcCPEmCx0dO
 I0nAGjwG9+fYFRSYyIhc+gEqGWcLsgf2ss6UCZXWMkGGcKzXp+3RJ1T4gQrpPzS/KXeMz61uaLq
 gDQlAC5XUYHCo2D4ZXb5x5/voF5SHVKcJp9YHAtu8MIXhR5EQB5VhlRLIg1uQzLHt4SROsl0kfu
 jiZhYrlEw7I3D583B+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
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

Add proper tracking of last attempt version and status for firmware
updates to enable accurate ESRT (EFI System Resource Table) reporting.
This allows the OS to query firmware update history and status.

Introduce helper functions to manage last attempt information and map
internal error codes to UEFI-compliant status codes. The fw_version
is now only updated on successful updates, preserving the previous
version on failures to maintain accurate ESRT state.

Update last attempt information at all failure points in the update
flow, including verification failures, resource allocation errors,
and device errors. This ensures the OS always has visibility into
the most recent update attempt and its outcome.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_firmware.c | 129 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..dff8de8cf8f 100644
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
@@ -190,6 +190,67 @@ static void efi_firmware_get_lsv_from_dtb(u8 image_index,
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
+ * efi_firmware_get_last_attempt - get last attempt information
+ * @state:		Pointer to fmp state
+ * @attempt_version:	Pointer to store last attempt version
+ * @attempt_status:	Pointer to store last attempt status
+ *
+ * Retrieve the last attempt version and status from fmp_state structure.
+ */
+static void efi_firmware_get_last_attempt(const struct fmp_state *state,
+					  u32 *attempt_version,
+					  u32 *attempt_status)
+{
+	if (attempt_version)
+		*attempt_version = state->last_attempt_version;
+	if (attempt_status)
+		*attempt_status = state->last_attempt_status;
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
@@ -237,8 +298,15 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 
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
@@ -427,6 +495,10 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
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
@@ -471,11 +543,19 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
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
@@ -661,21 +741,40 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 
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
 
 	orig_dfu_env = env_get("dfu_alt_info");
+
 	if (orig_dfu_env) {
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
+
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
 
 	/* Make sure the update fitImage is properly aligned to 8-bytes */
@@ -698,9 +797,17 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 
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


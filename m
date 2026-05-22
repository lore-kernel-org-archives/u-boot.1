Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B847CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460D68470E;
	Fri, 22 May 2026 08:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPHj++Tg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="biLk/Occ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C6E846A4; Fri, 22 May 2026 08:10:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C98483FF5
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LNxqIL778834
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LkKuqoRcPr5gWcEe+xFy5Mx78QnGPUDcFqGP/zHwbFg=; b=PPHj++TggSWqhRaW
 ra+Z6lisjcQUKTAaFQR2Jy4XsnPc4mPJlKL3WoitaFKM8nVd8IH+TN7sNL4RQBoC
 jwqs6zq2adwL2+3hD6gFyt9YMFSNnv9WGwunD6ZeU0e/5kAvzpWyMcGF5vTZvAj5
 2x0K86VLmyrmRkgK50MA1/ByCwNIuTjv7XrgOMsDBCn/E56LVUKvn5dp8dMKmBt2
 HGHgtBzIlatndlBjnvVoWoeS766ur2PqN/NqW/Uv+T+jmv6nV8q40WE20u1W6b5Z
 zL4fSz+g+WRcOSN8hghl92N/0+/mDEvFb9bwmuwKUVriF/ZDTW2GKTZqV8xSPTb6
 zCWd7w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7as2h3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83eefe4867eso3760118b3a.1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779430197; x=1780034997; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LkKuqoRcPr5gWcEe+xFy5Mx78QnGPUDcFqGP/zHwbFg=;
 b=biLk/Occr4RAg7DxVbUgoKmQuZNp7/c7rBUXoYpRKxHuysYr7HzGlShmYLU/7TLdTS
 REi+2iyFTPNEN41h6Bx5FtKNp0nzeOTlDGomBhR4d5GfQvbh28KfFPNxvqNoMDvUrUtB
 l12hr8UJIOanJddc0zayT/D32dwY/TJWEs4UFzRh7uUKaqxY/I6qAPGjglOZPNJsLXnD
 fZBX1eWVhSKyRztZyGb/yFKcIL0F4tGd2MMbnscDKq4gdSO7fHvKBsuDVTcCvI0YII4v
 NPc5/Cbm6Fsq1tSRzawCHvQE+AA132fB4TTIiu3y2LHeoheEXW8DzUb+9G47SOF5vfRM
 n7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430197; x=1780034997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LkKuqoRcPr5gWcEe+xFy5Mx78QnGPUDcFqGP/zHwbFg=;
 b=rwJVFGSmNVcd1abdefbsPPTfT1I2RkH/EFWlD24ek7ifFoKIQEbkYAC8yJlUJoY2vy
 nL2t7ebD1wf+zCnLQBt5LJO4hPRjka6oKfe3psf66Q4YQN4opF4bNh8xzVQ3FgfCJOcJ
 eIlg9c6XInwGA2q0lEKlfE2n72cQ7izXX00gdGNIUiIafuKZBC4qqaQAyakNUjMaLKOp
 HTqRFjMdoWwjVD6ZD2g3PZszUokzBc9TC6x87KvVId7CC5R8X5fwTmyvWoETw3q4Myg7
 ROfsR3gXTsPG/lXdEKZ8UO2+mzclWWP8BPkw39Nomzc/DiaacgJmYdzVGjJ4EJYURIGh
 KB8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IkwlHZsuLBGcMhPXdUsVbv7miMKyhCLYCMjZzKE6HiDfsnLT7Yxvar0/m46s8KerZp6V5udg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywiyw2gv+p0hbv2HrcW1aYIRe1nqesVdSrLkIMu8CL7aBiQBRap
 0/jL9GhpT23RKPuEqa132lQo+R0bpbXPtaT0hQpLqW4sjdnp74t13mUbpUsLQaSuQNjqlzN8tJK
 /dHwH7y1TfbWkYpGJSnIC8Hn9KnyXfUhQNnuQtoNjk8KjOTLk2dBx6F/q
X-Gm-Gg: Acq92OEQ8PTc+c0RWo0WXMTeMppZ+AGp91jBTroS9DJxmhkiuvJyS4TVC5/CDXqXEma
 GlmBZ0E1KBB+o2mlKd2NPmKJRWUihcPL7bKUvkr/ukPHFh+JhWUXq+DpgNkqUK5IDUofZcJ37Au
 /q5ZH/n9vl+be/8KIqRETbnyGxMhHD5chgzoQn23WIbh+vR1bgB+QXSWrwmWmfvTDVPw73HxbiK
 rRdelcV8x2nv0reNGP7Y+NB9x81ADXYbysWC67UE+SsxmtlLwLnADrZ8WhxWOIMBoT2CbmQFOG5
 XAVE7272ibo4yxq4d5VyXGrp1L4PEEtnU1xABb2xlj0hpHWOgNFPFIH/3bfd+nKoHiy71geM9vZ
 cuDPeXeSvuQD6s8DPztY18r/uiqgXzdEJFqGw4XcTZa4u3B4nLgY52jOf7CWgjOunVxE5K6b/0l
 2Wy4HMBO0wK9xi+u599ug/83TEvouegmvvySZMGqaEMa6DBgrr8Q75jrPEwR9u
X-Received: by 2002:a05:6a00:ad02:b0:837:a211:4ed0 with SMTP id
 d2e1a72fcca58-8415f5460camr2394055b3a.41.1779430196743; 
 Thu, 21 May 2026 23:09:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad02:b0:837:a211:4ed0 with SMTP id
 d2e1a72fcca58-8415f5460camr2394025b3a.41.1779430196246; 
 Thu, 21 May 2026 23:09:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm807951b3a.18.2026.05.21.23.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:09:55 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:39:32 +0530
Subject: [PATCH 4/7] efi_loader: Extract FW version even on authentication
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-capsule-v1-4-ff0ac9978d48@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779430171; l=2019;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=svhq5CxaJGVVxevphcLlE1S9xrPYN0Il//3zgh4iYbI=;
 b=bCi1mquqKSeh+LbF4avNI7n5CVIHXUewhwTI5AHvj1YI91NnME3WdQ5CcAfy1HVdzUReGYRL5
 M8Rn9YPFwppAnPNJ61Tun2HGPPlIfQi5GLfGgV+mTRh2MFiHY+W5KO6
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 7wDu239hGRNxRmvPvSp-iz_eTUHemiLn
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a0ff335 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=9GGkdg1y0xL4wW6bVOUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 7wDu239hGRNxRmvPvSp-iz_eTUHemiLn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfX9ZONFtc2xK0b
 N46XLAvjdK0xrv4oR9n42Tztv3aT4vhUk3sVJCQgRfodBNZ4Yjv0ua7X4juMDFyjE/p0MFJ9gKk
 kIhf+cm61Ehq87ITbP88dppsXcFutsmaCk/HQwL1hTNakXNZBqSP0Q9gCpnyrvXecNGlfKCfVyy
 2SDWpd21ttSzBhy/9zqL3ihe70cEKC1pA/3ycMuUQNnwT76OzAKOotWReZfPgHVRB6K5uF8g3Jk
 BcrqLH+pNvlGV4FxcT0esvluGnzVkaj0XKsG8OFlkzdovsA33YmY/vQceDKd+Qfj5xPYQlCAD00
 u90qIXtxpjtDeQkcsgDjVNLVswU5CfgB4gQulGnDs2Nzj9ZEfCpSm0r9wFpi3AVv2EEt6JJa63f
 MHENLs+He+zh+1m5DTNDmweNQecGDIgqPwdXSXJRCIoDhQ8DhusAhp3GTeW8iYnO8RMXanINFB5
 eG2mEdznIBqA6BAOXew==
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

When capsule authentication fails, update the image pointers to
skip past the authentication wrapper before returning. This allows
the caller to access the FMP payload header and extract firmware
version information even when authentication check fails.

Additionally, call efi_firmware_get_fw_version() in the error path
of efi_firmware_verify_image() to ensure version information is
retrieved regardless of authentication status.

This corrects error reporting by providing version details for ESRT,
even for rejected capsules.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/efi_loader/efi_firmware.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index c30283cc9e4..ce6ca04ac69 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -471,6 +471,15 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
 
 		if (status == EFI_SECURITY_VIOLATION) {
 			printf("Capsule authentication check failed. Aborting update\n");
+			/*
+			 * Even though authentication failed, update the pointers
+			 * to skip past the auth wrapper so the caller can read
+			 * the FMP payload header for version information.
+			 */
+			image = capsule_payload;
+			image_size = capsule_payload_size;
+			*p_image = image;
+			*p_image_size = image_size;
 			return status;
 		} else if (status != EFI_SUCCESS) {
 			return status;
@@ -620,11 +629,10 @@ efi_status_t efi_firmware_verify_image(const void **p_image,
 	efi_guid_t *image_type_id;
 
 	ret = efi_firmware_capsule_authenticate(p_image, p_image_size);
+	efi_firmware_get_fw_version(p_image, p_image_size, state);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	efi_firmware_get_fw_version(p_image, p_image_size, state);
-
 	image_type_id = efi_firmware_get_image_type_id(image_index);
 	if (!image_type_id)
 		return EFI_INVALID_PARAMETER;

-- 
2.34.1


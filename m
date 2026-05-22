Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20208CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3B6846A4;
	Fri, 22 May 2026 08:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z7F8dVxv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ekAZeMWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07EF083FF5; Fri, 22 May 2026 08:10:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6F1846A4
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M3hwAi2765201
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 avnBWRxkVUU2sBSo7N5xUv9GayYP02iB/xK+7wp0Uko=; b=Z7F8dVxveOcUU23n
 G6dWwrTPBpOC+mHv6vfyFK2iuzVjxuT0Rz4dalC8cNkyJ9qieqEJEjo6oZXL3mPF
 b0OaOPmX9cnHg3ardETK1Ge5dFoyF05Fu+4nzHklZU6HOs5s7NPTkScK2lfQmma5
 LzGSYODvzdV+CZyTfhn7KEwqvh2EFURIHwKzIe6F1/MJc52fI5vh/Ckyx1Gugf1b
 6xZRH+fsPlqafnEEj7wHLUYJ3dIPlu9bfqDhNkYQcNo+chk4JVYJrUu37xZkTcuC
 drE8b8LEWdhkK8pwckUkFH7Slz62NOuzGl05tHxhmGsSxjV4QK7XrnvbewG4BgjI
 Mf8j6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7ub2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:10:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa860e71eso3553708b3a.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779430202; x=1780035002; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=avnBWRxkVUU2sBSo7N5xUv9GayYP02iB/xK+7wp0Uko=;
 b=ekAZeMWlOC4VljwkhMwEK7DjBPyvqP/XS9hOnM91onSm+3XV9PGzdMB7K8QzLcdY15
 Rx2ZwuOu4wu00Bkz65u8wuLYP36v8ahY9SFHtNOwDjnBdzUbGHDxtJJqmerMUFf3hDAZ
 5FqBJFGU9Nf0seWvrg2hMhYZp9HA8cNUFyFoq3XwRU6amVhnOeI2hnLfIWXeicnj+ObA
 JalmQNYbwNQnf4K2WpBwqYcznZ/jPJ1v1i76Ul6JZIL0QcVGa1NDhRDfYJrq7GK+eQjR
 EjaHakCGwauKwX0MaeZdYZiyzR3tJpFr/CD2jXcEatpz5ex4AGJ8R75zMKkF9iPnUJ1l
 1cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430202; x=1780035002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=avnBWRxkVUU2sBSo7N5xUv9GayYP02iB/xK+7wp0Uko=;
 b=XS4A09PDLXbeQ6bx7X5ujXafoRQouuJV+ayGvtU7ebAsYH5CJlHOIMIgFLEKI7PJ94
 tj0XEArY/76ML1H2adw9iL6YMkSP7xfV6FzJS7CvAREm/QHcI/Jrsg9OyludR7EcQQya
 Eza5M/u5dBm0RINCaFtkC+NDY1UShtQwBmyfczAO9K6Uun94+O9ipEmaCteLvDdU/qqe
 KdjwX/PFj5zXLGqPLYhGAZ7+vRk1Y3AV4QKnrADMmIm7viBVOl/XSdWDRXcuWIdqCwDI
 J5OorO6/WqxsstRjLezlwgqGcXmZLw6uCW9uUGmNB9T00OsVXW1rtpqbNvMoSbtfXbIZ
 47mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wClY2BLdbwWGp3cQbwFEf2cBoQeLP6OPcrQM3IW2pfRizNSVVm2YXQF4LvTCy3J4TQ6wDg7k=@lists.denx.de
X-Gm-Message-State: AOJu0YzV9BE6epu3pU0QGJDxGoRjjQnLbQwS79DdhvJnEu9S+GuaE+l1
 ejOXhZJLhb5KHmAPqbazqTzMrpx2z6QfiG4prn/z2A2zqr14EUca7X9h+lAFtyz7HU4k+eDYK60
 K3meH+Bx1nysOlVy//eQr8AVn2hQ1Iu8tJ8NhVtyJVLePerbhR4uA3535
X-Gm-Gg: Acq92OFdoZuOi1QDNUv5QlZBhse2jGSffYyJ0xINl5BbPIjvwBn7aHCYtoGCOL9cLfp
 kL95vL85/V0/vHJevgJIKQ83kXg5G1rFPAtwN68X7o9p5wx2vgeUTjseTkz4++CIXbXa5C4taqr
 CgYWOr/sUXztNI92hkcbTiX3fNij3HSJC9orGFl0nSks7/t4mZznrDsPN202aaGzzSTuSxi8kwt
 k9REZaQjSi5xfjs3fUK7+iD/RFXcEGMWC2zeyzSXrcybRkKegx20TzL/agTzVZSarH2IljdFaDT
 AR27ZIy3QG5asKxx8lKcOAIUYRam4UMk0Ss6Pw+zV7kkco0kl7EsGysFf0ZSVIW904WW+Ge4euQ
 F4A5jQF5QhbEg/R48DXeGNLtcl7QisCWvFcZHqFATStDbALzmsCwbJq9EEpmH0TurO3glhBM8VG
 t6yR40Cu42cRnb+Dr/YK+o4XVwd4yKIe9g4ipHGq78Q6q+UEzyvA==
X-Received: by 2002:a05:6a00:4407:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-8415f1dd248mr2415267b3a.1.1779430201819; 
 Thu, 21 May 2026 23:10:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:4407:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-8415f1dd248mr2415212b3a.1.1779430201214; 
 Thu, 21 May 2026 23:10:01 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm807951b3a.18.2026.05.21.23.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:10:00 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:39:33 +0530
Subject: [PATCH 5/7] configs: qcom: enable FIT capsule support by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-capsule-v1-5-ff0ac9978d48@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779430171; l=754;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=v1gN24f7v50SysIJ8LO9K1EEZ9GENnHzgi2SE6SbYt0=;
 b=sdylXImVNNmkQ1iv0p1AYjxgdYNbbgM1H5pVH9c0Hb8mL+Es8tKHoEC5MPI6sH+X8p3hF3USC
 9A6mQMSeL18CxXUkz5Dq3Sk30g/Tbtz92czOrR0e3cOX38LS9mgWlY/
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a0ff33b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=EvoqSR5td3e9X8VeMgIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 3ddvE9ePHrbwSI6Vf6NrfaAV2p1hcC48
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfX0L7+zR7usBRs
 VIGdsy1fasgvJ49JF5VcaYeumhKri6bip9nLSezsZz69FoEw+/QZFV0OgQ04Vwc6xklwabJBVA1
 7uJsEX+5YVHY1jPPx98GhfoHdMMZHVTCiwr1ITtv0ueFC5PBIIbm5Yhd0u2hkB1ERkonPBlULAx
 9NRL3uoTTWkiqunZVkSbD3pS5ieUBzvSOLZ0Uc9C1ldioGL+FR8UBaeIKfdNdUCjjOFqlmRjlko
 BG40fN+KIX0Nylq+ePdTNgr1EFoF8V1OCW7De+NqaheY5pvXIX6X5vz63xqowGZZ+oWUDrdH3S2
 Op/xX335P7V4OQnRA+P6m7fOCInnXNh+oFS6gFCfBq7uV8I5jDYTDp7TLNBEQnPx2LBCZod6AM8
 QBfyuPU5n3pKmzFA0rPTYK+NTlh207OE2m4Imyo3bKLal+wUX8PKQbHeWe1n0BVR0eiK7JXShgq
 FyS6VN7Hxt5da9wFK5A==
X-Proofpoint-ORIG-GUID: 3ddvE9ePHrbwSI6Vf6NrfaAV2p1hcC48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
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

Switch from CONFIG_EFI_CAPSULE_FIRMWARE_RAW to
CONFIG_EFI_CAPSULE_FIRMWARE_FIT in the default Qualcomm
configuration.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70..25059d2e6b4 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
 # CONFIG_EFI_HAVE_RUNTIME_RESET is not set
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y

-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B24CD8C85
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 11:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B6F8466E;
	Sat,  6 Jun 2026 13:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HOGlbAjX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JQY+BQM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839FF8405A; Sat,  6 Jun 2026 13:20:38 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DC0838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 13:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BEGGP1331289
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 11:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/9vY+KX+wxNGPH0XDHcJyj
 EDtTOPnB6BYuKVimwrqtY=; b=HOGlbAjXrXISh3++BRJl8KydvpVRRTsw4tGm7n
 gPWKgkthgruMkE869x4PsDl4qWeNqWWuS9mbaJ6znXs91DGtC3R9Ccq3+e2fJv4l
 X4qGRa6HKZzHnX2EQldZ78vZDE2FG3/cN4MWIMSg9RBIRewDr87SZkdziHwDY7OM
 ID2ZvcHzy8ZvaLYZHT/3ZN/vQi5gvVSsKycq7RgidNVM+5sY9E8o7Bdzv6Hp2HWT
 hkuPcodX90lfz87AZvIjpDCT9RBcisMUOy+jaNeLb0ZTfupZuhOGCU2hsiBV/djV
 VY03g/9iV6EBUgR/U4aKP6UG2S07GtF10GwxdNO/YLQYfIOA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98csema-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 11:20:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf1845bddfso33052585ad.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780744834; x=1781349634; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/9vY+KX+wxNGPH0XDHcJyjEDtTOPnB6BYuKVimwrqtY=;
 b=JQY+BQM5NMyXom1Oy/RLB3PLr/8fWsdk7WNOXCONKB6HZ4nU/MkXCsfs6Fz6UyUbS4
 ZlM+F5P/3anI8e1MYE+HF4yY0hxb/yONMVJHm1cWDnXek5VWl1PHFowXQN9JWsHtkdq7
 HcjudVPvLxD/yvbxslDVVIxWUXB5Gb3JDCwZ/gowZSsrojORXiEoGr9TQgqZ70eDGx5F
 Oqj34zJ4YLEXKa5tzNkTKdl10/R7p7QRTDjQTWF/P7oJQ0GNOTHxWQohXdr7MIttNNvt
 WmILeDZG5YnWWTX7dMFE+jTnJE2R725EqnVH2yvpe32R9/udzoEb8Stqjg70hlQVMgQW
 gbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780744834; x=1781349634;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9vY+KX+wxNGPH0XDHcJyjEDtTOPnB6BYuKVimwrqtY=;
 b=cVWlDYzieqOTFeZnv4ZFm+NR6fdtjkGLp45NlPRRLfZDxjbP54lLgZulMQmfp+8aD4
 EeKow4A5nAy68dNQzVkFIhq8tLGN6bAiYm2ndiEz4YCnWnpr5TzH6orQeC8Vn8MotlOj
 SHmOgIw0xnID1S3a5TmK6DP3fH8NFjOVzigq458Hu+XOFzrQdouDdzcPZNaqzw84M55O
 Z3X7xIpUlhsRw0hdLp9uiFh1Zc6mU2873Ijwp+9UrPNfXuexAiKKurNEn0yR22xx05P1
 JCz6B3RXYNCLNAjS+IVTeQkxQelCw0sEm5OLkjoP2Br5ktRCY1LQBC5FXTOLZgMM2fnF
 bwOQ==
X-Gm-Message-State: AOJu0YyUGhs44uSCBf2QQ8CJkr0sttz/2j/jfmBTTmA1l4e8Po2Symig
 xfPiJUc3WE4diqfTVKQoUqBOlRVIrgpqtLNoWzb+Y9SL558BazbFg02MIznO3FPKZvgZ76aqSir
 VBa0WLJIQSpL9N2xEzp8Xtz1fZBDgoc2Dd/8Gdgf9r6vcLAF3i7glZ+HA
X-Gm-Gg: Acq92OGlbA237dqpIjbF3TZdgI6GqN0zsxRkPnkWrXRPP+hOnPcw8MVIOD7h69T53z0
 8BW6CwjbQo0t0e4F6Hh8YxEunTML3u62iydIAvO6zMAC9lakIRaiuzPikMvy6kDyXH6iTOoFCGy
 H/wDuEtHhIfQpqi7K47RLOsTSROsPJdqqcV3f9AReESD9N0TmtJFFc77gym0CCSYz1FILVKodA/
 fR3P60LLlzhqpnj0z9YMdj4Ngbnv8D/t0mNQ0gLQGPFre2LbOXxTDxjGcVGkrQhJYKC+dpXvul4
 AsPWK4v3lgQGyxMbmg8bWzArbQ/QRcrsVUahtLXmMGDeBIVFQxiDtwF1dQychnbZXu+KuOWr0SW
 HydGk6SE7+Jn3bcNHVRaGn5M5A0+Ofl2zD8dRL3q+vYH/RtDYXVQtc6j0nfH6c8idOZVqzf9e9E
 L8zdKKib4UtgKEpvhHEhwD91IU94IwSaU0a+YmeBjadMx17v93OoE45MXFk1WA
X-Received: by 2002:a17:903:1b4e:b0:2bd:8dbb:293e with SMTP id
 d9443c01a7336-2c1e820e57cmr90546995ad.14.1780744833587; 
 Sat, 06 Jun 2026 04:20:33 -0700 (PDT)
X-Received: by 2002:a17:903:1b4e:b0:2bd:8dbb:293e with SMTP id
 d9443c01a7336-2c1e820e57cmr90546655ad.14.1780744833079; 
 Sat, 06 Jun 2026 04:20:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6e294sm120672185ad.6.2026.06.06.04.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 04:20:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/2] Add U-Boot SPL support for Lemans EVK
Date: Sat, 06 Jun 2026 16:50:26 +0530
Message-Id: <20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHoCJGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDINTNSc1NzCuOLy7I0TVPNjMyNkw2NDNJNlMCaigoSk3LrAAbFh1bWws
 AbcAsclwAAAA=
X-Change-ID: 20260606-lemans_spl-7c6231c164c6
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780744830; l=901;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8rcqe9UVmtewkeHWFGgyvHxYvNmDUO+Ejmb/IPAhomc=;
 b=63JxxRRwomy2/qI/Cs+50heKJsF21AvHSy/n59r8rnokJwqZ4uLgIEnXV2W2KcaJhbcqqg6QT
 UZ/j4wjIPc+AB0mQV0YVIja2psUB5ExHXa0MMFpbeXRRuXon2qPT2CE
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDExMSBTYWx0ZWRfX2iZCF8GCMc86
 Cj6kR4UXbAH+vny4JhEmT0ns+j0qcb5qvh6+8YLheTOBGtCG4+/dDQNbo8JDdxI/aJXTmmuKZEa
 sdZq9D7CKgjjkWH9gr2hMUwkBUBKgP/hLgz2pWHvi5SRlpYV8rzE+5IQ29OohpibGjmXbjU+BX6
 a0+/mAbTtz90wHojaU4x2/NKbSVrBHXJoFSM01RIDMczraE0uicAZ/IJ4A80rQ7zeU+0IBKxbi2
 GDxbD6EpzT2JkqPidtnobuirOUcFVhazxYNLJZtHkxcG6XQjvtNBSscsNOs6en5tr7iXGjSvzqV
 bI43q06bUD1hYhrPHDh/ZEL7yZ254F/BWL2VuWkgVJXJ7KmLXbuAMZ5S/PT+gVmbF/3SINVb+TM
 vP7K9PijSYUowqzGfRnqFPtE3xaiVfrPvT0OHLvKu5BAAzlmFWcZdFsw7/c3YoGiNb+MvOar5tn
 vrDzNNxgGbY14iQsEJA==
X-Proofpoint-ORIG-GUID: EKdG15NrCRfbHM8SyD8ML-vVipWYSwSB
X-Proofpoint-GUID: EKdG15NrCRfbHM8SyD8ML-vVipWYSwSB
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a240282 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XzbtZ2SWhSquIMfxYcoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060111
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

This series adds initial U-Boot SPL support, enabling the SPL to load
a FIT image containing TF-A, OP-TEE and U-Boot proper from the "uefi_a"
UFS partition and hand off to TF-A.

Patch 1 adds the U-Boot DTS overlay for the Lemans EVK.
Patch 2 adds the SPL defconfig for the Lemans EVK.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (2):
      arm: dts: qcom: Add Lemans EVK U-Boot DTS overlay for SPL
      configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK

 arch/arm/dts/lemans-evk-u-boot.dtsi |  63 ++++++++++++++++++++++
 configs/qcom_lemans_spl_defconfig   | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
---
base-commit: 75daa277941702bf58c88d65c0cb6ed962899d9e
change-id: 20260606-lemans_spl-7c6231c164c6

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081E4CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307E1846A4;
	Mon, 15 Jun 2026 10:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIal9jUw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EtDCfASb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1DE84704; Mon, 15 Jun 2026 09:00:39 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0602C83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J8Z23250401
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xeh/UcF2lXpiXQR6rtQeI1
 7ktRttU6tzvjgad2vzD+o=; b=PIal9jUwbS2bqYhpHN3ohoYQ66T1EakiBrypR4
 /veh80puuslkOJdD3V7JDYmc3dmrYx9cCZsH5XOP8oFyB72u7jPlWVH98r0LaACt
 ZSWM/x2IKLfxiX3ag71VUYDbWdc+/EREuPwONY1L4yjac5SRQJB5Rhju4C11/6Mx
 JvGaGMMoS4Po3pIwRIrVSXB74A2wW8mOekeSUu5mhL2S3c7VFW86PJflsiNdF6V0
 MnBPc0zeOmWWGft4zQAosCXUmGxODXs11GzlSb3CPBDUkn1kRS235Sah14HsCV8J
 uNCZ035OGrcvKd4p3AKLwXk+CwqDRHO8qASUV37nzi7v9r4Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryybwyrm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:00:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842211d6e48so3813515b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506834; x=1782111634; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xeh/UcF2lXpiXQR6rtQeI17ktRttU6tzvjgad2vzD+o=;
 b=EtDCfASbF8Gb2rVA7sJe1o56Iv1KZXI77DWeUTeEhgevBZchCDuvZqivfAz5fYvA2G
 wWZjINxW/JENbAOCLYhZMBFEiQFmXZpXYH3NAXNw071ABsF8sA+n21bb5diV/51YTcc8
 v7vr9UFk5/W2iJ1KR+LigJHzyNok7Tcmwo5JJtNC8EvXR3jv/V/Av+4AKrGceO30ruju
 TqBCnwMhTBeoFHpfzICdQVkk809xGIvTqKI0r80O+HAzrDcSkFN7TvC3drECS/sjJLi8
 jZ7LUgbCrNTQjo5CHJpIZDX+looAOTbmtMHTGUq2MyMd9jF8i8UxKUPP0eoKw09/D4yA
 fthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506834; x=1782111634;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeh/UcF2lXpiXQR6rtQeI17ktRttU6tzvjgad2vzD+o=;
 b=hRsrZgZ6a/Uxir8tYFmXWI94n/iGBwEC9fo5m5LBgM9kYMMeW3xKPHCyk/LcpaAbXt
 YtCxOxYcXnW1+IoAQ1z2UYqXnvRRW5WlkMrbvQ4t3i2dauovw50NqLuqDIkWBi6z6ldx
 2yQPbUmJog7aVRW9Vcj5DEV5VTtlI+9GxTIGcmHKz/Fz7G5ubAe+wweJSAh/3tMY/FGr
 5f69LYJt+rWpaJ9gaONu5k3Q7ujHo/K39SM5u5p2o2Dr8+la+RDPIEfWudGzmERaQtQp
 +BHWEmo5LR7jDO5PPeK5oOesllPEm2v2BpwTp6es0EeaHFN3FwsRysOOqgXeBtKyWxwU
 C9+w==
X-Gm-Message-State: AOJu0YzhNiHgq901Zli2GJ891YiGx0Bs+k/nFBmlHGYB3GF9vzo5GbH/
 omK8i09Tj7ef5ebgTJATnF8fvlrwGC2SWpnLIFF6ZcurTZXQU1Sdi+KOGhtj0nus0gvpvbpvWZZ
 CgQ84/TYmNTMEHcp02vaYhZuRmfv/is29lOLEAWLLSBW1RJqz+IVe/3pT
X-Gm-Gg: Acq92OFN8O7cSlQWA6POBBQD20om/trYmQyikmYE8Uy6BxuADy0eP8m7iu7iNuuoaJj
 YZx4EPQZrWUCuFu1R4pM97x+pljlyacyGRm6gHsQzBOUdblmMMkFkfIHr/fLzR/p99jEupVaQA6
 /wrvc+/mX+h8cTOOIfRxdp3+8mon5EClO+wHPvUbUSmLxUjVX1VSSEtlxhN6Ym/3LxJJV6fQPDL
 tbFBNe5SSFGMLM4egzj8RSvzgzVbNceAq20uMkTnDJSGCS9DPtIaJYygT5uEaEJedG/yZo3Qyhk
 TIuBLElvZaxm0KFckQ1XqePwfos3lf7xK4S/dNPCXF34MUmsZiNBVat25kfyxTF3Grct/a1pk/r
 +ifCCknqW4f/xQcOka0imVW9BwMUtSgKb5BcGkTJRqAb84PQeOuNaWjeNDCGzQOJv1ueJ5ZhH54
 16eEfsAU3PR9kjQ3EGnjxuesYk86njnCumPUH48oeDZSZ7XyEJ/Q==
X-Received: by 2002:a05:6a00:12cf:b0:82f:7b98:e499 with SMTP id
 d2e1a72fcca58-8434ce25fe7mr14725508b3a.31.1781506834082; 
 Mon, 15 Jun 2026 00:00:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:12cf:b0:82f:7b98:e499 with SMTP id
 d2e1a72fcca58-8434ce25fe7mr14725441b3a.31.1781506833605; 
 Mon, 15 Jun 2026 00:00:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:00:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 00/14] spl: ufs: add UFS boot support for Qualcomm
 Snapdragon in SPL
Date: Mon, 15 Jun 2026 12:29:56 +0530
Message-Id: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyiL2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0NT3eKCnPjStGJd02SjZJPUJGMj88REJaDqgqLUtMwKsEnRsbW1ALY
 rR/pZAAAA
X-Change-ID: 20260615-spl_ufs-5c2c4eb327aa
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506816; l=4602;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AOnHxF609Kc8kYoAayBe1X7ya5CU8kC+lF9NiWnepiE=;
 b=Zvim1xMCOx3dhtTG7F/OXdptHUqdoWr3ZMGlyqoi+Eb3Q4V3j0J0tulv9QH3KsuJvOYm4cVBD
 dpSaeVfVO1KDlXrqPnW2vhgb2hb3aQ+UIu7xRQPJCrpP/iNFf3xDNRb
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 4gzBFORPGWPPZkHnNW4z2Xr4Q6TntRZj
X-Proofpoint-ORIG-GUID: 4gzBFORPGWPPZkHnNW4z2Xr4Q6TntRZj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfXwkAKgzRTLRnK
 FjTiHsD705hRFrksE06+rHNH5fN6FzMyzZk9o3EiI2AgiE2fxzSjROC6X1LK0IuC5mqDMOjObRZ
 IalPbfjA4FI06Ev85pupFe3kvAFiOjk=
X-Authority-Analysis: v=2.4 cv=JLYLdcKb c=1 sm=1 tr=0 ts=6a2fa312 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=asNiq0r0ggDr0FYxM6AA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX7VAYonbekydf
 3kLpd78vCIIg7KRRnbZjKpby4Qo8msFHjX3ON0rfx8ixaH8YD/6oQASOFk8mGX4ywjIztgrCw7I
 mp1jjc5yIhzMEjDsT9t8ZNOnTPyf3d9KtfJkg1YmWIQ9SqGFqZYZrQAl1+u8r9XA0pXuBl2hIKs
 JOljw+fYVUTcuu2KrkkUMRenDxuQthaAUZNKrZkjDLDJ8T5ZlTtCHxIEYGTH3hLSSJEk/LxaIz4
 fHH49saMn2SCTlKF5yAAfVdkVTli5C73xD91oqu0bgeeJYHXQNfUTgejrMVzGloO713PUMI2Dz9
 ytGhf95JCLbpjgS2u5y9swekpijHY8Y9/ocni3VKL7/ZTFMvAUGgHyeCk52CM7XCSECcBhjFrKz
 USJ+ON5aV4e3lgLoycJ1r64pDloYxIIbYLhZgp+BSqaWIl37x8F9xl0UpCq3QHt6k98hQQq5Kxz
 PusY7BLjUvOod8VBG/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150071
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
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

This series adds UFS boot support in SPL for Qualcomm Snapdragon
platforms, along with the necessary driver and infrastructure
changes to support it.

Patch 1 renames SPL_UFS_SUPPORT to SPL_UFS for naming consistency.
Patch 2 renames SPL_UFS_SUPPORT to SPL_UFS for defconfigs.
Patch 3 adds a Kconfig choice for U-Boot location: sector or partition.
Patch 4 refactors spl_ufs.c to add partition-based U-Boot loading.
Patch 5 enables part_get_info_ptr() in SPL for UFS partition boot.
Patch 6 adds UFS_MODE_RAW and UFS_MODE_FS defines to spl.h.
Patch 7 adds SPL_UFS_QCOM to enable the Qualcomm UFS HC driver in SPL.
Patch 8 adds SPL_PHY_QCOM_QMP_UFS to enable the QMP UFS PHY in SPL.
Patch 9 adds SPL_CLK_STUB Kconfig for the stub clock driver in SPL.
Patch 10 updates charset.o build rule to use SPL_UFS after the rename.
Patch 11 adds SPL_QCOM_GENI Kconfig and $(PHASE_) support for GENI.
Patch 12 adds SPL_PINCTRL_QCOM_* symbols and $(PHASE_) Makefile
support for all Qualcomm pinctrl drivers.
Patch 13 adds SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig and
$(PHASE_) support for Qualcomm serial drivers.
Patch 14 updates Qualcomm PMIC and SPMI Makefiles to use $(PHASE_).

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Simplified partition selection logic in ufs_load_image_raw_partition
- Removed spl: ufs: add SPL_UFS_FS Kconfig and filesystem boot stub
- Link to v2: https://lore.kernel.org/u-boot/20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com/

Changes in v2:
- Renamed SPL_UFS_SUPPORT to SPL_UFS for naming consistency.
- Added SPL_UFS_RAW_U_BOOT_USE_SECTOR config to clearly choose between
  sector or partition
- Refactored the codes in common/spl/spl_ufs.c to use helper functions
  to make the codes readable and clear
- Add the filesystem support in SPL UFS as a seperate patch
- Correct SPL_UFS_SUPPORT config name in lib/Makefile
- Added SPL_QCOM_GENI Kconfig and $(PHASE_) support for GENI
- Added SPL_PINCTRL_QCOM_* symbols and $(PHASE_) Makefile
- Added SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig
- Updated Qualcomm PMIC and SPMI Makefiles to use $(PHASE_)
- Link to v1: https://lore.kernel.org/u-boot/20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Balaji Selvanathan (14):
      spl: ufs: rename SPL_UFS_SUPPORT config to SPL_UFS
      configs: rename SPL_UFS_SUPPORT to SPL_UFS
      spl: ufs: add Kconfig choice for U-Boot location method
      spl: ufs: add partition-based U-Boot loading support
      part: enable part_get_info_ptr for SPL UFS partition boot
      spl: add UFS boot mode defines to spl.h
      ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build support
      phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS boot
      clk: stub: Add Kconfig option for SPL stub driver
      lib: update charset.o build rule to use SPL_UFS
      misc: qcom_geni: add SPL support for Qualcomm GENI driver
      pinctrl: qcom: add SPL support for Qualcomm pinctrl drivers
      serial: msm: add SPL support for Qualcomm serial drivers
      power: spmi: use $(PHASE_) macro for Qualcomm PMIC and SPMI

 common/spl/Kconfig                 |  51 ++++++++--
 common/spl/Makefile                |   2 +-
 common/spl/spl_ufs.c               | 151 ++++++++++++++++++++++++----
 configs/nanopi-m5-rk3576_defconfig |   2 +-
 configs/rock-4d-rk3576_defconfig   |   2 +-
 drivers/Makefile                   |   2 +-
 drivers/clk/Kconfig                |   7 ++
 drivers/misc/Kconfig               |  10 ++
 drivers/misc/Makefile              |   2 +-
 drivers/phy/qcom/Kconfig           |   7 ++
 drivers/phy/qcom/Makefile          |   2 +-
 drivers/pinctrl/qcom/Kconfig       | 201 ++++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/qcom/Makefile      |  46 ++++-----
 drivers/power/pmic/Makefile        |   2 +-
 drivers/scsi/Makefile              |   2 +-
 drivers/serial/Kconfig             |  20 ++++
 drivers/serial/Makefile            |   4 +-
 drivers/spmi/Makefile              |   4 +-
 drivers/ufs/Kconfig                |  12 ++-
 drivers/ufs/Makefile               |   5 +-
 include/part.h                     |   3 +-
 include/spl.h                      |   4 +
 lib/Makefile                       |   2 +-
 23 files changed, 472 insertions(+), 71 deletions(-)
---
base-commit: 1e80ee41441c612f05787a93bbef4e6e422e29d1
change-id: 20260615-spl_ufs-5c2c4eb327aa

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>


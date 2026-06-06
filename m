Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA9ECD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00F7846A7;
	Sat,  6 Jun 2026 14:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnJxWwYn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBEmyVQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03D48405A; Sat,  6 Jun 2026 12:18:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681A5838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65662j6O612359
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=IVIQnP4RxKG8PeVtDoCZJG
 XFFPDimAR9wN1LHtoHv18=; b=CnJxWwYnqPJaKC295TQDuc2riThoLLRo/TizyD
 q7FscVDEbxTn9qjJhfJJezUeG9uhD9N8rUzxVNSY0DUzPA8KuOB3kvVj8W3SKew6
 +iwU0jLaxMCAMq9E920huoqu26Uv6tY2AhzO4xQcy78QD7XMLUNFagSOBA/ewh5T
 aqLbvIRxS25ilxmgxkOT+MLfUXoUGFuCaOeqgWvDkv8pqMXY8NxZO8Rz33NnDtw4
 JXiPf66tVX7cm/vHQWNtuIhZoNNBDZTzMhJxxXz6yPZr8/yn8O24tZnPMjFvcuze
 Rmrzs9JsKYgGhT6DGnxNelLkx0KZB91WQcQRwoinzM9AEXeQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf10u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:18:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bf004bf8beso33164885ad.3
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741132; x=1781345932; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVIQnP4RxKG8PeVtDoCZJGXFFPDimAR9wN1LHtoHv18=;
 b=bBEmyVQXKarV5EWJtyyjUbMh07Z0PMVXuov9/0LBV150XqljqxSxhGoBg0jmRYcYCZ
 uwddGi3jV+n08d388Sshy6dfd4f4wAe3PALbieHJ3fpkSuVIsnQq60y6NaPWvIkS8mf2
 65+zqI8w+MRTEBkluE3X4W91hT3LSwCqpl21eHJj0M6ldPAEx1t2yR1OrngHS9VQO2n0
 kRlJ0EhF0EkNIlDJUMd64JJykFl3jjhv5xPbSiO3h8Don06vZsoLP6Xxu1eeeK8HyqXA
 hYD61i3xT31q2ls4LFKHD4ioQaLgx/z9imwDzwx9jSRO1hQKIhFkwH7DD6nzSZ+cD2yz
 7mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741132; x=1781345932;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVIQnP4RxKG8PeVtDoCZJGXFFPDimAR9wN1LHtoHv18=;
 b=ck5jWQ+CQNwSYWgBml9t9yqnfv/+orsr2pYI8Xh0ygxX7gshgxeNsMZ2kqzSiOHRwP
 jKemHMkye0J2N/gVTuEyKlHl1pEplYyDj058eRqwklrW1Gn37sBy90MVLaSLOmfq/lHd
 HKfIWbah/AHYUADuwzfKGvjmM1ibfMhV81AQ0XNFfJgMJWqMPXApDIDnfJi1az9+f09C
 rgFHMxUVleMA5HCivScTp9MBMcdCf+m7WW89VmQuhy0SpNe/0L6qs+/yMY9WEH8MZeWy
 lBPPXviBwz7wSNC6+hGLvdrZV1ZIQrq/tdbdKxfqDLbQANOgR+ASf2rK3KHHAQRAdvv6
 dTnA==
X-Gm-Message-State: AOJu0Ywu23boMQ15O1rlnELUDOm3j1hdIIfASumYRA6re3S4QvieRd+f
 wds6KK0y7QokVoHdsw3Ocpsiaw7YY/VOgz+Qld2ICyhKVCAIAAVE5hxjM/IuCeYF7nbjZXOE3BN
 3VQeK/M9LHzZxJeYFRKJfNuikEO93IMt07YmdBaWfbJHeHexlW1kVpt5T
X-Gm-Gg: Acq92OGjw+1cMtoA0RxaosN+BfXdHOuNONRIe0rmZelSPNqX0yA+Gr6X71QGcszrubH
 r2MkQ6mG/XSVOBw9HS0sj9R0It1/I10y0UGo+p+LmGNFY5X2IdKkMimzdCzlwtTlGzOAu5cwz9y
 N4lhz/P7MXhCliayF47uBYT5DzcV9z4AElJpZPgLO4ULsZyqjwHiiyFr9NBEBLqBqu3rTtvkIdE
 bysENBbNwsYvN6sy7qB4UNaaacw3qwYzVXExr3yH4Ak2zMGAarymJaNB/cFiz2bev2eeW526iR8
 leXGiQM+1lqOBGkJS1bHszYJ2QfwaAyH+lHnbCEkooYuk9LhXQj9jXMDc7WbrekG383IqZ6zJLg
 /yYTADHpNBcnZnXWJVb+SUg0Gy4yAP1pUezq5vS+8ugFh7lvKKe4ZNJRDujBaXnk1IFQ0izxH96
 9GpYkVtmRKo023J+JPj6l71kD/GgHPynGyQjfNjQrh0BuEYRu4Xp1HoZP1Bisn
X-Received: by 2002:a17:902:ce8b:b0:2c1:11b8:3c80 with SMTP id
 d9443c01a7336-2c1e833c530mr81509565ad.30.1780741131766; 
 Sat, 06 Jun 2026 03:18:51 -0700 (PDT)
X-Received: by 2002:a17:902:ce8b:b0:2c1:11b8:3c80 with SMTP id
 d9443c01a7336-2c1e833c530mr81509155ad.30.1780741131306; 
 Sat, 06 Jun 2026 03:18:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:18:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 00/14] spl: ufs: add UFS boot support for Qualcomm
 Snapdragon in SPL
Date: Sat, 06 Jun 2026 15:48:31 +0530
Message-Id: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfzI2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNT3eKCnPjStGJdM3MLI2ODRBOzVIs0JaDqgqLUtMwKsEnRsbW1AII
 nqZJZAAAA
X-Change-ID: 20260605-spl_ufs-678230a46e8f
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=4113;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=L8kJ59odXGVwjV5nrJDAhRB4iXRUjRS2cPFqzkKqeqE=;
 b=LrFA6w5f3sX7kSNxx37NwKleiXMA6UMlBgabIUXEusEuMRp4CMi3ckIcCStjc0AUrBjsci52R
 LU2fPQXFISJAORH5hlaKyPQG3wf6/EMKvHSCvtsVExNOpPEKEq9DIWk
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a23f40c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SfVWsfI0KNWozNyxfFMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 0gvw2ETpEy7XDRtcW_0rkP8n2C2NXyau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfXxBQ2VtMz9wfj
 TUUBPbRlXV+A6g53QbQbNOV5CDl0DtnNn62t6eJFn2vxOJ16kAp2ZC6TJlYid6VQ5U5iy+Y+SMk
 a8wsUy2vdK1JcZwFCRtwox9gL+6HoN4nNasJD9IVybjgD4CTs2fkACH7vA6kOiV4jI8HEsRq+Mv
 ihiOvXYoDzSrsQSfCLR7U3DQOe6AuxOJ45Ejb13GxuYhuTu3kQp2/gshnTu4OzHsxXdIEmg8JNC
 l/+VA+WCx9F88rOHHEHahTIOw4emPYDt92iz7fc9PZiJ2JGRSVTGj7VMnt6/3L8OPX4JhZzq1Ca
 iGzMdLZm0uJp1XC8JQfCxGF6HLO2mtOsHCwZHozU8Ub8g/vavjaqYU/KAsAfe2kxyQ18GMTICEu
 ohJBKWiUtrjB6YNnlsQh5K5VNDyI8jmAKSovji2QXDWMsx0USLctNCXAPfYSdO0VQvn4hbLAv6i
 W5zrdEf/NDe2E0jnaVQ==
X-Proofpoint-GUID: 0gvw2ETpEy7XDRtcW_0rkP8n2C2NXyau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060101
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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
Patch 2 adds a Kconfig choice for U-Boot location: sector or partition.
Patch 3 refactors spl_ufs.c to add partition-based U-Boot loading.
Patch 4 adds SPL_UFS_FS Kconfig stub for filesystem-based UFS boot.
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

---
Balaji Selvanathan (14):
      spl: ufs: rename SPL_UFS_SUPPORT config to SPL_UFS
      spl: ufs: add Kconfig choice for U-Boot location method
      spl: ufs: add partition-based U-Boot loading support
      spl: ufs: add SPL_UFS_FS Kconfig and filesystem boot stub
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

 common/spl/Kconfig            |  61 +++++++++++--
 common/spl/Makefile           |   2 +-
 common/spl/spl_ufs.c          | 162 ++++++++++++++++++++++++++++++----
 drivers/Makefile              |   2 +-
 drivers/clk/Kconfig           |   7 ++
 drivers/misc/Kconfig          |  10 +++
 drivers/misc/Makefile         |   2 +-
 drivers/phy/qcom/Kconfig      |   7 ++
 drivers/phy/qcom/Makefile     |   2 +-
 drivers/pinctrl/qcom/Kconfig  | 201 ++++++++++++++++++++++++++++++++++++++++--
 drivers/pinctrl/qcom/Makefile |  46 +++++-----
 drivers/power/pmic/Makefile   |   2 +-
 drivers/scsi/Makefile         |   2 +-
 drivers/serial/Kconfig        |  20 +++++
 drivers/serial/Makefile       |   4 +-
 drivers/spmi/Makefile         |   4 +-
 drivers/ufs/Kconfig           |  12 ++-
 drivers/ufs/Makefile          |   5 +-
 include/part.h                |   3 +-
 include/spl.h                 |   4 +
 lib/Makefile                  |   2 +-
 21 files changed, 491 insertions(+), 69 deletions(-)
---
base-commit: 74007f24a3aca13b70da6a2c098b830ad9e60804
change-id: 20260605-spl_ufs-678230a46e8f

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>


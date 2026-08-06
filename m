Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98E2C55ABA
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C3FB80E58;
	Thu,  6 Aug 2026 02:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFBYO63suRpo; Thu,  6 Aug 2026 02:21:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45FC780E59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785982883;
	bh=6uiYZN4FXJJLEsxz8Ah55/ifagMqB5fQUxtyO5opVNs=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=qnZiRi76U+YT8xeriKINI59BKarUKU+TrwvfkB/wVeooleN76JAD/vTNMF8D6tMPv
	 EX9i+ThDblPczW3uPlVRGM1s1vDVvmJR/DpFKB1jInRIjxAY2bwe6o6CG05v4Sfqxc
	 FC/Z7aFEyPWKu/5JO+z+Mct9GyP1OvmPURosFz8nbdalNjGu0thcZA1IGwJDE6gsXc
	 9EpeC9+LigVE9ewdDODdmR8rKdOOg1nFwniWdCk25t20RFZpw4inGSN4kGpwkj9+zF
	 2jJsRVJ2u7dAxFAZLDrr9Cag/LUNzk2v1n0/pyj4QOtXFnIpM1x29fYSPPD/T7DWUm
	 Wl+79gkiEpKwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45FC780E59;
	Thu,  6 Aug 2026 02:21:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45E251AF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BF1860671
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6l2rRKpn99Xe for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 02:21:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 37D3B6066F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37D3B6066F
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37D3B6066F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbB3R3701710
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 02:21:20 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f59v4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:21:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so1851190a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 19:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785982874; x=1786587674;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6uiYZN4FXJJLEsxz8Ah55/ifagMqB5fQUxtyO5opVNs=;
 b=SVIKXK1qZczmBG9JN3/BMtFKwBGtUopgCL+NbhFsPC+u3PrljrB2/AnCnZa6XDukw9
 Zdf5Weo0JwfMs2k+R07zrqHe1oG49DtV/GFH5OrGpdARH8gRiB4Q87NX0cyYv//RnG2E
 fLe7ssTEebQbqQ+UA6EMYkeYch/NXisy3uc9rx97UcN6CL54LOYs1MxxkbsGv0DOcaL/
 5u+Gb9tq+f8y8Zo8E4SrFPSYZtTE2foCM0tzT/JH6Fq6DX3SL9IAeOQHuZZ0R7GSbECe
 nwzj+RVGSbHDxNLWWJJI0FhceLr57DRu+L6ZqbC9dpEhn9MotkYG6QKRL0y1AffNvMbT
 xJzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKcIVnpFZE0+fYQVXHYU4eq187/5r5/gLFMIWHzpjiVT6/sf1zKs4QyQ/+DUIslZVy5SqFyx0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzH+hquWdNufk61+73wyQyGlsuMPPIht5s9uCTg8p2lvRC6HRaY
 uXcAcoqtTs3/OCQi5CGyyZ/niSDb3NW+qDvYEiu3+lRuYQvK8rrJ2sHCHav1ZEqdpAjRkd0J3QJ
 vdRXTky47xjJXBlwWIej03NAeed2r+MU+pLsyboCH2CeRs6+MxPz/wU7SawjjRcxhsl9OvnA=
X-Gm-Gg: AR+sD12QX5yg1115/FM2H8c+EeZ61aC979/wkmgy9np2Y6CpKPlhO2vB2IW9+YBP/Xh
 cyQYPesjwN5/+xZZyhhhGjjBDZJgDtwZEkau70wBaLiJtklkXHIZRwww7BSDbcVyo+FoQi0F60f
 JSrJSnpKhYxVwstizNrHUnWQdWqS1zPaw5Pk9SR0ium4Bm7ZN0QyEMMlWFw0eQS52S9XaeoLwZH
 Ge7MXxvlgZ10gLeQR19Lh64pgfl1V/ZfU/12enXbrIhg7h2QtIlYrcvOsWchuptLPEcv8T7FOjB
 XcRu9nuiDeK8ncvczfBV4OFkvqqK/OglERSl5qQObP9+vy8pfT2D1nBaTysnE4cVbG5BcuuQUPL
 wKpF/RDaikrhZJc+gy+x8uJTo62LlBfVuF9iecarJbck5Kmqqu7LVtWC2NvQOeUrCyzUNFML8gr
 YEOcR9gJ/mTTB7ggvMAEQLhMXxXbp7xw==
X-Received: by 2002:a05:6a21:998c:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3cb8603af30mr13484062637.31.1785982874033; 
 Wed, 05 Aug 2026 19:21:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:998c:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3cb8603af30mr13483987637.31.1785982873539; 
 Wed, 05 Aug 2026 19:21:13 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm36385067eec.15.2026.08.05.19.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 19:21:12 -0700 (PDT)
Subject: [PATCH 0/5] Enable fastboot support for IPQ9574 based boards
Date: Thu, 06 Aug 2026 07:51:03 +0530
Message-Id: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI/vc2oC/yWMQQ6CMBBFr9LM2iZ1glC4imHRgSnOAqptNSaEu
 zuR3X8/L2+Hwlm4wGB2yPyRImlTuF4MTI+wLWxlVgZ02DrvbjaGUimlqqPpkXH2HXlQ/Zk5yve
 fuo8nZ369tVjPEygUtlNaV6mDoRDahjD6HmE8jh8Yg3UCiQAAAA==
X-Change-ID: 20260805-fastboot-fa492e2d87b8
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: EmIovnI3NjZUpkauCRjNTisuC8WDdLqL
X-Proofpoint-ORIG-GUID: EmIovnI3NjZUpkauCRjNTisuC8WDdLqL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX7m4OwMuMF0le
 CRCqjEQ86Azjzk1plglAAWEiUv9WJ2r4ZYu09mF6SXXTvErR/R9jrG30upwSrnSsUJ9qsXpGvAc
 11aw8MfagCUf/DhEvMFm9VccDaykDLc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfXxe8WnQdsiSa2
 UyF0/6OgZ260EPxxdqxOBqeyq0DQ3BrA5Bx22EmlnxNNOt44RVlMImb74+ckTfXUsJRpDc3r6EU
 7C3nWCMVsWr+Mmxf0XC/N/CsV4K5ASq5AvZXRzY4zKgbHoi0sqPmPd9JaAJpoTsjMSWNHymJYon
 l+n9YWXIIXl6WK1WVFlYxEg2QpjvasS8wX11FIKecR7AFknL04jmSNZLUwdQPi/Z627pv0ZMAw6
 nBtHcGX1IHNWGO1V0G2Agmb+DjuKX4NQ/sbXyZ+b3PPUT4RvjVwCbf2zMPjP/GUIwbIB96JKXnz
 tPQSmmVRydw+zt1mqL3H5Bm6gO1oUTphg81RVHiYwbCfzH0u58Pvw4V9Rw/ST3Z3bdTnDp72nbX
 uwvlw31snOIZAggjwE8pgCY4DO12Ov6uuwqk2vLVndFvzslrKxCeavr06tMlYglBJF7iaowJN1n
 xyMg32zH+D0Tn8NCE6A==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a73ef9f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=qJFXdjvLX-yMI0ZwmuoA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060016
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6uiYZN4FXJJLEsxz8Ah55/
 ifagMqB5fQUxtyO5opVNs=; b=d7YAW1FM91kHwfHat4zXSkSDi5Y7OhCvnOkvf4
 c1AeKOSNIUeykNWpl4BdjyAMOBbR6budHLCpHebV7BjcOurK/OzaX0kLhCXGTr+o
 9RzvQ6sDTCBtMWiIuQ6X6K1MPV8cGje1iqmThDyYBKhkxBjJgrmPDQaOUuXSKIZ2
 6ksEzRWUQKk0NCK8HZppA1Pg9Ty2E9XgYSCb54e5u4xaxn1f96CbL8bH54/ZC+p+
 5x26V9nyikUwUMnnxuLdEmGou0kThRKbFyCqKrjaxOz0bKPyoWRmRIDjLh9ulgZa
 n68zvOPSY9xVZXlUrNN8J880r4aXM/D0fzszKrmDgEGXKuKQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785982874; x=1786587674;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6uiYZN4FXJJLEsxz8Ah55/ifagMqB5fQUxtyO5opVNs=;
 b=MI6VVZTVO9X4msbv9qATPppwA0IEnVVMbmRbbZ3Eqcnnr9ROmDS5eInAl1t29tAnTP
 jiJPapBto5RMBud80DXswCwLWvQSc94l8nuAK9TIodk2MiKsOwv7CMOgQWtkPfL6fLrK
 U/m6cvW1i/8UECQZ1zrGNuXqxwGTJtrLCXfv3KFwbCVel1h379CoxLUfIbJw/YDcKCTH
 33HATyxN51zLhppwV0Yw1hu+gscqdLsFUaOo7cUvC5uqw+9uLm/N5x9N48rKbdVEd5PK
 yHRjhXMPktY7Pg3h5BuZWxMLcmA1RWDWn8C8/tPt9bFPi3n0VwkpEZqKTJ4EOxy9JI2m
 tYQQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=d7YAW1FM; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MI6VVZTV
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series enables MMC based fastboot flashing for IPQ9574 boards.
For this the following are added/enabled
	* USB2 & USB3 phys support
	* USB Gadget support, Fastboot-MMC related configs
	* Flashing related documentation

v3: - Rebase to top of tree
    - Drop DT changes
    - Pick up R-b tags
    - Include Linux kernel version information in relevant commits
    - Update documentation about 'n/w driver'
    v2: https://lore.kernel.org/u-boot/20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com/

v2: Resend of https://lore.kernel.org/u-boot/20250715101538.4072985-1-quic_varada@quicinc.com/#t
    Rebased to latest top of tree
    Updated author and Signed-off-by email id from quicinc.com to oss.qualcomm.com

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (5):
      clk/qcom: Add USB related clocks for IPQ9574
      phy: Add IPQ9574 support to Qualcomm QUSB2 phy
      phy: qcom: Add QMP USB PHY driver
      configs: ipq9574: Enable fastboot support
      doc: board/qualcomm: Update RDP flashing instructions

 configs/qcom_ipq9574_mmc_defconfig                 |   18 +-
 doc/board/qualcomm/rdp.rst                         |   16 +
 drivers/clk/qcom/clock-ipq9574.c                   |   28 +
 drivers/phy/qcom/Kconfig                           |    8 +
 drivers/phy/qcom/Makefile                          |    1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h        |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h         |   36 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h         |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h         |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v8.h         |   38 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v4_20.h          |   15 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v5_20.h          |   21 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v6-n4.h          |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h             |    2 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h             |   34 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v8.h             |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v8_50.h          |   13 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v2.h     |  109 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h     |    7 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h     |   87 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v8.h     |   75 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h        |  231 +-
 drivers/phy/qcom/phy-qcom-qmp-qserdes-lalb-v8.h    |  639 ++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v5.h |   11 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v2.h    |  205 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4_20.h |   43 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_20.h |   86 +
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_5nm.h    |  328 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h    |    1 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_n4.h |   64 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h    |   80 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v8.h    |   68 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                |  136 +-
 drivers/phy/qcom/phy-qcom-qmp-usb.c                | 2198 ++++++++++++++++++++
 .../phy/qcom/phy-qcom-qmp-usb43-qserdes-com-v8.h   |  224 ++
 drivers/phy/qcom/phy-qcom-qmp.h                    |  142 +-
 drivers/phy/qcom/phy-qcom-qusb2.c                  |  356 +++-
 37 files changed, 5081 insertions(+), 354 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260805-fastboot-fa492e2d87b8

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED8C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD14240733;
	Wed, 22 Jul 2026 07:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNRDTPxcZRdW; Wed, 22 Jul 2026 07:41:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FF0F4055E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706095;
	bh=v17bTkjnZ6+S8hNzH/T7zU7zGIsrVOuRczygTPGJL2E=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=MnJWhQc3rL6XyYaZDLS96uxImdgrFo5s6pVjiRjDL6Q9W4xh1OxdO7jZ8VZA97Zmr
	 qTmNziKnJgzZ8nKJYjnb2IH/iVRyXRqBlIYgKyYfa8N/v0vAr/FNbFIib61s65udY+
	 Z3woANxZipERCz1L+J0fRWVAbfeRXcT93vL5PS3lI4rolJWNNyE4FusZzcEFdRo79k
	 G4R0ptYHX/hY6aQiFyI0tiTGlcOt4Lg2DOozmS0NwHrG879aD1aN3l0/b/reDtzjk0
	 mzvAlVBKInGUaJdL/IriUPvhjH5E0wxEFioIAlSPL6lUKHVrBdfvgnwyXxy4LklWh8
	 eSkTBv9NBtehg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FF0F4055E;
	Wed, 22 Jul 2026 07:41:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA33DDF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB89840173
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0zj8DHHXSvT for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:41:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 58FBF400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58FBF400D8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58FBF400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53uvA3996093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:31 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d2v2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:41:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso258320515ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706090; x=1785310890;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v17bTkjnZ6+S8hNzH/T7zU7zGIsrVOuRczygTPGJL2E=;
 b=GMvVuYinFJVCf77GN2nZ1DiQsvIQ3kW2yGbllFtA+NOOYphd3Sg+k4eTyA1BEdS3Bj
 clrDiP2qeEWTpiobq8mT8yiT8KladMqPDMXwxaeaMRJtj/G8e+qtU/COL2NL1yliRHfx
 wA4sqJHOCAkNcdw6pvvnuwU3c4xehadS84kTChANxJLKtclCYKAKFd2Ra1CLF7H/ojSj
 IpqWwSWEMjnZmUaxxvLjMa0BJjnIab52JgeB9yK7tElApei+yG563UKtoS+JA5Jy++3p
 J50SnI6HCdmJ2mgNrc6xkwiNzBhTClt5l+cRFRP6aCMU91FCd5xnC0w+UQN0m1YLyQlQ
 fxJw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0iHmpwmkH6SirMCR60KPbguNy7QYI42ubXeJPUCqPtsy3ZVRXbILx9a+DKhW36aFQ7SEWEbI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKjbakBY6sikyp3NxI6dMeVBPCb13ykg8AGTWfc+otMEm8lHfc
 NaKjGWEqRMiWJf96Ou94vli0tyu1IKSUPCkoOZuxzKPIdvio2bTmNsZWvsl/8au4VLe8K+2/Sts
 U3ctL+OJoJe3K6APfYymw8Pi+mpblQjRIjMtQjuFdCguG2GHYbC02wHLPL+So8EYOi7aX0g8=
X-Gm-Gg: AR+sD127LRSBop78z0VMa1j19uHCt+E3yDcrSe71RV6gQt4QVXphVACqC4jl5u5Abd9
 aYrhSvQMxd11hZqBQF3dCDhGlUpk5W2smT1HHmPNSF0XV9i3Mw4QdpSqs1MXhuOBnW7WIda8Zdd
 xbaU9of5G8FwZoZoipiyinNPS3JLeUgtB6631ZFY7x4vfJzwegsIlDURsN4v6e7BACq93xvHSOw
 pZx1J/yx6AAAL17B9HcCbRpfDMRYzpjbBatrGMJLvc/8cG00mdByYXanNNoqd7uMQI2HLj8p7HA
 ar1YnjCSS2p9qSavsmaR3iymfoQmMsADrcFw/wZSk3EKEcARImFLBYRHSpHJK/E+JbQ6kEB3MOw
 0rfAWqyg9DAI4CPGqQ4INKZ7uHxiCHrv+GyFCyEXK47UI0O4npGhUMNP5L8fnrgTK3ljYreJHCN
 nrO2cPKZ1uD9cJc+47psjSt0BCtndLNw==
X-Received: by 2002:a17:903:1a87:b0:2c8:25c8:85a6 with SMTP id
 d9443c01a7336-2cf3481b77fmr232775685ad.2.1784706090262; 
 Wed, 22 Jul 2026 00:41:30 -0700 (PDT)
X-Received: by 2002:a17:903:1a87:b0:2c8:25c8:85a6 with SMTP id
 d9443c01a7336-2cf3481b77fmr232775045ad.2.1784706089673; 
 Wed, 22 Jul 2026 00:41:29 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:41:29 -0700 (PDT)
Subject: [PATCH v8 00/15] Qualcomm IPQ5210 SoC bringup
Date: Wed, 22 Jul 2026 13:11:11 +0530
Message-Id: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABd0YGoC/3WNS67CMAxFt1JljJFjSGk7Yh+IQZK6D0v0F0OFh
 Ng7gQ7Rm1zpXNnnPo1yElbTFE+TeBGVcchQbQoTL374Y5A2syGkEg9EoNMVlgp2kdvOl6HG6Ew
 +nhJ38viKTueVE8/37LutpQleGeLY93JrCkbuyKHbt+Hz3bOq/241xbpkS+hlkDgmhoXAgi3Rd
 87VgQ6746i6ne/++tFtc/zj2INMsyOLsFhAwFBX5Kz3IbS/ivPr9QbTtHqFDgEAAA==
X-Change-ID: 20260722-spl-v8-3cedfa6b90c5
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Ro3tl_SvLcKMqe4ZSBO9YoGdUA_ZSfPP
X-Proofpoint-ORIG-GUID: Ro3tl_SvLcKMqe4ZSBO9YoGdUA_ZSfPP
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a60742b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YfCOm-DyAAAA:8 a=voM4FWlXAAAA:8
 a=tN4kDHNCXiRE03u7KZoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX6xzfEq/eHCTN
 RJobZAvsJMbxog/elCYgBSga03Jh4861LWV4tdKg/JzNAeaMbw0GnQUqPpKP19/LDeIhJ4Z1NrR
 8b/3MsqXVQm4NGvR6i4GG5y4ImtndTCnpVx33XNSvKufK5mCO4iXiRMMOtSHdMl6uXt6YSH654g
 ccoGBCo2j7TqNmy6LLZrMwMtIDXmTqbzftKXKVo1FEVclCsRHmz7xoMZfVgiZoHUEremPKXuW/3
 s2En5kEmR++fDYrWv+I/xceHlD2ID5hdHHm0BQCgLfx4iRsJZGHWqBDwGLe2V/98u+OWYGdlQIF
 aVUIQxVTUG1yl/Vi1j7PP09TCy9nVCro3rWoER3riwXHPMJ498RKWUeYyCdlaE6MSdmpwnDrYiB
 GlClXsNwCtpBLhOn/hRbPcNoWfrjt7KVtYZ7YrcxVDwZOUhoGMb5WymMZti9C6U3B7Cv8ck6skm
 2u3ZitYTGoVq2puIY1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXxRyBEYctOY1i
 K4KQRBlMZ60Kkt0xld3eMtDEaZPMGL4GY+VB3RNGqN17Jrvi19Sx5Dw+Z/ViYBtnIP7z2UEWxAd
 xeD4YymItHmUttNkhiXr2SHz+Zoe8BI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=v17bTkjnZ6+S8hNzH/T7zU
 7zGIsrVOuRczygTPGJL2E=; b=ep4GujyYY3XNMn6xiaUvvabnItH+i5QyB/+uTg
 mfEdzDPZZ4FVOHoRwE8U2mZw2nsVAqkxep4DQPdAZQBWq7oeH4JWlWtHd8XOKpO9
 Wz2M1cP+vaKP/JUIEv8uBtY+L/P+HTJP7GuOJHvvAjiXVBZjJVeb2DLd+/lv9PAQ
 EY7NsLe0SpXUUSnLibQs1Jy5KywUhSuPKF3rbhDSne2hKoyoOtXdNT9yko2aXoaB
 qshRu9sjBAn9/Ne/WAlehoPMmKt/GKYV4gZKu9QPXoee/jlBHvWGBtBNhlYTKdNC
 MdjvVSLq95d04jFydvhRAOK5I59bYTEvWosn2Hxl2lFA1o4g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706090; x=1785310890;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v17bTkjnZ6+S8hNzH/T7zU7zGIsrVOuRczygTPGJL2E=;
 b=RMdt0sje1rBlNKDT8SA2xRZ++/JVpFOmF7AoA3+H87povxQSt9YQKLt72emYzI5ftI
 vDMupGIS7hG464JmOi0qgXMnaqO1PnoEld5ZS6dj4Ewzyr8SdO5o7Z3skua+sDIYhAEd
 PkQKZdHrUhq90CZDJRCx4QB3ejxYyWjNKLoWmfE3leEjaEiEQf1H2CEiY1XGkx7SEAHx
 lpz/agQvbMwjCF29jczZHdfqhwNJbOS2tt8Yj0bw2ga/eJFNUTpwCIuNM7zfudxWEItH
 vVL1MPLFhiGvusnhbnrIJ1wtHQLphGULfSlOo9q+KuYsf2DII8jtFaZBIVKV7cWjl6S/
 1cHg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ep4GujyY; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RMdt0sje
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

Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

The relevant DT files are available in linux-next [1] & [2]

Working features, as tested on RDP504:
	* Serial console
	* UART
	* MMC
	* Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
	  binaries (a.k.a QCLib) load and execute as appropriate and eventual
	  jump to U-Boot.
	* The QCLib handles
		- DDR initialization
		- Clock setup

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h
2 - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/

v8:	- Rebased on https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
	- Address Casey's review comments on v6
	- Spin off GENI Minicore support and mkmbn support as separate patches
		[PATCH] misc: qcom_geni: Add minicore support - [a]
		[PATCH 0/3] tools: qcom: mkmbn: Updates to support ipq5210 - [b]
	- Re-organize the functions from spl.c into board_spl.c and fit-handler.c
	  and remove spl.c
	- Retained R-b tags since the code just moved
	- Removed references to MBN and multi-elf creation steps in rdp.rst since
	  mkmbn.py takes care of it
	- Add details about the interface table in doc/board/qualcomm/spl-qclib.rst
	- May need to update config.mk based on the final shape of mkmbn patches [b]

	a - https://patchwork.ozlabs.org/project/uboot/list/?series=514770
	b - https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

v7:	- Fix inadvertant typo in doc/board/qualcomm/rdp.rst
	- Pick multiple R-b tags
	- No code changes

v6:	- Move binman related changes to separate series, so that the
	  SPL changes can move forward.
	- Restore v3 build steps for now
	- https://lore.kernel.org/u-boot/20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com/

v5:	- Reorganize SPL related code into common and SoC specific functions
	  to allow SoCs to customize according to their boot flow
	- Fix documentation related build errors
	- Please see the patches for specific changes
	- https://lore.kernel.org/u-boot/20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com/

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)
	- https://lore.kernel.org/u-boot/20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com/

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b
	- https://lore.kernel.org/u-boot/20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com/

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (15):
      mach-snapdragon: Kconfig: Auto select options based on configs
      mach-snapdragon: Add PBL shared data defines
      mach-snapdragon: spl: Add support for boot device detection
      mach-snapdragon: spl: Update boot device information in SMEM
      mach-snapdragon: spl: Add support for MMC booting in SPL
      mach-snapdragon: spl: Setup malloc
      mach-snapdragon: Kconfig: Add rules to create SPL images
      mach-snapdragon: spl: Load next stage FIT image
      mach-snapdragon: spl: Add DDR initialization support
      dts: ipq5210-rdp504-u-boot: add override dtsi
      clk/qcom: add clock driver for ipq5210
      pinctrl: qcom: Add ipq5210 pinctrl driver
      mach-snapdragon: spl: ipq5210: Add SPL support
      configs: Add qcom_ipq5210_mmc_defconfig
      doc: board/qualcomm: Update RDP documentation

 arch/arm/Kconfig                                |  12 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi         |  12 +
 arch/arm/mach-snapdragon/Kconfig                |   7 +
 arch/arm/mach-snapdragon/Makefile               |   1 +
 arch/arm/mach-snapdragon/board_spl.c            | 290 +++++++++++++++++++-
 arch/arm/mach-snapdragon/fit-handler.c          | 324 ++++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/pbl.h     |  57 ++++
 arch/arm/mach-snapdragon/include/mach/spl.h     |  14 +
 board/qualcomm/config.mk                        |  23 ++
 board/qualcomm/ipq5210/Makefile                 |   3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds |  18 ++
 board/qualcomm/ipq5210/spl-ipq5210.c            |  96 +++++++
 configs/qcom_ipq5210_mmc_defconfig              | 113 ++++++++
 doc/board/qualcomm/index.rst                    |   1 +
 doc/board/qualcomm/rdp.rst                      |  79 +++++-
 doc/board/qualcomm/spl-qclib.rst                |  76 ++++++
 drivers/clk/qcom/Kconfig                        |   8 +
 drivers/clk/qcom/Makefile                       |   1 +
 drivers/clk/qcom/clock-ipq5210.c                |  93 +++++++
 drivers/pinctrl/qcom/Kconfig                    |   8 +
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c          | 349 ++++++++++++++++++++++++
 include/configs/ipq5210.h                       |  11 +
 23 files changed, 1575 insertions(+), 22 deletions(-)
---
base-commit: e0ef25054db31fee49d031ac337099b12c67e5b8
change-id: 20260722-spl-v8-3cedfa6b90c5
prerequisite-message-id: 20260716-minicore-v2-1-160af559b273@oss.qualcomm.com
prerequisite-patch-id: e06f4f15b24c0a2b5999530d2bd810e8d5d25bc4
prerequisite-message-id: 20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com
prerequisite-patch-id: 285af4539961420776d05b9785fce0d2c6f59faf
prerequisite-patch-id: fca45ce71c1d698831fa90bfc90b2b00817a6bf2
prerequisite-patch-id: c060a5765abbaaf96aebb1925414796edd42ddb8

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>


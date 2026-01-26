Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F55D13C3C
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 15:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF1083C4B;
	Mon, 26 Jan 2026 16:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKhTEPnD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jGwDjj/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187DB83C4B; Mon, 26 Jan 2026 16:59:52 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCE183C04
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60Q95K101075287
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=amG9nJOgbRbtXT5XUkm5bNpZn7/Pj2E7jlE
 Q9dfpJXg=; b=DKhTEPnDCtpTyelH+CPrAo0KFaBY0uiYcfj+LEUdmemkd+55bgQ
 xIRvu9C05e9qhKcvBgaqS7EhpIXBQIJAicLiBUr+S2n+eNZukAMz7uucW9ZhyVLe
 NbqghO+4OQ/X/u3WBJfZ29d57K9bjezGlEBebF7lufRx4UqWQ33iVVqSaUs0stpO
 rX29BFXYbie9zbnY9mRMQIAee4QDjDwGdz9wQobpjYO6wxnlWuNukZlhlLPwj4nP
 4k2ydUAKJVnsihDaSe45LRmBfe4oM/IAZU74o34reM/SwwLbQFZXrhCR+BsC6Im0
 0SbPhiCWj4oIUS17g+h/SwY1ALrxW25kWTQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f51aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a78c094ad6so44184765ad.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769443187; x=1770047987; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=amG9nJOgbRbtXT5XUkm5bNpZn7/Pj2E7jlEQ9dfpJXg=;
 b=jGwDjj/Jl5MBmhk0wCD/pOUSdUv8mOgH9v3Wv+jglbhdBWAQA0f+cxFPmqJS6yx3Eg
 WdFjVwEZL+vtsX2nj36+oMHtqqHhEpF+Bo7rseODxLSxt4ouoFzfZ4/3NJPkbKfxYkP/
 iezni69DjYnpCOYvLbVDkoE+iRm4tLI0O+ThPTR2e0nhUICPSUy2RyRhaunNWglUjisz
 I29Z5Z2IHLZs6PKun6KM2rCaL6adP4Q/KZTVUOtvVaCEOHK0NMi2RxxebPde/AR1lzlr
 ugac/zmIkFGt9yju43AtKBVZ+te9Uey4siwjLkuBEz0Hw12UQ9DnfqqUiZ52/3k1Xw27
 fTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443187; x=1770047987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=amG9nJOgbRbtXT5XUkm5bNpZn7/Pj2E7jlEQ9dfpJXg=;
 b=CgF/eBr0oCMjaT8EthB8AQzN0TMFpU1aRMX6kjWseFXavC4261IippTNjYLLyP8uHa
 gg0MMolPg+CCuQjjiGrqKwPwT2u4DPOxbBqvniG1Tvoh2cTtqMhpnmJcj1F5mw9J/nn3
 qJ+X9rSlXYNT1O++RO6s6mTw52w4+oiBmvsiVDiP9wcyu2jzJQ6vAalQXV+K3iXYiKmI
 WmYUVEo9jLapyf8l1V8G4s7ZgJuNitq3LTbbIu+a14rCl4Sztb2zsU4UMA4GVTiq7LAu
 sOJnTNp+2msgTesCzrRd+oS+tKU8+Tq1PQZU3hyW3Z1KhD7YpibDXGM1/0WmXYdHznnG
 j7aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS1wh4JzDzHJ8ynO9KF87TR2UGtTOBwadaIizfi0O3vjSOfVO6Qg1YSMXVTJjtiJTgIjduwO0=@lists.denx.de
X-Gm-Message-State: AOJu0YwcdvGUtl0OmGVFg2K8NImz1b5Zb29/0afUWeajX1Gz/NgHgC6q
 KrsJ+0xhgB17i8JTSBjlxFCuwCYyXzC84LKQyzvIYW+9ld/Ej7R/g1ZTw3ZmS8BKitSJ7UkVf9q
 oBNbU/TmQmI8mNpVZP3u81eHidJJG30NpgjllUT1wkl6WunQqSyLPFi6j
X-Gm-Gg: AZuq6aKhDKzsDboTuIp1ea1+MnvXjYpjIoGChe6sUqwkN5eHp3pcSRdHYU/Td96647f
 Unx3rbfGVl9QJ4mpkOhGH5726nnLDYMQ5QmENYs/7ySXai/dHrejZl2bLLGmCTjD3vUfKfO0VAF
 50rxKWHoNctqlj9d4n2IxgbZMFHF1Jrx9+SW79yLTAPHGnZWPPSGMQ4aHkfzN0NgHYvt0m/LaFZ
 bjK7gnQ18wdf6XGfyqMmeCteCrdg/0aI407IZfTpInMgKE0z0PsNMDjRI04m17BAYN9TDE0uqQU
 zRvLuEqnrgCGZE0gvWm74CKByw70sRtV4VwBalgOKNXfPDduSWZqlarLkpp1kqrrNB/XJN7Kp2k
 KUNHK3OftM5ACSXAD69BBD8GKZO42H4pCDhcNIm/04U8F1v08GObb0kEwTrJQWShAHaPNnIbD6k
 q0JYnV8Z3SCgHCnfeFK54IAMSKrWLlIA87P0XKiQ==
X-Received: by 2002:a17:903:2305:b0:2a5:8e98:1b44 with SMTP id
 d9443c01a7336-2a8452b5e41mr49652495ad.31.1769443186405; 
 Mon, 26 Jan 2026 07:59:46 -0800 (PST)
X-Received: by 2002:a17:903:2305:b0:2a5:8e98:1b44 with SMTP id
 d9443c01a7336-2a8452b5e41mr49652155ad.31.1769443185880; 
 Mon, 26 Jan 2026 07:59:45 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fd929asm93245505ad.90.2026.01.26.07.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:59:45 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Enable eMMC/SDCC support for QCS615 platform
Date: Mon, 26 Jan 2026 21:29:35 +0530
Message-Id: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=69778f73 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ESlZkW5zvKLu4ixrP44A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: _5CRV24a5ISVx3pgvFX1OyzLXZf5LFTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfX2xsZTLQIBuMI
 p1YlORSxn+2rdr3au8t/PVq2/zCChDcasKUYXUwknC6hK6EfmK41XX3jG/bquIfcmC4P3eC5XeG
 O2+7frV1VITu9F57T2O5ygeet9KWGOLlIp99WmdO2KFKUoBbe8rhd8XpaU7a5lN1atjAXGXAtaT
 6ktZqyH9hD3E/EcNFrPR37j73zh+7EiHvLlCmChpDZXvdRqgnfwh5P/mHpP2CbZgRonH+dIKwDc
 6VDhz7oGfdg04CNttq5KlP4//vJVoB60TDUfuyHB+qLSJZdgzXEv90AjtAR3VH7q77xiAyfsALm
 TgUDAhrST/wi+/wV7kZ/R4EoEjaK2EvGA1Rqy1u10Vd1gfW4pcMxQ6d0kNaKD+vaVdBvzHZFx8C
 /Z4TBVHcqM335z3yX+vBqkktRm7OYby7c7feVr5Sxj+o9p4XRUDxLgtD0bWP5yvTjueV4xDu9QC
 ABRcNPaBtGfigYdgcKA==
X-Proofpoint-ORIG-GUID: _5CRV24a5ISVx3pgvFX1OyzLXZf5LFTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260136
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

This series enables eMMC functionality on QCS615 platform by adding
the necessary clock infrastructure, removing conflicting device tree
fixups, and updating the boot environment to work reliably with eMMC
storage.

Balaji Selvanathan (3):
  clk: qcom: Add QCS615 SDCC clock support and RPMH-CLK compatibility
  arm: snapdragon: Remove QCS615 MMC node disable fixup
  board: qualcomm: Remove SCSI scan from default preboot environment

 arch/arm/mach-snapdragon/of_fixup.c | 14 --------------
 board/qualcomm/default.env          |  2 +-
 drivers/clk/clk-stub.c              |  2 +-
 drivers/clk/qcom/clock-qcom.h       |  1 +
 drivers/clk/qcom/clock-qcs615.c     | 10 ++++++++++
 5 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.34.1

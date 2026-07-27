Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F34C531C9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8684D40630;
	Mon, 27 Jul 2026 15:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0MfCJYNOaW4; Mon, 27 Jul 2026 15:56:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9157B40573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167791;
	bh=mwoFjeIfRr6XH2tCutL1rgkfzdPghCbC3CD9ur4/GSc=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=rEiFj1uWWb7VmMsOl/ci3xkL1SARGepc6NolXubqIs2WywD5Wn9kkcydOi/fgH+hF
	 fXpVXUZRyzqkItnbX1C6Kcx/Cr837IyR3JOfEzt0xAJryZJqh6x+qYR5ti9DYQJp/Q
	 SB+7Xbvgm284/bzjmH/kUcFDGLpMixh77Y3QNf4jRskwtZdXkKXZMeYFG8/ZrzA07f
	 amFaujXHYkax7yZzfd8vhPnlZ21zf9rwhBhSZkId9Mz8jwA3pkDIk073WarYVByDpK
	 2wxvO7kvCLUV62E4wFZvsaI+Xp9TAFE2ZlOgz+kexvei/Q1gD+W7akAZFT1okcFbgY
	 3dcUEr6spbviA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9157B40573;
	Mon, 27 Jul 2026 15:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51B114C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37B6580E62
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujSgrIcBjrNi for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 46F9480E61
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46F9480E61
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46F9480E61
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlfcP033185
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:27 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61p4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfbf3e4a63so80572315ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167786; x=1785772586;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mwoFjeIfRr6XH2tCutL1rgkfzdPghCbC3CD9ur4/GSc=;
 b=aqlNlRTYE5w9TxaZvnW0Y4DxbGREW83pq7UQZQz1zF2Vk6ynqN3utmXkIJaxZ2Qnxd
 p3KsB2nyKKtW6gzGd5V/OGPVFcr3GaOQVgIxsRCwKL6ksCSSVBQFxH+BQiocbXSLA7xd
 QJGSJySO/qbwzj8CstSUTmpA0PoMclzIcCe4mmxglL5LnqA02Fbg0wtGIi9TkHo5DpWY
 rPJSxWlsbenkn0yVrT01zM9Oc1mbOXSOcPGxzEAaAh/ag76iRjFq187Y2uUfVWZuEWK/
 sul/U1xQiUnXr9M3jorUgx2Y8O1V4di0kYtQVmFAqmPloVlxub19MZCGwcIjelR9dEO/
 BDaw==
X-Gm-Message-State: AOJu0Yw1+4p3GvYFx5sEb6jo9jL84SVILc1ZbcvgutxxoMTyV8l3Aywl
 MUbw+GIdmhSZuzvgWUxLg3SgmoxKBGjHcWG9RlK+2TsUtoyvNnBq9KT21t+HPzCRmPES2QocJcL
 xHjS1yf5I1EpXKtXL14uEpdBQv0DRre8jJXM4TV299/yC0JMx2jym9YN4d2MC0RCu1Sv+NZ4=
X-Gm-Gg: AR+sD10KWcJswINrCt8AbyydcR7qmH3fLVgQR6gJQtQO6r1FU45ez7J1XvOzaVXyHSP
 0u5vnRd50fFjD93FTAaXvGU9mM38lUoQ2EoMZk+NdUMWUrwGUMdqWhOS8if4R5aRuN8k4LjXrQc
 pAW/DP0qnXHdUaU3Vu7ZE0CIOt24osJW3inAlboVrtu/UgOo98Zgz8vEsPopuPBQmmsSuptvksI
 z0tavG7l0DRujrxm9V8HTs4X93oBM7m4g6Bi6y3i9yFtZZwwu4vyyOlyvWiolzn2wk0zw2bdlp7
 Vjbdl4qfBR3TpfAPS/M+ZxWG7NCK1j+Lj39eD0mdpVFnfWMeM09jseIA1d7FTny0VNOyzhtpVcq
 U8lJ4xKbaFJZeHHyUsu+eLzQWeMrNTiaLdPsZrvfFgQe/syHHCOmlWSU24dq97ZJwF5xERYA7LI
 aXHyF7hktY49GF/Nuth7KKZn9WSYc8
X-Received: by 2002:a05:6a21:b89:b0:3c3:875d:c53f with SMTP id
 adf61e73a8af0-3c67e0778fbmr9003788637.69.1785167786456; 
 Mon, 27 Jul 2026 08:56:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:b89:b0:3c3:875d:c53f with SMTP id
 adf61e73a8af0-3c67e0778fbmr9003747637.69.1785167785958; 
 Mon, 27 Jul 2026 08:56:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:25 -0700 (PDT)
Subject: [PATCH 0/8] mkeficapsule: Support multi-payload capsules
Date: Mon, 27 Jul 2026 21:25:58 +0530
Message-Id: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9/Z2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3dzs1LTM5MSC4tKcVF3LZMOUFLNkA9MkEwsloJaCIqBkBdi46Nj
 aWgAW9jAuXgAAAA==
X-Change-ID: 20260725-mkeficapsule-9c1dd6c05b48
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167781; l=2912;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8a05P5Ky4oDnW9Mzz1/XrWgVni1F8O1Wi3sqJfdpD5I=;
 b=prO6wOCevvWyv+ZSWrmLsxAZcMM1Sttpkipxw0cMD5eTMoFYQGjivNUGCEgYyanLrgYFATd/v
 BNj4vhOzuF9DGGJ61GNczKpaa4K0T52XKo+DrKSMipJEAKdlQD0+abV
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a677fab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8 a=02EIq6OHAAAA:8 a=cm27Pg_UAAAA:8
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=7c0yDloan08OQznFimgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=aZ5uHUMKh6B-zo3GvD48:22
 a=uCSXFHLys93vLW5PjgO_:22 a=d3PnA9EDa4IxuAV0gXij:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=vbqWBO59iwVkzqU4rnh-:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX1Uz0I5cj5QSI
 pYmWr9WzO6RQKN7rdtqyfo9sCUGSXBuREP2LwLxyiItlMH9WIL/IUrtUOX1osCpN/S+g4ZkROeO
 ifDW9zi/UNUmm+D4Krrfg5iG5uRzc+c=
X-Proofpoint-ORIG-GUID: o6WhHwDBVZEoBak3JsYsGe8DkKaX4bSQ
X-Proofpoint-GUID: o6WhHwDBVZEoBak3JsYsGe8DkKaX4bSQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX9eC2fDEds+Xa
 o0EFjWi81maOFg7CiEywx6NH/1kqpyakoNNt5Ytap+JhiV6KNv1dz7/olR3nlJF1OnCdbzUNKmu
 jwymIH/zdUZIq3LiCRkO4syvOZuqBItuGT1VmLRyr6lY03tDgq3LqFr3KgNPwqjWCUAkSSHtFTU
 jCN+P7pjvZEtQ0Y+eEQdnIyhiRj7qBkNrWTNLKWvNqy/D6Uo7rwlj1XVFluUNMD4pEs0jtmHEbJ
 LGb3E8IFPM7fMoqFX8RzQlp4e9FtmXooJKPRpfxs9qrPgaHYrpfclXOjWj+7vXQX2EAK6axnJZa
 72kmtBfv8jkgfgUukoQrqgLGMEjjeK0Ut5tX5/+BRiO3EQ75viTe6LweWUZYmNAjuXpidyRL9Cm
 6q2NbUI5QRETfWKgGPZH7hBSj2zAChRsGelkOGzVlZAdAXWH4VSDkoIYfBYC7as2B02UTR/T14d
 XWY1+/BHqIKFU4BpjXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270149
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mwoFjeIfRr6XH2tCutL1rg
 kfzdPghCbC3CD9ur4/GSc=; b=g3/DLzHkK8/wQmebCkWw4awGIqkIyZjnGlWZkH
 hMz8BZUkO7E/lzogv2hnXAwnBZcqOsuqb4qOb7oHpVzi5vv8YDIHfR1J6viPtmNP
 nAjgVetrhtDJ+sIfguoDnCpXNN+d5n/G7/1G4fiZUkplXpzjxxsEv1PiATzwUWhb
 TX39n+eMzZle55ey/0NHvVOBnSW6ipKbK8d/A96CD8pBitfx+deJ8TTSTSpWMYo6
 Rw/pJYEaRFmzq3WbHdx8H2KBEHUF22lsaDjiR51s1vrXuE5Hnv8tOJTwoQFWuoja
 7K43ntnpMQpbhYRv0JNZDjtC3ppuoAl/rxzWz9XkFKNDy49Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167786; x=1785772586;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mwoFjeIfRr6XH2tCutL1rgkfzdPghCbC3CD9ur4/GSc=;
 b=iexVFjmNcECiGRgxx1cmY/RV0RYsv99tBGBLvfaTO0uy4BKjQkO62wRth3mXmAjYrp
 FbRyfBq4PbtSYyn8/fDu2nE2WH4CFxSuvh7zOgQt5rw+EWVsducyvjjhhQg4ZUVeKjqI
 B1vX4eMwRKFV5cFjZOn6Ez9clpV4FF5S2Y1xDtbd4qcvrjU21cfFURABECrAN2KPGZXo
 TQA8h8CU2aoWHCGRkAlR2duEjctP452DDXWbDZVUGfgnfdfCjU+AGSjFT0hQNVsT+E8Q
 8iFB9pytgL3NjF2dMTCATnGO+sOreGj9LfFq7qhFXBYgxbQDD6LsxCKfnTKWki3uc1YL
 xbSQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=g3/DLzHk; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iexVFjmN
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series adds support for bundling multiple firmware images into a
single UEFI capsule, driven through mkeficapsule's config file.

It builds on Sughosh Ganu's earlier work adding config-file-driven
capsule generation to mkeficapsule[1]. That series produced one
payload per capsule; this one extends the parser to group payloads
that share the same output capsule file into a single multi-payload
capsule, adds a new API to build that capsule, and extends signing so
each payload in a multi-payload capsule can be signed independently.

[1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/

---
- This series is part of work to bring multi-payload single capsule
  based capsule update to Qualcomm boards.
- However, this series applies to all boards, not just Qualcomm

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Balaji Selvanathan (6):
      tools: mkeficapsule: Add multi-payload capsule creation API
      tools: mkeficapsule: Enable multi-payload grouping in config parser
      tools: mkeficapsule: Support signing in multi-payload capsules
      doc: Document capsule generation through a config file
      sandbox: capsule: Add a config file for generating capsules
      test: capsule: Add functional test for multi-payload capsule update

Sughosh Ganu (2):
      tools: mkeficapsule: Add support for parsing capsule params from config file
      test: capsule: Generate capsules through config file

 configs/sandbox_defconfig                          |   8 +
 doc/develop/uefi/uefi.rst                          | 112 +++++
 .../tests/test_efi_capsule/capsule_gen_binman.dts  |   2 +
 test/py/tests/test_efi_capsule/conftest.py         |  11 +
 .../tests/test_efi_capsule/sandbox_capsule_cfg.txt | 118 ++++++
 .../test_efi_capsule/test_capsule_firmware_raw.py  |  36 ++
 .../test_capsule_firmware_signed_raw.py            |  33 ++
 tools/Kconfig                                      |  15 +
 tools/Makefile                                     |  10 +-
 tools/eficapsule.h                                 | 128 ++++++
 tools/mkeficapsule.c                               | 305 ++++++++++++--
 tools/mkeficapsule_parse.c                         | 464 +++++++++++++++++++++
 12 files changed, 1206 insertions(+), 36 deletions(-)
---
base-commit: 574b1adad70a19d95c65e0f37f9c36d94fb5418f
change-id: 20260725-mkeficapsule-9c1dd6c05b48

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>


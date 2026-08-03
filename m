Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5974C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1C52405BF;
	Mon,  3 Aug 2026 15:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEgEXYTPJfvE; Mon,  3 Aug 2026 15:59:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CF04405A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772781;
	bh=x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qUnyZVe1tyWx7Ot8cus8sZhvMws0ZKFSUkXgeyvFgUbX6vXVXlLw3spOpQd0AfaL8
	 OdxepxvkxPdnSqCsS2XInda64NZzoYrSEYSuaIiw0eVaSj3xQ5eDrS5aAgJL/w1/AI
	 NlZ2Taee/WL7oIa7VAzjzNhEVdRhp58NI8mngsrX2hG4Xp1rPeZyuqPjSmurkH66i0
	 CRe0+Wm8OGN9skYGk8KRCq19OQmBLRS7piHQjswjVFzDpPg1cJzaAQ+5lXg8u9UFjn
	 r6axcKmXCWBDIFqqv73fZDylAViMfCzkZTbHdN57+TfH60COxwcC/7ZvcZ1DsSA3S3
	 ocYW0eam22Jyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CF04405A1;
	Mon,  3 Aug 2026 15:59:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC018389
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91DD460625
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnRUU07hX1dr for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6566D6060A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6566D6060A
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6566D6060A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673ECDTU827979
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:37 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhkjf4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb5ea36f969so3777498a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772776; x=1786377576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=;
 b=G8M2KaSKhM6JYOqv1yV8WNo0dsr/5ZZIRIerBQeA+oeRrKmwvaf9HWokJH6NH2+H36
 abVP9Rhv82d5p4gkMZ3pfgd/iV4rp6b/UtO2d62H8yVlX8Lu2rW+8aYDvpho0DjeNLgI
 VPqYQRccifkXWQbmA/KVVZAeZOpMHVxWbIZ2x37jtBqhzxk7J8N+ukgiPfREQMcegZWb
 MWsiEj2dfD7QEgvxI4j5PhJc3N6EB2AA9WVrZjYFIvWGzDcUXGnrk8h7P/Xa4teMlz5w
 EZO0dASi3/x5wZPYle8XX4rKwwQwz/ox3zIv9c73v1pMw0MdqjbL48WZmRP+A/po753G
 6Qaw==
X-Gm-Message-State: AOJu0YwC59KNXOg1lzjmlrdo+61B5HipRZC7e+dsfwQA+meXMb3rCBxZ
 L6ZeXRv4AX7eQWgtLTqQbKRThfzml+/JmJLCv3u03xC5gRyrjo6SD4IYAlBs08TNt9SU7X7y2/0
 ENhOPKC4wqkm38t6mz2OM+hHdcdZHdASbWfruL/1DkmUWQIPSDM3WyBwjTStL5OPDVBHafjIpYp
 9Mm0M=
X-Gm-Gg: AR+sD11He/BSIW3DoZYion+sw7zQU1bt9gfCGNkPGXdwuuv1G0AF8KQsSggEIoQB5rG
 gNY2VHUORdLuotr2HMBSFTLJEtiyYYW6FZ9uXVOQn4Y1CxihCobYBW07xpqCflY8jH26oRXFUOR
 ymwFRziivTtRH2cfH2gd7XliJv0M7mhc/bxdPOVHJ6iFimOs1e/annvXZrrB73+ZDQdQV+VYu+6
 xiNxG2GtT6766K6RPOVtor8Fg+miVkhB/7WW4mxtAabHxQpv3qC4XcbL+xytgWhhEAC5pCPeYd7
 bb2mVZfYGQL5XqqywAbPYzJDLcthXMRHFZveUFVcEjA0/qF+oPOga2Z+TMmA+qu9dddjlksAaP3
 CLwkTtjWNgRJeYh6efe8GHu7yPdCQoMc1IR71n+Ec4Qk7S5KHrpjgzk2CXIse7omCI5ev1L+FB/
 Yt1Y3XrjcHvB01f82Hqq5AjEfvBlRc
X-Received: by 2002:a05:6a21:a91:b0:3bf:6acf:2940 with SMTP id
 adf61e73a8af0-3c92a4c9b0cmr11398823637.11.1785772775886; 
 Mon, 03 Aug 2026 08:59:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:a91:b0:3bf:6acf:2940 with SMTP id
 adf61e73a8af0-3c92a4c9b0cmr11398779637.11.1785772775293; 
 Mon, 03 Aug 2026 08:59:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:34 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:53 +0530
Subject: [PATCH v6 8/8] doc: qualcomm: Add snagboot mode documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-snagboot-v6-8-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=9346;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AVqIeoYRQTRnDP3mh/U85zYT9L2vlnrkMoG5XZ5sHb8=;
 b=j7h8r7vFutc3UrzQMxyrnz8SeacQhZQAkhbp/m6x+F7ox1PeGQlFVYaAGQMj65umCgpw3xjHc
 /CvwV8bIdU2D9Jyq65Wwz7lxhQUi3+Nc0ko06G0bHccWgZFCSbde9ox
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 37iBx5akIUNqu_c1lGSSmIXC8Qtm1JXz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX9atqFfW4udRh
 Em/dpopFSS8NplaQgbC1uyBhN7dd+QviPMFh7NxSiQQ6mkZVMO5iAck0kkQyO87eWCDGSpdoML9
 ghVy4u5Q1Xn1g0+kX6nlWm13Lr1vHcMOOt0fOSwwNnIAPDSTDPoUNQ5en1y/zU9TPABNvY9W5wZ
 xPJ2Vsu0trf9jx+gH+51Fu/g1vF1h7sxX1zaJgexFJuknKoq8JwXR7bUJt7tcOIFTXaYC+HCtx5
 ee2rgmPCJX6SDBv/yOTlNqM/lJ88YgHM+PXeAQDeAgoNbzdSfEbjsWKI33/3wMvfrpdPpNu+T/u
 WUpVdjxLQ2wUBrkULliJfnglqnj77bQR3md8hUvGURwn21tGN/rE/h85DZKmBqqW5JEnjKSteo7
 fsle2XxGstFtIXcM7u35LCka/RXdgVphqRkykATu8MM/Jyh2LW7KsK/i+8i2bmodYxU62WgEmsJ
 7Ecjx2rTG6YRc0XuXxA==
X-Proofpoint-ORIG-GUID: 37iBx5akIUNqu_c1lGSSmIXC8Qtm1JXz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfXxqh//Kc0MUvB
 273TCr+AN3tFxxr68PzMzdoPJRo9U0gGY1XggRWKgH+1omzQJTCQXnCIFbey7iuXSc+U/PShyKE
 8FaJc2AUSS7afgxyVxyVAkBUcMIqwmw=
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a70bae9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=cSziVDP4AAAA:20 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=OjHaD72EHvCEK3kTdW4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=; b=mcwUrwn52JmP5S0s
 /Ll6q74VRumqOxfHsn319nTVaiROWRthPdCEIqazQJqqaZ3nijkLCFlA7YMjKnaO
 E6hFQ02JK+fOuuykB+yjOZIo7lROAyO1dzTkr4yNXpADaoA/+EmF+XNrpr1rpJj0
 Uk7bxcln4J2hMKrhxIVPF1x+tTxXn1wNT86evyulVM570+tE9U+gG/scHDhTFW32
 9bhurCMTg9x0nf8is0oldX5DEzcta01mlIbhWlkf2Kc6dEigLQtL6+xj53PDM5Cm
 6nEDTU2ZnQtl/w4BZNs3j/gAFLkF4/l1EcXzUm128r14rMERYHXSD2jokjRzdSVh
 11OCaA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772776; x=1786377576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=;
 b=hv9UYrjWEGT/eI8i2dxBey2Hl24k4ey/qPDthx1ioH2kJlap23YrMx2ejhTF+HE4be
 S7erGnvqJjPR0xa8LpR9rvTmxdBIizI3oeDca1voKghR6v3nPAPJ5TkjacP9SBnR7Olk
 Vh47jPmf3yYh9eYvW6d9MpIRSwCaPgtnS/FBJoh5SxHLoVPvfSFKMXeIX2cYYZtho+tR
 uI0cI22xXSWvlB4NHApxGdFIeribsfwoq2NwH6JlbFKp+KXEKpc6Dh1Wx//ZaYutrUtm
 aYBGQVUBBtan2F4HFh3SXXF2AJVIbZSzyRGachchub5nr4o2Iu88qdWNmfV47KIt7jmS
 JRUg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mcwUrwn5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hv9UYrjW
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

Add documentation for snagboot mode support on Qualcomm platforms.
This covers build steps to compile U-Boot for Snagboot mode for
Lemans-EVK along with the architecture, execution flow, and Snagboot
enablement requirements.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Added build steps for U-Boot in Snagboot mode

Changes in v4:
- Newly added in v4
---
 doc/board/qualcomm/index.rst    |   1 +
 doc/board/qualcomm/snagboot.rst | 224 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..ee2bc9e29e3 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -14,3 +14,4 @@ Qualcomm
    iq8
    phones
    rdp
+   snagboot
diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
new file mode 100644
index 00000000000..0cbde61253d
--- /dev/null
+++ b/doc/board/qualcomm/snagboot.rst
@@ -0,0 +1,224 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Snagboot Mode for Qualcomm Platforms
+=====================================
+
+Overview
+--------
+
+Snagboot is an open-source, scriptable flashing framework that provides
+an alternative to the proprietary Firehose protocol for device
+provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
+Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
+and execute bootloaders. However, instead of using the proprietary
+Firehose programmer, Snagboot loads U-Boot into DDR and uses the
+standard fastboot protocol for device flashing.
+
+The framework consists of three modular components:
+
+* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot into RAM
+* **snagflash**: Communicates with U-Boot over USB using fastboot to flash system images
+* **snagfactory**: Orchestrates parallel factory flashing tasks
+
+Why Snagboot?
+-------------
+
+* EDL + Firehose remains the default and supported factory provisioning flow
+* Customers are requesting support for Snagboot, an open, scriptable flashing framework,
+  as an alternative option
+* Snagboot reuses Qualcomm recovery primitives and standard flashing protocols,
+  minimizing platform disruption
+* Provides an open-source alternative to proprietary flashing tools
+
+Architecture
+------------
+
+Snagboot Execution Flow on Qualcomm SoCs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The snagboot execution flow consists of two main phases:
+
+**Phase 1 - snagrecover**:
+
+1. ROM code enters recovery mode (EDL)
+2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal memory
+3. XBL executes and initializes DDR
+4. Snagrecover downloads U-Boot into DDR
+5. Control transfers to U-Boot
+
+**Phase 2 - snagflash**:
+
+1. U-Boot runs in DDR and enters fastboot mode
+2. Snagflash communicates with U-Boot over USB using fastboot protocol
+3. System images are flashed to non-volatile memory (UFS, eMMC)
+
+Boot Environment Considerations
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In the snagboot execution flow, ROM code in recovery mode loads
+snagrecover, which downloads XBL to internal memory. XBL executes
+and initializes DDR, then snagrecover downloads U-Boot into DDR and
+transfers control to it. At this point, XBL has left the MMU enabled
+with its own page tables and has not initialized PSCI firmware or
+populated the Command DB. U-Boot must handle this non-standard boot
+environment to enter fastboot mode for device flashing.
+
+This is why several standard U-Boot features must be disabled in snagboot mode.
+
+Comparison with Traditional EDL+Firehose
+-----------------------------------------
+
+**Standard Device Provisioning Path Using EDL and Firehose**:
+
+* **Emergency Download Mode (EDL)**:
+
+  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootloader (PBL) in ROM
+  * Triggered via hardware strap, software command, or recovery from boot failure
+
+* **Sahara Protocol (Stage 1)**:
+
+  * Host PC uses Sahara protocol to communicate with the SoC's PBL
+  * Transfers Device programmer (Firehose) into RAM
+
+* **Firehose Protocol (Stage 2)**:
+
+  * Once the Firehose Programmer is running on the device, it establishes a Firehose
+    protocol session with the host
+  * Host sends XML-based commands to flash firmware images to specific partitions,
+    erase or read flash memory and manage partition tables
+  * Integrated into tools like QFIL and PCAT
+
+**Snagboot Alternative**:
+
+Instead of loading a proprietary Firehose programmer, Snagboot loads U-Boot into DDR
+and uses the standard, open-source fastboot protocol for flashing operations.
+
+Supported Platforms
+-------------------
+
+Currently supported platforms:
+
+* **Lemans-EVK **: Initial platform with snagboot support
+
+Additional platforms can be enabled by following the board enablement guide below.
+
+Board Enablement
+----------------
+
+To enable snagboot mode on a new platform, follow these steps:
+
+Using the Config Fragment
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A reusable config fragment is provided at ``configs/qcom-snagboot.config`` that contains
+all common snagboot settings. Include it in your platform-specific defconfig::
+
+    # Configuration for building U-Boot for snagboot/recovery mode
+    # on <Your Platform> boards.
+    #
+    # For normal production boot, use <platform>_defconfig instead.
+
+    #include "qcom_defconfig"
+    #include "qcom-snagboot.config"
+
+    # Platform-specific settings for <Your Platform>
+
+    # Address where U-Boot will be loaded
+    CONFIG_TEXT_BASE=0x1c100000
+    CONFIG_REMAKE_ELF=y
+    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
+
+    # Timer frequency for your platform
+    CONFIG_COUNTER_FREQUENCY=19200000
+
+Enabling ``CONFIG_QCOM_SNAGBOOT_MODE`` (via the fragment) automatically selects:
+
+* ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
+* ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
+* ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load address)
+* ``CONFIG_ENV_IS_NOWHERE``: Ensure recovery works even with corrupted environment
+  storage, since a recovery mechanism should not load a potentially broken or
+  untrusted environment from the board
+
+It also enforces the following at the Kconfig level via ``depends on !X``, so these
+configs cannot be enabled together with snagboot mode:
+
+* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't initialize PSCI firmware)
+* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
+* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader context is not preserved
+  in snagboot mode
+* ``CONFIG_ENV_IS_IN_SCSI``: Not available in Snagboot mode
+
+``CONFIG_QCOM_SNAGBOOT_MODE`` also requires ``CONFIG_COUNTER_FREQUENCY`` and
+``CONFIG_TEXT_BASE`` to be set to a non-zero value.
+
+You still need to set the following platform-specific values in your defconfig:
+
+* ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (e.g., 19200000 for Lemans)
+* ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e.g., 0x1c100000 for Lemans)
+* ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your platform
+
+Example: Lemans-EVK
+^^^^^^^^^^^^^^^^^^^
+
+See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of a
+platform-specific snagboot defconfig.
+
+Building U-Boot for Snagboot
+-----------------------------
+
+Build Steps
+^^^^^^^^^^^
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
+the Lemans EVK platform::
+
+    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+    $ make O=.output qcom_lemans_snagboot_defconfig
+    $ make -j8 O=.output
+
+Expected result: the build completes without errors and ``u-boot.elf`` is
+available in the ``.output`` directory.
+
+Signing Prerequisites
+^^^^^^^^^^^^^^^^^^^^^
+
+* ``u-boot.elf`` (generated from build, located in ``.output/``)
+* ``swiv_build_utility.py`` — download from:
+  https://github.com/qualcomm-linux/boot-firmware-ci/blob/main/tools/swiv_build_utility.py
+* ``qtestsign`` — clone from ``msm8916-mainline/qtestsign``::
+
+    git clone https://github.com/msm8916-mainline/qtestsign
+
+Step 1: Generate SWIV ELF
+""""""""""""""""""""""""""
+
+Add the SWIV segment required for TZ-based signing::
+
+    python3 swiv_build_utility.py \
+     .output/u-boot-swiv.elf \
+     .output/u-boot.elf \
+     lemans
+
+Output::
+
+    .output/u-boot-swiv.elf
+
+Step 2: Sign Image Using Qtestsign
+""""""""""""""""""""""""""""""""""
+
+Sign the SWIV-enabled ELF using qtestsign (test-key signing)::
+
+    <path_to_qtestsign>/qtestsign -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
+
+Output::
+
+    .output/u-boot.mbn -> Final Binary to be flashed
+
+References
+----------
+
+* Snagboot project: https://github.com/bootlin/snagboot
+* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
+* Qualcomm EDL mode: See your platform's technical documentation

-- 
2.34.1


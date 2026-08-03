Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B1BC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E77E8606E8;
	Mon,  3 Aug 2026 15:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zO62iiwyVRjC; Mon,  3 Aug 2026 15:50:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C43616068B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772219;
	bh=x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=T5lgnKyrS7m6SoDalCOSn+eQca4qfjZOnN2pJS0DSXA1iCp1bDMWh27o9ZqjqZzSm
	 9hUmaQGuRHzCeaKkE/uKajfpyu2ZEFCJOJnzAcL9V7UHEKz82Jwk8a2PNoX6FklILW
	 OTxUaE7CP7zrapX/SSFYAvmPnbt9bk1Zk8MLsg77svmewht+ay3gTotK+p9XIIQdom
	 fxSflSnIh2K56grh0+pRwtFp4P0PLWQu15ka+UtP9RU6cBss72se2eFkpOSJZwCwj4
	 CKJUxEsS0ROrpaxznAYE4apytqrg0WTh96n981woDZkmP9n62QVGaPiWpoxWIoeIy6
	 XtFEceXhz+t9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C43616068B;
	Mon,  3 Aug 2026 15:50:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C14DC2AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7CED6061E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRF_P-MML7zw for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:50:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8B63B6068B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B63B6068B
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B63B6068B
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673FJbOl2172822
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:50:17 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftwhdr43c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:50:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so2605160a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772216; x=1786377016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=;
 b=qscUwr/lw9YiCx6VU8CWscyyJKikjscppoKfEEoKlM8O2Rulo6Urt0ZeogUXCz7Efj
 tMPFbSfUEP18OOoWAnoMRsF5jMnlCIPwFtW4/PwMJl5pSPl3qX4PZApqzThKsCVbGjFn
 Sb93bvAS5EOqs+SRRVCKP4jjDYjgbc2820aZvUluqg2kN8Vo01SwIupn9sAArDG9Sw3w
 QvHpOggJl2dEHtV592q7VFoDYaDu2H1xO8VP5Mv/g0xRPnPU76tozoO7eEo7aqqiDFol
 XLN8A6ff/hIAuRYB744ykeCpH56ipqWcZbE0DNiWUUMkeFRM4aQnBWNRafgBK0im8tu5
 Gj1w==
X-Gm-Message-State: AOJu0YwCD8JqfPPrYBqMZUPaK90WQk2GRPtbVQ8gjO9G2GWylZ5JqEhS
 KJOUqLzHQUHByvtA3vGHp8g8Qngf13IXu3/1z16BmheOGY3I9QmWnzQ5ScjnsbMQfo3kyoSj6aW
 tbmw5jLk19bYsouFSGYaYTo0ajU5pmOg415DpOwu6nIOSa2XizElOqPmRrDR/c8ur8+HVeHc=
X-Gm-Gg: AR+sD12w2oMRCggJ70qTabAKhmtvSyxosCzDbGZANIqJ3lwOigZvZ8ilP1FHV5wSoKi
 Yi266qr/GVhPBuEp3jsY+580rQwy69XtxFniPTasfqngt6cFb/0u0MbY6slLP3+rcaJWihxuj32
 W0fdr4Uhm9VmO3Wm0CBZQn1Pr4Hyl5J0pigPBh/6dQpi4HEShCgztDkC/EEPZA+bxkg9hZHlni7
 wFSeSgcxlF9/P4FJ0XJgbPU7EHc1rnQ9CWmQv3Rh52l7ob3OBGpLylysayqK/EUGrhrnkk2XR4B
 3JbBNus14YeCFCtBVZU9woY48ZxamlXkveXPDLcCa7VsgAuBBAUtZ5htn+sIqEhyO+ZfoQzJj67
 p56ol37Jh+EPQsy0fZfEs+iQXTXlKS96xiGFsKSiZ47da9N0Qm6FQyLdhJazZnyes3Ys4KwxxXR
 KOHC3uPqpQRb5pfkaYklZnDnNDlOh1
X-Received: by 2002:a17:90b:57e6:b0:381:85c0:1d9d with SMTP id
 98e67ed59e1d1-38fbc4e591dmr9141949a91.27.1785772216026; 
 Mon, 03 Aug 2026 08:50:16 -0700 (PDT)
X-Received: by 2002:a17:90b:57e6:b0:381:85c0:1d9d with SMTP id
 98e67ed59e1d1-38fbc4e591dmr9141913a91.27.1785772215458; 
 Mon, 03 Aug 2026 08:50:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:50:15 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:34 +0530
Subject: [PATCH v5 8/8] doc: qualcomm: Add snagboot mode documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-snagboot-v5-8-00ef4542934e@oss.qualcomm.com>
References: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=9346;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AVqIeoYRQTRnDP3mh/U85zYT9L2vlnrkMoG5XZ5sHb8=;
 b=Bmh83F1vKTz+2eLQuPdMd5sMFD1QqYenBp+ZepkuQhmlO7OK0EnqmOxytoB3DjkZQq/6XXAp0
 7Zv2ylqcqz3BgZs3cUUEBb5B/8hz/+tposV5eIA0zplJeAidZujSRMb
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Zf4t8MVA c=1 sm=1 tr=0 ts=6a70b8b8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=cSziVDP4AAAA:20 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=OjHaD72EHvCEK3kTdW4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 60qYd4sbRe9MFVuCx3sdPT7LyTkg7sdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX/DIIDBPQ0YHZ
 CHM6o3J4v51/mpAaCUBsk8fxSVzZ97gs0pmBo6kHgocN6f3flqkibW6Jr0nAzinkLE8T+A9EVrE
 HENHhuKm6Mcpc0G9rjSWM6S3qsyD2k8FwXICWHeaYlw1hxgbxPbbatrLE3gC62dI+iP2vy7wlnU
 Q5dSX9yDTFz0FU1NOm121rsFGCUim6dEffyfAr2+Ga5vaaDrL8CNfirhd/QALy7kv1n2opepzi6
 MBUtIrdnDUljNQoPpwcRo3l4Zf41okuw3HrgyvuWcyymrCskRghIDHZOWj5a5wLRsrP/XpDIaTC
 cHEWagVSRjSi6G6BNs69cXJ7TK5YZrCnUq3fGRs1iOCauS25sTyx9bI+sYINzAq30biiU79xRQD
 ZU18RY/YzY/I3ghQT98HGIO1LIXAyoSrTR6xndr+LljqbGH2fuVaU/rv1OKnNkfgFlNILwMCXF/
 BD3qVKm0Ya9bfRChvdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXyxFDKRD0PNdx
 eb2U8vXuyfEYlWy6dr0IcvlMAJl/V/QsNrjIRFV08i0IE6YXN0L4lCDqFqxv4zVhHE3tGopbroQ
 oUCPjfn5Z53hDJBth86Rf9VPf/fin7Q=
X-Proofpoint-GUID: 60qYd4sbRe9MFVuCx3sdPT7LyTkg7sdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=; b=hP8vSChMPp3qMZy8
 F+GRcXl39oXsojJgPHlmONc41CG1gBXbF+HQKJDlzYrkghy+OzSBgRpHRjFurHQY
 3C3vzjJ1obWwv6IJ5hgWw84Xq69GrUujlSQBsFYCl1asOtz4yDBrWOwL3APLE2uB
 wMlQviPlOjZGx15AXbfiNu1o1YhJkckaqqzHY3vMwUGGby2EPU76AMdplX7N8ZYj
 LzGFybjsYSWHkGPPWOvtPU7Rh+5iKI5NHCw42kitIHCv1HP+6JZC01nxAdp279pn
 oDplRRdhYUKs/IJE7ADO8hyFCIcqkytFyiur7Na/0Qf+rlWAtDORk+XeySgyB1bR
 WG/Ndw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772216; x=1786377016;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x4bFtYqesX+Z0qMz7WxvIdeJXfkpckjAST551iht3+0=;
 b=SU18lr3EYouDyNm1yjaPCEU4H4E8dKOaPdpL/Xr1et2UrXHg9K8YPyqqlvF48eKELi
 zM43XXlfOf+AhVY9ikgFXIvH1fK4LbpyvZ6OBg13CCJGbsG9gHCr50b6ocWsFAceG8kB
 8SIokMPTziBk4oIHcVIyZYkFAIsDuizWL58pB9xrlRZlgiromVBwGzHWLjiQnLsVXQNk
 xPQo8Ka1Xr6rnT3TiFcP0Ahc402BNkiNg+tDw9vRaoRBsl1FP4ihwAblvoUvO03D0035
 tkcR2VXW+x+E4OiV36cfJ0R5NdtorEDBYs37H/pj9F5XXwjkFqeVQqpWbS48vXOHaBRI
 xc9w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hP8vSChM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SU18lr3E
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


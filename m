Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B470C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E100080E64;
	Mon, 27 Jul 2026 15:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gdRIydSkSCLv; Mon, 27 Jul 2026 15:56:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B088680E62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167795;
	bh=ucm6vAW88iP2By7Fd10Ib473jkKciAe7gilhDOWSjRI=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=1Hp45roGqxYF/FKAX6UMr9nZYOZGb82VS1YkP9OzO8g8f/6CZYrVj7Wy5Pmo+jnEX
	 Xi4+jbQMM4G8TyFzQ9eH9drqi3/bobPGr1boY2+gMXLbC08AhuXMM9fYIw2EIcsIG4
	 Ol115ESzwLl+nySDG0ZE9Ktc0SRTrwdYH+E4+KyhepA+wgdsuQJxQpiDX2qsZRsVpy
	 xWkOaqFu1vLV5f292js5APlWEE4pezTjInEXxEnJWP/j/sAYRcwPd0/RJhSwlOexfE
	 9V8GZvoAmnxOLbjUXcOtphzh9MLX9swJbUpBPGy1F0nozseuJv0Oy7YNS+K4GUZ7co
	 THSsWOeMHWQ3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B088680E62;
	Mon, 27 Jul 2026 15:56:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 384D8350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 362B260712
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9_oUu5NsaS8 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BC33B605CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC33B605CB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC33B605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlfTY033181
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:32 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61p5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so486545ad.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167791; x=1785772591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ucm6vAW88iP2By7Fd10Ib473jkKciAe7gilhDOWSjRI=;
 b=sZ//TKaMUvwo1lyK1dVZmtJQBKQCP32upWAHYMuoc5BZ521pKC5KWcsQpEvgboUaUr
 gllvYYh27JASPhCN4zonePqMeKWrQfmlZsvx8ZXo4h0EOUdcp96lWju3DbZ0pAESjQCh
 uBoHlJ3orMYnz86HP4Pne4rsrlCgfceg5Vvlw3qxWGH6fvshvxTI+IS7FH8RvmoXG/2P
 sRKXS1nhUMr7b+0+BAKL+jgdCrzrwYpg1ev3NpZ/p4q7OjhKka/wX4kE+t/wS90VUEMa
 bMq38kfUPpPK0fWh+awwgYh5cccYeqZ3vUymh1W7GeniSarFVfP7DTi0pQnW9PQG4ayr
 Vh2Q==
X-Gm-Message-State: AOJu0YyFQaOgE8VNg3won5NLzrWKDL0YddErFVaS2fcsrz9lQVJU4KfE
 ZWBtpi2+8973MT7wQ8IPMcebjWAB5tp+X6LWkTB9/+1q1w3Zhnzd8p76MoPmQZvPwkMYKXMEG0p
 DWEqI6pjF9Gg52jWPSHFAO8om78jW4vaaFFDAUM5dLRxbskt7f8n1bEGYObXm8nrilwllkQg=
X-Gm-Gg: AR+sD1288ZwZiziCry8/FvieqvZqeUCbwvgpZOXz/h/h6SPyJSXgR7P63mDIxXYZ/FM
 jKXkHQD5Hf8VqHF8WzQ53pYRTySoodMvovwuQ4h5Hvb0wsWVi9PhkbCsdlX1L5VCTTIlkEtAi9n
 8mdo6eT1sJUHVecNfAh3SdMJfTpfAjUk9j+swaNjH62r7+jnqe1g3oi52h/THHf4TSWkJspBzKU
 dly/4rIjsz7NbQdDIk1GeUDOq/PLLKZbBhROh7PYV3bhrlyVsJY9EwBrMRkBehI960ptvYY2YGo
 zg4C5PMiUfJD3LbFq+XYqNO14fdRldAb04+AcO5G95iRD53myYaKxnxdW9diaUTtBIRiJJPZM4F
 8gRrWQrOnEPQTKrynTM5Qa8GlLLa7vexV7IAW+FZAA0s0eAr5+Te3WwO5bBVf81bSvZ3UlCMfy1
 P12RaKBZ9s7FGqUZJFCAU9xSaFOnjO
X-Received: by 2002:a17:902:da8a:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2d00e661f82mr474145ad.7.1785167790938; 
 Mon, 27 Jul 2026 08:56:30 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2d00e661f82mr473725ad.7.1785167790219; 
 Mon, 27 Jul 2026 08:56:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:29 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:25:59 +0530
Subject: [PATCH 1/8] tools: mkeficapsule: Add support for parsing capsule
 params from config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-1-5b162866b092@oss.qualcomm.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167781; l=23125;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=iStg9VsF7yGH0sMkBSfFK2nOkNzI7g6AaRFfo/Dc6Us=;
 b=zcPdx0MiNEDb8bS54YvBK+NMq/ibaG4dx7khZHgR2ZeunjjFuxDA1DgeRuKz50H8JF1FjA80x
 JSXBiIMkss2Do7z0+IOH/B0Y/fXPhaf27yHtvwZ4mavEd1aw8aElbxM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a677faf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=6DAy-sQ2A7kLRuyWJAoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX8xGuhH/AJ/Rh
 4JjRnSS0T//KxfAcIpM6YmoR1elg8c7ky7/uRW/AY5nN61miU2L4P+MriSw/Bgj35hpMwjLF68T
 wkcYGdtLT606mkZTAvE6bfO/j0KgSLM=
X-Proofpoint-ORIG-GUID: l8SfO3Dg2uz2Hkm1ZCf10DyvW7e_LBwf
X-Proofpoint-GUID: l8SfO3Dg2uz2Hkm1ZCf10DyvW7e_LBwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX0bl5pKECz59k
 sX2+ZhdxxIQ80DcW7mMrspSj9u+z1Ibp/MqWO7lqAioMU75aK803TiyRIXGeea2eNENOum9r/0i
 SI7q0OHiuCng6rabS9DuI016iY/qrrWk9I2WtKXVDzBzedmxYmDHrBnYbRofNxdxacMv75SfMbf
 PK9mHmyVX2sh/dUDmWqMM1Q9ll+5R5bTJDgNMPV8BsqDzt94P3L1tDQmleAPw44EECjvbaLGv4/
 Z0VX8atI9bWDlQeY/2v4HToR4h+SBlcfRwGffY3QMxslsayQAbl4PFOwHunxzvlmc1vqnSzlGHv
 f1Mh0tmJ4PvlXXE5xKrsK09F1pZfzctc39iK4ZzlgVDFVoxj9o+IU6Pj8d6rLYTJslzYZmhzJWF
 NTRYT+eh/2BljwKmbC0uHX3iGN59vBBjspaxz6jjWTJeY2XOfwoErDXj6Aob+kjKrwbQHnKG2Ra
 ru2c8J/yHqG3JD82CSw==
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
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ucm6vAW88iP2By7Fd10Ib473jkKciAe7gilhDOWSjRI=; b=QzATzsy4gOCn7Mt2
 qFB/B76icDPNHzeh0qw7hwx+5+DPL4ASQCR1mxmyAGFrshAEvAI/t234LBQn9ngi
 H8yww0fxTUGC5elRcv5JEc5ILUObhftBioTs6PY8T4kf7s4mqbCCAUz8KS9+l85Y
 SvLW6vOWyZI49hTOHTG77Csw24+gUNHByy/f6lah9RRBuUVesSKlcgf8/22QfO3R
 eA4ccRcj+jjpdAa7sBulvEhhw/rP1T1xoU4iHTCmLkXPA1Io0szAnBHTF3rpWQl7
 RJy5ar3XcvrI4tcyNQcyOyEl0p9axeHNxN9Srf9kK2SOJezcBJN5k7d69fFNnxkr
 YA0/cg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167791; x=1785772591;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ucm6vAW88iP2By7Fd10Ib473jkKciAe7gilhDOWSjRI=;
 b=SlrVE6CVhadH/ce4sDxcloC/+J2G0cvM/CT+PReP6e70stBp0SFSJ5hDL8KhasrMPb
 l2aoxBGZ5b/A8IsvlgRfJQV66YLstY+Q0rVYWmW2jlGfI7yKoujaZ7ljFg6t18NbZc4F
 Cpi7Jvd+0pHoeQCmcs+hZWEToowpdGdW3O3RgWkZRYF9ilWI9zWd14jWvdyabQgWISNw
 nGhlFRm1dlKLTxcl7Chjl3cCrtDAmqdlK2L3IMa+V0XanmeqcUC/3U4TJla/QN0feEXT
 rmcYFNqGr7KycBcdsZIjQkRARIHX689/LN6n02imD274vR9pmHVJmPtrDknGAozSeO4A
 pL+w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QzATzsy4; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SlrVE6CV
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

From: Sughosh Ganu <sughosh.ganu@arm.com>

Add support for specifying the parameters needed for capsule
generation through a config file, instead of passing them through
command-line. Parameters for more than a single capsule file can be
specified, resulting in generation of multiple capsules through a
single invocation of the command.

The config file can be passed to the mkeficapsule tool in such manner

 $ ./tools/mkeficapsule -f <path/to/the/config/file>

Signed-off-by: Sughosh Ganu <sughosh.ganu@arm.com>
---
 tools/Kconfig              |  15 ++
 tools/Makefile             |  10 +-
 tools/eficapsule.h         | 101 +++++++++++++
 tools/mkeficapsule.c       |  90 ++++++++----
 tools/mkeficapsule_parse.c | 353 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 533 insertions(+), 36 deletions(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index ef33295b8ec..8e09427fbac 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -114,6 +114,21 @@ config TOOLS_MKEFICAPSULE
 	  optionally sign that file. If you want to enable UEFI capsule
 	  update feature on your target, you certainly need this.
 
+config EFI_CAPSULE_CFG_FILE
+	string "Path to the EFI Capsule Config File"
+	help
+	  Path to the EFI capsule config file which provides the
+	  parameters needed to build capsule(s). Parameters can be
+	  provided for multiple payloads resulting in corresponding
+	  capsule images being generated.
+
+config EFI_USE_CAPSULE_CFG_FILE
+	bool "Use the config file for generating capsules"
+	help
+	  Boolean option used to specify if the EFI capsules are to
+	  be generated through parameters specified via the config
+	  file or through command line.
+
 menuconfig FSPI_CONF_HEADER
 	bool "FlexSPI Header Configuration"
 	help
diff --git a/tools/Makefile b/tools/Makefile
index 535a5d51c89..41f035b6820 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -267,11 +267,13 @@ HOSTCFLAGS_mkeficapsule.o += \
 	$(shell pkg-config --cflags gnutls 2> /dev/null || echo "")
 HOSTLDLIBS_mkeficapsule += \
 	$(shell pkg-config --libs gnutls 2> /dev/null || echo "-lgnutls")
-mkeficapsule-objs := generated/lib/uuid.o \
-	generated/lib/sha1.o \
-	$(LIBFDT_OBJS) \
-	mkeficapsule.o
+HOSTLDLIBS_mkeficapsule += \
+	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
 hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+mkeficapsule-objs := mkeficapsule.o mkeficapsule_parse.o \
+		     generated/lib/uuid.o \
+		     generated/lib/sha1.o \
+		     $(LIBFDT_OBJS)
 
 include tools/fwumdata_src/fwumdata.mk
 
diff --git a/tools/eficapsule.h b/tools/eficapsule.h
index 97d077536d5..6e27ed05144 100644
--- a/tools/eficapsule.h
+++ b/tools/eficapsule.h
@@ -54,6 +54,12 @@ typedef struct efi_guid {
 /* flags */
 #define CAPSULE_FLAGS_PERSIST_ACROSS_RESET      0x00010000
 
+enum capsule_type {
+	CAPSULE_NORMAL_BLOB = 0,
+	CAPSULE_ACCEPT,
+	CAPSULE_REVERT,
+};
+
 struct efi_capsule_header {
 	efi_guid_t capsule_guid;
 	uint32_t header_size;
@@ -145,4 +151,99 @@ struct fmp_payload_header_params {
 	uint32_t fw_version;
 };
 
+/**
+ * struct efi_capsule_params - Capsule parameters
+ * @image_guid: Guid value of the payload input image
+ * @image_index: Image index value
+ * @hardware_instance: Hardware instance to be used for the image
+ * @fmp: FMP payload header used for storing firmware version
+ * @monotonic_count: Monotonic count value to be used for signed capsule
+ * @privkey_file: Path to private key used in capsule signing
+ * @cert_file: Path to public key certificate used in capsule signing
+ * @input_file: Path to payload input image
+ * @capsule_file: Path to the output capsule file
+ * @oemflags: Oemflags to be populated in the capsule header
+ * @capsule: Capsule Type, normal or accept or revert
+ */
+struct efi_capsule_params {
+	efi_guid_t *image_guid;
+	unsigned long image_index;
+	unsigned long hardware_instance;
+	struct fmp_payload_header_params fmp;
+	uint64_t monotonic_count;
+	char *privkey_file;
+	char *cert_file;
+	char *input_file;
+	char *capsule_file;
+	unsigned long oemflags;
+	enum capsule_type capsule;
+};
+
+/**
+ * capsule_with_cfg_file() - Generate capsule from config file
+ * @cfg_file: Path to the config file
+ *
+ * Parse the capsule parameters from the config file and use the
+ * parameters for generating one or more capsules.
+ *
+ * Return: None
+ *
+ */
+void capsule_with_cfg_file(const char *cfg_file);
+
+/**
+ * create_empty_capsule() - Generate an empty capsule
+ * @path: Path to the empty capsule file to be generated
+ * @guid: Guid value of the image for which empty capsule is generated
+ * @fw_accept: Flag to specify whether to generate accept or revert capsule
+ *
+ * Generate an empty capsule, either an accept or a revert capsule to be
+ * used to flag acceptance or rejection of an earlier executed firmware
+ * update operation. Being used in the FWU Multi Bank firmware update
+ * feature.
+ *
+ * Return: 0 if OK, -ve on error
+ *
+ */
+int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept);
+
+/**
+ * create_fwbin - create an uefi capsule file
+ * @path:	Path to a created capsule file
+ * @bin:	Path to a firmware binary to encapsulate
+ * @guid:	GUID of related FMP driver
+ * @index:	Index number in capsule
+ * @instance:	Instance number in capsule
+ * @fmp:	FMP header params
+ * @mcount:	Monotonic count in authentication information
+ * @private_file:	Path to a private key file
+ * @cert_file:	Path to a certificate file
+ * @oemflags:  Capsule OEM Flags, bits 0-15
+ *
+ * This function actually does the job of creating an uefi capsule file.
+ * All the arguments must be supplied.
+ * If either @private_file ror @cert_file is NULL, the capsule file
+ * won't be signed.
+ *
+ * Return:
+ * * 0  - on success
+ * * -1 - on failure
+ */
+int create_fwbin(char *path, char *bin, efi_guid_t *guid,
+		 unsigned long index, unsigned long instance,
+		 struct fmp_payload_header_params *fmp_ph_params,
+		 uint64_t mcount, char *privkey_file, char *cert_file,
+		 uint16_t oemflags);
+
+/**
+ * print_usage() - Print the command usage string
+ *
+ * Prints the standard command usage string. Called in the case
+ * of incorrect parameters being passed to the tool.
+ *
+ * Return: None
+ *
+ */
+void print_usage(void);
+
 #endif /* _EFI_CAPSULE_H */
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a..e778343a296 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -35,13 +35,7 @@ static const char *tool_name = "mkeficapsule";
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
-static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
-
-enum {
-	CAPSULE_NORMAL_BLOB = 0,
-	CAPSULE_ACCEPT,
-	CAPSULE_REVERT,
-} capsule_type;
+static const char *opts_short = "g:i:I:v:p:c:m:o:f:dhARDV";
 
 static struct option options[] = {
 	{"guid", required_argument, NULL, 'g'},
@@ -57,6 +51,7 @@ static struct option options[] = {
 	{"capoemflag", required_argument, NULL, 'o'},
 	{"dump-capsule", no_argument, NULL, 'D'},
 	{"dump-sig", no_argument, NULL, 'd'},
+	{"cfg-file", required_argument, NULL, 'f'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -72,7 +67,16 @@ static void print_usage_guidgen(void)
 		tool_name, DEFAULT_NAMESPACE_GUID);
 }
 
-static void print_usage_mkeficapsule(void)
+/**
+ * print_usage() - Print the command usage string
+ *
+ * Prints the standard command usage string. Called in the case
+ * of incorrect parameters being passed to the tool.
+ *
+ * Return: None
+ *
+ */
+void print_usage(void)
 {
 	fprintf(stderr, "Usage:\n\n%s [options] <image blob> <output file>\n"
 		"Options:\n"
@@ -90,7 +94,8 @@ static void print_usage_mkeficapsule(void)
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
 		"\t-V, --version               show version number\n"
-		"\t-h, --help                  print a help message\n\n",
+		"\t-f, --cfg-file <config file> config file with capsule parameters\n"
+		"\t-h, --help                  print a help message\n",
 		tool_name);
 	print_usage_guidgen();
 }
@@ -469,6 +474,7 @@ static void free_sig_data(struct auth_context *ctx)
  * @guid:	GUID of related FMP driver
  * @index:	Index number in capsule
  * @instance:	Instance number in capsule
+ * @fmp:	FMP header params
  * @mcount:	Monotonic count in authentication information
  * @private_file:	Path to a private key file
  * @cert_file:	Path to a certificate file
@@ -483,11 +489,11 @@ static void free_sig_data(struct auth_context *ctx)
  * * 0  - on success
  * * -1 - on failure
  */
-static int create_fwbin(char *path, char *bin, efi_guid_t *guid,
-			unsigned long index, unsigned long instance,
-			struct fmp_payload_header_params *fmp_ph_params,
-			uint64_t mcount, char *privkey_file, char *cert_file,
-			uint16_t oemflags)
+int create_fwbin(char *path, char *bin, efi_guid_t *guid,
+		 unsigned long index, unsigned long instance,
+		 struct fmp_payload_header_params *fmp_ph_params,
+		 uint64_t mcount, char *privkey_file, char *cert_file,
+		 uint16_t oemflags)
 {
 	struct efi_capsule_header header;
 	struct efi_firmware_management_capsule_header capsule;
@@ -654,7 +660,21 @@ err:
 	return ret;
 }
 
-static int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
+/**
+ * create_empty_capsule() - Generate an empty capsule
+ * @path: Path to the empty capsule file to be generated
+ * @guid: Guid value of the image for which empty capsule is generated
+ * @fw_accept: Flag to specify whether to generate accept or revert capsule
+ *
+ * Generate an empty capsule, either an accept or a revert capsule to be
+ * used to flag acceptance or rejection of an earlier executed firmware
+ * update operation. Being used in the FWU Multi Bank firmware update
+ * feature.
+ *
+ * Return: 0 if OK, -ve on error
+ *
+ */
+int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
 {
 	struct efi_capsule_header header = { 0 };
 	FILE *f = NULL;
@@ -1040,6 +1060,8 @@ int main(int argc, char **argv)
 	unsigned long oemflags;
 	bool capsule_dump;
 	char *privkey_file, *cert_file;
+	char *cfg_file;
+	enum capsule_type capsule;
 	int c, idx;
 	struct fmp_payload_header_params fmp_ph_params = { 0 };
 
@@ -1057,8 +1079,9 @@ int main(int argc, char **argv)
 	privkey_file = NULL;
 	cert_file = NULL;
 	capsule_dump = false;
+	cfg_file = NULL;
 	dump_sig = 0;
-	capsule_type = CAPSULE_NORMAL_BLOB;
+	capsule = CAPSULE_NORMAL_BLOB;
 	oemflags = 0;
 	for (;;) {
 		c = getopt_long(argc, argv, opts_short, options, &idx);
@@ -1111,20 +1134,20 @@ int main(int argc, char **argv)
 			dump_sig = 1;
 			break;
 		case 'A':
-			if (capsule_type) {
+			if (capsule) {
 				fprintf(stderr,
 					"Select either of Accept or Revert capsule generation\n");
 				exit(1);
 			}
-			capsule_type = CAPSULE_ACCEPT;
+			capsule = CAPSULE_ACCEPT;
 			break;
 		case 'R':
-			if (capsule_type) {
+			if (capsule) {
 				fprintf(stderr,
 					"Select either of Accept or Revert capsule generation\n");
 				exit(1);
 			}
-			capsule_type = CAPSULE_REVERT;
+			capsule = CAPSULE_REVERT;
 			break;
 		case 'o':
 			oemflags = strtoul(optarg, NULL, 0);
@@ -1139,9 +1162,12 @@ int main(int argc, char **argv)
 			break;
 		case 'V':
 			printf("mkeficapsule version %s\n", PLAIN_VERSION);
+		case 'f':
+			cfg_file = optarg;
+			capsule_with_cfg_file(cfg_file);
 			exit(EXIT_SUCCESS);
 		default:
-			print_usage_mkeficapsule();
+			print_usage();
 			exit(EXIT_FAILURE);
 		}
 	}
@@ -1156,21 +1182,21 @@ int main(int argc, char **argv)
 	}
 
 	/* check necessary parameters */
-	if ((capsule_type == CAPSULE_NORMAL_BLOB &&
-	    ((argc != optind + 2) || !guid ||
-	     ((privkey_file && !cert_file) ||
-	      (!privkey_file && cert_file)))) ||
-	    (capsule_type != CAPSULE_NORMAL_BLOB &&
-	    ((argc != optind + 1) ||
-	     ((capsule_type == CAPSULE_ACCEPT) && !guid) ||
-	     ((capsule_type == CAPSULE_REVERT) && guid)))) {
-		print_usage_mkeficapsule();
+	if ((capsule == CAPSULE_NORMAL_BLOB &&
+	     ((argc != optind + 2) || !guid ||
+	      ((privkey_file && !cert_file) ||
+	       (!privkey_file && cert_file)))) ||
+	    (capsule != CAPSULE_NORMAL_BLOB &&
+	     ((argc != optind + 1) ||
+	      (capsule == CAPSULE_ACCEPT && !guid) ||
+	      (capsule == CAPSULE_REVERT && guid)))) {
+		print_usage();
 		exit(EXIT_FAILURE);
 	}
 
-	if (capsule_type != CAPSULE_NORMAL_BLOB) {
+	if (capsule != CAPSULE_NORMAL_BLOB) {
 		if (create_empty_capsule(argv[argc - 1], guid,
-					 capsule_type == CAPSULE_ACCEPT) < 0) {
+					 capsule == CAPSULE_ACCEPT) < 0) {
 			fprintf(stderr, "Creating empty capsule failed\n");
 			exit(EXIT_FAILURE);
 		}
diff --git a/tools/mkeficapsule_parse.c b/tools/mkeficapsule_parse.c
new file mode 100644
index 00000000000..12f5f04b824
--- /dev/null
+++ b/tools/mkeficapsule_parse.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ */
+
+/*
+ * The code in this file adds parsing ability to the mkeficapsule
+ * tool. This allows specifying parameters needed to build the capsule
+ * through the config file instead of specifying them on the command-line.
+ * Parameters can be specified for more than one payload, generating the
+ * corresponding capsule files.
+ *
+ * The parameters are specified in a "key:value" pair. All the parameters
+ * that are currently supported by the mkeficapsule tool can be specified
+ * in the config file.
+ *
+ * The example below shows four payloads. The first payload is an example
+ * of generating a signed capsule. The second payload is an example of
+ * generating an unsigned capsule. The third payload is an accept empty
+ * capsule, while the fourth payload is the revert empty capsule, used
+ * for the multi-bank firmware update feature.
+ *
+ * This functionality can be easily extended to generate a single capsule
+ * comprising multiple payloads.
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    payload: u-boot.bin
+	    fw-version: 2
+	    image-index: 1
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    capsule: u-boot.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    fw-version: 10
+	    oemflags: 0x8000
+	    capsule: fit.capsule
+	}
+	{
+	    capsule-type: accept
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    capsule: accept.capsule
+	}
+	{
+	    capsule-type: revert
+	    capsule: revert.capsule
+	}
+*/
+
+#include <ctype.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "eficapsule.h"
+#include <u-boot/uuid.h>
+
+#define PARAMS_START	"{"
+#define PARAMS_END	"}"
+
+#define PSTART		2
+#define PEND		3
+
+#define MALLOC_FAIL_STR		"Unable to allocate memory\n"
+
+#define ARRAY_SIZE(x)		(sizeof(x) / sizeof((x)[0]))
+
+const char *capsule_params[] = {
+	"image-guid", "image-index", "private-key",
+	"pub-key-cert", "payload", "capsule",
+	"hardware-instance", "monotonic-count",
+	"capsule-type",	"oemflags", "fw-version" };
+
+static unsigned char params_start;
+static unsigned char params_end;
+
+static void print_and_exit(const char *str)
+{
+	fprintf(stderr, "%s", str);
+	exit(EXIT_FAILURE);
+}
+
+static int param_delim_checks(char *line, unsigned char *token)
+{
+	if (!strcmp(line, PARAMS_START)) {
+		if (params_start || !params_end) {
+			fprintf(stderr, "Earlier params processing still in progress. ");
+			fprintf(stderr, "Can't start processing a new params.\n");
+			exit(EXIT_FAILURE);
+		} else {
+			params_start = 1;
+			params_end = 0;
+			*token = PSTART;
+			return 1;
+		}
+	} else if (!strcmp(line, PARAMS_END)) {
+		if (!params_start) {
+			fprintf(stderr, "Cannot put end braces without start braces. ");
+			fprintf(stderr,
+				"Please check the documentation for reference config file syntax\n");
+			exit(EXIT_FAILURE);
+		} else {
+			params_start = 0;
+			params_end = 1;
+			*token = PEND;
+			return 1;
+		}
+	} else if (!params_start) {
+		fprintf(stderr, "Params should be passed within braces. ");
+		fprintf(stderr,
+			"Please check the documentation for reference config file syntax\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return 0;
+}
+
+static void add_guid(efi_guid_t **guid_param, char *guid)
+{
+	unsigned char uuid_buf[16];
+
+	*guid_param = malloc(sizeof(efi_guid_t));
+	if (!*guid_param)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	if (uuid_str_to_bin(guid, uuid_buf, UUID_STR_FORMAT_GUID))
+		print_and_exit("Wrong guid format\n");
+
+	memcpy(*guid_param, uuid_buf, sizeof(efi_guid_t));
+}
+
+static void add_string(char **dst, char *val)
+{
+	*dst = strdup(val);
+	if (!*dst)
+		print_and_exit(MALLOC_FAIL_STR);
+}
+
+static void match_and_populate_param(char *key, char *val,
+				     struct efi_capsule_params *param)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(capsule_params); i++) {
+		if (!strcmp(key, capsule_params[i])) {
+			switch (i) {
+			case 0:
+				add_guid(&param->image_guid, val);
+				return;
+			case 1:
+				param->image_index = strtoul(val, NULL, 0);
+				if (param->image_index == ULONG_MAX)
+					print_and_exit("Enter a valid index, 1-255");
+				return;
+			case 2:
+				add_string(&param->privkey_file, val);
+				return;
+			case 3:
+				add_string(&param->cert_file, val);
+				return;
+			case 4:
+				add_string(&param->input_file, val);
+				return;
+			case 5:
+				add_string(&param->capsule_file, val);
+				return;
+			case 6:
+				param->hardware_instance = strtoul(val, NULL, 0);
+				if (param->hardware_instance == ULONG_MAX)
+					print_and_exit("Enter a valid hardware instance value");
+				return;
+			case 7:
+				param->monotonic_count = strtoull(val, NULL, 0);
+				if (param->monotonic_count == ULLONG_MAX)
+					print_and_exit("Enter a valid monotonic count value");
+				return;
+			case 8:
+				if (!strcmp(val, "normal"))
+					param->capsule = CAPSULE_NORMAL_BLOB;
+				else if (!strcmp(val, "accept"))
+					param->capsule = CAPSULE_ACCEPT;
+				else if (!strcmp(val, "revert"))
+					param->capsule = CAPSULE_REVERT;
+				else
+					print_and_exit("Invalid type of capsule");
+
+				return;
+			case 9:
+				param->oemflags = strtoul(val, NULL, 0);
+				if (param->oemflags > 0xffff)
+					print_and_exit("OemFlags must be between 0x0 and 0xffff\n");
+				return;
+			case 10:
+				param->fmp.fw_version = strtoul(val, NULL, 0);
+				param->fmp.have_header = true;
+				return;
+			}
+		}
+	}
+
+	fprintf(stderr, "Undefined param %s specified. ", key);
+	fprintf(stderr, "Please check the documentation for reference config file syntax\n");
+	exit(EXIT_FAILURE);
+}
+
+static int get_capsule_params(char *line, struct efi_capsule_params *params)
+{
+	char *key = NULL;
+	char *val = NULL;
+	unsigned char token;
+
+	if (param_delim_checks(line, &token))
+		return token;
+
+	key = strtok(line, ":");
+	if (key)
+		val = strtok(NULL, "\0");
+	else
+		print_and_exit("Expect the params in a key:value pair\n");
+
+	match_and_populate_param(key, val, params);
+
+	return 0;
+}
+
+static char *skip_whitespace(char *line)
+{
+	char *ptr, *newline;
+
+	ptr = malloc(strlen(line) + 1);
+	if (!ptr)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	for (newline = ptr; *line; line++)
+		if (!isblank(*line))
+			*ptr++ = *line;
+	*ptr = '\0';
+	return newline;
+}
+
+static int parse_capsule_payload_params(FILE *fp, struct efi_capsule_params *params)
+{
+	char *line = NULL;
+	char *newline;
+	size_t n = 0;
+	ssize_t len;
+
+	while ((len = getline(&line, &n, fp)) != -1) {
+		if (len == 1 && line[len - 1] == '\n')
+			continue;
+
+		line[len - 1] = '\0';
+
+		newline = skip_whitespace(line);
+
+		if (newline[0] == '#')
+			continue;
+
+		if (get_capsule_params(newline, params) == PEND)
+			return 0;
+	}
+
+	if (errno == EINVAL || errno == ENOMEM) {
+		fprintf(stderr, "getline() returned an error %s reading the line\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	} else if (params_start == 1 || params_end == 0) {
+		fprintf(stderr, "Params should be passed within braces. ");
+		fprintf(stderr,
+			"Please check the documentation for reference config file syntax\n");
+		exit(EXIT_FAILURE);
+	} else {
+		return -1;
+	}
+}
+
+static void params_dependency_check(struct efi_capsule_params *params)
+{
+	/* check necessary parameters */
+	if ((params->capsule == CAPSULE_NORMAL_BLOB &&
+	     ((!params->input_file || !params->capsule_file ||
+	       !params->image_guid) ||
+	      ((params->privkey_file && !params->cert_file) ||
+	       (!params->privkey_file && params->cert_file)))) ||
+	    (params->capsule != CAPSULE_NORMAL_BLOB &&
+	     (!params->capsule_file ||
+	      (params->capsule == CAPSULE_ACCEPT && !params->image_guid) ||
+	      (params->capsule == CAPSULE_REVERT && params->image_guid)))) {
+		print_usage();
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void generate_capsule(struct efi_capsule_params *params)
+{
+	if (params->capsule != CAPSULE_NORMAL_BLOB) {
+		if (create_empty_capsule(params->capsule_file,
+					 params->image_guid,
+					 params->capsule ==
+					 CAPSULE_ACCEPT) < 0)
+			print_and_exit("Creating empty capsule failed\n");
+	} else if (create_fwbin(params->capsule_file, params->input_file,
+				params->image_guid, params->image_index,
+				params->hardware_instance,
+				&params->fmp,
+				params->monotonic_count,
+				params->privkey_file,
+				params->cert_file,
+				(uint16_t)params->oemflags) < 0) {
+		print_and_exit("Creating firmware capsule failed\n");
+	}
+}
+
+/**
+ * capsule_with_cfg_file() - Generate capsule from config file
+ * @cfg_file: Path to the config file
+ *
+ * Parse the capsule parameters from the config file and use the
+ * parameters for generating one or more capsules.
+ *
+ * Return: None
+ *
+ */
+void capsule_with_cfg_file(const char *cfg_file)
+{
+	FILE *fp;
+	struct efi_capsule_params params = { 0 };
+
+	fp = fopen(cfg_file, "r");
+	if (!fp) {
+		fprintf(stderr, "Unable to open the capsule config file %s\n",
+			cfg_file);
+		exit(EXIT_FAILURE);
+	}
+
+	params_start = 0;
+	params_end = 1;
+
+	while (parse_capsule_payload_params(fp, &params) != -1) {
+		params_dependency_check(&params);
+		generate_capsule(&params);
+
+		memset(&params, 0, sizeof(struct efi_capsule_params));
+	}
+}

-- 
2.34.1


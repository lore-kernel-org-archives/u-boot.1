Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3B7C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B521B60DF0;
	Fri, 25 Sep 2026 14:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2vBmHPfKtFb; Fri, 25 Sep 2026 14:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 96BC860DEC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346424;
	b=W90mrgOYH9S48cq4aSBvY1vjvuph0ihOffOen+kpRCHsBJC7QapwCaDA2iB0UsOUpdh0
	 QW1fwOlCYEuWPVb7spRR/WdzYagxHFP8B64V3Wo+cZh76S/tApvf9cvh8h7OilbwLvlF8
	 JdVabwLLuXdLQHX51m/eEiqp64a9VrQ3LPvwLGFPQlPkBcmYqYf+PIlMVG/jrxTv2eaW5
	 7t9KATsv2apZCtaNlVrtsZXxqG2XWqd1ZvPs76fJIORJnw+cpDGCGJDW+NGvsxItZiDen
	 cUCgMo91gGlkGKMvc+XhYh9QliUi3OzubwTw/QP48Oa+A2uFK0aU0EFI1VQSMKkRVoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iiSY1TNGwgqRW52iy3kJxsqBc2rIZ2pMSqXWip1JPlo=;
	b=pV742QN0DwO6rwg6P3wJfPqb+qgl5ntBLzp/E7BCXhBtecfQ2as1s5lI1X/SAneFDpqZ
	 N4CJ3fKAchL9eQaapXzxsWjVhJB00KCoY3UvOG8uy0I70pvpJFmw+bjB6b67rr6pfZgpd
	 FkYt3+Fxux6iwC4y6WksJS2T6m4I1pAj0VdZiI1lzeItfOxX09d1SqJEbsZJXbHuszBeP
	 Z4LMmg5ZCoDFdjPtxWjI6Nz6FcMeEz/moKlSmahogggbJZ9jQKvmwq++GOMYBivsFsvY9
	 KIiUNfBZ3RMpJhzA6SsM/J+h6PJV+ltD1boRlMrhRWYZxYxktC7bRHNi2CzK9B01lPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346424;
	bh=iiSY1TNGwgqRW52iy3kJxsqBc2rIZ2pMSqXWip1JPlo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xd59Jzw7/vYkXt7gn8zw4DeS2XKsodQC0p79DeMnqQf0y1d3zrdQUHOgoRtRgvFXD
	 3CfDMhrCld3kkEHIua1ckQtLDCd3RjkfoQ6B+osfrBERxKXnzmusryZIijTSmrnvWJ
	 S1ohqoKmy5mCSy6o1cxOg2ZVmRQxda2v+5vH9GtK2bRxqffn7AcbrxpEzOO8bTC3pJ
	 /WXtkCvTS5dcfxWVCdAdfpWfMdoNeNm2qgs09XQsZla/El0YHbsa3wfYGB0A7gYjPj
	 +R/P+QD0MLaozGF7Ob/SHC66LX13/aS3O+s1XlhI0EpDJMll5OtDMAkJldgkDfH/Vn
	 /dmu/nULKyRig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96BC860DEC;
	Fri, 25 Sep 2026 14:27:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 326D8E13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23E8340AE9
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uzWXxsBJXqqP for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 02A1940B27
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341105;
 b=rvW36q0MEzJgqlPNVcr1rlnUIIRCYDPm7hNyn1aKp2iVeK4mgluImlxTSMRYJQ2D/9qA
 EZ00mfGQcQV7XkjYh+mfrkz5ljm3308ITWkIssf7U29PmoNkWp5fbq1TlxA/f2eAPfFOm
 f3y7FuKvet16TDp4LrtckADHRuroOYIjEUBz6qZ5tNzxJpjWUt/iqbhBJZh+wlD3vAhl/
 Ks0Klnf89Tw7dQJJFiQJMCQ8dV7DTJQVD1hZMbbKgdoKAOhfHIwxH9fVbDOsVtBv6Wf5c
 isTRpP7s3pFORbL8+JtpjyBABs4fE0YT/bE/PKFCT88QtKcBcmbz5iWBBWwyFrwdmlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341105;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=iiSY1TNGwgqRW52iy3kJxsqBc2rIZ2pMSqXWip1JPlo=;
 b=NmsnaO6hiLwyuQwKU7ftQclKC0zUEi8ZhJ8tUxZkleAgGDtBE5Qzmq/Pynw7w36gMXsA
 2vO/OWqWB3Kg2+AyNq96+idETa8W2x12PtUjvekb0oThzk95pSj6nWHWpLkhpvHYKFqJ6
 KTyhejUakpu1frx3s5GWwKsInt7NdZ3DqDUDvJY00nelYmwbr+4Rs8Pt9HscAhAo/AUks
 TwPKJZMtyxZoOxqk1Iku+btRd8cqGUMBxFrfUddM2d/rotISmkMPYPh94/q5bJx4cj0G+
 tMgZ40YpbL8UYSL6Z8hWVX3BqbcV9wJkkB2Q27A+9XPq4UOa7mbcqZXL6faGqODyE2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ndfxHE3t; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ndfxHE3t
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02A1940B27
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PBV9iB425977; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iiSY1TNGwgq
 RW52iy3kJxsqBc2rIZ2pMSqXWip1JPlo=; b=ndfxHE3tPvKE1lNehXKxV3gqRnf
 j16OQ6RCrcpf/B0eZpqAFFYZzHYAUcUecPVS7H1ztOFl+xnfMB5r/5u1kHrFnOzT
 KgSA5IroWNFH3xR8/FPieMPxJGzEAFmETn2dqNogo0+wB5x1ipbXAbgJYjWanunG
 GiZryXxE5ySjFCSlJT3L6wEBO9OwJaFlmGg45qUI9zTP27C34UlryL11LEfETz+Z
 dF+7IskJlc8cCHIA5Y8xmum8j4lPcir3XecyE6XsWmJyiRzgDvwNx74PEr5Xi+fZ
 OWOK6Qom0z0sKbG5zrEEd+vbExMKLFCal6PssnJ547b7L2tSh5+LLKpogcw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e88fg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwELf517683; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68PCwDSF517663
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id DB9BD621; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 12/12] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Fri, 25 Sep 2026 05:58:09 -0700
Message-Id: <20260925125809.1360030-13-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX2Px78T5m1w46
 r9DJaZ95piVY8FruOK5ylHJFEparoo749AgRbbw6k8O8G2FYYqLe4BbGkgXd9JcGlP4BhqBlBy/
 /dhm6rf/BXmdM+pnrcDNBZY8mIQg4oU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX478/vjI5J5Pg
 G0Nk9X7pIE6UKH86brDZe06qszSywoel2ZMwOvFN5kBEx8t9ztzUugrghCBJCc5q7IKqyudMgxA
 k43z2IRrzi0879kgNVKY9W/mOhxK3pEPCaRnx1NHMCiVfIrDl/WHtAB/dOYhbPyy0OiP5+DzWZ3
 4dgoTNnOIsA48TOA5b2Q6CzACj4ENJ4p6uUxoLXu+HrjREpA9dUiWgn43xl1q/pkSWsQwSpXH9B
 SMh5BRUD2v/eEK6IG0LgNZgalFiN06YlL+niKTXEMoIsEwzI2bTa5VWPIBWDgphxwLzb5e52ARi
 1c5ORkhaY80FT+/rw0rxhhieGveSJLupSfB5pf52MMvnFiEVfVAkvlF1tBjRJOyPbK5wj0WW5c4
 EMH9EX3HKJzJSYXfz18pNmTSwoeBBJdpHB4fNUq1YMIkcAmRU1fWEHlFWPGGHYo/FwqaWO5b+ir
 ZDy2pHTsQGUhnsr1Gww==
X-Proofpoint-GUID: MaqcBOTaIKVSBZXzVdCXLHFkSpGLpIYN
X-Proofpoint-ORIG-GUID: MaqcBOTaIKVSBZXzVdCXLHFkSpGLpIYN
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=l66fMvErkfCIGnPQoeAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 configs/qcom_shikra_spl_defconfig             |  1 +
 4 files changed, 67 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index b9c0362117a..ceebd679651 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -135,6 +135,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
diff --git a/configs/qcom_shikra_spl_defconfig b/configs/qcom_shikra_spl_defconfig
index 7bcb3e21a15..1d997510c77 100644
--- a/configs/qcom_shikra_spl_defconfig
+++ b/configs/qcom_shikra_spl_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_STACK=0x0C294800
 # CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
 CONFIG_SPL_REMAKE_ELF=y
 CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/shikra/shikra-spl-wrap-elf.lds"
+CONFIG_QCOM_XBL_SEC_ELF="qc_sec_local_signed.mbn"
 CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_BASE=0x0C219000
 CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_SIZE=0x134000
 CONFIG_SYS_BOARD="shikra"
-- 
2.34.1


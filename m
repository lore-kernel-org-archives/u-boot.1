Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CBFC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C7E080DC7;
	Wed, 22 Jul 2026 07:42:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 68t-vG7cNye9; Wed, 22 Jul 2026 07:42:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88AC080D7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706158;
	bh=wSTkxLaHNMN7Y7tTSKzNWePHz7fWyTNnwhejoEKQ52U=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WI4zlwisZGngxqSqpVYj0dd1NMls3AujASZ6XJGSQGtfEDpL56RjNW+61GNpbyBQm
	 sDibWWS2XY17tChHTCoF83rHs7Wy7R3ezF8sS/FY/9DLaREYVBp9xJ8xTt1yeFYP+r
	 /mmpS+xVpKmvPHsbhSnlXPeG+7YJK3PgYE0izjRXFDQ9w1ftXeJfk3pWOh4R+Z5zy5
	 XBnhYSYhbpPe0Dn5qqTWN6A4pSd8L3LvJghGO0tSzEaF/4+usmMQ+WMHrxRoxTmw0G
	 xczRpjtPISXzXN3C1CFYFriGo6Tz1qKoORL880x86Kjj1T6lrg4lSd/LQosciz2Uvl
	 QhiSsb0YpWb7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88AC080D7C;
	Wed, 22 Jul 2026 07:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FF26DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11C3740173
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VxqUSgjHCGzG for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:42:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1A23F400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A23F400D8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A23F400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M54JH23769548
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:35 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rx73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc8bde6318so217222265ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706155; x=1785310955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wSTkxLaHNMN7Y7tTSKzNWePHz7fWyTNnwhejoEKQ52U=;
 b=EkPMKHS/TV0BS5ENUw+gsGOLumingNFzUifOHI/EQtU61taiL6udZ0jYVYplwabOVv
 PIDSQ3uvzoEoPYv/4Jssp9G894Ma9MDv0m+o3tNHfQtcxWVpxtTBguroZlIItGlKXkB1
 vm4vVraTtGNJ9Z+pFSRfp5jgZDhi3uuNaVmRCkuqv9IbZ8IwYVRFXJsricAgRDR77JzS
 N/cMepUlBTZQEJktS/h4otvJ7m11aCrhaLPt44GTQ8ymObERl2JXGJMdOTNLCWUf6km3
 07pjQEHgesGXHBafzAZ1wCsflzImthGYE5gYdMx/b7Rtvq13qh7CEYQHdCx0IkzBJfQm
 GAeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTlTY2eSOrktQNlOjGqF+BASzxU/LlL8pxeFqN5XwYdmj8RFHQbFKdUE8PJDxxT9DWLP71WzQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw+0nmNreeVteGT6lC7WIrytRL4P2eTlLnE4N+am2lvXlQfTX/U
 sFC5gpcu5LO94DK5ycuYV/c4r2pxEsaAjXvWc1kNRMOtvpIPTQkhjcroxS56TM7sf9B6zKnjgpq
 DuiMmFPLWbmF1HrUBzOWd66qcF2m44R5rOKwgFB0l3vudsIgHEuH+QhVkeMAropZVXPeHHhE=
X-Gm-Gg: AR+sD11aBHW7YOnHotSghIzmn1wjtvLtd/Xmy56WHYKjBzqIXOVF7W6RArDAzoRoYlo
 F5P4pI2AhHO6yKCsWN0ZAvN6MHwkUJxBqPVrs0t/s3mx61IkdLwe0efk9WC4xpl3PzdT1FfnfIE
 8GCVitMpaufjhwzEn8kIdDW+cHz9V3THqrfBWUW+OF/2VHH07RIVx+nYKK0d7sqUrwzjIRrPSh9
 eztXJIzA8yrG8MgrmqSBDwmCS75zCigtQhHrNz0OOMeW0kPAfTnHhXBNw1RerFPQ8oldT1R8LQp
 2RU+GYWZmG0h/K6D1yZkpR80OzHPL096rD6HHrN6hUtZXDtIh4IPfoYwI/BpArxPrmUJAXeos/+
 PZYXRGA5ROjESSpvVjkEsSiRMSYdW2kEIHvVz3M96LAEIW8pL3HqpNZjlBLzbb1wtQ8/vx/EIKC
 vqi81T0awj7mINyJ3U4Seyct5LVmwDWw==
X-Received: by 2002:a05:6a21:9206:b0:3bf:a638:4371 with SMTP id
 adf61e73a8af0-3c3ad5d4660mr23770898637.10.1784706154792; 
 Wed, 22 Jul 2026 00:42:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3bf:a638:4371 with SMTP id
 adf61e73a8af0-3c3ad5d4660mr23770843637.10.1784706154342; 
 Wed, 22 Jul 2026 00:42:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:42:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:18 +0530
Subject: [PATCH v8 07/15] mach-snapdragon: Kconfig: Add rules to create SPL
 images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-7-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
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
X-Proofpoint-GUID: i9zSnIK97UYjg870Nz-qh7s6ncf21lRU
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60746b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KPGK5uzhZNYWFyxW8pwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX/KA65YR3sV6c
 jVpG9SPbH6e88y0f48f3kQfu9YyZ/usgBJd7lHWOfTmfQ0b/tf3brUvJ7lMie/K2w+I40Zi5Qmf
 yr6at9Ka2b5Y0rr3ubLbIJOxsi/VmG41MgCP0k9tLil5hmF4T6wgt/gAC/L8jJzfor3Z4QoMm4l
 6TFmTGcAnniGHVtgu6HG+PyDUSUdFfVra4GqX21PxCTRMC7Jr14BPDBKVU99D36p6k1Q3GzYDgS
 wKwyJYG3qDnn/m/K6rkIYPm5WJ42x7n7fhCPbqSBw5dtbfpeQ8mdlLv75eAysWVFIV2W3Ok751p
 ffabPCjooBX/zermAgVp6JoTj8C93k0s+VnBDm22Zc3gfZPz5Ie1gJyy92f6OUFGBtyk3ESURCc
 T3Sd84XhxZo5c88TFfRSbgcRztHGtQ0M51Kg3Qr7uJBrA3r+a3cigD9fz/K75+xh5Q+DML0aH+t
 gPVzmfGU12PEEEhveew==
X-Proofpoint-ORIG-GUID: i9zSnIK97UYjg870Nz-qh7s6ncf21lRU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX0EYpYEwVFYLL
 1mizLFsHmM+ILwJnTDQJLCUN8Da5wzEBO3Ihx4KxPpiE/f+75qYlSrZALGXna7mIaF+eCXMvIjX
 V7mAP2y7E+CUWCUPFjW0O1wCbTjA8Kg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wSTkxLaHNMN7Y7tTSKzNWePHz7fWyTNnwhejoEKQ52U=; b=BwCboTXl6PZE3b2K
 g/RWlleHQwcuyY+IRA8RTY7HOR/oZ5aTPDfFmuZpTFBcrsBpsQ/bpopl/HHlLa1J
 B8Am1hnnVoXfK4p0oF1ZiWbBbfUlHMWxvT4myeb7udHTONq6S7o92MmjlHwCMRfl
 tDDej5dU76enn921qbchsuKc9ECGihOpsbJ148qzJ7GpkViNpwWQk3zUU6jSqsG0
 JBo7Do2rpOx1bnMyX5+0SXwJDEZDhWOjByR91MfRt4vCulWFZ6b9YWYsMZGDKJL/
 6noH6royEVx1cJ7OdVcFSd7HkI97KkWbtM6a7/c50APExyhrJY/5D5+frL3yoBan
 lnVWsA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706155; x=1785310955;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wSTkxLaHNMN7Y7tTSKzNWePHz7fWyTNnwhejoEKQ52U=;
 b=NYUFn8RSpQ7rxZ0NUgSIs0UNIHhKHdth9xjAnrQD94AQpCSvASgF+MzdIHmbqubXop
 qLMUkYS6tIcIWBHnKHZ4qEBb9z3vGUNSBjQ6FeRDbtCWs63QNnAYd542hescaTAD3Dwe
 8XLXGXBS/tDZrvTgCQtIgpgqVU9ukRBLGpDYEGIYo0ZOFT2gGDr5ksyszKCNAN5s3MZi
 vnOZp9/noM+cJXPLGHwXyp4TerYkXAWJFpoh5j5zWpZCXseduCnVf1JX9KJ/MzPChz2h
 x44jX2sKQSFiHmMe3zdVAp1R23aqvYuXVn4W7ZUcP43ySFRNDjrUC0uRTVm7e0S3c0Oc
 bBhA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BwCboTXl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NYUFn8RS
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

The boot rom expects the secondary boot loader in MBN format followed by
the TME executable. Add rules to board/qualcomm/config.mk to create
u-boot-spl.mbn and u-boot-spl.melf.

u-boot-spl.melf is the combined multi-elf file that has u-boot-spl.mbn
followed by the TME executable.

Additionally, this patch adds a config option to specify the path
of the TME executable to be used to create u-boot-spl.melf.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig |  7 +++++++
 board/qualcomm/config.mk         | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..f1a6e828c3c 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,13 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCOM_TMEL_ELF
+	string "TME Elf to concatenate with U-Boot SPL MBN image"
+	depends on SPL
+	help
+	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
+	  boot rom expected multi-elf image
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..2abecbf8ea5 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -12,3 +12,26 @@ quiet_cmd_mkmbn = MBN     $@
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
+
+ifeq ($(CONFIG_QCOM_GENERATE_MBN),y)
+
+quiet_cmd_mksplmbn = SPLMBN     $@
+      cmd_mksplmbn = $(CMD_MKMBN) -o spl/u-boot-spl.mbn -l $(CONFIG_SPL_TEXT_BASE) -s 4 $<
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.mbn
+
+spl/u-boot-spl.mbn: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mksplmbn)
+
+ifneq ($(wildcard $(CONFIG_QCOM_TMEL_ELF)),)
+
+quiet_cmd_mksplmelf = SPLMELF     $@
+      cmd_mksplmelf = $(CMD_MKMBN) -o spl/u-boot-spl.melf -m spl/u-boot-spl.mbn,$(CONFIG_QCOM_TMEL_ELF) -s 4 $<
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.melf
+
+spl/u-boot-spl.melf: spl/u-boot-spl.mbn FORCE
+	$(call if_changed,mksplmelf)
+endif	# CONFIG_QCOM_TMEL_ELF
+
+endif	# CONFIG_QCOM_GENERATE_MBN

-- 
2.34.1


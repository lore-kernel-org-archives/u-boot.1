Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D75C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 06:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BEEF40A76;
	Wed, 29 Jul 2026 06:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubN_3gH6s1dL; Wed, 29 Jul 2026 06:01:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 467CE40741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304883;
	bh=kQBcBMlUJOaBmOHBnJxLmUnxbYigj6Dw99LyUITx22g=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=gtp7zrQfyY6v2xuL70KBwc08b7rOr+Z76ew4VuPfRPff22+FfLQAh5ztX58pwTzcN
	 IGfvFTuckzUM9TXHKF1fcAET42OJgFkulw1JkRuHFWM0tbk102dxWG4m0UO6J1FgOi
	 822xEE81IZzUfeClN08gublN2qkPyw48206yqnsqBam6vRdQRSpxrQ8I4OeaJIKKdh
	 AcXPAbRCxIZhSCoYqO7gpq3ORDFgEu0xQNgDhSQj2QCL488zSZ9PQk3yR47Wl78sBq
	 0qHdg48CatLMoVsKnv/UsVU2v1WUfv1vAVZuUwNQGY6PcIXlhQVfIN25pZ44Z2Nz2z
	 nYTX+KcnKMfMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 467CE40741;
	Wed, 29 Jul 2026 06:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB9F269
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D4D640232
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ES5C4IQInnk5 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 06:01:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 380F140096
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 380F140096
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 380F140096
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A0C8494B; Wed, 29 Jul 2026 08:01:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF4B8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:01:16 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T4cWdI927355
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:14 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq0q6tf1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so839142a12.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 23:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304874; x=1785909674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kQBcBMlUJOaBmOHBnJxLmUnxbYigj6Dw99LyUITx22g=;
 b=q2iGbJW74dCy0SLGZ1ufAFZDIdQRKTL4vWU7FFs/Szo13bLLj7+z0EFLk++ktVeres
 I9GsU6A0ZH4WN7uo1U40fIyET9k8d/FaI0LcMIytgd2SUQvcAL/pVdHVwiZsqDdbvzU0
 lWkW7W5SirS6LtqQ1nwOWBt6LZ0aRcdwgkqxVh3L0+1KiSRA/uLw2Lg1+t1Vq0sMvqtu
 OXvZvA1R2MRS8uXdm8i8w7ixXaCQHeBrgbSZ9TK/P074sVuCwtFGKtsqtRLbNoTvT03w
 xy+wtv889ptIHeaTr4wlyggRULMydkfbZBo7rZ2Jx0cdM4SdSCSENUvXUioqYcCLVk+2
 dk3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJLW053cJthlpiQ5QCx9s7HLohLte3GAz3YjJNy9w3btkAqVaallmahNzJzu63RNST5P51A1s=@lists.denx.de
X-Gm-Message-State: AOJu0YzTdPu3WrZNqaiefOsUjWXaO/1Xksh40Trlmia9emmP1FGLKkjU
 8wUis4Jyu6vpjUxC0FAayPEGn1NyeMTrGhlLkPU2AB94JdCZUI1D4p8GWH/icdxEMMXvgIr1KIu
 cLlcSClFFbwPoGAq9mCU6xb4avMH91sRixIcyRdLVmVFkQqKbKQjmm+nhnC/YYa4R
X-Gm-Gg: AR+sD13lbASFaEUXaGV05DtB/0lkeScSSpTbHSVi530Z7Z8DjsP69MJKBv5KWtCuiRw
 /xo4tDV2RCUJZAcbP2vbmDW/siGMnh+8MQ2fQHeFMepbOM3Efd+VMPPYBKENxrMf5wTXS3eooaO
 zrEJoCIHR0wW4UdPPwmy01cBbECJBVaW2c4aZxWAI49so+wWTbnEleXs464rjTRY9G+saA7J7q2
 I0+QPWknpzj6kyyuhOqZdC8jvzp3rQ6YLvsb2a3+P0n3ivJL5LLijPu+5MWoheg591MveWTWC9h
 Zmaywc3LdmLWTdb5zdJ0vGnbm5IkN1N+fVPHvWBFOzVmLKT7h4vD3nOzRxXuvw/APm4AorsXt/C
 G4QNkWxAebkGTkBEN4EWZOLv3H3cqLBDcEjIjT9Pkfa85QG8pR1azDfiHuXZQoMKHEukMOm+WWn
 9moT+ukZLW+3Ms0Q9SpvbO
X-Received: by 2002:a05:6a20:c99a:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3c8aaf295c8mr6120857637.13.1785304873642; 
 Tue, 28 Jul 2026 23:01:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:c99a:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3c8aaf295c8mr6120805637.13.1785304873023; 
 Tue, 28 Jul 2026 23:01:13 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm6868367eec.30.2026.07.28.23.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:01:12 -0700 (PDT)
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Wed, 29 Jul 2026 11:30:53 +0530
Message-Id: <20260729060056.2183090-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
References: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kp7sFrB8eGQhBvX1LZJDH_-Ukq1c3GnV
X-Authority-Analysis: v=2.4 cv=DqpmPm/+ c=1 sm=1 tr=0 ts=6a69972a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=c0c_lspPfvi_Ll8o:21 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: kp7sFrB8eGQhBvX1LZJDH_-Ukq1c3GnV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX8xAp6RJAYf6G
 /ShJA/gtfM+AhME2zsIInCvu3lCEjOqrbvlW6hsxMAPb+6M+OnltdrQAI0pE32dZf6kEU5RM/s7
 oN5AoEDdM/eEhqv0Ne/UNOnm9/YWyhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX/kSi9mMxaBnl
 bBdGxcOSr1B5TAv8zCLAjWus4nZk+sAvyB4PrzCAmgRmnGWYtSh8Ja3xj8zHwQGzIogFZsM6cCo
 Y5Q/1M6K6+WbvhnvUkDBWAVOVqa0O3d/ZPUwscw7m00Tv7ky0duICek15YJw+ZQAr9ulUjQpSrm
 eyMafB45vRR6y1cJ7W8oabc5Clvg8nyflBIpV9L2LbOI7KHMSZdXwUf9AZ20x8yF2qAV2NlAmco
 w+4/+iQyMTVPcdJ0JBU3giCOx+dpe4uBydfwd30aGfuSXSPlHZ7oJMPrykr9S10UFCixA+Zp3nC
 wh6gA0FhdDCBJvk4BZ6Aa2PSJ3TeloA/GT6i6t/jP3x3h867XALUlk7BiKzRMpbjxhPEZCkyaYC
 Y4qyus/PuUbeXVzScZKdyKYJW0unK27fdwJovj+mD81qUhPhWZIsjRWfclHO589oA0cEnPAWbin
 BRP4knUyv9hura2h4TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290046
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kQBcBMlUJOa
 BmOHBnJxLmUnxbYigj6Dw99LyUITx22g=; b=n9LqNgUKek5E1pNQpXBJGqD8R9F
 7KvbUs9dOCKJL5/C7ZyMuvlZJOvy/OnaW8nqWXQsPce+6MXD1MeXdh2RzAvQUcxE
 a7CkViMpUzvemDeAmw2PG3Gwlm4ZiHiJ/EXMoJ6nPgu4tpDJ6ZbNwddlSQcNUjH5
 J+wfgRyIsKDhOgMQuTKxYP1iTKQWlqREwC7pjFO+VjLX9AVjdrY5bFKuFS+PnNjv
 D+UxHTJk57xBVXNH/axvvynuE7ebXbPKtQC41DFuR9NMBFtUgiDIHV3oXikL4L3q
 24bM33LCDhRKzzoT/k5FLVZ7JghV5OgDkte9RyUMgYCOLoe+Ly5aEuYkePw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785304874; x=1785909674; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kQBcBMlUJOaBmOHBnJxLmUnxbYigj6Dw99LyUITx22g=;
 b=UDjQP+rkqmJ2uh05HMZia/VFCBS+ynwKgrkszHTlOWklIRyx0reJ4VCHeE7BGfa3/v
 TusRyPJn0oZJVdDOZFxL8xt1Wz0BHzFVLhCwU+OK0k3ZGAJb3MPMWr2qL7a92Sc/42Qc
 QBa/61HFou6YuBtJs/i09jHNPNOGo+eyAq7mvRzdG3DSsUfSkiI6gxx+UXgpl8NpbGEJ
 ouQ+iIHCgCe/y+FOA3v3TNqBDc0V4gNofB/3I2QSoOQ1guTmbQBhVrLkUTXx5OpEzhmV
 iC10ZObPTLgqGoLrwzDDre6Bzm0aXq8pceKQwn9nwKfmr2uzRZGjvh0ekfJZM1EpEBhP
 tQZw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=n9LqNgUK; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UDjQP+rk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9LqNgUK";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="UDjQP+rk"; 
 dkim-atps=neutral
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
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq9650.c | 93 ++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0a2ce55aaa2f..82c56cf605a8 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
 	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ9650 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_MILOS
 	bool "Qualcomm Milos GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b96d61b603e4..6cf069053743 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_IPQ9650) += clock-ipq9650.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-ipq9650.c b/drivers/clk/qcom/clock-ipq9650.c
new file mode 100644
index 000000000000..29c0c3fdf49f
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm ipq9650
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9650-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_IM_SLEEP_CBCR			0x1834020u
+
+static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE6_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     1, 2, 217, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].cbcr_reg,
+				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
+		return rate;
+	}
+	return 0;
+}
+
+static const struct gate_clk ipq9650_clks[] = {
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0), 0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x3302c, BIT(0), 0x33004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE6_CLK, 0x04018, BIT(0), 0x04004),
+};
+
+static int ipq9650_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id >= ARRAY_SIZE(ipq9650_clks) || !ipq9650_clks[clk->id].reg)
+		return -EINVAL;
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map ipq9650_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq9650_gcc_data = {
+	.resets = ipq9650_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9650_gcc_resets),
+	.clks = ipq9650_clks,
+	.num_clks = ARRAY_SIZE(ipq9650_clks),
+
+	.enable = ipq9650_enable,
+	.set_rate = ipq9650_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9650_of_match[] = {
+	{
+		.compatible = "qcom,ipq9650-gcc",
+		.data = (ulong)&ipq9650_gcc_data,
+	},
+	{ }
+};
+
+static int ipq9650_clk_probe(struct udevice *dev)
+{
+	/* Enable the sleep clock needed for the MMC block reset */
+	writel(BIT(0), GCC_IM_SLEEP_CBCR);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gcc_ipq9650) = {
+	.name		= "gcc_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9650_of_match,
+	.probe		= ipq9650_clk_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1


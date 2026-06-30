Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC1DC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38C884B33;
	Tue, 30 Jun 2026 14:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jn+Mebp2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToZ9li0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFD5849FB; Tue, 30 Jun 2026 10:10:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9307A84857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CHOe1029931
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r6/nN7HwDlG6cTTFwcUNHl/A1ObdnN6H3U96UOwyPIg=; b=jn+Mebp2bxDYAVCc
 bfrud2o3djearUzhS+0VEghynHHKV3dIbUkWHbCM3c4jf++z3G3T6pUOjtFThRaA
 axuJkeGD9Q9b0g3DIvkbZSy5cwiNaHb4AQIjt2gkATf1AK5TFtGbpEf8bv1EusXN
 RszGw+0m3TV+EnhYq0o76NPZpCKis4viEApIkLXgudMe6UUveKNRIDxNjYnlogzY
 J/eWLGNLn9fr/q7kgUg19A6wQttyBa+5LIOdgYu9YLBgT3F4Mqg9uaoIqvZ1+IOk
 9OMBQMzcZGrpNv26xv2JBJlUslyw4uVYo17Uns+GCWA14bpEwj5Tzf+ws0oyUVH6
 qqV/ug==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4h8wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso11507976eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782807006; x=1783411806; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r6/nN7HwDlG6cTTFwcUNHl/A1ObdnN6H3U96UOwyPIg=;
 b=ToZ9li0pENsQxOqAO6zzG1HNF7kJLokKgAeUPbLwZzjaNSxgOke8TInq4MO1kVjMEa
 yV3c1zAKi5l8pTiIZuTN+HTTWN+6YlOxGv7wilLrjWLYVM8/QQ8ykfUagWxNTrIkyGaz
 RbgXwleghLX911N3FAIxOPPZJ6WdS5vkkN1Xffu2wKi0uYeHlmqvDMiftl0Iw435IV1c
 7BHV0nFUfm92ASpfJ8TOTqqVA+QJ+JOzgqS4ESVrMeqNuLndcD/4FNOBlGwlY9HPHQ3J
 vaQ1ZarRy7DhvE0JWz2hQdCFgyXS6CU0hyylCYn+EhjQn50xFpC1R2D90RDoXgkNXnd5
 9oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807006; x=1783411806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r6/nN7HwDlG6cTTFwcUNHl/A1ObdnN6H3U96UOwyPIg=;
 b=Un6a+EOYU/uwjKq1mcQSTAouoghxrX2hBcruxFx8Xn61dPtq2/e77N5CT0p6RN/a0K
 J25B0IXi/g7Q7ezdEwdmBV6E2RI/TCzmJSMiMPMPzm28Mn9fD/As6Fx+g//KBqMr2WJh
 mOBHOafFxkIRDTKtgK4ZuviqnBUdgiOl4chX7y/K4/6o3g5gpp++X3vb7tbgv+Tc1psy
 c0N3dTDpAAQDWQDELHl7OoOFiRyT9BrbDcH6twazv5wgX/4mhCc9VO9AcxUvL0r65T08
 zSM3Osh4mgXwz2ToE75+hTwRexC2EtIzLZHll5sE+eLO1kk5BGuVo5RMlpB681z3ckrJ
 vxoA==
X-Gm-Message-State: AOJu0YzQPcxi1MNxA5mAYL7NY1DdaWanLfTkaKBps/oOYBuxqnMcoius
 Vy2dlE9yBBp4QUYiE9nU6R2QFaaLrAuOIJlVsHvnSUf24Jvb3+Z7kjiB1UMTHDYC/jEwX2j69ug
 w36yzhaIZlqpJePI42QovWZF3I/O4klvsu+vJACBlLD3dtARyz/mTNd9C
X-Gm-Gg: AfdE7cl3fhk4HDpAvMV8cCI0rRM+zHQ1lBnObLhf/jaZksaeJuJqAeoBETTtDew2+Z2
 ov/DOIb7pmvV5ShwdxHI4TYzqmW3i1CYccAlfOVzcNHxYhByZYb/3uqVthNgdyPzQFNrUOdB+sG
 DuKlWJPMWwEqjAMF68cdnJKitR41bJKH/PbvO5djl4pKFO+i1J88ZYaGdrzXiJF6uqcr/3kkTf6
 KiWhMfwELLWVY4UmMSKIsBozFX+KzCTf/ZT358QHjCf1zNQewBIH/ndJ3GpqqWKyowyjr56WhgD
 HcZCu3ccjl0UqubRd7YKL4iu96kKiX1V1+AK6rN0toNr71GMPtW+ApA3rLejxt4iA8tdmXPI14Q
 /yfWT4QjB+NpRQFr25FrYN58vLylBmiMRkjoS4RqnC6FBKkGSTEMD93WSdeU4VA8mx0NRU+zCr6
 GISK847u8rZ3yThXyz5C+cOaGnABXHTWCjSH9yXSBf
X-Received: by 2002:a05:7300:e882:b0:30c:7fc9:de05 with SMTP id
 5a478bee46e88-30ee121a878mr2327207eec.2.1782807005926; 
 Tue, 30 Jun 2026 01:10:05 -0700 (PDT)
X-Received: by 2002:a05:7300:e882:b0:30c:7fc9:de05 with SMTP id
 5a478bee46e88-30ee121a878mr2327134eec.2.1782807005285; 
 Tue, 30 Jun 2026 01:10:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:10:04 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:28 +0530
Subject: [PATCH v7 06/11] spl: Include SMEM driver in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-6-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: r78w1EXXQs9kH8yzRgdaFXugOdCjSEM5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX/RLEQBEHGl5O
 eFJCXtPFT0NZuOIZaJ6pxRw86bhpwQvWSg/OhpPeX1/h/ylUCgQTFm2CigrJjZaYEN91IcqjPuf
 TPNNWhHNp8pXr6iSuwVXG73H1Mhcgsw=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a4379de cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=urvU1upnej4-CWmsP9sA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: r78w1EXXQs9kH8yzRgdaFXugOdCjSEM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX//Grg3i8pFYA
 N3r3rKRWVzMQSSB0aOqJy62OkgyivZw1cMppSWFg3MqIZo3PIMgPyJY3MMCT2u3IGz3sRFeK9lo
 MmHv8w1SuS/41JVEoVgSTka0MmLoxx4LCg3uesQzHTA0+VHor844dKum6wS7P7d05dLPv/4Fm+N
 6qzI/H8LT7xIG/OVusi0XI48lFEk+ejC6PupytOghowQPJGLuBt498zqVVwcFZ1lho9D/7tWwFI
 Jz7hmluiJ1j6RWp+jJomeELQfJLbUJnnGXH5y4rM5IDVKKC34HsL9w3cYoLE/nEk6hluZu7I5pj
 moVDA7q9k42cZGVWxV9Zt4twZQtsjfDgLpFQsjjtdI4qz+6jQhSqpNUgN+gaD/ZqVzEhliGeOuO
 SACnjnyEdnAMvvrEChCPPph6exvoqubOWZK0NgnhTBfYbjl/fE1XjTWaU7SfLXWxmuHwiSLUonC
 ZzV5eOX0HSPXQ6J0arg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Add SPL_SMEM config to enable/disable SMEM driver in SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 common/spl/Kconfig | 8 ++++++++
 drivers/Makefile   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..88db96807b0 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1387,6 +1387,14 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_SMEM
+	bool "Support SMEM (Shared Memory manager)"
+	depends on SMEM
+	help
+	  Enable support for the Shared Memory Manager. The driver provides an
+	  interface to items in a heap shared among all processors. This enables
+	  the drivers in drivers/smem as part of an SPL build.
+
 config SPL_PCI_DFU
 	bool "PCIe boot support"
 	depends on SPL_PCI_ENDPOINT
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..ead082450ca 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
+obj-$(CONFIG_SPL_SMEM) += smem/
 
 endif
 endif

-- 
2.34.1


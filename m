Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E57C55ABA
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CF6180E67;
	Thu,  6 Aug 2026 02:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QP852yMc0f1; Thu,  6 Aug 2026 02:21:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B6DE80E6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785982885;
	bh=7rEqGQK+86fISZZ6wi966braRQvUNzGg3O4hjbfbPDQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fijP/NIk03WgF/2tPhGX6X8H+oRj0HQ90ZNAfd6cG0sbxTtZJ23f/rA/e6d8w8EjX
	 PFH0Z61qiAsgHxsNa8DqOObPRrrZKGsLFuoaDC+5E3bnny937X6XopcxObI6/D2tid
	 S8JugvKsB6cKH98e2v8vQINob8pH0yEMVQ2rvE/maZNvgto2RiBDBSOjdXH2umGLUd
	 VcP4qi38wxDOFRn21NVGu971XO6nzDgaHUT9v9WR+hTEdIUGwAHOyzPy+QGp/+jl1z
	 u+GGqOlm1itaZY7r0NNe2pGbhWdxZJnmn1pAFmVQvhGp1OJy3mAuf+Sn9NvWXXLQop
	 /Oh8klYzTQRcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B6DE80E6A;
	Thu,  6 Aug 2026 02:21:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DE76392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FE2640101
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WsYS8JotK8Jv for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 02:21:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF72240029
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF72240029
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF72240029
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbQim207310
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 02:21:20 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c0c36b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:21:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so3297350a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 19:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785982879; x=1786587679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7rEqGQK+86fISZZ6wi966braRQvUNzGg3O4hjbfbPDQ=;
 b=glxaVCkyyepGDU0zuQF8PQYp/7aEV2GahEoFQq7i7GF9AoDGMWj3KKQ7x6souwChb/
 tmiGJkVXNnjJdYBtnDEErKn+saFM5VdMLMXBTTO++JnMU9g8oEYm2MzMiEiDGwvmKVe6
 iQkWbaj7NfwTpI0D0HZc0ecbPanHWJ+jkPFowa3DkYGPj8GK1UAcyNKamL8XaHLdzv4B
 Nqu5btTrUkviDXCQLHBdBNAaEwz36IBuGlJWpckvVo91RPABhuc4KCQi0DPZrIiSSar4
 KSnP+qthoHohQv0iX29LVF1rFs/QOiT61jtkZKdJk4Crw6q64E899U9PvrCrHanmnXnA
 daqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RprutOktXvwLYLy9fTw9PtZkb0miFTMdDy4HbaqF5/v3HQCRk8rirjbat850JTyJ02WLcP+xKM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyqkJBVtG70FenopOCPUhaRjRIOrnY3Js5NWJUpmlsT06dyHv/2
 7vST9374JlD1vWgrZplTURRfCKGsXbUI8hUjM8fjr7UJNZmAE+2uv65jx3lVBEgtCQpLvt1ujeP
 ivHwGsCnhKeu6WnncCjo7w9G0/Sfsrt2AwIFA4UXKTcFA9ZlR3mPiWH+2jn6CBqlB6sUOXfc=
X-Gm-Gg: AR+sD12KZ2F2dAPYEmaokZvpUjyivbfdNW+oDZzdtrLu+t22EjqS1F8gOwQ1IgdAgn+
 pAglLD7DHT3S+10GzRbWTSwuDjfJHE7Fj/dHsXt1wl7rnjQ1LVYbcKDmiomz+wEeEHBxoaaSsJg
 Buvn3q6tD1uE2QEJ961rLf9zX2v/VnLCuW+1zkYufFDF5kmJkfxOgrgtZg7JqcERmnwB0D2ueG9
 upwev8yc+sRQXJR96VjEOndvtqOuVFsiZbir+utUbdDo/4KeUuN/I944PQY153Atvec33aKQ7CX
 IONEvvjyEU4brAsqfiZNKnypGcXDihZ+GS/4QC9/j6nM/RM1M+v3nuXMw1kBP2rM+NnglbegweW
 vartRcYxONs1RvOASRiD3VFxtS6+HnUbIrEzkCjHTysCXNcytVjX2TqyiDWUnNZYkUUfIrTxoQI
 jXmAMy1FCcnGjAaSC5kxExHTha2w291A==
X-Received: by 2002:a05:6a20:6a08:b0:3c3:859b:9178 with SMTP id
 adf61e73a8af0-3cb85f508cemr13111643637.34.1785982879254; 
 Wed, 05 Aug 2026 19:21:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a08:b0:3c3:859b:9178 with SMTP id
 adf61e73a8af0-3cb85f508cemr13111607637.34.1785982878879; 
 Wed, 05 Aug 2026 19:21:18 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm36385067eec.15.2026.08.05.19.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 19:21:18 -0700 (PDT)
Date: Thu, 06 Aug 2026 07:51:04 +0530
Subject: [PATCH 1/5] clk/qcom: Add USB related clocks for IPQ9574
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fastboot-v1-1-cab7d64e592b@oss.qualcomm.com>
References: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
In-Reply-To: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: VCKNjPkM6jBrvtKvlfBeXrx13ccqUQjB
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a73efa0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fbqHkSEcfmD6VvpdCmIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAxNSBTYWx0ZWRfX9zpYkPFKBhoH
 eBcH+qMDIqNLh366SpuvaauDZpeUZ+v3xtTxv/VWaeAmneKmMrJZT4KpvYMMj57VGqiQsKgmYvA
 o4nj/t3FyTTfvavrWN/lGIAZTZQGYEs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAxNSBTYWx0ZWRfXwkBPfrK2Wpwf
 GpWZrs3pbp6IUyxLqXaeZqTCZqjL8NbbjwdLebKFGYrFwfjk3lx/TZIUM6sfxA8PeuV4Wq0DHC6
 tb0nc5xob79V0gDlJcZIBOIg9CKhT8ThbFJTLOyskkazaHYHa3ZSCX8reU+bXTmq/XS9t0cJIWm
 kHEVXhByI8kiqNePCp0CbugBqwqYoXparvwa6pig/P/KsG+0dLg2jSMcQSWO1Gel6aPEeN9x+5X
 pPBfuH0+jdfCubZHfl8eM0SXFnxXm9oU+S9p5a1SXIFlEHAGAEeSZvIS82ZL9FIkVsZ3GGxoCp1
 7BH5GyQ0HEYGaM/WghNXwjoYPjYATK7G+m+RzWFbGQctcB8mERUorCKCck+5oFEMpX417u6Wesg
 PJkE8pmeusU18BW1wPfB7tAX4nJBWq24bh5tmnuLgIJnuXIxTjS+X6etp+8vSJbwVPB3jO7Zoyz
 mof9B3ZtvTip0RYbojw==
X-Proofpoint-GUID: VCKNjPkM6jBrvtKvlfBeXrx13ccqUQjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060015
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7rEqGQK+86fISZZ6wi966braRQvUNzGg3O4hjbfbPDQ=; b=VMnmFGkknytEbwD5
 fEgAKSD4OC7CGwYGlivIX3iGDhNm5K2E6Jbdlx+Hf9A8iocd7Y95BLRQ/W6FJkTI
 ooOiw2xrTfI0GSX4gOMlQoelpwjfWSK26saBpothc5yPka1SayVZBhFzsYz23jPC
 vpfR0WOWm8UJakLD3SRBEWE90e3tfKORZtpIm9FURWq7BB7ATYRYrgsws8BZ+9fV
 aFV3qOUNnWNZStHEoVwLst6uvh8DPfuLs1pcS41Sn2ZylqMVfLhzbIH44iwNU0O5
 UzgTlw1M3VJqUOZuP6PsCM1R9W0bb7izqN2sqoSqT42p+joiTl5fNvEgLWC6Hw0H
 J15r5g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785982879; x=1786587679;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7rEqGQK+86fISZZ6wi966braRQvUNzGg3O4hjbfbPDQ=;
 b=Ua2rdxhB8FDE/oILq/OFG3zUmJEL9IGZijzQ3UETt8pnovQFqSeUrwWkTDHlj7KMQD
 t0q/Uer3egHppDqUTGgAiN/JwPNI92sdeFr99WkuZyWJkj3AUxfJ2au4Jqe4hDskHI8n
 9kZDnwzVSjWaUeHam0jN9YsU1/Ad+1mbcmEEdTlTHSJI9xRqgE2PT3QNza92nv6Exqkj
 6eWClcfKr49eyBm+U6JhFPQTGrgB5Xf+mAIma8tpx2Jr6necQVGNH2XGi0+fl0Yui7r+
 GUn/8aBk+rhSr6kD6m8d0OqGUvG5QxTfUO+kfQdRFZ1BodzwUEhfBHLkJK4MJjHXxtwE
 u3lQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VMnmFGkk; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ua2rdxhB
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

Add the USB controller and phy related clocks.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-ipq9574.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
index b0af4036059..1f5146b29a1 100644
--- a/drivers/clk/qcom/clock-ipq9574.c
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -25,6 +25,9 @@
 #define GCC_SDCC1_AHB_CBCR			0x33034
 #define GCC_SDCC1_APPS_CMD_RCGR			0x33004
 #define GCC_SDCC1_ICE_CORE_CBCR			0x33030
+#define GCC_USB0_MASTER_CMD_RCGR		0x2c004
+#define GCC_USB0_MOCK_UTMI_CMD_RCGR		0x2c02c
+#define GCC_USB0_AUX_CMD_RCGR			0x2C018
 
 static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
 {
@@ -39,6 +42,17 @@ static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
 				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
 		return rate;
+	case GCC_USB0_MASTER_CLK:
+		clk_rcg_set_rate(priv->base, GCC_USB0_MASTER_CMD_RCGR,
+				 4, CFG_CLK_SRC_GPLL0);
+		return rate;
+	case GCC_USB0_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_MOCK_UTMI_CMD_RCGR,
+				     0, 0, 0, CFG_CLK_SRC_CXO, 8);
+		return rate;
+	case GCC_USB0_AUX_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_AUX_CMD_RCGR, 0, 0, 0,
+				     CFG_CLK_SRC_CXO, 8);
 	default:
 		return -EINVAL;
 	}
@@ -50,6 +64,14 @@ static const struct gate_clk ipq9574_clks[] = {
 	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
 	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
 	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
+	GATE_CLK(GCC_SNOC_USB_CLK,		0x2e058, 0x00000001),
+	GATE_CLK(GCC_USB0_MASTER_CLK,		0x2c044, 0x00000001),
+	GATE_CLK(GCC_ANOC_USB_AXI_CLK,		0x2e084, 0x00000001),
+	GATE_CLK(GCC_USB0_SLEEP_CLK,		0x2c058, 0x00000001),
+	GATE_CLK(GCC_USB0_MOCK_UTMI_CLK,	0x2c04c, 0x00000001),
+	GATE_CLK(GCC_USB0_PHY_CFG_AHB_CLK,	0x2c05c, 0x00000001),
+	GATE_CLK(GCC_USB0_AUX_CLK,		0x2c048, 0x00000001),
+	GATE_CLK(GCC_USB0_PIPE_CLK,		0x2c054, 0x00000001),
 };
 
 static int ipq9574_enable(struct clk *clk)
@@ -67,6 +89,10 @@ static int ipq9574_enable(struct clk *clk)
 }
 
 static const struct qcom_reset_map ipq9574_gcc_resets[] = {
+	[GCC_USB_BCR] = { 0x2c000 },
+	[GCC_QUSB2_0_PHY_BCR] = { 0x2c068 },
+	[GCC_USB0_PHY_BCR] = {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR] = {0x2c070, 0},
 	[GCC_SDCC_BCR] = { 0x33000 },
 };
 
@@ -75,6 +101,8 @@ static struct msm_clk_data ipq9574_gcc_data = {
 	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
 	.enable = ipq9574_enable,
 	.set_rate = ipq9574_set_rate,
+	.clks = ipq9574_clks,
+	.num_clks = ARRAY_SIZE(ipq9574_clks),
 };
 
 static const struct udevice_id gcc_ipq9574_of_match[] = {

-- 
2.34.1


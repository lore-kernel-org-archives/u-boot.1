Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAB5D3C92B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F5783B48;
	Wed, 10 Dec 2025 18:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oeb3nOvM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cNhd+HwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97792808AF; Wed, 10 Dec 2025 16:55:11 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A0F8309A
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BAB69Hh2419705
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jQk3pKXGQ18
 PnC5saGJ+4BGR890i/oQxtXvr+cMcgFY=; b=oeb3nOvMqy0HDwlmTsCiBQ4FrnU
 kC7MoXLtJQyIQAsm3J3mL8oPtyr6SGni2BFjGOPXIffrmgzZDSvLiN5/gznPiKsP
 aIKVUNJpn7IocWjGd6D+3LcI7CsXdlDoqMYcFd0QOo0+va7i77mjSyRsFeAtIMC0
 HVZiemLmXxjVo+AoMPVwkYLvc2k/svu6ZoQNQa9gjdcxYXpQsFAH1z7o3BfrBqoO
 ZdC7oIirHmMtebh1mGivnMYxr6Bncyx4V51ZeUFeP4kDoEXTfpS2TRxXoRSwd3Wd
 oNbGH+xD3uZ/ilgfach1oh6h0OCnRGRyqcjLvYWXlDSNyYn9HmOBOENkoVA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay7pp0vqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:55:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4eff973c491so157333951cf.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765382102; x=1765986902; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQk3pKXGQ18PnC5saGJ+4BGR890i/oQxtXvr+cMcgFY=;
 b=cNhd+HwSIbHfPXrFG5w6zzewcZZl5QFlU3TkODNHE3QFcNoGybmBfQqV32FE3B/ni5
 4OM8HX2oG61mmUkHuJkgajw4J8IuFsAXxDLrr+AYJW/tQGywSUJqUIJ1O+fcuJVeiOlU
 FyS26QjQRrjO0nzGgNBtxc6Cphe/Mg7Kyi6iyZ+FjCxMUYMjLcaHQ76O1dItwq7xoavi
 TiDz10YdzDVcDgquSN75c4/Fnu10bs7up3HEQ9AeqYe4qWrteghr6ySO7jZFYyORaeHx
 hGMRMmEzqoXa77ypeXzULmaVxN6GXo35C/mA6f8lFaSwprN552SDl7E6FhiiAkH0MRWE
 LfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765382102; x=1765986902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQk3pKXGQ18PnC5saGJ+4BGR890i/oQxtXvr+cMcgFY=;
 b=OXhjMQHVwXMdQzpbjgQNybqt1nOtsxkSZD6G3FY8yLyQ2J0IKLAkogx7y97Zmvnoil
 djsCep4hpMZanJogmPfqB+kl/6/H157tiRw64MJXJbXry6IQQv9Z3I+68XKFaewcuT79
 nkqy+Qcr9AaJ12GDNGukpLSfWTxtbqzwTtWvNMX0XgeGYOSQ2gsUdbjNp0qF7jSnpSNE
 QQ/tekgeM5yopjR9zHvfoODnyufekZ6xx2aX8laDg3q97ZwzJFxZBUipTkfEH28g+r8x
 Ckcray8OBfXm5xK3j5/b9vLwHr6n1EkKr+/cvupNjvecUksaP2iVH0Gp7fBrQ9k3CzJK
 O+Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu4Sm+748k3BuOfd0KsXlB84IqY41zeskD8zlLSEvOjMbuUoP9mT/q63GyIO3bG5QncJAlvJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxbZ3aEnxs7RllIyiCY1Knv5dFm/OYNSRsdjhFDFlqZthAzZaS+
 TPTj9dwZ6iw3xhBn8/t9xSA49qa0Uf6jTdD5G/eQkFWV8RSkVvP9UfMWZIv7JsC6NZgLiHwQX7y
 +Itiw61aB997e/nVyyJRdh8Bole+zIC2B6Q923/LFI5u+i5aYLTU0jQTL
X-Gm-Gg: ASbGncuNfqicGIJEu/QqW4pPOgR/olJE+yVBdbgg6YcPYawcWfJmlR4FIJ9z3jejYPB
 vnYsKNGKQmiI7d7oWnBJp25qPR/Eh+GDWYDUVHUltsKwDC2siWkYcyKwdunFfnl6vS5Xmy6gWju
 2MGjO4kamMr3J4MCa5v5M/5B9UeJ2C86Ih1hMkAIzE2d1Cq/3feKAkrm0oMVYUJ60of6Wxke9vS
 +85ZHa8cTJV/wlP40+4o3ETjLMbKqJ/tuvseeKS6RvdsDvd4nRtL5pzDLk3ZysogibsljijWSU5
 70TsiOaRzbrSdUIBLYZvs7eoa/13dyoJpMIWgh7zLH59QZL2JeP3GTj7Py+bP8jigBf7w2T7T2J
 Q1/+K3hyNHtPL7tOaFLyTYOiFqhdnNqhEfUH6QiSqURLuJNJid6hN+8NtqvfuCt6aTiCkbz4Jr/
 d0
X-Received: by 2002:ac8:5f48:0:b0:4f1:aa29:7795 with SMTP id
 d75a77b69052e-4f1b1ac9643mr44409111cf.49.1765382101663; 
 Wed, 10 Dec 2025 07:55:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNkM0YZimt5SiCOuI0byPaV0UFq2mEHLKhLp1KtymPh8XGBQoCmfX4E8vPa70TZVG1jFF1OA==
X-Received: by 2002:ac8:5f48:0:b0:4f1:aa29:7795 with SMTP id
 d75a77b69052e-4f1b1ac9643mr44408721cf.49.1765382101238; 
 Wed, 10 Dec 2025 07:55:01 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com
 ([2a01:e0a:82c:5f0:f840:4916:e7c3:a857])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee50sm38126808f8f.14.2025.12.10.07.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 07:55:00 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 2/3] clk/qcom: qcm2290: Add SDCC1 apps clock frequency table
Date: Wed, 10 Dec 2025 16:54:53 +0100
Message-Id: <20251210155454.1561611-2-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
References: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LHhnOE-Ygq1ETx3HnR3YFch4N_MA-xcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDEyOSBTYWx0ZWRfXx7y/AFlmNytg
 1MomgjyJV6gOV2eNRmZy7QW4+8d2SFvy5AxQ2TKwZnWICKTt95tBT2+0k3NWI7eyAIG0y+l6yxZ
 UH7TYvE04z3ZexjZNFLNLHNckJGTrrtQWg8Tp7Gk5shs/AXtT440U+spvQIZ0OUccfAtgxjTAP6
 qdKWn5FR02yo+xN/7moNg398qdyNjebB9xtY+VniaFceGDWBIvQtSSc4pq0RpV9QDqCO0ZktYvS
 XS1CbJUC0jSvO/LOycfGm2tkUhGcq6DrAuNFez73NK5gsrg99/swt/wHxAkk75CPECtcwuC1Hu7
 2CbYdywoeYdF0cfSt0fkZFKm43BdsG0rumff0oSRCxMMXxEH10h4TcfE7JCWom9Q9XzY9KOqtzQ
 h11CJp7JbsIn/PYNmXFBExk5HdhJog==
X-Proofpoint-ORIG-GUID: LHhnOE-Ygq1ETx3HnR3YFch4N_MA-xcb
X-Authority-Analysis: v=2.4 cv=WaMBqkhX c=1 sm=1 tr=0 ts=693997d6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Cv6jKa7Rss6kltGLosoA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100129
X-Mailman-Approved-At: Wed, 10 Dec 2025 18:11:14 +0100
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

Add support for configuring the SDCC1 apps clock on QCM2290 by introducing
a frequency table and enabling dynamic rate setting. Previously, the clock
was assumed to be fixed at 384 MHz by firmware, which limited flexibility
and correctness when selecting optimal rates for SD/MMC operations.

Suggested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcm2290.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index fad104fb91a..5a599085b50 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -17,6 +17,8 @@
 
 #define QUPV3_WRAP0_S4_CMD_RCGR 0x1f608
 #define SDCC2_APPS_CLK_CMD_RCGR 0x1e00c
+#define SDCC1_APPS_CLK_CMD_RCGR 0x38028
+
 
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
@@ -55,6 +57,25 @@ static const struct pll_vote_clk gpll7_clk = {
 	.vote_bit = BIT(7),
 };
 
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
+	{}
+};
+
+static const struct pll_vote_clk gpll6_clk = {
+	.status = 0x6000,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(7),
+};
+
 static const struct gate_clk qcm2290_clks[] = {
 	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, 0x00000001),
 	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a084, 0x00000001),
@@ -109,8 +130,12 @@ static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
 				     8);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		/* The firmware turns this on for us and always sets it to this rate */
-		return 384000000;
+		clk_enable_gpll0(priv->base, &gpll6_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src,
+				     8);
+		return freq->freq;
 	default:
 		return 0;
 	}
-- 
2.34.1


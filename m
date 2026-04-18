Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED77F436BC
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 06:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A677F84246;
	Sat, 18 Apr 2026 08:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwK6TKYq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXKv5wTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9502083B99; Sat, 18 Apr 2026 08:35:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6687784214
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 08:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4UDti1283236
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NFBfqIN3W4Ody6nCiwSiUdYnUWY8GiH9F5KrhSbN2qg=; b=gwK6TKYqxtB1d35B
 vPFo9cE1CVhB+6wSIKyC9otjgxc+goNvuhMPHMtJqe+SxtBXgfmx4htf9TxsyKiz
 LjwZN8JGi9Ms5Da/SXU8k6T+BM2Yq/sovV7CV5PR5hYRUQqQYZ88uwdwSrQz00NE
 5Cc6x54LDqRFvJ8Jr0N8ly1uMI2mfKcc9a8TdQYVV8PTMV1p4nirSHnQ2hGHinjZ
 Tsv0NAx/fllgRUhDVjW9wD22Vz8Mwq4KEV5hiOne3SrfmFNK9IqwpyvSzjf+GatV
 GQRvFc7LwPdkQPwWaQeIwpvX+lGrvDIYQTMb9PPtsiS/4ewNU9Oue5VcUaW0LsV1
 CHJHRw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm19frbrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b458add85aso14610035ad.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776494135; x=1777098935; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NFBfqIN3W4Ody6nCiwSiUdYnUWY8GiH9F5KrhSbN2qg=;
 b=OXKv5wTmSkAOoHNTlJXKwPcUbsksaD+fPtrFJ0WtJ/mWQMm6XOtVX1PZSua0l4u+Es
 Cd8gv1m9tjML77jVhOjauVSD4Jw0/LkBLilgucBDBkmsJAIMqL3Te5pMdC1MWbQpH0f2
 ChQuOeOoNKIjEObk7SM/S4DX0jdQjQp5ibOY5CjDxyewRRWqnedv2bSjnNOrVI1Huuqp
 9U2Sj8Ku+SUVr8FuDUUodvBT47HTa5fcwxrOpPF/NdyiE96TW+pyBZJe1uPsD9qaQ+Q1
 QV0uJJ3vepZn9wisM46znsRLD8XjeGIsZAHVYTd8SvdrwDzRrHEBerfNV6E25LAABxye
 aBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776494135; x=1777098935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NFBfqIN3W4Ody6nCiwSiUdYnUWY8GiH9F5KrhSbN2qg=;
 b=bR1EaodDg8VxoOYjxzyKgacM3yq2e5ap2WfK2zvKB8ay3l0zZhtaSpUo7bGxmp4kMe
 jCxOzkeFAKg64yAlgRdJtWfJ0Ala69NhjP2uEdadHPQvcld2ylP3NiCN2S9oomrTeEnV
 y2Zjk0G07QZ8PbNP/47/TLPvy47klQGtklgdLmVE6IQAfuKaUQ2i8ezkaUBa9OVTSOF0
 gWPhYd1HF1RkHSl3XTmRZoZeFhOy9xW4RD+trvrnjKTt5j+pQnxIS4WBCwnu5gzuynzp
 fOQn3eIjTRbA4y+BG3NUxmllO+yZIqZoybdjqhA5CE/K62z5cO2SfLlGoTnZoN/ZCCOS
 tyTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uDx9Xnyvhg09jHuQgQcOQs5rqrCjcMUg2V2A/ZXzGeoHnXYGWz16kBE8gmGvMhJxF/BHd9Wg=@lists.denx.de
X-Gm-Message-State: AOJu0YwMgiGcG24QVi09pGmeYSfqeGBiD3dAcNGBrwxvoLkHVW4txZ6p
 bRTlYoY1En/c33NIxQDWVUCRj2ifOn0TYEjzCWyjfNDzL2roIXSHfIP582RdBeqYtWUfM745JwD
 WBGBP2BxVEED/u5JnoKSmR7iC0ARErfRE9lJzbXSkS17yZXfXj6PhGW1l
X-Gm-Gg: AeBDieuhcz4IX04gEmC3VCvb7KbDcrgJegFEP2jaoLKGNJHyCbtOomdkrtyf76XB1GZ
 RTyFEJb8clFdT5aEz3G1qZs6Y80rAGiL/hh2riiRqe83t32dik+SR7GaR9uJaAtERxMnd/WGKoT
 Ssb7Wz18WILUJjDcJONuTGeOlmQ7k/i/8RNWGRS6XxoZ4b41EgnVF6PouBQ4y0pkYdf+A0U4qZn
 b7CqLWmK3N0DwaiXYUVhqSOczBLUmvl0KTwgrCIpKp8uk8sMTLhOhJNer/WSWUQ4P+LJ+6Rktrg
 yHH4BaBAvezK6Zhy40QiqL3/SM+yX5dmGZBuIUsCtN7g1t902LX+ZNB2EWOIFUVrG0pZV6LoLLE
 1D3hRveHwDBgNt7Qf67LlCP4R6XkwXFvjSysmuKe8dJS1G8mK3O9REX4U47sqyw4nmDMNK/g4MX
 XgZdGH+rV1I3WIiaRIMSJwjpk/8qn51IbWQHuk20YXp7jRs3xyiuPpT1O0ow0I
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id
 d9443c01a7336-2b5f9f3aa58mr56776265ad.30.1776494134794; 
 Fri, 17 Apr 2026 23:35:34 -0700 (PDT)
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id
 d9443c01a7336-2b5f9f3aa58mr56776055ad.30.1776494134307; 
 Fri, 17 Apr 2026 23:35:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20d33sm40542345ad.63.2026.04.17.23.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 23:35:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 12:05:19 +0530
Subject: [PATCH v4 1/5] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-kodiak_ss-v4-1-d381670c9d78@oss.qualcomm.com>
References: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
In-Reply-To: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776494121; l=1063;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KukZbcxBUkGOIyMmae7FHnNhf8B9HR3azue6DrbCWvI=;
 b=tDw7tp7LjAb3dOX8aoTOlD8fxb+/K3gbvtTMmXtgDmJgd+j004Ho8K4fQoamP30K4E/3/8ZB8
 Nbm7CWTSG6wBFGx+SPSe/vsIA/xrHjd+FHfvHYuUtDZfbE/ucxnhKSq
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA1OSBTYWx0ZWRfX1sV06kX0nvN0
 8x3CE1wUzQCbX+PAUd2ZeZIco1APi1r+tkrwP1OZo4mcgQPN+byUxBpsVxJKR/5hxZ4sego8r7B
 HSLO0g+hUGaNzBCP4fdEFkqD2SuQ2AI5XmA5RxgCmmWh56FNCskpQVwZegz8m+0IFbJ6dASXSHP
 0ETQVfbvtidLyn7yc1q7Ib5mIeIwaLuSJNeqxTwsjuUdfolcEKLuaCKl6nMldaC5oV7bj6jIgWr
 yJJUJm7XEtuSJvPEAET2bvv2netrtMN6+b7+V/99O6GDGW30Rc5XBuaT6GSf3TK9IFioifc/gwf
 Fv9xZlPPrxYd75EV3hSGtnivrdvh997G8cIAH3hjoRSIaOT+thAsWiVebqj+64uLkDJSE9WDdax
 V0B03moQC7DIFHWg3WYdLd8UQAtEMfubJYlDQq5QMtlsu+9cV8CgnDeaQa1k3pdu9NMU+ImoW3z
 23skGr7dUHMhA9ghqHg==
X-Proofpoint-ORIG-GUID: aexggiKnChh89YruY7WR0PuCx-HORDsJ
X-Proofpoint-GUID: aexggiKnChh89YruY7WR0PuCx-HORDsJ
X-Authority-Analysis: v=2.4 cv=FMorAeos c=1 sm=1 tr=0 ts=69e32637 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3vLCiLSuDpT7xIXx67cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604180059
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

Add support for GCC_USB3_PRIM_PHY_PIPE_CLK which is required by
the USB3 PHY on SC7280/QCM6490 platforms.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes
---
 drivers/clk/qcom/clock-sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 7b6ed826023..403995e5a0a 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -116,6 +116,7 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
 	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
 	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
 	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),

-- 
2.34.1


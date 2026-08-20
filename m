Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD35C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 05:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BA4F40586;
	Thu, 20 Aug 2026 05:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sb6fcmzlndK2; Thu, 20 Aug 2026 05:08:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787202518;
	bh=fRsg1A2WaRBsWpkxrspTWHje3AFUEXkGSHVVNx4k0Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bzD495n4Of2FKKwIwWx4e8mcE5SvtQrmz/pWifrnIvKYYxi47EaAW1zLPwP9RyqB7
	 0px/Ha5fbu4uAOh225F2zKWZb0+kOob8bc7llQnm2EvfZoxP1b7NNCxITK+qHxMEPA
	 i9oKQLebU+CPPIY1s7ST4B1Vo1a2onGS7e7JfTHR8Sv1082piSDdiJlQjOk3JkevSe
	 1ErYlVQpIUwVG8Xhf7LUP9FN6xKrj/D1h7vG389TL/X41Ql/OG+vpsfPRkBy/VFv2G
	 bNs4cx347REtE4wwQvSaeDIZ+ej4MWRBsuP8NznrQwH8JXQ7ATyN9zZR4p0eydM4ox
	 aA75yOyaHs3OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E34AE4057E;
	Thu, 20 Aug 2026 05:08:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 391BF334
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F22D4057E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A39IVb5aepPQ for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 05:08:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lutq/GtR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DbB8uUHR
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FD624054F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL8Ujx1259532
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fRsg1A2WaRBsWpkxrspTWHje3AFUEXkGSHVVNx4k0Ko=; b=Lutq/GtRQKbjiJK7
 rQr6n4/9U23Z19ccf8qrmywFyMQVaRtvo4+ECIkFMY05oZ5Q4amrx44mVB9dpdog
 gqZWB48lFWFjqgklMAOS8g2M2fYoxdfm0PfFenjAtwBzqM3YFub6r5YOBUrWwlp/
 xupO7bv0nvINNBPUHvrUIlIRB1m7liqt5mXlmPelmNMfUg1EkjqC9a8OjnS57RU3
 IiC7Pxcz69cAd1JB8Up1UsbEz1+r102ox2VUvMsJhxkG7+66BHZNzLZEgr6VmqNr
 0ftuGEQu9Rtgeooa7qbVdOZoKm0yBumXgk/IHEqlnARU3iPySzmf+DUvmRSuWIi/
 i2sAZQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es6358e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:08:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so1483373a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787202512; x=1787807312;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fRsg1A2WaRBsWpkxrspTWHje3AFUEXkGSHVVNx4k0Ko=;
 b=DbB8uUHR+dK6gND4qRt8CG7mBxxw3qtRwRdWZrx1JKiRsAFT90vuL+QUkwIS96Y7ay
 5QKvu4qOdigfX2kl24f4lobjVUBn5G6eguBQ0JkVyYUL0xNGt1fFs2Zq1niADzbNuPae
 SnWvbiqCfJ79K3v2VCdPaH99/zSUJIlMVhhm0yg/QKzVDZhLjTa9y588yPzp2iOMvVX7
 +MGe18N3XTV3/UkRqNsqXbECtFDToQdHsFVYW5DyfaXZvZEg0bw0tLqC6z4KrUIrulbK
 ArKbmQItdmZDlYf8R2zOotUiCck0VKQhpYZGwtGiVFON4oGuH/PyoUQBbroifZExO3c+
 zFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787202512; x=1787807312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fRsg1A2WaRBsWpkxrspTWHje3AFUEXkGSHVVNx4k0Ko=;
 b=ZuHdNc6Mmy8BU3QUFZEOT7oVgo3iAp5CmLVFtXhVWM6mtmhVvSrN4boDksFTcr/iEt
 PTzEM664y1ZLjzVEyL8XVu6adsBqLyLu16gnlR4XydXPW7d7jVnq/BW3vxr4fMdl9uF6
 e3p5CE6v4giXY2v+TBd7t/uUE9eL/U5LXvmVOM8/EVTMM8cFM0BR47PmJHtMMNOkTrxr
 EUAiC+Q5z/RfilH6OY2My3mz2ZZKjMIs5+2GMEjCkG19nOV3PmL1ZAVY/Hh1ak0fhzN0
 Ywiy5vvhTN7Pah5LvEUwVVcD5RtRTSB3RdGGSzp2Ec+BzxtNgRCzPYy7MvGKruZLaALJ
 dcUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDlkq3CL418LH4oKQNwNyVOgLRNPJubiztA6A4KDLevUN2uzNOVH3ddh0gvz7DGM7h8lBmGdQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lvsN4Aazrik7riShNYIT/GY3Q+E4H5a0bOiT+aPpXXOJjyKdLM
 NMgJ7b5vyYdDDOYYUfj/N8FSQAqxwhtBL/oGRt0mkSyzTr3b0kNPHGdx3lD7ylsYYe0LKyPDm/V
 6/A6c/j62yEDzxHggU1qI/58ibK7/jwgEkjlr4Hbj8rwc14ubIS+eGtlvNj5ax+0qgCCgrLA=
X-Gm-Gg: AR+sD11UH3ihpj4s37E9iwXZIwiJhycuiwmujfKIQpFn7E9PFR1z8UporRMmu1qPfi8
 6co5U8QY7/LmSII09Zu+O7TuRyqlyPhQ9LV2RFe4DY7aVk6zdWLQ+67P/WEWNhZN/LgqVbnIaGZ
 W6u57Jqyvd+Kr9gWdz6uCY3ATjIH9v6txJohDto7ghc9kgp7pLjW0JKOoc5epFJ4FfvMpFBFDMz
 0JQVsuxmgq6PMgX+ovKRTLKlsyEAPvDJpw6d00x1mZ7qv6gOA9xXvL4Ehs7o/Zja8JM/POcKOqT
 /Jc6LDtsFh2t19pzXlBX0aQkcIlYLamyI3+geXrhxlPGKTwUuL3cBgousjw/rHFt64KYtzSEMBI
 V+lg5GPXGa5dr10hkYf4JiByaGxHKY11/mhl/rAYN9xADEelrme+eN9kEVCq2kIhmVkBRcM6MCP
 pZ+lXmMg7SFNsNhUdAg+f0HiWYwvMQ
X-Received: by 2002:a17:903:3b84:b0:2d5:2f49:b3de with SMTP id
 d9443c01a7336-2d5fd3e78f6mr198326745ad.0.1787202512226; 
 Wed, 19 Aug 2026 22:08:32 -0700 (PDT)
X-Received: by 2002:a17:903:3b84:b0:2d5:2f49:b3de with SMTP id
 d9443c01a7336-2d5fd3e78f6mr198325815ad.0.1787202511719; 
 Wed, 19 Aug 2026 22:08:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf191821sm12012395eec.28.2026.08.19.22.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:08:31 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:38:22 +0530
Subject: [PATCH v2 1/3] clk: qcom: sa8775p: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-clk_gate-v2-1-8cd0059c162b@oss.qualcomm.com>
References: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
In-Reply-To: <20260820-clk_gate-v2-0-8cd0059c162b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787202504; l=3773;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=DrFFJX9r7uQl7StYemRHiRyiLGJFiPmZHbABFoc8JOg=;
 b=Y9eeUSgGwjMd1YD66FftvAjJHP62NHpsOBQ+yNgTF6bHIKYq2DS6m7pOlGesWGL/tobGletkU
 WpzdebaKhqGCiGQp1yFMgF+hpkJik+2oSmZdpz9Uzilf+3siWolLhuN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=E5/9Y6dl c=1 sm=1 tr=0 ts=6a868bd1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tttIFNwfO6LVqVDfAMoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: axXx4YeGFggKW5Ps_nwcChUi6rXTYeYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX6qUWpy77FOLI
 jSGoHfapsqIin2JhXtKwI6ymZXwjQz8zD/Ljx0QIGVSiimKOJYDajsaQ0h6SKTi+XA8/ueHr5pc
 gGgYA93jWuU8WlijWN+e8cKSo6i0/s2iC9I0caBv4Heqk44u2iRty8edH6woPP6Px3mmXdDCR+o
 pKJswRuKKP0mDWG7m7MNfgMCye0x95mjBnbkYsVLAdqStBjWb8U2T2m7Olft/FcqGfl4GyQ+dAj
 RYpHZOJaguvE532GjNDMOFHG2LylI01iRc4kVohVkSiNTB+YDGDTXRwIdsAL/P1Hw/kov6Amc3h
 7ajHS0A882wjLM+9AJcjVk2XEN73qFOAg89qsPOW1GgFRe77fOaXMJ8Bk15V3yR+U2wGyzc6iqF
 16tp85GJDbzQzRgmIrHl6hepNtX8Pl/w9LsJk3jwaGAtMgjX2FHTjRiPFGbuZpVpCLzb1cFJZZT
 +gH6iHC2Dyh2D3cCRWQ==
X-Proofpoint-ORIG-GUID: axXx4YeGFggKW5Ps_nwcChUi6rXTYeYW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzNSBTYWx0ZWRfX9PcbNrmcsZe2
 ybhyeLPzzwCz64OQWvbESrABYRLkoi3qcI3l/f1w3iSqocpp8UQ4yGTa6h6gPYhcAArgiE2IHaf
 sbmtjvjp2exNKpfw4cYgy7AKOkrkbgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200035
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

Convert the USB3 and UFS gate clocks in the sa8775p gate clock table
from GATE_CLK() to GATE_CLK_POLLED(), so their enable status is polled
against the per-clock CBCR register instead of assuming the enable
write completed immediately.

Leave the PHY-sourced clocks unpolled: the USB3 pipe clock and the UFS
TX/RX symbol clocks are driven by the QMP PHY, not GCC, so their CBCR
only clears CLK_OFF once the PHY is up. Polling them at GCC enable time
would time out.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- keep the USB3 pipe and UFS TX/RX symbol clocks as unpolled GATE_CLK;
  their CBCR only clears CLK_OFF after the QMP PHY starts
---
 drivers/clk/qcom/clock-sa8775p.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 7eec4aeae48..5c584c865bf 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -118,14 +118,14 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk sa8775p_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, 1),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, BIT(0), 0x1b088),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, BIT(0), 0x1b018),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0)),
 
 	/* QUP Wrapper 0 clocks */
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x4b008, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
@@ -157,18 +157,18 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
 
 	/* UFS PHY clocks */
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),
-	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, 1),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, 1),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, 1),
-	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, 1),
-	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, 1),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0), 0x830d4),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x83020, BIT(0), 0x83020),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0), 0x83064),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, BIT(0)),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, BIT(0), 0x830a4),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, BIT(0), 0x8306c),
 
 	/* EDP reference clock (used by UFS PHY) */
-	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
+	GATE_CLK_POLLED(GCC_EDP_REF_CLKREF_EN, 0x97448, BIT(0), 0x97448),
 };
 
 static int sa8775p_enable(struct clk *clk)

-- 
2.34.1


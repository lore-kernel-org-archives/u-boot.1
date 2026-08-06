Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D25C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F25ED40789;
	Thu,  6 Aug 2026 16:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vOeMXjbPCZFb; Thu,  6 Aug 2026 16:13:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12AFC4074C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032789;
	bh=FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VAs+cDFXtQ/dSzy1ZisJQGs5lSRTPyrsoFxjkUFDwIBGxXTT9TPxKSNQXLANO+GtB
	 hshbLqQw5e3lricbZ6FZ13gQt9TPzSrGR3abzIBfkMxpjaOwKIe2DdyK0tD7TwKakA
	 Q9ZLBPc2SpUdAcd4muEKJVTc2X6sPSh2HddQzf+hMhyk5RW8GvNNMSHuNtv6IUnw5W
	 uevMXO9H0koizlo1zztNGePf4AtoA3eDEkjVpzwZl5psx0K+63n/e/7tBVUd1kdGXl
	 zeg26oZk4HVYhOtFsJiAQWsrJcSiKCGMj3hU1SKmhKnbXuicZd9asfdTIEJeSNG3LL
	 3OkYUdOxrBHvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12AFC4074C;
	Thu,  6 Aug 2026 16:13:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C27C397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4933D60809
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ULpqZYCzHbFV for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:13:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2CE3B60806
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CE3B60806
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CE3B60806
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:06 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EnfTQ2276944
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:13:06 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvmrjjt8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:13:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b13so2725338a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032785; x=1786637585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=;
 b=UsguG7CduoARZEy9x6z/4MTVRiZfRyRA2eOlN2K5LJaYl0PZrztHoKlahxk03/sps7
 DH3TBFZ6zSWjKv/QvC3hlTi/RMAsRI/GZ/5vYuh1dgiL12LdpfhOir8HcLiKejUpxSlK
 3NEgmrOmtBp/j6MWgUeOdPlcj34S3aFdMejExrC5qXqihmMKSRMekJeS+2QqGPj5nTE9
 bNA8w1LktTIRguSQplVBe+c2CGY6FALzWoCXSYrip7VPJ1eUKwapJRxgR+YqcEfUmzSI
 gFnHdFwN/erRpgerAdJwd/0qdzIdvTvaWLtlj8OYyrPV+V5Kq7qgh8pDu5TIxSTjpSpO
 HnDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1wAqJq7Oi5CHHY/SzvwSLsqiUG8TjVPHTPVo82o3DicboNigFgPbjuyOsF/5t/1objP9/jUs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxd4atwOz5ti8jnUwmWuasvFpPooBibQ9ZX7KxWkRnSaP3s425K
 KV/t1+/PNiB/c3h6IHh/E5+JxobZU7iFCk6Oqwa+KMgSu4u7ZX5fAj1DOIqJzLP20kibe1Ta4G2
 LxC/RRI8ypEd0kDwe6YUpi+EGa8xlvwfnnVPR80iUJ3OvuCjBeTF8o8PFERwk/T2FUcg28Ho=
X-Gm-Gg: AR+sD12zC6Igaqmfhj2Zt1vTZagP+i9xcWzygwx/KHThD9R5X2wGlB7bH3wo1fh2cFr
 scYaX+FrvGtB99ApXrF1KdQJzQZyVqA4HLsgvm4GKnONdjVCEihu1feKB7ObRwg9eNxr8DbwzMk
 y6XGrB5iEMwt06x3dQNXQJzHWhvcr7Qiv5DPsgDsGYdJkv7YWiJR9kSVnLF8v3ibRGqS69HGaYT
 y8ZoJlXYqJN+VeUzqPOeB5L+A0dBl0AH8oRZrqkLU8ddUsIYrbGUBmMqUjpYQ/V0HyBVa5xt5Bk
 qg2Kd8QFuZlwb8BUK5nhFdNYoMwY4+d4rMaejSd02B8vptq1RABSb/Pb15nmERK36WlmOo7z58p
 z5dcsjNcGzZfV/IoTf9VFn73gNN+XUfyfXGoZNg8LjoGDEkMcSFibNqJs2LqqUdidtGHHxPN3BV
 pMlbVGvfyV114vMxxwQpqmoU/9kHaz
X-Received: by 2002:a05:6a21:6014:b0:3c1:85d:fa2f with SMTP id
 adf61e73a8af0-3cb85f4a66dmr21327502637.36.1786032784787; 
 Thu, 06 Aug 2026 09:13:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:6014:b0:3c1:85d:fa2f with SMTP id
 adf61e73a8af0-3cb85f4a66dmr21327430637.36.1786032784346; 
 Thu, 06 Aug 2026 09:13:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:13:03 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:23 +0530
Subject: [PATCH 6/7] arm64: dts: monaco-evk: Force vreg_l8a always-on to
 protect UFS VCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-6-8d7b4e2f4fe1@oss.qualcomm.com>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
In-Reply-To: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=1227;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=FiwIxCY0i/8xVvpAD6Hnjv8hNL6PUsBBG58wx4+CCtg=;
 b=kPEi2hk9p3FQtaU4jJgHXlKouQOPcwkozzo9hMm8GfDiWrk7IcLPA6ZgI68VEu6C4gaYdX0w4
 pTUgwMnK8NzDEE+s0beaL6BCeGkKso6USCS1Y99j+b7wJgnAuR8n7Xk
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VNPtWdPX c=1 sm=1 tr=0 ts=6a74b291 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qScA5Q7lTU9RTaJaGUcA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: -RgINwmYWCJVlJ3s_dgIZzq17JOLn0nP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX7tp8c6gu3SpX
 0cJvkOGP+K4nRu/QVLgcBOmPoOj4J9PGUDiSTWZfVuUMd5oXZe0wHeeaixSLExsC9FDmUkKcnng
 Rh2gFcum7CPckT353Z8qkpGhZ3ntdb4=
X-Proofpoint-GUID: -RgINwmYWCJVlJ3s_dgIZzq17JOLn0nP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX2s/SGriSQpET
 gp6mGw84nSbu9Sx+yD6uxmLYPKtxVsKrAbq+jnVQvlXnVjCEl00vrV32DT9AaM8DTEnolS+Jxvi
 x1m0R7n7NeubVK91JgRXV1JnDRxICMyRtsXG5ismi/6gz2gstKnjCtzYorBJd1ZYvdCWL22g8MJ
 fL18/Fd7gcLWG1SpM9EUAK3GRg+rWG5Xt4JZ/AbGpZKB8xSSjTGtA4AfmOYi6znDmSzSWfBco4R
 0azxIlGxOVCdp/cQvcPyqBvBs/sRaqe5NBiKATJANFjMD6hV0QLNG6hc1WbEf5nUjJPHJsQ99HX
 LGb19t3Vf0LSvLZPB8ZAHZyYr9pL1MgIZWWA+Afi45WmbysjPB8a2+3OyTP1TbKrAX9arQJTbHn
 WVylhGT5xMSNe8n8O5lSxn/2oEINXruZRAbCb5D4+G+Em60eP2wrBTF3t3QZB0P2EorxV7K7nbN
 UyrO3paKjKIo1xpFMpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=; b=I1k1WT9pzt8W5wWT
 KeUQ73DPUmeOfbn+bDUXEAGRgKyhPPAK0+FPCIAS4Yx1n1/4NyrRPCfeLDx0n7nq
 +FwCukzqH4TEORNMWx9iMENpJLmSWbMX/7ThRQhqSh5fSk6XjL/lY0UwjiDIVuxe
 aaDQuX7U2MRmz0OAUX0JW9FHTTEF8K8FM20PwHyxRjsyg3P5uEzgC4Ua51BUVCx3
 YoNNquivQfj3p2XvQsVYjujH1FSHqtCRpL7Q9PtMNirmCv0tVnk1C6qISMN5f8bM
 XRtm/x1GlyEYDBTxcBvPPfLiCJJUAxRahw0TiGOicApqLrddmG7CT7qwScGaTiNM
 yrX90w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032785; x=1786637585;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=;
 b=fepdrdfWgLvdRUmSN2MP17QcVG78pwiXi8F4SmfCqvjHGX52b1B8mIXTtmxTTe7QQz
 R2OZ8u2vp4T5+h4IXYSeq3ZpzNh7YzhBq4NbNqwSmN0fSwGmA2RlG4xTaAPqPTnO0Ena
 9x6wGUMkMPATsjuaELrQJc0M0aMzcp6Y3gfEs/6T8ygxVIfwnSs2mQeKR7sYel7QPAEF
 iJkghc3WJMOJfxECu7zBMCTEr5N2sVzVtjwQ5OSD99HJ7XUe8WnQmg7Qta1tJEUJ1m3u
 XJuXucG2y4Mv8vaLZ44bfg8NR89LbNysuqZsM47VMXvaeY4snjCCvmY3xL7yqBDTx7VR
 tpvg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=I1k1WT9p; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fepdrdfW
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

vreg_l8a is the shared VCC rail for UFS (ufs_mem_hc vcc-supply) and
eMMC (sdhc_1 vmmc-supply). UFS holds no regulator vote of its own in
U-Boot, so nothing stops other consumers from disabling the rail
while UFS still needs it.

eMMC's power-cycle runs after UFS has already linked up and started
transferring data. Its power-off fires a real disable vote on
vreg_l8a, glitching UFS VCC while the link is live. UFS has no
recovery from this: every following command fails (OCS errors, UTP
timeouts, "Card did not respond to voltage select! : -110").

Force the rail always-on so the disable vote is rejected in
regulator_set_enable() (-EACCES) before it reaches the RPMh driver.
eMMC is non-removable and does not need a real power-cycle.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/monaco-evk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
index 5520d111864..8e9102eae4d 100644
--- a/arch/arm/dts/monaco-evk-u-boot.dtsi
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -34,3 +34,7 @@
 		};
 	};
 };
+
+&vreg_l8a {
+	regulator-always-on;
+};

-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD236D1269D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC4283F54;
	Wed,  3 Dec 2025 12:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4ZCF9FF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HiWMFh2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B0983F54; Wed,  3 Dec 2025 12:08:03 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D2F283F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B38C1JZ404807
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=H2acQWqQRWw
 MKskJz7jZwj8dE7OXlMN69vgeZGkXVZI=; b=m4ZCF9FFrVHpAKQPccCC5tdCmQF
 8EH5Od57o0Dm0mp72NcN68qOFQYfTfxvqqLNunProQOf/0iKA7YzOFPMd6XVPG/D
 2Ggz78mvSVo+hVtm6hQEy6duj8W9msu9WMASQCcD2JG6fIBonIakvUaUxMD/GhBI
 HeyDSlny5GMFjQPkCXUmZaxx/moHH2BV2ti1MwMzgsfogwygkw425ZmN5wGInjQ/
 ineycvCUt21yHYd3trbqGVblLwpqRcSit4eGnuikge56G4+0fODv55VMvnLkaU2e
 RPW6P7exjvM9TXfBtqc2eXUSiVf9irs0jgEoZk51hc22J72g1aHmJXl0ErQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at9fca1c0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:07:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29b760316a8so76752515ad.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760075; x=1765364875; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H2acQWqQRWwMKskJz7jZwj8dE7OXlMN69vgeZGkXVZI=;
 b=HiWMFh2NHBnnGn4xa7hu4MWBAXLBfzQprLu0kYpYZ1tNJpBwLuQ/A6EHjjWIK470/w
 pnfGxm28Hazo6qssxvzEKgnzP/bj8oAYM6uHefE8ng8JkizwYqYPbd2i7lXG2UM05WU3
 4mMEisT3Bs3kOkC/jpk6wkghxRfvqVbotgU0qfD0XEkTGxowkq9MsQXNN0OQblT2dTsT
 i9ZaUa6WOC3zjpDIGd5ayp4FFIgHi7Mng8ODWVgBfBEp6oSNpO1fKE6JDr11IGasCaWC
 0b5DBdwRKVnXwj712r+Nt+d/dLk0RL9pZW/z5EnjNWG7ZSwFj1t79DmraQvXmS37JlNm
 Cykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760075; x=1765364875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H2acQWqQRWwMKskJz7jZwj8dE7OXlMN69vgeZGkXVZI=;
 b=FaA3KIIrL2+yMQ9JmD0QVpdWVwrgPmjfnCkPaqGSLdAhPsNhGeGrf6OHgCrMZwnTPN
 ySvD4MsBJmS83LiZjm5nyRxvC/In3RlK9sfxE5GSfH6lEH9HZqBjENv2H6xfjYedQb1i
 x+DiWE7q7JzksRKp4qvQLYEGzfsZZec2sE2uX7YV9KRew++FjGHtyKqeI6X6QZ9FSvaB
 oom7CcIF3iYlE4ndMqec82xWtgmxbB8rvlpdFhGC/VDdTjfoP+qI5q/bACa9VH1xdgqf
 j2c+pvFsYI3DdW+yUQ/L9cMYjt9pD9YFvrbakeImBDqyCGji8WHrorfaMSqdo8mTiDKz
 zrRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWppb12ys9Eb9Vv+kSLsrFZ0LP/pbKsZCwnyANNpZlTX+aXJqXpvWFIdfcgK9zZ7N2zWT1Zb/I=@lists.denx.de
X-Gm-Message-State: AOJu0YwLSZeapFvEmW9/7zFXND3ctYFuugfjbHX9LiWq2m3yajMkEFH6
 TBAaDgYpGFxjHRuTPvXndk2E+Ziw3PtWuLJudGAAFKjNGRW5+3b7TDL+tpfYdZMXBtZRFjhTMtb
 0G0uSqEU7srva+vKPvoRLuj1DqJiDN4e73Io59cUrwWV5hb1m6GKqNKFg
X-Gm-Gg: ASbGncvX7dDWd93fDG3g27alllo9uRdJrTFN1Vvx+dsOoH4PQkdC8ciC+aOnW5TvhTw
 zq1DWoYsgoydBUbXIJx4IuRSrLo8PZcCIiZP7Mr84/w9IC4xxW3YBOoTx6Km44j7ZdrogYD3IVS
 rYmvRjje/EZGHGmCVO9OUyWjYWnAqCbK4FVObppGD8kGtHh+KbsH/ddDZW4LDhHQLC9JhFSt2ue
 C8nzlgIrxC2xlTy6gD37Jq+Kl19bV3I+T2uoC31IYHBc0r22hFQ92cKlOS/PuUaKd3O5viGZ6Jk
 jGxZsitAztT9br86AMaNUbREeIW38fWs2q2Z4VogQOz8dv/K/26AmHVzszyyIdgNY7rKXPur1pp
 yaLtfi7LGQIFcVawFGHRcZkMUq10XP4W0neuhktyPrLpD7ChP6f7HlQTsqbxjjbnS8+twNs4NLF
 mT0DuwzlL5Ekch+1gXe3ro5bGDaktIE6Bd82Hytg==
X-Received: by 2002:a17:903:1209:b0:296:3f23:b909 with SMTP id
 d9443c01a7336-29d68401104mr25843045ad.39.1764760074608; 
 Wed, 03 Dec 2025 03:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGAWnEMjC2vQCJneycubnsv2Vi0PrFgJRs+axk09dLHd7RU5RfcWg/wbHMYylBezDTFEVu4g==
X-Received: by 2002:a17:903:1209:b0:296:3f23:b909 with SMTP id
 d9443c01a7336-29d68401104mr25842535ad.39.1764760074094; 
 Wed, 03 Dec 2025 03:07:54 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29d7b6ba774sm10132925ad.83.2025.12.03.03.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 03:07:53 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 1/6] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
Date: Wed,  3 Dec 2025 16:37:30 +0530
Message-Id: <20251203110735.1959862-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4OCBTYWx0ZWRfX3XDo/L6PWUW0
 S7pwSjtJIcjP6NE3964bmxkMAQLmnitpQNffJnGehnr5PqE7YOIgAyNW3QbkaLPRrs+cmn6dHht
 gHqcLaVxP3IQW7+Q3k4TPdfIIqjO54mpxQ3CGk9UhbWdfaLk1bXhZDkTLnD48aWRrQVCOEyYxBI
 GtCeGpruSnDF5MiJNebdAazsWq/tEZVC57Kz6gtPAtKo8qTyJnNreXElNXMJEJ+U9AD3qwBJzzU
 dZganuHXo/tzYw08GQlhRdp5kg6G4UmCBl61V2zaGwxS5rnHvLJNrIPBFSuEhTXXL4DoASJg+Hc
 Lnan5zX1643T0ZA+Mc6AzsjBj27uD/mJhghwly58uxeJmUxViesSQMNAq5g7/P2gwBWyJunuL0i
 ULlzCo7MHOr2bZyeqK74mmi/HMDhdQ==
X-Authority-Analysis: v=2.4 cv=Qblrf8bv c=1 sm=1 tr=0 ts=69301a0b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3vLCiLSuDpT7xIXx67cA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VD26-i_0EQUquCKXrQJT2rqZsi6P_fqy
X-Proofpoint-ORIG-GUID: VD26-i_0EQUquCKXrQJT2rqZsi6P_fqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030088
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 55a233df394..a2af73cd976 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -111,6 +111,7 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
 	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
 	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
 	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
-- 
2.34.1


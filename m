Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78B606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tgPBM53k;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JDu5BlAP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YsWP7lCd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1445640A3A;
	Fri, 27 Nov 2026 06:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3ZEu48MgLaH; Fri, 27 Nov 2026 06:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 56F2940A16
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795760298;
	b=Hmict8xlf2ebUhjhxy7LIHtNGWf4ql6JwA4+Rs73ZGl2V2sEF4G/oG0T3DgQ48VLXOGm
	 rRffLaQz4G2tMNtLmilGKzFsD6FVISKW0kUT4hvTOuiIs/KLipV9owdSF2Vc318z8UbN5
	 +z3yj+CkvuihmqqMU79/Q0STHo7WVPEbuBwJxDB0hSK+q9fopfFwMkBbhi7UKXJTjOrdd
	 5d4V1L/MM470je4DaNPSJqwtdNr53+r+o/kaWm13TWxra+WrTYkqw0zttmKYMWinBegqr
	 UTAWMAjrfsd9OPnM91Gzp8DLKrbQlwsAKatVIq0p/4W5/1D1VCrw/5HjW8YTHsvmV3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795760298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5np/4IeB6d+UQzdYMa472aldZvSssabg+YG5kSBiqq0=;
	b=aGg3tlvBaFZuK2tnzky5/LVpf+6gMUW88J+Igs4mXP/+adhyvJmMfEpOa+qgpiU05m5P
	 I/eXjTh/cQ5PLZJ7TT1S8AF2T/Zfq+TKKa6uNxQ+t5QrFXnfg/i7PbGjQDeu83mdTfd1c
	 cVT5TrNAo9e7ErKvfAv1OLg4sID57tr5DT2YbiV2mfY+DaDqo0aMroytFjs34/H6oPJCc
	 LgQKJupYGGT3FMHX76lmmZcRDIu5MG7j1vNXr1sIl07rTfeiP3RrFE5MexbmC5BIxhr2w
	 mMH2zli1GMUZUB9bDKQiRYrvagLmY5okACtvc3n6CZZ6Sm0urMUO1xtZ5S5v+RZVuVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795760298;
	bh=5np/4IeB6d+UQzdYMa472aldZvSssabg+YG5kSBiqq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tgPBM53kiIaOVsW1w+mwqam4cuxPa1Grbp0IqMoJJ43U71N1sprVBPGoWeV3/wqLS
	 MpOdrkZgy69gzeQv2Iycw14l1ROl3jmXPqbDiF9xQ1vwRUpCrjoxtruDrXGUhQyD0U
	 qkgKaSHZ51Npa28ZMmOB9SnpOpYyOpoM6698eH6dSmqTMKm2rSo2MYsn8CTexeZ8xo
	 QE1KYVe5snpcRaINoW9d2Cq9vaP310dreKBCagaPyIQe6kTT1ZnXe1mUO4YZJtMFBf
	 WFamZsOnAuQ9mk3Ha8MA2P5Yo20RpizK40CYsc75x6pTQ/QbNWNgLxA+/+RZ2OVIdX
	 6YfVF39bL1SzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56F2940A16;
	Fri, 27 Nov 2026 06:18:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9702D3D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DA2260A67
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcYe-Aql14LY for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B51360A4E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JDu5BlAP; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YsWP7lCd
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B51360A4E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:18:15 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw7PK781856
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5np/4IeB6d+UQzdYMa472ald
 ZvSssabg+YG5kSBiqq0=; b=JDu5BlAPg0jj1DNPweR3BHyJmwpHgswgcE08wNRR
 M9C931ijPf1bwhvJcFS284NJcU0xYYGx5nDpN8tFJL17t34xMjPuvqw8sn8DUNSi
 DdAZttHqpf2LsoRrR8KZyeJJ5YvuRI4blQhvz1qNYdFLacYyjebpGLK8LWkSmaYB
 DXdaK09cHrUV37fVPIxzKFIb4ICrUYdub84qT2y5JnevhUlmBfotpCvwBDyhK8t6
 X9x/wm21IQMaiLkLhT2mQVFMsAvq5v5RLMf8z54QZTV8gN/vNa4xwFpMyxifw/FZ
 sXfoMgKRXsovsIHBsI1S1iLB5b+rq4YTminz8moJfxitdw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm83kh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:18:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386177b0516so19453828eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795760294; x=1796365094;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5np/4IeB6d+UQzdYMa472aldZvSssabg+YG5kSBiqq0=;
 b=YsWP7lCdhMKa1IJ4fB0Nzyiu8eG0SmyPUJbb/itLX2AioW+4H6GK/P0NtEzvpYw0Bw
 sxo2sFrwhUiIL7rjZIrkDfhoxLJ4Ucq0e4ePA3+E2hXIsPuBL3ARAni0fbGmqPwNHzGb
 fObLTySLyWgS+aUeJvQPaTsoh1iduE+frJZ5seZgythnMrSDMNNY1FHijnFGAagT7ytP
 XB58OaAN2fKx0rZ+nBSLvobTsLb9Wgz00+Vjj77anupKpdWSq6g4q5ZqHAt6XhKWaTdX
 XIl9eVl4wlqOMlfPlPRjqilMBQqdpo53sxkOSqXaHMNBewKCF07YkwDXyt69dXNfGS0O
 reLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795760294; x=1796365094;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5np/4IeB6d+UQzdYMa472aldZvSssabg+YG5kSBiqq0=;
 b=AUTIenB2cOHWCsVxhdkrt8CJ0bswzMNLs0r2JqVQlRt22nvcgDEdV4/LLS0DwtQIpv
 xUWaOh69jadpf6aEmApRg+/JxAVAXu4rMmo3dy0Z2Sc8GAxd81ztRqLvCQ58bvv6qVgU
 aFAXvFSA4xiyVfk+CkFz69Kic40ZKcEfVRis7JN/3FBt6V4aZ73+md61081QmMRRvg8T
 9TE96830oYz/G2VsUT18NDS1EcHbmxA06wp6XanHElQRaLRoQxPP6hO98lMYD3dmTqbe
 3OTPHuyPV3ufA/yOLkWduK4oGHmUKq5RkX2hLSBMbqB+8bCw43hxe5qh7EPKYtzYqHSS
 H6AQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHGfhyF1BRCWogOT6A3X7ZHKXkWIedyN/IABP5WSSnGC2IMAzXC4KwrVztHQWX/ggiDjncjFhk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8vCCmGFFKWBo6dOLqUk/c22dAV4gtagN5ceAWqLhTMUrgmOftB
 XFtD0msR/+pzw3/hBYksi+LaAuBYvKuVo3LdtnuCen1jzumkxNtZJ9zepYuyYbjKiTMmfC0B98m
 TMguFc4R9bKV3HYm4u2zGNbA15vBxilYrFYw/gcRlf3F7o2bKKhFYPO5KVdOFLm0Pk0SvdeE=
X-Gm-Gg: AZFdTZffRm9OOGpzrw5Bto6ER8Rx3B8ZcJrZxQdSIIVXsMq3xam+NpLj8bVVd7wPUtX
 UXDBBdgezYTZouLuMkrKP0ktwLOVfx5mWqi1YfwwV+Tyw+gL3000Vf8zFto9IyUi62s8SuWBLM5
 AfFU4qRSz7bhaWIgS10+pPNM6coCXdGZAaIyQuABUE5nzJmVIZkg2pecKKNO/RVzqEWWIBTyHQl
 274uDh0R4moRNHZdgoIMxfUODO0UQMB8fS9yWpavlWsdhadNjdom/PxdIFI/AKMzkw/jRthXC19
 DujMwNpr8bdsycYm4UzOLWTg17psgRMP9nNeatgVCfpU3w4/DHUkIKyGwVSiTDJR33zAwuRkBI8
 BDrwOaMh/w5KdYQj+gJoEW0Jrt1d1dbtBwvijKQiCRQpqfYbO0wJcr8mT3HEMUw4TNcbGjEboA7
 V6SOGA/mEZs8DrB/IcQSOGhkMvWrWqUoHyE6PsD1CefWoz/q2phmqg2c8EwpHlH+YhHEhDcA029
 3Gcfd4=
X-Received: by 2002:a05:7301:1402:b0:386:119b:731c with SMTP id
 5a478bee46e88-386119b9d83mr26001376eec.35.1795760294156; 
 Thu, 26 Nov 2026 22:18:14 -0800 (PST)
X-Received: by 2002:a05:7301:1402:b0:386:119b:731c with SMTP id
 5a478bee46e88-386119b9d83mr26001355eec.35.1795760293703; 
 Thu, 26 Nov 2026 22:18:13 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm83584925eec.5.2026.11.26.22.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:18:13 -0800 (PST)
Date: Fri, 27 Nov 2026 11:48:06 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] qcom: ipq9574: use the eMMC RDP433 devicetree for the
 MMC defconfig
Message-ID: <awkgnlkhNISCypFT@hu-varada-blr.qualcomm.com>
References: <20261127-ipq-emmc-v1-1-091bd9e53665@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-ipq-emmc-v1-1-091bd9e53665@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Ln964Ju9_Ybg_SB-fSoFzlP61N09EYWx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAyNCBTYWx0ZWRfX01YGTJa0ACHg
 I53wTCLG7B7lmOjcoF0DdxO+wBd4+UvOGkAc9+/9OyVztCZ80rqMuAi0BiD2vV/cden+SX48ECG
 D4DUsFdcX7eZGq3xFrpGCsKMEv1KuzQ=
X-Proofpoint-GUID: Ln964Ju9_Ybg_SB-fSoFzlP61N09EYWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAyNCBTYWx0ZWRfXx/bsjbhZYLyY
 Ke5T73DgJ5NkkJl35M+qqTq18KosG0fPkNyOtnMwYOGDddDBGQks7PssuNyfJz0Es3AodaeuzEW
 wNbVSvYcPysf0pOZInf72JaRxSiICnQ3CcSEeW/zgkbJ2JU8ITd/7sbjjS3JxGUWnZPxp+k9Ya5
 My0P1YVOxkf/QxDTEvSCvNIZMLET76y6+XSL90M0KMFm2x8XwWyxZJk23I2RVesKK6Tqs9QVFw1
 74jll8oy6PfHU2Q/wUT42/qjFxp4Bpn1Ql2PU8E2LU49B2ua6+QMuEqRwGSja6CYoXnp8tn+XIv
 wZ2a3G5R4t/uPo81E5zR/cEJnXQHPRtwT/rEk6yd4tqdhy0QWrYY0QNqBmRzMZgy8+OF+6Yrp4X
 46MqNNRiB6Ma6DHglIG4G5oRrZytHmzfLevOs/Be/1vivhtXN7FQ0eQuWf7TzFE2sOD3cKqF9OY
 jNvuaNx5dFPZ/vvcSGw==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b0920a7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=C1593we_xT_bfEv0ZEEA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 11:45:16AM +0530, Vandhiadevan Karunamoorthy wrote:
> qcom_ipq9574_mmc_defconfig builds the NAND variant of RDP433
> (ipq9574-rdp433), where the sdhc_1 node stays disabled, so the eMMC
> controller is never probed. Use the eMMC variant (ipq9574-rdp433-emmc),
> which enables sdhc_1, and rename the board u-boot.dtsi to match.
>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB063606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QBLHgCHp;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B0B2W7FU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ilg+mQBq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5C0840804;
	Wed,  4 Nov 2026 16:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsjWcBhSjc9u; Wed,  4 Nov 2026 16:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A9E040430
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810104;
	b=eZxcT6DXV8ucT87dcq0Rv0j/cv8mMx5ohkX2mHxfkig8qL83JSD3zGmGVgVZvq/Y1/h9
	 W5psizWcHpVYZZCyaKR/IxdGmqEzBkGueFlUNw+n5R3HAF6n1pGyo6RCmX6vRW/vPKAUe
	 qLfW3OKP8O40Q1aemId0nRkCcgju456/uKF0aCEG3mUMV4njUsZtvoBpC6BPRtZOt2lAM
	 xWeyxLndIC5wSS5ln8wcLlHHLDkwreFl5SzTVzQqEKJhWh0E6kHvWrpn5Sw8ZCnYlWIZb
	 i0xEAjqWKnStT5QaNg0THoZV3j8vQOkdWfnWezRMzLj7Tm+lVTt54pXlm11YA6kVaEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dL6m9cWSdYUubo17kO9L9Xijh80M8cfhcRwJiliJXLA=;
	b=hu+Vt9pm5eJD03qPUNHBZpKM4OeDF9m2hOeIZFEr+2XBoiWiSi9H1hfaQXtMG72A4uZj
	 LrTvnGotpxtBf0aCAN4VaV+bHdlV0icl3zbWgHrRdjnPwdOwIz0aAu6JdwiJoYWrCF3D5
	 QoyCQIcZoC7xZfeaSZup7talUPx2L2JWd2XGljVDpwAqkPMBg3s7zTyrp7+vVjN//LlNZ
	 sTtB6mfokKdq4QVmV4NYjthfb5cAZf0AI2dTYRfobIjUPNKjZNLTA1Y8JxA3kFh6oH0+L
	 I0DxQuOyw3jPM+lDALGQY41AWvFQqW2WJHdNnBUanY4ESdvDG5Q/TSbeU+7FvLBfLxA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810104;
	bh=dL6m9cWSdYUubo17kO9L9Xijh80M8cfhcRwJiliJXLA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QBLHgCHpreo5BnZbn5LdyQ8UC6ubHYPSuUj5XDOvpEh49LdR6e7OzNh2fL/LU+YKK
	 xKtBZx0apGPRKp4Z2/ksufRQ/oZTAev+5x4S71wGI6snbXAwDluVvxdg7TuOWEGjbI
	 rc/OFugQvmtNPUwZu+bbyWvoc/XEEBGjYMgODLlKjI+yP2lsQvDlpI9c6eqdDUIrlE
	 XNFJEVM/XqIBdAn/pgcYFRRGYSmXHtXScRkZmHWMTypdz4DFy8AiwvKVnsDGsEpYtH
	 nMfiEmWu+A0dzVRJZw/a6Icg1qNwVblzxzSp18oP7u7W1PvSlCWE4f9EWsEL0uZ+R0
	 r7BbzynjJsJnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A9E040430;
	Wed,  4 Nov 2026 16:35:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D513165
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E2C080C95
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JyLPu37bPvt for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D31F580C5C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=B0B2W7FU; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ilg+mQBq
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D31F580C5C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:34:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjAbv1899551
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dL6m9cWSdYU
 ubo17kO9L9Xijh80M8cfhcRwJiliJXLA=; b=B0B2W7FUmYG7SUQtbmYKzNmOqFp
 rThDN8UMlXxG10mtFzPhgAs+FS8ncKl/qAyGr4pOFnRWL8xo7r8SBlwC2LG1wBMQ
 qBTNienrOznyq6boDbVnT2b1ruUuIkNM6fQesFtdLNlTNB3O7ypMn8xm1kpUB4Qn
 DnwRUMNRcXc1kOYuUytpgmuyBSTOZmbc9BD2IkxXZSh/TP8bOrFsJ2XW2Eu1T6bf
 ob9hUmIHNV3oOfUx1LMLQVsfPfWRM4Or0c3NGluUgZdQ8yRaAfml5aWvnBErgc1Q
 Uqb3nhvNDKVjp7vhTUiMZ2qxL1mZnS8Rko68BdRRQjZkLvPb12Gh48t7L5Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsgb2a6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:34:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3662e7a9299so3093107eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810097; x=1794414897;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dL6m9cWSdYUubo17kO9L9Xijh80M8cfhcRwJiliJXLA=;
 b=Ilg+mQBqjdMsdqifbZardifU8ZR038h0iP+Zr/Dh+RaJjdopvQ2gqomxg5UiBL3LOw
 GJWFdtuOOISlP7UTYOEH+TPrpFBvY+JlduCJodNayonEg8etfoqoVCjum1le9oDtSSUe
 aE8PoJvZpTQUe+Ed4vl0UIy1sliAsXkQ+RXIW1YSl3+gCjRYfG0DhRachwSZdaPoJ2qa
 7yKeZzBBIuI9rt+SHwdNQbaAzL9r7+S8W2SWGjzDVnrEKDh2r/BXyBy4+2W887xDRx4u
 l0zhfhcMgSUL7yQbw86enP+yyZFxz/08u6OhNSikV0voP+p1HEuTZwBnIPjqXHNiyMxP
 4uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810097; x=1794414897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dL6m9cWSdYUubo17kO9L9Xijh80M8cfhcRwJiliJXLA=;
 b=YYM9Qo8yCIFeNmEkJ8Q9TqvT/m2mbVE7F41uD2RVxEnMGdPuCc5x7A03+Ph06qgl5I
 pSLhlJhuuzT+26WT8ROwFeCzxwbS/xqnWaEybpTsM9KkOHlzcF+b614pZcD6REN3kA7L
 xqyrJ4bzpjODeTVhDYmwPyGpy4Un71mRXtXBV84jiCrDl9DWD3rIOArEDTYATHqbKpk3
 T27pOuf4epGOGWdad6Ktp3egh9dBuTpZ3JwHSV+Naqayo5CoU2l3Yff9xifBmnWPx05L
 Ep8bG8YVR8N3O5JPpKqKKw1jToG3m2W77sRlp5/YfgFvqrE8UZb2UyDj7DDeGS4SIv71
 OEuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMKEQwGUm/s0E8Us4nMVoEzYtccyogU+iMWgepzOYOvFV1Q3t5G1IO3RdiiJgtSOSIiJ9nL2g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/86tU/Lf3Lm1Nrsv7/WDQvorHhKoAGqd0IVOqkhLZG8fmRBOsd
 Q+Zr1Vs9Jgy9NBwHKoD5FFtXPpIXUMQt9mIWHanDvPcClw5LR741t1omv41FK/LOQSgEPdjwtF2
 DOCfWteHdvfs9yZ0X9L0rmRopfooTkugJRAPgY9IMmKlCvoIpF4P2v7HLtCkQSwANB1v0FeQ=
X-Gm-Gg: AYBFou2Rprfr8umlyAfY7XGgAfAzlUjo6GNmzdreIbdrJjr9Zz+GRGLd3vXbFMwVFt+
 mCG7RMR7Kze60sA70VuLbtdxgwNo4rSk18eMsJWhozXtMNFxut3SRIrcOjOJP6PvDtatR17MOSg
 KOMsRyIje5KZGE+LSUbcGAe0wq9kweon5TgnOxuQS6h4aGN5BYiS0uJpXDfqy0P/F6xMDBqB+h/
 XfY0UgW6gBtX1l7UnJYqTI/VfwZrWWtlq4YOUNRiCbdZPgXJbHAtGu7IKm8LWq9RMlbWrjs5afI
 nGgsEJ36AFenIYfkPl98u/lLFXG37U2Flz9Cw675kPNB0qRwISG3MQlNNrW5/8+K+ZnxuNWN6cx
 95s3UoI0RL0gZFDvGGiuwldFw/e5WtvzBikbA/MMAjqSkAOeL97MflBfrtJ9VrPO+oFhOd3a2tJ
 l0g5Xvl+oZF2LqlyKMN8DNPqhNYzElrCSGViCtBmOHD7vgOd/s1UvPhv2trBWHwhwt
X-Received: by 2002:a05:7300:8414:b0:36a:1489:fdf6 with SMTP id
 5a478bee46e88-36a42340d44mr25871784eec.11.1793810096717; 
 Wed, 04 Nov 2026 08:34:56 -0800 (PST)
X-Received: by 2002:a05:7300:8414:b0:36a:1489:fdf6 with SMTP id
 5a478bee46e88-36a42340d44mr25871749eec.11.1793810096208; 
 Wed, 04 Nov 2026 08:34:56 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:55 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 4/9] clk: qcom: sc7280: add GCC_PCIE_1_PIPE_CLK_SRC no-op
 gate
Date: Wed,  4 Nov 2026 22:03:53 +0530
Message-ID: <20261104163408.1250410-5-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb5eb1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=yq4TnKOIrOLqUJQRoD8A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Qo-DBYhvDChI56mTkxW0h7_Ei7mPHSRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX6wG39Y+mWX+c
 ILZmP/gV7sq2Gz7E6z0cf64QO9AgvjnWJHGIwIOjIE4JJFMCjO+s9wMeZMTk4EjVAGyuF499cfH
 YMfoUnZxa5zBR3Y3zBV1yiPwAnta48nyr8cyex5v0ayS5H49WStuw1NsoXbiA3TD57LXUHnpdt0
 VnovPjjDny95LKOy+atDrURhrBM77rwqbhytXBJUbKAC+7WrVzNymSTxNaE8ZIYQtLLGrJTPZHg
 frZ1L8LrqAZpzVy8vDhrIPb5Q347MujotzFUPRevbsOEYilwWdjH4nRNi393PhEADKmkksMm0/e
 0evb5E21cIV7T+cnZUKWMSu2bas2endUiMSGXtSmZGyuP7Gjm7iGDN9ZdHERtDSzUxeK2YA0EPF
 1eHrOsLo/OtJZSNmOoNb2AXQ/iTal81+M3B+YPwxLUXEVn7CKYh/H5GsiF5OhYE9wLdzDRIJqEr
 Fw//XlKC6LIjn8VPEUA==
X-Proofpoint-GUID: Qo-DBYhvDChI56mTkxW0h7_Ei7mPHSRr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX60m6cdvzW3wS
 +UZ/3+964ACJt7K9cpQp6DrfskUggpC8LOmIaVe7L++yxOEbFiG4EvufmKOojGZXxfDpkJ28i/g
 XxV7hRbbx6srC9qaFSQLA+lCWCNgyeA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040065
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

GCC_PCIE_1_PIPE_CLK_SRC (ID 56) has no gate entry, so
clk_get_bulk()/clk_enable_bulk() fail with "unknown clock ID 56"
for any consumer listing it in "clocks".

The mux it represents is actually configured by
clk_phy_mux_enable() as a side effect of enabling
GCC_PCIE_1_PIPE_CLK, so register it as a no-op gate.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sc7280.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index eddeecfd9b7..fb2a017674f 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -206,6 +206,11 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK_POLLED(GCC_PCIE_CLKREF_EN, 0x8c004, BIT(0), 0x8c004),
 
 	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x52000, BIT(30)),
+	/*
+	 * No-op gate: actual mux config is done by clk_phy_mux_enable()
+	 * when GCC_PCIE_1_PIPE_CLK is enabled.
+	 */
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK_SRC, PCIE_1_PIPE_CLK_PHY_MUX, 0),
 	GATE_CLK(GCC_PCIE_1_AUX_CLK, 0x52000, BIT(29)),
 	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK, 0x52000, BIT(28)),
 	GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK, 0x52000, BIT(27)),
-- 
2.55.0


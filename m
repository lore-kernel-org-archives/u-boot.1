Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6B606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wd2XkJuD;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRHVIg/4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WWNK5E8O
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1675580CFE;
	Fri,  6 Nov 2026 07:02:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bj12XFld8WHL; Fri,  6 Nov 2026 07:02:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3240880DEA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793948537;
	b=f0H+eGYAypFNjlJC480jDU3e+KFifohKH76N8yzSmu9xOuZeEryvZUbR2OJiF6ZFFeET
	 B9AqjYj7yfEDUFKTXQHz+zABbOmwcdO1yQbmLSf9yOxTux/LqTbK7gjQRq0ymzwqeQfRJ
	 41j5pW9dE5M1vV00eKN+rEhHm/fn+PsVUuv357z7V8wEJ0Wsi4kTQ4tPrgX6qqc7uo9vL
	 XSei650nEo7kjYlURyAgWuvv1AI8bsTeP5WqBvSYTMzShtV7K8fA+lJa/FWbdRXblAs2L
	 bIOgK09OD6XT8DDyNncuJy7tiI+5qMt6hLByvAKl4nN2WT5+usu34JVUKxPCWzacsvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793948537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H+25Ms7KhdPYWbROgILSb4+qQTy3pUSs4oZ9oA5bUpA=;
	b=PhumS/rhJ+Y5s9pJA8WOIpynpJP3aZbEx3HSBZ7fPeM+JqzmSq9BEpjUNqszLam/IBQL
	 mar26pUK55CYSSqYcVmdY1Zm8UZ9daAnh9n3FpZqop+T2n1ZL6cFCMNzFSLTe5o+69NWH
	 0XLql2NVEGggLsBklgrLujfGHSSgFTkpZACceTR+lfDtOs7clkfjUX0FxB/11LPJQgNz7
	 GLvuSzYe8LI5k2i5aCtrPeB+fds2hfu4GvWaj7U3C1Be9987qIYCH8UToOzqyBSnnJSdA
	 gJTDuFqeVw4RikU6Tvg/d8L2xHXeUwQ09rSEobJAYA+93//F62CswxOExdaq9IsO12Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793948537;
	bh=H+25Ms7KhdPYWbROgILSb4+qQTy3pUSs4oZ9oA5bUpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wd2XkJuDQRzoBCEw12Jph4HMTTJf/ZbkVpKEM7fYPXJwD//A8eG5nfQQ5IzA+4Ktq
	 OMItSRra/pSyqnu1PvEogUwFdUrQwvd0zLToCN0p5s0JpYO+8/I+zfxRnu1V7wC7xW
	 nPfaQD17nGhuNmpC0AviSiZn7iV2JqomP0Z5hXZywSAqbzReA5VlyR6Zj1RalNqQAz
	 6gTKbSlVMKMsHFdMfdP99RFzLt0nHqE1iLTuoCnKN91vEwHhEU/CPKcWOSwmmH4y8K
	 lteAiUk+zKAuslkrKAbG5JwuoRpNdVF2oJ9SlLhFAN88vYsH5xeHtlYyJOHUFpADTh
	 AAxURYWkr76jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3240880DEA;
	Fri,  6 Nov 2026 07:02:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92FB42FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83A0C6061F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATutaD8UT80t for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:02:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9922D606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRHVIg/4; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WWNK5E8O
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9922D606D3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A640sca3419251
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 07:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H+25Ms7KhdPYWbROgILSb4+qQTy3pUSs4oZ9oA5bUpA=; b=oRHVIg/4o2URwH+N
 fm8A7UK5lErZKSjRwXPPpQZLXfRgAgE7RVPbRqVebkGjAh7sj00cy2Kfk7gmTFSV
 ltQp9EChExoolBgC+kgK6KWGg6Yuj1XK6OACZyy4hWm4QXiRyriXrmtolC1lcwMf
 H1C6Fm854tMtGwyJlGaxr/eUuz9xoJm0FfSmK/pYLnWOVTKuLXuSQT0HJ4uFJW9o
 RMT99PoDhCZwMkPiEmXSujpv5e1NmNGQ5rBAeXDBZU9yBmb1ze3PdkDCql87iRYx
 t1+aQCbVOrFwYoCeL9/pVUtLoB0559TWW8dg3zRsocuVcIgH418rPgVqwvPHkms+
 RXGlPQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb1gct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 07:02:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so701732eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793948531; x=1794553331;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H+25Ms7KhdPYWbROgILSb4+qQTy3pUSs4oZ9oA5bUpA=;
 b=WWNK5E8OG/r1uuN9cmjP3iRIQBwtCEi/QCXpWLWHmS3d6yjGmqRcpU0wJt5s3wubRQ
 hKbfNbJfhSS3zr5wuTVMmFAMSpvb2bhopRkD1zHAD6Hy4a1o4sZc+j1drrJkBjNBGZ+A
 5vt5yyMV2diqnryJrw7N06VS4YSUskZMRVoACDwrRCyQxcbnnITNdlz+Fp4OiEBKV/q8
 IGUeYl0HPVMfqagbvu6zsEO7Z2FTOuqfdFwZwwpjAb/E7hDyxLPT+KpplcVQ3FrF69hk
 fgBdePWiky8ctFTuwu85basN2xvilY7DemdlOmIT50+kO54pC5SI1Bp1nOvF1GDuHc+B
 oIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793948531; x=1794553331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H+25Ms7KhdPYWbROgILSb4+qQTy3pUSs4oZ9oA5bUpA=;
 b=R637NTI5ogYwO1/57Ori9iWZjqK4lePY87KgX8qocewVQ7ef0LXTFHATkMMn/n0ZCy
 9rdK7sD12J6bp21rE+HIFdu3qGafquPJgW66CiiMgkecFkCZug+swJ+QhcWvJNnmqrYP
 eeuv7ubLldk4jaOKNNjBQ3k8gub78k0PRCVyv671z0F7bsWiY0hrsrxpViOSbrvxluEm
 XFMh0tg40WLx98y378ed3+sAEYltLMxwf1YWsOOLckqgmLkhg0+3V/CgEZCx3fDpR7wM
 taRKkgvxtNNxF61DFGkWmx8sr1+WJxvH88nJkSY00rvlv7DsruU8XHWPN+AATB/KPPTY
 apkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByecDhjYSwUXydjQlv43pnD97lMuryNTy/Atu9WcmT44izwlYaavT7vQMdX55MOeF1XmjA9IO4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9arYLdvcAap2oGxO2lp7kCiOdsO/NIqCqfCrynBRR4wocY0zt3
 WzP3sH4fywwVkzO+TqeE3XPFh6sgdkI6AM6nvxSIEuWITFdgZ/yN1sOwwwDkREsRorDFlrHxc9j
 jw+JCH4WJ0IOFHJtESyVhmUw3rD9FrfMxYZy1tx25kANboNhWFU4veFmXEAkBW/PY/mfrv5Y=
X-Gm-Gg: AYBFou0vx1e3tyYqVIJ1Pl3DANHQAhcOFkeKLCIvwKh9qQz/3X6jc5VBPBYJ4Gd3G1/
 xWB2yjfM8736vgYI8d979gSGTg8dM7m3V6qrbJvb+p7xNxQpSwXOQdoE/ijjalDhjMpd5SG+d67
 nngxzFm9EKA6eVAConnRd2PbqeI0p40XIrQlcwjxj4SGMqJ7mZ1TreeTaAkZRQaL0yfnuV+OuH1
 doRiGox07Ux3tzq7pPS2UfQlve+5E+IcLzXsq0NASJ869KWW4nDDLQ4pQfmbarwnhjkTt1qmR4F
 dD5xP8w4fQWKHbM7ysrNqhnr8DCxrviSOC2lWFSNIcoqmJdze09vwzvnCD7fv3VmdxIwvUwskVf
 9AS5gEYkBooSfeaK1FsiOvX2TKidNYrUtWQjf6qb81aRANbnw41ptBVgEzKlIVjPfZB6qJ8mQE0
 RbxDlel0kg0JjQjFbkQXfSV7AzgaFcUJkxXfQwQctRj+GwPIYvIgBbYOBRtXzx2khN6a5n0Q==
X-Received: by 2002:a05:7022:f513:b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-1b25d31ec18mr1703188c88.15.1793948531329; 
 Thu, 05 Nov 2026 23:02:11 -0800 (PST)
X-Received: by 2002:a05:7022:f513:b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-1b25d31ec18mr1703150c88.15.1793948530635; 
 Thu, 05 Nov 2026 23:02:10 -0800 (PST)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2735554c88.11.2026.11.05.23.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:02:10 -0800 (PST)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 12:31:58 +0530
Subject: [PATCH v9 1/3] clk: qcom: Add initial Clock driver for ipq9650
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ipq9650-v8-v9-1-23d8919e881f@oss.qualcomm.com>
References: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
In-Reply-To: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Badhrinath S <badhrinath.s@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793948519; l=6445;
 i=badhrinath.s@oss.qualcomm.com; s=20261106; h=from:subject:message-id;
 bh=ez7Bcgkig/cOMDmfERrl18HlYO2Ocv26cMe3AKi2KAQ=;
 b=8UNcSBwSgnUXGnnqqo/XBT5FEhYJ+laKFsq4sgtxYi7G0GDsq4yQPm3ovJOo7/BFQa/yTd11R
 he1UjAVLAKrBoCmq1IQRAkZFVz7EEb/7oH0Vra6dYmrdyPQiRLjLmWX
X-Developer-Key: i=badhrinath.s@oss.qualcomm.com; a=ed25519;
 pk=ZJCDwDnSPTkkqcC32xlBRlzhvdSO5FnWlOjVr6IVBGQ=
X-Proofpoint-GUID: dHZ6z9qWfXOJI2Qbs4847Nn2tWXJSMtJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX5JzfsV3beZKf
 KzCGEt1mdlo2DZEirHv8wRbOCD8vowuCryJoY4Ggerpu7vG3ItF9AWq2ZWiKsGsVNzvzSwBBRpi
 dRg51TYiR14xk5ACLWVzazBHawuVLJU=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aed7b74 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=80Y0h6D7KdPzqAkMEUAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: dHZ6z9qWfXOJI2Qbs4847Nn2tWXJSMtJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX5I29EPqEz48/
 nXfVyeYhdJ/+Md1IMWmCpKCn001EPUs6QLiXpvZWDx6oPz4cFCJdcPEYmGW/gPKe7ct7tmJk7Yb
 t9MLtoxjQY8suF0rDMmG6bVqVnjUCOicQNiZ8q832HcwJluVS0JdveFd8LjFC90GBnOBFhCmkBw
 d1r76JIORoOIyTdiYtlGN3CfKOvM0JGO9kZokEte5ULyeJps7wo2tj+K0YCbWgiYvV/okZaXgG+
 8uXvFWDPm2uIx0djgZ7RqnsReC1KpupmrTS41aZ8nLUFv+Tzrld3s1Lmnomtt+DOMcc6fa4J8NU
 kH83do/88peJa8eLX0SikgtaUPYb2KrkN2nQKOYIslpSuMPdQ67fjwRYhp4Q3Lw02ekHvoIX88O
 SmcPPpvdpZVte6SyE75kpeFOg1Ql8EWewxhQC3sdWxlF0QxuQyq/AJKkJc4dD1ix5i3YZHsg/3L
 KbbSqJyTOgg0X+JHnMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060027
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |   8 +++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-ipq9650.c | 150 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0d8f5028a4e0..1198e57f81c5 100644
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
index 73cafc3f938d..30929a76abf6 100644
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
index 000000000000..cccc750b9f9d
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock driver for Qualcomm IPQ9650
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9650-gcc.h>
+
+#include <clk.h>
+#include <log.h>
+#include <asm/io.h>
+#include <dm/device.h>
+#include <dm/read.h>
+#include <linux/bitops.h>
+
+#include "clock-qcom.h"
+
+#define GCC_IM_SLEEP_CBCR	0x34020
+
+#define P_XO			CFG_CLK_SRC_CXO
+#define P_GPLL0			CFG_CLK_SRC_GPLL0
+#define P_GPLL2			CFG_CLK_SRC_GPLL2
+#define P_GPLL0_OUT_MAIN_DIV	(4 << 8)
+
+static const struct freq_tbl ftbl_qupv3_wrap_se[] = {
+	F(960000,    P_XO,                 10, 2, 5),
+	F(3686636,   P_GPLL0_OUT_MAIN_DIV,  1, 2, 217),
+	F(4800000,   P_XO,                  5, 0, 0),
+	F(7373272,   P_GPLL0_OUT_MAIN_DIV,  1, 4, 217),
+	F(9600000,   P_XO,                  2.5, 0, 0),
+	F(14746544,  P_GPLL0_OUT_MAIN_DIV,  1, 8, 217),
+	F(16000000,  P_GPLL0,              10, 1, 5),
+	F(24000000,  P_XO,                  1, 0, 0),
+	F(25000000,  P_GPLL0,              16, 1, 2),
+	F(32000000,  P_GPLL0,               1, 1, 25),
+	F(40000000,  P_GPLL0,               1, 1, 20),
+	F(46400000,  P_GPLL0,               2, 29, 250),
+	F(48000000,  P_GPLL0,               1, 3, 50),
+	F(50000000,  P_GPLL0,              16, 0, 0),
+	F(51200000,  P_GPLL0,               1, 8, 125),
+	F(56000000,  P_GPLL0,               1, 7, 100),
+	F(58986175,  P_GPLL0,               1, 16, 217),
+	F(60000000,  P_GPLL0,               1, 3, 40),
+	F(64000000,  P_GPLL0,              12.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_sdcc1_apps[] = {
+	F(144000,    P_XO,    16,  12, 125),
+	F(400000,    P_XO,    12,  1, 5),
+	F(24000000,  P_GPLL2, 12,  1, 2),
+	F(48000000,  P_GPLL2, 12,  0, 0),
+	F(96000000,  P_GPLL2, 6,   0, 0),
+	F(177777778, P_GPLL0, 4.5, 0, 0),
+	F(192000000, P_GPLL2, 3,   0, 0),
+	F(200000000, P_GPLL0, 4,   0, 0),
+	{ }
+};
+
+static ulong ipq9650_rcg_set_rate_mnd(const struct msm_clk_priv *priv, u32 cmd_rcgr,
+				      const struct freq_tbl *ftbl, ulong rate,
+				      u8 mnd_width)
+{
+	const struct freq_tbl *freq = qcom_find_freq(ftbl, rate);
+
+	clk_rcg_set_rate_mnd(priv->base, cmd_rcgr, freq->pre_div, freq->m,
+			     freq->n, freq->src, mnd_width);
+
+	return freq->freq;
+}
+
+static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
+{
+	const struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE6_CLK:
+		return ipq9650_rcg_set_rate_mnd(priv, 0x04004, ftbl_qupv3_wrap_se,
+					       rate, 8);
+	case GCC_SDCC1_APPS_CLK:
+		return ipq9650_rcg_set_rate_mnd(priv, 0x33004, ftbl_sdcc1_apps,
+					       rate, 8);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ipq_gate_clk_enable(struct clk *clk)
+{
+	const struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id >= priv->data->num_clks || !priv->data->clks[clk->id].reg) {
+		log_debug("gcc: clock %lu not modelled, left as is\n", clk->id);
+		return 0;
+	}
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct gate_clk ipq9650_clks[] = {
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0), 0x3303c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x3302c, BIT(0), 0x33004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_SE6_CLK, 0x04018, BIT(0), 0x04004),
+};
+
+static const struct qcom_reset_map ipq9650_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq9650_gcc_data = {
+	.resets		= ipq9650_gcc_resets,
+	.num_resets	= ARRAY_SIZE(ipq9650_gcc_resets),
+	.clks		= ipq9650_clks,
+	.num_clks	= ARRAY_SIZE(ipq9650_clks),
+	.enable		= ipq_gate_clk_enable,
+	.set_rate	= ipq9650_set_rate,
+};
+
+static int ipq_gcc_enable_sleep_clk(struct udevice *dev, u32 cbcr)
+{
+	phys_addr_t base = dev_read_addr(dev);
+
+	if (base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	setbits_le32(base + cbcr, BIT(0));
+
+	return 0;
+}
+
+static int ipq9650_gcc_probe(struct udevice *dev)
+{
+	return ipq_gcc_enable_sleep_clk(dev, GCC_IM_SLEEP_CBCR);
+}
+
+static const struct udevice_id gcc_ipq9650_of_match[] = {
+	{ .compatible = "qcom,ipq9650-gcc", .data = (ulong)&ipq9650_gcc_data },
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_ipq9650) = {
+	.name		= "gcc_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9650_of_match,
+	.probe		= ipq9650_gcc_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1


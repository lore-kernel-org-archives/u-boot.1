Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0355606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BePLmY9k;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ijJ5JjxB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TxmiJYSp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A75B34084A;
	Wed,  4 Nov 2026 16:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KjR5Xoj9j5DZ; Wed,  4 Nov 2026 16:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D4944047E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810133;
	b=m/FVNE7o2YZpIq/+qWPtUX6D5wkz70Ve1bEIafbWhj+4MfSegHYnYEfYOtNvMUv2nX4K
	 RX4LZTwu7z7ikU7b+DyBGVfm+rc/3U/8EcoxdSPkTNoLOdObQTVSptvfhdOFn+ofYMe0d
	 CstiDZwKAhTIXxgmDk8spoDRKIyvSNeIib3WzZBby9279cF32ZsfaZIVTVbL1POWzRPfu
	 yZmvq2mN7ZfCvwvT+/8sdh6nocnOtkVves6LoL0H3gbc6mvi8mG/N/GS9BQrgEQj8Oan2
	 +BdJOGXTyAVW31Ra3K/zpNh50CkcComUw2Z9CPgxhHYYxq5fIaz+Ik+6YyDYCGEykVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kuAaTP4CggqVnKDZB01hfl0Dz1pZCE7X0nkrw22xTz8=;
	b=aBis9yPf5jdeH6MdAo+e1/Wj+GTzc16RiGat2PmhIz3IZbTJbJeg4uNreniO7nQYu2W8
	 FJVsRpcmcpdwJUGa6V1SPPAhmdlsHM3HvN0NebEqqjkoJ4tlfjEpJEQW2veviL/ar41r9
	 pyTI4IBTaj68uV7QLa9Q01xswlE0At1EId8Uz6M5T74To+oagyJKNEfjk6xGH7TCkEsMM
	 qEWfcToAyankQ+0x/eGOPHAWV9e1Wr+NGoA2EHr+rd4sEMGeWBojdTS1E+RWeusebXp91
	 JxwiqIq2MfAV/EW1HbuhWpM9VDW0SV+avOUF+hKfyCCueTaWJnEwMbaX8VKqWCSnJQg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810133;
	bh=kuAaTP4CggqVnKDZB01hfl0Dz1pZCE7X0nkrw22xTz8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BePLmY9kWk3/QdoCb133QmiT41PE0pJn60NzaqUHL7/ig4P1XpvvbPBgWM3ZlrGQG
	 sy87sHhzxnm/9sQol7rJhpQWSz1Uq5w70otmcdz/xDYMfB5RZFGIGXESBWE/QUbm3y
	 fM4VD6E7yCkAkBiCGNyL+tnhxsOGwDNKBROUiOBXmvb7KhWNlnIhjceqbq20VITy9w
	 XWbeiEdpunFex7wS0V69d3nWpROQhvErYhK/6MjPqikv7sA/RK1CeBrUYv1N5JDiZe
	 A9P6iSbqCb0kpXfnfyq+++/pDQVvPAdDVauu+pfevB/HawST1gZJn0UMzU2hzFEVZU
	 cOtoXVCEguVGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D4944047E;
	Wed,  4 Nov 2026 16:35:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA9D1341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A081F40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RK4Z_7UXm7sS for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:35:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C711940062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ijJ5JjxB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TxmiJYSp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C711940062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FilD83272720
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kuAaTP4Cggq
 VnKDZB01hfl0Dz1pZCE7X0nkrw22xTz8=; b=ijJ5JjxBYQJgyatUg+RXT9Jwiv8
 Hv8mlrhvDZULyNd85dm1ocKkvLzFsCNruVsqzDK6aWbrGg9klNMCJSZT5ztSMjL2
 svrS1qfAIxP2BCD57Snk0K/Zl4RZtTJkIfzh8Ri77IH1BBzKh1+sLAoPN8snKDxJ
 CbfBbdvvWzsEcFAP2rz5Et2WvgjjUcGOD3l+WE1cYKWDo0+d8hJbH/0jQ83a6MEV
 Q7qxzJmFGuFiGm9FYnoTzlu/AuAuaCPACmbsjRmclHgW+A/9WW8nOzwRnm9LsE2U
 SIALbqfd9tNjXRapolLJBRWRsiQ1yUiX7yQEcF5SORQm38mEpEfKlfYb9sg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngj8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:35:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so3094701eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810130; x=1794414930;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kuAaTP4CggqVnKDZB01hfl0Dz1pZCE7X0nkrw22xTz8=;
 b=TxmiJYSpI1Wbp22g+Bzgz6S0dS0KjgPHcZfoXumJVj83sm8XRiYiTL8DyrZpxXvyDe
 9Sb91SkLVSeOxXywdkCCdCeHTY3Yh33fbI0GYEnn9jItQguHZqWS1Qp3aLlxsh4QgEO4
 Z2zHtwXMhPmaVJSUES3Y9sJZckJVkyXK2LZDqerjJOET/j9+m4wSihr4qHDWxFd/TfQA
 MVrhlQcJnUNwzSxn7dT2cXWBtdI0+YviYISYOkMTU/1Ln6ElVVE4q3fVuzw/KKf5vVQn
 sIZo4gYQ7zUT54DvpTued2OT3qR6IppCIxC3VC02H0lati10uVi6wJ0FtwBADxNPhnFj
 EEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810130; x=1794414930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kuAaTP4CggqVnKDZB01hfl0Dz1pZCE7X0nkrw22xTz8=;
 b=Jrqzmfp5y/1didoMeS9BQTT59xM2mx4vuxPMVqlraSChmhe7cjh53s+QwcUmolsprx
 hGjVmCKdW0FlizK8kPTeoOPF3mOpXCDUtH4O59EjnJFL+4HugjFy1SJWPX//NhlOdLNG
 PoKBSRGhGfdcEevLYnBiw+Vf1BoBWzqyP4xJ2P6kSPNLmuP7UEyjT8dSVgqTdYpTU/ta
 PtNndVEQHg725e9uBI6xPySg98lTAp3gQ8hzz4eNcE5jZ2TvXTVINZilA4RNUcLSgZOd
 jklxM3wpY1CYQ0HQzvpe6h9CQz4oJhAtYypkgaLkZ8S8Mzk56i5kpvtyZHkJmKWbxhBq
 mhRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvqAncLB/59u5XxIPJ4gh3ZY0PPiEfn7pk/wAPsscYe8NdcdJeS5UOvdypmRxU7SkcaHig0O0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z94TJbtzqu6OXwHo57nGsAUGSzDEV990VUytjySJdJVBHiXCXZj
 BwxNhY4Ao+FvZSuTHo36M/YSzBvwb7Gwp3RBrlUwM6H/bN+eP+KmICbWkZrv40TC9hkLQOANSdQ
 GKNSFS1Rwif0m1py3TT7WYJa6QfTIyU/VHoNHQ5gbSb2/bgiXNbXzEbGGoHfvp3nV3Unives=
X-Gm-Gg: AYBFou0cqfVAWfAfXOwBd3DOCSeKtf+MGVF4DV8S7WwPNJtIsdcgDy0xRvxz1FXuuK8
 SAIqMXpnPEerkGQxVu6OM/W02wIYssDbnu+LZ7x8wj257mlY2LZPaAklbrhaja6o80gntV2GBgo
 TYs/x3HtFXbNQKEM/Arb66uqdTr4m691HaXtEAIZn+ktsBFzB1szCBgNAIIdlUBSHaZSdUl3ATz
 a9n2zkUV/O4283vcIJmpO51tYOd4GbJkoxh5LrNQEGGNT3TI9iRu71PJ1QXYY4dlxwp0EXb+qj4
 CuTwAhdlp34JquQthK5X0kR5+BUXRkKorUUsMtvIW/UXQdTylHpAKbmW6WbifDt3Vn4gSH9mFLN
 9Aq0SxFUJmXWkRL9VKcIKFLoLuOUWxjvTv9eoWxU9O3mMOzNX8E845IAnK2tM1bki+1uX+gpWIL
 Rj4qC5PkDxiZ/S18AKgwm8acoexCdN+zlUuqM1iKTIwAOMnDIRGDN+nE3+MKyCBFso
X-Received: by 2002:a05:7300:e9d6:20b0:369:d779:bcb8 with SMTP id
 5a478bee46e88-36a42059aa6mr26559245eec.0.1793810129696; 
 Wed, 04 Nov 2026 08:35:29 -0800 (PST)
X-Received: by 2002:a05:7300:e9d6:20b0:369:d779:bcb8 with SMTP id
 5a478bee46e88-36a42059aa6mr26559187eec.0.1793810128972; 
 Wed, 04 Nov 2026 08:35:28 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:35:28 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 8/9] iommu: add PCI stream-ID resolution for devices
 without an ofnode
Date: Wed,  4 Nov 2026 22:03:57 +0530
Message-ID: <20261104163408.1250410-9-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX+ltA7oUNPQzu
 bXsGNZQMNbcPKZgUFIGOCVIHUzubjNC/m7tA0SpiAOSulA8B1I8f1dSwRkn0LEf+JxEFz7LvkS2
 PHlxKMYmrX9k8hd19+k1w1Yb3U2h4V7lWphGoKbAFYvNTtnleLPIFMtsJbd2AH8EB8FgyR0zItA
 M7OnIhCrwPRgkgvsKT22m+nlSzyl9iI8LyK0GlxOyiMjym/Bl8PZdziTPIkXhC9KuAwzEIiZnfU
 Eq2vBl5h5RYjmkzjliQzCiFwiYkhYZUCNKoxr+3VHdMiGKgzNdToFcebov3XssY5XXg1deQqpzp
 HIfuNmi+ovTQJai++k+w7/ZnPIRqweMgUPz8B1pUqW5Gtme4CL3hY/WVzCnjmaG29E0vsEtgTqL
 MHILrdQoXJcH2e3e7fCrKtvhzageeytdKbZsYdbkdXy3OYAP21Y3PYtV5mP3hlucMv4ioH+LhPp
 8HYOoL7p/UL3Iggcisg==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb5ed2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=3OI-0-YSPqiP0vX_Sq8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: YSeRVoRjrIr6jTMfWBWKdbGNT0wsePFc
X-Proofpoint-GUID: YSeRVoRjrIr6jTMfWBWKdbGNT0wsePFc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX/SwLJx7WLMAI
 vqKh3UEBVL9iTkvJQzKv7PUp9m0i4kk/SRZk025BsaTgDJSyF0CbtHcbSXravivu5NrN7jiHZdd
 2BS/aG0Qu9cpAdVSbJC9Gs36+pyuJRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

dev_iommu_enable() returns early for any device without an ofnode,
making the dev_pci_iommu_enable() PCI iommu-map fallback unreachable.
That fallback also only resolve which IOMMU a device belongs to, not
its stream ID, so ops->connect() has no ID to classify the device with.
Separately, qcom-hyp-smmu.c disables stream classification at EL2,
but firmware converts an unclaimed stream to a FAULT stream regardless
of the CPU's exception level, blocking DMA for downstream PCIe/UFS masters.

Restructure dev_iommu_enable() to fall through to the PCI iommu-map
path when there is no ofnode. Extend dev_pci_iommu_enable() to
resolve and store the stream ID in the new pci_iommu_sid field and
call ops->connect(). Wire this field to get_stream_id(), and drop
the EL2 self-disable.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/iommu/iommu-uclass.c  | 78 +++++++++++++++++++++--------------
 drivers/iommu/qcom-hyp-smmu.c | 27 +++++++-----
 include/dm/device.h           |  7 ++++
 3 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
index 31b40e5713a..2299bbbdd37 100644
--- a/drivers/iommu/iommu-uclass.c
+++ b/drivers/iommu/iommu-uclass.c
@@ -18,8 +18,9 @@ static int dev_pci_iommu_enable(struct udevice *dev)
 {
 	struct udevice *parent = dev->parent;
 	struct udevice *dev_iommu;
+	const struct iommu_ops *ops;
 	u32 *iommu_map;
-	u32 iommu_map_mask, length, phandle, rid, rid_base;
+	u32 iommu_map_mask, length, phandle, rid, rid_base, iommu_base;
 	int i, count, len, ret;
 
 	while (parent) {
@@ -50,6 +51,7 @@ static int dev_pci_iommu_enable(struct udevice *dev)
 	for (i = 0; i < count; i += 4) {
 		rid_base = iommu_map[i];
 		phandle = iommu_map[i + 1];
+		iommu_base = iommu_map[i + 2];
 		length = iommu_map[i + 3];
 
 		if (rid < rid_base || rid >= rid_base + length)
@@ -64,6 +66,18 @@ static int dev_pci_iommu_enable(struct udevice *dev)
 			return ret;
 		}
 		dev->iommu = dev_iommu;
+		dev->pci_iommu_sid = iommu_base + (rid - rid_base);
+
+		ops = device_get_ops(dev->iommu);
+		if (ops && ops->connect) {
+			ret = ops->connect(dev);
+			if (ret) {
+				log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
+					__func__, dev->name, dev->iommu->name, ret);
+				free(iommu_map);
+				return ret;
+			}
+		}
 		break;
 	}
 
@@ -79,41 +93,43 @@ int dev_iommu_enable(struct udevice *dev)
 	const struct iommu_ops *ops;
 	int i, count, ret = 0;
 
-	if (!dev_has_ofnode(dev))
-		return 0;
-
-	count = dev_count_phandle_with_args(dev, "iommus",
-					    "#iommu-cells", 0);
-	for (i = 0; i < count; i++) {
-		ret = dev_read_phandle_with_args(dev, "iommus",
-						 "#iommu-cells", 0, i, &args);
-		if (ret) {
-			log_err("%s: Failed to parse 'iommus' property for '%s': %d\n",
-				__func__, dev->name, ret);
-			return ret;
-		}
-
-		ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
-						  &dev_iommu);
-		if (ret) {
-			log_err("%s: Failed to find IOMMU device for '%s': %d\n",
-				__func__, dev->name, ret);
-			return ret;
-		}
-		dev->iommu = dev_iommu;
-
-		if (dev->parent && dev->parent->iommu == dev_iommu)
-			continue;
+	if (dev_has_ofnode(dev)) {
+		count = dev_count_phandle_with_args(dev, "iommus",
+						    "#iommu-cells", 0);
+		for (i = 0; i < count; i++) {
+			ret = dev_read_phandle_with_args(dev, "iommus",
+							 "#iommu-cells", 0, i,
+							 &args);
+			if (ret) {
+				log_err("%s: Failed to parse 'iommus' property for '%s': %d\n",
+					__func__, dev->name, ret);
+				return ret;
+			}
 
-		ops = device_get_ops(dev->iommu);
-		if (ops && ops->connect) {
-			ret = ops->connect(dev);
+			ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
+							  &dev_iommu);
 			if (ret) {
-				log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
-					__func__, dev->name, dev->iommu->name, ret);
+				log_err("%s: Failed to find IOMMU device for '%s': %d\n",
+					__func__, dev->name, ret);
 				return ret;
 			}
+			dev->iommu = dev_iommu;
+
+			if (dev->parent && dev->parent->iommu == dev_iommu)
+				continue;
+
+			ops = device_get_ops(dev->iommu);
+			if (ops && ops->connect) {
+				ret = ops->connect(dev);
+				if (ret) {
+					log_err("%s: Failed to connect '%s' to IOMMU '%s': %d\n",
+						__func__, dev->name, dev->iommu->name, ret);
+					return ret;
+				}
+			}
 		}
+	} else {
+		count = -1;
 	}
 
 #if CONFIG_IS_ENABLED(PCI)
diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 5b37c21f66c..3fc3e1211a9 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -7,7 +7,6 @@
  */
 
 #include <log.h>
-#include <cpu_func.h>
 #include <dm.h>
 #include <iommu.h>
 #include <linux/bitfield.h>
@@ -92,8 +91,6 @@ struct qcom_smmu_priv {
 	phys_addr_t base;
 	struct list_head devices;
 	struct udevice *dev;
-	/* SMMU is not needed when running in EL2 */
-	bool disable;
 
 	/* Read-once config */
 	int num_cb;
@@ -132,12 +129,25 @@ struct mmu_dev {
 
 static int get_stream_id(struct udevice *dev)
 {
-	ofnode node = dev_ofnode(dev);
+	ofnode node;
 	struct ofnode_phandle_args args;
-	int count = ofnode_parse_phandle_with_args(node, "iommus",
-						   "#iommu-cells", 0, 0, &args);
+	int count;
+
+	if (!dev_has_ofnode(dev))
+		return dev->pci_iommu_sid;
+
+	node = dev_ofnode(dev);
+	count = ofnode_parse_phandle_with_args(node, "iommus",
+					       "#iommu-cells", 0, 0, &args);
 
 	if (count < 0) {
+		/*
+		 * No "iommus" property of its own: PCI endpoint resolved
+		 * via an ancestor's iommu-map property instead.
+		 */
+		if (device_is_on_pci_bus(dev))
+			return dev->pci_iommu_sid;
+
 		printf("Error: %s: iommus property not found or wrong number of cells\n",
 		       __func__);
 		return -EINVAL;
@@ -280,9 +290,6 @@ static int qcom_smmu_connect(struct udevice *dev)
 	if (WARN_ON(!priv))
 		return -EINVAL;
 
-	if (priv->disable)
-		return 0;
-
 	mdev = alloc_dev(dev);
 	if (IS_ERR(mdev) && PTR_ERR(mdev) != -EEXIST) {
 		printf("%s: %s Couldn't create mmu context\n", __func__,
@@ -354,8 +361,6 @@ static int qcom_smmu_probe(struct udevice *dev)
 	priv->base = dev_read_addr(dev);
 	INIT_LIST_HEAD(&priv->devices);
 
-	priv->disable = current_el() > 1;
-
 	/* Read SMMU config */
 	val = gr0_readl(priv, ARM_SMMU_GR0_ID0);
 	priv->num_smr = FIELD_GET(ARM_SMMU_ID0_NUMSMRG, val);
diff --git a/include/dm/device.h b/include/dm/device.h
index 5d700888503..f8777aead83 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -203,6 +203,13 @@ struct udevice {
 #endif
 #if CONFIG_IS_ENABLED(IOMMU)
 	struct udevice *iommu;
+	/*
+	 * Stream ID resolved from a PCI iommu-map property, for devices
+	 * that have no ofnode of their own to carry an "iommus" property
+	 * (e.g. dynamically enumerated PCI endpoints). Valid only when
+	 * iommu is set and the device has no "iommus" property of its own.
+	 */
+	u32 pci_iommu_sid;
 #endif
 };
 
-- 
2.55.0


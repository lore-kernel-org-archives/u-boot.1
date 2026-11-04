Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E363606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dE4EP+fc;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T+W1Xv2g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HfReMkFM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16BD380C7E;
	Wed,  4 Nov 2026 16:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oq6Y-TI2Ij1M; Wed,  4 Nov 2026 16:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B62980A55
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810117;
	b=Vy1dIjLjyUglbxm/mYil5/4JY2sOcDVwH7fCfV7dpBczbR120YHrMZcyPoByFUhtsITT
	 n134ni37XDOKh4CME0jlCN2bB82GwTZzI0SCiCd02Nvwm2uhZ6HJb4kl0yyIPRzKg8FED
	 o2KtQgUnGCWhRf822hzwyXEjSKkGZLLMaK/wOdVJNw3naA+gl1AioTLj8DnP4Bry5n/1u
	 xPazK4BKzRJoqnmVds6vtTa895kWTEiQucWQOySJ6X6LxtcpuZFa03+GuaPDlDMqDXwPu
	 DW+o2XqNQG/kUHb++mqMiJ6lm8FbTGylKqeiY7KRVvg9CE/8VECEJmfBNd4W7s5rGDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FcdDmcGWloAHUaAwkZlw60XooQ42sjIHbvEWVWgEZTI=;
	b=TnyAh2EkVNXHjpXWWYo4NB1TL6bJjRqWKhbL/GgCOCIG87aQMlu4peumAkQFx42jTqtq
	 yX8cc824ijIF6hF9ntWOaooh9bGa2w6ys/A0LNZmFcsLkA3g2uVH7607sikLVpHWMCVD1
	 r+oqAsxp5oTqQTcHH1eXik98rynh9ZXVI2gG+M4s4XHRqzwXgKW2O/6rAbnZjahNyRiLu
	 78s7nucljxQ3Fe58gCK0o5Uz9+xvdWnO+xrHO0m33aF5nhRntG1RxY44AhzW7HCkCYmBg
	 6aSRJTH/2s8CKC/SvoOeQ+1g3GTxt50rUOlLtPgimngyzeTG4+P2xEahtGYn47l04Eg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810117;
	bh=FcdDmcGWloAHUaAwkZlw60XooQ42sjIHbvEWVWgEZTI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dE4EP+fcanWn2FjPvc2zAEDWBD1i68ENM1gYEXxPZGqzSa6/kpVI4VB1Bo3S5y9iS
	 auIRqwMAVltTUWg/ATybzyJCaVUWAbmWCmw0eZS8MrieY+PlCBKTEWjveuGxzgt+76
	 WiAt9VB9qocwyqydTnq966MO6sQJiZOEORJUHVA8h7XDDFRmt0CZBOMoYCCwoOxjAM
	 rDy0FwBKQcl2adxqZG7JCgw/WAja54ciFmUkRXS7RbwcbPqaznjbGL310+euqp3wyi
	 7xpj4TEqcQD9AnfGME7ieSmBQ2/KqbksNsU58N1nnXzQLdTB8CwlIeJdupQrHF8y5H
	 EjmtEJQVbPDjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B62980A55;
	Wed,  4 Nov 2026 16:35:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22A16280
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FE9340068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4bZBmeEGBYuU for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F63440062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=T+W1Xv2g; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HfReMkFM
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F63440062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj3LB2251053
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FcdDmcGWloA
 HUaAwkZlw60XooQ42sjIHbvEWVWgEZTI=; b=T+W1Xv2gHFEkQl9ktoCLBI9zMyL
 otU/ufm0a4YG63ak8KN6AQu/holJOfAGHJw0nnSFk3yXKNC+p8tfYDhvWeqHgem+
 PVVy/shbtxUvPhW2zSdYJeJ/vfpRvlaz1wR8RnsplxShNTYBrhjoQHCxorDZ5EhD
 UH3rg0A050Ln3PF45elnGzZiIwEq0+HCQL8RoVS/afl0MIcnEXe6p1GJum4CkGXk
 c4Sm/vTqBkx7ESIp65Mlf0vYJI6EbaYFi1I3oyjzPdOi6uroCp/EY+X1+clKKz6L
 l8VvPxZ9VXPwUCg0lN5+53Zvisn2sHcgSGRmL7hPFCv/CfIeQ+IDRWOewmg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn13gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:35:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36cec75d8caso838498eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810113; x=1794414913;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FcdDmcGWloAHUaAwkZlw60XooQ42sjIHbvEWVWgEZTI=;
 b=HfReMkFM76y+zwJeA7rYUib8oTFIyN+mMiqCq1QPuQArgKNPK60v4tveWSSFhW0NKQ
 ru7B4aUjTfBQIqFkEpQBh8nBdBPh3uKwT1jtlYDstzt8SJHc7QZZfBrXu5U7GIv1WOw9
 z45rELGL/5w2VgaFp/A87Uzl0L+lf6INsdE0GzK80eOT5Kt72CgS5pAHekOmpdHEg/ka
 /8yfVNK/eIdb+r4iV9vb2xaxKywDjn5z0grC73Hm6xFQ2iRvk05NImIU35UIfvmX+HTd
 A1h9AVtwOfKfLKjPRvWsGS7nXXkVv9B3QdeLcaYfX/FdgDt20P6Kr3irKsaoIqGhj1oG
 Mfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810113; x=1794414913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FcdDmcGWloAHUaAwkZlw60XooQ42sjIHbvEWVWgEZTI=;
 b=H3+RKigxPDZYEAlVuHtTxxz6jsPbHIMOZKEawM8b+D/jtYRGUBvjfXDr/AwPhRW77t
 K/EzrT7BIp0VkOVXF7M/VyiolopTOdKwhX9/TYLd4UcsxbfBAgFDa+OIgeqUgvYCGIgu
 B/03JtFQ0hOlUQ5u+rm8MOfG0lavNhuCXxGfY/wpcDo3dtZsMUiw/loAiYHf3xMQyTRl
 rbUNrKZZ0551XgqvquYMT0x9xCz0Dgul3L4J8JqsUss/PT3X4w6fB/dEBjiRB3F23jM8
 /vha/yNQ7pegRqjRwGzL8zKo+ZtMX4R1yF2FikBoUODGgmygXFxZADGIJIhqRAMR+vTj
 3zUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxulEDMoayPPutrJmXSJT7HdSEHB8broXFGqwmWKTOevzmodxpFlWFiZIc3uAofb5i6bCG0gv8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/27yeLSORrlEe7hcNhHIoPw9vWznUevQ//q67WTCtLmkYjObO3
 UaDsMFTSd8G11/ta//vyuKPSu/WdG7eKT9fxKWVHwhO7Xh5AWHZRZiK6QdKBflmPGWObvmBMRK5
 zJ484hiTZ1F/nPcPM/QlEY5svmTUVXR+KcYjeVnTBl7NACT2TidWlt6W2bY/0f5HmipeSrzg=
X-Gm-Gg: AYBFou2MEH8jn/xQoqleHcuLotCJjblQg6yRZpYK796qgEbBlVWPliJ6ywGSf2DfQmT
 MPTu0A9LEI7vO19z2BLKQHJPbn+Z/b2/Q/Gk9jfFs8Rk4O0xxsR8WROmf/VVDxRuIuEyPD2faL8
 oL6nsHreZuiSdKcU42NCGXwUYSqYMmA6jflCFM7qkndfbzzYURiBZCTw3+tI0ROwhM2XrVIDuio
 GNNLwOlA33Wt3GqmOhp4d0lCe4IVj2EvgbY3Yw1gjwEaSrEic67SZ+LU3pkSwf4Py7aTwVqS/8K
 3xts0YNz0pO4W0cc+0O+wn//51qPi++FKVaCfnx2FCvHxg+2iR0X4CGQBZ9X4dH7oyfFaILzDxQ
 xNr7We6zgNKvvB9fWuLxrUE6U2LfEDi9zFrFO/DIY+lT/w+g8Nz5JeG8ZnrtOEa5b0OYjq2ytGo
 iH43hTrk697y30V9pa8JoRo4/6Gstg9zkVhZ9ejen9Fj+Gan8f2agPRVP4MWqip59G
X-Received: by 2002:a05:7300:fd04:b0:36c:a2cb:6ad0 with SMTP id
 5a478bee46e88-36de5f6f455mr15350eec.8.1793810112963; 
 Wed, 04 Nov 2026 08:35:12 -0800 (PST)
X-Received: by 2002:a05:7300:fd04:b0:36c:a2cb:6ad0 with SMTP id
 5a478bee46e88-36de5f6f455mr15267eec.8.1793810112180; 
 Wed, 04 Nov 2026 08:35:12 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:35:11 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 6/9] gpio: qcom_spmi: add pm7250b/pm8350c compatible strings
Date: Wed,  4 Nov 2026 22:03:55 +0530
Message-ID: <20261104163408.1250410-7-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX1RPAdgjWJgp7
 HM53FA45d6IKeT1jqU2JgTKcDjKtPGjnOTO6P+A9SVUT+h0lX91c9NXjrc8MWal+xJtR6x2C87g
 IMdis13upc/zGmLQvMZ0IpEHieTdculgrn+XqQY3s/POkWwYd8E6fDA+3/PB6eaETRyGZinxccj
 YsJR70kWIyZDo7FfE9Z1rGNOUEO8ie3c8XoWl08CbQJzmPDNbDQS3rAQn4lh51xVSPPuQCLY0PA
 kQk5Q0HNCaqcE9rcw3gViC1WHYdxyLyZmCyKth1UZWkH+wLovFdUtDF16/Wn7im+1YFFGmKiiNP
 twbg3LbFc4Fw79WVAxg2RSff7bX9iTLeb4lY/AnEWNcYbCYjoujhfZxlXntUkTNtgCExbRM0xrn
 pBmdChY6UUGQI0kCysZe5RX3sh2k1y/tLxW0lGOvlG1TozSMDz2usfJGdj2bymCXXxdPZpnZ2as
 O2IGzSUik858bBBHkkg==
X-Proofpoint-GUID: C2zRU_diZWXAaNPk9AVWiDTEsUFPpPCy
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb5ec2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=EBavscP35QYYPqTal-4A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX4VqForIRupiF
 csH9VwH2o3pVtbBaVMGk2w0GTlea8DvVtFeEaKGfeNl56OkTRImETtNm59U7HkRaCrHACz1h6Xp
 42DYq2IYBpAd3qd7On29Z+ZAPnDE7P4=
X-Proofpoint-ORIG-GUID: C2zRU_diZWXAaNPk9AVWiDTEsUFPpPCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

Add the missing compatible strings for the PM7250B and PM8350C SPMI
PMIC GPIO controllers, needed to bind against DTS nodes that use
these PMICs' GPIOs.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index d06b9a4b513..feaafba7e09 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -746,6 +746,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm6150l-gpio" },
 	{ .compatible = "qcom,pm6350-gpio" },
 	{ .compatible = "qcom,pm660l-gpio" },
+	{ .compatible = "qcom,pm7250b-gpio" },
 	{ .compatible = "qcom,pm7325-gpio" },
 	{ .compatible = "qcom,pm7550-gpio" },
 	{ .compatible = "qcom,pm8150l-gpio" },
-- 
2.55.0


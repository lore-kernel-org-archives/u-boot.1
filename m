Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57362606A684
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KZSDEtHb;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIXN9LQJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XqnlrCtQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3040960A80;
	Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndwm9zZDigjO; Thu, 26 Nov 2026 14:32:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 587CD60A98
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703524;
	b=jDvoaEMAXbgLnthPNMUDWzLH0XN866IQexYdyKlco0EsvpYmMVV6HwEFKIuh+6XLXEjp
	 RWdrOSz/QbyyZtN3KFXcQz9jJlN3t9lspkAP7Pc7WwbEHHSnBTdOgtEZ67uKDs1QrRN7v
	 LqcAOGF1oZj1WP3AWPsCQ1/crHQMso9PFi+0+ainBjBdXgUJ4jze6YoZ2KZD53clOk9Fu
	 lJGIlQ8BoDTus6aoJhvwvJ592nCd7nItzcl3jbkOooVmWNuuRj3+QjYOnxTQrisns5W/i
	 FtjKsa7YWT6H5wYj4wR9uWAokQXd4Q/maqlZrDE7dMOXu1CTvkPn54/R39Q8DpKdF/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nVzQWt+6Spw5rc87I9Uto0Pxl64X2VycjWOZhqyn0SQ=;
	b=eSn8K6b3u5PdBnV6UsUuXRv1ybul0GXgUzm1byN3dudcCBC1KIYfuiePpREUc9SDHy5/
	 zQ8YRKOogy+z74vznie9JeD6tIXBewk7c0GxVezLIKBLY8Z8MT5k0jUWYevusOUvEatr2
	 /pZxiW2sHKoSxRtkLSaDG7pR+eMmpV2r4JXG/PAIgWdjYN6kBfQFDCGsc6l1DSWQBaioQ
	 Mhqy4MHtZwU6WPR0cdm7Ld/4PRbsK8cTgWA+PZSO3BKGRWpxGq3k2w5AOiVEMvNQ7F/bt
	 mU4DmxknKs2QMaVvbDUS//+i6SDGee81LkGwwZfkPlPR3wFywLXhGGlESTDxhaIXrNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703524;
	bh=nVzQWt+6Spw5rc87I9Uto0Pxl64X2VycjWOZhqyn0SQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KZSDEtHblpnit7e47WqDlxB5jTlFhC3GlKegbzF/eW1KE7qD4XIDU2yYS7TtSM0ze
	 snAqV24lgQjWGSaWyiCgH2sO8GwoUfi+fK28bmA9T/0tXsqTY16AZhhczbnyr4B8jA
	 yRRhLN+VHToaz/Q4DyFqslIKsidAwrFKXDQd4MujNNpfMe+aoIBDz3kimQjr7Cq69y
	 i3iphbF9/43EXEGcqr8XHRjR9WdiI4yws5H9+gmrZVFwBAxPf84droWtPd68GFsy22
	 4iKR/YZrfjiEFOaK6N8o9nXEllC4/huIL9qJQWqw4pmBYBbyhkhgunICOm1/CtpZUK
	 UJ3NDFo5g380w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 587CD60A98;
	Thu, 26 Nov 2026 14:32:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AB80311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B81D80816
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iO3AsINFUDnR for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FDCE8119D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIXN9LQJ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XqnlrCtQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FDCE8119D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEV5fJ3664852
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nVzQWt+6Spw5rc87I9Uto0Pxl64X2VycjWOZhqyn0SQ=; b=cIXN9LQJRjaFgAvO
 hLUpfspkMe5CzB7Q9nzV4UwCRKcT3tzmRO1dGjqvirYJLkivGX+s0HclGJ2Ia9SP
 YwaZn/Ls753D7x0Ye43QbPbRIyu0T+8Yigq6o+zCjFtx6TIk9h9OkW/XIq2u5cdK
 5MV1ZSwTlj5UJrog5gimMsmAt2z4ZVj+LEPecz3Mu+nQopmBHaeJQ52F9xvKY4Ix
 Owkj1QZV0vCNUrgJswf2E4kP8zULGIhirW8pPsvU5c5iRokgvcbiOTp0FptORJJE
 3gmX9XjatDmG2lg5mpGFvFSIaONnBvBXVn27qMa32HO1iUzPPrTilYajZzi9i12C
 wugYKA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6h7g9a9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:00 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-57ce46ad0c1so5295764b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703519; x=1796308319;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVzQWt+6Spw5rc87I9Uto0Pxl64X2VycjWOZhqyn0SQ=;
 b=XqnlrCtQHOGDHCSXAsRyVNYojBsD/wUx/aI9MtmC9AbcIOvIEtsNN9qsAfdk2JnRTW
 W1bKiiR6tAYMkjlhLksYXyLxl3Wb9QtGUijhOQr5koxgq2a4jDJDFWXHe3vhwILSqc2p
 NTOnhRTiSJv9l2VGNZaYMBZhwIr1ir3t8CR0F9XfRDc3GRVHkhbBx4TGxFhmO44UrcGn
 5QCk1iV8JEablcZTV1YfdMfB+vbHPxu1UeGVLydK8dnfyLkB4ZNCwuOHKHOzdhflYzMH
 3KFpFnsxPiY0z6BIyY99fQB/1U6i92d8T5cVt0NF6gkN3p9SOjo1VJgEyAPD3fIj389J
 4wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703519; x=1796308319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nVzQWt+6Spw5rc87I9Uto0Pxl64X2VycjWOZhqyn0SQ=;
 b=q9wupxhitPtGNWYqhbkUbn3w3+ILo59+9EgBCsiSLSqPr6jBgVOsl0snHYAZkyvdXR
 ehOP0WjfHVzQvCj47V/S5juwom60dOEai9MEK8QS49xXKryVkO3MHL/X20b/7zZd+DTz
 5zSe1Wvno1DUvFaInu/unw1UEzXfL+oiodvuyMcuHn0kmGCXuboM5G49pk6kyu1fFqa4
 8iq6XSP8j+rQZZja7ehgb3Mpq6trTaolkFJU7fEs762HtXoDFlafsa/e9P9WjvDXiwhl
 yEAcn8V847pyaZKmOzOZ3XbBLenmn/gFBg7V0czG+5hbIBZnJVj1pK7ZiY6gtex3QcQT
 Qv3A==
X-Forwarded-Encrypted: i=1;
 AL+hErHiR/mxrrhY+zDkSooO7VlAIbN6w4oRb//HvU7EsXkxWIXU5/N+NxF9/JTqySksiWhD/RQtrLs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ujgd2scFXK1iIsXoOJ1FHvXrmUL157x0kJBmBhywUOFTxV8fr
 AP551mjfwn+nRPqHbBftjGpJXL03jWuQAW50ZPWli3aDXl8dW0nMiBNc3zP+gbaxdGsYyvzGVSc
 o4JN5af2kdP2KYrtFa8048X6Lo3zxCF1bkkQG5b4hJjnWNQiscEXEkfAc+bTyydfWeFHtDRoXKu
 EKlzM=
X-Gm-Gg: AZFdTZdnWWfThhni9964uRqgVfJp7K1WuFsa3LDbGifzeSeJEsirjGAAnHVQ+/atOX1
 36BjBQFr3NqHix/fz17lwx07Y57lLNDuO/AlxNV9u1DhRvwXs2mcvR3YWc1SvmAI9ylv9NiSEHK
 DzkZDbLOLmjvJOREcHBq5or0vj8tXEZMwqK3kJ2VDlKbIoC/8i/KNEX1juhDeyH49DwfxwaciNs
 vYTbtNOo20Y9Hg1asxzz7wm3mjqaFxNBUt9Xscqjw4Ae8wr/T3Z5liLAlY1UE/rD5Z9+AcUU4wR
 pSKEBZwLCAh4jLTLm9boFFzyn6D/BSG3CVbf9XoXHN4/gIcEoIuNjwvb5wNSPDOpBHEtR9DGwjy
 G8DOlI9zZwXJILs0/CUVnw0vMCLX+WKVC1alg9zB4oVGyoLpevSo3pVHG1vN0PCKFV+xOCuuMo4
 faV0JWJ5oBwaBz
X-Received: by 2002:a05:6809:2792:20b0:57e:3c4f:4b4c with SMTP id
 5614622812f47-57e3c4f5369mr7528031b6e.68.1795703519385; 
 Thu, 26 Nov 2026 06:31:59 -0800 (PST)
X-Received: by 2002:a05:6809:2792:20b0:57e:3c4f:4b4c with SMTP id
 5614622812f47-57e3c4f5369mr7528012b6e.68.1795703518984; 
 Thu, 26 Nov 2026 06:31:58 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b030ed9sm772664866b.86.2026.11.26.06.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:31:58 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:31:51 +0100
Subject: [PATCH v2 1/4] mailbox: add the Qualcomm APCS IPC driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-qcom-rpm-glink-v2-1-15707dc6f396@oss.qualcomm.com>
References: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
In-Reply-To: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: UoNDwy3Os-P5o-SzT4ezvVZuRFlx4G-6
X-Proofpoint-GUID: UoNDwy3Os-P5o-SzT4ezvVZuRFlx4G-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX/rG38PH5s9TB
 1su8G4SIs5GcFUpFSthAq6cp8FNCO5JKP4erKER40gY1CRK7xQfJ961lJSwZQ3VCe7yK4ZlJnQH
 W/n6g/vRoUeQgN1Eid25sDE/8c5ifiVl6OtfSglYReuynQg8l3gtrn72nj7MmAD3QBi7jbjOAmv
 RjaQyMSsgpdrWWwmwb9dPp44GpltsEFEx23lxVyOmQOtXl4J0o/LD1cAs3bywinJkwP9aeBavSh
 2/GEBu70BsZFpN2Kxoc5p2SrXY0aSChDKOTFIL/C/oxM9QaXjKQrty4dLEaDwXEsXGZMQO2UtWf
 aWaQ/96huS9PGHecrNwBzgfs+k4xVBBJ7sBjIE82MQ/xGyY8Bnq+nUu1Z0Kzipuqw+3Ncb4Q/kS
 OmXsefQE/LmB4d/N7Jdexh0ZsVKyhKqEwz9oLxYcsMs554iWbWOJTnKIRWI5mmcj89F0+HxWRYQ
 OWEiRL87yl0YHR5P+Hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX90S+AVKR3Wka
 hF74Uk16T1909xrG+L5tGX3ZXAdtFAwwzUE+a5wvLPFhiJ8pBqXCR3sk8jFfhkJnPs/KCu/f2/o
 190SFbJzcTWa2dVMhVszhaHp+QzSjJo=
X-Authority-Analysis: v=2.4 cv=L4GI0OT8 c=1 sm=1 tr=0 ts=6b0842e0 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=9D0mPIKU8ckUToVstoAA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056
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

The APCS IPC register is a write-only doorbell with one bit per remote
processor. Add a mailbox driver for it, with the register offset per
compatible as in Linux: 8 for QCM2290 and the
qcom,msm8994-apcs-kpss-global fallback, 12 for the SDM845 APSS shared
block.

Tested-by: Biswapriyo Nath <nathbappai@gmail.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/mailbox/Kconfig                 |  8 ++++
 drivers/mailbox/Makefile                |  1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 68 +++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 1d9e284cfd1..63d4d5d4ee9 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -38,6 +38,14 @@ config MPFS_MBOX
 	  Enable support for the mailboxes that provide a communication
 	  channel with the system controller integrated on PolarFire SoC.
 
+config QCOM_APCS_IPC
+	bool "Qualcomm APCS IPC mailbox"
+	depends on DM_MAILBOX && ARCH_SNAPDRAGON
+	help
+	  Enable the APCS IPC doorbell, which the application processors
+	  use to interrupt the RPM and the other remote processors on
+	  Qualcomm SoCs.
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index b3a36691497..7daf6eaba14 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
 obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_MPFS_MBOX) += mpfs-mbox.o
+obj-$(CONFIG_QCOM_APCS_IPC) += qcom-apcs-ipc-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
new file mode 100644
index 00000000000..acff66a7403
--- /dev/null
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm APCS IPC mailbox: a write-only doorbell register in the APCS
+ * global (or APSS shared) block, one bit per remote processor and channel.
+ *
+ * Based on the Linux qcom-apcs-ipc-mailbox driver:
+ * Copyright (c) 2017, Linaro Ltd
+ */
+
+#include <dm.h>
+#include <mailbox-uclass.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+struct qcom_apcs_ipc {
+	void __iomem *reg;
+};
+
+static int qcom_apcs_ipc_request(struct mbox_chan *chan)
+{
+	return chan->id < 32 ? 0 : -EINVAL;
+}
+
+static int qcom_apcs_ipc_send(struct mbox_chan *chan, const void *data)
+{
+	struct qcom_apcs_ipc *apcs = dev_get_priv(chan->dev);
+
+	writel(BIT(chan->id), apcs->reg);
+
+	return 0;
+}
+
+static int qcom_apcs_ipc_probe(struct udevice *dev)
+{
+	struct qcom_apcs_ipc *apcs = dev_get_priv(dev);
+	fdt_addr_t base;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	apcs->reg = (void __iomem *)(base + dev_get_driver_data(dev));
+
+	return 0;
+}
+
+static const struct mbox_ops qcom_apcs_ipc_ops = {
+	.request = qcom_apcs_ipc_request,
+	.send = qcom_apcs_ipc_send,
+};
+
+/* .data is the offset of the IPC register in the block */
+static const struct udevice_id qcom_apcs_ipc_ids[] = {
+	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = 8 },
+	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = 8 },
+	{ .compatible = "qcom,sdm845-apss-shared", .data = 12 },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_apcs_ipc) = {
+	.name = "qcom_apcs_ipc",
+	.id = UCLASS_MAILBOX,
+	.of_match = qcom_apcs_ipc_ids,
+	.probe = qcom_apcs_ipc_probe,
+	.priv_auto = sizeof(struct qcom_apcs_ipc),
+	.ops = &qcom_apcs_ipc_ops,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.53.0


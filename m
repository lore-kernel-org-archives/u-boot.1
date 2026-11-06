Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8A606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qP0imYDv;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fFOuFgDN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BIOfF42G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A79F081082;
	Fri,  6 Nov 2026 07:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwYMAN6ux2z5; Fri,  6 Nov 2026 07:21:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E735481036
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793949665;
	b=hpPeV7ek5oEbacRMKPhd/NlynDtqskJila9W04iZy4V1LSxxqT9Tk76/d5gW3bh3uue6
	 S8vcmzmcWHuJDydAEpLubc5IG3e/X7cJS6d7Lv0wgIg8o5ZCIUH0g6VMzh0ogKMVpih07
	 sCooU5if4+M008WH4upXviZCvDfTh7Gd+V/SAqJZnSFsIej240H7JYcuSnxX/sx86wY2s
	 9f+LimAYFOPEu/6dgBH6QYHXbcX2LGCY4vjdIur3WCtGTVOm6iRy3Ppa+cxboBzGLlxZ9
	 c5EjkAWje/a3MVLXgsQ46TsepbF8mxrE0WXfKzWUBK8jwhtvF9aM2UPnHXY5Nu+DeGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C7QaGLJDdKQSS7mZOwIK+daJYoVAuZmMlq1Rf7p9foI=;
	b=f4YJK1tMK1oEiyCGgcZclw4z5SJ7AdRHDapaUf4zZ32JXvG+89d5idk00pO2OQWfGcHE
	 DY2re11gSea1xw47RwTD/jtgkosmLzJud5z7Y/vyoZ7USfu/8pxO5h2AXCBPFuBF5RF53
	 i3+mOD1h6IZ99YKBaD9pGGTpW0mgADYpUCLOoiAYEVDapDC8kemS3ASOFYPkYum6M8GNE
	 7jEl6Qs0ydU9X+pwBwxyF2KaKB+qu7ac1ORJzqLQFOzaZmG1AxKzi4MmuTJYqgjr/HNeF
	 iqXWAaA7BdWwIF4ZO74fD5bM6gBHfn50IKdGCGHYNtPfahNWdgZr/xXvHOyXhLsIwqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793949665;
	bh=C7QaGLJDdKQSS7mZOwIK+daJYoVAuZmMlq1Rf7p9foI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qP0imYDvhbbNO2Ayj+uiN1+yYtWbQhPQnSMDRye47oTUbboEfo1hcYENtebpEhoDV
	 55AmANWt7FQsXyIEL2on9X6JiQ8OuJB4nKh9PmbppllqXcQhmz09EnQ4FV7O2JCphQ
	 P2WI0rnWe0PcsvAxlRINz1qMyZBFalKn7lxfv+8oxgR3xOng9qpAQwBiXgAXvyIc7L
	 st5q+7fGX2/VB6pRSQDyWFpz9U2HqeRGS6HRtBfXtkZ1fioQv1yPi3kvYl/qGE/kko
	 recpJzvF+4uOaYTS+L6TY7nyQUvTa4viZNBBkB4OwFxC8VYa81leXzSeInwMp4ZK4b
	 yRazSaVIn5VPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E735481036;
	Fri,  6 Nov 2026 07:21:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B85842FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9C0640070
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37qDzBkHcVIu for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:21:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 607A5401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=fFOuFgDN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BIOfF42G
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 607A5401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:21:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6407dj2834052
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 07:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C7QaGLJDdKQSS7mZOwIK+daJ
 YoVAuZmMlq1Rf7p9foI=; b=fFOuFgDN67UAfqQdGUVA9r2Wh8yYDWoB2S1ZtBUd
 tEaUmqUXyXqli+dj+6K6IRwgSRNaQ9N1KLa3Bf1pFRYWd0d+ufjeOGUNsaXyjBDw
 sYK9AzGwmYqycRs0WZOD8taHft7NheFmOm/DRwo0DK5JL/zkEtPqlEcAfJ+H2xsR
 3s+qWoP7sPqqDk7R+UbdMhm2tUvOTz8MIyi6UB90+9SNRS/qz04A9g8OZNYxWqWU
 zLN7sIImqLR4Cp9PrR6Ihe2WuGyDmpA+vkoM9/fhi9lAbmrDuFmaAua2v+sGPvVY
 UDHGB90FuJLbwdrPc0u8naU8R0cMx7KnYkFmTnbTTv763g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa1n26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 07:21:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-370230d93efso178264eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793949659; x=1794554459;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C7QaGLJDdKQSS7mZOwIK+daJYoVAuZmMlq1Rf7p9foI=;
 b=BIOfF42GAkjOnTzQlfpoNK1RFT3Kc4EeiT22w74SkDCOc13sLFrlLkUVC3ae/505X0
 UduvBv+No396jcrH50RlPYvy/x6RdhSsEzN3PATxHJopW1yTg++Kj1/eV2Cov9ogQjCX
 cQCKOfybF2uTOobKv/waqHdAEWWSei0XOOK3aRjZ+jz9uDnWDxGH922HH01tNtuhipPl
 /DAostTiWyAapbxmHNZ3pqKg76mBKRcvg0QO3XlpDOxTBBOk6gRxxP8KdOT8tZNrqL72
 RDrwfVkVXpkbtWRPL/OuyOutii3MQeCLIgfRuZaD/ya72/Of8HzLehsIZS7UOnLi/y9X
 Zw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793949659; x=1794554459;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C7QaGLJDdKQSS7mZOwIK+daJYoVAuZmMlq1Rf7p9foI=;
 b=AaAxfMvOtqtRagBjhRxSu/T/X79mGcFplPujfHkHp/bmt9uKHcCly+cAwNUC7JFM54
 US2s/ULQuz/FdiN4PEEYA5Uj/S3eCeGTjz5Xgs9qhsSwJIBiiBsGPyJCZ7/A2vWoLZOS
 rIn+SlZeXvZO14/GgMwmAhFlaFTrCy9PiOKZOWV/EMDcNOQg0T3AuroFF5+uY/CWbqKF
 rP2WA3L2/TgYDp5vlMNwk2msLXVF8StBaO6kH5WbIh6X/OvXs6l3V82TturhEcyMb6ML
 7AMOgoTJlLxJII1OW1fIjBb6Df9ftF8sn6wF1HWPMZQyrLGgKViDi0Be00lCeXIZEu3S
 +v0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEYb0M+nFxesO1ri9lMb3ROn6FJfkorOtrLPVlSH4zny3f/8XzwFEn7Vq+ne42dzFasWkk26tQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+tA2favpkAbsFYVC+y3/ZCbo4Q9bGiaxup9k04MWJ0wr34hOSb
 0pwXRZtTRgt35v+TijXI/0La4EZF5MQDeKiFJZsgsRsYRl5lBT6xxHYBUk6aExRwkW0kgnRKu5B
 hfpOe3xT/Aj1pthqDOjLVSu2SDIVwZavzWqDegRF9JZ1u1cQEmYPvDHE3bCE60m9m0xfhWJs=
X-Gm-Gg: AYBFou0Ss3rwHZMK4nGSs4uImmwwESwEhIFev9um9JQlL5r5OmNNbWDm/sT8h3V0oVi
 zmDdN8A3Jd6IDfBUwycTlHgtRxuqP/n2bgakmY+1aOOgYdDqf6SKGWThd2Bp1HjYfmd24B9nFMB
 km/3gPiLfOM9rGOTIF9oYManw2YWE10ok39RidXxSKPRkJSFc+fP1EaUtbLzVkNd0v9uZw5EBve
 CG74zdNeQIC1uTs7pXh/hB6iSAqrPhlaHETFPxVR75KwYypcKh0rbuulPtT8Eg7AMbbYTSG+5pJ
 u3BCVbbqT53wiV9wLRYzRAJ2YUic+vArQgasxYctaClUC0+wFKrxuO2pZG46RPE/9h+0OzG0Fsj
 a5KPnmS8IgA/oeO9m0LcDhlmz0NU4QIZ4zWQuq/n5JP3AZftdx7NJsdS3aRAjmlZORd5xxzUClJ
 eW/QgjwgWoSQR9WJuvhkch/q3QE1tx824hH5dt4yklzji+OEESDlCC4jTusm/obAm3ePU4B6uJf
 8ELow==
X-Received: by 2002:a05:7301:648d:b0:36d:d0f2:7c83 with SMTP id
 5a478bee46e88-36f7671df4amr1969109eec.32.1793949659232; 
 Thu, 05 Nov 2026 23:20:59 -0800 (PST)
X-Received: by 2002:a05:7301:648d:b0:36d:d0f2:7c83 with SMTP id
 5a478bee46e88-36f7671df4amr1969077eec.32.1793949658573; 
 Thu, 05 Nov 2026 23:20:58 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa651e6b1sm7973933eec.3.2026.11.05.23.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:20:57 -0800 (PST)
Date: Fri, 6 Nov 2026 12:50:49 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Srba <Michael.Srba@seznam.cz>
Subject: Re: [PATCH v9 1/3] clk: qcom: Add initial Clock driver for ipq9650
Message-ID: <au1/0QXZcMK8vwJm@hu-varada-blr.qualcomm.com>
References: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
 <20261106-ipq9650-v8-v9-1-23d8919e881f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-ipq9650-v8-v9-1-23d8919e881f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfX/2G7+vUWseNy
 /lUAyXGburKWuBBTihijpSak5XWo9naWzxr60kLQ2KiP2HX4rfWXVLP6ulOCxnI/q3AXaL4pmMg
 +qQRdPqzWpxbxTCFt6tpg32dtbcnLxoqIqsJeMl5rvRGFRHdkGJj3gghB3HOPMpNtbgygY+ukQ+
 lwagjnqfIPhx4APJyliSZa4pV1KUNGR5wxqB7AMmPXt8hR0VEyP5KS0M5hcBEsyY62cW1Mn4EDe
 tRjSL5laUcXAT+wLHb2bQ/YczQNTNkNLTKZL86u2Oc2Cdg9jDvXZpA+Y6S4r36/eOlMEvR+Ng11
 CXvz7/pM7pL23X9YbYvhUEsuoUg8WB1a+OxQ+2FzAJpTtz+YP3yZ3b9hzvJ+7oh8+FqnHAU/etp
 YURlsrLRs5PSJ7yuhAvfdc6i8a49JzI0B2a+Si7UteKSlZ1FQIS4sk2e8EtVs1Z81je8ydd3z4Y
 3wxqlwsqx7ztKnKdvyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfXycrXfv0KQ64Q
 tAIsHEcp9qzITNv5TFBMykWjmJux2veTon2cDMYcr3PJNG+Fmpbcp11xNVB8sCynvmA9/oX8hxA
 1HsBsiWbqLhNHkTVLUV6dC20YgHqgfc=
X-Proofpoint-ORIG-GUID: H84kNsKbId9KuaG81wGt5KO2Dgsj-VnC
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aed7fdc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=sSm1G-tbwzF-jILS-RUA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: H84kNsKbId9KuaG81wGt5KO2Dgsj-VnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060029
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 12:31:58PM +0530, Badhrinath S wrote:
> Add initial set of clocks and resets for enabling U-Boot on ipq9650
> based RDP platforms.
>
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

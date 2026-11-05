Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED6606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FYukwhRA;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RRHeS904;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YgoEv/2a
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B257404FF;
	Thu,  5 Nov 2026 10:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKz7JmEYqJRE; Thu,  5 Nov 2026 10:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88C0440583
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875289;
	b=EQhMWiyN0ekOERBUPenDrHtSSIuAG2HMD4c+bAEeGI68m2mR6MlQf21SDfnSz51IMHYt
	 7Jk7pnDhsLOZvwsU6sGvyTCRNTyhA+i2OS8crRjY0Ngr/Ai9kgzHafNqi8qDcPMFlHpQb
	 N6YsCFmzKcNwbRPAUJQXzVDey8zEW5eFDtS2MpfaC5nQ9d8TymR9o1C/JW2BD4muhEWG9
	 iDICdgk+SltVSjbdXw5BWFRn3AgPUnWCBBctTNmfTDS9BZFaYKPq0GXEZO5ww2kvJljpl
	 kRGng8o2RiGyU3C8ywQrCOkDf+iyY0I5qRPZFDIxEKm0TaNbqtRN8B4kSo0Qa5upZbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=anj5RYW+QD0SMgskkz/EPznKbPglhIyr2mkeDofbe14=;
	b=HRHuCLvpzzR8Z1EXfV2wPi34N2Ijkf8PjOzaQPTkElgGKcBKSez24Rmpv+V8QBozMm5k
	 HAMaE/86us5O4v3LKVoiICc1JhDOfsWORoNfLQEttDAog1Tit3zrD2fT/8d7dIJpI1WWH
	 R3dBhjmb+rGkm9tE3DQFjvwOeEkkMEcJv9VuELNhO3x2TXTEno5Cx3T2c+iUj5Zt0UH+u
	 JZWj+9xzRdegRWr4OdwktEahWlJRXRMsdQJj2Q5NltY9e63dcPTFk5Xs45eSPuXS71piT
	 bn/+R33OkhiM/qn5BNIg6v34xIbu8IMevb3iHh5QxubQYmYhM4yFBpazaTgreHtCeNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875289;
	bh=anj5RYW+QD0SMgskkz/EPznKbPglhIyr2mkeDofbe14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYukwhRAQ3NkUHO3xrA7D3TtqxyqGT7gFilaZYR8VUJpFuaylUlVe1xJr1H0K9Rem
	 3VM09wH0IiHzFbmEAAl+vKQmrgAA1BuFYtWZpZoEVV/1E8BHEGYKrI+GlMZOldHo6C
	 eazZ2EZ0gD4jRT2jpYts5k+TG1JIhK0FNvfWjpkjK7pwC0XJYpGPswT/q1GWHfFbcN
	 rhll8I8AgqcwtcIdG/CUhKmMTNHVAAypAui3Lc8zXS5/6j5ZB5UmEAcZebaIYkJRg3
	 HkvoA2yw+4pcRd6gMbV8ImwPdwP63Hdp/IUiFmyyTEM44kbcKiFURVUz0xCyNKT8nq
	 ZoERz7P7Z1V+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88C0440583;
	Thu,  5 Nov 2026 10:41:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A62042AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BD9A60833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXUpppyztVOc for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61C6C606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RRHeS904; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YgoEv/2a
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61C6C606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:41:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tBjh3684331
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 10:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=anj5RYW+QD0SMgskkz/EPznK
 bPglhIyr2mkeDofbe14=; b=RRHeS904+AcLhXqMdz2JBNJYRQBFFASx3M5Vq4v2
 fs5NredzZer9fAT152E1Ih5NeBwEdOKdSn7XV6ZESbdU/6aVDcNvf7Bflg+qOT2o
 TTy7g6DukMMB2TcNmNXslyiUDgJnrNR4S/jIU8K4wlm9uJohQhVmpnzPxnGO1FRt
 3JAXOHMWkbd7eGvjJ6X+k6fK8C0JEpn6F58DPZlHf5g4/320V2dnnX+TCJmGiGOM
 3fbVc/fwCt8KLZk3UbSOnPjCrFmgmuGN/APrAo1XxJLHOS6lzYURT+ySO9O6wYuY
 SrOczRKpMPZg7f2IIoVg1SADbHYIKBrNuz3M9WvV2SS6Pw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43hkw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:41:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2055726eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793875285; x=1794480085;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=anj5RYW+QD0SMgskkz/EPznKbPglhIyr2mkeDofbe14=;
 b=YgoEv/2aN5uEEC4tgW0j4rAV0G0sFGRDtRw7fzcHUsYinAgrN/H5aG8Xpzppmz4fm/
 T+RNZE2dcy+szjKtZFk4Kk2vsWkqWrjmkQXP5Z0SOZKKJU7SV0ZffYrCMd7wya1tBIrR
 7skkXrVFSvXpe/dgvPkQS5eP8ZDzCp2WlwEdnrj/QHCjcjmIh1aVnI04+lENwcfBAjl/
 o7LuG4Oz4MlVs2j2lVybRwxAvp2b1xZtVs2dNAsHjy5YDiR8wNRSj4XtIdvqc+33JBTY
 uZS/OHsP9LsmhquhQytwzhSI7zIqFubmVywAs5ZyNEVgML0LDwAkpFGag85c8jHnAStf
 SSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875285; x=1794480085;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=anj5RYW+QD0SMgskkz/EPznKbPglhIyr2mkeDofbe14=;
 b=xSuU1l/wX/5FRnnabmO+gsGOjd5HAIaXVYJXvxw+VVZ2qXOCMVg/FqosT8ev57GSor
 ENpS0Q8XnSTyTLP2hw5eRB/mKCxIcQWT2s76GzMAIrvNwfBfNcq5OKByln+aJ6PwJgRh
 Jx73gsUTG4K+aWGnJwhRZyMsZOHlJ6IIgR3OJHpn9Txtr/YRJLANSIGOMXGtQ5VIo7AL
 OIKkZQBCQvHSnfeYvj9PvTA6qa/xN8w6MvllC7WsCOnmUAPFNMQGUrQJ6nMERGV0rOE/
 fQBaCCT93j8xgMQdzFfH6QvZ8Gs7WapsGsCRkc6dG3+Z4w/ke+4/p3Bmj4vIi0qTDlxh
 LDoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlcgpOeksPoahktotIIeI0Dr1cxzRUD2Ceaapos3vqjXS9IiqVnpvlQQK0EzQPxm53CPYh4e8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z96TsOFtZ+O2oX3krU8uqlDQlh3fQOtNcy+OQ+Bnis9ZU97NQgT
 Vs4kFPPCYwu6qQqDsm3xGzQIEtcF8/7vF1wp7KoJadz48z8AYhwBjtKaIqHaTpzn0zkS01PrBhq
 Slvdy4Nlz8fdDBYDrWuJr2cmTUCmpBwbs8x9mGss/aiThoH658n7t5NkoWAzXzLAZZ749BUU=
X-Gm-Gg: AYBFou3R6XZfczRHOECJrTmZFBurOWLS8r7bOPaYpwpE9V8YkQSgZrME6xPXkmnVb+1
 ShIVs2z/cRbFxI2224w0/9GhkIhs9RM+lS1lf4QDlNNQp+D6nsLUmVRz5Yo+rPN1CLlpjPhzwZN
 jOSIcjUqWzUAvWZGE2jM3okYLNsgsTtJOhX/5lrozUJCXaojy695rldzDwE6ld4kf964rjL2Gtb
 MZNF/ku8+gPSnCPgzTd2ibgjb3G2GRQ0Cn864lHf4H9ovJAdoQHX05erTLpB8dN1pQner0vd/Wb
 gQxjO+f8nIIhH176gWfQlQhFUvQbMfxxAQvUm0PR6mGlQw0tWWMf5LPArUdwAzNo8ycfGE+ovna
 g9UUUPn3zPXjlABkELvaB8ILiWAjcQ5p6uOEJ7ErrEeWZgXIlcvTpoKy8M7+Uohz3lLOAI10H2C
 Gw8vCJEJlb4MqLdBR/eSgNfi3SDCJnq3u2S9IMS5urU0mtLklXTNnnAhD3AVvaGapZN4NWZHkFa
 CEc
X-Received: by 2002:a05:701b:418d:20b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1af16c4d07emr22646235c88.10.1793875284427; 
 Thu, 05 Nov 2026 02:41:24 -0800 (PST)
X-Received: by 2002:a05:701b:418d:20b0:1af:16c4:d06b with SMTP id
 a92af1059eb24-1af16c4d07emr22646187c88.10.1793875283803; 
 Thu, 05 Nov 2026 02:41:23 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3958747sm5613358eec.22.2026.11.05.02.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 02:41:23 -0800 (PST)
Date: Thu, 5 Nov 2026 16:11:15 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 nikroks@mainlining.org, jbx6244@gmail.com, xerikasxx@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v8 3/3] configs: Add defconfig for ipq9650 RDP488
Message-ID: <auxdSy/oqpKcZ21n@hu-varada-blr.qualcomm.com>
References: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
 <20261105095821.3009544-4-badhrinath.s@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105095821.3009544-4-badhrinath.s@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Usw0Lwh0bB_IfIuJdi0yi6e5trCeQgSA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX+Canrbde943G
 GAu32+AmVlpq3M+CZXlW0dNN5IZZ4WAic+1ykZRMJNTkWjHDLzmjhZM2li6Qpzb15pTcOyQLG/M
 Y53PojMJGE8aWvhSmKlqq8L0CcYH2PBNQ2v2rf2eJyVdRze676SqndNGTzMsjJ/ZgDmSsEPROgO
 lusd2McooF0Jxx0V9VjRQ9dnXznD79Q0HAugUi3OvJ2lZ12D9jF2jJ5IevsL4CSJrwrQMz9L7yz
 mzUx5jGhK1CGltR25pMXJZtdOQtN+K2YKMS2IE3hJo1kuSy8371IgmOAozUYl+COsjqGmUrNsjV
 z9aMcgeTcYCZOlJtu5TmuqQFO33Cnhw2A8eOxuxv9VtJ3zWQ8UN+OGLnOrWsnzZLHhkaonHmc+1
 VB3Yx3Rz2YmFUxOwmLspHTzUHEj+fRH2N3rskWqikPvo8vrJ83Whww4QOKZzDN197lP8E6HckEa
 vp3K05Iq/dQ0zrxRwYw==
X-Proofpoint-GUID: Usw0Lwh0bB_IfIuJdi0yi6e5trCeQgSA
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec5d55 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=UwEQbcAECfZgYlFb33gA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX4A4Q7gXEunL3
 gdxMnhUy8jSDAAkZIq9OR6JAVmS0qpNUZX4+FkQBKX/YIAtSwwEA57G75SQBop+zum9FMHBFS6X
 7KfgAfoorYr+Dj83+ZCWo512eLKfSqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050042
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

On Thu, Nov 05, 2026 at 03:28:21PM +0530, Badhrinath S wrote:
> Add default configuration for the IPQ9650 RDP488 board with eMMC boot
> support.
>
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

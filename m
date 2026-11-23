Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D42606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nSJy3QA9;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ax/Q+qE+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TD3R5i/F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A1C660712;
	Mon, 23 Nov 2026 15:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iogrIpO6bvZP; Mon, 23 Nov 2026 15:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6A0E6078D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795448538;
	b=JLEOAKBf4yihL0dzBT1iJ31nc8A1qkTw8Uy07kyMQpnneOHrfTi/860rkFo3P6EY1g7f
	 JpPo89lu2x8GEX78goTeb6/fyB+KWiVYO5MnVijehJGjx2LNo50s4y8BMngvFCPbLA8GS
	 +tFCkw1PBwNpWsH2s1w8VlfCRHk+GlPT7UQBT0jDm2nYxLQGsZJBQgsV0Ioe2Vn9pegTw
	 yMGOfzEDlJjzTXsrS0Kd5FtTxyWV+2GXHM/Sg9U+atF1aTjbNd+lHBxEYQk8eOwRlwQ3G
	 xbGuacNubn6rWcCJZhp/ZR6dY8xZWrpJFF9nPtv3zIBr0gcgj99xS241KgSM5IaEutQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795448538;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qQQKu4M50UZvDwhHXFMMrWziDL+xZU8Z7tJfCcMFbBY=;
	b=O/gpbenRo5uSDGn7LLLQTkzn8ONjMkRjWB3spRWkeGJllNesGNfJMBfjqKt1FdMr4Yxx
	 C4axBM0HThQg80FWrxoPk7MNZqeGwsIiTMaRUddBR9clWlq9G4mWARx7L8031WLtxM4t7
	 K1dMYWuYEGjSFwjJJ5BRRTyDKn5PHGQ6Zrh9B68JURfGtE95QTulmwP5XUg5wS23EVaXL
	 CTm8uUw8zHu3lN/MwBwnl5RyEJqUd62kaWHDR+YC6DCR5acMmmXy7GnjamTj2Los5WnRw
	 z+mxiK6sECthYG/ebVGY+6C1MwoKOu4JEpe5Grp1ZC4pta8LKbXUprrv7b3ivJ5Ouig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795448538;
	bh=qQQKu4M50UZvDwhHXFMMrWziDL+xZU8Z7tJfCcMFbBY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSJy3QA91TkHFe8Sqz4948yabLYoXXr4fJLh+zZbTM2KuXTRBV7scb5pIUTe1lXnh
	 gnFuRgdft0IQIvPpGyOFabt+N8zfZHQaGB/ojvmXmD8AtMHceAeN4zsJSdKhnAMQZX
	 S7tBQSLLfNQwdmA7bzxggkJ3sdFzhkQ4BL0y9yvJ7pfYZSSG0GlI9n5HLSAcTDmlis
	 aaBu6sHxHdHIDwE6uYJ4ZXWENq7hBr2z+mFBDekRbR9Gr89hn093x8fjuGFnvhjF0m
	 DEsXcfCEzfrSeLV7+FhfdmYnhlk+6HvQ4m8ypKlZbT9zamC6oW01I+lxI5JZEXjQlS
	 7oalSdSNLI93A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6A0E6078D;
	Mon, 23 Nov 2026 15:42:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 009A422B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA7CD40707
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSsOvyaGoEhY for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:42:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D15C04070D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=gopinath.sekar@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ax/Q+qE+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TD3R5i/F
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D15C04070D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:42:15 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKuaj3329299
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qQQKu4M50UZvDwhHXFMMrWziDL+xZU8Z7tJfCcMFbBY=; b=ax/Q+qE+4Py+9jNs
 M3Xx1symtsxu1bVY2dnIM+zQGJKS1hbVrPO9YVNhDB+IRW/H3JYAtqMS5SfflPPs
 pJydnD15Wz4/jNdfdFEGszGIPiaQQGSsw5cyvQmgSE96F0JjGc7BVzN9I8+FQK1C
 +cvly3IaqyVopOBqgBYkxL+iecDd6ugXmJ2LaAEZCfIQLdQnlTmkCvZrCxeyyekL
 rzUBMqCb9GB0uSL2Eas154Y212BvkRfcfxR7UDNzbvA+KR+Gq1GOzFGG7duCCU7W
 zepAvh/n6sxZkSAn580LfDPqGs51bg0wooBPIpVcG80z0AN46A2MhGWj6s5EI9jA
 a1dGYQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd25gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:42:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3847a8f4e77so462983eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795448534; x=1796053334;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qQQKu4M50UZvDwhHXFMMrWziDL+xZU8Z7tJfCcMFbBY=;
 b=TD3R5i/FZ3AOGJ1inzkBHtvVWEqza/KfHvIm4jM4XElMa8thff9FSG1jdT/LycYPdP
 JV2qIMkqld0QKaergdyQIDRT6ku5Oal9tlDHLaNQVuTC/c4GxBAkQdW0NB9kUHdXiRZe
 VwwuKXqtQdtIM2BnoNfsBq8phN+7TupcwZVqCS678qlONy94vw0BAYmp7PQdC9fR+L3E
 I6L0UCHq0sTwHN6lhqa1UjreaOLKqMgwGHLUTiWxHov3RUPbh+pcNToBreFp+c9ml/Co
 Vs0c5e7nm2wBKMl1Ogv2uPRIs2/w2ek/vVB1B/o9V5U658vqzJJTMYWuJJBXW/PxnTbV
 G4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448534; x=1796053334;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQQKu4M50UZvDwhHXFMMrWziDL+xZU8Z7tJfCcMFbBY=;
 b=eQAlQwCKk1SxYCrJ/Rpdqp7vVul+6sTz1ERHNqbdaRb4Xn3uB9mPZtRuEmmIrKnoTV
 VuhG9gwjXCO9VahU63xCSRaN8miPDi+hfvMoMkPHWdIr5gWRyafAshysTAeH035rHylV
 oXkmr/J+zJZfkCe9s4KzC2Uz6prMvpW75E54tEs1U1B3/89lEOlcM4sfMvoOIsH5eHCn
 UqyHTULn3L/1sbTlx7GewGLYVBxcUIcZtejMpKUlGnQrsVZJa41I+JaO9VWonshVpqmM
 QAtwGW/fyvcG6XcF8dPsKwczLzp2gndmE4ev3Q0OqtjAo6I5NnNF2OxpgAv1c95kBzhZ
 g9DQ==
X-Gm-Message-State: APuU4Z+N4b+FBSlHL6+yIq3FdQ1/MRSbYggp5apVt1G2+x+mQed2DfDJ
 dDJQwr+pCQ+7RjdHWXDXlJRe8WNzZwTZs6hoPrFdJv/+XG5SaVnu4oKTf2mdlggTwJN2ywCt8d6
 L8AMu+lpDO9f5aClNb3dPawZMJwCZsrg27GOm9ipr6OWDy3OIvTdFIdoXF1BfAwsonslRTtm+Ye
 J/7Ck=
X-Gm-Gg: AZFdTZdr/E6AKQV45IRUwK7iK63LKCOvCCYtJyhinMjBtdB0beYrJnh2VJe+IYRs+5j
 WZdmogIb9QCV3OLkNrB38vHH+rEtYZ0YY0Kr7lQJs75wJcZAWUTrfghWfKkglS3B2UNlWk837vJ
 yQ5USkSHHKML9S4Wh+9LSFCS8EATLX768YAphDN0lwODrPgI1Gp3WKqDJh5dEJxp425DfcmlXcw
 xHvq/5q2j84Ii/wMVcm7nfZTuRE2wCquPebaCZyo0s5Li340Rcz+DdCaMjqAb25zEg0BtkwX3f0
 BrV+pS+cq3vzmVQY3X8uI5PJsPDDWTpMDnFAbPPtXPmvFlWqceTDfHj0Al1k+7yeBVpJvclASYH
 RoyR/1OBJpJ2avN2oKG06W9MeKZy3v/0UsYvoItKnHFBBNmFximaZtodod2/UBsGDBUiXOLOOSl
 8HVRlHOw==
X-Received: by 2002:a05:7022:3a82:b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b5566e1086mr19350617c88.0.1795448533737; 
 Mon, 23 Nov 2026 07:42:13 -0800 (PST)
X-Received: by 2002:a05:7022:3a82:b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b5566e1086mr19350578c88.0.1795448533127; 
 Mon, 23 Nov 2026 07:42:13 -0800 (PST)
Received: from [192.168.1.3] ([106.219.178.136])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5567ff27bsm31549542c88.6.2026.11.23.07.42.11
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 07:42:12 -0800 (PST)
Message-ID: <125233e1-41d4-4052-b832-d340fe8aca43@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 21:12:09 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] net: dwc_eth_qos: support 2.5Gbps link speed
To: u-boot@lists.u-boot-project.org
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
 <20261121063919.3313168-3-mmanikan@qti.qualcomm.com>
Content-Language: en-US
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
In-Reply-To: <20261121063919.3313168-3-mmanikan@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: twXivbBC2Zc4gMEPnT6B512kiuw4pOeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfX6sAGvtqaII+6
 e6mA6iQJ3TkbZK2h7UhoRMODuSB4iwdqp7HuLWkq1WpBryU0C14s3UQYl2477a9DEpcuSycj2vS
 Dg54q03zaagu2WXxBnLvGClf4diqlOXD8X5S9wJpJSG0IEL3r+efB4Fdt5GdZgY5GtBY2zAnphD
 8eRPLKXGFe5PLP+VcAD1PzCl/0XYxTFuYvY1CP4f/i1HjsWVy690MVF+j0j4aMM+i74yhArJFTv
 PfaD26qhtVZU6Is7shmDJGpKa0WSGzQrXODca+WWkkDaDcohYxT00ZUHg70beBCwDN+u9YaSmtu
 fitUEc1ge66PViHtIQNFzDVdDEz+lXnwReAt6SLHfP5BtuBr9IMuZSHX3EZAE0ZoEHVQVqfkCYQ
 Zq0obeboUHd2Gnf+8yM+bgAhEQ8FjoNFTvWT/7RJtpQUxnhV7arxpHCLP5evPfF/UPDgKZf4rJx
 DoPK1oH8DODLPlKfPLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfX0JOYEkmhdxaI
 ne2wk5Nst0JwDGbbfA1/iN137lfPUt22NxLWe2jkQcqMR/4FYvtCjdBUjar25nU7/hVZiu7JCLs
 bfXrj59LuM1sZTQLpInAS6ou0r/M/RY=
X-Proofpoint-GUID: twXivbBC2Zc4gMEPnT6B512kiuw4pOeU
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b045ed6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=jCNHygwvtdUFbBAtyvamYQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=C_cQu5VisY103tzRSdsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230062
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Manikanta,

On 11/21/2026 12:09 PM, Manikanta Mylavarapu wrote:
> From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
>
> The MAC port-select and fast-Ethernet speed bits use the GMII encoding
> for both 1Gbps and 2.5Gbps operation.
>
> Handle SPEED_2500 in the generic link-adjustment path and leave the
> platform callback responsible for configuring its clocks, wrapper and
> SerDes.
>
> Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
> ---
> Changes in v2:
> - No code changes.
>
>   drivers/net/dwc_eth_qos.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 6f158202124..de06bb46151 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -557,6 +557,10 @@ static int eqos_adjust_link(struct udevice *dev)
>   	}
>   
>   	switch (eqos->phy->speed) {
> +	case SPEED_2500:
> +		en_calibration = true;
> +		ret = eqos_set_gmii_speed(dev);
> +		break;

Since both case statement are doing same functionality can we write

case SPEED_2500:

case SPEED_1000:
	en_calibration = true;
  	ret = eqos_set_gmii_speed(dev);


Thanks,

Gopinath

>   	case SPEED_1000:
>   		en_calibration = true;
>   		ret = eqos_set_gmii_speed(dev);

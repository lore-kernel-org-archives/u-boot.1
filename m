Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1686BC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 05:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD69380D7C;
	Tue, 21 Jul 2026 05:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SdpyXi-9ID5; Tue, 21 Jul 2026 05:59:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3C3F80C67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784613565;
	bh=S3AecRDKdQmz6IW/PT1T/SECJcGyvsdgymKBgb7tZFU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mYA6bCLPJ/T2RXojMrd9Y+56mr9e+riTiCIBvI4BYl+S+oUStq60y6BkhTv6GQdlK
	 gXnUpzCTOC93M2dkF4Y1f28OOy2T3EYwyD45DdAZz5iOqAIAS/dECaRzCwHfZpfJNO
	 TgxHKGcZM+ZZAkQH/U30o2ZTQqJfrctXenBMGhPdvcEdZ0fDcG5hsJS4OuGiszZ8Ra
	 fwL3upj52eF+QCvM/sNJTvErUydUGP4wrGRwxgg9p8+PmTPZoCToycofkbQkHfZhaI
	 Orhc/4Z1qf6nEy5KDgmL203V5/uz/+7qpaAnSXIPr5zeX57LvpTMOgRhnptRuEC6I7
	 UmP6X9yH8urYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3C3F80C67;
	Tue, 21 Jul 2026 05:59:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F13F9E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1592360665
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isTX77mZw36y for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 05:59:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0D2A1605FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D2A1605FA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D2A1605FA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:59:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F28844F6; Tue, 21 Jul 2026 07:59:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F38803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:59:17 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L2T2MK092114
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:59:16 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a8r5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:59:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e2237bc43so12420593a91.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 22:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784613555; x=1785218355;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S3AecRDKdQmz6IW/PT1T/SECJcGyvsdgymKBgb7tZFU=;
 b=jHLdAsASDDZheiCYfXwhicaC+CDaZ5BPN7AgXiW8aq6ID3wWIpVSJ2bwIYO3IovSbw
 T6KnBAEhDnRijfMXNGcMdAkLT+NhWjjCFVffgTVZ5Snu1EngawkW+n1eQyqjY6Bg0Bkd
 BeAvO5tsvgPlupNEIWs6xOpbrXP52Zo2/IoMAe6h9Q7NAUrqdy9q3VnJtyh1KtuXEM8a
 wehEsmYdAH9lwu3PzLM5DmnxvJUKPo7/BD07M7j1tB2FcnchECwglcE3Jz4a2DuRwmhI
 jaYw39hcE8za/T0rbPjSe+sRvRNWglEso3RG6rBonJcpX6bY05SuI85hJShEwjuNpdU/
 n0Qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfdUwE68y9cjMxVAm5FUCQYK1chGcd77KyIt3tqzjxN2+1PxOy3rLmdKvcMrGOy3eurO5RXaU=@lists.denx.de
X-Gm-Message-State: AOJu0YxS2PQFGR8IEZwpyeugw8f44ItAabm7PD7qmOhdh4ibWH+kPeB7
 Bopt/oWfhtDpJ11R8OQtyGsiVzIAYDBi0QmFBogS+AM5gH7D3jTJRGsMDYyKC1X1k/uU9J9lPox
 J8euzyZeMjGHKMVEM8c1z9Ucq38xgJotM6qxFevrZn/Ze0oFfIssZ+GRydN8EobI4
X-Gm-Gg: AR+sD13j1YgJU27FfJLNVlvSNv9Gn4kHLn8T6gtJBYY6NJea0Zruaf0a6UPYUk+NdAf
 Hu6fDzmmg1GsJYcVtOkVZvpM2hLRcaCukw3z6yNiVH/tDV59j2GpunN1dmRqQotTdRCtmgDehcV
 KR7TS7FImNAckPoABRfRiYw+Szr8Bd1EbWxgAG9VcXkr7vX4MBdLeau6V92TqScpCChsLua10WM
 YlWIwiNdXqsomJnb7sURrEnbgLYyb9IMli2rUiyFTvwVIIjhk5pP5zmEwc6Dfta3bwubwIN9O+V
 2PxAWHTehL6Rx/q2dbuBVuje097Ym4w/FAVbYX8QM96MzvEqZBrwM56k9+dYJTPBOAf9v0dYCiJ
 MNMU/EuTZcUkxSsTljev2jXyZox87c6IONI3pxg==
X-Received: by 2002:a17:90a:c104:b0:38e:679f:3b2a with SMTP id
 98e67ed59e1d1-38e679f4dc9mr8212657a91.30.1784613555164; 
 Mon, 20 Jul 2026 22:59:15 -0700 (PDT)
X-Received: by 2002:a17:90a:c104:b0:38e:679f:3b2a with SMTP id
 98e67ed59e1d1-38e679f4dc9mr8212645a91.30.1784613554709; 
 Mon, 20 Jul 2026 22:59:14 -0700 (PDT)
Received: from [10.151.41.190] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2900a37sm34924523c88.0.2026.07.20.22.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 22:59:14 -0700 (PDT)
Message-ID: <907fd260-0fb3-4d56-abf5-1fba95cd7f7d@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:29:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qcom: qcs615: align storage and environment with eMMC
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Tom Rini
 <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
 <fe9645bd-db37-4210-9973-8edd115d8e35@linaro.org>
Content-Language: en-US
In-Reply-To: <fe9645bd-db37-4210-9973-8edd115d8e35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f0ab3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Trqzf89keulCeZyZW4IA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2MCBTYWx0ZWRfX9emIZCtBjKJw
 8LXtR4eh8jZkfbdwtfFz6vQk5t8VOkPNGkJIK6DPiwnEm4rTFEfcyh3oGoSrHiP6WqRIV8ydD81
 aJoGbdwkTEglQhjHkz4ipuDIFsZKWOMWOch0QssKLeZyGoCQbSA69uPAxAzU05q4TvfITfMUopg
 ZEMSCBYWV23qePYpdDkyiz2zsv3oCMaLQBhd/pY+q2/JSGv+RGHrnlbEWKr8QLjTIRYxPYBjvaC
 ll9AOrxRktp6n3c2f15fs66/G1kqXSUQIfto3ZhX/PjnbFlkUg7Vm1KPj5b6RFtXCttvoVn4oQL
 3MKlZlaFOSc3GTm1XQiRKeCBmfNyuq/X5tXgCMZj+0qecEorXNjYw6xAvNCvDbBWPxJm661rt2V
 6kOJXt86I4rpLV333e/JnCwIDu4jcp99+jcvMhETG8FIeLb4KT420eL7lity+4NZYXLwpkaETds
 o1SiVJJ0VRG5zroztsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2MCBTYWx0ZWRfX3G5bxf1URaik
 R70KCYgip+AVWhABmtgq7eqGutl7mZAYwouQpiNKedBklWmKGE0zU2OHs9kud71WbXAY9Izb/gS
 pbKaJFhJHrg1PAhFk7s0PNjghCx71nA=
X-Proofpoint-ORIG-GUID: XfVR5ET0NurUzjDy2GAjMdhdIyIBupM_
X-Proofpoint-GUID: XfVR5ET0NurUzjDy2GAjMdhdIyIBupM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210060
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S3AecRDKdQmz6IW/PT1T/SECJcGyvsdgymKBgb7tZFU=; b=QVo/VfqjGyh/Eo5M
 mue4mBnKIxF52RlhT0eezgAnzesZzjoAMIE2OBlHMVWUV3FCsmYr9/GS46B/EKCy
 zz/g5FcV/tAL0n7d8gV6aY36acNgbpeGHo1glS55ltz2FyxxxFJmCYDdPr755HXf
 pyeF49v/tTiwxT0BwXyHqURkwjDT4sIt/Rg8yTqh5lszm9CafI/sTUXVzpLqIs3k
 3SjhEpdP0CFhXq03kN1HOQLziWXQaOaMkINshBWCmok0sgQsIJ8r0dNYhH84Ff1O
 OIc9kV7hypeMxacwDjCO+wthEEFEHNART8u/x1+1z8WBuTeXXBxY2os4W8ZTaJ0A
 eL3I6g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784613555; x=1785218355; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S3AecRDKdQmz6IW/PT1T/SECJcGyvsdgymKBgb7tZFU=;
 b=jqrYFCfYUevUOCD76KhI94cS8mObK/m4yu5F65fRUQkEN8J3X4fsYSBsLjGRdfGNJw
 IfkjJbQhnQLPullmOzahHOKEuEvldhFg/N/1gt8E75GD1+oH2WZdDv879rYacqdyNmMJ
 5AU8lioxecjBgfhIuHLR7a/ufgBHK6FwJ/S3GLnAXVwRA+jET7wiQHQ/4gj26Bh2hUPt
 gqtTK1bEHoEdSuHE8shRGmNmsnv4s2hByapdHKlNm23kmkeflhMszGD3o/zWQc+7VNQB
 2BrnyFRUStPNqciXUyqqc8fbZUjkxhYVsPdEtzzbEble1XziSrDV1JAk0zUcJqaVLc+b
 Domg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QVo/Vfqj; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jqrYFCfY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QVo/Vfqj";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="jqrYFCfY"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Casey,

On 5/5/2026 6:52 PM, Casey Connolly wrote:
>
> On 02/05/2026 04:01, Balaji Selvanathan wrote:
>> This patch series updates the QCS615 defconfig to correctly reflect the
>> platform's use of eMMC-only storage.
>>
>> Patch 1 disables SCSI support and overrides inherited fastboot
>> settings to use the MMC block interface, as QCS615 platforms are equipped
>> with eMMC only and do not support UFS or other SCSI-backed devices.
>>
>> Patch 2 configures the U-Boot environment to be stored in eMMC
>> using a software-defined partition.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Request to pick this series.

Thanks,

Balaji

>
>> ---
>> Balaji Selvanathan (2):
>>        qcom: qcs615: disable SCSI and use MMC for fastboot
>>        qcom: qcs615: store environment in eMMC logfs partition
>>
>>   configs/qcom_qcs615_defconfig | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>> ---
>> base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
>> change-id: 20260502-talos_emmc-fb6a079387d7
>>
>> Best regards,

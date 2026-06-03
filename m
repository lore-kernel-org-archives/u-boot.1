Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71402CD6E56
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 12:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F198469D;
	Wed,  3 Jun 2026 14:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="COl2msM4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XveQz7lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FB084857; Wed,  3 Jun 2026 14:16:40 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137A083FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536ROA7873796
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 itynGHse2rua30OqvMSQ0V6O3a+o9Pr2fHLvYBlHJdc=; b=COl2msM4WWmNfMQI
 NuglblDU3slHepmR3Uf0RjHhQHiur+7+forBJBaF9/7L5JK+C584FOELdIU96uVX
 xYMkI7dOJVaFZn1/FZE3w2HdVS6hdV74aYXDWqXwQH2gywA38wwIiR16sEZhjvXn
 6FX6tVcyWWP2Sxd+XCUtd7u2iqUPueNJWvSzbj9H98OoFZkIxBjP0crqmRBe73qA
 /q3MMKACZlvYnM2Ckh65N5g80r1uNHpLXumlMbqX2Ga28kkA9AB/CbGsqkmBrble
 h6VzSeYT5FgkTgSYju4X550y2WJuWQnXs7sqb5+aQcDhGTmKf9C/TRKPZKApavlw
 39ymoQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9kcqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 12:16:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c10cd7df22so34691505ad.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780488995; x=1781093795; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=itynGHse2rua30OqvMSQ0V6O3a+o9Pr2fHLvYBlHJdc=;
 b=XveQz7lOoBfhIx7dYwGNTrQGNvB1Kc3R4ZqU1Cppcqc4FB5otRMsy2P1l/zeewyFZg
 mnktLYN3kkVWep3MYuYXT54zLCOPISbpExZx3QRbikrJ/9OgQz0I51SrdYbbbbz5dA8/
 sN0aL/g/KECPEkiJsq9YlAi8FuHMdGR8pzqCiVaxobYd5Bt1QIafrJCu0/6M/SUCSXgh
 RNvCPv2usg8M5mpi37RPaFYtgC08jMYeVU+cVY0gobr4fTy2fIuYlC3A4IxugzwDtVJf
 f4tJFeDvauf5Zr99A1q7cLenlYRT1Dmii7p7kfL+fhMwMugfMfN1HnvhJ+QP+6SR9cH3
 vvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780488995; x=1781093795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itynGHse2rua30OqvMSQ0V6O3a+o9Pr2fHLvYBlHJdc=;
 b=CS/U2SNtQLASI/kpzptclGMDSh6goF8Rnh+2H/1cTbstHf3Jc3mSZqbzOjyb5AafY8
 dsGTpzjwsmM1lRpLYM+8ytLUw30bIT7eTGTrmZworyUh4cuHJEEgaoKabPmwvOapcZ5D
 kIWJ4c7azkO5rytj5Is5JxuyCPLHY4wQYMzIKk1NUcoIdEWeGMDcUi6Yp1Z1jL2pxM4M
 II8vvghFi2K/eGcNP2rrL/+W5biZE7puuZu/JAgaBY9k04MDOvO9Ajf73qxfWjKaJWB4
 ARxGyXjTMYhvxi4dbXM2yqU4koFzyN4kltlq8QnK1hi0/ddxg770rwSM0Pne6/v4Tsnf
 I1dA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/H1KNCrwpQVixncGG2LsqhTjRvPWoaUITK7HdGvcCyONCzvyctjeVTGhPCTkCrkpK2iK/1ueE=@lists.denx.de
X-Gm-Message-State: AOJu0YyD7Tbtsnj2URTMSM32cZ40a0QgvlXDZL9uokmVzoDg9mw60rRY
 z5uLdJTVk9w9DNNkTLlHl3VtLhFkaiaJh+qL8PFqGnLPDVi7eKCAkxLlbfrPyy/0Hw3P0BKRsMN
 +WfyMhGPF+XsMSrKG+Zl19QuyWY6ZEo+t10WE5/R0huQUTZCBbUu843BM
X-Gm-Gg: Acq92OH7WHLSm6JKea2rl81nu4QBtoLE33bZ+VC56aLyNSpIrDSFxf/7PKKK2hSd0rW
 pMNJu5I8FvzuMHEhLoRRlvARykShgVbexFVIBoiAebGkceL7rKLrN9o439lDf2AOqIkDJ1zSO+b
 EfLEjBHvmu1/5OsQ0q5owin5SOarZyRPImiP5bZ4ywbxzlC3HUMcnvxYPq7KF7dQPY+IRq/hu8r
 iGxvyI3yr1c6V+KCsZt0es2KjrS2/CBPXQPPOKIUjSSDte8Ghylgraomf05sfREbXXp/JlHG8qD
 9K8YNDkkEnM5aghhNzTvzJnbv00f6ubhXO35cVXfD65bsPzAUOy+L+M8wSDEwYfVJ0rEIg62zcr
 xiG0xpbFRxPbcaxoW0ILlK4a9YjfCqHyZ9UmQDwoHbFK3b5W8/oOoc/OgfE7dsvEXF9HxRdlWZy
 em
X-Received: by 2002:a17:903:8d0:b0:2bd:c5f8:504f with SMTP id
 d9443c01a7336-2c1644cc056mr32359545ad.40.1780488995485; 
 Wed, 03 Jun 2026 05:16:35 -0700 (PDT)
X-Received: by 2002:a17:903:8d0:b0:2bd:c5f8:504f with SMTP id
 d9443c01a7336-2c1644cc056mr32359105ad.40.1780488995000; 
 Wed, 03 Jun 2026 05:16:35 -0700 (PDT)
Received: from [10.152.192.83] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df04311bsm2110167a12.9.2026.06.03.05.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 05:16:34 -0700 (PDT)
Message-ID: <f87a07a9-a580-4eb6-9551-cdfdde5b1c07@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 17:46:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: qcom-geni: add DM_FLAG_PRE_RELOC to geni-se-qup
 driver
To: Casey Connolly <casey.connolly@linaro.org>, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 gurumoorthy.snthakumar@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com>
 <778d8313-7140-4086-997f-8c94a5e0e1ae@linaro.org>
Content-Language: en-US
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <778d8313-7140-4086-997f-8c94a5e0e1ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ld0-dc2A4UXwV_-io9FPGd1Qh8NTeNN_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExNyBTYWx0ZWRfX2iitKoc8lIQk
 W+61msFyPxIgFbgs1zL0OzGcuHeABNOa207zx1L7PV4xMpcWhuF5hicJ42Qibyxszjc5u1KgESj
 Y715hrgSoTffe7O04LpP0w7k58yieOjev8yD3eJByWKt+XiiZm4zgY/G1J7uU216dIRoe6GTkAz
 C6FQ5FNJpBdl4RLyjfnAuEUpUrLWoO3e6ipmq90soPJjiqgjKI1l9ormsthrw4k10hwJFpDM9SE
 d/FnxzI08iHWIQgeBcIVZvvxUUHgOrqJNdEjqDEa/KMUmYFmqpqhOkkPRfaIXXMWJaQ5DFFJxzF
 lXaxsGB/KDkemRiAZzEsYW/HEsUoMZm92fRVXP2xQNW3/T54PlJw2XeZlj+aDAMTWKilZ6n7Jmh
 U07yMIuKXOs0oEMJESCQMWF2bJJsiVIQoz1iw/63lfl/JAt7eXp2/wyIOKCM92rRNwwCHC1MBv+
 UGKGnPuCd4xq6JldDeQ==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a201b24 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CFapTc-p2J127mD2na4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ld0-dc2A4UXwV_-io9FPGd1Qh8NTeNN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030117
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Casey,
Thanks  for the feedback, please find my reply below,

On 5/26/2026 8:26 PM, Casey Connolly wrote:
>
> On 24/05/2026 07:03, Gurumoorthy Santhakumar wrote:
>> The GENI SE QUP wrapper driver (geni-se-qup) needs to be bound during
>> pre-relocation to allow its child devices (such as the debug UART) to
>> be discovered and probed before relocation.
>>
>> Without DM_FLAG_PRE_RELOC, the qupv3 device is skipped during the
>> pre-relocation DM scan, which prevents early serial devices from
>> being bound. This causes serial_find_console_or_panic() to fail with
>> "No serial driver found" during serial_init().
>>
>> Add DM_FLAG_PRE_RELOC to the geni_se_qup driver so that the GENI SE
>> QUP wrapper and its children are bound during pre-relocation, enabling
>> the serial console to be initialized correctly.
> This is a non-issue if you correctly set /chosen/stdout-path in your
> DTB. I'd rather minimise the devices we probe pre-reloc and skip this
> whole dance which we will do once we get
> https://lore.kernel.org/u-boot/20260401-casey-ccf-compat-v2-2-414d5b7f040b@linaro.org/
I've addressed in v2 patch
>
> Kind regards,
>
>> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.snthakumar@oss.qualcomm.com>
>> ---
>>   drivers/misc/qcom_geni.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
>> index a62ae6a2478..cbad7bd3bd2 100644
>> --- a/drivers/misc/qcom_geni.c
>> +++ b/drivers/misc/qcom_geni.c
>> @@ -576,5 +576,5 @@ U_BOOT_DRIVER(geni_se_qup) = {
>>   	.of_match = geni_ids,
>>   	.of_to_plat = geni_se_of_to_plat,
>>   	.plat_auto = sizeof(struct geni_se_plat),
>> -	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>> +	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>   };

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B35C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 09:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34AEB407EC;
	Wed, 22 Jul 2026 09:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjH6992sP5vy; Wed, 22 Jul 2026 09:24:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C180407CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784712242;
	bh=EmRqG9SVoYfW8IqG1Aa6xeGCP4xxMTCR51eQ0ZpygBo=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KHERtlt1nzC775pu3Gqm/cZ9y1bdIZQpJCDxxchxQEXVxxf39ywTCt/pLd/Y307nn
	 4/Yo5zlAY9mnjNjWFSqQ41gn7Ov+QYhYA+1j9DcX4e0CuCXosgr/mDT861ZJ9TpQ5n
	 8jEDYW9hNuCiEGfRi2wQirGNAzOY+n5Qb2shF+VDs5X0GHFnBPk/QmnRkKgqpWuIZ9
	 LMTKZ9GOQWDYxQRYvq9G4lYZYK8w8Mq6uEr5w1TIOivUlk+OX4gwnE8cwOvnO20+Ny
	 sHnF+7B53LbqkuPfzDO3wJdALFBm/LgQxgUWEfQCaInnF5mI7m/BnWMPU67BsZgO+A
	 4AxBj+pjwjPAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C180407CF;
	Wed, 22 Jul 2026 09:24:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C25A8224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3B6A80E2C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHDKkQiUaYQJ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 09:23:59 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=balaji.selvanathan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 486A980E1A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 486A980E1A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 486A980E1A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:23:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C54848BA; Wed, 22 Jul 2026 11:23:57 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECFA803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:23:54 +0200 (CEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M9DoL6049857
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:23:53 GMT
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fju228180-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:23:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so9826115b3a.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 02:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784712232; x=1785317032;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmRqG9SVoYfW8IqG1Aa6xeGCP4xxMTCR51eQ0ZpygBo=;
 b=h/J9Mj2kEen7PsIcoI6KcmcIFOFbPx6CzaE/lsYa0UgPctwh0/pwE5pD4Pyi/G36sH
 mEdk4PF16soc+Km/2BnUcN8D0YnHr/0PVUIdsjAFMTFZ3RaqrrWF/sTxdLN6urVtHnQA
 NE2uaP5eAl8iBWguf3SALzLl8yLS3q3HaOqUFbmZy97gSV2NEjP770ek5UGGCNyKgu27
 D26LTlIxh+eIZPtewjAGARXx44FCjIsheUoqRKCuNDcJUZdDAeJ7q9x3tNspPIJOe8X+
 GUuk8ii3papJgUC9qUPBASTE/G97ogOUkGChwV5i/hFVHAEgMOnY+N1QIxBJyGACCkk5
 89Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoX9mrxdj2ivwS1UX6O9cXcqeHj1Iv3nNjYtL25GCb6stYxriYYT0Hif0WogKNJC28TNpG0oAA=@lists.denx.de
X-Gm-Message-State: AOJu0YwvcWuQOjvuy9cXs93lvhArMQTmxSKDNT3IuZRUE6O22ek4UkPp
 FjDNW7joRBdqon7MZDxzDj7HBAm4iWSxkf1eXfwCSsEYegLYsTPmsql6jwOmmj7FbHkX24FTUoK
 P02XT1Q5ujkrxRUbkaViI2tuMOSRcUixts9RM5FCH3uG7iMIt/JGm9We6
X-Gm-Gg: AR+sD10Z3jo3CC9CuNohYSOXqLadVWFyQ0pg66iE9hiZT0E4HBMn0XWFOXQr51VVI4H
 4TJMwGht969dS4XFecm/5li+DS4Xt24JffCW8HawVNhLldeo9GR4l98MJmSwiL+DIP02nTqLcVo
 daREgFjmO+oMsI7RopU8bfoFxo76P/66+iGiFImY+D6GpzbXiuTNqyDcQmDl70mony29XjNRy5a
 Hn6L7ymVwQyv4EUW2PvGSpn/pQsbcIPTrXOlmTzs1bfjREf1KvTZsSRNUEw0U+Qhab9cpIJHEEP
 f+7TJkIw4a+329BQhu9R8PE0rpXu66l7HxXl6tpSeK07u/pMIVLOfZQW+g2oVtMyYH967bsnFrX
 K41H37zUNqHkJ0EklG//cf6WLg/hCrnSaiqDxOg==
X-Received: by 2002:a05:6a21:511:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c3ad9dfdf7mr24364479637.53.1784712231889; 
 Wed, 22 Jul 2026 02:23:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:511:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c3ad9dfdf7mr24364425637.53.1784712231162; 
 Wed, 22 Jul 2026 02:23:51 -0700 (PDT)
Received: from [10.151.41.190] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09a9dsm7399277eec.19.2026.07.22.02.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 02:23:50 -0700 (PDT)
Message-ID: <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 14:53:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
Content-Language: en-US
In-Reply-To: <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4Bi7mTe c=1 sm=1 tr=0 ts=6a608c28 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=BNVYgyeMIbSqxgrTfJ0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ctXDPh0mRxf59Q9hgTaMyF1CT_3lHPAK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4OCBTYWx0ZWRfXyOLrI948uhut
 4fmB/hM+bJ3F2AJJuCj0yBrCHIy+6325lAGpFNk9RHn7vfV4JV45/ngeZQbZtVatgUNZ6qKIF4H
 WnmEPZSe26CLhsXJbNI1nzvknhwXOas=
X-Proofpoint-ORIG-GUID: ctXDPh0mRxf59Q9hgTaMyF1CT_3lHPAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4OCBTYWx0ZWRfXzJkJf9H/sdm5
 sswKvYSaohdm8+/5X1Y3WGnwLHb4du1VmGlZwKSUT90A7hqLkM1N2CG8f9y1TGhWQ4DmM56kuaa
 JrHjELiKH0kuRwCv0ebmRwl+sg8uW+cS9uGE6Kv05Paf1o7QMs3PIGffBHgKIT5x2xSn11v/buM
 V7uNioZ2hRwlR6szO1qm3h3VkqBWQtPOsFr3pIQ1t3jDs4MHrlqMsnfhMnlPSYhj5lhzJiL8rse
 0WmhorpFLFCvBnEsHmrFZYdcweXDFd0BsrhWuEMKJ+z+xjCLbHO+7hyQHSU4pbAcIoV1HD9xHXB
 wYN1qNpxvvkmmH9ZuRFSWLEBb025NCUzg+zWnKceDrpFfbQBvzEFl9hKaCH9tpQR/1l/1dUNLrx
 C0h1tBIx6S/X0N6kWDq0OvjgMVCQM2CGN60pdinODYc6thLjyMthptGO/2jVI7dlOyZ0a58RiY9
 MH/DtnI5tjHmAvi3QRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220088
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EmRqG9SVoYfW8IqG1Aa6xeGCP4xxMTCR51eQ0ZpygBo=; b=Mq6N0ZLxLlMBvoKr
 4iqtQxbr2NoiRlszyMW+QOzHufxnBa4s9or+sbG/H1ljnZ3EEA1Dz36mTrcsygPs
 uIwLBVTZTQtLxzfBPPhdY5TeKV69zWPh7QPrL11OD/lYXtDAvF6qG4627m6mo/5s
 uwRTjcLSIy7Pz16vG3e6AbcqF5PMoWxXntirsAxiktA5hwNvm4jUBcqbGXJXZz7w
 bagh8SHneZqZmDrJ14Tw/n5o2r33EbYUK676zcRHjCHBBH9iZ9Uvb8Y69iHZh7pM
 SgoPdYbBqWUbfS9xidYBitB9m5iHa/oD6Z8ytcqe4QsgZHMoBv1tSXwhuwlIBl67
 UPleYw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784712232; x=1785317032; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmRqG9SVoYfW8IqG1Aa6xeGCP4xxMTCR51eQ0ZpygBo=;
 b=LQiJV0N2YAKrsvv9uHUGGHKKuevKjBzRllaoYcEEeKR/CWIQKGA9nlZhJgWlqcX+11
 OcWWVi2ohcR/9K5Gp/4TMi2HlGvtK+3Z8pfK7gQJAyuOpRMAuU+wmVO4EPa3LAMOWmCJ
 V4VyRu7DL6630vi1riKT4Cz4R83clcnOB9Tr9It4GHvhciPXtKxnbT5hXw9weIlEqP6j
 uMgd/dn5rA4oNP45CE1s+hlzwbQVm5l9kYEui2A328Sm0mo5PjxwDDPtmeUcBtJaG78B
 peQjHi3p9xeWyVEDBJMgyYoenfvkAuW9dfhQyA4ykB7S31xSz/9ncA0x4GjZSkRJtJTZ
 gd3Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Mq6N0ZLx; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LQiJV0N2
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mq6N0ZLx";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="LQiJV0N2"; 
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

On 7/18/2026 4:19 PM, Casey Connolly wrote:
>
>
> On 7/17/26 18:16, Balaji Selvanathan wrote:
>> Hi Casey, Ilias, Simon,
>>
>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>> Hi Balaji,
>>>
>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>> Hi Ilias,
>>>>
>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>> [...]
>>>>>
>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>
>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>>>>> but need some minor tweaks to merge them
>>>>>> Can you please point me those patches? I did a search myself, but
>>>>>> couldnt find those patches.
>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>> sughosh.ganu@linaro.org/
>>>> This patch you mentioned here can create capsule with only one 
>>>> payload;
>>>> means for multiple binaries we need to create multiple capsules. I 
>>>> have
>>>> also asked the person who made this series to respin, but havent heard
>>>> back from him.
>>>  From a quick look it seems like it would be fairly straightforward to
>>> extend mkeficapsule to support multiple images, the capsule header has
>>> an item_offset_list[] array with offsets to each image, today we just
>>> write 1 but it shouldn't be too much of a challenge to put a loop in
>>> here and extend the argument parsing.
>>>
>>> Given that we a) already use raw capsules and b) they are part of the
>>> EFI spec, I'm gonna try and save us all some time and just put my foot
>>> down here. A single raw EFI capsule file can already support updating
>>> multiple images, U-Boot already has all of the machinery for it with 
>>> the
>>> exception of mkeficapsule but I expect that's something you can tackle.
>>>
>>> The upside to this is that you will be able to build capsule files for
>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>> Thanks for the detailed feedback.
>>
>> We agree — we'll drop the FIT capsule approach and move forward with 
>> RAW capsules.
>>
>> Here's the plan:
>>
>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series 
>> [1] to support generating multi-image capsules from a config
>>    file, so we can build a single capsule covering all the partitions 
>> we need to update.
>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only 
>> supports a single firmware image (U-Boot itself) via a
>>    single-entry fw_images[] array. We'll move to a SoC-specific, 
>> multi- entry fw_images[] array (defined per board, e.g.
>>    board/qualcomm/<board>/fw_images.c), so a single capsule update 
>> flow can cover multiple firmware components — each with its own
>>    ESRT entry and FMP image_index — instead of just U-Boot.
>
> No need for this, just build fw_images[] on the fly derived from the 
> partition table on the board, with an entry for each partition that 
> can be updated. You just need to add a map from partition label to 
> fw_name string, starting with the xbl/uefi/boot partitions we already 
> handle.
>
> The entire point of having logic here was to avoid per-board stuff, if 
> you're thinking "ah I'll do this per-board" you should immediately 
> wonder "but can we do it dynamically instead?".
>
> Thanks,
> Casey
Hi Casey, Ilias,

   Thanks for the pointer — agreed, building fw_images[] dynamically 
from the partition table is the right call, avoids per-target code entirely.

   Plan:
   - Keep a fixed table mapping "partition label → fw_name + a fixed 
image index", this mapping going to be a superset list for all the Boot 
FW images supported in different Qualcomm targets.

      Sample table:

┌──────────────────┬───────────────┬───────┬────────────────────────┐
     │ part_base_name         │ fw_name                │ index │ guid 
(fixed)                                │
├──────────────────|───────────────|───────-|───────────────────────- |
     │ xbl                                  │ QCOM_XBL │   1            
│  QCOM_XBL_GUID                  │
     │ ubootspl                       │ QCOM_UBOOTSPL│   2   │  
QCOM_UBOOTSPL_GUID     │
     │ uboot                            │ QCOM_UBOOT      │   3         
│  QCOM_UBOOT_GUID            │
└──────────────────┴───────────────┴───────┴────────────────────────┘

     Target-1 supports xbl and Target-2 supports ubootspl.

   - At boot, scan the partition table against this table. Only 
partitions actually present on that target get an fw_images[]/ESRT entry 
— nothing hardcoded per target.

   - The image index for each partition type stays fixed and published, 
so whoever builds a capsule (mkeficapsule) always knows which index to 
target, regardless of what's discovered at runtime.

   One wrinkle I want to flag: today's SetImage() path assumes 
dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in 
dfu_alt_info purely by
   position. If a partition from the middle of the table is missing on a 
given target, everything after it would shift by one position and the wrong
   partition would get flashed — silently. Since I'd rather not touch 
that logic in common code, my plan is to keep every fixed index's 
position in
   dfu_alt_info stable by inserting a placeholder (U-Boot's existing 
virt DFU backend, which just no-ops) wherever a partition is absent, so 
the position
   math stays correct for everything after it. The missing partition 
itself simply won't have an fw_images[]/ESRT entry, so a capsule can't 
target it
   anyway — it'd get rejected before reaching DFU.

   Let me know if this approach sounds reasonable.

Thanks,
Balaji
>>
>> Will send an updated series once the mkeficapsule and qcom capsule 
>> update changes are in shape.
>>
>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1- 
>> sughosh.ganu@linaro.org/
>>
>> Regards,
>> Balaji
>>>
>>> Kind regards,
>

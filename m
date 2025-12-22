Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041CAD711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 09:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8018F83BF1;
	Mon, 22 Dec 2025 10:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAts89f4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dYcHXrCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6687A83E16; Mon, 22 Dec 2025 10:02:46 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD75C83B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM8E7RH090094
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wx8Lg3i+Nwi2kVqJkJZ0AzP6FsesAJjKjg6q2fmjx0E=; b=RAts89f4sAeblcKt
 wu5XFhERxRNkSfgJ/MbNOPZyDAT5klH8p9QEZp4gY74atSb61CV/3FZfXH6lgDRa
 KssWjZOICUy4ZZgki4njwYlPB3G83QE17GpXfbCiqZKVtwCt0Lt3nHfloBIgKa8b
 nPHA05W1ef5ESeytPQy1o6yBPKKbc2GrW7kVk2Z2gCIhXxjjWIViuFnU+JfZctXX
 AZf+xwx7J4tbl8hh3dvf4VI0Q+L490tGvdgeZ5Cr1umbTy9euNpRsPppODEhxv9Y
 1ZV0nyrrwBpv/9hvatqROuB7kPn4rO03oRUo0W9GWNlNWxdeQe+SchG+gQyR9Bib
 dO3OJQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mracd49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:02:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7b89ee2c1a4so7458740b3a.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766394161; x=1766998961; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wx8Lg3i+Nwi2kVqJkJZ0AzP6FsesAJjKjg6q2fmjx0E=;
 b=dYcHXrCb524XLdJMWn5w0+LdC3hw6OlSkdAKxK83vKhv0BMkn7KYdQB1ZP46Ku4x/5
 l84L/Wmo6EARxYdr8jIS8OSsV/eOHe0iRMmPZltyElvjdezLk3q0FMDeFdgd4CoaRjrW
 rkVFdxdNrt+ArSlrj0PffvbJReGIhFpL8izuoO6HUQoSgYSeaTP6mRVtaH3rsyO2hs13
 vX+BiAgxUssjvCPsi/j2RkGpLaEkgW2AuthTqdr8EJrqaxnok/RaODqdg2U4IcjUoTWn
 cT/a5Frq6MYP+SW5oo7qdMM+PtOaWDwj/TooSZfjW/AdoS88kCFAYRrCmxnl2i8qiiPf
 0C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766394161; x=1766998961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wx8Lg3i+Nwi2kVqJkJZ0AzP6FsesAJjKjg6q2fmjx0E=;
 b=IC0krQZIFVG6FLCf9VJKbA84XyCsgXDgbxfLjcDD+LnudjfcAc9ExfsyDBvzUbv1nU
 aKxvj5gwgeVU8ENtZhwvsRk0Dr/A3YjwAwvk1HfJ7zB1qlh2X6+fg7M4DI98D6DUr771
 XohczR6jJMzH5BUka5V8nIGkQcGMI5DQuWCjIx5D6Nw7WtCbE5J2PhKfLRXTJE7t/Uxw
 PgJsMvswsiWqpSmQouOTHQHJaSTPDeyrTyTjzYLyu8LOlwuW0C7A4nHcUjTj4v6eXHcy
 /bKqwnATKsMsU2UrIiIAmVytaU5X4ZB8n7OK1K3rdWUs2BhIG+6U+Czdy2aWfdC5GKXe
 TGwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPZhw31PLwe+clTKBFlM6xE3tHT5ngLHDucEoYDK3p+62LmLp5FyYVMsVhzg0rJMtMG+BHdoY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr2WUTflVMpYQNtFGFzYB/PkgK2AeHcA5OZe9rxxhEnuitZIvK
 1jMh33YveRCgOSikaAL1R4DBwZd8e/51ymK8Y7QjtoGpiF9qfIjR/VSc0U/Tu7XTLGceFn9MgMb
 MJ3OYMTWSckE+IHzMMqxMeqkxvR4QQbvixQD1PSnLG9HAlFpkLj0k+m2g
X-Gm-Gg: AY/fxX4fznZLDkoS87YSVPXBObvJjrtymzLpYQhJ9IY4kDPLS4s0VwTVUXeT47QDVJ7
 OR6ksiBiYa17Hyqeko7xuskP33ADh6fDLMy3PGMXhSYh5i+QS+V4f/LDQ3d6Fh9qb6SgRSYRu2k
 PaTv86MjeLWAHT7F+FdvEMr3jQj5M/w3Snk4iWQaGKrVCpLZbivu6ekaw+80uYFQ+NpLNzYrpqn
 ++BkJlFRpmnzwbKITiLPDM6boujyJhQMziaW9uuM6WJMMliUdVsRVXMLqRA743GsILsxfY8s7lO
 heUGcIAgD7E+Qk5bb7EYzK7ILJQcPLQaccoGrKHQICvb1lCap43W3YUf7ckVsFGJsKjNYu+R8LT
 qRiklsTJyxW4NtMecsrIQs1buHnpuL41XziISwevA8tQf3lw=
X-Received: by 2002:a05:6a00:27a3:b0:7ad:4136:946b with SMTP id
 d2e1a72fcca58-7ff65d7f124mr7990045b3a.28.1766394160872; 
 Mon, 22 Dec 2025 01:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRZn1RjuzqOJH5BBudSCjGCBcrkDCwSsVFyZ4nIA2xJKcwNrwdFHkQ0YNePayVSkBkm9btPQ==
X-Received: by 2002:a05:6a00:27a3:b0:7ad:4136:946b with SMTP id
 d2e1a72fcca58-7ff65d7f124mr7990014b3a.28.1766394160361; 
 Mon, 22 Dec 2025 01:02:40 -0800 (PST)
Received: from [10.151.41.129] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a2e3esm9588996b3a.37.2025.12.22.01.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 01:02:40 -0800 (PST)
Message-ID: <c880401a-60dd-4d58-8091-1c39005102db@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 14:32:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat> <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
 <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
 <041e5a5e-8b55-4632-8e6f-f8a05852894f@oss.qualcomm.com>
 <CAJaLiFx=ncCe0xzjy2z8-R1VyOjWqJwAKyaW0GZi2sffEcqopg@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAJaLiFx=ncCe0xzjy2z8-R1VyOjWqJwAKyaW0GZi2sffEcqopg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OuikS7Vy8kbQYD4TLRar_D9SzVvQcEaG
X-Proofpoint-GUID: OuikS7Vy8kbQYD4TLRar_D9SzVvQcEaG
X-Authority-Analysis: v=2.4 cv=e9wLiKp/ c=1 sm=1 tr=0 ts=69490932 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=k-42gJp3AAAA:8
 a=wiOJftdPHmf6E8-e-YwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA4MSBTYWx0ZWRfX2x5qAjFABqLe
 qaRF9C7/SC+Inda/kg/3Mb0MCI8dqYE3mKyvH4VrC8+58bv6zwhkmWz60rYx7udNT+MIqnIYDje
 nY28GueVWp4Y+yjHEFwgCeBRefHnj1KwW5arxMOaGtu5F8/ol7xGHB6DzROtKAIWTWCeTyTL6OK
 FoYJlYXY+mMgcm2JlRKhHP/VAfitEvDQ9OsyERwUQ6XFBOh9RByt2mo2LT+LHFIO89rhUIpdSDv
 QuvP4enoLTYa/F9L7vaLR1PqTouqzH5ONWeU990B844blPs92OUElRi77aJDtTSm3OguAAuim1l
 8e8guJhsVfWVmoUFCY1ULbDLpd5fLiTxVmC+mH8oOAuFYzoj82TzSVw55GzjJ5gqiDsl4GZGNZd
 Wqe/TWo0mV5C4dcmgWKe3wusGO5ZGo7NuvJIZT/jILF017Jgx6Vrajd3MrkatiH6G/9CuNBbi2f
 E6XhKCqO+nLD/N2yAiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220081
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


On 12/22/2025 12:08 PM, Tony Dinh wrote:
> Hi Balaji,
>
> On Sun, Dec 21, 2025 at 8:31 PM Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>
>> On 12/20/2025 2:47 AM, Tony Dinh wrote:
>>> Hi Balaji,
>>>
>>> On Fri, Dec 19, 2025 at 8:29 AM Tom Rini <trini@konsulko.com> wrote:
>>>> On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
>>>>> Hi Tom,
>>>>>
>>>>> Apologies for late reply. Somehow missed the mail.
>>>>>
>>>>> Upon analysis, it seems the most likely root cause is Tony's 238GB disk
>>>>> triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any read
>>>>> beyond block 268,435,455 blocks enters this path.
>>>>>
>>>>> 'blks' is decremented both inside the 64-bit LBA block AND after successful
>>>>> scsi_exec(), causing incorrect block count tracking and (most likely) the
>>>>> data abort observed.
>>>>>
>>>>> The fix is to remove 'blks -= blocks;' from inside the CONFIG_SYS_64BIT_LBA
>>>>> block in scsi_read() function.
>>>>>
>>>>> Hi Tony, can you please check with this change?
>>>>>
>>>>> Tom, shall I raise a new patch for this now?
>>>> Thanks for looking in to this now. Yes, please post a proper patch for
>>>> it so Tony can test and add a Tested-by if it works, that'll make
>>>> pulling to master before release easiest.
>>> FYI, I will be traveling a week from now. So it would be best if you
>>> can send the patch in the next couple days. Otherwise, someone else
>>> needs to do the test in time for the Jan 05 release.
>> Hi Tony,
>>
>> Have posted patch for this:
>> https://lore.kernel.org/u-boot/20251222042533.2024310-1-balaji.selvanathan@oss.qualcomm.com/
>>
>> Request you to add Tested-by acknowledgement.
> Could you also send this patch to my email so I can reply and add Tested-by?
>
> All the best,
> Tony

Have sent version v2 to your mail id: 
https://lore.kernel.org/u-boot/20251222090105.2275585-1-balaji.selvanathan@oss.qualcomm.com/

Regards,

Balaji

>
>> Regards,
>>
>> Balaji
>>
>>> All the best,
>>> Tony
>>>
>>>> --
>>>> Tom

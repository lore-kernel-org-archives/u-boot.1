Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D0606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gi0YEJKl;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=tIZ2mn+M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8037B6070F;
	Fri, 23 Oct 2026 12:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldU3LnSKkhr3; Fri, 23 Oct 2026 12:42:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96B01606F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792759366;
	b=htheitBGJJhBEn19w/ebXhHBxsok8GrtsHEKsAaiyFs6I6uOg7M9Kh+vAY2Ruy58vNJh
	 4LDjp7K8xjGqT59wvvpQpOYBZuTO2f2NPuw3NYvPCFTcb9dd/oPR8rFnwAinPm0seQRiV
	 6wPBH9PUogRyutkNPIbj6xCM2XnPNch3alGPEBE8kz+hizCOqi4qxiGHd6cDhA5L+266i
	 1ppGuvYJPBedY9bbyE1c2fV3xSzXpmCkZlcT0oX7cLzFvHRsStZWI0dewJlh8Qlb5mUIA
	 ESsdhZv3MvbwslMUxo9RXJVht2aykIkG5hTYw+XsWWzvK5bS/ivw+M9Qg1m0f1FLazw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792759366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KSjFC3f2RzztKA4PmUreHosJ3mJ9vFq4k2HbZ8aoFW4=;
	b=EJ6lqkyt1NBPdb6JgPZ+xNWvzbRWHcLMePLPISNtQZnY2nu1J+HZDkomHyhbijqg2J9G
	 myGZIu6xnq7Nm1KwAUxPWoZ017JvH83fk/ngqrx94d3LJu0gYGFUf6Ny9FugkeSzAdrBF
	 RdwryCdx6QN4cfVfANX2KRTHYOG7cDqicx0uiFx79C6qj/YiSQUJa9meSH/0q6DkLqlmh
	 X6UarB/kjJcE7u1Z/9RB9OxdPb/t1eGwdeOkd7HvLdjx/LXcn1T33Bj6U8+Ti8JfEK1Ou
	 a3q1imTCi++zOdDHhXtU8E9Ahioi2BXd2l6VrfJ2xgE6nyMTV1/WntDztsHRbA0yGWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792759366;
	bh=KSjFC3f2RzztKA4PmUreHosJ3mJ9vFq4k2HbZ8aoFW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gi0YEJKlZFJzd3pX5pfgDC6dvt+lZWORs8SpRgAjtYnSIgN7tPNQ5ykvAQgn6O2n/
	 ww08passU2L6f1I+Ii5/2YE7ziP3N/nopaCrE5IHESMBe4Ix0AO4QT+u3pysqWznM0
	 s6TiEeocLV8IdbBZjGN6uBDELLbBXJUmF5DYWRTqDRK8YuBKImUcncLn+mERaTSc09
	 Ttz0CPcwse/QJln0htrOtXVPjQuzvhQlqjjEYkRIAtdQ5GVHyBZNchtJxEj/ig27eh
	 eOpxm27CDTza9X0w9bzRfH+BIYxF0O8R70zljXDuB/I5oeORzX0fJLqcXK6lsWdA5h
	 IeHrzgUKxR7sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96B01606F1;
	Fri, 23 Oct 2026 12:42:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E8BA12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0008B81495
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:42:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRHDQL5iqyR3 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 12:42:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69A0D80C1E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792759365;
 b=Kvfove/Yurcn2d0Q471ioqfDtM+JjVKJOHgGizxhXwMVn1WQFUDIVsGKvdJp57Z/XFBJ
 DRabz59w9JuQnP22CGTNC25izgPT5CUKYYWhKTWb138Ne2Hphb2N3M9F6cJiahxteoYpa
 I8otLzjBDyiddkUgHuGydi/C5bR7knsJEumqi6xpUY/aZmpVHk7FnTunTXIaMmSOBQYxc
 +bKjppBU+1HwD0SqB412s2qmr5s3ArUgFewr/zxB1AhXB5g4Ep5GjumsVSDcLb7JiQeql
 +mangbaRpsN9xBwcqjZyZ+zD+L0GlBWFgBUXH3royaaqmStwLuf58JRAlbu3NOG81eA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792759365;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=KSjFC3f2RzztKA4PmUreHosJ3mJ9vFq4k2HbZ8aoFW4=;
 b=Zn+lhBcHStE23ZatbbElJAlJZsUWk50DOwLf4TO4E9qvCM4svrO2MNDaFq1f+k+856fm
 C+dGV7ROeBMZdrgzuYiBmH1A6bLn8mcNFj2FSPyYZmunXooauOlo7SwlbynwNLEeEr2eM
 p2w9/CqzX8gqp9gHTKIwzHdQ83KT+fNjKDc14XIRUEZ/qNRaBFVmrmGlbjsDBCz2X/yzm
 VP4qGGEis6NaoE3npADFb1JNUAN2pp+NerEUzOxGJuYiKwkwVsP2+wOJg1sh0vl4RTjuw
 CvTbOA8+P4BK7O//4r9RVEFeUN1Kqs3bgBuRwXIam4zE48oz51UJaJ+0GWkHftPLs7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=tIZ2mn+M; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=tIZ2mn+M
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69A0D80C1E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:42:43 +0000 (UTC)
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5643F4012E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792759361;
 bh=KSjFC3f2RzztKA4PmUreHosJ3mJ9vFq4k2HbZ8aoFW4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tIZ2mn+MqbLtwF+GUAt/RU6/I25N1LYSBE8UfpMw+CKUbr2y4izEvtIyUebhZzVIh
 LeZJhx+bDMUPBO+NBqBSQr0cgDuZhfKmk1jBXuO5wl6XM0nVKxd27FOMRqwFqnLOPy
 yfeSKMf85YHmklc0E29ZG842YH58oh1L7heNWdEmE7915Gh0szTLHvnE8WxCu4wIv1
 xhvU8iS9vbrUbBumS3lo1V4QYWfC4bg0d5twqIgJQRn6BObIEuDgGFr2iNPQ5VEjnb
 Vz+BpU3XLqoc3/K83BRwQ3j+f9AQ8tq6XY16VW42cZCu4kKf19CETx0Dq/C67NoexB
 VjrqKcNXt98lPepZcs2C/UvSc9Izv8uGkpUg3y/hN+E7j/Fek83FggDglftOf5TrTE
 4u7mNhQ/M+u6MYsy9v+18oygR8c9mzEkjPGmw8tUXSIx6+0I0YAHPWse0foBxZJUFA
 aKpqIWwlYwjY7DP4xOzJ6LGHiBPMKqCANJn1mtZDbNjZsqy1cpjWA230ZM+SRwyoKu
 e0XNl2Y05hYnLiXPPIyYzSuwcWB5TQi1SZWQhqv8uo+V+kySMLmmXe0G+ONNquTybF
 rKpntIP5zLkxdqPaXSuh7KtxC6O2a+HFrRjq3BqT0YaYWhaJloVhGkeAe9jhgkXz+e
 D7JkD86QbHWTVUUA3XUDSrek=
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7c0bad5ec1cso245985137.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 05:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759360; x=1793364160;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KSjFC3f2RzztKA4PmUreHosJ3mJ9vFq4k2HbZ8aoFW4=;
 b=dI1gxHieTS4DPX7kTknR4hmh74wYT2/dIHLHWZJd9ssbvZJYPRFQblO6D7EtmGtyA+
 +pfIBn0ZvcJsN5pILGe/HBiVTSHqmWDApnuimQl5dTXQdTKu1ye1jhabu/DvkyFrQbRd
 SmU4/JdZOJz0E0Xc4ZcyvysaI6D+b776PAc14fw5xUbykLy9VBqUOM2BP3B/lNqzybge
 2R6Atj2fqTNo+po7ou7zhEFkq30kruCU/o3yA/EhA/TbjI1NwQAdFd/DvZrLdci8E8ll
 zu4mJ10sDJw+ReR1il0V9Ww7YeBnDc+oa0Ts6pSuml7JSD/z/M7sIuof8kHyqJZakVr7
 Q6yQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfgpcLketUVURgBmJUIeZF89M96GELvMUzVaPaTY6to4ikf5nIw97ox4yeVREXam+Rsg39Nng=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKxsNBFjE2Hvz4tuu68Ga0FHIg6FLCySsrELXI4AsQ2WhMzFurQ
 1Wdxiqq4egkCKDSptHlfSuTNI+Co9m2vqFOmPNxXPTBDnt67BQbr1AyuPBl/xoEK/zhTVoPeesG
 34SAE2hrQReHGxsifltJ5w8BApKG3nrpOpYBPUen12NEDrJa+e9S+N0UbCCBZsoj91Xe6gs07wx
 aOR4xyoDJz0A==
X-Gm-Gg: AYBFou15C3jVqAj8kd8ih5n590MwgAzWDicWVdSXIiAu2iTagSwiHXaX5NkakfjnRcO
 u1f5UksrcV89KIpz2SpUMOekfDgVP9g+Dnznl0I5aTyH7l4x6aSystbtFanc0oExCNTLc9ejSOo
 DaACvr911gTvFX7NQfaNp263tsEbtuhI/VmGBx8shLnbrQQRByR1gYbvpVowmN1DtOfg524yAuX
 X8hluYLVK1AnWUxkdf9mHljkdKHl39ewjbGp6ZN9Pe5+7A0kRbUc/cqTHmH06VU33cRjSiKQU5Z
 QWdr0EDCKoQrpzEgnozxj6r1rbe3JAKCt/ZFKDqbHuU1Cd/C1oNp3+nX/ueQoo5Y1gBPDw1epl+
 FlzJLoCLTOFPfJlIUjIiAy9D76V5qhHYr4ZARcE+hIbj/7/bPlnyrQw==
X-Received: by 2002:a05:6102:e0d:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7ccc307b7dfmr744232137.4.1792759360247; 
 Fri, 23 Oct 2026 05:42:40 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7ccc307b7dfmr744223137.4.1792759359887; 
 Fri, 23 Oct 2026 05:42:39 -0700 (PDT)
Received: from [172.16.22.101] ([209.178.136.2])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9910c006d21sm96959241.7.2026.10.23.05.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:42:39 -0700 (PDT)
Message-ID: <fb610f81-878c-453b-9a39-e7b1fdb3055a@canonical.com>
Date: Fri, 23 Oct 2026 14:42:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: fix HII GetString()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, u-boot@lists.u-boot-project.org
References: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
 <81cfd720-f3c2-4807-9fd8-867d465b755f@canonical.com>
 <CAC_iWjLPxJ=TV5RtG0yGLSuDyN2GxsVPiJrHE_k6OCKSEoX3Zw@mail.gmail.com>
 <4ce18a5c-45c4-44a8-815d-e54df884499f@canonical.com>
 <CAC_iWjL5WdG1vxMtJrrwFtj_oq1LHQxg-SrcBQGTfHOf-dNnag@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjL5WdG1vxMtJrrwFtj_oq1LHQxg-SrcBQGTfHOf-dNnag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 14:16, Ilias Apalodimas wrote:
> )
> 
> On Fri, 23 Oct 2026 at 14:57, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 10/23/26 13:39, Ilias Apalodimas wrote:
>>> On Fri, 23 Oct 2026 at 14:19, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 10/23/26 09:25, Ilias Apalodimas wrote:
>>>>> Hi Heinrich
>>>>>
>>>>> On Fri, 23 Oct 2026 at 02:56, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> * Add missing parameter checks required by the UEFI spec.
>>>>>> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
>>>>>>      language.
>>>>>> * Handle querying the string size with *string_size == 0 and string = NULL.
>>>>>>
>>>>>> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>> ---
>>>>>> v3:
>>>>>>            Update commit message to indicate that parameter checks are added.
>>>>>>            Correct a misspelled variable.
>>>>>> v2:
>>>>>>            string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
>>>>>> ---
>>>>>>     lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
>>>>>>     1 file changed, 24 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
>>>>>> index 90dff91e5d4..47325f7d8aa 100644
>>>>>> --- a/lib/efi_loader/efi_hii.c
>>>>>> +++ b/lib/efi_loader/efi_hii.c
>>>>>> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
>>>>>>     {
>>>>>>            struct efi_hii_packagelist *hii = package_list;
>>>>>>            struct efi_string_table *stbl;
>>>>>> +       efi_status_t ret;
>>>>>>
>>>>>>            EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
>>>>>>                      package_list, string_id, string, string_size,
>>>>>>                      string_font_info);
>>>>>>
>>>>>> -       if (!package_list || !efi_hii_packagelist_exists(package_list))
>>>>>> -               return EFI_EXIT(EFI_NOT_FOUND);
>>>>>> +       if (!language || !string_size || (*string_size && !string)) {
>>>>>> +               ret = EFI_INVALID_PARAMETER;
>>>>>> +               goto out;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (!package_list ||
>>>>>> +           !efi_hii_packagelist_exists(package_list) ||
>>>>>> +           !string_id ||
>>>>>> +           string_id > hii->max_string_id) {
>>>>>> +               ret = EFI_NOT_FOUND;
>>>>>> +               goto out;
>>>>>> +       }
>>>>>>
>>>>>> +       ret = EFI_INVALID_LANGUAGE;
>>>>>>            list_for_each_entry(stbl, &hii->string_tables, link) {
>>>>>>                    if (language_match((char *)language, stbl->language)) {
>>>>>>                            efi_string_t str;
>>>>>>                            size_t len;
>>>>>>
>>>>>>                            if (stbl->nstrings < string_id)
>>>>>> -                               return EFI_EXIT(EFI_NOT_FOUND);
>>>>>> +                               goto out;
>>>>>>
>>>>>>                            str = stbl->strings[string_id - 1].string;
>>>>>>                            if (str) {
>>>>>>                                    len = u16_strsize(str);
>>>>>>                                    if (*string_size < len) {
>>>>>>                                            *string_size = len;
>>>>>> -
>>>>>> -                                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
>>>>>> +                                       ret = EFI_BUFFER_TOO_SMALL;
>>>>>> +                                       goto out;
>>>>>>                                    }
>>>>>> -                               memcpy(string, str, len);
>>>>>>                                    *string_size = len;
>>>>>> +                               if (string)
>>>>>
>>>>> This is always going to be true since u16_strsize() include the
>>>>> terminator. It's a nit so I am fine fixing it during the merge
>>>>>
>>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>
>>>> string is the pointer variable passed into GetString().
>>>> The value of string is not changed by our implementation.
>>>>
>>>> The UEFI specification allows to call the GetString() service with
>>>>
>>>>        String == NULL && StringLength == 0
>>>>
>>>> to retrieve the length of the buffer before allocating a buffer for it.
>>>> We must not call memcpy() if string is NULL.
>>>
>>> I am not sure I follow you here. If string is NULL, aren't we exiting
>>> really early at the beginning of the function?
>>>
>>> Thanks
>>> /Ilias
>>>>
>>
>> For String == NULL && *StringLength == 0 (I forgot the * above) the term
>>
>>       (*string_size && !string)
>>
>> is not true and we don't quit with EFI_INVALID_PARAMETER. Instead we
>> reach the loop where we look for a string matching the string ID.
> 
> But in the case you are describing
> len = u16_strsize(str); <---- len is 2
> The next if check will succeed since *string_size is 0 and we will
> exit with EFI_BUFFER_TOO_SMALL.

You are right that check needs to move down.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>>
>> We even have a test for this in
>> lib/efi_selftest/efi_selftest_hii.c:766ff.
>>
>> Best regards
>>
>> Heinrich
>>
>>>>>
>>>>>> +                                       memcpy(string, str, len);
>>>>>> +                               ret = EFI_SUCCESS;
>>>>>> +                               goto out;
>>>>>>                            } else {
>>>>>> -                               return EFI_EXIT(EFI_NOT_FOUND);
>>>>>> +                               goto out;
>>>>>>                            }
>>>>>> -
>>>>>> -                       return EFI_EXIT(EFI_SUCCESS);
>>>>>>                    }
>>>>>>            }
>>>>>>
>>>>>> -       return EFI_EXIT(EFI_NOT_FOUND);
>>>>>> +out:
>>>>>> +       return EFI_EXIT(ret);
>>>>>>     }
>>>>>>
>>>>>>     static efi_status_t EFIAPI
>>>>>> --
>>>>>> 2.53.0
>>>>>>
>>>>
>>


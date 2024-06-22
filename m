Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2CAC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D9B87923;
	Sat, 22 Jun 2024 16:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mYP3K8Ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9F687923; Sat, 22 Jun 2024 16:58:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF44878E2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8A0503F363
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1719068302;
 bh=9Jm4u5YekPHSaJ7AqlHgfn5Q5kjrYluRlYtp5xffR+o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=mYP3K8GeRzcWaNHdRNTlGuCI5Zh2uW9H5SxfppV+VCId8J3U1qzMbMDHQq2U6sskH
 5+KdtI5Bw4gIuf8UbvSkwNl5FwVL/NEMX04IMkTDCJXYeytK+GJPBpobqJ2cfoasl1
 wiEVUF0TjbmjMgY16Ip+zNklaITgx7mqxVg0UnUEW8Ng5pXKbrIrFwb4bOPPYeGcLw
 KMe0gHB1lUZEiqRD9FRxd6uEhWoLzNgKAhOh8KPZOTusz/jea4w1dv/hC0mp6UtN+V
 5O/SbRzp7tv32HmKiVDTT+nxzyhsqd5AK978VlPVK2hD1uc+RAuXkWYjwK6dZ3rq19
 KLIypYWTbBOyw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso1317224f8f.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719068302; x=1719673102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Jm4u5YekPHSaJ7AqlHgfn5Q5kjrYluRlYtp5xffR+o=;
 b=HzHhUtY+qY6cFqDwk7RlDKu2xOVJMDo9W6ZXrEQIOBDBa+vq5zWfcCmeWFooMSM2FX
 R0lBWBC+Q6GPK99YkB5NtsA4gdkPn7X/z6s1Yzf0CSxQ/wiNf3ZVeNScpMSKBsaLCQAC
 B7P1rk+g/WuC6l2vtrtXSikrJhLYeqT9qd0CR2msyWDkt+Q1EHR/lTVRq58gN8/5sZQg
 SHQbZO42vxO/5BNi5ll9WN+xFyDVl7o+jjkmOaNqa19vA8DiWnmZw23cCNYT/hxWeQBn
 DA7SaCgOjSyD/wMp+8JYQtCAyInWak4DvkalRogyAnDAN3UzU7MEBat67Ns/r+EcNH0R
 fgnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGEc98QzGYdOTutczFd1HvdsgbKzefDha1jY/lCPRjeE5AMu7zfra8U4Bmd9bvtfAq2Bkd/i7H3phzZHn1DJKRTDbcOw==
X-Gm-Message-State: AOJu0YxGAhwvMCd91rdyATvBVelRIjppDaKLoiZP0yj8Jbtbq6aSieqv
 d9nT7NMytXzA/jt3VRgr4Q6cnguOlpaiv+JUwXzme0pfp8rrXqxUnvX6xcJNJ7+P+WrWhEBGyAE
 hkwT+AHx1+V61NN4cTldpCOMxKEE/SHxj6PrX6lna/YoeWrINXIW9nrUAUOf8ChFlToM=
X-Received: by 2002:a5d:550b:0:b0:365:e79a:3e4 with SMTP id
 ffacd0b85a97d-366e956be3bmr8699f8f.30.1719068302053; 
 Sat, 22 Jun 2024 07:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK9w5MXEK3zdf/Mr/3xx0jGLi4CEZOAb4ZtEHPrifscvhsXCktXdjZoVbMNhKnRn4J7OLnWg==
X-Received: by 2002:a5d:550b:0:b0:365:e79a:3e4 with SMTP id
 ffacd0b85a97d-366e956be3bmr8693f8f.30.1719068301636; 
 Sat, 22 Jun 2024 07:58:21 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c789esm4787641f8f.91.2024.06.22.07.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jun 2024 07:58:20 -0700 (PDT)
Message-ID: <129ef964-b046-4985-a1f7-738457c369bd@canonical.com>
Date: Sat, 22 Jun 2024 16:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_selftest: can't have measured device-tree with
 kaslr-seed
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
References: <20240618122348.126196-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjJgFhAaDQU2TucwmG7rpwkT2CUnHg6zKrkaeEJNub4e-Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJgFhAaDQU2TucwmG7rpwkT2CUnHg6zKrkaeEJNub4e-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18.06.24 17:54, Ilias Apalodimas wrote:
> On Tue, 18 Jun 2024 at 15:24, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Test that we don't have a /chosen/kaslr-seed property if we measure the
>> device-tree.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_selftest/efi_selftest_fdt.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/lib/efi_selftest/efi_selftest_fdt.c b/lib/efi_selftest/efi_selftest_fdt.c
>> index aa3b13ae3ab..066d9581432 100644
>> --- a/lib/efi_selftest/efi_selftest_fdt.c
>> +++ b/lib/efi_selftest/efi_selftest_fdt.c
>> @@ -227,6 +227,13 @@ static int execute(void)
>>                          return EFI_ST_FAILURE;
>>                  }
>>          }
>> +       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>> +               str = get_property(u"kaslr-seed", u"chosen");
>> +               if (str) {
>> +                       efi_st_error("kaslr-seed with measured fdt\n");
>> +                       return EFI_ST_FAILURE;
> 
> When does this run? efi_try_purge_kaslr_seed() tries to remove the
> kaslr-seed before measuring a DT. Are we safe enavbling the check
> here?

do_efi_selftest() is called after efi_install_fdt(). efi_install_fdt() 
invokes efi_try_purge_kaslr_seed().

We would get an error here if efi_try_purge_kaslr_seed() were removed 
and measuring the DTB enabled.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>> +               }
>> +       }
>>          if (IS_ENABLED(CONFIG_RISCV)) {
>>                  u32 fdt_hartid;
>>
>> --
>> 2.45.1
>>


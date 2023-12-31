Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9455C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D3E87767;
	Sun, 31 Dec 2023 17:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UmzRr9ZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2A08785A; Sun, 31 Dec 2023 17:31:53 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D7A87120
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 47EAC3F0CB
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704040310;
 bh=e+iR9+AT/p0Q8Qtu+L+94aOEW8lUXOIKAJ2XWpv8ogk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UmzRr9ZAxN8Sp2qVkTldiZmqB5EtoXaq63AiQ9Mz42lHYGlhjQvWoxjSDH6OessLw
 /TiMN0JnEXaUalMCW8R+cWxjmNp/TZbuQ+0UGADx8VoPervnf1ndGKdZM3pFcu5fDG
 a9joX3seiEzj9j6Y41SxiZEfyqH+yTNymc9PR9deRTTTCzZtOltcfDnVzU2X5xHytU
 lf1La/NvNqGkFIUjrzCyXZE60snpiBXUuc3dHioVTZL1DinyL0m1djlkqj3ND6FUxL
 zt1Ve0kkgKqKaW2XMQW86JCFqPM7MJCok6s5ayqjlke9oiILFEWy6wui3vNNW8Y0Wz
 konc33Q9tiPzA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3367e2bd8b0so5890769f8f.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 08:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704040310; x=1704645110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+iR9+AT/p0Q8Qtu+L+94aOEW8lUXOIKAJ2XWpv8ogk=;
 b=UzEnZ+QX37Z2Px2JtsA3ZufH0GbUqMHoEOfcvzD0e1vLEbBxSG9bAcTjGTTxTdjjou
 YCkMKe03wqVw7WPr6LGId2OKrLsNVVBuEVZdu/UEwTLoZUwEdmQxSvxJWhCcEzrLs2PD
 l3EPvSnSfdJxwRkFUiyJQHiSpFezaQOM1/s9KeJhQ9Sqlg72z7ZdguqcwB9zsHmMnho7
 aIlwciH31F5SjsmJd6UclJHxLKtcQs3SydD33iwSkzn122S6uyb0UJIsrs2T5ARsm8uR
 8H/ZgD4s7taLE6IHtfpL0VLi1azOnh6dyKhcyDu+OyHqdAyd6fqPulxpRSOW9zRx1jZs
 eQ1A==
X-Gm-Message-State: AOJu0Yz986wrrNLytA2ZB75+zAPo+DrC4++RaCyDapElOjxdHGqNYD2N
 2KiywviRULNoYIMpDvM3AeOnEXYsdlh02DKg/fSzRdYAUhxiTFvyMWwuX4vkrXi3KzVTfKEaYYa
 NlVnQ9Nqd7Lzh7fozQD6Ezg13ns/aS0wSeBknNA==
X-Received: by 2002:adf:e7cd:0:b0:333:3d84:cb30 with SMTP id
 e13-20020adfe7cd000000b003333d84cb30mr7540131wrn.16.1704040309837; 
 Sun, 31 Dec 2023 08:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFskAasSCQx5efHHFJi4IaARMSSqNhCQ/Wnygke6fU+D0qS/1QD02sjyJkjcPUVZGej1StDcQ==
X-Received: by 2002:adf:e7cd:0:b0:333:3d84:cb30 with SMTP id
 e13-20020adfe7cd000000b003333d84cb30mr7540126wrn.16.1704040309403; 
 Sun, 31 Dec 2023 08:31:49 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 w5-20020a5d5445000000b0033660f75d08sm23934353wrv.116.2023.12.31.08.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Dec 2023 08:31:48 -0800 (PST)
Message-ID: <61a172c4-6fe7-4631-a92d-2b9fefdd998c@canonical.com>
Date: Sun, 31 Dec 2023 17:31:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: fdt: check fdt address
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjLOp8hJqPgCEVa+PDs-TGr6dtO+apMb0+WmopYZVpRbQ@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjLOp8hJqPgCEVa+PDs-TGr6dtO+apMb0+WmopYZVpRbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/31/23 15:22, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, Dec 20, 2023 at 5:00 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Trying to read a device-tree from an illegal address leads to a crash.
>>
>> Check that the parameter passed to 'fdt addr' is within the RAM area and
>> non-zero.
> 
> What is the motivation for this patch? Is something crashing? We don't
> do this with the 'md' command, for example.

QEMU with too little memory was crashing. But maybe we should write an 
explicit warning about too little memory instead.

Best regards

Heinrich

> 
> Regards,
> Simon
> 
> 
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/fdt.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/cmd/fdt.c b/cmd/fdt.c
>> index 331564c13b..dc954ea7d5 100644
>> --- a/cmd/fdt.c
>> +++ b/cmd/fdt.c
>> @@ -193,6 +193,11 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>                  }
>>
>>                  addr = hextoul(argv[0], NULL);
>> +               if (!addr || addr < gd->ram_base || addr >= gd->ram_top) {
>> +                       printf("Invalid address\n");
>> +                       return CMD_RET_FAILURE;
>> +               }
>> +
>>                  blob = map_sysmem(addr, 0);
>>                  if ((quiet && fdt_check_header(blob)) ||
>>                      (!quiet && !fdt_valid(&blob)))
>> --
>> 2.40.1
>>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CDACD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 00:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C35184659;
	Thu, 21 May 2026 02:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ORc3DZS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23EA847FD; Thu, 21 May 2026 02:46:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7218460E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 02:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B0813F281
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779324415;
 bh=Bt22P5t/+mjz1RdpsEpY96HBJdQBUISmacBjvXL1uHk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ORc3DZS8pYRo1wDl2Now7mkQQKXrYQK+L96HU5xOZIiP13t7Vgr55DDtPYMCaZC74
 gqSJMuL2hngo+gcXCe676KQ3TKJSpPJGWPlfPMRahvkrjWNfOYfHCOnIjxZcPwnCsx
 ClWK6+FmKcLWALhfSJzrNWJCajLDeuSiw1YSv2I27SsRHKw4iXF/ifL6Dt73mhLCBQ
 6EjRoiiQrgq23YwOEEazLQPk/SfJoq/bzpoPQUUJU4/lQqA7osAQfYJb0bjzVnBMJF
 YyH6OrVfLRTroqL5Nm6X6shToBRBP6Ph/7YAhu2LosQXEjmEufmaxRd6wLRUEpRX40
 a/iDzHGtT39UM2qAZ8M/eAQ4OnR3BzJzMO0Afb9UOsgl/d42fYyxyrN3+bAWT1L5jS
 USBNH6Esas5oPfLZY9MW15P/imuvEe+3n2/W6Nh2J1P8/vUzpTmLkl1vvRfWEzQlhJ
 y7Sx/F12/tAqbM3cv9RBfgkSOIoaNTq68FP6510S1XIl7BFjQE60Io1QViOY+YS4oP
 wbSG7FFGBzq++KLIWXIAspcLjiChTMjEBcSwJZyOlH7G6uvKImE7NIkTnw1ejQoU/H
 IGAqNl94Vjv3LnzWNzTVkgaqdD+oMeE7kfwSinKVDZlskwgBxq64NplTNHw+dtxkZD
 npgGNueh3WCyzEz330iKmqBI=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48ff0eb77b5so51808475e9.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 17:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779324415; x=1779929215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bt22P5t/+mjz1RdpsEpY96HBJdQBUISmacBjvXL1uHk=;
 b=hhjGRD3jtIO/Dtk3UiesA5uHoxggi51J3GOJVSdjAu3mkd1PeaSQfDM7TwzSXJ6Mkf
 zqxh40vpv3VQPHk3J45XNAPpAELsYEN+yPgj+P7921OrF6Sri0vvI4XCOqnDWRetLcUc
 knZ8vXjc8OmMjsGjGHkEBxeZFl0MoCcGmxf5hmVL6voDO2PDvznZzecXNK+7JBpb0i/g
 6X116+HYzEFTDFuBNhI67/0U8FNBCuFBCoZhn6MER14+nfkvGdFOuvnsX7kKSUjKDq1C
 hZT8jtJF8r38VSF+3Yu6KAFup9TuhqpGb3b4HHjqVpDroZwxcFs0DOWn1tsDc7dnmb5l
 6Y7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SBG/EB+SmZXSQfPMas4yIbXza61GO40d7WpgtpLbsjo8+warxKjSzperXBQ+PftDyMp5eki0=@lists.denx.de
X-Gm-Message-State: AOJu0YynQzXgFmkV2CAVJBy8wGCRxNWg4GFh24nntc5NnbsoV5+dMzcn
 2KZKl0qyoLI1jEEsZwln6rxJNyxZ1VQnTE1UPJTyuC02m6mjFZFDLU5tlW65vzrMm0LrtCFgSUJ
 w7VW0mEsDZimWRv+ZYkoCBsu/XmRPLXaA+ff49hwU0ymJ2xwIA+Lwh8Pph8qz0w3mwW2m8G8=
X-Gm-Gg: Acq92OE6+vtOkGVuD5n2cUFQmy/gqGWvze3zevU49zr0Wd1xiSOcDccBbQabfmWthdi
 bKaeNGJs3FsfyNquFtTSruoENrlm3Dnx+uKZRUR9PZZPTLR1lDz08ZZS5r8rEd6Xn41dZeJxNH8
 1L4pu/9sGVNMv6rwQo7ude9Xevd8FTSHjw9BFtS+RTnSktcBVH+lILf6BsCnu3RYTpFrPf2hEk5
 Wt9nUXPWDwBUf+KBRSOxapVLRyfN9ohP4GDGrA6uQO92rS9S5MZ4dcibXDqT31gCodjY6hxPzy+
 4qRzVldNyHm302PBwjhszPgDBbTujKz7aCR87kJigqVVM573WUfiVFUbDv90l2scQsAGHdMtUQJ
 /Q9Be2XyULwSnHBhwuJr7+Ju1nRzTRKz1zNOkmEFOrxlEb+sPS6gcpobIfJ6Ho5xUqL9L+d+HwD
 ZEfbsg8N9sIt3ncWb7STbHNP2E4rfx54SzzxyMscbCTO7nkra4LfA3J9q9
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-49036041d5fmr5262435e9.8.1779324414985; 
 Wed, 20 May 2026 17:46:54 -0700 (PDT)
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-49036041d5fmr5262205e9.8.1779324414586; 
 Wed, 20 May 2026 17:46:54 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035eeb4f4sm3618385e9.32.2026.05.20.17.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 17:46:53 -0700 (PDT)
Message-ID: <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
Date: Thu, 21 May 2026 02:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
 <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
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

On 5/20/26 22:42, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
>> displays the modification date alongside the file size:
>>
>>   4096 2024-03-15 09:30 filename.txt
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   fs/fs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/fs.c b/fs/fs.c
>> index f8e4794c10e..482a5523712 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
>>                  .fstype = FS_TYPE_EXT,
>>                  .name = "ext4",
>>                  .null_dev_desc_ok = false,
>> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
>> +               .caps = FS_CAP_DATE,
>> +#endif
>>                  .probe = ext4fs_probe,
>>                  .close = ext4fs_close,
>>                  .ls = fs_ls_generic,
>> --
>> 2.53.0
>>
> 
> I would prefer having a head-file macro which expands to nothing for
> xPL builds, rather than adding preprocessor macros.
> 
> Regards,
> Simon

Hello Simon,

In the internet I could not find what a "head-file macro" might be.

As struct fstype_info is not defined in a header file, a preprocessor 
macro defined in a header file would not make sense here.

Do you mean something like:

#if IS_ENABLED(CONFIG_XPL_BUILD)
#define FS_CAPS(flags)  /* empty */
#else
#define FS_CAPS(flags)  .caps = (flags),
#endif

static struct fstype_info fstypes[] = {
#if CONFIG_IS_ENABLED(FS_FAT)
         {
                 .fstype = FS_TYPE_FAT,
                 .name = "fat",
                 .null_dev_desc_ok = false,
                 FS_CAPS(FS_CAP_DATE)
                 .probe = fat_set_blk_dev,
...

A line without a comma in the initializer is easily mistaken as 
incorrect. I am not sure that a code reviewers life is made easier with 
defining a new preprocessor macro.

Best regards

Heinrich

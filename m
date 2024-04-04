Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8FECD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C08880F8;
	Thu,  4 Apr 2024 18:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VciM3AEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B348D883A2; Thu,  4 Apr 2024 18:14:47 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924FD88089
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 804EF4249B
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712247281;
 bh=KIe8yx1ulhjYRx4Q5QhyzRDpBRfhcMN23jqBhMLnyqE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VciM3AEuXzDun5nC6+iQX3FBdWiVcphu/9jQLRHm+2hRKb0kAcSUNICGEyYP8/oEd
 QzxoryScT82h1lMSVd+BbSpgJaHU/ZRayZyFcA0ju257oLYaHInlUMo2y8ouMHZyJX
 GUsNjVcIZl9qyuaO1k0okQ4fQ1MvJEcVSxmNtGc6U5fGdN9PVJHGfOsLoVpyvl81/C
 pocgp6hh6/kdiCkchT//uFOnPxD3fQspTYZy86g3LJHZNQT1xx/PiW4pKhr4fumpU3
 Y0XNntzoBooyRDbhCP06Zf3XXMHjIncAZ/K5Qw1EM0Xpwuw3nkvjrtTxPb15xURDys
 06j/ZvkF6Krgw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4148b739698so5500185e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 09:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712247279; x=1712852079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KIe8yx1ulhjYRx4Q5QhyzRDpBRfhcMN23jqBhMLnyqE=;
 b=UucwLE/vDkSzgDrtY/4r+BeZFXs039Zt7jHK90nSn12wj/c+fGSkuo6P56r10ZGhlQ
 c4hJzrTMDzuyGxu5djP7/F0qpLE1ZAX49kamfNkvoNAw+YypMC7ge7+ZO6n5di3p+dK5
 rozgHtuCuMRR350goBdpPTBp0LDchn62nlXcrYX5BNsSN898RvsjkLukwB7XRYz2foDn
 CUY6wzJQNziJzXCEEYkK2Az5E558CykXz6PkRluCGpo4DDdq1a7va0hdhCIJS7WphZzw
 sAq3a7qqsEOQJEAdj6bRrTVRG2R6EBjqX4F+XJhKcbw1GgIpf1JX3i6gkLI7XPiqOCwp
 s23A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCvgENBbSWjE/kfzRw8lsJwjywKT45WkoSmUaTxh4baceaP352OqbBL0xhRvLeLm73RfsA0colkrNB1JXYu7SGFUkJuQ==
X-Gm-Message-State: AOJu0YyL+HQMNHHjjoL0k4sz4RHZo/fEusMYng4cXeJVZq80kDnXvmSe
 0uNK6UHTFX/ud1BZaL1m8N+LSoy1sWeHYUYT+3PtSn4fLbPjBRYNPomUifgqpbLn27Rjmv4cvIA
 tckatK3oG4wCOfe6f4qlMZOphdpy7Hvm11kTbbFg0bArXNAjw4N1aq3B3+Nqmifc4ey0=
X-Received: by 2002:a05:600c:5853:b0:416:259d:b239 with SMTP id
 ka19-20020a05600c585300b00416259db239mr188591wmb.14.1712247279538; 
 Thu, 04 Apr 2024 09:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+E0C9nu7Ffk2bb1cfbL3Qxg2soirK67MjN98w+PYeftlLfFltq9TncShrEGR+hDL+954Bhg==
X-Received: by 2002:a05:600c:5853:b0:416:259d:b239 with SMTP id
 ka19-20020a05600c585300b00416259db239mr188554wmb.14.1712247278988; 
 Thu, 04 Apr 2024 09:14:38 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c470e00b0041493a93cc5sm3215347wmo.2.2024.04.04.09.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 09:14:38 -0700 (PDT)
Message-ID: <28f05b08-36d7-419c-84e5-137c99e77ebe@canonical.com>
Date: Thu, 4 Apr 2024 18:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] boot: correct finding the default EFI binary
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>,
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
 <20240404114742.81187-5-heinrich.schuchardt@canonical.com>
 <CAC_iWjJ3Fk-j227rGjdvH6RQy=t2jXXdrYmfgh2vtPT4Wg8ZRQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJ3Fk-j227rGjdvH6RQy=t2jXXdrYmfgh2vtPT4Wg8ZRQ@mail.gmail.com>
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

On 04.04.24 16:46, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> FWIW reading at this, I don't see a point of having it overall. It has
> a nice feature of trying to load external DTBs from a path though.
> I think in the future we can move the dtb selection in
> bootmeth_efi_mgr.c and delete this one

efi_mgr method should only scan removable drives for 
EFI/BOOT/BOOT<ARCH>.EFI to be UEFI compliant.

The efi method also scans non-removable drives for these files.

I agree that this behavior could be integrated into the EFI boot manager 
itself (with a corresponding configuration switch) to replace the efi 
boot method.

Best regards

Heinrich

> 
> On Thu, 4 Apr 2024 at 14:49, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> * The sandbox must not use an arbitrary file name bootsbox.efi but the
>>    file name matching the host architecture to properly boot the respective
>>    file. We already have an include which provides a macro with the name of
>>    the EFI binary. Use it.
>>
>> * The path to the EFI binary should be absolute.
>>
>> * The path and the file name must be capitalized to conform to the UEFI
>>    specification. This is important when reading from case sensitive
>>    file systems.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
>> ---
>>   boot/bootmeth_efi.c  | 44 +++-----------------------------------------
>>   test/boot/bootflow.c |  4 +++-
>>   2 files changed, 6 insertions(+), 42 deletions(-)
>>
>> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
>> index a46b6c9c805..aebc5207fc0 100644
>> --- a/boot/bootmeth_efi.c
>> +++ b/boot/bootmeth_efi.c
>> @@ -14,6 +14,7 @@
>>   #include <bootmeth.h>
>>   #include <command.h>
>>   #include <dm.h>
>> +#include <efi_default_filename.h>
>>   #include <efi_loader.h>
>>   #include <fs.h>
>>   #include <malloc.h>
>> @@ -23,43 +24,7 @@
>>   #include <pxe_utils.h>
>>   #include <linux/sizes.h>
>>
>> -#define EFI_DIRNAME    "efi/boot/"
>> -
>> -/**
>> - * get_efi_leafname() - Get the leaf name for the EFI file we expect
>> - *
>> - * @str: Place to put leaf name for this architecture, e.g. "bootaa64.efi".
>> - *     Must have at least 16 bytes of space
>> - * @max_len: Length of @str, must be >=16
>> - */
>> -static int get_efi_leafname(char *str, int max_len)
>> -{
>> -       const char *base;
>> -
>> -       if (max_len < 16)
>> -               return log_msg_ret("spc", -ENOSPC);
>> -       if (IS_ENABLED(CONFIG_ARM64))
>> -               base = "bootaa64";
>> -       else if (IS_ENABLED(CONFIG_ARM))
>> -               base = "bootarm";
>> -       else if (IS_ENABLED(CONFIG_X86_RUN_32BIT))
>> -               base = "bootia32";
>> -       else if (IS_ENABLED(CONFIG_X86_RUN_64BIT))
>> -               base = "bootx64";
>> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
>> -               base = "bootriscv32";
>> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
>> -               base = "bootriscv64";
>> -       else if (IS_ENABLED(CONFIG_SANDBOX))
>> -               base = "bootsbox";
>> -       else
>> -               return -EINVAL;
>> -
>> -       strcpy(str, base);
>> -       strcat(str, ".efi");
>> -
>> -       return 0;
>> -}
>> +#define EFI_DIRNAME    "/EFI/BOOT/"
>>
>>   static int get_efi_pxe_arch(void)
>>   {
>> @@ -259,10 +224,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>>                  return -ENOENT;
>>
>>          strcpy(fname, EFI_DIRNAME);
>> -       ret = get_efi_leafname(fname + strlen(fname),
>> -                              sizeof(fname) - strlen(fname));
>> -       if (ret)
>> -               return log_msg_ret("leaf", ret);
>> +       strcat(fname, BOOTEFI_NAME);
>>
>>          if (bflow->blk)
>>                   desc = dev_get_uclass_plat(bflow->blk);
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> index e60e9309fa9..674d4c05f83 100644
>> --- a/test/boot/bootflow.c
>> +++ b/test/boot/bootflow.c
>> @@ -13,6 +13,7 @@
>>   #include <bootstd.h>
>>   #include <cli.h>
>>   #include <dm.h>
>> +#include <efi_default_filename.h>
>>   #include <expo.h>
>>   #ifdef CONFIG_SANDBOX
>>   #include <asm/test.h>
>> @@ -179,7 +180,8 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
>>          ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
>>          ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
>>          ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
>> -       ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       efi/boot/bootsbox.efi");
>> +       ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/"
>> +                          BOOTEFI_NAME);
>>
>>          ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
>>          ut_assert_skip_to_line(
>> --
>> 2.43.0
>>
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


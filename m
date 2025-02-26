Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B93DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 08:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D9780077;
	Wed, 26 Feb 2025 09:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sxUY/W+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5E2801CF; Wed, 26 Feb 2025 09:23:07 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315E88004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 72E913F2C5
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740558184;
 bh=odeQGYYf6FxJMBmYntJpMI3lh+KHlx7cyzKf3IkHrjA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=sxUY/W+B4tViCbiW/nLgJ6aYBEcbLK3kWOXXA+WUc10Ue16avz3/3ZuCRmw+WX2j7
 rpR770+IchUVMz5xYCVfvWX1tJM5HHMvlfNrFVIrr5JfmNH6HzS5fSYPZm/uWtgpf0
 IO5f3MDrUJN9N8VM3MCVfdcqPVZ39393RjPZdPbg08AQF/D8de7Azpj/fCVBnV889y
 PL7D8OVeiOw+6qfpDdUNi1561Dct0V1xo/CebllLcccwiinf5eThBvnOb9kDKU7Pis
 kAC/sMxi32kV+69bINzG+oNpwisIQAZGIi+xpfJNgUb75h6J+acG8SkauCu9fpbcxn
 uue+WSLccl/AA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so44197505e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 00:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740558184; x=1741162984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=odeQGYYf6FxJMBmYntJpMI3lh+KHlx7cyzKf3IkHrjA=;
 b=XcoQuwJO7up5qK/mwlvvKvBugUFevDz+MK9RbXB2g7d4Gwp78pSaRZVDM3RD+7seyV
 UwpQYMtKvY+QMStssVbuZvAL7oNzRaQ3/FWwe+YyIRCBZr9xo+ppIHnq5r++WlxuPqSY
 hAFbwlSJ2baMOSL2s82FdqoQbT2gnF4+BackAnrSSkPN98or9KG3Ccud9NNkXorqAyjx
 NS4bAqDo4uncPuxDlodxWdPxQBZiqf+BeQDOu63p/iBId4ogi3f0E+R27gw3JOB01RZn
 SyCGUp3fAwvxUF6YsTSxuV5Ziz8+iuApOwFpZo3XZXIaaK+qWxyAUDFxj8WmXZzE/IFQ
 POsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIYf+jrve966gAq7LHf4PA1s9hiOrRIE0yB4Rk+l6mx0zNLZjqsj4nToupIBlJ+wSa6ruNczU=@lists.denx.de
X-Gm-Message-State: AOJu0YxDUSGIkCoR/KQQNWAruLE84mqRZkaou6owhuh7Fk/IC0dO+i8w
 /8IDEbN5+8dDMGULsYOCueeg6C8rjz3/OXbyEruhhzzvTJEperA/bHSJzSwdV1kfuPrSYveOJ8h
 K/4Fmm/CLN1q2wBvH2jaG5rR8SZFhYxmXs9ypF68zHtmeuHIq8oZkWiG9pdVORzbIAb0=
X-Gm-Gg: ASbGncufjrkz6SVR6Q4JC1++m+7RTvKWUoMKsQiSjTROqeb9nfGouax60hYRkdXrHF9
 P/XLtTwDq3Gv0tTwiJjqBRs0sw0f/tTSdNRyOgF2i52Dmn4nyR126RdUGZvMs4PgwTuI9K4cn8Z
 QScfoVOPAezK/ZGBbHc1AGmo1Plphv/vWL3SaQF0nr+E7tEjMLv+3zDZd2X1nXPaJeTldDb5L7j
 sScDBVeIQqc0ZhzWTO6MTPDFaypy3aIG/Sj/NW/NcsnADV9EDDf1ClYupXSyEUII9RIiyrLHRa6
 UTHHrjEvoFd6Du6mXFRkLl3W7/i/dF3mIf17uQRw3ZiiIslGw4GJQYx9FhwhvbmIZWEg/lJnSVs
 s0cyDZ86+VAnc
X-Received: by 2002:a05:600c:444e:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43ab9015589mr16321585e9.21.1740558183965; 
 Wed, 26 Feb 2025 00:23:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBYqKyFlTwiaAMzG3JEbdTH+yZa7DLYlzEo8Gz67U/pJb4koKDAx0NK4DTxrOvyMcw6wj3hg==
X-Received: by 2002:a05:600c:444e:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43ab9015589mr16321325e9.21.1740558183511; 
 Wed, 26 Feb 2025 00:23:03 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd866ac4sm4858866f8f.15.2025.02.26.00.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:23:02 -0800 (PST)
Message-ID: <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
Date: Wed, 26 Feb 2025 09:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: "Kummari, Prasad" <Prasad.Kummari@amd.com>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Simek, Michal" <michal.simek@amd.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
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

On 2/26/25 07:48, Kummari, Prasad wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Hi Heinrich,
> 
> Regarding below commit.
> 
> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> CommitDate: Sun Jun 19 15:53:09 2022 +0200
> 
>      efi_loader: initialize console size late
> 
>      If CONFIG_VIDEO_DM=n we query the display size from the serial console.
>      Especially when using a remote console the response can be so late that
>      it interferes with autoboot.
> 
> *    Only query the console size when running an EFI binary.*
> 
> https://lore.kernel.org/u-boot/20220614060203.33600-1- 
> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u- 
> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
> 
> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to 
> query the console size only when running an EFI binary. However, when 
> CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still being 
> invoked, which shouldn't happen. This results in issues on our terminal, 
> which cannot handle the resulting characters, leading to incorrect 
> display and halting the auto-boot process in the U-Boot shell.
> 
> *Log Output:*
> 
> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 
> ee:df:0a:38:a8:c4
> 
> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, 
> eth3: mrmac@a40f2000, eth4: mrmac@a40f3000
> 
> Cannot persist EFI variables without system partition
> 
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> 
> Missing RNG device for EFI_RNG_PROTOCOL
> 
> Hit any key to stop autoboot:  0
> 
> *Versal> [42;173R*
> 
> *Unknown command '[42' - try 'help'*

Hello Prasad,

The terminal emulation seems to be sending a valid reply indicating 42 
rows and 173 columns.

It could be that in your setup you are hitting the time out in 
term_get_char().

Could you, please, check what happens if you apply

--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
         timeout = timer_get_us() + 100000;

         while (!tstc())
-               if (timer_get_us() > timeout)
-                       return 1;
+               ;

         *c = getchar();
         return 0;

If the failure disappears, next you would have to analyze why the 
timeout is occurring (e.g. timer_get_us() running too fast).

If you still get failures, please, add debug output term_read_reply() to 
understand what is happening.

Best regards

Heinrich

> 
> *Unknown command '173R' - try 'help'*
> 
> *Versal>*
> 
> Debug logs:
> 
> Before entering the U-Boot shell, set a breakpoint at getc, which is 
> invoked by efi_setup_console_size() and display problems and auto-boot 
> interruptions.
> 
>   xsdb% bt
>      0  0x7ff0d648 pl01x_serial_getc()+2011873280: drivers/serial/ 
> serial_pl01x.c, line 339
>      1  0x7ff0d134 __serial_getc()+2011873316: drivers/serial/serial- 
> uclass.c, line 310
> *    2  0x7ff47dcc efi_setup_console_size()+2011873540: lib/efi_loader/ 
> efi_console.c, line 291
> *    3  0x7ff4e40c efi_init_obj_list()+2011873316: lib/efi_loader/ 
> efi_setup.c, line 225
>      4  0x7fed699c main_loop()+2011873324: common/main.c, line 61
>      5  0x7fed69d8 add_mem_region()+2011873280: common/main.c, line 84
> xsdb%
> 
> code snippet: Disabling the efi_setup_console_size() function prevents 
> the issue from occurring.
> 
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779d..ad68ac19526 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -220,9 +220,10 @@ efi_status_t efi_init_obj_list(void)
>          /* Initialize once only */
>          if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
>                  return efi_obj_list_initialized;
> -
> +#if 0
>          /* Set up console modes */
>          efi_setup_console_size();
> +#endif
> 
> Regards,
> 
> Prasad.
> 


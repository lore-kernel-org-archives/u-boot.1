Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86176CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 16:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E05B83B99;
	Mon, 17 Nov 2025 17:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NTCtSTRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A833283BF1; Mon, 17 Nov 2025 17:43:39 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C8183A8F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 17:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E537E3F7C1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763397815;
 bh=u/H6W3dzWAKqq5EBgGNoHIHRofM8VSExWL2o4ndUTck=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=NTCtSTRJuvs9hsNY6OoXWQKqVhTVOuUhrJwojJ8jzNAmpq0y4lC+5oy6FFz7RZ1GS
 zh8KNGsa2ixjAPrBXGY2xyXLG/EzbTV9YHcHrtJl9dK4sWXgHTMEAvhjQzw86YJzMY
 RP67EyVJ53dYGLalqHzQzVEvXHzTALUVPEO/JPBuubU0EJyVxGhVITjfiraXqg3DFH
 GAvetoiYuoVOSRTNHHmOw4mZfSQNUigVYCkAQ2CtJz8CMguwqmD+kxCwPSSCaeig2o
 bcrIhwmVH1XW5ewRZS1uM2gkSzrtYG3qUPR7GMmRaylQszjX1DKVbLvW1cx4aypVfh
 Ae+Jb92AhmSdamjDCdvI29XuJHYYSRs+iZrMWzdfo8RpegL1u10AYmS9Uk9D8erbKe
 ass9LudxZgQK86AiK/lIbkHwGKHcYXpBYqsnoNG1foBk0DEnrKfCIQlSd7s4ZCIRQ8
 FwxO1GWOsWaXk07LOEVlJzeVHTgVyBskkNBMDM9prHmjZnpz78YYEx6rXKvSHGAi0Z
 mqXJFbbimdDlrEYs4LAgRYNfZBRGhgu5AccGsYe2DpfV8VvKL4A3RX33CfuK0psLLZ
 NrDD+OjMi0NT9Ii5Ol9EIx74KhDHl9GJITI6jaPArgI9fwNGg3B6wQkx+aHkTNxvpT
 xsG2ofxTOt7Bsnt9/0YB+J8U=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3339cab7so3566913f8f.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 08:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397813; x=1764002613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/H6W3dzWAKqq5EBgGNoHIHRofM8VSExWL2o4ndUTck=;
 b=BjFpyoIgHVHLvwMFe8osNtY4S9mznbHezOSgRBAuA7EUR0UO4RK4sLuvkcFaPbvgWA
 0r37+qt1jRZwo9EsfzTE5OpGAu3+Y2iw8xKSGGqaIRS+jaxkILto78K868YyONunFwnk
 EeJf2uJI+lOdfUrsAK6/lQSQ2evinRqfcHBud/ikrcHzPpJy+Q4jgHuGCo/m1GOrotJT
 BFI0ecaBa5Jb5vibKQk0YPze474Uyw2AgwDIYwX4j662c5DMZN7ki34KH6aE9fbo0PRI
 ZTcvwQjz3EoVXh7mv1QbDJuKvaT+ALD7xxVn9wKlOJ7FlhPdetWb3rpklNFe6hfVWo1N
 NpTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3lkFRAJ9Mc5q0gZ3OOnCaU/f+NKUaPbPDndd6SFMLQJGnjVsOdIPrcpVvQn92w1f3W5CQr1o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2tFQzpsQkoonOUJB8KyOuOznHy7WCbhBLQRSUubx0LFTISvXk
 kPU7w8ItQd5o2571WJ7HtPXyP4B1HzRUHU6agWgbKjpx9fQiybF/QivryjMnN0/pyiZIdQ+sxIg
 n7J4Q7TdE7sg6gnwtrs5wnKCBQgdGOAFS29VmlfI+g3/e1LlfuNhkVcXE03UDgr4izz5Eooo=
X-Gm-Gg: ASbGncvrmnGZY7wynRhtQXvZUiwoGb8u1meHPQsrgKOd/tPzGBCFvij+tC+NtRzSomv
 vZVB5TBgB7HfyL/oTUSEdmkM1QZBxjtE8tCZJb/kkwV1X1ol1scDhfpC266eW8QKxj6Tmi0IMS2
 MnvSvNybS/U72j3LLM8x11RCm+37GdjowIpTKsYcoPVHPgiFXXxv33mnIf/miGJrUKHe5D/tk+s
 zaA9LYla9ZU9Iy2rkoNq6VNE+4HxwJQsPUcjLik2empsA8wcLNeNjbipcT+pVrh68S3aKAiTwwA
 vdg6dRXnv51LjE06VizYs4S4kGV0PkYeORL2/DZhRMuGs+95LI4nzTo21HMuwZDrs7nzqZdLrnI
 OrQKh8aC4sLwHkjPT8oOakZ+2TNfnWfl48Q+vIluJnUqWv1hdyyaDV/aAhc9JZvmIE05Yk89v
X-Received: by 2002:a05:6000:230d:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42b5939dc13mr11913332f8f.52.1763397812737; 
 Mon, 17 Nov 2025 08:43:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVZpqhyIapJWWQiVIgUioatARoKl7/jm0CpyJYjpQWg/T2M/wmqkACwY0DpfyQnJyZEBmk/Q==
X-Received: by 2002:a05:6000:230d:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42b5939dc13mr11913309f8f.52.1763397812327; 
 Mon, 17 Nov 2025 08:43:32 -0800 (PST)
Received: from [192.168.103.118]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b894sm27679885f8f.26.2025.11.17.08.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 08:43:31 -0800 (PST)
Message-ID: <15d4a8ae-5fd2-45df-af9d-e879faf6be1f@canonical.com>
Date: Mon, 17 Nov 2025 17:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: smbios: correct output for table type 4
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
References: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
 <CAMDkj5wQ=pRGFrf_S-HPUs9Zd-uWGFyLFDk3S2TRGCCuvJCMgA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMDkj5wQ=pRGFrf_S-HPUs9Zd-uWGFyLFDk3S2TRGCCuvJCMgA@mail.gmail.com>
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

On 11/17/25 16:48, Raymond Mao wrote:
> Hi Heinrich,
> 
> On Sun, Nov 16, 2025 at 5:39 AM Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     In the QFW case the SMBIOS specification version is controlled by QEMU.
>     Field 'Thread Enable' is not available before SMBIOS v3.6.
> 
>     We should not print the core, core enabled, and thread counts twice.
>     Use the appropriate based on the SMBIOS version.
>     Use decimal output which is easier to read for humans.
> 
>     Signed-off-by: Heinrich Schuchardt
>     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>       cmd/smbios.c | 21 +++++++++++++++------
>       1 file changed, 15 insertions(+), 6 deletions(-)
> 
>     diff --git a/cmd/smbios.c b/cmd/smbios.c
>     index 671c14e05b5..f9a352c107d 100644
>     --- a/cmd/smbios.c
>     +++ b/cmd/smbios.c
>     @@ -262,6 +262,8 @@ static const struct str_lookup_table
>     md_tech_strings[] = {
>              { SMBIOS_MD_TECH_OPTANE,        "Intel Optane persistent
>     memory" },
>       };
> 
>     +static u16 smbios_version;
>     +
>       /**
>        * smbios_get_string() - get SMBIOS string from table
>        *
>     @@ -504,18 +506,23 @@ static void smbios_print_type4(struct
>     smbios_type4 *table)
>              smbios_print_str("Serial Number", table, table->serial_number);
>              smbios_print_str("Asset Tag", table, table->asset_tag);
>              smbios_print_str("Part Number", table, table->part_number);
>     -       printf("\tCore Count: 0x%02x\n", table->core_count);
>     -       printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
>     -       printf("\tThread Count: 0x%02x\n", table->thread_count);
>     +       if (smbios_version < 0x0300) {
>     +               printf("\tCore Count: %d\n", table->core_count);
>     +               printf("\tCore Enabled: %d\n", table->core_enabled);
>     +               printf("\tThread Count: %d\n", table->thread_count);
>     +       } else {
>     +               printf("\tCore Count: %d\n", table->core_count2);
>     +               printf("\tCore Enabled: %d\n", table->core_enabled2);
>     +               printf("\tThread Count: %d\n", table->thread_count2);
>     +       }
> 
> 
> I think for ">= 0x0300", both parts are needed.
> 
> Below is the description of " Core Count 2" in spec: https:// 
> www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.8.0.pdf 
> <https://www.dmtf.org/sites/default/files/standards/documents/ 
> DSP0134_3.8.0.pdf>
> Number of Cores per processor socket. Supports core counts >255. If this 
> field is present, it holds the core count for the processor socket. Core 
> Count will also hold the core count, except for core counts that are 256 
> or greater. In that case, Core Count shall be set to FFh and Core Count 
> 2 will hold the count. See 7.5.6. Legal values: 0000h = unknown 
> 0001h-00FFh = core counts 1 to 255. Matches Core Count value. 0100h- 
> FFFEh = Core counts 256 to 65534, respectively. FFFFh = reserved.
> 
> Similar for core_enabled2 and thread_count2, they are all extensions 
> when values above 255.

The descriptions of fields "Core Count 2", "Core Enabled 2", "Thread 
Count 2" all say: "If this field is present, it holds the ... for the 
processor socket."

So there is no need to look into the old fields "Core Count", "Core 
Enabled", "Thread Count" for SMBIOS version >= 3.0 and test for 0xff.

We should avoid printing duplicate information.

Best regards

Heinrich

> 
> So, if for the consideration of the old versions of spec, the change 
> should be:
> ```
> -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
> -       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
> -       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
> +      if (smbios_version >= 0x0300) {
> +               printf("\tCore Count 2: %d\n", table->core_count2);
> +               printf("\tCore Enabled 2: %d\n", table->core_enabled2);
> +               printf("\tThread Count 2: %d\n", table->thread_count2);
> +       }
> ```
> Moreover, I think the same logic should be done when the table is being 
> constructed in lib/smbios.c, where the real content of tables is located.
> 
> Regards,
> Raymond
> 
>              printf("\tProcessor Characteristics: 0x%04x\n",
>                     table->processor_characteristics);
>              smbios_print_lookup_str(processor_family_strings,
>                                      table->processor_family2,
>                                      ARRAY_SIZE(processor_family_strings),
>                                      "Processor Family 2");
>     -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
>     -       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
>     -       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
>     +       if (smbios_version < 0x0306)
>     +               return;
>              printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
>       }
> 
>     @@ -719,6 +726,8 @@ static int do_smbios(struct cmd_tbl *cmdtp, int
>     flag, int argc,
>                      struct smbios3_entry *entry3 = entry;
> 
>                      table = (void *)(uintptr_t)entry3-
>      >struct_table_address;
>     +               smbios_version = ((u16)entry3->major_ver << 16) +
>     +                                (u16)entry3->minor_ver;
>                      snprintf(version, sizeof(version), "%d.%d.%d",
>                               entry3->major_ver, entry3->minor_ver,
>     entry3->doc_rev);
>                      table = (void *)(uintptr_t)entry3-
>      >struct_table_address;
>     -- 
>     2.51.0
> 


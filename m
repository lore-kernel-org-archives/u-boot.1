Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E848CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 17:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF8B83BE1;
	Mon, 17 Nov 2025 18:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T47bC6Zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27DA83B9D; Mon, 17 Nov 2025 18:27:59 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0548883B9D
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 18:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 882E13F826
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763400475;
 bh=n5QX1B7mu/jk/CJGRxQ3VOQoYlveyNsBszxOEe0k1js=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=T47bC6ZtKAXwk8Nv0DOnQH/OmBBHXllJ2OyyxeVjGjSLa/PEPg8jJU+Fp35XHYz0F
 CB7eQKxif1IT377R5eOAz3km1XTJyxh41Rn4tF7HUtLGR95JuWXO6p+eBl8MxHuGaY
 PtwmxiPIE78IS3Nak5lRi3dGMMNAkMz8cbSa4ISTvKWJI1yLTgzm3QbRmPn/fEbENd
 l/SRyilsvutnRPvkbqO+z0vHh8ORGkir7/nWTZ3VMTt/gOUIJXE9/scHlWWivFfmaP
 JZA9YMGKTJozl4wyVrLwUFDnrA9yUycw1t5sm4Hl+46eRYwvqMoQit8Ubptpc2YtyL
 /s6ZE3Y7C06pHqdC+6uWTR2pJ7FeUOLwmXlTCzo4ZatHIzB4Owc+3c/mLI11lKevVf
 Nfn/jYBIaFADaZOW90myBz+sgQRJ/DDQ39zOon4Adx0Bw0e8qYVRqR7FMO5BYvqiNj
 ZnxOJhg7lEfiPfqCg3tlHDWK3p1VCTaF1/jCL2edi22tntFP7/3/2xvuCyBWLKT0GD
 BPHiFe7epX+AA7iYCtnM6GBbNpurm5kLnIbTpPje3dGTwm6Pgm04tkt+ptj7/qOTcC
 r8W1KYVrt2IMwA/uvkfwkrJrCLMvNdNi8nrzsVOlopQywghrtJqwP8+LWuk7Adoyn9
 uEhY+rteePt9g3YpOM+dDa/0=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c95fdba8so204601f8f.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763400470; x=1764005270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5QX1B7mu/jk/CJGRxQ3VOQoYlveyNsBszxOEe0k1js=;
 b=Z0i4V+CN2riVZ+1PuJm9usfQaS9zAyAQSuZcm9LOn3GTtqTfJAedS7hoFsP/z76e5c
 6dIMm+4jbsNKg+q5xqriLoHgM2jjlC86s5ajqFcEEdOR/9i69ocqQF3oCXWQKuZEYg89
 sSS50IyhuxUSSmohfCkyGUYJt+7pq4+auM31n/5sV7UF8dLLRlcDArHcbYxBWvuvNPdo
 ThevqGEe5FGjVZJ0xizJ3lOBK3n7RH+ovOuPUn0D62oXOpfejpzHRngx7Y3FNCQD92Se
 zBVa08tSrFdbVZr9JzBqEI54tZ8UGUoOy2v0FHJBLJm8ZF+eb8T6qWXhbORG2PeyJIH+
 cyrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpiloET7e4XNDD6HtJuG9a8nXkotWiubAKHWSNk3/mZiiTPCrkJNnnrZahfvkVbyl1Rq9UgVE=@lists.denx.de
X-Gm-Message-State: AOJu0YwGkDjI8YT8ezy/xZC/aNjXmjuy3iDoI+cDoeWczvasG0BIIWqi
 nwqNPd8HoCGjSB0RplLmiOcTQhx+PERqomWM0LaktZCSRmDmoUAAGlyOYDATq+6a+siv2AcKErs
 RWDUS7vxLmY8261WzdZ9l8J/NVUU6IXzrKY/MRQjOje7Q+YfKyOkwEkkxo0wBv3sPFztPBIyR2j
 vHAHjnCw==
X-Gm-Gg: ASbGncsc6z+70l8RyCznhWYRB0eMaZGDpWcPsZkGBFKn4rMuFAB+0BV4ATVNzpM5mTG
 rCV+DJhSs3/IpXGpyNLUwUQ9Qnrc7fEtkjTg6GU43He2pev+06iQ/EtVIPSDE5ujCZOnbli5PDl
 DzhIxvgHhvkSmVtYmTGBOgpFKPY0ijpVwGWvhtNvyRTAoTKiUNkDku9plxnk2UWRE0I+P3Md9Ks
 VgGAaypP2uO45TtgstufhFZMOPwWZzu9mwZ8nTWMGNdcpl+v0iDDDS7UM1wHTCnygWnw/vOS7kY
 WK1IwCQ17HiGk+sq3wyCTsELrGVX3LPj3T+EUx6d1+7+oA1r3bigStwTxqKWabWW2dnGRFWaSRV
 t8nE7fsetR+oVctsJNO9HKI3bSNtqpyXrELvd0gcwv9QB1dyOeuLF/4K1sPeJom8jAr+xqC8e/F
 F6yApdwPY=
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id
 5b1f17b1804b1-477994bddeemr54492325e9.11.1763400470308; 
 Mon, 17 Nov 2025 09:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5ZkCARQ5xKWutnTcY9xKCjYEj/eHrY9iOm37vfZV9VDSxaO4V/ZWO7eaDD0oy2sNK+YMpqg==
X-Received: by 2002:a7b:c014:0:b0:477:994b:dbb8 with SMTP id
 5b1f17b1804b1-477994bddeemr54492145e9.11.1763400469876; 
 Mon, 17 Nov 2025 09:27:49 -0800 (PST)
Received: from [192.168.103.118]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19664sm27930594f8f.36.2025.11.17.09.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:27:49 -0800 (PST)
Message-ID: <c7727c37-c4a0-4399-82fe-ce421dad7c57@canonical.com>
Date: Mon, 17 Nov 2025 18:27:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: smbios: correct output for table type 4
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
References: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
 <CAMDkj5wQ=pRGFrf_S-HPUs9Zd-uWGFyLFDk3S2TRGCCuvJCMgA@mail.gmail.com>
 <15d4a8ae-5fd2-45df-af9d-e879faf6be1f@canonical.com>
 <CAMDkj5ya41Ea8_VU_VrmRHfMgYJ2q2qLexv14AT1CGYW7vYtwA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMDkj5ya41Ea8_VU_VrmRHfMgYJ2q2qLexv14AT1CGYW7vYtwA@mail.gmail.com>
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

On 11/17/25 18:13, Raymond Mao wrote:
> Hi Heinrich,
> 
> On Mon, Nov 17, 2025 at 11:43 AM Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     On 11/17/25 16:48, Raymond Mao wrote:
>      > Hi Heinrich,
>      >
>      > On Sun, Nov 16, 2025 at 5:39 AM Heinrich Schuchardt
>      > <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>
>      > <mailto:heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>> wrote:
>      >
>      >     In the QFW case the SMBIOS specification version is
>     controlled by QEMU.
>      >     Field 'Thread Enable' is not available before SMBIOS v3.6.
>      >
>      >     We should not print the core, core enabled, and thread counts
>     twice.
>      >     Use the appropriate based on the SMBIOS version.
>      >     Use decimal output which is easier to read for humans.
>      >
>      >     Signed-off-by: Heinrich Schuchardt
>      >     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>
>      >     <mailto:heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>>
>      >     ---
>      >       cmd/smbios.c | 21 +++++++++++++++------
>      >       1 file changed, 15 insertions(+), 6 deletions(-)
>      >
>      >     diff --git a/cmd/smbios.c b/cmd/smbios.c
>      >     index 671c14e05b5..f9a352c107d 100644
>      >     --- a/cmd/smbios.c
>      >     +++ b/cmd/smbios.c
>      >     @@ -262,6 +262,8 @@ static const struct str_lookup_table
>      >     md_tech_strings[] = {
>      >              { SMBIOS_MD_TECH_OPTANE,        "Intel Optane persistent
>      >     memory" },
>      >       };
>      >
>      >     +static u16 smbios_version;
>      >     +
>      >       /**
>      >        * smbios_get_string() - get SMBIOS string from table
>      >        *
>      >     @@ -504,18 +506,23 @@ static void smbios_print_type4(struct
>      >     smbios_type4 *table)
>      >              smbios_print_str("Serial Number", table, table-
>      >serial_number);
>      >              smbios_print_str("Asset Tag", table, table->asset_tag);
>      >              smbios_print_str("Part Number", table, table-
>      >part_number);
>      >     -       printf("\tCore Count: 0x%02x\n", table->core_count);
>      >     -       printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
>      >     -       printf("\tThread Count: 0x%02x\n", table->thread_count);
>      >     +       if (smbios_version < 0x0300) {
>      >     +               printf("\tCore Count: %d\n", table->core_count);
>      >     +               printf("\tCore Enabled: %d\n", table-
>      >core_enabled);
>      >     +               printf("\tThread Count: %d\n", table-
>      >thread_count);
>      >     +       } else {
>      >     +               printf("\tCore Count: %d\n", table->core_count2);
>      >     +               printf("\tCore Enabled: %d\n", table-
>      >core_enabled2);
>      >     +               printf("\tThread Count: %d\n", table-
>      >thread_count2);
>      >     +       }
>      >
>      >
>      > I think for ">= 0x0300", both parts are needed.
>      >
>      > Below is the description of " Core Count 2" in spec: https://
>      > www.dmtf.org/sites/default/files/standards/documents/
>     DSP0134_3.8.0.pdf <http://www.dmtf.org/sites/default/files/
>     standards/documents/DSP0134_3.8.0.pdf>
>      > <https://www.dmtf.org/sites/default/files/standards/documents/
>     <https://www.dmtf.org/sites/default/files/standards/documents/>
>      > DSP0134_3.8.0.pdf>
>      > Number of Cores per processor socket. Supports core counts >255.
>     If this
>      > field is present, it holds the core count for the processor
>     socket. Core
>      > Count will also hold the core count, except for core counts that
>     are 256
>      > or greater. In that case, Core Count shall be set to FFh and Core
>     Count
>      > 2 will hold the count. See 7.5.6. Legal values: 0000h = unknown
>      > 0001h-00FFh = core counts 1 to 255. Matches Core Count value. 0100h-
>      > FFFEh = Core counts 256 to 65534, respectively. FFFFh = reserved.
>      >
>      > Similar for core_enabled2 and thread_count2, they are all extensions
>      > when values above 255.
> 
>     The descriptions of fields "Core Count 2", "Core Enabled 2", "Thread
>     Count 2" all say: "If this field is present, it holds the ... for the
>     processor socket."
> 
>     So there is no need to look into the old fields "Core Count", "Core
>     Enabled", "Thread Count" for SMBIOS version >= 3.0 and test for 0xff.
> 
> 
> But it also says: " Core Count will also hold the core count, except for 
> core counts that are 256 or greater. In that case, Core Count shall be 
> set to FFh and Core Count 2 will hold the count."
> So the "old" fields might be with the same values as the "new" ones, or 
> they might be "FFh".
> That is the reason I believe it is still valuable to print and show 
> whether it is aligned to the spec.

For values below 256 the values will be equal. Why do you want to print 
redundant information?

Best regards

Heinrich

> 
> But anyway, it is not really a big deal to print them or not in cmd - it 
> is just for demo/debug purposes, what I wanted to highlight is the logic 
> to exclude fields for old versions < 0x0300 should be needed in lib/smbios.
> 
> Regards,
> Raymond
> 
>     We should avoid printing duplicate information.
> 
>     Best regards
> 
>     Heinrich
> 
>      >
>      > So, if for the consideration of the old versions of spec, the change
>      > should be:
>      > ```
>      > -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
>      > -       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
>      > -       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
>      > +      if (smbios_version >= 0x0300) {
>      > +               printf("\tCore Count 2: %d\n", table->core_count2);
>      > +               printf("\tCore Enabled 2: %d\n", table-
>      >core_enabled2);
>      > +               printf("\tThread Count 2: %d\n", table-
>      >thread_count2);
>      > +       }
>      > ```
>      > Moreover, I think the same logic should be done when the table is
>     being
>      > constructed in lib/smbios.c, where the real content of tables is
>     located.
>      >
>      > Regards,
>      > Raymond
>      >
>      >              printf("\tProcessor Characteristics: 0x%04x\n",
>      >                     table->processor_characteristics);
>      >              smbios_print_lookup_str(processor_family_strings,
>      >                                      table->processor_family2,
>      >                                     
>     ARRAY_SIZE(processor_family_strings),
>      >                                      "Processor Family 2");
>      >     -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
>      >     -       printf("\tCore Enabled 2: 0x%04x\n", table-
>      >core_enabled2);
>      >     -       printf("\tThread Count 2: 0x%04x\n", table-
>      >thread_count2);
>      >     +       if (smbios_version < 0x0306)
>      >     +               return;
>      >              printf("\tThread Enabled: 0x%04x\n", table-
>      >thread_enabled);
>      >       }
>      >
>      >     @@ -719,6 +726,8 @@ static int do_smbios(struct cmd_tbl
>     *cmdtp, int
>      >     flag, int argc,
>      >                      struct smbios3_entry *entry3 = entry;
>      >
>      >                      table = (void *)(uintptr_t)entry3-
>      >      >struct_table_address;
>      >     +               smbios_version = ((u16)entry3->major_ver << 16) +
>      >     +                                (u16)entry3->minor_ver;
>      >                      snprintf(version, sizeof(version), "%d.%d.%d",
>      >                               entry3->major_ver, entry3->minor_ver,
>      >     entry3->doc_rev);
>      >                      table = (void *)(uintptr_t)entry3-
>      >      >struct_table_address;
>      >     --
>      >     2.51.0
>      >
> 


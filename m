Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E30EA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4833383CE3;
	Tue, 10 Feb 2026 13:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o/AYQ1/H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HeO7qEHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93ECA83CEA; Tue, 10 Feb 2026 13:28:37 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFDA83CB5
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 13:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f9LSy4xTjz9tqm;
 Tue, 10 Feb 2026 13:28:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770726514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFjCwEOkuWPuPb1PB3itMjVPwmOSMxf7KNLORhpBax8=;
 b=o/AYQ1/HVSqB/kbvBdOXc0+dwxjjQvFcwgyEJkBTvVSFj3RPvCiFiQCd6LlkIE6idniwMh
 HqT9HMqsPWZwqGk6lrdkuYWchrOXbzjBwtPzRlv0Q552n/t1qcQ6XAiqwhuo33i6RLfCTK
 SHbkVeW7SD34cp9DGDNvlLw9dpQ7V3JGTWFPqbu4JQ539iaL95WPYzBQ1xM0uSDk8KgpSZ
 P24hJYvXeESEYJkwe4SKmVCuhN4fxF7wue/WBjKZuExnRQGIkkezRFaKlHlg4BCDc7E/Kt
 yB56E29l1SATrW6/CTUvmaDErBRL4GpVSvyheJpH5v0tmVU1Y7csDlG4a9bVgA==
Message-ID: <ccf94e4b-9945-408a-bd9c-bdd681431ea8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770726512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFjCwEOkuWPuPb1PB3itMjVPwmOSMxf7KNLORhpBax8=;
 b=HeO7qEHKKlyU+Ceh+1SBvBpW64uBAjqdKf9LmzUEK3jNeyGlnmBjzeBi1RJD+BlPVQTPCs
 v4kboHBG+7xQEPuHOLBCh6PgRuLz0GyraDn0KMWJipBWg7lybcBpapToCbDusbX8/hPgvd
 4uMVyIl0IJ+KUt0h5yyHTbXUNDdcaTroHXn0/HcYOfDwIPbxtx89U+x7ofv8qNbyyXVxGw
 ZbCXyEV/TBikqAb64ydIRHeOMfE1PakCODwdqrvVl6OoXNl5ItRCDir7Yf7R68Q1G3D/EI
 j4AHfjR07dS+hmDhFszd5zQh4OwJaRMR6So0INGKH/z6K3a1HX9j1zSOYPaTwg==
Date: Tue, 10 Feb 2026 13:28:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: image-fit: Add runtime flag to always relocate
 overlays
To: Jamie.Gibbons@microchip.com, u-boot@lists.denx.de
Cc: Valentina.FernandezAlanis@microchip.com, xypron.glpk@gmx.de,
 trini@konsulko.com, Conor.Dooley@microchip.com, Cyril.Jean@microchip.com,
 sjg@chromium.org, marek.vasut+renesas@mailbox.org, ycliang@andestech.com
References: <20260206151457.4104515-1-jamie.gibbons@microchip.com>
 <9e498de5-d114-485e-840e-1395e153edc3@mailbox.org>
 <4ff7fc064acf76ccaa8d58056fc3473798bd045e.camel@microchip.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4ff7fc064acf76ccaa8d58056fc3473798bd045e.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac10ca33692d0e9bf37
X-MBO-RS-META: zsphunk8hryyu9kheprixak9pqqk4uwn
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

On 2/10/26 1:24 PM, Jamie.Gibbons@microchip.com wrote:
> Hi Marek,
> 
> On Fri, 2026-02-06 at 20:06 +0100, Marek Vasut wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On 2/6/26 4:14 PM, Jamie Gibbons wrote:
>>> Some platforms
>>
>> All platforms, DTs and DTOs have to be 8 Byte aligned, always,
>> period.
> Thanks for your feedback. I have realised I misinterpreted Tom's
> instruction on my previous patch fix about passing a new flag.
>>
>>> require device tree overlays (DTOs) to be 8-byte aligned
>>> when applying them with libfdt. Previously, the code did not
>>> guarantee
>>> this alignment, which could result in alignment errors during
>>> overlay
>>> application.
>>> Introduce a new runtime parameter, always_relocate_overlay, to
>>> boot_get_fdt_fit(). When set, overlays are always copied to an 8-
>>> byte
>>> aligned buffer before being passed to fdt_open_into().
>>> This resolves issues with FDT overlay application on platforms that
>>> require strict alignment.
>>>
>>> Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned
>>> address")
>>>
>>> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
>>> ---
>>>    boot/image-fdt.c |  2 +-
>>>    boot/image-fit.c | 23 +++++++++++++++++------
>>>    include/image.h  |  5 ++++-
>>>    3 files changed, 22 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>> index a3a4fb8b558..33fd4248acd 100644
>>> --- a/boot/image-fdt.c
>>> +++ b/boot/image-fdt.c
>>> @@ -431,7 +431,7 @@ static int select_fdt(struct bootm_headers
>>> *images, const char *select, u8 arch,
>>>                                fdt_noffset =
>>> boot_get_fdt_fit(images, fdt_addr,
>>>                                                              
>>> &fit_uname_fdt,
>>>                                                              
>>> &fit_uname_config,
>>> -                                                            arch,
>>> &load, &len);
>>> +                                                            arch,
>>> &load, &len, true);
>>
>> This flag is always true, do we actually need it ?
>>
>>>                                if (fdt_noffset < 0)
>>>                                        return -ENOENT;
>>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>>> index d2b0a7daccc..a3fa2a01463 100644
>>> --- a/boot/image-fit.c
>>> +++ b/boot/image-fit.c
>>> @@ -2370,7 +2370,8 @@ int boot_get_setup_fit(struct bootm_headers
>>> *images, uint8_t arch,
>>>    #ifndef USE_HOSTCC
>>>    int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>>>                     const char **fit_unamep, const char
>>> **fit_uname_configp,
>>> -                  int arch, ulong *datap, ulong *lenp)
>>> +                  int arch, ulong *datap, ulong *lenp,
>>> +                  bool always_relocate_overlay)
>>>    {
>>>        int fdt_noffset, cfg_noffset, count;
>>>        const void *fit;
>>> @@ -2492,11 +2493,21 @@ int boot_get_fdt_fit(struct bootm_headers
>>> *images, ulong addr,
>>>                ov = map_sysmem(ovload, ovlen);
>>>
>>>                ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
>>> -             ovcopy = malloc(ovcopylen);
>>> -             if (!ovcopy) {
>>> -                     printf("failed to duplicate DTO before
>>> application\n");
>>> -                     fdt_noffset = -ENOMEM;
>>> -                     goto out;
>>> +             if (always_relocate_overlay) {
>>> +                     ovcopy = aligned_alloc(8, ovcopylen);
>>> +                     if (!ovcopy) {
>>> +                             printf("failed to allocate aligned
>>> DTO buffer\n");
>>> +                             fdt_noffset = -ENOMEM;
>>> +                             goto out;
>>> +                     }
>>> +                     memcpy(ovcopy, ov, ovlen);
>>> +             } else {
>>> +                     ovcopy = malloc(ovcopylen);
>>> +                     if (!ovcopy) {
>>> +                             printf("failed to duplicate DTO
>>> before application\n");
>>> +                             fdt_noffset = -ENOMEM;
>>> +                             goto out;
>>> +                     }
>>
>> Looking at this, if the problem is $ov aligned to 4 Bytes, then $base
>> a
>> bit below could also be aligned to 4 Bytes if there are two or more
>> DTs
>> in the fitImage without external data. Can you please try the
>> attached
>> patch and see if that still works ?
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 3ed69b5f7bc..845e769a7e3 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -2368,6 +2368,48 @@ int boot_get_setup_fit(struct bootm_headers
>> *images, uint8_t arch,
>>    }
>>
>>    #ifndef USE_HOSTCC
>> +#ifdef CONFIG_OF_LIBFDT_OVERLAY
>> +static int boot_get_fdt_fit_into_buffer(ulong loadaddr, ulong
>> loadlen,
>> void **fdtdstbuf)
>> +{
>> +       void *fdtsrcbuf, *map;
>> +       ulong fdtdstlen;
>> +       int err;
>> +
>> +       map = map_sysmem(loadaddr, loadlen);
>> +
>> +       /* Set up source buffer, make sure DT in the buffer is 8-
>> Bytes aligned */
>> +       if (!IS_ALIGNED((uintptr_t)map, 8)) {
>> +               fdtsrcbuf = aligned_alloc(8, loadlen);
>> +               if (!fdtsrcbuf)
>> +                       return -ENOMEM;
>> +               memcpy(fdtsrcbuf, map, loadlen);
>> +       } else {
>> +               fdtsrcbuf = map;
>> +       }
>> +
>> +       /* Set up destination buffer, make sure DT in the buffer is
>> 8-Bytes
>> aligned */
>> +       fdtdstlen = ALIGN(fdt_totalsize(fdtsrcbuf), SZ_4K);
>> +       fdtdstbuf = aligned_alloc(8, fdtdstlen);
>> +       if (!fdtdstbuf) {
>> +               printf("failed to duplicate DTO before
>> application\n");
>> +               if (!IS_ALIGNED((uintptr_t)map, 8))
>> +                       free(fdtsrcbuf);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       err = fdt_open_into(fdtsrcbuf, *fdtdstbuf, fdtdstlen);
>> +       if (!IS_ALIGNED((uintptr_t)map, 8))
>> +               free(fdtsrcbuf);
>> +       if (err < 0) {
>> +               printf("failed on fdt_open_into for DTO: %s\n",
>> +                      fdt_strerror(err));
>> +               return err;
>> +       }
>> +
>> +       return 0;
>> +};
>> +#endif
>> +
>>    int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>>                       const char **fit_unamep, const char
>> **fit_uname_configp,
>>                       int arch, ulong *datap, ulong *lenp)
>> @@ -2380,7 +2422,7 @@ int boot_get_fdt_fit(struct bootm_headers
>> *images,
>> ulong addr,
>>          char *next_config = NULL;
>>          ulong load, len;
>>    #ifdef CONFIG_OF_LIBFDT_OVERLAY
>> -       ulong ovload, ovlen, ovcopylen;
>> +       ulong ovload, ovlen;
>>          const char *uconfig;
>>          const char *uname;
>>          /*
>> @@ -2391,7 +2433,7 @@ int boot_get_fdt_fit(struct bootm_headers
>> *images,
>> ulong addr,
>>           * Instead, let's be lazy and use void *.
>>           */
>>          char *of_flat_tree;
>> -       void *base, *ov, *ovcopy = NULL;
>> +       void *base, *ovcopy = NULL;
>>          int i, err, noffset, ov_noffset;
>>    #endif
>>
>> @@ -2489,17 +2531,7 @@ int boot_get_fdt_fit(struct bootm_headers
>> *images, ulong addr,
>>                  }
>>                  debug("%s loaded at 0x%08lx len=0x%08lx\n",
>>                                  uname, ovload, ovlen);
>> -               ov = map_sysmem(ovload, ovlen);
>> -
>> -               ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
>> -               ovcopy = malloc(ovcopylen);
>> -               if (!ovcopy) {
>> -                       printf("failed to duplicate DTO before
>> application\n");
>> -                       fdt_noffset = -ENOMEM;
>> -                       goto out;
>> -               }
>> -
>> -               err = fdt_open_into(ov, ovcopy, ovcopylen);
>> +               err = boot_get_fdt_fit_into_buffer(ovload, ovlen,
>> &ovcopy);
>>                  if (err < 0) {
>>                          printf("failed on fdt_open_into for DTO:
>> %s\n",
>>                                 fdt_strerror(err));
>> @@ -2507,8 +2539,7 @@ int boot_get_fdt_fit(struct bootm_headers
>> *images,
>> ulong addr,
>>                          goto out;
>>                  }
>>
>> -               base = map_sysmem(load, len + ovlen);
>> -               err = fdt_open_into(base, base, len + ovlen);
>> +               err = boot_get_fdt_fit_into_buffer(load, len + ovlen,
>> &base);
>>                  if (err < 0) {
>>                          printf("failed on fdt_open_into: %s\n",
>>                                 fdt_strerror(err));
>> --
>> 2.51.0
> Thanks for the suggestion. I tested your patch and found that, although
> overlays are applied to aligned buffers, the CPU OPP overlay does not
> appear in the final device tree in Linux. With my previous patch above
> (the alignment fix), the OPP overlay works. It looks like the new
> buffer management breaks overlay chaining or the final DT pointer isn’t
> updated correctly, so overlays aren’t present in the running device
> tree.
> Let me know if you have suggestions for tracking the buffer or chaining
> overlays differently.
Maybe some memcpy is missing there somewhere ? Can you please have a 
look and debug this a bit ?

Thank you

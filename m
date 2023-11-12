Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49909C4167D
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 06:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1679186F40;
	Sun, 12 Nov 2023 07:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ri715YSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF5786F8D; Sun, 12 Nov 2023 07:16:40 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943CB86F26
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0C9713FD49
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699769793;
 bh=9SSQ5UJsSJ4kTvK3fl/WmPl1WhQSrvNosKyQ1IMu/Vs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ri715YSs/xKm9nr8uiixN7wNKOOWziyVyA9V+6LXejAHL+LIO642FygzfwLSVlrU3
 1yxrBGtmNzvUdS+OZiQPH1HVS34llXBe0LBljeSgE/PcQiBweZEV+IJtD7KFbnNYAq
 9py6i9IaTJNNp0wrmELV3xAiow+gZfybL4DwbsUkjZCuCdObImTXG9wF3xPd2EH9PJ
 LzLqtObDowNtcOkgRfyaA3kAQK0E0pSKEQu6I0fDlA/483C0TsZqGCdBlloadiHDKD
 9ioyhYfnd0vGlKu7dB2+ai3O8TJRFStF8BdeFuycJBHRkIMG0usehepfw+aNE4vXVY
 HqyO3DWSUtf7w==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408f9e9e9b0so23989105e9.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 22:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699769792; x=1700374592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9SSQ5UJsSJ4kTvK3fl/WmPl1WhQSrvNosKyQ1IMu/Vs=;
 b=Tzt+y04uLrtnaJJpKjpw53Pw0x+D571GNBuVhtiPd3hB9HyQkEmUTmVEv94EfHwxfO
 wgB2UVz2AK/ZBjeLaOkx4wgd7k0nWBV7W/b5XmADlpn3tooeFH2sSu6/TVaZpcJYEw7l
 UnVXDnCO/nTejKKOv9QypwmbDuaPkDXDuF6mpilVC+Ia1AKK8PHP6XvWxbHi67xBE16S
 ceNuhRz35aecwAcqtQJKUYdHfHsxV7fv0Ewi7P7KQkVhZMO7ImnaxYhNNnI5RjxKjEB+
 Ez8CQNbJKfV+nsBMQPtUta4Tl0Nh3K9P7IN2qKdfsJ0KhvSolKVeMb/+4CdgNxbB1C+A
 6DRA==
X-Gm-Message-State: AOJu0Yw757XFpcqlGfK/QRk9KAJwK2UK4v7atQ/pU12PWPbAVrcBcVkF
 cX810VCY1PIgPothXOvUGVOnYwYhqv6niLigigD29lyC0thugMnBlVyNEH/eQTE4tvQDX8AIlCi
 g5SYWSORO55HBSg08OKBtwAbFdpxdMmE=
X-Received: by 2002:a05:600c:1c1a:b0:405:4776:735a with SMTP id
 j26-20020a05600c1c1a00b004054776735amr2844271wms.2.1699769792509; 
 Sat, 11 Nov 2023 22:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUsKrRQ7yvxpJyx9X/EQCkclbpSWp74fxowsiXdk3ueV395x58BYGusNyr2PMTgo+EGGCYqg==
X-Received: by 2002:a05:600c:1c1a:b0:405:4776:735a with SMTP id
 j26-20020a05600c1c1a00b004054776735amr2844255wms.2.1699769791959; 
 Sat, 11 Nov 2023 22:16:31 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 i20-20020a05600c2d9400b004063cd8105csm9709607wmg.22.2023.11.11.22.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 22:16:31 -0800 (PST)
Message-ID: <4727b460-2e9c-4b5b-a9f6-5b7a9ada6987@canonical.com>
Date: Sun, 12 Nov 2023 07:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cmd: acpi: fix acpi list command
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
References: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
 <20231111134112.165377-3-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2jca7az3rgNmDoX0Zi5zSDFFKvaKkVvT-cTVEy3ktv7A@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ2jca7az3rgNmDoX0Zi5zSDFFKvaKkVvT-cTVEy3ktv7A@mail.gmail.com>
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

On 11/12/23 04:08, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 11 Nov 2023 at 06:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
>> to check the presence of the RSDT table before accessing it. This leads to
>> an exception if the RSDT table is not provided.
>>
>> The XSDT table takes precedence over the RSDT table.
>>
>> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>>
>> The ACPI specification does not require that the sequence of tables are the
>> same in XSDT and RSDT. Comparing entries with the same index makes no
>> sense.
> 
> Does it make any sense to have different sequences? Have you seen that
> in the wild?

The ACPI specification requires to ignore the RSDT table if both RSDT 
and XSDT are present. In this case its content is irrelevant. 'acpi 
list' is a display command. We should restrict consistency tests to the 
ACPI unit test.

> 
>>
>> The FACS table header does not provide revision information. Correct the
>> description of dump_hdr().
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/acpi.c | 48 +++++++++++++++++++++++++++++-------------------
>>   1 file changed, 29 insertions(+), 19 deletions(-)
>>
>> diff --git a/cmd/acpi.c b/cmd/acpi.c
>> index 7e397d1a74..d02108d821 100644
>> --- a/cmd/acpi.c
>> +++ b/cmd/acpi.c
>> @@ -17,7 +17,8 @@ DECLARE_GLOBAL_DATA_PTR;
>>   /**
>>    * dump_hdr() - Dump an ACPI header
>>    *
>> - * If the header is for FACS then it shows the revision information as well
>> + * Except for the Firmware ACPI Control Structure (FACS)
>> + * additionally show the revision information.
>>    *
>>    * @hdr: ACPI header to dump
>>    */
>> @@ -25,7 +26,7 @@ static void dump_hdr(struct acpi_table_header *hdr)
>>   {
>>          bool has_hdr = memcmp(hdr->signature, "FACS", ACPI_NAME_LEN);
>>
>> -       printf("%.*s  %08lx  %5x", ACPI_NAME_LEN, hdr->signature,
>> +       printf("%.*s  %016lx  %5x", ACPI_NAME_LEN, hdr->signature,
>>                 (ulong)map_to_sysmem(hdr), hdr->length);
>>          if (has_hdr) {
>>                  printf("  v%02d %.6s %.8s %x %.4s %x\n", hdr->revision,
>> @@ -43,7 +44,7 @@ static int dump_table_name(const char *sig)
>>          hdr = acpi_find_table(sig);
>>          if (!hdr)
>>                  return -ENOENT;
>> -       printf("%.*s @ %08lx\n", ACPI_NAME_LEN, hdr->signature,
>> +       printf("%.*s @ %016lx\n", ACPI_NAME_LEN, hdr->signature,
> 
> We really don't want 16 hex digits of output. It just isn't readable.
> 
> Should we add a way of writing a hex number with an underscore between
> digits 8 and 9?
> 
> 12345678_3846263d

I want to be able to copy the number and reuse it without editing in 
other commands.

We should simply get rid of the leading zeros as they confer no meaning.

Best regards

Heinrich

> 
> Better I think (at least for now) would be to use %10lx and live with
> the column misalignment in the unlikely event that very large
> addresses are used.
> 
>>                 (ulong)map_to_sysmem(hdr));
>>          print_buffer(0, hdr, 1, hdr->length, 0);
>>
>> @@ -62,26 +63,34 @@ static int list_rsdt(struct acpi_rsdt *rsdt, struct acpi_xsdt *xsdt)
>>   {
>>          int len, i, count;
>>
>> -       dump_hdr(&rsdt->header);
>> -       if (xsdt)
>> +       if (rsdt)
>> +               dump_hdr(&rsdt->header);
>> +       if (xsdt) {
>>                  dump_hdr(&xsdt->header);
>> -       len = rsdt->header.length - sizeof(rsdt->header);
>> -       count = len / sizeof(u32);
>> +               len = xsdt->header.length - sizeof(xsdt->header);
>> +               count = len / sizeof(u64);
>> +       } else if (rsdt) {
>> +               len = rsdt->header.length - sizeof(rsdt->header);
>> +               count = len / sizeof(u32);
>> +       } else {
>> +               return 0;
>> +       }
>> +
>>          for (i = 0; i < count; i++) {
>>                  struct acpi_table_header *hdr;
>>
>> -               if (!rsdt->entry[i])
>> -                       break;
>> -               hdr = map_sysmem(rsdt->entry[i], 0);
>> +               if (xsdt) {
>> +                       if (!xsdt->entry[i])
>> +                               break;
>> +                       hdr = map_sysmem(xsdt->entry[i], 0);
>> +               } else {
>> +                       if (!rsdt->entry[i])
>> +                               break;
>> +                       hdr = map_sysmem(rsdt->entry[i], 0);
>> +               }
>>                  dump_hdr(hdr);
>>                  if (!memcmp(hdr->signature, "FACP", ACPI_NAME_LEN))
>>                          list_fadt((struct acpi_fadt *)hdr);
>> -               if (xsdt) {
>> -                       if (xsdt->entry[i] != rsdt->entry[i]) {
>> -                               printf("   (xsdt mismatch %llx)\n",
>> -                                      xsdt->entry[i]);
>> -                       }
>> -               }
>>          }
>>
>>          return 0;
>> @@ -92,10 +101,11 @@ static int list_rsdp(struct acpi_rsdp *rsdp)
>>          struct acpi_rsdt *rsdt;
>>          struct acpi_xsdt *xsdt;
>>
>> -       printf("RSDP  %08lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
>> +       printf("RSDP  %016lx  %5x  v%02d %.6s\n", (ulong)map_to_sysmem(rsdp),
>>                 rsdp->length, rsdp->revision, rsdp->oem_id);
>>          rsdt = map_sysmem(rsdp->rsdt_address, 0);
>>          xsdt = map_sysmem(rsdp->xsdt_address, 0);
>> +
>>          list_rsdt(rsdt, xsdt);
>>
>>          return 0;
>> @@ -111,8 +121,8 @@ static int do_acpi_list(struct cmd_tbl *cmdtp, int flag, int argc,
>>                  printf("No ACPI tables present\n");
>>                  return 0;
>>          }
>> -       printf("Name      Base   Size  Detail\n");
>> -       printf("----  --------  -----  ------\n");
>> +       printf("Name  Base               Size  Detail\n"
>> +              "----  ----------------  -----  ----------------------------\n");
>>          list_rsdp(rsdp);
>>
>>          return 0;
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08C5D730A2
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 05:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E500384020;
	Fri,  3 Apr 2026 07:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zUPySWUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5428407E; Fri,  3 Apr 2026 07:29:19 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6D183DC9
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 07:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64e87a81639so1487914d50.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 22:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775194155; cv=none;
 d=google.com; s=arc-20240605;
 b=Lqhzsgu8uxtV7yCVAh8j57Erdme6/9vd/8yk3ZVw/TP/5rwD87f9nEgyYq+0bmtLhw
 zx8Vo204sEdwGGGMaSwAnAZTsnZzytd2n0F8CNGgU37y909qEHbE+FmRJRSHRP1qE39N
 mo056/0wJzv2TtwEKV5CbXuqTuOmyDKQ00RH+3cYTqwy6yfsAmOlyRw7frNndZ9ESjww
 jMPVNRwhTJ6CGVP65eaIfGIj6vPKlzaHtqoFWbr7Deg9oBO7g+2KE7vmdky+1kvO6eLT
 1TlVWeJLDLa6S+sujvOY0njN1iR/dbtQV7SCxphxdtuj8eIjyLvL+FBcrtffFH4GSDR6
 t4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WqGykn2gzJV7VsjK2igi0j6beAQhZTlyWpRkV+6c8n0=;
 fh=xQzR5o2A8M9wqiA8Fg5jB1ICrTFdmVPV658WtdmuFdI=;
 b=ZztXgI2k8ZUO2GlnUln8X3kWzzvdiNPV+c1eDdz1jNpVe4mlBbukoQfi/TrXvSYQiE
 ADCVkDFLk0EqR5PjvJvwW9urOX52BtHqikvkrKHRyepb97L0gsXVHNcnwTDA+puBp+yg
 cgmrkWqa3iezZj3ijCT5nMIUSUYM6pmieOTIIx97ALscMqt0q8Fvo4vIjl1KCiswG1Cm
 PRxpv7695I1mfQrEbNFCsLpzlKbeCdf+iPnC976lHTWGzU4Jv5lG57zVzWxuWq/KQFja
 MBU6hHA25TxZ87m21/71yHtKoHXsl2s027ih4U6W01BjNOAiT18ANToHWypsYlKKhkGF
 tRiw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775194155; x=1775798955; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WqGykn2gzJV7VsjK2igi0j6beAQhZTlyWpRkV+6c8n0=;
 b=zUPySWUwhi/GqT61kSmbePeT71jwsP9B4etBxrWVb+qvVXM0FzhU/eXdZxe9odxEI4
 xN7Dual4mP8ONx3WhV3xkGbSrUCJZoVowqWaAcXnJZOiytGrdqAWp9PLwEPw0PrM3amD
 j6pr4XDEE7UowfU8KEbooUDKRhebRpmZuSLD9TNKrZ0Zun5XePcEFh4CVqB5XwAwuOOn
 2Ne2R4pqVeucwfUBD9MvLLY+mfYlH3MnPSmL1CVb8ZLkXtau62+SwAUSumlQcZrYkCg4
 dmBT8JfhlBRka6CWtLR+jCf1GJeSltTIGmVXOCJhTSn3/zymlzvXEh4MkwYON9bjVLVv
 V/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775194155; x=1775798955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqGykn2gzJV7VsjK2igi0j6beAQhZTlyWpRkV+6c8n0=;
 b=OYzjqkoEyYfKLQjEKGXJD3FRofA1c0Z5Fc49PshZzIp3/HeTEqBe+ObV4rF43X6ET3
 LyPkFfB5vwA3ucLfENKhm6/4MGRGH3JUOgFGn5xoow8Ki2BTWXVSiNeZBfMRfZsUkfLM
 oEDFGuJ0lgRehYx6ZrcAR1GHURW7g/nRg7LWSLLQxTHCS1r+NHIM7S9M5bblX9t/w0MJ
 jmRT7aOhKNUEysZpLzwMv3dkih37lKtbDII3Q9FB+B31nYUSUK2mMVFV+48Sq6WWevNo
 8YHQAXEEf55brvt7ANogS1XullpY65PadzPOk7lCeU0jXnNhCgn7ysZeqnvUsu9DR+Vt
 nMFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvsf396tNthTxvDF7lwtvs/am1T/ZV8Dn1hqAfb+qDZfYPyUpFQt18pss8IMQ3J8/e7zuFpjE=@lists.denx.de
X-Gm-Message-State: AOJu0YzykGfuCn9MrbPRBrqHPLJ8z6pRlJ/XeoiGbL+2FhdPxRRU1RXd
 qbEw+KopDpKZO+YrEy+/fXTtw35M+LrCBlCGVmmz6DxClBeaclC3fnq4/SOdOVwpqxv7IpZPMaQ
 jU7UixP4aSEzbT03rL4jDNufPlpKranOfJglOpXoF2g==
X-Gm-Gg: AeBDiesVv+v5vAGux8JcwM7HSRAiJ9KiSnxhC8kn+pcsAl9icEUqI2L9N30GZzoGAxT
 iqfjY6rt1nxpK1AutewXC2UOVlamKgCtktIC/sgIa208Mz7rYNmugp7gxYhfnDnke680rpikgka
 FxbbJo8mWsZpDmPd/VQUMB5WyZK0bcSwSfyCF1d0iW+RMIv9hF46vf9/yyq6ePt5+GBFcOiyQZf
 eEA1aI+IoD5URyqpyG2G1gPtBY5ADebu6Vn1cMYRR7QzI8xD7F1Bkrb60WBBMD/ZnjjZ+FahHS7
 fUjmh9IjHSLE8RQ6abj/2+KpMmV51f50wEUgmZ0BR1CzmvUU7pjUEClQibeB4tZgsnsmdWwvrlv
 +PtkOe9brK3XlXBPIkrSniZJCeZl/6ToHojJ0ZYlpVrjCM38Z8sD0T3MwsvmJUXYzXnCN6PfPHA
 RKGsLHGCqF17nrmivTQ0FTwT5MPcPl35sd+ehKY5D9koxRIrmXb34lzDobq7TXNUpl6EBRsNWZT
 B6gPByHBBEZRHb3NZ2+gy4vgA/tGvAWAzM1hSRyeKxS1g+88c04co3MHvtivgqtykrEdIe0TphA
 wfM7c3+LhIEZ1D9pHCKMvNLbl2wwNqq/HVhxLTSLaAD3
X-Received: by 2002:a53:b702:0:b0:650:1d21:d6af with SMTP id
 956f58d0204a3-6504880fe6dmr1139942d50.40.1775194154811; Thu, 02 Apr 2026
 22:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-6-rs@ti.com>
 <CAC_iWjKbeph+3M=GDy3_KeprSaUTVd3375O3Ny9GPV14XNBUgg@mail.gmail.com>
 <DHIUKA2JVA4H.V11Z7EF0I1A1@ti.com> <DHIXO2TK649C.JAGU2F3IZ91S@ti.com>
In-Reply-To: <DHIXO2TK649C.JAGU2F3IZ91S@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 3 Apr 2026 08:28:38 +0300
X-Gm-Features: AQROBzBNedgA44ltInNrKP2PriFc14R5Q_MMmIOWYTogGGteQr1jNbi_b6KeoSk
Message-ID: <CAC_iWjK=Fx80=Zh73f01oLvQETd8qiuqWyVXCDDpQcwC=BDdtQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi_memory: backfill EFI_CONVENTIONAL_MEMORY
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

[...]

> >>
> >>> +}
> >>> +
> >>>  /**
> >>>   * efi_allocate_pages - allocate memory pages
> >>>   *
> >>> @@ -507,10 +528,20 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >>>         /* Reserve that map in our memory maps */
> >>>         ret = efi_update_memory_map(efi_addr, pages, memory_type, true, false);
> >>
> >> In theory the lmb and the EFI maps are in sync. I haven't checked
> >> close enough yet, but do you have cases where lmb_alloc worked and
> >> updating the efi memory map failed?
> >
> > Fair point. Now that I've fixed the FDT warning I should probably check if I can
> > actually reproduce the issue that actually required this.
>
> Yeah, this patch isn't necessary anymore. I suppose it should be dropped as it
> would potentially mask any discrepancies between the two maps.

Yea and if we really need a similar fix in the future, it's best if we
put in the lmb core code.

>
> Out of curiosity, is there any plan to merge the EFI and LMB allocators more in
> the future, or is the current layering scheme the furthest we want to go?

We do, but havent due to lack of time. It's been a while since I
discussed this with Heinrich but iirc the only thing missing is for
lmb to be aware of the memory flags EFI expects.

/Ilias
>
> >>>         if (ret != EFI_SUCCESS) {
> >>> -               /* Map would overlap, bail out */
> >>> +               /* Map would overlap, try something else */
> >>>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> >>>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
> >>> -               return  EFI_OUT_OF_RESOURCES;
> >>> +
> >>> +               /* See if there is any EFI_CONVENTIONAL_MEMORY allocations */
> >>> +               if (type != EFI_ALLOCATE_ADDRESS) {
> >>
> >> Can you please inverse this. It's going to reduce the identation.
> >> if (type == EFI_ALLOCATE_ADDRESS)
> >>> +                       *memory = efi_get_conventional_start(pages);
> >>> +                       if (*memory != 0)
> >>
> >> Same here
> >>
> >>> +                               return efi_allocate_pages(EFI_ALLOCATE_ADDRESS,
> >>> +                                                         memory_type, pages,
> >>> +                                                         memory);
> >>> +               }
> >>> +
> >>> +               return EFI_OUT_OF_RESOURCES;
> >>>         }
> >>>
> >>>         *memory = efi_addr;
> >>> --
> >>> 2.53.0
> >>>
> >>
> >> Thanks
> >> /Ilias
>

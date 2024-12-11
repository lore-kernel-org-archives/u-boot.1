Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6821FE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7F5800B3;
	Wed, 11 Dec 2024 19:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tnf+Ug42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B231A8007A; Wed, 11 Dec 2024 19:16:48 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF933800B3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 19:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso6097281a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733941005; x=1734545805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gzNN0Axe8Svj9ZyYnqMtpwvnqVZeJTdemccIcFapaUQ=;
 b=tnf+Ug42+AQJXTKTu6qKIU9EhFGcoqXekN8j/Sbs7gsX58ldqWHgPNC280EH2ltspm
 TOMWQet2UbVRUDAgK34NmgQJlCwzx5ga0bidiUI/Q3VdjRCdvoJ0I5c0ZdAgylWggIpj
 6+pLNumAkp4DcKI36Y0u61Lo1LM7tNrTP/dUqSYGbS9lreOYzE850Z06Zt2lkPsRqcy4
 Q+GV2oNrW9C4uKZWfYYEhCQRjzgANq7eQWrDxNSCYgeDQ4UARDInINQQQEdxUs10lVm6
 JRNBj5PUwxR2YPSYxPDNDly3m0KnPPNQ45gD1YswswCIMzDYGxZ68YF+D/TEUr2Tabjr
 guRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733941005; x=1734545805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzNN0Axe8Svj9ZyYnqMtpwvnqVZeJTdemccIcFapaUQ=;
 b=XPLCBVG/Lq3A4rFiU4n3G0I7Jo8D/75+QaWsS6dUtBaBBfTbRpmSHuBOmhMmU0q1lL
 AB2G9514GnZFLXg8MP1NbRhc0H4aL+/YI6+JbIADIPqZwVcjuoBPznSD5Rc4yZ4n8Nuy
 Whh84+Nm9AtzbMVXFYZZV2FiG/jpIjlvMotY99YkZkszLALyAElmGqdW3S+NXv5lfMHw
 Hrc9p6LRTkVcy6rFxMlBWa2XtdrV+kADyU92Slmt5/2KHFloL0zlIaSzEQOh3dVcWJcS
 DszXPXFuey2ndXF3EpYsoQ6CJmqbRqPszRAi8OzA1QPJGoLDVv1IMnAydEL2aSpG+Pdu
 Gkpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJYyHVqzEpuMuExDf+o6AJ/uESfrflxNDp5Zq5/7ivNBHYFj78WiHUZKuOzQtcl23EDnu8LJA=@lists.denx.de
X-Gm-Message-State: AOJu0YzoQ+Vmqa/QcfEQD6cyrSL0/00W9HuTtDjUYnoXs185gtlB18nE
 pQUlGb0tQPx95AUx6kmz7dPOP8/JVYnt4EV5QaJCk29i0nCTBuprc7frdStUPTgDzp0qZ6okNIT
 /7iBdYqvieLwZ6nu0uVCiRcHve6pwwYImOZOBqw==
X-Gm-Gg: ASbGncs+cV+Y5EqFj/MuwCPxFf+mUc4kSorWnzo02sTdL/zbmcbsugWCnDimVtzavW+
 Qe6HdlJllbxQGilwV6gknCiU6u++mW8Dy9pai
X-Google-Smtp-Source: AGHT+IG1mbbSTMmLgTL7At1FP4ypcqU1GFo26FjLsLPH/y48aLpiGFyCAyRWjW84llvHUuZxJjS4d/SXrKBoppAjaxg=
X-Received: by 2002:a05:6402:2349:b0:5cf:420a:9 with SMTP id
 4fb4d7f45d1cf-5d445b1ac32mr658852a12.5.1733941005311; Wed, 11 Dec 2024
 10:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
 <7642b0fc-8383-4877-bbc6-22bcd22536fc@foss.st.com>
In-Reply-To: <7642b0fc-8383-4877-bbc6-22bcd22536fc@foss.st.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 11 Dec 2024 23:46:34 +0530
Message-ID: <CADg8p951Y10c_ffDCKZaCS6kG+c8mR2aDrTtDgD3rZsWoBM3Cw@mail.gmail.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>
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

On Wed, 11 Dec 2024 at 22:20, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 12/11/24 17:27, Sughosh Ganu wrote:
> > On Wed, 11 Dec 2024 at 21:50, Patrice CHOTARD
> > <patrice.chotard@foss.st.com> wrote:
> >>
> >>
> >>
> >> On 12/7/24 16:57, Tom Rini wrote:
> >>> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> >>>
> >>>> There are platforms which set the value of ram_top based on certain
> >>>> restrictions that the platform might have in accessing memory above
> >>>> ram_top, even when the memory region is in the same DRAM bank. So,
> >>>> even though the LMB allocator works as expected, when trying to
> >>>> allocate memory above ram_top, prohibit this by marking all memory
> >>>> above ram_top as reserved, even if the said memory region is from the
> >>>> same bank.
> >>>>
> >>>> [...]
> >>>
> >>> Applied to u-boot/master, thanks!
> >>>
> >> Hello
> >>
> >> This patch is breaking the boot on STM32MP135F-DK.
> >>
> >> On this platform, we got an area above gd->ram_top,
> >> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
> >>
> >> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
> >> this area is no more tagged as LMB_NOMAP, because it's previously been
> >> tagged with LMB_NOOVERWRITE in lmb_add_memory().
> >>
> >> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
> >>
> >> I suggest to revert this patch.
> >
> > I don't think that this patch should be reverted. If the said platform
> > has a reserved memory region above ram_top, I would suggest to either
> > a) move the ram_top on this platform so that the op-tee region gets
> > marked as no-map in the lmb memory map, or b) do not use the lmb
>
> In my explanation above, i indicated that before this commit,
> this area was marked as LMB_NOMAP in the lmb memory map by boot_fdt_add_mem_rsv_regions().
> this is exactly what you described in the possible solution "a)".
>
> But now with this commit, as lmb_add_memory() is called in lmb_init() the area above ram_top is marked LMB_NOOVERWRITE.
> Then later, boot_fdt_add_mem_rsv_regions() is executed, but the area above ram_top can't be marked as
> LMB_NOMAP as previously because it's already marked LMB_NOOVERWRITE.

This has been done to ensure that memory above ram_top is not taken
into consideration when it comes to U-Boot. The reason why memory
above ram_top also needs to be added is to ensure that this memory
also gets passed on to the OS when booting with EFI. If it has to be
considered by U-Boot, the value of ram_top needs to be adjusted
accordingly. Is that not possible on the platform? If not, the only
other solution is to obtain this memory region from the DT, and then
configure the MMU.

>
>
> > memory map to configure the MMU -- can the MMU configuration logic not
> > read the DT to get which regions are to be marked as no-map?
> >
> > As far as the lmb module is concerned, it is being told through this
> > commit to not consider memory above ram_top for allocations, which is
> > not an incorrect thing imo.
>
> That's the case, we don't consider memory above ram_top for allocations,
> we only marked it with LMB_NOMAP.

That was because the lmb scope was local. That meant a platform could
add any size that it wanted, and then use that map for whatever it
fancied. The use of lmb for "allocating" addresses for io-va addresses
by the apple iommu is another such case.

-sughosh

>
> Thanks
> Patrice
>
> >
> > -sughosh
> >
> >>
> >> Patrice

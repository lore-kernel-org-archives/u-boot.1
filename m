Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEE8C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83C188617;
	Sun, 11 Aug 2024 16:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XK5oIYCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D5C885B3; Sun, 11 Aug 2024 16:50:16 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DDA88176
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf42a563c8so202896d6.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387813; x=1723992613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YUT1eyH/snTUQx7Mpmqh16o6mnv7afKFV1q4XTU+LM0=;
 b=XK5oIYCmDGvnuWV/0oTGL9qTk9htfsdGZI1KRoqRwwS26VuS+5O5ShIx/tvlWzSKKy
 jyJt5+9EvyhLUrDk7FIQ8X8HriUvnAatMirhx7jWF4iAaBEn+BlE2XHjLxV/nFYedhXT
 Q4PHHbxbxQcWSkMTiXrXy4GwtLoMe9gXi9Yu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387813; x=1723992613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YUT1eyH/snTUQx7Mpmqh16o6mnv7afKFV1q4XTU+LM0=;
 b=B8WcaYU7oiCGnVtxJmrR+EQAmaPjQt+OE7FiIRT9ErOKPvIGI3624lXqgkyAdaKn4c
 5xxCVE7VNgLdJPH9zmHef2JNuQXz8SukF5+FFiGPyvZPvuQgtlORQD53sjtK6EQv/N4y
 FKGpczMxSO/wxvICFFZSC0FMFZVU/5uqjqeYx/XPo/V866DOUi/wqh9yY/SwH6j2GeY7
 +YVBJh9nItQieNrJR8EwCIzYWwueZAIjVcjYFZV07UTp4dJppvEjv545sKjMWv9s7sDt
 opKiofJCGllygExmKYXFb5h+k4t/r9Pk4HaWdNwZmDL56GpZBjWKq4TA5IrhwvufWiki
 TjvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYMcJpOkGX2ZA65MalnDrXynufQ3fI57LPYkqzbtDutf4/tIIL7Hh9S6aeem1bVbZd/fRTsIBPuZ4zqHsdFuRokaGB7w==
X-Gm-Message-State: AOJu0YwF543hIpiU1hXigMMdNEDkNu6d3XtnL0SbDTkgnjPEMpN7dWOq
 VWOtsaiKqoCXI9NPV69Yuf028D4aOAu5uwXsf6eciNl1CXtPv5neRcMz3l3bmf2puNbWCUhA/cr
 XQJ37hMHrkhdvo+q9VBMXPtKA1Ifk9bnrvQ9L
X-Google-Smtp-Source: AGHT+IGGrj6SgJrTwuR7yEOkwAGj2bwVjt/PT6GPd8pqO8GZsSrpJ3RQg89GwJ2MVWjDnyp9Km8dBCUANjq0Ja5Hn3k=
X-Received: by 2002:a0c:c487:0:b0:6bd:88d5:fa87 with SMTP id
 6a1803df08f44-6bd88d5fad3mr45317056d6.55.1723387813094; Sun, 11 Aug 2024
 07:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-4-sjg@chromium.org>
 <4594d522-bb63-45ee-b660-0130ae55d341@gmx.de>
 <CAFLszTgmRMCK9E==O-sz51ONfaGENnoStXPY4LL5HS0F-=cDfA@mail.gmail.com>
 <5EA6AA2B-533E-424D-B2E9-13A4CA8C2E9A@gmx.de>
In-Reply-To: <5EA6AA2B-533E-424D-B2E9-13A4CA8C2E9A@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:02 -0600
Message-ID: <CAFLszTiYdE4CK2tf3=mxgZBatg4r55=G0X=LxDhofuqZU1TQNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: Show the location of the bounce buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

+Marek Vasut too

Hi Heinrich,

On Fri, 9 Aug 2024 at 13:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 9. August 2024 20:36:35 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Fri, 9 Aug 2024 at 11:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 01.08.24 19:36, Simon Glass wrote:
> >> > The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> >> > clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> >> > lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> >> >
> >> > This feature uses EFI page allocation to create a 64MB buffer 'in space'
> >> > without any knowledge of where boards intend to load their images. This
> >> > may result in image corruption or other problems.
> >> >
> >> > For example, if the feature is enabled on qemu_arm64 it puts the EFI
> >> > bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> >> > 1088MB. The kernel is probably smaller than 27MB but the buffer does
> >> > overlap the ramdisk.
> >> >
> >> > The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> >> > version being dropped. For now, show the address of the EFI bounce
> >> > buffer so people have a better chance to detect the problem.
> >> >
> >> > Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
> >> > that the feature may be removed.
> >>
> >> EFI_BLOCK_IO_PROTOCOL.ReadBlocks() and
> >> EFI_BLOCK_IO_PROTOCOL.WriteBlocks() are expected to block until all
> >> bytes are transferred.
> >>
> >> The complete file transfer is chunked according to the size of the EFI
> >> bounce buffer.
> >>
> >> Taking care of alignment issues would best handled by the block uclass.
> >>
> >> When CONFIG_BOUNCE_BUFFER=y, bounce_buffer_start_extalign() uses
> >> memalign() which limits the bounce buffer to available malloc() memory
> >> (typically < 2 MiB).
> >>
> >> I cannot see how blk_read() with CONFIG_BOUNCE_BUFFER=y will work if
> >> blkcnt * desc->blksz is greater than the available malloc memory.
> >
> >Yes, it uses malloc(). The maximum read length on MMC, for example,
> >seems to default to 32MB, although it is only 128KB on a few
> >platforms.
> >
> >I am thinking we should be allocating space in the bloblist to hold
> >all these sorts of things...it can be as large as needed and we can
> >allocate space for it during relocation.
> >
> >>
> >> Shouldn't the block uclass support chunking?
> >
> >It only supports readling whole blocks, if that is what you mean. Are
> >you suggesting changing the blk API, or something else?
>
> It supports reading multiple blocks. If not all blocks fit into the memory that can be assigned via memalgn, the block layer coud separate the blocks into chunks. This would replace the EFI bounce buffer.

Ah OK, yes it could do that.

Regards,
Simon

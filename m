Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1254C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1029A88C01;
	Thu, 15 Aug 2024 22:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KtR8p4up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B6A88B63; Thu, 15 Aug 2024 22:35:22 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A521888C07
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so1062980a12.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754117; x=1724358917; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hyXaTnlFG4joiLMNekVTOvs5RJtfQuY+xBuve7lCwZY=;
 b=KtR8p4upSpX/nu5NGj1KTpxc0R5GL/+Wm4UNlPgqtEWwdz3AxWi+5Ts5WBGUQZwTWG
 Lj8ZXr6p5llP/eb+Kwh7lnyOzaXbKSZoPzfLHpEXjl/hcK2q3B4X35AQcUGQdlqiJv0Q
 1fk/Ghlh83kwQ8BRDSfjKdSrNEkbd4zqVZ77U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754117; x=1724358917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyXaTnlFG4joiLMNekVTOvs5RJtfQuY+xBuve7lCwZY=;
 b=hUSncz1Fr2X+WcR3Z+TzC4rvOoWfROtyZ3WuioCSmCH2wHghWOcG60ec5Y+uLGCT99
 8+kvn5ucOobH8sqhWJVK+noj3jGqwxpwjihOQZScbXgN+aGkLDEjd/j+KWkR2CgSKs21
 D1DrjGzhXpUX9EP5mtIfsXbAlEWspSAC6c7gA22yEi/XF/ST6eArdajv1c77Ypg7ovUZ
 hCvJlREgR/UnlCwQ3dPpLqqc6gqF/8jGxph7LS/mk3ntQ0FPYKYjZALdPVZrtcB97aKd
 hy5C7A0GmS7Tsr9YLBXIr5OV7GK7kDg2+E6VIJT1+KnmtiJwyOhTA+xaShbxgXM+SZyi
 7Cqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo6inAn4fun9KX4krflZJ0PXWQ77+f9y7kzBLpmG0w9WBdEWIdKqOF4y9S22DaYRzraUTNyJHEX4P7ChzN3s8KyoWGug==
X-Gm-Message-State: AOJu0YywoGZmHTjepMBo1cmYxnzBaoTaqntO5S/yQzmkNhk+ae5EMrwq
 9Beng6Ru8FRVPDvbMIkCMMWp9mMnHdGXqsoKf+zwYA7Aey34f5+dDJv6JKnoa3lCP0sYMfykQKh
 grg6s3W+N9BTkaIzf/y5yT+gs2ITpYstV61Dt
X-Google-Smtp-Source: AGHT+IH09Efhxms5hGxOyyVi7WjTsPtL/HV6xslx4dEQf2S7t2Szw7/+vn97sZ4+uX9IQwCBShFgg85JjVY+csgoGi8=
X-Received: by 2002:a17:90a:ca89:b0:2d3:b49f:acd0 with SMTP id
 98e67ed59e1d1-2d3dfd8d3e0mr916803a91.20.1723754117420; Thu, 15 Aug 2024
 13:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-4-sjg@chromium.org>
 <4594d522-bb63-45ee-b660-0130ae55d341@gmx.de>
 <CAFLszTgmRMCK9E==O-sz51ONfaGENnoStXPY4LL5HS0F-=cDfA@mail.gmail.com>
 <5EA6AA2B-533E-424D-B2E9-13A4CA8C2E9A@gmx.de>
 <CAFLszTiYdE4CK2tf3=mxgZBatg4r55=G0X=LxDhofuqZU1TQNw@mail.gmail.com>
In-Reply-To: <CAFLszTiYdE4CK2tf3=mxgZBatg4r55=G0X=LxDhofuqZU1TQNw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:35:06 +0100
Message-ID: <CAFLszThN27npLDq5tb0gjD5fZTnb+5OTg7OjjksFdEG1=NBAHw@mail.gmail.com>
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

Hi Heinrich,

On Sun, 11 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
>
> +Marek Vasut too
>
> Hi Heinrich,
>
> On Fri, 9 Aug 2024 at 13:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> >
> >
> > Am 9. August 2024 20:36:35 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >Hi Heinrich,
> > >
> > >On Fri, 9 Aug 2024 at 11:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 01.08.24 19:36, Simon Glass wrote:
> > >> > The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> > >> > clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> > >> > lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> > >> >
> > >> > This feature uses EFI page allocation to create a 64MB buffer 'in space'
> > >> > without any knowledge of where boards intend to load their images. This
> > >> > may result in image corruption or other problems.
> > >> >
> > >> > For example, if the feature is enabled on qemu_arm64 it puts the EFI
> > >> > bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> > >> > 1088MB. The kernel is probably smaller than 27MB but the buffer does
> > >> > overlap the ramdisk.
> > >> >
> > >> > The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> > >> > version being dropped. For now, show the address of the EFI bounce
> > >> > buffer so people have a better chance to detect the problem.
> > >> >
> > >> > Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
> > >> > that the feature may be removed.
> > >>
> > >> EFI_BLOCK_IO_PROTOCOL.ReadBlocks() and
> > >> EFI_BLOCK_IO_PROTOCOL.WriteBlocks() are expected to block until all
> > >> bytes are transferred.
> > >>
> > >> The complete file transfer is chunked according to the size of the EFI
> > >> bounce buffer.
> > >>
> > >> Taking care of alignment issues would best handled by the block uclass.
> > >>
> > >> When CONFIG_BOUNCE_BUFFER=y, bounce_buffer_start_extalign() uses
> > >> memalign() which limits the bounce buffer to available malloc() memory
> > >> (typically < 2 MiB).
> > >>
> > >> I cannot see how blk_read() with CONFIG_BOUNCE_BUFFER=y will work if
> > >> blkcnt * desc->blksz is greater than the available malloc memory.
> > >
> > >Yes, it uses malloc(). The maximum read length on MMC, for example,
> > >seems to default to 32MB, although it is only 128KB on a few
> > >platforms.
> > >
> > >I am thinking we should be allocating space in the bloblist to hold
> > >all these sorts of things...it can be as large as needed and we can
> > >allocate space for it during relocation.
> > >
> > >>
> > >> Shouldn't the block uclass support chunking?
> > >
> > >It only supports readling whole blocks, if that is what you mean. Are
> > >you suggesting changing the blk API, or something else?
> >
> > It supports reading multiple blocks. If not all blocks fit into the memory that can be assigned via memalgn, the block layer coud separate the blocks into chunks. This would replace the EFI bounce buffer.
>
> Ah OK, yes it could do that.

I am still not sure what changes are needed with this patch. I cannot
use malloc() for the bounce buffer, so for now (until we improve
things) I would like to print this message as a warning to fsl users.

So please can you provide a clear response to the above?

Regards,
Simon

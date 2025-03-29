Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C57C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 12:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E404381E60;
	Sun, 30 Mar 2025 14:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nshg4yRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A6B805C8; Sat, 29 Mar 2025 10:05:54 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F5A800C1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 10:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so2487951276.0
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743239150; x=1743843950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s9GtLCu3gyux9oVcvDMwLhHdah2i3b65TcWN3cFiwwk=;
 b=nshg4yRX5MD6a7iRM0NUi71dX2qoVra/Ce5eL8/fR8/sdpMGCGYu4CZCunfaAugTmv
 xhTiGf9uZWEjE2c3oQ4QtfKszE8KqtzD2/bc6l2OArMxhmSgRblA4hodRex4O1ckPQjb
 o5fFFNnj6EQ5lLd8jetSnI5uwEVfkpoTKIYsqj1fxapjn0LsYxlw0fMcicrag3DxR3dX
 3eDc/taYeuSKXeciXq/GFFHJXFZQvyXPUxG3yaE0T+vBNK5QTVnicTn1GIVqOE2ueI+n
 ZiKMLeAtUIiBk3UgPc9Y5bNqKWFSYuLi0pOXpVY3W7e/XxBGM/IZVaHo5NaavxGDjHMp
 i9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743239150; x=1743843950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9GtLCu3gyux9oVcvDMwLhHdah2i3b65TcWN3cFiwwk=;
 b=oDgoHOJiNoosY3dPsg0/Tc+au/BoR0AbOJKTSBa+5THluZ8cJMjd52pwefSYj9q+Jb
 3qa8Qqk0GLwfqH3rYqxepaT9f55g46h2tvT27JrE2FndZJ9TN/svzPvNwa9KsNtGumWA
 zhYuyBt/9hftJAQBMKkPlonR3dTjgLwsVt62JSCdQ9ChiRrndeBrvbsb6Ba8wV45+lk6
 Iya3WFlvQJ0lokBbb5a8qOUOjcWK33Pf5j/INsJvaZHVrS2WNeC1qUVGJagP66dDbeXJ
 PTuAO554OXtOuTXW25AG82Eila02hUJQsJxoQSjSfFOfXXcPYi5WL8THDN6M64qMmh/b
 1kMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVREKRIWBTajg2kWK7S93omIRHRcYHuYwWlAu7f4ItpeuKht423F8yzFHT0UHTWpH8p0JbaGjE=@lists.denx.de
X-Gm-Message-State: AOJu0YwBPlOasuC/+V9EIq0h7NXROkyfYZz9nWq8K3cihMEtEfGkXStY
 pvQyxZ2xJ729kwcFCNscp3hi0FAT8Is8GyGgj3YcRIWQ3hjEyakPmJNczZCsuv90KbU4dCRXcc+
 evGG6W7r/0AdoBcUk4ncDthmpmcvzKGDUWwzuiw==
X-Gm-Gg: ASbGncuP8vm6AU+J+bC2+ZZUi6mCjwwOysWRLsTLLAIiIPH4CEtoIc5ovKiKCKCWzkD
 HEaca32HiIkhWs5itl6dI9Zh91Sa9+NGQ4DTDtgfbzjJSpwa0ComAXFe42Gdo3VE4qqMQlqlKbO
 CDlJoV7L/XEiY7gWd2iI57xF6bIBnixXVx3cfo
X-Google-Smtp-Source: AGHT+IHaWBs7FkRRJNP1+nPos8IY5efB14N3pdEqC2tQGrSYLXCswgEYpA5muddktZyz5kHqSLKQAr66CkxqBk5SSQI=
X-Received: by 2002:a05:6902:2808:b0:e64:60d:e3cc with SMTP id
 3f1490d57ef6-e6b838d4d60mr2529580276.7.1743239150356; Sat, 29 Mar 2025
 02:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
 <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
 <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
 <CAFLszThhK4-+Qh_eQLD0fuJZVodBkwit4rw5mOcGU58m6=5knw@mail.gmail.com>
 <CAC_iWj+2EsRUBT5ThAR7+wwxVkFSzrApCNDbTEEHQ-W658LwCw@mail.gmail.com>
 <20250328160419.GX93000@bill-the-cat>
 <87wmc95b68.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87wmc95b68.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 29 Mar 2025 11:05:14 +0200
X-Gm-Features: AQ5f1JrEJj2iC3Z6CIi7-Ll16Bfz38_3VNV2UJZa6sWDYGlFg_wXcp8jvlzDRIc
Message-ID: <CAC_iWjLNiNiJL49MbcGZJED=1GK_euoUox0T+dEn5fF8PcrvKQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Tom Rini <trini@konsulko.com>, sjg@chromium.org, xypron.glpk@gmx.de, 
 e@freeshell.de, rayagonda.kokatanur@broadcom.com, andy.tang@nxp.com, 
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, 
 wasim.khan@nxp.com, udit.agarwal@nxp.com, meenakshi.aggarwal@nxp.com, 
 patrick.delaunay@foss.st.com, patrice.chotard@foss.st.com, 
 Manish.Tomar@nxp.com, matt@traverse.com.au, caleb.connolly@linaro.org, 
 tien.fong.chee@altera.com, michal.simek@amd.com, sumit.garg@kernel.org, 
 patrick.rudolph@9elements.com, alif.zakuan.yuslaimi@intel.com, 
 Oliver.Gaskell@analog.com, duje.mihanovic@skole.hr, robert.marko@sartura.hr, 
 lukas.funke@weidmueller.com, peng.fan@nxp.com, jj251510319013@gmail.com, 
 adrianox@gmail.com, sughosh.ganu@linaro.org, vincent.stehle@arm.com, 
 raymond.mao@linaro.org, maks.mishinfz@gmail.com, semen.protsenko@linaro.org, 
 u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 30 Mar 2025 14:28:18 +0200
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

Thanks all this is helpful

On Fri, 28 Mar 2025 at 19:15, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Date: Fri, 28 Mar 2025 10:04:19 -0600
> > From: Tom Rini <trini@konsulko.com>
> >
> > On Fri, Mar 28, 2025 at 02:26:39PM +0200, Ilias Apalodimas wrote:
> > > On Fri, 28 Mar 2025 at 13:34, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 27 Mar 2025 at 15:19, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon
> > > > >
> > > > > On Thu, 27 Mar 2025 at 15:33, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 17.03.25 14:38, Ilias Apalodimas wrote:
> > > > > > > >
> > > > > > > > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> > > > > > > >
> > > > > > > > > The EFI subsystem defines its own bounce buffer for devices that
> > > > > > > > > can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
> > > > > > > > > which can be reused instead of defining another symbol.
> > > > > > > > > The only limitation for EFI is that we don't know how big the file a user
> > > > > > > > > chooses to transfer is and as a result we can't depend on allocating the
> > > > > > > > > memory from the malloc area, which can prove too small.
> > > > > > > > >
> > > > > > > > > So allocate an EFI buffer of the correct size and pass it to the DM,
> > > > > > > > > which already supports bounce buffering via bounce_buffer_start_extalign()
> > > > > > > >
> > > > > > > > Looking at
> > > > > > > >
> > > > > > > >      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> > > > > > > >
> > > > > > > > in drivers/block/blk-uclass.c the bounce buffer has to be explicitly
> > > > > > > > enabled by the device driver. Only the scsi drivers sets bb = true.
> > > > > > > >
> > > > > > > > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag
> > > > > > > > to blk_desc")
> > > > > > > >
> > > > > > > > Which device-drivers of the boards mentioned below do actually need
> > > > > > > > bounce buffering?
> > > > > > >
> > > > > > > Unfortunately, I don't have any of the hardware to test and I havent
> > > > > > > worked with that platform much.
> > > > > > > That 'bb' variable and the fact that EFI needs bigger allocations is
> > > > > > > why I ended up allocationg properly aligned memory from the EFI
> > > > > > > subsystem. But as Mark pointed out, the cache flush is a no go for
> > > > > > > now, so I'll drop this and see if I find time to rework the bounce
> > > > > > > buffer logic overall
> > > > > >
> > > > > > There was quite a bit of discussion about all this in the context of
> > > > > > my attempt to just add a message to warn the user[1]
> > > > > >
> > > > > > We might consider adding an event to reserve memory before relocation,
> > > > > > along with a way to discover (in board_r) where the memory was
> > > > > > allocated. That would make the solution more generic.
> > > > >
> > > > > I am not sure what you are trying to solve here. The EFI bounce buffer
> > > > > after the LMB patches can't overwrite memory, nor can it be
> > > > > overwritten.
> > > >
> > > > I am thinking of we can create a single implementation of the
> > > > bouncebuf logic which also works for EFI.
> > > >
> > > > I think the two sane things to do are:
> > > > - restrict U-Boot to using memory below 4GB for platforms which have
> > > > the DMA limitation
> > >
> > > You don't need that. The bounce buf code has a callback you can use to
> > > define the limitations
> > >
> > > > - create (in board_f) a special region below 4GB for use with the
> > > > bouncebuf logic
> > >
> > > The only problem with EFI is that you don't know how much memory it
> > > needs and we can't use the existing memalign calls. So if we replace
> > > that memalign in the bounce buffer code, with an lmb reservation we
> > > have everything we need.
> >
> > It's not even an EFI problem is it?
>
> Fundamentall, yes, this isn't an EFI problem.

+1 it's not. As Heinrich explained EFI just makes it a lot easier to trigger

>
> > You could hit the same problem reading a file from a filesystem
> > outside of EFI too.
>
> Yes, but we tend to choose the addresses in the env variables that are
> used in the more traditional boot methods to prevent this.
>
> > These specific SoCs just aren't heavily exercised is one of the
> > challenges I think and so it's possible that we have a few things to
> > yet improve in the bounce buffer code (which was added for other
> > SoCs and done as generic enough starting point for others).
>
> The existing bounce buffer code was written to solve a completely
> different problem.  But it could indeed be generalized to solve this
> problem as well.  That requires somebody willing to work on a larger
> set of actual hardware that includes SoC with cache-coherency
> challanges (which is what the current bounce buffer implementation is
> there for) and SoCs with DMA addressing challenges.

So, I think if we
- Use LMB instead of memalign for the buffer allocation
- Add an explicit flag on the API to cache flush or not. We could add
this to the existing DM code
- Revisit the 'bb' variable usage and set it correctly on
drivers/platforms that need the bounce buffer

We should be covered, no?

Thanks
/Ilias

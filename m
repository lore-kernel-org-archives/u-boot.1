Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4078C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 15:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2676A8743A;
	Mon, 23 Oct 2023 17:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="lfnWZN+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D3D87926; Mon, 23 Oct 2023 17:31:23 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A83878FC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 2fa56c10-71b9-11ee-abd3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 2fa56c10-71b9-11ee-abd3-005056999439;
 Mon, 23 Oct 2023 17:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=PgCC63xHv6XL1fAkpEJ7jn4I039/Wu2IuV3gDDkBWHs=;
 b=lfnWZN+RPC0XxCWRWDpImSb4gCsgKMZ2U3ENZGwcjPvulP7WaBTvJLyaOJFyYquoPKItMOVZXcYVg
 PvUf2cgekxraukSQIKJ2tb1WgTdSxXEP20538iiDaT1TXA1simynyYvqauULowI87tx+7SC6N5V9yO
 xW2N7TNJAGOkvyZKegBl+QMoT4DnqLIAHNUWdMrK8lOAC6NnCYotX31UWV9nuDITooJn9KnjszJ/Eo
 qqN47PQO0bKqSFJjjE0eOdkmql4hzBftAm8FkvtuzV7nRrJUBdDIJDG79LDJKG7VpOQEUdcMzOIMLq
 wpNxZqbH4l/BsjQ3tPtTt4zOIXVUbxw==
X-KPN-MID: 33|DCtANFCQ4LFATbzWuKwC1ybde8QxdTNCUe2f4vNwAwlML3TUAaPq0/l37VXrhZ8
 y0AS98EGI6nxlcWPImufKhZgJuy7o9ikO4Eom09gymEs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gj1VdpPK9Kuv7oNYjMxIaqZAMlMt8T2kDzHk9G8IwKTDvM6rDJsCCjUAjHZ6Y25
 W0Glojy60HzZ/zFYvIacl4Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 36cb2815-71b9-11ee-ad2d-005056998788;
 Mon, 23 Oct 2023 17:31:20 +0200 (CEST)
Date: Mon, 23 Oct 2023 17:31:19 +0200
Message-Id: <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org
In-Reply-To: <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 (message from Simon Glass on Mon, 23 Oct 2023 00:04:14 -0700)
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Mon, 23 Oct 2023 00:04:14 -0700
> 
> Hi Caleb,
> 
> On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On 21/10/2023 01:45, Simon Glass wrote:
> > > U-Boot typically sets up its malloc() pool near the top of memory. On
> > > ARM64 systems this can result in an SMBIOS table above 4GB which is
> > > not supported by SMBIOSv2.
> > >
> > > Work around this problem by providing a new option to choose an address
> > > just below 4GB, if needed.
> > I may well be missing something here, but I don't quite understand the
> > justification behind the original patch [1] which caused this regression.
> >
> > I'm currently preparing support for a few different Qualcomm boards
> > which have different memory layouts, so far it's been possible to avoid
> > having any fixed addresses, so the same u-boot image can be used on all
> > of them (with just a different DTB).
> 
> What sort of memory layout do you have? I could enhance the patch to
> find the top of a memory bank below 4GB, perhaps? E.g. see the
> 'bdinfo' command.
> 
> >
> > As I mentioned before, efi_allocate_pages() seems to work fine from
> > install_smbios_table(), I haven't delved into the code too much but I
> > wonder if this could be an acceptable solution?
> 
> Unfortunately that function is EFI-specific. The function can only be
> called once EFI is inited. We only want to do that if booting with
> EFI.
> 
> The tables are written at the start of U-Boot, partly because that is
> how it is done on x86 and partly so the 'acpi' command actually works.
> 
> The EFI code ended up writing a separate set of tables, which is of
> course not correct.
> 
> I did look at creating an API in U-Boot to alloc memory below 4GB but
> then decided that for just this one use case it might not be worth it.
> 
> >
> > Barring that, could we use an environment variable to pass this address
> > in? Although I think that might not be a very desirable solution.
> >
> > I appreciate you taking the time to prepare this patch and CC me. If
> > nobody else objects to this patch then I'd prefer to avoid blocking it.
> > In either case, I'd greatly appreciate any input on the above
> > suggestions so that I can implement a solution for my boards.
> 
> I would like it to be automatic. I assumed on ARM64 that there is
> memory available at 3.99GB if U-Boot has relocated to above 4GB, but
> as above I could make this more clever.

There is absolutely no guarantee that arm64 machines have memory below
4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opteron
A1100 SoC and all the recent Apple SoCs.

Cheers,

Mark

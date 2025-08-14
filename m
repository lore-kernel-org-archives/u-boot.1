Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33267CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 12:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A818391B;
	Thu, 14 Aug 2025 14:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="G8BU5m04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65E68391C; Thu, 14 Aug 2025 14:52:42 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4244838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 9101a422-790d-11f0-9775-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 9101a422-790d-11f0-9775-005056999439;
 Thu, 14 Aug 2025 14:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=uvXo9wFTQhGqwKrzbzdetK4q3ssrsaUwHPnPEAjvNto=;
 b=G8BU5m04mEdQaGQ5PlbNAto5V6ZERrRWt440POhU2CP5Bv2cc4oQGiOKi7gZHjmnXwgS+faUfp2p3
 MG+F3hLGUoSdWGPm6wkHDxsHy04i3WEofllC/lGQxztPdfaKuegwEPFADExJ5Fc918jJSy5sI7S8bO
 UVcBWS5Cz5ea+mXOLy48qFbCmkbKN3dBKZe18r28DlUyaBArIZL/doPGT/EyUmODezz/E70akogGhP
 OIyIkw0n4q5V3aFUHFSjnmEMgJwjPZI54R8TOjtY+P/R95yoW6QIh6BbZuV+ydlTBApSzrnMpdhTSc
 VFuxLnl7XsXMuQbycbfWH0i/VgD682A==
X-KPN-MID: 33|471lG7L76iXOZ0aXVbpIF8ABNigQDqGT9yW4HIBx6nel8hrxHtCLlX4g6iwfmiP
 ZLId+dW0KWyWRRzIRkScGfM4QlHgAJmSuseBvbAbMt7M=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ECSIu/BoXcfV8KmzlNWY3dqJYz4rjq4uXrcFg5h9BFowDLDY9E5do8UZhH4nQRf
 tdSoIHWupZIGGOr9uNMZziw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 8f3f04ec-790d-11f0-8897-00505699d6e5;
 Thu, 14 Aug 2025 14:52:39 +0200 (CEST)
Date: Thu, 14 Aug 2025 14:52:39 +0200
Message-Id: <87h5yakqug.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Fabio Estevam <festevam@gmail.com>
Cc: jan.kiszka@siemens.com, trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
 (message from Fabio Estevam on Thu, 14 Aug 2025 09:22:57 -0300)
Subject: Re: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
References: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
 <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
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

> From: Fabio Estevam <festevam@gmail.com>
> Date: Thu, 14 Aug 2025 09:22:57 -0300
> 
> On Thu, Aug 14, 2025 at 6:11 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > Hi all,
> >
> > I'm currently playing with eMMC emulation for qemu-system-aarch64 -M
> > virt and will likely propose upstream to allow user-instantiate emmc
> > devices (-> -device sdhci-pci -device emmc).
> >
> > To make U-Boot recognize such a setup, I currently need this:
> >
> > diff --git a/include/configs/qemu-arm.h b/include/configs/qemu-arm.h
> > index e296f398798..4e22aa36fa6 100644
> > --- a/include/configs/qemu-arm.h
> > +++ b/include/configs/qemu-arm.h
> > @@ -11,4 +11,6 @@
> >
> >  /* For timer, QEMU emulates an ARMv7/ARMv8 architected timer */
> >
> > +#define CONFIG_SYS_EARLY_PCI_INIT      1
> > +
> >  #endif /* __CONFIG_H */
> >
> > Is this the right way to achieve? Then a patch for U-Boot would follow
> > as well.
> 
> CONFIG_SYS_EARLY_PCI_INIT is not defined anywhere as a Kconfig symbol.
> 
> I'm wondering if we should change it like this instead:

Not without removing the 2nd pci_init_r() that is conditionalized on
!CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT).

That would require some thorough testing though; I certainly wouldn't
be sure calling pci_init_r() is safe at that point on the boards I
maintain.

> diff --git a/common/board_r.c b/common/board_r.c
> index 143d51d06330..3da749b05fcc 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -685,7 +685,7 @@ static void initcall_run_r(void)
>         INITCALL(post_output_backlog);
>  #endif
>         WATCHDOG_RESET();
> -#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
> +#if CONFIG_IS_ENABLED(PCI_INIT_R)
>         /*
>          * Do early PCI configuration _before_ the flash gets initialised,
>          * because PCU resources are crucial for flash access on some boards.
> 

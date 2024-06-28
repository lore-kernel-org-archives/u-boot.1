Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2334CC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 05:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2490D880F8;
	Fri, 28 Jun 2024 07:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bh44rpHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6D388229; Fri, 28 Jun 2024 07:53:52 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D111287FB5
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 07:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fab50496f0so1304995ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719554028; x=1720158828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L8OhW8WWwrKFGqKnDPuRof/I5IHbUr+oNEmEzUwC31U=;
 b=bh44rpHy6uARBUeuoEaIMyFua8LTkr1tRqmaupvg6aRNrJcpNsJp3IsJGRVF/pGbSQ
 UGM9UYLFLmZ/erf6HgEwyRKrinB3ZXuGg30luPZR8ZNCybUO6TY3H+Y5k6Bvq9PjqZtg
 /vV5OWBzzG9S9PJ45zzkWGWCOMUtEM/WuvG1tBxGpQyKGfd2cvwSnZSx7yfy0PJb1fVx
 QPIaqSq6mIc3S3LEeKhHoA89dv79bdNdlMOzgFyODRrgSvU1R/LitmJ+KNBSeRJlOjkw
 tJY0cRVbGj8aycLmO786P1MUKssUG59jC/3dyqNJitoY5hOxqiBfM4v08A+5psQj62UK
 N5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719554028; x=1720158828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L8OhW8WWwrKFGqKnDPuRof/I5IHbUr+oNEmEzUwC31U=;
 b=w+/n+EzU4MBI6j7cOJykOxCfyYu0hzIB53WJcXVG/AFZlKbhAU7sKiQXtYI4NTfIr8
 LCPyF3Rk5WXPE/AptM7QkNs6gfK+w94OjXPriE5WYNVODO6VSTg015njbm7X9Nvbfi+H
 rtVE9C3CvH4X/n0Kh/N4oxAA7l5nzzE0oFg/9OCACk/qPxJxp5/GA1lrbwWbxrp4EbFR
 M7XFwe7Io5/6e5sDVTH7t8qRC334l4zA4HrurdsmHJujbaoo4R2js/LfrcNEVtq+mbk+
 HkLfeTwqwBUNBaRvMsi2BxtuaUDZ8a02VitfdLCadv4AileHTppBJw8fMZzuXjDijOeu
 Ltaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbm12RBcOsiSju9RJxui6NPm8kGyIQNHIuOeiy0Ej7STw449cbjkfYZtwbRnxW25lTa4homM/N6JccQTBzpj12VyxVkA==
X-Gm-Message-State: AOJu0Yxu5cosamBWnUd3f2exkE0GfwKjvATLr+Uu5b8JFZNIe655gpLF
 t+kjx27Y40FCW/quAnOrp6f8ThxWcKnNs9g7WofNX0qQ/Y2clmrgyOu3Odn59f1eN7mLjet5m3p
 JisEmUVxOXoUQffP4x704AEl+tZSgAaFtjejrQA==
X-Google-Smtp-Source: AGHT+IHwSwAKPEitFO5iGIDj214vzwrsexCK9U8YaIdFLER1zSkr4+QjaE1xI+G+wCXD2qjM+Y6vxRFpSuuF3XoXUeE=
X-Received: by 2002:a17:902:e9cd:b0:1fa:bcb:3db9 with SMTP id
 d9443c01a7336-1fa23f60fdfmr111544625ad.31.1719554028070; Thu, 27 Jun 2024
 22:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
 <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
 <20240627-endnote-cacti-5c8ae6251234@wendy>
 <CAFLszTj3uSd8UOvmg5M2x1EOnidocRYxiBg0SeG8-eCfm1huRQ@mail.gmail.com>
 <20240627-prowess-train-e37fe71c1310@spud>
In-Reply-To: <20240627-prowess-train-e37fe71c1310@spud>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Jun 2024 08:53:11 +0300
Message-ID: <CAC_iWjKz18jONK-vVw1BR7xwJDqqD_rAF55yqdyfwN-gRqwMTg@mail.gmail.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
To: Conor Dooley <conor@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Conor Dooley <conor.dooley@microchip.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ivan Griffin <ivan.griffin@microchip.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>
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

Hi Conor,


On Thu, 27 Jun 2024 at 23:27, Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Jun 27, 2024 at 11:50:33AM +0100, Simon Glass wrote:
> > On Thu, 27 Jun 2024 at 10:38, Conor Dooley <conor.dooley@microchip.com> wrote:
> > > On Thu, Jun 27, 2024 at 09:36:49AM +0100, Simon Glass wrote:
> > > > On Tue, 25 Jun 2024 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:
> > > > > > The firmware on the Icicle is capable of providing a devicetree in a1 to
> > > > > > U-Boot, but until now the devicetree has been packaged in a "payload" [1]
> > > > > > alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
> > > > > > The address of this appended devicetree is placed in a1 by the firmware.
> > > > > > This meant that the mechanism used by OF_SEPARATE to locate the
> > > > > > devicetree at the end of the image would pick up the one provided by the
> > > > > > firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
> > > > > > when u-boot.bin was.
> > > > > >
> > > > > > The firmware is now going to be capable of providing a minimal devicetree
> > > > > > (quite cut down due to severe space constraints), but this devicetree is
> > > > > > linked into the firmware that runs out of the L2 rather than at the end
> > > > > > of the U-Boot image. Implement board_fdt_blob_setup() so that this
> > > > > > devicetree can be optionally used, and the devicetree provided in the
> > > > > > "payload" can be used without relying on "happening" to implement the
> > > > > > same strategy as OF_SEPARATE expects in combination with
> > > > > > u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
> > > > > > devicetree is only used when OF_BOARD is set, so that the almost
> > > > > > certainly more complete devicetree in U-Boot will be used unless
> > > > > > explicitly requested otherwise.
> > > > > >
> > > > > > Link: https://github.com/polarfire-soc/hart-software-services/blob/master/tools/hss-payload-generator/README.md [1]
> > > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > ---
> > > > > > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > > > > > CC: Padmarao Begari <padmarao.begari@microchip.com>
> > > > > > CC: Cyril Jean <cyril.jean@microchip.com>
> > > > > > CC: Tom Rini <trini@konsulko.com>
> > > > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > > > CC: u-boot@lists.denx.de
> > > > > > ---
> > > > > >  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
> > > > > >  1 file changed, 19 insertions(+)
> > > > > >
> > > > > > diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > > > index 4d7d843dfa3..2c1f7175f0e 100644
> > > > > > --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > > > +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >  #include <init.h>
> > > > > >  #include <asm/global_data.h>
> > > > > >  #include <asm/io.h>
> > > > > > +#include <asm/sections.h>
> > > > > >
> > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > >
> > > > > > @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response, u8 response_size)
> > > > > >               response_buf[idx] = readb(MPFS_SYS_SERVICE_MAILBOX + idx);
> > > > > >  }
> > > > > >
> > > > > > +void *board_fdt_blob_setup(int *err)
> > > > > > +{
> > > > > > +     *err = 0;
> > > > > > +     /*
> > > > > > +      * The devicetree provided by the previous stage is very minimal due to
> > > > > > +      * severe space constraints. The firmware performs no fixups etc.
> > > > > > +      * U-Boot, if providing a devicetree, almost certainly has a better
> > > > > > +      * more complete one than the firmware so that provided by the firmware
> > > > > > +      * is ignored for OF_SEPARATE.
> > > > > > +      */
> > > > > > +     if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > > > > +             if (gd->arch.firmware_fdt_addr)
> > > > > > +                     return (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
> > > > > > +     }
> > > > > > +
> > > > > > +     return (ulong *)_end;
> > > > > > +}
> > > > > > +
> > > > > >  int board_init(void)
> > > > > >  {
> > > > > >       /* For now nothing to do here. */
> > > > >
> > > > > I'm adding in Simon and Ilias as this touches on one of those frequent
> > > > > topics about how device trees can/should be passed along to us.
> > > >
> > > > The only thing I can think of is implementing bloblist in  the a1 (?)
> > > > firmware, then passing the DT in that.
> > >
> > > a1 is the register that is used on riscv to pass the dtb, I think the
> > > corresponding thing on arm64 is x0.
> > >
> > > Re-reading the firware handoff spec, it's difficult to see what benefits
> > > it actually provides us when we only ever have a single dtb which the
> > > firmware does not interact with/use.
> > > We are super space constrained in the firmware even carving out 4.5 KiB
> > > for a devicetree blob is a stretch and requires disabling other features
> > > and ripping out anything in the DT not required for U-Boot to load the OS.
> > > Even the ~1 KiB mentioned in bloblist.h for handling a bloblist would be a
> > > challenge.
> > >
> > > I think the only way a bloblist could work is if it was created at build
> > > time and linked into the firmware, since the on-disk format seems pretty
> > > minimal. Is there tooling for generating a bloblist at build time that I
> > > could use to check whether or not a bloblist is viable?
> > > I'd also have to investigate how that would interact with OpenSBI, since
> > > it's integrated into the firmware and involved with loading U-Boot.
> >
> > There is not such a tool, but it would be easy enough to write. If you
> > think that would help, I could give it a try.
>
> I mean I could also just do it myself, I just wanted to know if it
> existed, since that'd make investigating this pretty straightforward to
> do.

Someone is already working on it.
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/29253
this will help!

>
> Either way, the firmware already is capable of doing this with a
> devicetree blob, so I figure even if we manage to get bloblist stuff
> going, there's little harm in supporting what's already there?

There isn't, but OTOH the bloblist support is already in u-boot. I
would prefer to try that out first. Up to you

Cheers
/Ilias

>
> > The confusing thing for me is that the 'firmware' is very
> > constrained...but are you saying that U-Boot is not?
>
> Correct. The firmware is in eNVM with a size limit of 128 KiB, but it
> can load U-Boot from mmc or flash etc.
>
> > Why pass U-Boot the DT?
>
> Primarily to allow using a generic image to be used across multiple
> boards, using the compatible in the devicetree to determine what the
> boot the OS with. Another idea that was floated was using vendor SBI
> extension to request the information - but I felt that using DT was
> better than conjuring up something specific to us.
>
> > Perhaps you could explain the boot sequence so I can
> > understand it better?
>
> Ivan, correct me if I go off the rails here please... The firmware is
> stored in eNVM on the FPGA, the FPGA's "system controller" sets the
> reset vector for the CPUs to the location of the firmware. (There are
> some other boot modes, but they all work similarly). The firmware
> then decompresses itself into the L2 and runs primarily on hart 0,
> which is a "monitor core", supporting fewer ISA extensions etc than the
> 4 cores on which user applications/OSes run on.
>
> The firmware then loads a "payload" from a storage device, that contains
> the next stage (or next stages if not running in SMP). The "payload" also
> describes the privilege levels for the next stage(s) and the locations
> in memory to load the next stage(s) to. OpenSBI is built into the firmware,
> although we can't actually fit the whole libsbi library that it provides.
> The firmware loads the next stage to whatever location has been provided
> to it in the "payload". For U-Boot, we're always running in S-Mode, so
> OpenSBI is used run the application once it has been loaded into memory
> and to provide the SBI ecall interface etc.
>
> I hope that makes some sense, it probably doesn't...
>
> There's some info on how the payloads configurations are constructed in
> the firmware repo here:
> https://github.com/polarfire-soc/hart-software-services/tree/master/tools/hss-payload-generator
>
> > > > It seems that you still need to be able to turn that on and off in
> > > > U-Boot though. So far we have not agreed the mechanism to do that, I
> > > > have the same problem, with a pending patch here[1]
> > >
> > > It seems your patch is trying to do some runtime determination of
> > > whether to examine the bloblist or not, but the ?existing? build-time
> > > check for BLOBLIST being enabled would work equally well/poorly as the
> > > OF_BOARD check the code I am adding. I'm not even really sure what runtime
> > > option could be used here here to check if the passed dtb/bloblist was to
> > > be used. U-Boot only runs here as supervisor mode U-Boot proper and always
> > > has a more complete devicetree. Whether to use the one passed to U-Boot
> > > just depends on what the person with the board wants to do - which, given
> > > this is an FPGA, could be vary significantly.
> >
> > OK...so does this platform use SPL?
>
> No :)
>
> Thanks,
> Conor.

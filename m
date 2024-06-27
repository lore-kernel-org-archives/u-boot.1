Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F2C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 10:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46721883E0;
	Thu, 27 Jun 2024 12:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lAD0a4Gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F62884A7; Thu, 27 Jun 2024 12:50:51 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6620688256
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-79d5e616e34so29200585a.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 03:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719485447; x=1720090247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s2u2QQGE8Di0KZDUemtkXeE5/9FJdnXHKVcE93fE6Fo=;
 b=lAD0a4GpoWUStMtZ+IdXwcGxE8VX4/1IWFjTQDklnytO+IxSbsfdOI5uV6cmAyik8X
 HI7nxS6cEG82ZxzxvaqFwxmBBIvdXPUHeh6Q4Je9buys/FpCiu93DSgGsRaovmVNlAWh
 Y+2gbdXV25bg3J4RC8ynR/GSrUT6NCQ1a1X3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719485447; x=1720090247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2u2QQGE8Di0KZDUemtkXeE5/9FJdnXHKVcE93fE6Fo=;
 b=stYbWK6eZOy+gMLK2K1CiYFymNKsdOFjkjWKAsw+DRa9Sf3NNKbHbyjwsrWSbr5ihy
 iSbbZ/gWU/WuxYUAXq+DdjM06JGMTkvGpFZunaumBIqrsN9bg1bV/Ook071M5LZaWFaR
 nG9wUNXdeUVXFgP73Jj22Ei74Hcl+39tPYkFJT6OHDdg++Zox1LuDsbtikQbjM1iL7BG
 11Pjws1vc2CDZ8pJ7+aszHqWk8DTOMPN7ubUzwX8cJYGJLl0p/BK9ebCWhTxQm++kMN0
 FO4AYn2ILI2aNBhqqqUoHrq5KfkNuubIsNL0RV9mp5GbM9+OCZjTzXtSufsJjTII4nxd
 PWxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvwZ/wOSRFfulo12y6zosEu0nK7gIsVLfq8i0eskKEmdVQolyZtLgadb7GEfawMsNu9E6zcM3f0pQ0jeI7GF1IGJ2JfA==
X-Gm-Message-State: AOJu0YyHlgRoqcfFztcvjlH4XrobY8ORad5qaQ+d5HJc8IrsWDz7uXSK
 MvYjIKXOA2odec+pa7jTW6ySbYPLdiGkQoHWKW8X3t4ohnwhYbjyq62O2QjkQa7ySq70NergqOz
 XfE0v3Cf5hmX7c+grX5zsdNgaUX1/AIB7rnQ8
X-Google-Smtp-Source: AGHT+IFWHPaV/n+xcODDJlypsr0/r3ZhGqf3+egFqxhIPSDTRZnCqVnZ+9PlMpxsjfisfgEPNus4kOdaMAo+3Z9SLoc=
X-Received: by 2002:a05:620a:3187:b0:79c:1178:dcad with SMTP id
 af79cd13be357-79c1178dfd2mr687941785a.26.1719485447308; Thu, 27 Jun 2024
 03:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
 <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
 <20240627-endnote-cacti-5c8ae6251234@wendy>
In-Reply-To: <20240627-endnote-cacti-5c8ae6251234@wendy>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 11:50:33 +0100
Message-ID: <CAFLszTj3uSd8UOvmg5M2x1EOnidocRYxiBg0SeG8-eCfm1huRQ@mail.gmail.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, conor@kernel.org, 
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

Hi Connor,

On Thu, 27 Jun 2024 at 10:38, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Thu, Jun 27, 2024 at 09:36:49AM +0100, Simon Glass wrote:
> >
> > On Tue, 25 Jun 2024 at 15:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:
> > >
> > > > The firmware on the Icicle is capable of providing a devicetree in a1 to
> > > > U-Boot, but until now the devicetree has been packaged in a "payload" [1]
> > > > alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
> > > > The address of this appended devicetree is placed in a1 by the firmware.
> > > > This meant that the mechanism used by OF_SEPARATE to locate the
> > > > devicetree at the end of the image would pick up the one provided by the
> > > > firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
> > > > when u-boot.bin was.
> > > >
> > > > The firmware is now going to be capable of providing a minimal devicetree
> > > > (quite cut down due to severe space constraints), but this devicetree is
> > > > linked into the firmware that runs out of the L2 rather than at the end
> > > > of the U-Boot image. Implement board_fdt_blob_setup() so that this
> > > > devicetree can be optionally used, and the devicetree provided in the
> > > > "payload" can be used without relying on "happening" to implement the
> > > > same strategy as OF_SEPARATE expects in combination with
> > > > u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
> > > > devicetree is only used when OF_BOARD is set, so that the almost
> > > > certainly more complete devicetree in U-Boot will be used unless
> > > > explicitly requested otherwise.
> > > >
> > > > Link: https://github.com/polarfire-soc/hart-software-services/blob/master/tools/hss-payload-generator/README.md [1]
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > > > CC: Padmarao Begari <padmarao.begari@microchip.com>
> > > > CC: Cyril Jean <cyril.jean@microchip.com>
> > > > CC: Tom Rini <trini@konsulko.com>
> > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > CC: u-boot@lists.denx.de
> > > > ---
> > > >  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
> > > >  1 file changed, 19 insertions(+)
> > > >
> > > > diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > index 4d7d843dfa3..2c1f7175f0e 100644
> > > > --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > > > @@ -9,6 +9,7 @@
> > > >  #include <init.h>
> > > >  #include <asm/global_data.h>
> > > >  #include <asm/io.h>
> > > > +#include <asm/sections.h>
> > > >
> > > >  DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > > @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response, u8 response_size)
> > > >               response_buf[idx] = readb(MPFS_SYS_SERVICE_MAILBOX + idx);
> > > >  }
> > > >
> > > > +void *board_fdt_blob_setup(int *err)
> > > > +{
> > > > +     *err = 0;
> > > > +     /*
> > > > +      * The devicetree provided by the previous stage is very minimal due to
> > > > +      * severe space constraints. The firmware performs no fixups etc.
> > > > +      * U-Boot, if providing a devicetree, almost certainly has a better
> > > > +      * more complete one than the firmware so that provided by the firmware
> > > > +      * is ignored for OF_SEPARATE.
> > > > +      */
> > > > +     if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > > +             if (gd->arch.firmware_fdt_addr)
> > > > +                     return (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
> > > > +     }
> > > > +
> > > > +     return (ulong *)_end;
> > > > +}
> > > > +
> > > >  int board_init(void)
> > > >  {
> > > >       /* For now nothing to do here. */
> > >
> > > I'm adding in Simon and Ilias as this touches on one of those frequent
> > > topics about how device trees can/should be passed along to us.
> >
> > The only thing I can think of is implementing bloblist in  the a1 (?)
> > firmware, then passing the DT in that.
>
> a1 is the register that is used on riscv to pass the dtb, I think the
> corresponding thing on arm64 is x0.
>
> Re-reading the firware handoff spec, it's difficult to see what benefits
> it actually provides us when we only ever have a single dtb which the
> firmware does not interact with/use.
> We are super space constrained in the firmware even carving out 4.5 KiB
> for a devicetree blob is a stretch and requires disabling other features
> and ripping out anything in the DT not required for U-Boot to load the OS.
> Even the ~1 KiB mentioned in bloblist.h for handling a bloblist would be a
> challenge.
>
> I think the only way a bloblist could work is if it was created at build
> time and linked into the firmware, since the on-disk format seems pretty
> minimal. Is there tooling for generating a bloblist at build time that I
> could use to check whether or not a bloblist is viable?
> I'd also have to investigate how that would interact with OpenSBI, since
> it's integrated into the firmware and involved with loading U-Boot.

There is not such a tool, but it would be easy enough to write. If you
think that would help, I could give it a try.

The confusing thing for me is that the 'firmware' is very
constrained...but are you saying that U-Boot is not? Why pass U-Boot
the DT? Perhaps you could explain the boot sequence so I can
understand it better?

>
> > It seems that you still need to be able to turn that on and off in
> > U-Boot though. So far we have not agreed the mechanism to do that, I
> > have the same problem, with a pending patch here[1]
>
> It seems your patch is trying to do some runtime determination of
> whether to examine the bloblist or not, but the ?existing? build-time
> check for BLOBLIST being enabled would work equally well/poorly as the
> OF_BOARD check the code I am adding. I'm not even really sure what runtime
> option could be used here here to check if the passed dtb/bloblist was to
> be used. U-Boot only runs here as supervisor mode U-Boot proper and always
> has a more complete devicetree. Whether to use the one passed to U-Boot
> just depends on what the person with the board wants to do - which, given
> this is an FPGA, could be vary significantly.

OK...so does this platform use SPL?

Regards,
Simon

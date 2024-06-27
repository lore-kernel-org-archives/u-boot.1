Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABA8C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD407880A5;
	Thu, 27 Jun 2024 10:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kEYER4jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063AE87FA7; Thu, 27 Jun 2024 10:37:04 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729E0880A5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-80fc528a4ccso440719241.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477420; x=1720082220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e6T1+X0AkW3kts/LhjgGUII1k9o45OeeFs4Ey0887X4=;
 b=kEYER4jgR/lLnGfJvli8IJe/EyAlAf2uA6toByj5Cg43ncMyxRMDB/c18rVykH0dox
 OosSfYlStAnwQhXo38H5p0w9cAwqhKVmqRZRRPyjxZaiL9EZzwsJhCTlGaJVSXKvVTHV
 VB3ryDzppcsalDO/Z8sO8NfZMB6NcLp+qF4Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477420; x=1720082220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6T1+X0AkW3kts/LhjgGUII1k9o45OeeFs4Ey0887X4=;
 b=lbvlAQh4w+Liz4T/3kUYWfXeiCWOhz411DjqntbTjOvRIHk2NOR48kkzbAPI1zo9Pu
 5Kydxcio+wMFQZ5CtWAvdU+VtanXhQ4hJqlwNwXUHkpHxrvDv/5jBBgjEQYv1Bye63hB
 l0yWp88+5SVTX9KihCWxMWHinPatXoVAceShdjvPV1YFDJPmB9jIGsYoYx3krUKvXS5P
 D5NJOdknZ7MjBSBvhlBb+TuPsO6sKn72jHccLMJp0kltIi+OG5uhTCgoFLN/5HUB3dlb
 slKiqqpoxj2DbzLlhNdoOTGrbypMzzLVohsYb3gjglQrT1K8hG7SquydTg/jg7P14xUt
 mFMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtQyZRICKcDqwKg/cJTDGGaHcWqFHa1SfIvMN7b1LfkvppJ86qN3vDa4jzDUEWbAvqLGY73f/jIp+IKq3jHFBkdZIpfw==
X-Gm-Message-State: AOJu0YydjzJtS68A8Z5LrXrhWkJsed2sPdAr10J4h2mkT6j4rwOCk+fE
 gy3IR/He7JkLzjV3fr2Mu+GgDjYGTEcM3plJQEv+o0PH1zKKf8qU8Zu5mmv9GTXu/1XGVl5AlQ5
 kAAf/W2QSdkhc8A3MhJVqnlvAZ489dYO5RGWb
X-Google-Smtp-Source: AGHT+IEtIvQESfnF9r7bCe7+NiWqBkx2HFX6u3fD3aMNjd7XPJohhjjaKtkjp7Vg9VA98WeznjqhEPU0MXL6Ct22URM=
X-Received: by 2002:a05:6102:21c6:b0:48f:21b1:b3ef with SMTP id
 ada2fe7eead31-48f4f1700c5mr12876487137.22.1719477420298; Thu, 27 Jun 2024
 01:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
In-Reply-To: <20240625143421.GR38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:36:49 +0100
Message-ID: <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 conor@kernel.org, Ivan Griffin <ivan.griffin@microchip.com>, 
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

Hi,

On Tue, 25 Jun 2024 at 15:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:
>
> > The firmware on the Icicle is capable of providing a devicetree in a1 to
> > U-Boot, but until now the devicetree has been packaged in a "payload" [1]
> > alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
> > The address of this appended devicetree is placed in a1 by the firmware.
> > This meant that the mechanism used by OF_SEPARATE to locate the
> > devicetree at the end of the image would pick up the one provided by the
> > firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
> > when u-boot.bin was.
> >
> > The firmware is now going to be capable of providing a minimal devicetree
> > (quite cut down due to severe space constraints), but this devicetree is
> > linked into the firmware that runs out of the L2 rather than at the end
> > of the U-Boot image. Implement board_fdt_blob_setup() so that this
> > devicetree can be optionally used, and the devicetree provided in the
> > "payload" can be used without relying on "happening" to implement the
> > same strategy as OF_SEPARATE expects in combination with
> > u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
> > devicetree is only used when OF_BOARD is set, so that the almost
> > certainly more complete devicetree in U-Boot will be used unless
> > explicitly requested otherwise.
> >
> > Link: https://github.com/polarfire-soc/hart-software-services/blob/master/tools/hss-payload-generator/README.md [1]
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > CC: Padmarao Begari <padmarao.begari@microchip.com>
> > CC: Cyril Jean <cyril.jean@microchip.com>
> > CC: Tom Rini <trini@konsulko.com>
> > CC: Conor Dooley <conor.dooley@microchip.com>
> > CC: u-boot@lists.denx.de
> > ---
> >  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > index 4d7d843dfa3..2c1f7175f0e 100644
> > --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> > +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> > @@ -9,6 +9,7 @@
> >  #include <init.h>
> >  #include <asm/global_data.h>
> >  #include <asm/io.h>
> > +#include <asm/sections.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response, u8 response_size)
> >               response_buf[idx] = readb(MPFS_SYS_SERVICE_MAILBOX + idx);
> >  }
> >
> > +void *board_fdt_blob_setup(int *err)
> > +{
> > +     *err = 0;
> > +     /*
> > +      * The devicetree provided by the previous stage is very minimal due to
> > +      * severe space constraints. The firmware performs no fixups etc.
> > +      * U-Boot, if providing a devicetree, almost certainly has a better
> > +      * more complete one than the firmware so that provided by the firmware
> > +      * is ignored for OF_SEPARATE.
> > +      */
> > +     if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > +             if (gd->arch.firmware_fdt_addr)
> > +                     return (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
> > +     }
> > +
> > +     return (ulong *)_end;
> > +}
> > +
> >  int board_init(void)
> >  {
> >       /* For now nothing to do here. */
>
> I'm adding in Simon and Ilias as this touches on one of those frequent
> topics about how device trees can/should be passed along to us.

The only thing I can think of is implementing bloblist in  the a1 (?)
firmware, then passing the DT in that.

It seems that you still need to be able to turn that on and off in
U-Boot though. So far we have not agreed the mechanism to do that, I
have the same problem, with a pending patch here[1]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240626155945.278640-12-sjg@chromium.org/

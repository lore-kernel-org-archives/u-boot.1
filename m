Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A7C52D71
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 18:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22F688AFF;
	Thu,  8 Aug 2024 20:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ABDwgl2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD7588B0E; Thu,  8 Aug 2024 20:44:19 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440E087B1A
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 20:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so7817216d6.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723142656; x=1723747456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FlhPSUPkUtvzX2yLpxUr8bjdc9RTAjuMHJNPw+sbyIo=;
 b=ABDwgl2SzCmMBZ3ysmPODMyDIm5Iws/Uhd9LNTPRITllEQO/5jF0wSbN3kRBPL5TD8
 u/VOlTD/qO9wh2AB5JiCH2n6iucCLKwukbzv+atrpxYrH6r3VQYUvi5pn+TyLTpBI3j5
 GXf30R1/Dy/QohsWIAYC7PlmJnC9Ic0t5bWp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723142656; x=1723747456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FlhPSUPkUtvzX2yLpxUr8bjdc9RTAjuMHJNPw+sbyIo=;
 b=m217lX4eoHWre5buJglyiZxf5b3aNRVjZHqOA99Ic1tkRqfegbFKjretiYv+UD8cLI
 y9GIo7yPDAcKnXwOwk8A6t2wQU5vCDemXCqV5sZSWo/ePULXMBVUK4ck+i0AiPmfps6c
 AnE5xG8wOH3GEmZ/OZDthk3SAy62jLqwRS0pqymSGrn3r9kgaOGDd150PBRdq9BwVH4o
 JNpxshJDnU+oxoFzCPH/NyLV3gza0p5bVOTpWSyE62jhEMIGpzJ8hR6Tex3VErxEQq0R
 PwEmaZ+nhOoZz+jS5WfRx8lk12M13wSxuGO5WI1rsA5+Hd42W5s2ZnJ7FU5Vcp2amS5d
 HHJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg//P4B3TtHpXWZGMcQoqzbh7wkriy30/Nc1wFaPUUF8hZXk0bim/imoGVbb7P9qSOqDrn0bg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzineuo4VsHPzhSpRzvjk3MZG6V4WX6UGfIV0eb6crhyioTT4Bq
 QJVTneqbjBr2sByWtWSBMWxfiVvl1QlWJmzfaT6PyAEd0cxjjFuUFY6gnIm6Ib1ZsC5lqinwVLp
 AFdEB7vRXljtdMCzHZc9NWD1h95W/PqMUA5yE
X-Google-Smtp-Source: AGHT+IESIyusrXvRp+1hJJGDiXOOPvu+FM3XqDGV5MrKfGccafzy81D9BG2ex5VCpKlNYkCboU7/ayevvoiHi/glXcM=
X-Received: by 2002:a05:6214:5d90:b0:6b5:a81b:b974 with SMTP id
 6a1803df08f44-6bd6bcae4damr29108476d6.7.1723142656046; Thu, 08 Aug 2024
 11:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
In-Reply-To: <20240807015613.GD1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Aug 2024 12:44:05 -0600
Message-ID: <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
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

Hi Heinrick, Tom,

On Tue, 6 Aug 2024 at 19:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 07, 2024 at 03:47:21AM +0200, Heinrich Schuchardt wrote:
> > On 06.08.24 14:58, Simon Glass wrote:
> > > While sandbox supports virtio it cannot support actually using the block
> > > devices to read files, since there is nothing on the other end of the
> > > 'virtqueue'.
> > >
> > > A recent change makes EFI probe all block devices, whether used or not.
> > > This is apparently required by EFI, although it violates U-Boot's
> > > lazy-init principle.
> > >
> > > We cannot just drop the virtio devices as they are used in sandbox tests.
> > >
> > > So for now just add a special case to work around this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > index 93a9a5ac025..2e1d37848fc 100644
> > > --- a/lib/efi_loader/efi_disk.c
> > > +++ b/lib/efi_loader/efi_disk.c
> > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
> > >   efi_status_t efi_disks_register(void)
> > >   {
> > >     struct udevice *dev;
> > > +   struct uclass *uc;
> > >
> > > -   uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > +   uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > +           /*
> > > +            * The virtio block-device hangs on sandbox when accessed since
> > > +            * there is nothing listening to the mailbox
> > > +            */
> > > +           if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > +                   struct blk_desc *desc = dev_get_uclass_plat(dev);
> > > +
> > > +                   if (desc->uclass_id == UCLASS_VIRTIO)
> > > +                           continue;
> >
> > We should avoid depending on the sandbox everywhere.
> >
> > Please, fix the problem in the sandbox driver.
> >
> > If you cannot fix it, run the tests involving virtio on QEMU instead of
> > the sandbox.

Which test? All of the EFI tests fail due to this problem. The test
actually has nothing to do with virtio, it is just that EFI goes and
probes every single block device, since [1].

>
> This is an area we go back-and-forth on but, yes, IMHO, if we can't
> easily provide a virtio device for sandbox, QEMU is right there and what
> this is for, so I see sandbox as more useful as build rather than
> runtime checking in this case.

The best solution would be to implement a simple emulator, like we do
in other places for sandbox. At present virtio_sandbox_notify() is
empty.

I don't mind working on that, but would like to get a temporary
solution here so this test can land.

Talking about virtio for QEMU is missing the point of this test, which
is after all a test of booting an EFI app. I do wish more people would
see the value in these unit tests. There is a talk at [2] which shows
how emulators are used in Zephyr.

Regards,
Simon

[1] d5391bf02b9 ("efi_loader: ensure all block devices are probed")
[2] https://www.youtube.com/watch?v=usXCAXR2G_c

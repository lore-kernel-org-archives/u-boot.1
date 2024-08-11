Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F1C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9239588100;
	Sun, 11 Aug 2024 16:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RgmE4m3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B1B888A7; Sun, 11 Aug 2024 16:50:35 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9687088100
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b95b710e2cso23642136d6.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387832; x=1723992632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6nNDFlTQFX0vEpPIuoMohJA6KzS6mszYHymi/M5T4Vk=;
 b=RgmE4m3ZK+16uLUB+Q+7Bok9/ryV44XqJhxoLJYu/2Uqd57YKpxtUsP6K8I5RPZ2Qv
 RHC1Ku8mnvOmd0kAQUinR6ZOIAaMcLr6s9vwOSrCGfTP03sKAfxZW7zHGTZwjxPCbVwd
 5X13lmTio+UJfMFZ6ZYhjFsgnSAm3KifJhc/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387832; x=1723992632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6nNDFlTQFX0vEpPIuoMohJA6KzS6mszYHymi/M5T4Vk=;
 b=Ka9DiNxDvJXqFRTElJS5g1ACV4K24Ww4UiVx8b0EREHe/1LNI0269yRxUnlHAPr0/0
 TT4qQ/6rixgUKkq/QfpQ3PVC1gCY2ep3tNA/hm4GfPEUtCmB/1F25TJvGhTnskOxvwn2
 JAUt04pejn8nCEb5QG6iQWQp5eW5qx0BbbkA6b0fSLaYKULxkkvNWMXbylQQUIjrhjsQ
 ta8rGg8jG6W0o4REdlt5y0xhmWiIjxJRjBm6mPa2NwLwNnJMDRaE/L72Y5UDn+9kpm2W
 bGvYb6mhLXNGv22huNcAVZMqBLVcYZ4u4y2j6pJuzmsFQA/kv4tl9RojCR46SUxPgnBl
 12Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUFJlzwyarVMXX23vGkKRQVPlqZRflnz0GFJEvX/udvdwHa6p8sS/eZS1UPfv8hKFvLX0GMBnmCWwRNc93LKn3Ye/daA==
X-Gm-Message-State: AOJu0YwzDtCcJGFaLx4zS9TSHvK/BOUHyWe2sYXVLf71LtdndrjET4uq
 nv1CraPTIXpowz5DCpLNWJFN8t0dglJxq+4YW1f0ugam8Aq4EIFy9VDoP3ZhbiHM4QsI3rTMh53
 1iwoW4xoZvurRg150vQcE6F8Y/8YiyP3bkZ2h
X-Google-Smtp-Source: AGHT+IFQ0T/C8vcqBX6TjAHzt5erKWy/FEq1/abg4uLP3TDEO/A2uZgfhn1kW0vL11/k4bExVEkwFkrNJ4ntThkQiK0=
X-Received: by 2002:a05:6214:5413:b0:6bb:bc46:fb79 with SMTP id
 6a1803df08f44-6bd78e84162mr81768446d6.47.1723387832424; Sun, 11 Aug 2024
 07:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
 <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
 <20240808200634.GR1626301@bill-the-cat>
In-Reply-To: <20240808200634.GR1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:21 -0600
Message-ID: <CAFLszThM=23AXCOfZ_uOyGGDQTRurDpAjR-t8X_NHjz4LgQ9SA@mail.gmail.com>
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

Hi Tom,

On Thu, 8 Aug 2024 at 14:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 08, 2024 at 12:44:05PM -0600, Simon Glass wrote:
> > Hi Heinrick, Tom,
> >
> > On Tue, 6 Aug 2024 at 19:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 07, 2024 at 03:47:21AM +0200, Heinrich Schuchardt wrote:
> > > > On 06.08.24 14:58, Simon Glass wrote:
> > > > > While sandbox supports virtio it cannot support actually using the block
> > > > > devices to read files, since there is nothing on the other end of the
> > > > > 'virtqueue'.
> > > > >
> > > > > A recent change makes EFI probe all block devices, whether used or not.
> > > > > This is apparently required by EFI, although it violates U-Boot's
> > > > > lazy-init principle.
> > > > >
> > > > > We cannot just drop the virtio devices as they are used in sandbox tests.
> > > > >
> > > > > So for now just add a special case to work around this.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
> > > > >   efi_status_t efi_disks_register(void)
> > > > >   {
> > > > >     struct udevice *dev;
> > > > > +   struct uclass *uc;
> > > > >
> > > > > -   uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > +   uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > +           /*
> > > > > +            * The virtio block-device hangs on sandbox when accessed since
> > > > > +            * there is nothing listening to the mailbox
> > > > > +            */
> > > > > +           if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > +                   struct blk_desc *desc = dev_get_uclass_plat(dev);
> > > > > +
> > > > > +                   if (desc->uclass_id == UCLASS_VIRTIO)
> > > > > +                           continue;
> > > >
> > > > We should avoid depending on the sandbox everywhere.
> > > >
> > > > Please, fix the problem in the sandbox driver.
> > > >
> > > > If you cannot fix it, run the tests involving virtio on QEMU instead of
> > > > the sandbox.
> >
> > Which test? All of the EFI tests fail due to this problem. The test
> > actually has nothing to do with virtio, it is just that EFI goes and
> > probes every single block device, since [1].
>
> Aren't we running "the tests" on other platforms such as QEMU today?
>
> > > This is an area we go back-and-forth on but, yes, IMHO, if we can't
> > > easily provide a virtio device for sandbox, QEMU is right there and what
> > > this is for, so I see sandbox as more useful as build rather than
> > > runtime checking in this case.
> >
> > The best solution would be to implement a simple emulator, like we do
> > in other places for sandbox. At present virtio_sandbox_notify() is
> > empty.
> >
> > I don't mind working on that, but would like to get a temporary
> > solution here so this test can land.
> >
> > Talking about virtio for QEMU is missing the point of this test, which
> > is after all a test of booting an EFI app. I do wish more people would
> > see the value in these unit tests. There is a talk at [2] which shows
> > how emulators are used in Zephyr.
>
> So that talk is interesting, yes. So, yes, implement the bus driver for
> sandbox for virtio, and until then we shouldn't have the tests running
> on sandbox? Or am I still missing something?

Sure, but perhaps there is a way to get this test landed without doing
that work right away?

I'm not sure if we actually need d5391bf02b9 ("efi_loader: ensure all
block devices are probed"). It seems to fix a real problem, though.

>
> But I also still say that given that we as a project are more resource
> constrained than Zephyr, for things that are QEMU-centric, there's
> already a wealth of information on debugging QEMU since it too is
> software. There's only so many hours in the day after all.

One of Zephyr's challenges is that it relied on QEMU for almost all
testing for a long time. As a result it takes a huge amount of CPU
power to run tests - last I checked it was something like an hour on a
64-core machine. U-Boot's unit tests ('ut all') run in about 12
seconds on my machine. I could go on for hours about the different
types of tests and the benefits of one versus the other, but the
cheapest answer is not necessarily just to do a 'happy path' test and
call it good.

For this particular test, I do want to have tests for each bootmeth,
to the point of running the target, so far as possible. It turns out
that we can launch an EFI app on sandbox, so connecting it up to
bootstd seems valuable to me.

I've filed an issue for the virtio improvements.

Regards,
Simon

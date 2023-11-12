Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC4BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 11:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2B586D3C;
	Sun, 12 Nov 2023 12:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C59286D4C; Sun, 12 Nov 2023 12:55:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 659A786D1D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87C91C15;
 Sun, 12 Nov 2023 03:55:43 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0D43F64C;
 Sun, 12 Nov 2023 03:54:57 -0800 (PST)
Date: Sun, 12 Nov 2023 11:53:37 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Peter Hoyes <peter.hoyes@arm.com>
Subject: Re: ARMv8.5 RNG driver (was :Re: [PATCH] virtio: rng: gracefully
 handle 0 byte returns)
Message-ID: <20231112115337.2bbe5ce7@slackpad.lan>
In-Reply-To: <CAPnjgZ3PKoi2z6iBCr1f0DJMbS_usp1fedwaCzwCjqd02O_87Q@mail.gmail.com>
References: <20231107160900.2652813-1-andre.przywara@arm.com>
 <CAPnjgZ1_KVcGvh869p3jvBh6umkwGv_VwFs73Yo3k9BBM54p0w@mail.gmail.com>
 <20231110141614.72b6dffd@donnerap.manchester.arm.com>
 <CAPnjgZ3PKoi2z6iBCr1f0DJMbS_usp1fedwaCzwCjqd02O_87Q@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 11 Nov 2023 20:08:36 -0700
Simon Glass <sjg@chromium.org> wrote:

Hi,

> On Fri, 10 Nov 2023 at 07:16, Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Fri, 10 Nov 2023 05:53:59 -0700
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Simon,
> >  
> > > On Tue, 7 Nov 2023 at 09:09, Andre Przywara <andre.przywara@arm.com> wrote:  
> > > >
> > > > According to the virtio v1.x "entropy device" specification, a virtio-rng
> > > > device is supposed to always return at least one byte of entropy.
> > > > However the virtio v0.9 spec does not mention such a requirement.
> > > >
> > > > The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng always
> > > > returns 8 bytes less of entropy than requested. If 8 bytes or less are
> > > > requested, it will return 0 bytes.
> > > > This behaviour makes U-Boot's virtio_rng_read() implementation go into an
> > > > endless loop, hanging the system.
> > > >
> > > > Work around this problem by always requesting 8 bytes more than needed,
> > > > but only if a previous call to virtqueue_get_buf() returned 0 bytes.
> > > >
> > > > This should never trigger on a v1.x spec compliant implementation, but
> > > > fixes the hang on the Arm FVP.
> > > >
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > Reported-by: Peter Hoyes <peter.hoyes@arm.com>
> > > > ---
> > > >  drivers/virtio/virtio_rng.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)  
> > >
> > > Unrelated to this patch, but do you know the hardware architecture of
> > > the ARM RNG? Is there one RNG unit per CPU or one for the whole SoC?  
> >
> > Architecturally and from a software perspective the ARMv8.5 FEAT_RNG
> > feature is a system register, so per-core. Theoretically the availability
> > could differ between cores, but the CPU ID feature registers are also
> > per-core, so as long as we run on a single core, or always at least
> > read from the same core, it's all good.
> >
> > Now the architecture only describes the CPU instruction aspect of the
> > feature, and establishes rules for the quality and spec conformance, but
> > leaves the actual source of the entropy open to the integrator.
> >
> > The manual in the Neoverse V1 core[1] (still not a SoC!) states that the
> > actual entropy source is a memory mapped peripheral, its address being
> > held in an internal, per-core register. So you can have one shared entropy
> > source per SoC, or a private instance for each core, that's up to the
> > actual integrator to design.
> >
> > From the software perspective this shouldn't matter, though: the feature
> > is "per-core", how this is backed is an implementation detail.  
> 
> Would it make sense to model this as a memory-mapped peripheral under
> /soc (perhaps one without an address?)

No, absolutely not. What I mentioned above is a somewhat hidden
implementation detail of that *particular core*. One big reason for
having those architected *system registers* is to do away with all
those implementation specific ways to access an entropy source, and
make this dead easy for software (including userland!) to use it:
Check the CPU ID register, read the sysreg. No prior knowledge required.

I now deeply regret sending this Armv8.5 RNG driver. I have an
alternative solution, just got distracted later this week to finish
this up.
Let's have a discussion there, or we find a way to probe UCLASS_RNG
drivers other than through devicetree nodes. If U-Boot really insists on
matching drivers to DT nodes 1:1, that's a really limiting design
decision, and we should not proliferate this by shoehorning everyone
and their dog into devicetree.

Cheers,
Andre

> > [1]
> > https://developer.arm.com/documentation/101427/0102/Functional-description/Random-number-support/About-the-random-number-support
> >
> >  
> > > > diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
> > > > index b85545c2ee5..786359a6e36 100644
> > > > --- a/drivers/virtio/virtio_rng.c
> > > > +++ b/drivers/virtio/virtio_rng.c
> > > > @@ -20,7 +20,7 @@ struct virtio_rng_priv {
> > > >  static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
> > > >  {
> > > >         int ret;
> > > > -       unsigned int rsize;
> > > > +       unsigned int rsize = 1;
> > > >         unsigned char buf[BUFFER_SIZE] __aligned(4);
> > > >         unsigned char *ptr = data;
> > > >         struct virtio_sg sg;
> > > > @@ -29,7 +29,12 @@ static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
> > > >
> > > >         while (len) {
> > > >                 sg.addr = buf;
> > > > -               sg.length = min(len, sizeof(buf));
> > > > +               /*
> > > > +                * Work around implementations which always return 8 bytes
> > > > +                * less than requested, down to 0 bytes, which would
> > > > +                * cause an endless loop otherwise.
> > > > +                */
> > > > +               sg.length = min(rsize ? len : len + 8, sizeof(buf));
> > > >                 sgs[0] = &sg;
> > > >
> > > >                 ret = virtqueue_add(priv->rng_vq, sgs, 0, 1);
> > > > --
> > > > 2.25.1  
> 
> Regards,
> Simon


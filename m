Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3F6CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0114488E90;
	Thu, 26 Sep 2024 23:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OROyxzi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA9288ED9; Thu, 26 Sep 2024 23:34:31 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1AB88EF3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb2aaf4a73so10880196d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386466; x=1727991266; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D/IS9o5cTkBgkEwzD1dCf658iDpMArnWopGTB4RNu/Y=;
 b=OROyxzi04nJShlGbAiTSzMK/8KHFVKDZrPQ9MMZ0+4sN19OibMd/zAcfKWXOFcNBS7
 qfo+CmJbSKUset5yizXikw2q9cB3zqmxQe01FjFfk8CVSRtDL/oGkKtXoY8GJLX56Jif
 /Vyzhw4dK+glCUIDOYVV1TO7HcyzjFhEQrs2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386466; x=1727991266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/IS9o5cTkBgkEwzD1dCf658iDpMArnWopGTB4RNu/Y=;
 b=DJl+SzqM+Wjw4v/WDms1EhZ3HUt+ML7PyNKrD1//tgfxZHAEMK7Zrg+HmWgI5/kpHq
 iuktSaw2HE66FtdOdLw3YFpkOYazzIhZUAQSkEjaHQPVIAYReqqtiycHsPx8P91q7TLq
 YSR3W5oeZrYtdRWmKXcN+e7g6R1jH6R/HqvY9pJl+N3lRtYEYPUQk/kZJ8m98uvQfGvr
 BjSAMrLeqgrLyrj6dH7Y9MRGEX2/NjRP0PRS2JVq10KJfNIpZYPPiCaU9s19p32i/gH9
 O0r671lKPqhi/Y6YKBIy3YlhAxc57j7iOhaCwxmSbAcFbigcipjV85Uhv+r9yesK1g8o
 QiQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxJB+DGlzMrKqmr+51ERUU7e2dAK7Fntfx+ltYY6GCjYodJ2S+TIFas+hnovZBHTh0WfvBWuk=@lists.denx.de
X-Gm-Message-State: AOJu0YxITR7rLSqO2O2sRLewNEpnR0DPKKdRKv9vBFl3xmjXXg47pQS4
 dxLYqcDElpvYgrR9VOid0S3W5R0dxwZHIPsKIXkrLHtFW5LO3ai9LQaN2Uat5gqp6v0jNp8s98D
 H1ANrHJWhQy3mDJAdlIR7AkCaWMMyFpK/QVxh472xn+JrUgaZiUPeWcE=
X-Google-Smtp-Source: AGHT+IETtkG/G6JBIZHL10iYeedD/i/xakMR5DdfUr+H92RLLwYYEZnj9BdoCr+JM8hqBEJUS3Hi8RRX/xbzd0VZgJ0=
X-Received: by 2002:a05:6214:5992:b0:6cb:3926:dacc with SMTP id
 6a1803df08f44-6cb3b653f57mr16174576d6.39.1727386466138; Thu, 26 Sep 2024
 14:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
 <20240917170346.GN4252@bill-the-cat>
 <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
 <20240919174554.GT4252@bill-the-cat>
 <CAFLszThvd4HSz6n+3OPVcQ4sv-pKD5rPfvJ_2gy_aLnPMG40hQ@mail.gmail.com>
 <20240920145933.GB4252@bill-the-cat>
 <CAFLszTi=Kquk3AfQJYpYdvmZn=EKNZTzjOL-ukLJCtP15KfigQ@mail.gmail.com>
 <20240925172613.GC4252@bill-the-cat>
In-Reply-To: <20240925172613.GC4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:34:14 +0200
Message-ID: <CAFLszTghO0Cf3M4hPAxzXktcz5Y1JjSr0WiPdmtMKcPGryx3jQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Tom,

On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 25, 2024 at 02:52:04PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Sept 2024 at 16:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Sep 20, 2024 at 09:25:29AM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 19 Sept 2024 at 19:45, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Sep 19, 2024 at 04:10:12PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 17 Sept 2024 at 19:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > > > > > > While sandbox supports virtio it cannot support actually using the block
> > > > > > > > > > devices to read files, since there is nothing on the other end of the
> > > > > > > > > > 'virtqueue'.
> > > > > > > > > >
> > > > > > > > > > A recent change makes EFI probe all block devices, whether used or not.
> > > > > > > > > > This is apparently required by EFI, although it violates U-Boot's
> > > > > > > > > > lazy-init principle.
> > > > > > > > >
> > > > > > > > > We always did this.
> > > > > > > >
> > > > > > > > Commit d5391bf02b9 dates from 2022, so I don't think that is correct.
> > > > > > >
> > > > > > > Yes, but I also could have sworn that was fixing the behavior having
> > > > > > > been changed again previous to that.
> > > > > >
> > > > > > I don't see any evidence of that, though.
> > > > >
> > > > > Yes, it's just my recollection of the time and I could be misremembering
> > > > > it as one of the other times we've had this discussion.
> > > > >
> > > > > > > > > What problem do you want to fix? I have not seen any issues in our CI.
> > > > > > > >
> > > > > > > > The EFI test in this series hangs trying to probe a virtio block
> > > > > > > > device. If you drop this patch and try the rest of the series in CI,
> > > > > > > > you will see the failure. Or you could just accept that I investigated
> > > > > > > > this, root-caused it and produced a suitable fix. This is a v5 patch
> > > > > > > > which has had quite a bit of discussion.
> > > > > > >
> > > > > > > And as I noted an iteration or two back, it's entirely unclear if the
> > > > > > > problem is "sandbox virtio is broken" or "this code is wrong here".
> > > > > > > Which in fact gets us back to ...
> > > > > >
> > > > > > sandbox virtio does not support a functioning block device
> > > > > >
> > > > > > >
> > > > > > > > > > We cannot just drop the virtio devices as they are used in sandbox tests.
> > > > > > > > > >
> > > > > > > > > > So for now just add a special case to work around this.
> > > > > > > > > >
> > > > > > > > > > The eventual fix is likely adding an implementation of
> > > > > > > > > > virtio_sandbox_notify() to actually do the block read. That is tracked
> > > > > > > > > > in [1].
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> > > > > > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v3)
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - Add a Fixes tag
> > > > > > > > > > - Mention the issue created for this problem
> > > > > > > > > >
> > > > > > > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > > > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > > > > > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > > > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > > > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > > > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
> > > > > > > > > >   efi_status_t efi_disks_register(void)
> > > > > > > > > >   {
> > > > > > > > > >       struct udevice *dev;
> > > > > > > > > > +     struct uclass *uc;
> > > > > > > > > >
> > > > > > > > > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > > > > > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > > > > > > +             /*
> > > > > > > > > > +              * The virtio block-device hangs on sandbox when accessed since
> > > > > > > > > > +              * there is nothing listening to the mailbox
> > > > > > > > > > +              */
> > > > > > > > > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > > > > > +                     struct blk_desc *desc = dev_get_uclass_plat(dev);
> > > > > > > > > > +
> > > > > > > > > > +                     if (desc->uclass_id == UCLASS_VIRTIO)
> > > > > > > > > > +                             continue;
> > > > > > > > > > +             }
> > > > > > > > > > +             device_probe(dev);
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > >       return EFI_SUCCESS;
> > > > > > > > >
> > > > > > > > > Please, do not spray sandbox tweaks all over the place.
> > > > > > > > >
> > > > > > > > > Can't you just return an error from the sandbox-virtio driver when an
> > > > > > > > > attempt to read a queue is made?
> > > > > > > > >
> > > > > > > > > We are using virtio on QEMU. Why do we need sandbox virtio devices? Just
> > > > > > > > > run the relevant tests on the real thing.
> > > > > > > >
> > > > > > > > Please go ahead with whatever approach to testing you wish. But
> > > > > > > > sandbox testing is an important component of U-Boot.
> > > > > > >
> > > > > > > Yes, but is sandbox implementing the "just be a state machine" part here
> > > > > > > correctly, or not? It keeps feeling like "not" and that the reasonable
> > > > > > > course of action would be to stop testing this on sandbox until that is
> > > > > > > fixed especially since we can test this reliably on qemu.
> > > > >
> > > > > OK, but I can't tell if your answer to my point here is:
> > > > > - Yes, sandbox virtio is broken / incomplete
> > > > > - No, sandbox virtio is fine, there's some other mismatch between how
> > > > >   it's used for sandbox and how it's used for QEMU. This will get
> > > > >   resolved later.
> > > >
> > > > It is incomplete, in that the block device is not fully implemented.
> > >
> > > Then please disable it until you can complete it.
> > >
> > > > No other test enables it, but EFI does, since it blinding tries to
> > > > access all block devices without any control.
> > > >
> > > > >
> > > > > > We have to move things forward a piece at a time. Not having a proper
> > > > > > test for the EFI bootmeth is a significant gap and is what I am trying
> > > > > > to fix with this series. It isn't perfect, but it is a step forward
> > > > > > and will prevent regressions. It can also be built on later.
> > > > > >
> > > > > > Happy-path testing with QEMU is all very well, but it only goes so far.
> > > > >
> > > > > I frankly get really puzzled about why testing all of this, in QEMU,
> > > > > where we could actually design the test to see if the OS has booted (and
> > > > > if we leave things configurable well enough, do this on real hardware)
> > > > > is wrong but sandbox, where we can't boot the OS, is good. Especially
> > > > > for the device that's only present in an emulator. We're emulating an
> > > > > emulator and not getting matching behavior in our emulator.
> > > >
> > > > There are many reasons:
> > >
> > > To be clear, I'm not saying sandbox tests have no value, or are
> > > unimportant. I apologize for imply as much.
> > >
> > > > - with sandbox we can test the operation of the bootmeth, including
> > > > under failure conditions
> > >
> > > Yes, state machine tests are useful. But we can test for xFAIL on other
> > > platforms, yes?
> > >
> > > > - we can test what happens within U-Boot itself when
> > > > exit-boot-services is called, which is the bug that provoked me to
> > > > write the test
> > >
> > > I honestly don't recall the state of the discussion around that patch,
> > > positive/negative/neutral.
> > >
> > > > - we can build on this test to cover other bootmeths without needing
> > > > to install a full OS just to run a test
> > >
> > > Counter point, we can't test that an OS actually boots. One of the most
> > > valuable personally tests we've added recently is
> > > test/py/tests/test_net_boot.py which makes the network load and boot an
> > > OS image, and test for (some) failure modes.
> >
> > What do you want me to do with this patch?
> >
> > Without it, the test cannot pass. Are you suggesting that we apply the
> > patches, but don't enable the test until it can be made to work,
> > without this patch? Are you suggesting that I implement block devices
> > for virtio in sandbox?
> >
> > I see great value in this test. It covers a case which we don't
> > currently have in CI.
> >
> > Please can you just take this patch so we can move forward?? I'm happy
> > to add the virtio support later.
>
> I'm suggesting, again, that you need to disable the sandbox virtio
> driver until you can come and complete it.

OK, I did not understand the 'it' in your previous comment. I will do
that, thanks.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79261CF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218D1893A0;
	Fri, 20 Sep 2024 09:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VQ3FQl/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B0D893A0; Fri, 20 Sep 2024 09:25:44 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925FB893AC
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a99de9beb2so115292785a.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817140; x=1727421940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Rfzahg6GtefshNF45Qi93KekZecZ4Mx6BfzWApkYTo=;
 b=VQ3FQl/ND2rg6eh8+NrgB2AdGRbFpusMGLdp/rbMT0dgTzzl/tu7sI0mpSj9dxaEI4
 7SUXyAVuBOWQIGuYn/LsnwxZk65woLnvYQ0ZCrhOR8po3MyeOZx9nwgPhGrZaPyIIfLG
 BP5aO1DRrefGapNmnWgavqFg3GEk0fQK8f4Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817140; x=1727421940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Rfzahg6GtefshNF45Qi93KekZecZ4Mx6BfzWApkYTo=;
 b=YtkUEnZXoqI/RyV9fJgFokiKs70ECTzQawlTV4f3nLedy6JX0KddxIWUxU1NOcil2B
 K4KdSekxwj3HfcPwTNatxFhVVb0CEC4NvL5CuwGNR2MVGJB3kf/1sRRZYLlwr6t/iLVT
 dPDjO0JA+K1KdV7rZt9o1nd9+jVL4eSP/+NSsZNnvgtwDEA2z6XKH2LfPmJhMc89tlfU
 wxFPOx65KFnqCPYusSk+9/UDhtV3EEzbskSvEK0eXnxQydOSLzWYqw/EI6lpKsSJV0t9
 wYq8+94PliDXt0PQe9b/6gHa12c64p8rXE68XvTS58xUm/A8MY5q3Z6r6vCJHRPzrWCa
 olUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBt72M5BADfGq7V7/RAwhtbgohDp8lmFbcN6Ee7pwM/iG1S5+rkqZYb9N5SxeprAmAI6E+H4U=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+u7h1Z5vsM2V9GTm1bIJvbtl/A9Ohq738WX6Kw97fM1wdcAsI
 MeRAY15/M/vEi2TMZPtLlSD3+RRAYVkcDSSLD6GbYwlHvawV+kv//D0MIVS2b5HAVJdUeNV3Mbf
 PV8+WA3eU5VNYiyeTdvisUmFb/9oc/Xn/uAWV
X-Google-Smtp-Source: AGHT+IGRAROdAT9GALjQdCXEWA4qa3cwD3eBOg1uCnZjrRSvw5NcIv2bBEZTXN9RsiJmUW6AYxENjLPPPwErfIaJ7PU=
X-Received: by 2002:a05:6214:3992:b0:6c5:2fc7:a623 with SMTP id
 6a1803df08f44-6c7bd4866acmr23311216d6.11.1726817140358; Fri, 20 Sep 2024
 00:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
 <20240917170346.GN4252@bill-the-cat>
 <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
 <20240919174554.GT4252@bill-the-cat>
In-Reply-To: <20240919174554.GT4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:29 +0200
Message-ID: <CAFLszThvd4HSz6n+3OPVcQ4sv-pKD5rPfvJ_2gy_aLnPMG40hQ@mail.gmail.com>
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

On Thu, 19 Sept 2024 at 19:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 19, 2024 at 04:10:12PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Sept 2024 at 19:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > > While sandbox supports virtio it cannot support actually using the block
> > > > > > devices to read files, since there is nothing on the other end of the
> > > > > > 'virtqueue'.
> > > > > >
> > > > > > A recent change makes EFI probe all block devices, whether used or not.
> > > > > > This is apparently required by EFI, although it violates U-Boot's
> > > > > > lazy-init principle.
> > > > >
> > > > > We always did this.
> > > >
> > > > Commit d5391bf02b9 dates from 2022, so I don't think that is correct.
> > >
> > > Yes, but I also could have sworn that was fixing the behavior having
> > > been changed again previous to that.
> >
> > I don't see any evidence of that, though.
>
> Yes, it's just my recollection of the time and I could be misremembering
> it as one of the other times we've had this discussion.
>
> > > > > What problem do you want to fix? I have not seen any issues in our CI.
> > > >
> > > > The EFI test in this series hangs trying to probe a virtio block
> > > > device. If you drop this patch and try the rest of the series in CI,
> > > > you will see the failure. Or you could just accept that I investigated
> > > > this, root-caused it and produced a suitable fix. This is a v5 patch
> > > > which has had quite a bit of discussion.
> > >
> > > And as I noted an iteration or two back, it's entirely unclear if the
> > > problem is "sandbox virtio is broken" or "this code is wrong here".
> > > Which in fact gets us back to ...
> >
> > sandbox virtio does not support a functioning block device
> >
> > >
> > > > > > We cannot just drop the virtio devices as they are used in sandbox tests.
> > > > > >
> > > > > > So for now just add a special case to work around this.
> > > > > >
> > > > > > The eventual fix is likely adding an implementation of
> > > > > > virtio_sandbox_notify() to actually do the block read. That is tracked
> > > > > > in [1].
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > > > > ---
> > > > > >
> > > > > > (no changes since v3)
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Add a Fixes tag
> > > > > > - Mention the issue created for this problem
> > > > > >
> > > > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > > > --- a/lib/efi_loader/efi_disk.c
> > > > > > +++ b/lib/efi_loader/efi_disk.c
> > > > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
> > > > > >   efi_status_t efi_disks_register(void)
> > > > > >   {
> > > > > >       struct udevice *dev;
> > > > > > +     struct uclass *uc;
> > > > > >
> > > > > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > > > +             /*
> > > > > > +              * The virtio block-device hangs on sandbox when accessed since
> > > > > > +              * there is nothing listening to the mailbox
> > > > > > +              */
> > > > > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > +                     struct blk_desc *desc = dev_get_uclass_plat(dev);
> > > > > > +
> > > > > > +                     if (desc->uclass_id == UCLASS_VIRTIO)
> > > > > > +                             continue;
> > > > > > +             }
> > > > > > +             device_probe(dev);
> > > > > >       }
> > > > > >
> > > > > >       return EFI_SUCCESS;
> > > > >
> > > > > Please, do not spray sandbox tweaks all over the place.
> > > > >
> > > > > Can't you just return an error from the sandbox-virtio driver when an
> > > > > attempt to read a queue is made?
> > > > >
> > > > > We are using virtio on QEMU. Why do we need sandbox virtio devices? Just
> > > > > run the relevant tests on the real thing.
> > > >
> > > > Please go ahead with whatever approach to testing you wish. But
> > > > sandbox testing is an important component of U-Boot.
> > >
> > > Yes, but is sandbox implementing the "just be a state machine" part here
> > > correctly, or not? It keeps feeling like "not" and that the reasonable
> > > course of action would be to stop testing this on sandbox until that is
> > > fixed especially since we can test this reliably on qemu.
>
> OK, but I can't tell if your answer to my point here is:
> - Yes, sandbox virtio is broken / incomplete
> - No, sandbox virtio is fine, there's some other mismatch between how
>   it's used for sandbox and how it's used for QEMU. This will get
>   resolved later.

It is incomplete, in that the block device is not fully implemented.
No other test enables it, but EFI does, since it blinding tries to
access all block devices without any control.

>
> > We have to move things forward a piece at a time. Not having a proper
> > test for the EFI bootmeth is a significant gap and is what I am trying
> > to fix with this series. It isn't perfect, but it is a step forward
> > and will prevent regressions. It can also be built on later.
> >
> > Happy-path testing with QEMU is all very well, but it only goes so far.
>
> I frankly get really puzzled about why testing all of this, in QEMU,
> where we could actually design the test to see if the OS has booted (and
> if we leave things configurable well enough, do this on real hardware)
> is wrong but sandbox, where we can't boot the OS, is good. Especially
> for the device that's only present in an emulator. We're emulating an
> emulator and not getting matching behavior in our emulator.

There are many reasons:
- with sandbox we can test the operation of the bootmeth, including
under failure conditions
- we can test what happens within U-Boot itself when
exit-boot-services is called, which is the bug that provoked me to
write the test
- we can build on this test to cover other bootmeths without needing
to install a full OS just to run a test

Just the sheer number of bugs found and fixed by this test should show
its value. One of the bugs was an access at location 0 which many
boards happily accept, but sandbox catches.

Also, someone should keep track of all the bugs we never see, because
a test covers them. For example, driver model is well-covered by tests
and we seldom see a bug. If all we had was QEMU, then all our tests
would be 'happy path' and we would be in a very different position.

One lesson I see here is that I should have pushed for a proper block
device with virtio at the time. But who could have foreseen that EFI
would throw away the 'lazy init' approach of U-Boot and just scan all
the devices?

Regards,
Simon

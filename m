Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16074CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1CA891E7;
	Thu, 19 Sep 2024 16:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dq2dnQQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC8E48919B; Thu, 19 Sep 2024 16:10:30 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42693891BD
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d87f34a650so663357a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755027; x=1727359827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oF3BXJQjcJ9Z/msYxPy8Qkfeka5LPcvQit+2je/gWy0=;
 b=Dq2dnQQ4nH8pttR1ILhGkQntbN8eUwhTeNu5WBmb5ZU9rY9VCJj108N8YO0s4hk1SH
 qfHguksDpREM+mClTnTEW6nix8Dqc6EP99KW2dQf46qFqHxSVpfdaoD7vDlW4ihPC6fJ
 +qP/fJcMaumFktH14ML17mwCcqPveWdcCLcS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755027; x=1727359827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oF3BXJQjcJ9Z/msYxPy8Qkfeka5LPcvQit+2je/gWy0=;
 b=cjms/tjQcAd6zw4fRzBN6LoXscKVr972CAQL8hpFZdnhODpSmRBTr66TsXSi3uwlPt
 3vYy9+5nB5pMfQwtHxpvo4FktJQeH2kI5XgIHMPkonnfkHMphGoC0B/pOZSEC6bync3L
 F7DWiuvRR4oyS29KQwYKMTj2zX4vStDbElqMbDyS534Vxno1KAPiHh1eOhsxNQfImwT8
 a5G+XnO9SAL1WhlXKncRtWW7T9UP4qLpENMLU3Xoy0GWKhOtrHTX5dPSEGmIxZidGd5K
 KRJMYs4qsRws63JgR+3l0GNc/TIGc1IMxC/zO0HrYkEKRb5T7Wh/WrhqulgeSb1JXm07
 yylQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8wE8F6pQhIW5Ie69PPar57hs3eobp3wfH14b5cHlb1kiSsed/Wr9vGq/woiBiSLVC/NeN7m0=@lists.denx.de
X-Gm-Message-State: AOJu0YwzM8qlVDgTRf7RKQnbTPyhf+lhboz9dcb4JDyIfrBIhYzf296K
 eyZ8c7IYWL2dKi4xkh05mXVhGhkoeD7dhDY9JkUKrMCJGFwQj08ryD/wJ6BX8KLDWbgNlje+th6
 jjx/ouhgMXXqHP/J9aiW2JfHv/3sqoYArA559
X-Google-Smtp-Source: AGHT+IG98EDN5f0Pkyx8kwniSZdbrV0JearGqlQMFsuURs6s4bNLT2FRKD0fJMTT5ZOqpuv9VVBS9mIzSKBA2y4Wvr8=
X-Received: by 2002:a17:90b:1286:b0:2d8:7a63:f9c8 with SMTP id
 98e67ed59e1d1-2dd6ce9b501mr5366950a91.14.1726755026735; Thu, 19 Sep 2024
 07:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
 <20240917170346.GN4252@bill-the-cat>
In-Reply-To: <20240917170346.GN4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:12 +0200
Message-ID: <CAFLszThMhNzvW=OTgsAA0Hikv+uxLaVn7bwTGM0=htf=BbzmcA@mail.gmail.com>
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

On Tue, 17 Sept 2024 at 19:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 02.09.24 03:18, Simon Glass wrote:
> > > > While sandbox supports virtio it cannot support actually using the block
> > > > devices to read files, since there is nothing on the other end of the
> > > > 'virtqueue'.
> > > >
> > > > A recent change makes EFI probe all block devices, whether used or not.
> > > > This is apparently required by EFI, although it violates U-Boot's
> > > > lazy-init principle.
> > >
> > > We always did this.
> >
> > Commit d5391bf02b9 dates from 2022, so I don't think that is correct.
>
> Yes, but I also could have sworn that was fixing the behavior having
> been changed again previous to that.

I don't see any evidence of that, though.

>
> > > What problem do you want to fix? I have not seen any issues in our CI.
> >
> > The EFI test in this series hangs trying to probe a virtio block
> > device. If you drop this patch and try the rest of the series in CI,
> > you will see the failure. Or you could just accept that I investigated
> > this, root-caused it and produced a suitable fix. This is a v5 patch
> > which has had quite a bit of discussion.
>
> And as I noted an iteration or two back, it's entirely unclear if the
> problem is "sandbox virtio is broken" or "this code is wrong here".
> Which in fact gets us back to ...

sandbox virtio does not support a functioning block device

>
> > > > We cannot just drop the virtio devices as they are used in sandbox tests.
> > > >
> > > > So for now just add a special case to work around this.
> > > >
> > > > The eventual fix is likely adding an implementation of
> > > > virtio_sandbox_notify() to actually do the block read. That is tracked
> > > > in [1].
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > > ---
> > > >
> > > > (no changes since v3)
> > > >
> > > > Changes in v3:
> > > > - Add a Fixes tag
> > > > - Mention the issue created for this problem
> > > >
> > > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > > index 93a9a5ac025..2e1d37848fc 100644
> > > > --- a/lib/efi_loader/efi_disk.c
> > > > +++ b/lib/efi_loader/efi_disk.c
> > > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
> > > >   efi_status_t efi_disks_register(void)
> > > >   {
> > > >       struct udevice *dev;
> > > > +     struct uclass *uc;
> > > >
> > > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > > +             /*
> > > > +              * The virtio block-device hangs on sandbox when accessed since
> > > > +              * there is nothing listening to the mailbox
> > > > +              */
> > > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > > +                     struct blk_desc *desc = dev_get_uclass_plat(dev);
> > > > +
> > > > +                     if (desc->uclass_id == UCLASS_VIRTIO)
> > > > +                             continue;
> > > > +             }
> > > > +             device_probe(dev);
> > > >       }
> > > >
> > > >       return EFI_SUCCESS;
> > >
> > > Please, do not spray sandbox tweaks all over the place.
> > >
> > > Can't you just return an error from the sandbox-virtio driver when an
> > > attempt to read a queue is made?
> > >
> > > We are using virtio on QEMU. Why do we need sandbox virtio devices? Just
> > > run the relevant tests on the real thing.
> >
> > Please go ahead with whatever approach to testing you wish. But
> > sandbox testing is an important component of U-Boot.
>
> Yes, but is sandbox implementing the "just be a state machine" part here
> correctly, or not? It keeps feeling like "not" and that the reasonable
> course of action would be to stop testing this on sandbox until that is
> fixed especially since we can test this reliably on qemu.

We have to move things forward a piece at a time. Not having a proper
test for the EFI bootmeth is a significant gap and is what I am trying
to fix with this series. It isn't perfect, but it is a step forward
and will prevent regressions. It can also be built on later.

Happy-path testing with QEMU is all very well, but it only goes so far.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903D8C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF3C88ECC;
	Mon, 16 Sep 2024 17:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="COyRU61x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7A888ECC; Mon, 16 Sep 2024 17:42:51 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356ED883D4
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e1d2cf4cbf1so4490456276.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501368; x=1727106168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eaqr+TSVmMmKCZPJDKFm5lOPEN+Mfgj4UMsV1cn8Omo=;
 b=COyRU61xpEZaBX75PzadTmW+DpuLuEroAMPTBK94iI6hmCjEFfmkInMa+lI/zZGhUU
 uZDCs5bol+q3aVZMyQO19k0k+WrW34MiRpKvdfv8oWNLrzaeUfLeJ+LHIbF1m8gBtEfx
 otn2+I6frW4TCJiUDuKJzPvuGDYa0QwjvjNcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501368; x=1727106168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eaqr+TSVmMmKCZPJDKFm5lOPEN+Mfgj4UMsV1cn8Omo=;
 b=rkUIiPl6W8dVTooj0GbdlUwXDzMkplEco1muQdchpy9Pk4TvmxY6pFZAWAHLdB/wqX
 aCZ5WhaGN4GEeCNOSI8R5pKyR9bkdVogIIXgNf7+ndxK7avFQJYiyBVd+lwaVhhpDVLU
 mFMhndBqXmFYlxUwaX3/hruSwWGYGBUKaakfiw002bCHru/KGPDMmvGYx03fqk89Lsh8
 s/4ZKrt7jXEpbRx8tG/2+nq+ABRpux4GW6DB8OoDjrQjEbwnvgi2L0RenLp24cIh3Amr
 rpViC3TAb2AY0Mf/eDv8um1VtdgrgSl3CWDij6YePcxn4TNdfbPVJUW2mKOz9O8fHccq
 RPJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIEg2gmT+CKBKKVcHKQ39qSFmuhDcwN++gx/f7HLgkujkeZpIN7h38lJfuUrGBCVJhOl8nRDE=@lists.denx.de
X-Gm-Message-State: AOJu0YwtS0uffeY14glZE15AmkzahRr+5hpoe0xTpdsD8NBHUY5SMG4g
 Db+LMjMqyk6FwgooDQJQ2uJhFNGfCN62kSjPS6UIajSkDmfCtGGL7hZ0y1kFQYjUEMP8kUIkrj4
 uZ04/WtFkyXVG0+R0B/UcDoss2qVL0PuiIQjB
X-Google-Smtp-Source: AGHT+IFnQIqGvzrlYdh4XTQlx3R00R7Gxh5UlwD3Ii2RFYEVZTTg05BDzXaBRf6LMtQ+hRdZAzQ41pgNwBel5Z7KOfk=
X-Received: by 2002:a05:6902:2601:b0:e1a:a9b0:d9b8 with SMTP id
 3f1490d57ef6-e1d9dc47e1amr10301146276.50.1726501368039; Mon, 16 Sep 2024
 08:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
In-Reply-To: <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:42:31 +0200
Message-ID: <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
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

Hi Heinrich,

On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 03:18, Simon Glass wrote:
> > While sandbox supports virtio it cannot support actually using the block
> > devices to read files, since there is nothing on the other end of the
> > 'virtqueue'.
> >
> > A recent change makes EFI probe all block devices, whether used or not.
> > This is apparently required by EFI, although it violates U-Boot's
> > lazy-init principle.
>
> We always did this.

Commit d5391bf02b9 dates from 2022, so I don't think that is correct.

>
> What problem do you want to fix? I have not seen any issues in our CI.

The EFI test in this series hangs trying to probe a virtio block
device. If you drop this patch and try the rest of the series in CI,
you will see the failure. Or you could just accept that I investigated
this, root-caused it and produced a suitable fix. This is a v5 patch
which has had quite a bit of discussion.

>
> >
> > We cannot just drop the virtio devices as they are used in sandbox tests.
> >
> > So for now just add a special case to work around this.
> >
> > The eventual fix is likely adding an implementation of
> > virtio_sandbox_notify() to actually do the block read. That is tracked
> > in [1].
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Add a Fixes tag
> > - Mention the issue created for this problem
> >
> >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 93a9a5ac025..2e1d37848fc 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
> >   efi_status_t efi_disks_register(void)
> >   {
> >       struct udevice *dev;
> > +     struct uclass *uc;
> >
> > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > +             /*
> > +              * The virtio block-device hangs on sandbox when accessed since
> > +              * there is nothing listening to the mailbox
> > +              */
> > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > +                     struct blk_desc *desc = dev_get_uclass_plat(dev);
> > +
> > +                     if (desc->uclass_id == UCLASS_VIRTIO)
> > +                             continue;
> > +             }
> > +             device_probe(dev);
> >       }
> >
> >       return EFI_SUCCESS;
>
> Please, do not spray sandbox tweaks all over the place.
>
> Can't you just return an error from the sandbox-virtio driver when an
> attempt to read a queue is made?
>
> We are using virtio on QEMU. Why do we need sandbox virtio devices? Just
> run the relevant tests on the real thing.

Please go ahead with whatever approach to testing you wish. But
sandbox testing is an important component of U-Boot.

Regards,
Simon

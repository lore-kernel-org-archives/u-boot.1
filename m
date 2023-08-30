Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0606AC83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 07:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40CF080711;
	Wed, 30 Aug 2023 09:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QurdXWKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CCD8611E; Wed, 30 Aug 2023 09:34:05 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB31780422
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 09:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ff9b389677so8165628e87.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693380842; x=1693985642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ROUSeryZnYZSMyInuOD6m1Q8SOSRIuKC3aBgDYckaE=;
 b=QurdXWKO0a5Y5O10fJ1t5r79o88hFTvNT9GM/nsXzXWUiqiCu8hOR4Vrb+7RrJvN9V
 SC9FyASKVVBRCR5OVqdnaBNMvsl4WmlqMGNQx6BqiVuwhvgmkc1fk/tkxugK/ip14Chx
 XAzfVocxVQeKuepb0mDsZ92/y/HxrBKKwqDlJgBuKPLTyuqJl6PZ7YTJ9f+fiGtHckVE
 JBWId2cfMx+Xl6uplGmtrsQJbEj9zAkl/c1geHYn+p44dW9Xd4TT3OdoFiGvNzJ0wvI2
 cAh1ibFe5BzI1h54q6zNdzJ8QQ76dQN7NMCOhatzUsIht9Z9puAk7LCI4xqmdG94GG0W
 HKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693380842; x=1693985642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ROUSeryZnYZSMyInuOD6m1Q8SOSRIuKC3aBgDYckaE=;
 b=gB0tUzvL6EqnygAHutnJygSGV/Ga8R8lOTeNoWYWWYyAehlyNuMVv7kyEJDnvTPm5B
 5/RDXN8cdcFhFESUte/HkP9kZ7sMSznUBTc6kC18rb9Teq2qaLoEIXwc9xr+TnEqAgpv
 puvvds7z7G9I5+uyC8NG6fKq3giDTB7lXgwG3jQTy5jgi5w49OwDtJgFoZEIuJdkoiLF
 JfwGlb+LKAgGxKvQ8L9LtNBGNQbwDuJjcV01UJw2rm85/xx8rsI02XUKtwFjqO3QJ7Hh
 GQdn1lakkbnVCdvL/qrpb/w3OsYF3NaLVcv2z0m8H2/bQAjS4S1Vt7/6UReqKTlalhxs
 k6Zw==
X-Gm-Message-State: AOJu0YxMsY9+YzFfHEySOrvfThK/eY8IE8zQ2A0HYqeI0sssesN378QP
 PzDfR76FHbQlJxeHqupowpM656PUNYQNsPcsUkjT/w==
X-Google-Smtp-Source: AGHT+IHtAJ3ZnTi2dm4WyAkjMssWCDQ0E4N7yC7P9B8n2QYBYLHAmGF7NwDWLkOQv3F1wole2tmXIJXcDsW+NP7SmfA=
X-Received: by 2002:a05:6512:3d16:b0:500:91ac:c0b5 with SMTP id
 d22-20020a0565123d1600b0050091acc0b5mr1199364lfv.30.1693380842228; Wed, 30
 Aug 2023 00:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
 <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
In-Reply-To: <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Aug 2023 10:33:26 +0300
Message-ID: <CAC_iWjKADqX3HaJON6CELbGeAD5VDvdyGfgHPxCjA8G+YRd7gg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Alper,

On Sun, 27 Aug 2023 at 18:49, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-15 01:43 +03:00, Simon Glass wrote:
> > Hi Alper,
> >
> > On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >> I actually want to put the root.img device first so that the VM can boot
> >> into the installed system when it reboots, but U-Boot can't find the
> >> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
> >> scan -lab`, but it seems to only ever search the first virtio-blk.
> >> However, `eficonfig; bootefi bootmgr` makes it boot somehow.

eficonfig, apart from displaying the boot options on a menu scans all
media that have a simple filesystem protocol installed and configures
the efi boot options.  That's why bootefi bootmgr boots properly
afterwards.  You can probably boot even without eficonfig, but only
bootXXX.efi files will be accounted for and no boot options will be
added.

The EFI spec describes the bootmgr functionality in detail.  Back when
the bootmeth patches were added, I suggested we shouldn't deal with
EFI at all simply because it all already works and is backed by a
spec.  Instead, we should just have a boot option in the methods that
spells "EFI" and let the bootmanager deal with the details. But
honestly, I've lost track of those patches.

Thanks
/Ilias
> >
> > Yes, this is annoying.
> >
> > The problem is that the scanning is getting so complicated. The
> > boot_targets var lists things which can either be a uclass, or a
> > uclass with a device number. The currently implementation sees
> > "virtio" and moves on to the next thing in boot_targets once it has
> > processed one virtio device. That is obviously not correct, but...
> >
> > Would it be possible to just drop the 'boot_targets' var? That is what
> > is stuffing it up, but we don't actually need it now. The defaults end
> > up doing the same thing, apart (perhaps) from the strangeness of
> > virtio which can be both a network and a blk device.
> >
> > I believe it is possible to do the right thing, but I'll need to
> > create a better test mechanism to handle all the cases.
>
> I think some kind of a "priority score" could help -- iterate over
> boot_targets first just to generate bootdev priorities, then carry them
> over as bootflows are discovered (adjusted for bootmeth order), then use
> those scores as the order to boot / to show a sorted menu / to test?

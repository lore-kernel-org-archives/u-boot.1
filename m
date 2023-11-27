Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6FFC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 07:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992508750C;
	Mon, 27 Nov 2023 08:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KdTHX/cC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E59187516; Mon, 27 Nov 2023 08:16:56 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E68870F2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 08:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50baa7cdf6dso2004936e87.0
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701069413; x=1701674213; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWBYNn5grjriWnCGcz8KlzvRAPCpBBCZ3iwW4N426rA=;
 b=KdTHX/cC384uq8sUuknTtyTY0v5sELvAqHgHbhWeBASBqRhlvqwfqR19WBtlj8gqbb
 VyUvcrheZIcjrXQD9ScQyxEa6f8FHj1hYAyQhwnv9KwMgmVKoY0ZAyV3kqtR3PvnwLVI
 LUTSJhOdgiTW0YXJ7RGHsvDByQjqgro9Np/2Bge4aCGNJltRsqzbzXppZmgYLcQZTMKY
 shAZa/g3wfaWNuQVXRYJA/mrKJ7tK/Fg0Mapy4RVBzdYC07XIMGXSkqp4t+QzmLYoca9
 n01wV3l3P80RBgXM3wQipCidLR9V8gzAx1LdWMYodaMRZv1dGoJPwr6hW7w/hUcKrcIT
 lSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701069413; x=1701674213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWBYNn5grjriWnCGcz8KlzvRAPCpBBCZ3iwW4N426rA=;
 b=V6gTOWo5chtp9XWIEaw6ufAxPSv7PnjvmBC79vYnoupXAmqJ1064b8axMn908QBdCh
 x44ero/C7dUVGyK/d9NC7JjhFQZr47mtmy684qVYD+/pAfeT5qHmM7nnOlEMhXksUOeC
 +RiDjsyKxgnS9kuRh23O4GGKae5TiKlNTi8/MmilfcDeTbWzma6zPK47lvkOty6ogO0F
 Sih2JQOGtyDOFcqAfmLNjab/ELoz5Mg33dojEX8QS4MCQ0OtK03J1eL5gp4gpNjIasTB
 AUyJuo05Nqk3MZbmktEBOu34/M52t+kA6sCEWYaVOM82ddjVDhhbjr16izNYaA7sOAQ/
 H9GA==
X-Gm-Message-State: AOJu0YxWE3vR0Qbpa3/lduK5hvkpqWdacMZNHnw8GTnIOvO8r42l7Dlh
 bjEE+L+dDhxqDAbxB/79A9wpkM1E3/yJocn/IDpjmx7z4rIw6mTYdlQ=
X-Google-Smtp-Source: AGHT+IHfyyrDNVYQ+1f4Dh1cevyLvTMCEpO1uCuAVyAlRVZlgLeGPuF6+qlJZ38GFo6P77BWy2BFOzTRvM983xP6aZo=
X-Received: by 2002:a05:6512:280d:b0:507:ba75:b016 with SMTP id
 cf13-20020a056512280d00b00507ba75b016mr9494155lfb.3.1701069412795; Sun, 26
 Nov 2023 23:16:52 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
 <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
In-Reply-To: <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Nov 2023 09:16:16 +0200
Message-ID: <CAC_iWj+HV4dBqa4iG4NfJ9T=jwdqxLMi5Lunis7ZFezQ23VPag@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Shantur Rathore <i@shantur.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, takahiro.akashi@linaro.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Shantur

On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Peter,
>
> On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > Hi Shantur,
> >
> > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@shantur.com=
> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Shantur
> > > >
> > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> wrote=
:
> > > > >
> > > > > Hi Heinrich,
> > > > >
> > > > > I am trying to work out how to enable the SetVariableRT service i=
n
> > > > > U-Boot and came across your patch [1] which initially had the
> > > > > SetVariable RT service enabled in EFI but in the final patch this=
 was
> > > > > removed.
> > > > > I am hoping to implement it on top of the SPI Flash EFI store [2]=
 to
> > > > > be able to set Boot order and boot items from Linux the UEFI way.
> > > > >
> > > > > Can I pick your brain on why it was dropped in the patch?
> > > > > Is there any limitation in SetVariableRT service ?
> > > >
> > > > I recently had a talk about it in Plumbers [0]. Generally speaking,=
 RT
> > > > + hardware owned by the kernel is a very weird combination since yo=
u
> > > > can't guarantee exclusive access to the flash or the bus and you ha=
ve
> > > > to preserve a *lot* of code alive in u-boot.
> > > >
> > > > I'll respond to your v1 patchset and we can discuss details there a=
s well.
> > > >
> > > > [0] https://lpc.events/event/17/contributions/1653/
> > >
> > > Thanks for the background and helping me understand the problem.
> > > Makes me wonder how things work in the PC world.
> > > U-boot being only ~1MB, can we not leave it all in memory and maybe
> > > just disable SPI access to Linux.

That would work, but you cant guarantee Linux wont enable the SPI flash.

> >
> > That's basically it, on x86 there's specific HW that's owned by
> > firmware, I don't know the exact low level details of how that works.
> >
> > I think x86 devices generally use eSPI for this HW [1] but I don't
> > know the low level details. The Arm SBSA (Server HW spec) and SBBR
> > (Server Base Boot Requirements) specs that are key to ServerReady may
> > go into some details too if you're curious.

On X86 the SPI flash is handled entirely by the firmware and SMM. You
can find more details here [0]

>
> Thanks,
> I think the firmware is still accessible to PCs as one could update the f=
irmware
> in Windows so Windows has access to that device.
>
> I had some try myself and found that setting a variable to memory backed =
storage
> is doable with SetVariable call but we want to store it in any
> non-volatile storage
> things really don't look good.
>
> To be able to write SetVariable to any device, the whole u-boot driver
> model would need
> to be kept in memory, might as well just keep the whole u-boot in
> memory at this point, it's anyway small.
> I don't have much knowledge on how to or pros and cons of doing this.

The major problem here is who owns the hardware. With the SPI flash
implementation as well as the RPMB implementation Linux owns that
flash.
For the RPMB we've introduced a mechanism so the kernel replaces the
runtime calls with internal functions [1].  I think we should come up
with a similar architecture for SPI. In any case we should keep in
mind that setting authenticated EFI variables should be forbidden on
the file/SPI backends since they are not really secure.

>
> >
> > BTW I plan to test your other patches on the Pinebook Pro.
> >
> > [1] https://www.totalphase.com/blog/2021/09/what-is-the-espi-protocol-a=
nd-how-does-it-improve-upon-lpc/
>
> Thanks, that would be helpful.
> I am particularly keen on the usb patch here
> https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.512334-1-=
i@shantur.com/
>
> Kind regards,
> Shantur

Regards
/Ilias
[0] https://www.intel.com/content/www/us/en/content-details/671120/a-tour-b=
eyond-bios-uefi-authenticated-variables-in-smm-with-edk-ii.html?wapkw=3Dvin=
cent%20zimmer
[1] https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima=
@linaro.org/

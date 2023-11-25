Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074E8C61D9D
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 06:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD235870B5;
	Sat, 25 Nov 2023 07:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T5bJZ0v8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E7C87116; Sat, 25 Nov 2023 07:19:08 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5808A86F80
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 07:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54af1daf6a9so2451627a12.1
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 22:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700893146; x=1701497946; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4aW8jQOHjyANzui5wLtvRZ+1u2em29DR8aMb8PYe6s=;
 b=T5bJZ0v83wFYzxQBhqIMCSKpB8cfJHjjC1giLhd6GPNARpM8fRxwa+i4L6FHsx0gl6
 OqSz/iOQBHgxuP6EhWz2xoWt/p2o2DiK7Aen2ORiX2qTLV2JlTPEnTHUsQguOV9flORp
 mHyMOwtBk70pgO1L/WkpkVTrsprTx/ERkwZF+6B6aKVFy5FMfuLL9bcw9VmY2a1YaGHk
 9F021ofio9O4U5GpRHNia9+aW6OtMDhsYiTPGOsyrYKBHa2obxk1nFyV1BLEaqkSpdQb
 wFEBW9pNkDPaYnkGii7gB0fY+kVY/ffcsywrTGRIODqw8oBn3KZR0uqJcGLf77B4JxPY
 urUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700893146; x=1701497946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4aW8jQOHjyANzui5wLtvRZ+1u2em29DR8aMb8PYe6s=;
 b=FWvUPophvHf7RnKe+tsT4q4qpL8mdF6/RMmS7lTTlnJ2f0Smxg7jhOz6nqwo9gakJg
 Pm6xw9xNboAUF01NAKWpblAJl1oGEFdIj5TRliOjqWx7Q5iikQtHZW6zMhftfA296Y9w
 CAWYFVzaPNMUOxyi5FHxNvFQzuq43cie3hb1CAwqswYprre7DcR65+tqiQOTzGaCOaEt
 JZdJ4k8r8G+JDE1Pn7znpyKrwou0i0dnfCs8l3R8kEWsz81SnvMev8amt9pAYLvn/FWP
 6yJfmOqjpaf5WwH+JjAPMIQTSb4CoSuF0JlrTgmCibxwbEa2WQUKogkrfdNF9MxGy3Tj
 fBxQ==
X-Gm-Message-State: AOJu0Yy+cSwkLoikJMuHrL8XkFQQLt+hF9ATfWorlJtOA7wtAu21SN7P
 L45Vt/UWsWjvxGcm5VYTeazmz7Ln1Hn/wdcgMEo=
X-Google-Smtp-Source: AGHT+IHqPTjc9znF8/TX88txbUki5flsV93ynDt/UKBgJ7TSqDlycESsxlJrYpKhxI60gIp5uKLQmu60NZ2L4sCw5KU=
X-Received: by 2002:aa7:da45:0:b0:54b:22a1:e704 with SMTP id
 w5-20020aa7da45000000b0054b22a1e704mr623688eds.18.1700893145602; Fri, 24 Nov
 2023 22:19:05 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
In-Reply-To: <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 25 Nov 2023 06:18:54 +0000
Message-ID: <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Shantur Rathore <i@shantur.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 takahiro.akashi@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Shantur,

On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Hi Ilias,
>
> On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Shantur
> >
> > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Heinrich,
> > >
> > > I am trying to work out how to enable the SetVariableRT service in
> > > U-Boot and came across your patch [1] which initially had the
> > > SetVariable RT service enabled in EFI but in the final patch this was
> > > removed.
> > > I am hoping to implement it on top of the SPI Flash EFI store [2] to
> > > be able to set Boot order and boot items from Linux the UEFI way.
> > >
> > > Can I pick your brain on why it was dropped in the patch?
> > > Is there any limitation in SetVariableRT service ?
> >
> > I recently had a talk about it in Plumbers [0]. Generally speaking, RT
> > + hardware owned by the kernel is a very weird combination since you
> > can't guarantee exclusive access to the flash or the bus and you have
> > to preserve a *lot* of code alive in u-boot.
> >
> > I'll respond to your v1 patchset and we can discuss details there as we=
ll.
> >
> > [0] https://lpc.events/event/17/contributions/1653/
>
> Thanks for the background and helping me understand the problem.
> Makes me wonder how things work in the PC world.
> U-boot being only ~1MB, can we not leave it all in memory and maybe
> just disable SPI access to Linux.

That's basically it, on x86 there's specific HW that's owned by
firmware, I don't know the exact low level details of how that works.

I think x86 devices generally use eSPI for this HW [1] but I don't
know the low level details. The Arm SBSA (Server HW spec) and SBBR
(Server Base Boot Requirements) specs that are key to ServerReady may
go into some details too if you're curious.

BTW I plan to test your other patches on the Pinebook Pro.

[1] https://www.totalphase.com/blog/2021/09/what-is-the-espi-protocol-and-h=
ow-does-it-improve-upon-lpc/

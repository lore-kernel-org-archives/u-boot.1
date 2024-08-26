Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C73C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2069C8895B;
	Mon, 26 Aug 2024 13:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rIcCmRIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A593788981; Mon, 26 Aug 2024 13:52:00 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B8888418
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2021c08b95cso39139825ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724673116; x=1725277916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mp7lAQTWWHaUtzfPh3E3PzavUkEzw6CvjZGwUKBP+/k=;
 b=rIcCmRINaszXUn2+eoFjh23yXB2Z30LStoktAsdqw9PlOo/h8aP9oLExpLEn89fnNn
 6Fmn7A/OQNtZbrsnP/kjVAnGgIYn23AmoDYHZvNJhnP+G3oXB2U036GwS8QB93hB0awT
 DyHCuLSvot6HRlWHjfBBSmOP2WwBOOc6VDc273JsuD9VA2skxi4VsWu5enGbi/S+gQM9
 wQOjEypsaJHWylgE0ELjbGRbOyc3fOr6PUal62nbDrzvaZZzdMfPaRhSAAwT+Kkd9HS+
 O1rcjzTCPmJzOFvOswZTkNFI4wg0/7AhqLh7yjDc43K+y7hxPGaex1wFXU2HO474dZbR
 ZGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724673116; x=1725277916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mp7lAQTWWHaUtzfPh3E3PzavUkEzw6CvjZGwUKBP+/k=;
 b=r+aKYs4TBjNQir5MlBNi5ambMG8VnULftVbKFPaOh798AxYJu7++zW5GMjURnpDd8d
 MV8gKZTdtb93xc8ipSbTymcdSB/TG5q/G0CVd111H68NajaIKPIUIee5G2snoRNF2kgd
 hEL/JLHCzzeiY4qnR29HaFu5YA1hDFNUXr0VwmNxYP7tp6AyNIRYRfjdVQF2vAFoDLHa
 DcBe/6UhcO38FdQ7ioiIeMTWqWNikhPRhC4L8Y6XsH3KPQvfqN530rTjm8gMgUWrgE0P
 hdElx/M12uDngKmBL3sc2XXqEgKhtJjBGyjNWn5CQmez/b/8pUlm22zKTpMJjle1089h
 VfFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKyfe54wHGpijQwr9AvNTKOcO54oYCNbMtcVCHUDYijh3WFLER9s2EY0OccT89CkwW00tnn6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9tl2Pu6s/BLzDZ2jvE5k1PS8SvmIvS3icaeph0odHHQ/ShgRW
 bqGZ9LWJs/BWcWC9GzuSkZ49ebJMxnvZ36d2iDg9Ybb+9a6Mxg/2t5101bxamJmWNLMuplcN2iK
 aviBAFdYN6gk0Ggz/ro8Xv5swsH2TYRUCmj5V8A==
X-Google-Smtp-Source: AGHT+IHprYCplOz1tPAI6SUTAeJMlXAH9dQKtQQRVLhDo3Ang33jUGkRDQJ0rPGoNcMwLwAiOTAlTO6oP9mOhUSfHgg=
X-Received: by 2002:a17:902:ec87:b0:1f9:e2c0:d962 with SMTP id
 d9443c01a7336-2037fe549e8mr212533105ad.31.1724673116318; Mon, 26 Aug 2024
 04:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-3-sjg@chromium.org>
 <CAC_iWj+6CqPCxN8jSNJSzGiprd+sAw25ooQRaAf=t=Sdio67=A@mail.gmail.com>
 <CAFLszThVpvHO8Jt2Mz1WB80=fDtYpzieo1eR4k2Jj=e37Gb87g@mail.gmail.com>
 <CAC_iWjJJFygaws2ciBDMT=JJ4yMzhQC41T_Tg1RKFvrxzRTTyw@mail.gmail.com>
 <CAFLszThsVcFwSe39geTeE=6bbJqK0bUT6kEYjULkOuNjO51e+Q@mail.gmail.com>
In-Reply-To: <CAFLszThsVcFwSe39geTeE=6bbJqK0bUT6kEYjULkOuNjO51e+Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 14:51:20 +0300
Message-ID: <CAC_iWjKPTv6Yzb6cQD=eJtC7Wm3bTC+cyaCUSmDXaWUySByoYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: Convert device_path allocation to use malloc()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Thu, 15 Aug 2024 at 23:35, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 14 Aug 2024 at 07:07, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon
> >
> > On Wed, 14 Aug 2024 at 15:40, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 14 Aug 2024 at 05:03, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 1 Aug 2024 at 20:36, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Currently this calls efi_alloc() which reserves a page for each
> > > > > allocation and this can overwrite memory that will be used for reading
> > > > > images.
> > > > >
> > > > > Switch the code to use malloc(), as with other parts of EFI, such as
> > > > > efi_add_protocol().
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > >
> > > > What about https://lore.kernel.org/u-boot/CAFLszTjLAKaYK_jLXJ7Z571L-QMtoiqE-oxHCRs186dZ2Qok5g@mail.gmail.com/
> > > > ?
> > >
> > > Yes, I reordered the patches in this series.
> >
> > You don't need to reorder them. As Heinrich already pointed out some
> > of these functions are used in EFI protocols. e.g
> > duplicate_device_path() requires the memory to be allocated by EFI
> > memory services, you can't just replace it with malloc.
>
> The pointers returned can be freed with EFI services. I don't see any
> problem here. All the tests pass and all the spec rules are followed,
> so far as I can tell.

Where exactly does that happen in the current patch?

efi_alloc() calls efi_allocate_pool() and when we need to free the
device path we are calling efi_free_pool()

/Ilias
>
> Bear in mind that I am changing the *implementation* of some memory
> routines, but not in a way that is visible to clients.
>
> I will send a v2 with things split up a bit more, so long as we
> remember that the EFI patches cannot be applied until the non-EFI
> patches land.
>
> Regards,
> Simon

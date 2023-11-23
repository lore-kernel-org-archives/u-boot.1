Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D58C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 11:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C00486DC3;
	Thu, 23 Nov 2023 12:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="zMUyp2MZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEB3C86D94; Thu, 23 Nov 2023 12:35:58 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F3786E24
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 12:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9fd0059a967so360198266b.1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700739356; x=1701344156;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBEp3qvgvln21EGbvmnicat0zLV4wSQ8Zdc8VZJfenc=;
 b=zMUyp2MZqA2Yx0O0ew6x74vZ0CnWaonkwNIQSvVFKO5vuBNWRQbJh+sQ//koqoXVIX
 b93zx360xPi3/bZ+LgahqPAH35+1OSuFzF3UdorUzd+SfTkLoAyGhafylglBT/4gaGf+
 IJNXVR316BL97AGhvCj/AgDnxupEXhBnafSwY8sFbR3tndt3yY1KX1CkVb/7UBWL4Iur
 zCnf4hOUjXpSoKyezbY1BTWrXH1YsEfx4tNbFH9cl3JZ0bhmltkNmlKkJMpq5q8LcueX
 wzrSgZ6vClyelyM//5y5jzUd+l66Rvh8SQcbEfisusYR8J1+zLNZEddi0qTRygnuzQ1l
 5Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739356; x=1701344156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBEp3qvgvln21EGbvmnicat0zLV4wSQ8Zdc8VZJfenc=;
 b=cBkkn1ytCA0KlHplK1e8K6norHxc0XBRokcbSyFDLOOG3SdvSxmGKZk9qEIHQp5Lmn
 QlwAHS+li4dsHe9nAclMvu36vAplDJCWD/t2KR4BQg7if/1W4BBvuVOtRUrGmzDNunEt
 F3iQLH76kdf9pDhVFY3S5ZDQjNjwQAlEecqfcw2+RAat91RU0McRUoNidpIQucDWS1tb
 f2en8OLf4xTKVZIe82hqQxKC7OqZsosjfV4XjH1Qp9mljLrJIKpHxtvxG0eLZCWkXSAC
 cHZMmUaPHEJDIul1IYHJvRKuFyDFOeF3dt98iTDqFyuRkisGIz46cjNS0KZ2VynoQ5A1
 jn7Q==
X-Gm-Message-State: AOJu0YwHLdtThOcpK4PHmImRoITXrz6Kd7vYLdjM7MLGBlkmE4wkM0Wo
 97aVP+M5juc+0l4h9x6So9ArJ5rtFxG3yQBnMAAcrA==
X-Google-Smtp-Source: AGHT+IGeRGLf7fv7SfUOxLAEPZQkEV09AbKAlGPCEcDv8GZywPXsuumwUqVRzAKpOHcL7b9Zf4JIJw==
X-Received: by 2002:a17:907:c008:b0:a01:d701:2f1d with SMTP id
 ss8-20020a170907c00800b00a01d7012f1dmr2734990ejc.14.1700739355985; 
 Thu, 23 Nov 2023 03:35:55 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 n18-20020a17090625d200b009fe1d575365sm678453ejb.55.2023.11.23.03.35.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:35:53 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-54a94e68fb1so1951639a12.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:35:52 -0800 (PST)
X-Received: by 2002:a17:906:6c88:b0:a04:7de1:4dea with SMTP id
 s8-20020a1709066c8800b00a047de14deamr1870497ejr.24.1700739351850; Thu, 23 Nov
 2023 03:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <CAHc5_t0k+Kv9PoZuLiYaMpJAFOmz7OB_Q-eyKTCoa9LToceMNg@mail.gmail.com>
 <CAPnjgZ0GrOTSFUaeUjhECS2Mm7=bs4+HYxLfmkPk_FkPdEeVXQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0GrOTSFUaeUjhECS2Mm7=bs4+HYxLfmkPk_FkPdEeVXQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 23 Nov 2023 11:35:40 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3yx3kjPG2qjmB46fbHoeqNOfuz6h_4W-W7TM4mU7psbA@mail.gmail.com>
Message-ID: <CAHc5_t3yx3kjPG2qjmB46fbHoeqNOfuz6h_4W-W7TM4mU7psbA@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] usb: Avoid unbinding devices in use by bootflows
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Simon,

On Tue, Nov 21, 2023 at 2:17=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Shantur,
>
> On Sun, 19 Nov 2023 at 15:47, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > On Sun, Nov 19, 2023 at 7:12=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > When a USB device is unbound, it causes any bootflows attached to it =
to
> > > be removed, via a call to bootdev_clear_bootflows() from
> > > bootdev_pre_unbind(). This obviously makes it impossible to boot the
> > > bootflow.
> > >
> > > However, when booting a bootflow that relies on USB, usb_stop() is
> > > called, which unbinds the device. At that point any information
> > > attached to the bootflow is dropped.
> > >
> > > This is quite risky since the contents of freed memory are not
> > > guaranteed to remain unchanged. Depending on what other options are
> > > done before boot, a hard-to-find bug may crop up.
> > >
> > > There is no need to unbind all the USB devices just to quiesce them.
> > > Add a new usb_pause() call which removes them but leaves them bound.
> > >
> >
> > I am no UEFI / bootloader expert and while trying to gather more info
> > on EFI ExitBootServies I came across this
> > https://github.com/tianocore-docs/edk2-UefiDriverWritersGuide/blob/mast=
er/7_driver_entry_point/77_adding_the_exit_boot_services_feature.md
> >
> > If I understand this correctly, EFI ( U-boot in this case) should be
> > halting all USB controllers like done in usb_stop()
> > Is my understanding correct?
>
> Yes, that is correct. The dm_remove_devices_flags() call should do
> that. The code in bootm_disable_interrupts() is a hangover from the
> pre-driver model days, I suspect.
>
> Perhaps we should also remove the eth_halt() and usb_pause() from
> bootm_disable_interrupts() ?
>

Apologies for delayed response.
In this case, I think we should remove eth_halt() and
usb_stop() (there is no usb_pause() ) from bootm_disable_interrupts().

No point stopping things twice.

Kind regards,
Shantur

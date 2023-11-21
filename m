Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBD3C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856CA87605;
	Tue, 21 Nov 2023 03:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fBH2N2j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26021875D1; Tue, 21 Nov 2023 03:17:44 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90C5875FC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5ca8c606bb7so15490387b3.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533057; x=1701137857; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuZFWzze5b0eMhqYV3aRHGjshQWLdD85467LLgEufSM=;
 b=fBH2N2j5pD8mFNmF70v1euFNs9VLm2ilWColaqln1aRrdAL/2kbe9BQKtR/M0QRyTL
 F3ugZ8SgeAEIzYkXIoqzZMAD6TOaOWuI9ThIB7QYhRT8SVv81fvtOPjxHLwFtcgNJ9d8
 koVpXIfnntNBvRAxBPaqwWb4uYc23pAUWhNPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533057; x=1701137857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuZFWzze5b0eMhqYV3aRHGjshQWLdD85467LLgEufSM=;
 b=l/tq6BvEMxEty20Frb873sAk2PDB6QFnhz2e2eTB0GZfAemFdV1OVVhyhDXhKNkVMm
 JdUR5g7OlnfFI8UBetQzLeOQR5mtm6IgEM5tcbaQ/IX4m6hlwOnbkpy5JjUaIKK7PERK
 a2OfXlWUdxAiKUdadKi4UZ0t07ThBtlJHvI3zVAnopp5Qkn65Bv7nYE1IIjypW/z5fFZ
 oVHuQ3NVOGBS3vnwrY7sFN0nXCJ/49SsNUj0Kmf6465woDV3C/2OsozyXs4lP0XzI5rV
 90VHvi58+7EueAUjgPmxTVwPQHY8UYiRz1VFLyrjYmjuCmALJGb/DgOeVpSzKLtQ4lii
 PxqQ==
X-Gm-Message-State: AOJu0YzhkQLzhe6mUtW3r0sUOgpkRTRthagsqLIe+HXJ3VmIyi0TJezb
 1QriJ4CLDO7gNXt65FO0RUYjZaaEPccFbGP/jIsihQ==
X-Google-Smtp-Source: AGHT+IEyPJsj14qqXaxHQUwC/i7b14+U41svj7JYc2zi9mrioVlgGmmWDqSIJKmFSSafsUQVEx3lN8v81Z0VI5i6Ccw=
X-Received: by 2002:a81:bd0e:0:b0:5cb:246a:736f with SMTP id
 b14-20020a81bd0e000000b005cb246a736fmr2973284ywi.38.1700533057403; Mon, 20
 Nov 2023 18:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <CAHc5_t0k+Kv9PoZuLiYaMpJAFOmz7OB_Q-eyKTCoa9LToceMNg@mail.gmail.com>
In-Reply-To: <CAHc5_t0k+Kv9PoZuLiYaMpJAFOmz7OB_Q-eyKTCoa9LToceMNg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:15:59 -0700
Message-ID: <CAPnjgZ0GrOTSFUaeUjhECS2Mm7=bs4+HYxLfmkPk_FkPdEeVXQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] usb: Avoid unbinding devices in use by bootflows
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur,

On Sun, 19 Nov 2023 at 15:47, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Sun, Nov 19, 2023 at 7:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > When a USB device is unbound, it causes any bootflows attached to it to
> > be removed, via a call to bootdev_clear_bootflows() from
> > bootdev_pre_unbind(). This obviously makes it impossible to boot the
> > bootflow.
> >
> > However, when booting a bootflow that relies on USB, usb_stop() is
> > called, which unbinds the device. At that point any information
> > attached to the bootflow is dropped.
> >
> > This is quite risky since the contents of freed memory are not
> > guaranteed to remain unchanged. Depending on what other options are
> > done before boot, a hard-to-find bug may crop up.
> >
> > There is no need to unbind all the USB devices just to quiesce them.
> > Add a new usb_pause() call which removes them but leaves them bound.
> >
>
> I am no UEFI / bootloader expert and while trying to gather more info
> on EFI ExitBootServies I came across this
> https://github.com/tianocore-docs/edk2-UefiDriverWritersGuide/blob/master=
/7_driver_entry_point/77_adding_the_exit_boot_services_feature.md
>
> If I understand this correctly, EFI ( U-boot in this case) should be
> halting all USB controllers like done in usb_stop()
> Is my understanding correct?

Yes, that is correct. The dm_remove_devices_flags() call should do
that. The code in bootm_disable_interrupts() is a hangover from the
pre-driver model days, I suspect.

Perhaps we should also remove the eth_halt() and usb_pause() from
bootm_disable_interrupts() ?

Regards,
Simon

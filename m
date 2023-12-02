Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517A3C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C4487702;
	Sat,  2 Dec 2023 19:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LSWgxdY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C77D87738; Sat,  2 Dec 2023 19:27:17 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0563987702
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5c8c26cf056so36378507b3.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541634; x=1702146434; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RRD0vRnKAZNmw1owudRng72yRe00TuOKgcTfiP5Q5c=;
 b=LSWgxdY7EV4z2+wGSlkkfZDb7eF2FihyiiV3gma/sxt56REvgVLBdhEFkjhuNcXNVZ
 IDBevr7gMw/472/olQy0pRj9Tx4PqybyU9qTkKqRUcpzeg3gUY2Lu5lnE2m981jhoyeT
 t9klcBHtIW/n7tVwsr9mTcSwmJ/F7UH7KKhKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541634; x=1702146434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RRD0vRnKAZNmw1owudRng72yRe00TuOKgcTfiP5Q5c=;
 b=K+yXpheQkX+p/xA9T/XaCW3iTmA4nxuE1kAADWABMo8ggVH8zQRWSjZj/b/xRQRPIS
 39jFs6zQIK9wDaLlWR8TaZsp5TNKQqIAXZJ7kJ5oDNQrPvWaTxaYzhBXmDPKyandiqZW
 lgSjgpvlFS64GnHCIqbIH4glyybHwv6EQ6V+43EC37WIjeT0cBJkUQqA/3BuLkkHnFKF
 Isu8nBHHsXuqzWO7E0F+o+RxjIeVm/CN9xRYMSL60xsxLOldcwbDVW4+bjD8eFKwhqIB
 /mioBH8zNv4CfpLAwvon8JHKERmYQsU9v93Mpq8aUToCZiksBNB1Yp9mS0dqLAJHdPx0
 QVxA==
X-Gm-Message-State: AOJu0Yyk5rrv1dbow4uNXfy4rDA5NuQztu+XcwQrQ7sVKLwrWG1gFpTv
 dfXjEOULdIalKkXx/Xq4pC120YH9zMNsVuk+6yJJZmEdtwZrMpSDxNDiaA==
X-Google-Smtp-Source: AGHT+IEznDoOYLT45b6jcS0cH3/Rldw3gLUxu2et3b+dT4lZLyb2fW4aUuhRmM2pu/N1oMEoWPvkqD5IVaKAol+P4p0=
X-Received: by 2002:a0d:d947:0:b0:5cc:61c7:b058 with SMTP id
 b68-20020a0dd947000000b005cc61c7b058mr1095991ywe.22.1701541633594; Sat, 02
 Dec 2023 10:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <CAHc5_t0k+Kv9PoZuLiYaMpJAFOmz7OB_Q-eyKTCoa9LToceMNg@mail.gmail.com>
 <CAPnjgZ0GrOTSFUaeUjhECS2Mm7=bs4+HYxLfmkPk_FkPdEeVXQ@mail.gmail.com>
 <CAHc5_t3yx3kjPG2qjmB46fbHoeqNOfuz6h_4W-W7TM4mU7psbA@mail.gmail.com>
In-Reply-To: <CAHc5_t3yx3kjPG2qjmB46fbHoeqNOfuz6h_4W-W7TM4mU7psbA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:26:39 -0700
Message-ID: <CAPnjgZ029jvsPom0+1=tufLQbAooc-h40Fv-Y9aGkrr8ae7wmA@mail.gmail.com>
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

On Thu, 23 Nov 2023 at 04:35, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Tue, Nov 21, 2023 at 2:17=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Shantur,
> >
> > On Sun, 19 Nov 2023 at 15:47, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Sun, Nov 19, 2023 at 7:12=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > When a USB device is unbound, it causes any bootflows attached to i=
t to
> > > > be removed, via a call to bootdev_clear_bootflows() from
> > > > bootdev_pre_unbind(). This obviously makes it impossible to boot th=
e
> > > > bootflow.
> > > >
> > > > However, when booting a bootflow that relies on USB, usb_stop() is
> > > > called, which unbinds the device. At that point any information
> > > > attached to the bootflow is dropped.
> > > >
> > > > This is quite risky since the contents of freed memory are not
> > > > guaranteed to remain unchanged. Depending on what other options are
> > > > done before boot, a hard-to-find bug may crop up.
> > > >
> > > > There is no need to unbind all the USB devices just to quiesce them=
.
> > > > Add a new usb_pause() call which removes them but leaves them bound=
.
> > > >
> > >
> > > I am no UEFI / bootloader expert and while trying to gather more info
> > > on EFI ExitBootServies I came across this
> > > https://github.com/tianocore-docs/edk2-UefiDriverWritersGuide/blob/ma=
ster/7_driver_entry_point/77_adding_the_exit_boot_services_feature.md
> > >
> > > If I understand this correctly, EFI ( U-boot in this case) should be
> > > halting all USB controllers like done in usb_stop()
> > > Is my understanding correct?
> >
> > Yes, that is correct. The dm_remove_devices_flags() call should do
> > that. The code in bootm_disable_interrupts() is a hangover from the
> > pre-driver model days, I suspect.
> >
> > Perhaps we should also remove the eth_halt() and usb_pause() from
> > bootm_disable_interrupts() ?
> >
>
> Apologies for delayed response.
> In this case, I think we should remove eth_halt() and
> usb_stop() (there is no usb_pause() ) from bootm_disable_interrupts().
>
> No point stopping things twice.

Yes, I agree. I will take a look.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05490C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1938700D;
	Wed, 20 Dec 2023 05:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WENf9CvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB8686FF4; Wed, 20 Dec 2023 05:11:34 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27FBC86E05
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-553a65b6ad4so1729230a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703045491; x=1703650291; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ltw8w40DhZusYGwcHiiBWUmpJulQAejvbNeAo3KKh+c=;
 b=WENf9CvHhVgYHG3afh03Nqr0kir6kaWlGe3DGhchdAFgF1GJ+ptn6hQGOu7EW7EeAH
 mcXD4txqo+fZlqKWXs+zuBtOmLsU/E6Owf1/9jxmq6ZYpC1Grun1RruEY75JkFFGaXjx
 j8gAUUGVMKNQbyJ6FEoUfBsmlHTKeY7dRfWo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703045491; x=1703650291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ltw8w40DhZusYGwcHiiBWUmpJulQAejvbNeAo3KKh+c=;
 b=SpyH8Mtp3pyJ9zMgwMp/zdmH2zycwzgpg/5NisEWffYSD/cYbTf0kgs5I/AbDCrkX+
 DVguVj3IWlB4X3T7jmJYmTWt0HY2zCpRPgAfmAbRK5bW/GMjugd+RYgBG77E8mXp9U7w
 7mt+QlQjidjTsiy9mbNYsZNAvIfmLgeXBLsHUOKHpDyzIo4gbzcjH5C5u6kWYlywZxSb
 bojHLZdkAdmfYCZg42zmOlHoNUxTcfOIKyeXbESLr+OcVLgiKHxyNIyJ5tY3OSFhwiGg
 UUHEKsk5v2oX5KLVoMTSyDW6udNCfPGhdVTizI8jEhbw0vxTVTyPrs7N/KFQhyKBB0fY
 QIdg==
X-Gm-Message-State: AOJu0YwX5HSINYdFYb+Ev5TE7nX/JloWpMSxmruAB8RLf5yApJ8Vc0Qr
 /OdligRXCSJeQEnS3BsvwyOO+Czo1BqGM3c7s5piQw==
X-Google-Smtp-Source: AGHT+IHnMYvog380u2VXPN7OaE7kdNT5zKgDCfHEPUQr8AdAXpbA+mKjsQ48/ZOYubqKIs0JIBMUJOpBw7N/hElsJQU=
X-Received: by 2002:a50:cdc7:0:b0:553:1681:2ad1 with SMTP id
 h7-20020a50cdc7000000b0055316812ad1mr4135173edj.32.1703045491291; Tue, 19 Dec
 2023 20:11:31 -0800 (PST)
MIME-Version: 1.0
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
In-Reply-To: <ZYH-K_UGat0yWMVH@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:11:10 -0700
Message-ID: <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
Subject: Re: Passing boot logs to Linux?
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

+Heinrich Schuchardt

On Tue, 19 Dec 2023 at 13:33, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi Bence,
>
> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Cs=C3=B3k=C3=A1s Bence wrote:
> > Hi!
> >
> > Is passing the U-Boot boot log to Linux supported yet? We are working
> > with a third-party solution, which works, but is a bit hacky, so I was
> > wondering if an official solution has been merged yet.
> >
> > I saw that there was an option CONFIG_CONSOLE_RECORD that saves
> > everything to a membuff, but I don't know if that can be exported to
> > Linux yet. And if not in the tree yet, would such a patch be welcome?
>
> To me this sounds very useful and definitely something we'd like to
> have in OpenWrt. So I'd volunteer to review and test your patches once
> they are ready.
>
> What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
> sequences during menu or count-down before boot, so we'd have to either
> introduce a dedicated log_printf() call and use that when ever we want
> the output to also become part of the log buffer or we could somehow
> filter the recorded console, eliminating all terminal control sequences.

I have been asking for this for a while. We need some sort of inline
function to enable ANSI output. Perhaps something like this?

#if CONFIG_IS_ENABLED(ANSI)
bool use_ansi(void);
#else
static inline bool use_ansi(void) { return false; }
#endif

bool use_ansi(void)
{
    return gd->flags & GD_FLG_ANSI;
}

>
>
> Cheers
>
>
> Daniel

Regards,
SImon

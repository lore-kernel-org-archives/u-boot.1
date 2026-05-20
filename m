Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E10CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA5A847E1;
	Wed, 20 May 2026 22:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j9pASE83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7487B847EF; Wed, 20 May 2026 22:43:19 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA05846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso11754238a12.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309796; cv=none;
 d=google.com; s=arc-20240605;
 b=js8qfYT9Fs+xXRGMaXCwikXl6ems7344W11VSmSbCx+X7+TEjAnYo34YWMax21W1UI
 bcYj/AZh/fgBvPOx2Fa47+odEuPT6+M6biQBu3Or676F4+ZA0tH9TFWWqC5mYT38mfKG
 uCRZvvaU5+yhk4xCFrJ1vBUu099S92cw4grXW2/Z71TgSQCe17Js3wzfkik21ibl1V39
 sNVgyz59DHBgx57qae1S/OwdnjBtXSrUM76tbD7hD3ASBolBt/NUI9jny1vXTk7gvl1H
 l+EzFQeXoIAO+joLgIwJbDI92MeXc2uQW/LjWO/q80kio6zkUa+iuNLlB7wyYV+pNICe
 mNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yCroq+zD+rWr1YGHhmPR+qC6fLJO8Dc3rrIfMsFdjdI=;
 fh=e9qjdlLDIVyYWjNs11mGr2XFbvvNcTJxiFT4RORLf6Y=;
 b=K6Hmvz9KdyEeX2TsJ7rTChLCF8aT4dm+TDDcQrbC50YwULkbFPg3q06f5gaZ72Ipao
 8mPlj3j6EK11Ihc0lL+l1LGPnapjRHjK0YMabwJlRvNY1JSL1YpSTR4sGxm9FuhVZDjN
 F3x2CkhjjzueBajqUsg06ag634KOU72UC+L+7182tZELzuCVmxZlehRnG+0S3mJkfNoX
 lnY0y7JtWX8rUeWCdwqER4A3h3SFAP5m3I5MbD/Qvd9DdkOVUGFjBz7URh/XsEmaMbpN
 ieNfy60ej8g6TYYM/Qf6nthjGqpTGSe64PAXWYFTeSED62XNAonmyXNgxl/KDUX73O8u
 gAyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309796; x=1779914596; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCroq+zD+rWr1YGHhmPR+qC6fLJO8Dc3rrIfMsFdjdI=;
 b=j9pASE83Su/70gS0oGzN9u37hOaU0wSMXRFl712HI5Opw8pa9S7rArHxJJVujDO+93
 Le8iXOAbI3C2TefLceAbua+qcbVO+XV1SReCXqcG4jQnznMfeqHK3v7bEzs/YURUQWae
 HLEyxCv1kIpVWXvUbtNdcK8M8bTXudKZGaf5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309796; x=1779914596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yCroq+zD+rWr1YGHhmPR+qC6fLJO8Dc3rrIfMsFdjdI=;
 b=li8iUH54SvF4wOHaN+GfFs3R2q3rOJNpi+ePj71OaMPyH6vqF0hWY5jBM0osmNZSEv
 hCM7qh1yVaS8juQiD/baTdLEhR22SZdGySgMCcAFm3TE1Km41Nqq58fOdVuHT+BkCYvh
 XR/wgND/2Fq9pLhzpInmqo9qwB+U/4tJXQYoji8ZBP5cttzDhpim8M0A0fkqMRLuYMi0
 tEH0errSZfv74bjWgx94JB21Sd/xquadZVgurJyQujIbt5mtdcX6wblEF7/IJie7icKx
 ft2+xflskvat2XhNyzvk6uD8cHMgmFvT5k3Ctq/RXiY8GLeptbKrtVUOCO+l/32HCTuj
 hMpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Mh8vEzj43GPTRDnrbtY311ofZAgaLPW5dbpzpsq0pqVtj1j4gNTdrTew7JmOuUHle/2/ryh0=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ5vYYXkPRQaQjUn+YLJZUQW800L8JZap3tzNXFhp9T2be8Ku1
 0VZwdEtrYDxPgYiyMqcKLcZ0Fbei1YqyI3fHJMDV2fOTUjah3QMRiwT3Qrs1IY0nEkqOGC9uev1
 E2OpQUxzpvZsP202p785sdioCqeXPUCNCuLPM18WQ
X-Gm-Gg: Acq92OFFHxKROAxbp1C5jRMll8dy5fmWXhTd0S0v7izVCetNaJ+fBy4+mh9miHJt1kZ
 ZvG8gDoLxog1/eF1aEoSjbAULxsUNJ9Ut929DdwBTeNDndSOYXDZ8/g3BitWo1PSCezvET9igpw
 Gm+s1Kb2IfLN60mwe2kJOl1BFLP3jNhwMGZEpgeeezXXwyvF3LWXCw7jcZgt+Zdankyw07u7bJt
 27vBnIxz+M01Qhgzm0mnAaXioLy+7HHMgCfGV+cW7d2EBi5BPQXSuPEbT8eeqTf/47T8LjSe3ID
 usA1GA==
X-Received: by 2002:a17:907:c28a:b0:bc3:c6f5:1d47 with SMTP id
 a640c23a62f3a-bd5177ba08fmr1621754866b.11.1779309796277; Wed, 20 May 2026
 13:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
 <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
In-Reply-To: <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:43:03 -0500
X-Gm-Features: AVHnY4KxUuoMuPDKGg7vWLJYUrYTbZRWdcfOhi_0I4ZpXHgKqZxS1wr9bxIyONg
Message-ID: <CAFLszTgjh2P2JDMOJTUBPxyi8+H55BrdDY7Y1k9bot_hdn255g@mail.gmail.com>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, sumit.garg@kernel.org
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

Hi Ricardo,

On Wed, 20 May 2026 at 11:33, Ricardo de Araujo (Salveti)
<ricardo.salveti@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 12:08=E2=80=AFPM Casey Connolly
> <casey.connolly@linaro.org> wrote:
> > On 18/05/2026 21:15, Ricardo de Araujo (Salveti) wrote:
> > > On Mon, May 18, 2026 at 4:59=E2=80=AFAM Casey Connolly
> > > <casey.connolly@linaro.org> wrote:
> > >>
> > >> Hi Ricardo,
> > >>
> > >> On 14/05/2026 22:57, Ricardo Salveti wrote:
> > >>> The Qualcomm default environment currently boots only with
> > >>> 'bootefi bootmgr'. This bypasses the standard boot flow used to
> > >>> discover extlinux and script boot entries, which are commonly used
> > >>> for FIT-based Linux boots.
> > >>
> > >> We intentionally don't support these alternative boot methods upstre=
am
> > >> as they aren't standardised or supported by typical distros. There a=
re
> > >> also plenty of inconsistencies in Linux userspace depending on if SM=
BIOS
> > >> (DMI data) is provide or not as well as EFI runtime services.
> > >>
> > >> Could you explain a bit more why you want to support extlinux and cu=
stom
> > >> scripts?
> > >
> > > My main use case is for the target to automatically find and load fit
> > > images by default (based on the config used), which is a quite common
> > > use case for embedded distributions and products (see that it is also
> > > enabled by default on several other platforms in u-boot).
> >
> > That's understandable, and yeah I'm aware that embedded distros have an=
d
> > continue to use this approach. I'm kinda wary of (and should have
> > disabled) bootflow, the code for it is a challenge to understand and it
> > has caused me headaches in the past. But aside from that, the default
> > environments we ship upstream are the ones that are actively maintained
> > and used, for qcom that's EFI.
> >
> > I'd love it if we /did/ actually directly have users of upstream U-Boot=
,
> > but as it stands today anyone shipping it will be making some
> > customisations to it.
>
> We expect to have meta-qcom and u-boot upstream supporting both FIT
> and EFI-based boots, the end user can decide which one to use, and
> that is why bootflow is useful here.
>
> I agree that EFI is more suitable for generic distributions, but we
> expect that some embedded products will leverage FIT directly, and
> disable EFI entirely (e.g. faster boot, reduced complexity, etc).
>
> Since FIT is already widely known and used in u-boot, I think it is
> good to also support it by default here.
>
> > In any case, the other reason I'm wary to use any other boot methods by
> > default is because as I mentioned we don't support them upstream, and I
> > don't want to have to care if a change breaks FIT booting (for example)=
.
>
> I don't think that there is anything blocking us to support it
> directly from upstream, and I expect that pure upstream should be
> fully functional quite soon on multiple targets (some even including
> SPL support).

This is great to hear - I certainly welcome Qualcomm's U-Boot efforts!

>
> > > As u-boot provides support for bootflow, supporting several mechanism=
s
> > > which are probed at runtime (including EFI boot), I believe it is a
> > > better default as it supports a wider range of use cases.
> >
> > In general supporting more usecases is better, but when it's something
> > like how to boot the OS I do think it's much better to push folks
> > towards standardising and EFI is that standard.
> >
> > Just because products and embedded distros today use other boot methods
> > doesn't necessarily mean it's a good thing and to me at least it's clea=
r
> > that we should just switch to EFI...
> >
> > There's no reason not to adopt something like UKI, or even to write an
> > EFI app that implements FIT booting.... But yeah, it's easy enough to
> > carry a patch or point to a custom .env file if need-be.
>
> That would be up to the user I would say, and FIT is widely used in
> u-boot on other targets. From the u-boot side I believe both should be
> supported, I don't think FIT support will be removed from u-boot.

Regards,
Simon

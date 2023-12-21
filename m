Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89AAC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E409877E5;
	Thu, 21 Dec 2023 10:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fh3PvMVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1A887854; Thu, 21 Dec 2023 10:34:18 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F33C876AE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a1915034144so66495266b.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703151255; x=1703756055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTNrlPh1ofPwgOurHGaBA4Ppnwg+3fAP9nz2fPKkNUE=;
 b=Fh3PvMVW5MvB/dllXsIFflETv4NLaXE8KUOiXVm19qBywJKjDng0Dwl9X/mJ2yopwI
 gCCSIPqKJHePIscZu6ykrNF4MOEtKmLF2jqeOlF0RrKaYX7EXjn0/SMd12WGa3lI/80z
 s4ZgJcfKgXhJGXhULfcIrBHNZdrajxtON/kc8Pzf+lxZFfLxMuQiHy5iiqrPanyLFkQU
 hbj3JKW1RkM8ehM9+9l6ih6oQ0svrYhayj0uUgtYiBDO9BLJFCy2e2uCjGeuhAbvOUZ+
 fRr8SPClHj7X9GdTFnrrf0WX2sno4QC2oN/+nJx36K2IXDz4lHKTuS6Nhv3cVjpZ7/CL
 cppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703151255; x=1703756055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTNrlPh1ofPwgOurHGaBA4Ppnwg+3fAP9nz2fPKkNUE=;
 b=A3++92ESH/mqJQAIbrjxI/IGRwYwLxc2N1fIZrd/S9vT8jHkFAQkFRSRZrnvVFwsCf
 AYKbqI2m1Xp+orShNuYanFgoFXDwzTC+nbxRrwlvKUEq7pDvU9b8XtGB9TJ5jdp5JV1X
 eJ/Ky6fCbOEMv4/t3Tn9CGEyhgDh1aXji3WnDH0D6AZEG+hXADdyTC+hS11U6N+GoBVg
 6Li89Pv291PY+hTAjhKU95Ex9+1wdLZcSNKLuS+7pdxv6lcEUrEbEOvaWdzJcGjGMIKO
 pnTV5cgG3mjcxyx39MLmg4l+0NHD4g+XyWTQU/dDqzuCl4NUM/K5/ceNOb+CfXlwTDRw
 rXqg==
X-Gm-Message-State: AOJu0YxR9n16lUCkK739lv/LytYBqFuj27lTOC6uJlGQO1etXuNt5OGw
 6YfpQuxXFeaACxfp2X41xUA0/EpPcYv1wDC1Zhs=
X-Google-Smtp-Source: AGHT+IFUUG+ZWizZElJOif+rDJw4MsAwV3lWuKrzRx+rZj244QTg7BzBbPNE0a/Lr8QDKY2WHWAWyIrpzTKfd2S4H+Q=
X-Received: by 2002:a17:906:6a15:b0:a23:4e3f:a2fd with SMTP id
 qw21-20020a1709066a1500b00a234e3fa2fdmr4036634ejc.5.1703151255437; Thu, 21
 Dec 2023 01:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
 <20231214131139.GY2513409@bill-the-cat>
 <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 21 Dec 2023 09:34:04 +0000
Message-ID: <CALeDE9Mi73Fikask=4ve9_B=T=hXqkUOZWTVAeP_oACFL0wBxw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

On Sat, Dec 16, 2023 at 6:57=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tom,
>
> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 08:19:11PM -0700, Simon Glass wrote:
> >
> > [snip]
> > > The new DT nodes / SMBIOS binding [1] allows for the correct
> > > information to be provided, though.
> > [snip]
> > > [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bind=
ings/sysinfo/smbios.txt
> >
> > I think the only feedback I can give on your message here is to please
> > go upstream that binding, and then we can see what to do afterwards.
>
> I am still tearing my hair out waiting for the reserved-memory and
> binman patches to be accepted. Every few weeks there is another
> comment, but no action. Rob seems to be the only one engaged.
>
> Perhaps I should do a conference talk about what is wrong with DT?
> This is my experience so far:
>
> - there is no urgency to apply anything
> - no one wins acclaim for applying a patch
> - everyone complains later if a patch is applied that they didn't agree w=
ith
> - people chime in wanting to understand the use case, but don't/can't/won=
't
> - any sort of expressed doubt results in delay
> - maintainers hope that the submitter will lose interest and go away
> - not enough people add review tags, even if they look at it
>    ... because they are worried about looking bad to others on the ML

You miss this:
* Patch submitter ignores questions, feedback, concerns from
maintainers to the point that people mute the thread

> I would be happy to discuss how to improve matters, but that is what I se=
e.
>
> Anyway, the lowest-hanging fruit at present is the U-Boot /options
> stuff. I was hoping someone else would step up to clean it up. There
> should be no impediment.
>
> Regards,
> Simon

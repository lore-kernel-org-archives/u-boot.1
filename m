Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7BAD29C28
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 13:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A5E839D5;
	Mon, 19 Jan 2026 14:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H524av1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E729D839DF; Mon, 19 Jan 2026 14:28:03 +0100 (CET)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DAB8397A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 14:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-12448c4d404so3060756c88.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 05:28:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768829279; cv=none;
 d=google.com; s=arc-20240605;
 b=JtlebH62nm1Qs3V78SOd8AnX0jRli5/uQTET2dDHOdX57rNDyLhBYBkkAPaE8UfAJO
 t4LJL/XrDo2amnGBByKHRRZ/VYQwW9E4mPw0s7VjbhNJtMmm1yKnsTuZWIEH7h3xG5Wk
 37FByjWTt/n3b8GPiyyJmwxQgwpi4qW+0zFAnd81/woCVnGC3rw/JGfOCuPLbXz03DEv
 SUW00zxSgdUR2PLgBeDZd4T+D6pTpum3Du3biO9pghDnB+lh+lBD+/+bjfkd0FTDRcBG
 EOLIwVfHKFLNJxcItFXbwiDtiyt627cUSjtN2Y+wl5n4cYTqTcVx+V/DrPrhGLL0nbiJ
 IK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nsx0D6a6qt6QYiArfbbL/too+E7M0oHc/HlEW78mnxc=;
 fh=eLU6fAMXDZgIhiZ+7cD8WOUC2l7zZ9JAIIfg0puxGq8=;
 b=LeupbdH592G6CwryxTL6kGEq6P0FcyEsy75Lg8S8g1l7tZlsrASia7GC4KyjT3UVYg
 64Yw9ge1Z/JLl4pJH2LMQQL0VnDMr50VuliA0V+YBBe/uCXzjyEosWqADFlJtjZ8M9hf
 SO3mG0T0n5gZFW4IoXxFwffvUd1XqDOIwwGrBNApDW24Xy2RFBJr2cCe9gItPERQ1dcK
 Ftfv8auE8K+0Bo8m3ea+jvb7xZ1NTg0wDbdb9fUrWMXqvg6yMF/l2iaSKmEmUkGk15OL
 cjZLNSnVUv8y2Qj1C9TvR6GYlSaYZe6pKvYiXnh4kPvPna5SxlVZjpLO5Bq35jfdRju6
 2UKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768829279; x=1769434079;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsx0D6a6qt6QYiArfbbL/too+E7M0oHc/HlEW78mnxc=;
 b=H524av1Pa6jlhymEU6g25VrtAx16FF3eBTVwHZ52OaxDqIN3p0g9G64JIw5csAasdb
 /Fg4LebjpCPUxbac8XWEtLkmYvJXnCOU+iR1NdkDY02oWNlYQugVB3dTTJTbGSEr7xqB
 g9npbEXcx/pJTGmt6KH8LtjdkhD/WJXzZBFX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768829279; x=1769434079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nsx0D6a6qt6QYiArfbbL/too+E7M0oHc/HlEW78mnxc=;
 b=EVJ8I4SkEzNw11WdiSqEeqS1Mua4hTAa1Ckm7dxH63rsIhS8ee6WMpugZbk02q5c0B
 C3jNbW8EuJwY/BqpwsYj9OiP0ENvZ0OPfdzbqBSapGIlRMB/yxGsVWAqF26cOr5NPv6p
 OZHtGjGMBVR1aFTW2ovk1tUaGlgCNP8H/x8+zYfeQruDjw3ldNWsVgrqLuqR98XFaXEh
 NpzhHwMGwcjESX1A76+bI0mHiMauhNpV1C586Z7Rf+9weNfFgy0wpoBRjNd8iEeitsT0
 WD2VqokEKZPktMDlzTNEMT/ISHVBJfWox0DIDP0wg2G5rrg8mUyHA+3Vjt4+qOpQXFVL
 st6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWZ7mEswOhKX8nX5wd4jeACrOvWYDhCMSCLkDiXkuj8FMTb9TrBR/GadD/Njm9EciTeF3KZgo=@lists.denx.de
X-Gm-Message-State: AOJu0YyYKSlgw/HusF3U0lTPk7moTBK1lMMdfVBG5zc/wllhw8fDaVgi
 UaMZEe391qh+pNP6i1wiuYwbk/f8W0RsScEpOJi9Vyj3HeNQq/Dyw3TdDbAIUwLoomnmS55w1dx
 mNQg7cesa1oXUE+mfvfcaR19zMvPAzr8ApzG/oCE77w==
X-Gm-Gg: AY/fxX6McqBUfVKJYDVnZZMwXpPaYIshf9MS9j7bQNrIC8s/LkUsI3FZAWHw8Z6A55/
 nLslW7s9WF6JFg0IRslrrwnxs2rwJ9sbmpExabTtxB36vaQ8JtSOFzp2MKb5sitQjPqAbeUrbQr
 RYKyst/4f5jbTOIuC//lUI9cWsaAhmtb/RCWGeWSVRvrCeKNf4jfgzWw1RuhZ+XXwSsT7ojJJKa
 LfVDNsevrE8sodJ43h9Aq2c3AQIXIGtk2x074tTpj/yLddR8nx0GaHhpjKYiJy1iLTO247Dm3E6
 R2z/38YkAOulvJB0i4hkqp6eInU=
X-Received: by 2002:a05:7022:698b:b0:123:361e:e87c with SMTP id
 a92af1059eb24-1244a72ded2mr10110664c88.11.1768829279201; Mon, 19 Jan 2026
 05:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
 <20251028091256.600992-3-richard.genoud@bootlin.com>
 <2aa84436-8a19-48d0-b2a3-c4b40102a81a@arm.com>
 <2a1824b5-e514-4eb0-8e08-2d4307f86c44@bootlin.com>
 <CAOf5uwkHyKJ_x74v4uXaexWMvM0e=0UXtxhCwaLOa5p7NxLLMw@mail.gmail.com>
 <ddb336ba-61eb-4d7c-b70c-9c2b050dec24@arm.com>
In-Reply-To: <ddb336ba-61eb-4d7c-b70c-9c2b050dec24@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 19 Jan 2026 14:27:47 +0100
X-Gm-Features: AZwV_QjQOfHvwLHNH5TTRo9u2MFQ_XCNMEtCXt48D9dMUra9Y1ydcKzwxcEKoQg
Message-ID: <CAOf5uwkavvsb-yaJDMKY=QnZmqc7Jf0v7Jq3U8Nv0tsVs573fA@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] mtd: rawnand: sunxi_spl: fix pointer from
 integer without a cast
To: Andre Przywara <andre.przywara@arm.com>
Cc: Richard GENOUD <richard.genoud@bootlin.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Hans de Goede <hdegoede@redhat.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>, Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Andre

On Mon, Jan 19, 2026 at 2:22=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi Michael,
>
> On 19/01/2026 13:14, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Mon, Jan 19, 2026 at 2:13=E2=80=AFPM Richard GENOUD
> > <richard.genoud@bootlin.com> wrote:
> >>
> >> Hi,
> >> Le 19/01/2026 =C3=A0 12:12, Andre Przywara a =C3=A9crit :
>
> ....
>
> >>>
> >>> The rest looks fine, thanks for adding that function.
> >> Indeed, I can drop it and add a comment to warn future users in this d=
river.
> >>
> >> @Michael, do you want me to do a v3, or just apply this v2 and I'll se=
nd
> >> a fix? (or you just remove those lines when you apply the patch?)
> >>
> >
> > No, I will do by myself, I will send a new pull request by today
>
> So are you sure that the series is really ready for merging? I think you
> mentioned you wanted to apply the patches that have been reviewed, by I
> see only the first half of them having tags. I was about to have a look
> at the rest, but got tied up lately in other things, so didn't find time
> yet.
>
> So are you sure that the patches are fine, given that nobody has looked
> at most of them? Or did you do a review, just didn't reply on the list?
>

I have seen most of them already, and the first part was reviewed by
you, the second
bunch are preparation changes with no functional changes. The last 4
patches add the new
controller support. I have no pressure to merge them out and if you
want to review all the others
it's not a problem. There were wrong assignments and I can start to
take a look at yesterday and today.

Michael

> Cheers,
> Andre
>
>
> >
> > Michael
> >

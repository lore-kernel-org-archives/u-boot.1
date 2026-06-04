Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62D8CD6E74
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472598486D;
	Thu,  4 Jun 2026 19:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="xBnj22Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0873384948; Thu,  4 Jun 2026 19:35:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A9A800AE
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68c32f3c6d6so1063876a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780594542; cv=none;
 d=google.com; s=arc-20240605;
 b=bAfe3ERJpjVnZhuEDtiVclP1yAtS1in6XHvA+DnsSbEPjsxAhJ4R1GLU8wD8w/ndCC
 pi5+hDezwhUZRmG1xeKPGO2xo6OQG+eFZeFnnnB6nX6WLUoTNprExE6lscUe9lBu72pZ
 zto3G85Ng8y9CYMppRJ9+PKktEB3SnLC7jF0OhgrIr2YpNNopLZiff4/HWaR6j5qvTBO
 9QEQzmqTczBUz5fDbwk1OfZjKoXvw+5dWh5vWonS4U8f9LpqC37aOfQNYOBVkqZAB2bz
 FnPkRpBVCV2bovumRrK/UZIrppQ54OzY2HmvdQEKGACx1n2rFosb7jEc8DQW0yU8HzE/
 cc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b1FUF5bfHoyW4YEip9en68E+GwbV+wrqjIkdj13PbdY=;
 fh=CizVzkhoIphOMTLPi+ZX9XSsICPt2R1OOdm20ifr28U=;
 b=FQ8jIViNsL1SssapF8uFZZZ/r8SF2yppzOGB48pjtGrTLRUlbI8PHQ2wl3dxXtMANg
 tQDecj/b27UI8y/JaVBaSIp3OS1gp7oGQ5ZERh9Eb6tGwfDishjbfJo7p6/cyONJr0S1
 4aDQbiTworoCgoYJuGD//SaMrv5DyoVFNMYJsWVVlGyBmq8uoWiyp/SfcUfSFV14uZpa
 H+Drnpx1f2d0kyBZKbbxeJPL7eB0X+UbUvzDkueIiuxdiiGoCk9mzgXC1LA9+Sby8RA2
 HyzrkJnfR+TxbsnViGifBJwahyHiqQQU+jYrYFR/M4L7vizPlA3748Ek5pZ4UcoNbxFD
 xX7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780594542; x=1781199342; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1FUF5bfHoyW4YEip9en68E+GwbV+wrqjIkdj13PbdY=;
 b=xBnj22BgyzYnoKw28NlDp2qQ8i2oS3arTLAv+EDemyq0S421JfTum6g3517kB9JhcO
 2seF8pJek+Ov2egnvMKvlxc8nFqDVE1Zse1vQVCCtTJN3+yVjNZEMMNxJdwwndzagSjq
 WREB9M9aNMgxbiFu6y6VYUH0qPgFzntDp+kAmeCzK3RPYpiuxTSO/wU6c7bhZgWnedec
 sbCtbLa2lYgZPTZZ2hJDwmzdQATl4ZrPQ0MpbrDJaaOU411qZT0Cu1InOyDYL08b/zBQ
 reXPF33lsJ4xuoyIkC46l/QMexS4XyEpjWC2n5vL5tmH5K15SlUDYw7GajCYjL+/E22s
 jVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780594542; x=1781199342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b1FUF5bfHoyW4YEip9en68E+GwbV+wrqjIkdj13PbdY=;
 b=dN5KUxABqhObBrU129WmORRJSY1zhihtnUYuNhkl5ogbt5yMGY+1u0tkiJzzcEdQqt
 i4S8FFSbMi4fpIN0KnDbsZpZiYiYzx8Hlv2FZttnBXmFwaHIosK/XcbtTdx0E07X94lr
 p1ad++9WSQrtBNaa4VJvJEmWwJcIv6UKK6tIZ2bzz0dzbgtqyR/TI7mpNth7viBx6GcF
 ejUedAmaVgvTVLi5wbhzBb0gObYjycTEpG3tGElzre/VzBunkAdpAyj7EeIsVuTLt+x+
 E2E/e2oGwLdSGQnaO6eOxQZ4d8WfLsEGA6QnfcsWvFRg8rjHWhZQF5Xx/Wh3A3kPiYSy
 Hqmw==
X-Gm-Message-State: AOJu0Yx3IUlDcBVvLw1krjcvVLmwhyUGbjxWbTrYQC0aGqfDblz/LvH0
 nQ6Qg+bm29NXI44y5YhQQZY4nUPhjzjxF4h5eMPX+nhvQ9zm3veEXaVCJz6dvnJrJA3JHR8SlOi
 Jnv07+a309xBV2BP9U46s988LyIVl+xqJAjDl4r5kow==
X-Gm-Gg: Acq92OEvpQJZbMWtr3OgN3jRKBFoK0Xg9ZE2yUcA91TP4OhNjW2xGQxpib8DNOmIp3m
 lvLfQA2vbEQSq+KrOzaaj5D4jPoyRrWV+4iNRCRI5ivgDozWitoDTKiKP5difsiVYvAX0kPHr0P
 pbWL4xHlFZLOVY7JBsyaJWjFwsVCWxDx5cLzli1DspRyZmtbZiNbzoOiw3Wue7BIrnmhS/MHuU3
 ucMoT+8Elf40ixxWVA8nFHXikyks5bPLKZY2+8wd4zXc5XMje69jbanHBuAnj46d+mLMhNuqLzH
 ACOl/rU2b2Fz2P3XTaAizoh92GZFi8BvQvBiSbguIFc5T+BZ6r2eCevUoJ2s
X-Received: by 2002:a17:907:971b:b0:bcc:3dd8:58da with SMTP id
 a640c23a62f3a-bf0ae70e2c5mr453178166b.27.1780594542293; Thu, 04 Jun 2026
 10:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604160547.GR627328@bill-the-cat>
 <CAKTNdwEt+CpeN8JssJr_JFowXi8yt8QPFg77=OKG0BeOri43MQ@mail.gmail.com>
 <20260604172115.GV627328@bill-the-cat>
In-Reply-To: <20260604172115.GV627328@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 4 Jun 2026 21:35:32 +0400
X-Gm-Features: AVHnY4LxUDGwkXxffY8f6J6g4MX3HVRLxuXATdpcD1WVRFWacFhuwuk0Zg6dISI
Message-ID: <CAKTNdwFaJODWtr4S15L8JVwzs7XXZ9VPD1D7L5r94o44bnyQXQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] pxe_utils: small fixups, implement BLS type 1 boot on
 top of them
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Thu, Jun 4, 2026 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 04, 2026 at 09:16:58PM +0400, Alexey Charkov wrote:
> > On Thu, Jun 4, 2026 at 8:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Thu, Jun 04, 2026 at 07:31:05PM +0400, Alexey Charkov wrote:
> > >
> > > > Add support for the Boot Loader Specification (BLS) type 1 boot ent=
ries,
> > > > as generated by default by systemd's kernel-install when loader=3Db=
ls.
> > > >
> > > > Given that the format of BLS entries is pretty much the same as PXE=
linux,
> > > > reuse the existing library for the parsing logic.
> > > >
> > > > BLS type 2 entries are out of scope, as they are effectively just E=
FI
> > > > applications and should be booted as such.
> > > >
> > > > This implementation is also only allowing a single top-sorting entr=
y to
> > > > boot, as the standard boot infrastruture currently doesn't support
> > > > multiple entries per partition-bootmeth tuple. I have a proposed ex=
tension
> > > > to enable that and will post it separately as RFC - that enables th=
e use
> > > > of `bootflow menu` to select the kernel to boot without jumping thr=
ough
> > > > several menus with different behavior as is currently required with
> > > > extlinux.conf.
> > > >
> > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > >
> > > This is good to see, thanks for posting it. One concern I have is tha=
t
> > > out of 1529 platforms, this would be enabled on 1392 of them. And the
> > > size growth is around 1.5 kilobytes. Is there some smaller percentage=
 of
> > > platforms this should be "default y" for ? Or is the expectation that
> > > something like Debian will be configuring for this moving forward, so
> > > yes even something like PowerPC platforms be using this? Thanks!
> >
> > Well this is the config format that systemd's kernel-install produces
> > out of the box, and it doesn't require EFI support unlike UKI (a.k.a.
> > BLS type 2). So one could argue that any system shipping with systemd
> > benefits directly. In my view, that makes it more accessible for end
> > users than e.g. bootmeth_extlinux, which is also "default y" but I
> > could only find a suitable config generator for it with device tree
> > support in Debian (not in Fedora, nor in Gentoo out of my extremely
> > representative sample of N=3D3 distros).
> >
> > Happy to make it conditional on whatever platforms find this helpful
> > though, or drop "default y" altogether. I personally only care about
> > ARM, and Rockchip in particular :)
>
> Right. What I'm asking is, do you know how many distros are planning to
> adopt BLS type 1 support by default? And since you're on Rockchip, why
> not just use BLS type 2?

I've only seen Fedora use it by default, but I'm not that much of a
distro connoisseur. There might be more, or there might not.

BLS type 2 didn't work for me last time I tried it because it
seemingly wanted to bake the DTB into the UKI and couldn't handle DT
overlays, which made booting different boards with the same kernel
binary a pain. BLS type 1 didn't have those issues, and a concise
plaintext config has its (subjective) appeal over
yet-another-packed-binary-format.

Best regards,
Alexey

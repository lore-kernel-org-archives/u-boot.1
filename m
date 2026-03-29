Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F97FF3D603
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 13:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621ED83D71;
	Sun, 29 Mar 2026 15:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GlsUX8/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B901784035; Sun, 29 Mar 2026 15:03:21 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C115483B8F
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 15:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66bb66db39dso657078a12.0
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 06:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774789399; cv=none;
 d=google.com; s=arc-20240605;
 b=AqOJAsapxPl2TkxFs3zbyy3IfiZfXzIYqO6jduh3VzAHyiRMObRWq7CVjF5QXEpin7
 M9ClhFpNfmz1yhqhsdBj0ZG4E+DHpP/P9uluOXmhLEoe7cY6ntO+Jo1rTq11PtpujKV8
 KlORAD1BcUInxOMnBNlUk3guZ4y6v4UtLX8tAL27SDEiarf2hTkzFt/zSfeEYkUyF2Xx
 wgSTbjZ6iPKgDDBVoyEMOeKMzEhKgWcxo4hTcdZmLWEIYnWWZ2rkUYbVsvzUvbTxDANe
 lfer4DmICCMHycwhgPTtGHy1t3lMf2Tx905OiM2UoC3/J8kcvYibdcjCqPAB4vfRptKQ
 yMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e5l8OHoIDrW8lfbxJNZxXgKoLSwYpVHPnaJSMzbRaic=;
 fh=dHEcrMAERhhNzY5aj3MUyWjPa8kEgAeM6e3wb4xEjZA=;
 b=CSXspNI8trKZoZf38rNtjAO4m9YeULw2Ot+ny0P/isZ5WxM/wDl6hcorIn/7zJlVW5
 iNQq6S+wMIwinuWiJZq2WBIeh/Zb7N/pV/gDEQCo2tpM7PUDVJ/t7bJKGoVez74RfkEG
 asSXee0ADZsdXdhsrgbRwcCWB7gIhMKx/vSfw2aPw/B0NLJWPlT6sb1Acv+t/O8xqPtZ
 pt+NEPPTUYk7ShNo5O73qyDz5A12KT63CTiVJe9IRhegEwbqatSht3XEbLs5LCmmGAJ5
 OlXnK9ob/WNisg7QlBzgoIiRkIhKTCDs9Em4gltQrEOZ6407PsRN+IPYUj2zFHT/fhDF
 Dxaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774789399; x=1775394199; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5l8OHoIDrW8lfbxJNZxXgKoLSwYpVHPnaJSMzbRaic=;
 b=GlsUX8/16soOnMLNsdAGkxVsfaOFmv2tGL6AycAT+AwUKFWzdx+O3lb8UXV9oW8skU
 5Ccy82k7ukjhR0ydf5bIryhV9lEPI56cL8HNL6t+nMzanuqykRZfYYgZWS7ueuIxwSBV
 rqlO6eV+8nVFzQCqS56sOCMVv0X+/sOQZj6nOzkG9pY9p4X0KewZZ7dbIlR8e1d7YJPK
 FF/kp43X1eB0rGCkD4/0hzcYYhqRiBca+qtR9mTwYrDkm0Ncz3RBX9is56eOQQwSQoEs
 t/TAVUD/h+BTmby8H1DJ6gz2iX/TngZrpl5eli09AZsxHbNns071+KomVHAmPYMJapAV
 rsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774789399; x=1775394199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e5l8OHoIDrW8lfbxJNZxXgKoLSwYpVHPnaJSMzbRaic=;
 b=oRNE8Dz7X6iu6Y/BSusQqb7w/MldtlPaLxIYxVvfSsprm+hCfy0sIL5ZSSVu0LXsDj
 StwiCzhHwzDwjqjm4ZphVhHIPpvTCB9ccBPMQQsWsCmh/HHrNeBm1E/AWLPrQx1Co9Vb
 hH5iDZ/KPY/M+3YhwiYrsE1Os22fffoOrSdmarLzm8sZPmtUkyQCsLuxrsiHeSE9NC1h
 /Mlz1A9sLrUB+tlpoK4dHhGerAF9gBn18Owk4V0GoPzUOdYrCX9bLEdWvsqjNz9aSEUW
 2zH1BCRaVOjrguSeP6P0nZAX+70RoB8zp8hmoFhfhNoGmEmWUXJeWwBxWN/pSgZv4aL/
 W8Cg==
X-Gm-Message-State: AOJu0YwXXY8OQ9darOQct8zS43KQb1ewim/wCsQdSAXvinJmtFsCPMWv
 U7pG/cdov5Ysp1n6H+ogAFY8d4281Fx/xUSkL9eva975GRM0QQK0M3ZKQuWBqnfBBak0ARQu8QE
 pag+bvQu056sEJ6tsgSo1O+kxFq3wO2bScQ==
X-Gm-Gg: ATEYQzyjYh3R+elU51d9TDAQX0NqLA/bqm/r8ckQ3u5za4B2RVWnFt/MvuVDUZ5pYIv
 Wn8k47kj4Fkr+jHrgK4fPwHeraBE9HjnfzRa7uMp786eJLEdQi2oDYfu6Cvw1OyvW+6/b+/Lf6X
 oZbScBdhl25XbytwN4QzUJlzcyqFXxicks6KfrtggvZMlZWjNPFU2Eb9zepZ5666R8orHHfXUVE
 Axy5LtPMKbXTeR8UIo981YoR5cch+oRe4DQV2k9bR56cojgmYoRXHOMK7nrd2xYY42EWg2wWQrw
 lKy5pbhSQeIx+MH7S0wiOmV09u9FI8PU/epQEZSggGu9p1KMeub+LkNEmlGAcKT8tmXDUKXKJUO
 1PFPzRqnNrTtNkHM+bScrnsaE/E3Vo6rv5ZfuN8W5IhTSVexGNNjWFdromD9kwO/pTNm/RQAM6n
 +S
X-Received: by 2002:a05:6402:320e:b0:66a:44cf:5fd7 with SMTP id
 4fb4d7f45d1cf-66b287560dfmr5662131a12.12.1774789398883; Sun, 29 Mar 2026
 06:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <MRWPR01MB1297423A4A87C6FDEC941A2898C55A@MRWPR01MB12974.eurprd01.prod.exchangelabs.com>
In-Reply-To: <MRWPR01MB1297423A4A87C6FDEC941A2898C55A@MRWPR01MB12974.eurprd01.prod.exchangelabs.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 29 Mar 2026 14:03:07 +0100
X-Gm-Features: AQROBzDN1lW8opvidWGqZyeIZpUaVye_J_dYDR7IM_Gdbiq8pxRyJ4Pb0pFL_1c
Message-ID: <CALeDE9NhzO7sHqp1uBPKJq7Kv--6JTpCLByuNTstLij9Bv0SfQ@mail.gmail.com>
Subject: Re: U-Boot HDMI console on rk3399
To: =?UTF-8?B?VGFtw6FzIFN6YWLDsw==?= <szabo_tamas@windowslive.com>
Cc: u-boot@lists.denx.de
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

On Sun, 29 Mar 2026 at 13:59, Tam=C3=A1s Szab=C3=B3 <szabo_tamas@windowsliv=
e.com> wrote:
>
> Hello,
>
>
> I read there is possible to use HDMI as console output on rk3399, but I
> do not find any documentation about this, only Google AI give some
> hints, but mostly mix up rockchip and sunxi stuff.
>
> I have a Giada DN74 which is based on rk3399 but I am not able to enable
> HDMI output in u-boot.
>
> I check in which defconfig is use necessary configs (|example:
> CONFIG_VIDEO_ROCKCHIP|) and which one is similar to my board, I choose
> nanopi-m4-rk3399_defconfig and build u-boot but no output.
>
>
> Is the HDMI output in some rk3399  board enabled by default?

It works on a number of devices I have tested it on, eg rockpro64 and Rock9=
60.

> There is documentation about HDMI output in u-boot?

Not particularly I am aware of.

> If not documentation, someone could please write a sort advise how to
> enable HDMI output.

Check what other devices are using, rockpro64, rock960 and likely a
bunch of others.

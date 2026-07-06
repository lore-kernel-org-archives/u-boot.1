Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86274C43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB36846FD;
	Mon,  6 Jul 2026 23:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="mKf0boNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAC984852; Mon,  6 Jul 2026 23:00:02 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC392846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 22:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso2596019a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 13:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783371598; cv=none;
 d=google.com; s=arc-20260327;
 b=dBSCpWtmDvrQMeXCi5AghqI6Q+X1U7cNPNcE0hE0HKxhjNnfLhOpN01MVarU/BH+zi
 P40qyfYjijjUdMqR8OcEDnnMon2OPS7wsBGgKZm2tOIWm9g8qaQl03hoZ/LIGNCqHi3I
 caa2ZNxEGahXVqszES3Lz/zbN2UgSryLF0KV33wWYGTR/hHBzBG3KxkPtJV8K3ttP2Nj
 62KN3nrgcKuNL9mdboii1XpTvAvtkYnept7XdPGoLjDxGyX5Cp6YqJ3lKa7TPFiZz+L6
 cAJJZPQe8wbSGpw9KiozLu9qhW0jfBmdQ0yvOLDbmAxbO//S41P0EIUQMHBOJrhK9anh
 rZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6rDLIBFle9SSfw2Oz77alpUSSX+KLSWQX9P8Kd1SSAo=;
 fh=6L+AusHYlUewn8EoK/1Mbo2rg5NefWhURBdyQ+djJto=;
 b=QAbVUqUjut09uRsO1WJrMV/sG+vJU2jEdBCM/AD3wDK/15bWmfCd5oEn11n2k+fH2w
 1LdLWvMStZtjA+7C6jDa3u3PAop+G1XvDbCCRiSFCv2KCGFWCPlT+MHVKq53u/QX4hQ2
 wM1tfvl7C2BoHV5eAhiNTqkE6VsYup/nYHvQAS1JHtFIca0Ax54iQy3TPwFvG4SFYUcc
 u3VBJddtz3Bltqaj1PwXMOvXOjT8wle5J5efLUegFawM1SvkyXABNPwYMK2769O/tXnR
 wnzpuFuhT9lRCk7xeUO7SnoIVFNXel5MU3NRGRssPBP18IcRS8QkROPTbSKg1CzNMZtk
 f9Ng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783371598; x=1783976398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rDLIBFle9SSfw2Oz77alpUSSX+KLSWQX9P8Kd1SSAo=;
 b=mKf0boNeOp3muGwIgix+KfK4O7p2ImTE9Y6nTkM8KcMZBvB+pdbKpF1J4RZEvLUPcg
 crfURLgmnxR4Bk0K3ATOFNRyqLBo/xPgrYPKoV3LM9ola/FkmQPvdTfymmROxsTk+AZV
 ucYD4KyG7g1O2nSs/GuuqIZkwDLNS0OsXHVy1z+EKwRGIjt00UFOYbFu7RngrEm+pvKs
 qrl/0Vg/WLLFVhbRP0wCwSz/dUbEJ+r5JmStuFlfEAAWQrRqSv3EGprZiymhV+SHm83d
 kkTob7xjpk03tuZkM4bmU0uz+gKPH7qEScMklo5SroXFngOsMwIudjVbKIp6rArJ7yoT
 FYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371598; x=1783976398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rDLIBFle9SSfw2Oz77alpUSSX+KLSWQX9P8Kd1SSAo=;
 b=Oyip13grDgbecRkPT+2Q8RnHb0GYIxPwuhtUjFJWtz1lfaKIodwaIfHVhn8AQxOBy+
 8os0amIcYk3JcxqDGAtsuGNDW/mMXsoVJdNJOnjotb9safyg7HSSg0a3F9p9gvkCW/hL
 y2FhwukXebEib9/R3vecfcA0GS/1jRZtwg+8rysr5/s5rmGblE7oP+FL6LWqfq4WwFFq
 /k4l33PtwXnuW1YHRnZmqT8e+cpr07MKobzgpBRFW3lRRLwDHseBWKQamYz04csnZaDP
 FO4bKopBDyF+Q5bZDobP/0CjJvuDsPk4ezjwrdqRPpVKLdkqvEjyhms0GYxkH/PYPJs4
 zGyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98pl015c98KkdBhKNNG20fwvyimu99t1INrc+yERUSZtLrW1AJZfG27XDzEQw+KjZKY1X/fwk=@lists.denx.de
X-Gm-Message-State: AOJu0YzD3yJFe5eUM6TUFXmws8yNF5DtteWQe7El7vqugygzRTSWYhtF
 ALhQCp3X+Xwsk4EFd1hQAZrSKYQjmBOf1wYO3211RTN7RZl6pAGGW8p9wBuM3Ez9WI3p8jGaMD6
 Oeeul7Vu2dvS8+TGNTkMS4JAdrG0rtCTT6NkBcMybpA==
X-Gm-Gg: AfdE7cmTfMtiR/+Isn7o5qNPLPcoQWc1pqyzx7AOa+MwLR8XqbCVJEnHEyZwSXd1qyi
 Wqzl59EZsmUGNt2MOpvnN0RdjMGLu0MGXUXflE0DN2aDt29mHs8Qi4CvKzIP1cYNuHO/NTztxfT
 qe2nlRAuhnCIsVJhn8oByB1x94S+sa995jkVRvrTob8Kq6pW5odv1beXZFzOlVepczPeZQxiUID
 7mp3EraTk9TTgIcbcn18T1XzawM4hQjf1LNONpWnbo+Li1kiKQnJcxvtid+bsLrzMer1tzuvw==
X-Received: by 2002:a05:6830:6a94:b0:7e9:e891:fb56 with SMTP id
 46e09a7af769-7ebb246a3bamr1452524a34.32.1783371598605; Mon, 06 Jul 2026
 13:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260706133322.68010-1-ccaione@baylibre.com>
 <6014ec62-5c2e-48db-ad45-64716acad733@baylibre.com>
In-Reply-To: <6014ec62-5c2e-48db-ad45-64716acad733@baylibre.com>
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 6 Jul 2026 22:59:47 +0200
X-Gm-Features: AVVi8CeiGMGgmjXeL3CF1xYmNhBL-tBWAryHvJkBojQJnzEiQQZUh4W9LerrEM0
Message-ID: <CADh8Lse4sXWg4Fx3mDg8_HuEH_7uVmKMxWeGa82rGe7Dz9eE4g@mail.gmail.com>
Subject: Re: [PATCH] configs: mediatek: do not autostart the watchdog on the
 Genio EVKs
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul.Lin@mediatek.com, jstephan@baylibre.com, trini@konsulko.com, 
 jmasson@baylibre.com, u-boot@lists.denx.de
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

On Mon, Jul 6, 2026 at 9:10=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 7/6/26 8:24 AM, Carlo Caione wrote:
> > U-Boot autostarts the SoC watchdog (CONFIG_WATCHDOG_AUTOSTART default
> > y) and services it from its main loop, but nothing services it after
> > ExitBootServices()/bootm: an EFI-booted OS that does not take over the
> > watchdog in time is reset mid-boot at a wall-clock-dependent point.
> >
> > The MediaTek toprgu can count at most ~16 seconds, once firmware stops
> > servicing it at the handoff, the OS has whatever is left of those 16
> > seconds.
> >
> > On the Genio 700 EVK the generic Ubuntu 26.04 arm64 image is hard-reset
> > before its first boot reaches the login prompt: the mtk-wdt driver is
> > a module loaded from the rootfs and cannot win that race. Nothing tells
> > a generic OS that the watchdog is armed, so the failure is silent and,
> > from the user's side, indistinguishable from broken firmware.
> >
> > Disable WATCHDOG_AUTOSTART for the Genio EVK boards (mt8365_evk
> > directly, mt8188.config for the Genio 510/700).
> >
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> > ---
> >  configs/mt8188.config        | 1 +
> >  configs/mt8365_evk_defconfig | 1 +
> >  2 files changed, 2 insertions(+)
> >
>
> What about Genio 520/720 (mt8189.config) and Genio 1200 (mt8195.config)?
> Seems like the same reasoning would apply to those.

Yes, but this is a preliminary patch for a much larger effort focused
only on the G700 for now. Since this change essentially disables the
watchdog in U-Boot I prefer to limit it, for now, only to the
platforms where this is actually needed. The same will be done also
for the other platforms in due time.

Cheers,

--
Carlo Caione

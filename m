Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFAEFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD888466C;
	Mon,  4 May 2026 14:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DZJ7u8UU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5EF8466C; Mon,  4 May 2026 14:16:41 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B26FD84671
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso1417497a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896995; cv=none;
 d=google.com; s=arc-20240605;
 b=d5hgu/QxYXaSgKHa+OhdXwopzT+qHSPTBpHs1f8r7P/pCTd7qyR0kk74OKtGfCNk4j
 3tEYAijTavCavcUh8NOghdM9Km/URJCobYRh2eqIBUxzrHH6v3h2zvBlMAsgF09Nbsny
 8SGojY4mv26sV/u/37YL1UEMmYYNM+Py4S9ecwry817fYqHD5KdaQP+Vu2rQiBzYNa7O
 65ipjqXbcPr+TARX+YPQnd5JpPVU3ctW1tm0Omfx8cqeNkhLlsfjJ8CxXxdrNYINHVhs
 F2bpAb2xhKaCMN6VHH/WfQAjNuFlsSipyrGI3Ys4KKB794m5J3MGlnjoRzlA23toAWZi
 U0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1f8KwBnqNCooT1Ww7kXYGkGibvOyPFzvHeXDoK1oagA=;
 fh=aufI3XuyC8qBpPBPGtj9YtLel9Xczy8vgZehQ2I4J2w=;
 b=Kj6oCeZZwgE9fdrCyjom2yGgGPy6Uj6tHyZHIhvItBct2K8asCjHX+M/u26hacpR2V
 e44/BGbLBoaOw7vyDddN4gzpbaDfdJ96Wy7DNstqGxAYWbIRG9ma70bdjBHiCXLoFcN/
 6oNSO/dXj08PGjf2zGgYDfnQrd2/hM+Ys+omgw1LQWODz7/gZ+81bKH9wGZsPzrH/RjU
 KRlm3V+w59mJqn/6WwooHBg26VpKBKgL/cyYqtgWfp1RE4hGzaiTvVlrD9k8SQhtDqV5
 ccTFhwj5Emt3LEk3Mj4o54GO8Kjj/k/S4egdOcWhoMAXJo6BiuVfT+o3zm7AT1wBmYPe
 fMjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896995; x=1778501795; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1f8KwBnqNCooT1Ww7kXYGkGibvOyPFzvHeXDoK1oagA=;
 b=DZJ7u8UUbgEx0gvKogAt/HppUNOu9fdivN253m3PD5+zFYWgoxXIIFkW/rBIWqzDk4
 UlB13rP7OGgy0EcP6xWVAaULt1CLtaIJn80aXA+O1R8ETYRMoSlom7hd05Ah+i6QRxu5
 1XDSFRWVCwikUTJ1e2dQs821M6yKVeAHFWfxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896995; x=1778501795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1f8KwBnqNCooT1Ww7kXYGkGibvOyPFzvHeXDoK1oagA=;
 b=FWi3bZQqKapmfMcRoTkWQ/zkQf3XRypl4O8LuLqj9+mspBbVhrexNg1GI85ZUv132l
 u8Vt1cxThvpksaCkZFdnbY+ml4Wr0+cvJMgjGfvLFF7uK28mSmnoIUTXKv7X2Qp62wyC
 P94dwGGhajOAas6Q5AWp4ofa41Xk8BwamNO1gKZ9kwfjuFl8oZ/hVofYdDPLVfAZ9/EE
 4eDBWxVFb+L5Mi7/FuyeQrQf+hiWiAthzFJZzbUWWhFqi9qFLgR4+3HoIgr8fsonz/OM
 094RLqOkkIxSN+8DVAqcDnWP5tbQGyesT1lww3H5xE6acyrcBgWdyJM9BVLvFrLQPyMZ
 +rfw==
X-Gm-Message-State: AOJu0YzCpatf6QbOFYnZhKyIk3IYsodqcE4hAq2iiaDnPBJrh8pjerda
 RCykcB0RA0OY3jNVH+QZ86NCaFgV8G5cwaDF1CyopMgVrUmnYe7D9+3gL/Q3fcB8kpWVV9HvLM1
 BAXwIxqsy6f9F8wLQSkqxOpWX4N9csvrWhvSpGxC+mSa2Ym0GsJY=
X-Gm-Gg: AeBDieuvh2vuaZvMbPAVlendZy/qakEohWLJDWYEXbs18nUE33HNazDZ/Os39Sfy2qh
 moVx13RRd7V/cRp1fcqyFDwajPoLNu9++gLCy1l0MTrUNSf20xHg0uerjv0bDmwdTiXe7oZol9N
 1ybKdTVwfeenRYPt1b6S+Mq8V3aCkxQAeg8zCg08xvFJdhz2aPvL6KEz3CaKmxp9I0N7oBdxKGO
 jAxg9kSVLkIueIoQJE48kLe7t+xKIz6fd5lILl+1i4MdbHS+k/ODLTBkesSU07mMZmEUc4T0pzE
 Wu9m4xgNvmLIveCF
X-Received: by 2002:a05:6a20:3948:b0:39b:edcd:d92f with SMTP id
 adf61e73a8af0-3a7f1a1d2femr10101335637.11.1777896995147; Mon, 04 May 2026
 05:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
 <CANNWa06xcOuCRwZ1YNLEm3xYSdxP7HcnLzY5EGf9RFYg3fs_eQ@mail.gmail.com>
In-Reply-To: <CANNWa06xcOuCRwZ1YNLEm3xYSdxP7HcnLzY5EGf9RFYg3fs_eQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:45 -0600
X-Gm-Features: AVHnY4LykM5gknjNT3QaOGwJf13CL8_pqNLiflMf5sayx0Pd3WUogqrky0YYrfg
Message-ID: <CAFLszTgSuTR4CALcTgV1Q7sYoF4f4_DSW_vEwvXAQherM4xPAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] BeaglePlay: add ITE IT66121 HDMI bridge driver and
 enable splash
To: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Cc: u-boot@lists.denx.de, jd@ti.com, tl@ti.com, trini@konsulko.com
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

Hi SHAURYA,

On Sun, 3 May 2026 at 12:56, SHAURYA RANE <ssrane_b23@ee.vjti.ac.in> wrote:
>
> Can this be merged or does it need some more changes?

You can see this in patchwork, assigned to 'ag' so should be applied soon:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D500835

Regards,
SImon


>
> On Tue, Apr 21, 2026 at 6:51=E2=80=AFPM Shaurya Rane <ssrane_b23@ee.vjti.=
ac.in> wrote:
> >
> > This series adds a U-Boot driver for the ITE IT66121 DPI-to-HDMI bridge
> > and wires it up on the BeaglePlay so the board can drive an HDMI output
> > from U-Boot (used for the splash screen via TIDSS).
> >
> > Patch 1 adds the new video bridge driver. Patch 2 enables the DSS,
> > I2C2 and HDMI-bridge DT nodes for U-Boot (bootph-all) and turns on the
> > required Kconfig options (TIDSS, VIDEO_BRIDGE_ITE_IT66121, BMP,
> > SPLASH_SCREEN, etc.) in am62x_beagleplay_a53_defconfig.
> >
> > Tested on BeaglePlay hardware: U-Boot renders the BMP splash over HDMI
> > via the IT66121 bridge.
> >
> > v3 addresses Simon's v2 review comments on the driver: the remaining
> > bare BIT() constants in it66121_hw_init() now use named defines with a
> > comment describing the AFE power-on sequence, and the unused-looking
> > bpp local in it66121_attach() has a comment clarifying it is a
> > required edid_get_timing() out-parameter.
> >
> >
> > Shaurya Rane (2):
> >   video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
> >   BeaglePlay: enable IT66121 HDMI bridge and video stack
> >
> >  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  42 ++
> >  configs/am62x_beagleplay_a53_defconfig       |  13 +
> >  drivers/video/bridge/Kconfig                 |  10 +
> >  drivers/video/bridge/Makefile                |   1 +
> >  drivers/video/bridge/it66121.c               | 609 +++++++++++++++++++
> >  5 files changed, 675 insertions(+)
> >  create mode 100644 drivers/video/bridge/it66121.c
> >
> > --
> > 2.43.0
> >

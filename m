Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F27BCEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89CDF83C6D;
	Tue, 18 Nov 2025 07:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCqTCNCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6AA83C72; Tue, 18 Nov 2025 07:45:15 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422CB83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-298145fe27eso68818965ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448311; x=1764053111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfSU6cEVTcGYtiZPp11W7v+SHN1bRdOOlNYOyKPhRgw=;
 b=DCqTCNCO9+8MS2mCUrIaS/CUOxwqVUssKy5xRFDzoTtbeSs1P/hizrIcSsIlqmpfcX
 isYk+yXkAvH7jK6XcOLgjRjVy5Vrw6GunRHzwCaVhpgy0fNCqHRPOE+YK6FmoVh7UsQF
 1CVZLE1pG0RsCPaV5GNQYr4AvJsU9yTagNKqF/z5XLn8Crr6D6taaMnHIBMS+/OexSN0
 6MhXHiDd05FU6kl7e0Y5RtjKE/4ZW6UrY87FCEqSHnmjZss422r82Nnz5NTBwFo5h4Wv
 F69TuFb82bv68rTRRLf+xs+mMvB9jeTN3Mh1OdXlBem/ywc287YTe24MrdCRx/lekD3l
 hZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448311; x=1764053111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfSU6cEVTcGYtiZPp11W7v+SHN1bRdOOlNYOyKPhRgw=;
 b=KkQwTPc50atAxbGpyTVVko6AhejlVlNCLYpjASXHFuGTrO/DvMSWwnkIBC+JlNvWvm
 L0C1vApAL6D9kv75YiPUzqIN+9hXt4pX9lwm/yloU8menfopc5YS1n/92J1vr98T/sv4
 DmMUJDSxUe5gD5tDuN+m/G0a1SD8Ktdu5g+Jf8sO3rqyjWdoLBN6FURtSbHld9iBgV6+
 buAFAF6t+yCRfe/8SPQYN3LWFlXmYyPPQE+n/wGkqRUAnMHwKKCPRcuiDIoVJ7ycVT/Y
 hcb1dWpAsws3ymfQ6racTkEfMSJ1/aBX82cqN/818YlgkCAahtnw1Ie2aZ6vU17L9g7h
 cj2A==
X-Gm-Message-State: AOJu0YysJ5AIwtT7aemiG1BuHl9bSNDLv8X3RQYhSDNV/XXz0bnYeAph
 rzpogvu6k+hs4Dfo20Un8hARFdI9nbojUk/Ie19DxYaESBv3i9r7ms5gPqXga5NhSMsHGpe6vqe
 s+/GnK4ILQ1TSX0hi8jUHhfocvrWFoS9HYlA=
X-Gm-Gg: ASbGncvOsMjrNI8BdA8x84yvRz1C3VEfr47iD9k6Hco3XUuuLtsKkcOyDSZlRuQ361j
 1qdXVPYVK4zZFRK0JqeieeRf0YDFYBYkTO4IYVJEH0u+vz1Mp6cUSjWdNTEh+TP8OnD6d/vx0k5
 Jr+iwcDDj6mqArWRxAsI+bn2nXa6imKrhBzrkbCLsWxv22Kp6esteJPZWUZ1S7/lkMZUh2d+Y8A
 xD4sJlN5YlgzmzSDNr/FwNc3pMylLO+u+Cta+/UiNKUWWBwi5V1hW9A1xLsXSrY60eYIwA34Ncy
 /tudRkh6YT9SeOj4LY8Wz5s7XKI=
X-Google-Smtp-Source: AGHT+IHy/LQZkKet7tI05s8rXQc0kbSrH2X3ClCxvSiXTiF/fu+YmNnPusoCjCIZzI2f73eTxpNGhAYhZ0iJa+8I6EA=
X-Received: by 2002:a05:7022:f20f:b0:119:e56b:c74c with SMTP id
 a92af1059eb24-11b40fa7f4bmr7284698c88.17.1763448311112; Mon, 17 Nov 2025
 22:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20251118064000.14613-1-malysagreg@gmail.com>
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Tue, 18 Nov 2025 01:44:42 -0500
X-Gm-Features: AWmQ_bn6Cqv7YkfTjU3zcN-A7ArzziREc6-y0U2zsEe5Jtc_sGtEks8UXqUsUB8
Message-ID: <CABdDSeVzJrec1oe4WOcQhuH+v+MsxG4_pxOMG1iXKZxMp1VEXA@mail.gmail.com>
Subject: Re: [PATCH 00/12] sc5xx: Add complete board support for all ADI SC5xx
 boards
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ian Roberts <ian.roberts@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Philip Molloy <philip.molloy@analog.com>, 
 Philip Molloy <philip@philipmolloy.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Yao Zi <ziyao@disroot.org>
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

On Tue, Nov 18, 2025 at 1:40=E2=80=AFAM Greg Malysa <malysagreg@gmail.com> =
wrote:
>
> This series adds the final pieces to enable mainline U-Boot to build and
> boot all Analog Devices SC5xx SoCs and supports the associated carrier
> board options. At this point it should be viable for new users for these
> platforms to start with the latest version of U-Boot rather than our
> vendor fork, however some features (such as OSPI support and falcon
> boot) remain unavailable until we are able to unify our implementations
> with the mainline implementations.
>
> Changes in v2:
> - Rebased series to latest u-boot master
> - Replaced SC_BOOT_MODE Kconfig with SC_BCODE
> - Use Kconfig to restrict choices between EZKIT and EZLITE carriers when
>   appropriate
> - Separate dtsi for revD and revE of sc598 SOM. RevE is the default but
>   revD is included so that any customers with older hardware can boot it
>   with a single change to the .dts
> - Fixed GPIO naming and polarity to use only positive names (such as
>   gige-reset rather than ~gige-reset) and set the active low/high flag
>   appropriately, with all code references updated to reflect logical
>   values rather than voltage levels

I forgot to include a link to a CI run for this series:
https://gitlab.com/gmalysa/lnxdsp-u-boot/-/pipelines/2155569443. That
version is functionally the same as these patches, but the commit
messages were updated ahead of submission today so the commit hashes
are different. For the paranoid, there's an ongoing CI run for this
exact series at
https://gitlab.com/gmalysa/lnxdsp-u-boot/-/pipelines/2164366404 but it
has not yet completed (ETA 2-3 hours) and I expect not to wake up to a
failure.

Thanks,
Greg

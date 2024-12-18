Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A75E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B138021A;
	Wed, 18 Dec 2024 13:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2vBHeqMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FE48021D; Wed, 18 Dec 2024 13:59:43 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916B680214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so3276802f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734526779; x=1735131579;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FtYhmAHpiFNCRCgbWGs6FZJAujUpPPmM9g1qkAj5oRs=;
 b=2vBHeqMCwoiP8XZUHCQTNkl1MsSwYMLBdZwgzxpOt9YpspLpGSYMu7vuSBtAhLpvbA
 YnDxFLDnEvLuFKbheDizeg9Pnv/dAWQPDOCHaLjl21HN7hUAFhyo2oyT85XhAquN0Bw9
 rH5DXeLJgSF2YkKq5XN59ePpsQPdZCxgDcoKSASLJCtyTuOYx04bxuhAA/xsMq+GAI+v
 iS+3EHcAXMhxSB146VCsedEMgY7yp6X+9yAlyMQ3IUjI3dIqu8xmzXWWPhjnmBKA7L+u
 JOZC0/017JI5sdpQGDcv3yO+mgkaPmqTLBrNJ/p/AYTNMx3VkqP9e4MqJbbUvv53iUkp
 yFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734526779; x=1735131579;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtYhmAHpiFNCRCgbWGs6FZJAujUpPPmM9g1qkAj5oRs=;
 b=bT+gvjQWnZW49RUsIZW3a/NCn0tTItdoLQPufSUexMM5cGOyJ4/4IPMQQZQIJNjkSo
 nGwQJrLBHrLgV3okxbfckh274493viybbToo+v/SGdqM9o6ydYfbOC2jeK9/1Eribn5u
 vJsO6RBSg6/gkM0I/jHU4ApgBSbqzTjmHQ4kq9bsftN7XKp3uLFERmZJrqt7uInOnCGq
 U/MqbAErvCCboA5VZlLNJzhC3KP7UHSe9zt4+ib8MxRh/uMgbPSMX7Wb5oBrdvRhYXv1
 DdqIEowgdaZQwI4Ps7bYpu/y2S1fpjkG0+rVveY9XdbMV7w7711yvBipIjYWiKEoXUOF
 3WVw==
X-Gm-Message-State: AOJu0YxugrU1ui6KKooZbfj/x0Inj3KBSpC7+hwEt3/x7tX9ziEHCgiV
 vpqWLzHxADeoQMqt78eoZQigRNz7ikKV67z+up5emHj8D1VvByMFmTm3P0T82bA=
X-Gm-Gg: ASbGncuf4Ts8JTezBBcfWWwFEVtvv9xgjawNw/EEPviMfBP0y3DzwlsKhPsD3t8TeEc
 UwPo5rCp0rdPZwm9L5JMqr4PRa6zSbfcpFqaXxa3WNDPI8ij5rR3b054vbSmMec9WRDUUCkNw1J
 Wsq8QFm7Y2H1Zngqj4cDQg3UBuO96DyfhqwdhO2SXg+ZIQ6TP6CRBzxSqG9yZoYUZsVPhuuiVGm
 GqXaC3cdJS+7+9jHVtyHdm4fBCeSsCQpBY0DuTm1jGcFCzDYR5wvr5QYEsW74iE5w==
X-Google-Smtp-Source: AGHT+IFYMRqdojd99KPHgtXPwupOiNlaN7BipASgEfaPodlyhacVoW6unTIzFe2alOiiDgr2E+vumg==
X-Received: by 2002:a05:6000:144c:b0:385:ec89:2f07 with SMTP id
 ffacd0b85a97d-388e4d5db3fmr2282887f8f.32.1734526778845; 
 Wed, 18 Dec 2024 04:59:38 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8047324sm14209390f8f.78.2024.12.18.04.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 04:59:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v2 0/5] Add support for USB DFU boot on AM62Px
In-Reply-To: <20241218124542.3519447-1-s-vadapalli@ti.com>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 13:59:37 +0100
Message-ID: <87bjx9w3ie.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Siddharth,

Thank you for the series.

On mer., d=C3=A9c. 18, 2024 at 18:15, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Hello,
>
> This series add support for USB DFU boot on TI's AM62Px SoC which has
> two instances of USB Controllers, of which the USB0 instance of USB
> which is a DWC3 USB Controller is used for USB DFU Boot:
> ROM =3D> tiboot3.bin =3D> tispl.bin =3D> u-boot.img

>
> v1 of this series is at:
> https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1=
-s-vadapalli@ti.com/
> Changes since v1:
> - Dropped the first patch of the v1 series since its equivalent has been
>   posted by Jonathan Humphreys <j-humphreys@ti.com> at:
>   https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765=
-1-j-humphreys@ti.com/
> - Based on the feedback from Mattijs Korpershoek on the second patch of
>   the v1 series, the patches in this series have been updated. More
>   details regarding the changes have been described below the tearline
>   of the respective patches.
> - Collected Reviewed-by tags.

I have tested this on the AM62Px SK EVM. I did *not* apply the
dependency (20241217204835.3312765-1-j-humphreys@ti.com) and it worked
fine for me:

I did:
$ snagrecover -s am625 -f ./am62px-sk-evm.yaml

Boot logs:
https://paste.debian.net/1340393/

Also tested that I could enumerate the board with "fastboot".

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>


>
> NOTE: I did *not* collect the Tested-by tag since this series has
> significant changes when compared to the v1 series. Though I have tested
> this series before posting it, I intend to get a Tested-by on this v2
> series itself after it gets tested.
>
> Series is based on commit
> 3b3c7280b82 smbios: address build warning
> of the next branch of U-Boot.
>
> NOTE: Series *depends* on:
>   https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765=
-1-j-humphreys@ti.com/
> since the corresponding patch has been dropped in this series when
> compared with the v1 of this series.
>
> The USB DFU config fragments for AM62x are to be re-used for enabling
> USB DFU boot on AM62Px as follows:
> R5  =3D> am62px_evm_r5_defconfig + am62x_r5_usbdfu.config
> A53 =3D> am62px_evm_a53_defconfig + am62x_a53_usbdfu.config
>
> Series has been tested on AM62P5-SK. Logs validating USB DFU boot on
> AM62P5-SK with this series:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/d70cff3bfff53ef094d3a77=
5e44f84c7
>
> Since am62px_evm_a53_defconfig has significant changes in this series,
> SD Boot has also been validated on AM62P5-SK with the
> am62px_evm_a53_defconfig of this series. Logs for the same are at:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/971df121c8b69a2b8fb17f1=
c585ee0f4
>
> Series has also been validated on AM625-SK to ensure that the changes
> made to "am62x_r5_usbdfu.config" config fragment being used by AM625-SK
> for USB DFU boot do not cause a regression on AM625-SK w.r.t. USB DFU
> boot. Logs validating USB DFU Boot on AM625-SK with this series:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/627c69150c34171b0652048=
39c410e92
>
> Regards,
> Siddharth.
>
> Siddharth Vadapalli (5):
>   board: ti: am62px: env: include environment for DFU Boot
>   configs: am62x_r5_usbdfu: extend for AM62Px
>   configs: am62px_evm_a53_defconfig: enable USB DFU support
>   arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB DFU boot
>   doc: board: document support for USB DFU boot on AM62Px SoC
>
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 +++++++++
>  board/ti/am62px/am62px.env            |  5 +++--
>  configs/am62px_evm_a53_defconfig      | 24 +--------------------
>  configs/am62x_r5_usbdfu.config        |  3 +++
>  doc/board/ti/am62px_sk.rst            | 31 +++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 25 deletions(-)
>
> --=20
> 2.43.0

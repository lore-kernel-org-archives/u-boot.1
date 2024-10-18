Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5C0D30003
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC95588EC9;
	Fri, 18 Oct 2024 14:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCgimeSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BC088FE4; Fri, 18 Oct 2024 14:37:19 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1309188D9C
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so22916271fa.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729255036; x=1729859836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iToSDiAVQgeQxRF9CQtJxaOlfEWXvGXocqMYxPeACm0=;
 b=KCgimeSZz5wuljAcKIiBtSPPljfLVoMgfQ4hKV9WwAEhiSmVC9rTtj+gXMNTqyO82e
 zkykFIRD3jWiCD2zdvgqGisRUf+Hqnz3BSgXgRZA08nmdS3VcG2J4vKF01U7g6qA9z6Y
 0ObofElCb/dxj7qIbDLWr88DEVnQ0FlfIZLmF2Jkh1/PUdCnDkhvuDeFo/x5SXd62Ydm
 kH8HBfAmiR9/7rNWpcBe/Ebg4emwSey5X1nJoHdEsFttOh01Bm6kVQ03si46STPFbek8
 UwRLgLJz32J3BRYr2qrS9tXpi6BkBX9rrJUJwS44l7qHWXnOlwVPPm7F2vVRvTa0E7p/
 iXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729255036; x=1729859836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iToSDiAVQgeQxRF9CQtJxaOlfEWXvGXocqMYxPeACm0=;
 b=px7PKK+/lp1gQr/W/aAPpV0V0QbfymFH9z7KsdoyUoddjmEzzcshEkG9bBk+ZYrd1H
 yUbBdBdJ2FpGDq35QYz6unhlcoVclzRZagg8zvFsyI8xKCeZqHF+ZOa6S7WYOlRTe+qe
 orvXqA0iMZT/nJWvlSBqw0AgeeId0HCWmBm8vPpEV/K7Yqx88AusLtKMrTPNQF3Kzjfz
 h1ww9/HDGNHedAmOq4Ap+/R4WpddSEErzDUiUUm/X+P7wuWIwRGLAAAdtCUnROrclPL4
 LgYoZNBHFjJJEn9hrBhuIDr367BirXjMFTBmGuLZygwMo30k7JUG5EtdxIyv5EUhJrkw
 EiqA==
X-Gm-Message-State: AOJu0YwBVbKeHVhY5p2vgbo/TLLq1Yd3F4DO45PTB6+GYpAuwZ2J5wgI
 HH/uMjgPFxTpOpBDj//DXb6gT0jhZiTwXRn9hqjJpNH036xnDi3pwm7y2T/JCXLRBMlNlaNXkV+
 KGI8qnialHKbl0c3k1AJkga/7gWnxJw==
X-Google-Smtp-Source: AGHT+IFvKvTTA9Z17z509YnaUiwjhUmkR1BooSr+pP1ZaqxUvtCPZJTl7qI9JoA7Dx78o/6TXQGaLXId0IQGwowmTqo=
X-Received: by 2002:a05:6512:3da1:b0:539:e2cc:d380 with SMTP id
 2adb3069b0e04-53a154a87d3mr1256736e87.27.1729255036094; Fri, 18 Oct 2024
 05:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241018122914.251188-1-festevam@gmail.com>
In-Reply-To: <20241018122914.251188-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Oct 2024 09:37:04 -0300
Message-ID: <CAOMZO5COb90hQ64io8HJc=sSfSED0wxnmABFVDEAwRyeY2X+yg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241018
To: trini@konsulko.com
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

On Fri, Oct 18, 2024 at 9:29=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tom,
>
> Please pull from u-boot-imx/master, thanks.
>
> The following changes since commit 608a31bdec6284ad6f821226e4c62c9cd30528=
74:
>
>   Merge patch series "Introduce the lwIP network stack" (2024-10-16 11:11=
:57 -0600)
>
> are available in the Git repository at:
>
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241018
>
> for you to fetch changes up to fd3f2e3f0edc1f87be4c5a39a0c81037d551c069:
>
>   cpu: imx8_cpu: Avoid revision to corrupt device tree (2024-10-18 08:02:=
30 -0300)
>
> u-boot-imx-master-20241018
> --------------------------
>
> CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22796
>
> - Switch to using upstream DT on DH i.MX8MP DHCOM PDK2/PDK3.
> - Add ability to build fallback DTBOs from arch/$(ARCH)/dts.
> - Remove fdt_high and initrd_high env variables from imx6-dhcom.
> - Add dummy clk for imx8.
> - Fix DT corruption in imx8_cpu.
> - Improve DDR stability on pico-imx7d.
> ----------------------------------------------------------------
> From: Marek Vasut (1):

Ops, please discard it. I had to manually apply this one and I messed
the From line.

Will send a new PR shortly.

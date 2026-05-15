Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D71CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 23:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180B584812;
	Sat, 16 May 2026 01:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l3R0TVWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7D684884; Sat, 16 May 2026 01:39:28 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7B38480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a8721851e2so480517e87.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778888366; cv=none;
 d=google.com; s=arc-20240605;
 b=PDszHq6tCxG/Tnmp99h+AY2TNn6hIUHZS7ca1UDGN364WYUbHkMfcdscy4LjgvpWB7
 QsoPt/szNMuwVE9Pi8qkwglC/zwKKxo1MKaF4PqVDlHskL23i5wPSajO4HSTkEoI6wjN
 hyY+hTP4bYLQNg55q95X6LbyvO/YhIdXrkA7YXou0sd3z27YsHXP78pp5OkG2i2CCiiX
 Ye1nJmiSgyIk6uKnDtxOGKoZ6JzEWYLarEpiDF6FBZjZltwf7o+amifxEGZTTXw8JNwC
 m9HjG9QbCqg3wCgMRcwDHN5eZcdEIqzGlQbMvwch7fuZ1QGxenRxND7YFDyPFSE33jS4
 HmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jYWePIqRhiGTtq2LCvL2TgbYCRMoRwBCqolEZSzCf8k=;
 fh=zx497grXRyQK0+Q8+IT+pb4MGf7ejk2C+k95EUX9H8Y=;
 b=d2QgUnudsNNRQ7ZgWCrjuYtOKNeTkZ21i176rtZrHaabLBp7dWw2Ofs6tvCbkJ8YS+
 OkKL9e3pqGj2sxdB49MAtTzvpTjovRJ4CU5h/WrajtIgo+IxEh1F8i5HUKBXW1Rh2VIz
 03OjqmvNVyA87cly+ItpjSWqvGgLcqAlc/a1qc7qbRO08uSzEbxhXL+LFZgET1sXyZSW
 39a6w4mZbD/7YCYDSwoHiMC7PQza/+wi7UlXASBlnUbODRWORJXWljH6nyB8BEGkRr1T
 v7q6OWH0hXWPS8qQz3+EayCmW0VusD36CznsXWTg7PpuS+9xMY3nL8cSQpOPiANL2DOx
 hEew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778888366; x=1779493166; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYWePIqRhiGTtq2LCvL2TgbYCRMoRwBCqolEZSzCf8k=;
 b=l3R0TVWP8WG/Gli9NG+19mYX6Yyd/Hn4+mhbOjM+7gTIsEeqT8Y2eO58I21w2qWY8E
 TqqRNLhxhHKJyfrcoy2mHtHb71Yu8OWoZjXPQfzYechmqqNo0Z8ThST1PPVV6WpszeJt
 OK6z6boqiVXD+8qy8RRTbraROUptStYPWIb7ZD6DeGUNQaCbL+k2dAtIIY//AuuA5UXu
 Fu1big+9fO4nfICy0wamHLgADX1W1+ODmahEzD4j0Lv7fUdGDWfoBCyVzId6ae9tqlfQ
 Yp+N563MV9JFxio3kYzVovBFXrNkVVyao91xJ4rFCeTMb1sa6wO6PrsxRvEZLPEb45Mw
 GaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778888366; x=1779493166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYWePIqRhiGTtq2LCvL2TgbYCRMoRwBCqolEZSzCf8k=;
 b=El8ujJ5F0AJL09OxSuvhyUpJTTONN9QVQcoj4pVJD3yzeun1u8ShUXenbn9s1UHU8Q
 sweOe26266iMQ7k5lfgeilbR5yx9P2iWJFqb2lqIzC59jfh6aAVaB7QHzVsOakikjTuI
 /NT9nZ7oFcK49wQNjZM0+FQgnMTiGIgAmH968oSCINRWdcY49Z5lFMFPlpkCG9X7IPa7
 OD4x+tpYlBH5BiKzOsUchvzSIZUO9uBx6+BVAsIWCqcn9UZeBz8sysWxrIXaU9xxQ/X3
 aOfMmL8XQHOQSL6IyXbgC+fzk10IcbQcczW8m5ff5zy4WBtaI4wWt0SZ+CrC2eciAxLV
 kddw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dijZO5HKVpliVKqsoPjXAXWxiWPviVpiyj9Vc1B6MoaC4HjsFUBk6hRORyR6aRuntGauX6Gk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/hUCbAR5DgHhBkLW7DYj1ynsgcmxM5QX5bCDyMPe3ez02tvla
 oGOnTxXvzvhZW7TaHJAkl3XUWQQG+CwVPchSmL8SnTZakvXrFIVb2jbjwKF8rDw+Laq2aon9mhf
 OXuEF8FUh6LXENHoUsq/oMr/j7cKFiek=
X-Gm-Gg: Acq92OFwOHitB+jocAtHFM+i62UqGp0P6rTEexFYwjNEBdXBBQE65lXnpPRglKHjxLk
 TBBhLTAIjh5EBLPrm+hcrsgVPQEV1CE/VMFXa0Qz1beQ407h+1I7iMRc3SGfAiKWfLt+T5llzPP
 iBgHjcm7RPBdQ7COGsw22GjQrfdZOeoyUYrD5nfs5EiOTs0DrC20WttejpYk1zr4cRqT2UaB/v+
 p02/cGQAl49YzmnYRxdDVpwPBS1uiJ1nu6fscyVL2JA9PkgvIh3Qf4OPNVoVa+phiQT2vccwUoZ
 CstiGiitNo5grQneu50KHlH7bfvPc6bWyzR5RIM2ZuLI8A6kQxissglongZgpvN/85Qr7wxU
X-Received: by 2002:a05:6512:3c97:b0:5a8:57de:e6c1 with SMTP id
 2adb3069b0e04-5aa0e73ca79mr1906945e87.7.1778888365782; Fri, 15 May 2026
 16:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 May 2026 20:39:13 -0300
X-Gm-Features: AVHnY4L0NgVreKs2bYUPuKfUM4slCA0j9oLqYo7I7sEYx1YyjM2WPln4fK36YaA
Message-ID: <CAOMZO5A4fxHXk++4Ha6hpw+=saE30B2OxmFtkHzpzsi704Ysfw@mail.gmail.com>
Subject: Re: [PATCH 00/13] iMX8M: Covert to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 kernel@puri.sm, 
 u-boot@dh-electronics.com, Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>,
 Patrick Wildt <patrick@blueri.se>, 
 Ye Li <ye.li@nxp.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marco Franchi <marcofrk@gmail.com>, 
 Alifer Moraes <alifer.wsdm@gmail.com>, Angus Ainslie <angus@akkea.ca>, 
 Heiko Thiery <heiko.thiery@gmail.com>, Olaf Mandel <o.mandel@menlosystems.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Matteo Lisi <matteo.lisi@engicam.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

Thanks for working on this. I appreciate it.

On Fri, Apr 24, 2026 at 8:20=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> This is an effort to convert i.MX8M Boards to OF_UPSTREAM.
>
> The only left one for i.MX8MQ is:
> imx8mq-cm.dts
>
> The left ones for i.MX8MM are:
> imx8mm-cl-iot-gate-optee.dts
> imx8mm-cl-iot-gate.dts
> imx8mm-phg.dts

The imx8mm-phg.dts is present in the mainline kernel.

> The left ones for i.MX8MP are:
> imx8mp-msc-sm2s.dts
> imx8mp-rsb3720-a1.dts
>
> These board dts are not in upstream Linux, need give a look to upstream t=
hese
> dts to linux, then move to OF_UPSTREAM.
>
> I checked all the board dts, but I not have the board to test, best effor=
t on
> this patchset, but this change might break boards. I would appreciate boa=
rd
> maintainers to help test.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (13):
>       imx8mq: reform2: Switch to OF_UPSTREAM
>       imx8mq: phanbell: Switch OF_UPSTREAM
>       imx8mq: pico: Switch OF_UPSTREAM
>       imx8mq: librem5: Switch to OF_UPSTREAM
>       imx8mq: kontron-pitx-imx8m: Switch OF_UPSTREAM
>       imx8mq: Drop arch/arm/dts/imx8mq.dtsi
>       imx8mm: mx8menlo: Switch OF_UPSTREAM
>       imx8mm/n: Drop unused dtsi
>       imx8mm: data-modul-edm-sbc: Switch OF_UPSTREAM
>       imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
>       imx8mp: dhcom-drc02/picoitx: Switch to OF_UPSTREAM
>       imx8mp: data-modul-edm-sbc: Switch to OF_UPSTREAM
>       imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM

I applied some patches from this series. Per Marek's request, I did
not apply menlo, data-modul, and dhcom.

After removing some patches of the series, subsequent patches did not
apply cleanly, so I dropped them as well.

Feel free to rebase and resubmit.

Thanks

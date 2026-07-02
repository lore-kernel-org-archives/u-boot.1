Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB2EC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF64284A77;
	Thu,  2 Jul 2026 16:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="NRGasGt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEFB84A7C; Thu,  2 Jul 2026 16:52:27 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF8884A57
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c0c15bd6b8fso203390866b.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783003945; cv=none;
 d=google.com; s=arc-20260327;
 b=V+EIQIcqi7pFu33wsLqBQGHxMcPV6Gi6wJwX5mGPQ3KqOJ1qTQUCjbkkFgc43bFUzQ
 0k0Heh5y14jDMQ574FYXGK7hz/S4zBiRB9gzoXllk7dcg0I7K3bjBXqUf9wLE0T6VTrS
 Jr3M7dt2O0CBaFL6svn0pkl98q0xqJ96xjAJsOZjLuF1DuZfZHSywiv3Rc3BUaZsSJ20
 4C/czPxTG0b5V+oZyytQzLGTY/L+TiNKX7CxXucHA4qSCsodNWALmWtcWOBvqe8mIMdV
 ekoqjGkWMhsDSOqSPlARPLgeodu0OQPteP8xa2XMAec7CXAnOKs9g9M8pJWsCtjtDkxa
 0Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kFiB3lkrVxgXpThKLPZVA4fzP9mekKhZS6QsZ3hMClY=;
 fh=+9MuPjcdJl1knjw7aGMcquPTQey62pyvZqux3VuF8Gk=;
 b=afrQYFGMmgakGyJYo8i///alIM0jv4nvG+fsGplgo3Vr/J11SeXeS8p5KnOztw/KRj
 rWUe6iRUCBks6InQt1qev+3Ee37fWaSm3H9T/YgpJLQXo4inTBLQKIEJ39diHQTUMJ2j
 TNbHRJqRMDIgOf/k+2nUlJJTHh8RftYKX0TSMCHA1Lgom4D+hBr8szgzRZ0/d3PQMyfi
 OkDtv+gZ0V7pxwHDQhT5ETe8kgMH72ZuI4Ieev4prq4BqyHnuF/XkN7Jsuq/TtcTQaiP
 zb5GZUDIxQAMeOMw/8LiKURL0rZsipxiciME/5mvdRuKYjbQieo7rK5SdeRcjVdVRMOh
 f42w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783003945; x=1783608745; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFiB3lkrVxgXpThKLPZVA4fzP9mekKhZS6QsZ3hMClY=;
 b=NRGasGt6toW6wfx+EGPdthPZMSAfiJ8ECuZOcGCGF2mJ8O0WF6P+B1Xt4/AYoCZtra
 g7Sqp5r+Q/VE3Olxni82wQbH4Ak6eicfmYfONjDQslRKiGAZkaXgVZQuNOCX5KSk7FJ7
 Hf1zdIcdFftLq0kJs+gRFkzgjxbx2xb1t1mMglu4NGXzwwP56lOVkvJZYaaFD1PXJDJN
 bvwRgccBaNmZjR7PJPtk1p5gmW8IaS6lKtESPp+EsK8pU5PLCO6AovTtRm7Nsnkz6Lp+
 Ohfj9auwwq5FNQCsY6ITAz7BuYlryXWH9pKyLnftq0+1+6EXyZRYk6EYht/T5tFjWhBK
 PoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003945; x=1783608745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kFiB3lkrVxgXpThKLPZVA4fzP9mekKhZS6QsZ3hMClY=;
 b=OpgO7Mf+JibR0ockB7IPyghff8UAJItMAh5hU9oOSCvLLjnBd2w+Vdp2cfe4VT2mhS
 6haUYzFMybz+/5+upuIXKNoDTtkZON7DxE2F9F55R62Z8aYOQc2VQFCR9EOiIfTlsBli
 FpYyLDJTvF1VObQvqzodotxTvA/i5z7aEkY/iejZXUlpwcrczZd3m6pY1qOhOqqdtNZ1
 uu906rgh/PBL6FxGzFx6YjQPyeeCtKSoFGyfPnNSO7PXpmRQVEF3VEZomHz7nHK3lVdx
 SzYJNsZkLzueqEnVHzvH38DXiTx2am2actHKAufjrt1SiIEyxkIzAut6WyXn6r8EB5At
 hUkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqxxkElBvArkpnSjWQym3mBqfegpKlMPfWq7rjj9yaha+SmB5g3WZxhEKWP6SjJvcB3RiMPTg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5UyOlM5lX2Fm8Drz5uxrA7+7jgQDcHWRdayvzKcV6ZGkjCQTE
 7fBQ5Plab+0svJ4rC0OfR2iMU9jPc+BG569zK0zYet37Nyz7pu6an2sdpXGCqdANmK9Kz8ibyJI
 SIFWVr+dlbdV63pzJ8OzUC99dz4YdTy1EpDYhPCJTp8BVAipvrcHLWFElcw==
X-Gm-Gg: AfdE7cm1sjaw8MJ0+A1aQXJ3OsgX5keDfZiBYjskEivFF/q/svE2+iJJ9PU1AtQfJWO
 Bpb88HUrtMOCAkLFK9pPiL/NcPmTSDQv9scgmP9znuJwtyo1JonoEPowyvamUc2Vae7Xj2M0yAF
 RHpR9EBhxODefYNfOC6AatI2W0APhdVTvAi64xR5R4F0oAoRocilzfvsLFc4ZRkxchBvDEQF32q
 MRvIu+D71dUjHjTu9Ma0uQcyqlOZKSh3CmIbymOV9kQ2J6m8c5UBszomUfheSJHKdLMkHFfUQR0
 K3CSXA9R6LQVg1cA5S5esKQ+VYllwOb+1TUqgFvYqrOW7Fmrb2XzOLHNmFPFw1J8g2hSgMuUtbg
 064G530nruisdoF4=
X-Received: by 2002:a17:907:170c:b0:c12:1e33:8590 with SMTP id
 a640c23a62f3a-c12ae48da5emr219921366b.14.1783003945187; Thu, 02 Jul 2026
 07:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com>
 <20260701161838.GJ749385@bill-the-cat>
 <534ff837-08ca-9d95-c53b-64466fcc8aa0@nabladev.com>
In-Reply-To: <534ff837-08ca-9d95-c53b-64466fcc8aa0@nabladev.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 2 Jul 2026 16:52:24 +0200
X-Gm-Features: AVVi8Cf_1hzFGNpInpJgsbarpxLI_1x9qEQOtrG_Zsw7bIB8Q20UhultvIjcrvo
Message-ID: <CAEHHSvZQTE2y2HyzpB2YTXYgWTE4W4CP5Dh6j8SkSCHt=pP2Ag@mail.gmail.com>
Subject: Re: [PATCH] cmd: kconfig: i2c: add DM_I2C dependency
To: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Le jeu. 2 juil. 2026 =C3=A0 06:30, Heiko Schocher <hs@nabladev.com> a =C3=
=A9crit :
>
> Hello Tom,
>
> On 01.07.26 18:18, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 05:55:14PM +0200, Julien Stephan wrote:
> >
> >> CMD_I2C depends on the DM I2C API but currently does not enforce
> >> DM_I2C in Kconfig.
> >>
> >> This can lead to link errors caused by unresolved i2c_* symbols when
> >> CMD_I2C is enabled without DM_I2C.
> >>
> >> Add the missing dependency to prevent unsupported configurations.
> >>
> >> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> >> ---
> >>   cmd/Kconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index 032e55e8127..636891ed493 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -1392,6 +1392,7 @@ config CMD_IOTRACE
> >>
> >>   config CMD_I2C
> >>      bool "i2c"
> >> +    depends on DM_I2C
> >>      help
> >>        I2C support.
> >>
> >
> > This removes the command from the handful of still legacy I2C boards:
> > $ ./tools/qconfig.py -f CMD_I2C ~DM_I2C
> > 15 matches
> > MPC837XERDB cl-som-imx7 d2net_v2 db-88f6720 db-88f6820-gp inetspace_v2 =
ls2080aqds_nand ls2080aqds_qspi ls2080ardb_nand net2big_v2 netspace_lite_v2=
 netspace_max_v2 netspace_mini_v2 netspace_v2 work_92105
> >
> > So the depends on needs an "|| ..." in there, for the I2C but not DM_I2=
C
> > case. Thanks.

Hi Tom,

Thank you for catching that. I was wondering if I should handle the
legacy devices..

./tools/qconfig.py -f CMD_I2C SYS_I2C_MV ~DM_I2C ~SYS_I2C_LEGACY
0 matches

So I guess  depends on DM_I2C || SYS_I2C_LEGACY should work?

Thanks
Julien
>
> Thanks for checking this!
>
> bye,
> Heiko
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C7C2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0EF885A8;
	Sat,  6 Jul 2024 22:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xj02aQD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3848858B; Sat,  6 Jul 2024 22:55:14 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E6B885A8
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ee92e3a4efso3091351fa.0
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720299311; x=1720904111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co+E7uDRZ4LjqgU5CjA+4bq/z8/tj+FCl2LKkuxXeYA=;
 b=Xj02aQD7bX8a59fRIxIBmgoQ1dVbBgy2N5KXLT/x956uOjl1E8Vs0k4GWwzydxQGZd
 mYY57HPO1F8UOZS8m2Jeleczs5FYVEqp4sOThDcypVl6oMs//VIszughGitSdxs6jo4m
 et16riyv5x3muPGtdLmjIKuUWJQ0WefPuvKtLmeCiYAAL9TU5z8MZFTvefF/VuwrkutL
 TMl8+oc3uYhQa8E8Bfx1clCDeNhzStzB9rRlsHeHtD8ys2G+piDdL2DhOz3Glc7QUxWw
 ZSUx2pVOejQUV8Vo8lvNkrP+q0zH7eUpEURub/ZXpbVj599Qv8I78DesrfMVXBBO9/xx
 fjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720299311; x=1720904111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Co+E7uDRZ4LjqgU5CjA+4bq/z8/tj+FCl2LKkuxXeYA=;
 b=EH/MzxdtBSTJBYjlTF/Mi89EATjJ/SV6SYa6xyahMnFHWiM8vSsTd1IIzJsIG4h4qC
 eI3B1g/U5MgEMquur+0gXUfmpG5R11AEag63nUNV2TL4qXlVdxrCuZG3jFY6Ql39dW4D
 /xVSxyWVUbBf3/Y5iNRin7RRmRxwP6O/NZHPz8O8Dbor68eMGF/6pJzoshqNNKwI4m4R
 FaQTyvel/f2TLyV288nPjDv9aVOaz3OYb5WgDuM4ZB5LgUYB4qVdYQDCjoQuwEUdKgr2
 12en9MrEEOIh2l+OP7b+sUGlnUfuIkRuH3BbL0uKP9Pzsc/FQ7VVaI+oBwlj6eWd1x3N
 o6Mw==
X-Gm-Message-State: AOJu0Yyg60drDNz6YQT8gONxz+1qTrwZChxgeQbQFra6xF0ESkTjuRs8
 WkeVPqmyz4DYvUDBX9bv8FK1cudZmbqk2UNrNoOSKAT4tVjcspgtBbE1balI8wRP+6HD0FUi6oz
 v1OEYGmLqlme+pkLXmnBG3E9aKI8=
X-Google-Smtp-Source: AGHT+IEbbwU/RUAK4qs9A8b27fVlsGlB+C9NpajRWodIMma1ZyhGnp0M7ndlH+mISdj15foxv6ERFDOfXB9WsZMRmvg=
X-Received: by 2002:ac2:4ec9:0:b0:52c:d5a5:bf7 with SMTP id
 2adb3069b0e04-52ea073559amr4586589e87.4.1720299310655; Sat, 06 Jul 2024
 13:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240702153739.2651815-1-sjg@chromium.org>
In-Reply-To: <20240702153739.2651815-1-sjg@chromium.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:54:59 -0300
Message-ID: <CAOMZO5A0fgwuX_EFwUoi2EZkw0MYXEhyX7jzBctXbmxeEM_p6g@mail.gmail.com>
Subject: Re: [PATCH] mx9: Correct repeatable build error
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Hiago De Franco <hiago.franco@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
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

On Tue, Jul 2, 2024 at 12:38=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> For some reason every second time imx93_11x11_evk is built it gives an
> error:
>
>    make O=3D/tmp/x BINMAN_ALLOW_MISSING=3D1
>
> It seems to sometimes skip generation of the .cfgout file and then
> eventually Binman complains:
>
>    ValueError: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n
>       spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000
>       ./mkimage-out.spl.mkimage': Fail open first container file
>       mx93a1-ahab-container.img
>
> Correct this by using if_changed instead of if_changed_dep
>
> The only reason this hasn't come up in CI is that buildman did not retry
> failing builds of current source, but now it does.
>
> Note: The logic in this Makefile should be moved to Binman, e.g. these
> warnings duplicate Binman functionality:
>
>   WARNING 'bl31.bin' not found, resulting binary may be not-functional
>   WARNING 'tee.bin' not found, resulting binary may be not-functional
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

This breaks imx93_11x11_evk_defconfig:

  BINMAN  .binman_stamp
Wrote map file './spl.map' to show errors
binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n
spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000
./mkimage-out.spl.mkimage': Error: spl/u-boot-spl.cfgout - Can't open
cfg file

make: *** [Makefile:1126: .binman_stamp] Error 1

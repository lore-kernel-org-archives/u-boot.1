Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD79DC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6C884712;
	Fri,  8 Aug 2025 14:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K7p7MADO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2622B84713; Fri,  8 Aug 2025 14:57:11 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E95846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-332559ace6eso18764251fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657828; x=1755262628; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b99YOK0sT/oy7chz/m1q22nioG7DZtR7yU8/+VH0sxc=;
 b=K7p7MADOkHPVnIPWcS9WiYw2QQMOZw9WkAE1HFSILc6ebmhRWOWqrwmxVA1d+E5IHI
 0amfwoXMpJ5zY0IuPwklKrr9Y5r1H7WPNNdF8TSscBNmvDvSaaQRCsxtfrVso28U1Nj8
 rNNQwTKqJo/y6100ywwRnrzx/WDmJSqiM3VeFKb5ewZeElpaHqQkKUagyZQvu6LrTLgI
 d2nU4w2aW2vPlVsUQy/yCPe9EDWmrvPXKvbhlRgQdFncKoQ0tqk2OX3Akg6C4nropdpa
 DKPbZjjhVbbux1AQl1CbUhMTr1+IjS2qz0cW9pdD6VyI047dnBjTAu9sw79oTyBFDwhg
 fBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657828; x=1755262628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b99YOK0sT/oy7chz/m1q22nioG7DZtR7yU8/+VH0sxc=;
 b=mVqqDzzIc6G7L4OJENwNQwBB1jcrNpTS327LBhRFXhMTcI+Wo0vvl5cw16i9z3Ytez
 AD2iID0NX6vuQlzhjiYPmg078cg5r4opg6uv4gB0GiMRCCZg9ZQjMux/tP9HofslYBld
 YByuOgkHthF0TfNVCA1MRoqjoZCxoyrSqyIHxrsttX0ayqrffKOXWPGH2IxjyvFhFtKC
 wy7KfPYo3RRisHI2ngKfc+DFtJWKlfzJNgAX/LomAwzH7MP3FLSLIEG0nHb68R5epAVb
 rvntMlUutI/3ZtlsGIhWo70w6woCf2IrDq92RpCsa/6A4LiJoySDXkvcLAea7KR5q5J3
 WPCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAFthDgfOw3X+ehQn61WpWA31lXFA00pzhRmxxFCQ77lCRz2JKJGiPIf0Zv6kkBH98ZmHbV8o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1lWt4qCylbssnVdHOD08ZnFykdDVJzs70RJKAJZjZvxM1OlQ1
 uZZFFYwVq5zT2qk+LW4VZKWX7l64M8+UNlSvYQG3+9ubw8nv7+jEWgVAb/yqbnjs/ST37akyUAF
 FOMX2h6UGYx5x8O0e3bqkLAvNY3ynqOY=
X-Gm-Gg: ASbGncvj8ueu8RMAKEdIYtYxjMtLNE1u+i4fR+aLcBuX1RYKEZcneQl1GyS3sr9d8X0
 4lMTs7/SkKTSsP5FCFybcDZpwiwHK3mBEV6OSH5R/2AJ35OX+LqFnACJoL//DpZLfLHG/oqSgvr
 4daMTsxtRPLp59YaP/ZdO35ubqLOdi51O74iRcP7+n/5A8kOuC0RBI1UQzUYEc0RMKlHolY1EjC
 pl3kEvSPjasGVqeBwL7qITfy4PyzHTh08EsIw==
X-Google-Smtp-Source: AGHT+IHGqk25bhDfBk83BRSBHjYGeki7eYKqKwHFeKU5hKZW9/VDQmch3Ve9iO9MXG+8ZlANjV6If8N5UvHf3EJIY9E=
X-Received: by 2002:a05:651c:410f:b0:32c:abf4:d76a with SMTP id
 38308e7fff4ca-333a22cc380mr4237381fa.38.1754657828194; Fri, 08 Aug 2025
 05:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-clock-imx8m-v1-1-1aa0ec77305e@nxp.com>
In-Reply-To: <20250728-clock-imx8m-v1-1-1aa0ec77305e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:56:56 -0300
X-Gm-Features: Ac12FXyGNJbWgqaSMmgJS4Ta8CQaBi3GxzwmMkaSr354YDEYcctK0AKl936CuJE
Message-ID: <CAOMZO5AUwF1sCNHJo9mwsH+-dfAYVPg=y5myzOJx_84LNTmQVQ@mail.gmail.com>
Subject: Re: [PATCH] imx8m: clock: Correct imx8mm_fracpll_tbl
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
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

On Mon, Jul 28, 2025 at 6:15=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The minimum frequency of Fref (Fin / p) is 6MHz for the PLL AC
> Electrical Characteristics. Setting p with 9 or 8 voilates the Spec.
>
> Update the settings to match Spec.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.

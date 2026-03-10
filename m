Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D866FD4F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE89684118;
	Tue, 10 Mar 2026 17:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J2fIXsul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FB984120; Tue, 10 Mar 2026 17:12:42 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D93C84101
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-38a2f92fab4so62633861fa.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773159160; cv=none;
 d=google.com; s=arc-20240605;
 b=E2HbAqME6dSOpsw6cuN9DELvkv+3hjXNmf4xwUNIQ1vK0R4MZ9+HoI4R+OoRlZwmTv
 BU1zGwDtXvOf3xxccpIESyU4WlZMssupS/JseZLsgAiCox+AgBuswg4Or8aSJ5LWLmPS
 62IPt02DY+nBVuVnRUqxFn6wKxU1A9TqL3ulSbCu3BP7GdHCAfy/L1CakrfkX4ukKcac
 qyaCjr8deYK8Zn7LihHHkx/sBPEcAoWrzNlNNk7Qb6U6U8QcV4B589Zv9Y5hNZz9Qsq1
 XazWwvPC/c4cPs4ZtpZjyG8WlJipgtSLpZFK7r0FXNoDztLKwxNcmfyXuT8eqxXCKJzq
 YwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HkLunpzi2enZUZJG7c5KLq5BCos+HIdY6nOMMkJywFY=;
 fh=KqGinA8bjcfKc9LIU0Ugz8KXwcUZZ4fsDK2RA7g3dEI=;
 b=GTYPg5AJwNSYjimdDsKhIeGTFtO0sMFdwZaUfjlj3KGCwzxd5qmDL5PPvKqDEt6rGI
 Y3FjaX0nNhKCK4zDwd3tkUgmPGOiN3ctGyH2EyruTnvlbhtVzpYS24uBT3FQJQYEeQeX
 sHfZ5OYUOaQfVq60b33ZxxORN+OOqxL62asuS2GEGu94LDdfjeOMeN8kJ6yi9gHToi8X
 g7CwreWMK9KczuTtuVcLQVsPjFQ3Ia5Gfvd8xLfcm3UncgOHMzfVuDzJYV95wm/4iBXn
 MWf2YrjNTyR7POtSpLSUbrmhwZUI6QZZxHYlcHMhWzcQfAUoVRsEo2mEDT0w84KS8I7U
 RPyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773159160; x=1773763960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkLunpzi2enZUZJG7c5KLq5BCos+HIdY6nOMMkJywFY=;
 b=J2fIXsul77bj93JYfcASlrB0mSbdZYyd/GKgkMEx0+b09eXj6EDzS2tegrtWbhx5co
 Xota2UE7Akbu+j6JyquNHVbfredJxS/QrPQFHjQC0Ig1XDmVIsYSvaW792IwXdgvod59
 RpOYZCV/2pWv/aSpVlfFtTSLbJYs3bcFma1oLxWpOCD16IZTPmEJWCXo+dAMmArBORhn
 1mm+lRmihvlPqGc/3vzaC4H1XYn+SfeRPrgCCxX/3P8iNaZRGVWSMMN5MnvtcQZL9KJB
 cOj+HdNrIiWHLlEPr5WHvzH9IpOhv8oiFzyxOUTPRcUXrZMBV/+RhuAfq+1NQR3o6aQ0
 CcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159160; x=1773763960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkLunpzi2enZUZJG7c5KLq5BCos+HIdY6nOMMkJywFY=;
 b=Ke033yfr8v0Org56Zgu9D2IjozYGXPZV/zg1xtLJfrCDhxcSNzfEsLr8Bu49xJ16NP
 Igt2h+lZVdwwAG2v4mLkEfZWDY9Wt+q1paFNVP8b9umHHrLE7oton++uxvzjFWdOFAkS
 WRolaATOfk7ics3GfHK8Y6jD+dw5szQpTYpXpn0I7DnDIzlR3oEraT17oKDrCyTqYDy6
 bZF2l61QA4vkp9wa7e+RIRKzLYmQXrymv+DTJRW6Lc3tDKbcYeblqHcr7y1QpguU05Co
 Bzvi/QrhNnccwOXc0C82caajBluccLw4mwqFreNgtBqemC+oeDuIq5G2aTe20Tm2KLMe
 QvIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu1un+6JKX/zdX4MSQBOk4qzJ7o9YqVOFNI8ilQE/TQUtfLaiI0jeWGjfe4g8WC06n3sbQeJ0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7QFFlZhrlSCWZR9iHA0B14HUUKjDXVY69P3m72iRWlaMizsNX
 oyrPxzn4fqNayx52BCaoN/eK9nFLvk/Yg8y1HCeakIl4Iwvx4t4Y9hkDx6nYlOW71bI+OQlwicy
 BVFUzQbjvy27kOcBzCzJTjfgdahtuK30=
X-Gm-Gg: ATEYQzxRQY51FYC2LVnIRqbp6GrMnhdmND3zXi90TBb2uaI1IuMDxIPshTMUl0RGaYJ
 964VN3UeaUlk8m1Rxz/4GYDTS9yNO+D1ZaUl0nF78a3x7v65186hWXdR4lJykWD1wJkg/tcezrU
 nfDDbfKzHme2ykLDswSw/FqVHi8969N2+AjceXe0Hzx1gfetzFzPPE75U5XnhOYjQUJRn2qn+wb
 BxqxNi6fSl21ChAhaX07ZeV+9vrydyuQnS/t2BC0WXZPzegdVCefncpTdx64FxERC48zUkbrQ4t
 N8sceSFnA0j4ApRp71LUCwazOJAXxW96t8Q9e8fJt6uq3Fp1ALyhfnkqJluk7yIaLjgSPis=
X-Received: by 2002:a05:651c:210d:b0:38a:4de2:85f1 with SMTP id
 38308e7fff4ca-38a4de286a5mr35340501fa.32.1773159159422; Tue, 10 Mar 2026
 09:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
In-Reply-To: <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Mar 2026 13:12:28 -0300
X-Gm-Features: AaiRm53ZMDf4qU9O8wS8JGXHC2ARr7-TMLzhK5BgVLOUPCwzczwc26Dq9WP-mes
Message-ID: <CAOMZO5BRMVV=NW8Si2fEK0P5BmWHiPJb9zWqT+v7hES7U5Xu8A@mail.gmail.com>
Subject: Re: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, peng.fan@nxp.com, alice.guo@nxp.com,
 ye.li@nxp.com, 
 simona.toaca@nxp.com, viorel.suman@nxp.com, marex@nabladev.com, 
 ravi@prevas.dk, fedor.ross@ifm.com, sebastien.szymanski@armadeus.com, 
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org, 
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
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

On Tue, Mar 10, 2026 at 8:44=E2=80=AFAM Simona Toaca (OSS)
<simona.toaca@oss.nxp.com> wrote:
>
> From: Simona Toaca <simona.toaca@nxp.com>
>
> Call qb save automatically in the board-specific
> spl_board_init(), if SPL_QB option is enabled. This
> makes sure qb_save is called before any image loading
> is done by the SPL.

Why do we need this? What does "QB" mean?

Please improve the commit message by providing more context and an
explanation of what you want to achieve.

> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> ---
>  arch/arm/include/asm/mach-imx/qb.h | 2 ++
>  arch/arm/mach-imx/Kconfig          | 7 +++++++
>  arch/arm/mach-imx/imx9/Makefile    | 4 +++-
>  arch/arm/mach-imx/imx9/qb.c        | 9 +++++++++
>  board/nxp/imx94_evk/spl.c          | 6 +++++-
>  board/nxp/imx95_evk/spl.c          | 6 +++++-
>  6 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/ma=
ch-imx/qb.h
> index 5efe68f0a60..4f923d79e7a 100644
> --- a/arch/arm/include/asm/mach-imx/qb.h
> +++ b/arch/arm/include/asm/mach-imx/qb.h
> @@ -10,4 +10,6 @@
>
>  bool qb_check(void);
>  int  qb(int qb_dev, int qb_bootdev, bool save);
> +void spl_qb_save(void);
> +
>  #endif
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 17aad696648..069b25c6241 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -71,6 +71,13 @@ config CSF_SIZE
>           Define the maximum size for Command Sequence File (CSF) binary
>           this information is used to define the image boot data.
>
> +config SPL_IMX_QB
> +       bool "Run qb save during SPL"

What does "qb save" mean? Please explain here and in the commit message.

How does a user know if "qb save" should run in SPL or not?

> +       default n

No need to pass "default n". Drop it.

> +void spl_qb_save(void)
> +{
> +       int dev =3D spl_boot_device();
> +
> +       /** Save QB data on current boot device */

Please use a single /* instead of /**

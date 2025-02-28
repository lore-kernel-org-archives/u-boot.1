Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A8BC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2346E80AE1;
	Fri, 28 Feb 2025 20:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e40oKg5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD670810EB; Fri, 28 Feb 2025 20:47:42 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9962F809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5494bc4d796so1703773e87.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740772008; x=1741376808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inQkP2Dksmb0fw8C9R+yOAQwh3cEEzGkjLJy5/rLucE=;
 b=e40oKg5z8E6/Kzc1hEtuEk2bqQqxqX2patzVYtCbXd8OJHfom/Ot6Z1QSn9W5ladtB
 DlKGMAz70tI/MMDWfNr3Yvlrn5aa+6NdG5SlXuYu1+b4R2AN0/fdY9r4ztuNH4PvH8rD
 wteEG1+11CaPmVp2HcQErIps367s7F4We9/PmEL8BsDouyUfaJbhmwQ1OpS0AzJjmvUr
 lW5hN5xXThv7oqDqKAm9SasMBk4sIKRb5k/GX6alk+8LZKQMJLUiVmwupzXfb3PVlQzb
 k3xoJmyvi23x2iACdLHV3CC0L6htu0XbXmCEInE7stMyUtpH0C+BaaWS22wvVX2VkBge
 sgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740772008; x=1741376808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inQkP2Dksmb0fw8C9R+yOAQwh3cEEzGkjLJy5/rLucE=;
 b=tGl2gXP7RSb5yCertBdl8UeA4ZjVLWbehC42Yi5B8m3tEfhjDfaiFj1LE88SvtI+oe
 jaf/mHC6wGKC6ckHzy/dzJxDnl+hr9VOpW2eGB9ysEILio93HCTQ+JdT9IuiLgkr1sqM
 mUkNNDd9v45/wvHV8Rt7HbTEzPsdS3bXOJ9XZROaOhkv4LE9NOdS5I68Hfy9Y++kh9FQ
 GHVvaY42EyfYq97Zs4witvx1JzQ0NFV/VoJ4J5AXR9+8TKzAxJXI0HZiDlTAgC1B2b5L
 7pExGgCxm9rqsMbxo8ApjJTjpvxbfuBXMCOKMXhQo3SmvEQ4lTDv97QiSSfEVYvROoAT
 kUaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUf8ncUBUG8Z4M59BMOFaktfrgNaizWWqWoupaEUjpxvjZjcoI58uwzPxF8MphO/F0opQRYI=@lists.denx.de
X-Gm-Message-State: AOJu0YzwOBKY159HJrT4Er8OUuMBxswgd4G+r1usSSFmFXIMJ4OXyNVB
 lV+SLlRzuV9RZrU41lKNv1/IYntavrt6RANdL9+JDHPwmPb/dXpfTjyk7EJNv7ivhbAbcch4asF
 iTTN65Of41v+070pBbAktKuXwPUo=
X-Gm-Gg: ASbGncvHuUK6kTw7ThSOAbPyXGF55tdLMruqJNqjjk6TX4EU1i5EJj+Xo7RskFYem6W
 Hx0UqF0B6ZUmvMxas28W/SrWqjOl9yrLkvFClhmW/KV/rbEGpPnB3GpwSX4ScLUL9/rqYMhTHz9
 MzRXhzM6Q0cYFzwOYJIP8HG3D2+eA/HR3Hx4O8kQ==
X-Google-Smtp-Source: AGHT+IGvP/x1xDa1cHAyq41SsfJzqEjGnhaMHvJKmkmA0gkcbWB0ZL7Ronk0B4uHsjUpgElRlhfIN1/PMnRM84Y5yEQ=
X-Received: by 2002:a05:6512:3087:b0:549:5866:6489 with SMTP id
 2adb3069b0e04-549586665camr334856e87.47.1740772007620; Fri, 28 Feb 2025
 11:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
In-Reply-To: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Feb 2025 16:46:36 -0300
X-Gm-Features: AQ5f1JrqCvU0YchobOfrkR8WwP3oNJHUNfOqzqFCYHp_2-dQXFnovwYxNZS1hOo
Message-ID: <CAOMZO5DU6-_L=8XiyMyX8eP4D6O1KqbE8PTNjKC=pafFkE4wfw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Support Apalis/Colibri imx6 v1.2
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Simon Glass <sjg@chromium.org>
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

On Fri, Feb 28, 2025 at 6:53=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> Apalis/Colibri iMX6 V1.2 will replace the STMPE811 ADC/Touch controller
> which is EOL by the TLA2024 ADC and AD7879 touch controller.
> To support this new version, we detect the presence of either the
> STMPE811 or TLA2024 during boot and set a new environment variable named
> "variant". This will allow us to select the correct DT easily.
>
> "variant" environment variable behaviour:
> - Empty or absent for all versions below v1.2 (STMPE811)
> - "-v1.2" for all versions starting from v1.2 (TLA2024 + AD7879)
>
> This behaviour is then used by the PREBOOT logic:
> preboot=3Dtest -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${f=
dt_board}.dtb
>
> Ernest Van Hoecke (2):
>   board: toradex: apalis/colibri imx6: Detect new v1.2 SoM variant
>   toradex: apalis/colibri imx6: Select correct DTB for SoM v1.2+

Please run /scripts/checkpatch.pl and fix the following warning:

From:/Signed-off-by: email address mismatch: 'From: Ernest Van Hoecke
<ernestvanhoecke@gmail.com>' !=3D 'Signed-off-by: Ernest Van Hoecke
<ernest.vanhoecke@toradex.com>'

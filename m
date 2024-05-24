Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EA1C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BE088646;
	Fri, 24 May 2024 18:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="He6fhHZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C5288278; Fri, 24 May 2024 18:29:25 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74B988168
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-68196aae27dso102636a12.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568160; x=1717172960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CjNQM+4MJIu4/KMm19j3OsSz2SPk+AwDHLKXFbK5qg=;
 b=He6fhHZej1XwRc4lX+pB7wBMy98R+p6/Sf4TIkX40GamFqvhNk9RzINdk0H/eEu3Wh
 FWck7fLQUPe/UFhTOhAzW7MmG7SlP6/g5jsXH46jeSKKfxCQiRWGowc2+EIru/c3lWqs
 TUT/DRA5RXd6bFVfwDtcsBRoiDoSoXXGh5C5A0BT0iHA8zUbtOkkv/8pjwNMzs9k7d14
 MtXQD97DdROafbCm/4P6w6cMCQ5GzdGEqDHLd5cJQRVEdpJEidUR4iYFM3R07p/YdI2u
 MlxYc1qWAiR/gqzmztqfj/EyyPx7od6v2clrmyYlcIW4S/WuuJWjt14afap8+r6G79Eb
 uruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568160; x=1717172960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CjNQM+4MJIu4/KMm19j3OsSz2SPk+AwDHLKXFbK5qg=;
 b=Dda0PLyqFk1oKzHRQUzqNRekftE6aM1sSUCcH3adG2NMiCJugGFvfazRTdWTljuCw8
 tqHyOCVcZN2W56TOWLsHOg4RbBz5PT+Oy3vQd+m4qeD/LQcdLuNKcVh/QojaC749efw7
 J/i5lVYs4jxVnnZljlHcNZCBR/y8yMaB0bahA4VJsohNhkHxEFmr8HGU8laXWnvEDt4B
 gEvxvtsOBa6UPh77FnEwvhQQu0pi1glz5F/yQ4JuuSC8f1DJ5lZ0LDTIeyMCLpN3MB4c
 xtNootmq3icKOLZat8GO80kFuIhjNb/zV7fu3Br1Tbrla0tqmZNucaFak1yThTIAVkDv
 O1qg==
X-Gm-Message-State: AOJu0YwYMiVitllXUdgelC0wrl/RR5PLn2Elbv05e46saiAanooizuuZ
 AbrTBXfaxhSrTW2SAFnEO8p7OOia57xWCgCKURq3tD4rz2+wqwGcwqhgE5XCF0Zy2mPdHfNXcTT
 dwfRvhAW5XlIWtNszkf7TWyyf2kk=
X-Google-Smtp-Source: AGHT+IFcA7LHKjE30dScSvgttfRWszZedbyuptHvE0m+PGqevVEKsp584Cp99YPUVdZzlqrudRdpy0gPY1HGbecFLpQ=
X-Received: by 2002:a17:90a:6d22:b0:2bd:df8b:4ad7 with SMTP id
 98e67ed59e1d1-2bf5f407f12mr2572340a91.4.1716568160221; Fri, 24 May 2024
 09:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240521094108.8858-1-marex@denx.de>
In-Reply-To: <20240521094108.8858-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:29:09 -0300
Message-ID: <CAOMZO5BYCEtyGTvOhtk=y2r=6boS_dA_yVRFg3tLo_tifxoeLQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx8mm: Update iMX8MM Menlo board configuration
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
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

On Tue, May 21, 2024 at 6:41=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Synchronize Toradex Verdin iMX8MM based MX8Menlo board configuration
> with Toradex Verdin iMX8MM and enable convenience commands like cat,
> hexdump, xxd.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.

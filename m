Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD19DC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5382B810EA;
	Thu, 27 Feb 2025 15:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mif4YRg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1DC3810F1; Thu, 27 Feb 2025 15:21:35 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6DC580F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5462a2b9dedso1016908e87.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740666084; x=1741270884; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8QVL4GfpCJVZNvToquOknsKpYyFJnqE9psXOjgce/I=;
 b=Mif4YRg8eL6UCiC73IlIBrgZ/feKMkdQOfGlSOOFAOLGsliBIGUpNDzOLUBB1Y1CGC
 CaqX7RVAmkgYSi7etFTxCHThnVLAWVJmlY0qk3uO8XG0QRIWxxhrpthieah5aSUO+FZA
 ugoVGlkLt+Nk/EJxJMS1omvNrlYgvVla/VCf6GyaNMCQAVp8rGJttQOpbCM4Gz7PFk5H
 Mx/Evk0KM+eUBg0xSEaO5HorUDu1UNh800/PhXfH/lhgh8/E/9ftO7dYIN8SjP3ma7Ug
 I/Vz5FrsENV9IDEGM1lkiZzA5rI84W/WDQCf2SCATiJehF1ZAr7dYD1WupS5J2iaUcao
 nMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666084; x=1741270884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8QVL4GfpCJVZNvToquOknsKpYyFJnqE9psXOjgce/I=;
 b=DGvGS3h34N5+CA4ZMp4siFyZt3sq8tuEZohA0xx3CUryBFyrm6CpbVyBVT6NYSSNGU
 sA4OZzq49eA7+1SeiTlHDAdLGqtFT7yZIBjMVjV8+UrL7kQ9GbNCLbauTJEG1UbDMqc+
 75OyvslJy275mmsm58Y1zhKslCmOnonfJwA+kMNn5jP1h1RPaopRTNglk6+V8pvtRv4B
 1GEEydNhyOitCvMrdeUd59vw087zs0/tWAo19XJ2HYRYR3z0m20Yg5Sr1tgoBWvJz5Kp
 0Gzm+aMkT6kr94mtvwTAt6nSvYbU7XKrMbBSQietVTryR4SzPXyaXRjDDTpcClULRDGJ
 MfgA==
X-Gm-Message-State: AOJu0YwA8zY5LPZlnUhdh7YMuAl5OBgO7F+ELSrAK+Z5GR1hG3ysYzUd
 6y7XXrsojxsOeMzbVAhzK8F+260xIH0Msy8eqLdJvK2mhiyp0FLIF90R37kzXUQOUx2MZfPLImG
 XMOwdaHfY8ZWnnGdFTkR+bxUHEMc=
X-Gm-Gg: ASbGnctMNx7abn8Ht1peucu25Y7aCDlc01ZFR9b966YpngPI8uXFQPOLp0O3cblLrKx
 dFSEb8RXFQ+B+IL4Cl7sNMRtGe4TqwLZrI4BSSHt/uGevIOL0Ujrm4XIuelm+NbtgE7EhQ8eYj7
 rx9TmZTFgaIBAgey8UBDD+qeuL1b9Ec7osydNxPhE=
X-Google-Smtp-Source: AGHT+IGeMa1+T7+Xgh+TVx03lM88WpiwRqL8QJt4rYsqLYO0NnrCDWIp9JCWXDt0kpRWTZLR7b6fyYV54GAWOfTNQ2Y=
X-Received: by 2002:a05:6512:31d2:b0:545:6f1:9494 with SMTP id
 2adb3069b0e04-548392685bemr11957583e87.35.1740666083771; Thu, 27 Feb 2025
 06:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20250127211950.813813-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250127211950.813813-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:21:12 -0300
X-Gm-Features: AQ5f1Jp1e2zVRmCX9t3IKz3GqDV3A7c3DbxbVMrfjoAwidkXSDQZX1XtA06n73Y
Message-ID: <CAOMZO5DNajOAiNGk9Xr0bty3fyd3xWoZ1oYhytMGzB76RbK=pA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>
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

On Mon, Jan 27, 2025 at 6:19=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> The device tree for imxrt1050 is now
> available in the /dts/upstream directory.
> Migrate board to use OF_UPSTREAM.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Applied, thanks.

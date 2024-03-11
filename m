Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8244FC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01BAC87D3C;
	Mon, 11 Mar 2024 14:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dK2YtSji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D88D87E88; Mon, 11 Mar 2024 14:08:51 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B2F87D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1409788a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710162528; x=1710767328; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEYupDDSrkMm2rHpSrMd/b0xaqZpQEeatlz8nsQSlMQ=;
 b=dK2YtSjiinBw7nisAkO1cLG2rOUu09maG+McOGZJFoCVrydWbKWiqAm7QaBeo0dAhI
 tUmTKXXpsyRORXrsjOb4ksBBmPPK5i4/7sVMbwOkKykmjWNScPMYuvykx6P9x4XVlmzt
 ILJgcC5T8LS+hmQKhmRE4b/+OJ2XZHKJbNJkm2qQ9oBBd8NjBdl6mztcoG3KloQ5ll7H
 /aMMpo2Ww9GXvWuAomkpLP5/JzdS1Y+gue6IaIsHxNpStfwY97yNr6LLDapjuUh6s97C
 aspkQ9bwRjIwT5JEM4hj6z78Hyl3g+c2cE2DmZk8Hdk/AhVbJ52uSmRNRSL68uyESKDA
 YfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710162528; x=1710767328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEYupDDSrkMm2rHpSrMd/b0xaqZpQEeatlz8nsQSlMQ=;
 b=tNAHJw7U7Yx7OpkMjslN2z1uw94bc9Glkmc3LkjIkN/yerIGhHQBvrsiepou8RmT1R
 cIbN6dSX1isNND+XJavXuehquVvc5mplHvmmYmoPE08rx+nqCPF4cGP9hpuzJJ+BT3el
 5GDJkglFAao4HFvatYaF/jsS6Nvmo9OPxaDzg5qeEjKtapeCA/OlcHER+zCD6PNQdqet
 AvxmN9F4gU3U9zPeWlF2nPI7Vz2yYmQ0HD0TpWg0cF2Q6dJzqxkUDHXYVd0hZwf10SKh
 JDdJx0pbmIGzznJe+KhXCOaZEc+qvI1xbk9M+pSBX/OeTxUAtKSVT6jkckORZ3nrGXqg
 GpSg==
X-Gm-Message-State: AOJu0YwM9YlNWuc+5j3kQ92mC4MHlWan6nQmt40MadJ/Qwuc73AFYMoY
 p/pI38ocfsUIn2PuqP7ik/EmCflbouMw/kbTA7l0Ygzruu4ir8dTyk9ZjfWYnIRnwng7tGzaSwJ
 qOfqOXlYRRdw6xf+O36JfNV+JPw0=
X-Google-Smtp-Source: AGHT+IFyXnRUcY1gs/yVofIYlecd/y1VBM/rY8tUqP3SwrCej2rljNLS3zsiQC24V3NkVK5YqwkPSuun4hVTuu1Mjpg=
X-Received: by 2002:a17:902:e98c:b0:1dc:6941:cde5 with SMTP id
 f12-20020a170902e98c00b001dc6941cde5mr6908383plb.4.1710162527829; Mon, 11 Mar
 2024 06:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240307115859.22198-1-aford173@gmail.com>
In-Reply-To: <20240307115859.22198-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 10:08:36 -0300
Message-ID: <CAOMZO5BNbfUvFYR6aP6f-kx8TmPuSZqM6LVyu9zLX6WGCcAiaA@mail.gmail.com>
Subject: Re: [PATCH] configs: imx8mp_beacon: Fall back to using TF-A
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

On Thu, Mar 7, 2024 at 8:59=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> When the board was originally added, it enabled some features which
> allowed it to bypass Trusted Firmware, but as the feature set of
> Linux grew and more features became available, the U-Boot config
> options which bypassed TF-A caused issues, so it needs to return
> to the standard operating mode of using TF-A or the system no
> longer boots.
>
> Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.

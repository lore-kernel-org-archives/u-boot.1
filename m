Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5982DD0C61F
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF81588FE4;
	Fri, 25 Oct 2024 17:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnT04aIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5895088FBF; Fri, 25 Oct 2024 17:09:58 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712BB88B23
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso23073581fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729868996; x=1730473796; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUjqwRTRTw/U+nfHBcDkiMZ08jdJ1F5hEYX5ew9jRi8=;
 b=bnT04aIKe/cQS1bUkCjWGZUbJ1tFFZ6tVky7YbPNNxGbNI+qZ9iYfkx/ee+Ujm/Bl+
 jPeMSaG+96cr4LtxMstzHq5SmqJmeOGg817brOjnhXlfz5rD63dRVd7evtQieq5ZQ8BZ
 QhGQUVwUAEr4gkhhZOt5xuUrzy57bxyDEQ7OhsBdn98V9deprUYThBKf4Xm3MgxW10Rd
 ApEmMBjlUjhkI1ZlNvHbKD0Q5IojGNQNU4h1IRyWOPhVeRQYDcM2j8qTK4H58gqei1D6
 b3/IcCi4bozb3BFY++/gLMWDpzSaEJW85DBortxLqVcj7R6jeGm8REKH5kf0WieN/w5f
 sm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729868996; x=1730473796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUjqwRTRTw/U+nfHBcDkiMZ08jdJ1F5hEYX5ew9jRi8=;
 b=HIpZcNwjX8lBXOqr+7NGmuFP1pL8xfRiiDNXWSXX3auI+xd3Yv5Bryoc9xFdOSK2nd
 oPlLEY3n5U9PWQV4DLgX0MXJqcGPb/uaPYq0yS8m+manAixpSP2gona6H5NsfdRU+Wg9
 jTDHKhhvGJ8AV5Sz4MOiiaLXpTiktI2cKMaCOP307Kq/Vzl9AbTiYf432Iqhl9gzclam
 QMRulP5ZddHOEOFT2kBI8FT7+lZK2cy/Ghk8KPmMmPKGjBEouR0k2xWfSZfjWpr9xaAj
 Zw/3MGDp/y23Z05Jpnop1hm73atJzOa/gX5Q6itkTSmILkojWXbmBIjwv97Juxf+z0k+
 qg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN8xcFvNueCUxDOxBRK0eHSNI9rVrR994s3Vt0Yd1iKFdBac4X7IwJ+jOwxb8zeIc7458Rskg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu9+lrXnKUgce66sw0ZSPCW+XkCuI0lw6of0+H+hRH6GqrDam7
 U+Fv4JM4089C1UK0+H2YSIy7dAla1Ig3LlAs5IGJMvMFANeaulF4TmneMRFi+pRKb17t/3Cz7Z2
 8mebP1nSN5heCuEJLCIZFtKVcrYMgWg==
X-Google-Smtp-Source: AGHT+IF9DuOITTW7z+xtxQsCAAzzywDF94KOeJvKNw3eP/NDc2qomQ3/tfxNaBM4AB+bWBmtWOpsUKjPky4pshwRlx4=
X-Received: by 2002:a05:651c:1546:b0:2fa:c0fc:e3d8 with SMTP id
 38308e7fff4ca-2fc9d60a0f9mr56167481fa.38.1729868995423; Fri, 25 Oct 2024
 08:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
 <CAOMZO5Aae_0cDXX-E9syhVPwMF7_NVu2__40m6Tmi7daePyVbg@mail.gmail.com>
In-Reply-To: <CAOMZO5Aae_0cDXX-E9syhVPwMF7_NVu2__40m6Tmi7daePyVbg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 12:09:44 -0300
Message-ID: <CAOMZO5DNQ6cKyNqsQaU8CE-FwoOQdgaf99S8dQ4_FE9XZDvmCw@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: hs@denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
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

On Fri, Oct 25, 2024 at 11:51=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

> > > Heiko, can you check if this works for you?
> >
> > Works fine for me, thanks!
>
> Applied, thanks.

Sorry, applied it too soon. I see there is an ongoing discussion.

I will wait for more time.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C027CEE57D0
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 19:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D7288753;
	Wed, 11 Sep 2024 21:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jBJHQbA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43BE688B27; Wed, 11 Sep 2024 21:58:36 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC2F88753
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 21:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53661ac5ba1so206897e87.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726084714; x=1726689514; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8nM7m6/4h9H2zsRV3XBNzEKj8jgCAPaGJeK8Am7BAc=;
 b=jBJHQbA0f2iTsrNFLF4WXnOoB3400OD/h5Yzc5dM8glsqrDVgCMEJpO/7MVZ6W99Y5
 jm+gKZpwLCdkyy93zMjBGZkZl4U7UVj457qHnOk3P0a39b9+PPg7gAjCMtndqX//hpKx
 8W8Xc+lSZom5MGS3I6mjJoOOno03S0gHTR1W3NcUwbvLcG9pnNV9rP12Zy7OKA6fiRsI
 MOaKat0UpTGBoNoqMskN72hGicABER6aIjwDV1my2/t+hwtOGvYqY1JWN5pRssxAVs0G
 WXt+GjuoZqdxCCyAciEsSpv3N0eFyKnT2iXPopVzzLKiDNtqq8MlcSo3sfw814EMyavp
 9Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726084714; x=1726689514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8nM7m6/4h9H2zsRV3XBNzEKj8jgCAPaGJeK8Am7BAc=;
 b=OLSScSUHt/bhP9+iQUguyydABXamVqeL2Q4F6PQbjh7yyBoC+0s2m2YO1pfMiLM0Qo
 H7YsTRPwvHPVv7tMxRHGTNAUj+NlThrVbpvAUNa7uambPiXn43T5ZdH7nq+QbJWdT7Ry
 u1qni6+K4zN6pqhzHlfe6lRUG/G1IdBdsAkjWLLexljTZfm6zZbPP77VRVpmkezUlt9j
 +UjppFfeLLqDJ14Ix/HU4BPdMoVKyhTsrQmqCoChtBR6CrzqTD5Ayb+oCpW9m3+Zif8F
 M/dICmD5CqWmKJgTFfrd1KpRRvqhBGUOa5W2P6e7N3tuHQcUdbnZFzz3KW0kFJZPG1rP
 x2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPe6oUUUNZTnjm8tRg8lKJa3eCkCLzDnwwU+0pHpiZhseQ4FV3wRShnGncoO1b5Fp05dKq4ro=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2+vSSfxBef+on1Gg9Q7IsDDZjruM1HfrD4CrhewL/yHYdCXaW
 I0aIsv21v2RJQjF8gUcr9uCQZytOYU3YrWPiEQfrk4OdmvYn8u58Ks7aaqGqcBDyCnb92kbbAsa
 2wsh5+LPmRHjyZJzgzMmJwlAMhGg=
X-Google-Smtp-Source: AGHT+IE6f4Dmk/SzKzc4ZLaLW+HFd3TWO0ktI6amgOmc3W0pvS29fKG24l1Q0qGVYHlYuGnWT1mBbyRkoSI188ho7U8=
X-Received: by 2002:a05:6512:2208:b0:52e:7656:a0f4 with SMTP id
 2adb3069b0e04-53678feb138mr294844e87.41.1726084713578; Wed, 11 Sep 2024
 12:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-9-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-9-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 16:58:21 -0300
Message-ID: <CAOMZO5A8vHweYjKLW-Wpy3pMuX728CcTJeEFh-o4SJnh93wtFA@mail.gmail.com>
Subject: Re: [PATCH 8/8] video: imx: Add LCDIF driver
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

On Tue, Sep 10, 2024 at 7:51=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Add support for the LCD interfaces (LCDIF1/2). When probed, these
> interfaces request numerous clocks and power doomains, attach the bridge

Typo "domains"

> and look for a panel in order to retrieve its capabilities and
> properties.
>
> There is a similar driver existing in the upper folder for other i.MX

"similar existing driver"

> targets, I discovered this driver a bit late. It is not tergetting the

targeting.

> i.MX8 and I have no idea how different can the LCDIF be on this SoC, but

i.MX8MP.

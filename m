Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A1AC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E336C88D0B;
	Wed,  7 Aug 2024 15:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eobX4NM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793AC88D07; Wed,  7 Aug 2024 15:45:10 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D479E88D3A
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 15:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52fcdc2f1b6so252881e87.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723038296; x=1723643096; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7rXieBPEcvTsKK5q6ecR3xe051b33Zz4DKhhjx8JH0=;
 b=eobX4NM3G6cobihDz3AxcnnxRIyFw1w0csFNFQxo9y16viDKx56Hdrb6gp1kqjJPh4
 nshuFEP6J9qP1tQoS9NiH1+rc6RrxwcxPRKCdR+EyUqtv1MMNLv+f2JadOrTsjPXmk8L
 oJxqfqHpjiNH8CCRkma+ULkdp9HzlfHI7zlVSQN0FcCknTITdWNJBFp6dpk+iqF0TjMf
 v7l3hfklUZdIQEQ/4/C3dIxqoX+9gVS4jsOFnKfeRuO5e81OrtDQIriQJ1hUtBJOt8xP
 xjOVUiUUO7AqALysq7t0yiVaBSAYRBewVAY8i/5mZxmnU1SqnC27vEBohS2frPW4eR50
 yCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723038296; x=1723643096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7rXieBPEcvTsKK5q6ecR3xe051b33Zz4DKhhjx8JH0=;
 b=GafIvbzCt7rrEh1lDqIBZTIH5yITwNcAAyfFyMZjvlVg4xGU9DJ9gC3DnKuf+D/Oyi
 4qvckMkHKkcc+txuvEWq53aF0NGn9hoSFYj4vHAFJ762RGlvkPCliMmaIWZhOaGjIp3d
 vEUjFqP5+rKS5V7eydMKe6QUMHQFjCUpYBOAXc4SpYkZmU17cc0UZnTBXS7iNoDDmEAC
 reKJHUWxjzHKALskvepP1pqQ4lSBQmdxfm0pbmoNht5Vu9B1EYGD7c1q92RC3qbEOXml
 OdI4sAKQecuXcj0dyjuglVBwbMIRpEfvmC0nTl0HGokaHmAgUE5SuOiJyTTB3KmxoXmt
 RMbg==
X-Gm-Message-State: AOJu0Yz3HacClO1O2K6/wfzDRYAFapDejzeXexcQXD0zLZZXkSVuqMzX
 7PkYWZ/iyVh0U1MnwYtNOAmfqR7pU5FgbC89/EdgljLaHPSCTFgzoxv8ytEArv5K7Z+kG8ebzUv
 TPMB3N9jD637357iJkQF29Fy8U3eArA==
X-Google-Smtp-Source: AGHT+IF8ya8StOADSTdmyth+Pfjs3njGV00+83bPxVnDuEqbstaXBTA2/bBlLSfzcfOG/g2rh7LKYu865SsnDr96XiI=
X-Received: by 2002:ac2:5d4b:0:b0:530:e0fd:4a9e with SMTP id
 2adb3069b0e04-530e0fd4c71mr390992e87.9.1723038295790; Wed, 07 Aug 2024
 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240803161513.486062-10-agust@denx.de>
 <20240807130933.846385-1-agust@denx.de>
In-Reply-To: <20240807130933.846385-1-agust@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Aug 2024 10:44:44 -0300
Message-ID: <CAOMZO5DneSby5XRjjFYEqSQpJcXHK2V2ixM4nJsikRymJ1BWQA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] board: cm_fx6: convert to DM_I2C
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Nikita Kiryanov <nikita@compulab.co.il>, 
 Fabio Estevam <festevam@denx.de>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Anatolij,

On Wed, Aug 7, 2024 at 10:09=E2=80=AFAM Anatolij Gustschin <agust@denx.de> =
wrote:
>
> Conversion to DM_I2C is mandatory, enable DM_I2C to fix board
> removal warning. Convert EEPROM access to use DM_I2C API.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Cc: Nikita Kiryanov <nikita@compulab.co.il>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2: fix trimslice build errors

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E65D30000
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3B88902A;
	Fri, 18 Oct 2024 14:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqLH4Dyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A308902A; Fri, 18 Oct 2024 14:32:14 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A8E88EA3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso2402899e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729254731; x=1729859531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UREgMb6WUzrUU80ozuJe/k3ghsycmE1P9RqcyS5GPy8=;
 b=DqLH4DyyP0if4pY8yuAWpAdzgxRH2Dkn1RESrz2UCYamnJHJmt+juXohVhjC2fE3gL
 FY5WNQAiyrWuJAB4BUAH7n1RecDH1mxfPi3vDnCR4R7uH1wQYu8h3Hr8VMcprz4bUplI
 CAZ5AC8r8uvTTXqPXcaMK1nEYthKajLSLQX4dEn8OzROmAKdYlueex76ugdmf2B096Ig
 zVPFZ/G0Qi0aKAeTI3finACJQ6tCeuim5v9iZq/GVsba1Ktfg6xTftgENVmtaYzlnEYZ
 b6g7v/JUDUhfv+ovWmKguMh1yNsUM1ZUWrwAPtucEm+BucF1dPgVNTHNfp9wXY+6Jdow
 tt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729254731; x=1729859531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UREgMb6WUzrUU80ozuJe/k3ghsycmE1P9RqcyS5GPy8=;
 b=qPuaWhtjJ7efBUNhUgogz4/vcbajXvQ7pzLv81ldVaoMVOszTh82UdHCG5bSDIdpH3
 JL3Gg2Yph1e0ME4Lm7tdnHzG5YRn+MqifcNAL//o5IQZfD+b7lqYsB/3Sb9L+Gk9SBg0
 YXrzMzkzuzsNIOZWszOPoAlOrK+vwLK3117AmvqSHiEbgon8/FbvmFMbW6J1tDNIr/AM
 PxIzFk0VGDpkttw4bfT3p9aJyBXjdwPH2e6EfG0FduZxey2ZRpLcT90vCqG1Mv6M54G8
 q/7DrhrBlhsrASeASWBuvQ52rL7Rgc6pK74I7WFNOgmXOfqS0g5YuzlE9M4USV1Il3PA
 /aag==
X-Gm-Message-State: AOJu0YzkBa8Z4peUOZeHkWfrx8WG6JJsL5gQcSNYyFzy0oBJ6mwRU0rq
 odORfPDsNhfuE2m9pMHqSrfxlCYRiJ0LPb86/uv1qrTp2Rn1qo46/dIhglh1euMlmSHTOkbwqbD
 WzgGceY9O1XxRkoBWR1EZpcRatAYH6g==
X-Google-Smtp-Source: AGHT+IFKGFL4ZLlE9i/tbzAK4/0N+ACwqgEwspEwnJV1WfBNF0Hemv0QD2FQ+89c+Fd7e1pv1ArxWa5yeYqajEUuWOU=
X-Received: by 2002:a05:6512:3f29:b0:52e:f99e:5dd1 with SMTP id
 2adb3069b0e04-53a154c7716mr1405437e87.47.1729254730968; Fri, 18 Oct 2024
 05:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241016201536.2032-1-egyszeregy@freemail.hu>
In-Reply-To: <20241016201536.2032-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Oct 2024 09:31:59 -0300
Message-ID: <CAOMZO5B+US9az=0aDhAkeQ9sQKkA6YOjYvgX8iYi6C9JUZxsXA@mail.gmail.com>
Subject: Re: [PATCH v2] pico-imx7d: Increase ODT resistor value
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, sbabic@denx.de, otavio@ossystems.com.br, 
 Ray Chang <ray.chang@technexion.com>
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

On Wed, Oct 16, 2024 at 5:17=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Ray Chang <ray.chang@technexion.com>
>
> Increase ODT resistor value from 60 to 120 ohm to improve DRAM stability.
>
> Based on the following commit from TechNexion U-Boot:
> https://github.com/TechNexion/u-boot-tn-imx/commit/8a00e57b697c6f7d3d3abc=
fc552550ac7d8cc96d
>
> Signed-off-by: Ray Chang <ray.chang@technexion.com>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Applied, thanks.

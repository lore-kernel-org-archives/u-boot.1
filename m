Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21938C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 22:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BAF82CDF;
	Fri, 20 Jun 2025 00:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgXscUJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6BE82D21; Fri, 20 Jun 2025 00:44:39 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1682D82CBB
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 00:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-551efd86048so1240746e87.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750373076; x=1750977876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncYXh9hYMoHK7PoZ2NO3JZydQRNIA2ofo8tauo6aRLw=;
 b=OgXscUJdAt4jAYgFYFPih5hzDvYO/a2p14pz5nshVcwvmC1MwQWixq0xkzSOvW6eV0
 CMWTlxoCsWbKE6TnZGymcdkTYcehLSWbBNfmD/rsVPxAWN7/uwMMbliuzPhtRdV6Q+b1
 wc5GvV+qdjfFKGN7XbGEmS6HQrz/HYbtqgp9lHmw1TmQheeptkE1NiHCjiPwyDxda9h3
 lH7mmEqcN+HAyYbkzpmXNO6P7HnhSo2V9ncYQW6pgEium8N3WJIaKyqgcCnQF61lReCJ
 4GK6j2bSXEQ1pNfyFGwnyCgFaGZTt53k1Xac5bL5WMdb2ed1kAK+9nHOoHFmnY+GXkNJ
 Gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750373076; x=1750977876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncYXh9hYMoHK7PoZ2NO3JZydQRNIA2ofo8tauo6aRLw=;
 b=R6B8va5EkOp3WN+aZB0YBYv3M37oGYVWKRDSp9q80iGaZ/DJsgnbmuoKl5oN2icGoJ
 J5y18SWZsP2S15aSHQhr0UBMPuWzBk2IvJhvzTogVXQ+7N3qJVTj1baWcntP81LhmcG2
 pRdE1WBWG6p1ye8CqHthYarqbq9fzPfn1l9SSBmrE6CB/qXJAFZ2cxIgbe+rYnLEvbVS
 Ki3VudmEivKfTs/h3+Sz8eePlQ26nxtvrFJKp2J2AkP+wDQMByquSsaYS8lj4bU0KxRK
 pMQn7mexp6lgmEQ+mctbJntO9IOpMBuHaYHsNAClj/bVH72dv3lXuUlmfxiISuHnX96I
 hrhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyh83HmAUq98EcHJznzNBAI0VeUewju4VUsaxvAAJ78EYk9iwrv8BETiDNJpWiFcnpR2ygOJM=@lists.denx.de
X-Gm-Message-State: AOJu0YxoUHT+Ic7BWjTd8aKvsGGq+BpCg6BgHKMHbxlUnawKOaYciw+L
 B0SHRUwdDUD0hSm/2IaqWaSl6fMkeJjFpF6SrGQRdpt6ZDVU6DO1gN/AZeQPxsMXpkVJizgImx1
 KRByQAIjYgLUuThgyVP8CgAZbLFvKFMY=
X-Gm-Gg: ASbGncvJtYd6eSavPS7K8P7WKyGqYYVVf66yyFLSnrzygCdOQyQaWtcUiY3newrODB1
 SlVbKhaumiegdL89cgdPd+CgnRaGhzBlbGLjCLFdIugXzAu7uoWQZXQkppPnXI5fWD4BcnGtyFH
 gaCHHJoaWSvYG+S1ffmk2wv3eTY0Idq7GG0z2V9KSIRp086r6umbygQj7ONhoTJuCDcx1pRB6dJ
 ho=
X-Google-Smtp-Source: AGHT+IFYRQfY2ODSS2y/6K8J+Ofg523+Sn6DDsuqTyD0cxeX7N5tvwDOTqcvIeYkWTc0dNeikbSiXLYFk2SJtYRvHms=
X-Received: by 2002:a05:6512:a94:b0:553:277b:17c8 with SMTP id
 2adb3069b0e04-553e3cfd999mr204994e87.35.1750373075986; Thu, 19 Jun 2025
 15:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
 <20250619-sr-v1-1-631100a113a5@nxp.com>
In-Reply-To: <20250619-sr-v1-1-631100a113a5@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Jun 2025 19:44:24 -0300
X-Gm-Features: AX0GCFujulHkf19BlBuM-mtsOpEljJQbc8ovxgcY4mWdNWmxa2LIpNss0Refv3c
Message-ID: <CAOMZO5CHSgaYcQcS+9VtfP0eH8QTwvJ6rG8yLijDU2M0JVacuQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] imx8mp: evk: Add support for capsule update
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

On Thu, Jun 19, 2025 at 6:13=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Define image array and GUID
> Select configs for EFI Capsule update

Please improve the commit message.

What is the motivation for adding support for capsule update?

Why is it useful? How can this feature be used?

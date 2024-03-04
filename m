Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E170C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD5C87F91;
	Mon,  4 Mar 2024 13:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0bzt+CW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C7287F91; Mon,  4 Mar 2024 13:19:26 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61F8875FC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so389960a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 04:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709554761; x=1710159561; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9a8Qt9IE1KSDAYRBk0Llzwzbdwkvg7Cf6QYsQNdGGkE=;
 b=a0bzt+CWhkDRphrb786ObAem7u/AsjrdPFVccLXdO8VFpLjvq4xcAfuiOxGUHKuzYN
 lQhoc1WW1YoOuNc6h6NhyLOtjNoK7bUhuJsh1h6ekeiv0Epmtbzhx3oju3QXFwNYG2Kn
 YpzTHkJu1AmroYXNIZsjSiwS23w9mYx03XIQqJhtNOiOxQ4OreQ167UJ13Hvw4pHEvrP
 tg+1+jWTZVHVh1jeWLs67NZ/N10Ort1qFNY79XywNCHaTrDUtYjyiXPUjWeo+qHqPEcU
 BvIWJHJVcRLuUlltWgn1hiA01ibD1DK85zaX+jai/fxYnyYQyJxtqXDAGfHeNDzFemAF
 Dfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709554761; x=1710159561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9a8Qt9IE1KSDAYRBk0Llzwzbdwkvg7Cf6QYsQNdGGkE=;
 b=vm4Tf5rOO5zXFgEvIu3h7xSaBinHHRMO932RRds93qk4n4ARZFxEbnqZ4wk4+HQfqZ
 jMQzLuiJbPaUceD+ZvCuVWuxJIBMjZjKZ9nEvOZ+uFNFY4MerHcwismLMoZ53G+ICM/h
 FWmSriz1dsJw66L7hWe606gr+57gzD+OetOylJvD/fweENHS8ZXDvCdWEl3o309Ay/5Y
 Uu1OJKqfiApQElf5z/+F53+c+6CHCYRZqxPUXBjdG5OD+w/MDXkwNq/ENPw6W/q23phN
 t6UWfw0E9X1mHNhi3mHFcwCHS/KnYFFywu2QKNCLaTakjpZQH1u7odWgy/5XA4DSnfeY
 48aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQInlghjnLDpcF8yl1jXIVC39ozcY8wXeEiLElCuW6puWvFbjUEmYBn9/xq83o3cWiAZT6Lqp3JMfwpmUulToYgvpqBw==
X-Gm-Message-State: AOJu0YwLuSHtnEpTE2oux/WWow8mH0/ePdH+hNpPga3H9Fmg7UyKTg+l
 eEUPmk/76bP4FYYvaJ+04IsyPHebNQbCSsFT444OLzNqLlKVC12gGOStBmfGkt8wKMUuN6y0WpK
 /f63lLCCn8m7NkQhtVYte29U5lLo=
X-Google-Smtp-Source: AGHT+IHK5u4cexBCm2ExiaqExA47U7B/EyhMVhJxelsto5GEmd0Ns0fnm8alaqaeewH8wTYSgu+UmG+Mg4bbpComlpc=
X-Received: by 2002:a17:90a:b78d:b0:299:25ad:7c98 with SMTP id
 m13-20020a17090ab78d00b0029925ad7c98mr7183588pjr.2.1709554761062; Mon, 04 Mar
 2024 04:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
 <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
 <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
 <CAFA6WYM12F_9yyNwXY5xj9+zh3Jwa_Jmz8MkaKsxm3Jn3NPNKA@mail.gmail.com>
In-Reply-To: <CAFA6WYM12F_9yyNwXY5xj9+zh3Jwa_Jmz8MkaKsxm3Jn3NPNKA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 09:19:09 -0300
Message-ID: <CAOMZO5DgEaTGmxJfJf=fGgwauE-M+XyHm+tA8rfOw+MwRK_mqA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, peng.fan@nxp.com, 
 marex@denx.de, Bryan Brattlof <bb@ti.com>
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

On Mon, Mar 4, 2024 at 9:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:

> I suppose the earlier reference patch wasn't complete, can you rather
> try its v4 [1] instead?
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240304121257.35511=
04-1-sumit.garg@linaro.org/

This one works, thanks!

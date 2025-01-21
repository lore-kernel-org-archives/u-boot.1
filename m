Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835E2C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 14:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD4A4801F5;
	Tue, 21 Jan 2025 15:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/ENXswQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4795B80326; Tue, 21 Jan 2025 15:09:28 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC5B801CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 15:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53f22fd6832so5965396e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 06:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737468565; x=1738073365; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0f5LIRtI8lE0I3ck6MQDuqfIBtneIytlW8SPUiAz038=;
 b=X/ENXswQ7ZgK41TVAAWjdTBRV7aO4+KD8aqu6ncwdXJCe5G0wTGwYb5U1kDde4c8E3
 whEj2HB2UtcLZvwk7MWKMloRAjUu5keVNf0Hk8FU+FVbJf1GqAjMRkhgJy7fhmqGcpZJ
 CavEfShXT0EvRUKQvlVHSnaHv8vcnfYJoEWqXxG/T6B9MXGgaG46lJtq7Q9c8en5nupe
 zVU7x+cB1zOjwb8YvAJSGpFAj3W5ywyZrIqHDBS3jyUNXCdc3l29X2Ty7iSQjgzy/Eqg
 4ywZQ14EKis092O9VGDAHaBUg58vQvDVsdfUauocno0k+gApoghm3yJC1bq7aoBMfkvA
 VUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737468565; x=1738073365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0f5LIRtI8lE0I3ck6MQDuqfIBtneIytlW8SPUiAz038=;
 b=vC9yA1DOObB9KyiOXP/31ppWHcDOcQafVAc0domxZKu31WtwQfwLeOwctEdCpnwPHI
 q/WZYlfxtJcMBuvl4UbErHzxnhmsIYN5Jh99mHSDsxAFXF74XnnLvMIaHJ6jVc+bR8P+
 Tk3NVGv18RZfYfd4HhryWpdloDL8tqesQXT9kvTxIuLbCLncJZf5txjWJWMaL4AakJ/2
 a2xtXXa1iV+hytxpGZZ7zybbXPPWzTQd8kvIVxhGyvvX0LwoNKL50arI/WAZscRxgLd9
 R68zI+2iamCawzCfyFc7LfIMLgyiy52rwFwBm9Hz7rL5NOthbrwy9hEZQuod3pOocy0B
 5yOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvTscMqyqA0P9jgtQdN7SOr7KwQhI5Nuo96A5Np2WLSefQe30xB8DBMjp0zTAWIEMp6SLQJuc=@lists.denx.de
X-Gm-Message-State: AOJu0YzWUhcmUQhjleQlkL+FFSSnAycqBe+KKVw1ZCWRcWJ7krxmeVv4
 hlU/Az1/0dunqE5aebtE4kEgDUJVjyBTmckiHEJg3wJ1j3uOLxioDBNjLdinSfr4yjo3ZL7pDde
 +Ms6pjCuH/13OByolx1v6ZBX1DtM=
X-Gm-Gg: ASbGnct9ci+/VriUlVKP0TWbTG0d33uH2oczk8MWwLtv9Cm3PEZSyGD8dPeLE88okPI
 ENc0Nk0+ngYYGZolaIZUk4EH/Rv5X6qACxTYrb2TmrUpR2BNlVYb+isfiN3qhLqAXCJvpQF1ldR
 0SNXmLrWo=
X-Google-Smtp-Source: AGHT+IEl8olHS3AakyjI0mY2grLClN36y3UMDhUKH2hf4HuNZrEv4erXsI4PFXb9uEC/TvHlpAbUW0srMbG3/NlTGIU=
X-Received: by 2002:a05:6512:10d0:b0:53f:a8c0:22a7 with SMTP id
 2adb3069b0e04-5439c282546mr6089411e87.38.1737468564777; Tue, 21 Jan 2025
 06:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20250117015642.2373824-1-festevam@gmail.com>
 <efbbd217c00ec775fb7c2a7a0da18a4b5ee0e39a.camel@phytec.de>
In-Reply-To: <efbbd217c00ec775fb7c2a7a0da18a4b5ee0e39a.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Jan 2025 11:09:13 -0300
X-Gm-Features: AbW1kvZmFJeLr6LDhOO4zrPM39uost7RlkvhUK_uXHRlUyvRnLH3ITdyhcTJLv4
Message-ID: <CAOMZO5C0yDQr1QJ3RPOa_=O7=hgtR1_9GQdYCoomjuTUB7SyRA@mail.gmail.com>
Subject: Re: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, 
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "marex@denx.de" <marex@denx.de>, "festevam@denx.de" <festevam@denx.de>
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

Hi Yannic,

On Fri, Jan 17, 2025 at 5:24=E2=80=AFAM Yannic Moog <Y.Moog@phytec.de> wrot=
e:

> I have a question:
> Since tee.bin is marked as optional, we still get the same behaviour when=
 OPTEE is set but no
> tee.bin is supplied.
> What do you suggest to do to remedy this?
>
> We could remove the optional. Given that we guard it with CONFIG_OPTEE it=
 makes sense that the tee
> binary must then be supplied and should no longer be considered optional.

Yes, this makes sense.

Would you mind sending a patch?

Thanks

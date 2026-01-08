Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B26D185CC
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 11:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7F683B8A;
	Thu,  8 Jan 2026 12:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJfXHBXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E314840CC; Thu,  8 Jan 2026 12:08:29 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBC283B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-646fe7f70e2so2242019d50.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767870506; x=1768475306; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Py6yocSKu5givPH7U/k5x03ZD6xwfJNxeCqjI7dqoVQ=;
 b=eJfXHBXlJkS5P2aYl7iz1gqPZEDt7GBHLimzgnLmDlIuPjTgx5BXnduq5Uep2OeQnA
 hfMCRaBX4jZyGxQaHgWUFtnPGqb9RlUEnSB7H9aixrG16q1TKxot0x5Xh7g4iilRPYd0
 /pDBUwvBl6fWhA5i7Hh/29M9A3RRzucZCqmrDui5TjhOeHiCf0459P1WrCGu/Qwmax5f
 TWW/TL0UxMraQPGrlMP3SK0RYJlrHoIreuS9FacEzOEm8Jx/gRhXTDGcyyclpYmZ6ICW
 as0wFAVY48H7e7kY460eY3jSpqQ+kQ5WLtsWmGUaTxZlzdXYNXXMyJeJuv+RoGZH/ZQJ
 tMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870506; x=1768475306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Py6yocSKu5givPH7U/k5x03ZD6xwfJNxeCqjI7dqoVQ=;
 b=U6twnjrApu9d+tIZUoEJ0+Dca1S5c+5j+eQWYTleu94uDFVMVoDncYyJHS24Zxypgb
 FIUHJyesmxKTTBL/sYUBu4oEMPCT2DdXnOnv71djq3bZPXYguBH2xsZazVwrvzGN2cHT
 tJoJNE2DyzbdM9HRAyp2yPouKeyxs3MkHRUqMK0FgCoycd05d1wcm5nKAYdy1eWilM4I
 3eU0nu71tdaS9ie/R0y6LjPaaksLGT83s5woGQ+NixbDN7nZZJSyo4LrjZH3rL9iZuzu
 AhofJ7VAKlQrEvrxWtplwfetbjFOytvl3y8ys0IWM+QGFzinz0bReWneFmnlIqJ+GtIF
 Zsmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC1fdfycwJPPdpUy4LzsNF+K+xlMMwACa1RIFxgh2deUpB60XdrssSKWH+23CzTbJwmf9s2rg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr4VJJ/GvPNZZY8lPit76Bc2xFx5I/mrAsOlsRY2xYiU7bY1fF
 NH4uo/l/N3nmaebTmcW2b8A/8YvQoenV6PDRdYPkiTmBpwaFViAo4CA4syMytlwBT3oytP4Mk/o
 ryIyjXulJC11g4U5CuTgfQMxwaBMhkmw=
X-Gm-Gg: AY/fxX4QlJ/tfnliS0UGY6BZwF9t+pyu1L2PW3xELJncbj6iOYDf77ZgeOSpNvd0E1y
 UqhAUfKsyJojjm+X4C/XsUGjQhh0LJ3++c0t+m1eGxn8oYYNOJXMOmjrVmHRxmqSKDy/bR0lofq
 1Q2KYvTcoNFaSsa7rWWnCsot4ykOUJwJzt2IFP6U2W4h9X/Dm4Vh4ClH02Dtjaz4VKP3ZMXnPJ/
 /TG1/Pe0/bkMDproq8svxK7rSMdgpNuL+eB0w7Dmoc+bpdV6mKeZYtuVOxJUv1wQBL3aDRGLBSG
 wPYYt/SwUR75HLBC0ebclWLt9/0=
X-Google-Smtp-Source: AGHT+IHFUigOyBnQrQQSLu4j8YIjRmY3Ufvk+fXED4TT6QhmvamI6nn/T6BKptsC3yksfvdLKN87Rpg3jBhLBStUSnQ=
X-Received: by 2002:a05:690e:4186:b0:646:4e41:739d with SMTP id
 956f58d0204a3-64716bd5555mr4741507d50.34.1767870505563; Thu, 08 Jan 2026
 03:08:25 -0800 (PST)
MIME-Version: 1.0
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
In-Reply-To: <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Jan 2026 08:08:12 -0300
X-Gm-Features: AQt7F2pKtEDkMIjxhRBgX2TbJBeA6PTsyn4q_NegTZcMeOdzJwjkZ13GMYb70wM
Message-ID: <CAOMZO5DSf=ViRb-3Z8RWKFiN+P37sk2Wds0Evd9_Gt0nbekc3A@mail.gmail.com>
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Vitor Soares <ivitro@gmail.com>,
 u-boot@lists.denx.de, 
 vitor.soares@toradex.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com, 
 balsundar.ponnusamy@altera.com
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

Hi Tanmay,

On Thu, Jan 8, 2026 at 5:25=E2=80=AFAM Tanmay Kathpalia
<tanmay.kathpalia@altera.com> wrote:

> A potential fix could involve either:
>
> Adding the "max-frequency" property to the relevant device tree nodes
> (e.g., setting it to 200000000 or the appropriate value based on the
> hardware).
> Or Revert the commit aebb523a2381, since platform data from
> dev_get_plat() is calloc-allocated (zeroed), so prior behavior left
> f_max at 0 until the driver set it=E2=80=94restoring the hardcoded limit.

Could you please send a revert?

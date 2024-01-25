Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050DEC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 20:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3D587527;
	Thu, 25 Jan 2024 21:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ghhkxnEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5974F876EA; Thu, 25 Jan 2024 21:10:05 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2487C87B6C
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 21:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-290327b310eso1158781a91.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706213401; x=1706818201; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSXpcFq2X2YXlQkYrDhL/Pejs8x+ZYqBhbRO7+UskfU=;
 b=ghhkxnEmUZA/KihhdpJiDvx5R3ro5uAozsHURcFBWsYcav8azcaq4sQqwv6U+YF4xb
 RxBNDGKTlf/+mclronn5gDJdcV35mjAM6go4LqRGYjbwQXvo/XRE5IBs7e2hfrikTM9v
 4vb0ztGj5YvyfOu/cNbo3sqnITm8+8bRumRLHR+6r/MGGyup4lfQuqh/wOZO2XOff/X6
 2Quf1tCDwpsONSuPxt9bK9keLbFvAeJuk5+4tT0uCsd3T7llTNGJrw3fzWCoJKdbEomH
 k04ZITjlba6DfMPvPLaO7Jxyd2tutmPx6ZY3mmEe7kXkYyNdxekApG5+09VxnT5xXnog
 2enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706213401; x=1706818201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSXpcFq2X2YXlQkYrDhL/Pejs8x+ZYqBhbRO7+UskfU=;
 b=dGUvVrKHGIq03Xrs0sBGllbOSEpwSgcSEmow/GT9u7aUKgSh0AJEL4j1sXhAje7OST
 CoM1lDqwTzKkE02oCSe4kkKKid9U6iT+LgZQjLVhLZVQ3v7MRxIhNRE/LzzfkyC1Qbai
 p8ZgdJLF/FFncyRGN+7gReZAslVS9KjEIwneeex5m556IPuXgFd5rlz2WKnbWtGROxMn
 8pXngOE3UguSdzEL3Xo9zJ920c0pNj4e7iG6q8RPEJXBLqOKYDc1FmrV97zFFpuVmvpG
 ckGTvBD3XQySptO0B7nqbzrDmtmfZR4FUcSHzAiIlcNzbQgQO/2sPxz8M5WIKoVwOpq9
 QpFg==
X-Gm-Message-State: AOJu0Yyiy0mszWOGqHKWOuSZbNV6imBENgN3cRzk476V1nbDDBVkyj11
 VbXna0QSFn1RuUpFS/bv7IIQNgHxExEI1HHBKH5ax/FwrrVYGoA9SM51M02aw5QR17Se18dxMbQ
 4J2+8xo87kpq1CnXAEu03z2pQDYE=
X-Google-Smtp-Source: AGHT+IFp+v/CHup0v39fBf5Pm+cHYevaCGChkeJ8Zjl1V9/cEjmvtwMQVA1xS3oXr56lnWxYo6Bar7SfhabS+LN5wsg=
X-Received: by 2002:a17:90a:71ca:b0:290:8cb7:fa28 with SMTP id
 m10-20020a17090a71ca00b002908cb7fa28mr311328pjs.1.1706213401357; Thu, 25 Jan
 2024 12:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Jan 2024 17:09:49 -0300
Message-ID: <CAOMZO5DLFfx35pcseW5Ojqbj6QcqXtMBDhDgYsj-Kya7c9EB=w@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Jesse Taube <mr.bossman075@gmail.com>, Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Fabio Estevam <festevam@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, 
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

Hi Adam,

On Tue, Jan 23, 2024 at 11:15=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
>
> Modify imx8m Flex SPI Configuration Block to work with imxrt.
> Add more Flex SPI configuration options to Kconfig.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Could you please test it on imx8mn_beacon_fspi_defconfig ?

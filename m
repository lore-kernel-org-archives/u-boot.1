Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD88C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEBEB87E64;
	Fri,  9 Feb 2024 13:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fzP1Qz7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B85387CE6; Fri,  9 Feb 2024 13:26:58 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B06987E6E
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 13:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d862e8b163so266423a12.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707481612; x=1708086412; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsqC4BCenCOteRvb/WycJdiliic4adkq7oKbDDv36sA=;
 b=fzP1Qz7FVN+a0y7uCP9Y3gQ/fdIQcypAXiC/huJKzdwcdoQtjlpfWac/gzKtR4juEN
 /T8wtNlU9qMOwV7mYBU+sB9IjxjNchUlIS8OM4ew7uewrMw6xYyqP4MC70jBB1y1KKmk
 0mwHfvUGez3s4Ys+AZgZ4KS95euo+QCaXEefsu6LGZiFhoEEzzwYfesn9bDZIQ8du08p
 Rsae/28NskmX7MMfuE/abIeSxaN7fkpnneBs5mS3Gel1ArkZeRCckR4l5ew4zjpqeNFr
 DDyQnbnpEVbGPBYA1qoPBnjXbfVw80ZiXZ5yrlS9VIbUEO3nKIMubvChAoT6pi76WBPQ
 U1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481612; x=1708086412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsqC4BCenCOteRvb/WycJdiliic4adkq7oKbDDv36sA=;
 b=Sd1uB//IVvt4EnhHn+bqgxUCD/MRr/htG5Yo3kuJ9wvpgACzgJ5SBTn/pz5KNP+S56
 oqPgNsjjU3fSGSWkPQQ8OPn/WhYwNN1jYAL9ldjlRo/xJaF53R6cXjbMIJYM9jUalqAq
 QanylO5/24XSrf/EQGtBHOlGo3F28OFvEIxxIidWDVqMwtdu6JwKGTO4uh2VdBIYSyNB
 q1Kic9lnuMIJ+DvI+Di+gSAxtc4zNq8ZGNNIpQZ0vmItXo7JsC17+ZoUiWHYKwPUNLAt
 8w3AxdI+e9vL4JILrNqUqJ/bRVxgAR8NQKohjXixXdQC5ucCMSBcboe+KcGYrhKrYw/Y
 Ca8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvxZgMtR7/rP5idd9CAVMgHsU9NLx0RrvbiykmmZsesKKtFhrZoqOax1epxezOWq9Py87eZFcoMA4AA6ukbbAT5x5w4g==
X-Gm-Message-State: AOJu0YwJhj+0WgOtj1xsgZ3UMf/p1qrZYcftXar/yHkUwq+oqW27Q/no
 HLpuYNF43u+XZvhN+/yl2UKA6BqkOWgTZQjNcZ601FT99Vr1sK8JYhbZpw5pTE6avsCAo/oOpw8
 Uccl3mSZtDED+OQi+vxq2MLTyPWb69wLgqgo=
X-Google-Smtp-Source: AGHT+IFk3HapPtAWZj5mZjug4XRPGfO/iGVNdHBVOHPUoIv15P6ioOFvEWC16Xe5nBZfRPjplCMHay4Hp2SalAC7llE=
X-Received: by 2002:a17:90a:6fc5:b0:296:e236:f69e with SMTP id
 e63-20020a17090a6fc500b00296e236f69emr1167522pjk.4.1707481612408; Fri, 09 Feb
 2024 04:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20240208165849.104787-1-frieder@fris.de>
 <20240208165849.104787-3-frieder@fris.de>
In-Reply-To: <20240208165849.104787-3-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Feb 2024 09:26:40 -0300
Message-ID: <CAOMZO5CpOYNquoUY6FvmXyM8tgzhe1k67n7j9wwvrYgni_0=Rg@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Frieder,

On Thu, Feb 8, 2024 at 1:59=E2=80=AFPM Frieder Schrempf <frieder@fris.de> w=
rote:

> +Burn the flash.bin to SD card at an offset of 1 KiB:
> +
> +.. code-block:: bash
> +
> +   $ dd if=3Dflash.bin of=3D/dev/sd[x] bs=3D1K seek=3D1 conv=3Dnotrunc

I see that you used binman to create the flash.bin file.

You could simply use the standard u-boot-with-spl.imx instead:

$ sha256sum flash.bin
a0a4536876f2957ef88776036f13c6604a9f7e7fd78a236e8ea7322c2ae3e4cf  flash.bin

$ sha256sum u-boot-with-spl.imx
a0a4536876f2957ef88776036f13c6604a9f7e7fd78a236e8ea7322c2ae3e4cf
u-boot-with-spl.imx

As you can see they have the same content.

I would suggest dropping the binman generation and just flash
u-boot-with-spl.imx.

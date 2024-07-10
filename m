Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AF4C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 13:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0904788702;
	Wed, 10 Jul 2024 15:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VmkeX+cI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD68988712; Wed, 10 Jul 2024 15:39:14 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55A088657
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 15:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso774915066b.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720618752; x=1721223552;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TF4f0qw57FYP0pHYOH8R/bNm+1DqTrhaxXzUNn0zCgM=;
 b=VmkeX+cISeirlLZbVp+diNGIWmq3qbe86IiNyqqwnorqJLz7BZrVLxCoxA9SVBrqHf
 TbrNlx5u7psEq/Kjdl0sy7TiM+BKFHehZVwN09a/HLQk6rRxguws5FuWJ+njxGkYPGr7
 S/dS7vfujeEzcNbyrWg6ab+Tb9TBZt3SMvTUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720618752; x=1721223552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TF4f0qw57FYP0pHYOH8R/bNm+1DqTrhaxXzUNn0zCgM=;
 b=w5iWeRfHTcmHutV8q8I2Q3vzlhVLmZ4rOyMN1KmJ+PwlOA/C/wLJixeMcWtCNyCQoq
 ClguKszaGLXje2/Lc6tvVLLylw/EvtEMxHvPq6iR77RYnreBf5FFWq0E3TCGJuVN+h9x
 cT6vNlQ/HSqpo3ts+sej9FAAJI4qDBU8nkaOW9bSE6zlDYbNo34S6+C+8tbhxdkrC8rT
 xVtDlnPh2p702QY3ANEb0jAtGfy5F9Tcr4rGTM9d33BPU4g417FHcm6fBjdvMfPIOlS8
 5MGjuDIZxRrHofKgdoBcXigr8zcp8CjeEg09yk+7NbfvUjHInHWTJ0weFRggGgdnHJ9X
 g9rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpXZhALyPfUOPMkfqc6BD8B87l835ybIFObQUAD1Yo0TcNkLu7T+XpYr/rA+Ed6N5pXHmR6CYFJu6TQZhA0Xqo28g29Q==
X-Gm-Message-State: AOJu0Yzl48hVxbASTcr0gUnyl+w1Ap+jpXO1m/O462oz5k7BGg8ogRqe
 VpNn+ym1JAgNmXmHA6s4N59GXEVNNsutPqtGB9VX6SFwkHBnEHRTlSpWCAX0wQ1yACKrXCxOjI5
 oF2Fzdi5ufmEWLDfiqdH1O2Yy6cRoLbC8LxvaIA==
X-Google-Smtp-Source: AGHT+IG89LTEh/9qqSBF20Uf4nIqY13GQaoKYQ6+5tfIgguUcOh8hNCh8k4EBsGVEukgTOu8RnqcbtsM9rWR0v7yzPs=
X-Received: by 2002:a17:906:378b:b0:a77:dd1c:6270 with SMTP id
 a640c23a62f3a-a780b688911mr375900366b.5.1720618751789; Wed, 10 Jul 2024
 06:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAOMZO5Ddm_2rerosTctkCzcd_+ku7VfsrxfXOEU1NynEOgoQbA@mail.gmail.com>
In-Reply-To: <CAOMZO5Ddm_2rerosTctkCzcd_+ku7VfsrxfXOEU1NynEOgoQbA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 10 Jul 2024 15:39:00 +0200
Message-ID: <CAOf5uw=wktwcRrPOXmCjehKSsQvzAAhmM4KKsbdxyE6cRVBMrw@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

Hi

On Wed, Jul 10, 2024 at 3:34=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Michael,
>
> On Sun, Jul 7, 2024 at 5:20=E2=80=AFAM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_pll2_200m=
", "sys_pll1_40m",
> > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", "sys_pll=
2_200m", "sys_pll1_40m",
>
> The kernel uses osc_24m. Why does U-Boot need to be different?

clk dump

It's how uboot is registering the clk in dts. My idea now was not to
change it to not impact other architectures.
I have a lot of changes but I don't want to address regression and fix
and test before send more patches

MIchael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

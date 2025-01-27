Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6870FC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD37D81119;
	Mon, 27 Jan 2025 13:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f3cdcMIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203F98111F; Mon, 27 Jan 2025 13:13:46 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C1081115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3076262bfc6so45167731fa.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737980023; x=1738584823; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HhXiyuTk0iVBNAWv8B6pHeKf9iVmjMcVfHSgf5FURg=;
 b=f3cdcMIwJMkl9tCt59FSFQzs0rdWqfd4Epe7Y9oEKS7XQMPTkyxZhc/TiaIU0djL5L
 BRjZCTKDjffUk9x0YiSNI3x/UrRKE8Q17YFFWq6jg20aflPaiGz2Zzs83M8j/bBSVyzr
 7Ax4kAlYrn3o/25vJuYCOYXdYBzrxU0RafQbu5Be80BqI/DOQ7bzZiBNeOTv7gdYG2v1
 k4U16/wfqSlvI/p1qi+XfKICwFJVxZg/fUOq83dtNNtIYweTIbnEg1d/ux/Pk+xMFa9y
 WipID6vdfi+DkOHimEx0gNKbKXahZnenmyrJ0SWf5ODvJFKOA5zq0AI4PXMybkvUgCRc
 9TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737980023; x=1738584823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HhXiyuTk0iVBNAWv8B6pHeKf9iVmjMcVfHSgf5FURg=;
 b=bYb+rAthnwGtm4tzA24PruN6ElHfN2xoQgNzATH/ZRExsxDTuA+7rjwFGstLGevls+
 XTAT6EyrQRZ1Ye1ldd5/WcqWOByRlBvGnUPDutewXsdA1Go80Rld3VQcqmizOMi7QLEa
 W6M9HM2Mh4zEhMYAF9Ku3SkC8P82SlWjVV/An32K+WVBEpnjq1lDwh7EMPXbjc8ScVf/
 PE4E80F9Viam+4r8LS5xNajupu3odq+nmaHFZP2rYNpoZcO0WW7mVru+zUWC7KQRI3WT
 RWfMJoq/lYuee3k48llKsEnnbawDJvXBouLxtUKVoKcfIo23Q2f29cjflbrQJSWwMW1w
 3B1Q==
X-Gm-Message-State: AOJu0YwKVOAdCHa2a+KlxmHarWOM5Gm9ApG5Op7IWwOOM+nTGlz6n45V
 OWGIifskFViFFaIRz1BLS7Rcp8uB/lnoKfusxi3fkdNTjduESLJ5S5P87rV/LlRO6p/PhO8thd4
 /kegsuco4wg0uTNxabos7cmAN+pI=
X-Gm-Gg: ASbGnctB0IwkTLdsJD4W+9vD5bTx667OWVQNiIWa43OGBfDVhituL1si4wpDFT5qoHn
 kifGZi7htJhDRQJHephTEbO1Oyhlq/srYohVmTwqbPJGRg0DuZ9h8IuOJwBInnPYcH2uHQ0Rqt5
 bmgDk7+QukMyWrFUZZlg==
X-Google-Smtp-Source: AGHT+IENoocULZ+W+hjeT/tt5EycUz7/sXXWMI0ImMx6QCXJHwaPWHkkjIbJkJODwzwCCDeXZIU1HOcbK4O0uhbeLUw=
X-Received: by 2002:a2e:a449:0:b0:2ff:c242:29c8 with SMTP id
 38308e7fff4ca-3072cb245a5mr133055691fa.35.1737980023129; Mon, 27 Jan 2025
 04:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20250127010215.555205-1-marex@denx.de>
In-Reply-To: <20250127010215.555205-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jan 2025 09:13:31 -0300
X-Gm-Features: AWEUYZlJRX_eaM1SVp7DHgTTfzaJCsfqhyKq9mTgEnU7TWV_eqE8yEv6aGL9e_w
Message-ID: <CAOMZO5BTHgmWEwna4ZHAhGXOJ-EhSGPVey=zeJoM=Cd49nVasg@mail.gmail.com>
Subject: Re: [PATCH] net: fsl_enetc: Enable optional ENETREF clock on i.MX95
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
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

On Sun, Jan 26, 2025 at 10:02=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The ENETCv4 port DT nodes on i.MX95 may contain optional clock phandle
> to IMX95_CLK_ENETREF "ref" clock. These "ref" clock must be enabled for
> the ethernet to work. These "ref" clock are enabled after cold boot, but
> when the system booted Linux and rebooted, those "ref" clock might have
> been disabled in the process, which would make ethernet inoperable after
> reboot. Make sure those "ref" clock are always correctly enabled.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.

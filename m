Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD9E77197
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 01:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825F8803DC;
	Wed,  8 Jan 2025 02:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKE0KxRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42224805E9; Wed,  8 Jan 2025 02:20:35 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D5C8007D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 02:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-304d760f0dfso47126211fa.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 17:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736299232; x=1736904032; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdu8zpYGZLBfNMT72ofd7W5oFRNvkFLCXqwZ9x9Q3Vg=;
 b=AKE0KxRWkTizQPua4LxB3q0JmBKAKMnVsnxVBqJaUT7asDB7V82CyMte2rBxE7A59i
 LqWpilNBcQTDW6oGPNhExJXEovgcBTUb03brXpehdfgyumRUh82IkTjVWpdKw1JepRuS
 X3FS0JYlwTKAJvLzO/54hG1BZz5/15wPG/oWAmLaQJm3vDMe8IsIcEt4C//Mm7xyD5h3
 zDA7dIybaQGvWLtpSzrrbotDDcXFWliVTJE9HhfMu6WU9tXR85jgO2gTkQO4N0HXeTzS
 VpElnSoJzYCLZd4Zfz8V9yNujeWnaN07SFu9q+BWk2UP72pNgxwaHor5BtuVXARr1Ztq
 WrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736299232; x=1736904032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdu8zpYGZLBfNMT72ofd7W5oFRNvkFLCXqwZ9x9Q3Vg=;
 b=M1Li0NOkvVaUAmpJhIPUCrasWVTzW+kjOpFLN5LlhZ0gFgvsy5n5esGVJn5s0YGLjI
 NcNqMf6PPNeYH8ye/nGbjF65GaWl87mHroUej+MNQbRYYD05wLl1beKwygFDCgBqhltP
 +o0btkUMCGgKS3zqgftds2Tski0CBew2xj2T7Qw0vQQZCeo+k/7FSxdV0xqNVForpIhj
 ZB1w3odpM+UtEZLIkQ49TYig8YQ0ZpWcOKhDjzWrlyNOGI2tMACxu9KufQeAA1qm9C8K
 feignr1ElSeEine3nB8BrYBxbIokKLgNiOzMC5Rin14RozIzmRNnl6G/2J16YDtsf5Ft
 fi6Q==
X-Gm-Message-State: AOJu0YzyGhH84l52ZxHf35wThP6hrrzNJPnywb+ttO2t2t8vIUWx/aB/
 JtGgWyVTZ+8kgaRTsOfzzn+E7N4l4dBcm6F+gMJhENXFH5lRIPna+2MSPrOb+nKHsrvLc4AWHxd
 8BfudOil6DoEhsSwd960nUa+JQHg=
X-Gm-Gg: ASbGncuQdFj8WEotutQ/yzBbL2Q4LYkzmzSAE1ZnLJw3Y+S0UX0z5jhCQH1yDFtMFzi
 lSnoewpt92CLm7UsU5OdwAEXTV6haTQ9frCIAXHSU7LuCfxvGH/9fbJt2cXtiVAKMCSf7tw==
X-Google-Smtp-Source: AGHT+IFHHGu37UV85sZRnD7Mr5Vn/K3clBdx+O3bPZfisMG44+t/isOlDRf73PkD2PdfiZh3Zo3P45St3r3q/VBmtsY=
X-Received: by 2002:a05:651c:50b:b0:2ff:caf8:3007 with SMTP id
 38308e7fff4ca-305f458e851mr1768341fa.19.1736299231994; Tue, 07 Jan 2025
 17:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20250107225616.195878-1-marex@denx.de>
 <20250107225616.195878-2-marex@denx.de>
In-Reply-To: <20250107225616.195878-2-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Jan 2025 22:20:20 -0300
X-Gm-Features: AbW1kvYsqvEU27Ykq2y9tEgTBGsuRz8_nzq1ae2cLC5zOe_o_InRB2nlHV9eJ0c
Message-ID: <CAOMZO5BEaHyG7x3QaxYFrETgDVRMx0szk95RsfLPM-S9LUFeHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: ehci-mx6: Use regulator_set_enable_if_allowed
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Jan 7, 2025 at 7:56=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> With the commit 4fcba5d556b4 ("regulator: implement basic reference
> counter") the return value of regulator_set_enable may be EALREADY or
> EBUSY for fixed/gpio regulators.
>
> Change to use the more relaxed regulator_set_enable_if_allowed to
> continue if regulator already was enabled or disabled.
>
> Based on 335799b7252a ("usb: dwc2: Use regulator_set_enable_if_allowed")
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

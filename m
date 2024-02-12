Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6847AC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 10:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C2687C93;
	Mon, 12 Feb 2024 11:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzfdw0Ce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9C187EC0; Mon, 12 Feb 2024 11:58:59 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C776879DF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so593672a91.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707735535; x=1708340335; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uPWWYeCrMoWyjKCNOQFepcDTF2FjgMoSQn7gPsogzU=;
 b=gzfdw0CewA6pBeGJwnL9fJ/d7dcRQmgyaH0k4+JHBZph7Lc/3pnBXW6NfOF8PswUlw
 TWRM45QYiB55DnTaR6MfbwC8BQ9mOa1I/iF7KtWZ1g9hlrT43pX2rxcCUALiqvkQYHJv
 LTC5UN48+XTIO9kxlO8XvtVFVK/sKov6sZVOsW+7FVqTtL6QBrEn2VGBtdLvRtEiVwM+
 q2z5DSqtEvYTqp1mWKGTTcWFUrTCc45mzLn9LTCLAoTLqQiVdFD+SAzA2/s5ZdQpVswq
 sWVt1VYXlREFxPAAc7FHXURtGo3rYw206gHZO+LDL630c0c/4ofH38UkK5fBROMwuglY
 TpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707735535; x=1708340335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8uPWWYeCrMoWyjKCNOQFepcDTF2FjgMoSQn7gPsogzU=;
 b=fLPbOLP2vkeYacOkdy4I66mqtXZxIt5OFP2rKgJIaDTWtbgcLCccKhjkm+Ffpc7Rwa
 VjYreNlZYUdZtv1y7XoZPjDye2XbCBUzqszrV78xjvZRc3DJJhPyY9FR9OWqeG5DIYik
 hvTtddiWX2ZlgIXq9TSGfGWwuIX4+FDayLRwPPP8hYBTfnjjBWVnQ82VHPAARpek3WOi
 /LGbN8tSenwgGWjsk08xNzS7pbuli+wqmlkjTgH+XnGdz5VADnsbrjDAGhrwyEWE8GNJ
 0m4bcjJHWgL7x3DzKNuJzuSL9BBZRG6GWCe9/D41lzZGvzMaHoF1mWgaWEqZ8y96abTe
 n05w==
X-Gm-Message-State: AOJu0YyXJK96HLsH9iA3I1p0QxaJ7GkaOVcQvz0+mRfRqv0VcYSg6xl5
 VvE2QA/F+FJDYcWhSoWgnNHjFPOtSjP8vIcMCCMIoQrk6q2yyArTtdsDiB7MXvYvjXyrkooOWn3
 XCb9vsS9H5X8OGAD4THrzlnMitvrSUMEz
X-Google-Smtp-Source: AGHT+IG0r/v2Hj2vWw0vfrPXHUlQClxMPNqq8e1DtRea8AY75MyObLcXE4apfpOi/H8+bFcBWEsynMJ7e1Y47h3Q89k=
X-Received: by 2002:a17:90a:72cd:b0:292:e812:19e8 with SMTP id
 l13-20020a17090a72cd00b00292e81219e8mr4356052pjk.0.1707735535580; Mon, 12 Feb
 2024 02:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20240209000012.455355-1-marex@denx.de>
In-Reply-To: <20240209000012.455355-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 Feb 2024 07:58:43 -0300
Message-ID: <CAOMZO5B9XJcXDwTrx60vGUqdBeU_AR4wKO-c33eccDdhTPy3JA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: mxc_spi: Add imx6ul-ecspi compatible string
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
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

On Thu, Feb 8, 2024 at 9:00=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Recent i.MX8MP DTs use new fsl,imx6ul-ecspi compatible string instead
> of the fsl,imx51-ecspi compatible string. Add the new compatible string
> to fix ECSPI operation on i.MX8MP.
>
> For details, see Linux:
> 48d74376fb68 ("arm64: dts: imx8mp: update ecspi compatible and clk")
> 8eb1252bbedf ("spi: imx: remove ERR009165 workaround on i.mx6ul")
>
> Fixes: 451799a6ceac ("arm: dts: imx8mp: Sync the DT with kernel 6.4-rc4")
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.

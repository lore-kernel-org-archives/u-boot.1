Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA06C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B02487A59;
	Thu, 28 Dec 2023 17:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M+w8KcQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E04F87A13; Thu, 28 Dec 2023 17:35:48 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6C387A59
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so1444433a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703781344; x=1704386144; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGsqQjbpMc15dTQSrduH4C5gZJva2nObfO7aYG5IMxU=;
 b=M+w8KcQoJtNezd4I5Ynr4RcB5Yv8HcP5SpdgT7HRDbJFiVoEr0iRc4yex5X04y8XR4
 QPnazc3LrTQyxh4sovUlTQflP8BIsVazz7WCC/25W4PuCle7eUVztTdj8iBJ0E84HCZZ
 N2mI4IQU/NWQDU0zv+aKNtU9isIilBLf7PCtgP40dIbh8xbgaofzYquA+yfxReUShOLm
 bq/Vq31PSFgW+wDsVDSTxanoW4d9XhgeFJSaEbsxZEa/y10Lq+XodQnA9LBtIqAHjZPO
 G0ZS5iCK4l7PiiHCmmpAgsRpyFiBhUSddtbp9HCG+2I/kphiUXfKawt+pQzeIXEIO7d4
 ph/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703781344; x=1704386144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGsqQjbpMc15dTQSrduH4C5gZJva2nObfO7aYG5IMxU=;
 b=IFUQu3gudt49c38cty9lckS10GNelEBi/IeLcSuIeQl89YYltfxIuhG0qt8qlPsc9R
 aEFGAXGQK0d/08e0pPIp0NR2hZKiCkopJ1tdHYrU2qhL0otCtmr7FTrkhDA5cADySmY9
 1psZ6kNeV7RocBNxBXvEhx599NEGxMN4puxx3+5uvQegMjTDYK/XwBULMbaGPLXOdBG4
 EWl3tWUGv6x4CciV8qF0HDV4dUA5UvVmsVjhCiaCgyy80sOxP9hKCb3NKCmriCVQfuVH
 MyDHfJEQECylmdYQFDf2wipIAe1sEfQD/4GnavrNTf+Sa3aYdkBU9Xq67HdgpCI7TDC1
 7reA==
X-Gm-Message-State: AOJu0Yx2uNs66KaqqcSCv2Hk1caHpOy+3sjR6pBM1tzw85HsJEOTkd21
 TrwMj7TJKivl/OgdoekSMOZTiTNMgTPTSRrcKPMRsrTNDn8=
X-Google-Smtp-Source: AGHT+IFeQ4nO+moOEWNMpzEggu+0+j0KtycIf3o8NOMl8ITXT5X991K/4BQ03JgCUG8X6ImTvVen8xKNPgcPyxoUCQs=
X-Received: by 2002:a17:90a:bd17:b0:28c:113a:9678 with SMTP id
 y23-20020a17090abd1700b0028c113a9678mr14374534pjr.4.1703781344127; Thu, 28
 Dec 2023 08:35:44 -0800 (PST)
MIME-Version: 1.0
References: <ZY2ZDWAQuTlRjV9H@francesco-nb>
In-Reply-To: <ZY2ZDWAQuTlRjV9H@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Dec 2023 13:35:31 -0300
Message-ID: <CAOMZO5BSt4rbdSDNrcchg89qYJ6kK2nkHLFqfjdu21H_joU-jg@mail.gmail.com>
Subject: Re: Regression: i.MX6ULL reset not working
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>
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

Hi Francesco,

On Thu, Dec 28, 2023 at 12:49=E2=80=AFPM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> Hello Marek and all,
> I just tried latest master on colibri-imx6ull-emmc and the reset command
> is broken - it does nothing.
>
> From a bisect the issue was introduced with commit 68dcbdd594d4 ("ARM:
> imx: Add weak default reset_cpu()"), U-Boot releases >=3D v2023.07 are
> broken.
>
> Any hint? I did not try to debug it myself (yet?).

I think we need something like this:
https://gitlab.com/u-boot/u-boot/-/commit/9043adee3ea67f4a71498e8f06023e3f6=
3d7668f

but it needs to be more generic, at the SoC level, instead of per board.

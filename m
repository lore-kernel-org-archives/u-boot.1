Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1871C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE10488511;
	Fri, 19 Jul 2024 13:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbUqcoAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A7888511; Fri, 19 Jul 2024 13:33:31 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D896B88B7C
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ee8cccf2bbso1745591fa.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721388809; x=1721993609; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZdZRCBXe5F1rE2OoxF6ygNe4DOxhM2ql4qMkgfKm0s=;
 b=jbUqcoAHO1ANEuxARjgPwmDAlX+f3vaYKeMlDp3TG++GzooObzg6JK1d4AEqF1AVNd
 VbVxZhjA1kOpcyrhtV9JsEjk3Qh7TxHsP+BORifxkhUatg4TpOAxLdz921kaH06PVoNT
 Xj/rS15EeQn4LtF+G8k4dIlwvDIzezi9KX/NBMeKQl4OnK6b8QCHTWPMX/D5GURD/s+h
 PX7k0TuSdAyqPo0sXGShN5sBubyFTy3Pc5CYluvsWBwiQ7fsxNQPXrN5zTps5AKq4O3o
 vQLvj0iOaQ2ZhiiearD/d/EadIkithmeM5KeRbvvw6RNrkpjfHtDwbKwy4qG+cPpSoUu
 wbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721388809; x=1721993609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZdZRCBXe5F1rE2OoxF6ygNe4DOxhM2ql4qMkgfKm0s=;
 b=OeTsOiqVPGECcE2SKPjZ16c/QHGZElx9gEl9PU7zY+Qndpx9T3xmgsdcPADVZ7lzOo
 8t+5m0WgLkoiBYDlf6vMmHoVH4tm1pvZzXEWfzNgG0svcGrvHQaMYPERCwif7o3txNy2
 +0v1Gr8ELxlaxrNAF8zdoJhtwoXS4ovRDKrJngPc4p8P3+RWIzXZcpEtRzq4YK1HXRzv
 2ncVnRbgTalr/2qSoeo9cIgdVJfwbXHLtSH60I2gE5X8rKMkAVD92GCBIEISi5bUeuVU
 lP2RSt9y7QK2ctqacPaP9HSudavLnkZbW6kIgBTjOd7IEFOuEI/rGOAkgQkdNLfavL9c
 cEEQ==
X-Gm-Message-State: AOJu0YyohN3tdzTumSQw9Wv/fh39DnYfM+xHoTZSclwwY4ipb44Ga5CB
 4S4h/HVvNh4pPtO4sHU5Tr6nE4uE9y31i37o3EyVZIzHQLeAtyEq/4IwEGUUeVuWvCPTDr2pPEN
 Jx9B2APLIgLzRwTLIoPwl3pYTEq9Xx7mi
X-Google-Smtp-Source: AGHT+IHm3U4hnMIPnkIJrOKhVNApAo3gvnl2IVgc97ADOR0XLzF1hYgXMhe+DYg9za3bLmLncHbnCWmwKZE727L/H1Q=
X-Received: by 2002:a2e:be8b:0:b0:2ee:d55c:255f with SMTP id
 38308e7fff4ca-2ef0d6915ddmr9330531fa.7.1721388808793; Fri, 19 Jul 2024
 04:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
 <20240719100758.1917-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240719100758.1917-2-Zhiqiang.Hou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jul 2024 08:33:17 -0300
Message-ID: <CAOMZO5BoEqV_h5RdLKZitt+GDwAMyV7T6jH3P=t_TnovYMEd2g@mail.gmail.com>
Subject: Re: [PATCHv1 1/2] mp: imx8m: add cpu command support
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, uboot-imx@nxp.com, 
 trini@konsulko.com, peng.fan@nxp.com, Yi Zhao <yi.zhao@nxp.com>, 
 Jiafei Pan <Jiafei.Pan@nxp.com>
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

On Fri, Jul 19, 2024 at 6:47=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Implement the cpu command to kick cpu core to run barematel or RTOS
> applications.

s/barematel/baremetal

Please add documentation explaining how to run this command, how it
was tested, etc.

> --- /dev/null
> +++ b/arch/arm/mach-imx/imx8m/mp.c

What does mp mean?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E86FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B0687579;
	Wed, 13 Dec 2023 17:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLE+qXUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D584B874CC; Wed, 13 Dec 2023 17:21:16 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C2087579
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ce40061e99so1199128b3a.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484472; x=1703089272; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ9WR+eP6YZTANLhOfP9PIN1yT2yEU+HxxAOQwKfBao=;
 b=mLE+qXUln7F0aW+cTze1lIVCEmYpZ8PP2Ep0goegg9e94hsw1WId5PYqrlfeg8NSyJ
 T4R+QjujT3REvC0iAirg5RkCNToUvkC7jxpltsanGCR+gI2wzo16fY/6vMCEuk4NgzIs
 u6EwKGHcCVF/haXdbRva+DdqutFAxUNGwA97+hhp9YF5BQkH8EXRbwLE0OisK3rolGlQ
 5pIKlWAJ/yX8IezfFTZ8W/fKaL4rqa3kLornxF9BPImUlF8ElY9zPg70I6Fa5B+pu/PC
 Kt6DVN3MN4GavUPEoKfYb0j/toi4+QpJwGLTG0HPw0M/Rt0ftZi7Juth5yDUbhRn54Sh
 pZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484472; x=1703089272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ9WR+eP6YZTANLhOfP9PIN1yT2yEU+HxxAOQwKfBao=;
 b=fDXcAAZ56H5Q55Siv9Bh20t9H0G1L8hfTHNIkTQ0+uOl4ea9VTy74wJp5/jTe/1pxS
 itT6JByDGtGETLB4ekWPu7luk6etAA16244TF7MrhYlx4GbklqXhiDeF8vBvxXcv6xSM
 sneITbFROXBsqa7EGG/bQDVXGlLPT7tqhjs7SSEja1WtxZGItfG3c6vI/5XLnI2RBrAl
 cNMxI9TKWJYpDyihYjVXUjA9gH+inrLZqUlvuWIIcIyd8K+l1z47xvvLysEx+Khzc9N2
 VBSCWqZ3t4g3Q5ZHzhgnO2RQk1MwXf4SpHD3QKId2K4aFSiIxZtd7U/uwvfk3zRpNmtM
 YAmA==
X-Gm-Message-State: AOJu0YwPlyDghrdmm5LuEWH8qrMu4MK/y7wAJHt/GuvjLuMRHxb5FGug
 /hyB37PD6PdWNm4zm/ucoAS65WDbP8xd0IJICSddTOsy
X-Google-Smtp-Source: AGHT+IFrs+v5ktTwJfYJX5Ir7duf8lO/GeFgwc19B3Mmr/Xa44iwc3YmjkCL7+gZmtsyclJv7dmwgLG/9iZwFVfsGXY=
X-Received: by 2002:a05:6a00:1254:b0:6bc:ff89:a2fc with SMTP id
 u20-20020a056a00125400b006bcff89a2fcmr17495816pfi.2.1702484472360; Wed, 13
 Dec 2023 08:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20230504104111.1823988-1-festevam@gmail.com>
In-Reply-To: <20230504104111.1823988-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:20:59 -0300
Message-ID: <CAOMZO5AqSfdf4HoWMX6yFgu2LutJvr4O84RpfxPizc1-r1ppGA@mail.gmail.com>
Subject: Re: [PATCH] imx8qm_dmsse20a1: Improve SPL memory configuration
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Oliver Graute <oliver.graute@kococonnector.com>
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

On Thu, May 4, 2023 at 7:41=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Currently, building imx8qm_dmsse20a1_defconfig leads to the following
> warning:
>
> aarch64-linux-ld.bfd: invalid origin for memory region .sdram
>
> Fix it by using the same SPL memory layout as done in the imx8mq_evk.
>
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Tested-by: Oliver Graute <oliver.graute@kococonnector.com>

Applied to u-boot-imx next, thanks.

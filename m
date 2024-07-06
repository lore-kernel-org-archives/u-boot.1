Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D7CC38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05109881BA;
	Sat,  6 Jul 2024 22:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0BB0RnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB2D881BA; Sat,  6 Jul 2024 22:46:47 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC88C881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52a559e4429so333869e87.0
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298805; x=1720903605; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGQLg0i3Bqn+eFgEEoCskMjTZgvsmJp/eSITN+3FFCU=;
 b=D0BB0RnW9jtr/1QIbznnAMpGhPPBfVRPHDJv5PzCfSHG4K70kGRknbZrvhz8ujtChA
 CH3u484Dj/J3u6wR5JE4wSYf5IS7vZuAI6jqBOUQTAjlrcMwn/nOmQpOfxNzfGqAOiin
 V9xnQjrhSNNF+635FUocdKr1Vsp/F8D1CNevFLq4yECmZXOiiGS0WtdNYC581xmGhsfR
 qllHPBelto/MSfol5KV+m3hb3ZkuiQ9gvCZm/Rlws4SAELu/SVxTjC6dfDWWCCkbZ9bD
 UKNZvS+wMwzvauIZQAVM1ccFoghm6l49y/+8pNm2uWC9Eqs2vwJk6ByzzcCepE1COUr4
 F+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298805; x=1720903605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGQLg0i3Bqn+eFgEEoCskMjTZgvsmJp/eSITN+3FFCU=;
 b=dkdeWrJYtygePEQaEXqF2g8mDHCOwhczLorEbGirchGdOwK3Ws/RCGn7smTLbMz3mq
 K8ON3AaP7hAl8P266GU22I0v9LQZxXgUuioWlnE8nc7YB2bhvzM6z6m51IXa6vUrJbjB
 2eV/DwS0WsUEi0COoZB2/1tZgq0byBzql2IETZRrKqMLdG6IV1rvyxnKX8ZeckMfKI/A
 CU1eTs7VQt8R5UJuZtbaRkTLrs8RDctFHJkTeROJX2223WWcjzHopELU0ok+10ya4fak
 mj5xAVY4qtUpNYtHGLbjG2BozFlb+j5Ohcmf+f53XvPDQnmRj+mPu9nvwbKo42VPzWIw
 KXrQ==
X-Gm-Message-State: AOJu0YzzhAguh/pL1QfMm6Dr4QIVIiI7UWV0NRFS4uS6Y7tWk8wX3zAi
 6ytGqQx6jWCMf+mE8jYSkebMbRgVl80HZdHFAQEN/hF8DIIdeq5ZMaijnzngHU/nZ+u8XVaj7Ql
 RchKaUoHc9VfYEpLZJMy+UC9EdtyYVQ==
X-Google-Smtp-Source: AGHT+IEesMB2JgvznFBNyEXC8Z96KK2yZQKv/GY9wILiti2k7kB0gFuzI6z+nuYBNmCqTX6QrmsTOeEkffJYxvazy2M=
X-Received: by 2002:ac2:5df7:0:b0:52c:dae5:af2f with SMTP id
 2adb3069b0e04-52ea0431fabmr4320966e87.0.1720298804709; Sat, 06 Jul 2024
 13:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240704212247.178521-1-aford173@gmail.com>
In-Reply-To: <20240704212247.178521-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:46:33 -0300
Message-ID: <CAOMZO5AOOQkoenLg8+uKVho2tjw0AUEfw2x0p6XwgEJDvXcg_A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx8mp-beacon-kit-u-boot: Drop EQoS clock
 work-around
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tim Harvey <tharvey@gateworks.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>
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

On Thu, Jul 4, 2024 at 6:22=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Since commit ecb1c37a7b64 ("clk: imx8mp: Add EQoS MAC clock"),
> the clocks for the DWMAC driver can be configured, and removing
> them breaks operation.
>
> Fixes: ecb1c37a7b64 ("clk: imx8mp: Add EQoS MAC clock")
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.

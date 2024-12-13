Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AA4E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2058010E;
	Fri, 13 Dec 2024 11:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="keI1gFJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359558012C; Fri, 13 Dec 2024 11:58:52 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3E7800D6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ffa49f623cso17359821fa.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734087529; x=1734692329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EKshlzEQ9f5Hp0NEw5QNgxn6UcZ+sCb8oQzhBpfDbxs=;
 b=keI1gFJNHi5fZfTeO4IGeN+wLib3tU1RiAaXjwXWlfZPBAWCYfnIFk3uz70mbU1hNb
 5HVjHiUQ5Ini3Zfy6a/Fq4wCmG9YAvHkFxa/K/PL91Jh7pcqcVlYFvjJr6cLjq1n4Gdi
 aM3UYMZadyRtMsCd9tsLZjm8ns+FzcSdQPQ4L+mFMnXekBNvNdQ+WyPnka9gs4JbJ52o
 DmdypEbEatw3Aw+wH63mX7p4HgLibhFy34/A6IEzb4v8rR5q7GbB1keWC5gr5J1/ZMNK
 Y75SYva89AvrXqztLQtxE4T8CfaySGh6Yuh/0CUFCyI+P7Qo90U1upklvob/3TRrk51n
 uI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734087529; x=1734692329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EKshlzEQ9f5Hp0NEw5QNgxn6UcZ+sCb8oQzhBpfDbxs=;
 b=tBd0il5tqAUT/0DlIr0ET5F7S3NeSnb5x8KtWvO3L/9p49rjjTM9vqWWJeSzVDu+DS
 ETcBbw2lC/ZGdfehIObH5Uh3tk6TIDTg611JQLOAHbzwLA8uoWH5a7MNPN+2fCLAVaKl
 ZEalLdQ2Mmfqg3FIYmK6FylRDpVapJwpsKF+gnk9USdcwLah/usKDY36wmyJsQALmzZr
 U6vgtRYkt6DFfwZ6UfQ5cAYUO8bHn4RryVgJEi/SDPJubmkkRtb/7k6pNhD0xVbxbW5Q
 i87/oMBOvm2Pi1p2gw9I6LM8zEr1M0sr5bsr6FGQ2N/0ycvMrGD8roFwboIfg0VL7zAm
 HzNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGnRFSTe6a504RgY4npTayFDINrFd36lbhi5fqWn87c1RLEMNZkiBgh1ReaRifVAtmp5Tfmjw=@lists.denx.de
X-Gm-Message-State: AOJu0YykAP7JDXp2KIEbGL2D9NApmNIVCDHeO2Wbsv4Xwf5Qp3gaoDcr
 M5GqLDUZRFyHbG6DH2N+MXlZgkecRsOuZYQFvrLQglWkWs+EVj6gqTa091Ai+8eEttz3TCtscNK
 nUufC7gAZpqmR/HnxTVuZouC9jPQ=
X-Gm-Gg: ASbGncuKoaOECiLIO6lxcKUvAZBNJFKwyd1fGgelHqKdi26ik3QhBSmYlps0mv6hKfR
 SR2chsgNo03yrpFMmx5YX3Pz48w2eewIOcrH3Lzc=
X-Google-Smtp-Source: AGHT+IE4D7otbpLq/7h9xtKtINIqZYppXjbKoUwouw9skgrGsogi4T/j6ub5lFo/vzDpp576MNmqt/l53Q72HSSPHds=
X-Received: by 2002:a05:651c:501:b0:302:34da:ac30 with SMTP id
 38308e7fff4ca-302544617f2mr6170741fa.18.1734087529090; Fri, 13 Dec 2024
 02:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20241213102321.2166920-1-mwalle@kernel.org>
 <20241213102321.2166920-6-mwalle@kernel.org>
In-Reply-To: <20241213102321.2166920-6-mwalle@kernel.org>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Fri, 13 Dec 2024 11:58:37 +0100
Message-ID: <CAEyMn7apsamXCxs6FWgd79u=QtUyQq6h1oMU1EJeAsWNqU5sEQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] board: sl28: fix USB0
To: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 thomas.schaefer@kontron.com
Content-Type: text/plain; charset="UTF-8"
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

Hi,


Am Fr., 13. Dez. 2024 um 11:23 Uhr schrieb Michael Walle <mwalle@kernel.org>:
>
> Since commit 61ff13283c3b ("board: sl28: move to OF_UPSTREAM") USB0 is
> broken because the former u-boot soc dtsi was setting dr_mode to "host"
> but the linux device tree isn't. That is because linux fully supports
> OTG but u-boot doesn't. Therefore, u-boot only ever enabled host mode
> and never OTG mode. Add it to our board "-u-boot.dtsi" to fix it.
>
> Fixes: 61ff13283c3b ("board: sl28: move to OF_UPSTREAM")
> Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

Thank you

> ---
>  arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
> index aacf181e2dd..4202d1e5654 100644
> --- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
> +++ b/arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi
> @@ -203,3 +203,7 @@
>  &sysclk {
>         bootph-all;
>  };
> +
> +&usb0 {
> +       dr_mode = "host";
> +};
> --
> 2.39.5
>

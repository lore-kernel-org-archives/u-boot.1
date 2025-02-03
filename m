Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59187C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DD5800CF;
	Mon,  3 Feb 2025 16:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8cQpo8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C81801BE; Mon,  3 Feb 2025 16:13:49 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4554280079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so4125908276.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738595625; x=1739200425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g8oRLTj/Aw2U9yYEV2h8tui7pBGB3PJ2DX/wcYRD4JE=;
 b=w8cQpo8uh0j7776WyzeWKxp50tgLpX8nlNKoEXvSYf9kWRsPwnWavqIbtGInTVJ6K6
 44W86ilnHbKCxF/eClYswfjHLku4yQ+iqudzING0rlcO3De3dYia4h1sy1hC7RnVU6MV
 qlAeZQ05EX6HZPc6qR6y2yU1TloY+PJmxOro6m53CkR9xyaQ11bNk4vxCPL77HHdHh/7
 He0Yoi9Zr3TXichxbesi4uhtAVw2HfmB6ofUukNj2gNIR8ZPXbSLWbKGIKUdfAqvDVxr
 yRojwQqQ6Wb/b68nPcEXADfyhUB3AWNcgQdPhKS8MupRiIp6wVoAXY2SzjxSOPLpQTB7
 ifOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595625; x=1739200425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g8oRLTj/Aw2U9yYEV2h8tui7pBGB3PJ2DX/wcYRD4JE=;
 b=Qa3EGJ0Bif5uRP4ElPiK5a94khCiSQXC1fHg62hYgZUj26QLiae6oF7dzOn9gR8SEE
 2/q1p7x3Y6myh2HtVurA0bBeVxaUb1cLwVcAL8vL3Am5U9CJ92k6iIn4aqK/b8/j+JVo
 ItW/9WE9ZzWhTGxtWFzH9Bkot6I/q0Skkb2WSZy4s8PQWL2Jiw7ik4rSRCHKog1gvszI
 uL/HKmq3Au1MyXYmdC3UI8egsIL7TnHB6EM98p5iunuQrnyyC+c3jwOEiBdWrqSaLHDP
 V5QeGJsaNRMGclb/NTHm+J1LSdIJ2wEkl64OdsLm22g4FpnHNJFaVrQNmwPb2zdKRj9p
 HgNg==
X-Gm-Message-State: AOJu0YwtvNFymijiQjauhyWtMOGraU23k7V2YiBELaBOCmjWQSBH89v1
 chy57H2kHg3hTjbcRQi5v2+vAaQV/7aFFRuonbk2MppxSjBQcR+kmLftujhLEyWbdvxHZ5RTCqg
 b2JJEkeajC7Ony+9wYvRnqY6qXIGJ2FCquH+yxg==
X-Gm-Gg: ASbGnctxJM3Mj0+Ag4AzIxX0yz0LJJY7QADj/yTbPAEKhgWGkh6kut1kmr1b00G+ELZ
 43wLjFvMtaNNyH9NxUwXC0egEzX++Wafr9MkyFsTY6qzhaoSok5Tg/j9XqDY/KuZ/fZdVyWxG
X-Google-Smtp-Source: AGHT+IFEsH7SgjG/I7jLs1xveZXIth/uxsVKXArdh7OvejNeyn2mqOgiJdVTEMJTkbrC5K0tjGuue+1LBsVThpk1XMA=
X-Received: by 2002:a05:6902:1b8a:b0:e5a:c9b7:687b with SMTP id
 3f1490d57ef6-e5ac9b76a81mr12651624276.34.1738595624526; Mon, 03 Feb 2025
 07:13:44 -0800 (PST)
MIME-Version: 1.0
References: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
In-Reply-To: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Feb 2025 17:13:07 +0200
X-Gm-Features: AWEUYZnQWQg_domxOJffK9H7HXB-S42tZosu7V_uAyzf-qZ4lU9uZW_ftoG8MN0
Message-ID: <CAC_iWjJ05Ge10G8KgXEqb7zuRboYxH7KVQC8FdrjptTfTpZ74g@mail.gmail.com>
Subject: Re: [PATCH] net: Kconfig: Select DM_RNG for LWIP
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Adriano Cordova <adrianox@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

Thanks Michal

On Mon, 3 Feb 2025 at 17:03, Michal Simek <michal.simek@amd.com> wrote:
>
> LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
> is not recorded anywhere that's why select DM_RNG when LWIP stack i used.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  net/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index 24508026200d..6c684624fd6f 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -249,6 +249,7 @@ config WGET
>         select PROT_TCP if NET
>         select PROT_TCP_LWIP if NET_LWIP
>         select PROT_DNS_LWIP if NET_LWIP
> +       select DM_RNG if NET_LWIP

There's a WGET_HTTPS symbol, I think we should add that there

>         help
>           Selecting this will enable wget, an interface to send HTTP requests
>           via the network stack.
> --
> 2.43.0
>

Regards
/Ilias

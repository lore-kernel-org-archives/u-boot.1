Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED44ECF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111FA8908A;
	Wed,  9 Oct 2024 03:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aZNfWlIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEDA889065; Wed,  9 Oct 2024 03:51:47 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C672189038
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e03be0d92so2053297b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438703; x=1729043503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w75rPjpaB2E0yxRgFoliW6Q94CdzGQq3vjM6OUdJM6o=;
 b=aZNfWlIkwI7Y2N+gsgVB4NbGbfH3UDAr0oUQQuEHYGY9RBpVe/ho4AsIH1mYW6qYAz
 yNelIoH+iEmfdBn0LIhH2tOt1eMbPk38l0grE33+8G13F6GvAUxMHF5QvIa9UMWvEoC4
 GyO+h4QunWpbKEeU2JodV47MjlW/dcVcDeq3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438703; x=1729043503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w75rPjpaB2E0yxRgFoliW6Q94CdzGQq3vjM6OUdJM6o=;
 b=uyTe328aCU1wB4M4cO2vMSP9nkNWTNI7pGPRlCZcqv49cTLV2Gxfcesav8VwJ9VoBc
 0hBRkG0mOAJ6tR1kyA0fXliF9luxRb2Gv5VAYl5rVBQ+HjIy8dR3z2V0ejd3oI3YDUyr
 BYs2mBAHfv3H9Yr3YFYztiJ1u/2AMgejuxN9xrfTrXloK2mFaY1rjkccecN3vOJuMmCJ
 K26sU4M0/8h9S1kCb3Kku2xat1PzMORjd+nqS0HcrkQqlhmq4f+Bc0HMNIE+zoZtCJaT
 qhBqcfkzL6LlSEGEg08M/lPojTT05+XUze5DGJuepxGMdc9ASeelsRqW+aQBX7Z0xMYJ
 ht0g==
X-Gm-Message-State: AOJu0Yz3KilZpHHVLa8oRgNsEMZ56ixknh3MNJR3mFMeSl5YZg//nyCe
 xKdlPi1w05WoCO3rFZmX97SMH1AEdWWIG+QcolswX6BFIhkaM8lLBOvd4CnkzSYQqXWUCn6FjHQ
 Mwngq0teuEmmF0GVJaMQ2UgifIoYkvJa3JxiA
X-Google-Smtp-Source: AGHT+IEfxtCoejnF8j9pnIWsq1ZKig8O35wmKiyXY+m5bLYpFx9wD39uusPUskdcZxy43GnvzFX/5I8c3ybPWsk5+3k=
X-Received: by 2002:a05:6a00:1487:b0:71e:49b:59c9 with SMTP id
 d2e1a72fcca58-71e1dbc7550mr1413057b3a.24.1728438703301; Tue, 08 Oct 2024
 18:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <f980100c26995da542aff85bf89788e19aceb7b6.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <f980100c26995da542aff85bf89788e19aceb7b6.1727968902.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:11 -0600
Message-ID: <CAFLszTg3rconzzG89SddKT1cSQy0DgHkJsE9hNzbXZLBHaaxxA@mail.gmail.com>
Subject: Re: [PATCH v11 01/29] net: recv(): return -EAGAIN instead of 0 when
 no cleanup is expected
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Maxim Uvarov <maxim.uvarov@linaro.org>
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

On Thu, 3 Oct 2024 at 09:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Note: patch posted separately [0].
>
> [0] http://patchwork.ozlabs.org/project/uboot/patch/20240927142038.879037-1-jerome.forissier@linaro.org/
>
> Some drivers do not behave properly when free_pkt() is called with a
> length of zero. It is an issue I observed when developing the lwIP
> series [1] (see "QEMU CI tests for r2dplus_i82557c, r2dplus_rtl8139"
> in the change log) and which I fixed incorrectly by not calling
> free_pkt() when recv() returns 0. That turned out to be wrong for two
> reasons:
>
> 1. The DM documentation [2] clearly requires it:
>
>   "The **recv** function polls for availability of a new packet. [...]
>    If there is an error [...], return 0 if you require the packet to
>    be cleaned up normally, or a negative error code otherwise (cleanup
>    not necessary or already done).
>
>    If **free_pkt** is defined, U-Boot will call it after a received
>    packet has been processed [...]. free_pkt() will be called after
>    recv(), for the same packet [...]"
>
> 2. The imx8mp_evk platform will fail with OOM errors if free_pkt() is
>    not called after recv() returns 0:
>
>    u-boot=> tftp 192.168.0.16:50M
>    Using ethernet@30be0000 device
>    TFTP from server 192.168.0.16; our IP address is 192.168.0.48
>    Filename '50M'.
>    Load address: 0x40480000
>    Loading: #######################fecmxc_recv: error allocating packetp
>    fecmxc_recv: error allocating packetp
>    fecmxc_recv: error allocating packetp
>    ...
>
> Therefore, make recv() return -EINVAL instead of 0 when no packet is
> available and the driver doesn't expect free_pkt() to be called
> subsequently.

Do you mean -EAGAIN ? Otherwise, it seems like this comment relates to
a different patch.

>
> [1] https://lists.denx.de/pipermail/u-boot/2024-August/562861.html
> [2] doc/develop/driver-model/ethernet.rst
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/eepro100.c | 2 +-
>  drivers/net/rtl8139.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/drivers/net/eepro100.c b/drivers/net/eepro100.c
> index d18a8d577ca..f64dbb7d6a1 100644
> --- a/drivers/net/eepro100.c
> +++ b/drivers/net/eepro100.c
> @@ -678,7 +678,7 @@ static int eepro100_recv_common(struct eepro100_priv *priv, uchar **packetp)
>         status = le16_to_cpu(desc->status);
>
>         if (!(status & RFD_STATUS_C))
> -               return 0;
> +               return -EAGAIN;
>
>         /* Valid frame status. */
>         if (status & RFD_STATUS_OK) {
> diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
> index 2e0afad089f..5f4b1e2d3a0 100644
> --- a/drivers/net/rtl8139.c
> +++ b/drivers/net/rtl8139.c
> @@ -433,7 +433,7 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
>         int length = 0;
>
>         if (inb(priv->ioaddr + RTL_REG_CHIPCMD) & RTL_REG_CHIPCMD_RXBUFEMPTY)
> -               return 0;
> +               return -EAGAIN;
>
>         priv->rxstatus = inw(priv->ioaddr + RTL_REG_INTRSTATUS);
>         /* See below for the rest of the interrupt acknowledges.  */
> --
> 2.40.1
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F43C83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0280E88C05;
	Thu, 29 Aug 2024 16:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aQNlKpb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C4A88BCD; Thu, 29 Aug 2024 16:05:08 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA8988B94
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a3375015f8so40307385a.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940305; x=1725545105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4FR8s+8j3rLsw5lMWQuNtZDQOj1d1j0nTlxhPSJ+Tbo=;
 b=aQNlKpb1zQn19jOkeRNkUU+lCtFMUZ14BIOZ5LccN8P2yKYIvIawsqS+V8jlPGRFBZ
 R1T1pEhbNs03CJhLxB7quspMsfMyuUXGeULm5zV5xIppS8nv4F6B6rOuYbDf457aV/A9
 LsSgJpV914HiqLUdur2C2DuADfouzSrzir35g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940305; x=1725545105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FR8s+8j3rLsw5lMWQuNtZDQOj1d1j0nTlxhPSJ+Tbo=;
 b=RDWInfqa5Ctti6Z2kJbaFl4O1kGotHd2PBrdT0pJ8pfz6Pz4DZ8bETJrsW//eM7nOM
 tTHBqtOeQnJUHxDOhpLuEYZTabe7DiyBtYoGodPSyaqJRPcP7fmFTpMiG2lVYKe4VyWV
 /wyMShoWUtnf1pNLm8Vv4dC92mME1wtLPznQV7V9y89NMFYjiwvvNnFX4FnD8c0X860J
 oS4gkA5MMzYMsyRW5+62Xd4bftz+gRKk+i6C1Zg3dBgQZIIpPR3s7ib3+GiMzPXYpniR
 lRKexTqTDJBSPJvarFIAtm/MszqngjuHClwwtJTqkbNGZWEdj3k12xItPP9J39xlw8QH
 GEmg==
X-Gm-Message-State: AOJu0Yz03dRJlJ41vLZAmKILFbogIjJHC3/lXDd6nLHK3W5W3AfIQu76
 iV63aju/rcdfeA+FCMQaG0TLQ6qY2Gku0zppyzb2+E4Wwps5sOh9p5R5vjDFq79b05k30Dk2hJV
 rcO5flA/kwkiN2iJiJwoQNALUBxTFgvsFk8Th
X-Google-Smtp-Source: AGHT+IEXTuPdw6nosRIgNSiqppTD9mKcYSf3yUhxFye83jrVAu1Ir7MBW96mHKwZ24fqRsP2ScS3M/UU0AGcblV/pHE=
X-Received: by 2002:a05:620a:4248:b0:79e:ff64:39d4 with SMTP id
 af79cd13be357-7a8041d1ef8mr328297185a.39.1724940304968; Thu, 29 Aug 2024
 07:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <679e20bfd9ac3de6560e202f82452563b01fca7a.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <679e20bfd9ac3de6560e202f82452563b01fca7a.1724846454.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:04:54 -0600
Message-ID: <CAFLszTh87_wd-+XLe1EeXziMiu9p_rT-qfAgHg4PxGwhsAKUtQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] net: fm: call dtsec_init_phy() only when it is
 defined
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
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

Hi Jerome,

On Wed, 28 Aug 2024 at 06:11, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> dtsec_init_phy() is defined only with MII so add the proper conditional
> in the caller code.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/fm/eth.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> index 19f3f0fef0..e4ec769693 100644
> --- a/drivers/net/fm/eth.c
> +++ b/drivers/net/fm/eth.c
> @@ -701,8 +701,10 @@ static int init_phy(struct fm_eth *fm_eth)
>                 supported |= SUPPORTED_2500baseX_Full;
>  #endif
>
> +#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
>         if (fm_eth->type == FM_ETH_1G_E)
>                 dtsec_init_phy(fm_eth);
> +#endif

We really want to avoid #ifdefs in the code as they create different
build paths. Can you use if (IS_ENABLED) ? Also BITBANGMII seems liike
it needs a CONFIG_ prefix.

>
>  #ifdef CONFIG_PHYLIB
>  #ifdef CONFIG_DM_MDIO
> --
> 2.40.1
>

Regards,
Simon

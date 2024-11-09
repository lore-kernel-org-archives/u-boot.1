Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60255D5E367
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 12:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF498909B;
	Sat,  9 Nov 2024 13:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FlUQJxXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1CC890D5; Sat,  9 Nov 2024 13:03:26 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6FD89072
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 13:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539e7e73740so2850418e87.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 04:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731153804; x=1731758604; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt05G9RS6eTDfT2tRcOGvQUqyysyLHElQPwVHRLRz+Y=;
 b=FlUQJxXl/oDIS2KFxY7ad1G1OTpZJmd05rtdw8VNG7T5B7eNvFeEGWz2sflqb09nf5
 exOocDI+qpLgBgHKrfeoAHo1Nwa65LgKNUFYhrGnnxk9LGGhBh/aNz5ovwSFvxz5xUGv
 SviJFdgg0+rF1oF1wLSN1xyWYGxln9odozOAJN89DXuGbZpAIzfkZsTpXTiE0Iuj1hha
 a8pHcy1MPlan3OLlfwc3zuyFyRh0hw/AImhvKVIkRgfaYZ+6BmrwpS/w/+AXQDscjg8I
 yqpFjgXX6G62QcqpZNz8fwL8BgnU+mHLWWRZS55tuEyB2VkzblseAvdcMLtHQYDLuPEl
 XB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731153804; x=1731758604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gt05G9RS6eTDfT2tRcOGvQUqyysyLHElQPwVHRLRz+Y=;
 b=C8MO5zfVtud16yvaV6HMtMwXtKH+wAXUFf9N+3qmsgN2tQoD99Poo8xiuku8kwlPxv
 Vv4l/EENKgQXuCs7AmkfWkdof2K16l4u1xv0YKr4XS+3gkrfLG5RGkmIejqD2bTB5Ego
 V4D91aqceUClCKc/2PUldFNv+BVf/e8XW+KQQhl2jaNNGCcSJB9BGl++HMSAXCFwnGo2
 kTEWcCRixnKCd7ZeaOzqBP/RF9tku+7F+3knrrkTxwLFGz58jcAygyqKa1/utoA9JUqu
 l828pl+/eN0TwtT7P3YJ/sxd/mVLgcjI2l+tNkDyLA4d884fWFNtZOWkwHbBhtjJC4Nf
 dIfA==
X-Gm-Message-State: AOJu0YwzZnPBHSjn4h2NInDkLyMpYhij9Rk8To+aFhEaw9w1vIRQ3z3e
 a+6ZF6/JoIlmpMgfmw/7N/RXq82V4Jv6X0PyU64XMKHvfaJrB4yzIstsY1JPWzAXaxZK/cv0fPl
 VO+mpDAA+dUQAV5duhsxKuAjSPkc=
X-Google-Smtp-Source: AGHT+IEtmsipk/tSVTMD4/T/2WDcnomhGs4dCQkEBZrRrcWz89WAgzOmQ8ywjo5jqCgSM30TG/MW++L5EwteJmVmZeM=
X-Received: by 2002:a05:651c:b2b:b0:2fb:3ca8:efcd with SMTP id
 38308e7fff4ca-2ff2021b3admr29257871fa.12.1731153803621; Sat, 09 Nov 2024
 04:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
In-Reply-To: <20241108052143.26874-16-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 09:03:12 -0300
Message-ID: <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
Subject: Re: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Heiko,

On Fri, Nov 8, 2024 at 2:22=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> - remove DMA for console

Why? Does it cause problems in U-Boot?

> - add wdt device
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>
>  arch/arm/dts/imx8-capricorn.dtsi | 16 ++++++++++++++++

Are there any plans to upstream this dtsi and switch to OF_UPSTREAM?

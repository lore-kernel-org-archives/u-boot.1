Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FCACDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D75786EED;
	Thu, 12 Oct 2023 05:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DqGfowhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A29386EBF; Thu, 12 Oct 2023 05:44:40 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C6086EAA
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7ad24b3aaso7019367b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082267; x=1697687067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Te9eFIYPsZvFkreaC3LQ+GA06ZopJAa3Pc1TtfWz69g=;
 b=DqGfowhV3et7CLVkAIMlUcp2pYlKrFB/pd4TMqbiEgleqW4yjhYXmQhon08bbpPAL1
 k1J+MKwEEE3Ar0gSHMyZtlL4sPxpYLetpAPbu9eqL4xYn5Tx91EzaGcfcV8+Y58VIhmy
 xZT8j/8vfPjXH8iZi4ZKpTl4oQTg+k3IExdPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082267; x=1697687067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Te9eFIYPsZvFkreaC3LQ+GA06ZopJAa3Pc1TtfWz69g=;
 b=opo5P9lUbqWsieyv8A8WisrR83TfLDP5z1lmmZY9dF6XwdR7wpYhk6ODJXSnblx11g
 fRnpk4nyoeDRC+ZC6r/r4Mov7ZrQWq6riRyBCv8vky5L+WYRUFfnl5bH0b7rTqqHEUID
 vhx9t1wTLTR4ICm1k6DSeY9cCz29rtTwgEXHKWgBitw6m75s1/jaSndJL2nUrv/+oiIl
 wlWd7C+1ypkwnInwCGZNXHyaoTbOJXOJxbQvgxN/87xn7XSjz8Rn0W7YJg7cWAY4Ol1U
 NXIAdV4mEcLdB7KDQWV7jaq6K4wKKEn9pBvzSo+e1FffSh4zOprnmYsFjGipcVnocjOW
 dq1w==
X-Gm-Message-State: AOJu0Yz4O0+w86T/C5pVJYzA6n372do805mK/znbqFyG8yM2B+Ka4cBP
 wk8olWtZokSk9cNzkCzMbuMI2xZ0RCYpyZDLlfhvGw==
X-Google-Smtp-Source: AGHT+IFDDn7vQ1eGzWJwIbRD8vvMEiqvcBnHajeqt8Q/SZetNhjouSLjY1EjvNlieNHgIcKOJLwPnhtkCggKGJHeclU=
X-Received: by 2002:a81:7c86:0:b0:59f:687c:fb36 with SMTP id
 x128-20020a817c86000000b0059f687cfb36mr23652618ywc.45.1697082263699; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-18-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-18-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:27 -0700
Message-ID: <CAPnjgZ32A=uuBthz_cFUT563pKWS-+y7YMNdANiqOQ1JGwBYqA@mail.gmail.com>
Subject: Re: [PATCH 17/26] spl: Use map_sysmem where appropriate
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 uboot-imx@nxp.com, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> All "physical" addresses in SPL must be converted to virtual addresses
> before access in order for sandbox to work. Add some calls to map_sysmem in
> appropriate places. We do not generally call unmap_sysmem, since we need
> the image memory to still be mapped when we jump to the image. This doesn't
> matter at the moment since unmap_sysmem is a no-op.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/spl/spl.c               |  4 +++-
>  common/spl/spl_blk_fs.c        |  6 ++++--
>  common/spl/spl_ext.c           |  4 +++-
>  common/spl/spl_fat.c           | 11 +++++++----
>  common/spl/spl_fit.c           | 36 +++++++++++++++++++++-------------
>  common/spl/spl_imx_container.c |  4 +++-
>  common/spl/spl_legacy.c        |  6 ++++--
>  common/spl/spl_mmc.c           |  4 +++-
>  common/spl/spl_net.c           | 10 +++++++---
>  common/spl/spl_nor.c           |  5 +++--
>  common/spl/spl_spi.c           | 14 +++++++++----
>  11 files changed, 69 insertions(+), 35 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D198DC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 05:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B7F88113;
	Fri, 10 May 2024 07:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GJ2VEgh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C94A88194; Fri, 10 May 2024 07:37:12 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E630880A1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51f174e316eso1985341e87.0
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715319430; x=1715924230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i+6SpaDWKVVUB3BjHgEoLfA5G4X6vWg3igCK3/cfc8E=;
 b=GJ2VEgh20URq5VcjDYrP9+/axYqb2DpzEmsuFWfzl/tIES7xmLuYwWT19G+YHXBJRL
 K1yohuEnXNhN0lVGL4BeCMv0DJJjCYtHehX1PCbGR6Sne6Za0+wNrNaYYi92xoraCIjK
 HjhWi3XIM4WzCHlFNOup/JPcCbkgsWn/ZD4ZAA/QViKQn7NSKHTGxzzsHmP2T3rr0DPs
 kFPyMTQ/7QQtxScg4e5Ohn+LtOp74lX0x232Q1NVT84Appdlahj27UYyuuCHKwbI7OMs
 HpYiP2fR2KnGvgGclHcllNs4StVv80pjfe8FywfokUXV4lFG70jEoyxmzj1MQlCj0cn+
 Nfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715319430; x=1715924230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i+6SpaDWKVVUB3BjHgEoLfA5G4X6vWg3igCK3/cfc8E=;
 b=YtD1Naz61V5R1ldiO+TgUD671ZTlpHfomVQ7Ocv5VtYnrz3q27oqgGlKc9bTMxpB0Z
 oCxYTPMl1LVppEL+02kXmClgyY86UhelVctyb6AEputiBo5kKJMQ09z1p6vH6PTgu8kx
 xEGzYgQNU55aC9ae/MvOA//go0uDkp+RHOlG3RqgjTM3XvpdI8rISqgmNrAS+A564gAR
 oQyBwlMdoCQkLmPJRJZN6wYUl4M3UzDiGwjaKRlNvXgyC5cgi+a4lLqs2L1Whv9ZYlzn
 G6oT81Ibe7ics69XX00YMylLdhqbCsQ1WfyrP1n0Snw8VL8K3E1lPtBaTGngl9bLs5kA
 8Ejw==
X-Gm-Message-State: AOJu0YwEVoQolUpenAJdfi8S+Wirhpfh2RrWjx0gBw+ntqgr6vcg6EwT
 uYlEAfG2Mh+F2j0qX8Pw4gF2krVTBBTVIlRcfhAJAAIRkKe7jdxMkrkgpck66Lulbr7L7HBJLdF
 KsogNE6KeRe5JJGzWzr4nlhaXEyqfHboVSOP8NQ==
X-Google-Smtp-Source: AGHT+IEul9wtrq6jBZ5qBvrLaW6xNz9o/6G4riV8/noYVgP7hmYgtdOGVbVMQuY0oQ9L+j9JFho80bTiKZUQf+oEN3o=
X-Received: by 2002:a19:6b0b:0:b0:51d:97e8:d2ea with SMTP id
 2adb3069b0e04-5220fb77411mr852249e87.30.1715319429691; Thu, 09 May 2024
 22:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-27-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-27-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 May 2024 08:36:33 +0300
Message-ID: <CAC_iWj+v8YqK7mA-rWZwK+j1NmG7dwMDSfSV51Q_qCGrVJ4h5g@mail.gmail.com>
Subject: Re: [PATCH v2 26/28] asn1_decoder: remove ASN1 decoder when using
 MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng@tinylab.org>, Eddie James <eajames@linux.ibm.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 21:03, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> When building with MbedTLS, we are using MbedTLS to decode ASN1 data
> for x509, pkcs7 and mscode. So we can remove asn1_decoder when
> MBEDTLS_LIB_X509 is enabled.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>
>  lib/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 3534b3301ae..7e3dc1084fb 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -82,7 +82,9 @@ obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
>  endif
>
>  obj-$(CONFIG_CRYPT_PW) += crypt/
> +ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
>  obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
> +endif
>
>  obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
>  obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

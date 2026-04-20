Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F51EA71BB
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BCC83B99;
	Mon, 20 Apr 2026 06:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CXLSP/dM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E93C83BC8; Mon, 20 Apr 2026 06:27:19 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1261B83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba3b9601b97so382880366b.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776659236; cv=none;
 d=google.com; s=arc-20240605;
 b=TbAACJhsJYI2C6Qjywh353h3a1uzwwbh3pKRD8W4tZ/Gm+gOWKFFDXwiiJ2KarXD2a
 0hI+sYRY9xmlMb2exscrc33rRtaorJ/2Du0JuhTXZnf+k/PnjQi0fFYOY6Mqs0e2lO9e
 BkXUkOGtdL51WGtINDNgef6Rssb2BvHXASdIGawcE6kARX3z3b+e783cwY8bM/OHFeqF
 hPYE5YcqYU2takPnlnkjKcPLoywCMfTCBYoPJ+7Q5ZQywcWa8yKVTNfzuNOd4iKjXUsF
 jBZXQcHJn0q5sRqOZP/dNRd2JXlLBTw0CGQ8jsiDtaMIodUnAtb70jAx9ySIjXOzMzTH
 QX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ebVc4ijCxOyOF4OhisBlxIRjzsqTdMQ4vk+J1uaQsT8=;
 fh=zWl3So9+fODPop9tZWtOyjgwqy8hGUpXRjmylG4dyN4=;
 b=NmYULZJ6qI3+6oXT310sbpTkL8RA5t8AyZa5aBHte53tcRzqEUyffmpIvvl3P2pQ6x
 xtuEmqrrixlYbo9p5OiuRpg/IG0zhMATCZtuf5A270NRPr7yM0jNoYJSpspUxSjUHKCA
 fq32qbAgaE8R3oiJix51H3EDdNAYDMt2rjS/Za7KFKrjMLn53tdAhpZfUg8CGnBopsiO
 AyUeFQXJlHt8NIHkx/Q7TP+5LMUiY9n8wQibtTT9oHPq6qs0yegdBVfE8VO4rNIoO2rx
 rWfeSF/UqOPAgxlrTS4ZaKxvbfZSlctygEVTKrynTGCZPxqSRqGRmmVhEPQlYDbXnJPd
 pf2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776659236; x=1777264036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ebVc4ijCxOyOF4OhisBlxIRjzsqTdMQ4vk+J1uaQsT8=;
 b=CXLSP/dMI5+03m9c/b7NXFKCX3etRCnkgQeGPLiUJuYWidy3rJHQwWHq4hlArWQmW8
 CLsAfU+Oc4RnyHrjlY9YXouvE7vv20/DL2AkebZJsmN7zRO3i8D9o5d+kW9rBdl13NAE
 d3e71/Mz1p9ebpNmqSrhA3kg363vfJngDKUiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776659236; x=1777264036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebVc4ijCxOyOF4OhisBlxIRjzsqTdMQ4vk+J1uaQsT8=;
 b=lrSJFx3GjP1Lf95T4pJ+7q2MSyXbX0K6gI+4beEqAFpnUnkjwiUaB1Ah+W3h1n/Omi
 up9zgh7t8DCU/svMT1zGN78d1B1WVI4RD5pBHzBw4GUeFt+dLOqedF6zars49OHf17Pd
 wgX1qmm4MDIwwG3WiX/69zX2dlfUGSw+qeVWFf0x3j38WeQMkqzvamZCJacU/pOphOKj
 JJx1M7tAsrVNEp+9pcA8fiBCgG4YC76Gbpih89HXC1JZergdHXQj9nCC+nyllxia8oTB
 7KBP/0aHnKeWIz0/hOuOLD3a6lzxp22shIPsrAPX93Yt/Zt/J22tB0Qoe4OqA999Kyz1
 wZeA==
X-Gm-Message-State: AOJu0Yx3N5kRP1INWTt9s3ILaigPtd6owqxhD9cyPPL5Z8DO6/RGT2Va
 o+pAFXaL4m83bqcGZTwLdaKaGTW1PppDojzK4QESd7sUVWqg3gaVpFGajmqH/gQqgVa35T6isnZ
 3dNUdcEyp7djzZrODFzWIaDFdiuEtV++CN2WluWz1
X-Gm-Gg: AeBDievStZPGlatzuSbDmwXWBjwuJlb5SMr5h0E/5znFZXKECPItdtkyLOZRNnYxmOG
 5jEWHU67umApWY6M1W/1q/++CkYSwZYxjhrgjm3ul0m+UMp8iYYMrETLtRisBKO14F9gmm2G7ma
 1W3DILdUQcVnH2ny11WLMw7R9dv6SQYSjM93x01b9KqDP4eVjIgTFI9XS92R6Y+4fmMcmO2OVqu
 OZAeTC5YxaC921ebV+iUwezPeXQ9ThM3E60m9HaT8W6m4C2UOQ0nejUPr3n5oKNCNg59bDvJQI/
 TTHsc41PpnkEt0kUz0kQ
X-Received: by 2002:a17:907:6d1b:b0:b97:ce8f:b9db with SMTP id
 a640c23a62f3a-ba41916eb89mr525366566b.10.1776659236297; Sun, 19 Apr 2026
 21:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:27:03 +1200
X-Gm-Features: AQROBzACsMqcZS2W3-E4GjMmaex2eovy9tsQ2r3T9pE2VdDWVox4SslQFKpS-8A
Message-ID: <CAFLszTjN_MPr-RtBm4QMzcKVGU3mz7_TouvBugWOG=7CeTCb6Q@mail.gmail.com>
Subject: Re: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
To: Wojciech.Dubowik@mt.com
Cc: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
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

Hi Wojciech,

On 2026-04-09T07:47:07, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> tools: mkeficapsule: Add disable pkcs11 menu option
>
> Some distros are using gnutls library without pkcs11 support
> and linking of mkeficapsule will fail. Add disable pkcs11
> option with default set to no so distros can control this
> feature with config option.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>
> tools/Kconfig        |  8 ++++++++
>  tools/Makefile       |  3 +++
>  tools/mkeficapsule.c | 14 ++++++++++++++
>  3 files changed, 25 insertions(+)

> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> @@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)
> +#else
> +             fprintf(stdout, "Pkcs11 support is disabled\n");
> +             return -1;

Please can you use stderr here for consistency with surrounding error handling.

> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> @@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)

The cleanup code at lines 420-423 calls gnutls_pkcs11_deinit() when
pkcs11_cert || pkcs11_key is true. When
CONFIG_MKEFICAPSULE_DISABLE_PKCS11 is defined, these can still be set
if the user provides a "pkcs11:" URL, but gnutls_pkcs11_deinit() will
not be available. Please can you wrap that cleanup block with #ifndef
CONFIG_MKEFICAPSULE_DISABLE_PKCS11 as well, or ensure the function
returns before reaching that code path.

Regards,
Simon

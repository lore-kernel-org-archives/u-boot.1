Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3BDC2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3222686EDA;
	Sun, 19 Nov 2023 01:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MX6EyfOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1578C87006; Sun, 19 Nov 2023 01:43:26 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A8586EDA
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9d216597f64so437494766b.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354601; x=1700959401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tz6P96QUD105FW+BI8o/OmKDz+DlWKLpJkO1CmXBiag=;
 b=MX6EyfOh9VOuMMNNTwmIv4InDI73rER5yEfVNykEatOOJjm2+EvtGDmmtmtIdjIC43
 4oa0T2Sbfo4yT5trCqxfGKi3FyLOWm9WoRCn+nqpgERbO3nVyJBqHz7DA2HZ7Efq21RS
 L8ULZ4k0EfSl56Yft3H5lXEm2UD2uDcvl7w9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354601; x=1700959401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tz6P96QUD105FW+BI8o/OmKDz+DlWKLpJkO1CmXBiag=;
 b=HE65EjqEWKaVheiehZSPPwyy/Clh8DPs3YYEg8TwhL/8iTZPMFJTFuPF+bQfJ6deek
 /3jCba773kfs45PhdrycY6YUbZi0uhP1DwkO2ZJ9XcIuGZQWkSV2z8cvodZwIfHfG+gs
 9dcCrYOqz7FGSDL1H470LAx/+uC+67X7AzdMIfIpaDQN4E7HxQPgHfaFqEApZbZhuiYJ
 jZ17aqTe7w1ieVll6gsEuOMuFRpQkBLTitutiE5ND0cvZjSyQD8xcig3UX3kAv6dXPzz
 wuIiTBI3I2T9oJvq8JDA7pCQXNVxVlYVWVKZgUf38rX+2iGk8+Vc+YVVYSc0s7LAe82P
 1/7w==
X-Gm-Message-State: AOJu0Yz8gNwDnIf+1XgSVp4DeUtefS9Q6ghVc9Ab+jLiWhA6Va3wFHqO
 d5vb5p4xsLJsEcq0Qp0NeY47HER6mGA6yv7moO79u8Ehd8HpvhxN5EI=
X-Google-Smtp-Source: AGHT+IHNj8NuaE+1d2QLV7C78CyIKp6QG6dm5o3vZn/1crznVX9o/CSQ5WZPJxiEyOw5sR9UC1lxpH9qCDKK5dIQGNM=
X-Received: by 2002:a17:906:99d6:b0:9be:68db:b763 with SMTP id
 s22-20020a17090699d600b009be68dbb763mr3981866ejn.71.1700354601243; Sat, 18
 Nov 2023 16:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20231118215237.94875-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231118215237.94875-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:02 -0700
Message-ID: <CAPnjgZ1VV13ESFie-8XEu1JEC=5YX9D-TATDVPwJC6M7AYTxsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: simplify acpi_write_ssdt()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sat, 18 Nov 2023 at 14:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Converting to void * is superfluous when calling memset().
> * acpi_fill_header() already fills oem_table_id.
>
> Fixes: d953137526cc ("x86: Move SSDT table to a writer function")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/ssdt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

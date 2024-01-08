Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F26C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EBE787ACA;
	Mon,  8 Jan 2024 01:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="niuyrbbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDFA87AAA; Mon,  8 Jan 2024 01:16:39 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F5887AB1
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f9ace0006so5439966d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672992; x=1705277792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CmNabySB4Gt2vdTiC46RAwTxcnbt+OhI1vz6Tr7MndQ=;
 b=niuyrbbM4fmb6Ne80RgKrLakOybZR+8F+V5ZYpu002Y58RdXqsVE7SVKpQ3a79rkZV
 UVnJc6VJICrDZp4BEDois1dDg7pKMynkXO3BxVVNyWIsrclZSZw2uRvrzGWAPjuaJoyj
 6XX7szXkRfzxNvycq7dCVhXZYIjfAcnYN9anE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672992; x=1705277792;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CmNabySB4Gt2vdTiC46RAwTxcnbt+OhI1vz6Tr7MndQ=;
 b=DR+MYPR+eCENPv+zyDj1v8VP5Fvl3mqGECHghKUEC7LI1QgeFvEreOsS2JNuID//ct
 IIqbXTseFqTeQmpCRvZ3hMlJXKt5Garlahb55PEVuPl8fStMTdFJZspBSMzbguBxvdEc
 LeA+JROxyS9vGBNky+UlMvTWKAaSi+GWWhmboUy+J3psm75qAmM3krpND3QqlqI7KtUT
 yLeI+BhRNtVelfEQGTtYlfiGTXQZRhN/MUo7rHb65eHYxy6mtv1laNLodpwC+HoQgQT9
 Rkia80rAtMY/tUx3SvMAnyMfDtY5KHIFZ+wjh/4Nruhw8niYtlxnS6BvV3A9qrSoUxcy
 K9lg==
X-Gm-Message-State: AOJu0YwTBThloSGYJGDHpdjmur1CYb7K6PZXPZj6UnOgGUddrf+fx7ag
 B9mfd/rH9xqc9u7h7YB19VwJmpDfR8TICaZXxlO+qcTK7Xbn
X-Google-Smtp-Source: AGHT+IGyU9drjNqlZou72sZzHi8QQuMd/z5CVLZVbeL2Lg5sMJzFlEJ8bw1oMX+1ZA25TGJCaHfJFjcIVpWARiI1uqw=
X-Received: by 2002:a05:6214:20ce:b0:67f:3175:7ddb with SMTP id
 14-20020a05621420ce00b0067f31757ddbmr2361755qve.5.1704672992363; Sun, 07 Jan
 2024 16:16:32 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:32 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <ZY52U+OgRMx9dLAl@hades>
References: <ZY52U+OgRMx9dLAl@hades>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-3-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:32 -0600
X-Google-Sender-Auth: HfBlJH3U7QY68soLNvcCstTx_KM
Message-ID: <CAFLszTjW3Fk+8Jsiqv17AdZ7LRU4CZu1PgMqVg2FybR36JiC-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] acpi: carve out qfw_acpi.c
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Tue, Dec 19, 2023 at 04:04:01PM +0100, Heinrich Schuchardt wrote:
> Move the code related to copying tables from QEMU to a separate code
> module.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	add missing blank line
> ---
>  drivers/misc/Makefile   |   1 +
>  drivers/misc/qfw.c      | 240 -------------------------------------
>  drivers/misc/qfw_acpi.c | 256 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/misc/qfw_acpi.c

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
Applied to u-boot-dm/next, thanks!

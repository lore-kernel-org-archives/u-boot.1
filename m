Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E517CC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805EE82CA2;
	Fri,  2 May 2025 16:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d9iYmZLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A95282C38; Fri,  2 May 2025 16:50:03 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7447582CD6
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso335686666b.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197396; x=1746802196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N2OOXdNby+DIlygeG6x3z9K4fgXEVNaMB6Bw8aBLNR8=;
 b=d9iYmZLSc8TGZOWnenVcHl+eLgdajhx0NvVywRCqL+147Q8IlUsf9J0gkPhHB3SfR5
 uVy6PSdrp82x1iz9zbMOqebWcjG8YQfI1Vy9NTxnex/yXcBgbH9dxqpKMkvp33PkPTYa
 MZSlBb7T/YtTJljxQVvG5xjUjnEQSErqHNm28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197396; x=1746802196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2OOXdNby+DIlygeG6x3z9K4fgXEVNaMB6Bw8aBLNR8=;
 b=j4qSsKjwiyUg5FQl0YGHtfZWZ4SNxJqrqGNHjxmfz8v61fBAIQTB443BN980VZL0Bs
 MiuQtVIIdbxiNaae/r3vv2Wq4N+QQeqdhOf7LPMhzpRaD+DqYp9PB0If/skUuE7WeHSZ
 7ku/v+qNrn52ytueHbfWiqlMpbz46DaOvCwYeL3reQyFp5VQHWnROoIU0J+xl3w1c5Hl
 fwzwFf59KpgQnM3qnPRos1e25Z+uupIkGvO76t7KqtmzWznUQvRR7JYPXSx4iL94Vb+R
 gTNQZwSdYTFnNZS0zqRQa5u3rf6Tb+5WWzllT32VMzbTV6opcEScMx0UERwTQRHARLXu
 0DpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoDCgJID6w+j846xNcSeokUIm1nrav9/SdC0xHFZeQ1CbudPMMRAyFeiE8AaqGNH7qgleO/HM=@lists.denx.de
X-Gm-Message-State: AOJu0YxBkz4YGnHcNux2gkvD+rj08u6m4CburoVIl7OZr7Rkv8z31cgK
 qZuvwcUx1G1yRjP26XegQfeblTCv1LN4AHeAAMo/v1hpu/tz6MhsW0OmvMlaVUsDiGU94qMq2hx
 ClzIGaRRglbcRv6MtfUF4XtMYuMMoybFk3lyx
X-Gm-Gg: ASbGncu1CrvH76x5E8SxZ7/ATqZZxeijsYUlYJNsY4K5jAF4faO0oW5FJoTJHLEdKy2
 A8bRsjg7CL81xNWhyPlbn9T8BYIMJbRopyDVvrGh1NDxdMwgXcz9ekVK2/F4W1dnTr14V2Kzk85
 WLLwudsoUJU+TH0uGqLNyjC6g=
X-Google-Smtp-Source: AGHT+IHuzsNjjEoyJG/zu2AaKPxxyDDw06lumiVJTNivc88W6Yuvc0G7coKke5nUGsDvPUfkxGymp1R8UdlnzBGNOrQ=
X-Received: by 2002:a17:906:dc90:b0:aca:a347:c050 with SMTP id
 a640c23a62f3a-ad17a85cd42mr304354766b.0.1746197395888; Fri, 02 May 2025
 07:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 08:49:44 -0600
X-Gm-Features: ATxdqUGfreIlAC-feqinXERye94nxpi9BkSV9excZPidLZefmCWNDn-_iQ5Ibwg
Message-ID: <CAFLszTjcCXDnjOjpD88tGcvSz1AOAouyHKsynzCC3tngDqzOvQ@mail.gmail.com>
Subject: Re: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The boot method is deprecated as the EFI boot manager covers this
> functionality.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 71ddb37f6bb..b973d9eb0a7 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
>         bool "Bootdev support for EFI boot"
>         depends on EFI_BINARY_EXEC
>         imply CMD_TFTPBOOT if CMD_NET
> -       default y
>         help
>           This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>           launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
> --
> 2.48.1
>

As mentioned on the other patch, we need to keep this enabled and it
isn't obsolete.

Regards,
Simon

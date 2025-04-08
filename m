Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7BEC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 06:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F61831C8;
	Tue,  8 Apr 2025 08:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HQANRk9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B15D4831D6; Tue,  8 Apr 2025 08:13:54 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639B182FBE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 08:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so4165430276.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744092831; x=1744697631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eYvFRLMQgUhk/mfueocf0LvZjL9KyH/bO1soykCe+rg=;
 b=HQANRk9XNsWqguUdL5EvyYCkCXtIvjsfDQHCq3js/5bmka0lSVf0JUBAhfXBN7akMt
 lEbUhCN7JxBeHghS1CNqIC60dpUeTJcKH09GZnn7YvSGO3kkrHPKhKtErOoeYAT9z1VI
 2XabLMdZTfKb4wzfsD4Fzo0DUCINyhUR9CCn2T3OnGmYqly7VAow6pZ9lcwDMkyVGhK9
 tiEkPVsSc/wKI8UyLHHku9TB38CrfT1lQs5M0zN0n4ktqQdpIv4LQ1z4t8eP7pvOFDbB
 s9SwLMpFRxA+3nnFF/h3G4FNahbqTCZaW6iMKScwIePo4Sb150hYgNfH5S4JXHN/JDMY
 7PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744092831; x=1744697631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYvFRLMQgUhk/mfueocf0LvZjL9KyH/bO1soykCe+rg=;
 b=H3eDgyZVjzkbAhcedJ7vMpcWOurMi1nqSV5F0S46r+c7dDlc4XLiQEMZrtqOLDm1su
 MYoyiP+o8iRJ6Y9CHuxrYAv6ospOEvlo9y8tfWp2P4+vN9L6mjMInPSADq0z8WIULmd3
 tUcEY/b5nKSpMBoddsdcCj+pLUBrnz5GHiP0J+046aX3+NrbhAQAX/4LyXZ47Cx5Ze6a
 g8DBKxfOk9oPgmAQ+H3L9ft4FLGTSGCaSkwKh1hw/zVqAk3r3BIzdtOsiOdwbPoVdGKX
 9wieg79qiopjOCH6d1HeRlqeTjagSxeha+mnt4VcG3uObbhJpVkOVExVBtyFOtl+gpYP
 dQ1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXldCa1bhc5Vy7HhpWi4y1kmGRaJa4BbOrvzPH5ATySoF8jWY8TCo/NntXhI0NoAECh9ytNlO4=@lists.denx.de
X-Gm-Message-State: AOJu0YwB5LsNyNwTBw972TU35k1Q2ZeYiwroIg+zBiojWWQ61ZpysmAV
 JGJbO65Em/jw2nVPCte+ZpIcNtL9Fl1NVo6ogWx1y8HPkU3sQLGIPh5PT0xHzlC1r4+BlU+f+2V
 MuJ6g52ijCi25oaRIYKjFynCOsXxUNwLT6OdYqQ==
X-Gm-Gg: ASbGncvcwfZ4/1Bsyp5WqEf5toyFdvAGz3sxDbqVavINLTyVvW4SDv7TlXwg8SnCBqV
 n3cYQP3ABzxs3n+hZlcV/+XphZ0EhlI7p6DBvBmU2pXP1A4wn7k/5FK83fdXEdNZ1nIwIa67co/
 o1Av/JUHvVfGwF7Uj0bht2N1dWIHQ=
X-Google-Smtp-Source: AGHT+IFBl4CFCsasjXaEfGm6BmQWE/F6tplF6JehyAtR1sMHXk+B39/p3CYfgAjJClDzhWz/WcKVdPKypDNwI6yxG1M=
X-Received: by 2002:a05:6902:1a42:b0:e69:1efc:8ce7 with SMTP id
 3f1490d57ef6-e6e1c223f3bmr26574213276.24.1744092831281; Mon, 07 Apr 2025
 23:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
 <20250407064424.71541-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250407064424.71541-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Apr 2025 09:13:15 +0300
X-Gm-Features: ATxdqUFhjjcE4mfCv3y4-yZDJ2U0bGWFyl4hE0ARPwxdXVDnEgGGFIAIVpJSLyg
Message-ID: <CAC_iWjKJRfpzY=yhGGR00RvQsb=Vs6r7nuPcnq+-EwXgdO6LDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] smbios: select CONFIG_BLOBLIST
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Kever Yang <kever.yang@rock-chips.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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

On Mon, 7 Apr 2025 at 09:44, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since commit 53d5a221632e ("emulation: Use bloblist to hold tables")
> `make qemu-riscv64_smode_defconfig acpi.config && make` fails with
>
>     drivers/misc/qfw_smbios.c:93:(.text.qfw_evt_write_smbios_tables+0xe):
>     undefined reference to `bloblist_add'
>
> Build with bloblist support.
>
> Fixes: 53d5a221632e ("emulation: Use bloblist to hold tables")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/misc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index da84b35e804..6312f54a3ca 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -569,6 +569,7 @@ config QFW_SMBIOS
>         bool
>         default y
>         depends on QFW && SMBIOS && !SANDBOX && !SYSINFO_SMBIOS
> +       select BLOBLIST
>         help
>           Hidden option to read SMBIOS tables from QEMU.
>
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

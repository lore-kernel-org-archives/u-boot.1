Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA8BC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06939886BE;
	Tue, 11 Jun 2024 15:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dObyFZox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053E4886C0; Tue, 11 Jun 2024 15:33:32 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C24886B1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6818eea9c3aso4147176a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718112808; x=1718717608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ongtRQqUhLlqcAlXDcB/IMGpz3JOPDOWshO+26El4Y=;
 b=dObyFZoxazeh8wm0jifzQaaHryce9qi1tAk7N4rlYF4R2sTlfi9KXza4KhEFwjAuta
 seC/Z0Dt8PuahDjMqsjFjCTAd3fUYPZrsItyE3xQGkaGq+RHLRRpUdroJqSAuVJMu1hl
 TNM9ZT0i3AJFuopY7MBcZ22AuF4y1QIn1ZbJdtzI7V6JrPdw1erYGnk3uRkOaEbLBzgK
 rrjxKx/67E85VGspjzUPzCaqFulcAf5djjUqMXYaHpC8FfVVA3RgHPNJ7/wU+9lUsfuU
 sOkVQcYkmoNw6bXK3BiKtmiXCz79RUAbCO6dzakKZU1DZqKPX8bgsPug8G/bI2qHbmHV
 sdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718112808; x=1718717608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ongtRQqUhLlqcAlXDcB/IMGpz3JOPDOWshO+26El4Y=;
 b=UyKuf6paaOdNJFIHi2Ho5QRitmXTLLZ7jyCnJyjZIJboppc3KkD0oi/H5Xp0NYaD+c
 qeXKlRvfrT9h506wiKiAktXzlfSE6wYNf74IoFRepCBkMU8RaAOpxqppU+kccHQaO31Z
 0k8QLPOJ6eJDF2a3QOOGRAo8aC9oO6wSjzxokSDHeIeOg1VRP2jzU8NKCDe9lt3+4ix8
 NY26fwfybU9MNqOGeYPek2o/bJanrz+sPkcWdoNhfg2QZRkFlLSLOO4NBSn+np39HFf+
 AFb0bdSjEgdvi3m32xN3BFNx/bOmxGOZC93QoBcXZnvWxWZpJtNf3a3hU1EfrcK1ZnrB
 oGAg==
X-Gm-Message-State: AOJu0Yzkif5T+bk9IlweKwuOZQ619JukcyJ96GQJds1uQytqXywNOgNl
 17Brils1mKNRNmOu9vYm6G5XPMtyX5rYWBN0FHXkdPRCWKUcW9zur2zm0ihR2CqUK9/9gGMbfEh
 vERS5hQK9zB7j+QTvYmnxZSzMIzt5ddZRRaa5EPnvs+HyIv7SRbk=
X-Google-Smtp-Source: AGHT+IF4LPbozRcW5ADwYaHmIPvmZ9xoGC1VRF7czGgaWoQjb0C5I6LGFGzYIZdtdGUQ4li1Nb7AaNvnOc8OXknLyIk=
X-Received: by 2002:a17:902:c94c:b0:1f6:7a56:eefd with SMTP id
 d9443c01a7336-1f6d03e701amr118069745ad.63.1718112808166; Tue, 11 Jun 2024
 06:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-5-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-5-79096e3ca3b3@flygoat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 16:32:51 +0300
Message-ID: <CAC_iWj+uZU59XZfdQzzMDK58LBZSLsfX1dnQKQAL4auvRXAOTg@mail.gmail.com>
Subject: Re: [PATCH 5/7] MIPS: Add smbios_start to arch_global_data
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> This is necessary for SMBIOS to build on MIPS.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/global_data.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/include/asm/global_data.h b/arch/mips/include/asm/global_data.h
> index 147a95ecea8b..740bbcdb84e9 100644
> --- a/arch/mips/include/asm/global_data.h
> +++ b/arch/mips/include/asm/global_data.h
> @@ -40,6 +40,9 @@ struct arch_global_data {
>  #ifdef CONFIG_ARCH_OCTEON
>         struct octeon_eeprom_mac_addr mac_desc;
>  #endif
> +#ifdef CONFIG_SMBIOS
> +       ulong smbios_start;             /* Start address of SMBIOS table */
> +#endif
>  };
>
>  #include <asm-generic/global_data.h>
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

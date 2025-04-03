Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E79C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 05:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFF781CF0;
	Thu,  3 Apr 2025 07:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RVNjbXno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E38681DE3; Thu,  3 Apr 2025 07:54:03 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A018043C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 07:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e6df4507690so545855276.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 22:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743659638; x=1744264438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VWkByxKPBLO8UB6+ldTk3yk5Ji6dD/ud9HwO3V14xfQ=;
 b=RVNjbXno40bfa/SF+ZP0JcgwT+1/3fs+Ggl349vglSDOOJZywa2Lct90JtOYVg5V68
 MROINWBgh+UVGqzlfcgfzGt4GSGeKVO6KGDMFVyfh0AlXWAEHztEuJx7XS/wZgXglxJx
 WJgFT4s6Ih9dfERmw3IEUVsDqEWPSWrRTLSkEujBPK27aEWWBApcITMJd7oNJ1A4GNTC
 TDvdFYx2AXMWGEaguvoW3Jt07d7Sbo73a1C4jW0NEFeSkA98NcduNv94EKnTODq4PCpB
 6FQJHgYLCIDvaZqdh597pByz97Iol91rZiB2nsJUo7ly417WXmVG9cRgkeOrOoZ/5BIz
 0hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743659638; x=1744264438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWkByxKPBLO8UB6+ldTk3yk5Ji6dD/ud9HwO3V14xfQ=;
 b=UujZoRZx4AF8dFMZau+bYH4UFwhQNg+6ZqUHJG1xFv0scdpxoFv0GSkgO+s2nmcRuV
 7EEyuUUZh54YZuZcT4Mxnh+pkNidDScDnRPEYrIC3MwRhBHQIuU9ALeIbYYzjMZsC1jA
 z15uSX/XwYWWWgb1xNYxyN6OCfdtJ+BoR94iukY/klu6sKgAxlQAv10wg8YdM0bIkHEL
 Kd7P0xztZZpVn48MRS1nrDQPXCbcoGUakcgn0AcN+rg+mz7qDa4yjwI5KgqDc78aMVXQ
 qrdBFARcuZwnsEDwimv77L6NMAuSiTn8YqZ8uG8UL3cjIHb15Mma14a8Utlj9M8gRIZ2
 d2HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaOv4kSEGO0AsLbEJfgpRyCVODWgtZW6u/TMHqQQvKtmhyWYH2tClrbOy5xG36LbLxrrdYuEw=@lists.denx.de
X-Gm-Message-State: AOJu0YxHZxS+nL5qF0C8FxTOMt3VvCJWUd0haxw4fxLUqbg+Z12mXOzY
 zc9WwQ6FzOPW/MjoPz3nHdo3IxiSpNq6VJjUp480SnLhsZyy4hke98mTQ1mlAnQ7nsddtxoILbB
 /4IkL9dk/+affp63DQWopYj6cMiI+n9IO4p6hVw==
X-Gm-Gg: ASbGncusrFkX7PrramIQOUQlETjpb23AT0Qu2/1dlGktNNrHezDiz+S2cnRZ4dMioA+
 wgyoPzotLnC9lVuzsV3Y/xB5gXQwJeq16ugL21IWp6feMzuasU7/YSRk3wAE6M5SP1qYWDZbKtY
 XIZ+cOtbn8TtoDucbq+9/Cwi+T
X-Google-Smtp-Source: AGHT+IG9okqRoWtzEYnYW3CFBi1n2/VhnVTeQC0QnOX+Phqo0HiPoWgfTiL/YshK+sEDeikzNrPNKGDXxgu5dZAo294=
X-Received: by 2002:a05:6902:160c:b0:e60:e14a:df7b with SMTP id
 3f1490d57ef6-e6e07703136mr3863661276.12.1743659637811; Wed, 02 Apr 2025
 22:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250403053444.2551339-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250403053444.2551339-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Apr 2025 08:53:21 +0300
X-Gm-Features: AQ5f1Jp65GaC2HqfvVQvTd6zBXozFgAoInuNraAGz_hoPUX6emDPgAuCVg6pmyc
Message-ID: <CAC_iWjLTUgocaxOPDtQCGS==yjV=66_=37nFv-Grv6b32FNDYA@mail.gmail.com>
Subject: Re: [PATCH] acpi: Fix table length for QEMU
To: xypron.glpk@gmx.de
Cc: bjorn@kernel.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Thu, 3 Apr 2025 at 08:34, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The end of the ACPI table is set to 'addr' instead of 'end'. The ACPI
> code for QEMU relies on those values to mark memory as 'ACPI Reclaim'
> and as a result the ACPI RSDP ends up in Boot services Data.
>
> Reported-by: bjorn@kernel.org

I obviously messed up my reported-by...

> Fixes: commit 638cc363484b ("acpi: enable writing ACPI tables on QEMU")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/misc/qfw_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
> index 0d0cf7646890..77cebae5e3fd 100644
> --- a/drivers/misc/qfw_acpi.c
> +++ b/drivers/misc/qfw_acpi.c
> @@ -305,7 +305,7 @@ static int evt_write_acpi_tables(void)
>         /* Generate ACPI tables */
>         end = write_acpi_tables(addr);
>         gd->arch.table_start = addr;
> -       gd->arch.table_end = addr;
> +       gd->arch.table_end = end;
>
>         return 0;
>  }
> --
> 2.49.0
>

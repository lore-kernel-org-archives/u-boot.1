Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F904C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27298845B;
	Wed,  8 May 2024 12:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t1qqqI+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498B688662; Wed,  8 May 2024 12:18:40 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E5F8843F
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59c0a6415fso959139066b.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163518; x=1715768318; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=60GX5JAA9s7MqFI3y1IHWx9C4wGSsNvenhGJGjcWlhU=;
 b=t1qqqI+wUuBlCxXmAEKvNOIcqCRZ2f5+5UotjodoFB3XCSHvfbwD6xxlYfGttsF002
 zzy/gedNR2mpq5opLhRIiWC3IJhNi+hNuuwe7ach+zJl52JwgTaAGfVdkiE7yFhgZ5vf
 SbazcdX8CFd+ALK9l4/R67CqezatgP1jl+wQlLcAP+cOa0uQCzjRF0PssYoyYP88vIyj
 9KQ8bkFeflsG1vp98Kt7QCFuz39a4gmEgr7OxcJfnHeuo6czu65LcYyo0LUHwp1CGQLT
 Aq++VaUgQi3kbbkTU5WI5pWe9s9WsJfLnHBgvPBp6UMmRhnrBAPA/6/EWHQkRjkMrbYA
 3JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163518; x=1715768318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60GX5JAA9s7MqFI3y1IHWx9C4wGSsNvenhGJGjcWlhU=;
 b=AEZ4v9ydlilRxrltpcyk41O9v0gQS8Umr6ISdG2m7k86TYIjUWlZE3jSyTouH+D5gz
 /BMFAmmwUUV8nl/fS4u9ZPG/jG/6FrZVVtZWfSKpAola5VpJppiBvhQnmhOIf80Ous5s
 5OMCTeFoyWxp+E1IyPoKQzahNRfTocrTOLkqdNrXuzfBqvx4Nb/0t3BIIzLtP9hb9NJ4
 8UC5bOsB0U6ylAbzj4JNfuROsvrkY/OWSBVQxZJMk0c9Vyr2Kpi8TXGIktXvTA3XDnqv
 6Arz+Brc131aVbBKLsmwxwxbTITdjoPLz53SWB/hU/zkJgLQypG6p/nkDLgbLUjWwI6i
 03qw==
X-Gm-Message-State: AOJu0Yz+VDTuQtvXGy7uaz4pnlHQkEPJ2Ur5geZGOzSfE3oS+AEtEwt1
 Idx561CRyhQJg9SLG4zB9vnIF4qOEnSh8pLRaQOnfHC+OIAylu9NjsZNbO1O5zZQGnQrdZAZCVh
 WpyfvyfAZTTDuqahyNzIQSzB/kNF1AGYCPL3GjA==
X-Google-Smtp-Source: AGHT+IE5pTJPSaBq9aWqxDTJ4YPnTofQ5p4MTGtrYnKokT5UWns/Kt3KNmsCgjXK4p8wLIg++6m4rPR566DqDE9+Guo=
X-Received: by 2002:a17:907:9623:b0:a59:a18e:3fda with SMTP id
 a640c23a62f3a-a59fb9dc8d0mr144694866b.68.1715163517734; Wed, 08 May 2024
 03:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-7-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-7-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 13:18:01 +0300
Message-ID: <CAC_iWjKf_kBfRj-V3mTTSoq=YEZp4MZM90hhi4RzkL6p2Lr4-A@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] efi_loader: remove redundant hash includes
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
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

On Tue, 7 May 2024 at 20:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
> and u-boot/sha512.h
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  lib/efi_loader/efi_signature.c | 1 -
>  lib/efi_loader/efi_tcg2.c      | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
> index f338e732759..184eac8cddb 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -17,7 +17,6 @@
>  #include <linux/oid_registry.h>
>  #include <u-boot/hash-checksum.h>
>  #include <u-boot/rsa.h>
> -#include <u-boot/sha256.h>
>
>  const efi_guid_t efi_guid_sha256 = EFI_CERT_SHA256_GUID;
>  const efi_guid_t efi_guid_cert_rsa2048 = EFI_CERT_RSA2048_GUID;
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index b07e0099c27..ac056dcfc55 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -19,9 +19,6 @@
>  #include <tpm-v2.h>
>  #include <tpm_api.h>
>  #include <u-boot/hash-checksum.h>
> -#include <u-boot/sha1.h>
> -#include <u-boot/sha256.h>
> -#include <u-boot/sha512.h>
>  #include <linux/unaligned/be_byteshift.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include <linux/unaligned/generic.h>
> --
> 2.25.1
>

Please include this in a different cleanup series along with other fixes.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

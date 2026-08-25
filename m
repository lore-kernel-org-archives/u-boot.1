Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4048CC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEBBA6070C;
	Tue, 25 Aug 2026 18:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5SFUuy0f4PIK; Tue, 25 Aug 2026 18:21:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787682077;
	bh=tPebeyBxacDb43bVOs6ztxZ2dpxoOJskYXfUKOYkJcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LDhAKt12FGt2JcZMzh15bFDlTpPNBnzGvLAJ5KXqEG/xjicLn8EZRVtfTLL/AmRZd
	 5b1xCSTlFRGXBEn8a7rqI8gKoVkmSNZ+taYDojldmENC1Hyybrq7RroCY9d7Wg6v5+
	 FDfp9sDMjY+4MXJrd8ZHhfZ/SjCZA71LZ7L1dIa4DlZzLqWc5IhmuLcsSblIOgKW5j
	 kpI9y3EER5o/WHUeK4jCSFJoe3cvkt89z4kE9lumbi3rEBLiPqEzf/5AcLGKmmU1qV
	 +gXdiNFE7rREHFSz2cSd/15/rerK36Yh8F4BrEuKblDw63OzKNzuIvp1zGhAACd5RC
	 fBz4JBtCy9JhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 554CD606E5;
	Tue, 25 Aug 2026 18:21:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A949023E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A88640441
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bA8Qg9Wl26k6 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:21:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lhSJmRlk
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99EE9403FC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:21:15 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so776330466b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682073; cv=none;
 d=google.com; s=arc-20260327;
 b=gGwYdYAo/siK7ZXLMa50vHvQn8BufbZDN+b1q6UhRuq3aLwWHj8Y5pqas+5WfZjn9v
 boe4uHrbRQ8ivEThOls5hDU2B3+T/LWb9aBWNoA1Gag4/BXT5CMiJSoPuuDc4ULtich0
 lNxZ7yCsDXMSSv3Rgv7pNqOb0afwmnngW+w+WMWIbcNPlSWEC0VryugZt7hhwdsWX2Sb
 Xg0dGz91Ww6hDI5O+FbX5szyKdh4ZFLAzc7Ij+EZWpBfv4q7RqcuO8mb0AYLMDuZpgFr
 lgUeU/XeCogjSdxPB95Ou1WA/TPiVPcwoswIQTRR1Ja7/7AD15KkC7IMuT+ht4F+gChx
 uPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tPebeyBxacDb43bVOs6ztxZ2dpxoOJskYXfUKOYkJcU=;
 fh=GY2BpgRB6aq9x26qgpww7DfQs5Xckx+JS1kQkLl1/Wc=;
 b=Xi7eV4L8MYInnLalWtR9+jADgwL77NrqR/cXUuiLxuKFIvg/s1f7TgYyfGNE8gEKjv
 avPtkj8EXb5Ya0ZdnaDW9Uzd7aUS07auCVJnwYVslRnqmu8GB2tP2A3FvHhCZIHR96Sx
 5N6mMFzMYQ6uFFX0Yk0eBl1Jjq5Ql2RJgyco3pm8sd/x3XC8D7vzBhsvndhWViI9trXT
 fTxfMubhO1qDsW1QF77pJlNBkoQh6iDDI8fme4E5NFFgz52tzCyIY1Xv3cibhRgOFlGO
 hTMYfGuL8MBJW/6+NFWy143zPgFvYdm3cQGfmvhux1QGMIfdpdlMvvfp3hDWwDRJ+kP/
 U2Hw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787682073; x=1788286873;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tPebeyBxacDb43bVOs6ztxZ2dpxoOJskYXfUKOYkJcU=;
 b=lhSJmRlkEYIjyfhTW73gsrtsLKy6dFurvmX6Xb6v3FuciEPaUmNbK2ruYrTOMiAxbj
 j6NHsEMGWGD3YLAQWfL1RKClMsVHizd5UPBi+79Sar3l6a0WFtxjr4Kh97Gv2Vh+hfIk
 3h12dWNRD9jbXXbDmMP7B4Vt/HB17iEWPV/KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787682073; x=1788286873;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tPebeyBxacDb43bVOs6ztxZ2dpxoOJskYXfUKOYkJcU=;
 b=jJ0xmshD62RwvD1bnq8FCnsf99l66fjApXMCMEdkAXBSxX90sEPguPVpNft5ARx22N
 +aocYDSxaj1ra5JdlOOGcFy5fwPFoig+bNSJWYo95LAvydvFHkw0m53hLwil8TNR03wm
 yFmsrflFldaIeVq3E40xxqLPreP/SvzT+ea1MDBVSj+WRQlp6LGcHz+ysRJF2Rk30CI9
 6LmWC4pVbONaGTvs+e76xT1BEjCyLXrO5Y2TmwDB0yigxlkBEA/U/ZgFYDtImvdBw9Q8
 ZbpGmriZHsoYdb71QTDS0O8DFComDHIygF68e4/emNyeMtblEN6psquwiE9mU02m9t1V
 /a5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTAyPr4q6lCI+va5EzfzHq6UvjwOWSkp9n4HAZYSWUBMrvP4oH/3U1050cPuHf5hiAC5SFgvo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lYppGC7XdnD5G7v3M18PVJCgIh2m+vPHeIrurZqfyQgE3AKlIp
 gdS1d/GYKpKE8hRq+l8V2PLPEjFJd+ugGiQQb7BDON4e2+mNT9x1cdmPG+TWh0BZ+7LzSe73e7Y
 /7yOrkzGKAFdCVl1LiPeGCDKhWK1pmzklPoI6O9Ka
X-Gm-Gg: AR+sD12MImF6Fj307SfsUThIc/9T4GKiCqNdRe5UkL5CnLUOsdIe4O68hL3e/Iuosys
 tuJjxEdFDi5n05G4utZVx4GDiL8V1StN9E9ED8RuGqE72D7eG57DTDv81dyWf4auWxl6Y9WiGD/
 xgvdKdXlN23wXqpLsT4w3Ck6p3+gKIwU4FL+3LKOAJhDoJM8BjRz5dV2y+Nd5n/W+O5OVs91NAu
 1WGcp1ZxT8fAuvxZEB3jxCmpPFeo/h9J1K8Z77hJCxm48naJ/VvlPz36aedGoHPEQHZ6guZA4Nf
 65z9R/OiwzcXbVJpH4Ko7rL4GSRs5rqwJ/3kx7tVenU=
X-Received: by 2002:a17:907:72c6:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c250bb58ab3mr68320166b.3.1787682073414; Tue, 25 Aug 2026
 11:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
In-Reply-To: <20260713083141.2772971-1-Jacky.Cao@sony.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 12:21:01 -0600
X-Gm-Features: AcwNN1Vkwt_vnXekZmIw_zVb2rGS26fq2DFr3ABvSi6peb2qxAlrNbk0APOcjOs
Message-ID: <CAFLszThWHSB3dnXYTvuSTwcTO0r4ja4hd8KuVgy-gKxb8ctw_A@mail.gmail.com>
Subject: Re: [PATCH v1] env: Fix compile error for envtools
To: Jacky.Cao@sony.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, nora.schiffer@ew.tq-group.com, 
 Steffen.Doster@tq-group.com, alexander.feilke@ew.tq-group.com, 
 Max.Merchel@ew.tq-group.com, peng.fan@nxp.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jacky,

On 2026-07-13T08:31:41, Jacky.Cao@sony.com <Jacky.Cao@sony.com> wrote:
> env: Fix compile error for envtools
>
> Following error happens when build envtools for mx6qsabrelite.
>
> $ make tools envtools
>   UPD     include/generated/timestamp_autogenerated.h
>   HOSTCC  tools/printinitialenv
>   GENENV  u-boot-initial-env
>   COPY    tools/version.h
>   HOSTCC  tools/env/crc32.o
>   HOSTCC  tools/env/ctype.o
>   HOSTCC  tools/env/env_attr.o
>   HOSTCC  tools/env/env_flags.o
> In file included from ./arch/arm/include/asm/mach-imx/regs-lcdif.h:16,
>                  from ./arch/arm/include/asm/arch/imx-regs.h:371,
>                  from include/configs/mx6_common.h:21,
>                  from include/configs/nitrogen6x.h:13,
>                  from include/config.h:3,
>                  from include/env.h:12,
>                  from tools/env/../../env/flags.c:7,
>                  from tools/env/env_flags.c:1:
> ./arch/arm/include/asm/mach-imx/regs-common.h:51:9: error: unknown type name 'uint8_t'
>    51 |         __mxs_reg_8(reg)
>       |         ^~~~~~~~~~~
>
> uint8_t type is defined in linux/types.h header file.
> The config.h includes regs-common.h that uses uint8_t type,
> to fix this, include config.h after linux/types.h in env.h file.
>
> Fixes: 9f1807e57cbb ("env: add env_set_runtime() helper")

env.h only needs <config.h> so that IS_ENABLED() works inside the
inline env_set_runtime() helper. A cleaner fix is to make
env_set_runtime() a normal (non-inline) function declared in env.h and
defined in env/common.c (or wherever env_set() lives). Then env.h no
longer needs <config.h> and the tools build stops dragging board
configs into the host-side compilation. What do you think?

> [...]
>
> include/env.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/include/env.h b/include/env.h
> @@ -9,10 +9,10 @@
>  #ifndef __ENV_H
>  #define __ENV_H
>
> -#include <config.h>
>  #include <compiler.h>
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include <config.h>

As Tom mentioned, we really don't want to move config.h later - even
though the files above it are probably unrelated in this case...

Regards,
Simon

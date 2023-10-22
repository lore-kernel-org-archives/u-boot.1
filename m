Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F8ECDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 23:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5D68764E;
	Mon, 23 Oct 2023 01:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="izwvyGzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD65787655; Mon, 23 Oct 2023 01:32:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964CB875C9
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 01:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 97A333F65F
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 23:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698017567;
 bh=qfRF6D1fipxmZjO0tgUvAyOndHxgbj1kQL5VcPr0Bq0=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=izwvyGzQPs4qUo0Q9t5TtPlQPYaVJA3MnpjyKNV4d0eWHYGFwj3rohw4QOhGSuc5i
 6NSyT6MOVlZM+tlFJJ2o7xrp/zTCp8yyLlnoZDvwLTIcKPfLxbWo3TnBD7j0oVZS9r
 hNadOvLoMfz6R1o7o/3jY+TKS/EznmJC/6V/0LxmHoGo9q0l5aGjgzuG55pE7Xv/GQ
 cVMUozjNKLHUJh4Nrti0bq+L67sFIPc0G2BVUr49/kltJOox6bmPGWn/HUTulXy/Su
 ROVRWCZUstAoPpPGqamLEK1XmZAA6ANe7ggaPZbkD5PpdTfhrF0P2Vprh46S3+T0oC
 AQMA33Do3/gEQ==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c51e44a4dbso22218211fa.3
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 16:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017566; x=1698622366;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qfRF6D1fipxmZjO0tgUvAyOndHxgbj1kQL5VcPr0Bq0=;
 b=bTi6YirVtApc5eazUrmG4dARoxcQt7Q5M5ZPlz2F0oNds8Po6WE6xNwsh0AumVdmML
 dyINBrPhvLhHciAMkhAxhhJqXux66hqY2Zeo3Ja6/BAt0TRVqzeKqh/22xwHc6rIR/lo
 AMjCEWEMCQ6qaRKsWRBJ/2wRtbD4sUfkBmtvYVniVgtp9uBPtQopX4dHi3OOm+ykFiv6
 dQNsyzF+xBgaefjLts7tmh4eTkDW31gy4+b65psvJkTvWsaPDvmPbaAKirbVqm2MZjOD
 WS5c8Q0HVUkaA1ZRFoZjPj5AtQj1EttXTOMgX7M1BSkesReoXJ+3Yx/4pcg0hS8Vagdc
 VqnQ==
X-Gm-Message-State: AOJu0YyctSx96JD23JBNFlf2REUKXZn/IVtJ3eJlUv6ZtOdZDo3T+mzV
 BIacjy5F3gZsa0aAHvl0ZHav0Zb2PbewPMvjJNryvi4ac2ZlBvEnYp8HAfxlO6CTxTYNSjQC7Bu
 JnnWpxKCbDJr7/6pHVDK9j+7QuPNjoYo=
X-Received: by 2002:a2e:7c17:0:b0:2c0:33be:3530 with SMTP id
 x23-20020a2e7c17000000b002c033be3530mr4743331ljc.45.1698017565827; 
 Sun, 22 Oct 2023 16:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA0aazm9xxrkwwWZLowTZ+9F2L3aOFh8ok3eWIV9L8auzQZbpQ3+rEbel9y0bma6nP2QSJKg==
X-Received: by 2002:a2e:7c17:0:b0:2c0:33be:3530 with SMTP id
 x23-20020a2e7c17000000b002c033be3530mr4743327ljc.45.1698017565441; 
 Sun, 22 Oct 2023 16:32:45 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b004068e09a70bsm8056242wmq.31.2023.10.22.16.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 16:32:44 -0700 (PDT)
Message-ID: <884509be-8e77-4ec3-a8b0-a9c2850cb2be@canonical.com>
Date: Mon, 23 Oct 2023 01:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sandbox: eliminate unused functions from binaries
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20231022062929.106169-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US, de-DE
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231022062929.106169-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/22/23 08:29, Heinrich Schuchardt wrote:
> The sandbox should closely mimic other architectures.
> 
> Place each function or data in a separate section and let the linker
> eliminate unused ones. This will reduce the binary size.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   arch/sandbox/config.mk | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> index 2d184c5f65..c02f0229c2 100644
> --- a/arch/sandbox/config.mk
> +++ b/arch/sandbox/config.mk
> @@ -2,7 +2,7 @@
>   # Copyright (c) 2011 The Chromium OS Authors.
>   
>   PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
> -PLATFORM_CPPFLAGS += -fPIC
> +PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
>   PLATFORM_LIBS += -lrt
>   SDL_CONFIG ?= sdl2-config
>   
> @@ -26,6 +26,7 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
>   	$(KBUILD_LDFLAGS:%=-Wl,%) \
>   	$(SANITIZERS) \
>   	$(LTO_FINAL_LDFLAGS) \
> +	-Wl,--gc-section \
>   	-Wl,--whole-archive \
>   		$(u-boot-main) \
>   		$(u-boot-keep-syms-lto) \
> @@ -37,6 +38,7 @@ cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
>   	$(SANITIZERS) \
>   	$(LTO_FINAL_LDFLAGS) \
>   	$(patsubst $(obj)/%,%,$(u-boot-spl-init)) \
> +	-Wl,--gc-section \
>   	-Wl,--whole-archive \
>   		$(patsubst $(obj)/%,%,$(u-boot-spl-main)) \
>   		$(patsubst $(obj)/%,%,$(u-boot-spl-platdata)) \

In arch/sandbox/cpu/u-boot.lds we must enforce keeping the command line 
options like we do for other linker generated lists.

         _u_boot_sandbox_getopt : {
-               *(_u_boot_sandbox_getopt_start)
-               *(_u_boot_sandbox_getopt)
-               *(_u_boot_sandbox_getopt_end)
+               KEEP(*(_u_boot_sandbox_getopt_start))
+               KEEP(*(_u_boot_sandbox_getopt))
+               KEEP(*(_u_boot_sandbox_getopt_end))
         }

We might have used the normal linker lists here.

Best regards

Heinrich

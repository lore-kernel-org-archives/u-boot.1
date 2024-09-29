Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5E3CF6497
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 22:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA931889C9;
	Mon, 30 Sep 2024 00:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q8tCe16G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D85889C9; Mon, 30 Sep 2024 00:22:47 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD12888C8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 00:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9d2195eso4981474a12.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727648565; x=1728253365; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiFA3X3GpQzGIKUl9t5L2FJp8TmDL2RLeO9sDSiI1rE=;
 b=q8tCe16G43DGtD0jfm6/nk5iix8+nxPEbUfOageEJTC7cBfzc4KFehQaBn4nskk6GK
 S9rjUFQ8CDlKB3vJG3GR0T2yNGhEPnzx+kQYuMwrZ8eFsOunIhheryReXc8FBEd702Pk
 HtJ1v9PMBlU2zBdK3cRsEOGUixEJ9610MrJz3zxJ5+ygxF1jvsCbYpj59MOJiZnJw45V
 DD9JBc7hxsIGFaELQzxjh9yxciw94vdVBEBoXqnRU4LT3n6+dyzzk8NlPsQw74e5HcP8
 jzb5roeo0VCEOwo3HMQGp8YCJ0AWKiOZxMB4HqjanF6QofRd2AC6vgnU9mMoCgTU9GwZ
 jk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727648565; x=1728253365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiFA3X3GpQzGIKUl9t5L2FJp8TmDL2RLeO9sDSiI1rE=;
 b=Q+q8P5/BqZpV7BjcTxxZDC6BOfVUtm5Q/Ze8qZjaqsmNUfPlO9l3cRolYzxZL0dDXQ
 qopx9V616VJIqX3gVmYWKBPkGmcbp+WkUyMFoSWEv+wF1h7kMitdeLADImpMO2KBFhIk
 ywyDZIPYzBnI+xStFzC9ZkTr2qsgePvYH703SCJvnueSalQ099phSXfYjH0LjR8PV625
 XrfpEqA5onqhBc931qGZ1IieeRAh/Ej0niaPfvucSuTf5oEI/dM4H+M4JfqaC5f8jSOO
 P/TqZ3eJ+sTzvZD6XEgFbVWwxIHO4n43dJQQmT+oc1OiViu7YQzEDNp4N3eF/vyFCm7k
 sHhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr/k9Pdly/IUiT7TAMuPNk9ljtD+Ops4QXJYnz2nq1HoIiauvmnZ1ccHUrtgYYdjbUd7Or1lY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7itZIQybF07tnbJ6y7AqBsZgqVeNsDiwpvHSPBWIFlEvi9dKi
 hydHFYrC7WpYcv8qASUkmnMU+SNTEi6X3W7DWnHaVmATeaetc+3ZDPCe/lKc6ZA=
X-Google-Smtp-Source: AGHT+IF8VbA86E/5BbViHwcmvYwUR4iaokWLT0SHp4vTsOGtLk787v+L+OVKCK1S+n6Xo9qY3aMsuw==
X-Received: by 2002:a05:6402:210b:b0:5c8:8208:2929 with SMTP id
 4fb4d7f45d1cf-5c8824eb193mr11307992a12.20.1727648564113; 
 Sun, 29 Sep 2024 15:22:44 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00:b14e:b810:b96a:ee48?
 ([2a02:8109:aa0d:be00:b14e:b810:b96a:ee48])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c882493b74sm3653026a12.79.2024.09.29.15.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Sep 2024 15:22:43 -0700 (PDT)
Message-ID: <21486f41-bd7e-44cc-adf2-769946942cf1@linaro.org>
Date: Mon, 30 Sep 2024 00:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dts: Deduplicate dtbs target
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240927214955.394224-1-marex@denx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240927214955.394224-1-marex@denx.de>
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

Hi Marek,

On 27/09/2024 23:48, Marek Vasut wrote:
> The dtbs: target is almost identical in all architecture Makefiles.
> All architecture Makefiles include scripts/Makefile.dts . Deduplicate
> the dtbs: target into scripts/Makefile.dts . No functional change.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> #qcom, OF_UPSTREAM
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lothar Rubusch <l.rubusch@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>   arch/arc/dts/Makefile            | 9 +--------
>   arch/arm/dts/Makefile            | 8 --------
>   arch/m68k/dts/Makefile           | 9 +--------
>   arch/microblaze/dts/Makefile     | 9 +--------
>   arch/mips/dts/Makefile           | 8 --------
>   arch/nios2/dts/Makefile          | 9 +--------
>   arch/powerpc/dts/Makefile        | 8 --------
>   arch/riscv/dts/Makefile          | 9 +--------
>   arch/sandbox/dts/Makefile        | 9 +--------
>   arch/sh/dts/Makefile             | 8 --------
>   arch/x86/dts/Makefile            | 8 --------
>   arch/xtensa/dts/Makefile         | 8 --------
>   dts/upstream/src/arm/Makefile    | 8 --------
>   dts/upstream/src/arm64/Makefile  | 8 --------
>   dts/upstream/src/xtensa/Makefile | 8 --------
>   scripts/Makefile.dts             | 8 ++++++++
>   16 files changed, 14 insertions(+), 120 deletions(-)
> 
> diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
> index 532a8131c59..fe6ad7b849a 100644
> --- a/arch/arc/dts/Makefile
> +++ b/arch/arc/dts/Makefile
> @@ -10,12 +10,5 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=  iot_devkit.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>   DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index cdb90f1d358..5976ebd09fc 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1304,16 +1304,8 @@ dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS += -a 0x8
>   
>   DTC_FLAGS_imx8mp-dhcom-som-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
>   DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb *.dtbo *_HS
> diff --git a/arch/m68k/dts/Makefile b/arch/m68k/dts/Makefile
> index 7988522eb98..8b354b9c570 100644
> --- a/arch/m68k/dts/Makefile
> +++ b/arch/m68k/dts/Makefile
> @@ -20,12 +20,5 @@ dtb-$(CONFIG_TARGET_STMARK2) += stmark2.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>   DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
> index 427a8f9aaca..9be902d3bb1 100644
> --- a/arch/microblaze/dts/Makefile
> +++ b/arch/microblaze/dts/Makefile
> @@ -4,12 +4,5 @@ dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>   DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
> index 14fbce597b9..752e771514f 100644
> --- a/arch/mips/dts/Makefile
> +++ b/arch/mips/dts/Makefile
> @@ -39,13 +39,5 @@ dtb-$(CONFIG_SOC_SERVAL) += serval_pcb105.dtb serval_pcb106.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/nios2/dts/Makefile b/arch/nios2/dts/Makefile
> index 2b29fa90f6c..d77db9762a1 100644
> --- a/arch/nios2/dts/Makefile
> +++ b/arch/nios2/dts/Makefile
> @@ -4,12 +4,5 @@ dtb-y += $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%).dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>   DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
> index 321c644804e..766b0c05951 100644
> --- a/arch/powerpc/dts/Makefile
> +++ b/arch/powerpc/dts/Makefile
> @@ -35,13 +35,5 @@ dtb-$(CONFIG_TARGET_CMPCPRO) += cmpcpro.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index c4c44057bad..f3dfd751cb4 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -15,12 +15,5 @@ dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>   DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/sandbox/dts/Makefile b/arch/sandbox/dts/Makefile
> index f810b4752f5..1c9fb4a4566 100644
> --- a/arch/sandbox/dts/Makefile
> +++ b/arch/sandbox/dts/Makefile
> @@ -10,12 +10,5 @@ dtb-$(CONFIG_CMD_EXTENSION) += overlay0.dtbo overlay1.dtbo
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
> +# Add any required device tree compiler flags here
>   DTC_FLAGS += -R 4 -p 0x1000
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb *.dtbo
> diff --git a/arch/sh/dts/Makefile b/arch/sh/dts/Makefile
> index 144fd3e7d22..e9153e42534 100644
> --- a/arch/sh/dts/Makefile
> +++ b/arch/sh/dts/Makefile
> @@ -2,13 +2,5 @@ dtb-y += sh7751-r2dplus.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb *_HS
> diff --git a/arch/x86/dts/Makefile b/arch/x86/dts/Makefile
> index cd77f4c4e81..9a46726e026 100644
> --- a/arch/x86/dts/Makefile
> +++ b/arch/x86/dts/Makefile
> @@ -24,12 +24,4 @@ dtb-y += bayleybay.dtb \
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   DTC_FLAGS += -R 4 -p $(if $(CONFIG_EFI_APP),0x8000,0x1000)
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/arch/xtensa/dts/Makefile b/arch/xtensa/dts/Makefile
> index c22c50ac4e5..aa582b85e5c 100644
> --- a/arch/xtensa/dts/Makefile
> +++ b/arch/xtensa/dts/Makefile
> @@ -4,12 +4,4 @@ dtb-$(CONFIG_XTENSA) += ml605.dtb ml605_nommu.dtb kc705.dtb kc705_nommu.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   DTC_FLAGS +=
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb
> diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makefile
> index 9a8f6aa3584..c86a2be5d85 100644
> --- a/dts/upstream/src/arm/Makefile
> +++ b/dts/upstream/src/arm/Makefile
> @@ -2,13 +2,5 @@
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS += -a 0x8
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := */*.dtb */*.dtbo
> diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
> index 26a83d3d29d..b6db0dc6b26 100644
> --- a/dts/upstream/src/arm64/Makefile
> +++ b/dts/upstream/src/arm64/Makefile
> @@ -2,17 +2,9 @@
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS += -a 0x8
>   
>   ifdef CONFIG_RCAR_64
>   DTC_FLAGS += -R 4 -p 0x1000
>   endif
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := */*.dtb */*.dtbo
> diff --git a/dts/upstream/src/xtensa/Makefile b/dts/upstream/src/xtensa/Makefile
> index 2a81acb32bc..c86a2be5d85 100644
> --- a/dts/upstream/src/xtensa/Makefile
> +++ b/dts/upstream/src/xtensa/Makefile
> @@ -2,13 +2,5 @@
>   
>   include $(srctree)/scripts/Makefile.dts
>   
> -targets += $(dtb-y)
> -
>   # Add any required device tree compiler flags here
>   DTC_FLAGS += -a 0x8
> -
> -PHONY += dtbs
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	@:
> -
> -clean-files := *.dtb *.dtbo */*.dtb */*.dtbo
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 790f3c508f1..1fe142f2bbf 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -14,3 +14,11 @@ dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFI
>   dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
>   
>   endif
> +
> +targets += $(dtb-y)
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +	@:
> +
> +clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS

-- 
// Caleb (they/them)


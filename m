Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567BCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F40782C84;
	Mon, 20 Oct 2025 17:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PMtoAZ5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BCA83631; Mon, 20 Oct 2025 17:19:49 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5E2807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b6bbfc57b75so118616466b.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760973587; x=1761578387; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xpzGCeyhAdHKP1AcggbEL8VzP9MkG3wm2ULJcmnWaRg=;
 b=PMtoAZ5DFCpmx2n5/c5nXOWd7TCfY+Xmf3xN0kPvroxtEemygq4FcIoCN/NEoLF7+B
 eYucHRd6CNCqy5fLtarr3h+7EFvKAyVqc5sWKxQ34q7pvf70nawixyf7cC2t2e1w0XoM
 4iAYAObZAI7ImBIEWzBsGxs6HQ1dAvINF0HyNe8vnYsokSwYnW0WRaEm9SB+nouZ49+f
 PpLJqW8ak9nQ6KWrDAhDwlAFInG19bM213EaK679wY6H1imCru2MrmbpBw41QJ8ijzvU
 RTiFzAKCAccDQORxokb8F9Ee1v2+LjL/7w/9jJnKJaKeSoA/rosd4r5/htv18GV6mXs6
 LajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973587; x=1761578387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpzGCeyhAdHKP1AcggbEL8VzP9MkG3wm2ULJcmnWaRg=;
 b=AAowa73WL4RXSuLwdE16B1kG8EBxgwB+z/kI5hfasNALiPPqHD35n9u1WxiwiHGkpg
 B0rGFX9uPHKEdyZBOGnydSTgfAHpz/X87eN7HvcM7uPPbQkfMNP9KyMkc1xRqDnecBUK
 vRwQV/cf6qZF/blC4kojH4NGpzkEWbQjdqI4cOhAeFDbwzmSYCiD8hQvaatsAr2bocvx
 ZQVzxCjy0R4lvJCDkF3kZ4pkAx4fpX6Un5WyUk4QbgdXqzxjzm8JPhbXjWMbqVJl7XhG
 qXlcFAXs6i/bJY7xM9k94pyMA4Hl5zxQEWj2aFLUpz91KEcWU0+VWgL0q7cItIKklFIQ
 c48A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkBAbWSPX6phQuHIw2gfzI5JwIgewDGnQ2bDPnrbEzPAYXm8zU8R3mbevN7UGBqewxHcIlvTk=@lists.denx.de
X-Gm-Message-State: AOJu0YyTt6DI5hh1m0R1bgwC2kz005sJZP+yWIn6+ZLKQ+GX7iJ77gh1
 RzKHpWVRj0YzairezcE1N6sQXZeXsVDRFbzp7Xw3yS1vGXwCBJiYIGeD32GetQhT4vA=
X-Gm-Gg: ASbGncu4Ql/aPoIrztvpIR5nwDNnIyFKM6A6Hv+I4vrHrd5P+jaOIqGApjUcVAP9MlD
 4Z/MRF8bgYXgdp62CGJl0EDugrf8PNst1OjRZosToL3KbWhDbnlFDZ61NzTxtnoxvyWIB7tSY0N
 6eJg4qatZfTMvCbFOTmj2sI7cRLfskco1n8FRdx2L9eIy+eiHC4N26NCioFL2UnmK1K/r2GdGV2
 5XHiWqMZ+rPcxnCCJyzTQvuRnCFJqeSRncwe6aOzqLprigbMysNHAC3Zg2+AAAf3O5+oce54HFe
 +DiLFqkOLPSzlIy948l8Do+lz0rBBlX8BcdFiFr0U7zwoNZz7Xk5acmaNSx0stp1IbUf8tN0wLh
 Zzo/VtX+bdvyJe8yIETJOoL/BTNPJOS8oR2NnxEgRC7semPQY25Jo0zym8DfmlToB/AgWj3hqdh
 soz0a2WWAYSHs97dkIaBU+Pg/uIrN4AydxsyMEYjzHetFq4l0pT0G7qAKKVO2UUeQirnV5K2zjv
 Q==
X-Google-Smtp-Source: AGHT+IGpl8YIQMGIABJ5AgGEDUPWLFYELyVglHKee2G8e9bdIBSrqSQUiFizF0cxVIi1qdMqGP/fEA==
X-Received: by 2002:a17:906:8e17:b0:b2d:4e57:58d8 with SMTP id
 a640c23a62f3a-b605249e151mr1923762366b.10.1760973586944; 
 Mon, 20 Oct 2025 08:19:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:2fe:bc2d:65b1:1566?
 ([2a01:e0a:3cb:7bb0:2fe:bc2d:65b1:1566])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e7da1ba1sm822272766b.14.2025.10.20.08.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:19:46 -0700 (PDT)
Message-ID: <ea1e0cd6-48d1-4999-987a-38febfd0e70f@linaro.org>
Date: Mon, 20 Oct 2025 17:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
 <20251015141856.4168612-2-raymond.mao@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251015141856.4168612-2-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Raymond,

On 10/15/25 16:18, Raymond Mao wrote:
> Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
> bl1 and fip with both Firmware Handoff and Measured Boot enabled.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in V2:
> - Move OP-TEE dependencies into the common group.
> - Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
>   post-buildman script.
> - Remove Trust Boot related build options.
> Changes in V3:
> - Clean-up of OP-TEE deps.
> Changes in V4:
> - Minimize OP-TEE build options.
> 
>  tools/docker/Dockerfile | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5b4c75f8400..73c1589e260 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -122,8 +122,10 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>  	python-is-python3 \
>  	python2.7 \
>  	python3 \
> +	python3-cryptography \
>  	python3-dev \
>  	python3-pip \
> +	python3-pyelftools \
>  	python3-sphinx \
>  	python3-tomli \
>  	python3-venv \
> @@ -227,10 +229,24 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>  	make -j$(nproc) all install && \
>  	rm -rf /tmp/qemu
>  
> -# Build fiptool
> +# Build OP-TEE for qemu_arm64
> +RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
> +	cd /tmp/optee_os/ && \

I would recommend:

git clone -b 4.7.0 --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os

...which will directly obtain the proper tag (-b 4.7.0), and minimize the amount
of cloned data (--depth=1 i.e., no full history, just the last commit).

With or without this change:

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

> +	git checkout 4.7.0 && \
> +	make CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
> +		CROSS_COMPILE64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +		CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
> +		PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \
> +		CFG_RPMB_WRITE_KEY=y CFG_RPMB_TESTKEY=y \
> +		CFG_CORE_HEAP_SIZE=524288 \
> +		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
> +		CFG_TEE_CORE_LOG_LEVEL=2
> +
> +# Build fiptool, bl1 and fip for fvp and qemu_arm64
> +RUN git clone --branch mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
>  RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
>  	cd /tmp/tf-a/ && \
> -	git checkout v2.12.0 && \
> +	git checkout v2.13.0 && \
>  	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>  		PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
>  	mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
> @@ -243,6 +259,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
>  	mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
>  	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
>  		/opt/tf-a/vexpress_fvp_bloblist/ && \
> +	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +		PLAT=qemu \
> +		BL33=/dev/null \
> +		BL32=/tmp/optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin \
> +		BL32_EXTRA1=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin \
> +		BL32_EXTRA2=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin \
> +		BL32_RAM_LOCATION=tdram SPD=opteed \
> +		TRANSFER_LIST=1 E=0 \
> +		MEASURED_BOOT=1 \
> +		EVENT_LOG_LEVEL=10 \
> +		MBOOT_EL_HASH_ALG=sha256 \
> +		MBEDTLS_DIR=/tmp/mbedtls \
> +		-j$(nproc) all fip && \
> +	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
> +	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
> +		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
> +	rm -rf /tmp/optee_os && \
> +	rm -rf /tmp/mbedtls && \
>  	rm -rf /tmp/tf-a
>  
>  # Download the Arm Architecture FVP platform. This file is double compressed.

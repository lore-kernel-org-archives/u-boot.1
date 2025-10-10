Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F6CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 15:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4038427F;
	Fri, 10 Oct 2025 17:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kI1SwfZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158348436C; Fri, 10 Oct 2025 17:11:37 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78C584248
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 17:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so11548295e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760109094; x=1760713894; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q39N3nl/GzuvlExy4mDoU8s8lZLw7CJtvWxn5waWgK4=;
 b=kI1SwfZ36NAcY78Z7PKCBIXF+RUsXdPB8jCYVRCPvvS131DLAUbOMXnmtmzrgAt3fj
 5rnZZzNL9Gjtot48g7bguOUX1xg5PkiPntvc7mPpOM4T9onHPxNdqxecEsSuVgHBevgm
 LxwQcRqZwL9rRj8GcmJJfzmEHSG4nmk7TrkPkqeg8cnb+rtQvvvUQlXra01FtmZnJOHT
 OgX/S4iOhtaO9G2BbdWelMYqB8aAR9+kP8+XR2QuxnPe0zxQbnevBb0khVHj+CqJIiRz
 1GeXmpxGoowjns0F16y41MFkfPQwJeSHy3ySzWD7RGKQcZpaHpLgwBSOGww+bTTq63+1
 rFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109094; x=1760713894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q39N3nl/GzuvlExy4mDoU8s8lZLw7CJtvWxn5waWgK4=;
 b=cKiIlVsa4+5NRHCuG+/OnxOgNiLnnEfvwxSoLX6EdTdfaDkXjVXWI8JHNOfBLVhL5o
 Cob8sod6TVq0T2ZaUypckwhkL2+8v3DnO4BGkEgzTkw1fCQ2BJTTBRlW5NBMQ16OElp3
 b+erWSRteIUTV5OtCzGDiQNicG+HtH0j6yp3FR3gFVymOeS968/Jrege2qUVGw9qXvbN
 JEEV3my/ZmK5aalPbfj+gmwdOrSXWBAsteegPlFufT/Aq1KRvnvqrHAuf/N8JMtWgVnD
 79QpaOen07j6mrXx28zgvfjEirk4eeSVofAhEsbtdtpHj6qfsY9GN5htpBTM2x0RKWDs
 Dwow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk7KiaFly/cv+MAPnc7XZd9njH0hsvrLgSkhpYbi66DvyPv6ZYjLqevB/pz27OybZPT5fCgYU=@lists.denx.de
X-Gm-Message-State: AOJu0YxJAvhTiWvsaOyKt901eVS6LQVoBP2Fj6vholb8HIyprBy0V3bR
 Y8mmTKbqvwKhuWyRa3iMBirEd9Tyh0nbOQFfA1Qze4IYmKOH/y83A0ppuM6m5FKRdjw=
X-Gm-Gg: ASbGncvxAFPjtvzEXd4xTk13hb4t1ErNRBNJ6wR1wK3h9sYbzF/EgGjJvHPWQ3qDkQ1
 mPK/xrTKPriC0siKwxkNTEnjFrhBQv3CJv5p5lbEGt9lmLlNC1lHyHMRf0CXFMoOtLrCsICqUrt
 cg05lzL+4OvxZsDWzwPYEjIQGk87SDYvNtUfvFVQV5wT6CtbdxDM+NUTItwRLYdVON0OW1F5hpR
 my4dHFrwW/7LME7opCLlb/rKL6XVqy6cECO16KDwyWSEWyP1YaIVkJLUudkyHGwvW5bNgF4/gqV
 qioqKGp4aAruy9kuL5+EfydToxzMvxMXgdPNGf4tWZJTTPllLgj7mXTy/3Ag5oqK0JIhSkwT+eq
 BJ9bYZeY3/tUrpBoJYF346XhVEpgkYhqHkKunzpei4fY1TRgYaKKxA7w8JFoLwyJ+KL85g5EZRF
 H5ieX2MENNIGt5UEZlM4e/ANPpMIdE08+HF0M=
X-Google-Smtp-Source: AGHT+IE+DRhsWv2da39DSem7ygIk91St5by6rOBcMKatCxUtSVfIvdn7PSJOvPqufEP1zkU/uiqKlQ==
X-Received: by 2002:a05:600c:450e:b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46fa9e8dcc7mr92210415e9.2.1760109094260; 
 Fri, 10 Oct 2025 08:11:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a3db:a2bf:105e:da6e?
 ([2a01:e0a:3cb:7bb0:a3db:a2bf:105e:da6e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4983053sm50004235e9.8.2025.10.10.08.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 08:11:34 -0700 (PDT)
Message-ID: <91ea6f19-8a58-4890-9421-fdc5cd7f09e0@linaro.org>
Date: Fri, 10 Oct 2025 17:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
 <20251010144517.3573014-2-raymond.mao@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251010144517.3573014-2-raymond.mao@linaro.org>
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

On 10/10/25 16:45, Raymond Mao wrote:
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
> 
>  tools/docker/Dockerfile | 44 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5b4c75f8400..51d07b1482c 100644
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
> @@ -227,10 +229,30 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>  	make -j$(nproc) all install && \
>  	rm -rf /tmp/qemu
>  
> -# Build fiptool
> +# Build OP-TEE for qemu_arm64
> +RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
> +	cd /tmp/optee_os/ && \
> +	git checkout 4.7.0 && \
> +	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \

OK

> +		CROSS_COMPILE_core=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \

Not needed (eventually defaults to $(CROSS_COMPILE))

> +		CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \

OK

> +		CROSS_COMPILE_ta_arm32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
> +		CROSS_COMPILE_ta_arm64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +		ARCH=arm \
> +		CFG_ARM64_core=y \

All 4 lines not needed (defaults)

> +		CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
> +		PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \

OK

> +		CFG_RPMB_FS_DEV_ID=0 CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_WRITE_KEY=y \

CFG_RPMB_FS_DEV_ID=0 not needed (default)

> +		CFG_CORE_HEAP_SIZE=524288 CFG_CORE_DYN_SHM=y CFG_RPMB_TESTKEY=y \

CFG_CORE_DYN_SHM=y not needed (default)

> +		CFG_RPMB_WRITE_KEY=1 \

Already set above

> +		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \

OK

> +		CFG_TEE_CORE_LOG_LEVEL=4 CFG_TEE_TA_LOG_LEVEL=1 DEBUG=y

CFG_TEE_TA_LOG_LEVEL=1 not needed (default).
Would the CFG_TEE_CORE_LOG_LEVEL (2 == LOG_LEVEL_ERROR) and DEBUG (disabled) be OK?

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
> @@ -243,6 +265,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
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

Thanks,
-- 
Jerome

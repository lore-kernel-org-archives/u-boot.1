Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18806CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E893383C62;
	Fri, 10 Oct 2025 21:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cc0nTjVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EFD83F7F; Fri, 10 Oct 2025 21:07:14 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9CB083826
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2680cf68265so18619385ad.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760123230; x=1760728030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=01SIPK4rYYFjLehCVovdOjFUUM6DAqRr8h/ABLPCqWQ=;
 b=Cc0nTjVMaD7zEXh9FJVM+EysXKqcAWznhiiWxEixoXK1s50QLmMh6joEQmL9N/+Cfl
 v0JmmmRyHk8WHq5bm1qfq47kTjq11/TiRfzoX4dm0GmKRHrwlSMHvNeOoz8Fgm0hL5j/
 2K+L1HjIFBCvesVR4YCipFUD4dYPvys2dpLkdTxQyCN7iduRcpzIfo+fuzOhYwRM4UwF
 SrSXGXa9JGfsyrxJObs4r9dNJH2QnPfUSzkP9/42Pm1HAqghW10Hn4YA+7f/gp6amNUi
 xWSIX9n8eqnmD3edx7RTfgriGNa70/FLufa48syiFX7Pa2PChjEj0+4PxQqywONLgAIs
 OxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760123230; x=1760728030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01SIPK4rYYFjLehCVovdOjFUUM6DAqRr8h/ABLPCqWQ=;
 b=BxpPvKoWfi8Q/Yjl9m3WudRA7OOQIGIJ34hzId/8mTKy0kPXi8tedtYXQCmytLs/84
 oGlXUt2GE9Hy2LaKys5UnqNVeoEit2WfWVqoV4EIDTURmnS5xHw2GlR4Fto9rLDg7njW
 OtykqLUB8bDFn73+x+UD9q8Hy7jDToq6cm56a1yyAJDMhTo5pMTQxxdEbkWUcfaf3qhK
 GR55edaofUqrek7lWf1gPMPdEixhwMlkbSSqc1NJATvzmMRTqnsApzSnvx6pgPzvY7dx
 5sl5q83p51Jqn4NDUwkP9A3H4yh57Psqsh66NdAj+p34m+vxmeMaKtKlKg4gKVsN+3qN
 TDnw==
X-Gm-Message-State: AOJu0YzjXS2tfGNJteI/r0LT5d2+KtZ5VdZ11lk84qzYFuXpOKedP+Bn
 YEGEjUkiRbU2QyC36iGHX5LEeJj2JAUoG9VZJz0snzCkZl+sbacz/idZhdoc05gq6D2MUi6FV2e
 JVZ9dBN3wpU0mh/JZZwROR894oJA6pOFCBjgXrA+EEQ==
X-Gm-Gg: ASbGncvBGNR5ikbB2rf6AycQDBh9krc0jE2Cr2pEYacWQyKW5y5XR/1g5sGpdUWHmnW
 83DP1lsWzkH5s6pQryJqIhfsB2qCtZSZ7FPyzt0bDkA+c7ByhVhfpPpiiTs9PUEEP+Bb3I3tc/R
 tk/pkIVekcW+CQX0+3pIa5Pin4FNeEjRXDFaPZvI6HbAk8mbcF3DfHgkLWSu//8bCT3Uc575pE3
 SHpU9z0l2jcUz4WcoCmLURUM36UNKE=
X-Google-Smtp-Source: AGHT+IE0ZjEaNFEMz6WAbSkqZdedfFTNDF2lm11DmhYQ8w/Olky5a7kB6/1TBWtu5h1y3RQsGRpwqkpLDpSVfvKAK/w=
X-Received: by 2002:a17:902:ef10:b0:27e:eabd:4b41 with SMTP id
 d9443c01a7336-29027216505mr181069875ad.7.1760123229808; Fri, 10 Oct 2025
 12:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
 <20251010144517.3573014-2-raymond.mao@linaro.org>
 <91ea6f19-8a58-4890-9421-fdc5cd7f09e0@linaro.org>
In-Reply-To: <91ea6f19-8a58-4890-9421-fdc5cd7f09e0@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 10 Oct 2025 15:06:56 -0400
X-Gm-Features: AS18NWDo7Ace-24ScXOl5VARqrOovI02QEnhjzA_E2yToL9hmgqOsyb72B9rkjE
Message-ID: <CAEfUkU+aOmxUnwhq8dS-S-wPiSoregTM6HSRR5exhGTnZBK82A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jerome,

On Fri, 10 Oct 2025 at 11:11, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Raymond,
>
> On 10/10/25 16:45, Raymond Mao wrote:
> > Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
> > bl1 and fip with both Firmware Handoff and Measured Boot enabled.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in V2:
> > - Move OP-TEE dependencies into the common group.
> > - Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
> >   post-buildman script.
> > - Remove Trust Boot related build options.
> > Changes in V3:
> > - Clean-up of OP-TEE deps.
> >
> >  tools/docker/Dockerfile | 44 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 42 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index 5b4c75f8400..51d07b1482c 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -122,8 +122,10 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >       python-is-python3 \
> >       python2.7 \
> >       python3 \
> > +     python3-cryptography \
> >       python3-dev \
> >       python3-pip \
> > +     python3-pyelftools \
> >       python3-sphinx \
> >       python3-tomli \
> >       python3-venv \
> > @@ -227,10 +229,30 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
> >       make -j$(nproc) all install && \
> >       rm -rf /tmp/qemu
> >
> > -# Build fiptool
> > +# Build OP-TEE for qemu_arm64
> > +RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
> > +     cd /tmp/optee_os/ && \
> > +     git checkout 4.7.0 && \
> > +     make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>
> OK
>
> > +             CROSS_COMPILE_core=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
>
> Not needed (eventually defaults to $(CROSS_COMPILE))
>

Removing CROSS_COMPILE_core prompts "aarch64-linux-gnu-gcc: command
not found", I think we need CROSS_COMPILE64 instead.

> > +             CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
>
> OK
>
> > +             CROSS_COMPILE_ta_arm32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
> > +             CROSS_COMPILE_ta_arm64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> > +             ARCH=arm \
> > +             CFG_ARM64_core=y \
>
> All 4 lines not needed (defaults)
>

Dito, removing CROSS_COMPILE_ta_arm64 prompts "aarch64-linux-gnu-gcc:
command not found".
I think for v4.7.0:
CROSS_COMPILE_ta_arm64 defaults to CROSS_COMPILE64;
CROSS_COMPILE_ta_arm32 defaults to CROSS_COMPILE32;
CROSS_COMPILE32 defaults to CROSS_COMPILE.
CROSS_COMPILE_core defaults to CROSS_COMPILE64 when CFG_ARM64_core=y.

So actually CROSS_COMPILE and CROSS_COMPILE64 are required at least.

Regards,
Raymond


> > +             CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
> > +             PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \
>
> OK
>
> > +             CFG_RPMB_FS_DEV_ID=0 CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_WRITE_KEY=y \
>
> CFG_RPMB_FS_DEV_ID=0 not needed (default)
>
> > +             CFG_CORE_HEAP_SIZE=524288 CFG_CORE_DYN_SHM=y CFG_RPMB_TESTKEY=y \
>
> CFG_CORE_DYN_SHM=y not needed (default)
>
> > +             CFG_RPMB_WRITE_KEY=1 \
>
> Already set above
>
> > +             CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
>
> OK
>
> > +             CFG_TEE_CORE_LOG_LEVEL=4 CFG_TEE_TA_LOG_LEVEL=1 DEBUG=y
>
> CFG_TEE_TA_LOG_LEVEL=1 not needed (default).
> Would the CFG_TEE_CORE_LOG_LEVEL (2 == LOG_LEVEL_ERROR) and DEBUG (disabled) be OK?
>
> > +
> > +# Build fiptool, bl1 and fip for fvp and qemu_arm64
> > +RUN git clone --branch mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
> >  RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
> >       cd /tmp/tf-a/ && \
> > -     git checkout v2.12.0 && \
> > +     git checkout v2.13.0 && \
> >       make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> >               PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
> >       mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
> > @@ -243,6 +265,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
> >       mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
> >       cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
> >               /opt/tf-a/vexpress_fvp_bloblist/ && \
> > +     make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> > +             PLAT=qemu \
> > +             BL33=/dev/null \
> > +             BL32=/tmp/optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin \
> > +             BL32_EXTRA1=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin \
> > +             BL32_EXTRA2=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin \
> > +             BL32_RAM_LOCATION=tdram SPD=opteed \
> > +             TRANSFER_LIST=1 E=0 \
> > +             MEASURED_BOOT=1 \
> > +             EVENT_LOG_LEVEL=10 \
> > +             MBOOT_EL_HASH_ALG=sha256 \
> > +             MBEDTLS_DIR=/tmp/mbedtls \
> > +             -j$(nproc) all fip && \
> > +     mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
> > +     cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
> > +             /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
> > +     rm -rf /tmp/optee_os && \
> > +     rm -rf /tmp/mbedtls && \
> >       rm -rf /tmp/tf-a
> >
> >  # Download the Arm Architecture FVP platform. This file is double compressed.
>
> Thanks,
> --
> Jerome

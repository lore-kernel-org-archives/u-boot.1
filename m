Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C5CCA471
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 02:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F18D8386F;
	Sat,  4 Oct 2025 04:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ax7ZgAFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC0F838A0; Sat,  4 Oct 2025 04:06:30 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5979F8383E
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 04:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so2471157b3a.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759543586; x=1760148386; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0jpaGr1uF4D30xSd0dNPLK5dGTT8TkvjRrHWlirpjx0=;
 b=ax7ZgAFzo+vT47U50JBXdqw9HTpzl4CM0KhjRMi/DIa7w3eRnKndCOMQL3KG02f20N
 hDWue77jY9lkw5nl2HRJil9vNID03pk/I2KuTmpLFr0Cr405xhW97I6CEk5wpAezW2sb
 8Qlr7CRTZFQjyFNSg9ptbS56SSphXsEqbtNZWRrhrUNGxiZBwLLj0OgKFmRwGvlKOYll
 Ku0Ri669JHE/JC1jilcDPP/Kol5h/oMV88ueqpMOkATsxYlVKFL1K91qpYiW7eKbdcRF
 +1V+iGewJcW/GZYpJVpmclWekGx0r7A/XAUbQbDhY8bNFyuITQ2rvgjzUs6sP1BOGEGg
 QNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759543586; x=1760148386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jpaGr1uF4D30xSd0dNPLK5dGTT8TkvjRrHWlirpjx0=;
 b=ajeVZBKcf1l47tKi53NmKaioM03Y/6H4/1OSxqOLATdLlSpQIrYMDJBUExc0RVz2qi
 3/9G5ioTsJO1TiiShGHbO3S5g6Jz3IAlGMrSZ8CIUVYgZ2a5gXItBvWLmHJroF6TmvDk
 DTygPEaqCAX533O8KVlpY0OTvEZgT6ZHw6ORCHnkZqS7UdjLt2K+QIe8AG4ZVyDKSikK
 16VulwBkAIb4Zk0h/FuVzzlmJCgNowVuNYqA0KYBIbPk/dY6ZYma4ViydrI2NrnW7BES
 bWv2dKXnBEQO3xLxQdTOlkjUfGx2wXAwpuYcUbBZMXotUQ5rh57lxvGc1wlGKsxcYRPh
 WB7w==
X-Gm-Message-State: AOJu0Yw2ZWWASIACKl29h1ZEXoesBqZp2a+hS/JtBRwVoTNenyxLGR+P
 2Nd/o6Jf5h7PFfDkJaslxMwwJJLuZhq1lAB6SU6UMckOkT929TaHwA2wXK9xw7Sb3GlsCpxluw2
 wbM3se6ij+PAEJU3g2oR2I7hxFCquPS3FsTW6vN57vQ==
X-Gm-Gg: ASbGncuigyREcN40Cc0gahNimV55B+xKD5O72iGZlNvv095Zz8VLr7G57WME9FxMYfj
 zDtN47b3F1ZVy9MzjiBcQBuVid9TGjNwrqF1qabyoVUbanLwAp+nerPSgKKZTBtEnpBhQob/G7b
 jCoJjL2XiHKVjBrHkMxukDhOOuMehs6E0YLxHimzJy6JAJvy4OZYJg/V+FzSxJvlweuvIiMHiH3
 zTNxKcRN+JIfkjKcT6XUiJG6akCeg+X7gD+OILArrpzGnE=
X-Google-Smtp-Source: AGHT+IFp6q+V8Pcm3J3VMYhv9nAQdnUhepJ+fuSdPqop+YjOp6iojXXGXvbcYnULnTadlFHHwuqkLLK8vQpTZZC5wog=
X-Received: by 2002:a17:903:4b46:b0:268:5892:6a2e with SMTP id
 d9443c01a7336-28e9a663317mr61873645ad.56.1759543585770; Fri, 03 Oct 2025
 19:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003192222.767882-2-raymond.mao@linaro.org>
 <20251003201718.GT6093@bill-the-cat>
In-Reply-To: <20251003201718.GT6093@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 3 Oct 2025 22:06:13 -0400
X-Gm-Features: AS18NWA7RTrB6-k2jPPI37HdxizWjgUBiCT0QyLP8lvg1K6f3Rt2E2MfL7q4274
Message-ID: <CAEfUkU+Z1dUc9mfEO8sSW4tZ40opX8n8T8cqGpo4DkDZ+SGX4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

Hi Tom,

On Fri, 3 Oct 2025 at 16:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 03, 2025 at 12:22:15PM -0700, Raymond Mao wrote:
>
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
> >
> >  tools/docker/Dockerfile | 74 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 71 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index 5b4c75f8400..0a213a7a61e 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -58,6 +58,9 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
> >  RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >      --mount=type=cache,target=/var/lib/apt,sharing=locked \
> >      apt-get update && apt-get install -y \
> > +     adb \
> > +     acpica-tools \
> > +     autoconf \
> >       automake \
> >       autopoint \
> >       bc \
> > @@ -65,21 +68,26 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >       bison \
> >       build-essential \
> >       byacc \
> > +     ccache \
> >       cgpt \
> >       clang-18 \
> >       coreutils \
> >       cpio \
> > +     cscope \
> >       curl \
> >       device-tree-compiler \
> >       dosfstools \
> >       e2fsprogs \
> > +     e2tools \
> >       efitools \
> >       erofs-utils \
> >       exfatprogs \
> >       expect \
> >       fakeroot \
> > +     fastboot \
> >       fdisk \
> >       flex \
> > +     ftp-upload \
> >       gawk \
> >       gdisk \
> >       gettext \
> > @@ -92,11 +100,20 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >       imagemagick \
> >       inetutils-telnet \
> >       iputils-ping \
> > +     libattr1-dev \
> > +     libcap-ng-dev \
> >       libconfuse-dev \
> > +     libfdt-dev \
> > +     libftdi-dev \
> >       libgit2-dev \
> >       libjson-glib-dev \
> > +     libglib2.0-dev \
> > +     libgmp3-dev \
> >       libgnutls28-dev \
> >       libgnutls30 \
> > +     libhidapi-dev \
> > +     libmpc-dev \
> > +     libncurses5-dev \
> >       libpixman-1-dev \
> >       libpython3-dev \
> >       libsdl1.2-dev \
> > @@ -110,9 +127,11 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >       lz4 \
> >       lzma-alone \
> >       lzop \
> > +     make \
> >       mount \
> >       mtd-utils \
> >       mtools \
> > +     netcat \
> >       net-tools \
> >       ninja-build \
> >       openssl \
> > @@ -122,12 +141,16 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >       python-is-python3 \
> >       python2.7 \
> >       python3 \
> > +     python3-cryptography \
> >       python3-dev \
> >       python3-pip \
> > +     python3-pyelftools \
> > +     python3-serial \
> >       python3-sphinx \
> >       python3-tomli \
> >       python3-venv \
> >       rpm2cpio \
> > +     rsync \
> >       sbsigntool \
> >       socat \
> >       softhsm2 \
> > @@ -136,13 +159,20 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
> >       sudo \
> >       swig \
> >       texinfo \
> > +     unzip \
> >       util-linux \
> >       uuid-dev \
> >       vboot-kernel-utils \
> >       vboot-utils \
> > +     wget \
> > +     xdg-utils \
> >       xilinx-bootgen \
> > +     xsltproc \
> > +     xterm \
> >       xxd \
> > -     zip
> > +     xz-utils \
> > +     zip \
> > +     zlib1g-dev
>
> Are some of these deps perhaps optional? I would hope we could build
> without cscope and xterm, to pick randomly from the top and bottom of
> the list. I ask since everything we add here makes the container larger,
> and it's already very big. I'm almost wondering if we should (follow-up,
> later) add a step where we remove things that tools we built needed, but
> U-Boot doesn't need for build/tests.
>

Actually those deps are grep from OP-TEE official docs, but yes, I can
find out the ones which are not really necessary and then remove them.

Raymond

> --
> Tom

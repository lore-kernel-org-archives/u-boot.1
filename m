Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1834BC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B67588A83;
	Wed, 17 Jul 2024 10:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W2Ymbril";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D4088A7F; Wed, 17 Jul 2024 10:33:31 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719E3885B6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-65f9e25fffaso40780107b3.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205208; x=1721810008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rW7GubfCuVriyMszdmFtJrIRPR1k2JjSLPHzMEKZABc=;
 b=W2YmbrilvsyM+DX6sxuFhd+wFm06S7/mTBat++gyCxOdTUX0HA+YCZeLnVpExNLI9Z
 AvnB9uc0PUVKvuwNUIa+nXkG4L0E8QPD4ugBTRpHbXAJT+iWQ6E7O0c9yxEjQfu9ro6h
 GwjhNDLebtaZhbZpvmD5aR2ztIzJu0kOQP++E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205208; x=1721810008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW7GubfCuVriyMszdmFtJrIRPR1k2JjSLPHzMEKZABc=;
 b=TJBLOl2vnz3Ilqm7D00eYsXoSCp4hP5i4hGgEtKz+FFRVOLpw/yFpzIDetRdoa4qYK
 oE+Cv0Oi/OG1XxZQf5DaKojId0Zi/o1h+Ets8PjT+4QoFBlgmL5j6gj64h9TTJXIZ8GJ
 yK6pz76UWEbtI4ujzqKa5Z9vIpwKJcotCXu5Of08TBI9nX8A4xDGKz7SWbl2YNOYoZ0d
 VamtVFxxbhWR1GvHSmCbheXjuf1xYn/wj9YX52t5NW8eN73KGBLXmB6/ixBVKiqxCP7n
 0EK7z4xS2dUidztLdViK7QpwrYAiDGcbUE40gHWqHM3cTRh8pBX8dQP+xFLzPMCNRFnn
 Nybg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4X48V5/bZq5lA7grtu/4vNqj+yUqjGObJlCxytpdKRLdtQyBgtRDHL2TjW2IOOMy8DRm2YYK65bJrqAxTo/7I1S2uEA==
X-Gm-Message-State: AOJu0YyEB1I+Y1yTqmVsM5klTZvjGHPT5a02M42bb9W6zeTvneO9kpLL
 5wBQL5gF1kqVC5hvDUphKMm2L4BFiROyBBRdrDtQqD1fRPBkwsSxXj2lo8HwMAHf6ZCm4I88kJy
 ih0GM6qBHmQ9vj2PB2hpO86WwiZ+fQn0G5h7C
X-Google-Smtp-Source: AGHT+IF3TUm65G84Sfh93yJcXTb5j459VXC1f8vTPrMVta+3QBhTPEX3Z7R6YxXo418opx1vRcEFq6YTjKL+BVW0m8I=
X-Received: by 2002:a05:6902:1007:b0:e03:5188:591d with SMTP id
 3f1490d57ef6-e05ed6b845emr1065758276.4.1721205208216; Wed, 17 Jul 2024
 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240716083534.19062-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240716083534.19062-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 17 Jul 2024 09:33:17 +0100
Message-ID: <CAFLszTiqKUVBn20N75pXupLNFmQC_ivGEUtR7wJPcuZ_BB2TNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] boot: provide CONFIG_BOOTMETH_QFW Kconfig parameter
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Tue, 16 Jul 2024 at 09:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot is often used conjunction with QEMU to boot via EFI or syslinux.
> Here the QFW boot method is not needed.
>
> At least for qemu-riscv64_smode_defconfig the kernel parameter is used
> to specify the U-Boot binary. Trying to run U-Boot as a kernel makes
> no sense.
>
> Provide Kconfig parameter CONFIG_BOOTMETH_QFW to decide if the QFW boot
> method shall be provided.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         default y on all architectures
> ---
>  boot/Kconfig  | 9 +++++++++
>  boot/Makefile | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

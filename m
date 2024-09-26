Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636A5CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743BD88E96;
	Thu, 26 Sep 2024 23:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nvIVNFTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93B688E8B; Thu, 26 Sep 2024 23:29:28 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787C788E1A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb399056b4so4631336d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386165; x=1727990965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j+swCKlfoXljh1Hu/0Qrpjoy4tGhDYS+cmjUv5wcQ0g=;
 b=nvIVNFTiT2qNYuVzfVHV3Tummd/gGtH8ASNFD3vbhVTeHGhz+BnTGMIVmwPDbSimwY
 Kpbn8TTnqARgmVYtwWLpnO8avR57xQ8UCVviCSQ7W69kR1FVgDsBX7Hc/qrO5s6q6Nf3
 WBxbJ2MnXacGpe2UfMoTaeNMZrFBI51Cwi08I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386165; x=1727990965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j+swCKlfoXljh1Hu/0Qrpjoy4tGhDYS+cmjUv5wcQ0g=;
 b=ZBUpdfYylWMLifXwVnjjx1aAc4Xee98o4wtLmh4Pd252P9l0O4KFG6euj2W1Rpcxyo
 UJAJWNGDDFY5Wv4y7XyGMCcH+ZIXefJsgwa8yEiLTD87D7k9yTqsv6DP8bK57Jb7ZHKr
 w9TzVsdfnMO8xn6iqxijT9TpkwiOgCyDMMeSYjxVzDJ4Vt6YOVr1Bx+VPFy4ttqvjJhM
 nV3tWaboAEIaLAnBb0UVzHBxFwjHzxzzSVi715HMnz5zpYSEuYfMlhr+ZtKgsgYA70Sd
 X24s51Y8SrRHLI6upIN/MMuyKSV2zJB+JPbb6P67+Kb2wfA7YxOj6XYIY4gwkkAXQPAr
 JSQA==
X-Gm-Message-State: AOJu0Yx4wR8HMiiqeHQis1ZjqIGEhoDkIHZcPBzj+wVMBbLOicUzIP3C
 Ze7Yx+koF0hNH3kqVrx2sHEX0JoM9FMvEDm0LUzovtFVt4LTAxZUZBRpRneS9sfCGDdLMG/m5b3
 4BOyISAoBLfrPBKJWOY/If5Qtp4L8nEj4eo8m
X-Google-Smtp-Source: AGHT+IFJ2huc7rd6dPx1SGjSzSK0AKd3XeVgNspJCXTwvGlRQYEnb8R+RueAxRyyqxI2e+Yg2jHjhagmicTQnQvJRvY=
X-Received: by 2002:a05:6214:14a8:b0:6cb:3e17:f4cc with SMTP id
 6a1803df08f44-6cb3e17f54bmr1186906d6.31.1727386165372; Thu, 26 Sep 2024
 14:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-37-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-37-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:29:12 +0200
Message-ID: <CAFLszTgNiRAh3bo26avy+tPZvu9L1R=CuFKJP4LBCJ0gdXfb0Q@mail.gmail.com>
Subject: Re: [PATCH v5 36/36] azure-pipelines: Enable qemu_sbsa
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 26 Sept 2024 at 10:12, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add QEMU's SBSA ref board and run tests on it.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  .azure-pipelines.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Should add gitlab too?



>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 93111eb612..2881851ecf 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -250,6 +250,11 @@ stages:
>                wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
>                export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
>            fi
> +          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
> +              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
> +              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
> +              export BINMAN_INDIRS=/tmp
> +          fi
>            # the below corresponds to .gitlab-ci.yml "script"
>            cd \${WORK_DIR}
>            export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
> @@ -415,6 +420,9 @@ stages:
>          qemu_arm64:
>            TEST_PY_BD: "qemu_arm64"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        qemu_arm_sbsa_ref:
> +          TEST_PY_BD: "qemu-arm-sbsa"
> +          TEST_PY_TEST_SPEC: "not sleep"
>          qemu_m68k:
>            TEST_PY_BD: "M5208EVBE"
>            TEST_PY_ID: "--id qemu"
> --
> 2.46.0
>

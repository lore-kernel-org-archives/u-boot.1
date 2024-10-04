Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35955CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FC588D75;
	Fri,  4 Oct 2024 08:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GMysRvbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AD688FF8; Fri,  4 Oct 2024 08:06:29 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01969884DB
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e199b1d157so1360796a91.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728021985; x=1728626785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NSLKsgCHUkN7G4OVOhl+Tu/CTWrtdD2F80qrQfu9ojQ=;
 b=GMysRvbYz3ipJBm9pR8CvYmLUJik8qm3w8hwC7aEQ0uVNKUTyerWJIWhZxv8vavoHQ
 +8x+MDoRKouvpfzQFLtQwvq833//uVMTXmYOvIlQFv0onxAHagzEug82T6uO+A2jo/Rc
 cdxybTN1wMtHsmD4jNEXHDcKk4JVWaT3hls5CN8Ya7i7tJcRwaJ5ps8PcOy/0VgMJBP7
 sxF3DuhitSfE9ZnIzbYQ4I6xgSJHHFpv2t6wUlgX+k7qVeGSEAOFtSMVZXaJaKm32e3p
 Mrq0rqWuPdA68gxJMHOAInhRh1VL7CkUOjunGqdZ0n1u8oZF8zNF3rWfDAILi5KLrXqS
 5VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728021985; x=1728626785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NSLKsgCHUkN7G4OVOhl+Tu/CTWrtdD2F80qrQfu9ojQ=;
 b=fgLXnTqO8cq1vwZgj2xlO1mkTrKR8LQgPj7bNXnTbnacAAG9pdstvKks0BcQBa7CSN
 B7avq7v9F1U2X+uzqFnFARExjD69j25PhGLOZIKnvu00Tadi7uU55cz0rtF8TOGYiVJd
 CljKh28euo4Xi9D5S9z0isqx23gqzYQnH5OnIGt2OLZGjnZkqxCzTjjBRxofJAfkFp1s
 qPTAyC5mhRKTcOT5kX9NmWPBsNAKnHZ/3Q2goaRpEBGlJn9TzK7fUkgF120cWW6FfBh9
 4ZJYVMw4a6HkswXpVx5Ld3wDagsaGzjYp5P3MmpQMW+Br1YT0B0Cetoop0JJilG8pvBS
 mAJw==
X-Gm-Message-State: AOJu0YwvhgdDvwVJQ2JrHOmhOjmSx2dzQDG1GVQ1n6waE88FV5UVpCvp
 /LLmKSg0wOioK7XN+VtE3FwFEM+vacD+MbuJ5S9duWu5ZAo9qCewkdLk1tUvYruWcXm5G7OWQrn
 i4MeNcvUMpZ5oCSw8f2hXF9080ujtkl8DbW0z3g==
X-Google-Smtp-Source: AGHT+IFG4wNdj73Di0fqTlZf4s/61kLuF8TlaWuRu3g09DhVnpaWB99Yin4DpJ9j1rMbiXzMjUvdqtrYD5UUBXz9qwQ=
X-Received: by 2002:a17:90a:bc92:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e1e63bf552mr1962248a91.38.1728021985424; Thu, 03 Oct 2024
 23:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <b7cc4bc4d5aea1310401c107f7836a9eadd6a493.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <b7cc4bc4d5aea1310401c107f7836a9eadd6a493.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:05:49 +0300
Message-ID: <CAC_iWjKtzkYF+vYXsA70rW4A5_DMhErXE1KPGoa1d_VDTe5t-A@mail.gmail.com>
Subject: Re: [PATCH v11 25/29] CI: add qemu_arm64_lwip to the test matrix
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 3 Oct 2024 at 18:47, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Build and run qemu_arm64_lwip_defconfig in CI. This tests the lightweight
> IP (lwIP) implementation of the dhcp, tftpboot and ping commands.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  .azure-pipelines.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 93111eb6127..59fddb96a48 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -238,6 +238,10 @@ stages:
>            cd \${WORK_DIR}
>            git config --global --add safe.directory \${WORK_DIR}
>            git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
> +          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
> +          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
> +          ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
> +          ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
>            ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
>            ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
>            grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
> @@ -415,6 +419,9 @@ stages:
>          qemu_arm64:
>            TEST_PY_BD: "qemu_arm64"
>            TEST_PY_TEST_SPEC: "not sleep"
> +        qemu_arm64_lwip:
> +          TEST_PY_BD: "qemu_arm64_lwip"
> +          TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
>          qemu_m68k:
>            TEST_PY_BD: "M5208EVBE"
>            TEST_PY_ID: "--id qemu"
> --
> 2.40.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

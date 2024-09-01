Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C95C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C0988B6E;
	Sun,  1 Sep 2024 22:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mbPTeCFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE7588B6E; Sun,  1 Sep 2024 22:09:59 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B48D88675
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a80511d124so205605685a.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221396; x=1725826196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQMLLyfXipjN1yidgehT72p7qllpsX4n3chON/hDbqI=;
 b=mbPTeCFuwuWAJSo1uk4K3pflXL8lKuhJYAjpmrzaIprcerDHB4JOr7SgsOk4dUFIfW
 zsf5GJlfl/TntWYnEwoIbrDX/sY+TKq2rDQ1T/3ZUa7z/lv4nmsRZnuU5mVRaFxextf4
 CgHhX12aBcebVvcml1HUy+bjZtdl/9MsMH1u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221396; x=1725826196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bQMLLyfXipjN1yidgehT72p7qllpsX4n3chON/hDbqI=;
 b=AZh6VA45nUTxIOEMDNciDANZiTp6oWkIL4DtklnUsPcrgBSsh/voJRsV/7evz/oJJs
 sJhYjjyOjW8SW9s55+Qo+xic5BLPTE057ogQV13tFYcuSlm9FpyJdTdCoqUw0vE9HDIh
 c2T2k6pqy6BbofZaj9/4aDHAw9uYN7CFRF36Ja5hjZEWJsXLRDMx448vpZLfvx3Vcdr3
 VPVHNx8ukDJJUAeYnI+hQxh3Jb18NdFkHSTJLy3UdPsdL8EeYffKntzaCHp3gVEnZK9h
 84GBDvKsTZIrUyK3lHdVPXlRpOVss6PNQFvMohxTM6W8muhuwg+cIwvjMwk4vqvvyxMY
 wYsQ==
X-Gm-Message-State: AOJu0Yy44EuPu9SEwFSSKqf2HAR3d03jtAuQm/uH4g656kUwFuhorTdH
 uclvIiJBP3rU9Tho0nup1oUHa4rXKM1at+WMLkfMAbRCoPEV1ARlX3QQsBM4jfDysZR5yW80zML
 20nvFY1dI3tcapvbL64zqIOmLHRFzuJ4zWX47+Zwfs9s48gI=
X-Google-Smtp-Source: AGHT+IFbLR0Nv8dyLOAC1/kRVsSx6focP8yZ+TYPZXBa1G9C5AXJ0xg3SBNr6Fd/KUufHrHrca7FT3ocjMwP6T7uFEw=
X-Received: by 2002:a05:6214:4b09:b0:6c1:6b19:15d with SMTP id
 6a1803df08f44-6c355f707e3mr84134846d6.44.1725221396295; Sun, 01 Sep 2024
 13:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org>
In-Reply-To: <e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:45 -0600
Message-ID: <CAFLszTgPCkaSrfzcT1i=4pH-VS4mqBfOa2Tw6Ow02J=rc+V3aw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
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

On Fri, 30 Aug 2024 at 04:17, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
> detected and the sandbox build fail. It typically happens when using
> ccache. For example:
>
>  $ make sandbox_defconfig
>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
>         CC="ccache x86_64-linux-gnu-gcc"
>  [...]
>  In file included from boot/bootmeth_efi.c:16:
>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
>     33 | #error Unsupported UEFI architecture
>        |  ^~~~~
>
> A similar error occurs when the build is done via buildman and
> ~/.buildman contains:
>
>   [toolchain-wrapper]
>   wrapper = ccache
>
> Fix the issue by considering only the last word in $(CROSS_COMPILE).
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch[1] seems to fix the problem you mention, for the CC part at least.

For the CROSS_COMPILE bit, why is it valid to use a cross compiler on sandbox?

>
> diff --git a/Makefile b/Makefile
> index f90e48f58a..dc7bdd7942 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,7 @@ include include/host_arch.h
>  ifeq ("", "$(CROSS_COMPILE)")
>    MK_ARCH="${shell uname -m}"
>  else
> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>  endif
>  unexport HOST_ARCH
>  ifeq ("x86_64", $(MK_ARCH))
> --
> 2.40.1
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-9-sjg@chromium.org/

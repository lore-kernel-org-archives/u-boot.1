Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E71E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CF586D7E;
	Sun,  8 Oct 2023 01:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NC94ZFtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D40586DAF; Sun,  8 Oct 2023 01:12:19 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB11D86DF5
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59bebd5bdadso40446447b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696720286; x=1697325086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9qWYNzavCA3Gtxq9lqZ5WDeULa15Cy6P3KFB8aKjxYg=;
 b=NC94ZFtDtZswKiYkjTvaIvQV7b3lDmrRas4FmUStuNcSV3ckEu1GVtepm3+tHLWu/u
 ZGtubd7CxrBRo6QgG3pteK1Ika1UUH81PM8zoQFUGjUg6tGtavghpWPHpiu+W+2NUmhP
 l+5JpOHdggl7mCYCww+lS8NRNA6cCgR+Z8ACQzIIOA8pNja839YqsN2KE4X1qSmCFcLH
 w1j7fbRs4OcXkErx9eTwLa+mCr5nNsMGTg2KsyammK2jAIkhC3cwgqb/vOjePL4vO2Iq
 I1zEmb8gYZdWw0It6tiraDmUuTvMv+ysrHhZhB3S/UppkzdiLQHN/y/TnuudfRS5T4Hx
 PnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720286; x=1697325086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qWYNzavCA3Gtxq9lqZ5WDeULa15Cy6P3KFB8aKjxYg=;
 b=QDAe6zaY6ONE+S4SDJu8W3PCdwKN5uX4mv2gWWkm3NXMJgma3ZnYjoyw/naLne99tW
 7p3uky/VLUBFj6zXh9gVdRH2nzHGSSF6iYs/iwIAcIU0aIofGtubRNXIr7PRd9uYU5c4
 82xyqzfpHlzrPbCHk1m2FZHdMmWDBKt710T2VdprMoBadK5SDW/uZ6RfLhhtWiV/WTY2
 d70ngyAAGV1gKFoC5ckFSvJ+3rWQq1PjpV2FPWgBWK1mtxkm/eGae+jwwdQdJPVqiBrG
 EfTKKFjYzT0nE1931mzlEtbNJ+IQY1Hr8B2DZx/byca0NSOJRrLZWC3xo5OsV8+j+tj2
 kT4Q==
X-Gm-Message-State: AOJu0Yw8G6N+reNtT6Oud7cCNPmK4iWBTJ1BLsC6MnEYIBTTLQWkvBgY
 dRHAARcAniz4aydTRgVOOWbn3fkvW37xt/ZwGMh++w==
X-Google-Smtp-Source: AGHT+IHIfqaBA2w+DlsSmBOiFJDZp0Lv8k5wLU3m7sJpY8WjB3WNSpBfy5iDomglIfZxqhLfPTKUOV8Bi8VizRA+kv4=
X-Received: by 2002:a0d:c546:0:b0:595:80e4:907d with SMTP id
 h67-20020a0dc546000000b0059580e4907dmr12475891ywd.32.1696720285460; Sat, 07
 Oct 2023 16:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231006112351.2275090-1-randolph@andestech.com>
 <20231006112351.2275090-5-randolph@andestech.com>
In-Reply-To: <20231006112351.2275090-5-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 17:09:56 -0600
Message-ID: <CAPnjgZ1gNtQ=fctPTrST3Tjz9QpcMg5+zMR-+PU_C6pT0fy_JA@mail.gmail.com>
Subject: Re: [PATCH RESEND 4/7] riscv: dts: introduce
 SPL_LOAD_FIT_OPENSBI_OS_BOOT symbol
To: randolph@andestech.com
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

Hi Randolph,

On Fri, 6 Oct 2023 at 05:27, Randolph <randolph@andestech.com> wrote:
>
> Introduce common Kconfig symbol for riscv architecture.
> This symbol SPL_LOAD_FIT_OPENSBI_OS_BOOT is like falcon mode on ARM,
> the Falcon boot is a shortcut boot method for SD/eMMC targets. It
> skips the loading the RAM version U-Boot. Instead, it will loads
> the FIT image and boots directly to Linux.
>
> When SPL_OPENSBI_OS_BOOT is enabled, linux.itb is created after
> compilation instead of the default u-boot.itb. It initialises memory
> with the U-Boot SPL at the first stage, just as a normal boot process
> does at the beginning. Instead of jumping to the U-Boot proper from
> OpenSBI before booting the Linux kernel, the RISC-V falcon mode
> process jumps directly to the Linux kernel to gain shorter booting time.
>
> When SPL_OPENSBI_OS_BOOT is enabled, it will change the default FIT
> configure file "binman.dtsi" to "binman_linux.dtsi"
> Default is not enabled.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ec1cfcaaa7..4f104789a7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -422,8 +422,17 @@ config TPL_USE_ARCH_MEMSET
>
>  endmenu
>
> +config SPL_LOAD_FIT_OPENSBI_OS_BOOT
> +       bool "Enable SPL (OpenSBI OS boot mode) applying linux from FIT"
> +       depends on SPL_LOAD_FIT
> +       help
> +         Use fw_dynamic from the FIT image, and u-boot SPL will invoke it directly.
> +         This is a shortcut boot flow, from u-boot SPL -> OpenSBI -> u-boot proper
> +         -> linux to u-boot SPL -> OpenSBI -> linux.

This bit seems OK

> +
>  config SPL_LOAD_FIT_CONFIG
>         string "Default FIT configuration for SPL"
> +       default "binman_linux.dtsi" if SPL_LOAD_FIT_OPENSBI_OS_BOOT

But I'm hoping you can drop this and put the logic in binman.dtsi

>         default "binman.dtsi"
>         depends on SPL_LOAD_FIT
>         help
> --
> 2.34.1
>

Regards,
Simon

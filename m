Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A47CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DF4891DE;
	Thu, 19 Sep 2024 16:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lwXOvzt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C09891D3; Thu, 19 Sep 2024 16:10:08 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1A2891BE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c36ff6e981so6725826d6.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755005; x=1727359805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u5yKwD6iSxVK6iOcdb9iFxqHmMv1z9+9s1JQS8QSMS4=;
 b=lwXOvzt3RQnlt0rK+Hsk6xos+NYuVR9Ai81M+IHjHfSk0tsLP2h9n6LLPiWT1jqcp8
 v8h3SNsZ33XCd+Qty6Fh/vKJpKbuo18h0vgm5SDoZCFT+fRclPzd/b2tIHaJgZu45n1y
 5vRb3rqVY8OeEvjg0GPNu+a85T6E/dJnPjaDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755005; x=1727359805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u5yKwD6iSxVK6iOcdb9iFxqHmMv1z9+9s1JQS8QSMS4=;
 b=aKzMQiA3xaVnLxLEuLlJgTcjJ4MsbZmBCBV7CA5zjIGt1pP9fvaq/0NuNvM/w6UxxA
 fD3RonVIEmrC4QLlvmz+/AOetW5rZRDOn3WDJ0u539j4YB52jgPNSwliZbaZJ9bvsIKS
 Bo/R6G8HjlHqWMNC8FX3sg2YGUjt/ThiA+PpPRU1GYGtMYjeo1rdP9zXZ/9j96FcCCiy
 rW0tNTonRDzUiK76HuMZCu5Ou8X/+CRkA7opgVg124mC3IJ5E1XtPSAycPmP7E3NH4sN
 UPWryyQMlBo5ep4TE2YPTAJtY+ujdlcyReJew8WaoeOHaFvmAiQlUyL9t5SgLTFWsz03
 vJzA==
X-Gm-Message-State: AOJu0Yys7b1wesCRGt9HA8jJlMMWBySoq1oaXws4GPiocp/j4sNyphBa
 3HSZn7sXNXhqwlJTy8u52iUxm5kBgVVo8uXUiXsxafYe8JfMM3WglNQU4OoGn4Qs0xvzaa3UcdB
 R5riF4JLgA1uETWLAUSEaNd6lyjNYj/paWDW1
X-Google-Smtp-Source: AGHT+IGQ3avyxha5SRR4L/3mE4y1D8VFFMUrfimuvv2d6bcrMQC9MK1d3izsS/bqJlC1G3ZSpD/jKXGOFa33Id6qDno=
X-Received: by 2002:a05:6214:2e49:b0:6c5:aaca:a48d with SMTP id
 6a1803df08f44-6c5aacaa50fmr212995276d6.13.1726755005487; Thu, 19 Sep 2024
 07:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-32-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-32-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:54 +0200
Message-ID: <CAFLszTgYwRc+1c3p+bg13T3Jz4r3=ZCuwioc3vcNS3CR9FUqyA@mail.gmail.com>
Subject: Re: [PATCH v4 31/35] armv8: cpu: Enable ACPI parking protocol
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

On Wed, 18 Sept 2024 at 17:27, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Update the generic entry point code to support the ACPI parking protocol.
> The ACPI parking protocol can be used when PSCI is not available to bring
> up secondary CPU cores.
>
> When enabled secondary CPUs will enter U-Boot proper and spin in their own
> 4KiB reserved memory page, which also acts as mailbox with the OS to
> release the CPU.
>
> TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 7461280261..544a4a5364 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -178,6 +178,18 @@ pie_fixup_done:
>         branch_if_master x0, master_cpu
>         b       spin_table_secondary_jump
>         /* never return */
> +#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
> +       branch_if_master x0, master_cpu
> +       /*
> +        * Waits for ACPI parking protocol memory to be allocated and the spin-table
> +        * code to be written. Once ready the secondary CPUs will jump and spin in
> +        * their own 4KiB memory region, which is also used as mailbox, until released
> +        * by the OS.
> +        * The mechanism is similar to the DT enable-method = "spin-table", but works
> +        * with ACPI enabled platforms.
> +        */
> +       b       acpi_pp_secondary_jump
> +       /* never return */
>  #elif defined(CONFIG_ARMV8_MULTIENTRY)
>         branch_if_master x0, master_cpu
>
> --
> 2.46.0
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94D0CF8548
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 22:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E777788FB0;
	Thu,  3 Oct 2024 00:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aqk+xOJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D752688F7B; Thu,  3 Oct 2024 00:55:49 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACE288F8A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb2f272f8bso3052646d6.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909746; x=1728514546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=elAAJiYmie6/BeJbW+ckCrB5BHiSIaWnrLSNZgAtbrk=;
 b=Aqk+xOJtbE1W5nQC/t774TZNSb6HyEMfc+64O5Ft+U8rAsq49XUnQIguqg5hVNt/nb
 gKR2WWIbrb9dnXmxf8i8Q6btUkH5e6w/hyua6y6YviBeUJumpyKNjHfheswY/PfGBGCr
 Eru67Ex566WAayK/qfmt5kC4nHWgKtq4wrx4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909746; x=1728514546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=elAAJiYmie6/BeJbW+ckCrB5BHiSIaWnrLSNZgAtbrk=;
 b=Wo5VmgGFDf+hgiiT6/EtrCg2+7V80EC/J+50og/RfLQtx6Na1ZfDng2lBeYfZ6MIrZ
 5xGmWmTPRAeXkugLNeUkpHPucUvOv2v4c1vlIjIMENGV60Dr8bZJwoxuS3JyYvLOOJqO
 NhJtqZtmKUhXPVMbUZnav3Qu+uAHIB3t8CURfuZjJ8+SG5701deabJizpeDXMFzRcB2b
 S7FMP9aHEymSX8xq5jZydGvFP/o6ZuZ4wFWYPpGQLFHq8JpIi2xxZlHQ0uK7Q3+5cRZG
 whNlH8lmDyc+Cja/l3P+JU3IpjaxDAJ6IHAv7aPrDwD+cVarIXtUQMArpfzNtlHfmlCy
 JQAg==
X-Gm-Message-State: AOJu0YxNDfMw1A7zbavsGg5Yd4esJhb+PQO7+X2tyVsY5B/kBbB6sGqD
 BdQBgceixzHSgKMAh3bhmyFYmofeWatn/QP4xiWbMwubJKWGNZClWAhhra181LJmU0BY/gsITSI
 Oida3CFmn2A6zkX40TuApTulYxdX7GH8tC8RiYsZSRYkyZZY=
X-Google-Smtp-Source: AGHT+IEEJKpMfJpjmIckkp4xQAz9YPjo2ohwRYhPYmYwt/EbiGHWaNgmqtcvsR0cG27XSP6Z8rWlcRHJP48RUWFgNPY=
X-Received: by 2002:a05:6214:440a:b0:6c1:6bf9:8fea with SMTP id
 6a1803df08f44-6cb81ccfc82mr56392816d6.50.1727909746706; Wed, 02 Oct 2024
 15:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-33-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-33-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:36 -0600
Message-ID: <CAFLszTitpXdNWSDaL9SkBCDg4SeVPuh0_cHdBSLJFPNdjahOWQ@mail.gmail.com>
Subject: Re: [PATCH v6 32/37] arm: Implement read_mpidr on armv7
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

On Wed, 2 Oct 2024 at 03:57, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Implement read_mpidr() on armv7 to make use of it in generic
> code that compiles on both armv7 and armv8.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/include/asm/system.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 7e30cac32a..94c6f8f134 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -384,6 +384,15 @@ void switch_to_hypervisor_ret(void);
>  #define wfi()
>  #endif
>
> +static inline unsigned long read_mpidr(void)
> +{
> +       unsigned long val;
> +
> +       asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
> +
> +       return val;
> +}
> +
>  static inline unsigned long get_cpsr(void)
>  {
>         unsigned long cpsr;
> --
> 2.46.2
>

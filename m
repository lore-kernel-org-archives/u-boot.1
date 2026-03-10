Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56623FCC9DB
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 08:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D5683F6D;
	Tue, 10 Mar 2026 09:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RGKr3l7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576F5839DF; Tue, 10 Mar 2026 06:58:53 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9F883952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 06:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae82df847bso25121025ad.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773122329; x=1773727129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mmJVCULRcGXTptwj3/adQjG/XHnW/6RVpQs0quSGz0I=;
 b=RGKr3l7G9RdDEEKewnN0VDfsP/CVD0ujvonS7XT5jbKmIyBpwKzqUthOOYqLoBDBhB
 yJlco7Ye6Z9n4XyWHpwhuoypR6A0WqeUVJNTVsHXyHurkyJme7qHw9ze2r4ns3SidLa8
 3qVNlJg3LeABEIiybL/ALSsnVyfbcqELJx14qe0NLxXs/mmKpBcICBI9LJm+M1x2uOYY
 0uAP9p6uA4P6Rj2VUGdjlq1HtLbGZlVPN0u37Rfd3m15euMZKayWuZ82B2lEt6QItFlg
 g9jp3nxti/vIQ4A+IqKS0RiGkZmAfqe2DwrkNnQ3gGMTimYytGN1H6uPnAMupmje56/U
 tfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773122329; x=1773727129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmJVCULRcGXTptwj3/adQjG/XHnW/6RVpQs0quSGz0I=;
 b=dibP9v70scKBCztT1vtWr2wEZF/MODG172Wz7Ru+rt6Ic1lMQn9CsAQMDsQ1gCqufk
 4D5UHkgMJ406r/sieaF+Pzsgzw4xvdPW2G0BaYAFDBv6CPX35UST/g3WSPI1PPyHlCfG
 4p4qAOcxMa+lmchd9QedNS5jOVbkOasu5xr9JoyUAbb4UaOKrR61rK4N8gRPK5EyFgFZ
 hLeOPv0ZxO4N5cDEtRztJtp3xIjLfT0MpyLMlcBcbyKfQrSIyfDxPixQr+OAEH60QTej
 F+dNl4+jVhN8/bWJx2FRUBMbM2xaCXEH/zXafsy9lX+i8hoW+ajqLKSbU5T9xjnvme4+
 1XFQ==
X-Gm-Message-State: AOJu0YzDtERgik3pfZrms8TABWreZi2HJ1E7wO+NzbHiIw7qWtsTLFMT
 xCEhg0gWWCjehtrCsl1c9cXo6KyuWATOiJWwS3AFHDga5l8+0gASF/rT
X-Gm-Gg: ATEYQzwWPw24erOG9uYbhAbOXXIHrL5fopU4sPDVmauOHLi5aKRK2Ia2ZD8+7ZhKvRh
 I9RnAW8Vm7xlSrxJte0FFL8iWB1pxkZCt0NUeJIcjXV/nnAVZZrZYgOMlxwONLVAekzAAXhNV2g
 pXkKQP4dCgZtv1ajXzuCjCOEAC/euWQaU++fkS9v//SErDuWKWfS81YQyr34V/i2EXV0ddirLF5
 ityQDbknUYuKQ3jJ/ERSmmQ6qQbyiBXImDaiI0oXE39Q/cWI8vWyF1UgZsbS1e+jHTv1WKN+wZe
 cDQEfVcATGKeWghcslP6XyHZSiq73uFnID+/J+y4ytld79vKXLnO4l77f20G3hWyAu1qgsNxuRQ
 McOTDiz5GZp4ugLDOKlUpormvBc1DYn7xDBBg+1h+xeUJ1GyqkEc31d9LTmENpfzTdSp9WyxTnO
 lExypel2405g/qN+rQ5u662mgAUrpM4ZBij2YDQfsH
X-Received: by 2002:a17:903:234a:b0:2ae:5a28:cbac with SMTP id
 d9443c01a7336-2ae824f46f7mr123358045ad.32.1773122329432; 
 Mon, 09 Mar 2026 22:58:49 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:16a4:8f0d:6d1:8d9d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e58592sm187652545ad.14.2026.03.09.22.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 22:58:49 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:58:43 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH v2 2/3] m68k: m680x0: Initialise the debug uart
Message-ID: <aa-zE7bNzY8wguoi@google.com>
References: <20260309105110.672832-1-daniel@0x0f.com>
 <20260309105110.672832-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309105110.672832-2-daniel@0x0f.com>
X-Mailman-Approved-At: Tue, 10 Mar 2026 09:36:34 +0100
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

+Cc Angelo since this touches arch/m68k/

On Mon, Mar 09, 2026 at 07:51:09PM +0900, Daniel Palmer wrote:
> Once the stack is ready we can init the debug uart to help
> with debugging so do that.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/m68k/cpu/m680x0/start.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/m68k/cpu/m680x0/start.S b/arch/m68k/cpu/m680x0/start.S
> index 0802ca1fca2c..fdfcd66f7785 100644
> --- a/arch/m68k/cpu/m680x0/start.S
> +++ b/arch/m68k/cpu/m680x0/start.S
> @@ -42,6 +42,11 @@ ENTRY(_start)
>  	/* Setup initial stack pointer */
>  	move.l	#CFG_SYS_INIT_SP_ADDR, %sp
>  
> +	/* Setup the debug uart if enabled */
> +#ifdef CONFIG_DEBUG_UART
> +	bsr.l	debug_uart_init
> +#endif
> +
>  	/*
>  	 * Allocate Global Data (GD)
>  	 * board_init_f_alloc_reserve(top) returns the new top of stack in %d0
> -- 
> 2.51.0
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7FDCDB474
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 02:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1F786FBD;
	Sat, 21 Oct 2023 04:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWvDHcZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CBD86FBD; Sat, 21 Oct 2023 04:39:36 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6408756F
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 04:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d4453ba38so8906436d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697855968; x=1698460768; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ymDkXouBbs9EVhrZPCocBR1SMVpQGYvpQj1m6na3cQQ=;
 b=gWvDHcZSKsUeM1mqBI8IgPBqJnxD7QvqxKneoRw1XkBGb78FXWeQOvlDUb+YJRBe32
 JURJ/Ob+fgwwltikm6ZZLtyD9G3RpzMEsp4oq7FS5e9i0hWu/cpPBuOA9FglNIyv6OBy
 diDmrCJwLYYqWfH0sCt4ceF5Ri/PlPeRGlLm0tnPhmDSOD75gZm3S28GG06GEMedg1NO
 rPTZGGpKhLT88N7cpdZtc9V1UFfGCKzNRAGaFQXnC0gOrsgWePMsmmZSdi37FZDeQtQD
 TkU14yS3H8HsPmbFP6wPfmuLM6zN9gAXjBbtOTc3O6VCiF0MBRC0ZBvUeBHFEyiuVmkF
 pkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697855968; x=1698460768;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ymDkXouBbs9EVhrZPCocBR1SMVpQGYvpQj1m6na3cQQ=;
 b=NPKy8aoocrrL56mA04sNnhex6se6GZSH+RirbLZkCsWDAXlOqen7B2HqVtUnAHb7FK
 8l1GPpeyeDLJ2RDHoXFbjV5g/P1vHAkmDOGSOXcVwdgRNWEnSiaWi5hM3j2JNPeVvy1K
 kesILNcGkw/Jp/BlbCi/CW2rOn7zQK1yxznuc/mJMs7wDPuGpuWmJ+3gGOwhKkMifZ4W
 VtYx5SdpD06yhjFfkXZO94BHPwY+76dkwrgxur2xKkh/iY/KZorocQX52A5RpS4DVM4Y
 tlDruGHzG1+qg3VePbFE4oLBncJawEHV3hyLhZNumXF/I26M0T0QlHBIwCX9zLsXINM2
 y5lA==
X-Gm-Message-State: AOJu0YyYbtR7tuyPuqnTpMsHfcq5ErnFReOFIAvixLN6xjlXze1Zvuez
 CLqTEtaT7j0XiLRX9D6uPZo=
X-Google-Smtp-Source: AGHT+IHuhWWTKeVtmG6m8Lcz+6FVPwSMMaPv8GmWT0aIdfIuGC1Wgo8J00Dr58xyjuq5XKb1gZCODA==
X-Received: by 2002:a05:6214:248f:b0:66d:33c1:3750 with SMTP id
 gi15-20020a056214248f00b0066d33c13750mr4175608qvb.49.1697855967737; 
 Fri, 20 Oct 2023 19:39:27 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 bk6-20020a05620a1a0600b00775afce4235sm1065039qkb.131.2023.10.20.19.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 19:39:27 -0700 (PDT)
Message-ID: <0c21dedf-dc89-5b13-b091-3b0106374382@gmail.com>
Date: Fri, 20 Oct 2023 22:39:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [v4 23/24] sandbox: Add <asm/barrier.h>
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-23-trini@konsulko.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231019150105.714407-23-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/19/23 11:01, Tom Rini wrote:
> Add a mostly empty asm/barrier.h file for sandbox where we define nop() to
> be an empty function.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   arch/sandbox/include/asm/barrier.h | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 arch/sandbox/include/asm/barrier.h
> 
> diff --git a/arch/sandbox/include/asm/barrier.h b/arch/sandbox/include/asm/barrier.h
> new file mode 100644
> index 000000000000..0928a78cbf8b
> --- /dev/null
> +++ b/arch/sandbox/include/asm/barrier.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#define nop()

Reviewed-by: Sean Anderson <seanga2@gmail.com>

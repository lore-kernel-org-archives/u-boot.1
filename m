Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F506C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09098748C;
	Thu, 16 Nov 2023 19:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KW88L/+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7535A874CF; Thu, 16 Nov 2023 19:39:16 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685018615A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77a277eb084so67149285a.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700159953; x=1700764753; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DxOgqcJ1O7cmTEi7e0K5eO2XEIXm0ASnZnU+BLksyDA=;
 b=KW88L/+2iZv8onzQUmKiCSXgUNxMXG29U0ty9tc8Al4fx6n73a9lFQ9OewoEJlfthG
 HrvFFz5v3hpnzS3Ax+5snf+vf3SRtCpT3lcfehihVo/Y2ESgaWBlQ8yEYCO6clSGjGhs
 VZZKL8/BoNkEE0O3OPlf0o5uq4JGMXcc8ptVrvWqlH6fMI62UEluPGBXek7siFC4QLn3
 qEGwA67fkAQX14fnp7fKR78SAds0F5mtykGvRJdTm9s+ZsMaM5cGHDY1GdswuEv7YYxu
 pYqLRzSIoRGdQcDZeQ+F/rbVtwGqkXn5s3YDOqgcNKAJB41rKxvE6wKyLSMTHebDpPIM
 QLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700159953; x=1700764753;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DxOgqcJ1O7cmTEi7e0K5eO2XEIXm0ASnZnU+BLksyDA=;
 b=M8Ek/MvlSkrW0l3k0kY3/miRmyjpEXwUR09aIVNMhmn4Fjc08hHXaLngFyvy+F284q
 q4UKMkQfzEIjJUtJUPU0xCES8HOoUlQ5PN/Md2xL0ZQ+aASO1KY2JyqEhIusHaNP8G76
 WspvLpqkJw8sYMElt1HKss6AS7WIo8iPt8H6QCGDmGw5EW6qjZJaD+rE95EWChD2HFQ/
 JyKU0qz4NMcALhUSC3ura0SxzwJY4Y2U560QDmxb1FDO1xJ5UPMe9nU0e1WdLL2adKbR
 M5WxA6a2g6onsg7mTQqwI0n1TlX04K8PVyeE7rrDugvSjMn05rHDr8hQgVuZ/gewfBHm
 rReg==
X-Gm-Message-State: AOJu0Yyy8QxnIBhoRyiHtg1VMl26oEp09b2lxgDSUu/p11PH8d1FIZAs
 S9M+IsA3D4ROlfHLaDGsER4=
X-Google-Smtp-Source: AGHT+IFmIKmMHKXcYaQCApLRemekEFeyvBg/C+o+bn2eNLU3vNBXfzVEtdzPPAFGnuRy3CEr6iHWQQ==
X-Received: by 2002:a05:620a:2404:b0:774:3436:aa22 with SMTP id
 d4-20020a05620a240400b007743436aa22mr12176395qkn.5.1700159953199; 
 Thu, 16 Nov 2023 10:39:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 vv19-20020a05620a563300b0076ce061f44dsm9862qkn.25.2023.11.16.10.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 10:39:12 -0800 (PST)
Message-ID: <2ab0dd14-3bcb-e092-a1f1-13bde2d7b08e@gmail.com>
Date: Thu, 16 Nov 2023 13:39:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] fs: Fix SPL build if FS_LOADER is enabled
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231116171612.143910-1-mchitale@ventanamicro.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231116171612.143910-1-mchitale@ventanamicro.com>
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

On 11/16/23 12:16, Mayuresh Chitale wrote:
> If FS_LOADER is enabled for the SPL then the build fails with the error:
> 
> fs/fs.o:(.data.rel.fstypes+0x128):
> undefined reference to `smh_fs_set_blk_dev'
> fs/fs.o:(.data.rel.fstypes+0x140):
> undefined reference to `smh_fs_size'
> fs/fs.o:(.data.rel.fstypes+0x148):
> undefined reference to `smh_fs_read'
> fs/fs.o:(.data.rel.fstypes+0x150):
> undefined reference to `smh_fs_write'
> 
> Fix the error by populating the semihosting entry in the fs_types array
> only for non-SPL builds.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
> Changes in v2:
> - Use CONFIG_IS_ENABLED instead of CONFIG_SPL_BUILD
> 
>   fs/fs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs.c b/fs/fs.c
> index 4cb4310c9c..5c27ae2fe1 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -256,7 +256,7 @@ static struct fstype_info fstypes[] = {
>   		.ln = fs_ln_unsupported,
>   	},
>   #endif
> -#ifdef CONFIG_SEMIHOSTING
> +#if CONFIG_IS_ENABLED(SEMIHOSTING)
>   	{
>   		.fstype = FS_TYPE_SEMIHOSTING,
>   		.name = "semihosting",

Reviewed-by: Sean Anderson <seanga2@gmail.com>

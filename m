Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BAC106F311
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602CF83FD3;
	Thu, 26 Mar 2026 10:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ATxhSigu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997DD83FBC; Thu, 26 Mar 2026 10:49:18 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B78883FA3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so498470f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774518554; x=1775123354; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=J396XDsZeUT91u9zAv44pZdLCvSwnUx+OeGSs3K93aM=;
 b=ATxhSigu38PZgskExwRUgCgOuo35pd1gYwMJaMgx+SfJbOpMICbsKIXYs2de7+3lP8
 HYJjALE+0yVpp67gNvqYysyATvaQGXfzuhqIDqsZtQjnR9HWm6JX5/3RCbToQqIKMPL6
 dKEXmEta0484k2XORpqheQHsJS3qAfxkYAq96rC5mZCOush42PG6mQh/PYS7Zutjs2CZ
 fLdk3Ey2RkHtQojgihxL62kNqCGFf5DZteNjyeWmKl7a/wYkXhP3BpLx4h2BRiPLTCs4
 jLPpjeSr3ZTqGZGbRmZSsbqAxpiiq27UhYh3BUb1/CPR6B8xW48k15CDJMYra8hNxzJf
 VTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774518554; x=1775123354;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J396XDsZeUT91u9zAv44pZdLCvSwnUx+OeGSs3K93aM=;
 b=UaYf3+om6mnAE0YVOdQ7xlhFoxTX7nt+iP5FHXU6wa/sc9uL/72013Db7a4bNE30b0
 HJkwgk3oStTIwTxyCrJudmE0V4J0P9+tl0GfMIw+4nzHJBcNySEweH7r96v//5c4I6/M
 mhMoNZWHD8wDnrvWRNTtrdwlNK/YaCxwMSNw4vxLzn1oliqXvJLIDDXwzq66ieKxXB43
 VjfRpxSR77CeXRgnztJtM4wiCgirHjtSW+MgDMGVbiJpYojFqyTHzQLZ/jnmB5H3Tqbm
 ruchux01OeimrO1jsvCEB4NEq33mSZ36508Tns8Mz7fWDa3JbasbGnWtR5VxHd+dir7T
 TWQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxdRUOB67sRzz67lptSWy6/SqDtBxXxpZePgaBkcZTyUnxjBJcXuzxQv6wdaIJqXzs3Hj035o=@lists.denx.de
X-Gm-Message-State: AOJu0YwdSdfWLfqqrO9tEhMsWk1dKTXyFyTzghKQFDQnDkjtA09SelGD
 OqHml5lc2S9nU3WZyM2McJJP3tYF5twuSLJjoG8gFIXUp4qklNLdmyNGgOHAOnVV1oQ=
X-Gm-Gg: ATEYQzwI2plWdbAgXm0AS+o1+i+faLY0QQ4uMSdwxlQBWjeuaxRAeKBFz5UEZngAj42
 WYn7g6UhzNtnrdMTRUmt/ioavr5hfnsMXo/45yEHNukYZymR3rOD/zOKMq50jfDLqiBS2WCkhKC
 wDjxy3xP7S6o+oyb14cR1alP7ficrg/Rr0p6XBxNfAejYnEvSigWIX0k26RI/fvLP+WvSJAYKn7
 YGVu+XW1VsYeC1BPGVQsvFOUJ0tvASTCft0KfehTO6uNXo2SueWN+p1n2oQOJFBFgbd38raal1N
 K3LQkCGrbZ+1M5BWwIhuKNBeHcgLHU8/6hq3OlCIqabsxy7M6D0Fxf0qJnGpAHUnYSei4q5UIVw
 2DZQ+fe/ao8/fB1h92Ta7Rlw4rkI2f2mQq9y8FOuB+4Yk2BQmFZp78y8+LEIV2tRH2US1+bt8AM
 KELaE8FJWMFrbnLRFRpY44r0a0i0X49MWNGVSWCkfhZi1KkUwVSOJAseApoGwuqRahtd5+IZaCr
 Q==
X-Received: by 2002:a5d:64e7:0:b0:43b:4960:60f2 with SMTP id
 ffacd0b85a97d-43b88a399aemr10026450f8f.47.1774518553764; 
 Thu, 26 Mar 2026 02:49:13 -0700 (PDT)
Received: from [192.168.2.177] (156.85-85-163.dynamic.clientes.euskaltel.es.
 [85.85.163.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2c8sm6606330f8f.20.2026.03.26.02.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 02:49:13 -0700 (PDT)
Message-ID: <35cc32cd-cf2e-4b49-8c62-6af784a951a0@suse.com>
Date: Thu, 26 Mar 2026 10:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: bcm: Include missing errno.h
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260315235816.305016-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260315235816.305016-1-marek.vasut+renesas@mailbox.org>
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



On 16/03/2026 00:58, Marek Vasut wrote:
> The msg.c file uses EIO macro defined in errno.h , include errno.h
> to avoid build failure:
> 
> "
> arch/arm/mach-bcm283x/msg.c: In function 'bcm2835_power_on_module':
> arch/arm/mach-bcm283x/msg.c:73:25: error: 'EIO' undeclared (first use in this function)
>     73 |                 return -EIO;
>        |                         ^~~
> "
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/arm/mach-bcm283x/msg.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> index 4993c0bdb81..05e1a02e80f 100644
> --- a/arch/arm/mach-bcm283x/msg.c
> +++ b/arch/arm/mach-bcm283x/msg.c
> @@ -7,6 +7,7 @@
>   #include <phys2bus.h>
>   #include <asm/arch/mbox.h>
>   #include <linux/delay.h>
> +#include <linux/errno.h>
>   
>   struct msg_set_power_state {
>   	struct bcm2835_mbox_hdr hdr;


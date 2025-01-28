Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFA3C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76ED8197D;
	Tue, 28 Jan 2025 06:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738042847;
	bh=aSgPlhmtz+58EorbkdHxgkXtNUD8+8fIzu6FKSLR4E0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mWha/8AvX9hyeJI2ss2hIUiVEIoMMJxMOTZ60fgSDVzTdhbCQ+RXKqxWzpd1PY4qt
	 CDvSYRaLdt1gfzBIjU1QWV1Pq/8aTnV1Z3QZp7y6xWLucndrJ9jAG2Yb8e7lWLqVGT
	 BcmzEJOBe63rF/zXn+EjB2DukMgCruJy5WWlQVXd0XF89rTLe9/9NTAiYbU8fL0Ygi
	 g1UPWjbgY/B2cZnYecuyzejLhbkNz02cMIiJ6x0Um4XEyMOB5N/H9+5f6lKx5PD3D2
	 VN+LOWtFAV0nOqcAU2fjhcAp5UM8N3j4eKxTJTsFmfMUqguaal8pleZ7lvnnA6AoPM
	 pyjrL7HMkZMcw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0035819B1; Tue, 28 Jan 2025 06:40:46 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D1A81951
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hL8TqPmY"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 26085103802C0; Tue, 28 Jan 2025 06:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738042843; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSgPlhmtz+58EorbkdHxgkXtNUD8+8fIzu6FKSLR4E0=;
 b=hL8TqPmYy41Du93I+KPyKI/U00ClaQEfJbtFsb7Tylbwk53zA+koGUZoo0ll5NwgBKASdN
 ems/UFJ8GckZnNVpzDfh7/FQ13wAJYxGBgxLgdCnmoMxuiEeVvfIZqie7lPmb5vULNGdT7
 BrqQl+nS2SpRaFmqv1URwxQjn6XfRg5BC+0SHqXaZlO5rsMA1Gq+rcn8atw+aeTqlZTpeQ
 KPIFuTu7nIXC+uu+TsMkfqTcnJP0qFN/SUX4+oVAfH0V08aa80972dM4IU0U6H4wfADDaA
 jCmF8tEbNt+pDgLbXjFDub7CdHWFbwwzz5Gd26RXt+uV44wCTtggdQLXiDOxkQ==
Message-ID: <dda85d65-4cf3-5c5d-000d-5582bd13621e@denx.de>
Date: Tue, 28 Jan 2025 06:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] usb: gadget: g_dnl: Fix NULLPTR dereference when
 serial# is unset
Content-Language: en-US
To: Michael Ferolito <michaelsunn101@gmail.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
References: <20250128030945.1219589-1-michaelsunn101@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250128030945.1219589-1-michaelsunn101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Michael,

On 28.01.25 04:09, Michael Ferolito wrote:
> The current behaviour of this function will dereference a null pointer
> if the serial# environment variable is unset. This was discovered on a
> board where U-Boot did not have access to the first 256MB of ram,
> resulting in a board crash.
> In the event that U-Boot has full access to memory, it will still read
> from address 0, which is probably not optimal.
> This simple check is enough to fix it
> 
> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   drivers/usb/gadget/g_dnl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Nitpick:
A changelog would be nice to get an idea what has changed from version
to version ...

> diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
> index 631969b340..f2540eb6de 100644
> --- a/drivers/usb/gadget/g_dnl.c
> +++ b/drivers/usb/gadget/g_dnl.c
> @@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
>   static int on_serialno(const char *name, const char *value, enum env_op op,
>   		int flags)
>   {
> -	g_dnl_set_serialnumber((char *)value);
> +	if (value)
> +		g_dnl_set_serialnumber((char *)value);
>   	return 0;
>   }
>   U_BOOT_ENV_CALLBACK(serialno, on_serialno);
> 

Good catch!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

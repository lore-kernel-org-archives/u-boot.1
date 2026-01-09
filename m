Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC36D1A610
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1C584332;
	Fri,  9 Jan 2026 14:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uHk475xT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28EA84337; Fri,  9 Jan 2026 14:15:18 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56F48432F
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 14:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 773D31A26D9;
 Fri,  9 Jan 2026 13:15:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 42EF3606C6;
 Fri,  9 Jan 2026 13:15:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 51C6A103C88DE; Fri,  9 Jan 2026 14:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1767964505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1o1fdpjkXzkDneFiDJRB+SavKD9VrnOO+ui/Ci1z3o0=;
 b=uHk475xTYPQ0vj6urwIY0u6eDA6NsIKQRx2qCERAaqcxQA0HMBM87NGw3TYwRkuJvZIFwK
 aXSV4zr9H4gIm7JfiOkpDEmDauQsbl5dHL10VXvSj38oVKiLi65ONPLnn+62AHl91g50wa
 vynedfPjiHf1nuquN7T+LtUP8Bouy2HiIQW+PPeb3rs/c4p0PS4hzOE3KVqbvdLl5CbMCa
 aMPdtxN/dGMfG1yqOO1fajkzexHl60Wg71BU9gua/WJSQnFqZYkXW2o1ZWCwp+EC7zyiuF
 cr6YQcFYKxXItRYSLRLBMUKURpcjCQi1p7WGzn1Uhc2qBZBqGuLDSzjcT78JYA==
Message-ID: <a4d590e4-90c0-429a-b8d2-566c1ad1afe0@bootlin.com>
Date: Fri, 9 Jan 2026 14:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] fs: prevent integer overflow in sqfs_concat
To: =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-4-t.preissl@proton.me>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260109112428.262793-4-t.preissl@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,

On 1/9/26 12:24, Timo tp Preißl wrote:
> An integer overflow in length calculation could lead to
> under-allocation and buffer overcopy.
> 
> Signed-off-by: Timo tp Preißl <t.preissl@proton.me>
> ---
>   fs/squashfs/sqfs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 4d3d83b7587..f668c26472e 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -255,10 +255,14 @@ static char *sqfs_concat_tokens(char **token_list, int token_count)
>   {
>   	char *result;
>   	int i, length = 0, offset = 0;
> +	size_t alloc;
>   
>   	length = sqfs_get_tokens_length(token_list, token_count);
>   
> -	result = malloc(length + 1);
> +	if (__builtin_add_overflow(length, 1, &alloc))
> +		return 0;
> +
> +	result = malloc(alloc);
>   	if (!result)
>   		return NULL;
>   

Reviewed-by: João Marcos Costa <joaomarcos.costa@bootlin.com>

Thanks for the fix!
-- 
Best regards,
João Marcos Costa

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89EC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4084783046;
	Mon,  7 Jul 2025 12:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WEqTKtJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0F98304D; Mon,  7 Jul 2025 12:07:51 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F2383018
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso602623f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751882869; x=1752487669; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=21b8qZxjAw7fqY/fUnMZUAJ/s9TgkW6+06fv+i0FsIM=;
 b=WEqTKtJ3kKH5WgxVMyZAbaxnLE6femWkk5Z0M8SC6K6AFc/4jwFrZbAOLw92GsZU7J
 XfcwQRm7W2IECqW++YBNTQkYsx9wHIFyA5kp+MI7SzK+9uvOxN6ArWH/+u46zV2e/Ns0
 PGcAZYCPjYFrDjCldsBhEuGME1JZ4tlK2YpuMQEKUxnoEbDxj0oqD7uNf1a9Tor9YH9D
 n93Z+uFXKdxnQFUKbAxVKu9hy/5nHWVe89wEJpXzYVRI1SeF2r4ldnsEClc6lTlRZcbD
 ag540uQpu6BjyI9H0LhKdWfzzlxG7oD55Q1Evt4zjkX4ZDmiqT7wvl6G9lIEgboZ2Z++
 RZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882869; x=1752487669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21b8qZxjAw7fqY/fUnMZUAJ/s9TgkW6+06fv+i0FsIM=;
 b=ZWK5s6fQdTC+PFXYrsIPLI7fFqb2gQd6aL/07wMZBK91IxMinPs/LF0LKzqyLTcGk2
 c24u1zwQ2eR/jr56jTZOOy8sRamP0pn7GxK1Z1EbBw4X/U1REuuh5IDyqnjH+16jguWU
 h8oY5iRr70mFBmylETZXEuNAQl7ONrcaTzWBKVbg6mT1R2/+uaLrqNSTsAmibV1vBiZ7
 34s8mQ9fAk86wGu4CF3VDnucHcO2hj9+omlO1nzqwyh7Vcql6AWsoOIc2RjANPCPZaUp
 ewvZEqEpIlrJColie99+krwd1yj29KTGKrhYdx1nSU7IixpZogzAlNRf5AssjpYgehhX
 28Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGXBxvykK1Z5RvtXjoANGqaheLy43/hf+tjYQyfyGE35EzlpOboqeb3Jz9wD3m+ayH1Tlqyt0=@lists.denx.de
X-Gm-Message-State: AOJu0YyXFXKQT9wfEmFl6cJOhgzZ1Ka7qr6H2YeYrkg0f1JyIvV/wxlR
 3UOXQilHLvFjrOgjhI4hwNNpQ8qPwK2ToyDLpPCy1bIvlQDDS/wOjxCZmnfQSR+hUw0qb5WAj2e
 7zsP8
X-Gm-Gg: ASbGncuMedxVKSSQQHC6wb+m+QhwZVNNQ2bmjQR18Tqr3Q6gKI1EdKoz0GJFVuL1dQK
 q9OBweffEfoCnkd6Ij9NYiwJJbX94rsfzXkWTJKCwHWv4ZP4yqbESXOjVplh0czxJLvHnlr5s6H
 Y7SDW2XOLk5e/J64muGYxbeBG0eWx5dSAJNPVcUxn3jh5+BNBtgcsHkPpmqAqotyz1Gv0COpafX
 7Q32SywZ3Wdx9syjda1PXIO/YS+obji+aEpn/dmWfA7/5EbVwLeNNG9br4jd0+3Wkuo9UVCj6CX
 jpRkNO81hcgmLu5TZCk+2cPq4l2hQRTTrW9hFywEtOgQjLQRupVvAo7EA6h+RlOctGZRD5qrRGp
 +0dwq9KqAsybe/PmBhZ/9nVRbK0HG/mg6lgwS2fo=
X-Google-Smtp-Source: AGHT+IF+ts5N9ydjBaMBG6OzE9JBXqQTticF+lfYsV8PhRh5+rlkOpPeEJkDvgyWDHTpMURICMBiEA==
X-Received: by 2002:a5d:64cc:0:b0:3a4:fc37:70e4 with SMTP id
 ffacd0b85a97d-3b49aabd1efmr5557273f8f.58.1751882868943; 
 Mon, 07 Jul 2025 03:07:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3?
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e367sm134069575e9.15.2025.07.07.03.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 03:07:48 -0700 (PDT)
Message-ID: <93396c29-c65c-4665-bef0-024fcf264c30@linaro.org>
Date: Mon, 7 Jul 2025 11:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: sandbox: Add support for SYS_64BIT_LBA
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250704214612.3418920-1-trini@konsulko.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250704214612.3418920-1-trini@konsulko.com>
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

On 04/07/2025 22:46, Tom Rini wrote:
> In order to use SYS_64BIT_LBA with this driver we need for "start" to
> also be of type lbaint_t and to then use the correct printf format
> characters.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   drivers/block/sandbox.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
> index 6c74d66037e7..9cb27561a97f 100644
> --- a/drivers/block/sandbox.c
> +++ b/drivers/block/sandbox.c
> @@ -18,7 +18,7 @@
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   static unsigned long host_block_read(struct udevice *dev,
> -				     unsigned long start, lbaint_t blkcnt,
> +				     lbaint_t start, lbaint_t blkcnt,
>   				     void *buffer)
>   {
>   	struct blk_desc *desc = dev_get_uclass_plat(dev);
> @@ -26,7 +26,7 @@ static unsigned long host_block_read(struct udevice *dev,
>   	struct host_sb_plat *plat = dev_get_plat(host_dev);
>   
>   	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) < 0) {
> -		printf("ERROR: Invalid block %lx\n", start);
> +		printf("ERROR: Invalid block " LBAF "\n", start);
>   		return -1;
>   	}
>   	ssize_t len = os_read(plat->fd, buffer, blkcnt * desc->blksz);
> @@ -37,7 +37,7 @@ static unsigned long host_block_read(struct udevice *dev,
>   }
>   
>   static unsigned long host_block_write(struct udevice *dev,
> -				      unsigned long start, lbaint_t blkcnt,
> +				      lbaint_t start, lbaint_t blkcnt,
>   				      const void *buffer)
>   {
>   	struct blk_desc *desc = dev_get_uclass_plat(dev);
> @@ -45,7 +45,7 @@ static unsigned long host_block_write(struct udevice *dev,
>   	struct host_sb_plat *plat = dev_get_plat(host_dev);
>   
>   	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) < 0) {
> -		printf("ERROR: Invalid block %lx\n", start);
> +		printf("ERROR: Invalid block " LBAF "\n", start);
>   		return -1;
>   	}
>   	ssize_t len = os_write(plat->fd, buffer, blkcnt * desc->blksz);

Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>

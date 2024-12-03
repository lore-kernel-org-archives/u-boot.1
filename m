Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44944E64AAF
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD82895C7;
	Tue,  3 Dec 2024 14:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="reHskZw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4ACA8961F; Tue,  3 Dec 2024 14:58:13 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00CA8921A
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0cd8a0e91so4656046a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733234291; x=1733839091; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07OFrUEl6kBRLvuc9bw4h8H9Ws4NWk6SS6qwWjMvbv0=;
 b=reHskZw5H47Ro4Zdxa/ySVCR4trW2Dc7tjGj5vDS4GcXdFj21JUVnuAME7eXLll7WM
 7HO7OWzPOcqcw+YFCEVAJXBDRN7MVS9ogcw41HeoVYOyqYA4YXzN913fq1dAQWIYM1Ba
 zHWie02lQySeGDURFBDcJisa23uGXe6JuR7F+APQFfI6e3NWN7pjlzXdm0ZWblz6xh2J
 fPQpDL8wOzEBB9k9LJZtXHq1naMvhWFFJVA+6URmA7OQsVCnkza7ZqCM+lbUkXBSvR9e
 88DL6wo9hEP0YQCb0EnqA1IANg/PwJIZ/a+wZOgv9Z7FqR6iBaO7DzTCwQfVGUmM3Fay
 qAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234291; x=1733839091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07OFrUEl6kBRLvuc9bw4h8H9Ws4NWk6SS6qwWjMvbv0=;
 b=GXdda8/iFlaekoNTekblbXgSH31yzFugvQfnxumBFu7nF5qqMXhhuYV7GuThoKTism
 ojJCNgBCD2+FQ+Ei7GL4xlM3ZzrzEXj7IZqEpMXmvwYXKbTP08R3wsggAFClLQXBGVNf
 B3OKlq4FYyz84FBdTmKsJUQXaQUvzLdsN6bJU0wsGsWNdQ2AKfXpHGrnXYaXGYtMn6rJ
 yLhKbyUjGT2S3A/wl/ineRTDCqv3UkCDmw9OcvJoBRo81UtzV4rJvdVnPSiQcxtkYPOG
 yLePKpiEXkz1qMFjanAuwOS9gnDh81g2ZIiP8Q36WnLuFRYYfkKCjGqFCJz42n6LOzNf
 WRVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVThxTVzwtcFdNNnt3mMaM6KKs7CPaeOqlhyHUnctwmuhMV0NOXJ7Q+6Vlk0Kt+9slIlkPrqNo=@lists.denx.de
X-Gm-Message-State: AOJu0YyO/Mtr8P3CRhHar9WHNdmP+IM4AO9v/FZVjgi5ztfNW8ga2Te5
 xjJllFetcVMlLjJfgvkBqsx4arBXeqzSb6NW+AOJoEaEWlB8bKcNw8hSPlkhaJg=
X-Gm-Gg: ASbGncvZYWJTD3+YroCbbdmlgyiamldAfZTW/WambqZRy6MfdxuElOkhxoL3PZ9urcV
 1uUOFhktsBVnfTWUYSt6b6LKDYuBxktb+2j0EYyHcEmuEs8e+wqFLFwtFr1k4shNTuwff4sxnYN
 b8eFLHQcMiQ5Gy/l1FvdH1Mo4gtewzYY4OW1MJIzZz4rODOj1hHGEhHxJ+yFoMs56XwMTQ+mvS3
 qjEE1ZMXYFvbPU1ehF749kROa0yImnbpXZ1iSNQvhWQKbRoOw1T/LzEc1Zk5A==
X-Google-Smtp-Source: AGHT+IF2+ow4Iejw7g+6yPRanJLk5tiOs/GWcLH7QseVo+Qkhm8FzoxI6FNprEpmW7lgxmxfqNp+GQ==
X-Received: by 2002:a05:6402:13d3:b0:5d0:e410:468b with SMTP id
 4fb4d7f45d1cf-5d10cb4d22amr2473343a12.2.1733234291025; 
 Tue, 03 Dec 2024 05:58:11 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d1100a198asm384257a12.65.2024.12.03.05.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 05:58:10 -0800 (PST)
Message-ID: <597fb901-fb91-43cc-a871-cedd0a238583@linaro.org>
Date: Tue, 3 Dec 2024 14:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lwip: wget: pass port and server_name via wget_ctx
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com
References: <20241203125534.1582903-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241203125534.1582903-1-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 12/3/24 13:55, Adriano Cordova wrote:
>   Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
>   correctly rebased on top of the changes introduced by Commit 6cc4d04
>   ("net/lwip: wget: put server_name and port into wget_ctx") in next.
>   This commit re-applies a  couple of lines from 6cc4d04.
> 
>   Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> Changes in v3: there was still another server_name to be replaced by ctx.server_name
> Changes in v2: changed commit name
>  net/lwip/wget.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index af48d741a4..3d02f26c09 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
> -	char server_name[SERVER_NAME_SIZE];
>  #if defined CONFIG_WGET_HTTPS
>  	altcp_allocator_t tls_allocator;
>  #endif
> @@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  	struct netif *netif;
>  	struct wget_ctx ctx;
>  	char *path;
> -	u16 port;
>  	bool is_https;
>  
>  	ctx.daddr = dst_addr;
> @@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  	ctx.prevsize = 0;
>  	ctx.start_time = 0;
>  
> -	if (parse_url(uri, server_name, &port, &path, &is_https))
> +	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>  		return CMD_RET_USAGE;
>  
>  	netif = net_lwip_new_netif(udev);
> @@ -319,7 +317,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  	if (is_https) {
>  		tls_allocator.alloc = &altcp_tls_alloc;
>  		tls_allocator.arg =
> -			altcp_tls_create_config_client(NULL, 0, server_name);
> +			altcp_tls_create_config_client(NULL, 0, ctx.server_name);
>  
>  		if (!tls_allocator.arg) {
>  			log_err("error: Cannot create a TLS connection\n");

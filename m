Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E7AD43349
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3F889251;
	Thu,  7 Nov 2024 12:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U0udz4J+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BC089253; Thu,  7 Nov 2024 12:21:28 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB50689266
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so6849425e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978485; x=1731583285; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SOD5MMy88K0gEs9f1TcrlL+l+Dv2B5Z2dU4f0FPc6aE=;
 b=U0udz4J+pK8lv3pQFrAP0S5n7zHHv9OBa/RI2kSz7j8H3ben+f0hIQZ8+H0Hes6tbw
 atfdkz1FqzHKhQcM03+p/Ip/CqemyXAuXVy6MTSIYFNEke1/lXSeEIH3x8G9WfTzzv6M
 lP0/j15Q5CniPdSimr98Ccszc6AEVJc9ounJMIWDfjrXdF9nYr7LFhHLenwaUr7srkxk
 h8NZ6khd4+fNoXpUe3UAXcdUUDF9RGvVjPowQ2S0XV+E05LKycRQIXdp6eU3vV8WW9JY
 4E6LGZrXWco7E2SaR0/KOidZUaJGxYl/Q90Y2Iqd1M+jV9jnoxZKefDTNG1i5K0lK/oe
 VJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978485; x=1731583285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SOD5MMy88K0gEs9f1TcrlL+l+Dv2B5Z2dU4f0FPc6aE=;
 b=f4lF0hstTNP+gjrIwOErnfZc0hDNpGaO5eWf4l3JpqaMwl1JDhZW0XPaa2vxI2cTqP
 qyXWNKd1Vv1PWw/uKaD0pemC2ILLwoyVkqj42PY4io53EWanMqUgtL6j8VpqcNALI8mk
 gf4/ZzGg3UIlej0x5qkL8WU/OvNO9MSPX9b1NBHF4RLb2C+7Wh+99/LX6zKaChOg5T54
 N0AprDAWNoEt1niWYbNMUavVmYq6VkR6EvBc3xDA8txYy6ffCBBFEGGUECL9Q/Y2RAiM
 GQ+iyOHTWIJ5fK8foTXMG3lUNWCTEKd4CiQZzM0Z+C5AOj+QvA+SdRAExjU5Sn1Qn7kj
 Zn2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXR5XsFbfXPmD70Jo8khxu3sNP8h3k+Vf9imdH6IBjg0izHnwCMx5AVzD1EqGgpIjXW20M5QU=@lists.denx.de
X-Gm-Message-State: AOJu0YwzFdM9Wa1EGGlWZMS1Do5fy2RzhrVLhqC3aBI2r/Fqe2+2TPXW
 HaFrOFH5wJ0ggXW5fbD5c5usvNfoCFKGUMq+83upwvNIjqE6pJbJY/4JH9rUC16j1lE0Nn9cEjn
 Th5lg/w==
X-Google-Smtp-Source: AGHT+IH1VdvDyM+0j4HoEiXzUYjeNvEWIekj1gi2QEz3d8o28nIFttGUg4E6DL8ZEGlL47jpe8ZEhg==
X-Received: by 2002:a05:600c:34cb:b0:42f:8287:c24d with SMTP id
 5b1f17b1804b1-432b3086a2bmr8178965e9.21.1730978485268; 
 Thu, 07 Nov 2024 03:21:25 -0800 (PST)
Received: from [172.16.25.132] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa73886bsm56987865e9.39.2024.11.07.03.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:21:25 -0800 (PST)
Message-ID: <3aa5b358-37d6-48b7-ab10-176bdee1e05b@linaro.org>
Date: Thu, 7 Nov 2024 11:21:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] net/lwip: wget: put server_name and port into wget_ctx
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de
References: <20241106130428.211190-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241106130428.211190-1-adrianox@gmail.com>
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

On 11/6/24 13:04, Adriano Cordova wrote:
> Currently server_name and port are local variables in wget_loop.
> This commit puts them inside ctx, so that they are accessible
> from the http callbacks.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/lwip/wget.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b495ebd1aa..4add520045 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -23,6 +23,8 @@ enum done_state {
>  };
>  
>  struct wget_ctx {
> +	char server_name[SERVER_NAME_SIZE];
> +	u16 port;
>  	char *path;
>  	ulong daddr;
>  	ulong saved_daddr;
> @@ -209,13 +211,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
> -	char server_name[SERVER_NAME_SIZE];
>  	httpc_connection_t conn;
>  	httpc_state_t *state;
>  	struct netif *netif;
>  	struct wget_ctx ctx;
>  	char *path;
> -	u16 port;
>  
>  	ctx.daddr = dst_addr;
>  	ctx.saved_daddr = dst_addr;
> @@ -224,7 +224,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  	ctx.prevsize = 0;
>  	ctx.start_time = 0;
>  
> -	if (parse_url(uri, server_name, &port, &path))
> +	if (parse_url(uri, ctx.server_name, &ctx.port, &path))
>  		return CMD_RET_USAGE;
>  
>  	netif = net_lwip_new_netif(udev);
> @@ -234,7 +234,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  	memset(&conn, 0, sizeof(conn));
>  	conn.result_fn = httpc_result_cb;
>  	ctx.path = path;
> -	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> +	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
>  			       &ctx, &state)) {
>  		net_lwip_remove_netif(netif);
>  		return CMD_RET_FAILURE;

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

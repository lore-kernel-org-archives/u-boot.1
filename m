Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02503D43349
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6D689275;
	Thu,  7 Nov 2024 12:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YCNBwCvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F83D89270; Thu,  7 Nov 2024 12:21:33 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F9689259
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f72c913aso1327332e87.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978491; x=1731583291; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RQPE+zGT4WxgpPy6KpmEgwoFCSbOpXh3JJclLSvNfKA=;
 b=YCNBwCvrJnmT/BOxQ0mj3kzj2t+bYF8WlfXjSJjrwgJVlO52ovO2gHT3yoTZSn5z3y
 /rfHLi2eYodXTLDhBbqzZVahSshM9RXo1H+lzUHgXuBWoUulkRfoMOwHAk0us6w//EaS
 xYCviEFhoEc3x23KNz1e+jH1bVRZbbFywsxbSXr1DqnwqHBWXXq/S5sIiE2JRG+KaLHr
 yHOBgiQ/ka0w8Bd5MNrbX5I5ZThg8xaSpkKupyPi9a8OpCCw6EsG6931+dYVn6VNeC4j
 L0f9VAmLqcot/3eFKoOtigzq0fSYcagmaSH+SA3htnghCkydixLKEbNUTUFbglnjzSi1
 jIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978491; x=1731583291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQPE+zGT4WxgpPy6KpmEgwoFCSbOpXh3JJclLSvNfKA=;
 b=TOlS0pW6yBNOMoDyZbqZ7wDYlaR+CArDbNXTdF39dO5uxwvz6AFe/v98StVKOOYJe8
 Gv9sK3LNvNaa6LJUDszUf9clvMBchu0Y28FBlIh2Y4lW1I2XFpi8Qb3UHojROs3NMBuf
 vWI0Ut3sGx1AHhaOzLpaIRBpt2BjiSHXTderxSKJznwTQmtkJ6g2ktYrsoe4nLK779+u
 wOeZG5wSatiqDF903HQ+fF55Zi/2AcffbYaPaSnbcGfEDSmY2VSKZveqXxzr2AlE5CF5
 +eRT671QtdAjBqA0qJimWVudsf435o+LbvgUhIryxcjy3SNxa0pcL5oroz3is4xZLMBb
 oaKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJFlBtL6bViBKXYTgBrqtuh5yG4THKSAoPuMAWft5qCRPCzrks/kenaPwt0j9MVAfJeGDXnV4=@lists.denx.de
X-Gm-Message-State: AOJu0YxMxgfKX5xAzZRXplUcNJwtPwgTQyBkzWUT93PFWclDv5cVEmwh
 5P8culsNTSoPx2Ly/1OOBqSXEplAhTq1+ymdkLZMjCNzo2Iaa/T8ZozVKjyF9pE=
X-Google-Smtp-Source: AGHT+IGTODCXlWjQfBkn1090sM3c7jrmebrnz61kJdnyTN5jDjLWKGx19W5Fd6YNEIowJXWI3GUHfQ==
X-Received: by 2002:a05:6512:3b0f:b0:539:fc42:e5ee with SMTP id
 2adb3069b0e04-53b348e3390mr21859053e87.29.1730978490541; 
 Thu, 07 Nov 2024 03:21:30 -0800 (PST)
Received: from [172.16.25.132] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa73886bsm56987865e9.39.2024.11.07.03.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:21:30 -0800 (PST)
Message-ID: <eb1e5c49-3a2d-4ac5-abae-71cf82b90823@linaro.org>
Date: Thu, 7 Nov 2024 11:21:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] net/lwip: wget: integrate struct wget_info into wget
 code
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de
References: <20241106130446.211222-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241106130446.211222-1-adrianox@gmail.com>
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
> Each wget request now fills the struct wget_info. Also, the
> efi bootdevice is now set conditionally to the set_bootdevice
> variable in wget_info and a buffer size check is performed if
> check_buffer_size is set.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/lwip/wget.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 4add520045..bc0ecfe5b7 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -34,6 +34,19 @@ struct wget_ctx {
>  	enum done_state done;
>  };
>  
> +static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len,
> +				struct wget_http_info *info, u32_t hdr_cont_len)
> +{
> +	if (info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
> +		pbuf_copy_partial(hdr, (void *)info->headers, hdr_len, 0);
> +	info->hdr_cont_len = (u32)hdr_cont_len;
> +}
> +
> +static void wget_lwip_set_file_size(u32_t rx_content_len, struct wget_http_info *info)
> +{
> +	info->file_size = (ulong)rx_content_len;
> +}
> +
>  static int parse_url(char *url, char *host, u16 *port, char **path)
>  {
>  	char *p, *pp;
> @@ -178,6 +191,13 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  	struct wget_ctx *ctx = arg;
>  	ulong elapsed;
>  
> +	wget_info.status_code = (ulong)srv_res;
> +
> +	if (err == ERR_BUF) {
> +		ctx->done = FAILURE;
> +		return;
> +	}
> +
>  	if (httpc_result != HTTPC_RESULT_OK) {
>  		log_err("\nHTTP client error %d\n", httpc_result);
>  		ctx->done = FAILURE;
> @@ -197,8 +217,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
>  	print_size(rx_content_len / elapsed * 1000, "/s)\n");
>  	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
> -	efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
> -			rx_content_len);
> +	if (wget_info.set_bootdev) {
> +		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
> +				rx_content_len);
> +	}
> +	wget_lwip_set_file_size(rx_content_len, &wget_info);
>  	if (env_set_hex("filesize", rx_content_len) ||
>  	    env_set_hex("fileaddr", ctx->saved_daddr)) {
>  		log_err("Could not set filesize or fileaddr\n");
> @@ -209,6 +232,17 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  	ctx->done = SUCCESS;
>  }
>  
> +static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
> +				   u16_t hdr_len, u32_t content_len)
> +{
> +	wget_lwip_fill_info(hdr, hdr_len, &wget_info, content_len);
> +
> +	if (wget_info.check_buffer_size && (ulong)content_len > wget_info.buffer_size)
> +		return ERR_BUF;
> +
> +	return ERR_OK;
> +}
> +
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
>  	httpc_connection_t conn;
> @@ -233,6 +267,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  
>  	memset(&conn, 0, sizeof(conn));
>  	conn.result_fn = httpc_result_cb;
> +	conn.headers_done_fn = httpc_headers_done_cb;
>  	ctx.path = path;
>  	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_recv_cb,
>  			       &ctx, &state)) {

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

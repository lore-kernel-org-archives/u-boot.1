Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8387DD43349
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED1489247;
	Thu,  7 Nov 2024 12:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hn1nhFda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DF188FF6; Thu,  7 Nov 2024 12:21:06 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847918924F
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f84907caso763512e87.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978462; x=1731583262; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+2NOUO8hPTG1GUTfJ6ZDLNq1r5uiV9m+8gcvilYKPM=;
 b=hn1nhFdaTwIKgghBKJv/Eom+NPXrJT7MDshDmOjZv3caoEH7OzrBM+YZbdhokx3DhF
 s1dcc2912Y41W00nYSRF2x3U11vT0YheX27JLFNhatw6I1ZiGv9iL/39DyhAxW8w9oTW
 uPBpHshSB9C1S3NiqfXeMxLpQnDuSqNqVC7ZeAN6JedArfXfJaF95HfozLtGESzDWicZ
 AI6WjbWJFfH2W0NizRn2pGvKYypYWvVR2/onTFw+JZ2JJ03tEMqdyRgBupRVsmNyNASC
 w5BUagjjE5Lq7u8iDQ+Y9ydqrelIgFSI1qhT2ClTbqgsKr8tz86PECaB3PfCIssQ+zFM
 Q9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978462; x=1731583262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+2NOUO8hPTG1GUTfJ6ZDLNq1r5uiV9m+8gcvilYKPM=;
 b=kNakWfi5HhvuoYuVxYNJi/GXlwn2o3HE2XAPzlBpv53HY681ibl1v+0cVMUquFU1UZ
 rDF/QbAeQBVrpR3NzJjVfyUL2YHwUPBXk9f0ZCQuJvsfromRMcwfPHavR7TzdobFvV/r
 pafWkIOhTkmuDGSyjssZtOTi6xRsCeC32/mg5AAkdWGty+2gM7xDGKaRVuvBDcwsolDi
 zIVUKLdKAomK1gKsNlst9G04v6kwi/TKoECb2zGfdZyx4Wl40cCInEoMxrfJFN6QV4W2
 OmpEhlOgORyksjM5RDkdA66jVj+WQF+vlNvwVJhYls8hb4wkwKtp8HwnA2STy2iSz4HS
 aAJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9tw4i9RIvwMbW91045VRrnsQ79WYV0lKNU3xZ5lvVzHD8N6Y9+X6pJxnKsAz0cwZ6IWgF5FM=@lists.denx.de
X-Gm-Message-State: AOJu0YxZLgltVpBoxsUEH/5de6oKaGRVXdwzuBq/CxF+DmtXBB7QVOkZ
 UppMtopYRfHY+3JyJzY5FgwuD+mEJyECZbLCu0MxX6lx8LRVloeAQj/YkhHJ8F+IWaxsEs4NoIT
 58AZGaA==
X-Google-Smtp-Source: AGHT+IHnyyBCuLemr+eYsSV/Wwc9hmAYYHwP4gKHeeAdnXPSfOUbvcoxr/L/3g1QltNOi6sNDVsguw==
X-Received: by 2002:a05:6512:3a88:b0:533:46cc:a71e with SMTP id
 2adb3069b0e04-53b34c8dde4mr21047228e87.54.1730978461763; 
 Thu, 07 Nov 2024 03:21:01 -0800 (PST)
Received: from [172.16.25.132] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e6042sm20308645e9.44.2024.11.07.03.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:21:01 -0800 (PST)
Message-ID: <72eb2769-b409-47bd-8a06-d4e180096fb7@linaro.org>
Date: Thu, 7 Nov 2024 11:21:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] net: wget: add definition of struct wget_http_info
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de
References: <20241106130318.211072-1-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241106130318.211072-1-adrianox@gmail.com>
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

On 11/6/24 13:03, Adriano Cordova wrote:
> The struct wget_http_info exposes the HTTP information of the last HTTP
> request issued by wget, and it controls whether the efi bootdevice is set,
> and whether the buffer size needs to be checked (lwip stack only). This
> information is otherwise discarded. The wget_http_info struct can be used
> by HTTP drivers to have more control over HTTP requests.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  include/net-common.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/net-common.h b/include/net-common.h
> index fd7c5e7b48..38ba95cf60 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -8,6 +8,7 @@
>  #include <env.h>
>  #include <hexdump.h>
>  #include <linux/if_ether.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <rand.h>
>  #include <time.h>
> @@ -506,4 +507,30 @@ int wget_with_dns(ulong dst_addr, char *uri);
>  bool wget_validate_uri(char *uri);
>  //int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>  
> +enum wget_http_method {
> +	WGET_HTTP_METHOD_GET,
> +	WGET_HTTP_METHOD_POST,
> +	WGET_HTTP_METHOD_PATCH,
> +	WGET_HTTP_METHOD_OPTIONS,
> +	WGET_HTTP_METHOD_CONNECT,
> +	WGET_HTTP_METHOD_HEAD,
> +	WGET_HTTP_METHOD_PUT,
> +	WGET_HTTP_METHOD_DELETE,
> +	WGET_HTTP_METHOD_TRACE,
> +	WGET_HTTP_METHOD_MAX
> +};
> +
> +#define MAX_HTTP_HEADERS_SIZE SZ_64K
> +
> +struct wget_http_info {
> +	enum wget_http_method method;
> +	ulong status_code;
> +	ulong file_size;
> +	ulong buffer_size;
> +	bool set_bootdev;
> +	bool check_buffer_size;
> +	u32 hdr_cont_len;
> +	char *headers;
> +};
> +
>  #endif /* __NET_COMMON_H__ */

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

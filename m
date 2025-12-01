Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552C6D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 15:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBC983B64;
	Mon,  1 Dec 2025 16:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jpT8GY4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D109783B7E; Mon,  1 Dec 2025 16:27:27 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5B883B4A
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 16:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so29737395e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764602844; x=1765207644; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CxPZCPKmUzv/MECzGExRaSJlohK0/6JQwZwIyLtRzTE=;
 b=jpT8GY4B/kanOlZE2JMDCFeI8z9ZyY0XvI7h0r3/APnqb6yfxEmNG3WV1/5xccX/Ut
 4WwVIQGlw6wvrIk4FvGhcVn6g87xXPXMYXXtIiaQVAON01sedmoMXc3ZwdcTzPzYgE/F
 iC7MGmpYfaC+leqiW963r64npIpBH2yHxe2Uuuy8pnk2lBCYrLgGVPYbUQi1yhDZ2XIc
 I8WsFcjthccta7CMC/GQVczAJb+cljnu8t1PzT8ejZ1OO+DuH+jdBRW45HtAwLJnTxqc
 0QKTfbbhxUGP45/foqmtBOrLn8lFLhJg0arBx4cXq7Na71hPWRsqUOMQJ81WgzYJafgy
 BStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764602844; x=1765207644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CxPZCPKmUzv/MECzGExRaSJlohK0/6JQwZwIyLtRzTE=;
 b=rP4BbTxlS13WYv4eARDo7d3Mi6qAc+3YU8xaYug7GnpsDiyx59Atd7DSikg0CSGgyh
 qSTfh0OrpAbx2ZmOhvGCyioH8hQpduvQmGYP+jwTrv47aEMFqyIel231PaCnCHU/sfzH
 Ik5JR4XLCW7kZNr4rnBJjRMiquOyWv6tQ0kP4BNj9Wdfrw3wzprpGH5txve5UhUmmLsm
 7vEUk6J4kCFxdw3S2kmeaYBqBtL68m0fKcU5TuRCEQa8E3rtpXB79m2N/nUvhH555bqR
 7h/Pbyk46NRjB2NjVvniw3roDmuORtE2xi0viyeABtWQ0dGxq8O66XpXHTNKRCIl2bKV
 2QUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL7UGuUglPnfXJrga7j+Xit5v9UrfBuXNtuZO9j0hWv6/mH5HGl1l/WwRTTwGu4tI7eoauI70=@lists.denx.de
X-Gm-Message-State: AOJu0Yzda5AHxaVs9dw0EYF0UO9XXImJwi9Y7F5ZXNLF98qL1ezRZZs2
 GUmJz3mI2YWumtK0GSGy5LRI2j+GWGmYBI4noLTCUTtJg8K+FhIfTNm4zLW5wh0dcoA=
X-Gm-Gg: ASbGncvt5FSWSlZ+wk0lUNnMdfih7I/LRU4M9sIqKnjaMG6oFhghFY4bScTKFwVu9wz
 kPenwxEi7PlKNPSljICodmPAFLDJL4hO98Gc9lizVd6COZhgJer3SQecgBWVoISdgdsYoKpT7Tc
 1FMxBF3hDf5s0w9tRoqZ/m5E57cj4fitZm7jiohrRbb7EY2TQCl94y+Ce/GLECmPIEcH/Jz3qn/
 4UZtspmrjUOcTU4wh3e4XfjnB1NLm0VzFVBIxfzl+FpS4AOsq7Gldb+Ugy+gmEuPUCgH47CcVbD
 Eg0IZ2+UUfJrTCjWScuPMcYvYlXCC2fGUU6VdQh7cYXiXH3uINiT/erhr1L9tK6UE46JC0wTKbz
 bmcu597bY7zn3B36SXI0CmJtjkqNqy/QGJaAdl1zRGjoGPPZsJdCpk9zSC7w9fsa5C+fFG2+tJ1
 9Ta7hp60yPZe7DWeIXAdM2EqIRdizwrNmF6IBGpnP3mQeojhxwmCCNw4/94kU23ygXvQ==
X-Google-Smtp-Source: AGHT+IFdqv+HZKSIX8QT4l/MsFzhaf3luvNQtTqNpiPHyqAxAZzsAIIizvVlRQZLbtltFx9GLGzZuQ==
X-Received: by 2002:a05:600c:63d1:b0:479:1348:c61e with SMTP id
 5b1f17b1804b1-4791348c721mr117908895e9.20.1764602843952; 
 Mon, 01 Dec 2025 07:27:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72ad:24ac:eba1:9535?
 ([2a01:e0a:3cb:7bb0:72ad:24ac:eba1:9535])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3041sm25497563f8f.6.2025.12.01.07.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 07:27:23 -0800 (PST)
Message-ID: <4ba063e7-da9c-4957-85cb-0674a777ad2b@linaro.org>
Date: Mon, 1 Dec 2025 16:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: lwip/wget: avoid NULL dereference in
 _set_cacert()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Walle <mwalle@kernel.org>, u-boot@lists.denx.de
References: <20251201151724.338924-1-zfsdt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251201151724.338924-1-zfsdt@canonical.com>
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

Hi Heinrich,

On 12/1/25 16:17, Heinrich Schuchardt wrote:
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Running `wget cacert builtin` leads to a crash in _set_cacert():
> 
>     Unhandled exception: Load access fault
> 
> Function _set_cacert() dereferences variable wget_info.
> We must initialize it before executing the cacert sub-command.
> 
> Fixes: d3761a31ef09 ("lwip: split net/lwip/wget.c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/lwip/wget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
> index fc9bc11cd83..4883ad61bce 100644
> --- a/cmd/lwip/wget.c
> +++ b/cmd/lwip/wget.c
> @@ -180,6 +180,8 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>  	ulong dst_addr;
>  	char nurl[1024];
>  
> +	wget_info = &default_wget_info;
> +
>  #if CONFIG_IS_ENABLED(WGET_CACERT)
>  	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
>  		return set_cacert(argv[2], argv[3]);
> @@ -214,7 +216,6 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>  	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
>  		return CMD_RET_FAILURE;
>  
> -	wget_info = &default_wget_info;
>  	if (wget_do_request(dst_addr, nurl))
>  		return CMD_RET_FAILURE;
>  

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

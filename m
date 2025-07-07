Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC63C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163C2830CA;
	Mon,  7 Jul 2025 15:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e9ZFEqjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E958313B; Mon,  7 Jul 2025 15:41:07 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A968E8305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453643020bdso24046065e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751895664; x=1752500464; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=44Ge/hcBIRX/mrU5kUEwCCnuEYNuTSNf59a85qkgaEM=;
 b=e9ZFEqjOjYlkXo2299VDKjA/4z+Tbq6caLrWr4Yrpswd/tekRyIqvqUtfq5IlINz1z
 naPerW5AA3MRThUMAKACitkP6jdbx68h+wxPxGI6oAb66GLNJdQxfPxf4n98CHUSt1DX
 HEivSjVLm3w2zjA9pb6QAyIJSqy10xLjKLfsNoIgCFwpjdZLxCRCkNTyC+KfhzNNRB4I
 fU9m2YafKoUsPl190jKTpOc3zfcKGM75QkPlfc62V0N99pAs83dhiD4BzqBio47tRH25
 T4Tv4E/TTtaSlOjFb4mNgI/8NeFDG5jeG+70TQOYgIZBpc8yeqcnecZWQPvbcUMrZGR9
 W5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751895664; x=1752500464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44Ge/hcBIRX/mrU5kUEwCCnuEYNuTSNf59a85qkgaEM=;
 b=NE0RiqbuKU7ckM0eFSWTPEypMSrbUpW69TvYRohVxC7bH0YO/mHQc0eoIzDUP2bOOA
 hc0kW9HkXxWiHIrPB7n1f2sIySkFM8wrRUYIbmrWSUN+MyBb4ThLBgk8oGDbTmGxw9Hh
 FFc1jrKeqJHst8kMHQNQLRyJDBuNWv57fG3+0UKe3BjsFiy4Uix2xCwi1hBoyHpSDEJX
 /9czVKBQvz2DofVY0zCM/Qlt0c1/JJULu+rvlvLH5pfxOz39F+QHWckRJ6O2aOWiiH+t
 V7p0TDZ56OGUBpJFolaiUfzGlDXkjnrD4SKriocauSMehTzibkNDa6FCv7vRGJ4K4wRe
 5FYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsJxy/SyPqcrnhsbPV5EX2f9vWq9gJHmyk8LFtEqKwZlZ8ziLie+fcdYf4K6ZPhK722wq0p1c=@lists.denx.de
X-Gm-Message-State: AOJu0YwOMJ25/6xho2LoCVesZrOCTXRcAYqnlzB9Ae/x+gg4czSBtSB8
 XZAlEaZmHGaCc1BZSsKURdq0DB/b7kJMfipuaxuywzcdQSyfzbpyWAOm94ofgZz/mPs=
X-Gm-Gg: ASbGncuoiGtyk14MS7X4qawQmZhmvBhI4zZMvT6DbfdVNYi8ngNknZUTikF85qDOTh1
 7VM4+ilHOqgUoFsiD1Ycxyg9Vv/683efv6hpavJyZVm3bixEnTH66Jd2QGlbguNxfZk2XQXk8SM
 niBB6hwXBNMu/HGndE3BeIZQgoyCbfxpq1s7AyIhuehctHHVz0dFEThz9bBMV97PzyySiw7lwGH
 FJFf6fZ36n4C2aYVCZwsrweEXd9VUf/OcaOnXc+62/wv96DXNTWtbYKDnYFQOEVylV7ufXBJAq8
 JPNnO4Bjf/oMhKkj3nZBqpjlrN+7c6mgvP2fgbIN8S7/K8Ehl2iRvMYLlN8Df8CPIt5W9owBcJ+
 KZFNyeQCOW4ykM75afEBjmFhPCCA/1izsBkxlcgg=
X-Google-Smtp-Source: AGHT+IEyj3NfP7ARxa6pKeXbiItaDf7nGgMWkKBG6mJyLQXjnwJeM5MbH8Z1g6qr9cSV240JbdSerA==
X-Received: by 2002:a05:600c:1f94:b0:454:aba2:c332 with SMTP id
 5b1f17b1804b1-454bb82de10mr76351155e9.29.1751895664091; 
 Mon, 07 Jul 2025 06:41:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3?
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b161e8f1sm113469215e9.8.2025.07.07.06.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 06:41:03 -0700 (PDT)
Message-ID: <18f71373-49b2-4197-9051-0eeb8c7fd6aa@linaro.org>
Date: Mon, 7 Jul 2025 14:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] serial-uclass: fix typo in comment
To: Philip Molloy <philip@philipmolloy.com>, u-boot@lists.denx.de
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
 <20250707150438.3016690-3-philip@philipmolloy.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250707150438.3016690-3-philip@philipmolloy.com>
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

On 07/07/2025 14:06, Philip Molloy wrote:
> From: Philip Molloy <philip.molloy@analog.com>
> 
> Signed-off-by: Philip Molloy <philip.molloy@analog.com>
> ---
>   drivers/serial/serial-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
> index a08678dde4e..32108c381a4 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -109,7 +109,7 @@ static void serial_find_console_or_panic(void)
>   		 * from 1!).
>   		 *
>   		 * Failing that, get the device with sequence number 0, or in
> -		 * extremis just the first working serial device we can find.

That is not a typo. [1]

> +		 * extremes just the first working serial device we can find.

This would be poorer grammar.

>   		 * But we insist on having a console (even if it is silent).
>   		 */
>   #ifdef CONFIG_CONS_INDEX


Andrew

1) https://dictionary.cambridge.org/dictionary/english/in-extremis

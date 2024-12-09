Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE7E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 14:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF3789748;
	Mon,  9 Dec 2024 15:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l45Awgo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB658975D; Mon,  9 Dec 2024 15:58:14 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6823889634
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 15:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso2753976a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733756292; x=1734361092; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fy3rQPobaHVSkEacmzn37jDDpiaEXOR/5Evf6MBWe+8=;
 b=l45Awgo6GXBIjIcGYMxz1R4Svtmuf/96c5yAhuRzxZgBGYOIOT/eIv2njZlGq4+PTH
 YRnHSEFhbrjNwY8xFPIKemwBUBxeTn/L88QgUzquWkj5w2DUEVWwYDpZGrQgAPYXnNBQ
 vI9LPb/E65/XxTW3ehMLPrGFuUxk4qoA1mpYqf0Bnhb/8khTD+7oIa1q06wpZYbp91QS
 ayoMzrA0UGTKYEVzDaQRVfUxybLyMOwVdUHd2M+85L74brc69UNCMn/ELILQXhsrkrAB
 CnIqGOJCSDt5L6DBJ5Iznne2D7NqgqpR6Z4Ix7qePknrFbaiD0qnI1vNEBZeIKeomVsS
 efpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756292; x=1734361092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fy3rQPobaHVSkEacmzn37jDDpiaEXOR/5Evf6MBWe+8=;
 b=WHa9R7l9dsP0KqO2K/9tOEKgNPGLfrpbTNEMIYR8COzUYWQuYzeCRU7P+UQ/O/XalO
 iOJrSYqnpg+Z06vBUOVbXwHLE6O0ZVb3tWJ3xuwV+YB79yruSr4mick53BT29HGzQe3T
 32pywiCxJxGlewWA8hIOb3Jijtluo/OIa+q70RX1K52861BvfRVKyCy4UtqGNR/cNZ1Z
 uOEfiPUpM/URWLgUppIxct9CjEfrg9tmgSAuEoLX3E2dvSWUts/E1GGSQbjvBW4o7DRy
 +aSAmPgK3PpOiU1JpUMZ4K9/vLHy2FkGtBcFxRXhzFXBPPpn4qaEFoJLsD1LXqlFb5L3
 yXbg==
X-Gm-Message-State: AOJu0YypM4TqM2lCtObf/TZKHpYnzv9NzvdV8TAE0c2EzDy3wT8HfOXs
 mIzYCzmsQkfSekJwjSepkOWpPDduhOEHA8D2hwdUBeE+jt5iF4rGn2le/zOw0F1EW0m3INlI/PB
 YOig=
X-Gm-Gg: ASbGncvIsJomOJe6U/etHRXeL87PJ43Hy2NF6BJRoN99uCYuc1eeHF3VNfcoa9huBAm
 RSrCLhlnxWBvctBnkyuBqRtX4FurQUJMXMcgDsVC8OTNjUhCqHLESPQ4LHzm+5644HoFdiSPJ9M
 y615YQUiRbBYQyyGLk3p11jw2Lhhp7M0gNruAl7p8kYAXo6dxTtRXYGlWuFZjCtoSgk8t0p9ofu
 8ayi5lC68TZ8VCp8LmvzxAqTpVP08GUKF62VCXUax3w481zF9btoDQhHia+5qR7r1/aenBpZ+HG
 vRJqQ7NhrUeH2h4TmHg1GWA/tT3n/ZRt
X-Google-Smtp-Source: AGHT+IHFAv6dsr62rXUW00DOkCngo8gSvrjlVL53mgx4gF4pufYV9qf1J1md/WrNK0rHTFT1m/FoSQ==
X-Received: by 2002:a17:907:cc25:b0:aa6:7ec4:8bae with SMTP id
 a640c23a62f3a-aa67ec48d67mr422442966b.26.1733756291870; 
 Mon, 09 Dec 2024 06:58:11 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa686bb8cb2sm171780166b.153.2024.12.09.06.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 06:58:11 -0800 (PST)
Message-ID: <c55251f3-0dbf-45e2-8e83-8b6232a351df@linaro.org>
Date: Mon, 9 Dec 2024 15:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: ufetch: Fix type mismatch on 32-bit
Content-Language: en-US
To: j.ne@posteo.net, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
 <20241205-ufetch-v1-1-df861318bd49@posteo.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241205-ufetch-v1-1-df861318bd49@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi J,

Thanks for the patch!

On 05/12/2024 19:35, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> On 32-bit architectures, LAST_LINE (_LAST_LINE - 1UL) is 64 bits long,
> but size_t (from ARRAY_SIZE(...)) is 32 bits. This results in a warning
> because the max() macro expects the same type on both sides:
> 
> cmd/ufetch.c: In function ‘do_ufetch’:
> include/linux/kernel.h:179:24: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>   179 |         (void) (&_max1 == &_max2);              \
>       |                        ^~
> cmd/ufetch.c:92:25: note: in expansion of macro ‘max’
>    92 |         int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>       |                         ^~~
> 
> Fix this by casting LAST_LINE to size_t.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  cmd/ufetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 0b825d7e8c75f3b18933d3e3f77e5f40f2c7b658..5f3ef847b268dc384271fc6774720e5fd2337157 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -89,7 +89,7 @@ enum output_lines {
>  static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  		     char *const argv[])
>  {
> -	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
> +	int num_lines = max((size_t)LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>  	const char *model, *compatible;
>  	char *ipaddr;
>  	int n_cmds, n_cpus = 0, ret, compatlen;
> 

-- 
// Caleb (they/them)


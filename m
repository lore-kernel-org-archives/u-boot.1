Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A98CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A392E83045;
	Tue, 30 Sep 2025 11:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y4zwn9xB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA2E8349B; Tue, 30 Sep 2025 11:57:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6878B828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so3812130f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759226264; x=1759831064; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7sXk29mqPxm5xU9rlyQX3XYW6+uMBm5pWsLOBz6uvw=;
 b=y4zwn9xBoDfMUS3PMYtVJnOY3zPe0cpuSZM3gsI7//Ugrl1Q1utG0itn7eumaSJv5J
 D3rV24GgrBMMHhjuHkVbXMT9QxCma5l/SRQNjF+2XteRam7lIU9AQhlOrL4u7dwfHHpP
 oWLN4/D2Z+Lz3+otvh5Qbg6V7trQdjoIb/waUsVI1/NneTEDj6Fw0KTtscwrPoDCItB9
 eAh4NplTZB8OLaQfMbTGbkP7xAIF3zMc4IBhq4muwv4TOOwGbyuCS0BFwky30sEjKO2V
 VcXgUtlOpoIOdkfeyYVZiChUNL134okNpLicQ6YMv+RQyYzV/ytuk166Ufq8iEPUOZQa
 mXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759226264; x=1759831064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H7sXk29mqPxm5xU9rlyQX3XYW6+uMBm5pWsLOBz6uvw=;
 b=dwdcrbolLp7oaIN1BhjJns3F9kDaECz7i0cGqQ3s1SaKRjyVR7buiVjQNq1fppkGI4
 aSz7PQU3qtxSQEkSrQxd37lwVgAxBm1zEhZQ5fuirDzDqvbxKMJZZEbObTpiLHv7Kcr/
 sn1cAxxwXqT/8ojvDRimvgR0o5ZmmlyC69r3fHA1BDe26gAm2/GVS6ew++JX2iddo0WC
 paDgF6NSoU17fcj5uq2hGlUHor9mlK85LXsvlFh6y4qcezZdTJ0kWJ5rOqyk+T9hwmJ0
 xlNXfRcM8LwbM3zP6h/sppU2jGztyFvExgqob6o52ezA1s+xMlIJxZwnYcLIR6fttY9u
 b8TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmKwSER4sIdfC2VgQlsSjEmGQqes6/vpeV8l5pUTg9lmawwES/0LsU6/kpt5vmArky1+IcVGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1em1x5XKfvAjTDxgpnuXIkFR47f4smr2AmEaTUAMnQW1djCFo
 s+fMFqxl49XdGI6i/DaMpMTcJxuWarbz55nHL7IODIZRfgSnM3baW94ir+VrRcEgBq4=
X-Gm-Gg: ASbGncvQg5ZLtyziSsEy6co1qVJb+5mH0yKiKzQAib+3om+dfTNCSDBT8Pl/Ca//ALu
 qK0+HTTgyrlLFstPKgdhCWy6KW1YtLOmPTvJwyvHPOK2y6ZiOxqyaR9OxvHp/zmMv6ccSCLv3MU
 cUu1utT2qbNSfS4SgfUdNxY0T5MhRW85tAMP4D8gyDxF63EevjTnO1Z1IUO5QWs374YzfiaBWl/
 kUimoRabq1n/bhK0XTFmDvac8Firy/yE6KeDYEHP4UKm6jLdpndqXnStQxFhZgChsed3jm00ch0
 XvjRdhBsvwC2xoEha6yrpcX7mgUhfQvLT2iQi3vkITh9JNSN2OlxhKgR+U6NNx+NTHpxC+ADD0R
 PnJvF/fMJeu+xoGmGUzv22GcHjynPVozx/Eca5lizGwG2wImdOpWdBjEP
X-Google-Smtp-Source: AGHT+IHexjyrPAQosSKF5IfZk2sJX/7jX8tMNNKcxodLpOrJjzsP0i43CfEQRbCVMnqKLguBI0wQVw==
X-Received: by 2002:adf:8b47:0:b0:424:21ff:5151 with SMTP id
 ffacd0b85a97d-42421ff535fmr1661800f8f.5.1759226264294; 
 Tue, 30 Sep 2025 02:57:44 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603161sm22334223f8f.35.2025.09.30.02.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 02:57:43 -0700 (PDT)
Message-ID: <d7279d1b-9e6f-4715-af7b-3d30ee8388cc@linaro.org>
Date: Tue, 30 Sep 2025 11:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: ensure alignment of packet buffers
To: Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250929192149.3735435-1-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250929192149.3735435-1-tharvey@gateworks.com>
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

Hi Tim,

On 9/29/25 21:21, Tim Harvey wrote:
> Network packet buffers should be aligned to PKTALIGN. Add a compiler
> attribute to ensure this.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/net-lwip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 660ceb10cbe..aec05d55de6 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -30,7 +30,7 @@ void (*push_packet)(void *, int len) = 0;
>  static int net_try_count;
>  static int net_restarted;
>  int net_restart_wrap;
> -static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
> +static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN] __attribute__((aligned(PKTALIGN)));
>  uchar *net_rx_packets[PKTBUFSRX];
>  uchar *net_rx_packet;
>  const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

I'd rather use the __aligned(x) macro from <linux/compiler_attributes.h>.
No need to resend, I will update the patch locally before sending my next
pull request for the net subsystem.

Thanks,
-- 
Jerome

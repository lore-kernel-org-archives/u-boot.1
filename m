Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913E9EA4E3E
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 16:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC19683F2D;
	Mon,  2 Mar 2026 17:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fOnfbQVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B792183F30; Mon,  2 Mar 2026 17:23:46 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D37583F2A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 17:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso3445280f8f.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772468624; x=1773073424; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NQiaIkD0Xucvghuix62C/hLs4g3HxkTwiG5Td5ptXaA=;
 b=fOnfbQVifmfHE1OTwwump/vLXNsQkTkq0eevUQyC6paPUpZHtPZgI+/7SvVbT8UFTh
 2sghL8a/sdLGWnp+k4CYk2BkVbTfKR7JvB6IpAPXSAMK8SSDvaCV7El38lzrmFIe2JjO
 v1XJ8MSgja2tHIWPgkpQHW/hl7bqzwN+Sn4vAnfIqFLJmft/w9q6BazZgu4IfLP4VK6K
 y5ilHqHSw1BnsxIgw3H9lYONI8TyYC72b3VLEhqqnmnbYrUgKOwnM4UBouz5cCkZYU1p
 YCepth2vMzK+n+x0/KDSTCyL6R7ZMTtrzslZvP9c8ez2xplgCTK7rGSS6eJp7AXaKxdd
 fbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772468624; x=1773073424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NQiaIkD0Xucvghuix62C/hLs4g3HxkTwiG5Td5ptXaA=;
 b=Cc9zGbV69Gm4GmwTtAJFoZXxsiHRvJ5T7w3HVMhZ9Eo8q0HHzCcHAVu5FztC6eLZ9Z
 VYZpq+WoB7xKq5CYPbTw0ufqImUiHlq6aBhWj0ZwqggvsIbpzp6xNBJCPymR2keoia7T
 i/LiaaeECFZ5LhKeh/7SIg1aRfXYdoRsfdTaL1qSfBiU/m++QJ/EO2Yx64bFMMGR58l6
 DnBVzUtxgpl1m3wtCXX2BcwBQwewmSvqLv2foDOIRkIGdkV9oHD8kzPk2AIeZzagiFA/
 a8Np1/tq2+cDhyKKyjm+jPM47yfbcR1PNheS43vK4l+FdknFQxXEMUo9wRazyt+Rg6Sa
 7GbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2S6a8RVigdqTzqHHEITWCp1bjJLs7f9hTahQ4PB2K9V4cnFUcIswdhOn2oYyB04Y+Faa74DE=@lists.denx.de
X-Gm-Message-State: AOJu0YxXKNLMeTR6dTeNVpylS7Hs+sKcRfqIwDyQk+aI/r0YVeuTV/Wp
 titU0b18zK380DtjD8rh9Otv6M3N6RhP5X0lv35mfyuWkx52hH+PYVKn
X-Gm-Gg: ATEYQzxVfn2RebGRSeVCIpXTBv1Nm/DE3NAd79eRhQwJ4l9jNdludLRUOPtWy8O/G47
 MGDTvMQG7agem9VJXcidMqcSNMff7xPBxCeQgPRe/TqLOJKomQbX22FrpY7mCTujv0dt6YqWhGw
 SIVGcsN1A/HqepOK8JmAoHdFWFoFgU7P/dVJseZ+B3kZjG59hShd+RpCQCpXaHjYz+EJm+iioAw
 kL98f5SHqzCeOjekT3nhz6WE3i5Vd1F9pBAYixHj+j1YKIOjmzYsRcaL5NubjnaVRNFwz6sRCp/
 nHQaPnqo1owiaIifR/OEaDWzeF718GmheuDMOmgRQd2Ekw3StbVo1GAs72MYj4fdkfQDlxbAQXL
 cU8H5EniejWtPafIn3MBSp+P3obtQJpirgbnQa4y8GZq71DYMb+ks4PgV+UNcPQH/645UwZuwJt
 d4JHL0EJE6yERFXg18R0Nxs8QGJPTt67FF3TJjuOjVpw0a7nwrXweG7I2wu9QYP+a50LNyAvpxX
 zHyrS3xhg==
X-Received: by 2002:a05:600c:8108:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-483c9bfa168mr196055325e9.30.1772468623764; 
 Mon, 02 Mar 2026 08:23:43 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f26d7sm434625235e9.3.2026.03.02.08.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 08:23:43 -0800 (PST)
Message-ID: <beec85d9-a580-4ae3-854d-3c957b888eb2@gmail.com>
Date: Mon, 2 Mar 2026 17:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: stm32: dsi: add .of_to_plat callback
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20260205-dsi-v1-1-eb5805068e97@gmail.com>
 <50a9f6c3-4284-460c-a429-49b4a53c836e@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <50a9f6c3-4284-460c-a429-49b4a53c836e@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Mar 2026 17:32:02 +0100
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

Hi,

Can this one be picked up for v2026.04 or is there something I should do ?

Best regards,
Raphaël

On 2/24/26 11:01, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/5/26 00:35, Raphael Gallais-Pou wrote:
>> Drivers should extract device-tree data before probing via the
>> .of_to_plat hook.
>>
>> Implement it for stm32_dsi driver.  By doing so, it also solve a
>> variable shadowing in stm32_dsi_probe() where &clk was used as
>> peripheral clock and ref clock.
>>
>> For readability some struct have been renamed such as:
>>
>>    * struct stm32_dsi_priv *dsi -> struct stm32_dsi_priv *priv
>>    * struct clk clk -> struct clk pclk
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>> This patch has been tested on stm32mp157c-dk2 board.
>> ---
>>   drivers/video/stm32/stm32_dsi.c | 168 +++++++++++++++++++++ 
>> +------------------
>>   1 file changed, 91 insertions(+), 77 deletions(-)
>>
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 


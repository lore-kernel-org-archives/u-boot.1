Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7911AD12686
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 11:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE7E8900E;
	Tue,  5 Nov 2024 12:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WcBYUknu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DE988D29; Tue,  5 Nov 2024 12:12:50 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736BC890F6
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 12:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so4007463f8f.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805167; x=1731409967; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fdwu+YpFls5JEPHdQzsSrl9+4IkVbva4LPAnPBsPzEs=;
 b=WcBYUknu4WDfpAuUS33bzd4Jzb/fNIkQp/CCLimqgJ+Fgs1HI+Aznjxgq4Q0MqFkaP
 hY075GMNEFYhcGhMMh/JAsXoCH8f7/GmLIb7f4f9TLr58dOmz6+ROMCW9HvQry8vuP86
 zAGrhbfZce2rE3chs1vx/7+0N8OYr0+0upzYYDgsUIBq6v2h46pjXYcHYyBQNCmagFrr
 Oa41l/UO8wYx7sWDa83JTEdyuija7afXsLo24gKlLa0S+/FbZlg8uGGP1b2/vhoHvfxm
 lAk/I5KM3Ue5D1qN3IHltTrkFndf3sxYKaJki48Y2nk/u+S7WtwTJCtp1owUH/Yc7OlJ
 SFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805167; x=1731409967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdwu+YpFls5JEPHdQzsSrl9+4IkVbva4LPAnPBsPzEs=;
 b=mifoVDC/kt79OVmQpdVg78q36dn43S2vw9EQVNG3t9TJYtLcqDYM3gt6m1Y5sgvz6h
 x08IBAATNJbJzF8D+iCKKkyJ+7uYl/hhKkw7D9onWObtESJ2nAKJZ9+4KW0QtrlRgHkJ
 DNSKsRPHLyK3vQQmU85qJL5dGE/CEe7BPTqvZ2OFfG5gf+cTNBcSE0lV8anGAFe5Q4y0
 O2iEo778re1mHHeF4++pfgvwMS8/v4qrfhbNUOWRHys2Yb91iA0qP5rAKc+LnZ1sovH8
 T0w1F0qEkQsTBcgUIMeMFTnjbGPM8x3c4hvsKoBCe+bF9qZ2yYPrK/LJ/4gUD5EkZ36R
 nhsw==
X-Gm-Message-State: AOJu0YxUFzx5f7uZNaxi3r49t7cr6fuMQ+MOkcY3ypcX9OC5Ds4ONxmh
 dBWwLRtqoglxsiUQ7ux6XnEkywv+LdvbxjrOsjRWJ6YKKVMiDA/OqRYQd1hgmsSccCkqniDdx9+
 eRiz98oHH
X-Google-Smtp-Source: AGHT+IGiBqoAtOX1eC0F/RwN+muooA+TI5UBesvdGhk22AhwLXbE3EgqsuFLppWcBIW94JqKwtt4yw==
X-Received: by 2002:a5d:6d0e:0:b0:379:5c8:33fa with SMTP id
 ffacd0b85a97d-381c7866580mr13599182f8f.0.1730805166785; 
 Tue, 05 Nov 2024 03:12:46 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9984sm216052045e9.32.2024.11.05.03.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 03:12:46 -0800 (PST)
Message-ID: <daf599a6-bea5-4610-b498-db460bc470cf@linaro.org>
Date: Tue, 5 Nov 2024 11:12:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wget: check strict_strtoul() return value
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
References: <20241008094646.4052174-1-jerome.forissier@linaro.org>
 <20241027183206.GM4959@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241027183206.GM4959@bill-the-cat>
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



On 10/27/24 18:32, Tom Rini wrote:
> On Tue, Oct 08, 2024 at 11:46:46AM +0200, Jerome Forissier wrote:
> 
>> Check the return value of strict_strtoul() when processing the
>> Content-Length header as recommended by Coverity [1].
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2024-October/567050.html
>>
>> Reported-by: Coverity (CID 510464)
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>  net/wget.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/wget.c b/net/wget.c
>> index b4251e0f293..a3821495e03 100644
>> --- a/net/wget.c
>> +++ b/net/wget.c
>> @@ -256,7 +256,12 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>>  				content_length = -1;
>>  			} else {
>>  				pos += sizeof(content_len) + 2;
>> -				strict_strtoul(pos, 10, &content_length);
>> +				if (strict_strtoul(pos, 10, &content_length) < 0) {
>> +					wget_loop_state = NETLOOP_FAIL;
>> +					wget_fail("wget: bad Content-Length\n", tcp_seq_num, tcp_ack_num, action);
>> +					net_set_state(NETLOOP_FAIL);
>> +					return;
>> +				}
>>  				debug_cond(DEBUG_WGET,
>>  					   "wget: Connected Len %lu\n",
>>  					   content_length);
> 
> This leads to:
> U-Boot> wget 200000 EFI/arm64/helloworld.efi
> Waiting for Ethernet connection... done.
> HTTP/1.0 200 OKwget: Transfer Fail - wget: bad Content-Length
> 
> On for example Pi without lwIP enabled. This works otherwise.
> 

Yeah. The strict_strtoul() call is wrong in the first place. Replaced with:
https://lore.kernel.org/u-boot/20241105110849.41348-1-jerome.forissier@linaro.org/T/#u

Thanks,
-- 
Jerome

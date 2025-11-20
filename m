Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78377CF6497
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 00:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC82783EA6;
	Thu, 20 Nov 2025 01:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="B++eWMvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D954983EDE; Thu, 20 Nov 2025 01:13:14 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B2983E40
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 01:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so2452215e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1763597591; x=1764202391; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yHL4XCbYJBzpntArreb4pVnWAo3d0/nepVM/P6clMPI=;
 b=B++eWMvW2aR5UjJSXI3rtc7R+Ba3GZ7cz+HM256i18BiwaeXM2PDPEHGKR1MBGx/up
 Bh1ek9EN/GZyqI+Dn0uMKVJoN6KpoPwICwHI6uBiBlUIxIaglfyvOuBpHjgntbkE7GED
 GoTUV+pn22Lzn7BaBlumFGHaMqD/zR8Yqsq9xts5amc5nNSgbbJRNGyacHp4bfyL88Zf
 wziedLNzbMNOvFgEhxeseEckIZS7OxiQaQsTvlMGxwLJbdElk7Ms4ixF8Sn0nyUVixz+
 HR10YUck/yBuYixhwmaxroeADyV3Sy/aey91Vs+9Z5jMHJ01LtvoqXlk5Xc1ZGw6OkA9
 uJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597591; x=1764202391;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHL4XCbYJBzpntArreb4pVnWAo3d0/nepVM/P6clMPI=;
 b=qPTzjZ+qToMbJIpReh5sT1ExWOURszEaKnuW34TlkbK8O5KhkUQkqBpWAjPKx1OWP4
 Lbe1mR6CQ2jlflJKSz8rdZV2Z0gJ8giD4XHhzRWpF45A89SISm7E5pMRMPAQGB1Rs+NR
 7yifQcke3Sfp+rzKXGPs5PT0pz27hA6TP23TExoYng265tU6bkTXFGWGtwdl2Pt2f7jx
 voEAHLv0sig8Aki676Kh2UUq1e/4Xm0YvTITPiJP0Kbjwk4aUKAIQlWYX7y5VZzMqFDI
 +cwH72uLC5/HKhBKszbC0Rz+QRHOOIt+VTujl0jJzNNJ+79nf7jVlZ7ltsC+Xak+jlRS
 d6Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYRKQNrM3i4uf4vxj3T80KxZ04OjC2o0ja1In6cY4Nh6JmzLVVxII3k1OJkjqwcnaoNZRrwoc=@lists.denx.de
X-Gm-Message-State: AOJu0YxPntJgJ0O7iXTP8CDMutJjNhA16m9E9RWseG/+S1udOEv89NVb
 6DVtZnPQv3lInKGdFhOBK4irM5FlI0g1AB+RtklrOCEAzDT6ftDF9m85ZXjHg0WCE/8=
X-Gm-Gg: ASbGncvWmG8T55Q2cNKGbLVDgnjpfjHcoIY54k0YNkBefCZ88WcmSjcYEx61ZVvxai2
 KPUxbyMuRUDJPocdmNl2nCG9t6gLAYoecdF2QjE0D5uIpyxMNou51VYUa72h2vM+9cod/xusPT3
 gn3IkAnn+5chHOD/am+lFFsM+w7WX9vRJ50yNRIYmmuL+lDHYOXWtudx/x+2BoKrPhnFZvPOy98
 AHq34vNZcU38Y42AjNXWDN7pRoePjAZGc25qgIPs3ipnU3AByudrNvGqTnH0HWtJ6XfZTR8zVTO
 hL5Ke6JInzpehWsWErOBBH8yO3ub5iQWFnXBnrRHHHHHF/7fSKwTJMOhIwZPJ31Ah4M3LJ0k1en
 X541aT8cTKe60mDw/55flWdKxX6Lb9wH0Q7LFcQ+h6I5slFehQHoWhidHrCeuEtYl0yfmtjNnhC
 QkkO39ONwIK6aN6TtxyNAH51dZNWfjuO8gCXnvSLGn8R6a/vqLpxCByw2lBuSnU4GNcnJX8qEx
X-Google-Smtp-Source: AGHT+IF0UrK0CfcSGSdDJm6sdGY8PayE8gh8wPYxZcj/HrK6WYNSIXTwjxM+j71oxDRh5PIFOSDr/g==
X-Received: by 2002:a05:600c:4e8e:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-477b8579e57mr10318765e9.4.1763597591270; 
 Wed, 19 Nov 2025 16:13:11 -0800 (PST)
Received: from [192.168.2.177] (241.85-85-167.dynamic.clientes.euskaltel.es.
 [85.85.167.241]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8ff3sm2034666f8f.29.2025.11.19.16.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 16:13:10 -0800 (PST)
Message-ID: <a9e0e5da-6bc5-41e2-935e-885e29ca6301@suse.com>
Date: Thu, 20 Nov 2025 01:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Retry FRU EEPROM read on timeout
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <9556d204c351d2dc40176a31dab11f789fd1cc7f.1763542221.git.michal.simek@amd.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <9556d204c351d2dc40176a31dab11f789fd1cc7f.1763542221.git.michal.simek@amd.com>
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



On 19/11/2025 09:50, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Wrap the dm_i2c_read() call is used for FRU EEPROM reads in a
> retry loop, attempting up to EEPROM_FRU_READ_RETRY times if a
> -ETIMEDOUT error is returned. The loop exits immediately on
> success or any error other than -ETIMEDOUT. This improves
> robustness against transient I2C timeouts during FRU detection
> and decoding.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> 
>   board/xilinx/common/board.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 26facb6daeab..4735b6ab58d6 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -70,6 +70,8 @@ struct efi_capsule_update_info update_info = {
>   #define EEPROM_HDR_ETH_ALEN		ETH_ALEN
>   #define EEPROM_HDR_UUID_LEN		16
>   
> +#define EEPROM_FRU_READ_RETRY		5
> +
>   struct xilinx_board_description {
>   	u32 header;
>   	char manufacturer[EEPROM_HDR_MANUFACTURER_LEN + 1];
> @@ -207,8 +209,14 @@ static int xilinx_read_eeprom_fru(struct udevice *dev, char *name,
>   	debug("%s: I2C EEPROM read pass data at %p\n", __func__,
>   	      fru_content);
>   
> -	ret = dm_i2c_read(dev, 0, (uchar *)fru_content,
> -			  eeprom_size);
> +	i = 0;
> +	do {
> +		ret = dm_i2c_read(dev, 0, (uchar *)fru_content,
> +				  eeprom_size);
> +		if (!ret)
> +			break;
> +	} while (++i < EEPROM_FRU_READ_RETRY && ret == -ETIMEDOUT);
> +
>   	if (ret) {
>   		debug("%s: I2C EEPROM read failed\n", __func__);
>   		goto end;


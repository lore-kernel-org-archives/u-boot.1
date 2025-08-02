Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D406AC87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 13:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EE683D5D;
	Sun,  3 Aug 2025 15:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIWwOOW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B656B83B5F; Sat,  2 Aug 2025 08:10:00 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 822FE83B4E
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 08:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2403ca0313aso20686515ad.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754114997; x=1754719797; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p7PCdODH6IF2ze2S5jHpOmYCAUXZdfTI+JbWoxCu82g=;
 b=aIWwOOW74bWOIP2LnshGtjWt9OcHYyzuIBo+VGWFqhwJzMq0bMQ0Xpf7ut6ALhOudL
 pVMncDg2fSAxO+Y40qGZjmt8V+CjzDfSONYg7+XB31JMQ6w/gsM3f9iRshXT33C0HpQt
 vxgt1NX4sdBl/gW5ECKKq8L+DCISkeEOSnYutGzrQwJjRX1I3ipoc1bGlge/3UPEr8yu
 5rpHCf8C28qzAwtqldy1ZPfFSSQuutkzRmtSp2qTg3bLFeiEyuMuZqmc7NfPUpLcPI7N
 lNyl1oxyzKfAPie9k7fcrQX57rHX6ytNCjjXAnI/oqY+ggRuNYwDoEep6aLJ+wMNCd7z
 7vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754114997; x=1754719797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7PCdODH6IF2ze2S5jHpOmYCAUXZdfTI+JbWoxCu82g=;
 b=u1KMYYwxPdskZUy2lIxrF4przj1XLpbWiltj8t4h/TrWH/jYBbNDghgwqnaO6uOnIr
 oYuhoAYNJ7cBadV6LvJYi+CNToNGXy+lygIJKxPGzRu60zQ+zf9BYL0Gpkxfdt5VFrV4
 64ReuLvDTjcjsljej1DxUIHAQMZFXOYQPSHTrL/uT2lX+QMCksDeKXw+47vmMNGGHeGF
 AAZvFATC0wKkqlWlFlzsybsZpC2PxE5Om/s906r7mwFoGz9lAc/8LmuonwtOTnHLBsjJ
 nvspzKhFuXajmFfAOsEe866gnd8SZWV7YRTljoIplLZxIUGVS76JtkfSoI6iZctcy2qU
 yJUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzEcZ0F/0YXx5p7sFq0u6XzQQCAtUh62i+BX7CipfqLCvwEHOaLxBTzGKxvTnKmRf4Ip8+/wI=@lists.denx.de
X-Gm-Message-State: AOJu0YyhTVujlQ76UqMzfyQoFCeaju9brRnMv/lPHgFLbj0DNTYHpfIj
 WVKDC3cDpzUyPa23dk5WbPx0eI+yagsDl++xIfkX7UsgPTIOJly01/JB
X-Gm-Gg: ASbGncvWwzgd/cnJXyeYIbzaKGFmF5xMF2ij1AmoZ8owcVZcjIw/pihqfteZwewOWLf
 nQcXRRgONMiiAkYe8KlE1mnXde8306zDdNGNlbAsTpVt6Jg9/Fp/5wh4EoStZQqOjzR5ZCIMy+2
 /61N+MwiL9vVyGm0MKmwEpo+eF6S5Bf0ZgpIfxljETnqpSjYAPZELnCVD096nDaVV4v8cMglU+d
 kCUNZjO0P6awWFaAfq0m254aGVnezDm+JKGJ9+trdRf8SbW8Z9OgcKP6tkmMwqiQDz8GEfngrgS
 oplEFsIp5pT2t+khEez1/zx3H4oFVnzbBBaFEqWanEKdbvtn61UIM0IxRJzCucwbeg24tClQnWc
 nLVDy+GsdTxnVc9AIAU63kX0JdDPQOvjHmv8UjCDJeG60VrOR0xXcC2DmwFI2FYVeihRtZO83Sa
 LR/U3bGvCgHfgpXVJ/5g==
X-Google-Smtp-Source: AGHT+IHNadZCRaWquJm8NIczTrzvAoFy2P8zm0tMGhocsMUIqnvdcrhwXnA629GWOusFq4qy6Y0X5w==
X-Received: by 2002:a17:902:c94c:b0:242:126:476e with SMTP id
 d9443c01a7336-24246ff13a3mr33708025ad.32.1754114996803; 
 Fri, 01 Aug 2025 23:09:56 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976cb1sm59039505ad.89.2025.08.01.23.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 23:09:56 -0700 (PDT)
Message-ID: <d05993f5-0153-4c00-a111-5d2e157ed25c@gmail.com>
Date: Sat, 2 Aug 2025 14:09:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v3, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20250729145146.2935-1-lucienzx159@gmail.com>
 <ed7d3970-b550-431a-9f41-3fccdf5bed73@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <ed7d3970-b550-431a-9f41-3fccdf5bed73@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 03 Aug 2025 15:22:51 +0200
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


Marek Vasut 於 2025/7/30 上午 02:07 寫道:
> On 7/29/25 4:51 PM, Lucien.Jheng wrote:
>
> [...]
>
>> +int request_firmware_into_buf_via_script(void **buf, size_t max_size,
>> +                                      const char *script_name)
>> +{
>
> [...]
>
>> +    *buf = (void *)memdup((void *)addr, size);
>> +    if (!*buf) {
>> +        log_err("Failed to allocate memory for firmware copy.\n");
>> +        return -ENOMEM;
>> +    }
> One more nitpick, do we want to memdup() the firmware here, or would 
> it be better if user passed an already pre-allocated buffer pointer 
> into this function and this function would only copy up to 'max_size' 
> bytes into that buffer ?
>
> This:
>
> int request_firmware_into_buf_via_script(void *buf, size_t max_size,
>                                          const char *script_name)
> ...
> memcpy(buf, addr, min(size, max_size));
> ...
>
> What do you think ?
>
> Also, I would really like if someone else voiced their opinion this 
> firmware loading mechanism.
Hi Marek

I agree with this assessment.

I think it's better to have the user pass an already pre-allocated 
buffer pointer into this function,

and I will modify this part accordingly.

Hi all

Since you all have extensive development experience with U-Boot,

I'm very hopeful that we can make the firmware loading a better user 
experience for developers.

Therefore, I would greatly appreciate any suggestions you have on how to 
improve the firmware loading mechanism.

Thank you in advance for your insights.


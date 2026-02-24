Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9F1F3C99F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D5383642;
	Tue, 24 Feb 2026 16:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TcfX//+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F6983981; Tue, 24 Feb 2026 16:45:53 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664EC82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 18C373F1CE
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1771947951;
 bh=FXyQth1LYgLyIDxoRS6AfucN/dVl2JxkwyhP6zuhoKs=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=TcfX//+CuyR33Jpzf+fr3GdZce/vYnMOW3USec8FOFOLzF7svIH/lFraOOn9CDsV1
 6nXP5whtPTzIi1uqiVdFjt8vYrvGaGpg0hbAkF69s+oMqUGUt2UzHjdKUZnB6PVqPJ
 IsZ31qhTkqECM62Nh6OhDgrOV8lSEZYNiuIBr0LfPVa5kdfl1cO5W2EEMflRb0LQZv
 Kn0ByT7blJCRn8x1lV3NSKIYW5zbRmBrnKRI4seWeSlhbUFagKz/VZzj5QAW8ND7ub
 3Bl6rjNKFzYuv0oZob84VK5a3HvJr91cb6RXpzD9kCcXAr90hbbQwoGZGx9aQQm5UK
 PrUmg11bWt/c2cHIEtG+fenz6tSf1EGm9FqD8c3T1+dZl2MXIxYhF2tZ+oqKvnaNje
 9ssNAmE6QHw/GQvTCZcmXmWUkIj1K+lSkqa+hpb0Kgtuv5u3GUkmsq7utRYF33XePS
 prgjzoXE5/LIjSTLGTaHea/ma2JFB26wlSdlzaFRA9G8a0IqxYwUX8umKvQAhrelk1
 QDYdZFci6k8sgZmXQCFZOy1HTlCtJh3V/sHpzFZqWDpcby4Ojmb01k3lT7ssM7lmku
 wbRIj16HKYJ+6GccqPOwl3MyW1bf8GEBBJizbKD5GEEUYOohRshmvQwfg3O9PUrElT
 IVIoBsjMKRkir6E2GI7GRsB4=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837246211bso59795305e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 07:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947950; x=1772552750;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FXyQth1LYgLyIDxoRS6AfucN/dVl2JxkwyhP6zuhoKs=;
 b=d7GgP+cGo1dQPrWtSI/OMWe7OfQrmpSyZgA1OTefx6b3vI8uuayFXE30TeiYAEhuyW
 p4agkK7WU1+MHESeNkv+sl3lN0sICj/Ap0MN5kF8ba1wzGBs2ymlIuJzNkBv6AxGTUqv
 o0lUYMEkA+GSK55P3pYs75SwyLWjSzJ/a5/jLzDutSE2P/hmLULI21duheBH3/jQc2xX
 IsHDv0VwnZ5t9p2EFShz5PFG+3F9GFRM2gJgZj51PWMSBdp/DvqFba8as1q/E9VNyAAJ
 GYkcgR/wbdDuxjVpzTgEdAih9rLWm0DuB7Qt009x6KeaVPh/UYaw7q5E2LkdiCTzdr2Y
 sHqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzwLn45NVTr23DfaQzwF3ix3Y5vLOAztTGhBZ1guSdMyeqkxpaJXgbp3ddE8i81XYCIpwixcQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzJu33Vzziiz/y+ksOQ+is9XugOWKkl8GZlQLGzk8R2osYGW+4F
 OgmVvba2xDYpFzHAqcjzkrd7rrDZZvkWGt07iss856qqAMXc7wyE+nCyYB0RjAyQzy6h4tSW7kW
 nNM/4cGmlGlQL2A+9yKXbG8z+j3MaSRO5I0JAG5ktggt8aV5GEJvvWmON+vwJygpwJnn4iTreY5
 A3WBc=
X-Gm-Gg: AZuq6aIj0+k1yNEJMnEv89+ltxXh3+zHX7ge/Uzqp4nVEXLG4wFt3r4to4pY0r8vbqV
 YNhyOX3HQ+Mm6btg17x+WJOQa/Z1u5znAl+9sDlrKn0xN1AxMXHCvdx/2kMV3VbHWSXyNwx9qhx
 aTEPFX5Oh0kdD6BD2U9QLl5XtMo6yndcx2mKkKIp7YoPHOf2jHcrH5t8PDWHlUOZrWchS1wZzUm
 ikFwWgzV158bmXjPv1GLou7EMMmYQQJyxiaREFB7bNYdgbZ1SOOKRcR8oNP7aFz82ApzrTUI3Ye
 LCMFeyV0WaUSefKNOrvxy4aydnpJicLQkX09PZWVYhzpSIi8kBzkpF/uQLetVVK+oU1eH38wtrz
 j1qF7GrJiUIqolIPuCvqRUuXKj5NIOdnqtswa0TMrB1fuITpvIs8O/xeD3lHKVRH2iLg7SCFvCR
 PL825xKymo9aeymrpxwItxmr10/j6Gc01K5g==
X-Received: by 2002:a05:600c:a016:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-483a962e470mr214994425e9.17.1771947950640; 
 Tue, 24 Feb 2026 07:45:50 -0800 (PST)
X-Received: by 2002:a05:600c:a016:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-483a962e470mr214994125e9.17.1771947950220; 
 Tue, 24 Feb 2026 07:45:50 -0800 (PST)
Received: from [192.168.103.129]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483b8902ed2sm21163675e9.20.2026.02.24.07.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 07:45:49 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <db9de791-60fe-4308-b2d3-66ad6eb07684@gmx.de>
Date: Tue, 24 Feb 2026 16:45:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] efi_selftest: fix buffer overflow
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-2-vincent.stehle@arm.com>
Content-Language: en-US
In-Reply-To: <20260219184400.257008-2-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/19/26 19:43, Vincent Stehlé wrote:
> The test of the UEFI LocateHandleBuffer() function clears a returned buffer
> at some point to reuse it, but there is an error in the size computation,
> which leads to a buffer overflow; fix it.
> 
> Fixes: 927ca890b09f ("efi_selftest: test protocol management")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   lib/efi_selftest/efi_selftest_manageprotocols.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_selftest/efi_selftest_manageprotocols.c
> index 097b2ae3545..ccffa59095d 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -241,7 +241,7 @@ static int execute(void)
>   		return EFI_ST_FAILURE;
>   	}
>   	/* Clear the buffer, we are reusing it it the next step. */
> -	boottime->set_mem(buffer, sizeof(efi_handle_t) * buffer_size, 0);
> +	boottime->set_mem(buffer, sizeof(efi_handle_t) * count, 0);
>   
>   	/*
>   	 * Test LocateHandle with ByProtocol

Hello Vincent,

Thank you for reviewing the code and pointing to an issue.

The fix looks incomplete to me:

In line 167 we allocate a buffer with LocateHandleBuffer(). Assigning 
buffer_size in line 173 does not make any sense, as we free the buffer 
in line 185.

In line 223 we allocate another buffer with LocateHandleBuffer().
Assigning the value of buffer_size value to count before the invocation 
doesn't make much sense.

You fix in line 244 looks correct.

Line 249 sets count to an arbitrary value that is not related to the 
size of the buffer.

Line 260 sets variable buffer_size and buffer_size is again used in line 
306 to set count to an unused value.

We should completely remove variable buffer_size from the function.

Best regards

Heinrich

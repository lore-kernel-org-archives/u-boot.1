Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC6DEB28F8
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 09:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAE58382A;
	Fri,  6 Feb 2026 10:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mSo8RMVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BF783A64; Fri,  6 Feb 2026 10:04:01 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9BC836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 10:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D289F3F78B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770368638;
 bh=wqPrIwCBQWzaNVyoPt3pKvVO6ToAiqdj+nXBlbVlV0Y=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=mSo8RMVh+CM8Krvw8L7iJfRoiSi9cmcOTP/k2CMHh0csqnH7pF+Mz+QQLalD++rpA
 9jdTMlUL89jvsoD+Ua9SUpfnHpoynPGk146W9OzrgsI3sVTE8xoamxrCBdBySW2OTs
 cXekTDUALJug1UNuzTbgnHhn8c+qWbILTtueeHTa8kdkRU9NCk3CsS1AUl+gcig9Wd
 1qGNE/nOz7sYd8EKvAbtpIP4iSQjJfF/YgdBnJZVw5RfJo0zSOms3ri1/Ev9jPRN8+
 EGNDIVt45uYPZxNJHpjowqiqpDYw35Rgv1JnQbg+T7/B6K3Qpjp5/uwSHFvnoViMYj
 QXTK2kn3wVV0dvs3jWyW7ebyHvpTrhzda+aUDAu1dZOjpdztiqNoSR/1yiJxGRT/TU
 Z1ASJfGoITZfl5GRlleq13zhkTB3QGwieLB1T1dFpbXwzpy7HsCNoF7SyW8hA8l7lM
 tdHE+UJDtEcpKEmgrZhhsJeYpu+mJ5zujmofiof50wqH3XVnLBqJPGCJYYd6K1E7fb
 CyCDehJeItTfUFf9RRRnZ/QhF3yUFIt5F+3d5GrSZEw5RkUgEzP93yizpA7oK1jJao
 bNPTAdFeGqoaTz/K6PwzMo8uDRvmWJLP3gBtmXhzlJ6tzJ2Kzj331PCa2yqz9OSwTU
 O6braVQfo6+1CWgVaqqRF1h0=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806865a01bso17110995e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 01:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770368638; x=1770973438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqPrIwCBQWzaNVyoPt3pKvVO6ToAiqdj+nXBlbVlV0Y=;
 b=JMRFlPf+24/cb4juq06s2AuDYBEKp3XBiIHdi4eZsM9icjki9iXfgYWLQhAxDViYd6
 XLIKiOnHkDnUXRNpWExot/SdSCe9N2+XoNrcSwdwtVDGXVSfQEoWpSGKHsVUeUIVz7d5
 moMewG/YbutSjzGrio9ZPzRVRtlVHFiH5mWRo9kAodnSv2dEE4jTY5ESP+nRMyusmJIt
 rK9STF3xFr9P/ju3wbbGKN8Q7l2bZ9RRyA0Rr2VxYeeHjT6UlAs/pKmlF6Gn03TR/v2r
 CxqmCbvAumAryuT9tyQ4kVCLOUAYoKto0QyR08qMmJlCHIgOTE9Z8QvVqFxmOZwzGNnJ
 c8Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQrC7H2kjZcCVSJ9x2vXxyHT8ZRr32QrsZbzqiMJthiaJVEDAsXk+N4s8bHdkxMW9i4blrEJM=@lists.denx.de
X-Gm-Message-State: AOJu0Yybetpm3S3Fo9eomRJsjkc02+qUlEvAfKUYdzcbPATf28zsWNpa
 OuGDs0xvFvzPPgVp4ipxfa6vllyYkbXZ1YPv+6rWkJWytar/CM1g8IFGxo+pl0fmFpMOUd1B0Io
 0EOrMkxK7q11ic8pukcSCxOMCaErh2feYZxO0VfUwJDoMTS7mMjbXo8yc4NsBbwaPZJ9Quxs=
X-Gm-Gg: AZuq6aIz9DSlCu1qXK3v/BKM3wwsxoFxMN+JwM1/MAw8qoWb+WO6rA+jPY10R4nGlrY
 rG53z3QIboBlYkxP5htqqY2bgdVaTVD9DyyC1/EPVbnRVI4mUhr8qh4la8y+SDtmB2siONNVVYC
 NyysMJM/q68KhIUtM3m9PoJsLStmF/sd+XHejfPKiFoRfZO85fYv87+PqRrQM82xHVqo3eQm2lv
 5tRhkBWxK9lJcMj0J45UO8a6ylfgXdw0DJn/nJ2G6ZXQC7crxQj9pMLW3rhpzyQiiEUWmYpDsMY
 cLV0in0WLmkQYrZhaMPcdPmfYlJ+4B7yiSDPiPFfhYtZ6APChNlnz8CKpRJK675WMrIlMqazkYb
 m4s+jENdYUm70a81VpIb1OgAnsDjcxGL+LYBTuVD+5MQ0FeQ2GYHWPZPSNVgmgO5ED2PcA2RimU
 Wv6zGemd8=
X-Received: by 2002:a05:600c:19d1:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-483208b9470mr22829645e9.0.1770368638368; 
 Fri, 06 Feb 2026 01:03:58 -0800 (PST)
X-Received: by 2002:a05:600c:19d1:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-483208b9470mr22828955e9.0.1770368637933; 
 Fri, 06 Feb 2026 01:03:57 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e37f9sm19236535e9.3.2026.02.06.01.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 01:03:57 -0800 (PST)
Message-ID: <375abbda-c692-4592-8b17-65ece2090db1@canonical.com>
Date: Fri, 6 Feb 2026 10:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_net: add missing EFI_CALL in efi_net
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
References: <20260205164012.667019-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260205164012.667019-1-vincent.stehle@arm.com>
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

On 2/5/26 17:40, Vincent Stehlé wrote:
> The efi_reinstall_protocol_interface() function is a UEFI function;
> make sure to call it from within U-Boot using the EFI_CALL() macro.
> 
> This fixes the following assertion:
> 
>    lib/efi_loader/efi_boottime.c:3752: efi_reinstall_protocol_interface: Assertion `__efi_entry_check()' failed.
> 
> To reproduce the issue, define LOG_DEBUG in lib/efi_loader/efi_boottime.c
> and build u-boot for your platform. Then, boot the U-Boot helloworld.efi
> application over the network. Example commands (adjust the URL and boot
> entry number):
> 
>    => efidebug boot add -u 0 net http://10.0.2.2:8000/helloworld.efi
>    => efidebug boot order 0
>    => bootefi bootmgr
> 
> Fixes: dd5d82a59995 ("efi_loader: efi_net: Add device path cache")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Adriano Cordova <adrianox@gmail.com>

Thank you for fixing this.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   lib/efi_loader/efi_net.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 0f8a851e3f2..c2b85dac236 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -1024,8 +1024,10 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
>   		goto add;
>   
>   	// If it is already installed, try to update it
> -	ret = efi_reinstall_protocol_interface(&netobj->header, &efi_guid_device_path,
> -					       phandler->protocol_interface, new_net_dp);
> +	ret = EFI_CALL(efi_reinstall_protocol_interface(&netobj->header,
> +							&efi_guid_device_path,
> +							phandler->protocol_interface,
> +							new_net_dp));
>   	if (ret != EFI_SUCCESS)
>   		return ret;
>   


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C188C53216
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 07:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39BD183AC5;
	Fri, 20 Feb 2026 08:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C0JrBmlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3578583CF2; Fri, 20 Feb 2026 08:37:47 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E172A83AA9
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso1075474f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 23:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771573064; x=1772177864; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQZ8FmIAK2bW8YQBVzK8yze8iAMk4qMK7RQYKdQESEM=;
 b=C0JrBmlxiXw0gzJswKt70GjQxZzPItdwv85XCqg2M9yF5EbrVLU44UblDuN9LPPHzb
 0KUOy2ohFug/IEvicjqLypqg49I3Thfq9zwyJz3+oJYVWFuVRReIrORYg7P4me5rXYz9
 eXk/kh+JsoqLGzCqriU0hLfQWYtzV1NemIzDHFoLXqIfSmFCFJdzOpkhRpp7owYEMnmb
 5iY+xv19HXWoPwziKWhNoV2+5+bQRfc7bdVhnuxmwtP6r5Rn6i0wM/da3ZHLki4PaqLE
 j26S4Kn0hUrM/XZjXfCSNjv52MXG39Alz2IDQOHsG57sKv4YwQUM6IYW2wm+h/S89S4Z
 MexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771573064; x=1772177864;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQZ8FmIAK2bW8YQBVzK8yze8iAMk4qMK7RQYKdQESEM=;
 b=WT2ME0OJtMChjs0woyBue11FJ7/HAfYIdbQe0ox5UlzPgFZiPlQMQM88ULBlnVLfMs
 0v6WvHRN4e1gQabc983DbL3l4bcyid+FOtCeaQHbj4V+oR24ouqRC2E+o5AfJnPkAExh
 Ai21wqtKm6e7gLbgQpjSeUxhrnCuoj2GEMpuOoR7zu1ZSIY4uVu2SnSQ712RMWVeIOg0
 /8IpjU7m353PcS6IyQsRcPYCbZ6q8rdVYuPnC4Oo+1NC+sAPIlEo0s7JFxsWhAh+hm+S
 lszyHhzKpDXK2F/jhUqc3jcmAbWJRu0HQrBCjQIs4kchrnwVKtQLYE78l5iVas4zDWK9
 GSMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ydxfP22iniacpn38hcEaU6P334L6ps2qtjlH3Idk6GR3IZ9tJqqzVDL1AYssmCrS7x7SqXs=@lists.denx.de
X-Gm-Message-State: AOJu0YxTxzDddn88eiwOpxy1NlYOWbCMOVr/lBHF/bWPRtiUXHxRFN6U
 u2RKkvsLxyXdyKvYIV9INcjI84A0CIPue7yuqrpaFQAb1pJtSXq9YHkK1KYrYO8KOW8=
X-Gm-Gg: AZuq6aJ/AcL0DJYIfInnFsmTe1T/egMPsZQVjY1hUDeUdKefbtEdbPsZ6jzY9FMP9st
 elQ4BTkEMFFGX4BOZcT9fbZzyggFawWBIy1Aci9GmXbzQm57yTNCPm/D2fpY9I1qYmQs2Pi8m7G
 6/Odfr/n2YPIIQfGYdezMEubrZl+8+EZ+LDD6uftLJj3GgVSXUToK8G0u9qDFGVg5A7RefinQsD
 YuCr+aZOGDv6tup8qWAiBn5xiCL3EB+v9yrjAGwJ5vPTfomlRLaXP1Ojx1dzDpRnNnVctU1FKEN
 1chhW77MpTGa4GklfLH2vfshrLSbukdk/D7iC6cNq60+IpIDESoJFzwKgdTNqUJr+6AvVHciuHx
 re9Q0juq3ryW9sbfNqjBwGhRQAg5YXAstLIJtZNqrzmCMAPpdbVg9ig+/MCS4Yk3vZH6QAfQZDq
 enYH0C2Z5hnQy9sYdCFNraZYZI0UgV7glEGkpNvAuds+6TQDH5LjtIFAhcZbFVXD0ZB/1GY5iCj
 VRfLZq9Q+tvKc/6ROAzItGSTt3Yl7DXeYBfQW+DL7KPmjFf8y2vxOkdUfkYWfRYmUF3BedyYwd4
 rs54WcUhoGTsusuLpS315QHk+VJxGM1QD8T+F543DlcpXSm5BnRzKPRGj6khl79J2M4u0DlRPP/
 LdS7o2z/9s6dQLXCrrWapPmJxCbVmxvRSfy0b/exbFeiMU78+w4XaP7zFSmFc2M8+TjAbC1Q/Fm
 YcTveEOj9Zo5nhG8Xn05hmOg6AfxUC1pRzldGLzp1pwfuqy6kN+hjWSKa2GxqQ5+c1DIGmmPHhR
 MnY3w==
X-Received: by 2002:a5d:5d03:0:b0:437:8941:2f7b with SMTP id
 ffacd0b85a97d-4396b040281mr1377009f8f.19.1771573064280; 
 Thu, 19 Feb 2026 23:37:44 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a6desm54113964f8f.10.2026.02.19.23.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 23:37:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 09:37:42 +0200
Message-Id: <DGJM8LNP7EV2.1Q9FAKXOLKK@linaro.org>
To: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 <u-boot@lists.denx.de>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 1/5] efi_selftest: fix buffer overflow
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-2-vincent.stehle@arm.com>
In-Reply-To: <20260219184400.257008-2-vincent.stehle@arm.com>
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

On Thu Feb 19, 2026 at 8:43 PM EET, Vincent Stehl=C3=A9 wrote:
> The test of the UEFI LocateHandleBuffer() function clears a returned buff=
er
> at some point to reuse it, but there is an error in the size computation,
> which leads to a buffer overflow; fix it.
>
> Fixes: 927ca890b09f ("efi_selftest: test protocol management")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_manageprotocols.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_se=
lftest/efi_selftest_manageprotocols.c
> index 097b2ae3545..ccffa59095d 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -241,7 +241,7 @@ static int execute(void)
>  		return EFI_ST_FAILURE;
>  	}
>  	/* Clear the buffer, we are reusing it it the next step. */
> -	boottime->set_mem(buffer, sizeof(efi_handle_t) * buffer_size, 0);
> +	boottime->set_mem(buffer, sizeof(efi_handle_t) * count, 0);
>
>  	/*
>  	 * Test LocateHandle with ByProtocol


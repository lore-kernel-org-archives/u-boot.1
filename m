Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 06:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4511388502;
	Tue, 23 Apr 2024 08:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VBHQynaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BF488561; Tue, 23 Apr 2024 08:57:08 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BE5884F2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 08:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A45F3F15B
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713855425;
 bh=egJ/wCBpwu+ZMNbyByUfoY4dBvgo0ld8htKBglsvpdc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VBHQynaGhTXPmo+3g18wC20MGJWR2ZnYaBJ888JuINcJJtOAyzp/kmG/sl2na49b5
 HZ2sxWJ/x84ZzNaCNVjSDw1Hd7Je9QUfAd81OavdKbCD5YP4z1G+3nMG5g1nI3otXc
 JbMDghIFCNn0uBkJf5lwLmUaaNISEohloc72qELNTVV/rjFqkavbUsOFQ2gB7hhzJ3
 bx40hTtd5DonQvLl+booolFWjW3p9PHVzC/NG5T4rOuDa4311c4kEMmv2zCIcp0u3o
 Rv1JTo2hTXjaPPB5zfzeDmmcXxvKNn1j8xva27wE1ZqBNWtn00YCSfgsM1xFl0tOhS
 2FMSa1E8ahmXw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41a1eb33994so8128905e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713855425; x=1714460225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=egJ/wCBpwu+ZMNbyByUfoY4dBvgo0ld8htKBglsvpdc=;
 b=f+bML80R7QQMzFMkEIFfjdORiABOdHuB6zhfvHdDd7c24jTpl4XKbg1mIbVXq6X0WW
 4J6n4HcjZSqXunPPmy0xc8D/cWB2Wsn0k0AOO9pbJxhnBtuibP7Kez0tCw1QCETZNwqD
 besiC5NBtizuSdyHiEMEo6sZNRBUp+nQUZozSFj++P9WtVFxGOfHYMy3s2EJf4AMScLL
 xAa/d9ToEvuiIEoG9LyYel+/UWsIKb8PFPz8tpGCSY9h9fRGcnqUNYTHLKv/HIvjQG1s
 ahx6pYY61UTemy/7zvYcQUZAVyKhBFgsQymL5zrpaLlUEw46a7GKpHm2qiJNsQ2C+RDH
 wmXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ2Y66o2u3Sn/dEM+Vtfpn/jysa9RP10HJtHIQFQniKmrQ+eVqegvqRA4fgLx0/pEt5PL/np4yEWj6YjnEu0VaJXbMmw==
X-Gm-Message-State: AOJu0Ywkid2mUKNvuabnc5n8Mwu4zD7Ebe1f777A0EGPZK6fXtjrb44i
 rXwH0jtiVgPDsJZNJFRQPGc64LdUx5KdmHqw1lKOKmJ4STtF0cpRNFzhZYijfz3G0K5FHIdB79O
 DpnNbdjHwrxghrqkozxNUMaHMLPRVOWwv8rL3ts7aMjJHhzWr/ucTP5VF5GAbmTFrCPg=
X-Received: by 2002:a05:600c:1907:b0:414:3713:e9a2 with SMTP id
 j7-20020a05600c190700b004143713e9a2mr11093663wmq.3.1713855424895; 
 Mon, 22 Apr 2024 23:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFls7bdRisXisobghFNOCc68+t+z9Vw43EytEcpGpXt2ydquh2fzju7KQqZ4zf3hXEM8jvHxg==
X-Received: by 2002:a05:600c:1907:b0:414:3713:e9a2 with SMTP id
 j7-20020a05600c190700b004143713e9a2mr11093633wmq.3.1713855424370; 
 Mon, 22 Apr 2024 23:57:04 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c138b00b004187450e4cesm22817429wmf.29.2024.04.22.23.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 23:57:03 -0700 (PDT)
Message-ID: <d7f544c9-c779-4498-a012-12535bdc1d3e@canonical.com>
Date: Tue, 23 Apr 2024 08:57:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: address coverity report 492766 for dead code
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240423053806.4962-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240423053806.4962-1-ilias.apalodimas@linaro.org>
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

On 23.04.24 07:38, Ilias Apalodimas wrote:
> The check of the return code is already done a few lines above.
> Although it doesn't cause any functional issues, remove the superfluous
> checks
> 
> Addresses-Coverity-ID: 492766 Control flow issues  (DEADCODE)
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   lib/efi_loader/efi_var_mem.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 940ab6638823..139e16aad7c6 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -232,8 +232,6 @@ efi_status_t efi_var_mem_init(void)
>   	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
>   			      (uintptr_t)efi_var_buf;
>   
> -	if (ret != EFI_SUCCESS)
> -		return ret;
>   	ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
>   			       efi_var_mem_notify_virtual_address_map, NULL,
>   			       NULL, &event);


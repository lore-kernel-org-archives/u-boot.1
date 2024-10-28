Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B710CD5B156
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D780890A9;
	Mon, 28 Oct 2024 22:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kPUZ4nqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6EE890E7; Mon, 28 Oct 2024 22:25:05 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FD78909F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27F3E3F2AB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730150703;
 bh=G8P8v94lzJBZ5DsPdqHDISbod4v+z/ZSdqEMbyAIIxs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kPUZ4nqdcbVzZPH3EHxOtQppWupu+CBcVtEtm/n5eWBqxSxhre+tvO08zhIWcl6/+
 iTDsFCBiHUjvQN5MO6cSpaPsRT4CianIOoxWGzcGqjpRDIrgFUVfBlIr43dzsfSlSR
 pCbnD+YrHoic6ki4ChTrJZvrwAXR/D/KVsXf2KdLFfkPha1SHR7wKWVqsvwGiku7Gz
 sclDe/YQD8jare+3pZV6w/BuiRao5rzf31w4NGsl+4z0p0xiuex0qvptyA99j+VZr6
 VQ+fS0F+IZ8uPtS3zzVKCHN1gpZB0rDTSQP0LNGsxOK6TOFvpXKpHoGnTKVxE8BafM
 Go/MeHGyRlkNw==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a9a1828916fso575385866b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 14:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730150703; x=1730755503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G8P8v94lzJBZ5DsPdqHDISbod4v+z/ZSdqEMbyAIIxs=;
 b=oK9vOdAdYUxg7BbF7CE/Hq/YUEQ+XBjGRRaunMoIGxRZNgbRrWL9OuCwLdzyEYuf16
 Y3LnFWxDEqT1ri70Gce/36dGLpVQa5x8ZqOYmOtcIox91cj9t7oDqyMZ2reEfP70sA9n
 AisJxZ4s/Vg5bJVp7QJYCWDsUaa5e6UXHkOFcLUqtCA+N5waPCtrbH3HEXm6p4BrN9Mk
 2+rEYQTOYY4mo+9oW0NNDLi/MDgXkdrEgXqg5CbkqIK8WXpOoL0rOUTdO8f0zK+1nAC7
 2HUnDyPN96UThgdu+8uboZHUVKlBiScoGUC1oFnDly5GgUK0rKBvglncmXGDwsXGLadC
 fzaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqd27N8V7lgRPcDb/uCYOqZNFyl3Sj2iVEMFCBPQFBe3/MT72p3/vcB4XUdqPza2Po44LOM3I=@lists.denx.de
X-Gm-Message-State: AOJu0YxEXcPLAR4R4gtFNgzSylt3jVqXAn2z+eXF6LNj1cr+yCNMhIHZ
 8T0esWW9LtUl8kW3YGIcCgJAry6wl/m1mzTeWphhdYQ9t8IHLIuCoX1HCyrs0ljuwjKteq9pUQs
 rrTUgPPnkEZkCYqzyUDl3bR+2j0LnAzewOdK8ox3+MEN5w2ePGedQxZ9Q7eMkXnbglIk=
X-Received: by 2002:a17:907:3e84:b0:a9a:a890:9fa8 with SMTP id
 a640c23a62f3a-a9e2274c1ffmr99708966b.11.1730150702698; 
 Mon, 28 Oct 2024 14:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRtomWpDBfP7jmwd5IgboImlT8FZcpqW2PvNXuQv9CF3wKgcft0pmNEDaoON4zJlUxlFiqCA==
X-Received: by 2002:a17:907:3e84:b0:a9a:a890:9fa8 with SMTP id
 a640c23a62f3a-a9e2274c1ffmr99706666b.11.1730150702315; 
 Mon, 28 Oct 2024 14:25:02 -0700 (PDT)
Received: from [10.43.6.224] ([87.215.50.114])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f29737fsm409350866b.113.2024.10.28.14.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 14:25:01 -0700 (PDT)
Message-ID: <7eb00a6a-bba3-4aa5-ba63-1da2c63b3e5f@canonical.com>
Date: Mon, 28 Oct 2024 22:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] test/lib/uuid: Make lib_test_dynamic_uuid depend on
 SANDBOX
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241028164844.2308549-1-trini@konsulko.com>
 <20241028164844.2308549-3-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241028164844.2308549-3-trini@konsulko.com>
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

On 10/28/24 17:48, Tom Rini wrote:
> The dynamic UUID test checks for the sandbox specific capsule UUID to be
> used, so we can only perform this test on sandbox currently.

The tested function is gen_v5_guid(). This function is used to generated 
capsule UUIDs. It receives the test data provided in 
dynamic_uuid_test_data test_data[]:

* compatible string
* image name

The generated UUID is compared to a UUID provided in the test data.

By chance the chosen test data contains the string 'sandbox'.

It is not obvious why this test should depend on running on the sandbox.

Where did it fail for you?

Best regards

Heinrich

> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   test/lib/uuid.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index d00e9563a472..55ef9e7454d7 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -84,6 +84,7 @@ static int lib_test_uuid_bits(struct unit_test_state *uts)
>   LIB_TEST(lib_test_uuid_bits, 0);
>   #endif
>   
> +#ifdef CONFIG_SANDBOX
>   struct dynamic_uuid_test_data {
>   	const char *compatible;
>   	const u16 *images[4];
> @@ -159,3 +160,4 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
>   }
>   
>   LIB_TEST(lib_test_dynamic_uuid, 0);
> +#endif


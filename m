Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE82C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 03:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7588288055;
	Thu, 22 Feb 2024 04:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMVTIQCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 207B68805C; Thu, 22 Feb 2024 04:15:22 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC5C88028
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 04:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-781753f52afso423679285a.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708571717; x=1709176517; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t+C+9komLN71OZZznM69kyzyiL3nMhb6D3s0IUP4XYs=;
 b=cMVTIQCkkBT+PA/sQD8EQmc96LewLZvwXuPVRgdLyKRRFa5FtNhb9CveeM+7tpKZpF
 eNfcpR7QhE4p0R1m6eIrecPfDCnF4SGbRhy7akppO76fAGRcaLHAcKFTH3Q8Hvjn0ywC
 1TGG57wqgeesSXyUe6Wb5ch/nMXq2IYo3YbUbiwESOqGev8e/yB9DSlmFVdinsgoso9q
 rreFhC18n4VOWoGkUg5U7ZqFfAFw86kCTaMprMqWKkVPsNG6WrHG10cnxXjB+x9Rqi87
 uu3YD3HQ0fHKqROp7Ib3eIYs5vQ0ozNe9q8wjgE9EBGbhqINwkPL6X6Xv2r7Thtf8URi
 zO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708571717; x=1709176517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+C+9komLN71OZZznM69kyzyiL3nMhb6D3s0IUP4XYs=;
 b=IjxyiSEGkgRSsCGqj8NjG6E6HgjcvBpqTwAtQn9+8yx/HUXOiK1nnp1bzGGeyKD8nG
 0NNITVGl+7SR2MloSV59dX/okIExHN4n8fqwe1x9vyHcVJG7IoH0wAsRMK0EP8YHbmDF
 kiEuhHZtWhzbkuVTZuqy5FNkL36uNeVPi5k4fcI+8eQrcZAOGJLXJGjq46zX8C1okZG7
 fD/rVhmKgOufw12Tvz9M1SoXQ2wXZjLpUSebscETzNvJ537g5krzEL/eSwQNEnjnkoXd
 3xiHJ+yVZmPyr2zzIyt7ypfm5nFVagSL8GxW10RZ6hDMFiPuRqb2+LvDn7Tt2L36u2S9
 fMHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP8Et7Zhm+TpDHf4Lc/wsNJZyWcetW1IHJvm9LuxllOFGQh0UaoUvAYvcjlseadJSBs2s8oCiMLG38sojhMiNOEoI6Nw==
X-Gm-Message-State: AOJu0YxfNpVACEjwCLClB9WKL5ig852HBdzkX150MDHN8/VfCDGUmyey
 VUVtpVxLv93UZw6j/vUz+ijPV3NRbDG1OvoTvw3xvl/bQtrf/RSG
X-Google-Smtp-Source: AGHT+IEW8nfleXVQqqlHRcUSrWZ33b5LgSlNFlGlWajqEdQBRA4KsDB6whomsZQsHPQ8F5drmLKyTw==
X-Received: by 2002:ae9:e106:0:b0:787:1e17:ed8b with SMTP id
 g6-20020ae9e106000000b007871e17ed8bmr22315363qkm.60.1708571716695; 
 Wed, 21 Feb 2024 19:15:16 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 o28-20020a05620a111c00b00787a1c74595sm32957qkk.105.2024.02.21.19.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 19:15:16 -0800 (PST)
Message-ID: <89c12695-9c71-7162-a9cd-9e2172ce6a2c@gmail.com>
Date: Wed, 21 Feb 2024 22:15:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ecdsa: Avoid null pointer crash in ecdsa-verify due to
 absent property
Content-Language: en-US
To: Bob Wolff <bob.wolff68@gmail.com>, u-boot@lists.denx.de
Cc: pbrobinson@gmail.com
References: <CAF1iuRpqKhsDdkmC1jM7gK41JzhwVTKeh=a7Wtixp6Vz4M8Fqg@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAF1iuRpqKhsDdkmC1jM7gK41JzhwVTKeh=a7Wtixp6Vz4M8Fqg@mail.gmail.com>
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

Hi Bob,

On 2/21/24 19:27, Bob Wolff wrote:
> If mixed rsa and ecdsa keys are specified in
> dtsi, an rsa key can be sent into the ecdsa
> verify. Without the ecdsa,curve property, this
> function will crash due to lack of checking
> the null pointer return.

You can wrap commit messages at 75 characters

> Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>
> ---
> 
>   lib/ecdsa/ecdsa-verify.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 0601700c4f..01ffc3477c 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -31,6 +31,11 @@ static int fdt_get_key(struct ecdsa_public_key *key,
> const void *fdt, int node)
>    int x_len, y_len;
> 
>    key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
> + if (!key->curve_name) {
> + printf("Error: ecdsa cannot get 'ecdsa,curve' property from key. Likely
> not an ecdsa key.\n");

this should probably be a debug (like the below message)

> + return -ENOMSG;
> + }
> +

and it looks like something ate your indentation

--Sean

>    key->size_bits = ecdsa_key_size(key->curve_name);
>    if (key->size_bits == 0) {
>    debug("Unknown ECDSA curve '%s'", key->curve_name);
> --
> 2.39.3 (Apple Git-145)


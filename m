Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24179C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 01:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D79787E91;
	Fri, 23 Feb 2024 02:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U1PLbJDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0946887ABC; Fri, 23 Feb 2024 02:24:37 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AF6876BA
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 02:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-787a2e56b11so19674585a.3
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 17:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708651462; x=1709256262; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9gPJb19fOmO6qn//mhX0qXVmlgABil9sw1I0CnoM+RI=;
 b=U1PLbJDZgDiOTmSrCHJ8ddK9hShZXPWXcci5FOsgdufiDXryxL4fps+3c4OaSqaydq
 +B0by2XI03I33tDqxamoEFHewF8w3JYQVwLD/nvWoJmLTKToVfDGUF8VLgvPtHsOqkGu
 +PBTB9Gc/97UsseStBERWP07nQJGTBwBPpOaZNyiaNQINk77hjbI5bwq+f69oheQvzIM
 NTbIwU+0x/2L8eeMkkQbVYGf1MbuVi4iJpK9MhhNBu5mhafra/hYLdpf+Qb2wtUZ7ZYF
 UbVtPxn1qjmu6j9lx8t26yJnDkyg5wr6eDOag0oqJs6kJaCqNSQwckmYXkqdVGr65aAw
 ikfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708651462; x=1709256262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9gPJb19fOmO6qn//mhX0qXVmlgABil9sw1I0CnoM+RI=;
 b=Tfx9rbF4cqeHldiGu9U4wQaYxDd75WYKgUxoxRmgk0LgY09Lt4RmtlOkQcWgnCoqVq
 fvg11PldYow01X6RTDKYDew7QD25Jn8+DQla7jbodhUIIKdiEI85PkM1aDIlA3MvyctO
 EFW3EoqBJzHu42unUxD9CDEiDHXsRwgNT3lk9/80IXxyVa5n4LDAXlWZry5hBhdHEclc
 AbO9NAnn4SroOb7SGJ2te4aq7qABmfZ4ZzYfrXlbXDjxDsXujohNXZvmWq0dTNgIZ8qA
 wOVIBSHK+bS7rxvyHhm4V8v8DuiF7qJfMFw7aTkpkdF03Lzy0MQ5kNRrQ2zKWokbNUHY
 tGvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOHjdLvtqCRQDSb9OmTrG/pi8PLY8y1/fTeZC/7i6Gddv69elkc1iEzfalGxxIMwXryWGNY97cIxX7S5ebMY1NF67BfA==
X-Gm-Message-State: AOJu0Yx9tsyp++j+nVgKw5whCDsVB5Tqz2WP+BFqv+hajdHio0xIHovP
 TPd2s5VPgYkO3aN3jCzF2zKTNPBipZbolwkuDji4VrvkqOD/Gxm1
X-Google-Smtp-Source: AGHT+IG+LI477vhO6RrDL7vh+ZNYumqPHe4nnC6dBPsbb3jNJuFSzt4jm0Llsvr1CFP1peumIskzwQ==
X-Received: by 2002:a05:6214:2b05:b0:68f:58d9:77aa with SMTP id
 jx5-20020a0562142b0500b0068f58d977aamr1058759qvb.30.1708651461983; 
 Thu, 22 Feb 2024 17:24:21 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 mc8-20020a056214554800b0068f11bec5desm7514221qvb.78.2024.02.22.17.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 17:24:21 -0800 (PST)
Message-ID: <801f58e6-2b23-8a85-b3aa-fb81f4fde2a4@gmail.com>
Date: Thu, 22 Feb 2024 20:24:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Check curve_name for null to avoid crash
Content-Language: en-US
To: Bob Wolff <bob.wolff68@gmail.com>, u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, Tom Rini <trini@konsulko.com>
References: <20240222221814.3496-1-bob.wolff68@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240222221814.3496-1-bob.wolff68@gmail.com>
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

On 2/22/24 17:18, Bob Wolff wrote:
> If mixed rsa and ecdsa keys are specified in dtsi, an rsa key can be sent
> into the ecdsa verify. Without the ecdsa,curve property, this function will
> crash due to lack of checking the null pointer return.

nit: there should be a blank line here

> Signed-off-by: Bob Wolff <bob.wolff68@gmail.com>
> ---
> 
>   lib/ecdsa/ecdsa-verify.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 0601700c4f..4d1835b598 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -31,6 +31,11 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
>   	int x_len, y_len;
>   
>   	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
> +	if (!key->curve_name) {
> +		debug("Error: ecdsa cannot get 'ecdsa,curve' property from key. Likely not an ecdsa key.\n");
> +		return -ENOMSG;
> +	}
> +
>   	key->size_bits = ecdsa_key_size(key->curve_name);
>   	if (key->size_bits == 0) {
>   		debug("Unknown ECDSA curve '%s'", key->curve_name);

Reviewed-by: Sean Anderson <seanga2@gmail.com>

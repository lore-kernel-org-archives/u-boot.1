Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300CCEFD20B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 09:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7257583AA9;
	Wed, 25 Feb 2026 10:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fMAbvK1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C7883D77; Wed, 25 Feb 2026 10:06:17 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48BC82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 666BB3FA7A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772010375;
 bh=bp7xhJg3OGOEZQh+mwC4P6eFhUBktpB0iVBu0FraYGo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=fMAbvK1EfSO1AxJb9AotKwYEXc7b+KS+P3HwIJVK3QOG7vLJbqYuJqudkgy9Ov3sg
 M835kOysWNJWNePClT8FBFXka1wilfQgIGh9AOCYaNiBCNWSiBQ72BvEi0tvyjnq/h
 SiNeA1krafwEZpvBnf4kLP69S/uu0KJrGOtcK0yyr6dnO1w++/Y2Im4nTfCj7WkGnX
 LNkB6lTPNBy5I39Y6a7I8cvIr9JIM995W873h0zi7WlNnZ7Glfc+ajLhsAbU+01+pA
 0B6gO7HjPF3AoBZI9gSTSRxhHlKRQknr4GOezk8/U5jBjrMIMx3MQFxne+MDf7Vlxs
 WFtb3N9/USABpoe0TYej8FxINQg/4tYNHJGiicSkiyVGt1UJ43C9k3OEJP4ZocUBGe
 j9xeYOez34Z6clFK+OWod8Caugj54etcj8Ki0hs3P8GQaXjw/uCUlJPPNRy8+x8py7
 /LwgLxvzBV/5gQsozHCNlZJWT5JnV0Yw1XvGc8agWt+EFd5v7OvcTrPdvIwoWtggqL
 DlL2e3pt1cRxU98+w+hrS91EMgyicxJN6hTJfW3SMv3+YKXJxa75avwYrXtyDTnhq8
 9ilecHurvb8nHOTVFMmXRrblESKfxwkjGYiE8CMmjmTF6/I7mdtrSWXJToA/3f8rB1
 cTwtn/dbGx89q07bDVte2kUI=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48379489438so72300365e9.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772010375; x=1772615175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bp7xhJg3OGOEZQh+mwC4P6eFhUBktpB0iVBu0FraYGo=;
 b=nZcIUGMVaTnGKIUZWYi8WA2z3kiXaKIBgRzyMECOcY9RsvyVAXoSlpY0010dSBH+++
 ACLGCaXV5JXQT6ZPGnLwFyVRX3jCP/U9uRPvD4r91v76vCXB7ylPsrUXro+jCekS3zsl
 2AOBB8SM1N3FUqNhKhCfagsMLP6Yb2RaxkYndrK7luzyddfi1tqQkTE39pYpbEMvpymH
 W8bQ2kx+HSXPFi0NgQLS8Uq/RHACmTF3/t5nADzV9XPB4TAdIF4rgkg71RnOlKnvxc1A
 jteCQTeO/VjMwD1dr5yoM/6vKrNTgoeRaTFioD7I9TfVP8UNp+ksU6TTEGKpMcW8I57m
 CdiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtwfrtrzabKZ0+29kxtFLD+f53pOb0QYa7yBOEIYteqIQLFBocZxEa3KKo3DXWbPx+LqkOPc0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+4A42HJ2Y5f1PxeMtkRE0sgv7jP7EdZtoLjQZxT39NT4T3GS5
 7cdXarViUupg0itfhenIFLB+D/7+gMTXJ06cDdQYQfT+Nd3o1DrAjiz3/D7xjaMsyHYyrsBiUCy
 0qAE+D+cHD0IaYcXWz2pffoCqs1IzJ5NQ2SP6BxiSTCqbQ/BCxrnCDDHDJDLvw2R/4EorpiQ=
X-Gm-Gg: ATEYQzwRthcWRFNiOO8rQUrMWZT9NQ4wwyjN4qN+QuA1AE/zJINoJ7NZ7vONCxIaVHX
 RMTkQ71GH2mtQ4tBLelWT6UN9jmmxOayQ3vaE70POH9nTUpWKNfUlVZiDwjuaKOA+OWdNYK/08A
 hDUXZgZeKCEJwmonhK9rmkH5yaOGOiSOTkGcPFZL2/QQPQdCd6imfIzG+ff3OdbNwuq9BMVsBXT
 x/8a+PXsd/5PKiReBUcQZ4ZqgPR7S+5Z1Z2KrOt9XqkXXwsNByj6i0jXYZevjT4MZAKSubcWnDR
 fxcipybz9ThnyOeoERwPq5TvKtb5+7z1J3F15Ajl6g4OP9hrCQc38NDnUz2ajNK/KBH+e8HV8YU
 36yvXjbGasID+z/GryRFm8l0tCQldsnznlCAmS4XkOg1u0quuencJwlujoM62gfRvkQcrg3J6Vo
 oXeY/BnIbdD+aewLWF0s1+envQHMLvhSdWKb4Rs+W3X7seO0sIsj4=
X-Received: by 2002:a05:600c:37cc:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-483a95bec82mr272295265e9.9.1772010374872; 
 Wed, 25 Feb 2026 01:06:14 -0800 (PST)
X-Received: by 2002:a05:600c:37cc:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-483a95bec82mr272294695e9.9.1772010374365; 
 Wed, 25 Feb 2026 01:06:14 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb789efsm13345775e9.2.2026.02.25.01.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 01:06:13 -0800 (PST)
Message-ID: <e9d98d0b-578a-41ef-9440-00ea615d224d@canonical.com>
Date: Wed, 25 Feb 2026 10:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
 <ee169196-69a3-4003-8531-0ffa4e76bf6b@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ee169196-69a3-4003-8531-0ffa4e76bf6b@cherry.de>
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

On 2/25/26 09:37, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 2/25/26 8:37 AM, Heinrich Schuchardt wrote:
>> Symbol CONFIG_VPL_CRYPTO does not exist.
> 
> Correct but I have a hunch this was based off of SPL_FIT_SIGNATURE which 
> does require crypto support, so I'm assuming VPL would too.
> 
> But this symbol indeed never existed, and even if it did, it wouldn't 
> compile anything else as far as I can tell since drivers/crypto is 
> enabled by default in proper and only if CONFIG_SPL_CRYPTO is set for 
> SPL, and only SPL (checking for !TPL and !VPL)... so something feels 
> unfinished with VPL here to me.
> 
> I'm not sure we're improving anything there but I don't think it makes 
> things worse, as such
> 
> Fixes: 4218456b3fac ("vbe: Add Kconfig options for VPL")
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Thank you for reviewing.

There is a symbol CONFIG_VPL_MBEDTLS_LIB_CRYPTO that might be used but 
then VPL_FIT_SIGNATURE support would have to depend on MBEDTLS.

Maybe Simon can inform us what his design intention was. Adding a 
defconfig actually testing VPL_FIT_SIGNATURE would be helpful.

Best regards

Heinrich

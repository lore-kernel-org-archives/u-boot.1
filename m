Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733ADCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE682839A8;
	Mon, 17 Nov 2025 11:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OKEWjQh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7519283A79; Mon, 17 Nov 2025 11:55:37 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A81839A1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F04123F628
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763376933;
 bh=asJZRBw3lJV+AlcomqG6mn8aYteBHBxsdFQmH15RjTs=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=OKEWjQh+3F3s2RpxLcRBtvMYdV/9ZDOvmJKZBsD//4o6KI5T5K1DnIgwQckTeTWpE
 rMPo6cn8Ezzfn1Wvv9q0eoDcbSVF5iI+iUAmK4x2/IwmP8FBvzygVTXekfhPbggEuv
 XbmN/SzWECuANf2BkymRpjUZdSm3IBur/FlqYXkLKTEmRTi/Y5Ioylhok7uG5jnasi
 7LBiZUQzxW8BcS6vn7/30BEGoBtSQA9BL6Eq/QBOQqw7WcBSapbdZpLt5IlswLeagP
 proYt2/OdNYMowGnHNuwfeaIc0+ghm38aqXefZQE/6MygIneW3X+Xoli3QeXo4MsMp
 zYJ5ufZzVMUL8ojjfgwzggHsDqu3OjSWZN4hiLa79mzpH4hA0zPSMiE/Vi2wxP/Djn
 sBPDdp81CLz5e7mdP2KS6joBn4rFCVIPToZcUceaPR4s1zijj4cJfGtdNq4FJL5Tkj
 7wrGMKObIFn/LMejYT0iY0/Il4+slnJ2zlSikzA26bMyNPsM0uPG1Bt4jjWjmCknQM
 FglP0TeXyL67aZgK6W7Lt0zUBOUZQUYAvc8SAogMtWiZCrKaFh+lZj4MkL2Y5jP0BA
 63vnJGhbDDyz3DkHidANQtNJy4vx9kb/95PGfvbUInKdVf+LdUd/9P/kV017L2mWJB
 k8+cwQI8rlbl+G+hK05g+kZQ=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so2768981f8f.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 02:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763376933; x=1763981733;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=asJZRBw3lJV+AlcomqG6mn8aYteBHBxsdFQmH15RjTs=;
 b=i6hlMKjzUKjXCdkj/amuaZVww4Qb/jaR+SnDaKwsjsapZuqlRfyw/94/v+y4cwoI0U
 59PiYUV6/hkwaXCRBBP2i2g318WuGNLcTTzs/e5WUg6aKLKZff4k5ihopLjASE+bwdsW
 EjJ3M1NF8hmGDIsTjsldUrzA3e+5WfzGeJkzdyjyms1OcRXHjjK0MGXSPkcEAGCxyuQ8
 oTDd16Owt4A2hqZxjZi0ZlqrSsTk3akSXOVS89sYYujYcYg0qKczOlMHWfv/Ktu82LUD
 Q46IqEghcd6iSPpjhL3KlhTrruXMi9raGX9OIwYtSRcGIt33zSe7OqV6UaQeVcJzimSU
 pKYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3N7+jLL/J8m5Lma5YBeKPT51h73Cr6y0eTdyWTilm/xTGhWu9uMy3GfIsUpaYY1Cp9jof0BY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw09yejkJqqTN0tPr9PjGmFOjMHwOj2SSQK+xoiQUWUewVpYi0i
 jMyBcuTH5fcqOyAgN+Wx9Soq08T/SAhyZ4lt1DfSdTa1eQVY+iawGj3Uk+IyrNgXvBmSCNeHa4m
 urKHeb+Vn2XFWTwbyjYyHVeF5lg9RWsieGOGA57lbro+FXX7VoHCJb8llANpNpgbXG0LWWxs=
X-Gm-Gg: ASbGnctgd4bXGT2CBeEsvNTqOeJyBsLfxZSJ8rCKQX6yABcXT2582gcYa9GpUdcbYYe
 b9vtqqCMK5bAl6gqzfs3fKcmMsbRszNpS9Morcfaq5GezcZHYu/WQnq8hfX/Y97q+VQwg1NqjCf
 kZ+m3o6yMeOh9Q5dOoCQv2mT+5kOyORRpjL9HVOolDIAAoitUj25srn3Oa1tex4RgactuHkB+07
 hYESZ4nwtsf6vAwounE2V3oKGugM7Tjg8k2Z0gdtMER1oMB6bLZp8O4IssBYKuNQxNYw6sb+/VW
 HYM1a3C75fBA1BiE8zkybQVi9Fwl1Nrk9MJxOfthSKIdWeKWXf0g9H2MTppCe+mQfZ7qhEnVtfT
 E+IsDOrX8Cwn31DkfRIyPzPUxkcZ80LOlUaTbIqq9cCYfHni5FXksFAs=
X-Received: by 2002:a05:6000:4186:b0:429:d19f:d959 with SMTP id
 ffacd0b85a97d-42b5934d6f1mr10457349f8f.15.1763376933526; 
 Mon, 17 Nov 2025 02:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj3RJypO6RlvOSzOvbYAQDbrraZxZ+1uGhjPxwwYOwI4enEgoGTWe6ShakpW41HCvFFoFanQ==
X-Received: by 2002:a05:6000:4186:b0:429:d19f:d959 with SMTP id
 ffacd0b85a97d-42b5934d6f1mr10457317f8f.15.1763376933095; 
 Mon, 17 Nov 2025 02:55:33 -0800 (PST)
Received: from [192.168.103.118]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae5bsm25513651f8f.8.2025.11.17.02.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 02:55:32 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <86bf47cb-60e2-466a-a471-b08ece0efacd@gmx.de>
Date: Mon, 17 Nov 2025 11:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20251113093313.362055-1-kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251113093313.362055-1-kory.maincent@bootlin.com>
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

On 11/13/25 10:33, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> 
> Fix two memory allocation bugs in label_boot_extension():
> 
> 1. When label->fdtdir is not set, overlay_dir was used without any
>     memory allocation.
> 
> 2. When label->fdtdir is set, the allocation size was incorrect,
>     using 'len' (just the fdtdir length) instead of 'dir_len' (which
>     includes the trailing slash and null terminator).
> 
> Resolve both issues by moving the memory allocation and string
> formatting outside the conditional block, resulting in clearer code
> flow and correct sizing in all cases.
> 
> Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

Please, add

    Addresses-Coverity-ID: 638558 Memory - illegal accesses (UNINIT)

so that we know that the Coverity issue is resolved.

> ---
> 
> Change in v2:
> - Extract calloc and snprintf of the if condition.
> ---
>   boot/pxe_utils.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 038416203fc..7549a93bdad 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -473,18 +473,18 @@ static void label_boot_extension(struct pxe_context *ctx,
>   		else
>   			slash = "";
>   
> -		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
> -		overlay_dir = calloc(1, len);
> -		if (!overlay_dir)
> -			return;
> -
> -		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
> -			 slash);
> +		dir_len = len + strlen(slash) + 1;

This line could be moved after the else branch to simplify the code by 
avoiding separate assignments to dir_len.

Best regards

Heinrich

>   	} else {
>   		dir_len = 2;
> -		snprintf(overlay_dir, dir_len, "/");
> +		slash = "/";
>   	}
>   
> +	overlay_dir = calloc(1, dir_len);
> +	if (!overlay_dir)
> +		return;
> +
> +	snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir ?: "", slash);
> +
>   	alist_for_each(extension, extension_list) {
>   		char *overlay_file;
>   		ulong size;


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DF1C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9605D80104;
	Wed,  5 Feb 2025 18:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="bB8EQ6VJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FFA8033D; Wed,  5 Feb 2025 18:10:23 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1E18003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so69948245e9.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738775419; x=1739380219; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nFHRn550DXPQ+EmgyYlUAyt0RWH5sIgwG3JMTjsfNnQ=;
 b=bB8EQ6VJfqlGD/zGpFoczw0p0MkvfF0e3vZI+RKAQUbSfxWL43YE9k0+PgpA/LbJGU
 NdC2vfU57z/e7ZLGcZekXS6rFufHc2gvOqgHK782cCXlLvOIiDVLVDpiy7ulQxSsLR0u
 VIvaa/swS5mzgDDSSUB6UaN4bdPy3vOIkC3SUH43RqyvENB94J2qGN9pwhie5Id0WPcV
 Mn8bG7oz67MDUNMkxK8V/mT15hbh9dUKajtUMF9dLMMGjv7JI4g0iEgyW7E0voSmGeTm
 7zO8XokpOXg1FNZIxesWenkVBdfCCrfifi6Aj/nST+Hok789pffUS8BBKue/Ce5m/l+X
 ZrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738775419; x=1739380219;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFHRn550DXPQ+EmgyYlUAyt0RWH5sIgwG3JMTjsfNnQ=;
 b=FkEDcvE31VcpL3lkmUiBVeOSgAsq0q4hPU1T8GokQaC5s5Vx0cuKuB0WORwKtoTd08
 il8KNL9D/SBKUfBAWOssSBT3/Q0gJ13Ahz9ww6s244mHk5GeAV8RQKRzVORNg2sQi7zm
 InTY/ef/u7E+dG241tTPdkv9ndvSqJnG76msTf18Rz5vZ1/yS2GQd9mVg4lRo4MmQ3J0
 fipuupsh8iXS51coIwf+KBsY839u3DDcTKNu8Huvda2qhA9t8bDw4oBQ+XMdOXtifuDY
 7YgHqAQt88eUwhynbH3T1GC4YM3oaLe8/oZst++aCdXlE1stl7aMYV88bC99UnLdNdYE
 P8Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKf2vPAU/xdvZQA/HALfMbLlR5kVKww5g5YNa3b+flIt+BEq6C4fl9t+Yh/vpm7Sa/f/JDzGk=@lists.denx.de
X-Gm-Message-State: AOJu0YzDe4O1BYB5Xt05ct5AvDM/iNI4QBaSEslBiVKpsShyDmP63pI+
 cFWMD8dpRdoTVbSctMIDkZ3GL73I9nf/FgEXrIEps6IY4nMbkVjKYPeRKiYNNpw=
X-Gm-Gg: ASbGncuB3bObDzdmTouAFVgbrflysLQ+kaDhCJDf/clAfLSMxLEREkkxV1l3Tf82Xas
 +xzoa5aqt7Q26esJfO/s1Mgp01kh4gRC75CFsmQq3KS1dcJOyXC8Wyx+O17gpQl/k2dNWkVFTkR
 Nrw/z0IV76mE2d/H64Mtk9J5JzrXS7qgOdx2mPdUhHgO9nGJ6MkDcjI0wTH/hLa1Zn5g1S0zJKB
 Th9LpZn+D6lmOqvQxAhgPP6rtWpgHz50lJDndKnkXwxn/na91BfwIVdfu8jzlbTPHmYNJRlynhB
 sU6lMgJqE5C0z18=
X-Google-Smtp-Source: AGHT+IHmPbtk1CfICOwF90kBKMsVlK5jS3PB+Ebo7Dmpt/NNGJUWmgsInkIUQgdjjmqE/tAWWeSHbA==
X-Received: by 2002:a05:600c:1992:b0:434:a94f:f8a9 with SMTP id
 5b1f17b1804b1-4390d56c1f9mr27168985e9.28.1738775419270; 
 Wed, 05 Feb 2025 09:10:19 -0800 (PST)
Received: from [192.168.0.31] ([37.223.143.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf896sm19913375f8f.94.2025.02.05.09.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:10:19 -0800 (PST)
Message-ID: <94185012-c67d-4ea7-9d4b-4f5f65f7712b@suse.com>
Date: Wed, 5 Feb 2025 18:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/32] lib: Provide fdtdec_get_pci_bar32() only with PCI
 enabled
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao
 <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-6-sjg@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250203174245.1331464-6-sjg@chromium.org>
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



On 03/02/2025 18:41, Simon Glass wrote:
> This function calls dm_pci_read_bar32() which is only available if PCI
> is enabled. Add this condition here too, so that the EFI app can build
> without needing --gc-sections
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> 
>   lib/fdtdec.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index 3b4247be25a..0244e8a3a72 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -248,6 +248,7 @@ int fdtdec_get_pci_vendev(const void *blob, int node, u16 *vendor, u16 *device)
>   	return -ENOENT;
>   }
>   
> +#ifdef CONFIG_PCI
>   int fdtdec_get_pci_bar32(const struct udevice *dev, struct fdt_pci_addr *addr,
>   			 u32 *bar)
>   {
> @@ -264,6 +265,7 @@ int fdtdec_get_pci_bar32(const struct udevice *dev, struct fdt_pci_addr *addr,
>   
>   	return 0;
>   }
> +#endif
>   
>   int fdtdec_get_pci_bus_range(const void *blob, int node,
>   			     struct fdt_resource *res)


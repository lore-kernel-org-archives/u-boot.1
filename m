Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1356BC79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B04440A67;
	Thu, 10 Sep 2026 12:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llHTv4gPwwye; Thu, 10 Sep 2026 12:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A89A640A55
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789043762;
	b=YDfaPAn+X9vlpTzLLu3Rh4RObDw+JxffTg8NNvdQ3Ff6v7tNfofL7Ncfs+N0j501fhSJ
	 ZW6BO+jby8QfAQhQYdwr/Isl+wtRjXVv8Lxw3sAZoc6QJgteUPrRYrTPl5yXRjUogB/dK
	 xWDkTNdliZ8/KTYLmN+k6oNloGl9jykzfoeqAsxD7nGdW+ZbRNO1jbGbbYbxIFfj+0Vup
	 ghPJ26lXp9N8g+kJcHziMyX2GFU0Yu/ipPqcBhtdAKY/FhlBiIjLzyMKIYXsJHP3UKBTp
	 aR4egKwTMuJIy8aCX1+e3rMKx+p3hbs1BehDmoG5QmcAwmoKtYqTAAKRNH0ALU2ENog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789043762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rFxi++1uo2N2nKvOQrvgJ41PRPRxMHX+KzgtflsfrjQ=;
	b=oxObHTc/roQ6h23CTarf94zSYmQZwEQbaH+vHcEP9F6FOTsOWZ8VHg9Vwo7ZSB0LDl4o
	 q2RUe/uUcVObb2J7E2ireKSk/ziY/sUiniUhhhi8llMa+KMZrs+JCoA6xiRLZjP6PsxX2
	 8LK2QKSHH9T0XyY1HUS69htxAGMt31I8aoI5DC8oqajyJakudbgQQhgNtLUs3SdDG7wHz
	 1+2suZvBQoIm7xNJ/Na2MTLdAdn2r8oJSgWkeNRBQaF/BA6QZ9SeIqCSkJcOInd9FaIK9
	 p83QbuabibGrY3wwhDdAtiwWgDyEbLEkV/EQY4reH5zQ5bF1HO0bgCXiRS2nWzqwmnQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789043762;
	bh=rFxi++1uo2N2nKvOQrvgJ41PRPRxMHX+KzgtflsfrjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AYy3mOlJmMAvL90UoOmpKpDeD9x+66l5HkVsWKY0rHbf+UWqPAFLyIlDKKS21rBW6
	 FB4pfyNGI/raYfJkkusLElTueJJCopRSxnjW1ls8h2mph18vlUogDpQdnkg5PTtUw5
	 qgFo8O0jVQxfqPlYQsrZ9bBoY/cO7JV5FI2pHqrTPgKkdHj8tlak5qe5QhMygN7P8P
	 c8uktOatDnkDhQkocviOUimLzttnet7MPko4x40prHPBJXKiWhZpC90oQPl5RidfU7
	 roMNNJiqkILiBQ/BM3yBCn3BEj3S4P5rNiYcsGsXsQTynDv4JO8kyXyFWo++17oj7U
	 3E+fpZ1KJA2VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A89A640A55;
	Thu, 10 Sep 2026 12:36:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F09349D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8581D80FC1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zQozEHEIiQZ for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B9C5F80FAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789043761;
 b=knNB+X9hOO/5Zic1TNLGxU1gRyiVYrgwyePZlpycDLAJHjvFfhcZqMnfV7jCDIT9XmT5
 eQvR5s9WcXuUenKOW3eYDOg8gpjooTTA6s8Z/oI9v+agj/cRramL0oKDBZeWomEMZMbrb
 66u5kjabHdz8xwyzy0FiC61BlL72Vne59EdVe0nUo7sG/WlJXbh7phAVXdN9edFtbp5dn
 v/6Zu5c9ePumYAhRlDbew5OTxCEFIQQV2W9g+FGYQGJq2urVEB9Uzv54gTPkRjbXvyEvK
 HDD0hnJBH68/GorNk4csRMxnaHOJJyn0QWjBSh14vsBIFPLNxp8IgMjj9aHh9j/YUzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789043761;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=rFxi++1uo2N2nKvOQrvgJ41PRPRxMHX+KzgtflsfrjQ=;
 b=WlF+8o4HFRWmaoaMbHqkSsoi+baAcX9UhvbLouNN7U313upCks0afGEBLYgv8v8rzjtQ
 134d7yYuv+qMAGIwJ0BgWilmp/ewhgDNgLDb/umuimRy+kmtnkS9vfq3G+OgXZqpKsgzO
 2ovy5qC/sLR0+UMc72S5O7U0fA3+urKB/sZv6ki4JcnUw/+5CErGREFASvdDOyhYmEDBE
 f/k8HsqjOyeoG6M0A+fS2iNYYmLCwhAWVhNs0D/k7g7YQeofgX/WAUmviX/8EgI4gcZcm
 YF1tut8VILO4zcfnfOOlQETT8M843J0kRMTOoSuCU4lkL7QNXCfbPos49BVB9EudwYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=J0bDtPw1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=J0bDtPw1
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9C5F80FAF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789043735; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lVTxH/vl79SKRIAOBf1IJSybT/VHQUS5aZpPg6n4j1IT81IIOV52VG9xnR7JzPDQsyh/FLCIKjquSXv6sAK2pok5FlVB8QEcBiw9gL8THGqJr9vQjIjNntHKqsu8Q+cHRZrzG6WTn/j21ciyC90m4OtxtwXIzxW1MbS1WoXxt+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789043735;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rFxi++1uo2N2nKvOQrvgJ41PRPRxMHX+KzgtflsfrjQ=; 
 b=TyhmqXLu59mBCcBsN5vZdnxAOZIGGd077pojXZ4HmUHacvxwF7HEZ9TWHSnLKxhAvQD3IKUITB+jNQVKIXit41GMhZ2jxeGpOvb8MerEiygAj+QXdzPc15/rOLNx+PwFqu9AgooDAr25ZP+aFnseiWyF+xrRTvj9iIjWWlYVRpQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789043735; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=rFxi++1uo2N2nKvOQrvgJ41PRPRxMHX+KzgtflsfrjQ=;
 b=J0bDtPw1y+wb1k6k2Ns+juSYg+xuWYy0tE5QpPe+EO/26GqmotwF0op8a3+QJ4Vt
 w6APRK2qSue1W5euWDGmKA6JCd108OYk4B6pZrqHg2WxEomFJT+4Wm8rO6Z3BJDFGAv
 6TSY+9TUqBHW7KeGPwFNVgykLtT8Jp/kL3R8zYx0=
Received: by mx.zohomail.com with SMTPS id 178904373201642.900811622213496;
 Thu, 10 Sep 2026 05:35:32 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:35:26 +0000
From: Yao Zi <me@ziyao.cc>
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 E Shattow <e@freeshell.de>, Yixun Lan <dlan@kernel.org>,
 spacemit@lists.linux.dev, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 1/2] tools: mkimage: add SpacemiT K3 boot image support
Message-ID: <aqKkDoGgnJkOQ8s-@pie>
References: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
 <20260909-spacemit-aihd-v2-1-780e98cf2fec@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-spacemit-aihd-v2-1-780e98cf2fec@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.29.40
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, Sep 09, 2026 at 11:51:08PM +0800, Junhui Liu wrote:
> The SpacemiT BootROM loads the FSBL from a boot image consisting of a
> fixed 4 KiB header with two metadata headers and authentication
> information, followed by a 32-byte-aligned SPL payload and a trailing
> authentication area. K1 and K3 share the same layout, but use different
> integrity and authentication schemes. K1 requires RSA-signed images,
> while K3 uses CRC32 to verify images in non-secure boot mode.
> 
> Add mkimage type "smtimage" for the K3 CRC32 path. Populate both
> metadata headers, fill their CRC32 values and the payload CRC32, and
> reserve the authentication areas required by the layout.
> 
> The image header has no reliable K1/K3 identifier, so select the SoC
> with -n. Omit dumpimage support since it cannot take -n to distinguish
> between the variants.
> 
> Only "-n k3" in non-secure boot mode is supported. Route SoC differences
> through a variant table so K1 and RSA authentication support can be
> added later.
> 
> Tested-by: E Shattow <e@freeshell.de>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  boot/image.c     |   1 +
>  include/image.h  |   1 +
>  tools/Makefile   |   1 +
>  tools/smtimage.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 205 insertions(+)

...

> diff --git a/tools/smtimage.c b/tools/smtimage.c
> new file mode 100644
> index 000000000000..96e8b5d8d171
> --- /dev/null
> +++ b/tools/smtimage.c

...

> +#include <image.h>
> +#include <u-boot/crc.h>
> +#include "imagetool.h"

I think you should explicitly include all headers you used explicitly,
e.g., string.h for strcmp(), stdint.h for uintXX_t...

...

> +static const struct smtimage_variant *smtimage_get_variant(const char *name)
> +{
> +	int i;
> +
> +	if (!name || !*name)
> +		return NULL;

Isn't this !*name check unnecessary?

> +
> +	for (i = 0; i < ARRAY_SIZE(smtimage_variants); i++)
> +		if (!strcmp(name, smtimage_variants[i].name))
> +			return &smtimage_variants[i];
> +
> +	return NULL;
> +}

Regards,
Yao Zi

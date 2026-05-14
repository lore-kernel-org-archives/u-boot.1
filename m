Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E821DCD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 15:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775FA84687;
	Thu, 14 May 2026 17:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4cXd99S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFA88468B; Thu, 14 May 2026 17:03:33 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDEF84686
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so73631965e9.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778771011; x=1779375811; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HeGpSThbSFjGw84J67vea1Oozl9PNwEItQAB/hxVtA=;
 b=b4cXd99ShVrRCI1nP0OeyjEgnSq5k+UemZjsoHBnifnRY+/avf+ob0zBElHbRXxjDi
 zj0ID5zfdsVbjiYolmaDng//RZd9CbfG8JdMueFMIQQpvDqYX9Nb5dj2d/2wwYvoCIKj
 /1DuDMxS9EU/vNssaApCk3GJ5aSnmqI2OEf3/gzVOfSt7NdnH/+jqJR6deMN8eYjIM66
 rXEvLkpMhOW09xuxx7jjqlQPr0uIp5oD5+NGSF53+YKP3B0GCcilb6IVC3KX4IjeuQoV
 d/ESGrObf0zsmQVMVVo0ZD9wzDNkoi9/f2qmQnj4wE/+wHKsIhfd1SvOdmb5f56S93nC
 moSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778771011; x=1779375811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2HeGpSThbSFjGw84J67vea1Oozl9PNwEItQAB/hxVtA=;
 b=cvBGUXr1QsNYKJ/KVGLZiQYmo3OYIQM9qKof+LnF3qeS7Y736alOSxhkM2i4DfwIPX
 CMtlpN32t0H3mueWJvy+tECJW+2EoHd+X0MSrSiV724dcSKCDTsjbygqliY5TdLivMQz
 wHtiZysJ2VkJu3s2/c+VGZ/Q/50r6WsZBRMlqta/SGCGA6yvWPoeBO85xy2lYcYbINKm
 be+3hOQi02jjKZcWaTHt1YchVI8x5l8+u+QDh4AFaZL7XRf2hbe1jkFBV9Oi2BdKEryd
 aCReXtoWz+u10QY6GR40VIlR1FgEsqvyCF3DRZOoaC6I6tP4l7Azctj2oq6KdLbqLBaP
 7a6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b9YWqF/rT5W+PKpedIgkUhdZi3IFrw+5in7n2bi6FII8qZbuGGGF6wMzia4W1tFPtRXA2O2k=@lists.denx.de
X-Gm-Message-State: AOJu0YzeHmi0XkTRGzKY1V3kb8drYuAFvLBtSj8tBsnHzg/vQqS9zoGM
 rF+Iv10WKC1HfyPiA5yC3JhGYBRWSqq4wDw7i928sg2J/ipStEn6kjkU
X-Gm-Gg: Acq92OHK38EmtOmRrB/y6YEPPoDL8MXBKZdtyipxQlDzi5yFe+xs6VRAdL0fhjH+han
 CNFTt0k7edz4rEBYcQAOebdg7g9rXM7tLRvXaBKaE8vg+0PodT+Ngkd49AUEpSXGMrAiNgYFfGR
 2LujSNNgFVpbmRPg7M12GPPGL/5lg2QvdXBjBVCA7Pc/2w1N6Rx9p7L798+KfjkPqWx/GxaB+UA
 J4j0EvBc9elQXDz6nBflFP6ZSESY47KnmdwclJbNAsUYR5vaeQCXrv/XmA7yQXkH720Zjo5SgXS
 WeqE0NMMkQYafdyutkLCzVOqvLOkCqLVcc2Hxq11rfxHKjvhyuJhUdd5vq5f/iGVZxkOxs5lryA
 9SbedMt3FmdgOWS/ygS/5B8Ut1K9mlqy8wE3xOsl1l+ydN/NNgpQlAXe1TwGFmxH2N0v4WoVyS4
 edp9P+7H5mdA6JD2oJWB/LfYGP4AVbDZmEKg4W+mhSL+TEj5lyZf9EztvdcdI7V1/SChaI+YQ=
X-Received: by 2002:a05:600c:4fcb:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48fc9a0ebc2mr120926805e9.8.1778771011273; 
 Thu, 14 May 2026 08:03:31 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd769141fsm20252065e9.32.2026.05.14.08.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 08:03:30 -0700 (PDT)
Message-ID: <8bf4666d-c168-4bf4-a079-7b41b3af2534@gmail.com>
Date: Thu, 14 May 2026 17:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] video: stm32: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
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



On 5/10/26 19:17, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---Hi Marek,

Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Best regards,
Raphaël

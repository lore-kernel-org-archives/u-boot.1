Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8155EC83F14
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 08:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B904864CE;
	Tue, 29 Aug 2023 10:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693298526;
	bh=6xo/fUkS7Kc8uXbRCPd3AiCbq5GpHu1J2HPMruSuu1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jMC/SgLMyBdZZI+wZDJ9knnhdvcGB6mUtZg59RBmXCQphJJeSdVtPXEBN3UB68/fs
	 jSntzTx+Whwc/qzDceF0ux7Au8I5wd7YzigqH/SWFoz0sz4EAMhVxVWFBwDNWZOlOe
	 L/LfRRG0gJ+btCeu1XeNUJwfBMobqLERF7ZauUxjL8/OjPJEGuBVGh6waLObMCGH11
	 VTYtNCxWM0ZDNxf2gIioyIMqDbYjbS//oQfYgMPV00Om8Q1MMtoKOwF74NEWzzGzJ/
	 A2WxMYM+iCSy7V3lQO3DXm1gcKXEO86HMBOq82Z4eWY4/mQ5IK8cXix2N79mtwv8bT
	 wYaQiLhAAUEbw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5194B864CF; Tue, 29 Aug 2023 10:42:04 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85AA8648F
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 10:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4RZgs310MWz9sR0;
 Tue, 29 Aug 2023 10:41:59 +0200 (CEST)
Message-ID: <680fa53d-74f4-58f4-414c-05bef83b60ed@denx.de>
Date: Tue, 29 Aug 2023 10:41:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Pogo v4: Enable LTO
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20230824190713.30866-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230824190713.30866-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RZgs310MWz9sR0
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

On 8/24/23 21:07, Tony Dinh wrote:
> Enable building Pogo V4 u-boot image with LTO, which results in about 30K
> reduction in size.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/pogo_v4_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
> index 3e3e811543..ad36da712b 100644
> --- a/configs/pogo_v4_defconfig
> +++ b/configs/pogo_v4_defconfig
> @@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
>   CONFIG_SYS_PROMPT="Pogo_V4> "
>   CONFIG_IDENT_STRING="\nPogoplug V4"
>   CONFIG_SYS_LOAD_ADDR=0x800000
> +CONFIG_LTO=y
>   CONFIG_PCI=y
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_BOOTSTAGE=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

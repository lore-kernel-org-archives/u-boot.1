Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E17EC3DA65
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 18:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BDA986BBE;
	Thu, 17 Aug 2023 20:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Prnc8WXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25B086BC3; Thu, 17 Aug 2023 20:40:47 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA2986961
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 20:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RRYjP6nTyz9sWJ;
 Thu, 17 Aug 2023 20:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692297641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rilByqYCdfFhwpZQJI2WYOgIzVLrRbkTLBbR6D5hskA=;
 b=Prnc8WXC5HHT46CPwT5skn4D2s4kJXD2SRJGoiiyehPh+kZjGvAoTmo2gPlgVLnQHQY2j5
 LhT/znjo4zLpGwDY9r+u33tx+0/NImgWqJSKvroWLe/d1KHmcp8A3O3BgTkhnxWFaAfbHz
 jwevtbRktuJuL+8TmMSv881N/+nguzWHskacYHsOcI7m3wFsN+tZ4De6MprmH8fvHfyLk3
 R0YqgIB7/VjHAt5iV3FkfkcDsJBB05+X7gN9L6hBkxaWfExNq/UsV4GFJgrdmZzkjssOm+
 UD48it3v3Ckm/jQeXq49z3+f05VAoBt9kZWecQGJ3GWHhdcqOmEDjLOTYTZ4MA==
Message-ID: <3e7c1df4-5a44-25e9-c762-56011edf2e73@mailbox.org>
Date: Thu, 17 Aug 2023 20:40:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Update UFS maintainer
Content-Language: en-US
To: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
Cc: bhupesh.sharma@linaro.org, nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com,
 sjg@chromium.org, trini@konsulko.com
References: <20230817120914.144240-1-n-francis@ti.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230817120914.144240-1-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4zccn5s6txmttca819j9ayn6cyqrrk8g
X-MBO-RS-ID: 69fbb92f01501ad195b
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

On 8/17/23 14:09, Neha Malcom Francis wrote:
> Dropping Faiz Abbas from the UFS maintainer list as his e-mail ID is no
> longer valid.
> 
> Adding Bhupesh Sharma who has been using this framework working on
> Qualcomm Snapdragon SoCs as well as sending out fixes.
> 
> Adding myself as well to support in reviewing and testing patches.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Add '---' here so the CC list is not part of the commit message when 
this patch is applied, like this:

Signed-of-by: Foo User <...>
---
CC: Bar Example <...>
...
---
V2: Did stuff
V3: Did more stuff


> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Nishnath Menon <nm@ti.com>
> ---
> Based on discussion:
> https://lore.kernel.org/u-boot/CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com/
> 
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77a8b0ac21..d19e1fd60b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1585,7 +1585,8 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>   F:	drivers/mtd/ubi/
>   
>   UFS
> -M:	Faiz Abbas <faiz_abbas@ti.com>
> +M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +M:	Neha Malcom Francis <n-francis@ti.com>
>   S:	Maintained
>   F:	drivers/ufs/
>   

With that fixed:

Acked-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks

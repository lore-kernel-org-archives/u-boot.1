Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6683DCD98E3
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 21:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBEB83FB6;
	Thu, 13 Nov 2025 22:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q04ivn+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9B183FDA; Thu, 13 Nov 2025 22:37:23 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D87D83FAE
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d6tsB3TQ2z9tWl;
 Thu, 13 Nov 2025 22:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763069838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQnoWAXVOuuNrTCDbjGXsOYU62fg5L8CAoAKA9S5x/0=;
 b=q04ivn+5fGMrGhyX+dKnMGVAZY+hoibnIoW50CsIKo/nfGZD1R+WEzWYTswYf6kpcayCC/
 KXzTOuIk6z4EB/cr7qc5TWY9LYfAlG23eyzNvfOpBLvW7GQFPn0+PqcCa5qH6kPJU+3yrg
 SLnYCr2HYWu2KwdOzop0iWdrUmyyUzikIFo3ATGgavHmtRU6dOBCuBzUIDmbWVCoojy47d
 goha6lK4ETuI2Vx3GYnqEqmhD/pyG2eLlAFcdwJNAU0xwIjxr6XgmzLto0BuIJJzFlIUtr
 /VQMOAyfYmAPMk3HNdCUsYwRJh1OWd06+jSh2YNUD/ENzIdwwB4N1pVYNmWNYQ==
Message-ID: <eddacbad-b443-4597-ac18-fd9265b9ef2d@mailbox.org>
Date: Thu, 13 Nov 2025 22:37:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Dockerfile: Include python3-tk for FATtools
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251113205733.1818836-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251113205733.1818836-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1804a79ac24868dce4a
X-MBO-RS-META: c5gqxagd8qdadpxt8p1b1k3so8fcg6nc
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

On 11/13/25 9:57 PM, Tom Rini wrote:
> In some cases our tests for exFAT don't run because we fail to be able
> to create the underlying image. This is in turn because while creation
> of the image succeeds, it seems that some way of how we invoke FATtools
> wants to import tkinter, that fails and so the test stops there. Having
> tkinter available (and then presumably a fallback to non-GUI because
> it's not available) leads to the tests running as expected.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>   tools/docker/Dockerfile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index d2384219c06a..f62513b86b2c 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -127,6 +127,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>   	python3-pyelftools \
>   	python3-sphinx \
>   	python3-tomli \
> +	python3-tk \
Keep the list sorted please.

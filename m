Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BBBE7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61588802C1;
	Mon, 16 Feb 2026 11:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ecpYERcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E752D8063E; Mon, 16 Feb 2026 11:15:21 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B1C80086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fDzDQ0Bcbz9tDy;
 Mon, 16 Feb 2026 11:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771236918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEVxur46Rn0njn60k6sXXxocc6BqmzZuLJGEWco9934=;
 b=ecpYERcvo/YGzpxCjDpjs6M9yVrYojPJnbDcpxfJM9WlCyBj5aoUK2YlxvMEF6bhXPXcht
 DKUS5ZwGkuLvRlix0fldocSWg/VKIb6ZbP/eOEstxu8R6lDZE5MyXJqu/CF5gDDAqNzYvg
 bYvPX5pNvkoMFjHHtTiX9E8rdA2nX84IHkpCiMa2+dEbZnWQXsW4k6iQJkkA/eg40XQ/g0
 b7vsj+ofROrjUzIB12R87rEA4VTKi8h4VJP6PE3X/g06CysEYQ8eaKyiRN9Fj4BF+ngHWl
 SkMfE309q+qBkTOGMNLSMqLzpJWMeVAsuKkNUBK4L6E2uca8MO1rBKfwNmoWXw==
Message-ID: <1a1b9dc9-0ad5-43b9-a8b7-fefb1eb6277d@mailbox.org>
Date: Mon, 16 Feb 2026 11:15:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 05/11] imx8qxp_capricorn config: add wget command
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>, Peng Fan
 <peng.fan@nxp.com>, Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260214045703.28051-1-hs@nabladev.com>
 <20260214045703.28051-6-hs@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260214045703.28051-6-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 60eb158a965cce8b498
X-MBO-RS-META: 6jymduwktibfwmrrbthotm8814dru4tr
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

On 2/14/26 5:56 AM, Heiko Schocher wrote:
> From: Walter Schweizer <walter.schweizer@siemens.com>
> 
> Faster than tftp.

The commit message could use an improvement .

> Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
> Changes in v2:
> Added Reviewed-by from Peng
> 
>   configs/imx8qxp_capricorn.config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
> index 62babf2626f..b5c9fdbc9b3 100644
> --- a/configs/imx8qxp_capricorn.config
> +++ b/configs/imx8qxp_capricorn.config
> @@ -73,6 +73,7 @@ CONFIG_CMD_CPU=y
>   # CONFIG_CMD_CRC32 is not set
>   # CONFIG_CMD_BIND is not set
>   CONFIG_CMD_WDT=y
> +CONFIG_CMD_WGET=y
Do you also have CONFIG_PROT_TCP_SACK=y enabled ?

Also, keep in mind, if/once you will switch to LWIP, the wget command 
syntax changes sightly (sigh).

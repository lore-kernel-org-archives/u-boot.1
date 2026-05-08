Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCE4CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 06:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF6384A20;
	Fri,  8 May 2026 08:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UJ3cKbP3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LbBcv1UF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0298784A37; Fri,  8 May 2026 08:38:06 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46F7849E0
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 08:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBfZL2GLTz9tGG;
 Fri,  8 May 2026 08:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778222282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44aDehuh91CE5ccoLrD3qqu231u7YHBlJNybg2kbERM=;
 b=UJ3cKbP3VEeokiTEmGOKllzvch0AAG3dUOlrwCEocc13gaTRKGhsjJQgj+sLrm8/C8oY+8
 k4OCvA9LFO+BP1YWUot64DsOQAkuCW9lXoULLLhKBa/Uy7mov/EKAiffB8aBJ04FMg44q2
 F3Poxx803+cyte+eTfj0izg+RbW6RL8oR3V6ic+ZwoOEbGFn+tVQzmI0FlwYttrpI6a+Ra
 jMgvU/8OidCyU43w2McCrJ3SFxq8lexf6H6qRCPKn8A4P88Yj0v7QXkTiti0Xo6CpBIBs9
 NKEPSLIGEIrbj8ml7hRntUikRVLD4A285m7m/Zatgr8ydv09SZiFtzdevTq7nA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LbBcv1UF;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
Message-ID: <a4340687-d970-43d6-b6b7-751cb0b478ff@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778222280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44aDehuh91CE5ccoLrD3qqu231u7YHBlJNybg2kbERM=;
 b=LbBcv1UFmOE3lJkXAz4nSUfmg9GGN/ApkhWtpXs+2XaojYhWodAk/gKGi9B8SmWY9bg1S8
 2AGGlqZiK9PVGCAar2PPfyK2ZtclYDJXm9xv1U+7IAY7kgW1sOag5M+yHOhNTSJAQJjkya
 h/nknSYVswReG8UAb4fAa3/9M8GqGRZ+5oE4tCOZ/gl+nCVFTYXiuAFuor3DmOpQLMVd4J
 gVH1kx06DLBo4yBtzytZxwfFQs3bhoIs/0WORemwnSMFui/xD5OHA6eKOEEUEVZpBr1PZr
 i1DbKzY0DMmtRlkdtuiF8Iqt9rWEJSsPDEF/DX+qGwMCCr9VZokGWzT7Bsr2AQ==
Date: Fri, 8 May 2026 08:37:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] ata: sata_mv: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
 <20260507164225.59325-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260507164225.59325-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 83irg4ra8s1zokjh3xppexkfhw4zb66y
X-MBO-RS-ID: 861cfb56421b99ad98b
X-Rspamd-Queue-Id: 4gBfZL2GLTz9tGG
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

On 5/7/26 18:42, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/ata/sata_mv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index b8c73b4a9dd..3fb1a245698 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1122,7 +1122,7 @@ static const struct udevice_id sata_mv_ids[] = {
>   	{ }
>   };
>   
> -struct ahci_ops sata_mv_ahci_ops = {
> +static const struct ahci_ops sata_mv_ahci_ops = {
>   	.scan = sata_mv_scan,
>   };
>   


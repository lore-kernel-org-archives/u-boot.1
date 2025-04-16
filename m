Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534A0C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36C582D17;
	Wed, 16 Apr 2025 11:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744794621;
	bh=Z03dqJkXnxKXwddsQahgygaJRfn5APi1BwtjhUI2TAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UtIPY+8uF1mrKjETLyhepBOYLG3H/uL8Ka2hJvQrwgNSQBOtzNM5mw8MGsPwvc/G/
	 efcOo4NMA7+pspX0/2D7nSmSi6gZHjptMlDiWdlxA91fKVSpyr1NFivtRd8yqEgKVm
	 AaS76KMzd2OuJoa1bJJ6vlrhbEhlxBF7XQVENLr6WNHMEiC/fLdNwYOCUH8nvd8q5w
	 cHd6KO8ENZLVBZ5A2k0SxIuEZqYAt0vpxwbw2yBeqwkn9jVeAHDrtFbhC1rRfFcEjn
	 IjFm4t6WlhxzaNyDQtVQm4TOgkrxEKyYB49EI2O1nbaU1nQ9IlsnOkfwz65hrWfr43
	 1XN4AwjSAT12Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB5A82D40; Wed, 16 Apr 2025 11:10:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C488082A
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aftymgXN"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 293C11039EF29; 
 Wed, 16 Apr 2025 11:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744794617;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Z03dqJkXnxKXwddsQahgygaJRfn5APi1BwtjhUI2TAs=;
 b=aftymgXN8fOohPZ4F2Uuqer4HYNBYQq+FTchXI+xFXZrQkUaES2N1yNDuG9Fme8VXHn5fk
 KwGqYMeQghLhsUvFV68736+2OyzI++1QYK7+QeW5NnfJlVEui7yPD/tej6eXViZxCqTsbX
 vD3LvnkLnaiJYqwJWVpiHsFrezGlVn3h3iiI6Asxqkz4bdfyggJmBITlnlK6gjEQyP9DK8
 kFYumpQoD7Zz/tTZKZACc+LdRODw/Uu9P00gKs6mrKgk6jFWYERQ8p9Jp3J9HOgcAxTVC0
 Z52IjRAeYTTnGaxJzO2O61pz9057dFha3VBz9V8B5GsUMj6H2DGh5vxnPLdHQQ==
Message-ID: <336e20a6-6628-0e1d-3065-66fec7bce60f@denx.de>
Date: Wed, 16 Apr 2025 11:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] i2c: mediatek: remove duplicate entry in
 mt_i2c_regs_v1[]
Content-Language: en-US
To: Martin Schiller <ms@dev.tdt.de>, u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, ansuelsmth@gmail.com
References: <20250416062919.1355568-1-ms@dev.tdt.de>
 <20250416062919.1355568-2-ms@dev.tdt.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250416062919.1355568-2-ms@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Martin,

On 16.04.25 08:29, Martin Schiller wrote:
> This removes a duplicate entry in mt_i2c_regs_v1[].
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>   drivers/i2c/mtk_i2c.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
> index 6edf3f44eca..55381dbeced 100644
> --- a/drivers/i2c/mtk_i2c.c
> +++ b/drivers/i2c/mtk_i2c.c
> @@ -143,7 +143,6 @@ static const uint mt_i2c_regs_v1[] = {
>   	[REG_RSV_DEBUG] = 0x44,
>   	[REG_HS] = 0x48,
>   	[REG_SOFTRESET] = 0x50,
> -	[REG_SOFTRESET] = 0x50,
>   	[REG_DCM_EN] = 0x54,
>   	[REG_DEBUGSTAT] = 0x64,
>   	[REG_DEBUGCTRL] = 0x68,
> 

good catch, thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

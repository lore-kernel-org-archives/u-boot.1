Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9244C87FDA
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40076846CE;
	Fri,  8 Aug 2025 13:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jTmmI4w/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5056C846D0; Fri,  8 Aug 2025 13:56:50 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46309846CC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bz2Z62t9Wz9tKs;
 Fri,  8 Aug 2025 13:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754654206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAUUx1E1aqxPIi4YbY1LqrwY+rdiYLOAhviihMCL2Bo=;
 b=jTmmI4w/I7ZT2pyVCOdj0rN9jPSk+Qdz7kiZDE3KbRFIGrE7fkKn6DkRkWVCMkf3qFHTLo
 oCMyfKNjZSt2DbS/xbxfpsTII1zt8e652h8BJvKeflPozrEcsnEg9RNOHk3QIpmpTkI6dJ
 07NoRMzeHBl9QKRMPzbz4gnkgSHwYIQCHl1GPQUv92PQwboDO6irP8FGbSkTPBPFulNuDF
 Gkr/hRnSS026/99biUBAumuoodBPBu68es6CQ8mPL83Dv6BGYSfdF1tlfYAEIZddyaAFGH
 YPBWYnJwU34EN7w5M09KQQcudUds8T4kbotdU4777qzQeVDx2XFi9N9uj2OIoA==
Message-ID: <2c39de8f-5aa8-4a6b-b60b-5a78909b5620@mailbox.org>
Date: Fri, 8 Aug 2025 13:56:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] phy: marvell: Fix off by 1 limit checks
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
 <20250806-phy_marvell_comphy-v1-1-ad9f4e789d5b@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250806-phy_marvell_comphy-v1-1-ad9f4e789d5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f770a095b68d096bf22
X-MBO-RS-META: iwm3m4b7dufohjfpiu71ieoejjui6ibz
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

On 06.08.25 18:43, Andrew Goodbody wrote:
> The limit checks in get_speed_string and get_type_string are off by 1 as
> they do not account for the maximum index into an array that can be used
> is 1 less than the number of elements in that array. Adjust the limit
> checks to allow for this.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/phy/marvell/comphy_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
> index a666a4e794e..a4121423873 100644
> --- a/drivers/phy/marvell/comphy_core.c
> +++ b/drivers/phy/marvell/comphy_core.c
> @@ -28,7 +28,7 @@ static const char *get_speed_string(u32 speed)
>   		"10.3125 Gbps"
>   	};
>   
> -	if (speed < 0 || speed > COMPHY_SPEED_MAX)
> +	if (speed < 0 || speed >= COMPHY_SPEED_MAX)
>   		return "invalid";
>   
>   	return speed_strings[speed];
> @@ -44,7 +44,7 @@ static const char *get_type_string(u32 type)
>   		"IGNORE"
>   	};
>   
> -	if (type < 0 || type > COMPHY_TYPE_MAX)
> +	if (type < 0 || type >= COMPHY_TYPE_MAX)
>   		return "invalid";
>   
>   	return type_strings[type];
> 


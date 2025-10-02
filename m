Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC41DCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 09:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A71E828A2;
	Thu,  2 Oct 2025 11:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="GR2nR2hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C2283526; Thu,  2 Oct 2025 11:47:07 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3E0828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id F1219240028
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1759398424; bh=iF0HtuU1lXWEA3IJHUIKBunnywvlP7svaC5m/7fXvn8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=GR2nR2hmtyQpHzE2/DmcV5dY2laPAz35ek0CaFriPLsaYTlo1dLmRk6J2lmJ3eCLM
 kEhq/0oHX4i7V1WuRSrFwLE+wfMRf04ciq3xYqIlIuhw5IH2JqbFkagAEh7lJdcQGy
 VUg9oqkl9ejN5AwjMIE0r6/4xIibd+TfPHFKMTM0+QVA2nUJpwdjExHYLNZ6mvCgyT
 Cq+EKOVvZyw5+2dEBB7yri5pHhkwLgtihxUPCnEzyvcBrIRfY469a9HtgnEbDx+SN9
 15ub0AFu3JOkeZIXVk7Xwt7FGUxehcdd8Pv+DhMWPOk2F9H0tnBOCFSZJy0j6HH/t/
 ApeT7tkBHoyPg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4ccn5432PDz6v0G;
 Thu,  2 Oct 2025 11:47:04 +0200 (CEST)
Message-ID: <f4981d74-0b4d-8add-7804-9c71886af88d@posteo.net>
Date: Thu, 02 Oct 2025 09:47:04 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] video: nexell: unsigned parameter cannot be negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251001-video_nexell-v1-1-380881a4d30e@linaro.org>
Content-Language: en-US, de-DE
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20251001-video_nexell-v1-1-380881a4d30e@linaro.org>
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

Hi Andrew,

On 01.10.25 12:05, Andrew Goodbody wrote:
> The parameter 'alpha' is declared as an unsigned type so cannot be
> negative. The code to test it as being less than zero will always fail
> and so is redundant and should be removed.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> There is no call to this function currently in the tree so maybe it
> should just be removed entirely?
> ---
>   drivers/video/nexell/soc/s5pxx18_soc_mlc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/nexell/soc/s5pxx18_soc_mlc.c b/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> index c8cf833f308836aa9205f4ed2148e41075b83c29..2c8348bf633929272d084b407dd4bc247eff21b4 100644
> --- a/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> +++ b/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> @@ -1641,8 +1641,6 @@ void nx_mlc_set_layer_alpha256(u32 module_index, u32 layer, u32 alpha)
>   	u32 register_data;
>   	register struct nx_mlc_register_set *pregister;
>   
> -	if (alpha < 0)
> -		alpha = 0;
>   	if (alpha > 255)
>   		alpha = 255;
>   
> 
> ---
> base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
> change-id: 20251001-video_nexell-f93362a0bf72
> 
> Best regards,

Reviewed-by: Stefan Bosch <stefan_b@posteo.net>

In my opinion, you can remove the entire function if you like.

Thanks a lot,
Stefan

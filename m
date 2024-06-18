Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14C6C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA89883AD;
	Tue, 18 Jun 2024 14:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718712087;
	bh=tJbkOB3vsIptPiurqAxu/Um9NBWYoP7UYfADNjk4VBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ur1zBS5FxwieFLXs6yRiGS6leK/Lxe9V0b6FCqSeFlUBXY8BlacQodQpSYzs0kYcs
	 qtMpIWR/oHYw+G8ltZwuL23S0HKxaoMSZj2m6y98S/s84CDTwh3L8o2SjWK3nnBXyb
	 vcjbcQp0s8SmkAaJ4eRjx42XtCIzwC7ipBeOkQrLF1PIEogsUtRlVFsnc15+xqOdX7
	 VKX4klm+dspMyT2a+yaoiVTRqOzXVRgkC2c6DBHuDbXuBeHO1Z5CBf19dWWdtNKEy8
	 h17EMasMm6qkmdRTNHidqBcXiArom3aBiC1wV5h32YtR+F0m54VYbSVaTTrJkUJI3z
	 jOTDWNeR7nTrA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4F9D88839C;
 Tue, 18 Jun 2024 14:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718712085;
 bh=tJbkOB3vsIptPiurqAxu/Um9NBWYoP7UYfADNjk4VBo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ky1UI95Wg/wBEwcYYfIfHPf8mSYGBz47dTICCYXtxneN6v0AOFO/rDLU+EJHK4Ky4
 rWSgTFfvXKtNn620zfc80qVm2PGSkEjHvT6jmIeWg5kY11pnrZa20Q5SP5bWz9k7Q8
 MdBrGRN7het4x5OCv332i0frVHoTsF2h5Ewc3Qqhw97FPkqYNfSEGKWKzdn9ddiYmD
 uYLb1UfePHnBjbdzzGPSn2EVSftJ1ogCYSmvt01OhOCv7uoM310ZcmKxg9Mp2CysBe
 ux0dJ/mTtvhAM77O5+0ttUeQ3WNndD65sNHU3nAcRHOuWJ57qWARTaCcXVfRtZ9XQ9
 sW1Uoc0ZG5WsQ==
Message-ID: <30fc3a75-ee32-440a-9730-57dd5883919f@denx.de>
Date: Tue, 18 Jun 2024 13:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] spl: correct link to FIT specification
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, u-boot@lists.denx.de
References: <20240618063230.24478-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618063230.24478-1-heinrich.schuchardt@canonical.com>
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

On 6/18/24 8:32 AM, Heinrich Schuchardt wrote:
> Replace the invalid link to the FIT file format specification.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> SPL is tightly size constrained.
> 
> Shouldn't we remove the message with the link which is only of interest
> to developers.
> ---
>   common/spl/spl_fit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 988125be008..2a097f4464c 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -587,7 +587,7 @@ __weak void *spl_load_simple_fit_fix_load(const void *fit)
>   static void warn_deprecated(const char *msg)
>   {
>   	printf("DEPRECATED: %s\n", msg);
> -	printf("\tSee doc/uImage.FIT/source_file_format.txt\n");
> +	printf("\tSee https://fitspec.osfw.foundation/\n");

Why not fix the link to local documentation in the source tree instead ?

I would much prefer that than random links to random websites .

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C875CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 04:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBD882A9E;
	Mon, 27 Oct 2025 05:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Y03cGb3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A8B82C7F; Mon, 27 Oct 2025 05:47:45 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A163980422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 05:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8CB6103244; Mon, 27 Oct 2025 05:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761540462;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XyLG5pXckc3Wr0LN+F8vv/0fR8fpQ5rp7HnhxLpb//0=;
 b=Y03cGb3IP8BHMuP5mAR3yB3+ZpSniPl9u2CMvFIW2v4XiUGbl6FpyyzzQvqr1gOiu2NR7a
 UjoY6eSO16lN18ynfu/RWEs63sJbExbe0lI/lh+na7tNUCu035Cuv98ZD5hlGYdrkzbB+s
 LP4yYvW+GGI9EHcIlxEZxJ5TwxmMadwJmFRwStV5i4ZknjWOW+0FmSxCBo4K8yGayuhsjh
 iVI4CfXRY178GBbUt17fLaEEC+1ZaacAVETiuQlP4ZCrSdSgTqEHHQMeIcUqgjR8TGuPv0
 IxpT3yH1XrYUiGWOVshwf2igkidqHVXIYyX3gPVmjPjDvdkBdmseitMVmvgWLg==
Message-ID: <160dd771-127a-c91a-7392-5eae01917ec3@nabladev.com>
Date: Mon, 27 Oct 2025 05:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] gpio: Return -ENODEV if gpio_hog_lookup_name() is empty
Content-Language: en-US
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
Cc: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Zixun LI <admin@hifiphile.com>
References: <20251024125251.39886-1-wolfgang.wallner@br-automation.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251024125251.39886-1-wolfgang.wallner@br-automation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Wolfgang,

On 24.10.25 14:52, Wolfgang Wallner wrote:
> If CONFIG_GPIO_HOG is not set, then gpio_hog_lookup_name() is empty,
> and thus does not initialize any of its parameters. It does still
> return 0 though, and so any calling function might assume that the
> parameters have been initialized successfully.
> 
> Change the return value to -ENODEV in this case, as the function
> would in the case when CONFIG_GPIO_HOG is set but the gpio hog
> could not be found.
> 
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> 
> ---
> 
>   drivers/gpio/gpio-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF76C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1641E88AFC;
	Thu,  1 Aug 2024 12:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722507918;
	bh=t6xuPSonn9QaSC9akwU1jxz8bvnh92nM53EeAz5m4Zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QBPWTIhWhGkU2q1wn3tk/QCcYDOhRtGFQgsCsIABhZGlyJ4xoyre38JilvRaBSh+8
	 SP84mzGPjBwIttcVU9HyBCGr0+lcAnMKGM2bD4fO7Ix2o8d5q3HVng4rrwg5V7WgsW
	 hyB/E6SMfhMfCQg4baLWv9rJiWvgBb0TyF45MqEf7dBVFRP5tFsMVXcFnK5tCH4MZB
	 0m/5+U8ZGpqe6aJjWvRw/6kALXU+XBLUeEk5VrsgRbDbLH+5zz7vUvLSgIXw5R9xyz
	 DKaFdpFvSP3w/SQwby9VNmA4NB0dY/4EJAaKoL2E4YlHYOfevojydUlMct+SBWZoki
	 uEcMAODYj71CA==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 353EF88ACC;
 Thu,  1 Aug 2024 12:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722507916;
 bh=t6xuPSonn9QaSC9akwU1jxz8bvnh92nM53EeAz5m4Zc=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=nvv7Se3ko4EI4/Y2I+zU0/g5Fp54YaI136xIy/HM4m0ilX8zPIdVgr5sx+NZB/TGL
 46kCr+1z43q/pgFlHYxyAR4/DbU4bpTnDKEf4snzinEKnIfgAMSvOUGDymEcz2aOk6
 BdXCWjEwMkcyWPfA2rfBDoXpOyztdk89Mh2IvqhpIOSYfhYcABaNrUcDon6re7th/L
 SGJ5xLM7NzUgkLHYxhNXZDDfXj32bFuJa0QPDjFOQ8+MyWAPm8w0JGNLG+pyq58QkO
 50VLqMLUVYctOvBhEgCWcDufcDxz346eXIznZmv3PDwXNxMF6DWeiu+cK2lU402w5b
 xfJA84bTloVrg==
Message-ID: <d39aaac3-71f9-3fda-aebf-4778dd993c61@denx.de>
Date: Thu, 1 Aug 2024 12:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: pca954x: Remove pointer to GD
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <c6a515e15b855a9a53edf642f161432b5db64198.1722498084.git.michal.simek@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <c6a515e15b855a9a53edf642f161432b5db64198.1722498084.git.michal.simek@amd.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Michal,

On 01.08.24 09:41, Michal Simek wrote:
> There is no reason to have any pointer to GD that's why remove it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/i2c/muxes/pca954x.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

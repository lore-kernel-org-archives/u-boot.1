Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735A5C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 04:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C7882A4B;
	Wed, 11 Jun 2025 06:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1749614482;
	bh=LDpzoHva7cVKMl1dUcfP2bY9tEveNBxU/zVxc98XUKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zb+fTj72dhFdk8tAcaJWvDLw4cYL+hnj2r2Tb/r97bdqNENu30uwEN/Jvfm/TqOZQ
	 6WS/DdDq+I9fBM+9OMBlfPsr8Vg3NdS/aHs0aXesUtwI1gmRVBBqDgc7B8N9yCzcoa
	 M+DA1kDTU0eEN0RC4JTzAlMiPL/XWHAJ/YicsGuSF2gpHBp1qAwWopA+k5BvniL2VN
	 Gcq3ytm6bHLJekPoRzYat0SQ6Wl/m2uQQuze6cVvp1ZHP89/iaLK12ieMR+7bafEhb
	 jGkfiOniC6oWt66xzvpcZ6kkkgH1qTzxh5zEHEce7tHCRazEoShljGJiq6qqcAY3OQ
	 v8+U5Ro1m7riQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A8082B18; Wed, 11 Jun 2025 06:01:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161018070C
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 06:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SquDgohK"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 021241039729E; 
 Wed, 11 Jun 2025 06:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1749614478;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LDpzoHva7cVKMl1dUcfP2bY9tEveNBxU/zVxc98XUKs=;
 b=SquDgohKle6Gr7BqdroWRv3MCJfMD4/zJ+Gnukc1a56nejvHGQLVsYqO9ph2RlulEpYJli
 K+8MsoMwwW9/YLRaVXZp490ULdirLJtwFLU8ODqXIq0on0Y2ZCCZtqdJNqwtlwkhiCmRBO
 gKLeIvNneW0oUuY8RXFfUOsS/YEpQNh7Dz7e3YPIldlbvxGtj0AW19IjGhSb2T7/trtdE/
 fa9H59436OmxVPBO7Zf5Mn0DUARkWzNfkxjoT6qe+flhpi04yInn54u4AQJauFc3+sH3yO
 Wop7ZeBdLHVa9E3h620iH/S7OUtGbLGNYCA93plo3kyBrgdEwY+tGaggpzvZag==
Message-ID: <00368ed6-fef6-eb9f-b9f3-b0a6d51d0a23@denx.de>
Date: Wed, 11 Jun 2025 06:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] i2c: geni: fix error message wording in clk_disable
Content-Language: en-US
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
 <20250610-geni-load-fw-v2-1-7cad6bc18db0@linaro.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250610-geni-load-fw-v2-1-7cad6bc18db0@linaro.org>
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

Hello Casey,

On 10.06.25 18:50, Casey Connolly wrote:
> Correct the error messages so they accurately describe that we failed to
> disable the clocks, not to enable them.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/i2c/geni_i2c.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
>   
>   	if (geni->is_master_hub) {
>   		ret = clk_disable(&geni->core);
>   		if (ret) {
> -			dev_err(dev, "clk_enable core failed %d\n", ret);
> -			return ret;
> +			dev_err(dev, "clk_disable core failed %d\n", ret);

Hmm.. why do you remove the return?

>   		}
>   	}
>   
>   	ret = clk_disable(&geni->se);
>   	if (ret) {
> -		dev_err(dev, "clk_enable se failed %d\n", ret);
> -		return ret;
> +		dev_err(dev, "clk_disable se failed %d\n", ret);
>   	}
>   
>   	return 0;
>   }
> 

In case of error, you return now 0 ?

If you intentionally want this change, please describe this in
your commit message and why you want this...

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBE1C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 03:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF6F88453;
	Wed, 31 Jul 2024 05:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722397453;
	bh=3xxAwloPi0UbCsTbbtplAtSuMGvXz2Rv6pNnQpEfYKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Lj26sHdERf2q7RSCYs0MfMq/d6+t1aA59uYYLAlFXjjfXZ0UtooD5IexPxZcy/cbV
	 89NjDVWfq7jGlPTdq1mbT3KHfjNGzojvVKIS1PqCg9wKYoxKFP0KERZKW0Ui4QrKPk
	 hsDzBaPmPqVjG80oywuefPArna+MCGAAiljLetvh9ZsCu41B6mnnVj7Lj1oVvrV7lI
	 xRu1Zy0Q7DM5MGXYWUUMYyY+uaxwDBogQJseVPua4ng4VKCWf5ZL07OIiP7eyZyY+A
	 V0asT6PXNj3CVLzQ2YO6Go7KCaTnkftPt+Tdvj+qpcuGh/Q2btiDRwUhRqWMGx6+iC
	 QfOwTeXXyI6qQ==
Received: from [192.168.1.107] (87-97-105-110.pool.digikabel.hu
 [87.97.105.110])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B90B588780;
 Wed, 31 Jul 2024 05:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722397452;
 bh=3xxAwloPi0UbCsTbbtplAtSuMGvXz2Rv6pNnQpEfYKI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=UGWk24YuuifRT0Fzgs3zFqj1pUzd9Wv4MQcytViiaDrF1g7FghpysC5WFAKFqx3k3
 gGQFW1S7WmEdw5ROf13gRvCPykPB7ZOXjheemmI2nBVYQ+jxNZIipeWbPpWIBxqX4R
 LgRdKR9GzUejuh5O6Y/wr/Qs+D+quFT4qpl6zKUpJqpZCdKlhvz4Gt4ldxHairyCcN
 PVgLvVBMJcHYYtP0T1lusbkFXJie2eOJBW2zV01YvaWyyppLsm5ABqiKp0/pX45LhK
 /KxpbbVgK3+qaAUoAJdtmCEs84Fih1A0/1m9NL1fcyKErufUNy2Pq1/OcMyLPWxydw
 kN2CUGypvEw/w==
Message-ID: <6c8481c8-4ef4-ed75-922b-3db35a0ff68b@denx.de>
Date: Wed, 31 Jul 2024 05:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCHv2 2/3] i2c: imx_lpi2c: Replace hard-coded bus speed value
 with bus->speed_hz
Content-Language: en-US
To: fedorross@gmail.com, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
References: <20240730152529.143651-1-fedor.ross@ifm.com>
 <20240730152529.143651-2-fedor.ross@ifm.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240730152529.143651-2-fedor.ross@ifm.com>
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

Hello Fedor,

On 30.07.24 17:25, fedorross@gmail.com wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> Instead of using the hard-coded bus speed value I2C_SPEED_STANDARD_RATE,
> use the actual configured bus speed. This way the bus speed doesn't
> change suddenly after calling the imx_lpi2c_probe_chip() function for
> example.
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> 
> Changes in v2:
> - Add additional '---' below SoB line to separate Cc list. This way it
>    does not get included in the commit message when the patch is applied.
> - Drop the second parameter of bus_i2c_init().
> 
>   drivers/i2c/imx_lpi2c.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

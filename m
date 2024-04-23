Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAC9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A5F885A0;
	Tue, 23 Apr 2024 15:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713878953;
	bh=VzdS1xsfXtaKWMHOKnCsbK1CaOVpxkwdXfx+Ga9HK+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UuESq5Yrslu5qiCUnYf6aI6jwWEOgKGd7TyrxSHWjXfHSjOa2Mqp41eHuRHGzjYl5
	 cT2qAgHC2XkbmSWBvvO7WEQSI7/Tfz17C/Bp5VTVjj1dMlD8KK+7mAIZ1HDHXv3u+c
	 0Uy+yNNo0wd2xpyCRMn1ZUVKsygjaX+xZiThXBL0RS93Sbsc0Q8G3i2RXNhVRozWky
	 t9ZKDW1W8uWMsPOBSXpTzmO6nIpS+qf8ogk8e8rEk5QHx4vj3MVAWjOXrZ+hFUO26K
	 M6i+zR0RzvOPHYbO3jspVY4LZS/ZNFxx/pwBjQYRMMRONfmi5MB7uY9f+8wCLoGyuY
	 R5fdmWJrByNxw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AFEC48851E;
 Tue, 23 Apr 2024 15:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713878952;
 bh=VzdS1xsfXtaKWMHOKnCsbK1CaOVpxkwdXfx+Ga9HK+o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xK48aa8q+Jk3mZaj4RyvH5HZN3IeVOcGTVPGhwoFpd8yNK8yeXiV4lL6wZtPT1kb1
 A1GN9lSntOsQo+pbcm6k73YP2JDU6KGAGYs4vUfHc4AkrWmG8fbYe2s381Jrm1Vy3X
 idLvlXyEqyFJCYK1HLHBbh9DbymavuYLFpqPwCqBw1jEl3Cygolk3j3DKVRBN+SycI
 JWnNJC1ryxFJjLTomrrqB5YLZHTol2t37a3uJ09jnAjpmoXYY0LCwSyC9GWCXtWae5
 Um+4K15PU1vKo+7gatq2ashTm0X0CVi0sVHmFrRnUSeVo434snDkiUOE/MK1RQ1Vjd
 5rOH+9PBnU8Mg==
Message-ID: <1bc044d6-01ef-4a7a-87e6-e212f10c032e@denx.de>
Date: Tue, 23 Apr 2024 14:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] net: dwc_eth_qos: mdio: Implement clause 45
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 patrick.delaunay@foss.st.com, patrice.chotard@foss.st.com, jonas@kwiboo.se,
 leyfoon.tan@starfivetech.com, epsi@gmx.de, xypron.glpk@gmx.de,
 seanga2@gmail.com, sebastien.szymanski@armadeus.com, festevam@gmail.com,
 sebastian.reichel@collabora.com, yanhong.wang@starfivetech.com,
 christophe.roullier@st.com
References: <20240423085158.29246-1-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240423085158.29246-1-pro@denx.de>
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

On 4/23/24 10:51 AM, Philip Oberfichtner wrote:
> Bevor this commit, only clause 22 access was possible. After this commit,
> clause 45 direct access will available as well.
> 
> Note that there is a slight change of behavior: Before this commit, the
> C45E bit was set to whatever value was left in the register from the
> previous access. After this commit, we adopt the common practice of
> discerning C45 from C22 using the devad argument.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>      This patch is labeled RFC as there is a slight change of behavior (see
>      commit message). I'm not sure in fact if this solution works for
>      everybody - this is up for discussion!
>      
>      My implementation is tested on an Intel Elkhart lake SOC. Driver code
>      for dwc_eth_qos_intel coming soon in a separate patch series.
> 
>   drivers/net/dwc_eth_qos.c | 66 ++++++++++++++++++++++++++-------------
>   drivers/net/dwc_eth_qos.h |  1 +
>   2 files changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 86d989e244..64a9bff6bb 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -162,6 +162,25 @@ static int eqos_mdio_wait_idle(struct eqos_priv *eqos)
>   				 1000000, true);
>   }
>   
> +/* Bitmask common for mdio_read and mdio_write */
> +#define EQOS_MDIO_BITFIELD(pa, rda, cr) \
> +	(pa  << EQOS_MAC_MDIO_ADDRESS_PA_SHIFT)  | \

Parenthesis around (pa) are missing, DTTO for the rest of this.

However, better use FIELD_GET/FIELD_PREP macros instead.

[...]

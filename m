Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19258C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 16:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58BFA80842;
	Tue, 11 Feb 2025 17:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QV5XQeUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7CA80AE5; Tue, 11 Feb 2025 17:46:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBA0806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 17:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7c24=VD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739292395;
 bh=MVnmj+q9y6u3InFHJzpn+00LJrVUrrZJmko4kVB0nsc=;
 b=QV5XQeUq1jqCc0/8dqa/WdV/M7ijfl7HH7hXq2R0C7hJPYxiEnmLIZbyXWKqX6QpLVKvln7M0
 7nzaMXXX/AijXeoDRyMr7XkEftJXC3GE4B+g/SKdVZ2jROdbdmZeznzRSB3TyMILJoGQNVWcLC+
 fx4SJRINt8loVitLhFGGrQmlo0slj6oP3qUb+DLWLAvRXL6iiQUVCWK6ynp5uPnDiMWhIzStDDy
 FGGW1X1SO73HGGOfHYepkMzCTooumA/jw6HrYxphlw75BGMUSI3cbgDDzi9nKUWoey3lysjIwd3
 20PZ/OnwpOyoB7FBCrQ6CEex1n8XfOqap+CAIPwXmt7g==
X-Forward-Email-ID: 67ab7ee943a7d273da0585f7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a9eae65c-d125-47ed-97fa-08d815217605@kwiboo.se>
Date: Tue, 11 Feb 2025 17:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay
 for RK356x
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250209232801.3185681-1-jonas@kwiboo.se>
 <20250209232801.3185681-2-jonas@kwiboo.se>
 <0eb7b5d1-692f-4fc8-a3b5-6eeb5c56f90e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0eb7b5d1-692f-4fc8-a3b5-6eeb5c56f90e@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Quentin,

On 2025-02-11 13:20, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/10/25 12:27 AM, Jonas Karlman wrote:
>> When rgmii-rxid/txid/id phy-mode is used the MAC should not add RX
>> and/or TX delay. Currently RX/TX delay is configured as enabled using
>> zero as delay value for the rgmii-rxid/txid/id modes.
>>
>> Change to disable RX and/or TX delay and using zero as delay value.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/net/dwc_eth_qos_rockchip.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
>> index 9fc8c686b889..3e10e07403c1 100644
>> --- a/drivers/net/dwc_eth_qos_rockchip.c
>> +++ b/drivers/net/dwc_eth_qos_rockchip.c
>> @@ -46,6 +46,10 @@ struct rockchip_platform_data {
>>   #define GRF_BIT(nr)	(BIT(nr) | BIT((nr) + 16))
>>   #define GRF_CLR_BIT(nr)	(BIT((nr) + 16))
>>   
>> +#define DELAY_ENABLE(soc, tx, rx) \
>> +	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
>> +	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
>> +
> 
> Considering this won't be used for RK3588 in the next patch and that I 
> found it obfuscating the constants that are used, can't we simply do...
> 
>>   #define RK3568_GRF_GMAC0_CON0		0x0380
>>   #define RK3568_GRF_GMAC0_CON1		0x0384
>>   #define RK3568_GRF_GMAC1_CON0		0x0388
>> @@ -85,8 +89,7 @@ static int rk3568_set_to_rgmii(struct udevice *dev,
>>   
>>   	regmap_write(data->grf, con1,
>>   		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
>> -		     RK3568_GMAC_RXCLK_DLY_ENABLE |
>> -		     RK3568_GMAC_TXCLK_DLY_ENABLE);
>> +		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));
> 
> (tx_delay ? RK3568_GMAC_TXCLK_DLY_ENABLE : RK3568_GMAC_TXCLK_DLY_DISABLE) |
> (rx_delay ? RK3568_GMAC_RXCLK_DLY_ENABLE : RK3568_GMAC_RXCLK_DLY_DISABLE));
> 
> instead?

Sorry for not being clear in the cover letter or in commit message. The
DELAY_ENABLE macro match a similar macro in gmac_rockchip.c and in the
mainline Linux driver and will/should be used by pending RK3528 and
RK3576 support.

> 
> Also, if tx_delay or rx_delay is 0, does it actually make sense to write 
> the delay config in there? (so the regmap_write before this one).

It seem to be what is done for the other SoCs GMAC in both mainline and
vendor U-Boot. Not sure we should deviate too much from what seem to be
working.

> 
> Note that the config is set before the enable on rk3568, but the 
> opposite on rk3588 which I find quite odd, you usually want to configure 
> something before it's enabled?

I also think this look a bit strange, however it is what is also done
for the other SoCs GMAC in both mainline and vendor U-Boot. Hopefully
the reg write order does not matter for the hw.

Regards,
Jonas

> 
> The change itself looks fine though!
> 
> Cheers,
> Quentin


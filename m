Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91715CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 14:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCC7868D1;
	Fri,  1 Sep 2023 16:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="gzjrl8vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E39868D1; Fri,  1 Sep 2023 16:10:32 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80C286907
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 16:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=5FA1l1wD5EAzoZy3FKMVGgp0Fgb4EoBxvSuBsc2pAow=;
 b=gzjrl8viAEOCUsymHWc0qlI+AOYQr40u6liuPjP0bFaEYi9ubjoGKe6B431Y9PnRdqZT
 WrCqQerSvCy2qqGku4jH184t8Ip0tIdwk8h4NEfCaLpAvSXMsmIwOPr7aMA7+oNvcwXrV9
 F9PzHVvW8Ty1G1jQ0SsvFXwTaWWgz7u/7wSEJBnlHmeDXYm3/a+ax42Updxhvf1KvbznB4
 jiYjTeaQVaOn82vby4EHCO5GQWC6tqKfcsI3BXG/2G5iLHg5hHTcsK/C4lrUNH/0jVQ3rd
 YfnfK0E+WigabVoNhxxC4bg7pVCj4EJN7jfpb+97vVJ7Bkoetp1RlQZehMbCpjmA==
Received: by filterdrecv-d7bbbc8bf-nzpnk with SMTP id
 filterdrecv-d7bbbc8bf-nzpnk-1-64F1F0D1-25
 2023-09-01 14:10:25.224095951 +0000 UTC m=+9815432.168287522
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id CSWwyR_lQcKmsk_IKurvmg Fri, 01 Sep 2023 14:10:24.846 +0000 (UTC)
Message-ID: <2d42eeb3-91ae-078e-8da6-80963c1ae4ab@kwiboo.se>
Date: Fri, 01 Sep 2023 14:10:25 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] video: rockchip: dw_mipi_dsi: Use generic_phy_valid()
 helper
Content-Language: en-US
References: <20230831221629.1027552-1-jonas@kwiboo.se>
 <20230831221629.1027552-7-jonas@kwiboo.se>
 <7532dcdb-ed81-b424-a8ad-5f98a8acf81d@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7532dcdb-ed81-b424-a8ad-5f98a8acf81d@rock-chips.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5i7M6DjbloljwpwY?=
 =?us-ascii?Q?iJ2hKOqTBYr6kSQpyfwfESt7g0ZMOnaRv5u6zB2?=
 =?us-ascii?Q?goiv9YHBXWESeayMabrmg10ttqHv5Jek7DxSz+z?=
 =?us-ascii?Q?KebxvYCn4c9uUtN=2FzxcE0J2nQP9lPHDaNP=2Fz48=2F?=
 =?us-ascii?Q?CE3JWrAQPhHeNNHul7=2FNkpK1wwVO1zdDc8hqYq?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Anatolij Gustschin <agust@denx.de>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Ondrej Jirman <megi@xff.cz>
Cc: u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi Kever,

On 2023-09-01 09:49, Kever Yang wrote:
> Hi Jonas,
> 
>      Why is this patch 6/6 and didn't see other patches?

Patch 1-3 moves a workaround made in usb dwc3 driver into generic phy
core so entire series was sent to usb maintainer and cc mailing list.

Patch 4-6 was trivial and had no real dependencies on prior patches but
was related to the work made in patch 1-3, so sent these to the listed
maintainers and cc mailing list.

Full series can also be found at:
https://patchwork.ozlabs.org/project/uboot/list/?series=371248&state=*

Regards,
Jonas

> 
> On 2023/9/1 06:16, Jonas Karlman wrote:
>> The documentation for struct phy state that "The content of the
>> structure is managed solely by the PHY API and PHY drivers".
>>
>> Change to use the generic_phy_valid() helper to check if phy is valid.
>>
>> Fixes: b7d8d40346f2 ("video: rockchip: dw_mipi_dsi: Fix external phy existence check")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> Thanks,
> - Kever
>> ---
>>   drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
>> index 0852b53ebed5..1a5ab781e3f1 100644
>> --- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
>> +++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
>> @@ -377,7 +377,7 @@ static int dsi_phy_init(void *priv_data)
>>   	struct dw_rockchip_dsi_priv *dsi = dev_get_priv(dev);
>>   	int ret, i, vco;
>>   
>> -	if (dsi->phy.dev) {
>> +	if (generic_phy_valid(&dsi->phy)) {
>>   		ret = generic_phy_configure(&dsi->phy, &dsi->phy_opts);
>>   		if (ret) {
>>   			dev_err(dsi->dsi_host,
>> @@ -559,7 +559,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
>>   	}
>>   
>>   	/* for external phy only the mipi_dphy_config is necessary */
>> -	if (dsi->phy.dev) {
>> +	if (generic_phy_valid(&dsi->phy)) {
>>   		phy_mipi_dphy_get_default_config(timings->pixelclock.typ  * 10 / 8,
>>   						 bpp, lanes,
>>   						 &dsi->phy_opts);
>> @@ -859,7 +859,7 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice *dev)
>>   	}
>>   
>>   	/* Get a ref clock only if not using an external phy. */
>> -	if (priv->phy.dev) {
>> +	if (generic_phy_valid(&priv->phy)) {
>>   		dev_dbg(dev, "setting priv->ref to NULL\n");
>>   		priv->ref = NULL;
>>   


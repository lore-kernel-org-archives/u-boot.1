Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1316CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 04:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A76986D33;
	Fri, 13 Oct 2023 06:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697171867;
	bh=6Lq6VvQ6iwv+25Okuql94nLkmHBT+teeMHUvIz08a8c=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=d6aL02DR02l0+Bj5QE/VtQE8q1Xafek5sllaldnv6uUl6fYk8kGKtkMyC+JlbJr8D
	 AFh4j9j7QHlbGxKVlsP71mxtML1y2gm6+Gb2u+5qrqYjtEhsgJ7bfsamyLoNjNWMdu
	 qUkmKIas+L/fsXFgJzfRR3zPp8Ct5VyReO32Yig/pheo5Kf3o5Xt2GuqOng4smMzS7
	 zFbYPeMj55Acj+8wFcAXRrHT8/D+M9R/BzK/bPXoeGc2jAW6KN+T6vjiRgI02BxCGQ
	 6hFwNjiT4TPjbKm83TgG877qIESLrz5EbaBmIPDaWOiVTlZcozAUyiZ5IdqlQKUk0f
	 k09IZPUBM/dWg==
Received: from [192.168.1.107] (91-82-26-209.pool.digikabel.hu [91.82.26.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DB031869F5;
 Fri, 13 Oct 2023 06:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697171855;
 bh=6Lq6VvQ6iwv+25Okuql94nLkmHBT+teeMHUvIz08a8c=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ynjkeM8u25AafsmXZpqOscn4/HEYuqp8oXnExKdOi1/U9EBAV5XE2BZaqR68S6eaQ
 EaP0rZQout0z8rrqAoFjPmJ7IGh2yXxEY+LL49pDQYQdtuyREyqiXXd8gyAnFclDs9
 yHdMCoRJIumiT4xaWXMRNggY6oqBOK+yAQJop9111oH3JnwlyvvGvfdc/YFZSy3GbG
 8CGEqm2oUZ0vNYKquDaOfsuz2zNrZkYxboSvaT657d3eNoCOjBUHNU2eKyzCK6huwB
 LDAR8ypNxtS63RKgqctZiSrgqYSSJxNQ7pTRy4dg+oIn1dc5l4h8Z5qlNzMQyUuf7N
 gvfG5G2QihMvQ==
Subject: Re: [PATCH 1/1] i2c: designware_i2c: adjust timing calculation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231011044813.122941-1-heinrich.schuchardt@canonical.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <d461a87f-14d6-2b22-f3c6-522a54b7d517@denx.de>
Date: Fri, 13 Oct 2023 06:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231011044813.122941-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Heinrich,

On 11.10.23 06:48, Heinrich Schuchardt wrote:
> In SPL probing of the designware_i2c device on the StarFive VisionFive 2
> board fails with
> 
>     dw_i2c: mode 0, ic_clk 1000000, speed 100000,
>     period 10 rise 1 fall 1 tlow 5 thigh 4 spk 0
>     dw_i2c: bad counts. hcnt = -4 lcnt = 4
>     device_probe: i2c@12050000 failed to probe -22
> 
> When changing the offset for the high phase from 7 to 1 the device is
> probed correctly.
> 
> Without this fix the memory size of the StarFive VisionFive 2 board cannot
> be read from EEPROM.
> 
> Fixes: e71b6f6622d6 ("i2c: designware_i2c: Rewrite timing calculation")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/i2c/designware_i2c.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
> index e54de42abc..55e582091c 100644
> --- a/drivers/i2c/designware_i2c.c
> +++ b/drivers/i2c/designware_i2c.c
> @@ -155,10 +155,10 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
>  
>  	/*
>  	 * Back-solve for hcnt and lcnt according to the following equations:
> -	 * SCL_High_time = [(HCNT + IC_*_SPKLEN + 7) * ic_clk] + SCL_Fall_time
> +	 * SCL_High_time = [(HCNT + IC_*_SPKLEN + 1) * ic_clk] + SCL_Fall_time
>  	 * SCL_Low_time = [(LCNT + 1) * ic_clk] - SCL_Fall_time + SCL_Rise_time
>  	 */
> -	hcnt = min_thigh_cnt - fall_cnt - 7 - spk_cnt;
> +	hcnt = min_thigh_cnt - fall_cnt - 1 - spk_cnt;
>  	lcnt = min_tlow_cnt - rise_cnt + fall_cnt - 1;
>  
>  	if (hcnt < 0 || lcnt < 0) {
> @@ -170,13 +170,13 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
>  	 * Now add things back up to ensure the period is hit. If it is off,
>  	 * split the difference and bias to lcnt for remainder
>  	 */
> -	tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
> +	tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
>  
>  	if (tot < period_cnt) {
>  		diff = (period_cnt - tot) / 2;
>  		hcnt += diff;
>  		lcnt += diff;
> -		tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
> +		tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
>  		lcnt += period_cnt - tot;
>  	}

What are this magic constants? Are they somewhere documented in the RM?

Hmm... and does this may break other boards? Should we have this in
someway configurable?

Tried to look fast in the linux driver... and it seems to me, this
constants depend at least on i2c_speed_mode?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

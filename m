Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C993ECD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 18:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213DF84912;
	Sun, 24 May 2026 20:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sBIm9Vzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B397C84913; Sun, 24 May 2026 20:24:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33958848E3
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 20:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=46ba=DW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779647088;
 bh=qQ+uChUv+F+A1JBQZ3JX7m06oG9pVY7KAI5VClYuMRE=;
 b=sBIm9VzyLmmBayxShY0s10BlvENuP0yqfxWUjrG8X0HPiNDL5pgGteAB7fdY8TIsmL0jFqYeA
 h3yd19UeXcRSqQZkvzNwg6Ys4xobQ6GQL1ScbUuCip9pcmg5U2dqYuEl7a6NbrTgW9HPaKP0+1Z
 J0Fl7PNoKik8QDUtaIH3dWROKCT6YBSbAOr2CUW3BLnpxYamoesZl2YDCrj9H4jOmRG6F0UosXK
 JAagmfpg2nywq+IRe5NgspPGZglL9v+tvwoORL2A5ZJ5+ObxAjsakbHFkfs4tJQ2c2PWpgDLHOu
 k6KlLC57XUgg0CVr9KP2Hwq3QG+dBEJNzDeYyUpINifQ==
X-Forward-Email-ID: 6a13426d1434e766ef86e788
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7710a784-b01e-4de4-a489-6d05414c9d09@kwiboo.se>
Date: Sun, 24 May 2026 20:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/18] ram: rockchip: rk3568: Limit maximum DDR
 frequency to 1056 MHz
To: Pavel Golikov <paullo612@ya.ru>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-18-a24e16302a13@ya.ru>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260517-rk3568-raminit-v1-18-a24e16302a13@ya.ru>
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

Hi Pavel,

On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> RK3566 has the same DDR memory controller as RK3568 has. The only
> difference is a maximum supported DDR frequency.
> 
> Limit maximum DDR frequency in DDR loader params, so DDR controller can
> be initialized on both RK3566 and RK3568 SoCs.

This should likely be moved to a Kconfig option unless we can detect SoC
variant at runtime. I know we can do it using OTP, but maybe there is
some other hw reg we can readl() to figure out rk3566 vs rk3568?

Regards,
Jonas

> 
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
> ---
>  drivers/ram/rockchip/sdram-rk3568-loader_params.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram-rk3568-loader_params.inc b/drivers/ram/rockchip/sdram-rk3568-loader_params.inc
> index d9beea3519a..3fcc70d8495 100644
> --- a/drivers/ram/rockchip/sdram-rk3568-loader_params.inc
> +++ b/drivers/ram/rockchip/sdram-rk3568-loader_params.inc
> @@ -17,7 +17,7 @@
>  0, 0, /* reserved */
>  
>  /* ddr4 */
> -(1560 << DDR_FREQ_F0_SHIFT) | (324 << DDR_FREQ_F1_SHIFT),
> +(1056 << DDR_FREQ_F0_SHIFT) | (324 << DDR_FREQ_F1_SHIFT),
>  (528 << DDR_FREQ_F2_SHIFT) | (780 << DDR_FREQ_F3_SHIFT),
>  (0 << DDR_FREQ_F4_SHIFT) | (0 << DDR_FREQ_F5_SHIFT),
>  /* drv when odt on */
> @@ -39,7 +39,7 @@
>  	(0x1 << PHY_CLK_SR_SHIFT),
>  
>  /* lpddr4 */
> -(1560 << DDR_FREQ_F0_SHIFT) | (324 << DDR_FREQ_F1_SHIFT),
> +(1056 << DDR_FREQ_F0_SHIFT) | (324 << DDR_FREQ_F1_SHIFT),
>  (528 << DDR_FREQ_F2_SHIFT) | (780 << DDR_FREQ_F3_SHIFT),
>  (0 << DDR_FREQ_F4_SHIFT) | (0 << DDR_FREQ_F5_SHIFT),
>  
> 


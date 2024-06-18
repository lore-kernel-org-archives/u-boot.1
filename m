Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813BDC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 21:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE6888381;
	Tue, 18 Jun 2024 23:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="n8JQmWVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E0688335; Tue, 18 Jun 2024 23:56:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D719E883AD
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 23:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf49=NV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718747753;
 bh=CsJZui3W2OaO6fCHw44lMa47wvkQlQAsRjc97gkNGx4=;
 b=n8JQmWVVkZCY3AynthhdTUq6bmCgIa7TPsEL6AJej6P8OKq/BnPl1H3YCjzTlvXLlbg12Qls2
 JaPVR5RGISq2C5+ijywLifcYiTqps0unYkIAMtiXdk8niSqTlvzS+3zrgNhY5LuzHXTx8jZjqVr
 FxcO7AO005YRbHod3hl/15eqMg6beCldWsBiHyU850ppcx2fCpCbg/9Ji5Pq1zihEZ/3j3nsAey
 8AMWT5SeR4wtGv6KLmK6qYwfZsQOaTa17kxiWdaHsup0iJijSnR+nAhXp617KqVyMxFJjadFnHg
 j7RcohdnzaQE/nknaTYP2pcl62deN0bVZ5sx6E4aaTjw==
Message-ID: <879e9e9b-6d71-4ca1-b71b-262fa0cdb78f@kwiboo.se>
Date: Tue, 18 Jun 2024 23:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3328: Enable ARMv8 crypto extensions
To: Jagan Teki <jagan@edgeble.ai>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Da Xue <da@libretech.co>
References: <20240421200908.518855-1-jonas@kwiboo.se>
 <20240421200908.518855-3-jonas@kwiboo.se>
 <CA+VMnFwVMzVxq6A6Mxxug5y+=puq7=GFh8-J5hz9=c+E-8sYwQ@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CA+VMnFwVMzVxq6A6Mxxug5y+=puq7=GFh8-J5hz9=c+E-8sYwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66720265e82f966972441e2e
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

Hi Jagan,

On 2024-06-18 21:18, Jagan Teki wrote:
> On Mon, 22 Apr 2024 at 01:40, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> The RK3328 SoC support ARMv8 Cryptography Extensions and use of the
>> ARMv8 crypto extensions help speed up FIT checksum validation in SPL.
>>
>> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
>> extensions for SHA256 when validating checksum of FIT images.
>>
>> Also imply OF_LIVE to help speed up init of U-Boot proper.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: No change, rebase on latest master bransh
>> ---
>>  arch/arm/mach-rockchip/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index ee0f338995b9..651ecfe9b8fd 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -180,8 +180,11 @@ config ROCKCHIP_RK3328
>>         select SUPPORT_TPL
>>         select TPL
>>         select TPL_NEEDS_SEPARATE_STACK if TPL
>> +       imply ARMV8_CRYPTO
>> +       imply ARMV8_SET_SMPEN
> 
> This blocks the access of PLL registers.
> 
> U-Boot 2024.07-rc4-00052-gfe2ce09a07-dirty (Jun 19 2024 - 00:43:40 +0530)
> 
> Model: Firefly roc-rk3328-cc
> DRAM:  1 GiB (effective 1022 MiB)
> PMIC:  RK8050 (on=0x40, off=0x00)
> Core:  241 devices, 29 uclasses, devicetree: separate
> MMC:   mmc@ff500000: 1, mmc@ff520000: 0
> Loading Environment from MMC... Reading from MMC(1)... *** Warning -
> bad CRC, using default environment
> 
> inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
> inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
> failed to power on phy (ret=-110)
> inno_hdmi_phy phy@ff430000: Pre-PLL locking failed
> inno_hdmi_phy phy@ff430000: PHY: Failed to power on phy@ff430000: -110.
> failed to power on phy (ret=-110)
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Model: Firefly roc-rk3328-cc
> Net:   eth0: ethernet@ff540000

I could reproduce this issue on my Rock64, and it looks like there is a
bug in inno phy driver at inno_poll, it currently readl at wrong addr:

---
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 3bb1a254ffb5..7459779dffed 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -432,8 +432,8 @@ static inline void inno_update_bits(struct inno_hdmi_phy *inno, u8 reg,
 	inno_write(inno, reg, tmp);
 }
 
-#define inno_poll(reg, val, cond, sleep_us, timeout_us) \
-	readl_poll_sleep_timeout((reg) * 4, val, cond, sleep_us, timeout_us)
+#define inno_poll(inno, reg, val, cond, sleep_us, timeout_us) \
+	readl_poll_sleep_timeout((inno)->regs + ((reg) * 4), val, cond, sleep_us, timeout_us)
 
 static unsigned long inno_hdmi_phy_get_tmdsclk(struct inno_hdmi_phy *inno,
 					       unsigned long rate)
@@ -575,7 +575,7 @@ inno_hdmi_phy_rk3328_clk_set_rate(struct phy *phy,
 	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN, 0);
 
 	/* Wait for Pre-PLL lock */
-	ret = inno_poll(0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
+	ret = inno_poll(inno, 0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
 			1000, 10000);
 	if (ret) {
 		dev_err(phy->dev, "Pre-PLL locking failed\n");
@@ -674,7 +674,7 @@ inno_hdmi_phy_rk3328_power_on(struct phy *phy,
 			 RK3328_TMDS_DRIVER_ENABLE);
 
 	/* Wait for post PLL lock */
-	ret = inno_poll(0xaf, v, v & RK3328_POST_PLL_LOCK_STATUS,
+	ret = inno_poll(inno, 0xaf, v, v & RK3328_POST_PLL_LOCK_STATUS,
 			1000, 10000);
 	if (ret) {
 		dev_err(phy->dev, "Post-PLL locking failed\n");
---

Please send a proper patch to fix inno_poll :-)

Regards,
Jonas

> 
> Jagan.


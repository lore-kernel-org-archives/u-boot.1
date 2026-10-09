Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E8ACA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16D28812D3;
	Fri,  9 Oct 2026 12:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_ob4nr8n6Os; Fri,  9 Oct 2026 12:38:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00E9D81255
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791549483;
	b=T1wt0TiTCb379Fb3q0WQlv9Rc48y0WElJ80Z02OrokIHUC0L1h7lCEvNgzwKFlj2mgtV
	 dzBOdLASutFpOU9Z/l0KixPBy5CAWblymIuYHB3iMcj9gCOQfNeIDJf7RDaK+xeT3d4zi
	 u+2yFxOiTrZ00CZNdBlajIlLnAC3DaVZ+bqKcNSdoyPVZUgvUqyiUm0wVTE7oLD2sMtuy
	 fCP6D7X+rVA+XndMu2XGaT2W4TRY1F/Ejs8yuq5DDnXgV4IWetoZoI1nW9Tvvf1RxA/Fa
	 dOLuY1jZ1rPVOLJMR2Npm5GXGzBAIbj1N+GXAxARIKx14CV27KlLSsStT4Scv0yGejw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791549483;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0onVYCeQkXyQ/0bYz7UYwAF+HEc8pLY+Tzj4dWmw7NA=;
	b=C+TKCwlwLhAGwa0aeAmO+SduAmjE78xVE5F/E7oP081UvZWW3abzxkzRlXXR6rQU48pA
	 C0/3klZnxq8Zu6mJmER+ML7iAHW4ovkmLod8WbP2lTHqeujNN0rFRooY15WLCgPbR7egF
	 uWFVT3WmtBDsgbDJjnkjygDb/+xhIH0tB7IkpCvG7zdnUoXmJespjk3uzWnVRcX7lysmX
	 7Z50G9jkGQ4y/+IMEmL2gOQmjRkAKc8dppOzqO1GKtu2VM+Ue5F6jN+eTMRIJivtk+gru
	 XvZrRo6iTCxYBSe0B4T4sgoaXfrUuQlEIs9R4SSwp1TtPQCW7x2nWQw1igslVFgR24Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791549483;
	bh=0onVYCeQkXyQ/0bYz7UYwAF+HEc8pLY+Tzj4dWmw7NA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yvf61/BQWbYCC11FbMRAH8D2ThbMdDunIoI1zsF6vjMguBSO8OATzFXy7k7PFonxe
	 d2xHQFm+XeN/x9QJoPE1i4smGZMfzli/KByYvQ04rfXDMnwxJzPyugMKXwhwBfJJNC
	 4EuBQRdlVAcadnrQCYYZ9Mxffl6ARDYJRLQwXTRSBS2ZT/LKVJJ5/+S3/ZCChO1SlP
	 olz2bQT7kGHL6bh3OXfRve4RbZdZ31M30FtevOcavGkT4TmTderPizfhsRVs7/ABc6
	 l0ba0pM0ij9tz/accMZHV6b5edPzYHBldzMqVhd2Oce6ajh2rY/atvoqAWl0J3J4qa
	 Lcqx45tB33M4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00E9D81255;
	Fri,  9 Oct 2026 12:38:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F047422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64B604083C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:38:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W7Zw20tkxrbN for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:38:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BFA04082A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791549480;
 b=CYlzSggZO/jdMSPpfXlKhqB1vao3de/3LqGGD3F4WERhRBTG2KKZyCJWc3/tmu6z+ycd
 qtwv8isbxkKOYQbqMxaKoKzn5lIklXdcKHCqyX7KLd3aQFPBHmaTPjtBilgCeis+n7PsK
 uCchkAsf96SS/sE8rRt99l3M8zOUkmnWVLQfD2ckiVb15elGBA1oMhZUuXieM2PxX0rUY
 BvduZQoTDPNEhMf3cZBU1V8PTkTc7Q0mt9BepuUOSLueJTeJKWSlljj7B3j6iJih30k+w
 C2MmbdZ5IpLUIjP2ae0tEWkMTN7juuE21BQLOYpeym2bDO5xB4HwNPs1LAm5bLrzkMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791549480;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=0onVYCeQkXyQ/0bYz7UYwAF+HEc8pLY+Tzj4dWmw7NA=;
 b=jyGRQ15CaB97u5bDwH6GMNAj8V+EOUXQgYcsy3fKWePH/LuDUkFWj/Lip4Ju9PeSOPi/
 teZnwXsAxYQWoQXEutzJyH0A5cpz0tsF/yC7lr+rAZbhrj7Me5k9/bde7Y9WhLpfU3InJ
 hbSMUPXNOM2rBHaR+2/j8itXgztGIZely/q1eeRasU9GxWsqbaOCE3UCnLc/QBVJ8Pi3W
 zdrvrwVrVL9h+9bQYO7tFW7FTVExYqtjiuRltgHOc2vmT8LZmy3eWA2VKhHQz7nbu5nji
 9NpebQ05fk3lTafF3jiqBa73m+9sEG/a0zsbJq1SLqvs7CFkF8Wqnic9m7e2Iwpek3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Cgz7wwMi; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c672=ia=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Cgz7wwMi
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BFA04082A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791549477;
 bh=0onVYCeQkXyQ/0bYz7UYwAF+HEc8pLY+Tzj4dWmw7NA=;
 b=Cgz7wwMiYg//6DLCPquhfrYBx9/E3hO2AM+emPBPUaYhGm6G6Y6MWwwYd4SRgRhp019RmHqOJ
 ESvIrI9Vw6TaFDtiGLo4Akumc/ooIfdGvvAb1o8ubQ0eqZztUIXJgCIbnmvlp9RqrH/3eExbWqW
 vdirvr8gqpqHenzyXekxHfsSR2Dd2bxrZj0wNweQvr4m4rrFQYVOKaqSxHK0XFzSsQx8GidcKq8
 LCp66nHrEFG8p+cBIlIKg6Hi0V0upFO3vYAnHgTlYIhV6mSemZMfQ1EeNasav8QSoQmtFXTn+RP
 vBnEMMtjre/4QAzvZvl7/sq7dRZH83Rg3hORr2ShKzsw==
X-Forward-Email-ID: 6ac8e022ec5a50a7d2b616c7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fdc92c5c-f0ca-41b3-9b1f-1797d56e8e72@kwiboo.se>
Date: Fri, 9 Oct 2026 14:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: rockchip: rk3568: Always init clocks in SPL build
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-2-jonas@kwiboo.se>
 <2a1d6192-5d60-40da-9c7b-574117d5b3af@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2a1d6192-5d60-40da-9c7b-574117d5b3af@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 10/8/2026 4:59 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 2:26 AM, Jonas Karlman wrote:
>> The ACLK_BUS clock is initialized to 150 MHz in SPL on RK3568.
>>
>> Ensure clock driver is always probed after bind for SPL builds to
>> initialize core PLLs and clocks in SPL phase on RK3568.
>>
> 
> You explain what this does but not why? What are the symptoms? Why is 
> this the proper way to fix the issue?

Hum, as mentioned above and in cover letter, a few clocks/PLLs needs
to be initialized at SPL phase.

"""
This series flag clock drivers for probe after bind in SPL builds for
a few RK35xx SoCs that require core PLLs and clocks to be initialized at
an early phase.

This should help e.g. ensure SPLL is initialized correctly on RK3588 and
CPU core rate is initialized on RK3576 when booting from RAM/USB.
"""

The clock driver always used to probe in SPL back when these drivers
where added, however changes/optimizations have with time changed
this and now there are boot paths that never trigger a clock driver
probe in SPL, so clocks may no longer be initialized as currently
expected.

This series ensure that the expected clocks are always initialized in
SPL, i.e. restores the old and tested behavior.

> 
> Based on Heiko's message, I'm guessing the issue is that we need 
> something to setup clocks that are only accessible from the secure world 
> and SPL happens to be running in it, but not proper (nor is the kernel). 
> Hence why Heiko needs this in order for the "DSI panel to work again" 
> (I'm assuming in the kernel hence why any fix in any driver/device tree 
> to enable the clock is not gonna help with the issue).

If I remember correctly one of the clocks used in DSI pipeline may depend
on the SPLL, possible use the SPLL in parent clock tree. I think a patch
to set SPLL rate to fix something in OS was applied some time ago.

> 
> This seems to be a bandaid patch instead of fixing the issue (that is, 
> the kernel should enable/control this clock through some mechanisms, 
> e.g. by interacting with TF-A through SCMI).

A few PLLs and clocks use strange or bad reset defaults, so clock driver
tries to normalize/make adjustments of these clocks to help support the
remaining default clock tree and rates.

Some of these PLLs affects CPU core rate others use these clocks as
parent clocks, so we want to normalize/adjust to the safe and expected
defaults as early as possible (SPL phase).

For current mainline unsupported SoCs I added a brief comment for any
such adjustments that are made by clock driver, e.g. for RV1126B:

	/*
	 * Change CLK_CPLL_DIV10 (100M) from using reset default 10 (9)
	 * divider to 12 (11) divider to prevent overclocking to 118.8
	 * MHz when GPLL rate is changed below, after changes: 99 MHz
	 */
	writel(FIELD_PREP_WM16(CLK_CPLL_DIV10_SEL_MASK, CLK_CPLL_DIV10_SEL_GPLL) |
	       FIELD_PREP_WM16(CLK_CPLL_DIV10_DIV_MASK, 11),
	       RV1126B_CLKSEL_CON(1));

	/*
	 * Change CLK_GPLL_DIV6 (200M) from using reset default 4 (3)
	 * divider to 6 (5) divider to prevent overclocking to 297 MHz
	 * when GPLL rate is changed below, after changes: 198 MHz
	 */
	writel(FIELD_PREP_WM16(CLK_GPLL_DIV6_DIV_MASK, 5),
	       RV1126B_CLKSEL_CON(2));

I have delayed any such analysis and change to existing clock drivers
for a future clock improvement/refactor series, in this series I only
intend to restore the old behavior and apply clocks before SPL boot
devices are tested and not put too much weight into why we do it.

> 
> Heiko also said "my DSI panel work again" which implies it worked at 
> some point and got broken since, so it'd be nice to know what broke it 
> so we can have all the clues necessary to fix the issue in the long 
> term. Considering we broke something, I won't resist too much on this 
> patch even though based on the above guesses we're fixing a kernel bug 
> in U-Boot.
> 
> Can you please confirm my guess or clarify?

See above for some details, in short: old code depends on that probe of
a boot udevice has a side-effect that clock driver is probed. Here we
instead ensure clocks are probed/initialized in a more controlled way.

Following commits have at least helped escalate this latent issue:
- c6bba31dbdd4 rockchip: spl-boot-order: Defer probe of boot device
- e22335a221f8 rockchip: Add support for RAM boot from maskrom mode
All udevices are no longer probed before they are boot tested in SPL
and RAM boot does not need any clocks.

Regards,
Jonas

> 
> Cheers,
> Quentin
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
>> index 9f3e9322161e..5a05f1b4de00 100644
>> --- a/drivers/clk/rockchip/clk_rk3568.c
>> +++ b/drivers/clk/rockchip/clk_rk3568.c
>> @@ -2934,6 +2934,10 @@ static int rk3568_clk_bind(struct udevice *dev)
>>   	struct udevice *sys_child;
>>   	struct sysreset_reg *priv;
>>   
>> +	/* Ensure clocks are initialized after bind in SPL build */
>> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
>> +		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> +
>>   	/* The reset driver does not have a device node, so bind it here */
>>   	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
>>   				 &sys_child);
> 


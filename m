Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FB8CA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEA1B80E13;
	Sun, 11 Oct 2026 10:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TtdHH8TB_tvK; Sun, 11 Oct 2026 10:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2487480E18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791715855;
	b=aRzsSbBon51+YFT1AYkPggOCToMTFW3rpp6Fe4hFtCsUH1dSOGWe/ftCdBx6ckiYVJrb
	 QouET1ACrGkNpghOSXXWP2kN9Mw3F0Si8uGnZx/DcJhvovN1YZ/1ykGtmZTYn7sX4w611
	 Zr5uNcVJK6G6JjrSxJAXyD5tWslenmxGQpxNxLRrloY8MpNIfR6qUPL5SnaiRfu0LQxEF
	 d973lvr+3uqb7PGrDBzVgg7YaWYpbza7KGvLAQ93CRSXzr7QE2g8YHgB/grBm5ekWy1rN
	 wZAMD8kwa92Q9HleklySwxjRgkaUWySI9RHRnoWiWx/TgufDFgYrIQ8Z5zyFosKrtkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791715855;
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
	bh=UBDBdvCbP/ze+UsSMNCkO8x7+g5d2bXkpZOYOmMzz48=;
	b=T3SxYoPb7MSH6e/ey51/o1z1m6a1MyRXoNbpyG6ZtDegYw8Ur133R0tEOle0DOtIYAL0
	 CpNRfHJsjy63tfqOp3pFqPR+vR5p2nsvNw9Ht88VCzCokycOPGVfmn8RvEBmXaImb4mga
	 BrOAVTTaeyeTUJruzz2Izvlgil6AGQTvXYp5mPLD/FXxfi4Bphc8sBrczyINKLornu98Y
	 4u0LiKHyvo3iuoGrE26v8gXZZoYLjfhs0miPUgoDEXN/9kezAzFKC9bDzUQrnj4Ha3aUv
	 W/mxK3i04v8KkLiKzC+x9i5NSJMe2zerXdEy80JtA2vhaQ3jnoL5XHkf+KEzlDphmZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791715855;
	bh=UBDBdvCbP/ze+UsSMNCkO8x7+g5d2bXkpZOYOmMzz48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VzbRBO3e5XggLtpdmd2DCi+rNCUtWA0obL/Fbbhe0halKyXaBCoc2ppVMnaibIUpF
	 BLrvf3o3TvCJ2scBA6it8k3BYzlEQiexleiG2qhAr6U6+AAZzosgi0HGe/dJ6y9Bco
	 aFpXvt9oC4k8Gzl4HwTlCx+dQ5PiYSgNsOk2PabM10N9U5dPP2diyybZ3wg7uFwnPE
	 2knc18Zqb1skswtVHzJlrgz8iQTEMuXL5qQG27uQfQuDxh8bNxZxy01qwbpZEE0nx/
	 M1cD5dRVLEG2dGTRE2ds+/ZCjIxep7D7zpCw3/azlXjk3uhJ89+xvL7IdL5yZ3s/v+
	 mTmmxTVHTimjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2487480E18;
	Sun, 11 Oct 2026 10:50:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 845691DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 819274068C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MlXO7-JQu1RN for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0D484068A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791715853;
 b=kwEaz4IqpIyK/30hNXd/5k9+0QJAIHHajzn9xN8ScYd63bA5P8xBydf9H7G9nGnu/2jj
 0OadykbpKrXk2F6IkWVcucPFq+/wS6zVsi5u23EQLcMozM7w7FF2ruEzZHuN1Iunb2lea
 agmOsFYjY+ggmu0/dmCoMDHvsDDeHuU30EqRJdSJu0ASaiD+rtjYNSSM8EG+wP+dF8GD+
 tNP4bXV2Hvs2bBo3qV7wcN2IRBqhy0XgMGH/H1VPXVPkeBtZKEzhQHxvbKLqtyP9T/hGB
 eSL37rrPY9zgc62srH6Tpvf07zvPzyoL/n4TZhVowJDBIgKOAE8XST1RvNuf9FlXnhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791715853;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=UBDBdvCbP/ze+UsSMNCkO8x7+g5d2bXkpZOYOmMzz48=;
 b=GjF9w49wytfYHI77S+L97h8G4FtII4wgnbutZ/AUSFV3mYo4CIs9zTL2NyllMPJ3hpCC
 6v4QNfiyyks43iCfvtHIKO+KI5W6hviOVYY1a8sIjC7K0y/53G0U8v2eLIKa5VE7VGI7U
 eGRjGlVUcWJJHLfW4P1qPmeaVf+RdRDSmNVTCn6WK/6f+IidybXWj3WTRs37DMnjEA+gz
 SHYNdZbyDCuQAPmdyG3TuxCONukxyeLg/Aep3A9RVUnh0GuramK75GwwzuzIsDN8WEh+T
 9E4KXhhfOeGYhqeeBZsmZIZnzYEvSW1zj1dfEdbqwmFxUG24cKIGIw9FWb8n+5nirUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=W3mldz7T; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7247=ib=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=W3mldz7T
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0D484068A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791715851;
 bh=UBDBdvCbP/ze+UsSMNCkO8x7+g5d2bXkpZOYOmMzz48=;
 b=W3mldz7TdlFN6CGBck/xc5ysQ/mYuL+gPVtzmd2X5TjcuW+zQVsX8wMhTPElknxKuvV9bkKBA
 YgO6AXS2NO431bVuADzspQshOEVFXJHzeNbLrjg8HbtghXDLCxBgasY5ZFNEcvC+29ql8cMiYs6
 KFdi+QeYirWt6lHyF/aS5HsG3gKZ6K0R8Mlr9rQh20KdIL3TwtoFdiPUNcO34ynxWbg1EaiO1vW
 DjoZcc0k9G+iKQ3xpiPFH8dHqM3yM55S0ACCWsIMArtg5fSXiRky2e4zK7+70vaJAqoLvlE/wR6
 aq3WDS3LHoRj7rG9R1Vd1IbC9+SheXQA+eAdj+SAnP1w==
X-Forward-Email-ID: 6acb6a0890d5aa3528e3af8e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <181fb05d-7f89-470e-93cc-f89facc8f421@kwiboo.se>
Date: Sun, 11 Oct 2026 12:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] clk: rockchip: rk3568: Use fixed PMU CRU base
 address for PLL access
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-5-jonas@kwiboo.se>
 <a8ecf218-0342-4b20-9f04-a4f02ae7a6a2@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a8ecf218-0342-4b20-9f04-a4f02ae7a6a2@0leil.net>
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

On 10/9/2026 11:48 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>> The RK3568 PMU PLL helpers lookup the PMU CRU udevice before accessing
>> PMU PLL regs. This may trigger a full PMU clock driver probe to get the
>> PMU CRU base address from the clock driver private data, something that
>> can take several ms.
>>
>> Change to use the RK3568 specific PMU CRU base address consant directly
>> to simplify and remove the unneeded complexity of using runtime lookup
>> in SoC specific code.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/clk/rockchip/clk_rk3568.c | 34 +++++--------------------------
>>   1 file changed, 5 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
>> index 5a05f1b4de00..eaf51728520a 100644
>> --- a/drivers/clk/rockchip/clk_rk3568.c
>> +++ b/drivers/clk/rockchip/clk_rk3568.c
>> @@ -94,44 +94,20 @@ static ulong
>>   rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
>>   			ulong pll_id, ulong rate)
>>   {
>> -	struct udevice *pmucru_dev;
>> -	struct rk3568_pmuclk_priv *pmu_priv;
>> -	int ret;
>> -
>> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
>> -					  DM_DRIVER_GET(rockchip_rk3568_pmucru),
>> -					  &pmucru_dev);
>> -	if (ret) {
>> -		printf("%s: could not find pmucru device\n", __func__);
>> -		return ret;
>> -	}
>> -	pmu_priv = dev_get_priv(pmucru_dev);
>> -
>> -	rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
>> -			      pmu_priv->pmucru, pll_id, rate);
>> +	static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
> 
> Do we really need a static variable here?

I guess not, there seem to be a mix use of static vs non-static for
similar variables in Rockchip code, have changed to following for v2:

	struct rk3568_pmucru * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;

There is no change in code so the compiler strips out the static vs
non-static variable away the same.

> 
>>   
>> -	return 0;
>> +	return rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
>> +				     pmu_cru_base, pll_id, rate);
> 
> This is a change in behavior, please have the change from return 0 to 
> return rockchip_pll_set_rate in a separate commit.

Sure, I will split the change to make set_rate return the configured
rate to a separate patch.

> 
>>   }
>>   #endif
>>   
>>   static ulong rk3568_pmu_pll_get_rate(struct rk3568_clk_priv *priv,
>>   				     ulong pll_id)
>>   {
>> -	struct udevice *pmucru_dev;
>> -	struct rk3568_pmuclk_priv *pmu_priv;
>> -	int ret;
>> -
>> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
>> -					  DM_DRIVER_GET(rockchip_rk3568_pmucru),
>> -					  &pmucru_dev);
>> -	if (ret) {
>> -		printf("%s: could not find pmucru device\n", __func__);
>> -		return ret;
>> -	}
>> -	pmu_priv = dev_get_priv(pmucru_dev);
>> +	static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
>>   
> 
> Ditto for the static keyword here.

Have made same change here as above for v2.

Regards,
Jonas

> 
> Changes are fine otherwise.
> 
> Cheers,
> Quentin


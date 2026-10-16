Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C1FCCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33B9A40812;
	Fri, 16 Oct 2026 21:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LeNEIL-pumXa; Fri, 16 Oct 2026 21:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47BF640705
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184641;
	b=F3e4ATTvtwg19rIHI3f+2kqreMRXUGwGR0zllJBw04bVa6kJn636e5H8Ik8UnZv+rpLc
	 nqhw5Qagg0c6PNx94laSW/WtLTAdVt5EVyUA74o9KJQFcGBT232oGGg2gL8uDTCh/lcGi
	 hx2Kr1tBePy8sUdAbJzMxVbCxGhB/umVslT4aE5rLg/9IgH+VuZyQBEeMVOYhZH7otpH1
	 k795zNReTJFejst7a21yk1cM13PatZ167p5FYqZ0nwnSB1CBj1ZVgsgcuvtWbu99xUoJr
	 kCEPPU4VREGbPZKEzt9knkyDyJ1M6Sp61/rUljoRXDaCBBPBii6r8aORDUSqQk6dv8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184641;
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
	bh=USHLqgb4N1L/Umg3jkRur2VgaqTyzLLGxHRoYRfQasI=;
	b=FPmM01OFKXZ1YD9U3OWc4b5ACGr/An7Aak+KyNX76s8w8Y5yCZ416j5F04/JRreCW5x1
	 sfKJV+doC1ifXv2cwC545kwWesSuaH3BuuHdvrjXy6CobCrmKwrPJtdt0cJPVFaDf2KlA
	 J8Fy/OKgV8DRkicCx1BM2EpbKcdsAGDxObt4MMlDPos1r+sq5ydyo6eWHg0iFqLYj1sz2
	 3Ia7FvCWAD88qnjWl9xsU8zPGVAzfobkhp57B2XwaFaJEWUQmPA7D0ZC1XBKbffknI8yN
	 7Ro8SbZaMgwmT1PRySnJ5VRIE4J8EigOADspM8uJDsKSSf7G2I/cnPXLK/SSH5MbXZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184641;
	bh=USHLqgb4N1L/Umg3jkRur2VgaqTyzLLGxHRoYRfQasI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vmlVbX4k/BTpJw1cp1WBOugvwg9H0eorSeEe0/WpVEqZ/FHDGHFFejYRY0IqTenUC
	 NQVgu4rDyf6HA6ZPdZuxStrdmBk6+K5SuoDbxaBsBVZFDCiadg0dEHQVxJdYkMwvrM
	 XzEWQMGk3MGPJnq7Seu8MeMW1IJxPKHI82dXrS4OicmG7OyQc3WoKnj7Zmv0LRD9gV
	 fXswvvOvSHJqUwER4o7oedFIP1MdEuPmYOzsMp1KRQuHW7+k1Odt5vxwXmyeOL2WXp
	 6TMUKh4REORSb3ROm7375OdKBDzeOb2PynzOe9FvyoCJQjsY6uNmzxSPCV4KIWT+bg
	 EWWSuaJzVfKZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47BF640705;
	Fri, 16 Oct 2026 21:04:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7BDE1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD797810B7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9N-UpHeotLD4 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC5BA810B3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792184638;
 b=jFjWhpeolK7qVTX2qGkVLSwHmi/7Zipu2AXWwACohhbsBjS6VKvGW7hwCPwPTTFRoqA3
 mGo3cnOQlmLx+y+HJMJL7zQ5013TZEtH+4JFC5IAiYxpwcEavx96YLRIhWLGJLuptyhG8
 D6JhQPI8O5xoI5qOoHORH7gTN/pEnB3zML1bao/hoIbi8rI8gKY/n4Z+RyzSzUWvjCAcz
 Y3BKWj3wEorxVVY6WcI/O5UVDwSE4uuI00CGmuLqSuz5dEaD3MtPN5huXVr2c8RFDI5v6
 ZqTsjlHD90Eq8FETdA/7OfOZx9T+4Dn22EXBpbv13ta8hLX/ohfD5X4htuCNIuWGGcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792184638;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=USHLqgb4N1L/Umg3jkRur2VgaqTyzLLGxHRoYRfQasI=;
 b=kwQZqRP63rRCn1zqWKvo71O6lQhlmnlBQkOoSAPTz6fZcxQqxGpIpqkTqnDjtEZgiI6X
 BXWZ6bJz1+SSh1ioiGMgAj2JrP3Cz2A/ztGPmCLaXTMQDAXgYWUtD9yCHYhhAV+Mt2cTt
 gcpE5HSBGk606yfApsL6oe39U1SqHuMUb/xD+fSKMfWKGxJVO7dGHg5/6Ji4skW25Kp0m
 3B8FqnLMHzHE92OG2PH2CugzGjOQ8r6/w3nMFX8zDO4ZUKZLJxgkQ6syEnKA4Fl/ickIS
 NLeqGGUePNZWU8MADJidu6ffFTVYm/gHMZmOpfZ8un39nu8m30WcNr9fVemXLVlBK9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zKpxcBmA; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=a807=ih=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zKpxcBmA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC5BA810B3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792184636;
 bh=USHLqgb4N1L/Umg3jkRur2VgaqTyzLLGxHRoYRfQasI=;
 b=zKpxcBmAZyBi6OG0HIaXEnPuOszv6ponNxj9Q9dGBZrbGuTNTyOMo9hAVaWZZ1HspfLrhSafm
 Ndk+RBNORQouXlDnfcaaAvdxC13riwxva7hVrobT3FUrXQ1aSKTuR9UA4tPr8LhDxaqNLPy+xLR
 YmGnhURh3dQZdZiqtMegCvCLMq2Z/A1uCTY3G5W+DXaFyi7I8lJKw3EwtZnzg2Oz7uY6Vs/jjqx
 uPlFKs3rac92DM/2FSDmowMTXpVenBoz8I2F5SL2vWPRc0wqjaZWLGDbmUqBiEDlemThdgpSq+O
 h642LmZW03aJSCOQfVq9UKgbAtcJLPhwyrs2gCHXFyvg==
X-Forward-Email-ID: 6ad29132d6a9c2496e41244a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1f744efc-0c74-4669-b02b-7619eed61402@kwiboo.se>
Date: Fri, 16 Oct 2026 23:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rng: rockchip_rng: Enable clocks when reading data
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261004211349.62883-1-jonas@kwiboo.se>
 <20261004211349.62883-3-jonas@kwiboo.se>
 <71957510-7b09-4d52-a45a-76cba3d8675e@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <71957510-7b09-4d52-a45a-76cba3d8675e@0leil.net>
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

On 10/16/2026 1:11 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/4/26 11:13 PM, Jonas Karlman wrote:
>> The vendor TF-A blobs for RK3562 leave the TRNG and RK RNG clocks gated
>> when returning to U-Boot proper.
>>
>> Try to enable clocks while reading or otherwise accessing TRNG/RKRNG
>> regs to ensure random data can successfully be read on affected SoCs.
>>
>> This is not expected to have any impact on SoCs using a clock driver
>> with unimplemented enable/disable ops.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
> [...]
>> @@ -306,6 +308,10 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>>   	if (!pdata->soc_data || !pdata->soc_data->rk_rng_read)
>>   		return -EINVAL;
>>   
>> +	ret = clk_enable_bulk(&pdata->clks);
>> +	if (ret && ret != -ENOENT)
> 
> Because I was confused that clk_enable_bulk() could return -ENOENT, 
> maybe add a comment stating this is to catch clock drivers that 
> implement a .enable() callback and return -ENOENT for unsupported 
> clocks? RK3399 and PX30 seem to be the only one doing that on Rockchip. 
> Same comment for rockchip_rng_probe().

Correct, this is because existing .enable() ops may return -ENOENT for
unsupported clocks, for pending SoC support in my rk3562 branch the
clock drivers instead may return -ENOSYS for unsupported clocks.

I could possible add a patch that changes existing clock drivers to
instead return -ENOSYS, then this check would be unnecessary. I will
otherwise add a small comment here for a v2.

> I'm also not entirely sure this is proper, shouldn't we rather implement 
> support for the clocks instead of just saying "it's fine, don't worry"? 
> I think only RK3399 would be impacted (as only RK3399 and PX30 clock 
> drivers implement an .enable, and PX30 DTS doesn't have clocks 
> specified), with missing support for HCLK_M_CRYPTO[01], 
> HCLK_S_CRYPTO[01], and SCLK_CRYPTO[01].

We typically do not need to have enable/disable support in Rockchip
clock drivers, only for clocks that is disabled out of system reset, or
as in the mentioned case, because TF-A on RK3562 disables these clocks
before returning to U-Boot proper. Also we first should/need to have
proper clk enable_count handling before we try to add new enable/disable
ops for Rockchip clock drivers or we can very easily disable clocks that
are needed by multiple devices.

> While looking at it, I also saw that there are resets in the node, maybe 
> something we'll need to control in the future too?

Out of all RK SoCs I have been testing 'rng' command on, only the RK3562
is having any kind of issue, and only because vendor TF-A blob
explicitly disable the clocks used for crypto/rng block.

A different hack/workaround would be to ungate the affected clocks in
RK3562 clock driver probe(), but that is something I rather avoid.

> 
>> +		return ret;
>> +
>>   	for (i = 0; i < len / RK_HW_RNG_MAX; i++, buf += RK_HW_RNG_MAX) {
>>   		ret = pdata->soc_data->rk_rng_read(dev, buf, RK_HW_RNG_MAX);
>>   		if (ret)
>> @@ -317,6 +323,7 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>>   						   len % RK_HW_RNG_MAX);
>>   
>>   exit:
>> +	clk_disable_bulk(&pdata->clks);
>>   	return ret;
>>   }
>>   
>> @@ -336,12 +343,22 @@ static int rockchip_rng_of_to_plat(struct udevice *dev)
>>   static int rockchip_rng_probe(struct udevice *dev)
>>   {
>>   	struct rk_rng_plat *pdata = dev_get_priv(dev);
>> -	int ret = 0;
>> +	int ret;
>> +
>> +	ret = clk_get_bulk(dev, &pdata->clks);
>> +	if (ret && ret != -ENOENT && ret != -ENOSYS)
> 
> I think what you want is clk_bulk_get_optional() from the Linux kernel, 
> so please implement that in U-Boot. We have it for reset, clk (not for 
> bulk yet) and gpio, so this is the right way to go.

Hum, in U-Boot we have clk_get_bulk() and Linux have clk_bulk_get() with
different set of parameters, so adding one more non-conformant clock
function to U-Boot is not a can of worms I am willing to open ;-)

Regards,
Jonas

> 
> Cheers,
> Quentin


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26B7CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD4E846E7;
	Tue, 19 May 2026 16:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PCrx9NrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55EA84705; Tue, 19 May 2026 16:27:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E222846E6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d823=DR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779200819;
 bh=Ntmr+O49BW5VCicn5dTrw14JcS+RRDxxOseWNhf3/qU=;
 b=PCrx9NrP6PRsmd1h+S5NlopxuzC0TWQanxdVRNGgGbJS0C5R4xe9+vg9zSdW6ObN1cfdZKzwh
 IY3JShfRf6JLR9QOItJtkiA9pNYYCTcP0tDfRHl0DcifsCMBpbIzAozqAML7cj4AOTIxdZ9bC2d
 R0xwa1JOOQ6bHVfTo8jzlneROQ49v255/hpDdq1L2va7pe8k7wwZZmOoj0N0nPhVldFKCtuZo8X
 LwyTBD4UsI4JEpMiKsdqIAeUBv17mRoUlZgJVXD7YbX9oIN8OXlrDsKbPB+xfRbkwaRS0rgutTm
 awSF5eM8wm3Eb6LL1tunYGsY8ghVZCofU7kkB4rWzMhA==
X-Forward-Email-ID: 6a0c732aa924624a2f9d552d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2f1c1665-a744-4755-9755-0fe3e34fb294@kwiboo.se>
Date: Tue, 19 May 2026 16:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: add gated-fixed-clock driver
To: David Lechner <dlechner@baylibre.com>,
 Daniele Briguglio <hello@superkali.me>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
References: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me>
 <20260519-rock-5-itx-pcie-refclk-dtsi-v2-1-738b67857cac@superkali.me>
 <fe4af92b-ccfa-412e-8786-efc34f575ff3@baylibre.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fe4af92b-ccfa-412e-8786-efc34f575ff3@baylibre.com>
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

Hi David,

On 5/19/2026 4:09 PM, David Lechner wrote:
> On 5/19/26 6:55 AM, Daniele Briguglio wrote:
>> Add a UCLASS_CLK driver matching the Linux DT binding documented at
>> Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml, a
>> fixed-rate oscillator whose output is enabled by toggling a
>> regulator supply.  The optional enable-gpios variant is not
>> implemented.
>>
> 
> ...
> 
>> +static int clk_gated_fixed_enable(struct clk *clk)
>> +{
>> +	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
>> +
>> +	return regulator_set_enable_if_allowed(priv->supply, true);
>> +}
>> +
>> +static int clk_gated_fixed_disable(struct clk *clk)
>> +{
>> +	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
>> +
>> +	return regulator_set_enable_if_allowed(priv->supply, false);
>> +}
>> +
> It seems a bit odd to use regulator_set_enable_if_allowed()
> since the point of the binding is to provide a clock that
> is gated by a regulator. Why would someone use this binding
> with a regulator that can't be enabled/disabled?

The regulator_set_enable_if_allowed() is the main func consumers in
U-Boot should be using when dealing with regulators. Unless the consumer
wants to manually deal with i.e. ENOSYS (no regulator support), EACCES
(always-on), EBUSY (in use) or EALREADY (already enabled) status.

Regards,
Jonas


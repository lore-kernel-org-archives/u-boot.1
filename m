Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D81CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 16:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8895F87DCA;
	Tue,  9 Apr 2024 18:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ky8vgl3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786CE8809E; Tue,  9 Apr 2024 18:36:46 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFC8875E9
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 18:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712680603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCZ2yskQXS4wYFuTl5L9iIfFSZizhZYLgnNGl9drMwk=;
 b=ky8vgl3Z096ngETT+oXfWadJlwn5k8iiPRJVRu6G9nnhZz34B1aWzvfZtO83j8CznFV9Io
 Ad0FH2h10ybv1pTVOZIRSwM08d1OSQ+TvwXc0Nx2rQIyUqGEiBqNWW/l01Pwdb6eWj00gY
 zN6+c23MShFzgdRUkJlF1sqm3PlEQKYgmI3N/+tDbkhMUQzy1+DK+MLDbsmOEqV8fsAHMb
 P3jKALUkodghZPpSNqEWFHU3F+8TWFgQR5EcE2fhcohOKTXObuoPkUAGKw/v/X3diCZypM
 aBgY3cfL3MXEZbmCl+fvczBhff7Wjs/laotHur8vxbMoDU+pU7XGRkCOewwlVw==
Date: Tue, 09 Apr 2024 18:36:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Andy Yan <andy.yan@rock-chips.com>, Akash
 Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 05/14] rockchip: rk3308: Enable random generator
In-Reply-To: <3fb8bdca-042a-4153-ae0f-114bbafcb82f@theobroma-systems.com>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-6-jonas@kwiboo.se>
 <3fb8bdca-042a-4153-ae0f-114bbafcb82f@theobroma-systems.com>
Message-ID: <6fd1fb1645c7e519f071f22930eb8b4d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-04-09 17:45, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/8/24 20:14, Jonas Karlman wrote:
>> The RK3308 SoC contain a crypto engine block that can generate random
>> numbers.
>> 
>> Add rng node to soc u-boot.dtsi and enable Kconfig options to take
>> advantage of the random generator.
>> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: No change
>> ---
>>   arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
>>   arch/arm/mach-rockchip/Kconfig  | 2 ++
>>   2 files changed, 7 insertions(+)
>> 
>> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi 
>> b/arch/arm/dts/rk3308-u-boot.dtsi
>> index 436f66d1b87d..fa31c838d34d 100644
>> --- a/arch/arm/dts/rk3308-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
>> @@ -26,6 +26,11 @@
>>   			reg = <0x07 0x10>;
>>   		};
>>   	};
>> +
>> +	rng: rng@ff2f0000 {
>> +		compatible = "rockchip,cryptov2-rng";
>> +		reg = <0x0 0xff2f0000 0x0 0x4000>;
> 
> Downstream says something different:
> 
> https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3308.dtsi#L1007-L1020
> 
> I couldn't quickly find the TRM for the RK3308 so cannot check myself 
> :/

The RK3308 TRM can be found on the link below.  BTW, there's also
a rather interesting PDF file that describes a node shrink of the
RK3308, the so-called S-version chip.

https://dl.radxa.com/rockpis/docs/hw/datasheets/

> Also seems to be missing clocks and resets?

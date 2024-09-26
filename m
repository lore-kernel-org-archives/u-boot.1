Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3DECDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B935E89041;
	Fri, 27 Sep 2024 00:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727391048;
	bh=ChzMy5WYqc3uW8w8j0l/YJ76ufI3mEG1AJyTnWAHWvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gGaB9pbhCG+ZkSLuTHrS9/tQqGucJjk6Gkj3y5hN1ExN1DmRFK317fCKKjLu0+TAW
	 g7j/D6uXi+jOSowEuAJDD6biHgWxggK5Rmj5raDsAAieJUlv8If2nS9x5QXJ1nslvp
	 8HuX2RimmmQz1UMQNIgRPf8Y8+LfENxAlz/pYMTspY6J9CxMxTa2L7OIFVCn1oLZyU
	 LXqSNKU9sIDdAdRqnRftPH70wYBVvcXaobAXEs+uKPWwBhNzArMNr00wXZ5/bB6wNB
	 iO0h+hOSM/4o8YimSuXcLS4/q4AX47rvovHLxN1KtjMWeZU6zBhliuFjqjGoQK5MIw
	 hNsJGcdefwjAA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 28D2788F08;
 Fri, 27 Sep 2024 00:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727389015;
 bh=ChzMy5WYqc3uW8w8j0l/YJ76ufI3mEG1AJyTnWAHWvQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DiXsIH+G6ZySjfUCfP5aKPpfnXl8I+vYWVWriBGcB3t9w31yebE3rXbXxbca9CkgY
 fbucKsnL1LcldN3CfoMX0eWUNl6VePMlr/EGjolRDcqbLZG/sC+lkOUzdFa6GHmgDg
 qz7roYNQmT4NjhE68/kRHiCZsysXPbVT5OuPaxW5VY6FZ79KVX12uxtE/H2mkO7Hbh
 lSFNUjcZBwNJJC6spPPk5tdLYrUNXWLYmava2gf9lNqH9SudwnRAvsez4Q5WDAFtqw
 l9eEjCyR04aBA+D669ArIuyD6Vvx27IxFlb7rLK0HBcnOQGKsc6Wl9fSeoRrwAWvAR
 DDKhYGTEFPNSQ==
Message-ID: <b769e5c6-7e19-4ce6-9c3d-9a262a1bad8e@denx.de>
Date: Fri, 27 Sep 2024 00:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] power: regulator: Trigger probe of regulators
 which are always-on or boot-on
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240925022314.714285-1-marex@denx.de>
 <b8eb1c20-afdb-497e-9788-498550520d61@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b8eb1c20-afdb-497e-9788-498550520d61@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 27 Sep 2024 00:50:46 +0200
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

On 9/26/24 5:05 PM, Jonas Karlman wrote:
> Hi Marek,

Hi,

> On 2024-09-25 04:21, Marek Vasut wrote:
>> In case a regulator DT node contains regulator-always-on or regulator-boot-on
>> property, make sure the regulator gets correctly configured by U-Boot on start
>> up. Unconditionally probe such regulator drivers. This is a preparatory patch
>> for introduction of .regulator_post_probe() which would trigger the regulator
>> configuration.
>>
>> Parsing of regulator-always-on and regulator-boot-on DT property has been
>> moved to regulator_post_bind() as the information is required early, the
>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>> slowing down the boot process.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [snip]
> 
>>   
>> -	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> -	      property, dev->name, uc_pdata->name);
>> +	/*
>> +	 * In case the regulator has regulator-always-on or
>> +	 * regulator-boot-on DT property, trigger probe() to
>> +	 * configure its default state during startup.
>> +	 */
>> +	if (uc_pdata->always_on && uc_pdata->boot_on)
> 
> This check for always_on _and_ boot_on does not fully match the commit
> message, comment or the old behavior of regulators_enable_boot_on()
> where any always_on _or_ boot_on would trigger autoset().
This should be ORR, thanks for spotting this, fixed in V3.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF7CCFA10
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44DC88C9C;
	Thu, 26 Sep 2024 04:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727318843;
	bh=mDA8nYm085iMQg82Ruu/WNYO/8JmotOYpZYNOBeNcdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRJnZIXDbVwFX8bw1D6zspkNpidzFR0UjVAF7O4gzf+pMgIFd+HRgPOG/AK361FBD
	 IJZlm8jfJQFGXGRxg14RjP2chjzcsojAqN9O1J6aS4CLL220TYmInplQU25C2qzHJ3
	 8tZJ2akWJVbft8psX+s7NHnI8wLpNXdg8G1h05+XZUN/TBh8vk/5MoVbq9oG7XExsn
	 9pgJ2/jLR23Bn4JjVyel759mAqOUb7MJe2VN8ZdjkZnq5Jqr9q64ydJQT0UoS0bvyb
	 73bUHKY2wPk1TF0JDQux1+uB4TM465xI/fqFnfTImJkNfYw7RWZuy4dkaY4HYkVLZc
	 Q9T6lR52YTEqA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5B38A86E61;
 Wed, 25 Sep 2024 16:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727274856;
 bh=mDA8nYm085iMQg82Ruu/WNYO/8JmotOYpZYNOBeNcdQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Tui23UPtVgOIxEEO6PgYEFsJsB4rGyLsqDAhkI6BYrS7UgO+ykKq06A0yD4HGetIJ
 DJKGZ0L8h1ByKg/Esr/jxg6ZSvdqFD1Xif1vs4669HfwafHDGu3f1RRPc5f82vVy8t
 XXzl/0Kb3AZEX2LNBUlB3civOIaW5aD0Hkzir0x1d4gmV03nnph51wDE4ZAvGGYsve
 +ZRu2T8B5muZbACDw2wSi13IgI3v7zOP3i7qBxrg659Un8Rc4Dd2MZdcQpPynTeXW6
 kH9M8qwaaL1wwNTxCp/CoK+wb61ldOVSiLyNvgPcfBLjZUr/sLE0XZE6N9j/bGxarX
 YD+/CcaQ2fFuw==
Message-ID: <3ed23dbc-588c-439b-b018-489aafb8ec25@denx.de>
Date: Wed, 25 Sep 2024 16:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
 <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat> <20240924234406.GX4252@bill-the-cat>
 <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
 <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
 <CAPVz0n3cH5_1iK+0PSW1mBFKQz13Z0DKJyi6GdsGpPQpvBQ7mg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n3cH5_1iK+0PSW1mBFKQz13Z0DKJyi6GdsGpPQpvBQ7mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Sep 2024 04:47:21 +0200
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

On 9/25/24 3:04 PM, Svyatoslav Ryhel wrote:
> ср, 25 вер. 2024 р. о 15:48 Marek Vasut <marex@denx.de> пише:
>>
>> On 9/25/24 12:18 PM, Svyatoslav Ryhel wrote:
>>
>> [...]
>>
>>> Hello there!
>>> I was digging this when I had some free time and found that with
>>> patches from Marek the only difference is that function
>>> i2c_get_chip_for_busnum is not called for PMIC's main i2c address
>>
>> Is it possible this is called earlier, before UART output is
>> initialized, so it does not show up in the log below ?
>>
> It is highly unlikely, this function is called when uart is already
> working and pinmux is set.

It could be called earlier now, try to enable CONFIG_BOOTSTAGE and add 
BOOTSTAGE_MARKER() to points of interest (like the I2C functions). You 
should be able to see whether that function was called in 'bootstage' 
command output, even if UART wasn't active at that point yet.

>> Could it be that it is called before your pinmux is properly
>> initialized, hence no UART, and that is why the I2C communication fails?
>>
> But if we assume that pinmux is not set, then how we resolve situation
> when pinmux and regulator enable are both set by probe after bind and
> regulators are probed before pinmux. Regulators will fail, they will
> not deffer till pinmux probes. Or you propose return to pre-DM version
> of pinmux? Inconsistency.

I am not going to guess what the problem is, currently it is unclear. 
Once we know what the problem is, we can determine the best solution.

>> So far, I only found Toradex Tegra T20 board here, no T30.
> What do you mean? Specify please

I have Toradex Tegra T20 SoM and board here, probably not useful.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51CC369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF21788C40;
	Wed, 25 Sep 2024 14:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727268563;
	bh=YyPyGijE2wAEVvrrSqSVu98U/0LY+Z3cFTaHvNKWdcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s3UO4Y6WNTxL/SKtl7mbgCeDBnXiRQ4qDbZonCZQeo9XkE0zIhSEeGxTqnExiz66L
	 h1JWPmzXwx8j9QjNc8DFq/ZLTdMYLr57E1ugpT2fxPZfMOs8H4XOJFexwwOd29uePJ
	 m8MLdAwXmBnkWlbNL40SHX+WbLT9nClhFgEeMT/L5WV4ery2OQGy0QxOmVUoTChASA
	 7+bL2bohj2kecCOyfoWqQeIhC8buC/v9y7gS6mRUjFm0yeKhWz2DdgYCXYEJ2dv9wO
	 lHVz0IEbO680FfHCE01QyiNghu7sdwjoxiahoscLMjcHiaXpC++n8sNoqb8+GQd5y5
	 fXOXDpgmPJpJQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0DA9F88363;
 Wed, 25 Sep 2024 14:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727268494;
 bh=YyPyGijE2wAEVvrrSqSVu98U/0LY+Z3cFTaHvNKWdcM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LUv051IGbnRJBQh6Q3iv9zLndq1JNMQAO0bkLYz+7YjzScBWyK9LbxsrBvjNdYmTJ
 DWxAg++LnqOgGqv8SaZvjviBqVRajPJbhikdIzvvpG95LR4OFPGcqhHBE06tjVV1jN
 43+rVjnCortkwvd9IihGLK0Xdbidrr3cl1byTFJlb2ZCI1zm8qqpYq3iXPBtZI5NRe
 IsO8HmwXGCdajqSFq02voogYXbVPxgmaI+C8zgrx+C8vOkg+GaTsqbrRESSlcdHQDM
 6B6EEAlBEt0PAV2tOsL8N2y1LL3hs/dVE/CTK/sSmPs/H/D2uBR7G3WBIuSh3Vw3AX
 +WxIpnNuD/ZCw==
Message-ID: <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
Date: Wed, 25 Sep 2024 14:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 25 Sep 2024 14:49:21 +0200
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

On 9/25/24 12:18 PM, Svyatoslav Ryhel wrote:

[...]

> Hello there!
> I was digging this when I had some free time and found that with
> patches from Marek the only difference is that function
> i2c_get_chip_for_busnum is not called for PMIC's main i2c address

Is it possible this is called earlier, before UART output is 
initialized, so it does not show up in the log below ?

Could it be that it is called before your pinmux is properly 
initialized, hence no UART, and that is why the I2C communication fails?

So far, I only found Toradex Tegra T20 board here, no T30.

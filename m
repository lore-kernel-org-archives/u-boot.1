Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3222C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 23:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6788878A;
	Mon, 29 Jul 2024 01:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722211153;
	bh=k1AFgygvFHZ/zHSDrCNFMP54zJy2JPbF+8/VUQ/Extc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7w6tIsKqdxfgBAUe9kjUv/fPt6Hlu/Q2Zqt0y2FbTGYvB8PwKGFTBtCTes6Ijaxw
	 04067ocM3JTOsBSA9UWc4s9ZBz7kl0Bzo1aLYsriNaKBoadLK81Ar1CcMOgJ6zQA6L
	 IquleYHNsMp2chzejB3Fz1VvIOzA5XDAchSUs2VX2SlyKq1R0QHedogjWi292Ryq2c
	 t+KmtZRRmx46b7fR+WYzoK4yV6e8C8SYY0lZxSHEBQO5TGiJJY7iXsxQdKKQhS7DTh
	 JvQCRlvPsJKAkhz8xCEZd5mEM2cUL3wezWpIamwrKNmgiOVUkhGrvHP0xzj7WqOuob
	 gWkGrv3TX/TCQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2B00087705;
 Sun, 28 Jul 2024 20:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722191730;
 bh=k1AFgygvFHZ/zHSDrCNFMP54zJy2JPbF+8/VUQ/Extc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=E95E+AaqxU/+atfpQ090+6A6zZEY9c7cUP0yJ765Tj/3Y1t2sVixWaHp7jtSUSLtE
 PNMThkHyC9YT1IxZykQaWfPrngHvGza+S44PItDnFxuLxw1QW7jpNOPFH9sePYHQMA
 1kViKesylQXdVH3t6O0ZyS9z3e8DwtvzfYeMVfVBpLdNXpwxyemBN52P/azSGKkVNV
 sEYB6qkPtgS07GWXqOfTdPcfHkR2HGbqwWkl/CLxhDkCcIESE/+7F3J67ThDxtsLKc
 IExQ5Uyw4HWlhefPjHsVtkcihmDCJvIIJlSIg4CzPc21qOg6M+ptopvexRsQbQl3+h
 hJk6K2pRnUvnQ==
Message-ID: <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
Date: Sun, 28 Jul 2024 20:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
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
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jul 2024 01:59:10 +0200
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

On 7/28/24 7:55 PM, Svyatoslav Ryhel wrote:
> нд, 28 лип. 2024 р. о 19:38 Marek Vasut <marex@denx.de> пише:
>>
>> On 6/27/24 1:55 AM, Marek Vasut wrote:
>>> In case a regulator DT node contains regulator-always-on or regulator-boot-on
>>> property, make sure the regulator gets correctly configured by U-Boot on start
>>> up. Unconditionally probe such regulator drivers. This is a preparatory patch
>>> for introduction of .regulator_post_probe() which would trigger the regulator
>>> configuration.
>>>
>>> Parsing of regulator-always-on and regulator-boot-on DT property has been
>>> moved to regulator_post_bind() as the information is required early, the
>>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>>> slowing down the boot process.
>>
>> Is there anything blocking this series from being applied ?
> 
> This patchset causes PMIC regulators probe too early which results in
> i2c line setup failure. These patches MUST NOT be applied in this form
> since they will break at least 15 Tegra 3 devices which use DM PMIC,
> maybe more.

Thank you for testing. I do not have any tegra 3 devices, but this 
patchset does not do anything with pinmuxing. If a regulator is probed, 
all of its dependencies (i2c bus, pinmux configuration, etc.) should be 
probed as well. Can you have a look at what the problem with pinmuxing 
is on tegra 3? It seems it might be unrelated to this patchset and would 
eventually show up elsewhere?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0790CCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED6088C7C;
	Thu, 26 Sep 2024 04:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HC9i1e9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D0A85B66; Wed, 25 Sep 2024 16:30:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B44188B13
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 16:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4199=QY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727274590;
 bh=Z4zeMRODlJOGsqiMVzzf6up848uR7mLw3u/TVTd5u58=;
 b=HC9i1e9i4C3LhyjTRbMK6duOTjOCxvJxbOKDzN/Dc7pbjdBholfAyg/nxZJ06jnM37vFbZ+LM
 2Prv6mRqSlidZZYjarLv6VOzTmPDQ0HMK8I5b3Vmq7DoC3squc2VeC390BSayi75v3qmX6o6nCE
 N88ZEU+0lSU0hnHqanUo7Afu4D2kbSJBsN9biGb3F7gH6H5/FgbtqF/+jIvjLcMbFif0oktIwjF
 w1Hl/RlKL9usCWlN4jHwSWtSpJUeUsZxjDMt28gahyJLLoPF1aI8DtBZPzu+YayMfbeA7zLS332
 0cTSfbgxGtffdmkrEzz6UZSPRZBVz7TmcnnJR/nbxpeg==
Message-ID: <22f60b89-a1bb-4ddd-a5e7-8d6b19ea7f68@kwiboo.se>
Date: Wed, 25 Sep 2024 16:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
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
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f41e5b51aa012038052da9
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

On 2024-09-25 12:18, Svyatoslav Ryhel wrote:
> Hello there!
> I was digging this when I had some free time and found that with
> patches from Marek the only difference is that function
> i2c_get_chip_for_busnum is not called for PMIC's main i2c address
> which results in issues with i2c you have seen in logs before. I
> assume this is not a tegra specific issue and not even related to
> these regulator patches itself.

The i2c_get_chip_for_busnum call is typically protected by
CONFIG_IS_ENABLED(DM_I2C), do you have DM_I2C and SPL_DM_I2C enabled?

grep DM_I2C .config

> 
> To verify my suspicions, Tom and Marek my you please dump u-boot log
> with and without patches and with enabled debug logging from
> i2c-uclass and i2c driver of your SoC.
> 
> Here are logs from my device (Tegra SoC)

What board target / defconfig is used? Would like to understand what
bootph- props are used in the built control fdt.

> 
> Not working
> (bootloader) i2c: controller bus 0 at 7000d000, speed 0:
> i2c_init_controller: speed=400000
> (bootloader) i2c_init_controller: CLK_DIV_STD_FAST_MODE setting = 25
> (bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 59:
> (bootloader) not found
> (bootloader) pmic_reg_read: reg=37 priv->trans_len:1i2c_xfer: 2 messages
> (bootloader)
> (bootloader) i2c_xfer: chip=0x58, len=0x1
> (bootloader) i2c_write_data: chip=0x58, len=0x1
> (bootloader) write_data:  0x37
> (bootloader) pkt header 1 sent (0x10010)
> (bootloader) pkt header 2 sent (0x0)
> (bootloader) pkt header 3 sent (0x100b0)
> (bootloader) pkt data sent (0x37)
> (bootloader) tegra_i2c_write_data: Error (-1) !!!

Is this at SPL, U-Boot pre-reloc or after relocation? A more complete
boot log may help us understand when this happens.

> 
> Working
> (bootloader) i2c: controller bus 0 at 7000d000, speed 0:
> i2c_init_controller: speed=400000
> (bootloader) i2c_init_controller: CLK_DIV_STD_FAST_MODE setting = 25
> (bootloader) pkt header 1 sent (0x10010)
> (bootloader) pkt header 2 sent (0x0)
> (bootloader) pkt header 3 sent (0xb0)
> (bootloader) pkt data sent (0x0)
> (bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 58:
> (bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 59:
> (bootloader) not found
> (bootloader) found, ret=0
> (bootloader) i2c_xfer: 2 messages
> (bootloader) i2c_xfer: chip=0x58, len=0x1
> (bootloader) i2c_write_data: chip=0x58, len=0x1
> (bootloader) write_data:  0xfb
> (bootloader) pkt header 1 sent (0x10010)
> (bootloader) pkt header 2 sent (0x0)
> (bootloader) pkt header 3 sent (0x100b0)
> (bootloader) pkt data sent (0xfb)
> (bootloader) i2c_xfer: chip=0x58, len=0x1

Is the working scenario happening at same call site as not working?

Try with #define LOG_DEBUG in lib/initcall.c and compare/include a
longer part of the boot log.

Regards,
Jonas

> 
> As you can see this part
> 
> (bootloader) pkt header 1 sent (0x10010)
> (bootloader) pkt header 2 sent (0x0)
> (bootloader) pkt header 3 sent (0xb0)
> (bootloader) pkt data sent (0x0)
> (bootloader) i2c_get_chip: Searching bus 'i2c@7000d000' for address 58:
> 
> is missing in log from u-boot where Marek's patches are applied and
> this log fragment co-responds to i2c_get_chip_for_busnum call


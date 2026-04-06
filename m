Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF47AFB5178
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 23:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A671284034;
	Tue,  7 Apr 2026 01:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="f5ldu1Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE2283EC6; Tue,  7 Apr 2026 00:55:16 +0200 (CEST)
Received: from mxd-3-715.seznam.cz (mxd-3-715.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790448352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 00:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-lgzgl
 (smtpc-mxd-7644845457-lgzgl [2a02:598:96:8a00::1200:715])
 id 51ad0b5d0aa35f345004c703; Tue, 07 Apr 2026 00:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775516072; bh=rk0RCtZi3tfxRufQZNo2xK6XlxUog+OkvQ12Nj1R9ok=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=f5ldu1Jone/7J0sl74aBqNIDueDtKW3EDLrxOa1YorvwTh4BrFIxqCJIxK9aQDHEy
 vBeMY05heVc1wT/ZBoQD4/BlQgjl3Na/8Ezdq6w5vrTBtytxNKQk63WFJuICyRoUKC
 rbnvfI5IQdlCLmMHT+V7mAw7MnT5ntcR/n5Tg3MwgNjAvUESf5D95VplUVH4PoOnpI
 MNgUAOzqajI/lVJsMFen3pBOwFq1xUhjLD4OiFmROzm2sK3kMkTJ6B0E1nTzllO60C
 X0E/k7Tm1o9RGcazhz6LgxH6Nv1xLeonBPpOAMUfbBayOxHAduqWO4x0bgFEwGKEWG
 qf9Rvv+x1TyMw==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-789d8dfb5c-q6vgm (szn-email-smtpd/2.0.71) with ESMTPA
 id 3ce55bc0-00f1-4f6c-be3f-02294f33651c;
 Tue, 07 Apr 2026 00:54:23 +0200
Message-ID: <d27384d2-3783-421c-974d-bbbfa509bfbe@seznam.cz>
Date: Tue, 7 Apr 2026 00:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dts: add empty .dtsi for shift-axolotl
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-5-9e6c2ac66587@seznam.cz>
 <CAFLszTiFMrsz6ePKymAuRUP2zYaLdjTjsaeAPr97DiawVopCuQ@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszTiFMrsz6ePKymAuRUP2zYaLdjTjsaeAPr97DiawVopCuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 01:26:10 +0200
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

Hi,

On 4/6/26 17:53, Simon Glass wrote:
> Hi Michael,
>
> On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
>> dts: add empty .dtsi for shift-axolotl
>>
>> This is necessary to select shift-axolotl as a target, in practice
>> the upstream dts will be used
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> diff --git a/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* When there is no previous bootloader, the memory node won't get filled in.
>> + */
> The build system uses the first matching -u-boot.dtsi file. Since this
> board-specific file exists, it takes priority over sdm845-u-boot.dtsi,
> which adds bootph-all properties to gcc, usb_1_hsphy, usb_1_dwc3, and
> rpmhcc needed for USB DFU in SPL.
>
> Please can you add:
>
>      #include "sdm845-u-boot.dtsi"
>
> This is the standard pattern - e.g. meson-gxbb-p200-u-boot.dtsi which
> includes meson-gxbb-u-boot.dtsi.
I just realized my (compile) testing was flawed and used existing artifacts,
fixing that and doing a proper clean build alerted me to the fact that
messing with CONFIG_SYS_SOC is a terrible idea that leads to pain and
suffering, so I will absolutely be simply using an include instead in v2.
> The commit message says the file is 'empty' but it contains a comment
> about memory. If that comment is relevant, perhaps clarify what it
> means for this board. Otherwise I suggest removing it until there is
> actual content.
That's definitely a copy paste error, I was copying the SPDX header since a fully
empty file was still triggering license error and must've slipped. will fix.
> Regards,
> Simon


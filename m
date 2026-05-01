Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D479CCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 14:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5C880F0E;
	Fri,  1 May 2026 16:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="ANTim1dS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A218583A91; Fri,  1 May 2026 15:05:31 +0200 (CEST)
Received: from mxd-1-a0f.seznam.cz (mxd-1-a0f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA45B80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 15:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-lmwqj
 (smtpc-mxd-5f4d8d5f6f-lmwqj [2a02:598:128:8a00::1000:a0f])
 id 7573546a2e7d000374da9834; Fri, 01 May 2026 15:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777640681; bh=h9ccC0VqLVcxOfYvfbKVB0EExFie/lKMDAtMK1j/jS4=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=ANTim1dSnF6b7ZrVAV39XMp4F+SoAqqByhOI5uZEqPEdKNojLKIpEeD8Di/0wSeQo
 JISjjxSEEeA2+1Unh/wtctsc9sSEXYWt6mwk2Rp4hJihyOTIzNddChgQ9Wm6u+DIWQ
 whmrYg37gsvOlYLZW2Q9aXlECSrgknx6V8p9FIR/Mf8pLPTl9t8+nvHMH3FLqHJMEe
 SbWHYxPZzLHEeRfEV9DF0v9zaVi6JOaPjvstPZ+QAiON9j34w4NS5/pXZTLp6lg0tm
 9CimstdVjemOYBkVC/iwHJjEzgHvOh7clvzbvxIFhSG8lqlnnS5kgKXvBFl94E800q
 devCpWaoG1/sg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-6597cc8696-j2tv7 (szn-email-smtpd/2.0.72) with ESMTPA
 id a8dd897b-e2ac-40f1-99ec-aa162094c0bd;
 Fri, 01 May 2026 15:04:24 +0200
Message-ID: <425e0586-a8f3-4852-88d8-d770d4afd955@seznam.cz>
Date: Fri, 1 May 2026 15:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] dts: add u-boot specific sdm845 .dtsi and a
 .dtsi for shift-axolotl
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
 <20260426-qcom_spl-v4-11-8cf4133ff883@seznam.cz>
 <afRXvbwdCbz_TQeb@sumit-xelite>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <afRXvbwdCbz_TQeb@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 01 May 2026 16:46:21 +0200
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



On 5/1/26 09:35, Sumit Garg wrote:
> On Sun, Apr 26, 2026 at 01:26:13AM +0200, michael.srba@seznam.cz wrote:
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> The board .dtsi just includes the SoC-specific .dtsi, which
>> adds bootph-all markings to upstream dts nodes which are
>> needed in SPL.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>   arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi |  2 ++
>>   arch/arm/dts/sdm845-u-boot.dtsi               | 16 ++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..d41210ab23a
>> --- /dev/null
>> +++ b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
>> @@ -0,0 +1,2 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "sdm845-u-boot.dtsi"
>> diff --git a/arch/arm/dts/sdm845-u-boot.dtsi b/arch/arm/dts/sdm845-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..b029264555b
>> --- /dev/null
>> +++ b/arch/arm/dts/sdm845-u-boot.dtsi
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +&gcc {
>> +	bootph-all;
>> +};
>> +
>> +&usb_1_hsphy {
>> +	bootph-all;
>> +};
>> +
>> +&usb_1_dwc3 {
>> +	bootph-all;
>> +};
>> +
>> +&rpmhcc {
>> +	bootph-all;
>> +};
> Can we have these DT overrides posted to upstream kernel board DTS?
fwiw it probably belongs in SoC dts, since there's nothing board specific
about it, but yes it should eventually go upstream, I just wanted to have
a self-contained patchset that doesn't need to wait for that + next sync
> -Sumit


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308B9C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB7188141;
	Thu, 28 Mar 2024 12:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m/dl/EBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63F688144; Thu, 28 Mar 2024 12:18:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D3787DE6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SBIYGY039217;
 Thu, 28 Mar 2024 06:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711624714;
 bh=qVHB9YZ+glrJaS+qXbrqNs/Fi4FuSBR/vHvCgFyX8t8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=m/dl/EBbI1VZmkG4qIhtSEV7YyHNVVIO33WCgbm6uNo3FiIBsUNiLVceCZXmXqHGo
 Y/mWnjK9+qMSZHomB984gddO8dQRYkFnlmzTEy+/TWMPBmn5FTCIntlWA71jRpZXnh
 39vr+tIFgG3a8+3NEXt/P/FFELbWXrnOWBF4V52c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SBIYu4078037
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Mar 2024 06:18:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 06:18:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 06:18:33 -0500
Received: from [10.249.139.5] ([10.249.139.5])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SBISXv086035;
 Thu, 28 Mar 2024 06:18:29 -0500
Message-ID: <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
Date: Thu, 28 Mar 2024 16:48:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
To: Michael Walle <mwalle@kernel.org>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Michael

On 27-Mar-24 8:03 PM, Michael Walle wrote:
> Hi,
> 
> On Wed Mar 27, 2024 at 8:01 AM CET, Neha Malcom Francis wrote:
>> On 26/03/24 19:18, Michael Walle wrote:
>>> On Fri Mar 22, 2024 at 2:10 PM CET, Neha Malcom Francis wrote:
>>>> Clean up templatized boot binaries for all K3 boards. This includes
>>>> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
>>>> UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
>>>> code.
>>>>
>>>> All k3-<soc>-binman.dtsi will contain only templates. Only required boot
>>>> binaries can be built from the templates in the boards' respective
>>>> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
>>>> clear distinction between the SoC common stuff vs. what is additionally
>>>> needed to boot up a specific board.
>>>
>>> I appreciate the cleanup. But as far as I can see, a board might
>>> only have one device tree. How would that work if the uboot proper
>>> must support multiple device trees?
>>>
>>
>>   From the discussions that took place in the mailing list [1] the consensus
>> seems to be to not focus on multiple devicetree support as it leads to confusion
>> for downstream users.
> 
> What are users in this regard? I don't think you'd confuse
> developers.
> 
> Anyway, I'm planning on upstreaming a TI board which will have
> different memory configurations and different variants of the board.

I am assuming you are reusing an existing TI SoC?

> And on top of that, it will just be a base board and there will
> likely be some carrier device trees (overlay? I'm not sure yet).
> 
> As far as I can tell, you've put the memory configuration into the
> device tree, so I'll probably need to switch between them somehow.

The "k3-<soc>-ddr.dtsi" file will be present in your k3-<board>r5.dts 
which makes sense, the memory configuration depends on the board.

> Also, regarding the board variants, I'll probably need to choose
> between multiple device trees. That is invisible to the user,
> because u-boot will choose the correct DTB according a board
> strapping, which btw. works really fine, see for example
> (boards/kontron/sl28/spl.c:board_fit_config_name_match).

Again, this is assuming that there is some HW blown register available 
for the board to use (or in our earlier K3 case, the EEPROM) but that is 
not necessarily true every time.

> 
> I don't think it makes much sense to hardcode your generic
> *-binman.dtsi to just one FIT configuration. I'd rather see a split
> between generic things which are shared across all boards and board
> specifics, like the FIT configuration. I mean I could just copy all

Correct me if I'm wrong, but my understanding is that you would want to 
add more FDT blobs in the *-binman.dtsi correct? That is still possible, 
adding another "fdt-1" and "conf-1" in the

Something like this in your <board>-u-boot.dtsi,

tispl {
	insert-template = <&ti_spl>;
	fit {
		images {
			fdt-1 {
				...
			};
		};
		configurations {
			conf-1 {
				...
			};
		};
	};
};

provided you have the support to handle this multi-dtb FIT. But as far 
as reusing the k3-binman.dtsi and k3-<soc>-binman.dtsi goes; you should 
be able to do it.

> the binman and tiboot3.bin and tispl.bin magic and put it into my
> own "-u-boot.dtsi". But I'm not sure that will make things any
> better.
> 
> -michael

-- 
Thanking You
Neha Malcom Francis

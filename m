Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B0AC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 07:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA8687D31;
	Wed, 27 Mar 2024 08:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KfvEHOkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3F388103; Wed, 27 Mar 2024 08:02:08 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1018E870D2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 08:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R71mCP118493;
 Wed, 27 Mar 2024 02:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711522908;
 bh=SEwLXw1tsX6mDeFwwRTiP1q0rpiN/gapBokOei7ZYfk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KfvEHOkvnuxEjfUdwwU2XBxopCu8Z/d7BPx5twH68joEuLF6LoQNSnlcTG/vNRPet
 7dfPjdQRbzh64lfM4EsFidv9toUJRQ2padiIsynVXgQgbUyHTWVOSErAtQwtyOk6ud
 AciFd60MvblM3A7uQOFj/nn9PNLzbX/ETZVElZFk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R71mwV007958
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Mar 2024 02:01:48 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 02:01:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 02:01:48 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R71hG2044813;
 Wed, 27 Mar 2024 02:01:44 -0500
Message-ID: <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
Date: Wed, 27 Mar 2024 12:31:42 +0530
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
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
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

On 26/03/24 19:18, Michael Walle wrote:
> Hi,
> 
> On Fri Mar 22, 2024 at 2:10 PM CET, Neha Malcom Francis wrote:
>> Clean up templatized boot binaries for all K3 boards. This includes
>> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
>> UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
>> code.
>>
>> All k3-<soc>-binman.dtsi will contain only templates. Only required boot
>> binaries can be built from the templates in the boards' respective
>> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
>> clear distinction between the SoC common stuff vs. what is additionally
>> needed to boot up a specific board.
> 
> I appreciate the cleanup. But as far as I can see, a board might
> only have one device tree. How would that work if the uboot proper
> must support multiple device trees?
> 

 From the discussions that took place in the mailing list [1] the consensus 
seems to be to not focus on multiple devicetree support as it leads to confusion 
for downstream users.

> Thanks,
> -michael

[1] https://lore.kernel.org/all/20230908183124.27zctk6ishfd7ics@canopener/

-- 
Thanking You
Neha Malcom Francis

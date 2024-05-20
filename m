Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0AFC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 12:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B0F88247;
	Mon, 20 May 2024 14:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kq7WREwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133C8886B0; Mon, 20 May 2024 14:13:47 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A85B88229
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 14:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 99E63CE0B31;
 Mon, 20 May 2024 12:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8070C2BD10;
 Mon, 20 May 2024 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716207220;
 bh=/1m1xT6/L4RnavI18KreWkLoFQCUn4HTd+UWob5CAWs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kq7WREwWizcy7N+3QYMqZjhd0FSLcl4KkowDyTJDyG0/fADV7TUBNyzNqIzFtbPNy
 H0H/H3fq1CQYnjqSJkADeeUTDs493AmZLVwO0itIElR1eDLKD3AIhILcQF4x71mXif
 KRuhCTpc6YLhfy888hovI8qfd59p0V++c3qwwv58wN4U+Al2qX4n+XVDEEnGih6faW
 JoDR3y2KKyfMCZX7pS4C1jmG2PgeUTRypeHsLbZQnC8UBXgEN56v5JQlA4VIkvOeew
 uuK7UqIiMPkP6rJaNQGRAHjZ7Ytg/QcxLYJ1r/LgPkj7iYcOdR6fNUtkwkbtRrSUxI
 ao8u8ECuI+82g==
Message-ID: <864a0203-409a-4db9-8248-14d04a6e71fc@kernel.org>
Date: Mon, 20 May 2024 15:13:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arch: arm: dts: k3-am62-sk-u-boot: Add missing
 "bootph-all" property to phy_gmii_sel node
To: Chintan Vankar <c-vankar@ti.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Sean Anderson <seanga2@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240425120822.2048012-1-c-vankar@ti.com>
 <20240425120822.2048012-11-c-vankar@ti.com>
 <5ac873d5-e485-47d3-b5de-f537c1fb88b1@kernel.org>
 <e3785fad-fb0d-4cf8-8787-0a91e6b52332@ti.com>
 <e9911fd1-6a69-448d-9347-7d188ec46c74@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <e9911fd1-6a69-448d-9347-7d188ec46c74@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 20/05/2024 09:04, Chintan Vankar wrote:
> 
> 
> On 25/04/24 18:06, Chintan Vankar wrote:
>>
>>
>> On 25/04/24 18:01, Roger Quadros wrote:
>>>
>>>
>>> On 25/04/2024 15:08, Chintan Vankar wrote:
>>>> Add "bootph-all" property to CPSW MAC's PHY node phy_gmii_sel.
>>>>
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>> ---
>>>>
>>>> Changes from v1 to v2:
>>>> - This patch is newly added in this series to enable CPSW MAC's PHY
>>>>    node "phy_gmii_sel". As per discussion at here:
>>>>    https://lore.kernel.org/r/20240112130127.rvvrhz7p4vmlyalh@smother/
>>>>    changes made by this patch can be dropped in the future when the
>>>>    DT-Sync is performed with am62-main.dtsi containing this change in
>>>>    the Linux DT which will match U-Boot's DT.
>>>
>>> I don't think bootph-all exists in am62-main.dtsi. It should come from
>>> board.dts
>>>
>>
>> Yes, I am having the same discussion at here:
>> https://lore.kernel.org/all/c13ac165-7cbd-4e53-914e-8c6bc28250e3@ti.com/
>>
> 
> Since I have posted patch which adds bootph-all property to
> "k3-am62x-sk-common.dtsi" at here:
> https://lore.kernel.org/r/20240430085048.3143665-1-c-vankar@ti.com/
> and it has no open comments and this series
> also does not have any open comments, so can it be merged ?

Since bootph-all is being added to k3-am62x-sk-common.dtsi don't you have to drop patch 10
from this series?

> 
>>>>
>>>>   arch/arm/dts/k3-am625-sk-u-boot.dtsi | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>>> index fa778b0ff4..e9a1afde95 100644
>>>> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>>> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>>> @@ -46,3 +46,7 @@
>>>>   &cpsw_port2 {
>>>>       status = "disabled";
>>>>   };
>>>> +
>>>> +&phy_gmii_sel {
>>>> +    bootph-all;
>>>> +};
>>>

-- 
cheers,
-roger

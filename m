Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5211C282D0
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 18:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A82780AE1;
	Fri, 28 Feb 2025 19:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HtPdKtGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C9480FF2; Fri, 28 Feb 2025 19:15:29 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B87809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 19:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51SIF8db2200103
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 12:15:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740766509;
 bh=uuq5fTf8DFFHViN1sfT6awgAxlmbSrlOI0H4LH+hbCE=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=HtPdKtGlpm1iXuKXP5aAxnbTE2TcrQEfUgRqYFNhC6UOexhnPdMNy3/2xgzxZXQIg
 IHWLWom8H2u3qWKyts6D7jqh1soLPiTC2nO1o3f7KUPeR7z2dufeBjcYFncL/F4wMv
 qGuUqnlDwFVS799r7fgqOxp5Hk7xs590oFVXzLqc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51SIF8rk051823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Feb 2025 12:15:08 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 12:15:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 12:15:08 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51SIF8Kt122361;
 Fri, 28 Feb 2025 12:15:08 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, Raymond Mao <raymond.mao@linaro.org>, "Caleb
 Connolly" <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, "Aashvij Shenai" <a-shenai@ti.com>, Roger
 Quadros <rogerq@kernel.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Tom Rini
 <trini@konsulko.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v4 1/3] xilinx: dfu: Fill directly update_info.dfu_string
In-Reply-To: <84a24111-d03b-447a-b451-e95fe3e7736e@gmx.de>
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-2-j-humphreys@ti.com>
 <26b269b3-9df5-4ae4-876d-ab41aec6baa4@gmx.de>
 <1a85dacb-9e84-43f3-a223-5a5aa7e68179@amd.com>
 <84a24111-d03b-447a-b451-e95fe3e7736e@gmx.de>
Date: Fri, 28 Feb 2025 12:15:08 -0600
Message-ID: <86frjyndg3.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> On 28.02.25 16:41, Michal Simek wrote:
>>
>>
>> On 2/28/25 15:33, Heinrich Schuchardt wrote:
>>> On 26.02.25 23:35, Jonathan Humphreys wrote:
>>>> From: Michal Simek <michal.simek@amd.com>
>>>>
>>>> Directly fill update_info.dfu_string to prepare platforms to switch
>>>> from using dfu_alt_info variable to dfu_string which contains
>>>> description
>>>> for capsule update when switch is done.
>>>
>>> Other platforms only set the environment variable.
>>
>> Not really.
>>
>> git grep \.dfu_string board/
>>
>> beagle, imx, rpi, ti and others are also doing it.
>
> But why do we have platforms that don't?
>

I'm not aware of the history of the Xilinx platforms and why they didn't,
but Michal has fixed this.  I'm not aware of any other platforms not
setting .dfu_string.

Jon

>>
>>>
>>> Do we have a problem that needs to be solved for all problems?
>>> Or is anything special about the Xilinx platform?
>>>
>>> If we have a general problem, solving it for Xilinx only would not be
>>> the right approach.
>>
>> This is just preparation patch for switch in 3/3 because then Jon would
>> have to do this change in his patch.
>> But the biggest reason is when 2/3 is applied, capsule update will stop
>> to work on our platform and I wanted to make sure that we can avoid it.
>>
>> Thanks,
>> Michal
>>
>>

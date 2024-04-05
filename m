Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40C9CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 05:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92EA8820E;
	Fri,  5 Apr 2024 07:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PLMtaaeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B713883C4; Fri,  5 Apr 2024 07:47:20 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F945881AD
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 07:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4355lAVj000778;
 Fri, 5 Apr 2024 00:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712296030;
 bh=zQUpJwk4yYgvPgDYNofc6jTWznox0ZteYkPcINVqCxk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PLMtaaeJyJrQPEvKrpur5Yo0EVBn1YU2LtAgLoQXDrKbNtq+gbz4NBf/k0PnQN9GU
 Bwh+JnD7sADu7p8pIvrAzxklQBOUFfn27gQSGkFZi4y7GCVnD2Z6m86Imoh3CQXfIS
 xhkCcPBBSyYeo6eAxLrplIDYwufoLobGZHof5rNU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4355lAKq068682
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Apr 2024 00:47:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 00:47:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 00:47:09 -0500
Received: from [172.24.227.252]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4355l5he004461;
 Fri, 5 Apr 2024 00:47:06 -0500
Message-ID: <60c854a1-11fb-42ec-aaba-364910b4f5e2@ti.com>
Date: Fri, 5 Apr 2024 11:17:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/15] DO-NOT-MERGE: dts: upstream: src: Necessary
 pulls from upstream dts
To: Sumit Garg <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
 <afd@ti.com>, <bb@ti.com>, <rogerq@kernel.org>, <r-gunasekaran@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-2-j-choudhary@ti.com>
 <CAFA6WYOjmVDigxT_Nw_vpEyOMmU=FK0jvCM0bVQ=fzVAaf205g@mail.gmail.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <CAFA6WYOjmVDigxT_Nw_vpEyOMmU=FK0jvCM0bVQ=fzVAaf205g@mail.gmail.com>
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

Hello Sumit,

On 05/04/24 10:27, Sumit Garg wrote:
> Hi Jayesh,
> 
> On Thu, 4 Apr 2024 at 14:30, Jayesh Choudhary <j-choudhary@ti.com> wrote:
>>
>> j722s dts support that needs to be pulled from devicetree-rebasing
>> tree. The whole series depends on this support.
>>
> 
> Which devicetree-rebasing tag does this patch depend upon? v6.8-dts
> has already made its way to U-Boot mainline [1].
> 
> [1] https://source.denx.de/u-boot/u-boot/-/commit/bc39e06778168a34bb4e0a34fbee4edbde4414d8
> 

These patches are on top of the next branch (same commit)
The required patches[0][2][3] are in tag v6.9-rc1-dts.

[0]: 
<https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=1339c374a4c10f184d2bb4c6dadd3155f9260599>
[2]: 
<https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=4dd9e11aa40f6d7bb2bd4993a8ddf17c935c9686>
[3]: 
<https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=ec136bb18fcc85d32787530bc065bd97ee3bba60>

-Jayesh


> -Sumit
> 
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   dts/upstream/Bindings/arm/ti/k3.yaml       |   6 +
>>   dts/upstream/src/arm64/ti/k3-j722s-evm.dts | 383 +++++++++++++++++++++
>>   dts/upstream/src/arm64/ti/k3-j722s.dtsi    |  89 +++++
>>   dts/upstream/src/arm64/ti/k3-pinctrl.h     |   3 +
>>   4 files changed, 481 insertions(+)
>>   create mode 100644 dts/upstream/src/arm64/ti/k3-j722s-evm.dts
>>   create mode 100644 dts/upstream/src/arm64/ti/k3-j722s.dtsi
>>
>> diff --git a/dts/upstream/Bindings/arm/ti/k3.yaml b/dts/upstream/Bindings/arm/ti/k3.yaml
>> index c6506bccfe..d526723484 100644
>> --- a/dts/upstream/Bindings/arm/ti/k3.yaml
>> +++ b/dts/upstream/Bindings/arm/ti/k3.yaml
>> @@ -123,6 +123,12 @@ properties:
>>                 - ti,j721s2-evm
>>             - const: ti,j721s2
>>
>> +      - description: K3 J722S SoC and Boards
>> +        items:
>> +          - enum:
>> +              - ti,j722s-evm
>> +          - const: ti,j722s
>> +
>>         - description: K3 J784s4 SoC
>>           items:
>>             - enum:

[...]

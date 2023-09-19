Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56179CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 17:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB1B86AC6;
	Tue, 19 Sep 2023 19:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yAk7aQqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A2386A38; Tue, 19 Sep 2023 19:38:14 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B469786A26
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JHc1TE097234;
 Tue, 19 Sep 2023 12:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695145081;
 bh=Xuswn+hcZZC3dLeYGXsjudTrwXbRu3s4teErw5urrBE=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=yAk7aQqhC2D1ySjDZOVVlEW8+ZKmV+sYi0UFrZv18PZbgE426ocySrUh4qgi3Q+Jx
 goPE6dFPbb5a/1PGZsQM6YlGRmj6nejJUrietaXvBQQRf7zCO+smTaIOFjhrVJfmrz
 iABNwfmUuuyvZ3bEGGHBfYFvbJvrSSrocq8mpB4A=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JHc1sK036995
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 12:38:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 12:38:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 12:38:00 -0500
Received: from [10.250.64.197] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JHbrJU067272;
 Tue, 19 Sep 2023 12:37:54 -0500
Message-ID: <ab9a9242-9281-11ee-bf44-002f27e6ed5a@ti.com>
Date: Tue, 19 Sep 2023 23:07:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/16] arm: dts: Introduce j784s4 dts from linux kernel
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-2-a-nandan@ti.com>
 <6b1b5722-f609-21cd-cd24-c36a7bc9c9b6@kernel.org>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <6b1b5722-f609-21cd-cd24-c36a7bc9c9b6@kernel.org>
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

Hi,

On 09/09/23 16:20, Roger Quadros wrote:
>
> On 08/09/2023 14:05, Apurva Nandan wrote:
>> Introduce the basic j784s4 SoC dts from the next-20230905 tag of the
>> linux kernel.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm/dts/k3-j784s4-evm.dts         |  864 +++++++++++++
>>   arch/arm/dts/k3-j784s4-main.dtsi       | 1571 ++++++++++++++++++++++++
>>   arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi |  703 +++++++++++
>>   arch/arm/dts/k3-j784s4-thermal.dtsi    |  101 ++
>>   arch/arm/dts/k3-j784s4.dtsi            |  294 +++++
>>   5 files changed, 3533 insertions(+)
>>   create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
>>   create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4.dtsi
> Shouldn't this patch come last in the series?
> What about DT-binding documentation for J784S4 SoC and its modules?
These dts files are directly imported/copied from Linux dts source,
so the binding are already taken care of in Linux.

As it is a direct import from linux, and u-boot dts depend on these,
I had put them in start. But if you want, I can put them just after
patch #8

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.


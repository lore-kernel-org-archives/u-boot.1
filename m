Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA26C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF0887B77;
	Tue, 13 Aug 2024 06:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tc2VzPdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6165886E5; Tue, 13 Aug 2024 06:33:03 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FAB87B1A
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 06:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D4Wl67076988;
 Mon, 12 Aug 2024 23:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723523567;
 bh=v+S4YQFqGxXTIejIf9K3Pa4PatHU14SxhLSe9TSRQLk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tc2VzPdJ+v5qpbj3bSmL1I+pEshOEz8ftdcbtLGkYuGY26FJEiDTWmaLpe8p7Y/+z
 7FQlxoxkd2PjfQUMwAZ5IOxom/0bS0+KMLxedRXKZrYLHngAbvKf5/+yaf5jEI/i+C
 0iQl0Cimz/DvJt8rWp1nk0XsPYqskn0cgG29BDhg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D4Wl42081530
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Aug 2024 23:32:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 23:32:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 23:32:47 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D4We3f101804;
 Mon, 12 Aug 2024 23:32:40 -0500
Message-ID: <60b5e59a-2658-4db1-ae4d-1b503c6153b6@ti.com>
Date: Tue, 13 Aug 2024 10:02:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] dts: upstream: src: arm64: ti:
 k3-am62x-sk-common: Sync DT with Linux v6.11-rc3
To: Sumit Garg <sumit.garg@linaro.org>
CC: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "MD Danish Anwar" <danishanwar@ti.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay
 Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20240812113621.3840652-1-c-vankar@ti.com>
 <20240812114945.3844224-1-c-vankar@ti.com>
 <CAFA6WYO5JeFsUyDWkF+Xw018cGehZiD7ZdVvXAc-VERZWSFTUg@mail.gmail.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <CAFA6WYO5JeFsUyDWkF+Xw018cGehZiD7ZdVvXAc-VERZWSFTUg@mail.gmail.com>
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



On 12/08/24 17:50, Sumit Garg wrote:
> Hi Chintan,
> 
> On Mon, 12 Aug 2024 at 17:19, Chintan Vankar <c-vankar@ti.com> wrote:
>>
>> Sync Device tree nodes with Linux v6.11-rc3.
>>
> 
> You don't need to manually sync DT files but...
> 
>> [ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]
>>
> 
> ...rather cherry pick required commits from upstream as the one you
> have mentioned. Refer DT docs [1] for instructions.
> 
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> 

Thank you Sumit for pointing this out. I will cherry pick the required
commit from devicetree-rebasing repo and send it in a next version.

> -Sumit
> 
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v3:
>> - This link is for the patch which was equivalent to this patch, from
>>    this version the node is moved to DT file equivalent to Linux as a
>>    part of DT sync.
>>    https://lore.kernel.org/r/20240705045030.1141934-11-c-vankar@ti.com/
>>
>> Changes from v3 to v4:
>> - Updated this patch by syncing "k3-am62x-sk-common.dtsi" file
>>    with Linux v6.11-rc3 compared to previous version.
>>
>>   .../src/arm64/ti/k3-am62x-sk-common.dtsi      | 32 ++++++++++---------
>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
>> index 3c45782ab2..44ff67b6bf 100644
>> --- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
>> +++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
>> @@ -48,6 +48,14 @@
>>                          pmsg-size = <0x8000>;
>>                  };
>>
>> +               /* global cma region */
>> +               linux,cma {
>> +                       compatible = "shared-dma-pool";
>> +                       reusable;
>> +                       size = <0x00 0x8000000>;
>> +                       linux,cma-default;
>> +               };
>> +
>>                  secure_tfa_ddr: tfa@9e780000 {
>>                          reg = <0x00 0x9e780000 0x00 0x80000>;
>>                          alignment = <0x1000>;
>> @@ -128,6 +136,10 @@
>>          };
>>   };
>>
>> +&phy_gmii_sel {
>> +       bootph-all;
>> +};
>> +
>>   &main_pmx0 {
>>          /* First pad number is ALW package and second is AMC package */
>>          main_uart0_pins_default: main-uart0-default-pins {
>> @@ -156,6 +168,7 @@
>>          };
>>
>>          main_i2c1_pins_default: main-i2c1-default-pins {
>> +               bootph-all;
>>                  pinctrl-single,pins = <
>>                          AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17/A17) I2C1_SCL */
>>                          AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17/A16) I2C1_SDA */
>> @@ -335,15 +348,9 @@
>>                          self-powered;
>>                          data-role = "dual";
>>                          power-role = "sink";
>> -                       ports {
>> -                               #address-cells = <1>;
>> -                               #size-cells = <0>;
>> -
>> -                               port@0 {
>> -                                       reg = <0>;
>> -                                       usb_con_hs: endpoint {
>> -                                               remote-endpoint = <&usb0_hs_ep>;
>> -                                       };
>> +                       port {
>> +                               usb_con_hs: endpoint {
>> +                                       remote-endpoint = <&usb0_hs_ep>;
>>                                  };
>>                          };
>>                  };
>> @@ -470,12 +477,9 @@
>>
>>   &usb0 {
>>          bootph-all;
>> -       #address-cells = <1>;
>> -       #size-cells = <0>;
>>          usb-role-switch;
>>
>> -       port@0 {
>> -               reg = <0>;
>> +       port {
>>                  usb0_hs_ep: endpoint {
>>                      remote-endpoint = <&usb_con_hs>;
>>                 };
>> @@ -504,8 +508,6 @@
>>                 0 0 0 0
>>                 0 0 0 0
>>          >;
>> -       tx-num-evt = <32>;
>> -       rx-num-evt = <32>;
>>   };
>>
>>   &dss {
>> --
>> 2.34.1
>>

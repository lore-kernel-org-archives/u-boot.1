Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65730C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C424887BF;
	Wed, 12 Jun 2024 16:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fcQYK7Xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57812887FD; Wed, 12 Jun 2024 16:21:08 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D1B886E8
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718202066; x=1720794066;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/pc5WMpK8DI6iOJaWGlWHKokPSD7guyN7U30xR0fBI=;
 b=fcQYK7Xh15PWlMk91puMk03qdzv4cQXU0m0AdE8W8NQJ8hsoy6im5GqQaEKFROF9
 Ju9sUSMrwSDx8NbrsIfyizyE+TDVdnxQjJhRHhZmbofWD3irAO005STRIP4E0zFi
 3kJA3/Bp4uwcQwmpTnqE24cwWEEiZLVaqmrJSp0v6Fc=;
X-AuditID: ac14000a-03251700000021bc-80-6669aed1fd81
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 25.AB.08636.1DEA9666;
 Wed, 12 Jun 2024 16:21:05 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jun
 2024 16:21:05 +0200
Message-ID: <5a795322-2e3a-4628-ad90-14ca5832632f@phytec.de>
Date: Wed, 12 Jun 2024 16:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-boot] [PATCH 01/13] arch: arm: dts: k3-am625-phyboard-lyra:
 Add fixed partitions
To: Teresa Remmet <T.Remmet@phytec.de>, "u-boot@lists.phytec.de"
 <u-boot@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
 <20240610133352.2473414-2-w.egorov@phytec.de>
 <1d1aa06eafb110b96fa5a46ccc7ab5d226946f3d.camel@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <1d1aa06eafb110b96fa5a46ccc7ab5d226946f3d.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWyRpKBR/fSusw0gx88FlMnbWa3eLu3k93i
 Xd9+Jovud+oOLB6vDqxi9zh7ZwejR393C2sAcxSXTUpqTmZZapG+XQJXRuei3WwFV8Ur9u0J
 bGCcJtrFyMkhIWAi0dQ8j72LkYtDSGAJk8S31sdQzl1GiQmrp7CDVPEK2EjMufCAEcRmEVCV
 uDyhjQkiLihxcuYTFhBbVEBe4v6tGUD1HBzCAkkSx7bwgMwRETjMKHFm+h2wemYBXYmtM38x
 QixYxijxf/8tFoiEuMStJ/PBitgE1CXubPjGCjKIU8BdYvpnW4gSC4nFbw6yQ9jyEs1bZzOD
 2EJA9otLy1kgvpGXmHbuNTOEHSqx9ct2pgmMwrOQnDoLybZZSMbOQjJ2ASPLKkah3Mzk7NSi
 zGy9gozKktRkvZTUTYygWBBh4NrB2DfH4xAjEwfjIUYJDmYlEd4zMelpQrwpiZVVqUX58UWl
 OanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhjT7uxbYPQk/MURpcJ1G54aeyU7
 bW80r5SawcB99dh7rWWiHBuiZ1Q1isz0ldS7flpGMm3nQbH7R+//nqDSL+C8T1YnykLK7QpD
 mvwyVfvZ+rGPHoiea+aMcpuSe7TKRCUhlaVli6XHGSt2LgVVlsQvxiI/171rb13/xX/fOhfx
 KBvXxXVv85VYijMSDbWYi4oTAUj4gvJzAgAA
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



Am 11.06.24 um 10:08 schrieb Teresa Remmet:
> Hello Wadim,
> 
> Am Montag, dem 10.06.2024 um 15:33 +0200 schrieb Wadim Egorov:
> 
>> From: Nathan Morrisson <nmorrisson@phytec.com>
>>
>> Add a fixed partitions node to the AM62x device tree so that it can
>> be used to fixup the Linux device tree.
> 
> for which branch is this series?

This patch is for u-boot/next
Somehow it landed also on our internal list, sorry for that.


> 
> Regards,
> Teresa
> 
>>
>> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    | 26
>> +++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>> b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>> index 94162282068..7c76acc0d59 100644
>> --- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>> @@ -127,6 +127,32 @@
>>   
>>          flash@0 {
>>                  bootph-all;
>> +               partitions {
>> +                       compatible = "fixed-partitions";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +
>> +                       partition@0 {
>> +                               label = "ospi.tiboot3";
>> +                               reg = <0x00000 0x80000>;
>> +                       };
>> +                       partition@80000 {
>> +                               label = "ospi.tispl";
>> +                               reg = <0x080000 0x200000>;
>> +                       };
>> +                       partition@280000 {
>> +                               label = "ospi.u-boot";
>> +                               reg = <0x280000 0x400000>;
>> +                       };
>> +                       partition@680000 {
>> +                               label = "ospi.env";
>> +                               reg = <0x680000 0x40000>;
>> +                       };
>> +                       partition@6c0000 {
>> +                               label = "ospi.env.backup";
>> +                               reg = <0x6c0000 0x40000>;
>> +                       };
>> +               };
>>          };
>>   };
>>   
> 

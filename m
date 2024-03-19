Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C093AC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 08:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F14B87CFC;
	Tue, 19 Mar 2024 09:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lHOGsVUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B8D8083F; Tue, 19 Mar 2024 09:39:46 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C46987CFC
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710837582; x=1713429582;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=39RcuCMAyqhSyaF8SfAqfg/2pMp5KeB0gsn6dgzWpc4=;
 b=lHOGsVUjKwcB5OT947sEPIMOxgvLx9LflGzabOO453Q9Y/Kxr2I6TDfVn9gyUDt8
 j4oR7Argg8WEAf2RyIr0mbjCH+4DR0bLDyB20UVQNpDZ0QYg8zt6EvmQHmdwbgGa
 2VYo4pCP4Q1bLbIc4qCI9Qkk8YjzJC1kibsTDnHnfEI=;
X-AuditID: ac14000a-fadff7000000290d-b7-65f94f4dfd1e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2E.D4.10509.D4F49F56;
 Tue, 19 Mar 2024 09:39:41 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Mar
 2024 09:39:40 +0100
Message-ID: <7e5fd344-774e-4b45-8bad-5054d9b3a7b4@phytec.de>
Date: Tue, 19 Mar 2024 09:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: imx93-phyboard-segin: Add USB support.
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Shiji Yang
 <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, Mathieu
 Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser
 <primoz.fiser@norik.com>, Christoph Stoidner <c.stoidner@phytec.de>
CC: <u-boot@lists.denx.de>
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-3-othacehe@gnu.org>
 <ae1e53d1-cedc-4ef8-be42-b9d807640b55@denx.de>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <ae1e53d1-cedc-4ef8-be42-b9d807640b55@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWyRpKBR9fX/2eqwY715hbf1v1msXh41d9i
 xs1pbBZv2hoZLc7f3cJs8WPVF1aLE10PWS3aT/lYHP73jNni25ZtjBZTJ21mt3i7t5Pd4mzv
 V3aLtuOHGB34PJbs2s/sMbvhIovHvFknWDx2zrrL7tE2zczj1YFV7B5n7+xg9Pj+dQOrx8Z3
 O5g8Nr9+wRzAFcVlk5Kak1mWWqRvl8CVMfnWAuaC5VwVVxY2MDYwfuLoYuTkkBAwkViy6R4L
 iC0ksJhJ4uyRSgj7LqPEzg9qIDavgI3EjanXwGpYBFQllv25zggRF5Q4OfMJWFxUQF7i/q0Z
 7CC2sICHxNE/Z1hBbGYBcYlbT+YzdTFycYgIbGKRWHXpNRNEQkqiZdocVpCEkMAkRokzx66w
 gSTYBNQl7mz4BtbNKWAt0fn8D1SDhcTiNwfZIWx5ieats5khLpWXeHFpOQvEN/IS0869Zoaw
 QyW2ftnONIFReBaSY2chOWoWkrGzkIxdwMiyilEoNzM5O7UoM1uvIKOyJDVZLyV1EyMoakUY
 uHYw9s3xOMTIxMF4iFGCg1lJhJed+2eqEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLp
 iSWp2ampBalFMFkmDk6pBkaLjQ4/ltdNEdxevmrX09/dC146JGzi0Lgyz0bm/N6by37LHW8/
 8zA229xIaPdCE/mHb90YzRVXeD15xPoj0+CKTFSJfemmpLqpQYdvMrKfmnFE2FhjhQAv29+X
 l6rEGGe+KT6WzXxXL72uwLZOY9HzoirLdL7zhq+qmH1WZ377InrfsqtkL5sSS3FGoqEWc1Fx
 IgA8kuF3yAIAAA==
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


Am 18.03.24 um 22:48 schrieb Marek Vasut:
> On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
>> Enable the `usb` command and some USB drivers.
>>
>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>> ---
>>   configs/imx93-phyboard-segin_defconfig | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/configs/imx93-phyboard-segin_defconfig 
>> b/configs/imx93-phyboard-segin_defconfig
>> index 24f9bd553aa..5acb987b817 100644
>> --- a/configs/imx93-phyboard-segin_defconfig
>> +++ b/configs/imx93-phyboard-segin_defconfig
>> @@ -23,6 +23,7 @@ CONFIG_SPL_STACK=0x20519dd0
>>   CONFIG_SPL=y
>>   CONFIG_ENV_OFFSET_REDUND=0x720000
>>   CONFIG_CMD_DEKBLOB=y
>> +CONFIG_CMD_USB=y
>>   CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>>   CONFIG_SYS_LOAD_ADDR=0x80400000
>>   CONFIG_SYS_MEMTEST_START=0x80000000
>> @@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
>>   CONFIG_SYSRESET_WATCHDOG=y
>>   CONFIG_DM_THERMAL=y
>>   CONFIG_IMX_TMU=y
>> +CONFIG_USB=y
>> +CONFIG_USB_EHCI_HCD=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
>> +CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
>> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
>
> Shouldn't this by Phytec or similar USB IDs ?
AFAIK, PHYTEC does not have its own IDs registered yet. So the freescale 
IDs should be fine.

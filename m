Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D3C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 07:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED793880F3;
	Wed, 20 Mar 2024 08:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DA0QGgQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B11880BF; Wed, 20 Mar 2024 08:24:10 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8A5880F8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 08:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710919446; x=1713511446;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzU6b0yA53f6ttUTVuGBa6FFCE9ZTNsZZqD8NUrRdZk=;
 b=DA0QGgQwEz6bkf+n/MB2TKNCfrbxFwq0UB2PUKxIJecvZbGSktBJXbkO8TIVhSLn
 CDBpy8SDjezOy3w8uyN5TVsXKUYB/n9Z8t7QiZ2a78CJ6/CtKWNaL/cVTAe3qbg6
 cMDV3RLuOtKcp8pJf3HAL7L+z607Fw4j6+F81Ry4c48=;
X-AuditID: ac14000a-fadff7000000290d-e3-65fa8f158216
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 85.79.10509.51F8AF56;
 Wed, 20 Mar 2024 08:24:05 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Mar
 2024 08:24:04 +0100
Message-ID: <e4cc7d4b-a6b0-428a-a9b3-52541d0dd70c@phytec.de>
Date: Wed, 20 Mar 2024 08:24:03 +0100
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
 <7e5fd344-774e-4b45-8bad-5054d9b3a7b4@phytec.de>
 <32150e9d-0816-4b73-9964-bb285f251de7@denx.de>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <32150e9d-0816-4b73-9964-bb285f251de7@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWyRpKBR1e0/1eqwbJzlhbf1v1msXh41d9i
 xs1pbBZv2hoZLc7f3cJs8WPVF1aLE10PWS3aT/lYHP73jNni25ZtjBZTJ21mt3i7t5Pd4mzv
 V3aLtuOHGB34PJbs2s/sMbvhIovHvFknWDx2zrrL7tE2zczj1YFV7B5n7+xg9Pj+dQOrx8Z3
 O5g8Nr9+wRzAFcVlk5Kak1mWWqRvl8CV8fX7DcaCDTwVz9c9ZGxgPM3VxcjJISFgIrG55ypj
 FyMXh5DAYiaJ5r1foZy7jBJ7++aygFTxCthITL6xhRnEZhFQlZh9vI8JIi4ocXLmE7AaUQF5
 ifu3ZrCD2MICHhJH/5xhBbGZBcQlbj2ZzwQyVERgE4vEqkuvmSASUhIt0+awQmz7xijx4vFv
 sA1sAuoSdzZ8A+vmFLCWmPH3GlSDhcTiNwfZIWx5ieats8HqhYDsF5eWs0D8Iy8x7dxrZgg7
 VGLrl+1MExiFZyE5dhaSo2YhGTsLydgFjCyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYIiV4SB
 awdj3xyPQ4xMHIyHGCU4mJVEeNm5f6YK8aYkVlalFuXHF5XmpBYfYpTmYFES513dEZwqJJCe
 WJKanZpakFoEk2Xi4JRqYNRTv3llj8N/nwd+KrJrE2wS+VK3uMw+Z9hYJp8v+fdoaPgDq4ca
 Sya9TpHr+uZrU3djecQVuylXZ81kMe9z3f05edsUv+b9G44lsvPcvF+U4coY8qGvVfeY3VPT
 TjW/zjwxgX8/c6JX9j+ymLCFO3fWRva1mzqPVWroHhVs+mCwhHOpdoL3MSWW4oxEQy3mouJE
 APwGasrKAgAA
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


Am 19.03.24 um 14:58 schrieb Marek Vasut:
> On 3/19/24 9:39 AM, Wadim Egorov wrote:
>>
>> Am 18.03.24 um 22:48 schrieb Marek Vasut:
>>> On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
>>>> Enable the `usb` command and some USB drivers.
>>>>
>>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>>> ---
>>>>   configs/imx93-phyboard-segin_defconfig | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/configs/imx93-phyboard-segin_defconfig 
>>>> b/configs/imx93-phyboard-segin_defconfig
>>>> index 24f9bd553aa..5acb987b817 100644
>>>> --- a/configs/imx93-phyboard-segin_defconfig
>>>> +++ b/configs/imx93-phyboard-segin_defconfig
>>>> @@ -23,6 +23,7 @@ CONFIG_SPL_STACK=0x20519dd0
>>>>   CONFIG_SPL=y
>>>>   CONFIG_ENV_OFFSET_REDUND=0x720000
>>>>   CONFIG_CMD_DEKBLOB=y
>>>> +CONFIG_CMD_USB=y
>>>>   CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>>>>   CONFIG_SYS_LOAD_ADDR=0x80400000
>>>>   CONFIG_SYS_MEMTEST_START=0x80000000
>>>> @@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
>>>>   CONFIG_SYSRESET_WATCHDOG=y
>>>>   CONFIG_DM_THERMAL=y
>>>>   CONFIG_IMX_TMU=y
>>>> +CONFIG_USB=y
>>>> +CONFIG_USB_EHCI_HCD=y
>>>> +CONFIG_USB_GADGET=y
>>>> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
>>>> +CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
>>>> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
>>>
>>> Shouldn't this by Phytec or similar USB IDs ?
>> AFAIK, PHYTEC does not have its own IDs registered yet. So the 
>> freescale IDs should be fine.
>
> Manufacturer can still be Phytec , can it not ?

Yes, we can use PHYTEC for manufacturer.


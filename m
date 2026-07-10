Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF483C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16ED484A0A;
	Fri, 10 Jul 2026 12:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ltmf/LTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119F784A48; Fri, 10 Jul 2026 12:33:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78118484A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBQlndEKU0jPAgapGpeYrhI/sdWckfZhHR4KADDykDf0R6vUjVRILRoeEEujaBQ+NZL0MVbumi5lbRy4O9V4lBXf2AeIKHoRqQiD7hS1Y3zU6iz1BUeNT2xedj++Gi7b2eqt+TAB25F+mATo+DcS/85vqQVgddX8AU65jD1h/Hy3kd2RIXWV0LUNLZjBdvXyupaMRtvdfeZwd8Wk4UEbR9W1R2YO25OURXwjYRhWilp6NQphN2CoKTci6n44wczxbippQ+eMXMBFtMEYJq2UvrS0n5rPrWe+/C/o7qLclo+I1Cp8RZSLtbgSGhHQhEXlF2ioxRKvCliS1Cold8WoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYOOD6CXp/sJjcAXHEZaVVjzSaOf1cBYDI26bY+E1mo=;
 b=W+fXUXKJtEdKIuE0UonouNCPSIkfz7wmcg673lMQr8Q2RralQUAid+Fc2PzZc99I8HXqW2S2cG3uWww+sOc1bRx84nzUovWpIuAADND64RlUsA/qvnIiVCJ4Z946EmnTp8irgY+8FJTeXsYSM/fbAAomtElyLpq9G3onzb4dAMOgFhyyXJgAftLkB6tLdZM10BrOz+6PcPvHjOa/uM+KiLmUZIsrLix4brjkjs/BtfydHWR0znMZEGeeyjBiBuGN4wZb9VFtfSZaxsb/fttDr5O+1WWMfGTAZVWTLBEtg0EWgBSDCP7405SFWVTla3dEPE0fNNYKbLzt9cXO0CBvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYOOD6CXp/sJjcAXHEZaVVjzSaOf1cBYDI26bY+E1mo=;
 b=ltmf/LTn3sg/MmHjU4O8JW3GBh5cF7WprJLTFlvLYbv8aJ9uaojP4BSQmYSyCX7c24NYvVM4vScd4kJD++62PEbgJ9GD8QNhE6oWQCU70ati0JAE6FkN/o+fGW4NUGzeEwFhb2mI1vaD6HI8SxDgbn/kBNaDuz/PEfeWfVP571c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB11072.eurprd04.prod.outlook.com (2603:10a6:800:259::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 10:33:25 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:33:25 +0000
Message-ID: <ff591aa7-49b3-4091-9be1-ea8b35287bb0@cherry.de>
Date: Fri, 10 Jul 2026 12:33:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: clean up README.rockchip
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
References: <e1a0fa32-5418-4f66-98ae-f0e85451dcd2@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e1a0fa32-5418-4f66-98ae-f0e85451dcd2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIUP296CA0151.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB11072:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5986f8-ae5a-49a9-57c2-08dede6eac80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|5023799004|56012099006|6133799003|22082099003|18002099003|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 3HiyzOduZXZJu4mBiruPjMwy6wvPz7kRYvgp49RBP9/2pIutsLlquYwVF8/ja1K+jPde/nKCdKVOiGRlKePiTm5EusWeiNTuN4+2M7YaUgW8yBx0FwCjrzOae2/xMeG43lRbBMFNu0UlIvvnO7FiM+0j4iHIW1A/0O1KBCQoC9M/AJqd9W0Ds8heDgGbqovIbK40ncOoU66SLSnAzhaKkaJ6lwPD4d2EcmwquGpAD/YDHcSF+3K5JfnRv3A3IT8ihPVXS93bCVeRX/jjbMd/suXik0kNSlQlme+umhwuZlYDJd0GV8QtHJYvKjDpEfzidj0JbFLGydavMIUDwnMIMvRGwRTPZemyFhBfigPX2YdC1SN71xGK55k/5ebY9QiVSKbDzQ0f8+7vLFF4/rh/LVggoB5bVuN4AoLB1/eBZnrwo8eAyyJrVKVhLQUNMpr0Mx3qhSjKaVJMd4t2jmo9cnwENLIvPBiXtNG3C3iLSQTS+LJCgF1Hu/T6Z2UGzCEXpXGOAJPbS17rA3aBfg2dKVlCeaKnQU/NvQMAiX/kjmZUUpmv3GekcbpxmKPx4eeeQ+hRJTCIXfpj9TKiX6RHv5BSAVWYsm6ktrrXe0iv8rMrRNHxvOpekj9+776GR2Ri
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003)(4133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1k5bXNxZzFMbG1mUXlvTHNiMEk3QS9rQm9BdE91dEZEbXFwS0xEWjk2MjJj?=
 =?utf-8?B?TW1BMXIzOTVGcysxWThBWEtndnE2R0hHY0MxU0ZESytqUlNYTDJQUmdWTHhm?=
 =?utf-8?B?cCtsVmhGKzFyWUNlQkIyRkVkeXJLajFWZGhpUjVRNXZyUVA3eUcxOFV3UmRD?=
 =?utf-8?B?NkVaeEM3Z2Raa2d3RUlWdDhCdHBVZHQvM045QTVreDVtWHI2OU8yZFV5dXlH?=
 =?utf-8?B?M2ZZOUR4SFpSSEd2ejNuc0QwVEMyVlRyODZib3YvQXpzYUI4b2R0UWV1WEJo?=
 =?utf-8?B?VWFYeWl3ZzdJTlVJL1lWd21LeFVqVndiUzRzNjkxd3dvb1pZSkZxaVVudUdm?=
 =?utf-8?B?TWdsYkJ4c01yTFZvd0VacGVQSW4wcThnSG01a3VQRFZGN09ienBuRzlqL3lK?=
 =?utf-8?B?aTUzQ25hUnFaN3NaN3VFWVltTG4ram5RZkM1VWxLa3EwcmZqa2dVSXQ1TDM5?=
 =?utf-8?B?RzJ4RmtpZ3QwdjJPQ1JNZ0h0Ylo5eGxzd3VsaEt0TlZlak8zVkZXaVpnSmhp?=
 =?utf-8?B?dHlDWE9CcFJaM1RPa1dRZWY5aHBJL2tSeEhPNm5UYTJpUFIrWDVSZXJYTzUx?=
 =?utf-8?B?TUNvSnR1cWUrR2drMFJHcXJ3VEltOFhRYlhBRnhoaC9KQk9tQjZZYzUyTlR1?=
 =?utf-8?B?V1NEcEpwN3B0REVGY2RZL1lEa2RBZENrUGtLdGZyOHY3USs5RGp3aEhxS2Qv?=
 =?utf-8?B?Vkkxa1JFSFBuM1BDMzh4NmM0aDI5YzVWbjVUU09jTXlSSnNiKzNOL3d3bmpR?=
 =?utf-8?B?c0gwR1RBUVBkY09GZHA1MzZrYUhNMS9qbUJqNTdpU2R5cnlQWEhrWkRxcFo0?=
 =?utf-8?B?dVd2ZXhhZHRnbFN2TG0wRDFXYnoxTlJUbmhyWUxDT3dxdDZSOXdOclh3VFg3?=
 =?utf-8?B?NGQ2ZHBWYWZsQzhqZStOQWRaK0doNy9qNC9BaVRSMythREovZUhpaDdDc1px?=
 =?utf-8?B?MU9hUDhqNzBGVHJJWmwxaHZlZi9KUEhaSWRVUHR3YmVldWR0c2VrUllDSEpn?=
 =?utf-8?B?OHRzcTRtWFNFNXFWYlJqOXhyT296dnRUQ3FnWmZ5Y2Jud3k4SXFudExRRGxp?=
 =?utf-8?B?ck5leHZSRmVXM0tIQjM3Vk4xNlI3SkFRNC9nZkNpRHpiU3JyYzVTS1dOMmdW?=
 =?utf-8?B?eUJTMnl4QXJEVlRLVnRObi9hUHRBUm9JTVdwUTVlamlqSGF2UVdoQ2FZcVRo?=
 =?utf-8?B?U0xpUVUyb3VSN0JBQ0tYSURyYmtpWlFENWYySHBUMUN1N3MyUGV5SVIvSGpq?=
 =?utf-8?B?b2ZTQ1BVN3diMzJTb21mQTdyZFFJbVNzNWdxOHk5d05aTUF0a2Y5ZkRHNytn?=
 =?utf-8?B?MytIOVFLQ0ZNMkh5azFaN3I4ZGQxS2dWZnJuSXR0NWRCUTVpMUtFVCtCeWdu?=
 =?utf-8?B?WU9lOG1kMGp6MU01azZRTm85eDhCOTdXZmQrR2VJakg0ckwrdWN2LzA5blNK?=
 =?utf-8?B?VXduUGVwNzgwdVBidGQ0alNCdnJzVUxTanVGczNxdXZSTEgrUS9oTVlzRXR5?=
 =?utf-8?B?WEpMcVhwYmh2ODQwaDBUYUorL0pnMTNLV0k1MlJ3Qyt0Uk5jYzdrcWo0OFYz?=
 =?utf-8?B?a3lFOGtvWWxaY0pUT25FQWU3MkFiSFIrZGZyWnFVTXNkZnltU0c2eXlwKy9i?=
 =?utf-8?B?VUtSa04rRDZyK2I3Q1VwV0pFcUE5L00rTllqM3g0Q1R3Uk14dlJKdFdETUti?=
 =?utf-8?B?NkJta08yVUlrcnVXYk9wSUxIU3BtMTZBSFhVcUYrL0ZjV0k3Rjd5MHB6aVpw?=
 =?utf-8?B?d20vN2hmYWxIUHc1aVZseVJlVjFNQm0wU09VdlpSWDF2R3hjQWdrVzFJd2lm?=
 =?utf-8?B?QXVaTDg0Q01sUzhMU0V0TWltWjFIMURBWlpXa0xwNDNrVnN2bXE1b0wvT0Zk?=
 =?utf-8?B?OE1iNXVYUXJEZzR5NnZwcEJubXE4czdHaDJGRWQ2RmswTk9NbGIvbG9heWZ5?=
 =?utf-8?B?L2xQTHo3OUxGcWJwN0lDVFlab3Nndk8vKzJCUFR3aEFyeFdzL3Zaemg1bWI5?=
 =?utf-8?B?RmF6R2lHMW55aTBlVzJqRTd3QTZPbHovdUZVK2t3YXpVRHdCNGE3VkdBQU9m?=
 =?utf-8?B?dkNyeFNJR2l4b2QvRjBHY2FwSUFZWlBDZXc5ZW5pNnJwZit1TWhnMXA1SG9F?=
 =?utf-8?B?aVZ0ZW9SRkdvNjBmQzQweExmcHV5WUY1UHZCN2o3aTljUExUS1FSVVNaclBB?=
 =?utf-8?B?SmVObk5PbWgvamZsQ1JYbEphQ1BIYk9tYWR3amM5Yld2YjNQZjdTM3JQeTNJ?=
 =?utf-8?B?UHVneG1vNktRMkRNdzduTWZhNExZTjM0cm81QTV6Qk9vNmNtQzZWOWQ4d3NB?=
 =?utf-8?B?NjlQR1JUb1d4K09mV2VBM25Yb2N4Y1F6dVFKeDFTK1FJcjBmU3ZhZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5986f8-ae5a-49a9-57c2-08dede6eac80
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:33:25.6596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /laYgrvUHsgRoc8htLjoaPESqNap7pfNCZID9BCxFkD/PCVCHped5ve7yq2gMMTjS3AFbQYkmI2p2R6B7IaT9zMuOaRh2C6VZCny1gOAkeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11072
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

Hi Johan,

+Cc Jonas, maybe he has some additional feedback to provide.

On 6/5/26 7:45 PM, Johan Jonker wrote:
> Clean up README.rockchip for info that's already in
> rockchip.rst or no longer applicable for the subjects:
> 
> Prerequisites
> Building
> Writing
> Booting (except for rk3036/rk3188)
> Using fastboot on rk3288
> Booting from SPI
> Future work
> Development Notes
> Device tree and driver model
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   doc/README.rockchip | 563 --------------------------------------------
>   1 file changed, 563 deletions(-)
> 
> diff --git a/doc/README.rockchip b/doc/README.rockchip
> index 96fa49d697bc..82df9d084439 100644
> --- a/doc/README.rockchip
> +++ b/doc/README.rockchip
> @@ -13,260 +13,9 @@ Warning
>   This document is being moved to doc/board/rockchip, so information on it
>   might be incomplete or outdated.
> 
> -Prerequisites
> -=============
> -
> -You will need:
> -
> -   - Firefly RK3288 board or something else with a supported RockChip SoC
> -   - Power connection to 5V using the supplied micro-USB power cable
> -   - Separate USB serial cable attached to your computer and the Firefly
> -        (connect to the micro-USB connector below the logo)
> -   - rkflashtool [3]
> -   - openssl (sudo apt-get install openssl)
> -   - Serial UART connection [4]
> -   - Suitable ARM cross compiler, e.g.:
> -        sudo apt-get install gcc-4.7-arm-linux-gnueabi
> -
> -Building
> -========
> -
> -1. To build RK3288 board:
> -
> -   CROSS_COMPILE=arm-linux-gnueabi- make O=firefly firefly-rk3288_defconfig all
> -
> -    (or you can use another cross compiler if you prefer)
> -
> -2. To build RK3308 board:
> -
> -   See doc/board/rockchip/rockchip.rst
> -
> -3. To build RK3399 board:
> -
> -   Option 1: Package the image with Rockchip miniloader:
> -
> -   - Compile U-Boot
> -
> -     => cd /path/to/u-boot
> -     => make nanopi-neo4-rk3399_defconfig
> -     => make
> -
> -   - Get the rkbin
> -
> -     => git clone https://github.com/rockchip-linux/rkbin.git
> -
> -   - Create trust.img
> -
> -     => cd /path/to/rkbin
> -     => ./tools/trust_merger RKTRUST/RK3399TRUST.ini
> -
> -   - Create uboot.img
> -
> -     => cd /path/to/rkbin
> -     => ./tools/loaderimage --pack --uboot /path/to/u-boot/u-boot-dtb.bin uboot.img
> -
> -     (Get trust.img and uboot.img)
> -
> -   Option 2: Package the image with SPL:
> -
> -   - Export cross compiler path for aarch64
> -
> -   - Compile ATF
> -
> -     => git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
> -     => cd trusted-firmware-a
> -
> -     (export cross compiler path for Cortex-M0 MCU likely arm-none-eabi-)
> -     => make realclean
> -     => make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399
> -
> -    (export bl31.elf)
> -    => export BL31=/path/to/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
> -
> -   - Compile PMU M0 firmware
> -
> -     This is optional for most of the rk3399 boards.
> -
> -     => git clone git://git.theobroma-systems.com/rk3399-cortex-m0.git
> -     => cd rk3399-cortex-m0
> -
> -     (export cross compiler path for Cortex-M0 PMU)
> -     => make CROSS_COMPILE=arm-cortex_m0-eabi-
> -
> -     (export rk3399m0.bin)
> -     => export PMUM0=/path/to/rk3399-cortex-m0/rk3399m0.bin
> -
> -   - Compile U-Boot
> -
> -     => cd /path/to/u-boot
> -     => make orangepi-rk3399_defconfig
> -     => make
> -
> -     (Get spl/u-boot-spl-dtb.bin, u-boot.itb images and some boards would get
> -      spl/u-boot-spl.bin since it doesn't enable CONFIG_SPL_OF_CONTROL
> -
> -      If TPL enabled on the target, get tpl/u-boot-tpl-dtb.bin or tpl/u-boot-tpl.bin
> -      if CONFIG_TPL_OF_CONTROL not enabled)
> -
> -Writing to the board with USB
> -=============================
> -
> -For USB to work you must get your board into ROM boot mode, either by erasing
> -your MMC or (perhaps) holding the recovery button when you boot the board.
> -To erase your MMC, you can boot into Linux and type (as root)
> -
> -   dd if=/dev/zero of=/dev/mmcblk0 bs=1M
> -
> -Connect your board's OTG port to your computer.
> -

We are missing the first few lines in this section in 
doc/board/rockchip/rockchip.rst.

I think we need to explain that ways of booting into MaskROM are to 
erase all possible storage media the SoC can use as boot media, or hold 
the eMMC/NOR/NAND in reset or short the clock/data line and removing the 
SD card, or on RK35xx series (all of them?) ground the ADC channel 0, or 
on supported devices (require U-Boot support which is not that 
widespread) press the recovery button during boot.

> -To create a suitable image and write it to the board:
> -
> -   ./firefly-rk3288/tools/mkimage -n rk3288 -T rkimage -d \
> -	./firefly-rk3288/spl/u-boot-spl-dtb.bin out && \
> -   cat out | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | rkflashtool l
> -
> -If all goes well you should something like:
> -
> -   U-Boot SPL 2015.07-rc1-00383-ge345740-dirty (Jun 03 2015 - 10:06:49)
> -   Card did not respond to voltage select!
> -   spl: mmc init failed with error: -17
> -   ### ERROR ### Please RESET the board ###
> -
> -You will need to reset the board before each time you try. Yes, that's all
> -it does so far. If support for the Rockchip USB protocol or DFU were added
> -in SPL then we could in principle load U-Boot and boot to a prompt from USB
> -as several other platforms do. However it does not seem to be possible to
> -use the existing boot ROM code from SPL.
> -

I don't mind if this patch doesn't document how to fully USB boot 
mainline U-Boot, but we should do it at some point :) (even if we 
explain the user currently needs to use boot_merger to generate an 
rkdeveloptool-compatible binary with the 0x471 and 0x472 binaries we 
generate).

> -
> -Writing to the eMMC with USB on ROC-RK3308-CC
> -=============================================
> -For USB to work you must get your board into Bootrom mode,
> -either by erasing the eMMC or short circuit the GND and D0
> -on core board.
> -
> -Connect the board to your computer via tyepc.
> -=> rkdeveloptool db rk3308_loader_v1.26.117.bin
> -=> rkdeveloptool wl 0x40 idbloader.img
> -=> rkdeveloptool wl 0x4000 u-boot.itb
> -=> rkdeveloptool rd
> -

This is not documented yet in doc/board/rockchip/rockchip.rst and we 
should document it. I would recommend to simply tell the user to flash 
u-boot-rockchip.bin at offset 0x40 (64 in decimal, in blocks, so 32KiB) 
since it'll properly handle the offset for u-boot.itb.

> -Then you will see the boot log from Debug UART at baud rate 1500000:
> -DDR Version V1.26
> -REGFB: 0x00000032, 0x00000032
> -In
> -589MHz
> -DDR3
> - Col=10 Bank=8 Row=14 Size=256MB
> -msch:1
> -Returning to boot ROM...
> -
> -U-Boot SPL 2020.01-rc1-00225-g34b681327f (Nov 14 2019 - 10:58:04 +0800)
> -Trying to boot from MMC1
> -INFO:    Preloader serial: 2
> -NOTICE:  BL31: v1.3(release):30f1405
> -NOTICE:  BL31: Built : 17:08:28, Sep 23 2019
> -INFO:    Lastlog: last=0x100000, realtime=0x102000, size=0x2000
> -INFO:    ARM GICv2 driver initialized
> -INFO:    Using opteed sec cpu_context!
> -INFO:    boot cpu mask: 1
> -INFO:    plat_rockchip_pmu_init: pd status 0xe b
> -INFO:    BL31: Initializing runtime services
> -WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will rK
> -ERROR:   Error initializing runtime service opteed_fast
> -INFO:    BL31: Preparing for EL3 exit to normal world
> -INFO:    Entry point address = 0x600000
> -INFO:    SPSR = 0x3c9
> -
> -
> -U-Boot 2020.01-rc1-00225-g34b681327f (Nov 14 2019 - 10:58:47 +0800)
> -
> -Model: Firefly ROC-RK3308-CC board
> -DRAM:  254 MiB
> -MMC:   dwmmc@ff480000: 0, dwmmc@ff490000: 1
> -rockchip_dnl_key_pressed read adc key val failed
> -Net:   No ethernet found.
> -Hit any key to stop autoboot:  0
> -Card did not respond to voltage select!
> -switch to partitions #0, OK
> -mmc1(part 0) is current device
> -Scanning mmc 1:4...
> -Found /extlinux/extlinux.conf
> -Retrieving file: /extlinux/extlinux.conf
> -151 bytes read in 3 ms (48.8 KiB/s)
> -1:      kernel-mainline
> -Retrieving file: /Image
> -14737920 bytes read in 377 ms (37.3 MiB/s)
> -append: earlycon=uart8250,mmio32,0xff0c0000 console=ttyS2,1500000n8
> -Retrieving file: /rk3308-roc-cc.dtb
> -28954 bytes read in 4 ms (6.9 MiB/s)
> -Flattened Device Tree blob at 01f00000
> -Booting using the fdt blob at 0x1f00000
> -## Loading Device Tree to 000000000df3a000, end 000000000df44119 ... OK
> -
> -Starting kernel ...
> -[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd042]
> -[    0.000000] Linux version 5.4.0-rc1-00040-g4dc2d508fa47-dirty (andy@B150) (gcc version 6.3.1 20170404 (Linaro GCC 6.3-209
> -[    0.000000] Machine model: Firefly ROC-RK3308-CC board
> -[    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff0c0000 (options '')
> -[    0.000000] printk: bootconsole [uart8250] enabled
> -
>   Booting from an SD card
>   =======================
> 
> -To write an image that boots from an SD card (assumed to be /dev/sdc):
> -
> -   ./firefly-rk3288/tools/mkimage -n rk3288 -T rksd -d \
> -	firefly-rk3288/spl/u-boot-spl-dtb.bin out && \
> -   sudo dd if=out of=/dev/sdc seek=64 && \
> -   sudo dd if=firefly-rk3288/u-boot-dtb.img of=/dev/sdc seek=16384
> -
> -This puts the Rockchip header and SPL image first and then places the U-Boot
> -image at block 16384 (i.e. 8MB from the start of the SD card). This
> -corresponds with this setting in U-Boot:
> -
> -   #define CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR	0x4000
> -
> -Put this SD (or micro-SD) card into your board and reset it. You should see
> -something like:
> -
> -   U-Boot 2016.01-rc2-00309-ge5bad3b-dirty (Jan 02 2016 - 23:41:59 -0700)
> -
> -   Model: Radxa Rock 2 Square
> -   DRAM:  2 GiB
> -   MMC:   dwmmc@ff0f0000: 0, dwmmc@ff0c0000: 1
> -   *** Warning - bad CRC, using default environment
> -
> -   In:    serial
> -   Out:   vop@ff940000.vidconsole
> -   Err:   serial
> -   Net:   Net Initialization Skipped
> -   No ethernet found.
> -   Hit any key to stop autoboot:  0
> -   =>
> -
> -The rockchip bootrom can load and boot an initial spl, then continue to
> -load a second-stage bootloader (ie. U-Boot) as soon as the control is returned
> -to the bootrom. Both the RK3288 and the RK3036 use this special boot sequence.
> -The configuration option enabling this is:
> -
> -	CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
> -
> -You can create the image via the following operations:
> -
> -   ./firefly-rk3288/tools/mkimage -n rk3288 -T rksd -d \
> -	firefly-rk3288/spl/u-boot-spl-dtb.bin out && \
> -   cat firefly-rk3288/u-boot-dtb.bin >> out && \
> -   sudo dd if=out of=/dev/sdc seek=64
> -
> -Or:
> -   ./firefly-rk3288/tools/mkimage -n rk3288 -T rksd -d \
> -	firefly-rk3288/spl/u-boot-spl-dtb.bin:firefly-rk3288/u-boot-dtb.bin \
> -	out && \
> -   sudo dd if=out of=/dev/sdc seek=64
> -
> -If you have an HDMI cable attached you should see a video console.
> -
>   For evb_rk3036 board:
>   	./evb-rk3036/tools/mkimage -n rk3036 -T rksd  -d evb-rk3036/spl/u-boot-spl.bin out && \
>   	cat evb-rk3036/u-boot-dtb.bin >> out && \
> @@ -280,23 +29,6 @@ Or:
>   Note: rk3036 SDMMC and debug uart use the same iomux, so if you boot from SD, the
>         debug uart must be disabled
> 

Is there a reason for keeping the rk3036 part? Can't we use 
u-boot-rockchip.bin instead of the above instructions?> -
> -Booting from an SD card on RK3288 with TPL
> -==========================================
> -
> -Since the size of SPL can't be exceeded 0x8000 bytes in RK3288, it is not possible add
> -new SPL features like Falcon mode or etc.
> -
> -So introduce TPL so-that adding new features to SPL is possible because now TPL should
> -run minimal with code like DDR, clock etc and rest of new features in SPL.
> -
> -As of now TPL is added on Vyasa-RK3288 board.
> -
> -To write an image that boots from an SD card (assumed to be /dev/mmcblk0):
> -
> -    sudo dd if=idbloader.img of=/dev/mmcblk0 seek=64 &&
> -    sudo dd if=u-boot-dtb.img of=/dev/mmcblk0 seek=16384
> -
>   Booting from an SD card on RK3188
>   =================================
> 
> @@ -321,291 +53,6 @@ tools/mkimage -n rk3188 -T rksd -d spl/u-boot-spl.bin out
>   truncate -s %2048 u-boot.bin
>   cat u-boot.bin | split -b 512 --filter='openssl rc4 -K 7C4E0304550509072D2C7B38170D1711' >> out
> 

Same here. The rc4 encoding part should already be handled by mkimage 
since commit 162c46d5ee71 ("rockchip: mkimage: Add support rk3188 
serial"). I'm hoping we got everything right for the rest of the 
limitations listed in this section.
I believe the "small 1kb loader which returns control to the bootrom" is 
controlled by xPL_ROCKCHIP_EARLYRETURN_TO_BROM which is enabled on 
RK3066 and RK3188 (with different implementations, see 
arch/arm/include/asm/arch-rk3066/boot0.h and 
arch/arm/include/asm/arch-rockchip/boot0.h).
As for the 2KiB (it says kb, but I'm assuming it's B and Ki but who 
knows), I believe this should be handled by mkimage also, via the 
rkcommon_get_aligned_size()?
As for 29KiB + 1KiB for the SPL, I believe this is handled by the 
spl_infos[] entry for rk3188 where the size is limited to 0x8000 - 0x800 
which is 30KiB.
So I think this is fine to remove.

> -Booting from an SD card on Pine64 Rock64 (RK3328)
> -=================================================
> -
> -For Rock64 rk3328 board the following three parts are required:
> -TPL, SPL, and the u-boot image tree blob.
> -
> -  - Write TPL/SPL image at 64 sector
> -
> -    => sudo dd if=idbloader.img of=/dev/mmcblk0 seek=64
> -
> -  - Write u-boot image tree blob at 16384 sector
> -
> -    => sudo dd if=u-boot.itb of=/dev/mmcblk0 seek=16384
> -
> -Booting from an SD card on RK3399
> -=================================
> -
> -To write an image that boots from an SD card (assumed to be /dev/sdc):
> -
> -Option 1: Package the image with Rockchip miniloader:
> -
> -  - Create idbloader.img
> -
> -    => cd /path/to/u-boot
> -    => ./tools/mkimage  -n rk3399 -T rksd -d /path/to/rkbin/bin/rk33/rk3399_ddr_800MHz_v1.20.bin idbloader.img
> -    => cat /path/to/rkbin/bin/rk33/rk3399_miniloader_v1.19.bin >> idbloader.img
> -
> -  - Write idbloader.img at 64 sector
> -
> -    => sudo dd if=idbloader.img of=/dev/sdc seek=64
> -
> -  - Write trust.img at 24576
> -
> -    => sudo dd if=trust.img of=/dev/sdc seek=24576
> -
> -  - Write uboot.img at 16384 sector
> -
> -    => sudo dd if=uboot.img of=/dev/sdc seek=16384
> -    => sync
> -
> -Put this SD (or micro-SD) card into your board and reset it. You should see
> -something like:
> -
> -DDR Version 1.20 20190314
> -In
> -Channel 0: DDR3, 933MHz
> -Bus Width=32 Col=10 Bank=8 Row=15 CS=1 Die Bus-Width=16 Size=1024MB
> -no stride
> -ch 0 ddrconfig = 0x101, ddrsize = 0x20
> -pmugrf_os_reg[2] = 0x10006281, stride = 0x17
> -OUT
> -Boot1: 2019-03-14, version: 1.19
> -CPUId = 0x0
> -ChipType = 0x10, 239
> -mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
> -mmc: ERROR: Card did not respond to voltage select!
> -emmc reinit
> -mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
> -mmc: ERROR: Card did not respond to voltage select!
> -emmc reinit
> -mmc: ERROR: SDHCI ERR:cmd:0x102,stat:0x18000
> -mmc: ERROR: Card did not respond to voltage select!
> -SdmmcInit=2 1
> -mmc0:cmd5,20
> -SdmmcInit=0 0
> -BootCapSize=0
> -UserCapSize=60543MB
> -FwPartOffset=2000 , 0
> -StorageInit ok = 45266
> -SecureMode = 0
> -SecureInit read PBA: 0x4
> -SecureInit read PBA: 0x404
> -SecureInit read PBA: 0x804
> -SecureInit read PBA: 0xc04
> -SecureInit read PBA: 0x1004
> -SecureInit read PBA: 0x1404
> -SecureInit read PBA: 0x1804
> -SecureInit read PBA: 0x1c04
> -SecureInit ret = 0, SecureMode = 0
> -atags_set_bootdev: ret:(0)
> -GPT 0x3380ec0 signature is wrong
> -recovery gpt...
> -GPT 0x3380ec0 signature is wrong
> -recovery gpt fail!
> -LoadTrust Addr:0x4000
> -No find bl30.bin
> -Load uboot, ReadLba = 2000
> -hdr 0000000003380880 + 0x0:0x88,0x41,0x3e,0x97,0xe6,0x61,0x54,0x23,0xe9,0x5a,0xd1,0x2b,0xdc,0x2f,0xf9,0x35,
> -
> -Load OK, addr=0x200000, size=0x9c9c0
> -RunBL31 0x10000
> -NOTICE:  BL31: v1.3(debug):370ab80
> -NOTICE:  BL31: Built : 09:23:41, Mar  4 2019
> -NOTICE:  BL31: Rockchip release version: v1.1
> -INFO:    GICv3 with legacy support detected. ARM GICV3 driver initialized in EL3
> -INFO:    Using opteed sec cpu_context!
> -INFO:    boot cpu mask: 0
> -INFO:    plat_rockchip_pmu_init(1181): pd status 3e
> -INFO:    BL31: Initializing runtime services
> -INFO:    BL31: Initializing BL32
> -INF [0x0] TEE-CORE:init_primary_helper:337: Initializing (1.1.0-195-g8f090d20 #6 Fri Dec  7 06:11:20 UTC 2018 aarch64)
> -
> -INF [0x0] TEE-CORE:init_primary_helper:338: Release version: 1.2
> -
> -INF [0x0] TEE-CORE:init_teecore:83: teecore inits done
> -INFO:    BL31: Preparing for EL3 exit to normal world
> -INFO:    Entry point address = 0x200000
> -INFO:    SPSR = 0x3c9
> -
> -
> -U-Boot 2019.04-rc4-00136-gfd121f9641-dirty (Apr 16 2019 - 14:02:47 +0530)
> -
> -Model: FriendlyARM NanoPi NEO4
> -DRAM:  1022 MiB
> -MMC:   dwmmc@fe310000: 2, dwmmc@fe320000: 1, sdhci@fe330000: 0
> -Loading Environment from MMC... *** Warning - bad CRC, using default environment
> -
> -In:    serial@ff1a0000
> -Out:   serial@ff1a0000
> -Err:   serial@ff1a0000
> -Model: FriendlyARM NanoPi NEO4
> -Net:   eth0: ethernet@fe300000
> -Hit any key to stop autoboot:  0
> -=>
> -
> -Option 2: Package the image with SPL:
> -
> -  - Prefix rk3399 header to SPL image
> -
> -    => cd /path/to/u-boot
> -    => ./tools/mkimage -n rk3399 -T rksd -d spl/u-boot-spl-dtb.bin out
> -
> -  - Write prefixed SPL at 64th sector
> -
> -    => sudo dd if=out of=/dev/sdc seek=64
> -
> -  - Write U-Boot proper at 16384 sector
> -
> -    => sudo dd if=u-boot.itb of=/dev/sdc seek=16384
> -    => sync
> -
> -Put this SD (or micro-SD) card into your board and reset it. You should see
> -something like:
> -
> -U-Boot SPL board init
> -Trying to boot from MMC1
> -
> -
> -U-Boot 2019.01-00004-g14db5ee998 (Mar 11 2019 - 13:18:41 +0530)
> -
> -Model: Orange Pi RK3399 Board
> -DRAM:  2 GiB
> -MMC:   dwmmc@fe310000: 2, dwmmc@fe320000: 1, sdhci@fe330000: 0
> -Loading Environment from MMC... OK
> -In:    serial@ff1a0000
> -Out:   serial@ff1a0000
> -Err:   serial@ff1a0000
> -Model: Orange Pi RK3399 Board
> -Net:   eth0: ethernet@fe300000
> -Hit any key to stop autoboot:  0
> -=>
> -
> -Option 3: Package the image with TPL:
> -
> -  - Write tpl+spl at 64th sector
> -
> -    => sudo dd if=idbloader.img of=/dev/sdc seek=64
> -
> -  - Write U-Boot proper at 16384 sector
> -
> -    => sudo dd if=u-boot.itb of=/dev/sdc seek=16384
> -    => sync
> -
> -Put this SD (or micro-SD) card into your board and reset it. You should see
> -something like:
> -
> -U-Boot TPL board init
> -Trying to boot from BOOTROM
> -Returning to boot ROM...
> -
> -U-Boot SPL board init
> -Trying to boot from MMC1
> -
> -
> -U-Boot 2019.07-rc1-00241-g5b3244767a (May 08 2019 - 10:51:06 +0530)
> -
> -Model: Orange Pi RK3399 Board
> -DRAM:  2 GiB
> -MMC:   dwmmc@fe310000: 2, dwmmc@fe320000: 1, sdhci@fe330000: 0
> -Loading Environment from MMC... OK
> -In:    serial@ff1a0000
> -Out:   serial@ff1a0000
> -Err:   serial@ff1a0000
> -Model: Orange Pi RK3399 Board
> -Net:   eth0: ethernet@fe300000
> -Hit any key to stop autoboot:  0
> -=>
> -
> -Using fastboot on rk3288
> -========================
> -- Write GPT partition layout to mmc device which fastboot want to use it to
> -store the image
> -
> -        => gpt write mmc 1 $partitions
> -
> -- Invoke fastboot command to prepare
> -
> -        => fastboot 1
> -
> -- Start fastboot request on PC
> -
> -        fastboot -i 0x2207 flash loader evb-rk3288/spl/u-boot-spl-dtb.bin
> -
> -You should see something like:
> -
> -        => fastboot 1
> -        WARNING: unknown variable: partition-type:loader
> -        Starting download of 357796 bytes
> -        ..
> -        downloading of 357796 bytes finished
> -        Flashing Raw Image
> -        ........ wrote 357888 bytes to 'loader'
> -
> -Booting from SPI
> -================
> -
> -To write an image that boots from SPI flash (e.g. for the Haier Chromebook or
> -Bob):
> -
> -   ./chromebook_jerry/tools/mkimage -n rk3288 -T rkspi \
> -	-d chromebook_jerry/spl/u-boot-spl-dtb.bin spl.bin && \
> -   dd if=spl.bin of=spl-out.bin bs=128K conv=sync && \
> -   cat spl-out.bin chromebook_jerry/u-boot-dtb.img >out.bin && \
> -   dd if=out.bin of=out.bin.pad bs=4M conv=sync
> -
> -This converts the SPL image to the required SPI format by adding the Rockchip
> -header and skipping every second 2KB block. Then the U-Boot image is written at
> -offset 128KB and the whole image is padded to 4MB which is the SPI flash size.
> -The position of U-Boot is controlled with this setting in U-Boot:
> -
> -   #define CONFIG_SYS_SPI_U_BOOT_OFFS	0x20000
> -
> -If you have a Dediprog em100pro connected then you can write the image with:
> -
> -      sudo em100 -s -c GD25LQ32 -d out.bin.pad -r
> -

We don't have this in doc/board/rockchip/rockchip.rst but I don't own 
any RK3288 board nor the tool to flash it. I'm hoping 
u-boot-rockchip-spi.bin can be used here as binary to flash. We generate 
it and it's sized to 4MiB in arch/arm/dts/rk3288-veyron-u-boot.dtsi so I 
think we got this right. I'm thinking the flashing instruction is fine 
to remove though.

> -When booting you should see something like:
> -
> -   U-Boot SPL 2015.07-rc2-00215-g9a58220-dirty (Jun 23 2015 - 12:11:32)
> -
> -
> -   U-Boot 2015.07-rc2-00215-g9a58220-dirty (Jun 23 2015 - 12:11:32 -0600)
> -
> -   Model: Google Jerry
> -   DRAM:  2 GiB
> -   MMC:
> -   Using default environment
> -
> -   In:    serial@ff690000
> -   Out:   serial@ff690000
> -   Err:   serial@ff690000
> -   =>
> -
> -Future work
> -===========
> -
> -Immediate priorities are:
> -
> -- USB host
> -- USB device
> -- Run CPU at full speed (code exists but we only see ~60 DMIPS maximum)
> -- NAND flash
> -- Boot U-Boot proper over USB OTG (at present only SPL works)
> -
> -
> -Development Notes
> -=================
> -
> -There are plenty of patches in the links below to help with this work.
> -
> -[1] https://github.com/rkchrome/uboot.git
> -[2] https://github.com/linux-rockchip/u-boot-rockchip.git branch u-boot-rk3288
> -[3] https://github.com/linux-rockchip/rkflashtool.git
> -[4] http://wiki.t-firefly.com/index.php/Firefly-RK3288/Serial_debug/en
> -
>   rkimage
>   -------
> > @@ -657,16 +104,6 @@ rkmux.py
>   You can use this script to create #defines for SoC register access. See the
>   script for usage.
> 
> -
> -Device tree and driver model
> -----------------------------
> -
> -Where possible driver model is used to provide a structure to the
> -functionality. Device tree is used for configuration. However these have an
> -overhead and in SPL with a 32KB size limit some shortcuts have been taken.
> -In general all Rockchip drivers should use these features, with SPL-specific
> -modifications where required.
> -
>   GPT partition layout
>   ----------------------------
> 

So we're left with rkimage, rksd, rkspi, rkmux.py, and GPT partition 
layout sections.
It seems we don't generate any image with mkimage -T rkimage and I'm 
wondering whether this isn't already covered by the 
CONFIG_ROCKCHIP_MASKROM_IMAGE-controlled USB-bootable image Jonas added 
support for recently. Since it's part of mkimage, I don't think we can 
remove it. We could however move the documentation within the 
tools/rkimage.c file I think. I don't even know how much of it still 
stands today.
For rksd and rkspi, the technical details make more sense (to me) as 
comments in tools/{rksd,rkspi}.c. mkimage manpage (doc/mkimage.1) is 
missing documentation for rksd and rkspi though, so we should think 
about adding some words to it :)
For rkmux.py, I think it's fine to remove as the comment at the top of 
the file (tools/rkmux.py) is good enough?
For the GPT partition layout, please add it to 
doc/board/rockchip/rockchip.rst, it is quite useful. For example, 
meta-rockchip in Yocto reuses it. It used to be hosted at 
https://opensource.rock-chips.com/wiki_Partitions but it seems the 
website is not up anymore, so link to the wayback machine, e.g. 
https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions.

Thanks for the cleanup!

There's also doc/README.rockusb that I think we could put in 
doc/board/rockchip/ alongside the rkmtd.rst file?

Cheers,
Quentin

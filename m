Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A28FC46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 11:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE481871C3;
	Sat,  6 Jan 2024 12:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="to06F19p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6298784F; Sat,  6 Jan 2024 12:58:48 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71758718F
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 12:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjEJ8CVIu2b3D0jsprRSHooEJy8vqc9lBCM0+2AMOGmNvKULW7R6ukO6Fwnlh+vS9/Rozl7ntUyU79k8gBZoALXxH6q5NYBhUTkgUzFcN2Il6UMqGjCudkP3QiFSuLpAE/B/X6DKc8OMYSRb+Q8ZMW+N24Ix4cruijU1UvNF3P2er76fB8xKbrufbpu5K1a2kbcXQr7JgcwtCNNUrunrssDgbLSYB9/Tgm9Q1TfbjcSXGHZ0YuboPffFUl1iSXbygUKYee+GnGbWcSTWIbYBd5s4lowBvhyW+c+tS++ysPy8zgyHJtEv7WnDdI5oRxpHZ/0gUo+qkN1+lHsQ4Esulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OFuemEiSmVN5QCjC98G6yc+bYx7FnZiEh1uXPqlv1A=;
 b=V6eFDPysUwAUCeqSaleiGDlUOyxdkpeROAq0ekdwwQyV0Ax2joyswfiA1Bh+Zv6HWMwKDiwq56YD5LCBwn519zAzY5h/lNilYmIEl/Yhn5PDCX+BM6jmeDPSVCHjwmAYxF6zzO/PQpCZDvLokh7ZEwZSucf8kjH9TafK/Y5vUweHcl8MWoTAA2X10Si3RR6lS4B52uSWVD87ep7NHnY5CMtWS4RVh2uOKbq7BKeXeDw7TPv7Yq9ZjV/hQC5Bx8RvyBcF3ufzj7Stif9A911Vc+nAv+FX4xZIG9U4wtfkn6FFS1F/nZSFZ8ssEzYSll04DWK7PmnZrxuZsqER4lxHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OFuemEiSmVN5QCjC98G6yc+bYx7FnZiEh1uXPqlv1A=;
 b=to06F19pNfz7/NKhhZXPXNOrRgonjQxYIP7+m4LHkL9POBiWPOzS4NVUMImJAazEJhnJbayueUdP6UikkhKk/ipE/vBijERWocM6du1j0rYWCxYA7dKL6V1Jx0T+EJA11SacJHyHLTFiXN2zRvmm8e3svprgbnhkXokwu8oUBTJQV3NKGo0HYZwf0/SYMxmag7I5stAkaLWnqPHWRjQyFcWflx8WvYTLojF30rZtT0Lu6SESIShjukke406CqiWb+E2QauoXPlfP647z3M52oz75pWaflkLhMRCk2UC2c+wdxcvB/fj6uyGUSVvgLL2WUBLcPa8jTta5Fva6DJ2+3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 11:58:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 11:58:44 +0000
Message-ID: <7ab0f707-bbe9-4631-8c95-c5035a775b9b@siemens.com>
Date: Sat, 6 Jan 2024 12:58:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] sync am65x device tree with Linux v6.7-rc1
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
Cc: UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
References: <20231229174656.634065-28-bb@ti.com>
 <10cffb20-3157-43e2-acfe-e2b2fe207c23@siemens.com>
In-Reply-To: <10cffb20-3157-43e2-acfe-e2b2fe207c23@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3860:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bd48e6-18f0-45fe-fccd-08dc0eaed52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKn62lB1cQ+eY7emAf4H0MIQ6kTsOEQEfMCMzh4tMIZNUf/egMsZE5wa2jT5tStGHaA2B1OCTEbDr0kKgylaV/AkdJX36yuOLp+fbgiVahSbPYxMByv4Jpb11JujLP0+t8+R2Zqa4jz5huX/Tn/gAjad2IHEHdBnnLZWtPoiJf9JLnhiKpDZizSD5osL2EJjnaMXnw+X13fDWG5hnuL8qbF4I2emsTqwYUhvgeBux1FIky4ElLhsqoQWc9InXkrM9pvnHOfxin4yFWrb7jz9Qgj7d73WeNKwQEUaFy3JZSBH9QJqnKPlBK7+X+TDekn7PfqQBnO5zIWKmo0Pw4armT4MnmdTTa3VYBINcti1XuozXY3j1FNZC3ykBry0Yw2QinbmYSLYS0vIPk4oPHvWDYp3I7ecs1B9b6UFjNk56UEW1PFZFYLH7mIpphkQLCvm0I0riWGznku8IEvSeWIt9d784NSexwAuDjm8V/VT2thfOTS0OLP/gv7pFaetkl04o0BuyDtiEwWDZuZ87qYsfi64h5UiLctjvypSP4AJMdM20Cv+FDyBjSwO61ZSFZQ4ahhqxWWMiGcD/9JozKvDhUrT1z2DncjkRxSOgE4/0ruKIhgSLyoJ4OCRQeS/NWzmzadNXCEXhHFBIADrVDX+og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(7416002)(5660300002)(82960400001)(86362001)(41300700001)(31696002)(31686004)(316002)(110136005)(54906003)(8676002)(36756003)(8936002)(6512007)(2616005)(6486002)(66946007)(66556008)(66476007)(26005)(478600001)(966005)(6506007)(83380400001)(53546011)(4326008)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdBVWxveno3cHdRcWpudm43MGEweVBlb0pxU3Y4VHhYcTRXOUllWW1yeGYw?=
 =?utf-8?B?VUZMcTlRUG92UStFREwzUWNQTWpKQTBFem43MmVNVC9PVkFBb0FRdmlvb01T?=
 =?utf-8?B?a3hDbEU2RW4zYUpsaU1vNndMYjEvVlBacDNuTlZFZUgxY09Db0xsU3grbTFm?=
 =?utf-8?B?YlczVWMvMGJRWW82VkRlWG5rcmJ2MjkvYkQyWFNLQ3RsOHZ5V2YvWWhmMmE2?=
 =?utf-8?B?UTZEa0NZSU5sSDQvZlpXRlM5OTZOZW81UFM0cytMdHRLU1JPdHJlSklwcVRF?=
 =?utf-8?B?Q2MzM3FVOWc5S3ZITC8rUEVvWlFqOFh3U3NFeWppZzhxaUFxYWZERHdBMXFk?=
 =?utf-8?B?RlRxUFQxa1l6Ujh4bDkzREcxUDZ2eGRsbEJYZThiUUt6Q29ucHdiUVk5eGtt?=
 =?utf-8?B?N0pDY21GcWoxM1Q3UW5MMmRMS0lCcUNKYW16WHJJaFhkR1piL1JZYmpkTnVQ?=
 =?utf-8?B?RkFHelFjQ2pGeGF0dVlFU2cya2lZVFkzVGIrRU42aW1QdUdxRGxZN0FoQ3Zn?=
 =?utf-8?B?QnN5ck05VnIvbW5aUzIvTHNGZ1NWeXJoNWlzRTdXaXZDb0FTZXVCZVJRaUxD?=
 =?utf-8?B?ektqN1lKTVhkOGFocHFNT3V5aVB4Uk5lc28xeFExSGlwNEVFdlk5QlJSTGZj?=
 =?utf-8?B?dUpMaEFnTW45Z2JNTTZ4b2xmc3ZvcDI5U0hKMXhUOWxLRmk1ZGM1Ly8ySUJr?=
 =?utf-8?B?R3VjYVc3Mk0vV0k5QzBHOXJwb1h1TFpBUUVKQVFSeHNDQ0JScUtJbFNWQ1R6?=
 =?utf-8?B?Z2swdVZCQlNxOXhjams0eExLSDVnaEhwNGxSWnVqbFdUQ0tULzBLeEdjRGZZ?=
 =?utf-8?B?L3lPWjV0YTFWbUZqWnJhZUFrSWdSTkQzazdIbUhlQys2VzFxMUtEWFBRL0xD?=
 =?utf-8?B?VU0rWG1Sb01CNE1tNGhWeCtOWkxDS1RCYmRGbTl4R282ZnVGMWplTC8vZHpn?=
 =?utf-8?B?bHlONEhNa3dDMjk4WFZEZGFaOHU0cWpJWWkvTGpiNmxCUmNKQkRCaUNUV0Uy?=
 =?utf-8?B?ZU5XWC9JeDlqT2R6TmVvK0diaGZEdkk3WG9oNG5UZERybzk5aHZDT1ZDS1Na?=
 =?utf-8?B?SG9wL0dhV2pHMzVQVFg2OUVFcVhINlJHc01HVURCd2QrSThGWUhMelBtaG9T?=
 =?utf-8?B?VW4xdzJBN05YZmtTTnJKRldrNlhIZ0FoZmp6SWhKN0tBK0MxcEpYSWFyaW52?=
 =?utf-8?B?MlNuRFBmaUlYZDNHU3dBdk9OclJNUGE1U0t0K3dUWDNVd1RJa3VRVW9LUmd1?=
 =?utf-8?B?a2o3QWRyT2ZFT2NEeUtobnRSckNnMkc4VmZzTFk1cXloOTJDd0dqTEpwRGVw?=
 =?utf-8?B?b24veC9lVENQVFBmeFdnajJQdUd6SnRyd2RMM3BkRDZ5WEo1a0FCUkxab3A1?=
 =?utf-8?B?VjFVQ3dUdkg2eW93N0FrdDBUdXMwcTEwQ2ZtaFVVQVc5cVFLSXpEYm1qb0wr?=
 =?utf-8?B?N0E5dkNDdmlpTTdyMjVGRkhib0hla2hlUy9HTFlGLy9TaHJoTURYcmU2d3FE?=
 =?utf-8?B?VVBzRFBZcVVyL2Npb1dKQmhqaVpsTThvRnhJTnRhQnhCTnkzei9nV1JRbTNj?=
 =?utf-8?B?Yjgzb3VSTjYxYkpiS3NNQ2NzUzJvcExwZi9rNm12M1dKTnMyMklCdFNuSEpK?=
 =?utf-8?B?ZzBJUHJYZVlxazBucVU1TXQ5emZPV3VpYzZYZzE5aTZHejlwSWZkZ0Q4R3ow?=
 =?utf-8?B?MWd6VTU3SkhxTGJFT1BzMUdaUzIxWVIxVnNtYWo2dmhyNEtKTlB5U2hnSFha?=
 =?utf-8?B?azdGSlZBTGVxc1dUWEg0MTFGeStaNGhoVnRZRmQ4L2VCc3VuN1lHVHEycDVi?=
 =?utf-8?B?VFl6cHZUY00xWlJmSkovZTA0VUpVZ0ZMVHRBdTJaUnN6blJSSTJEUmYxNXRy?=
 =?utf-8?B?YlF0YWVXMFBFQXJvYzJycUdTS1RLY1VKOE4waU4ya0F1M3hEZElRcTFJU0wr?=
 =?utf-8?B?bWExY3UzQXVsUmJBSms5bXdEc3NjVmFNcDQ1UVVHVjJUTkd2R1ZUM1JqL1Ux?=
 =?utf-8?B?ZVJmbFlOM0wrQ2pSUElxalZvQnhjVE1hei81Uk1JRWVZZ2VhYktwUGlURkdW?=
 =?utf-8?B?WUt1bkh2bytxekMwSHhUd1d6dEx3UDFnam50eUp1dzI2WmUzS1RoSTA5dDRB?=
 =?utf-8?B?SS9UdDQrVTlDeU9DUVRPL0JIRHNJL2g3M1pBbzcxZ0pTQnNXQnpuRThwN1Ry?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bd48e6-18f0-45fe-fccd-08dc0eaed52a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 11:58:44.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQd1yeYS8JjpIQQHtAtSC+vBEbLenguuuOWr1vYaJ99qIZXmTGd7EbC/vzRb/twHOtTzfCjCFPMqThC/lIqrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3860
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

On 06.01.24 12:57, Jan Kiszka wrote:
> On 29.12.23 18:46, Bryan Brattlof wrote:
>> Hello Again Everyone!
>>
>> This series gets the am65x booting again along with syncing the device
>> tree files with v6.7-rc1 Linux.
>>
>> The bulk of these patches unify the WKUP SPL board file with the arm64
>> files to make future syncs from Linux much easier. In the end the DTBs
>> should look a lot like what the DTBs look like for the am64x which
>> is fairly similar to the am65x.
>>
>> For those interested in what UART boot looks like:
>>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc
>>
>> Changes from v1: [0]
>> - fixed multi-line comment format
>> - moved wkup_uart0 and mcu_uart0 U-Boot overrides to the r5 board file
>>   as they are not needed for a53/main domain U-Boot builds
>> - corrected a bad wkup_i2c0_pins_default fixup in PATCH 6/26
>> - spelling fix (s/Libux/Linux/) in commit body for PATCH 6/26
>> - added trailers from Tom
>>
>> Thanks for reviewing and happy holidays
>> ~Bryan
>>
>> [0] https://lore.kernel.org/u-boot/20231221174412.210807-1-bb@ti.com/
>>
>> Bryan Brattlof (26):
>>   configs: am65x_evm_r5: enable driver for fixed regulators
>>   configs: am65x_evm_a53: disable CONSOLE_MUX
>>   arm: dts: k3-am654-r5: Merge board file and U-Boot overlay
>>   arm: dts: k3-am654: pull in dtb update from Linux
>>   arm: dts: k3-am654: copy bootph properties to a53 dts
>>   arm: dts: k3-am654: include a53 board dtb for r5 build
>>   arm: dts: k3-am654: remove duplicate vtt_supply
>>   arm: dts: k3-am654: remove duplicate wkup_uart0
>>   arm: dts: k3-am654: remove duplicate timer
>>   arm: dts: k3-am654: remove duplicate mcu_ringacc
>>   arm: dts: k3-am654: remove duplicate mcu_udmap
>>   arm: dts: k3-am654: add needed regs to udmap nodes
>>   arm: dts: k3-am654: remove duplicate mcu_uart0 node
>>   arm: dts: k3-am654: remove duplicate main_uart0
>>   arm: dts: k3-am654: remove duplicate sdhci0 pinmux node
>>   arm: dts: k3-am654: remove duplicate sdhci1 pinmux node
>>   arm: dts: k3-am654: remove duplicate wkup_i2c0
>>   arm: dts: k3-am654: remove duplicate ospi0 node
>>   arm: dts: k3-am654: remove usb0
>>   arm: dts: k3-am654: remove duplicate mdio
>>   arm: dts: k3-am654: remove duplicate vtt pinmux
>>   arm: dts: k3-am654: remove duplicate root properties
>>   arm: dts: k3-am654: remove un-needed aliases
>>   arm: dts: k3-am654: move dummy_clock to root node
>>   arm: dts: k3-am654: remove duplicate mcu secure proxy node
>>   arm: dts: k3-am654: convert bootph-pre-ram to bootph-all
>>
>>  arch/arm/dts/k3-am65-main.dtsi                | 342 +++++++++++++++---
>>  arch/arm/dts/k3-am65-mcu.dtsi                 | 156 +++++++-
>>  arch/arm/dts/k3-am65-wakeup.dtsi              |  10 +-
>>  arch/arm/dts/k3-am65.dtsi                     |  19 +-
>>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi  | 195 +++++++++-
>>  arch/arm/dts/k3-am654-base-board.dts          | 301 +++++++++------
>>  .../dts/k3-am654-r5-base-board-u-boot.dtsi    | 208 -----------
>>  arch/arm/dts/k3-am654-r5-base-board.dts       | 303 ++++------------
>>  arch/arm/dts/k3-am654.dtsi                    |   7 +
>>  configs/am65x_evm_a53_defconfig               |   1 -
>>  configs/am65x_evm_r5_defconfig                |   2 +
>>  11 files changed, 886 insertions(+), 658 deletions(-)
>>  delete mode 100644 arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
>>
>>
>> base-commit: 0a0ceea2269b983e736b80104f03cc800d1a5e2a
> 
> This breaks the IOT2050 boards, probably because it did in incomplete
> sync, changing the core dtsi file without updating all affected boards.
> But also [1] is missing in upstream already and seem to have an impact.
> Bad timing for a sync.
> 
> And the series is not bisectable - already the 3rd patch breaks the build:
> 
> ...
>   DTC     arch/arm/dts/k3-am654-r5-base-board.dtb
> Error: arch/arm/dts/.k3-am654-r5-base-board.dtb.pre.tmp:423.27-28 syntax
> error
> FATAL ERROR: Unable to parse input tree
> 
> Jan
> 
> [1]
> https://lore.kernel.org/lkml/1edbc1b56ed4ff2256d7afb7db3cab4b3a423692.1699087938.git.jan.kiszka@siemens.com/
> 

BTW, folks @TI: You have our devices by now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


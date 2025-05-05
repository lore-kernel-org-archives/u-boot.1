Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8799C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0973782161;
	Mon,  5 May 2025 16:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eXgeWUuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19ABA82757; Mon,  5 May 2025 16:06:22 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC7D8212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pzkfho9Uu8DWJ+6otuvSPwT2iztuLdng28X+I5eX7EBG6j9TVem1SdnsYVoP8v36JQQ7QINJrp2PZ2vJ0QMuhI1lbGJnO1YH7XpEVyE9yN1ms7xx4v89KSo+GDBw3cq5RYLM2NO+/xYoxwbq18nfDH3FXKe3ZBSUq7FREUVLNpClavOdhnIn2/ukY+61wwA7PtUosnzmcr4XQxrwwQgL2pnDCL23dZ5JKvPVVtWwDYfl2zlTQTKa2HTMU5b5hlx13Fio/Zcf6df6Hq4jKAqIrcZOw+ibhnr9PkUc96Z5WN5JYlr4qfxFcTdIyH3TdH/UMBkb5Gsuu4Hjxg3F3ImfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ur8wT0IYpbHGxUqEV8KkjYzSyZ3BWjvg2yz/ExwRgU=;
 b=MOF6MRV05xiEzLNuhuJdoM1hDvxHezoiltKpzcuREtQnTcYyoTlzAB5EOgRpeI2RSKXiT8faf4f3VFptYQ/xy/HuqGdFirpqhJ/bqqNmpFSUq8Z1bf3oWk8I6vuUnKlT7f83FOogh+JuhvP+pSmDVsY2dmnrrtJR1VayhiNOKwhO7uHoMgUC+ZI7PZ77taUMy80MUlb1wqaF/PJynB9gT47g0884ceyGjimY+NRe24GQDn9hBwY1JxgFsFlsthBYrE8RC1yV4+/XAmXm7IqG71WYBzd0JaT4QIhy2yxXzObV1aNnWvsXYF0I2USj8mCbTjbzgYPgvVeF+clYiCYpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ur8wT0IYpbHGxUqEV8KkjYzSyZ3BWjvg2yz/ExwRgU=;
 b=eXgeWUuNLczPZNiSKVZounW/yO+WyeU1EmHPST4yeawLP6WHBA3NlnF6QHjln2ey/70IDb6EmGsEVNux7E1kmoRZK7y47VywL0yGw1/LrobiI3M+oJQgNVrZVgl/ps+rk77XoGQ00gKMRUVyhUhH5h0iZEYd3lhiuYzNCL95SPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:06:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 14:06:16 +0000
Message-ID: <4c5d558c-da3a-4927-a802-c9c3529fd9b2@cherry.de>
Date: Mon, 5 May 2025 16:06:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
References: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: b8454ada-16a2-4860-1113-08dd8bde008d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGhMdjJNRlNTMy9XWjA1MnB3bzV3MjNqbWtJMk9ZajIxUzZMS252eUxCbFVl?=
 =?utf-8?B?MTA0NGJDZjdtQkJLWVh4enRMZkk2UnpXZHRRSTFVV3RYWk4za3dMcDlzb2la?=
 =?utf-8?B?WlJyVDNEbmM4R3ZpR0JlbmVUNWk5NEhnd3dyUEE0TERVNzdxUXpFR0YrdXlt?=
 =?utf-8?B?aTY2cWZDdDA2RWRteGY2QUo3S1ZYSFBLYk5UYzFwTzYrR0NSakRIQ3dKYXlG?=
 =?utf-8?B?dUpIVEJVenQ3MFNBSElBZDN4QWFIS3o1ZTNGQmhCcjhLZmtONXZCaXhuZVBP?=
 =?utf-8?B?Rk9lT0loVmtZMkZZN28zMWhlUk1kU1diRWhLa0d5MTE5Tk9hQlpaTkhZbFpC?=
 =?utf-8?B?YkZJdmEzSytWSUVKZFkvZUtQNk95aER4NEVxd3pnakxFVVRRWDZDUkllUUVt?=
 =?utf-8?B?QVdWZ29NNTVsTGpoMm9FQkU0cEdnTlY2aW5RMDV5K3k2MFpaRWdIejBjdk9B?=
 =?utf-8?B?c3FLT1lzdEdTSmo2bWxXbWV2YmczK3lpVlZocjhUb3A4VjJXa3I0Q2xYemxL?=
 =?utf-8?B?MTdXUUpuaSt6MmtXcFhvRFJaNDFZT3BZUERMSjlHa0VTeGpsTWdyLzV1Zld2?=
 =?utf-8?B?bzNOeE9SckJ4aUxwY00xNkZwYTB3TVo5aUtPS25rbHJhOXMzU0tycVVjejNu?=
 =?utf-8?B?Lzg1aGtvY0RrNlFRRlBDNktIejd5Q1JkSlo3TnF5MlBQTkxmc2kvM1BtOVdx?=
 =?utf-8?B?eG5lME9UZEkwcEY2QWpNQmpVTkNuZGFpQ1gvWjNHanF2aGhmL2VJWkdQdHdK?=
 =?utf-8?B?Zkc3V2pmQUxmbitkYVJybTdZeUpudjBDbXdxdWRoLzl3SE9mQ0dPYXVReEpn?=
 =?utf-8?B?enF2K1ZCYXhxN3Iva2NGTnRpbFphblYzNTluRlk5MXNYWUlpamozWWhDRmg1?=
 =?utf-8?B?UWVPSFhXVklzdlhpS2pYWFM1Sko1MFFXaG5GbCs3T3B5azBOYm81a09lWmJC?=
 =?utf-8?B?bCsxd1NLalFsWVk5RTJrUmVYK294TlZkQlRrclFncGl6M0Uwc1pNMVVid0I3?=
 =?utf-8?B?WFBvSFJocnRDVU05WW9lTFNiWmwwc3UzRHlOV1BNTWRpWFprRFN2bVNORm5M?=
 =?utf-8?B?YVVrUEtIVk9qSnFxdFU0UkVuMW90RnFlUTE2SmU2dFBxcGRoOXFUbDJSTjZO?=
 =?utf-8?B?WEZ0RENXSXEzM3ZZYkN1b0xnVmtDMjRxcTFOd3JBZk53TW9rZXpaaTlnMWxC?=
 =?utf-8?B?bW9OWVh3UmhnQmYzRDRRaFlwVHpYeldVdGlGdk1LTFZnLzU5VTYzMDBzeHA3?=
 =?utf-8?B?eFgzZ3prWGdyYUdhQVg4SHdOOHRrbzAvdk9jSWNBdTBOeDVEbHNCTzIrRU1B?=
 =?utf-8?B?SndlKy8rM3RTZExjV2RreUNHZEhOc0Nwa1R6d0pxNzRwNXluaDJuYlJQT3Bz?=
 =?utf-8?B?MHVic3BLREczWkpWeCtxU0VQN2xZQ0M1UjZ1NElxdHRkeStCWFNqYWJHM1pv?=
 =?utf-8?B?K05Pd3M4ZWoyeWhRVnZYcVdEdzh1SWtRaGU0UEpxakIwSjdaRXI3OEFFU2pS?=
 =?utf-8?B?SFg5QXNQVVBodm5tcFZqN0tzM2U3NVFxR0UrU3RjMHpnZmppSTZLYnZtU2Jx?=
 =?utf-8?B?OFNFL0NvL1Rlc25vNDh4dGtpelFlODZFMldSV3l4a2Z2bkNMZWNZUnJZU2hP?=
 =?utf-8?B?NEcwM09NVzhoZGhkSGR2YmVJVjRHQ3dpbzMvZ09LOW04WXB1a0x3WlkrdGYv?=
 =?utf-8?B?WTY2MzcrSmNScUNralFIamxKbTNRV2lEWmplN0hZTFhabFlWek9heUFuN1VX?=
 =?utf-8?B?SUpuOWdvSVNiWktqNEI5R3MyenFYZWc5SlN5czdoNUZXRjM2ZlF5Q3RqZ1lz?=
 =?utf-8?B?bUpKd01aM2lKSEk3UDZBS285STBabStyR01YUmRwZVUyM1ArYzBEdDhLaGx0?=
 =?utf-8?B?d3ZZbThvUGdRMkovaklRMW9mcGxuaklzTUJrV1Fza2YrNmMvY1dqZnBGUWJh?=
 =?utf-8?Q?A/bdJ7a6qqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ZUa01nNlRNbVhtamxaM3ZGTzR0ZVBYVXArMldROEVENkQ2eVJsb2hvUEY1?=
 =?utf-8?B?clhwUXlhNUVjUURSZ09WUkFYUGs3WlRIVFp5N0VTK2JkaTJhdHFmQ1J3VVBW?=
 =?utf-8?B?elVmWEhCM0w4cUJMRDIvQVZVazJ3WGRYUkN4cC9XdjliQTlpQVZRK3p5VkFp?=
 =?utf-8?B?d0t5SVpBcWx0UThMelZtaWt6VXdSY2lUZVZjWmJsY3VVVkc2UFdZczBKZGpW?=
 =?utf-8?B?ZG5XMlFuL253cDI4Q3cwQ2VmVUxuN0lYSFhMK0tvSW5xTmFURnBwbUtCb1FC?=
 =?utf-8?B?YXBKbFo3ekxpY2pQekVlZ3I1dGp0dk9IOG9KOXd5WHA4NXBGcTNqVFhmV1Ez?=
 =?utf-8?B?TkxoSjZaOWgrUldwQ0dUdERzYnYrS3d1d0FEeENvNXF5SkJVNXhhRENvUDlD?=
 =?utf-8?B?Q3RhWnRtVFNLMjNMdzIrK2VuOTR5TW5FZjJ2TDRrNUxiOERMQVptTFpUM2U5?=
 =?utf-8?B?QzlPNlkveE1Ob0FsdGlRSy9DRXlCVCt0RjZRbld0S0VPeXc2Q28zN3RjVWVz?=
 =?utf-8?B?SDQ1bndkbHhhTWlGNXhibldhUlNwbmZHSWdwc0lSQXBMcGFqOXlKZlp1WGJy?=
 =?utf-8?B?dkcrNHpFdGRKQ1FXbG5nSTFlcjUwaDZkS3RtMks3YTFIKzkrZDNUYzJRdzRp?=
 =?utf-8?B?b2Rkc1doV2xIdmg1MHVDdnBHdGZYMFFKOEVOaTFWenBGcGRKMGVxUi9neHlz?=
 =?utf-8?B?MDVzK2hIT3BIS0Vtb2tEeFlHZEYrTW5OYWJJT0xobTFrM2pldnVkUnVEdVJs?=
 =?utf-8?B?SUF2aitpeS9ObHhmbEtpK1JPTXhTMGpwTXZsQ25yVlZML3RkeTFQSEhUN3hV?=
 =?utf-8?B?a3BDdSt6VStYQzkwN3NaMkpjejNNY25QUXYyNjVSTXBFbm5ndkJjOU40c1dX?=
 =?utf-8?B?UlQyOThFY3hVNGpwRGJLd1FyOSttaTV0UCtYTm5pZTErQSs5ZkkraW1keXpi?=
 =?utf-8?B?SHJkendOVC9mUjdvVGN6eGpyOEtVdkQ0YVJmaVdQcW5KV1BONy9KbFFlUXpN?=
 =?utf-8?B?U09kSk5YajBqZ2dqeGZ5ekZPZVp6YS8vT2pmTDQrVVBuWEczYksxVXR6WGZP?=
 =?utf-8?B?UmxmWGFoUUtXcXk0M2NweWlldnBvbThEeHRQU01tQXlkOW5MZnpMV3Vsenl5?=
 =?utf-8?B?a1dnZHJqV1VZVkVvc1dNSHo3Y2g2aE0vNERQeVNwSFFjTWhiaE85YTNMdFg2?=
 =?utf-8?B?R1Y5bGdVSDdidGs0aVlMcG1SRjJiWTZKR1JGOCtnTW1oazYrZUZ1bktTbmpT?=
 =?utf-8?B?SFBqR1J1TTdFblJ6Mkl4aEREd3JrSHpOdjVXdUQwdldtcmlxUWhIaU95QXZ3?=
 =?utf-8?B?Nm5uWGRkRVE1dkx0KzVDUk5rM1VxbnBmQWFJZkQ2TVpKK3ZkekxnL015azQw?=
 =?utf-8?B?MGFLcG5wQm02a0Nmd0N0c1p6WlRMaCt2L1hvdkMxLzFxUWFYUk9JZDNsMlB2?=
 =?utf-8?B?MEV3c1NKSnpFTDJvVHpsTjJ0TG9zYWozZTFxOUFBNnRYaVpTanl1b3FneEhu?=
 =?utf-8?B?ZEQ2YVM2R2lGdzhmZks3U2pPdDFBSUc3L3ZuSUttUHN2V0hVSEV3QmVLSE9n?=
 =?utf-8?B?Z2ovZmFTQUJ6VWJpZDcxUm1VUTFSN1lmam1KY3JDdXllNzI3ZDcxV3cyN21K?=
 =?utf-8?B?a0hMbHRDRC9tUHlDTU4zbGwyOVJOV2FVL0NEK3dtNnhVaEpUaXp1ZVJjOEJQ?=
 =?utf-8?B?aWQ3VTlKSVk0Y3MyVFRHSy9yWnlQOHdxR0M1dHdoS0w5Z0FsbzlZSm9zaU13?=
 =?utf-8?B?MGR6bGU4YjJ4WXNtSDFJREVZSnFJZlNxZk0wbG9yMnE3MlNVTnFyc0VyYTNV?=
 =?utf-8?B?N2NGVEpUVFVDSGdMQkJYOEppUFJ5REdxMStuZGV4TWtIMGU0NjRVOXl5NjdC?=
 =?utf-8?B?OXc1MzBMZEg5SWpTUjB3b1V5eVB1QU9LUWc5VnZHYldFL2kwcEdGTGtkNHR6?=
 =?utf-8?B?WmFCTGcxc3hqYnh0RVlGR2hERUVBWjRzTStHU1pzeHBYR1VrOUNwZmgxOVNV?=
 =?utf-8?B?Kzgxc0tRUUJCYlBQZGcvN09qejRGSy95dFhvV2tTVDBHMis4elNSNHgxU1RS?=
 =?utf-8?B?Wk5odjlYc2x3WDhtVk0zS01oZGFwRjZGckVsbVdBT1VWUElQM2tieEJBaHRi?=
 =?utf-8?B?d05JTnZUbmhFVlBqM0h5V1B3cy9MbXZPSTNTaW80R1ppUDkySVhqaVAxRmxa?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8454ada-16a2-4860-1113-08dd8bde008d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:06:16.8645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmefJM+j1THd+S2tROaycMGSc486ipt+PwWF9MXpc1SU/kgVwgWEQd8MaHB58Z9UOZBehMJpzoEnbt8ICuqIz7lj2xXrqkZ5BC4+pF+bA98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
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

Hi Kever,

On 1/31/25 11:31 AM, Quentin Schulz wrote:
> While testing some WIP work done by Ilias Apalodimas on guaranteeing
> read-only memory areas truly are handled as read-only[1], my RK3588
> Tiger couldn't reach U-Boot CLI anymore because of the pinctrl driver
> modifying a const struct rockchip_pin_ctrl, triggering a CPU abort.
> 
> Instead of going the lazy way and unconstify it, let's fix the actual
> issue in play.
> 
> This also means we should be able to constify the private data of the
> controller device for all Rockchip devices, instead of having those only
> for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
> patch series[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all
> reach U-Boot CLI. No further testing (like booting into Linux userspace)
> was done.
> 
> [1] https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Gentle ping as I don't see it in your u-boot-rockchip custodian tree 
right now? I see that you added your Reviewed-by on the v1, but please 
take the v2!

Cheers,
Quentin

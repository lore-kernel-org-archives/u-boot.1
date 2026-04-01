Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9840D35157
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 08:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE5480517;
	Wed,  1 Apr 2026 10:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="ddN3tPoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB1983F5B; Wed,  1 Apr 2026 10:01:11 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ECE980077
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 10:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R16n+gu7GtrPys3GuuvKbwQ95oubl67DpJdzvU0RZy62HZkw5lHs54LMOP68qMd38K95VTB4sX1FQBDbpSw6tABGrNA7tlPsc/rJColn62rXHSCtRyCNOt1f3fNkVlaI390Y8izTIsF0Kc48LyqfivGVa5B3h4AFSJvlc+JbY9CmlmSbiggRQ/EoK/049w6PG3MNjkOX+6y8D8cqYT/cS6EXimDLA0t4k8RbGW6ZE9J3FVbPG71EFBI4uBtE6NlMeMQc0jy0b+WBwv6J8VpSmDuIFogFXiWZU3bwFnE+C0UcDxKCRnTDy3OQc/HwjkuuM5vm4xXg/pRTIFQaSKcKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tEXQykmBO4Is8++YsFBBCFZuSOjc9W8VnoQOFfOl/M=;
 b=rXeqEAIrzLZykgTyGE3buqy1qv7BEruGds2L/+tN3ZgeI1LXLvofgyM1ZpmzRd1tDAOtdkKo6YJBcMbXBZbOV5NTFtuirGVTDskZ8Ow4IodLpxeL63+tKTHHI9LNMlbXuZzmcvVcE94vDc/0TqXU8fEyTUc1HvDlobKqsTSB1r2ofzyKFajFKFlXRgF96kI3+hD/L8w9or7n9QjaMpifHyiXMjV+upk4Z9cDU2XGEhrrYO06OLOakXeAH1+JMGB5WsbBE86y9HdT69OcksPU+Neh8+2d+f4b45SZGllp8UfaGHfvp36gMRoi3m+unKnZSvS0OGrzU8fRAZzIYiZXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tEXQykmBO4Is8++YsFBBCFZuSOjc9W8VnoQOFfOl/M=;
 b=ddN3tPoUG2VbcP6mlUM6uvpb6tbvssvqVjZRom+YAL/zHv6P4bbgtVrZgn5OOaxkFQC7nRmlrQoA/Lrq0YMqVq3aVqqzCZH3tgzLxN5GPO5SwSOtfZWtJ8sMxwULmBLj3cShozOzYVZXyhtrkhfPjgPdAHVEPIXIRmeYbTtRITk2iMevaBttOvxNJsSWF/tQ3mBrjYdZ79XEJOulKEZFDwAX8fdNXNv9n0wVDBv92hXW23RBge50fTedJMfvZiu5DKbttv3p3eYNB1cviyl4r37v8z3GlqdGuxWHU6bZFGV+xw4yvD1YAJJFOPSijyBuayDh6fJ7o0DtIZJfiutWew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AS2PR10MB7686.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:645::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:01:01 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 08:01:01 +0000
Message-ID: <fb79593d-3017-4169-a91f-85bf265c6039@kontron.de>
Date: Wed, 1 Apr 2026 10:00:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Teresa Remmet <T.remmet@phytec.de>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, Yannic Moog <Y.Moog@phytec.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 Leonard Anderweit <L.Anderweit@phytec.de>,
 "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "matteo.lisi" <matteo.lisi@engicam.com>,
 "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
 <acnemXvnI7Ifs3Xp@shlinux89>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <acnemXvnI7Ifs3Xp@shlinux89>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AS2PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 468ac665-970b-4508-3f6e-08de8fc4d08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /ZBbDxLbXxKrxOu6A+BiPB051jmRknE9GDd1VRWf4ZBRxNnfNlflVPa3Dl6/Qn4PxD10D34Frca6CQzikNPjCMAbYR2c92P09XRS0Pvxm8LP2pMtH9OtKb5c8HLj/oVTBiiHHnrZ0g+YF+Q21lC5BgxOJs7Pkf1VZmnjx85SOEWeZH3ENxxL9hdcQIWKhJz+VlPYVkpA+MOc41zN0oZ9rqoHpiApCS6mUNvHQ4I+xllaNlyexz3v6yLvOJBqJcqKm2zNO1gfSL91/QwOjTVuMkJjzPZXvXj0FaLfxPs4+g5MPueyqvH/qo4sxJiIbm2m50PxQVZ736srX7U8GiIRD3zjdRM5UwA0NKfzNilbgBi4ZEQSm2voVTqf2Y0PWhaIXgB+MQt0YMvasn9MmELJnITvEkal/7X9I4w8di/DkoF3tI9GhLT0vHZR2NE/f2Lecv+87QgziiF87SZ3KgfFHXYRDCcfTa43blni5fuwIhbYvOHaQMbQ7zt6aPQi9tb6l9K9MsiNk9NhuI6kKmEAMwGN1sQAUfbepOgyf4EL8kDgnz3gFVisT24CYFN+MJGBa7p5UTzK/2tl2Ifs4kqAUkcL1fdZCsuKXrsDdnq7pIFf6qw5Gj2ua1k+EBDGof9CFGoP7GX/6I6C2A4SoCF7beg8A7T+AIUHKLdwYlysVtIE5tk/F4Smusa/fBB8NHqZI/3aOTb7a/bM8jRqCVWzfaeYQPKmPGld/ZXFwAUw0hA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anYrR2lueTV4cFlVc0JDLzZEK0NSK0JvYmUzYW83V0FLOS92YzZ3N1ZFaXhF?=
 =?utf-8?B?K3NkOWNxV3ZpS0ZRMlc1am9vNVIyd2RhcnpUVWdSTHZnNDAyTWdTTEFUUU9I?=
 =?utf-8?B?aW1BSzdLNVpYVkUvNmpkMGNjUnFjMThzNDdCcXljT1JYU1pBckhad3ptWTNm?=
 =?utf-8?B?Wk90Z3BSZWpWb2Mwd2VQaWRDNGJmcGRYcUZicGlydHlTaCtxWnNKR3VRMDZa?=
 =?utf-8?B?WS9tMmg5RGJOTWE3SHY1MmlGYnFCa053Z1MrdmR5a094bCtnaW9uL1duUUQx?=
 =?utf-8?B?UDhpWUN4N1ovTVhaYWxRUlNsQkxzaWpNOU1KWHlvMlFIdmV4RUVGRHBkditr?=
 =?utf-8?B?NmpHb0pmYm15clVaMHpPbmNzMlhCcWhRM3hLRk5NRHJjdjhJZUhyZytLeWRr?=
 =?utf-8?B?dWx4RU5oMEFqUU13R1RhUUpidkNqUmxCM1lLN3lxbHVxMTJzSE5sSVd6WElV?=
 =?utf-8?B?Z1o0Nk9ubnI4bFFSeUwyd2FOWjczdzFLNGl1ODVUdDF5aWk3bDlneDcwa2c2?=
 =?utf-8?B?UHVyeWo5L2YwZTNHYjFqSGlhbGtpcXFQTTBadm52MkxFZ2tGVWVOa25DQ2lO?=
 =?utf-8?B?OE56NmRFMEFpQWozRnJWWmV3d1Nzb0M5d09RYUVsV0w3UVViM040M3BQUDF3?=
 =?utf-8?B?RnZKeDl4Ylh6RGlxUHVPSGN6alN6WFRncmhPSkZrd1dlN3luQmRtLzUwMHk3?=
 =?utf-8?B?RkZqYTMrY1RtenJtaUs1Tlg0VzU5UE8wS1UxUFlEdUc0bm1JWUFlZFVBdTNB?=
 =?utf-8?B?TEtqTHZrYkI1b0RjZ1VOUnlaeFR0UEw0OENQQlhjQkpHT2x6MDdsU2h2RUNo?=
 =?utf-8?B?Y1JmMmluOVhnQW9pWm1SLy94SWo1cWdlQkZtY1pEWGNZZEViNCtMTTNpLzgv?=
 =?utf-8?B?L3ZZWDIydHZVekhOb1lBaFQ3bHQ3VmpOaTV5cHZ3RW01aWZMZVVyOGIrMEYy?=
 =?utf-8?B?dGtmU201eldsQkJjQWw1UysxcUxUcVlqOW9HVUFFVjJXUWZsWWlhYUozazc2?=
 =?utf-8?B?bXJBU3BiZTh2QnpINjAySEF2Q3g3eHpyMUE2b2hqeU1SSTBvOVkxSEZ2dVpE?=
 =?utf-8?B?ekJZeW9lTzBIMDU5SjMxc3BHWmZoT0RLV0l5cnJxSXdnd2RSYlEwaGZZYVRx?=
 =?utf-8?B?a1pISlVudk1vSGw3RmdwTmRKbVhaNWpkZzl3ZUtuRzJCRGNiQUVJcFdBRDh5?=
 =?utf-8?B?cnRXckVWK21FSHE5YWZ1REVCY3FlV3cxVTBVWnRSQnhTMW9EVGNpY2hZL2p2?=
 =?utf-8?B?RHZzM1N1QVQ1WTk3RzJRQlp3MWJQWWNiY3I2ck9WbHpaL3JnMFRDS2h1cDJM?=
 =?utf-8?B?bHlqL21vTFFZem56R1p5QW41NlVMWVFzSGRqYmc2QVA4bEZZU3FISXRSOVlB?=
 =?utf-8?B?S0R5QVlIVEhaZDk1dVFmU2RkcFhURlpxT3REdXUxU2dhVjhlTFBFNGpFVldi?=
 =?utf-8?B?SUhMOTJkc09PdkptSjdzUEo1WFM2OEFaeFhWcFJRak1oUE5MdVlYNWJHQ01G?=
 =?utf-8?B?U0xPMm03dlliYmkwY1FBVGFCYnZlSzRYVmMrcmJTZXMvOTJycURKdCtpTjI0?=
 =?utf-8?B?VEQ1V0ZGQU5ncHc3UjJlZVd6Vm9LNWlUbHVQTmxqUm1tNys1UmZXR2VkY25G?=
 =?utf-8?B?UDljSTZISU0yTHRXK280V2YxUW5EN09wNmRxaS9oeWFoY293SUVzcUhYdU9K?=
 =?utf-8?B?QnRDWkR1aFJ2YXM3dGs0Zm5VNThLSVNzclI0Yko0aUpaOVhHeFc1Z3BlUUxt?=
 =?utf-8?B?OEZaNGkzR3c1MkdZWCtYWUl1d1FITFkrU0djQThwQ21IenFUR2U2KzJLMFA4?=
 =?utf-8?B?QXEveTkvd0NCOE94WkNraGxTLzJNdHl6UXpUM2pOTTZFdmlxNzZaWTdrWno0?=
 =?utf-8?B?a3NDdkkxY3dZVkNpYllMM0kweG90Vnk5c2M4Z2pzbE1yeTJQNlZLT2pMd3lO?=
 =?utf-8?B?SWVma1duVmJldlpONjZuYjluQkt1dXRMRURvd0VxK1BDRmhRVGFkSGEwUkpP?=
 =?utf-8?B?eW1zeXhEVVZlRkRCLzdIZmR6YnI2QytYRVl0SUJlTElRRE9GQjc2VEJnNUFB?=
 =?utf-8?B?QW1zMGtmME0vN1Eya0RqT1hOc0FwUDBTdkIydCtmY3VqL2FYWlRwTUR2M0cw?=
 =?utf-8?B?K2NiOUlsQmJ0cVBTRGE0S0FQbkdnUC9xaGNZdjNiNHd4eWJTaUxMb1pqM3JD?=
 =?utf-8?B?RkJpLzcvYUlvTWdyUk51UndmQW1QWEpNWUo4Y0dtczMzTmxUamFoZWpBMGxs?=
 =?utf-8?B?TW1LakhFZDhqajMvUS9YUm53QkRnM0JmYk5UeGV3b3dZcXBvOWN3OVc1R0Qr?=
 =?utf-8?B?ek5rTER6V01NWnMwaWJINGJQL1BOR0x0aDhlZFY4b2lldEFxU0xVaUxtdHpq?=
 =?utf-8?Q?BW4t3KVhrl6pziwE=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ac665-970b-4508-3f6e-08de8fc4d08d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:01:01.0040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/lJR6qYBhMFC0thIRHP7mZ9DZZSsgHYaKsAhlOXOd0AliBDsIT/SKfL0QuNs3iLSkA8Wqm3KUNH+CsF+tcjT8gNSYEY2Sg7UYX6JEu+QZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7686
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

On 30.03.26 04:23, Peng Fan wrote:
> Hi Frieder,
> 
> On Wed, Mar 25, 2026 at 08:40:26AM +0100, Frieder Schrempf wrote:
>> On 25.03.26 04:50, Peng Fan wrote:
>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>> DM_PMIC
>>>>
>>>> Hello Peng,
>>>> Hello Yannic,
>>>>
>>>> Am Dienstag, dem 24.03.2026 um 13:33 +0000 schrieb Peng Fan:
>>>>> Hi Yannic,
>>>>>
>>>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>>>> DM_PMIC
>>>>>>
>>>>>> Hi Peng,
>>>>>>
>>>>>> On Tue, 2026-03-24 at 18:30 +0800, Peng Fan (OSS) wrote:
>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>
>>>>>>> Convert the board to use DM_PMIC instead of the legacy SPL
>>>>>> I2C/PMIC
>>>>>>> handling.
>>>>>>>
>>>>>>> Changes include:
>>>>>>> - Enable DM_PMIC, DM_PMIC_PCA9450, and
>>>>>> SPL_DM_PMIC_PCA9450 in defconfig.
>>>>>>> - Drop legacy SPL I2C and PMIC options.
>>>>>>> - Remove manual I2C1 pad setup and legacy power_pca9450_init()
>>>>>> usage.
>>>>>>> - Use DM-based pmic_get() with the DT node "pmic@25".
>>>>>>> - Update PMIC register programming to use struct udevice API.
>>>>>>
>>>>>> these changes break something.
>>>>>>
>>>>>> Getting
>>>>>>
>>>>>> Loading Environment from MMC... Card did not respond to voltage
>>>>>> select! : -110
>>>>>> *** Warning - No block device, using default environment
>>>>>>
>>>>>> and SD card is not accessible as a result. I also worked on this
>>>>>> modernization and got the same result as with your commit. Have
>>>> not
>>>>>> had time to investigate the cause, yet.
>>>>>
>>>>> This change should not impact sd, unless pmic not probe correctly.
>>>>> You may give a look on "regulators", "pmic" in U-Boot shell, to see
>>>>> whether pmic is good.
>>>>>
>>>>> And you may also need to confirm, whether SD works or not without
>>>> this
>>>>> migration to DM_PMIC.
>>>>
>>>> I see the same issue. The error is gone when the patch is reverted again.
>>>> PMIC probing is working but the voltage change of SD-Card is probably
>>>> not.
>>>> We have set
>>>> dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi:
>>>> vqmmc-supply = <&ldo5>;
>>>>
>>>> which references the PMIC.
>>>> The evk is not using this property.
>>>
>>> I tried to add vqmmc-supply for i.MX8MP-EVK, I not see issues.
>>> Not sure why this property impacts phycore-fpsc.
>>>
>>> The only suspecting point is 
>>>
>>> -                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
>>> +                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0x1c0
>>>
>>> No more ideas as of now.
>>
>> I'm pretty sure this issue is related to the VSELECT signal in some way.
>>
>> With MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT being set, the SDHC
>> controller controls the VSELECT signal that goes into the SD_VSEL input
>> of the PMIC and switches the LDO5 between 1.8V and 3.3V. Internally the
>> PMIC uses the state of SD_VSEL to decide which one of two voltage
>> registers for LDO5 is used.
>>
>> When vqmmc-supply is set, the driver additionally sets the voltage by
>> writing to the PMIC LDO5 voltage register. This can potentially cause
>> conflicts and lead to an invalid state, where the driver thinks the card
>> is in 1.8V state but the voltage is set to 3.3V or the other way round.
>>
>> One way to handle this, is to set the SION bit for the VSELECT signal
>> and specify the sd-vsel-gpios property in the ldo5 node. This allows the
>> PMIC driver to know about the current state of the VSELECT signal and
>> use the correct voltage register when setting or getting the LDO5 voltage.
>>
>> Below you can find some pointers for additional information. I hope this
>> helps to solve the issue on your board.
>>
>> Best regards
>> Frieder
>>
>> Relevant U-Boot patchset:
>> https://patchwork.ozlabs.org/project/uboot/cover/20250811131213.211124-1-frieder@fris.de/
>>
>> Relevant Kernel patchset:
>> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/
> 
> I think this kernel patchset might be wrong.
> 
> GPIO1_04 is muxed as SD2_VSEL, reading GPIO1_04 will not able to get the PAD
> value of SD2_VSEL.
> 
> I also tried in U-Boot on i.MX8MP-EVK.
> u-boot=> mw 0x30330024 0x11 ==> set SION and MUX as SD2_VSELECT
> u-boot=> md 0x30b500c0 1
> 30b500c0: 2000780b      ==>BIT 1 is VSEL, already 1                       .x.
> u-boot=> md 0x30330284 1
> 30330284: 000000c0                             ....
> u-boot=> mw 0x30330284 0x1d0  ==> Configure PAD
> u-boot=> md 0x30200000 4       ==>Read back GPIO1
> 30200000: 00001028 00000000 00001028 00000000  (.......(.......
> 
> value of GPIO1_IO4 is 0, not 1, but VSEL register is 1 in SDHC2.

I think you are right. I probably misinterpreted the documentation.

> 
> So with your kernel patchset, reading the voltage, it will always return 3.3v.

Not really. Reading the voltage in U-Boot works fine, which is why I
thought this is correct. But I probably also misinterpreted my test
results, as this only works by coincidence. We now always read from
LDO5CTRL_L and this seems to have the correct value even if LDO5CTRL_H
is actually in use.

UHS card:

=> mmc dev 1
switch to partitions #0, OK
mmc1 is current device
=> mmc info
Device: FSL_SDHC
Manufacturer ID: 27
OEM: 5048
Name: SD8GB
Bus Speed: 200000000
Mode: UHS SDR104 (208MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 7.2 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes
=> regulator dev "NVCC_SD (LDO5)"
dev: NVCC_SD (LDO5) @ LDO5
=> regulator value
1800000 uV

HS card:

=> mmc dev 1
switch to partitions #0, OK
mmc1 is current device
=> mmc info
Device: FSL_SDHC
Manufacturer ID: 6f
OEM: 303
Name: CBADS
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 3.8 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes
=> regulator value
3300000 uV




Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C562103A9AD
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0008405B;
	Wed, 25 Mar 2026 12:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="VcZcCTue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8755A84088; Wed, 25 Mar 2026 12:36:09 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431AC84020
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2fRuUq9C2jrGGWvciPcCKI9pOy/zFCs2OBn1q6m/Se6FjTgMUrrOrheGbBunJj6jhJ4q7WkAbv+g0nwNHvOjyIx3S5VemsBVkim5sMR8XwTENLGEOhUmn23cYpLIGx3zLGAJSrdBHimE64N0ZA3K8SgTX9aU7OpFUZzGJiJJBc29YbgowNar8pAkR1hFFvXjWpIKVZs/u2RnV7IpKuX6ncfp0vQ62/fWvWz/USp7yRF4p5y1IDrcwHjMAzMzEuuQXpil+vjhkUhPJYSsNJtA0qHTCsxw5/rCtGu3mpqnLAEe19ljjAHQXxGxF3X9jneS2tFMGrFeVgmvRz31kcoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV/ICPhotZgYTPSaQ9VgDSZjmXTejTGsjPKdt6PTGx4=;
 b=mK0bdCQVty7ekkbE93Qk/k/k0TTu4jaFAZ1ltETCgiIXZe9yT9Ps99dIL0/wd6kx6q30UDFu69/r5JjwyTGuKavbAgwDkFI0Q4Le/dcyssybVMw5DigSj0tdC8gsBr4LmwsLCbX2ccPatyfvbTBYWY8EsgdrbmpIWlwyX1K8qRmzccmfDzDAjqv/zTp5+VKdQerSKBBovapuIxQ0YlSExOncx4iRtx5+/MxC3cz/7ioZ5xJlUbVqJPDTjI+wDJVmsY/6a4pEife0Get+YNR4QQzsEd9EZd9NjnIl4kySgpyXSQj0ntYcnOIfaPWIJ5iEdhaTLsMYDwhaOBPzxbk4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV/ICPhotZgYTPSaQ9VgDSZjmXTejTGsjPKdt6PTGx4=;
 b=VcZcCTue3PYLEXBdPX1oepNBajHTihXdUJCy6qOozszK+hGorH/3pyRsgNrZm7LNjLAcnN6JgQZYRSH+j3bTHfeDMoNNh7/g4G+QJRwatnrNGtwSQmhkNhd1f5Ghy4lyXel7v8wTUodZoM7fmmFZTpBRCvOCfP/KLJoSnMcOS//aVLhWvcef59JV3bFneEOI7ip2gcXkG6MEt7B4HybGtvwQk7ZRLRfcuSFpRjCucmJBMLT9uqxSxapkgNq6+8KHvBsapuCEk33x7dV38keHHmNCK31Q6d2UiASRo1ttSLI1kwktFhul8kfnK6RKis9b27kfEnY+BgeMxE5LRqlLoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::22)
 by AS8PR10MB6340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 11:36:01 +0000
Received: from PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6aec:a389:7814:860f]) by PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6aec:a389:7814:860f%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:36:01 +0000
Message-ID: <d10bc263-3129-4504-acac-e751c0f8e3c3@kontron.de>
Date: Wed, 25 Mar 2026 12:35:59 +0100
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
 <acPDFUn4R/nsQcg0@shlinux89>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <acPDFUn4R/nsQcg0@shlinux89>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:97::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4288:EE_|AS8PR10MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: f8527965-39d1-4cec-1989-08de8a62b0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: w++m2zBrPINbwooNJX90Qglr6pifKfnoZY1rR8QwiENxOZqgIAgMCfwKjIpvSAdiftYc+SApV46k3AjhC4YnPv0tF2vLZmvchR/AOMSugygrbpfyeBqiiFhl2q1YDomysyBkhbyZFIflkVtnw10gaHUPBKNH1Xxh4eWUR1JU1yFM+FJq7ltm03RKuB47A3R1zJv0gFCR4JBHLJXzeu/ZUnCNA0AfMbj6YQverP8zzVN8D4ktAm5hhtVdyl51MyiRCHcswksLKxnsxm0Sva2zZPglF778n4uPMykYSVoER3FLwtzxvd6jQmcxBM+TaATwNPbJ5kg/+iVB1pvKfUG21QLOUnBKI1FpfHA5ro+WB1L53p7ZXGhepjs3WIkep01RqmulnClq06EwJlSecY6LoCyoZnTPlmZDr4UuZCFSoQsP8VZppVaYWzCGFEIG+9Lc3MIJtgmjGFFqqfM6p5gqyEECfLNNc5o3xefN2VLEcG0FGroF5fuS+rffbuwm15mE/TY478PGCyBUFXC/pIShmBFd1dmsEJScozzzoq20hIVUSvjPAc6LhM0Y9nLGEPC0VeiQcpfdchCNKjKRXYNqatn5/jZ+twdgmJTH3THvKmCFlBA1x5+4btK82PH88jdyYzv2H+T15YL1B9QFGaXqpkBZxrA672bK30eF83pPg9Jyb1ahkgT3xgulXL10cFeJ1w6SKAX+Bwgcb48YacEmQFKizhRf3x9SC2WUjKO4Xgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFWSTM2VnM0eENYeFhldmFycUhwcWNkSmtFRjU2US82YjMvMzhacFBoUmhj?=
 =?utf-8?B?c1M5TkVNKy9XWFhGYjdOTk9PeFVNODlSWjQ0ak5IMUc0bWp4WTRYTUgrclFQ?=
 =?utf-8?B?emZGTEdkREZhU1ZTMk8rQ3RkLzBGNmx6S2JiWExDSGRhY0FlZlRha3ZZV1Nt?=
 =?utf-8?B?Y2FyQUNvRVA4MWV4akp2dHhacjBNRzUzai9nUjlhUVIyemg2WHU1alZDSmhz?=
 =?utf-8?B?ZHVsM253aStFY2R4UE8vSk10YXlUL1JteDJIZG03c2FSK2cwa3NySlhQUk9D?=
 =?utf-8?B?Zk5FUGtBYnlNREt5b1M1eEg5MjFOd2xWcVNrSGhPZG9ZRFhpeHl1cnpGVUdP?=
 =?utf-8?B?ZDBnbnpwejQ5VkVueFN3R1pheURQelhkSTlNNXBaK01uYUJyQWNLRDFXdDFR?=
 =?utf-8?B?RWhYa2R3cDZMUzlTT3JGRjhCMHBGdE1BYUx2SkRHWk9ZL2htTEFzMmNkOWRZ?=
 =?utf-8?B?VVMwVGs5N2o5K0lkWERKN0h2aThEdTRWV2dUUU45UFEyUGhiRzVkS2ZLMDVM?=
 =?utf-8?B?L3ZnQ2l5bTB0dXAwQWNHMWZZa1ZOUTFZNi9WWGRvOXBER2JPSWZ3dnNvWFd3?=
 =?utf-8?B?MG4xcHlMU1NWSFk3Mm9IMnh6WmdnZi9vSVcrQ0NZVzNTSFZvd1ZXZWluL0U4?=
 =?utf-8?B?ZUJNUXl5Sy9XRjBDYVJkWElCbU1UNTBkZU5va1FpSGR0aHpLUWpBVEhVZEpu?=
 =?utf-8?B?eWZOem1GK096ODMyZXBQWXk4RWw1VU00MkpmVUxYOVMrTVQyZG1ET0tiZkRn?=
 =?utf-8?B?c2g0Y2l0K3kyK295RkJ5c2cvRjhyTXdweWgxQ2gzNzk5ZzNmRTd2LzNJZzRE?=
 =?utf-8?B?WXprNk5QUmw1ZGo4NWViWW4rQ2RwbVBsZG5BOTRiTmxzNDVWT1ZwdmFjWml6?=
 =?utf-8?B?Vm5yK0NNNkhGOGpVYkdWMW9IY3RZMjdXem5wQXdya2s5Q2lQb0U2MXk3enBI?=
 =?utf-8?B?aXhGRUorUHM5N0tab0FKemYzMlVzVTVBU295SGUwdHM4cDhKczBzdkd4THF1?=
 =?utf-8?B?U1BLcjQranhwcThMdWhLaktZdk1RYzRWTXI0RUFJUGVJbllYUFJmRnRseDlz?=
 =?utf-8?B?Q1BJRFc0a25WV2xndGg5em5EM0pRcjVEWU41NWRZOXg2YjVkamt6M1B5Y1ZF?=
 =?utf-8?B?a3h1aTZ2NFRyMUlxeFUvT0ErZTZIMmFYazhQTWdNQkhZZUNHcERqTlY1MEpY?=
 =?utf-8?B?cS9Pczh0L2cxWkZmS2M3ZjB3OUlGY2ZGZUM2eTNxdmNYenFMQlkvYkxxVzMw?=
 =?utf-8?B?cjFDeENWeUJYcEdjaHl4Y3Jua2V4a1VKUWppK3BGbnJpcXNZSDEwWVpsVmhV?=
 =?utf-8?B?c2gxVmNtMmEyNFJNQVlhL2F4RDQrZVhqVEdsLzhMYlNaZGwzTnY1cll5ZCtj?=
 =?utf-8?B?Mmd3UXZ2dUtYazhwQy96dEo3TElyZ3l2OThzdHVMVTBnNnV3S2piZE5MSE43?=
 =?utf-8?B?d3JYamVWWmJwT3c3QkpKUldmTFNQR0hrK2lHSytNRlJUVVo2MnVjcU9uVU1q?=
 =?utf-8?B?U1YrdThzckYwQytFQUdpRkdLVTFwc0IvNFI4dU1DWEUzc0hOVzIvblg3ZUJD?=
 =?utf-8?B?NDA4VVVvOGYxQ3BON0JlbVMxV2JvbC9iZzFNenJMV2IwR3F1a25FNWV2NDYy?=
 =?utf-8?B?TGVyUk44dXpZQ3RubWs4Z1hEcWtZcUpPT2JBN3hkbXExdm1tRnVmTHg3L3F2?=
 =?utf-8?B?WjRFMU9zU01aRmVEb1FrbWk2MFVCY3YrVUY2ZmxiNE1XR05jY0FPcDhCaEZW?=
 =?utf-8?B?NmdqMHZlRnJ2VmFLOEdEcWtzalpUQ0hZSVl1dy9TU2kwaEo0U0ZKcktxVnZh?=
 =?utf-8?B?NEg1d3hObnVacW91RlVnYWNNL0dCVXk1anl6Ylp5MEtmaVVnRXUyRXRVdk9p?=
 =?utf-8?B?U1F2SWpJcEZ4ZnVpK0FGNDhjQ2NwaDRORXFQeVFidGFuNTRoZGtoME9VdUhP?=
 =?utf-8?B?VjJVOG5MTDIydllVNkpKTCtaVUJFelptSUJyRU5RWkowL1ZaL1o4TUtJbWlH?=
 =?utf-8?B?R1ZHc1V1b1RPTy9Hd29USFVTT3hoM1RBT0VXcVpiNy9MdCsvYjU2c1pwblE5?=
 =?utf-8?B?YTVtdzJpWnNqekhURVd0cHB1Skg4QnJjOS9DY0NuTjkzSnlTNGpNcXZSb1ZM?=
 =?utf-8?B?VXNqdmhBYmZqL05vNnNMdXpUZ2l3SFBFSmhTZFJEMTR4d2xKYnlPLy95MEMw?=
 =?utf-8?B?SWxCbFJicGN0VGtyTFVkQnhmVE5CWDBRL3dzcDVBZWtnN1ZMRFJ1SDczYkFY?=
 =?utf-8?B?NXIyVUJMOE85SDlUNHlFZnhTNGphKzVzVlhNODEvSmRvbkFVRkNKUlMzTXRP?=
 =?utf-8?B?Ris3ZkRtMHJHN0VvbGtNMzFuS0NaMjc0UXdMUytqT3FpWTd0VjRPQ1FIZ3hJ?=
 =?utf-8?Q?VfKT0nqJI+nA7UOU=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8527965-39d1-4cec-1989-08de8a62b0da
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:36:01.2910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCAZGxLVbydz4/Oh743iskSeDT96itHoSMhucx3qFLBRbr1KMoRh6Ut6NY8cmRE0DBcCffP4GHADdIURlpZiGPCI5Ex11rDDcKZyXnORqUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6340
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

Hi Peng,

On 25.03.26 12:12, Peng Fan wrote:
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
> 
> Thanks for the detailed information. But I still have a question:
> For current phyboard-pollux-rdk, vqmmc-supply will always use
> PCA9450_LDO5CTRL_H for regulator value configuration.
> 
> In drivers/mmc/fsl_esdhc_imx.c, when configure with 3.3V, PCA9450_LDO5CTRL_H
> will configured to 3.3V, but SD_VSEL is low, so no impact. When configure
> with 1.8V, PCA9450_LDO5CTRL_H will be configured to 1.8V, and SD_VSEL is high,
> so it should work.
> 
> or I may miss something.

I think you are right. The process is the same as in Linux and I never
saw any issue there. Just the fact that when reading back the voltage of
the LDO5 regulator in Linux or U-Boot you could get a wrong value. This
can be fixed as described before.

So I'm really not sure what the actual problem is. I remember having a
similar or the same issue with our Kontron boards before switching to
the upstream DTS with sd-vsel-gpios. So it might also fix this issue
here, but of course it would be good to know the actual reason.

Best regards
Frieder



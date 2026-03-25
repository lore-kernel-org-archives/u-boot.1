Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABB0FEA82E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 07:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB428352B;
	Wed, 25 Mar 2026 08:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Rm9wYxCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61DB838BB; Wed, 25 Mar 2026 08:40:34 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F267981E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 08:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcse/IYsHQ9Xd5qfxmXyiFamU/LX+MLJQv7mwllUBiA5bMfqkRRiM24KWIcRbBCBFZuWbavqPBZNNXtcDQ/7d6/d8iN6Ya1j5Uc8dXAKylaSuXipWQV0vv4E+OL51tJcYYmVftcVUO3oFVT2ff5cyWDne6hB40KYTxKh+6Q4/w8sPXZFSRsXXqAonSinyAFliXB07QNRAyV7K8eo+EIvX8X71UA3UCRBE2/4GjEnsbWRj3dHiFovCTyvJ2lUdVpjK+BsHg4FGwa71DjWfTqZr4qhIgfiXgJ+iLCL6gL2YjkHSCWwY+ZRL8niAZF5kQ+H5EX7jbjjETrwAG+wojAjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o63acYEa7OwCjfHvCKlceGs9MLcYHEDp/oa34VC+Rc=;
 b=YfkIx2zLhJy+idIGf3f5m8mUolCbD0sQKr1XFel2gjVMYmIJPsgeebZdxD9UV3nafXP88RNNFJT8aPCMnnokh/QfvS/2D8UFZ/vzY64kJIeJFivccCwX+CcDdIv7CRCHB6p9pZM76fCCLU23Cm6FiUqXRhZaEZWfMz/gRC41yqTGAncWcmO8W0l5uMXblPzrV/vvIL1PzvZWSyFQiAF/EIl8113rW7aCiJfVCdrZVPkr27O+KSJt9q657tfCn4efwnLCl1kSg7raJqZSWMzkECCKgH29Zb4B13MNhQkhIpHPot9MJrXV8z8jw4enueOc1NrmifO8zhrAswKDnMe+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o63acYEa7OwCjfHvCKlceGs9MLcYHEDp/oa34VC+Rc=;
 b=Rm9wYxCvZ14+kOy7o7nFYWawrglFuvvhVCcte9Xfj+5pwLwkKLz/KbhXlsUM8BhVPAQwUPB8nIS7a8ta/t+uF8HRgjcbsmIZ/Kr5m6tUfDN1QTkFz/jNWvdY4Xy6cQv42gPQhrhf86YiqZ7OlK6v92bSvAWRpmKZ5G3ai60onFIj7BubvbNYoZG++kFXba79VTODkqgfRODxI0uJQRZWI3uI7bruR7vzTDdptcJ6MuCf3BBFMnCRRNNXyIXO+xV3Ui9+yR0I2ufOCtMaaAp+HMetm9Ci+nX/WGgiz1FE4bmu/F/4uILKonoI9KhfVAXwvx1gNB+HcRzWE9i5vYPgbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::22)
 by PR3PR10MB4016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 25 Mar
 2026 07:40:28 +0000
Received: from PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6aec:a389:7814:860f]) by PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6aec:a389:7814:860f%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:40:28 +0000
Message-ID: <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
Date: Wed, 25 Mar 2026 08:40:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
To: Peng Fan <peng.fan@nxp.com>, Teresa Remmet <T.remmet@phytec.de>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, Yannic Moog <Y.Moog@phytec.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
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
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::19) To PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:97::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4288:EE_|PR3PR10MB4016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3b02c1-43be-4362-0731-08de8a41c89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|7053199007|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: jMayMQ3TidWirsQvsp896waBtMeaMCDHEEtO8CuphGWhqwgJjNsVF9/6571Mv5mxYAMfifSW2qiHDgfr9QknA6eU8sTTX0HCBsv37xTI9qr12c06YF/Qj0zXdhmmv4EVOf90oUEoVG6yxvCrFS+DTxkUHYLB5cm/MBiR6PMvBIHEJU2bb24VIRxOgIrnYN6CMDynv6qm/8oGy/uGcfwJEvBKtb7Uoma7RKU9ZOWtB3kDCUN6h6pwJ0JCgN3ht06Rg3MJlm3Q7BoeNjfU1Dk7LyyIHrvoRGQtkWhTQw7eiq6t3TXGNY4kzAoNT3F1shE1uJkU9Uh/bTAw7Zi+3KuatGZevuvzMHw79bltrPzrToqI7jky7VJQ+0VAwvSlbpbximxSC5yHJ72PNJB7BWHi2bPgh4Kz3xHSgUudqGgU0fZdVyxPa/FdgV2CEQ1FT2EwPtNKrofscdu2vZB8GfhLeNVPo9dRJt+BK4a0qgImQPBkyAShuKjbtXHzrHVlAZqnrKRh3oD+MCWGwnlUn1z+LiG51ZS9kcJQNO+obHVUYX0QPYcsh7qz90qZXZ1y4N0Xy/8bNKj4wcu/ysECIKqsxh8OJ1LdnGtt68whuGStIqtf3GPZ2bTik0v6GojcfleF2RWCtNx7WHUPxp/Lcj6aHLwti9f1trdoUWH1OdhBSa5g518kcM7Q4qP7nt0Z5gMUzrzFxtGKf0R5yJfGNm7CODemND5fwzfd2aHCWxf2FyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(7053199007)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGcwTzVTa0FMeExEZ2FsWHNsNWZvVzBFb2YzdzRLdSthVEF5amgyUEVTVm1M?=
 =?utf-8?B?bTYveC9oMyt4ZzNCazhPM1pDbjdDL2tHZTZiN0xNT1cxZFhKS0xXcFB0QWdN?=
 =?utf-8?B?T0krRVRWekZrK0ZzT2FUT2FzNWFkWlJYK0o1TzhZRnN4aEswek1mQmNpOGw1?=
 =?utf-8?B?b0xKY3RUUjFaUDliN3pDRngzS1JvU2tEVFBmOURCRU9INmFZRC81T0ErdGFX?=
 =?utf-8?B?RXVLamg0bVJib2Q4UkRSUmxhRUlsZ2RrdGV6dFN0d1JRNGNGd0RBRm9qc2FV?=
 =?utf-8?B?Z2UwaTRFRzQ5M1RoT1lpaGE4dnNOS2xMZDBGVW42NzN2a2p4SXowNkx6WVlP?=
 =?utf-8?B?d2NiNmZraDJDazNMU0p3bGNReHFncnhoei8xRHpmVFNMaEJ6T2hxQTUrYURl?=
 =?utf-8?B?bnl2TzlLeTBhUXRZSzN6T0JFZE5YN0t2Um5QMXV5S3JManJjT29OQTVHM3Fa?=
 =?utf-8?B?R2swRE4zRnVibDVHeGdFRUVTMjUydFB4OW5xbWpFM0JyVFRFejhhcG9paXJj?=
 =?utf-8?B?UHpNYUNuenBTOE8rdXdiZ2hXL3B3cTR6VGl0YldkWllLK2U4bmVBWlBiQkNK?=
 =?utf-8?B?KzN2bmZQMnJxUC9sbDhQclhoOFI1UUh3MmdRZ2g0YWRjdStDWEFFS3U2dDE2?=
 =?utf-8?B?TEFMaDJBSk4vSzJvRE43S1ZzbmJqUTgwckQrMXYvQ0VBSis0R2xwSkFCWFg4?=
 =?utf-8?B?L3lQQ28wLzlERTVkNkthS0pld0l4ZWhwUFBlaWFzeE4zODJVeWxlQmkvUkFi?=
 =?utf-8?B?RFZ6ejhPak8yaFNqNGQvV3BPN1I1WU1xQW1EQzdGcGFnczhSTDZDWFgrSXQv?=
 =?utf-8?B?Qk9mVDIvb0RiZWhrZ2h5am96cE9TemRzZ3ZvclU0VGhEVnRXMTFoOEVQYkts?=
 =?utf-8?B?LzVnQzR5RVJBbEpPQTR6cDBzOElmTld2M3FPbEVGdC80ZUpQdC8zdGVmUjlw?=
 =?utf-8?B?R2JJZk8wNVlFVXc2N05rSXFnU3RiMlUyZjVZWEhIQ2pzd05peUdBaFJFbHR3?=
 =?utf-8?B?bUtVU1hzRkJJRTBRVUZNRXlhRTR3c2poczdxSTRBa2VOL1hZSE12ak9ZN3k4?=
 =?utf-8?B?M3FZQ29Za01KaGJKdU1uM0NIQ21zYytuNmNUZXVLa01DS3ZlVEZhd2FNVXZK?=
 =?utf-8?B?aHpEbG9HVHVxbjB3T1A3YzZ6U0F0UmtDMFN2S3BjNGZsRFV6WktYVnEvcHVt?=
 =?utf-8?B?NGRLNzU1NWt2ZG5LYVFpU3hjbHNOSCs2TlhtU1IxWGdzdW1GZjAwNmVENytZ?=
 =?utf-8?B?RFRpQUJVa01NaVFDb0lzNlhidmlZcmtVcEY4Y3Z4MGVLYnpueUdvYjBITnMw?=
 =?utf-8?B?bnJSdTBLczhiTmF6ajYxYkUyTHV3RkJVc2dvM1VyR0Q4K2xvZnFZNGd4VTJM?=
 =?utf-8?B?ajdLTGdyd3VZNlVFU3kwN3g3SU9uY2FPeVdsL09JSS9iRGQxZWhCcHl3OE1Y?=
 =?utf-8?B?ellWb0J5dGEvREl2Q0Z3eTVseFJhRDkvTy9Dc0E2MUN3a2lOSkp2RTk0RndW?=
 =?utf-8?B?TVk0bHYyc0tmNWtHVmpBa05XaFZEQjZEUnQ1aW1qWnQ4RjlUVXJBa1pReHVC?=
 =?utf-8?B?Z3FmQVFnOTJ2U1c3YWQydnNGZG9yaURVQkRXYXBaa3NCMkxsQTJBVTB4cXFx?=
 =?utf-8?B?SjBTVzVSYlFvV0I0dURVM01JQ0F3SEp2OERnbjEzY2lZUXdtS283TTQ1N1Vq?=
 =?utf-8?B?MnI1WllITXBHazdpdXhDVGpoZTZkOHhKUEhISjFTN2QxY0UvZFVCQ0RDK1lJ?=
 =?utf-8?B?Snk3U1Zjcko1eWcwZklDZ1ozR2xJRUNsSjFnRVl0U3ZrZjN4WE9rcC9DRXN1?=
 =?utf-8?B?L3pRaGczK2RXUmJ2V2ZRa0svNWFXMU8zZnBramVuL3NUZWl4MUpmUmVudVBS?=
 =?utf-8?B?Qit3UU5vS0U5UzcwWG42dlFqd0FCZW9tcWY2ZkFmWDdmWS9BdWthU3AzcndT?=
 =?utf-8?B?YjVyVlFTZFl2Unlpcnd5WHBXcGlsZFFWRnJkQnc4UHBqSGR3TlgxZm0rdFJ2?=
 =?utf-8?B?YWZ5MzBrU2F3Vm0xcWdWTGsrTHZVclZuSEhQNUJtdjZXTko5OWRCMm8reE9B?=
 =?utf-8?B?bEdOM3FOYUYybDdKTUFyL3N6VEdRVXZhVVVTRnc4K0YwR3dQb1k4REFlZ29z?=
 =?utf-8?B?WjJqN2pMNGUvVDh0VXpIenBjdXBUNHJjZkR3dmNpN1YrZVY0TE15Q1RNakNW?=
 =?utf-8?B?UFR2eHMwS1V4Smx3MlYwd09weHJjUXdSQVdjeHRyMGNDL3JoQjV3enFCN3Fy?=
 =?utf-8?B?c0I2eTBQUTE1b24wWEIrUi9QQ2pxd0JFS0xaMHp6eFpIRkhFc2ZReEdHdWk3?=
 =?utf-8?B?Qy9IN1IzOXVjQzhRcXBjU2tuOTYrL3R6SlJIYmlaRXlEWmEreEE3T29Pb1hQ?=
 =?utf-8?Q?dKCRhHXlo1tql5Q4=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b02c1-43be-4362-0731-08de8a41c89b
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4288.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:40:27.8412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkq60DoWi4TeDnBkUaaoQ/zsGyY2KnKr+qpafMXCOmfjmRpOBnKdMmbEM2N7+LjOAC4lfHyN5KLAkc61rQROpnpKeBbjXqKQ3thlTP2EAsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4016
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

On 25.03.26 04:50, Peng Fan wrote:
>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>> DM_PMIC
>>
>> Hello Peng,
>> Hello Yannic,
>>
>> Am Dienstag, dem 24.03.2026 um 13:33 +0000 schrieb Peng Fan:
>>> Hi Yannic,
>>>
>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>> DM_PMIC
>>>>
>>>> Hi Peng,
>>>>
>>>> On Tue, 2026-03-24 at 18:30 +0800, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Convert the board to use DM_PMIC instead of the legacy SPL
>>>> I2C/PMIC
>>>>> handling.
>>>>>
>>>>> Changes include:
>>>>> - Enable DM_PMIC, DM_PMIC_PCA9450, and
>>>> SPL_DM_PMIC_PCA9450 in defconfig.
>>>>> - Drop legacy SPL I2C and PMIC options.
>>>>> - Remove manual I2C1 pad setup and legacy power_pca9450_init()
>>>> usage.
>>>>> - Use DM-based pmic_get() with the DT node "pmic@25".
>>>>> - Update PMIC register programming to use struct udevice API.
>>>>
>>>> these changes break something.
>>>>
>>>> Getting
>>>>
>>>> Loading Environment from MMC... Card did not respond to voltage
>>>> select! : -110
>>>> *** Warning - No block device, using default environment
>>>>
>>>> and SD card is not accessible as a result. I also worked on this
>>>> modernization and got the same result as with your commit. Have
>> not
>>>> had time to investigate the cause, yet.
>>>
>>> This change should not impact sd, unless pmic not probe correctly.
>>> You may give a look on "regulators", "pmic" in U-Boot shell, to see
>>> whether pmic is good.
>>>
>>> And you may also need to confirm, whether SD works or not without
>> this
>>> migration to DM_PMIC.
>>
>> I see the same issue. The error is gone when the patch is reverted again.
>> PMIC probing is working but the voltage change of SD-Card is probably
>> not.
>> We have set
>> dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi:
>> vqmmc-supply = <&ldo5>;
>>
>> which references the PMIC.
>> The evk is not using this property.
> 
> I tried to add vqmmc-supply for i.MX8MP-EVK, I not see issues.
> Not sure why this property impacts phycore-fpsc.
> 
> The only suspecting point is 
> 
> -                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
> +                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0x1c0
> 
> No more ideas as of now.

I'm pretty sure this issue is related to the VSELECT signal in some way.

With MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT being set, the SDHC
controller controls the VSELECT signal that goes into the SD_VSEL input
of the PMIC and switches the LDO5 between 1.8V and 3.3V. Internally the
PMIC uses the state of SD_VSEL to decide which one of two voltage
registers for LDO5 is used.

When vqmmc-supply is set, the driver additionally sets the voltage by
writing to the PMIC LDO5 voltage register. This can potentially cause
conflicts and lead to an invalid state, where the driver thinks the card
is in 1.8V state but the voltage is set to 3.3V or the other way round.

One way to handle this, is to set the SION bit for the VSELECT signal
and specify the sd-vsel-gpios property in the ldo5 node. This allows the
PMIC driver to know about the current state of the VSELECT signal and
use the correct voltage register when setting or getting the LDO5 voltage.

Below you can find some pointers for additional information. I hope this
helps to solve the issue on your board.

Best regards
Frieder

Relevant U-Boot patchset:
https://patchwork.ozlabs.org/project/uboot/cover/20250811131213.211124-1-frieder@fris.de/

Relevant Kernel patchset:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/

Example for sd-vsel-gpios:
https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/freescale/imx8mp-kontron-osm-s.dtsi#L314

Example for pinmux with SION bit:
https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/freescale/imx8mp-kontron-osm-s.dtsi#L812

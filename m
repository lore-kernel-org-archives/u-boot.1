Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C0FF4930
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 02:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C156183C14;
	Mon, 30 Mar 2026 04:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ex4KEUqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3348483C5E; Mon, 30 Mar 2026 04:21:16 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8F783B48
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 04:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOU1YoJgarQqZMt8n+VSwoLh3/cXQ/xG2EmM/d0nsdmQemCjCHzitG+GQFFbpai2zD6ZF1bCGTh+vi4L4RRL0BVwzYqcORec/itQYHCbCKEQ38/IUs3DzCi5THHzBA7Q8bB0co4KpNuZNinJLdWYpkdFmt7riWzAR6TSwpNyxioLdHi7jbCq8fMs0n0NfNJfljaIiYJBQd/hXvvCtcLZfIqzG0/GLSWepVAFeirG+W5lnNC4Q+OaidklvxVzdd4emAiDs3ho501v2cxAi18m8DmX/E7IV/LjccjenT5wSd5X8YXDjvrk+ZcJeclP0GMLH9KL820lLcWq6oGqLPAfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICuHsybfbWgwc8dva5U9Xd4Hw9plXkAaFswSjy2M5GI=;
 b=BjIBdWDl0trA1WKtnR4k5sYYp8RIIwBDQsquMCD4JpN5UpTXMVBUuS6tZBFripHimrqbxzwJetiCFDkG+rZC5X1cCkdemB2Z7FNAEbGXzNJ7qlb64DPH9dQH83TtG5o9xMGCXEMMOSHcKTn1pchtBCfR/21sgoKh8+ayCfYBL85cOgwxSrK9EXZxIky6cuDFJx2f3Sj959XyY8tx/3DYmkTOqs1Zs5oibmEGoyFj0mpgROm+iSzplRndtkDfq/GIYHXun+EynAgyAB26l5ZBpWb5C/og8IqZp1Tj4BZTs5Co5gQQGLl6ILYPrulPh5VCHW/a35p4MYEsEHpXI3rYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICuHsybfbWgwc8dva5U9Xd4Hw9plXkAaFswSjy2M5GI=;
 b=Ex4KEUqYCOh5ZDzBhRxlQLDHpFxMVO+/hv5Pf+lJ8P6pNai2qWBY+vwo/UeFIkpki1iPUw9UY0V8tP5bB53R/+zuCkrzy+JOB3x3ctujylPFEDKMsYqrcuEA3ADcCF1c/eL8HGocVMyxXy3X+JrdTVbTLhAL7roWXg8tWwvukSGvBHOAN0jqSz6ULvR4u8rF/iWQxJhdqSPMkIGjWOI4yl5sB6lk8Se7tED1yTpRjkU5mR3p8M7TcheqjwGEREQ/Q72vTF5G7IiPW6gZz+2OYeIL4KdEYbcFEl3YKyWPiL/TPh9CFK92fGYvCIR6nXtLBDecVfcMv8PF79Y4fxJMnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB12324.eurprd04.prod.outlook.com (2603:10a6:800:30d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 02:21:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Mon, 30 Mar 2026
 02:20:43 +0000
Date: Mon, 30 Mar 2026 10:23:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Peng Fan <peng.fan@nxp.com>, Teresa Remmet <T.remmet@phytec.de>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>,
 Yannic Moog <Y.Moog@phytec.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
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
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Message-ID: <acnemXvnI7Ifs3Xp@shlinux89>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
X-ClientProxiedBy: MA5PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB12324:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cff5ea-40e5-4d95-c649-08de8e02f188
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 23QIhTqtMG2FOx+46iOnFEUpLDBeoXcThbTgFdspsQL7QTDUqyrU+4L0YVunF5le78lXFdy7fOky0VuGmjLgEPdwh0Ab2BuVB/VrhvFGhe4R49r/s5xu1tIrCHzQLzPikWE84EX+qFlTpzgQHaB3apQWYlzgum+cmL/a4RtVs965EdCo0BWRNJBjiTLB8ZTThEjLXh/BDnEZBn4S3I6y74TfFukA05Wmznnkkwe8fGYt/0K3rB4tnR8Qh/pGWqywZX4iHPRI6uNg/YkRpAh+pObS86wQnixyjq5Ze6LpyjHNrAEniE29gG2EMqA1SLwJrV7ynVmRaZjJ+h/+lVTqsPQBDPI5BWHLNF6TtATRWZMPW/xbg/bm8seZSG3ncWcCy3tTKNgehEHQ2tWPi8ef1Oaw4g+otVGqrFJv5IGfEmB6S7r+Dwo9hw+O+4NstwYZr7nCtoFUa+6jWdC4M51Inealy4U0kQbZP0VRXL66ArPLGfc/SWiE3T79QPv9TLoV/V7j57gBc8zcG9XnVlLoSyYPbZoYJ8P4do0hRmxrD+agAs+J/f4FAyl4KsPcAdtWmKdDu2Xs/iKm0PZ8DX8fvYYxG+BXx7czmW8OCmcAx+fPbYRB70VW9Kbadpfzdn6+OOGgx1G8ptkKUtdk5Kepyjqb2ufhov9lPnzCJUzxXl67cEip0fgW61jK03hlSYa35PrJr55LjTQg05KURcwzQkBqUBpYvTT/2/mhHFVyvqD9tvVnazWPTIlzcxjNAsRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzZX8iEX8tl+xxBdedBkJ0J0OgAt5jUHryShSMSuronuMIUDJersyMGpOnSX?=
 =?us-ascii?Q?2RrfCM4TOWdNPaJm4y3KbJGLAZCA0ZhAv9pbaNMbiXNm0Vzk18KO5veracTM?=
 =?us-ascii?Q?feWIjscwAhGRJsagHS7b6b2Tl9ctLQwDBEYDXuk2RiEHRIP+ciSvhl7MHOtX?=
 =?us-ascii?Q?unVl8xtWs543TGd+S3os44Ag9dydf+DLNwv/eCckWD8/hhaQ3a3MWviVBIBI?=
 =?us-ascii?Q?qTkYN4sXnto5ISpgOeb3arWTTHkA9KrcdXFBMB4tv9TYOFdHLthfFXlJ9QyM?=
 =?us-ascii?Q?Kh1H7ew0FsPGnjvFYw4PupomX1nUPV6IRrihLM+gBKv3qpADWyWEU/OOc7ZS?=
 =?us-ascii?Q?qYTh/sZGyf8tVo57T4TXeKIUbe3mBbj0TdngovAiUbRPjwics/7VasfOCJWZ?=
 =?us-ascii?Q?8JecLoDEqX4g8fEsxbTkbTfD7uCYMGihfXUAebdJ3eGN9QDEzWpJszkMMGhH?=
 =?us-ascii?Q?TvRWdmDN0je8cjU6kcdxZ6sCnixTRalsAcggRtZlWM+Zy6zPOYhi30aITeoJ?=
 =?us-ascii?Q?iRIdC2scs1A9Ps2PRRq/lY/EM6GtedkhrHjv3VvJIBqp9eaZ21XhFmxAGvLq?=
 =?us-ascii?Q?g4ToIeoz1L7v/btueT96AOIDri0J8kRAQpQXY5apXNTmPwOk1t+LBxrtZLhr?=
 =?us-ascii?Q?r32RgOg2AcPuQAOarUPWYRPkSjeK5w3G61e9a1hgiph3S/aAqLyg8rvYpENc?=
 =?us-ascii?Q?XWtxdwxN0T42pW0ZR7UPstlWfHN9/rQPBwNQWyr1DF9ILqWUMf01KPw30puQ?=
 =?us-ascii?Q?+VzUEX/OtYv18h+J/LKdnpNuKBD+MbCKT8Ygt3uRBDkQLOWNupn1rZpqoN6y?=
 =?us-ascii?Q?PQEtjkMmLgkjhhJ8vl6CUD9sYND4YgrJyQ0qA+2n0foVFkc7trFXSqbUoTmn?=
 =?us-ascii?Q?yqtvmTykJFr9f19BKwh1YjIdf6WAKAjGBnvFWeaF5fi0I63f1mwLv+kfQWyL?=
 =?us-ascii?Q?onqyvRSe1kNUQGy62bIf18UeRFGTLK3KgbQ7PdpXwcU4q0swmwJsit2zsKNX?=
 =?us-ascii?Q?atSgIp6l1ZeZ1nythbhPzkChGGTcyuNsYstz8y3bAsp/pLkvNpn72c+iceSv?=
 =?us-ascii?Q?70cvtf4pUinZkSw14qPExbZBfW7ablm87xotG3BgS93i//ql1Hqjy+wGnrcu?=
 =?us-ascii?Q?ndJ9vzQkiNPZ3lEyZx78C1psXMXswj/AFAFQT1e8rrnotmgDjRFyhQAodqKm?=
 =?us-ascii?Q?ZOp0BKfeHksfPlkjR3Jb+BIgt7xH3cHsQJX8WrTuVDTfSCJFE5JpucQzMfTF?=
 =?us-ascii?Q?KRuzJKlDQB78M5E0Fn06w0+cvniDoClAFaSpCH4PC0pKyHyvAlw0mewQUOWA?=
 =?us-ascii?Q?MypML4vIK77Roe9pEq5STj/llD1RUCCY8tU3DKhYqSMqbZDN7LZs/eF3QDER?=
 =?us-ascii?Q?vZ1+iSQ/4liC/5L0DMWzjuKuUpKZGfa80ZPWFU7MTWXXt5wmUErEH9poShwF?=
 =?us-ascii?Q?yvXi+ffyMt8D1kVTkyrdPWU/pmQ6YSIl090txBc20lYLAQvQ4eO2P/Uj9Pnc?=
 =?us-ascii?Q?csz9vBT+ZArvrqVdgUJtdL0JZQsNNqhKUuoDvm009d2RV/uvwa/xEF7AkuPu?=
 =?us-ascii?Q?5R0kdFgBQiAp1Cw5Bef/qhReLGKaJz2Ipk2/pDGELXnCoFCXRoXTL0+7qFBz?=
 =?us-ascii?Q?ugtzN4rIjqUXqMMlyAjanJAnXd0zX5+d2Jz1qvobaSV3TXJV6YdigkL4tLc+?=
 =?us-ascii?Q?KNMT+CAUTbuZl0V+RJOb7ixhHXzmRF9Y4aS7ZgwwFfx8KtD4nPTn2Bc7+1qi?=
 =?us-ascii?Q?fWPyxDakDQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cff5ea-40e5-4d95-c649-08de8e02f188
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:20:42.9133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TkFznxycHQjNT+UqUsdhSFGpuMHjC6/bm4K5bj1AOwbNGA/j0cuvxv/9g2xMdLVRokFmIauD2xyXXx73fn/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12324
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

Hi Frieder,

On Wed, Mar 25, 2026 at 08:40:26AM +0100, Frieder Schrempf wrote:
>On 25.03.26 04:50, Peng Fan wrote:
>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>> DM_PMIC
>>>
>>> Hello Peng,
>>> Hello Yannic,
>>>
>>> Am Dienstag, dem 24.03.2026 um 13:33 +0000 schrieb Peng Fan:
>>>> Hi Yannic,
>>>>
>>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>>> DM_PMIC
>>>>>
>>>>> Hi Peng,
>>>>>
>>>>> On Tue, 2026-03-24 at 18:30 +0800, Peng Fan (OSS) wrote:
>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>
>>>>>> Convert the board to use DM_PMIC instead of the legacy SPL
>>>>> I2C/PMIC
>>>>>> handling.
>>>>>>
>>>>>> Changes include:
>>>>>> - Enable DM_PMIC, DM_PMIC_PCA9450, and
>>>>> SPL_DM_PMIC_PCA9450 in defconfig.
>>>>>> - Drop legacy SPL I2C and PMIC options.
>>>>>> - Remove manual I2C1 pad setup and legacy power_pca9450_init()
>>>>> usage.
>>>>>> - Use DM-based pmic_get() with the DT node "pmic@25".
>>>>>> - Update PMIC register programming to use struct udevice API.
>>>>>
>>>>> these changes break something.
>>>>>
>>>>> Getting
>>>>>
>>>>> Loading Environment from MMC... Card did not respond to voltage
>>>>> select! : -110
>>>>> *** Warning - No block device, using default environment
>>>>>
>>>>> and SD card is not accessible as a result. I also worked on this
>>>>> modernization and got the same result as with your commit. Have
>>> not
>>>>> had time to investigate the cause, yet.
>>>>
>>>> This change should not impact sd, unless pmic not probe correctly.
>>>> You may give a look on "regulators", "pmic" in U-Boot shell, to see
>>>> whether pmic is good.
>>>>
>>>> And you may also need to confirm, whether SD works or not without
>>> this
>>>> migration to DM_PMIC.
>>>
>>> I see the same issue. The error is gone when the patch is reverted again.
>>> PMIC probing is working but the voltage change of SD-Card is probably
>>> not.
>>> We have set
>>> dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi:
>>> vqmmc-supply = <&ldo5>;
>>>
>>> which references the PMIC.
>>> The evk is not using this property.
>> 
>> I tried to add vqmmc-supply for i.MX8MP-EVK, I not see issues.
>> Not sure why this property impacts phycore-fpsc.
>> 
>> The only suspecting point is 
>> 
>> -                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
>> +                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0x1c0
>> 
>> No more ideas as of now.
>
>I'm pretty sure this issue is related to the VSELECT signal in some way.
>
>With MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT being set, the SDHC
>controller controls the VSELECT signal that goes into the SD_VSEL input
>of the PMIC and switches the LDO5 between 1.8V and 3.3V. Internally the
>PMIC uses the state of SD_VSEL to decide which one of two voltage
>registers for LDO5 is used.
>
>When vqmmc-supply is set, the driver additionally sets the voltage by
>writing to the PMIC LDO5 voltage register. This can potentially cause
>conflicts and lead to an invalid state, where the driver thinks the card
>is in 1.8V state but the voltage is set to 3.3V or the other way round.
>
>One way to handle this, is to set the SION bit for the VSELECT signal
>and specify the sd-vsel-gpios property in the ldo5 node. This allows the
>PMIC driver to know about the current state of the VSELECT signal and
>use the correct voltage register when setting or getting the LDO5 voltage.
>
>Below you can find some pointers for additional information. I hope this
>helps to solve the issue on your board.
>
>Best regards
>Frieder
>
>Relevant U-Boot patchset:
>https://patchwork.ozlabs.org/project/uboot/cover/20250811131213.211124-1-frieder@fris.de/
>
>Relevant Kernel patchset:
>https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/

I think this kernel patchset might be wrong.

GPIO1_04 is muxed as SD2_VSEL, reading GPIO1_04 will not able to get the PAD
value of SD2_VSEL.

I also tried in U-Boot on i.MX8MP-EVK.
u-boot=> mw 0x30330024 0x11 ==> set SION and MUX as SD2_VSELECT
u-boot=> md 0x30b500c0 1
30b500c0: 2000780b      ==>BIT 1 is VSEL, already 1                       .x.
u-boot=> md 0x30330284 1
30330284: 000000c0                             ....
u-boot=> mw 0x30330284 0x1d0  ==> Configure PAD
u-boot=> md 0x30200000 4       ==>Read back GPIO1
30200000: 00001028 00000000 00001028 00000000  (.......(.......

value of GPIO1_IO4 is 0, not 1, but VSEL register is 1 in SDHC2.

So with your kernel patchset, reading the voltage, it will always return 3.3v.

Regards
Peng

>
>Example for sd-vsel-gpios:
>https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/freescale/imx8mp-kontron-osm-s.dtsi#L314
>
>Example for pinmux with SION bit:
>https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/freescale/imx8mp-kontron-osm-s.dtsi#L812

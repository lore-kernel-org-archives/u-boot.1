Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEA1FEC11B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EAC81E18;
	Wed, 25 Mar 2026 12:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nHZSWRYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5C58352B; Wed, 25 Mar 2026 12:10:32 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5088280517
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FztD0JqiDR46LXDjfQnrLqwFAZqTo/xGQIP9hDOOANo7/P5FA3THMCBlouR8O5fHpVlNHasShx3EALy2uLZhbviWEWEVwMworSeeM1i8KdJyiN/m+yiJhQ2/qfWD+EXgmRchqFXHlD3dPDOZqz18BWjzqDMWxmgRFU4woNApmy8I7sUI4p6P+muzd8pgLea0IM7l81DXcNvW5HAi0oBtklgGuGHrTzT/bzGweLHvQSOBrSbmIFil2nlPimBtc/PfX7m8DEds2mRGAJtlBTyy2TpJFXj6nxXCXjTzxbR+oYiqqTaIToTy6mPclvs/23yhgArOkaQ5Wj8igAKbuxarOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZNre63KArFVEor34XouU9CHEzhrjOUpL1k4mAJW9dE=;
 b=D7NJB7dnSiKLNkt1SNpRbFUTEKNk1Ssjjdk1Lbb0xmL1ybNOGd+bHHUCB76r60+mW6nz+6w1+dRflhathXp2MwMxHM57FWMFOicS1MG8k2qASWbAqD3ZRd88jjIuseVC6xk5LrdKx63sGvBQ06WmMws/XMuI8R3h/FuUgwjE1uOQ3Wwwv0is68xpwKOA2VDXp2yfj48gR0C/qKHKmUTLQdl+/pMoi2VrY2XxuSzCVpHKmc8jANaYxc/76NaKY1/GCnRHXUQjbxXrE750Kg4IUzH98tj8kK0+HFZHVx1xOG0zE1gBJrTR9y2Ejeb2FOE1xjrJTptiRoZIufyUz9quCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZNre63KArFVEor34XouU9CHEzhrjOUpL1k4mAJW9dE=;
 b=nHZSWRYWXC/wencHShwOnZjfl/1N2nUC9CSe44Rk9la7TVKvJTPiazkMhjE0qHTahYHpCsVmMulckDeBEOw5wEoKAybEYzMBLL3N3BIGmumQdo4jzu81Nl7SRNirZ3fjF3l9mdJ08RMFUG9r08pYkxUAOMhPpp0eJnBJzhIUIBKIXC6zClBtWSJFJgQLdOMQFfefZHHCqdC7IXNuHD8SZeuyGfibO71+BU1OY+8lSfiRs39WjmV3vGHVI8XVniBOlrAm3osoMWhKUVLKjt3CBCw2w1gThT5nI4dlzW85yY6Hv7SYCaSrPL0YYMI9xle8IC+yf9O00LgFukEDeqInCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9749.eurprd04.prod.outlook.com (2603:10a6:10:4ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 11:10:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:10:04 +0000
Date: Wed, 25 Mar 2026 19:12:31 +0800
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
Message-ID: <acPDFUn4R/nsQcg0@shlinux89>
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
X-ClientProxiedBy: MA5P287CA0166.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a49581a-0d83-4e1d-400a-08de8a5f107d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: X4Jly83/40gIjYRn/Mb/em0zVVDzeTIwKcjxPQAaxfw1of6E121w1QwMgoCucI5uBRJGD9alSLGWFx7kFdNxSXJNR6v/CzxAUTsHcl87+JPPy9jDLLQi7bYQp7HbjjGCHi9bwQof1wAhKMkWP06C8UVhcyoc624bf4WPb6NwaeEdL/GPSRCkc68HsHMA8BceYZekmkEgFAp7Bcm5Y3/G8otbpZuZwxolvXh3mhf97mdTcd0+pWyULMe3wgK3LSoc2sjO8U3gVDx3/0aYbTUxgCouYCR6vys2RyibPqWEFAgtbbItfBTA8GuisGGvctqNCTIxFtTpeIrR0jxc826EHP6Ul1hCoOFjW0wAOO6Kp2pqbwPR27C4LOpOvdo7NPTO86ORucrN9ftLyYbvbN3rRezUhEoy+p8W8BJ57RYQsxh8bJ9+3TivTrJd+TwunwqNhjNX189d/dtc/gRaL4TJDl1vfYSZYu0uS5zaxAneW1OJ9Pfp6FlX9roqH6BF9AqDdJ7g5aUTxAWKYoY9RU0mlL7jXdHs6poCXWkKhtE0FYFwd/Gy9Rg8ZcHm2amoVNkF/cXNkxYf+VFMsO9DGB9JPPv12gN1kX8he02ycNVLjr2FxCh15mM2BFNreX1hPzUZH0dx24gux6PGHahg3Ylyh6XFnb1Wxl8upi0Rts0TNa3t7rpXCxafRsk2RuMb5XrDjIiHawexMV+mSvDqmgAzrYmklSe8tFgzPXprkRQSee6r0o5ZYyD+YE1V5Wx0MYuk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(18002099003)(56012099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYO/nPMMD2tFSH/RmDZ/DO6SExlPxUGWZAIt4m0hvGvnelPF9pMzwa5pIXJS?=
 =?us-ascii?Q?j/E53NFHD4WinBSM0pmO2jc7HhmTjgXsKvhwdcHEUFhi3A3/kqYDUwcwX6dk?=
 =?us-ascii?Q?YEgf0KKi/yoTL4kWrp+LOzGX7CtZzFMWRb7TUbkgbNQdXbteqW1MzeHQAL1Z?=
 =?us-ascii?Q?XixvZi6bGm6Ct1d2Nuzpjo+R1QCvrowfeEtRtmzNlJmVrO2KBFgFUmTk3Mhr?=
 =?us-ascii?Q?LLvTOkQA45nhPRSf6WN1mVvSfHkTEW/t3w1ACTzH9+rPMIlniyXgxW2BCt8s?=
 =?us-ascii?Q?wnmSzkEoWKp5mV6zmeD+Bt3+a6/Qbh6cBeN/70UzNFBOcS8+9hdW7a2LqUGs?=
 =?us-ascii?Q?4+JwEwEd86aYcRqlcM3w2SBfPEtJI+WUDRPsUcIm6Kfjl1SKT6ls5ZiHkkzi?=
 =?us-ascii?Q?VU/9JsPbMQHsTPEFdBy8NXckt/5CiZ1Tx6UjIsWRDobIx/NwygKOBj9UQ341?=
 =?us-ascii?Q?1UFfZvnIAGo7qHEZGFvenEDTh4q/RU0FqP2D+zdMQHqSBNgoyxOug5zYHmYs?=
 =?us-ascii?Q?Jw4KVpI44YWlJ7W2OYLwyc9J99HE7q93cXtR1SOnONcxe0A120LmAGaauDPg?=
 =?us-ascii?Q?SjGvtCwpmYxmgw3wS4pD1UZpf8PoWRcglF4iciMZH7Hf3mfqiAIh32VY4EpL?=
 =?us-ascii?Q?Awc8hpkBfjOch/P2L42p/reYNrTfBaYyuSDn9rQRH9mRo3vWopstcjjgjRXw?=
 =?us-ascii?Q?nvwP4z4019uPKIhMJ+0MFzVaNOG/DdlVKW1qYJcDHfSDOZXklkWDVPyCmfvX?=
 =?us-ascii?Q?NvUOLTqJUr5Y72cVH5zSDne6D8RXr4TAqjULHf7GhRbxxUOjy2uOsiR1Fs95?=
 =?us-ascii?Q?0G9X7DTfv4FIRX9eb6ozg99U5G2mQVoDYaNiNI54Pp+Msd5qyKfRI8+KLHN4?=
 =?us-ascii?Q?0IHLWlgyoyauEkN6zH4Z5BvRdqGiInrV0PnSfVaP7jrAHsJwG1KAaCepZYYP?=
 =?us-ascii?Q?N3k+Wk3iYNXe66tIta8m2l6g3A3LQNPhi6ONAoYirSp4eL29nQv8Z9Bx0WTb?=
 =?us-ascii?Q?NZP2+UUU4zxR3CCC4tR+KwOkLEq/NfXT4ZEq4uL+asfnSqVHg6j047Jt+ITh?=
 =?us-ascii?Q?HzmBhA/O+2OT9ozj8PCyexDRce1yasHretmjud2VDTcH4mhGsud6Q2nq6wTV?=
 =?us-ascii?Q?CnEbHS31avdCH7usVY+qdgq/vXEASXxe7pnr0i2BOL8JFTxKx1xwuXKkpNzZ?=
 =?us-ascii?Q?11I0EI7IOYdJxSIUy9c9UUlg6tExZoH6M6SFD8onjcChsR0svx7rsPuHKysX?=
 =?us-ascii?Q?wvXhR/OCBWbhPNi4INSF68jCyK/AsuZ4R2xq0Yuc6oJL7ypVh0ejONA2U4tj?=
 =?us-ascii?Q?JBt6kYuXSllVZylptIapHksCZpOm74OMIZsNBmU8TIpMsmJBWjrSdOIuDINF?=
 =?us-ascii?Q?+wwYhjYVGlVaybcPzJFF/ejj6TtPJAz7oPTOnP+SUbn8VnWhzs7DBzjOBu6c?=
 =?us-ascii?Q?qT+EDxlPI1LPBTHewiLYxfrWQIUBYj2JqUv2hHv4+Ohm3yPlUSWznFfouI2a?=
 =?us-ascii?Q?+V9DYhvSXK5aB0iOv5duSFkQCp9QgyYSdgLktp9PohuLlGMlxUEfxPXpiqE3?=
 =?us-ascii?Q?qzKNwS1cMhHtvLIaWfa7XJrj6dZssnh1mpK9a5Y7VHeKByZbYUfPleSfO1S0?=
 =?us-ascii?Q?uIb2WdNHtHkN5khUxF5SvmR4NMFJ0hXiPHuSJkWMQRHGxgXTX833S9l29GLH?=
 =?us-ascii?Q?ifh/XSBvsuXXPOcsEtRH7QKAtlGB46OX3NRKXFq7ya98f99AnTvmI/GExC7I?=
 =?us-ascii?Q?HohB8t2M2A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a49581a-0d83-4e1d-400a-08de8a5f107d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:10:04.0580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvD7eiGs/sWG9wRknENemV/bV8a3eskbguIRHws4Y/iItV+7VAe4ZQF5rEtVKXwXy0OAmCB3Idy0IgxdY1ztsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9749
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

Thanks for the detailed information. But I still have a question:
For current phyboard-pollux-rdk, vqmmc-supply will always use
PCA9450_LDO5CTRL_H for regulator value configuration.

In drivers/mmc/fsl_esdhc_imx.c, when configure with 3.3V, PCA9450_LDO5CTRL_H
will configured to 3.3V, but SD_VSEL is low, so no impact. When configure
with 1.8V, PCA9450_LDO5CTRL_H will be configured to 1.8V, and SD_VSEL is high,
so it should work.

or I may miss something.

Thanks,
Peng

>
>Best regards
>Frieder
>
>Relevant U-Boot patchset:
>https://patchwork.ozlabs.org/project/uboot/cover/20250811131213.211124-1-frieder@fris.de/
>
>Relevant Kernel patchset:
>https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/
>
>Example for sd-vsel-gpios:
>https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/freescale/imx8mp-kontron-osm-s.dtsi#L314
>
>Example for pinmux with SION bit:
>https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/freescale/imx8mp-kontron-osm-s.dtsi#L812

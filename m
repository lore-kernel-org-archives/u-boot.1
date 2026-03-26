Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC55106F2EB
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB5B83FAF;
	Thu, 26 Mar 2026 09:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iEp41n54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C0683EAC; Thu, 26 Mar 2026 09:03:39 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013018.outbound.protection.outlook.com
 [52.101.83.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8A380517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK3YBTUiGxsY0zEPrgsaEjyJGL3KIphsma5+p3zVLFTapfwyuJOTPSbNvNYGky7rfxcosdL7MePFgQYK5f3YXPIDngu3gpT9OiAa5xC+M8FDBJJ6v+LbXiF52Ajds4JwD+aZw6h3+cT3w18pBabAO4LMWoa1AjXCcJVSqVgP8b9D0mj8u/kkS2NFu7mhg5dbP+z1AdzKDc+DgsV+mdwxS2ptVFkjQJ/oEIytvjLjLZ0BcKSxmgt9xdqGPPP/3OGC+Rwp+15FCBDmFBlyLfoA657Av+ZR9XNwMD6rd5qlGA/d9EsH/iDrWnPhiDS/fffoG4RIaeylqUTlDiO2rmISaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmyuZchYCX08imH3S3gG8YQ1YWM4wTuJEUcsPK2cbM8=;
 b=nHfi2kWPsi3gyh/SrZfQk9KcvVlLUWe9XMNrrJru9Q1oaC+BkpcUBuqAR82KlwXYhLaXRCbLSWgLKzP8rI7hDI2+34W5QDDRvoyYkcjwLx7AHu91iO0OYprldvEKaq8irnJvUlh3b4/Ib9QYqZqPmGwetQ7ZSzhKT8bfFd3aYGD6wOnk+kmuAg3TgpoMzLybB7+uaygX9M2mtWby23RuegZCmcYqz+ID6mEIVnfnxk7IBrmENck+FuA4DuNR4EP0Xu5QbFAha6VoTKb12fPitlGQzaeTDaxlYOtyINiV3iDBbVPQ0wURQeRdyA6tG+tTRrvyS5j2T1zkI0DOEzeCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmyuZchYCX08imH3S3gG8YQ1YWM4wTuJEUcsPK2cbM8=;
 b=iEp41n54cndig7NrUrhBedUjT1nD6ZQZ087NetSyWLNblhG/kDFYxHDwz442aKkH3/Yfc46kAgLI50lPI+uePK/9vzqCcTwj2n91k6Is57JdubOCLhHCfU8OXxFHFykA4qcHS2XXr/XS1fto/WPB6etVNVMjIaH6DqckXZ43RycN0pRf7plSJ+bsSL7GLMBdP0XQfX4eBlUiaWZbQMV2KtNF5pb9zOxxLRriBK0UY+Td40/qWYsCrPcaJ9lOasBR7ZYEJMT/fdmcX+un1JYdmgyWbKor8BwUETj2JvcmWQBYUUeA+tADEZadivSdNfQ6NcevV8KNBP8H2krMQAn5LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV4PR04MB11730.eurprd04.prod.outlook.com (2603:10a6:150:2df::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:03:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 08:02:46 +0000
Date: Thu, 26 Mar 2026 16:05:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Teresa Remmet <T.remmet@phytec.de>
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
Message-ID: <acTov6d4vNMnG5qY@shlinux89>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
 <acPDFUn4R/nsQcg0@shlinux89>
 <d10bc263-3129-4504-acac-e751c0f8e3c3@kontron.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10bc263-3129-4504-acac-e751c0f8e3c3@kontron.de>
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV4PR04MB11730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c085ee8-68c4-4ad7-bca2-08de8b0e10db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 1BdoGm7bsdStT19e0helUa456QpDKOXcd746mO1yH4pKlXxRfpiFt5+SBRh+2GZa1RXkMopdEp2CQojJL4hwrLJhycfJ9HnBQJHr6+3P/VsE+PE5btVNsfWelNO58Y6GfXgS/7BmA0SbBXcCUQlEHlQ48K6nrfJ3WBzBaE2Q3VLr3nhVKZWdz2vAAGiS47OPmdywimddlW9JZ3ESdLG641nOa7PtT0OsYwE9KDhEW7o5q0rZdNiojQ8YybS20g+8GI9uZOXUBTvfK+mEZ101KiBPswDwE9vh0x+8O/1ioPo22Nmy2a39KNpgnn/0trmzbghvAihet8e73n+es34pmpIfJG5Yz46+UUJVQupD8xQrxDifYEjEzmz1KYFcQW5yC17l0U5KHDLufhSi6/KO8bpr/2RoTFhrUuqXssUA9S5tm+cp0Bd2FtfK6XalqeyE4bGKxulv0cUywqmaij8CsdvkC0dsg0ypIRo+TMOZQ5o2VoAiFODTgwgEJ6tuSShgU92nnwK71AfpzVlcAqkaQP7aYXfjxoxQ0riyzETcsYjCIuM8cBf8XDrEajpYaNLUFAvGvKDwDsmJOipnbtoKOY6JxPLybXrrbxLISuddQIW1uIJZAJ8n9gAosk3AQBIwzK99Ig2vcgRx0CQFfuGn25yV5Lxq0otm8Lac9KLEEkO8JTLaNgNrfAdHrKCH+Fwfjzxc51ttZ1yFyQ7FSS4RMSVy0r+CAzmwG6F7qiRLNdKjS5c0hx2eltfhMgn4ofys2+v3qzHzcHDrp2G8aESbohi4ULamodbhCOVFQaMagUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zCXAlcEwQKFwUDq3DjeBGnC/QgLuBVFZp4AGL2ICFbI6dCaRaeLarRmEHvUZ?=
 =?us-ascii?Q?rL+Z7h9AKctSe68+DD6GtofIP29aYZ0R5Msqz+iuVj1iF5F6G5MKK+HXQ/z5?=
 =?us-ascii?Q?V9riv7K8BO8IVRBUsxlQzjQUC1B/kRAUZ94kZhbxTTPDF5bIQoRi9qv+TWpn?=
 =?us-ascii?Q?O78YztOBcdUClkZwmtYDS1YqW4rUc652uCi47vaRP+owN1XxBlFRwKNNSwqt?=
 =?us-ascii?Q?11xfVvYouWw1j2qU91K4S1JgZ96Zp4jxo7B9gAdAth5MIR1D8wLqKWIWZvSH?=
 =?us-ascii?Q?ztJEbhOB+NaRJond0u+40oRw50w81L1NqIG8shwb4MencsJUyM7/uEtnry8L?=
 =?us-ascii?Q?uF2mDnSEDz25HVGP1oBoRz7+AfyNyEcbdyWSsChpAqXwmkXQV0sFFDH3YyM4?=
 =?us-ascii?Q?iI7Y2P3+AyuK2RsBY5FVYBf+9OeLazRhhj4qdQj8QGPlus43F2TReZugTJmx?=
 =?us-ascii?Q?cg3Ab5IyZ+U7+zdVNWUWyRiMAnBWnjYBKx1hF1V3exPbfhxgyBLH1sqlW6qc?=
 =?us-ascii?Q?E+8xgF1jy7/Y7jXlFJ1RwGkLMApXsMonLhPA1dpRzoxhTqEXWAdrbWSOrigx?=
 =?us-ascii?Q?xT4qEP54T+sDqfMVqR3zTi3F6796833bgWnc17gFAfNqTYMBpJ9BGWuJ9SZh?=
 =?us-ascii?Q?ITDhCUMfa63WH23JtdpOOh1jn7jcJ+ErnZqnkVwcFYLcqGX9Zd4JBlfeSIvK?=
 =?us-ascii?Q?oj3RwBcPpE6o36pcEO3/usTktXU4PKERZ5BrO4F8AR9Fa794cGNt3NyGpCg2?=
 =?us-ascii?Q?33cSrML8pfl+jyJylvFoct1cjaFWWoXOndnJNj39mQZtADEP9DFajzcMCBU/?=
 =?us-ascii?Q?l9TDvXByLKeFS19GXGzMA1dyuHmUTLS7tqZi8Qhsf3IkiZpSeKvd/MU9rQeG?=
 =?us-ascii?Q?98JooxLIZvuPauMe9Fnd+A5xlpsqwmLmpzCZul1UtBhCDqWliPUpYSnnvKIl?=
 =?us-ascii?Q?byJFu9nqe1EaEA6tdxFaHY7q3Hy84Q9sOq/13Ka4wtWC2A9unag+e51Thq0C?=
 =?us-ascii?Q?1fO/XjUPfh2lstJvuqhhMI5WAkbn2p80m9UwFS9pQBSBe3zzSCy2qMdpoaSO?=
 =?us-ascii?Q?igS4Z7LNGTQ7+1ayvTMibsvo47A+5XyweyWiEu+vUozVqssZNR9gCSvb0khG?=
 =?us-ascii?Q?5h1TArNS/z+3ZE3MLpUli4/ksM27oHE6YhLeDxzfz+84EgF7NKB5WCjEv77O?=
 =?us-ascii?Q?h0Zh3SOr5cylzMGEWcx4JlunMWdOY6Cmoo4C4zf6W4noQggU3YjTqU4uoeOd?=
 =?us-ascii?Q?Ge99sZBl2PMfuLKJd0GMLSf/yTokEZU5JvJ1GxyvARgr5zWsAOYxCIg5JzVQ?=
 =?us-ascii?Q?/LBCth1ckMNvjUc0IaKLV1AtQL/TUGTx9olQhOw/ts6IYBoY9nNTHwPkWR0u?=
 =?us-ascii?Q?W5GFtxH9jmaKHCT8ZA/TJmlbFo6T35xS0S8TPqSzOF61xiFxQfJ+lct1BsL0?=
 =?us-ascii?Q?XRz/smwlfiYzZ4TaZrjFFJ2Hdx3mi67hAZ1AJqCzFPUCNKFoQESpepcEgKTi?=
 =?us-ascii?Q?7wZ3jtm7Gv4QNr8fmkiD3hbAbwpwYHqstaiH0MLRj8hGK7/M44rrrRLxw1I+?=
 =?us-ascii?Q?4FpgZ8ixdz9jErKOS6FcvcgEHImg2Tz+fq17LyPHsUer9l96hj9w5eBv7pHo?=
 =?us-ascii?Q?bqQU65f48P+TpbwyKQ8611HWIsyExPZxe313+f7kgC2ksTi/hpWAz8HMOiW6?=
 =?us-ascii?Q?0/Wehjh5ewaoMRyUgJohq083KdGEErowZHE/0aHimt/4womKole3OVz0vKEo?=
 =?us-ascii?Q?0dvSLM2pTg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c085ee8-68c4-4ad7-bca2-08de8b0e10db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:02:46.8011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKDvgIWqJT9aQ5Vy95OgHOObVOJFktPDTgs3quNOjS2UbgC4RUwwEy/YsiIaD0sudyocujGgtP86qmADxsoicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11730
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

Hi Teresa,

On Wed, Mar 25, 2026 at 12:35:59PM +0100, Frieder Schrempf wrote:
>Hi Peng,
>
>On 25.03.26 12:12, Peng Fan wrote:
>> Hi Frieder,
>> 
>> On Wed, Mar 25, 2026 at 08:40:26AM +0100, Frieder Schrempf wrote:
>>> On 25.03.26 04:50, Peng Fan wrote:
>>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>>> DM_PMIC
>>>>>
>>>>> Hello Peng,
>>>>> Hello Yannic,
>>>>>
>>>>> Am Dienstag, dem 24.03.2026 um 13:33 +0000 schrieb Peng Fan:
>>>>>> Hi Yannic,
>>>>>>
>>>>>>> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
>>>>>>> DM_PMIC
>>>>>>>
>>>>>>> Hi Peng,
>>>>>>>
>>>>>>> On Tue, 2026-03-24 at 18:30 +0800, Peng Fan (OSS) wrote:
>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>
>>>>>>>> Convert the board to use DM_PMIC instead of the legacy SPL
>>>>>>> I2C/PMIC
>>>>>>>> handling.
>>>>>>>>
>>>>>>>> Changes include:
>>>>>>>> - Enable DM_PMIC, DM_PMIC_PCA9450, and
>>>>>>> SPL_DM_PMIC_PCA9450 in defconfig.
>>>>>>>> - Drop legacy SPL I2C and PMIC options.
>>>>>>>> - Remove manual I2C1 pad setup and legacy power_pca9450_init()
>>>>>>> usage.
>>>>>>>> - Use DM-based pmic_get() with the DT node "pmic@25".
>>>>>>>> - Update PMIC register programming to use struct udevice API.
>>>>>>>
>>>>>>> these changes break something.
>>>>>>>
>>>>>>> Getting
>>>>>>>
>>>>>>> Loading Environment from MMC... Card did not respond to voltage
>>>>>>> select! : -110
>>>>>>> *** Warning - No block device, using default environment
>>>>>>>
>>>>>>> and SD card is not accessible as a result. I also worked on this
>>>>>>> modernization and got the same result as with your commit. Have
>>>>> not
>>>>>>> had time to investigate the cause, yet.
>>>>>>
>>>>>> This change should not impact sd, unless pmic not probe correctly.
>>>>>> You may give a look on "regulators", "pmic" in U-Boot shell, to see
>>>>>> whether pmic is good.
>>>>>>
>>>>>> And you may also need to confirm, whether SD works or not without
>>>>> this
>>>>>> migration to DM_PMIC.
>>>>>
>>>>> I see the same issue. The error is gone when the patch is reverted again.
>>>>> PMIC probing is working but the voltage change of SD-Card is probably
>>>>> not.
>>>>> We have set
>>>>> dts/upstream/src/arm64/freescale/imx8mp-phycore-fpsc.dtsi:
>>>>> vqmmc-supply = <&ldo5>;
>>>>>
>>>>> which references the PMIC.
>>>>> The evk is not using this property.
>>>>
>>>> I tried to add vqmmc-supply for i.MX8MP-EVK, I not see issues.
>>>> Not sure why this property impacts phycore-fpsc.
>>>>
>>>> The only suspecting point is 
>>>>
>>>> -                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
>>>> +                       MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0x1c0
>>>>
>>>> No more ideas as of now.
>>>
>>> I'm pretty sure this issue is related to the VSELECT signal in some way.
>>>
>>> With MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT being set, the SDHC
>>> controller controls the VSELECT signal that goes into the SD_VSEL input
>>> of the PMIC and switches the LDO5 between 1.8V and 3.3V. Internally the
>>> PMIC uses the state of SD_VSEL to decide which one of two voltage
>>> registers for LDO5 is used.
>>>
>>> When vqmmc-supply is set, the driver additionally sets the voltage by
>>> writing to the PMIC LDO5 voltage register. This can potentially cause
>>> conflicts and lead to an invalid state, where the driver thinks the card
>>> is in 1.8V state but the voltage is set to 3.3V or the other way round.
>>>
>>> One way to handle this, is to set the SION bit for the VSELECT signal
>>> and specify the sd-vsel-gpios property in the ldo5 node. This allows the
>>> PMIC driver to know about the current state of the VSELECT signal and
>>> use the correct voltage register when setting or getting the LDO5 voltage.
>>>
>>> Below you can find some pointers for additional information. I hope this
>>> helps to solve the issue on your board.
>> 
>> Thanks for the detailed information. But I still have a question:
>> For current phyboard-pollux-rdk, vqmmc-supply will always use
>> PCA9450_LDO5CTRL_H for regulator value configuration.
>> 
>> In drivers/mmc/fsl_esdhc_imx.c, when configure with 3.3V, PCA9450_LDO5CTRL_H
>> will configured to 3.3V, but SD_VSEL is low, so no impact. When configure
>> with 1.8V, PCA9450_LDO5CTRL_H will be configured to 1.8V, and SD_VSEL is high,
>> so it should work.
>> 
>> or I may miss something.
>
>I think you are right. The process is the same as in Linux and I never
>saw any issue there. Just the fact that when reading back the voltage of
>the LDO5 regulator in Linux or U-Boot you could get a wrong value. This
>can be fixed as described before.
>
>So I'm really not sure what the actual problem is. I remember having a
>similar or the same issue with our Kontron boards before switching to
>the upstream DTS with sd-vsel-gpios. So it might also fix this issue
>here, but of course it would be good to know the actual reason.

If possible, please help do a test. After applying the conver to DM_PMIC
patch, then apply below patch to see whether you issue is gone.

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 335b44a8a1a..f92c0c91c4d 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1454,8 +1454,11 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
                        return ret;
                }

-               if (regulator_get_value(vqmmc_dev) == 1800000)
+               if (regulator_get_value(vqmmc_dev) == 1800000) {
+                       printf("value is 1.8V?????????????\n");
                        priv->vs18_enable = 1;
+               }
+               priv->vs18_enable = 0;
        }
        return 0;
 }

If issue gone, I think issue is clear, driver think it is 1.8v, but it is
3.3v actually.

Frieder's fix is still the best for your platform, you could go with that.
Other platforms using vqmmc may also needs same fix.

Thanks,
Peng

>
>Best regards
>Frieder
>
>

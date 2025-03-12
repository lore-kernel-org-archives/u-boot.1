Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98D5C2BA1B
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5031380F9C;
	Wed, 12 Mar 2025 06:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fpqa/6/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F291980FB9; Wed, 12 Mar 2025 06:41:05 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F710805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/TpbRwZ+8wz5qefXdY7rq/ZEnTbf8asd5/6r5gSYmnWUpc3xW4o+dktlVbBrP4qDEetn4t9dyyFixPrnsVr3635vZaNL137Ak7UEVPuUk1h2vB5rELJ5Azda0lRuXjP+OwCMKm7nnUeig4VbiooEMBvIOLDH+o9VoOd90SvjV194/Ol3jd3PP2qBV1wzCbieNLDGiY40X4jddeTDxodOcKW98yw0MPpE6Jtzy+6nYtnymlKeAOOrVrKMk5GgjWRCYfPdts2ZgqsybF2W13uAV03/WJjoQ38aqgft1zEvBQusQ3+GFMVezuRw2VzJkdu6c+3geA94Hkxt46GKIdQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dE5lfanKPACVVLvEjHL+ABITcYYYlRTh0hyRzuyBZE=;
 b=nO0QUTwA2bh07sLCL8Qbu/t3b7uCyxAqwhmiG/yCDUmKeTkwwMyOcD0QOCLp/8uXFysKA+kV0UeneTyDFqCx3YYFtnPQlH2iSzmPxhs2s9eYCERQhj3KDLRC7cjE0KnfOvfyXpHNB4ibTKDtPKdMzyEMrKPxwlHrwqHmHUjOs3RHbfF10DLMyE+bpxHMyFWzLQvh/ZqPElZ34+K/Zg2M2B5OFIKYpcoHWk7kweI0t8OA9gdFFqo+0tALWSZpbhDSiKha6XWn+X8pGUGlqO/GI83yuUX2bG78nHXHMPrB68Vf7Ugt1mj6gEqsAcylpwyom9rU2I8TbfftMG/OWVG/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dE5lfanKPACVVLvEjHL+ABITcYYYlRTh0hyRzuyBZE=;
 b=fpqa/6/8s6BhXskd4lQJumavFcvu1F6ehcaEHL7wFhAs1iZziG0bgyrMN7NyRwcX5T0KqfqGvf7F0BgLr+zt4Pwogz24RzMhMK6XuwGKYUMZQdqiehejaPX7aHFRos1R312se3T+2Bw2WcsYoKpYM4TtB6rEnVlin+WO4DTYMIAKS1yBJkL03XVlz8uhUJdT3L0fA4yRheekKTeaUCQlInZO9VpPzdNFxrJq3VskKq/vRjh0wstXq5VKj0dXUhvQb4Qw6Fmumg2gFVs13szdGXsq3saIdBNAXz2JGvFpF0NBJwLX39GpytdpOmBMJNXw5gJzR3ppQBvTd5278RrVXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:40:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:40:57 +0000
Date: Wed, 12 Mar 2025 14:48:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 09/10] configs: imx8mp_beacon: Select SPL_CLK_IMX8MP
Message-ID: <20250312064837.GH11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-10-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-10-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c452446-45b8-42eb-00c2-08dd6128764f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4hHaKbKRNLH313hzW5VDkG8GzR0UFF8d9MxeeepsMB5dh1bhLD04XmZZ8Cn2?=
 =?us-ascii?Q?U0peP/MvAIrek3l79hKspJMx4hnKrOdJM/IVn/pYgzHS2+iGgE4XJZL1Nn8/?=
 =?us-ascii?Q?8vkr3KMc544D7Da4+/MGzZx2s8vlsoy330a9vKKU8MGQrABrdP7dtZvGf/lp?=
 =?us-ascii?Q?c/mFysT1OPP8EmgQyMzP8r4sX/n5ZqbjEKhVKDqBg/kNVHht1uUcvIeg/lvf?=
 =?us-ascii?Q?4IIUBh0Q4TDItVk/2kNnukN9Oq9Pj9FiDCBj01Bw+FPtS3L1EJUINMdmSQrE?=
 =?us-ascii?Q?1D4ETkXXrBcrKhQcyU75hBdor0llHMWoz28FCV2NU0+/AB1O8WPzD2hqV5Bz?=
 =?us-ascii?Q?UidL8aeNxw5yaLBkRCW32QbivpqCqWFjeTgBYEycNJnbd29VLBuoYi5Sgkm4?=
 =?us-ascii?Q?LvmczpqgpXi2/qh97+eOxmgsY2QaujvNkawyoVRWkqhD22VlyhuSz0g5itkK?=
 =?us-ascii?Q?o3s2HczpGVC0Uei1cxN37y6el26xyHRqM2pzkrD57cGHwy2vw+y+hLAxXjCW?=
 =?us-ascii?Q?GuigH4IoKERrIcZ59AItLxaUaf58VL4JbXxVCsRClKUyqqLvIxSqDrO8iPhs?=
 =?us-ascii?Q?0TX9fzVgLeUNUN7Aav0PtgvAKeF8ELDFCAN9PMaiD20iuoNyQLZbrxK4Caqf?=
 =?us-ascii?Q?w7W2caedhKNUhdg8F+ueePcFL6ENPhO9+tA19BE/D88ArFbKj8ZrZoy/NkPc?=
 =?us-ascii?Q?4iF+rZk84Z7hyjv8Z7NaZE9w85IVP1ROzZoCx/walaX6nsnI2ySV/tj1xB8q?=
 =?us-ascii?Q?3llHCbnjRRpdfZTNz6/cEq+HeFtqTjEycaxa8iGebIWER1C0WHirMjO5nboT?=
 =?us-ascii?Q?2X4FJT64gsVaIlTEGW1EwhM1EEvYE45v38bmocwMWlg22ohCkwOGVZuZmiTK?=
 =?us-ascii?Q?O9fDow2TajV/0WQdV/lI4KDkWZDecRdsoxJ+a0gNsf1L45ZOVn61f38bUpTR?=
 =?us-ascii?Q?LS6JPtyVNdd10EKYe/EHKys8ziyAvE10pBB343YJCsUaZtqmxKcWENtUyBfT?=
 =?us-ascii?Q?D6/gGP5pvWbgADbbyvU2szPNZFNHOK5kXB+DILxVbsm/NW1e4GTV50yObgyd?=
 =?us-ascii?Q?wKBCJUAnFRuOp9QfkPMThEqDoeGKzKFF0BQNV9oA2xiIcAA4LIwY18o/YbXJ?=
 =?us-ascii?Q?5qK106oL//gyB6SIFPr9Z5lcN1IyLt4XI6i2KtLNxOiPil2j9sfXnggJs0Va?=
 =?us-ascii?Q?rGjQOaVCngwF/3u19MjB7+KitsgdfKxqM2OTffdf/LQIKLVIKzh6RgZbBYrb?=
 =?us-ascii?Q?4GajIJUTSs9VFkiNsHJN90tlXG0fanWFmF+ynykxuARgRNtxhXMUhL3OqQhN?=
 =?us-ascii?Q?O5n25a4A2ihoBF4c8+im+V7JpHMbD0cN7M5C+9O404qo46CYyaUdxejf64bF?=
 =?us-ascii?Q?6aNiszoisMqliQga7PPGNSEROGjUpUgyceO8dig+jxP0JwbUVbTYO7LzreUD?=
 =?us-ascii?Q?A4REdKbZc6BFw8pLKdj3+lJR8F0pQksD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+NIv8vhms+7R/znvk7XKhM+OXtMJUUcl0Gfn9zciEGFq9kG9rBcbL2mnteH?=
 =?us-ascii?Q?ZsF3JkNHPMZ4HonafwqKiJr5U3FnLIl6iO5+3ZzahpZB+eM1lZKATVAgXMKn?=
 =?us-ascii?Q?6vW85QsWhDkmEcRwZQ5RYklSm6GqeBkvZGx5o+Ew6/AQadmB8yBFsDFiYfpv?=
 =?us-ascii?Q?SVg1PD40FrWLB00iKjDrr2QUGh+fxxTqzS7fmiRmRDOeAedV8WWxQKsYBNOK?=
 =?us-ascii?Q?eSsVvqVFrzUuf4o4z6Diog/Eb5Xp1GOthKKupeYuvDeHgZ3qfvsFLPzHChhq?=
 =?us-ascii?Q?neZqvntmhu2CHMj0vPUm0Zqbv+7HfRXfae3os3mm5rDwjaHwFfLSqHHfgzeX?=
 =?us-ascii?Q?L5shNge/LePnBWkbwjAl3nCbijGiGKvbCPW18kC0d4h3DWE9TZF4zswwLnG1?=
 =?us-ascii?Q?oqswxZDECp+bUl4xwa52CltO4Lb91ptaI+9YRrWUJiKfODwY+UsdveQ6Lhmo?=
 =?us-ascii?Q?b2vUVne6HmFo0mctD95kt05xuIaddZ2iZSMUnC41rB1VRmMOdbI3heS2RReR?=
 =?us-ascii?Q?ZMbwAtfaG/69gHRobF8f+5jVQf47HTxgPD4YXJjCFxCtsqkXXmFgl+xpUnKC?=
 =?us-ascii?Q?Pfd1eEYPcuQtrrHugsk3vkL1z09y6KyryuinLdwb0OhPWAyCs8K/WsLlu2Vd?=
 =?us-ascii?Q?xgm5tJRbADj29yJm6/GJGiIY/LmqhTdXbRYSnVm3h9iKh6RGeJ8vcAQOcOjQ?=
 =?us-ascii?Q?eXP1fsmFKyvHri6a/oD+eUF/jFeRfQNDLgn7rVEemokzp+RojvErecBj0AX+?=
 =?us-ascii?Q?l6CacKtDMuFT34cAV6tv8G8KVxaxM9slEJOPiEyhh4SepWE68hVV+v7pMRsC?=
 =?us-ascii?Q?/uvidmTp9PhtKVMT6s85XaCbLtAVzhMmVlXEEVkyVcIuQ8qytYCtREpWpGRq?=
 =?us-ascii?Q?3Ao0ndeevvavvc/cgeCLINj44vzYv6Pnc7x5bkrgO4XvHHndPo5YiBb3PLLi?=
 =?us-ascii?Q?OdRQTpZIO6F9z2W+wAiylY7pYJa7R2gK0a8C6v+z9CzBD9a7qfOLILJiG9vN?=
 =?us-ascii?Q?erT7Gs40Df5GKq3v0P2c1ak0UyEBOMWxFU6wOSp9hyf7OJHzjHs6AKNWyl49?=
 =?us-ascii?Q?JU7p8EeLm8aYUXLXRY2NGzk3yXaEsTW7pAGL54hzpJqiimyHdBBwskouXJcM?=
 =?us-ascii?Q?qBJQwggpcNXEiwQW5KzDzL1WjS/EWMEGT108Rn0JDVEWISkjO0HhyKu0qclL?=
 =?us-ascii?Q?HzcqBu6HWjcK+jICtWDzrk9EOroD/xghSrthaiqtGuu5cIXJeq/r00eKO9yF?=
 =?us-ascii?Q?LZCh8zoW8gEv2EVFT7c8PZaY6pOAL3SNFsVWmu/BFjUMWym7NMJ7KKPoI/zo?=
 =?us-ascii?Q?U8SNH1rQI/FbtmzjbAehjOZVeQOaKPvLdfV85StALsNUSP+2xBXzRgHK1VaP?=
 =?us-ascii?Q?YRJUJa8/RXlhbJq7b5bKSQKwXD0wrHUi7jmNbztea3zk7jk4/mH8Lwbda9iT?=
 =?us-ascii?Q?F+o7rUvkQKbY2Ox3r5gDCaEYDwzxlIQhkjIrkeEfrKby9hnk0CWL+TvN9/kY?=
 =?us-ascii?Q?XNgWR/kVqHgwSK5DSkIWckwmKSdBuhphnAo9HNdGDcBok7gTqBOWJ4pXYPFJ?=
 =?us-ascii?Q?VN+RmnJC5TIWYq9rjx3G4NE30B8En2TUxm92ME6l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c452446-45b8-42eb-00c2-08dd6128764f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:40:57.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6Kb9L2sSiC1XtKKDd+1PfY423KWWPiYRfYYiRIN5WMFE/bcskjJ/WWHtkY/lph3l0WGtnvuY2tlRnYxbyjLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939
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

On Tue, Mar 11, 2025 at 07:30:29PM -0500, Adam Ford wrote:
>In preparation to remove manual references for enabling some clocks,
>enable SPL_CLK_IMX8MP which automatically enables SPL_CCF and
>SPL_CLK_COMPOSITE_CCF which permit various drivers to activate
>their respective clocks automatically.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

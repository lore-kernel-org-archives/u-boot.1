Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E375BCDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF668904C;
	Thu, 19 Sep 2024 02:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DUjTvsfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FBF89068; Thu, 19 Sep 2024 02:14:58 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D27BF8904C
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO0FzORpv66edgbtcjgp4/leFk6i3MuD08P9teZBxMko+D4sOYub4a9GqZJwPhqr7lX3nWJDhZ4y5kohYX/DjrYBT/n6UZZkuUps31TKaGXkstI54t9uWe9SHuHTg2po4cOpGxiGJyPwjwenRbTbhdulY3sxll109merFtKYbiN0u0VhfcLGBHeq3xsstBPc6wgTMqEIeal3C5i43kOL4SN9DioivzaH2rMb7lFw+2xl3AjhcC69XCo7Rz7rtWhQP9DQ0XjT3gDCJa8Kcdya6EiB7y2Ed12Kkn228joR7/jDtGo97KF1axp+TNRt/HY5ykGU6+stFG7y97jkPN8TBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+YRGepBIkvrRsa0MMf4sY788f8lrYmbdWuvh+K6J5c=;
 b=xlq3v9bx5IY8R5PARwZUCy+1UqU5eZLftVA074mcN4/RAJCOQJmPwvf8J8ukQLaiVMoHhuR3de7h4kp6/8NT5A26lcpT1I5lN4vDJiZOHeMklZdXAqn7D98B0Qtl/CInBfiSkED1Ny0dw/yvrv9+u8nPAX7Eke6eTzs8Eno+pChskTSDRxhSVvttjDTImLXP6DMMdli38axenDdrIhjSDgKGl6O70TPO6aXOrjOqymNiLY9Va6s5HE3X/vOEausfWMpkye886hQHKSRMaGBvJ5YRKOLHHPtytpnAfDDthLnrxsQa5SfJtpLkv096iRIiehuZqBsV8K1wQlMJ9qtz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+YRGepBIkvrRsa0MMf4sY788f8lrYmbdWuvh+K6J5c=;
 b=DUjTvsfiFRKvMVoIRN5LCXFTZ6eV0a8X8lERhTowY0eWwuXFJRvX/5GseXe3ITqofrPfPhrjCVUt2mZXYQ/Z7qkifrcS6U5eFkBTHx8lzBlBT6n09otnRuu8sOC9QxtS7GEbOuKbF+OwqoUdrkq3Zr5rPdDixD+RECaxIw4vbF1Uloo3pKxHJ4oucMFry52ZeLcxqW6vG1eTXP1tzoIriownZG0IHafGpfA3e9O+gWerWOCXuawq8C41CsrPSWF6bU3uWdeoo1StytmXWeOpUEEKomsQ8BXGwVEtb8zWJiV28777TANVo7X5u5so8tC7OUskZ4EOTzrys76GfM8rZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:05 +0800
Subject: [PATCH v2 06/21] imx9: soc: Change second Ethernet MAC fuse layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-6-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 794e293b-caee-4436-8bcd-08dcd8401699
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWxFc290OEFmWnRUTDZFclIyY3VLaEtJTVBSNEJKdDdMSE1mZG1ZZnRTeS9v?=
 =?utf-8?B?VEp3VjllT3EwdTVSUklBdC93aGFKU2FBb2t5MXZOc3I0TDl3MWlXVjJTdlc3?=
 =?utf-8?B?TnJmN3NRRjdWcXY3SHduUk80bkJ4K01ST2llR3F3eERUVFdyTFVncnV2WjAy?=
 =?utf-8?B?bTlVdERDQTIrbnRJaFQwOTNJUWp5djZSTlBGd1k1TDBnS3dDMnNQamZmdzdT?=
 =?utf-8?B?ZUU2bTNRVkIwcnR6K0tTYzU4R0RLZkhSVEk2NzRkMDFYRzJyQ1F3Wi9MajNV?=
 =?utf-8?B?UUN3ZFF6b1lwNGp5K0ljRC9iaEpPSElkWSs0UW5sOG00SFpteVU0RGFHZEpQ?=
 =?utf-8?B?K3BQaDF1cGZNRlpDSExTelhGZmZiZDFoTHFHVHFFYlJHOXZFcU5QalhXVU9x?=
 =?utf-8?B?ZVZRVjFkYnFQaHZNWDhGdW92dGNiUjBiY0tXRlRPUGZGWjBqOVpjQVprWjZt?=
 =?utf-8?B?YURuUC91S2dSUFhGL2FFWDVmVzZkdXA4Q2pNSjV1Z1czTDlYMEhmNmhkVktF?=
 =?utf-8?B?WjhwR0dtWHdRYkMwV2poRFpvRkhIQ2FmcFlOOTBPZmhYWmVtRWlzaDZraEFj?=
 =?utf-8?B?YWQ2U2FreVo0LzAvd2NsMXJPRVNzN2FFckJ1Nmt0N0doRDFEM083VEVTZ01G?=
 =?utf-8?B?ZnAyT2orMlplTkluQ3UxM1N4WkZsYzNDZFh1cjNmWjhQMmJ2dkoyc29salhv?=
 =?utf-8?B?RGR2Rm9NUjBnb3AzY0l3T0dBazlDN25OTE5pMCt0OVMvQ3Q5U0VUcDB5a21P?=
 =?utf-8?B?TDh2SElSTUNwZGo2TEd3R0d6YlNKUU41M0ZiYjhiN2tnQml1Nk5OSDNrYW1j?=
 =?utf-8?B?V0x5RVZkbHRldUhrUWM2T01lR05LNGNsZnp3SUI2NXN2bzQ4QU1NMnFhSkpS?=
 =?utf-8?B?TjVTendVZ3daamozV0tCRllvQjdNQ3Q5dUowME1PemdzMVVWNnNIMkh0eWdV?=
 =?utf-8?B?dzVkK0hFaHJkbjI3Sy9IRnBjMzVzQ0diR3pybzV0d1dsS0hwWWFvMXZvcGVK?=
 =?utf-8?B?STBwV0E0UDZtUExFTm9BYWpFcnREdzZIaXIvWmdSS1RUUmhLV05TbkxWZ3By?=
 =?utf-8?B?cDNTbFFXUUpiTHdqRy9WdHY3RG96aU91S3BValdnWTRMRHlqcHhKNVNaSDgr?=
 =?utf-8?B?TzZaV3U4dEJPRnhjcVNURHRNTis3YWhaL21WbGxLTml4bXJ4TUtKVmlBbStJ?=
 =?utf-8?B?dkpBTW9zYzBCZDdOQVFQeUVGNlp0WkFUTC82TmI1Z09SOCt0TjBWajBScU9D?=
 =?utf-8?B?WHdKdDhGTC8vcTBWbXdkQytXMUF2cjg0ZmhBa0JCVkE5UTFyUVhaSG9xb1NY?=
 =?utf-8?B?VFlKRzJ3MlJiS2RiNGxSenpXZW1IWmpIU0VLQkl3dWNoRERnUmxUM2JKdlMx?=
 =?utf-8?B?cy85U2E5VXc2WDFLZWYvdU9ObGF3enMvUVBQUVpJa21zUXJnSnk5cmdPeldK?=
 =?utf-8?B?TTVQOWh4V2ZnZjNpMzN3bmtWdHBOQ0lvUmZhaUJGV01POXBSYXpMTjRwOTRl?=
 =?utf-8?B?Vm9Ea3EyM0hnWHlXNzd6VXJHMUE0K3VFRittU0QxSGJ5TWFLaHc4czdXMGFW?=
 =?utf-8?B?dUxva25PN0tscUxaL0RvSHZ1SjcyVUp4ZmdRL3JVWHNJKytkZ1BUUEtyc0pT?=
 =?utf-8?B?Z2JZTE9rdFNZckVteGN1bGx0eVlTT1o2YTVSeGpnZnFtcExSRnF1cGQ5dnJw?=
 =?utf-8?B?YlUwaWhwcFlHOTQrYjhuYWZKNWdFcjdyZ2ZLWm9jL1Bxd2FyUFlMQm5UVlB5?=
 =?utf-8?B?cjE5V3Y2NHNZNitJTzBvSEk0bUJ4RFNielNmYlh0Tm8vd2gxSzVzQTFNYXdi?=
 =?utf-8?B?RmtVM0dqVWVzM1hnWnRDWjRYeUdqd3JVQmUrSEJCdGlwZnp3S1Q5QnNac3lx?=
 =?utf-8?B?eVplbnVYdThHTnhPZndpK3pOV3lUWThzRy9ESnNwNFFWd3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhlZExSdHNOYzhHT0ZWOEQ4ZWlTaXY2cDZvLytGR20yVjBtN0lxY3Z3Z210?=
 =?utf-8?B?MGJIYnd5bm9zeEFkcVMzbXFLMEtqMFVYTWtlUTBaL3RaNDJpaXh4b3U0VndH?=
 =?utf-8?B?QzM4V2svY09hMzNvRE52ZXpoQ3FzZlJzRnBjSVhxSFo1ZkVjbDV6QkowTStC?=
 =?utf-8?B?M2VsR2c3V1RXWUlhTmgwZFZaeWllczZJeW95bHc5OU9NM1VpNmgrL2JPekFj?=
 =?utf-8?B?L0ZYbEg3dWhzMkhHMVJnYXhKemJLVWdteTVHaHI1WnFzRUpOOHkzOG0wbTgv?=
 =?utf-8?B?QzlBNFQyVjF6bGpPNjRTbFQ0K3lzWCs3QVhPUE03WjMwZmY3V3hUMkhLaUts?=
 =?utf-8?B?T1hZcTFpdnZWOHdNaS9HUFk1anhDV21OeUpwMTY4QkdlbGRqWWxHSkVaREhL?=
 =?utf-8?B?MXJObkRqVG5MbFVGUEt1c1VUZ053ZXlIZWdxVVhGM3k3UWdXV0lReEZBUHNI?=
 =?utf-8?B?UXFJOSt3RVF1N05NYVJKcXlnV2MvN3VST2h6Ukt0ay9zeHorWmtXZlhrMUli?=
 =?utf-8?B?SllUcTIzUGZzYkhNUkRJK0JpYTlucE40cFl1cE53STY0NmJBNVdaQmhyTVRv?=
 =?utf-8?B?RjZLMkdOYklFQ3FDanlvaDlOZTB6ZlpHQTJ5VHU2UGJJYm1ZeGZDWVBNVkZL?=
 =?utf-8?B?TkI5RWdhL1Q2NE5INnQ0QWdCU0ZWS2pKalJXSlpuWnM5dFY2enVIVitOQXJv?=
 =?utf-8?B?Ryt5MDFESzZmVFN5clJ4dWFweDBpbE1iTFdDd3Z0M2ZqLzZvdjNYS0k1TTh0?=
 =?utf-8?B?WlBlMDBHVVZNZ0paVWNKdUhDQjVMTU1tRWhMY3BkZGRHaVNMME5pM1V3WGhl?=
 =?utf-8?B?bDI4K2xSRVF5NENpazF4MUl6QXd3Q3lzSXQ5akpoWUQ2djRuUGRqUys0VEc3?=
 =?utf-8?B?VEJsbUNncUdJdjEvbkNPam5QQ29CZlFydFlxNkQxTTFjdU0rRDVORk9RZkVN?=
 =?utf-8?B?MnJ6ZUcxR1lnRk5kZXpzRmpPQkpYZnRjc0d3WWNqQUkyT0RoMFZ2WHJQNGNI?=
 =?utf-8?B?ekNIaExwbHBUNSs3WkJMMnJHdmx2QmFCOG01OFVpd1hsRmlpOXhKQkVyWTZ6?=
 =?utf-8?B?YVd2MStVOG1xckZWQUg1YjdWakZFRHNUeDZIS1F1a0ZPMkhIeHZjaGhkSi9K?=
 =?utf-8?B?YnRRV0tyMExUTi96ME1IQ21OWmN6b0RRM21ZUThqRzVqNTUwNDc2alpzRFdm?=
 =?utf-8?B?eG1Ra3hQTHFadENmSXo4WlFXd2wvTVBUT0pqclpaZk5pOFRPNjVJQnFLZzV2?=
 =?utf-8?B?TFZ0a3ozTVBqR2FaSFpNeTJBSWliTnNScUJRV0JJSHRoYWcwTDdxYTk0ditv?=
 =?utf-8?B?eVFudGJQZEp4YlZZNUxyV0hxaEY0dU1MR3NiODhNaEpZNVFWRlI0clc3aFFD?=
 =?utf-8?B?anFMOHFQRUQ5MUJIbWQ3aVd4eUMxZUY0bEtWNm9wQWlLTjhhNFZqMW9nb281?=
 =?utf-8?B?NXBRWFJiSFU5VU5yTHcrR3IyeEpFYWRKSDZneEdKMWg2SFZLUnJCUzArQU1N?=
 =?utf-8?B?b0dtMzJrb0NVQkpyTkJ0a3N1VGFtVHJvbXpIbnRhbFJHQ2F1bXcxbUZqejJW?=
 =?utf-8?B?NitzVWZYYXBTYkdlWjA4SVNzQ3pzZ3NqOHZUMXU0clI2QjVYSVFYVVdxak8y?=
 =?utf-8?B?TkJSUnEwWFlWdlVBMUEvVXRFYXcvNWFaNlhDZ0JXL3hrUTdjcUpMR3A3Y0RD?=
 =?utf-8?B?VVcrRWd2M2xqVUFONjNVbkNkd0VxT1NKeXFoZUNWdDB0RUFNTFJoa0JzbkRT?=
 =?utf-8?B?K3hPZHUySE05U2N0b05IeFJzeXY3U1huNXpEem53WFZjbVlzYzlRM0hIaFli?=
 =?utf-8?B?cTBUZTdyQnE0ZDlDRUVYZ092NWkyNGJKRzFoMWVyaXpORXZ5aENIbFViV0RK?=
 =?utf-8?B?QWZTbGp2MzJZTVpsQVRrNGdqR1R3RGVjdlFtZWJwNmVESytzUFlrYndoaS9I?=
 =?utf-8?B?YnhJV0V5RFVlek5TNXRwSGY1V241NlMxMVZ1a3UwSU41ZUpucFlYUTR3ZWRr?=
 =?utf-8?B?ZytWcXc2UVVYT3NQejBQaUJJRFpOaEJSQ3Y2cTBJcS8xOWZVTlNBTWxUZmx2?=
 =?utf-8?B?TFVwS1JOWWNZRklJN0FYWVBjZXBOVnBqWEt6aFc1TE1ldDBCWWtCazA3L21o?=
 =?utf-8?Q?Hz5p12RdztzA1RkmyHu7dIvms?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794e293b-caee-4436-8bcd-08dcd8401699
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:54.9964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38OeADTSil/ET5TkAA4a18FCsNpMyLRaSTDtsCDSoKCtwCm/T7d3Tvf59X8GoTnN6Rzc73IkwWqkU2MXAxad4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

From: Ye Li <ye.li@nxp.com>

The second Ethernet MAC (eQOS) fuse layout is changed since i.MX93 A1
following other i.MX platforms, for example i.MX8MP.

Order for A0:
MAC1_ADDR[15:0]
MAC1_ADDR[31:16]
MAC1_ADDR[47:32]
MAC2_ADDR[47:32]
MAC2_ADDR[15:0]
MAC2_ADDR[31:16]

Order since A1:
MAC1_ADDR[15:0]
MAC1_ADDR[31:16]
MAC1_ADDR[47:32]
MAC2_ADDR[15:0]
MAC2_ADDR[31:16]
MAC2_ADDR[47:32]

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index f3d6c7f84cb..7bc896b74da 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -504,12 +504,21 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 		if (ret)
 			goto err;
 
-		mac[0] = val[1] >> 24;
-		mac[1] = val[1] >> 16;
-		mac[2] = val[0] >> 24;
-		mac[3] = val[0] >> 16;
-		mac[4] = val[0] >> 8;
-		mac[5] = val[0];
+		if (is_imx93() && is_soc_rev(CHIP_REV_1_0)) {
+			mac[0] = val[1] >> 24;
+			mac[1] = val[1] >> 16;
+			mac[2] = val[0] >> 24;
+			mac[3] = val[0] >> 16;
+			mac[4] = val[0] >> 8;
+			mac[5] = val[0];
+		} else {
+			mac[0] = val[0] >> 24;
+			mac[1] = val[0] >> 16;
+			mac[2] = val[0] >> 8;
+			mac[3] = val[0];
+			mac[4] = val[1] >> 24;
+			mac[5] = val[1] >> 16;
+		}
 	}
 
 	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",

-- 
2.35.3


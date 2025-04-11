Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EFDC369A6
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0554E83E4C;
	Fri, 11 Apr 2025 04:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lp/DU8pK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62AD983E61; Fri, 11 Apr 2025 04:46:34 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD28830E4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDoBAXNi7r95xT0W5EpTORBSI/QwxbwRM0mdPZH3aVe0GDoYiJr1OKYzl4eHC/ESBo2uwLfAaeTRUqagfHXAVkiVWikIfBVuplampUYCiFt73D9tTy7kJaYdEFAl3qSQDLdh9kU9HSt3Z5/xpbREv6LiM9PcUpoqBftmX8624Y9WxhSYR1ioKsywnmFb5gMJSzAiBt2Biy71Y7Vs8gEVuUbV5guhAAxPz4p5DuP0uFxQqbMSrloHYhVYyO9vLuqTFV9DX96U2mgwWlWjoGclqTx9ZzuYNDj1Q8Jy/sWb7wY1S27TzZ+y4kOilgN4ezOtMjMEGvBIj03xJcVod+msKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nu9JPxjFheANSzRlz7rb9RnCF5iUscRchL3WeEC4Y4=;
 b=E7RreDTYtov4m3I0cIaprYDc1LVlifiU1FTsqXEMtGaps8374dAJ5Cf955oZ84bH9otV4FAdrks+0bGOU0yh0brWUKA6ei9r7LEWAcZlqcRx7ZL/dzrNXNApPrrB9bNL0xMh/cOxXASZG1d6HBWAyEduUD3GNlaYlmHN1Vm+FkAfc7HPJLmEIb6c2/JMENrgedv1g9GzWEN8kFq3cMo562XEJX4ijJRIIGWPreWMoSOA1OprstWgOVGJzbXtHWQtCMD7ftVfBlGTUI727S+MwZ1jnvDNwJ6q3l89YJiyYc/QHpf9xg/pk29WZoOcZQz2b0dH3iCPgXftgO04xHiIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nu9JPxjFheANSzRlz7rb9RnCF5iUscRchL3WeEC4Y4=;
 b=Lp/DU8pKQCVGIMT7fvNmb5/oZtBQBx3Zh5i6QVmMoFjUY6D/h8h9iW5K7NOUKl3sgxrNSyxalKXE+AGf20S7Z9EdBME16D7mfQb6Q7PxIoV7j2UGZbxiUu5y2eMyYYbLQW993kw8sNC2m+vVXbKCxeSF1aLaY8cGxn43RKhbOAceEC2i+yNbF3v2Og+wGqZUqNdAkPUOGmK+TqbUylogFZpL4/GHgxIA4GWbzHZFuwLN+SnQT74tcBfevo9ZPXwEQ2XzNmGjgGi0YDZG0aeWyRGfENtxGkgueE7cRsuUxauvqBp4phOsYtluwBcX6hUBBmz8R/nXUNFplckza9esyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, jh80.chung@samsung.com, trini@konsulko.com,
 ziniu.wang_1@nxp.com
Cc: Peng Fan <peng.fan@nxp.com>, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, tharvey@gateworks.com, jonas@kwiboo.se,
 sjg@chromium.org
Subject: Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron eMMC
 BOOT/RPMB hardware partition resizing
Date: Fri, 11 Apr 2025 11:54:22 +0800
Message-Id: <174434362346.24440.652411300083913191.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
References: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f349331-1f9a-4fa6-9b35-08dd78a31045
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1ZSNERuOGRMQ2p5RU1USHZ0M2lQelg2UlNaRlJPZTBqYitkWTc5M3A4ZVQz?=
 =?utf-8?B?a0x5YVlwdWYrSGN1MGhkYkdwZDlxenMxMElyMDdQZ1RCK2F3YVNOTmgvcEV5?=
 =?utf-8?B?ZG1lckVkTTJITlJteU1ZYlRER05qdHNpQUE0WGRYbEh5N3BhUnc0R1BIMlRP?=
 =?utf-8?B?K3gyRUxmU29iWDR4bHlLV1ZtNXQrYUZWQWxhd285c3ZpMXRiY0N1WHdnVnV3?=
 =?utf-8?B?b2czYTh2MzVGM09hRjUrdExVRVhYYzRLSkhNcFQxTzBkbVFaRmR3dVpMM01l?=
 =?utf-8?B?RGkxdVdZNGU5UU1xbnZ6Nm9QRDdrbE8rdzVGZGpGUGdoQU45ZHdFL013byty?=
 =?utf-8?B?QStxSjBabFBHL1A4UnFIOGMzbFIwYVdVZWFVWGNoR1h2Sm14WEFXaUlUQy9S?=
 =?utf-8?B?cEVoVnArcVBaZ1d5akg0MXhxdWExRWxFWjlWTGZ3Slh1YmhBM1RGS1J0Yy81?=
 =?utf-8?B?Z2JQRU52NmNpcFdQR3FGZkhhNmRsT1ltZW1RQ0lPL0t1akJocFFNL1FjanNW?=
 =?utf-8?B?NVo0OEQ4RW9rQUw5cVg3YzVGd2txNzJYSTZuVkF0MlhmWFhRNFNOUytEeGNj?=
 =?utf-8?B?YWhqYUEvdGJrZjNRc2l1RzVXOFdiWGNFNExjb0hmWXZrYmZ1MUZucy9HN0xM?=
 =?utf-8?B?WVdVTkZLcXArTE9Gb2hOM3pOeWNHdXBBdVp2V0tUa3ZWS1BLYlpoNVRuUmNh?=
 =?utf-8?B?cEpQN3AxY0NXN05NY2dONlZYZXhrZEc4MDE4Q0ZhSnJmc3MxQ29RUFZtbk9F?=
 =?utf-8?B?bDRUYThiekdTUTRVVjNDbW5EQWRMcEVpdnVRT2tLVlRUVmFEckYyd0NQSStQ?=
 =?utf-8?B?KzVDZGdheC8xdDc2dUxBWERlYmhiU2hIazl6MkE1QzkvZit1NEZJTXpNQXNT?=
 =?utf-8?B?bUFGTUV1ajV4cG1wUy9hMVMrVlRHbmRpQzFDQzRTZUZtdk11MGlZOEFCSXpZ?=
 =?utf-8?B?bURxNHZwdjJLdXo5M1dDR0VRV3V3WlkrbnNLTXg1WG1VMmNSWUFhR1A5aENh?=
 =?utf-8?B?ZkhBRmJlTTUzQm11VzdYOTJDcmNDNjNNWkpTVTFOeEtTcDFhNkl1M1d5SE54?=
 =?utf-8?B?WjZvMWZlQ2RDQ1Iyam1CMVczVUhlbFgxKzNQWk9EY1VDNUR5YkdibVJXYjN3?=
 =?utf-8?B?NTdpZWVhUTBDNlczelFycUhOS2p2QS93R2E1VXBhc3JYalFuNHB1bWtIUXJN?=
 =?utf-8?B?MEo5SXV1elQzNWxUb0ovZ1MzN21RNWZjTCtkYU1OUUtqMkZCQmZnVVRCNiti?=
 =?utf-8?B?SFB0RkpXdEFwcVBqV1BQdFoyN0JMbmVMcG4ycjB3dU9LaUtBU25wNWltNStR?=
 =?utf-8?B?MmhydkhTNnpudGp5cnpOUmNmTWFDQXU1Z3M5RU9GRmtGZnZiRkVPNTNMazgy?=
 =?utf-8?B?bHppeUNERXYzTVdPTWNYZG5wNG5iRmJyd0djcWRVQVprenRvZTBrS1dUNlRl?=
 =?utf-8?B?ZWVqSnp3cGpUQUpNazZnSk5hVDZXd0I2YmNVcG90alBMNlU3UjZMMStzZmgr?=
 =?utf-8?B?WkxmRUVvRDBRcyt2TE1ZejF6MjFRYnNZRXF1ODNyemd1cDdDc0xzSUVFd2d0?=
 =?utf-8?B?Unh5Um1uVUlCMDlIVi9tQjNCdWxLaFZaR0lpZXpCNmlWTVJOdHFsOFZkQzli?=
 =?utf-8?B?eFJidGp3SEt4c3FXd0FKc2c0SngwNTJBbVdRQXhUZUpWTVlScUN0cWZucHFz?=
 =?utf-8?B?VzNscXB2eVQ1ZGNjeTFJWVdQaW1henNZKzdVdFhxSUk3Si9OV1dUMmlpMFJB?=
 =?utf-8?B?U3hOYWVVdVErTnRveVNNQjZna3hGTzFRcDdHbWM0eE9QVDA1WE9yTWNNVDN2?=
 =?utf-8?B?UmtiNklNY2E2SGpQRm1LL1R2bndTWFY5anNlcFhkQVFlZjMrNWcwTExNV1Nq?=
 =?utf-8?B?UFpGekdodTlKM01hcnRQU1d3T1BGbTV4c09SaDZmWW90bkR6SjJXckcyTlVw?=
 =?utf-8?B?UHhpWmxvc2RHajJxSzdsSnVPRHpUdFdzQS9NRE82dTJBanhjVUFLNDRrcXJy?=
 =?utf-8?B?YXRTYXJhN3FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpVMjFTcWtoT2pCSENva09qeWJHT0FWTzdycENBc1pmNEkyNnNnazJ6SktU?=
 =?utf-8?B?Y0E2MWFKQlliNjRFWHdoZUZyUkY3c1ZvVlo3Z1F0Uzd3emRzd0dBL0doMFRG?=
 =?utf-8?B?LzlKRFVRYklQNmlNbWpMa3ZyTVNwMHJzN3pFSHBMNUJGNVhTV1dPWWY3UUpl?=
 =?utf-8?B?TUhObHNkQ01qb0xQVlFVY09GSVVtV1llUVgreXEzQUlNY3F2c1UwRkY5ZzQy?=
 =?utf-8?B?aFJTakllNnV1TUV1TGs3RFJFV3h1SlcxcExyYm9rOTA1Y051WGE2Umh0VWVo?=
 =?utf-8?B?NEhtY2VKKzc4RGNDRnB6TDJaTXd4ajlyQVI0VW1qUU9HRTlmQytNVE84MHBw?=
 =?utf-8?B?OHpxS0RlaEZNMFU4aVdsck9mbXVlaFRvditqenI5WWJ6WDFtdWVGVkdDRTNw?=
 =?utf-8?B?Y1dvaGhkOEVTSlNkdjYxUzZ6aDBJRkg2MnYrYkFVamMzcWh2TmlEcmErOXZ6?=
 =?utf-8?B?bDlPTFZlSzVuRDUvaUxwWkdhM1dRUkp3d3ZEYlljUUo2MWhHQ3o1cW1pVDNi?=
 =?utf-8?B?TE1zVEh1TmRWZTZaNDlQcWNUQlZablB6clozNVlMbk5tdmR2eVlEc1JPZm51?=
 =?utf-8?B?VnViRmJuOFhtOWJmU1hJWUNMYUlmSTk0R0VzODhOS2VFbDQzQS8rY1BNL2Nl?=
 =?utf-8?B?YmVmWkJpaUIrT04zdmpWUmpBTFFSMjBJWk56MW9Wc1ZFZFQ4eVducjNOcmlk?=
 =?utf-8?B?TEFIcGZwYWtOaksvRjJpeWt3TXZ3bmcyelZGN1dCdWVGbmdLR1ByWVMyL29x?=
 =?utf-8?B?ZFkxWDBPb3JwUlVCckNhS2k2MElNczN1dDBUSmJaSTZLbVR2UC9yU2RtQm9P?=
 =?utf-8?B?ZEdncW8vRFJBRFBMazgrS3BiV3BEZFR2eHpER2FEWEdybGliQ1R5UXgxckxu?=
 =?utf-8?B?UndKQU42ekFoN25yd0V1cnpHODU5STVESmlEcVJIREM0Rk5uQXZrbnJrYTdO?=
 =?utf-8?B?SCtLcEEwQUtuOGMwR0dQNUVxZTBtQTBMaHdCdUNibW8vOGR1Q0J2WDhjcm1r?=
 =?utf-8?B?dW52TVVuRnNKOVdLRjV5WmliaWh3MEoxQmFTNHY4WjhUc012OEJPQW05UGJB?=
 =?utf-8?B?L0REajhoZDdOU25nbFEyK0h3MWpPYWtOTzdMbFlpQTRhQ2w3aHNUM3ExNmJY?=
 =?utf-8?B?S2pjcy83TXFPWmN0WTFscDhEZU1lR28yRVBHc3R2SThTVitYaUJ2WnliejJs?=
 =?utf-8?B?Uy91djhVdXdhblpSdm5BWW42V3NkRHNTU0NPZENJdDFUT1Y1RHU1Uk05U243?=
 =?utf-8?B?TTBZQjlGTDVWdmh6bURYVVdySjV2c3h2Zk5UNVArcU1mMEJDL0QrcXNyU2E0?=
 =?utf-8?B?dFFwVnN3em50U0hTbHV2T3ZnVWhJV3FyWWFSOWJoSTd4YTVDTGFBUHpJcXFt?=
 =?utf-8?B?N0x4L21HKzdqeURvdWZUZXNZWEtpVm5Cams5VGhsOWxYS294SGI0WDJTZFRo?=
 =?utf-8?B?blhMVEFEbG94UzNRa0FacmhFK09kME1scnJuWXdpZGo4SzZaSDk0bXJmUGVP?=
 =?utf-8?B?dGozSmtMcDJiNkhzOXo1TmErUG5NejdoemgrQjcwbUFXY1hEMVZSYjBHWFFq?=
 =?utf-8?B?Sm95ak53QVU0czI1Z2hObXJkdlNLb0IwVTFneDhhbEVPeTRDZlArdWx0ZXZP?=
 =?utf-8?B?S0dzMnVxbG9YL1VpOTBHSXRTbUh5RnNWaDlzVnF4eHk0QmZZclkxSW95bDBX?=
 =?utf-8?B?Zlc4YmpDb0pmaER4cWZqNXphR3UwZUpwRnRSRzlzdG1SRVVMK3M2cVVpTHR1?=
 =?utf-8?B?Y1RQTURrVklWdGdqclV0RHgzcHdObjA1VGhyMXFGb25QYWdBQnRxaldCQnVx?=
 =?utf-8?B?Z1JaR2VYWWt2dDZzaVVoVzBZNGFselJhQXhXZTJoaW1pdWxwa2NpRlh0bmkx?=
 =?utf-8?B?Y043MHpmcFQ4QmRzL0pPeGlRRGt3U0dqRzdialE0ZEd1RE5Hb3VVQ01NNnJw?=
 =?utf-8?B?VG53YjlJanRhUHc1NDVUYlV6Qm03MDRyaUZRVW5IMUR6NG5HRHlwQ2hWTG5o?=
 =?utf-8?B?Mk1obDJUTUVhMDFNTGNtbWJJV0N2Wnl4aTl3ZzUwblhhVlM1NTFwUm5JaGRY?=
 =?utf-8?B?ckJBUWUvS3ozWWtJeVFHWmt4QTJQUXRDazJyMWpVUk4wVHlsMXpkWVpjVlFV?=
 =?utf-8?Q?8eYa8qJOzhSoNMS2nASeLifFT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f349331-1f9a-4fa6-9b35-08dd78a31045
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:30.9762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTXPuocTch4bvaB33IZep2CGDAJ7H7j8llcjfh0CZOoPoXK0/JaqM1GCDWeDTILFlMJxN1vf0mubIDqlqRgqTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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

From: Peng Fan <peng.fan@nxp.com>


On Tue, 25 Mar 2025 16:29:14 +0800, ziniu.wang_1@nxp.com wrote:
> Current mmc bootpart-resize command only support Samsung eMMC BOOT/RPMB
> hardware partition resizing. Add Sandisk and Micron eMMC BOOT/RPMB hardware
> partition resizing support. The commands and parameters for resizing
> partitions are different for each manufacturer. Select the corresponding
> function according to CID.
> 
> 
> [...]

Applied, thanks!

[1/1] mmc: mmc_boot: Support Sandisk and Micron eMMC BOOT/RPMB hardware partition resizing
      commit: 7550bfdbf41b721f750a62b87a42a3329a2e2f81

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

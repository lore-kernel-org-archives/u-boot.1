Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31115CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8B083257;
	Wed, 27 Aug 2025 09:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m4URa3Rc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0FA8320C; Wed, 27 Aug 2025 09:35:23 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5597B83192
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNofgaLMl0l07YsT12ktq2iLI2W+cFNWsn8uPJ2S/6igOF3Ra3wHROL1/pkmgun8uYrk4sObZ4cFqhmHuETHNYR8Nd3UyBkFTzBeY1kSY5DRCwOcCrwU8reDNxsMN4gOxBT1DPvILQTUtH2MkudqZij/WO7xj0Fh00fKxShY7jGzfnVrrfnLhWLgg8vB5h/8ShVhLvqrWR6xH3a7RGVZigjMegjP7wgrh4JO8A++gltiDeyBib0s+WeILDuVsQIrXqPtb3QRYDEkBub9RCZ/tbnFJr+xAZQOxFnTejsVwKRUmAlFXEg4LuXEPALnmFixCe/avPkvfjKll22Z8YdDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO+or3WvHU1zadJFDjqTWIO/0TAGca7voIIsowpu1Lo=;
 b=yK022IOw4EaIvZKNjh1cA4/RHYefEa2AB8g0O2AWtfFao0jRdNMfGWMRMWuu1uJcNaAqBu1rpGD5OPkZqwtxTrtohvzt0/E0r0tUAx8q040yCwRSKlzTS9uDE7HU5axls+NwpQiSo+FUPr9UEQTtxUwj0yJPn1FC0rraLMZZZ0v2kSKEpCgXmRka3BTpj3zUAPPwcXC9QUVpWCds3U/rZrzqgGvUJYwb+dqOzhnPx9vWHNdTBXEK4v9a7ucZIRfVtc4CpL29TvVzCiBcoXLRuEYAyQ+65h64i94siDZpOK2NkvDA1VPqSWt3iQ8YmGc6NLDMdmKwWjYtdxawOf/W8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO+or3WvHU1zadJFDjqTWIO/0TAGca7voIIsowpu1Lo=;
 b=m4URa3RctI7STrliK/ixCtydfamT+hEyvHo55r20aiRuygECr9pdl9Y+mfKHkBL3BzYnj0hhxxz+frGMak/LRUzDQNPdluq/mvg6cOtNsofnpbmTANWBh8Ucs4dDY8W2yiOw60d9tWOcX0tKhuot6zpgxFEccEn8/FNlx8xi3rGBIeo3XURphW8PEJnpf5BkkJ99K5sNqSqdZimvnJm4zkUcKjI1i3ow1pyYCs7mB2fIpKJZHm3pFTAsou1GIZHIDgdvxsZuZTbHkKw2rCxPO3n52JRq780NF+amBQaxzizaOvJ8rpgtAf8g2kbHIHEcBR7+2Q09RE0G0m5hTK1uQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Wed, 27 Aug
 2025 07:35:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:35:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: Peng Fan <peng.fan@nxp.com>, vladimir.oltean@nxp.com, trini@konsulko.com
Subject: Re: [PATCH] fsl_dspi: set scaler values for CS-SCK and SCK-CS delays
Date: Wed, 27 Aug 2025 16:46:09 +0800
Message-Id: <175628406774.4168.17181831217319241860.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
References: <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e11eccb-6685-4d55-d9ed-08dde53c45ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1Fjcmg5M2ZzekJzWGJoeWRLRDJVRzFRK3p1LzVBaFp4bEYyVnlqMFpuTDIx?=
 =?utf-8?B?Yi9oRHdFbGhQUEg1anE3V1QwMWJFanV3Q3pOMVFLdlZLSitjc0IwN0JtcTRM?=
 =?utf-8?B?RFE3ZWVVL0Jaei9OanFvVWw3VFZlN1ZSL2tJTFUwdWlIcjljTVZONEc0WndM?=
 =?utf-8?B?UitvV1FHMjYvQU5wa05vWGhpcTVmRndzYmZrV0I5M0p2OWdEM0JvWWxtSkdh?=
 =?utf-8?B?S3J2dnphY24zbEM3bHA0YUhQQ2ZvdGdnendnWU9XaS9rRkV1ZzUzRlFyOGxl?=
 =?utf-8?B?d1Bxd0VJOFRXamN3VTlZSlVQWG14NHBsQWFpOURKV01nZm1lQkc4c2pSNVd5?=
 =?utf-8?B?dVdycytRRmdjQkRTTGVlY1ZLV0N3bG1naHhWcjZDT2RmR0ZueWNNT21VOHdD?=
 =?utf-8?B?czZwM0lvNW52azJMVG56SG9HSGcvcVJCdVU2M0FVdjExbHlRaGVXem9BSUlt?=
 =?utf-8?B?SXJKNU5WSmpaSTB6UmhGM0IzcmxGdFNkdFRMSVVWR3RaVDEraEVzMlhlT1BB?=
 =?utf-8?B?ekxLMlJxUEZuK0pRcXk4QWZFZnNIeEZldkhGa2xNQkxJTFlxeUdCNEI5Y0ov?=
 =?utf-8?B?a2oyV0dXSG1tTlVYdWxZSitsUmZpTHBKM0t0K1NpVEd5L3NrbEJEQXJzUmJs?=
 =?utf-8?B?NVJSK0l4QjRuUjdtbWlEN045TmpDY0d6TmhWZHRMT3U3MG5LOTdDYXRGOGV1?=
 =?utf-8?B?K3R1N1QyRG1tTzhjcXh1ckVNb1RoS09rS2JyTWRBTS9pcFI1YkVRcmJVaFpY?=
 =?utf-8?B?am9FUGxva090OUpzazdHcERqYTJLanZadytvME52aWV1aElhRk1zd2NrMHRo?=
 =?utf-8?B?bVhXbTE0M1RMZ0FBeGdIZGdySllCZnFzWS9sSi9PYkRDZkxXc0QzeGFXeTkz?=
 =?utf-8?B?cCtyVHZhMFh6TFJFbllHWnpqTnN1REhZV2FSUmpyNjc3cmQvSlAxeWRib3h0?=
 =?utf-8?B?VGNOSE5xWkpTL0tVZXoxUUJEczlDdHN6M0pSMHF2V3VEVkpsSDh3OGhVOEto?=
 =?utf-8?B?V09HNUk0elUvdCtJVlN0NEI1NXhRN1RGSysxcm9pb2x1amJYY3Z3eEdKUGZl?=
 =?utf-8?B?RDRxb3V4eFkybkZ4Q2xUTUFkanhwcUNmdk0vL2hZdlVIRkEreFpUYTY4aG1m?=
 =?utf-8?B?Z3lFRGNZODZBR3BQQlg4UGJ6QkhkS3dETTNwbktXR1R2Snk3OXBvNGpFdXo1?=
 =?utf-8?B?Vy9hdkVaT2RzNEcrdjBYTXNWVlpjRzF1RU5jRERQWkRQakhvNTFsaHh5MFpS?=
 =?utf-8?B?RzJhZnl3LytpK3JiVlBiYWIyc0FjMlV2VlBSQ1c2NE04citZOEVhRlJnd25q?=
 =?utf-8?B?S1BqTFIyQzNVNmx0RDQ0RlN4bFV1WXUyRjB6THF3YTVQRW9OMFF0SzJOeGJP?=
 =?utf-8?B?L0xoSjhDdXQzcmtrTWw2ckl5ZG9jNDJIYWdVZkZJenR0bDgzZHRoSTJtdTBv?=
 =?utf-8?B?TkpFZnRFdVB5Z2w0Sy81eUdyN1AxYVgzT2IyVk9HQTZmdEVsYUtycWpaclVt?=
 =?utf-8?B?MkwvVlZIYXpNMXlWcExpZnQ3d29UM05UdmVCVmg2Z1lHZTZJb2N2R1BGMW9j?=
 =?utf-8?B?bkVsa2tkOFBZcndDWGFGazMrYjV0WE4wbjk2YTZlR284UDVZeHlnRXZUQUc5?=
 =?utf-8?B?bS9sM09CWWp6ZzNOWUFCMGVVdlZRb05wZkw0M05uOTJnelp1S1E3K1I3MDkz?=
 =?utf-8?B?L1lBaktyL3dPZ29ldE55MXBDNE1HRmJsczFta3NoMmNvMDV0WW9XeXJVTEFS?=
 =?utf-8?B?Z3o3MjgyZnBzUWpaNWQxRFZsWSt6aUNKTnM1VFRoVzRzMm84aEpnVno5czRG?=
 =?utf-8?B?OHYzVjZzTDBCam9tQks4b3h4QjEyVnd4STdjUG43NXVHZmVQU00vZUwxcWhE?=
 =?utf-8?B?UzZ2bGI0WXNveDM2UGZQeXBVKyt6MmpZUVZtQXRHb013YWs1Q2hEMVRHUy9K?=
 =?utf-8?B?THlXRXhPVXp4ZmdRUWJTbElMYXhubEV4Z2pKTW1sNEhTUDRKbkVjSGY5cWI3?=
 =?utf-8?B?MGxPSEk3b253PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejY2LzJ3SlpTN0FGZjJ4TzhhaENJNjBMVzZBdmdGRFJxRm52SlJ2RENGSlox?=
 =?utf-8?B?THdvYzFQb2RNUnk3OFp0ZVlJNnFSWFdJMHgrd09NYWlZaVIxSEhJRG1neW5M?=
 =?utf-8?B?bFhpekRkRkhFWEpMLytqMEI3WlJiRUcyM0paaHFiRG14MEZtNUt0MjZ4ekR4?=
 =?utf-8?B?R0FsRHk2SG5lMi92YXIvb1ZSTUdSVDdUR1lmUU8zVy9OeGFST1I1R213aGx5?=
 =?utf-8?B?U3A4K2xFblVjMGtGZzNSTDlSa0pPTXJQQi9nWkQ4ellZR0YxN0JyaUJaRlhQ?=
 =?utf-8?B?MzR4V1NUbzE3Q292ekdENHU3TXh5cnI0b2x2RkpjYzRRcmZJWEtPK3NqWGE5?=
 =?utf-8?B?UEV2RFh6Y3BrVXJsMTZza2N0Zjl5WWkwREhKd3ZwS0NtZWNxQ1RJL1hmNk05?=
 =?utf-8?B?M1dtbnBsN0hacUFJbFB0eDR6anA5VFc1RWd3VGVQRVEycDJzbUhlY09tTmpy?=
 =?utf-8?B?czBSajlTMTIyeEFGMGJqN3A5VlFHNnIzOFJIRUYyMm4zczZ6LytIK1dzTTBB?=
 =?utf-8?B?SHBPb1V5cVNsSzIzU0NnZEtLdklhZnBESDFLbnRsd1RYUjlUalBOVXA5K0Q0?=
 =?utf-8?B?VXoxVjgvQlROb01SRXpDMTZGMXFLYkpMWmYrdDhPZHVRdThacUwyZUs3bzR4?=
 =?utf-8?B?a2NXWCsySUk5UEQwamE2QktBOFdveUZBNldLNmplZjdqa1ZNdVZvVmlSeGM3?=
 =?utf-8?B?WmNBS3p6V3ZjanhWcXFiL2FrWjZSU0ZNa2lMTnhBWUdXN1JaeGsxYnBrL3Bh?=
 =?utf-8?B?ODloK2M3b2xYcEdBVlgvd3JzL2RFMFlHOVdoeFRhNyswdUxFL3RtSnJQZGZZ?=
 =?utf-8?B?cUV2aGRZSWx1YmVkajBYR1ZGRHdac2p0a21UZGZockd3Q2MxMTJmbndGcGJH?=
 =?utf-8?B?Tnl0K1BEeEpxR0sxd08veWNnQU4zYUZ5ZjU0MFRLSU5menRaempRWVJiVTg1?=
 =?utf-8?B?Ym5Vc1RMTUJ0Yi9aSkhaNklzam0rQkFzM3pqblBmd0NvZWtYU21FN2t5Q2wz?=
 =?utf-8?B?SXM0U0t3WFNqR3NQUGx4UHJORFM4amRyeU16bms2NXptTVpmOEF5Y05NZnFU?=
 =?utf-8?B?MERzS0tkV2x5RmE2R1FsVld0VkFzRDdyZ2lubHh4WHRsQkkvNGtweGJDM0NF?=
 =?utf-8?B?anRFQzlOTE42T1c3WUtqdUMxQm9qaUpXWDZ6VFI1QmZRUUlRZVAxNEpUR3A3?=
 =?utf-8?B?em45bjJsRmRYMlBiS284SlJWQTRIOVloczAxODhMUGR1QTZXaFVIaXEyS3Ay?=
 =?utf-8?B?L21EcERYV1VTYVpOS08wTUtTNndtYk5jK2tva3dMTHFaNkl1QUNJKytSd1p4?=
 =?utf-8?B?Mi93SzNLMGNyQ3pKU0tqVWthYUlkSzQvMnd4T0kwcmh2Wm9DV1VrMXRyTXJv?=
 =?utf-8?B?NjdFdnRBbGcvWUlrT1BiVzRSRmRNNnBURVRiMnl6Zk9MNEF1NHBOYmhUMVkx?=
 =?utf-8?B?WUF0ZTZXbzQ5cElWVkpWK1hCaHdHc1N4MHJlYlJ4UmdRVng5bWZ3NEJxMXZ3?=
 =?utf-8?B?UGgrdkE5OWNEbVFIZFRYMHVkalZHSFRWTS82aHVQaTM4NWVzU1l1UkRqM05B?=
 =?utf-8?B?Zm5EZmdPMk1nT0c2MjI4T216WDF3SWxMNzMyblZvRUVWRzN5MW9XMmIzeWU2?=
 =?utf-8?B?aFdhZkFmRVlWcHE0dXBTMmd4aC93MDJtbm9BTUIwL2pveFV4RDZYcjRXYzNF?=
 =?utf-8?B?ellTaEI2SkdmanZFbEl5VERXTzJOdDYzQ3BuZHBmZGwxbHdFakRLdjRLQ00y?=
 =?utf-8?B?QW9KYkE1MzFsSGdnT1NEbCs2c0ZrUytZcjlTZGtMTnBnTGpQdmwwM0VKV1Nq?=
 =?utf-8?B?bmd2WU85TmEybjB3c0JXL3Zpd3lBOC9zcTBzMWJsb3RGVTVWR2pvMitvRnJS?=
 =?utf-8?B?bnpYK053Rm01V2ViYWFkTjZaQ3ByT3MvcVdSeXdjTE52Qndya2hQZzErdEZL?=
 =?utf-8?B?dlhxR2R6OXlaZ0hSS3JNQ2Y0OWFaZUpKckNMSGZDdFhranhrWXdjdTZ3Zlpy?=
 =?utf-8?B?N2g1Snh5UmZtVkcwaWQzWU1OY0MrMUVHYmQvR0pDeEtzT3RBWkVMdnU2UWNH?=
 =?utf-8?B?WlZQRkhsdE02ckM1cTBzYzVKOW4vS3czZmQrallZdjFoS1k3VGt2MnJDOGFy?=
 =?utf-8?Q?xkMRb+NqxMLSp/CLIg1DDhH5u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e11eccb-6685-4d55-d9ed-08dde53c45ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:35:19.4650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGdde9CBRxTX++NhL5WO+RRSr79XyPbldHu8Yh2NgZCU5S3hgiqlhVESHf5b4/ziYXW+b8UrH3TA0zn4jQPP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
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


On Wed, 20 Aug 2025 10:17:19 +0200, Tomas Alvarez Vanoli wrote:
> These values were calculated but not set.
> They are required for the calculation of the delays, as stated in the
> "QorIQ LS1043A Reference Manual, Rev. 6, 07/2020" page 2172.
> 
> The delays are calculated as (1/freq)*PCSSCK*CSSCK and
> (1/freq)*PASC*ASC.
> 
> [...]

Applied, thanks!

[1/1] fsl_dspi: set scaler values for CS-SCK and SCK-CS delays
      commit: 1363f9c1a0652448687a4a457507881aa1670ba2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

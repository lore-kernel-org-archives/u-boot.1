Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F574C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EAD81273;
	Wed,  5 Mar 2025 14:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bdSBfLkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77752807B1; Wed,  5 Mar 2025 14:28:59 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56144807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIEoDPhVd1Ej+V8XrLnoFC2p4Gm7Z11rE1NuwPflJCC1zoX4RqYIOZ+9uucUWDTpMP+hgKejfsKBSALqmLoFpK5oRHX5s5VM1VQAiIt17CJtKvHIyJOzHFCByDVpP5bIacKba4zikGBTmXk7MhcqNuXmbyKe9NdTfvWM60aysEAQWMx7o/zESI6ScjO2IO4cQxNl43+ISdI+M4IVA5UTiiRAehg9d9lD2f0T+9sxQIqIdCunxxKKvBY6DImXSJc9ZkNy76sX3/WazkNzRpkOkHSm4VnpYDmBleQYYbXpRm+xg7asgAUcD5vOzGifQxTgD+poU/PIJDfe29ZlBrpCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4snUcnN6xQV/p6mYUyVNDZbSfwNMx2voioutK+n7s9M=;
 b=RXpisv3GrCt93GKZIH/YhEFT+ANJ2iLcnsuGP0ZVcX3bLye9r/OSu562nPt5icvJ2/hl1TMEdxq86MLVaqdZssmZ81pGfKfKLalJnPPM/zar5k7iEDweY4kega+PS7Nk6UkfxPq9FOLwwVm413dVxA8X1Atww89FgRn3qWw3lA3zdXmqqmVuIDutpNzo4XUEzeqqIgR8rFEIRsTSENjgdZq5rnNCgXzwd/w368Xl6dyY+wohbg6bf0PxtQhTE5DPFL9MxvjOx6ji2VreaH2XWP4enmWkRybCdLvgM+HCB1avGzBzJnxX62CTLWu4qsn/qFTVfHHUw4L6qnwEY4rvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4snUcnN6xQV/p6mYUyVNDZbSfwNMx2voioutK+n7s9M=;
 b=bdSBfLkFlWDWTp9BEdTf6LZM15DwM5FSmzr66cJCEjlFHkV+6PGZa89qQV4GD8Blmlmi3jLzKyzFiPPjsJaCAxwHxBngY+v8r311s6CuLPe5rG693NMjj6YbrbruWIXgI0ZzHvox+ofTf9y0zR3gRDdzs++HOIHVRJmyoO23xoqQAXB+/AK2pMgVwPo6ycumdnsz4Fo/4EexPhMVL6wqP1V76CKqoTqyxHoSM024i7JOPYzHuS4dZEqYu/NJIj0HB+7RWFH8abYfYAZiL5/pR5mlpPJuUvXKj6JHB1nzUS8F5J4uDHp0qazY7tyFvrb2/bO3cwpmOW4pX2dRAiaQFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:28:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:28:55 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:14 +0800
Subject: [PATCH v7 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-2-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf358b0-707d-4f3d-f960-08dd5be9adb8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YytNV3J4eTlBSGt2S3NERnJQZTMveVNKZWVtMkVOVmYyUy9QR3FrQkhCMWk1?=
 =?utf-8?B?UGVaWXNJRmpSemxPOWw5ZUc2c3liSDhiMzFyVEg4dXpvZ1Voek5lVmRvZWgx?=
 =?utf-8?B?WFJCcnI2TjREdW54dW0wL1p5VFB5azZBQ2VTUGptTmNhdkUvM0VMemhMRVk2?=
 =?utf-8?B?V0pWRzVIVUpJMWljYmNWZHdraFFDVEJxYXZWZnFnbzAxcEwwQThxWEI2aWxE?=
 =?utf-8?B?OGhmQXlyK0ZjRVFTMEFDbXo5YmNla25GRHpFOXJQTkJOb1cwVXUwRFAwQk5a?=
 =?utf-8?B?UjhGZXdteVRrQUhqQm44YkZ4K1pxSksvTElSSWx4SnBiV1d4YVhYT3NaN3lw?=
 =?utf-8?B?bnJjcGJvams4RFlQUG1OTzdEU25HbXk5WXQ5UlRvY1hUVi9HR01NSEhPaUdz?=
 =?utf-8?B?eFZoaWlhaklWSE94K0l0dHY5VDlZVDdiaDJCTTJONURiSWRsbjRxZFZkSXdr?=
 =?utf-8?B?K3hXOHhTT3daanliQmpKM05xVmI0eWlkcTB5ZWs1SERVVlh0ZWhvSjBENTBP?=
 =?utf-8?B?UHpKRTVpOXozdS9Bb2YzVWVjYlp6ektvTC8zRHZtTGppZzNCRWFpVExpOG1R?=
 =?utf-8?B?cVhLZTFLWTBzbmdpNTNlVFRweE1hRzVQT0R1MUtFb0cveE5tTHBZeW9JZ0Mv?=
 =?utf-8?B?d2RIRk5QYjd2ck95WDN1OW9JY01sUUh2QWR1QjNTSnJDM3djS3ZGaHZ6YS9j?=
 =?utf-8?B?aXlzeFpMM2t0V2ZCV2IvaHB2cW9OVVFQTHpMZ25EdDJpeEdSWi9PanBoNXlC?=
 =?utf-8?B?cUdxZitMb2ltNHdtRXJWS1AyNHhJbFcyVXJvZ0pvM2NTdTlPSHlScTJTSkRH?=
 =?utf-8?B?bC91VDZ0b1UxdnVxSFczemF6R0plTU9QSjF4b0EwQTd4SkpYNGh4cURPL00r?=
 =?utf-8?B?bVpvWCtPSjFnMFFUclZ2UzhVaVdQSWovNHZ5M3NhK3NwZ1hUNHJidnR5ZXFB?=
 =?utf-8?B?Mjh2c1hLMjVXZjBwejBIKy9EMmpjSVlIck1QSXFoK2NkL0JrUU1IQjIrbjVu?=
 =?utf-8?B?WStUSWxpb0RPMnA1NXZJOTVCV0RwbzdKb2hZMEVtZ09hZExCKytFRVh2QW1Y?=
 =?utf-8?B?WGUxM1kyT1lNR2lvWVl2KzNWbUc0TFhKNlYxQUhxa1grT2Z6bjhJQldkWk9M?=
 =?utf-8?B?cmNISjFGVThGVEJ5SkRXQXcvRlZUNkRqNGhyUEw0TUIrS0hmVTA4MEtwYlRm?=
 =?utf-8?B?cS83TDV3QTNjbCszeVpWR284VWF2elNZMi9QNVdnTXVZZ0cyNE9xdzRSRFlx?=
 =?utf-8?B?dEVGOFUya2FaYjBPdEZ2UmtjY211OWszU3B2YVN2TEhRU2ZXcEVHL1JGTHp3?=
 =?utf-8?B?b1pZbFc2S29xRld2R0N2Q2pRcHBnV1UxRGxqSXljUFlXeWdVMDBmcFA3OWVx?=
 =?utf-8?B?bW9hd1RuZ3dNQmladEx0RkRaWWN4MEZ0K0NGZHkzYkJzNlE4bGRZaC9CaGg4?=
 =?utf-8?B?SXR1ZFZNNENTcXZoR21uc0JVeEEvNFIvOHlKbHkwSWMvQy8rMlcraFZIbHd6?=
 =?utf-8?B?KzNuTUNRdlRZVURZR3p0b0hLcXRyakd5YVlMVmRUZ2ZKUUk4VEw0eS9NeGJK?=
 =?utf-8?B?eXYraUsreGJuaHI2aHZBdVdQN1ZjK01rZVBJdzROYnUwSkthcHVrTStIUDZq?=
 =?utf-8?B?SHZXMTE1Z2V1aGNkWFJ0L2ZVN0QremdXNi9iL3c3T3RldFVXS05LOFoxdkQ2?=
 =?utf-8?B?cG1BalZLbGRRY2taSG9HZU5PazE4RytRZjhpR2tUanZ5UHdodkhQZTR6a2JD?=
 =?utf-8?B?T0dlRzZPMjJXSFRmc2VsY0RmUG9XdnJUQ3dXTDN6b1NSU2VUZ3J2TzBtSmVV?=
 =?utf-8?B?Zkx5ODBSVGlPVjBWSXl6SGJvQ2ZPa1c5dk1Qa2k0QjBuMmRIeGVWQ2FxZmRo?=
 =?utf-8?B?SHR1V2ZmZmZ6TWpTRUZnaGJDM2t0WHc3amU2K25sdWZxamNxRSs0SHdZUDU3?=
 =?utf-8?B?NlY4OEpIMEtGQ3hjUWVieDlHTlpzazRCYzl3eVJya0tWeDJtS3FoVFJFTXdY?=
 =?utf-8?B?cUVZUXM1cUlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZQYlM1emJKd2lCTVBkZi9rTm9Ecm8rbW1pOHdXZ0ozMUQrcWJYNW5QZ0k1?=
 =?utf-8?B?cjJ3aG9CVk10VnRBQTJaWU9ndXdXM2h2QURJUVFwNEhMS1VHWUtFZ1RRdGR6?=
 =?utf-8?B?cGZtZC9GWDBaa3FxUlY4TTlKRHRoaHlUY0hWdjlGV2tLWit1QUd0L0ljbkRQ?=
 =?utf-8?B?K1djVW92QmtEVGdjeXFzeWR3VnJYbFcvZDdjWHQ1YUtHMjcvMG9wekd2R1h6?=
 =?utf-8?B?Q25ueFZrcWltazlzWnAway9nd1lHRkQvK0VrR1d5bWNLNDc4aTk2NUZxRFJ5?=
 =?utf-8?B?QXJkend0NVkraWlOUHFzd0YzQnk3aHJSQW5qSE9lUHd4RHYvZCtMZm9rQWVv?=
 =?utf-8?B?ZWRydlByckwzTVlQTDBFRUdhdUV0T3AvckQxS04zNjUveDAxVnNGc0o1Z1JD?=
 =?utf-8?B?UVNKM2ROdm50c1JoM0kreklKSXBSYW1XTkN6Y0U4em1DM2dmM3A1a0ZoWlR2?=
 =?utf-8?B?d09vQVh4a25BTFZVaFVOYjY5d0s5VWRvdG13NTBUdHgvOW1TNTlSNm5CQ2I2?=
 =?utf-8?B?cmNDcVVaNm11Y1FYVVJOVm5wQngva21KRG93Wm1wdzFsb0NhaHkwQmsydUFm?=
 =?utf-8?B?UEFLc0NhNXFMS1dxakhlU1lTY3RGWXY0KytGd2xOWWVwRFBWZUt4OVBmcFpK?=
 =?utf-8?B?K1VhVTJCZG90emRzU29rNXM0cG9uT3duckxsdVlLcHB5K1YrTmxyVWI5c1BW?=
 =?utf-8?B?cE1HZVEzdjJZSVZuUXh1MkF5dENERjN3dGRIVHNLRkk1M3ZPeGMzTEtVN2J2?=
 =?utf-8?B?UmY3RUhLMWhrT0JjNVhJbjZiblEreXRYcHpUMWMvOWIzeU10UlpqNzVrZFhs?=
 =?utf-8?B?RTFCN1NVYjlDWEtnb3RtRXM2UmNxMDBoRW1IaDY4anRQMUcrYnpmMVVjdk94?=
 =?utf-8?B?OHdacDg0b05iWE15OWIwUG9zWVpHd0VHcUtJWjF5N3BNblo1bDhQNGl0RmJs?=
 =?utf-8?B?My9CaE16b0JhQ3A4eFpsak1SdFF1cjZaSzVZdGVrVVFCY3p5cUVveURuL3hN?=
 =?utf-8?B?UWtENzFYR01rL2xRWkZYNXdoZHpMN1NhS1FpV214WTJiS05NRUR5WjVsOGxK?=
 =?utf-8?B?Z1JlS0ViMjM4K0ZDS2EvOW9xRk4vdzYwOTVBSzl0djZJR1ZWQ0doU1pReWJD?=
 =?utf-8?B?NS9LZ2hXL0lQMUpCdUsrdVU0WW1MMmlreklNbzd4NDVRYnd3eG1BZUFpYXda?=
 =?utf-8?B?eXBJWVozMkN5K3ZjNlh5S1lmR2oxUHhqUWhDTFNEYVpJNU1DWjFnQ291c3dP?=
 =?utf-8?B?MWtUTkVDK2NudS90OUhzQ1VhWHZ4OHQ3WS9ORUdiMmFGcDJCY2tkb21pem9h?=
 =?utf-8?B?NnVxdWlyUnVBU0FlRDBYd3Zqa29nSFU5N1NvVDh1YzZ5aTQ2Z3k4ZEtVYzRG?=
 =?utf-8?B?UEpmWFFwMGgrb25oblJXZWlEck4zczRKeXJYb0I2dHJwSnNjUVBaRDNCa3Bl?=
 =?utf-8?B?VktmcFhoTW9JL2ZnS3BFMTFOMDVpOXdiMVppOEdCaXVBdW5ERStGaTZocWE0?=
 =?utf-8?B?ckkxcFlYcytOQVNtL0hvK2pVSVZvdFpZd2hsRVpjT2xXNkhKeDlqMlRqVXRo?=
 =?utf-8?B?UXdHdUpXWlEvQXM4WmZaRkJQYnorRytoMDZUS1Aydkt2UVZhVmR4RkxhZml2?=
 =?utf-8?B?RFpaV1hmNkJOdjBKa1JrZUpwRVZ6TG9jMWR1clZYYkpTSzBCSFZLVlBuMTZP?=
 =?utf-8?B?bTJGOWZVNjU4TC8zSDQ1eHUwMlppT2Q3cnFITm41bk1WWFM1dzYzT3A3NmtP?=
 =?utf-8?B?KzVHZ0ZvaFF6ZVYzV0pWcjh6TDVyaGowcnZNbnMwemp1NjRRcDVDd0tROVdh?=
 =?utf-8?B?ZXp2OXh1NTlUdllCVXF0M05OL2VlM28xSlNNN2crVmdyYktpa2hXUDV2VkRK?=
 =?utf-8?B?Nnk1eGY0SzhYdXpvbHRhWmdKVEZPVXpONHFUdzg3dzhCYldXbWJ3V0xFc2J6?=
 =?utf-8?B?Q3NGS1hNL3RDbHpPbVd4R3hzOGNtQTc3RGxpSlhQa0N5Tk04NmZ1N3lHK3NB?=
 =?utf-8?B?T3dORmVJejNUMzJmemlrODhJdEJNa3lHR0FxWlY5ck9NOXFpckxRdzBGbExE?=
 =?utf-8?B?Y0RQSkZmVWMrM3FSa1dHd0ExQ2k2bEpSN1pVdHJPZ2dVWmFBcGpJMXhVS1I5?=
 =?utf-8?Q?ZFUQAYDxjuEx2sju8/WWFFZ+6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf358b0-707d-4f3d-f960-08dd5be9adb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:28:55.8143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmWg+/qrZb9pTC8QIQplzi+I2U112ybpgOBqnWlycU/Ose802D7dmyqxq1dXGFr4CYRhEllhYNjOsFcw6cFXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

From: Alice Guo <alice.guo@nxp.com>

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig            |  13 +++
 drivers/pinctrl/nxp/Makefile           |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 152 +++++++++++++++++++++++++++++++++
 include/scmi_protocols.h               |  36 ++++++++
 4 files changed, 202 insertions(+)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d..84d9a3641f 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e..7d861ae52c 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-imx-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
new file mode 100644
index 0000000000..0ed971369a
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX93	0x360
+#define DAISY_OFFSET_IMX95	0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	priv->daisy_offset = is_imx93() ? DAISY_OFFSET_IMX93 : DAISY_OFFSET_IMX95;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+static int imx_scmi_pinctrl_bind(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX95))
+		return 0;
+
+	return -ENODEV;
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.bind = imx_scmi_pinctrl_bind,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36..279ebbad44 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0


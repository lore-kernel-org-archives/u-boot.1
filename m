Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE73FD206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BE788F14;
	Wed, 16 Oct 2024 09:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a97CO9wE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3C488EFA; Wed, 16 Oct 2024 09:20:03 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B42388E89
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgx8nqi+T6djIjyCFOJMDCJxFdM8PZok0gwtoKflg9xeKncLuyi2XvCwd4QMeV3psaRtCEYBqDp5w6ILzxOSYp0jgL2VhBlibF2zUJf3snLLvVbNi2WqIT/TNL5dPqabq0Ju3qySowbYh4/0um2XLWqyWVO4B/Pq5GkF1ubzfajRLEeGtnZD45qYs4hGf179YWL3sOkUkImz9VgsFJewkXKfYYbcVSGTY/Hcyy3PGuC6WQcQTpOUKEU1L7uDoD0ARyOirCHBHM+i7OESCoX4z6MhDxR8Rbi/bQzIAWwnUYWd0SC5XZegt7JEF+oTnDEHJzShvxYdHgy44TqcuSlGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=QkgmCkUlOh77zkCX1mZk241ZdwItJ2Ykr+gvjBu9jM7szOMv7fB+fQfQxatvM6W/VMAWVCnrsRITC84ym44WCUT+8xqEJsVfAkr2aQvyINDpFUKONVJIM7Pg5PfNToFDBBLwk5zNTpOHwn7PrmUpIKThqkVpowZHDQrlP5gXT8QkArK0NnAg2l7gGNmWfgHwODWJ0w2pLP+yk595ITLmV4PuEBqNZJsf67vdc6ifiw6GFnsr9wu/sNoV9NEoVZjmPL2htMlOJ1BqYphlqE0D5An4K5HWyWIuFBtt76zbAGvZro/HaXNCiw9ENhUH6RDOJddiVX5zyZ8zNB1QXtx9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=a97CO9wER+SaNYql9NrDeRjuxpyn8NjqJX+ba7zJl1sWjZ/gjbCmkcNXH0uvQCPxHjreV2GfQQ0BjiV9DvGlTYLW6AhG7d3nqhe2jLareonDbx6NoMn15x8S9u3eemjrFzZMNwvaQRZEgXg5MF/vNdswYsaOqGsNkO82nLXI/+YOUdgnZm7b9s5clYz1CH5QuowE70yiREiF5ETfOwagjVFMb20WimAqPCoLa5nfEAe7btlciQ6P+JsHjyy2BjBb1JTHzZWVOqJwx5/5w5zj5iIvhLvF4fcwBsFWreDkrC+KM51lBtsMSlDMHHjXu7nO1SB89G8BLZh6istsW3QPBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:56 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:08 +0800
Subject: [PATCH 15/17] imx: add V2X container support on i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-15-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Teo Hall <teo.hall@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 518987aa-082d-44de-25d1-08dcedb2ef87
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnU1QmpFZXNRTlhYSDR0aTRHS2J6UnhDNkNOdWthckdZNXZkVXZaNzMwN0t2?=
 =?utf-8?B?dVVCRW5pcHcyem02a3ZTZTREMjBWRW9VM0FLNS96V09DY2pML3dTa0RzakNz?=
 =?utf-8?B?LzZSbUlFU0tQUStlR3plcFBBcDA4ZVQrTWg3MS9vQjhzN2lxaTd5YmdXZjNZ?=
 =?utf-8?B?Wk03YUZoeHpVZG1aeEk4OGY2S3pCN24yM2FlMEpNVXJFUkU3bFpLYUpUc1pw?=
 =?utf-8?B?MVV1SFowNExpTzh2UHZyRXpYNDlmdzMzVEJyTHJCRzcrRmt2amRMWWNvbGZa?=
 =?utf-8?B?L2J0MkF4bHptdk1PckFVVnJmSFJ3aUtXT081VDdoQjNlbndGTUtqVndXVGgr?=
 =?utf-8?B?cEx0MkhXdUlXc3k1T1ora1E3V3hXVHNsVlcvZ0YyNmVPdVAyZTR2Q2xKYVZo?=
 =?utf-8?B?cGYxZ0ltT3dUVko2c1hSaWp4R2dOWGdsNnVPRldNWjhYNWdadWVKVHBhdmph?=
 =?utf-8?B?bUxMeHFRQVpmdjJLQlYyYktxaHFYWWtQZGFBR3ExWERSUEVCYmZscnduZTl4?=
 =?utf-8?B?TlJ3dkE1RzZITzAvUHhzTkVCa25GcHovS3paUW9hS25qQkdVQ05PYVhCY1lQ?=
 =?utf-8?B?NUlSbnQ0a1hEMTluMzRDVHIzSmhnd3U2OEkxc2ZKRm9VZjI2SjFpUjN2TlRX?=
 =?utf-8?B?aG5qUzB6cHVZSXEwZjduUlkwalRQNzNTRkF2dFhHYjFmRy9TVHkwL3RCSFc0?=
 =?utf-8?B?YU5kVHhXMlYwTnRUMURqTmZlQjlLblNmTDdkTWFKbEdBU0FxcmdDcW1mYlMz?=
 =?utf-8?B?R1FBem85MlVPdHVSMXVqemJuSjBQd1hjc3d2cSs1OVRNZzRGVUNYemJUc295?=
 =?utf-8?B?Tkt1R1M5a25tSUdrSmN0Mml4WHcxQmd5b3I1b0ZjRCtEYlpyVVpZTHlUS1Ur?=
 =?utf-8?B?cHhVVEQ2Mm9KemdZeElPSGU5NERCVkd6YkREV213TGxnTFF4RnUrc1JqWVdM?=
 =?utf-8?B?NjBSMnRFVGJqVGRMZGtEQWpBTXVnbnVFUksvV1JhYjZXWklLdWRZSHF0bFIr?=
 =?utf-8?B?SkpPNUM1VjlubUxldXVxaTFqY1g5eUErSlZsQUpjK2psd2ZWdDVhZzVrSk83?=
 =?utf-8?B?MnlCeFo3NjJDTnlNOVRwU2ZzL0hUcGJ6ZHRHeVZPOW1xUEtLTzVVekNoUlBD?=
 =?utf-8?B?SERiY1dmWjU2b2dYcGVhZ0MzLzBqK0FIMml0QXEwKzY2dmxWcU1OdTduTmc4?=
 =?utf-8?B?QXNJc2VsK1JWVzhTdnluUGRRTGZGaG9GUUt1UDI2a0swMkRzY2xQdWdLcE5W?=
 =?utf-8?B?dWpqbStOSVFMS3FPUG8zSm1sT25tZCtmbDRrcjlseGpNOFZJR0JTOFM0QzFv?=
 =?utf-8?B?ZVNDSSs0anZXS2VUR3ZuV0NnOFJPU3dFTUc2U081TUliTG5tYkp2OGJrbHhn?=
 =?utf-8?B?Y2dNb1ZOd05rNXo0Qkp3L2dndjRGQndiTFVHN3FlSlBieFJTVkE0YTkzaDZh?=
 =?utf-8?B?c3lNcUdPeFZRbFdUKzZWTE90QWhmVzVwNDlCVXFEVUFmKzFOZ2FHSjZ0bjFJ?=
 =?utf-8?B?Q0xUM1lIdFN3Z3dMT1IvR1M1VHQ0YzVteCtBbUtlYTVVSnpSeDdxS1VnUlRU?=
 =?utf-8?B?V0FKZE5hVk1mSElHMmRXQUJtVVNldEpYN3ZKMlFTR3VuaHZCV0pCVk5rejlU?=
 =?utf-8?B?amNZeG9zWDBtYkhOZk5qaWtQckxZMU5kOEl6K2p0SGY5K1BiY1pXRWNSVFlC?=
 =?utf-8?B?ZmozK2t3WG43Y3NxRC84WjlOS1cycS9QbGQxNW1JelpEL29HMHZvWVhEaEhZ?=
 =?utf-8?B?YTBBWDJnb1FCQWNmUDdyL2Y2cFpGSTV0NXIvUTV0c3hUTDlqS05NOXhQeGxI?=
 =?utf-8?B?cXRkelA2T05aTnp0QUZWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdhcFRhOW5YcW1oMTFTcXBLTTFuZGt1WUVqN3RLUlpTN0xrV3l5MHRWQzdI?=
 =?utf-8?B?RVF3ak9JN3dZRU5ieGJmWmRvYmgzSnlOakkzdytlMWRSSlFiMWpHL2JCWis2?=
 =?utf-8?B?S3hCYm1SZmtlbGxXMTBTd3grRm0rRWh2dGlJbEh6RUZqWCs4Y2pHL0lSUkky?=
 =?utf-8?B?KzU5T2NQRXc4bFdSaTIySjRibWRnaGVrN3d0R2JDWXNMVzdObW4wUDVITUtz?=
 =?utf-8?B?YnduVFAvR1VVTko5bXVuLzZONnE4dmF0QzZZQ3JTRnlPcmxvbmxqN0YzMis0?=
 =?utf-8?B?WFVXN1N4NEk0Z2dBY2dDRVU0WG85YU9tSUIzVDVsS2F3dnJRcSsvUWtLUEpI?=
 =?utf-8?B?anlmNFlvTWY5eW1SRDJMV2swd2lsSjkrQXJPNEJDbk5jUWZJMjRkbW5VL1ZB?=
 =?utf-8?B?WnI4ZW1ET3JRMmEvL2RwYS9RdWZ5TUQ5cnBFYVNkcklWbXBVelpZRkVMdjhv?=
 =?utf-8?B?a1N6YTVFY2RiQnI5bklEcnBSd3crU2F2UnRnUEdsTzE4T2tvRVJKMFRLYnFD?=
 =?utf-8?B?c3NrQ01ZOU9FSkJ0enIvRXoxaG0zWjhhYzV0UHdyNGwvVWhVR1FrK3RwVWMv?=
 =?utf-8?B?aVVKUnhzZ00vQ01GM285UHRDQ0Z4KzV6bWR5UURHS2VwZHA3YUlzdERTOGl6?=
 =?utf-8?B?RlZqZmtWOWlnVWJEdVpsVDdyQ0JhVW9wOTZWbGR4a2wrTGdwblJuS2k4ZmFD?=
 =?utf-8?B?UkRORFZndnZsSDdKUjFpVFhTZ0dZaFlhUDhOLzZJOEprZk15UGtWQmJtcXNk?=
 =?utf-8?B?dXBxMXZRNWUxZ1FIbE1yWVBFNmdnY2tHT0o2V3pCNzFGL0p4dVhRM2Y1RzFP?=
 =?utf-8?B?OHZhNSt2QnByMlJzVDYwUjBDR2hWV0E3SHl6cWNTWVVieHZrUkp4ZEsxSW5j?=
 =?utf-8?B?SHQ2K0NQMTlBNW04VTNNeWhvQW1yaEFRWGJVVThySHBGdjhUc1FCUEQvaFVx?=
 =?utf-8?B?amxXaHNDYTlGNVdNMmJjQmhtMFQ4RjlUVFdLeGo1OExVeG9SUFdncjJrUEZQ?=
 =?utf-8?B?WlRiSnpJT1EzU1FRL0Y5UjNkK2hZNXB6VG1sVHlqWXZ1OVVvV2pjVFVndlVT?=
 =?utf-8?B?ZG5QTzlDSW5qcENYMGFLdXM2UHl4YkxRbU50c1MyVkpsYkFHcm9Pcy9sSEU3?=
 =?utf-8?B?TlJrSzh6amxPbmdVaDlNNUlVT0syVkwrc0YyTkVZTWFMRi8yei9reTdGL2NW?=
 =?utf-8?B?bituVmErbXRsWjd2S21qdlNWNWdISTBkZ2R2endSdzF3WEhIQmRXTVhxV2Fn?=
 =?utf-8?B?cFZFN3VxRkpNQlR5WDRDb25pZ3kwWGVXUVhsdWN3T0Vhekg5MXdSbmxWUzlY?=
 =?utf-8?B?ODRueThWL2lrbWdxcktvRUJaZkUyNmdnQ0RBTUNDT1dlMFpHMnFoNVFHZzh6?=
 =?utf-8?B?Qjd3Q3VrSUtaQW5rTytzQU9lSThSV01pUkRCa0pZSE4yZkxuWUtiVXBjREFj?=
 =?utf-8?B?K21DZ1FuelBhUXlVVVlGZmU0TjNoWE42QUZDZGtkT21rWHZzMHlQaEpDWVFH?=
 =?utf-8?B?Q0g1cTQ5UE9Gc1M0ZE1iN3BYSUFJMFZFbnE5MktKMjhqTi9qZ1Z3U2V4dWNM?=
 =?utf-8?B?c05jaU9FQW5ycmJrQ29OQitBQjA0dE0zTHZyMDNjMTlLdVA3eW9FU0t4Znd0?=
 =?utf-8?B?SndSV0V2V2R5bVlLcXkyd2VxWmJ1ZDZyNHhsRC9JbUhiTWF0OEJGajZ0bm40?=
 =?utf-8?B?SVJoeGJGRTBZSkFweXpydUduRkwxeXpqcmxPQjZlRVkyeGF0SE9iM3dUZUQv?=
 =?utf-8?B?Y1lIMCtIVjN0ZzNrakxlVGR4K21NVXl0MTdRSElZUW5ITmQ0MUxMMXJyY0Va?=
 =?utf-8?B?bGdGQlRUT2hoRzJQUzd2MW5FOG1vVEFJR2RoUHVJWXZacEt0MTN0aWYrZTRD?=
 =?utf-8?B?RjBnaWJTSlFYREFUSnNVaUIvOTBZVWlrc09kaXZhS0RhZEhxcnJFR290V3BR?=
 =?utf-8?B?TVljOXFscWVkYkxlZGRaU1NVK2Ric3FJeldNTkNhcEE2WGVGeVRRRmh5NVd0?=
 =?utf-8?B?QlEwNGZ0aFpiRzc5Y3BHQUZLK0FGNU90V2VqYnNoUTlsNVhCV3k0bTMrdkpS?=
 =?utf-8?B?N0ZVZ1J0eXVETmpkU1NUYlg5NklhS1dpbG94Y1kvU0pUSEJjc0F0S2Z0Ly9G?=
 =?utf-8?Q?adUCBApXop0HjarGW+RWBCaWE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518987aa-082d-44de-25d1-08dcedb2ef87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:55.9310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6ZITn1XROFHS1bjiLKYwH2BKvwwzpbB8oVN4x2POHKNcf4CS1OYX5695U50UnUzLBPfMZy1Fmyv/FhNAYnsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

From: Teo Hall <teo.hall@nxp.com>

This patch adds V2X container support on i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a0681862098a6566a873873f24069b88..54ae7721888dbc93fdaba8e5aedc52c4506bb1c1 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -231,45 +231,62 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		debug("v2x container size 0x%x\n", value_container[1]);
+
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
+	}
 
-	return value_container[1] + offset2;
+	debug("scu container size 0x%x\n", value_container[2]);
+
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +296,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +329,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +343,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +356,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.34.1


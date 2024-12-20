Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657A4E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175288021D;
	Fri, 20 Dec 2024 03:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XE5eugsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A214803CB; Fri, 20 Dec 2024 03:56:04 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99428803DC
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiA5Jy0aMSG/PPTxwTvHscvURwn4yKPItsJ9qbeWLVBDP16ML5t8QNOFWJJEYtAY5dyTAQKcEeqb9CQrvxGAaIMM1hqRuIJ+pfnpN58DG45+lI/JKcY0L8SV7VHKtrsXJLiYIp7XJciuXs7crHSg/vBpLE+iQu9EJY5gQZkyiAakIisQm7ImOWkN/S5tq31vhQD4l5hc75nA1NMzCXanUmOUB6+QNad3qKyX3oCiv0xt28HfCMbBVSKZnONJT5v0qIjgh21eKmuU3rU1nDIa/O7yxrTud3oqyJnaw5HQdfihcdZpW+6PLONgVTezb9KZgKPJ5EbBqObf/5mKBqvlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6T05ihS79g/HBVgUdAZwyFnAQpBreb+1KxoLxYLnJI=;
 b=CnEDDllnOtsugICVUSvlvJqFYhyj2ZbDKLe9Q/GLQ/1X0V/ZCMDQojsKyJM4beKW3ibOVV31bbR7RNtqaJ4KLJQVGYkqbcuutSfnEcJg9kMJUCjIBdW24GZ/HlYPRDb5YLv/VqrM1bK+Cc5osKLGpUcTQmw5ZYS82jaW02yoEqSmudrTWvqGofakJJVqHKWylLR2eet6dsvWMXIlNV9Ho+VTguhAGlzcEvpoW6jFiUWwyAJIIUo+tzTqEM+w//ehTe3OVgqscDv+jWmCl9Qey1+ANrGXFQn5umTfq8R9srSwYfQhIL/10Ru8Kyub7srVoB0nE/G8/N+ggynl+BsbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6T05ihS79g/HBVgUdAZwyFnAQpBreb+1KxoLxYLnJI=;
 b=XE5eugsTf3qFR5QC+wShjDW6QmSca8E5i1D07Yh+HoB35t9tKTi0eMKxWg9/8VkAR6k2nLuhZlWJYeqPDgTQUwwpRHLTQ+tjnzHFgI8RyrTv5TB0yfbuwN9BpfLGDN9vx6+EwjTiEOxEw8DOz72ittA4DzKbCUf8e2DY5B+DiPing6dloLUXeZGxIogoJ6gUlGQqp9QTfagbt50JTNWj39cMFE7s3afJ5K2J0AFnTPLuZJ22Vl69STh0ZGtEzp4VkhsHqGKW2JgEtCX+RLclSHcEzi1A9qTlpcwVZ9YeEi2fDLDoVrqj/NUw8ot+V1x/U9uf3PDrgn+aQqbiRIRMDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:56:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:56:00 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:12 +0800
Subject: [PATCH v2 14/17] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-14-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=4931;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=ffYHDDIX+g6m6StD1SZfr/Jv4wny9s9QDYu7YZP/dyg=;
 b=pchLyd1v72+Dk3VhajjjiEAlV16a5I1zkdv/eOthCiMn9C9fItDdryFQ3qbgXQbjUE24FJHHy
 1MktM/yeVk3A1vVVQKNjcs0Wmfdd846fu3qtlI4O1R1LGIGhfSwEtpF
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 60834d73-a348-48d1-e5b4-08dd20a1d56d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VC9XUGg4STJ3TG9LdTRRZ1A2VTlYUnZrVmlwd3NZLzVjVWg0Mm9Ya0UrNHZs?=
 =?utf-8?B?YndzeW12VVpheStIeENUOHFua1R1QU0xc0M1V1RvcGp2Y3NnMkZkTEJUZTJn?=
 =?utf-8?B?TGVyVFZVL3BKeUdCdmt2VEdnZzFEMHByK1owQlRGVWZZZDJnSlZ1QmJhZ0dX?=
 =?utf-8?B?YnhsenVHTkRNWWVlc04yS2JNb3JmNnRYMllLMVFKUm5uZFdicHRrSUZ2QU4v?=
 =?utf-8?B?S3VrZVdvYXNIMkdqOHpLUFd2K1E3WVNDQUFvWUNGemtSeFVzWno1ajMvejNR?=
 =?utf-8?B?U0s5VC90aWhiTkN2YmJKM3Q5OGZmMFVOK3l4Y3l4dzFHVnI1Qml0YnJGOFQ2?=
 =?utf-8?B?QkdPeU1tazhObXFaN2w2blJnWjZOdGFReFJxTzBSWThDWERId0tXSFRraFpQ?=
 =?utf-8?B?UVUyRktrKzY2eHVDNFV6SHVDNXJaODUvOHMzczFtNnY4MnNDdjQzZE9NbkRr?=
 =?utf-8?B?VjJHZ0E3NG1UaVFtMEJuaVRzYXlWbVNGOGhoVTYzSHVsR244VTQ3Y0tWVUlk?=
 =?utf-8?B?OUlqZlZFWnFFZk93elJOREJaYjB3WU95cDg3ME9xRTRPay8ydEp2ZjZwVHNF?=
 =?utf-8?B?aXlEVlBOckl3VGo3SWQ5OHNySFlkNXRxdXovQ3Y0VFJGTG03MHZHWERPVlJC?=
 =?utf-8?B?Vi9ERzFyWndGbTZaTHllWmVrd1NGSmJMdmhlWW91WWh5S3NKSk42bTdaMEZu?=
 =?utf-8?B?ZkhYbEJZNWoxK0NtN0VQUlo2VFNZSlNETy92QzFHWkQvVDhBYTVob3RuaU11?=
 =?utf-8?B?aHhpd0FJZUFmR1lhN1puTCtISjNJT3hsWWg5OVJHMkk0MkhkdVdGSDhmekFn?=
 =?utf-8?B?cHZVamJBWHVNQXdtdlhzcWR6dCtWSlpJcUFGaURQOEJmTWtsTCsxSmRPQkFP?=
 =?utf-8?B?UFFIWTlaZ2FVQ2dEVlVYQytwSTNSNm5kb2cvK2VBclN0YWRqeFQ0WmVFNnU0?=
 =?utf-8?B?dW5leUR5SXdZZW1tWTEzL2F5d3NjNkpURkxyKzVsNG0razRIQlQ1eDFVRG5C?=
 =?utf-8?B?WmRQcWVQRGhsRmx3cTFCSmFDZi9ZdVI5YjFlUm1iZGZWRk9SYVBlUFR1WXlx?=
 =?utf-8?B?aE1aZHR2L3VrZzBsbzdMb3dSaWl0VEFhbURJR2lOOVJXb29mU3J0T1hzNmpS?=
 =?utf-8?B?bnhXVnFrUG5pZVdmMkFpY2c5VGpIWDlud05Dc2tUUHBYT3VPVmRLSDVDMUt4?=
 =?utf-8?B?VXRKelZhQ1hvemtSbWdWK0dMdDkxMEdhN1YybVlOT2ZvQkVMYWlTb3FhaU9l?=
 =?utf-8?B?NTBjWUdYQ2piTS96bURCQmRNd3JaTEJDRkluNmJzeDhUdm5PdmpNN3o2dmcr?=
 =?utf-8?B?NVp5cXpYendBRTVCZWF2MVo1YkIzSFVYajFMOTZGNXY4YkRQVDdpVUJBQ2Fp?=
 =?utf-8?B?c1FzMUlpWloxOEU0enpRVFJtaVoyM2NkWTN2OWh3N0V4TklVZnhaN0E5TkJ5?=
 =?utf-8?B?VjdPaDVnODhHaEtJTXRzL0hINzk1VEEvOTJ6NXlrT1JHbUpMU2Q1V0NycjFn?=
 =?utf-8?B?bXl1c0FGam91eitqaGw0OFQxejd6SjRzZDhwZW5rSHh5c3d0NUJITElnSm1G?=
 =?utf-8?B?MEduUHJPcnArSGNLMTFsMGtqS3Q2OXBTTlFqZEU0TDJuNEtHZmlJVW9ZVVhR?=
 =?utf-8?B?dlhhdFRMb2J5T09xQjhsQnRzOGpSSFlwZSsxVzM5OFllL0pLNU1yRTFsWE1v?=
 =?utf-8?B?Y3Q5MmJOZU9DSjVWOGs3NFFnb0RiMmN3UUhTMFVDYkxxcE5NL3krN2JpcVVR?=
 =?utf-8?B?L2RFdzVTQXhsQythSFprZFMxeHhieDRFb1EvU0F2U1BMcVFLSDdxcTJZZGFX?=
 =?utf-8?B?RGlOWHRlVFc3aTA1ZkkrdTN3VlpZWDQ4enMvVU1oZ3NIVUNVV1QxK0NoNEZR?=
 =?utf-8?B?QjlOZnVDRCtrNVNsaXFNc0RucWV5WGRSZnRsbWlWblpkQURCWUM3bjMvUm9O?=
 =?utf-8?Q?CQX2UMjdorF7GKQ9NAnQ8Ab0lOSBKyVY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTlNbzFScEJhdG5oY3lPWm1MUW9ZeXRpb0hudktMMmREdWVzcS95ZWgrVExX?=
 =?utf-8?B?VHJya0lJUWw2VFAxQTMvQTBXTDJ2N0YwS3Z4RXJKM2JobmtQL08vS3VRbGFE?=
 =?utf-8?B?MnhXNDlGY3lOOURQWWRIS2dIUklxVTk0Uk9UTnU3N1VwcHgrZ2NaM21WMWJr?=
 =?utf-8?B?eWlkc2ZxdWI1QW5PZTdHSVNNb0ZJR1NkRURldHBtMlYrZ1gxRDJJM3U5MVhO?=
 =?utf-8?B?cnpjSXRXLzZnUjBSdHlScmZENThVS2ZlLzdINm9qVkVidkt2bm9KM3VHSWZu?=
 =?utf-8?B?VU1kOVUvbVk2bnJmL1RxeTEvRHpEQ0V5d1R0blNZVXVEWkczSXNmN0hFTlJD?=
 =?utf-8?B?ejE3eFlGWTJPSXZvcjREWEJZMmVjNXFra2Rxemt4Z3NOSW9RL2xjV2YxYWQz?=
 =?utf-8?B?NFRraTFaa0s0d0I3b3c0ZlNTdnIwSUJJbUtrMlllcVNGQXRjNmsyditQQWxw?=
 =?utf-8?B?MHN3V3JDdDJMZitXZi94UDlNVjYydjdIU1ZmaGZlUUk1RHBlelMxMHpSc1JD?=
 =?utf-8?B?UGdZSzA3WmVxS0k0alJ5YmhpNWc2VjNZSE1QL0Zab0RVUlRMSDdtZlNXMjVh?=
 =?utf-8?B?VnNZb3pSYnZmdldOWWFYdk83Nzd4T2tqMkVXYWtCcU5qaEt6SWptcDBTNVlY?=
 =?utf-8?B?UDVjemFjMG9kMnpkaUQrcXBZdHdKK0FtdE5ZNStNd3NGRUpVdm5jSVRzdGhG?=
 =?utf-8?B?SllSemY4MkZ4bHlYRldybVBvaGxsVTdFTHB4QlhMK1BpUGlSTmhPUXVRaHBx?=
 =?utf-8?B?S1YzZkVXTmZFL2ZyRHpaOHFrbDdsQXhTNDJrRDREdWtZNXhBRWlROUUwU0h1?=
 =?utf-8?B?SUVnd0h0Rm5LZjlFZ2hzeHVEQjMzVHB4OEVIUHpkTmR6L3RlTzhiTC9oR2J4?=
 =?utf-8?B?Yzc4UXhSakpKaGdoRUxsM3k3em5oYzhtdDhKYVEwR1A4U0h0OWwxU2JVUTY0?=
 =?utf-8?B?R1RUQlFFU2JWbUZxdzBTTkovbFZWdXhzRVZlT2tMYnhFb3V0aWlhc25VZ0p6?=
 =?utf-8?B?b1JSek8rQno1a3dSWG1Oc3FyaGFnTzZoeUNQQ0NtTXhCZHVzbGwxUFVaa2V2?=
 =?utf-8?B?VWg3R2x5dGJHdFFkRlJrdTV4VlZuOUtmcm5rVVJjSkxNR25Uck5lbkpsRGR3?=
 =?utf-8?B?enoyM2dMOU9tSVVMWDBBU3ZHak4wZ0NMK01LTEtVM2h6TmhTVU1JV01hWWIx?=
 =?utf-8?B?QS9zVjdaZmZmTi9rSVA3Y0pJMERrclc1U0JJOGsya0I5WHF6Y3R6WkNYeG5u?=
 =?utf-8?B?d2R0eW5KTFhKQUNFZi9MM1NxUHliMkplZFo5YjFFU3pLNlpZcEY3Vm9UMTdw?=
 =?utf-8?B?MW5idDNpQVZTaytXVzJoU3FLVTJKTis1RHNCTm1zTFhwLytBelhyNm9Wb3Ew?=
 =?utf-8?B?aDVSdWI5TkFaNGpkdmM0eTI4L3BWcTVOYytwWkx2bGVkYVczQXk4akIrWk9Z?=
 =?utf-8?B?QmY0ekg4NGdnUkRkUE82MVViYktIa0krdlhsTHRQR0RkTGpxdnk2NmJDVzYw?=
 =?utf-8?B?bGtvbGdvNXBSVUs3VWZWcVVqdXZaYmwveDhsWlZjNjNla0E3MnZENkFmUXR2?=
 =?utf-8?B?dmJFdit0ei9DQ2QrS0lmMmZiL1FJNEk4VUdRY2xLZ1RHYndncXduN0g3K1F2?=
 =?utf-8?B?U0MzM1NKeG05UkMrR2NFOVdSWUJBVkwvVElVYTJ5NXJUS1QvYUs1bTB0bjFx?=
 =?utf-8?B?Z2NyK1pkWnhlbmhqdDZCTmxEVWY3M1JZV016WUo0cGpVVHg4S0RxbkpWNmhI?=
 =?utf-8?B?YjNXMzdUZnZLcnA4Y0I3WWQxK29IazNUK21ZM1BlYWhNa0xMcWU4UzFMaHVS?=
 =?utf-8?B?UlV2ZndkcHB4M3IyS2JhTmxYb3p0Sko5SitvRXdHc2RJT2VQNURZempaWnhl?=
 =?utf-8?B?OUZPL3AzTEJHODAvZHdWdWdLTWRjMjdTVHQ1b0FBK0pwREFmSkZNdW13LzQw?=
 =?utf-8?B?WE90TFdRQUJxL0JkVW16SnQyc0twVm5sSGJQdldNWWIzY2RCSkVGSWk2SDRs?=
 =?utf-8?B?ZjgwVGFwTGNvcnM0aDVFK2dQbEl1OXFubDYyRWEyenVjUWs0RDJ5VlBuME9O?=
 =?utf-8?B?S2pTK2hjMUR2UWFxUU5JdFpLMTNPSzZScDFxRkJTdlord2dVd3YxSXFlbyts?=
 =?utf-8?Q?a1ZqbYEtk8FrCWYeywIeTSsjw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60834d73-a348-48d1-e5b4-08dd20a1d56d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:59.9992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyj4FibwX4hq4OHcyCRVaaSwP5LwvdR/o6LGwB8Jfn+32LqA0R22G9FIvVFQcvHL2oHeHbAlgw1Rd8WxYS+3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-append-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst               | 14 ++++++
 tools/binman/etype/nxp_append_ddrfw.py | 78 ++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 83068ba6d39d9a5b586312fd4a062b0da31eb595..061bd2f1da9812d36c90b1fb10a919667e36ceaa 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1658,6 +1658,20 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_append_ddrfw:
+
+Entry: nxp-append-ddrfw: pack NXP LPDDR firmware
+---------------------------------------------------
+
+Properties / Entry arguments:
+    - oei_m33_ddr_image - M33 DDR IMAGE
+    - lpddr_imem - Synopsys LPDDR PHY firmware
+    - lpddr_dmem - Synopsys LPDDR PHY firmware
+    - lpddr_imem_qb - Synopsys LPDDR quick boot firmware
+    - lpddr_dmem_qb - Synopsys LPDDR quick boot firmware
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_append_ddrfw.py b/tools/binman/etype/nxp_append_ddrfw.py
new file mode 100644
index 0000000000000000000000000000000000000000..bc23a7611eaf823651a8fcbc9898c9140c277d7f
--- /dev/null
+++ b/tools/binman/etype/nxp_append_ddrfw.py
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 NXP
+
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+import os
+
+class Entry_nxp_append_ddrfw(Entry_section):
+    """NXP M33 OEI DDRFW
+
+    Properties / Entry arguments:
+        - oei_m33_ddr_image: M33 DDR IMAGE
+        - lpddr_imem: Synopsys LPDDR PHY firmware
+        - lpddr_dmem: Synopsys LPDDR PHY firmware
+        - lpddr_imem_qb: Synopsys LPDDR quick boot firmware
+        - lpddr_dmem_qb: Synopsys LPDDR quick boot firmware
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.required_props = ['oei_m33_ddr_image', 'lpddr_imem', 'lpddr_dmem',
+                               'lpddr_imem_qb', 'lpddr_dmem_qb']
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.oei_m33_ddr_image = fdt_util.GetString(self._node, 'oei_m33_ddr_image')
+        self.lpddr_imem = fdt_util.GetString(self._node, 'lpddr_imem')
+        self.lpddr_dmem = fdt_util.GetString(self._node, 'lpddr_dmem')
+        self.lpddr_imem_qb = fdt_util.GetString(self._node, 'lpddr_imem_qb')
+        self.lpddr_dmem_qb = fdt_util.GetString(self._node, 'lpddr_dmem_qb')
+        self.ReadEntries()
+
+    def BuildSectionData(self, required):
+        u_boot_path = os.path.abspath('.')
+
+        oei_m33_ddr_image_path = os.path.join(u_boot_path, self.oei_m33_ddr_image)
+        lpddr_imem_path = os.path.join(u_boot_path, self.lpddr_imem)
+        lpddr_dmem_path = os.path.join(u_boot_path, self.lpddr_dmem)
+        lpddr_imem_qb_path = os.path.join(u_boot_path, self.lpddr_imem_qb)
+        lpddr_dmem_qb_path = os.path.join(u_boot_path, self.lpddr_dmem_qb)
+
+        if (not (os.path.exists(oei_m33_ddr_image_path) and
+            os.path.exists(lpddr_imem_path) and os.path.exists(lpddr_dmem_path) and
+            os.path.exists(lpddr_imem_qb_path) and os.path.exists(lpddr_dmem_qb_path))):
+            print("Please check if there are any external blobs that do not exist.")
+            return b''
+
+        lpddr_imem_size = os.path.getsize(lpddr_imem_path)
+        lpddr_dmem_size = os.path.getsize(lpddr_dmem_path)
+        lpddr_imem_qb_size = os.path.getsize(lpddr_imem_qb_path)
+        lpddr_dmem_qb_size = os.path.getsize(lpddr_dmem_qb_path)
+
+        with open(oei_m33_ddr_image_path, 'rb') as file:
+            oei_m33_ddr_image = file.read()
+
+        length = len(oei_m33_ddr_image)
+        if (length % 4 != 0):
+            oei_m33_ddr_image += bytes(4 - length % 4)
+
+        fw_header = lpddr_imem_size.to_bytes(4, 'little') + lpddr_dmem_size.to_bytes(4, 'little')
+        with open(lpddr_imem_path, 'rb') as file:
+            lpddr_imem = file.read()
+        with open(lpddr_dmem_path, 'rb') as file:
+            lpddr_dmem = file.read()
+
+        fw_header_qb = lpddr_imem_qb_size.to_bytes(4, 'little') + lpddr_dmem_qb_size.to_bytes(4, 'little')
+        with open(lpddr_imem_qb_path, 'rb') as file:
+            lpddr_imem_qb = file.read()
+        with open(lpddr_dmem_qb_path, 'rb') as file:
+            lpddr_dmem_qb = file.read()
+
+        data = oei_m33_ddr_image + fw_header + lpddr_imem + lpddr_dmem + fw_header_qb + lpddr_imem_qb + lpddr_dmem_qb
+        length = len(data)
+        if (length % 8 != 0):
+            data += bytes(8 - length % 8)
+
+        return data

-- 
2.34.1


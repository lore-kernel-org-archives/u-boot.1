Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7205C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F095D80771;
	Wed, 15 Jan 2025 14:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q0CTfL7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B94C80737; Wed, 15 Jan 2025 14:30:07 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A91380778
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJDTo+Y4kBsvINZHTtWZm/qTbh5/uCUh4xRx5zTXLy3kU2B7GaODFFem4rog0QGitM3lrMH4U17qrtkwNwoWgh3wS1at6vH2/2dSFTEuQrDa+eJpORR5fij484oNDVbu6q+qGiQVz7+T0e0EdO5SlNh7T3692BkTvhBClgzZXItJYbSGtZqCcw94fTWJG8ngDpoYcAMUJGvvattyvenkHJgfBgEgBhG1aHHYod9ZuIqnDvUC2oYr2Au/lJGxxpwuKrQnxc4DDAxv9SkK3nfJHhPveIwA5/rdkbpPzXYDPpY4d8ukSRClGHU/IaA346/S8uKBXW83av5iHRCYh+0qIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vlar/gu3IQ2FnXor5LsXqkoUOKr83MpOuLR/5OtAeRw=;
 b=awchFGutDRmRCtWOTt+kV/rSZk4rl0L1ANyI87AQUmCGCcOnKRFPoN9jaMjjbotNms7b4F+ZDn3IbzTJ/Oa+OmjXhVUqn6T6yMc69m7+6NDRdv3nGTmzeYHi2yvyRY9+zI5yn9RQaGI0ixPJICtk3Q3qebySBJX/JzujJYa6Q+egOfnZkv8ZXWKrm054p6rVJTV7jUaFv+JI42j/SsuEfwhIjHnPGOKex5ajILjpalXp7njwTh3uJ2jI2k4fgi8aIlQAUU+GfxdoZcwr/Jk8mHHPWMJqHKTrJJf4KyIPBthQ/ZgcwbfFUwcfJmc3N5jCPTVE98Tn0OJJBS32rS3LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlar/gu3IQ2FnXor5LsXqkoUOKr83MpOuLR/5OtAeRw=;
 b=Q0CTfL7xilp6sZQUo2MF8c0OhVXW5GPjX0H40/Z8OfSQrS84P/iAY852ufhkd837r7NZQLmVxjShpEtckfjz+Toy6AZagZ/EXXwzwKCMrwKRLitzWehC9N8BNoJ4h1xngvQ2/SqXCVwdGCjaH93/huQkNvcWGiGfrBveToEo53p03fChZqmcnhxeSsrou1n4AHtqR+1infZ7FOAJbcHtmBvndzC9R8Ec0LecY2EC3F20yrnGvcCsPp3C1VgJHsZSwZz+egESoO/cQA/jEWorJM/3et2pG4aW3oQK6RkTdHif+rFp7S4J1oYAidHf3q+nYHC81lSHbcsr4uzirYVcXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:01 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:00 +0800
Subject: [PATCH v4 13/20] spl: imx: use trampoline buffer to load images to
 secure region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-13-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=4300;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=LsrPwvciIxAdjQ8oJPzCB2jTHKjEM00izzVrs6QrhY0=;
 b=y7XnLJ20s1wq0j6gbX7tfSE/l7jWHrm7VnJOB1CgtTJS71+cc/TkXG24L1DBhBTsQwqDWAIlA
 Fs3HCbRma0tCeDYq8bXUHQHxuyp05QZmQVuNETHVrPf6F+d88R0c1J6
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: ac944162-17d9-4a8c-388b-08dd3568b6da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L29WQ05DSTdURHF4NkFINllHQWo0UWtDQWl6SnBvZ09wZ2loWGxLa0Uwd2cr?=
 =?utf-8?B?N1JweU1jZ1ZsUzRWczY0eGhpLys4UmFhdWwvbzNDZHpkbFZpOHBJbkJDUEV0?=
 =?utf-8?B?azZnampoUzRHblhpbCtRSVZzU0NwMURBQmVHQy9ydzdaRktZOFM3WVFaWUVt?=
 =?utf-8?B?T3BiYWsvak80eDA0RHRYajVteXJtdkRENVRRUHdZUSt1VUxhaUZwTnZHalVN?=
 =?utf-8?B?OFJzS3lBZUFQYWlHRUM3UFhxVG5LM1ZVNGw5M3FwRDhFUWMxOGdCRzZnSWZh?=
 =?utf-8?B?TW0xeFRmcG5IWDB0OFU5SS9GdUxvK2kvTFpIZ3dHSmRCbzhia1BMZGJhQ25Z?=
 =?utf-8?B?aVdaUXZFWTUzcHY0emQzalFJWFYxUUZuM1lnbmw5MDJUQkx0dDdtQVBzUlFI?=
 =?utf-8?B?MERlMHA0VS9jVEplUFJPdWNjRUw4enl1MWtKSEZkQVkrb0k4TC94R1M1Um5V?=
 =?utf-8?B?MmZYbEpkcW1xS1dETG4yNW0ybE5QTDNOMTlUbWZEMUltRkhQeTQzcllzRlBH?=
 =?utf-8?B?U2x1Nmg4OE9jV3NpZjhFanRkTGR0dFhKbk9UWFB2RHI0WHUzdFFDblZwbE85?=
 =?utf-8?B?ODlxYTJsUlBGQU1ENjl0dDBTaFROUE9zZUI1U05pQnNBZzRGNFpVTnBRQzk1?=
 =?utf-8?B?bWN4a1QvWFhwZ21jMVJ3ekVUeHM0Q3BwcWRYZHA2UGMvd2lxbWdtc2FuY2h3?=
 =?utf-8?B?QjM4dEIyV2xsNSttdVQzcWZGUERpaXZvTzBGRWFBdmlkQ2txZThBVjZOcWli?=
 =?utf-8?B?UmhqaVNPdjIyKzhWaWE4RjFwc09BLzZpODJreklmQkl2QWhENTd6N1NkTml6?=
 =?utf-8?B?SzBWUUxrWUl3ZTh4UTdicDQ5NnU5TFZ6dmxsQ2YyQ0tlR0lxc1plWWwwUFVL?=
 =?utf-8?B?Z2JoUGZZQU5GVW54Smc1UUVEaGxoOWNBb2N0RkN3QnJBbjV4RTlnV2RxcGEr?=
 =?utf-8?B?WHRaN2VuczhKek5sMlRPVEZzT0ZlNVFIUWZjMmNFQXIycktCTkMzTFlkUERK?=
 =?utf-8?B?emdkWlAyNW5hcjBlWUtCcTRDWXI5SHE1em1rempqMG8zN241S0ZQaytLWjIy?=
 =?utf-8?B?MG1KRk1oSUxUeEw0a2JPME5FKzBCb1d4R1ZXRmVNV1NKYWI2U3Z5WDNlNG1m?=
 =?utf-8?B?NjdqTWVSdVJRZGlERHVYRmEwYnI0MlhGSi8zbGVPMWtRYm9welQ2M2hmajhi?=
 =?utf-8?B?QzVkdTFmZW1HOWQ4SHZGQmRSTDNmOWl5MUNyV0NKWlI3dG05YTFsbFFEUmEr?=
 =?utf-8?B?bHFiWFplb2t5WTIzZkdFT1dlUDlNM3FWN2NNMTBIOEs0akt2Z3Q1a2E0Z3NF?=
 =?utf-8?B?Z2ZSVWk3b2JwTGFvSXMxUkJuaFEwZXkwejhjUUp5WE9PQ0xPNXhxSWYxZVNQ?=
 =?utf-8?B?aHZyQzh0Q09OTU5nL3hpcXVMUkRZK0xUYnRuMW1yMWcxSjFyRHo2cVMzMGFV?=
 =?utf-8?B?VFBRQUZ4YVR4a21mNVJKc0JOU08xNmc4S2RWaTlESTZpSndTK2JSc1F1aFlJ?=
 =?utf-8?B?WmhhWWo3OUFMdnJnUm1XYThiQjZVdndleDRMbFV5RnNuSGNMRkNaTHpmOE9y?=
 =?utf-8?B?VGFkODRlcVN3UGE0US9WOHBncXQ0aEIvZmxmTWwrVW1nVWd3VnZ5cUxOcFBJ?=
 =?utf-8?B?dCtVNENDOXhQYTJGaHI3eDYweWVNU0lHK05DY2k5a2UzU3lOVDlldVYzbjdB?=
 =?utf-8?B?M1pXQm95Yi9FMmdJRWdMR0xibFZFcFlNYUpFTnpvZkUrNUJiRTVaWjZQditm?=
 =?utf-8?B?aTFQd3FXUkpKMXM3eVNRL283NUtUbGpQK1U2c3ZoVENBK3BxeGozNmw4UFBT?=
 =?utf-8?B?ZHJDcDNoc0pIeHBPUEU4V3JjRVFqelpmcWdwc1NPTnVDN3BleGdsQXFMZXdN?=
 =?utf-8?B?OHVkdUE5V2JvZjF1QlpvOGlhVVFyaThvUFdWVzc5aVpsM0VGNGFSdDc4cnA3?=
 =?utf-8?Q?8CLvRL/0541vPHgMETRuRUkefnIq0jLu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5iNS82N2lXNkZwSm56U0V1cHRmcXpzdHJRYTVMTXlZeGhlRnF0YlZOYTh0?=
 =?utf-8?B?TVQzNDd6WGdoNndZS09TREp3LzhwQWdYOTYrL2xTZFZpOTV0c2ZIbGZuVmVP?=
 =?utf-8?B?TWVKcnVmaDQ2WG12enR3a3RldzlzenZsbE5GTnhvTW16NWkzTnV4aXpvdmpQ?=
 =?utf-8?B?eSs3dzFYQno0YXlsWG1nTjUya296RXkzT2pFclFuWDlWdXdkUUJBT0ZqWDFi?=
 =?utf-8?B?Q25WSEEwdDJFdFVOTFhHRGNkY3oxc0Uxa05UNWMreDd5WW1SY25nYWt2VzZm?=
 =?utf-8?B?VnFicGxHMysydUt5MVpETHRaUTNJalFNSytJQUo0S25DL09TUmw1bWtNNDhi?=
 =?utf-8?B?M29TQVNPV1ZJSW1OMFJCeTNyYi85WDA2Q0lxK3pwSmk3SHA4UXVMZWxHSWhy?=
 =?utf-8?B?UW8xQUF5THVZakVyNVIwMEs2b29EOFVOVTRXRUd3SjAzeC9kKzhVUTJQelQy?=
 =?utf-8?B?U21zSlozS1p2WlRSbkNSK01KK2MwVHZVeENEalQ1Y01rZGVYWnJHNGc5b2dz?=
 =?utf-8?B?UFU1R2ljdzdjNzZNUU8yd1lyQ1phdTRRT1BWTit2Q1Buc0JaVVRyU1JYVk1h?=
 =?utf-8?B?Ky9sZ2xaekw2dDZ0NEc0NWZ5eUNWZWFuQmNHaDlmUmFDTzZ3ZUErRVVkekc1?=
 =?utf-8?B?QkR4SHRTWklIUzQ1d01TdWNqOUNycWJzTStCNXF3Tko3WFFXR2lta0FhZzlp?=
 =?utf-8?B?eEpMQmduRUhySE9hY0wwZFpPNHJQQnVncHgraVNhdTFqMkZVYSsyaFBVQi93?=
 =?utf-8?B?eXVtRDkwU04yQkphNUdBalVRTzI4L1BTdHh3Z0FaQjFTZ3J6allXZDdsZlds?=
 =?utf-8?B?NW1EQ3Rvekl2NjVESWptOWx2SWdjdUdaV2NEOVZXOFJjeDFFMjRrbU5VaWZs?=
 =?utf-8?B?UVVoR0tDMWt1TldXZnF6NCt3bG9kR3YrUTNoUUZnb1piNU11czJXc3dZa1Rn?=
 =?utf-8?B?M3RLNzUzZ05HRElxbk9qY1RNQVUyd0ZyNlV1a0h5NWsxeGpvWGY4ak1FZXg5?=
 =?utf-8?B?UFZVTTZQa1RMQVR5Z3QrbURWK2Z3eUllZ0ptUkhsVzNscnlaaitwSTFRVysy?=
 =?utf-8?B?YXFYOFBaVDAyYncwcDcyUWhwc2p5OXVrSEhTL1o5bXRaeTR6S0VObVUxRUhQ?=
 =?utf-8?B?QXFrSWkxVVFhM3BBb0dDcysxN3Z2eDBxM0R4VWZUV3A3OCtDQnpxa2IvR3I0?=
 =?utf-8?B?b0NRUEhNd0FIdmlENzVKbllSRHJWZ0JuQTlpVjlnSi9ORGtXeFQwSE12MWxx?=
 =?utf-8?B?Mk8wN1JkajNMaUdCcG1zK2dmTjQ0MFhYOVo1ckt2cWNFVkNjV2R6VHJIUTI4?=
 =?utf-8?B?SnVpd2c0aUhzaHVHTCtQSzBiSWZINWx3M2ZtdlUrT2ZaVEM4MlBQSC9TZEtB?=
 =?utf-8?B?dnZETXM1Q1QwdStxK21icmlvK0lPQ0x1TW8zVUhSRU1ZSXlyQjNaaU1ZU1hw?=
 =?utf-8?B?ZGdFdFljMExYaVcrbnRqMTVFbnRiZFhCWHQ2Vmw5bnJhcFJtUDQzT2VOVjNI?=
 =?utf-8?B?OVRUOTlpbEpRZDBlZEpUWUdVdmRjSkZ4VWliL1o2bXFPcUxxVWtjSnVXRVZC?=
 =?utf-8?B?NjVPNnR4N3Y3d0pCeUVLc2R6enh4U2JuaVFUdDRmSVlPTDF2Y2I2aUNKUXIx?=
 =?utf-8?B?SFZQSFhkUzVFWXVySUNBRTBBeGhSdWZJVDBNamlXQkdZc1FNWWhuRU11ZU1t?=
 =?utf-8?B?VTdSbE9RMTJtNHZjNklhSzZzWm5hUlpmOEpYWVZ1UmJXU0xSN015SXV2OWg5?=
 =?utf-8?B?bzRsVjlnbWc1bHY2SzZVcTdidGJpRUczZ0wrRXlTR0QrT2djdjJPelQwUERN?=
 =?utf-8?B?NytPVGxGcGlRUkljd0pmS0tadnorZWxocmRsVGovYkNVL2NncVc0dG5BNURu?=
 =?utf-8?B?bnNCV1VQQTYwcnJkeU9qQlJLdkJ5c0ppeWdma0ozZVNRTkQ2aURWalVTMG1M?=
 =?utf-8?B?eDFFNE4xeGsxT0U4a2lSbUlvQkhqQkVpTFhGdm5HY3JaaFdVaStTR3hUOW9X?=
 =?utf-8?B?bEtGUklsNzBydGJlZkd3RHkxN3NEUzZwUkRPejd6MGhlYWtlYld5Sm1vbFY2?=
 =?utf-8?B?TTJreXRNQW5TdnNGOVNNeWJJcEFxUXZVR0trQStTNHd6WjZ4bW0rcEhaV056?=
 =?utf-8?Q?gmDLQBv7/nhskYapsW5ltcLTC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac944162-17d9-4a8c-388b-08dd3568b6da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:01.8463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvMdd41Fp4vXstU3+doamQHHRLXxLVral5gDpWxWI3xUGjOSl/UcUfjnbRgHskbvUqvhWzcdwZuI2J8nx+4bYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 +++++++++++++++++
 common/spl/Kconfig                |  6 ++++++
 common/spl/spl_imx_container.c    | 41 +++++++++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f1683b0484b84bf18b8612abc4daacf2f69d5e0b..f3840761e1bb1f5f6b4ebbced26d8a8f41eb4867 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -807,3 +807,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4e56d9909c80f8e888034df4a5098d1bb288d9a0..fc8175c853af4b0855e1854f0bb5f9a5002bbbae 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -362,6 +362,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd3af2bc5c738f492a465df280197933..47fb2e65e34829cf3a1a107a5910d73edffe40bd 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT

-- 
2.34.1


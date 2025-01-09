Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32FAE77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9332805F0;
	Thu,  9 Jan 2025 03:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G5esuoPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723768069A; Thu,  9 Jan 2025 03:23:25 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6054F800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at1yaZBnwSuHvnGq/do8Wch5Wz61DHqDWloE+vTYckUZR1SP+gJM0L6U7btc2AWUkTbCj5lUr7H0l+Kqdi+Yr9es4VtXWg0emvB2zr2e+NMBT7QEGTF8m7TqoSX0WYzPiNBDUrXpnzyBeUfsHst2BHF+ddRBzn9djU/1NQNFpDNDQ4+3eJ5MxpV6CglOC0kmcR2Kmm6p+MO8hOfr2JNqGQSz4TvNjJJD5YbHy2nWQSQ6eEqtSFZXUjvK/ytH9BM2WCZptcK7bMVl3ENMpDgS1hvkzR5c47EmGgQDbbmtjNkmAXpNK71JkY7uwWzaTQGUGSUsntrdL0581yv5Y6HduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHjmvUq1Wqk253HLW2WCkLSN0wJGhOsfQBss6A2MwaM=;
 b=TllNccWmKKhd9eI81eaYoCDHTfMZOVoEvmlZDqOW7IWeb3vpJUULxDVE0ZN7fNbXgP7RGosms9Ic5PksqmhdV/frizN+M40DdoGdjHWL9svPSq0wPi1PGwhdz7Udx6SUQVXHZlqluTxs8NgtLxB9C0VvZIiVlUftr5Tii4I0tSDXiK6ebNRhy3geZhENAqEKnXrEduXYmOnjuy23xghXpQTfWSBzeREo/UiFZa9bqBE+rthncZ6IcyTK5DpPaYCdcVH/YArYQ+r7MQpvVgf7zrwxXjq9oVrgO6lPPyRUCiS9DOSmbHYaZR0Whcc6mPixqvWYgBLiY1uGvDKqafdCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHjmvUq1Wqk253HLW2WCkLSN0wJGhOsfQBss6A2MwaM=;
 b=G5esuoPA2hnShfJOfp5jC6E32NJDOP+q+u3/wtq6hb4KqaNYxwOYow99d93p98+jSVIGBVOjNMF/QGOMQRkZnyU5ICfVDWVRfU6Ymom4rNvFpRpGpNpc+Q4aHhDZWp98LKWnCWWjt7uG42REk0sfxuuUME1gAJqktDBwDXWNiaWtFLvhgUdoRsYmobAZKb1G5eX4x9BChmrgc4/vv2LP3/Y5PEHm0XavspLb0F5nfTi4MuOAOkuoWHakxJEukm01IbfHKQtSwi88NBHTumpY+3z99PvpKN7DiOeAmO+iOlPYPjTFwrlcuZLfiowhIAtF+gtP6seoFFK1Mj7yfDvVvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:22 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:06 +0800
Subject: [PATCH v3 05/17] imx: imx8mp_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-5-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b9add0-1294-4ba5-e193-08dd305496a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFl2V3ZsaUhocjlDZk85WC9lWFN6UXNOT0FrREVCaWlVSVo3K0xmVWhxV2I2?=
 =?utf-8?B?NlZFNzU0YlljMStjUEFjNXNDNFRlc3RhYW9La3RBU1cybUxlMVZEdjJOYXdX?=
 =?utf-8?B?NDdIVHlJVUJ0N1dGRHc3UEduMHVOQmg3czRFZjRWZks4RDRKN1ZWTzgxWHNN?=
 =?utf-8?B?VFJ2YVJOQWI0RnZ5aSs2Qisrakh0ZzBTWmVwZHM3YzBIdW16TXVkOUphTm5S?=
 =?utf-8?B?ZTFOUHFZcEN6WGd5M1dRSWsrVThXTHhGQWdTOFAyeHFyU1VhR1JhRFlob05a?=
 =?utf-8?B?V1lJQjFtYmR6Z2hrZHJEc25ZSjNLVGs4aUtoM0xlZzBsZ1pCa3ZKQmJjdVJI?=
 =?utf-8?B?TkVOQVJXd1NQc2JoQ1AwZ1pCYzE1dUVkaGZ0L1pxT1BLYWFnQ0RrcU5aNXk4?=
 =?utf-8?B?aXlwUkI1MEQ2ZVNCS2c2b0hGMmxEMWVBbFBMc3IwS3IrYmlsVi9mdmt6Y0Mz?=
 =?utf-8?B?alF0K2hobDNXRi90ZWVwTzRVY0xQZTRmbTI4aG51VXJOeW5Db2ltQTJDaWZK?=
 =?utf-8?B?TGM4L0JjamRnZWZkR1YrWDczSjRmZFo0blJLMzNEcDI2TUxJeXNQN3Rsc25L?=
 =?utf-8?B?RHp5QTNvTi9LdkFCZUJVdzdTRUZieUhpdlgwcDJ2N1J6Uk9VdnZDS3JTQ3pu?=
 =?utf-8?B?SVlrMzN6aTBSOGJCSVprbWwxaEVFZVU2Z0lnWWZvcnlqaVpuRW81ZmtmaFdW?=
 =?utf-8?B?dXkvQVRyUkk4Y3kxMy8wcFYrRTM4b0VHWXU2eWdVaWVGYWdYWExzTHJodUhR?=
 =?utf-8?B?WnlWQUN1RVdrSUtSMzF3L01tSmpBL08rM3RtTnpTNC9kV3Rud3VXVkdUMjI2?=
 =?utf-8?B?SFdTVEFSTndYanJwb3EwbVg4OS9QbjBwN1d6bXhyZ0dZc1VTVEU2OExZY1FN?=
 =?utf-8?B?SmtsNkpuRDlGOS9XclFBOGt5MXlBSWtGWUF4QWdwbVF3Vm5yWTg0VmNLcnhk?=
 =?utf-8?B?OE5NR1pPUUYzMUpCakM1eE9NOC9DWnNiTVZqUkZ2SkRpenhjeklsc3FLeEJq?=
 =?utf-8?B?ZHg2ZkgrT3M5V09pV1BUUmRnTjNzbnFzTmR2MHMwd2ZvdDlNek00bzBISlky?=
 =?utf-8?B?MkwrWkQyWmlFYk81MXVXcnhXa0tLWi9qUjNHd3F0bkw4VzVYR1pXZ2phMmtv?=
 =?utf-8?B?aUNicUt2L0lCOEw5V3hIODhBQm1KRXRJUjNZWFpoL3JxZUhyaGdnOFRoc2Zh?=
 =?utf-8?B?OEFRYlNQdmliNUZ6a1pUTGREeE5zN2J6UXhGY3B5RUxUNENhaXRFOHZPNXhH?=
 =?utf-8?B?eG9CZEo3MHhFZ3BORUp0MGdrSzZ2SzRQOFBNdXpGWGdPcHBYYjBXSWN1R3k4?=
 =?utf-8?B?NTA0cmpQRE5Kc1Z2MncvRSt3Z1pSNHF0bE0vZlltNU1xL0lnTHJ5TWRYQWRY?=
 =?utf-8?B?RlpET2x1UGpHaGRlV0lJSUJDbzJaOThleEFhd0FHY1VuSy81RmZaL3lRN0p2?=
 =?utf-8?B?eUN2MVlnYkZEQzh3SFA5cmcwM0FpeGZjMTJJVGo2SXk4ODFkaWtxbDR1Qk51?=
 =?utf-8?B?WU9zMWZDQnc0TGtiT3ZtdVB1S2QvVmVWVXNveXhlSjRNZHR1blRFd2RyNW0y?=
 =?utf-8?B?QUFNQiszWkVwQ3FqU0xKRUJMMTVFY3p4a1FyeEI2anJMUy92Z3FwTUl6UmNx?=
 =?utf-8?B?OTlpL1pWSHNxNXF3c3NnQnY4a0hseWpiK1NRejgrTkZjdUFhQngyTkMxNllD?=
 =?utf-8?B?cFdoN21wV0ZNTHJxSG5CR2JWM0dZUTdya3VXNFR5b2YzYkF5bk9SdGxZNEVj?=
 =?utf-8?B?MjRlVnBhcFVXNW9qMkljdXB0YnBKQ2lCR3N5QWwzdDlBbGFyMm5kY1o2b0tS?=
 =?utf-8?B?YTZqeGtlWDBwTnBhVEl2Q09oRHdmUzlMem9zZVRHcG44RTloTHcxWXpuNkh0?=
 =?utf-8?B?c2FBdnhBQ1lZUTBuMG5wUy8xTWk0aUJaZWpTOWhtc3hiV2NDQjhxMUlhL21M?=
 =?utf-8?Q?hr//ZuIziInUVq36thnt8RfjRBoe2WLF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVV5UHZ5dVNtTHE1eWlNMWZGdjY3VU42UGl5MVlHY2xLdDU0eW1qN3lBakV5?=
 =?utf-8?B?SDVmNE5HVXIyVyt5YXRhako3aEVlbnhkRVoyNytpdnFsQ1Y4UGN6MkltWnJG?=
 =?utf-8?B?ZmZSblpBeUNNeks0ZzE3SldrMWQ3TENuWmY1ZlRBSWNhWE95TUI5TENUbkR0?=
 =?utf-8?B?ZVVaVUwwYk9LTXU2Q003WlB6UFhqS09hbFozRnROeUFKQWFLZjlaMTJ1eFdr?=
 =?utf-8?B?K3c5SnVVeE1MWmlwcU9zanZGS3BiZW5aRWczM1ZCWTViZk9oMUl6d0RSd01S?=
 =?utf-8?B?TGk5OGNrZlZ3S3dSa1BVdjZZTDNPcGFpMy9ZZFR2Y3dYdFlDK3Q1L1pxcXpy?=
 =?utf-8?B?eXV2SkNWWWRhVzVtTmUxTWIydFdVdW9pWEtyVWg1RXdyQ3FING9oTWx0L3hv?=
 =?utf-8?B?WFFJamxFRCtUM1NSbTlOTTQ2cUdObFFaMmdOVUY3R0RFVkxEdTZLdStxNnJi?=
 =?utf-8?B?SEREbHBLdjBrdHNCWTlKZzBqSmNPR0FrK0dGOVkya2lVa1pjK2l0d0JlQzBB?=
 =?utf-8?B?eDlzekc0Zmt4S1oraFhxVTliQmpINnFwUW9CRUJrTkdWTXpPSHhuNU9IU21Q?=
 =?utf-8?B?NlVzMUoxOCtiMVR0S29GbExoeWd2ck12TnE2UVJFYmRubmorQ2FMcHNtQVJk?=
 =?utf-8?B?cW42ZWdBY2gwMm9Ya3NSYjQ5MFUrSWovNy9ObWw4aUR0bUw4MGF6ZVpZTi9R?=
 =?utf-8?B?eEdIUWlFSlo3MC9hT2x3eVZFOU9KKzRzT3pRTUpUdGdINlRWc1BpU1hzTlQ1?=
 =?utf-8?B?aTFBbERub0xWVEJ5dlhudXJNOEhOeEtzMzRaMEIxMWI5NEZJeDNJK0N3cUg0?=
 =?utf-8?B?TTZ2UW14VXVPdnJnNWZocHM2YWxIa2dxSFp3VUYvTWpaeXV0MVZKaVRLdGto?=
 =?utf-8?B?Um43b0phNFFQZHM0cm84b3JidVJLcE1EVWRkNVdLS0Q1QlptWi9aUUZnRW5m?=
 =?utf-8?B?ZjVGdFBoWFRCTW41ZExianRsNFdubkdoZlJFRmtGMjY3QWFxQWR4YmNPcUdr?=
 =?utf-8?B?alRPWWxpZFhPb1NHcTljblI1eDVxUFhWT2QvaWh2aU5XMU9VM2dMVUQ0YWU3?=
 =?utf-8?B?YnZySkdoM1pjZ0E3SVlWb08vZUNDSTNhWEwzWmFCd2U2QngybHRoVERrU3BM?=
 =?utf-8?B?MXBJemN5SjZuYTlsdUNEbEtoUzJuMmJtMkt6aXRDZWN2eHFQNDFIZ3E3dDNI?=
 =?utf-8?B?aEx4dHNYY1pENVZCRThId2NOL2xIdmZNemRVTTB3R3NLWTZLVmN0L285bXRs?=
 =?utf-8?B?cmp3S2RQM256MHQ1WnRIemVNRk1qMllBMmJIakRPMGZkeExzdlFBS1poNzMx?=
 =?utf-8?B?RTRpamlGWjR5UnR1eStuRTlyaTdQNUJTa2NOdkRLbXBFS0o1NEM3RmdQUmVT?=
 =?utf-8?B?OFFmUmxweHg3OS9kNFRqUk5ZYXIwZE9zVll0L2pMS1JIT0VWWUVjSDNyZWgy?=
 =?utf-8?B?ZU1NenpMSXNmWW1URG9JZ1pDTjF1T1BCMTJDeW1KcUJtcG1pZUZZT2RyaWNW?=
 =?utf-8?B?ejRsNGNxRUdPemtHU2gweEhQL3hHU3Q2VUJTSmVZNENZRFdDZEVWT1NiQUd5?=
 =?utf-8?B?cVZPdHQwZGQvRHFTbEZnY01OUDdwSVdLRGJBWGFuamE4Sm9lZG9RdlAvMVlk?=
 =?utf-8?B?SzNrNHIyUEw1MXBBS2JLV2h5bjBpU1VLSUxtWEc0MGNqRlJXdnlpeXZ6ZThY?=
 =?utf-8?B?YWphTHRTV2NaTHdZMmp5ZTFpOWxraU5SRlJrUXJlT2pDYTY0RWR0K1pJQ0lq?=
 =?utf-8?B?Q3F6UTNUQVlUbHc0aldJVklLWm5LekNDeS9oT3BHR1Qwa2grNmQ0MENQVmgv?=
 =?utf-8?B?dXRtZVBEUytiWGtHbi9NREpxVW9qZlNxSnVqR0g2TjFJTXRBVmZYeFA3bHFE?=
 =?utf-8?B?bjA4LzNNcjM1VFp0VmhHWVJJRGV2eUt4QVVydHZQWFlMUGJzckhZbElxUncr?=
 =?utf-8?B?MEg2NWExazlmSWRpNm1vUWpqNGtma1lvYzVLMy9GcHA5MjBOL3AweFJFdlFH?=
 =?utf-8?B?RHd3c2VnQ0dGRTJaUG40aWtEeVhLejNnSDA3Mmw4UjJDQUdwT2o1TnZSMWNQ?=
 =?utf-8?B?b3p6MERqTG1UQjBXSnpTbmdMOG9xQ0hlVm44WUlUdzVkWVREV3ZHRXo3eDd6?=
 =?utf-8?Q?Wq265EZZkvK81QVIWGQ3GN7cj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b9add0-1294-4ba5-e193-08dd305496a5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:22.0704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzyliGIzbSzZ7J/qTGi4m/aD/C7JiDxsdWv3VK8d59OSUUEpdYn2ub8mx5qmt2q/oLi/UOfYNU4+NTSY2H98jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Move env to imx8mp_evk.env.
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  2 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env | 57 +++++++++++++++++++++++++++++++
 configs/imx8mp_evk_defconfig              |  2 +-
 include/configs/imx8mp_evk.h              | 21 ------------
 4 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index b254a50b091a05393d99db6000dcfcb4427dfa5f..0cf3c1baffeecc5d7475e6f7b8d77539aa9646a2 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -227,6 +227,8 @@ config TARGET_IMX8MP_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MP_NAVQP
 	bool "Emcraft Systems i.MX8M Plus NavQ+ board"
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.env b/board/freescale/imx8mp_evk/imx8mp_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..18f6c6e200ede28201c95eb34c23a596e6771fb3
--- /dev/null
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.env
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2
+bootm_size=0x10000000
+console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
+fdt_addr_r=0x43000000
+fdt_addr=0x43000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+image=Image
+ip_dyn=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mp.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if run loadimage; then
+		run mmcboot;
+	else
+		run netboot;
+	fi;
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5369f8b84a4172434dcef142c854d06e3437caf1..2438ab5d26a7d9b335b4dbf3451520bee81b665f 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
index 741ee39db1a340136b57d9411d96bca995e0ebd2..dfb5cd22528ec4febee8a2fe069c17cfdd77decc 100644
--- a/include/configs/imx8mp_evk.h
+++ b/include/configs/imx8mp_evk.h
@@ -17,27 +17,6 @@
 
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-       func(MMC, mmc, 1) \
-       func(MMC, mmc, 2)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fdt=try\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000

-- 
2.35.3


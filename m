Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F13C28B22
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5748083E;
	Wed,  5 Mar 2025 14:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nu5PviBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82502808B6; Wed,  5 Mar 2025 14:28:50 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23AAA807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjALHqE4h7VGRD5/Sr2OKC11coVFEQZDkmc0nFlWiUsKoUzNxpd53i/nxjqjW7BfbPD3pEoKUeJYHwuluvICbnszn+ETn2KDDs7MRfHBuLxPBScfbwkW0p7RqU3JYM/L6DC/D222EZtzUofcC4cXRzwnRUMPcQp89PWcAMtyY/X47fsZ1MrU1ElksdANuBkbqmLX8FtkV1ngANmmjxCeajR2DbqXknsx7yj1d03Vp0DuaEzDVQn/GWOTZcrvC1OdYTH1QHOyR20xQaZVHqWDMhzjfiwISGz6vr2wH24v4Wzev42NN7ZF1b3jVP6qbqFgYCK9paODZzgBwn/db4DR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnARmj0EdPxBs60xfWKz6vdRoQbKaKwg7s1QESkRwJM=;
 b=aKd3cZNibkvXo+cFlnvRyzPL5ngoQQ8WEAWeGD9WbowYtd6u1JPPXNEfTq8+1aNjqqo6xiKux7Gb+HU1mgs4iY7jXfjLTiSZse7ghrT6evZzi9X8Y9rxcxh+RxpG/57n2RBnGKEECAnz1Z/+xyszv+nhwReG7WRH7svD1Bp+sI40hk+I2Hw7fWoml1f3E91cjuoRhEGzeHxz2xSa4UT+PkAMh8QD8KxAMJfqiEVq7qZpt11/YEZK1q2fvxMdoxZPOwpfgydl6321sjqvlX/O243wx57+yjCO2lBnenl+KOXOnkGDJZb5ib7aJAOVOqIj8oV0BOfcQKYzSn+L+ejt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnARmj0EdPxBs60xfWKz6vdRoQbKaKwg7s1QESkRwJM=;
 b=nu5PviBVcu7ZuABlrGwlKQNE8xip5czVfmBLNe+jONfZryxMFPsdVVBHT8Z6ZTGc5q9d4r+AfbuQsk97SEQp2Jykhqh9lUTNM0/4Adfo5IdJ8GxgFUWe9ZASQiQFOiyprhYrT6fNdz77nBF4buUIiEt2zOIi7wnC5aNnkpPd5Vv7mKJWCEpoh5ZHTVmazX8k6bT95j+wN1t1qROu7AWps/fOwSKejNDSLVznTx8Ac0m4np/r79/dCRnGWFiXXIoGMZv2s268ZLBIi3ObSKy0IIzdBvSZFZIEnEekzaiK5W7KBU9TkTrieLmXW5pbaJ4wzd+YDxgAXA8D60kc1xH+xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:28:44 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:28:44 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v7 00/19] imx: add i.MX95 support
Date: Wed, 05 Mar 2025 21:28:12 +0800
Message-Id: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGxRyGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNT3czcCktTXQML09TEpLSURLOkZCWg2oKi1LTMCrA50Upl5kqxtbU
 AlgrG9FsAAAA=
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Teo Hall <teo.hall@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb8e2a7-789d-415a-d4f6-08dd5be9a6eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG0wS3lvWjFQTGlDQW9IZ0pPZDNjWTV1a1VjRDlqQnNiVTdmUzE3NGJ4RnFW?=
 =?utf-8?B?QmhVL1Nnb1F1dk1XbUFxb3FYTmxsdlhJTE40T3BYQ3BzelJZQ0lmT29XZ3h0?=
 =?utf-8?B?NHFNSzdnTVliQXZrNXhtQVc0OTRkNEo4azlwaUxhUUV6cFJCYjRiM0ZsMkNS?=
 =?utf-8?B?TGFTcnlPNTkwdG9OcSt6cmp6Rms3UzZQS29FMGc4Z2N3cXluUDdIR2YxK1M3?=
 =?utf-8?B?Vkdycll5OGpzZGlic2JvS1BtT2dhOGtjMWg5OVNNUW5TWktMM3JRUjZiNmRV?=
 =?utf-8?B?bmpBWFNCNHJoaHk3L0xwUWNZWWRNZHFxQm9LMWpaZHI4cy94SlJseklsVXJy?=
 =?utf-8?B?cmVFUzF0SE9USVFNSnpaK2Q1QVR3OXJGNU9MMkhycmtHMm1HbHExemh4UHc0?=
 =?utf-8?B?WDVxMW9nZE1XV1VhVjU2SGNJNUZYVU9TTnk3ajVLVlFrdzJ6bTBaRWY0OVF2?=
 =?utf-8?B?a1ozUGNFditRMlJaR1NxWHQvdldweUlKVTA1Zk1uNUZWWmg4UkR3Mjc1elhq?=
 =?utf-8?B?THdWZHlxcnBKckVnMDcreUFNSTVpTjJkMk96ZDhiVTYzUmYvQUZyREZERENv?=
 =?utf-8?B?UUdQOGtRZFVyUXo2THZkYUFvL1pQMVA2UWJnMjRDL2lQREtWeE1VT2l3bkJy?=
 =?utf-8?B?SUVoM1UvMGhnb0RRSjhLWFNoTGJIUlhDdmljTE9IamgzQitjOHhYU1UrNUlI?=
 =?utf-8?B?TDdrOENMamNXOHhvRHFtZk1Pak9iT3J3T2M5emUvaDdWNG9EYzYwdVpWZnhN?=
 =?utf-8?B?aVA5WXFOWjY1SHM2NFNyR2dBZys3aWN3T255enJNeEpRbHhrVXkrYU5pbHla?=
 =?utf-8?B?amZ0Qko1UWdxaFdPM0I5azlSTzd2SnpITTRHT3Z1aVUvL0FrR3EvR2tRd0Mx?=
 =?utf-8?B?eEJMRzQyejE3dGtTNGpZOHNERWhYNURnZGtDaTdQK3RIRjZwdWxCN0QyckNE?=
 =?utf-8?B?a2szVVROanY4SGpXS2NXMGtUZ24wRzhHUzg2eVI5UkZkcG9mdzlrMzRjcU1y?=
 =?utf-8?B?TmNZdjJFb2FnLytCOHZLVUJCM2tJS2hvOXlTVlV4UEZZamFoOWJnNS9lTVBt?=
 =?utf-8?B?TThDZjlEYktvWDNESU04eFdZaTZkMzRiaVF4VnZpSjAyN3dOeWd2SUNZNm5u?=
 =?utf-8?B?Ylp2Ynhwemc3SERJaVJOdXUvMjRnN0hSOUZzeFNSaXdUQVh4NXBBYUkraDF0?=
 =?utf-8?B?NFlNUS8yaktxaDdTcHVsV1NuRDBhbnVENU8wOXpGZ0JNQ0RMaE5mSzlMaVp3?=
 =?utf-8?B?MWJlY0dQMGVvQlJraktQYlZraG9mZWtSNlk3YTk3NkNBMTAzdTVSb1JNM2pE?=
 =?utf-8?B?d0FtSXh1dVBjZjVaSU9DWGI3TzNXYSt1VWxybEVwWm9SV1JVdTIyaXQ1Nkxp?=
 =?utf-8?B?bmF1NVd5RTRCekNqNnpOZzVqa004T3dZRVNKTk1lOFhuak1aUE5CTXg5VllF?=
 =?utf-8?B?cGY5SmlONkNSRGtOUVBYZi9sd2lqc3N5UlRBMnROR3Z2ZUtjQmRYZGJSYllE?=
 =?utf-8?B?eXBLazhYZktqQXp5dzM3R3RzRXU1UDNBRlFGcTNiMFZkUHMxbmVLaWNlUlk4?=
 =?utf-8?B?SnE2U2ZEejExY3VrbG1BNi9GMklFY0pmVW45NzVDN1hMeVU4dGdHU0NpV2tV?=
 =?utf-8?B?YzU5RXp4MFpDZW9YdnRaSk51dUgwRDYvTDNmUklXMkROaE5DM2FQcmFGWXVS?=
 =?utf-8?B?V0VzSEJ6N0REeTN6alpnYW0rNTdOZU1kQkw4cTJGcElZRVlGSjRrOGdsWWlx?=
 =?utf-8?B?TEVlbFJnd1N4QmZNbFlnaHZUOVkxUnh0VzRPcXNpOHhzcEdDdXo0NHBPcnJw?=
 =?utf-8?B?cFF6eURDclh3STlBSjRqQXh6cndCTzJRV2dRRmc3WVNjV2ViVjJIenJ4U1p1?=
 =?utf-8?B?WVlTUFgrcVhPM2M3UU9tMTVvTk5ob21mL2ZmNUVkVHpzMVlNaThKMGlnR1dM?=
 =?utf-8?B?Vlg1eTU2NzdEak1JMWNmUS80TCtqQUJiM3Y2KzBGY29yeGxRelY3L3hGc2lP?=
 =?utf-8?B?V3dZbW9wWDBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05zYzExZzBMMmE0Nk1Cdmw0Y0dXS1NhUXVIRUlRL2lOT0VEcldsZ0psRVpZ?=
 =?utf-8?B?cWowUlU4OEhPRnI3SkgxcnVrL0lnakY0a0hJNXpCbmlJNXd4TmJWWHBWT1hz?=
 =?utf-8?B?SmVhL2l4cHcwK0docml0Rk45MUl2bWlnZlBDYWpIeEdzaTRHL1BFQ25weXBr?=
 =?utf-8?B?K3hXSWFJVWlESEhhUm01UXNqVkJhTW9PczBOajY4ZlFDdmhYRkkwVU84eXJv?=
 =?utf-8?B?dWFUaWRPVEwyMUF5bW96d2N6cDVwQmszbzA2V3FJcjlYVXhjSHhlUStsU0NF?=
 =?utf-8?B?L1FGTXFQSUhXbzdVZ0lES0F2ZUZ4b25WTFhQS0pRTVNXSFRNVmV4ZnFoMVNO?=
 =?utf-8?B?MGoxRzB1eWlId3Y4SU9qaUcyVTlrSXplaXdnbFBQanhYQ00rL3pFRzNRZTFW?=
 =?utf-8?B?eFVySFVVNWdNNmxmYkI4N3R2d1pYSXJBSXBJUGRSQ0h5Tms5TzdQc1lZNEZr?=
 =?utf-8?B?TytWVUV4anpvVC9ocnNQV0N2V1diNzZldjQzMkVpZm5ZOWo4ZW0rRGlpSmM2?=
 =?utf-8?B?NzVicmZEWGRYK3FFMkhISEM3U1BYZ3UzOEY1MU9oaFlRQjk0eHg5aGJCSUhw?=
 =?utf-8?B?eXVwTWl4NFJ6MUgwcnVRQXpUMU5iaDBzT0xnS3BGbzJmMVdxY2U1cnVxNlRm?=
 =?utf-8?B?TC96ZHkwK1BSeUVmWnJESmZCbXA2NGpvQXdyY0tYV3BLOEtKckowT0wwaElr?=
 =?utf-8?B?UzZHekw5VCtvYitiZWVTeUhxUlZwMFpBNVJoYjl2L1pwU3cyeDJBNTVoYkFp?=
 =?utf-8?B?T0tNQjFRU20vd00rMEpWbnhuNzEyYlh5eDVud05yRUxlbGpsQ0dWUm54Z1dR?=
 =?utf-8?B?K0hNakJqbm5XSmQ4dEpvZVZDbFhVMFVRbzVGeE9kTlMzc0VIL2Q0Y3ROdllk?=
 =?utf-8?B?MlcwMmtvbWV4ZFJ0d29ZdmRibHBHc3gyOTk5cWFObUQrc0FZbFJEdFBPazRQ?=
 =?utf-8?B?emdVTDFTanZBZGZubVVKaXEyOWk5TnNhbHRvNm5OcEhaTkFTUC9pZlZuWkZC?=
 =?utf-8?B?TEpoamo5VVdGNStjVitJckRCb0w5ejFPK2VoaEs1Rm8xOWF0TFl3a1M1SHlt?=
 =?utf-8?B?WEoxNXUxNXNPNGVKMU9aSU9STURXL0tSTXBMOU5yZzlka0pXMHNsRzROV1VP?=
 =?utf-8?B?a2pUWlpNVkpFS2lEZGR4cEFaaG5oUE1lcE9ab1Z4aCtVVEJSTGNGRk5acXNV?=
 =?utf-8?B?R2NWUU5UL3ZrWTdSTkdJdFhsM2g1c0FwVDhvUjJCUUxOeTZ6MS9mM3hhbmM0?=
 =?utf-8?B?Mm1iV0xLMlhUNnBoUHVqeHYxTFpNV0ZwMFJRdklJVW05Z3JReVdHZE5GMFpl?=
 =?utf-8?B?OExkKzZMbDZ6eTZIcEJ0VmdBWWJmWVNMT1NPa2h2NjZxQVFiUWJHL2ZLSURE?=
 =?utf-8?B?V2d3QmR6MTFnYm9wUm9veWkyNW15VTZKV3ViTFVsbG5Ob0hUR3VrWkZZWVdI?=
 =?utf-8?B?WCt1OUtVaTZ2SGVaZEQweVhLRHd3SGk5NkNNME5IcUx2YVY2dzI1OGlYVUNn?=
 =?utf-8?B?YktJaEtrUWJMT042Q2U4aGxacmJ0ZDNvWXJsRy9La2lIMGRjRE1kNTZ4RWQ4?=
 =?utf-8?B?cHUwVy9qY0F4NUFvQXZXYVhVV2pnRVFPa2doaEY4bFFvVkRLNXV1Q2puaExi?=
 =?utf-8?B?Q3JBOXlNZS9sYWFBN2Y1VVVKdkVRcGFIcTVvbFlqNmErOStwdVp4Zk5jME5F?=
 =?utf-8?B?Z3RRelBTejBtdm5yVEFvbGFQWG9EK3YyVlg4NHM5K2d2V2w4WmxDRXRDOUVa?=
 =?utf-8?B?bFFtZ1FoUjdTclR6NHhsK0tEUHRDaG1CcGRET0MzY3pjQTdTVWFLRVFPQ3Bz?=
 =?utf-8?B?dmxwQW1zdUtGS0hPSERKTGhmVlMzQlI3M25EZGh4cmlJdGJRRll1ZkZDUWFY?=
 =?utf-8?B?bHk0eDVMbjZhQ2xGbDVJMDdQTGpjanFrcEt4STR1WHpGQndUQkpHRUlPSHNG?=
 =?utf-8?B?dTRNVURQeXVpcHRGZjIzRHp4TFM3bXhvUVE2TkFPMU84eHFKdDRRbzFTUldj?=
 =?utf-8?B?MzN3aTdadzlBZWNqWXhrN2xPQ2Z3ZFZqWmxyQi9udVRCQzhqZU80aEhoYTNn?=
 =?utf-8?B?ZzBCYWlRTnhjSmRCUlMxbWQyeVhCVXI3U2xGNVBoUHF6cFh5dmtKQkI1akxs?=
 =?utf-8?Q?ix+htn7KoIU+Qb65rM3y6HEbG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb8e2a7-789d-415a-d4f6-08dd5be9a6eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:28:44.5117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ov7WRPpjTI94bYJoJSaOKx3S3Yit494xLWHNm6Z0dk9i3F4IGqr04UHjdPsi8MTWmW1Nlc8W2iz4EbIme6AUQ==
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

Changes for v7:
 - separate i.MX Messaging Unit driver patch from this patch set
 - add U_BOOT_SCMI_PROTO_DRIVER() to avoid putting i.MX related code in scmi_agent-uclass.c.
 - update drivers/clk/clk_scmi.c according to comment
 - dynamically allocate the size of struct scmi_base_discover_list_protocols_out

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (9):
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi_agent: add SCMI pin control protocol support
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support
      doc: imx: add document for i.MX95 Image Container Format
      Makefile: add some files to CLEAN_FILES

Peng Fan (4):
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code

Teo Hall (1):
      imx: add V2X container support on i.MX95

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (4):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx95_evk: add i.MX95 19x19 EVK board basic support

 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 +++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   5 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           |  63 +-
 arch/arm/mach-imx/imx9/Kconfig                |  16 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           | 105 ++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 806 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++
 board/freescale/imx95_evk/spl.c               |  72 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 152 +++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 191 +++++-
 drivers/firmware/scmi/Kconfig                 |   6 +
 drivers/firmware/scmi/base.c                  |  24 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  25 +
 drivers/firmware/scmi/smt.c                   |  13 +
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c        | 159 +++++
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |  17 +
 include/scmi_protocols.h                      | 104 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  29 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 143 ++++-
 tools/imx9_image.sh                           |   8 +
 50 files changed, 2930 insertions(+), 73 deletions(-)
---
base-commit: 986ab810fa2cb095f5617349baa5c88d83cffc46
change-id: 20250305-imx95-085eabfda6bc

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C631EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D0F816AF;
	Wed,  5 Mar 2025 14:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xCGpJizS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3AB08164D; Wed,  5 Mar 2025 14:30:10 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA433807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZXEnESsxapyp6uznJQLqqtzpa7VvwNBTVTq0HFXrtFIjrk0mrLx3MZoRVNL6kKPYmLDQVlHGwC2tzUNDZYylI9yWxpxH0jpHLcuf79PH4EvrBjksepJT1nCTwuNSTbUWbIrcAxN8JjZ8c/aINQ1U8FfMBmUqxws1yDHTtPxr2mKVMPqrtNlHHvtFc9V5PLuPCUkJKLZ5sw8Yn/AemhYtENrpO7Rbzsd/uxdarB517TGkKMblDSuVLAmt++xZ3BFMkV/v5L1uq/WAC5f+nwp2VmjwQ4xQTBPPGMb72m7cbNcoOUo24szecC/eyHAcZjXXTj2ZUkppxDJYvjjSbqn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4lWJ7dvEATJESzuWZXPaxq+vC9sNi8pdJ6k9zQkKsw=;
 b=iGItlK/QL3D5wURqHf/leP2enfUr4E/IsztFOqLxD5cQZMEoGB7GMmnUCUKlD1pzDpbdi940mCVlGH6nwaNdgTBVDqUp8Y9ounWTjvYwvQi2/eit6MMXcnq5FjzM6nRdBjBrEOdkFq98MH26vOyNBdVMWn2bigu6lgvjgH8rFnYazz/lNrlRelbJw/qXbY/6In/NinxbFTPMswjH1Cve3ZZxwxf8A63ymfpPMi7hJ6ELWHGzKPRny0te//GohQ+IfJCHKdor7TOdepQ2IpzSvMhnLFI8sqa/3yb4KOw9UrBbbb7RNBXScSyMcpcXEQ9MbdENP6Q2/XcpDImPZyRI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4lWJ7dvEATJESzuWZXPaxq+vC9sNi8pdJ6k9zQkKsw=;
 b=xCGpJizSX3jM+yUGB5Me7gMlOE7yxfpYUSPAzumuxzfZbCjcIDSAWOgwuyaXPQosbDwAMhA8YZ+hVAEyGLfZq/yNIjxDJAevdoFyykoDevydM4kYaAoZjXagkclL7Uo7eKALJlzb+dSnSwbnpslSysPbQmBDN5n2dhiCW8ppCOPBaOLJh1BENjcAr/pwKUn+WOZ5bCnKOE2RqbMYBDfC+S7qpomJbar2cj49JnoTbNNxTWGHkSlgGXt/mJnzj5proe8bgliKqw7daJ2Sw71CECcScb7IpPlulywb8Ai4uBaH++AE5cVAL47aGRTao31JQS7j+FQrdBez36+QAD9Suw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11028.eurprd04.prod.outlook.com (2603:10a6:800:27e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:30:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:30:07 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:28 +0800
Subject: [PATCH v7 16/19] imx: add V2X container support on i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-16-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Teo Hall <teo.hall@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB11028:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b12ac9d-8334-4f78-303b-08dd5be9d826
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDZibmtyKzBxcml4QXlZanNqa2xRYlg5ZjA4bVRUb21tSGFkQkw2YTBBOXg1?=
 =?utf-8?B?SEFyR2VyaDhVMUJ6cVlTeHZmQW14YXpKR3FJUWFlbktrVm0wOG1Sc09RRWlP?=
 =?utf-8?B?L1J0NnREaCtnQXFGaWlUbWdqc3UzOFZLQVVUeEQxdWtCRklDbXUrK2tiL1dZ?=
 =?utf-8?B?T0prVkFlZUpQcmVVaFpvZWMyY0E2R2J6QVBTY1JGSCt6Y1JSUUprR1BHd0xo?=
 =?utf-8?B?LytsbVJ2T0tJQ0dVSFdYRUtEYVhTRVdTVitrbXJjc3NBTmxmdzB6ei9JR01z?=
 =?utf-8?B?U3JCMUo0Tnk4T3U2T2NkQ2ZVRURvY05hS0VBQTc1L29ON2RxRFdRcjNIUERr?=
 =?utf-8?B?Nll6d2FCWXVPd1MySzdSTDVHUFppbHE4RGdLZWZZYUpUUE8xWk9tMFlZeU1m?=
 =?utf-8?B?VkZVWWJqdzg4UTBHYVVUSFhmQ2psdmJpdmFGTDZzdHRZL0VXaDQ0WWxJV2xU?=
 =?utf-8?B?RFp2RXZxZFlDSUNvUTRiY2JKZ2dnNEJHZDYyTTFKV25qQjd2ZTFKcmxOL1Na?=
 =?utf-8?B?VXQ2WUdsYndjcXJVRnBoTENFcXVVbmhJZTRWTXVEZXdtSHBvR0tjQjFmMFFO?=
 =?utf-8?B?QmUxMGVhMWk5TGtHS3djZUNEamNRVGxGeFN2SzhpT1FXMzJQNHN3L1N2OERw?=
 =?utf-8?B?TjhKQVB0akZtaE80NmVVUzdPaTRsM2ptRGJvTUFhb1BKdG1EMWFWeWJWUHhz?=
 =?utf-8?B?SzBYdnpiVkp3QjFJeFdlSXlDQVJsYytHWVpNRFBRaFhLZVR5b1JKVnQzZHAr?=
 =?utf-8?B?YUJ6UVo2VVF6UlAwTFNOdFBSU241NURqMWo4QjJLTUY2VEJueDE2U1ZQNnM3?=
 =?utf-8?B?c0RIYU41TUx2dmc2NHlFVFV1QUlLTGlEb0tIRklmeWZVSWhUSFA1bUpHREdK?=
 =?utf-8?B?bEF1N09DcTFhK0ZwYW4wZ1JWb0ZXS0dKTlU2eG1wUG84QmVIdXpKOHhZeHlJ?=
 =?utf-8?B?RGRkSlZjQyt2dlRuV1M0aUY5cWhzZG8vWjRMNTI5Nk5NTmZVNTc2emg1RzFR?=
 =?utf-8?B?aVIzSVlFTnZPZTFjVWhtbXoyS2czaTY2VXpoMmRxUTVURFpDNnlrakgxcWFp?=
 =?utf-8?B?dkpRdlZXWFZPeEpJM2RlbWRsT2Y0cVMzaW1JblZzNVpsVU5yU0JZQjd2NHZI?=
 =?utf-8?B?Mkkwb3loYVNYU2VDbzMyKzZYcTREbnhzWWkzQmlDRFRrUU42Y2RLaTlaRDNt?=
 =?utf-8?B?WkYvczRoVjAyN1h6bFl4V0c5ZitVMGczT2hJdU1qa0NzVTlOT3FrM21xaEhm?=
 =?utf-8?B?WFIwNTA3ZkhGYVNOR3VFVGwvOU9QME9XQXNJc3RwOGhOUGp2YUZyQ3ZaMFMx?=
 =?utf-8?B?Q2t0NHhVS1RaOVBLd0V0aVlFUnRVTE41V1VSbzhDNGtIdHR4aUVOMGxqc1FU?=
 =?utf-8?B?YTg1OVA4ckNIMWVDOFRPbW92dDZTMUJzYTNQZ2tOUDNJY3NHRk02OE5uRmFJ?=
 =?utf-8?B?b0F4UEZySEtWTDZlejJaNHdvUWkraFEvZ0JVNVpzaWhvSFhLbmMwLzNFRFpV?=
 =?utf-8?B?ODZWdWk1clhoWWx5ZE5NaEtwcWkvenpTeVRyajY5UGQ3YlN6azRwblpSTmlr?=
 =?utf-8?B?eVcwb1JmTUdydVUvMkFoeGdIOFdjLzMxSDJRRDRCb2gwK2VnM3AvVHZYTlk2?=
 =?utf-8?B?NnBKYklzNVBmVWEwd3lhemkxT0Z4azVjQTVkVnB0eFMwZ0hyQ2ZLaUJ3MTV6?=
 =?utf-8?B?WmVHZzBLRFlxcVI1M1VXVFpGREJvVU9lUElaMjEva1pLYWlaLzhNZVZadEtC?=
 =?utf-8?B?ZmVHUHpHbWZvK0NqVlMrN1dlR0JuS3pqSXRvcVBaUHdwZFh3ZnFTSEZTRmgv?=
 =?utf-8?B?WFRvaU9lRkFyL2xFK1lpUkYyYUlWbGp2UTFMNW1maHBxYmZ0b1NScGl3aHdV?=
 =?utf-8?B?QzRGYXZXTEVNUEZ5a1dvOUNlR2lQcmVMV0xpck5UMFpCNTZwOHU0aE1OMWdl?=
 =?utf-8?B?bkVGM0JRV1F1V3Y3V25QZVlXN3RPVFhjYzZkcFp5NzZsWkFhV2lnV3M5TkNK?=
 =?utf-8?B?N2RYSjJBZE9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THN6ZmNMdE5HZUpPQ3pjZ1RmYjFhTTRwVEFrdUFEazJya21JbHc4Tm1NSGU0?=
 =?utf-8?B?bUFZcTIxNWRuUko4clVVYXF0ME1KV3FZVmFNZktTaTFYZ0VKYW5KcW81R2dO?=
 =?utf-8?B?OGl1dTRzWjRLK2xiVmlydG1Vai9TSVhOcEhyYXdnVEwzekZPQ2tFMGg4TkxI?=
 =?utf-8?B?WlNkbWdGSGtSMFdScU1jZm9RV3lCQi93ejYxMTdPTU1pSklGTkI1ZUMyRCtJ?=
 =?utf-8?B?YWxvTnNPSW1sUEgyeXo3dHIwM0VRUEhPVkdadVV6QjdyVGdNSHp6ZVJSMnYr?=
 =?utf-8?B?Nm9QeEtQb3JLRjB0TEFqckF5Vllva1VjbC90aitsRzYxQ2tKR2htNy9oWlY2?=
 =?utf-8?B?aUtOUmFhR1Ezem9CWXN4ajRoQ0NOZkJ4Qm1NTDZqVkJ1RXJnWENSK041WUNP?=
 =?utf-8?B?RkpxcWM5ODdtZDhFeHpBMnAzSzNJRDJRTVRvMHladHlxUGJXcWEwbEtZT2I5?=
 =?utf-8?B?aXcweWkwRG1JNVdrSkxUYnRVOUtFdTFtNWYybFZPVGdldjBFTm13NHhCOEtv?=
 =?utf-8?B?N2hFelFsbTg5Rk41VUg4a2RpVmE1MkY5TE9UK3U5VG9ZVEZSQi9BbDJ6ekQ5?=
 =?utf-8?B?bTk0ZEdVNkJpS2xZS3RUamh4ekpkOW9Ha09RVXZyeVloTXVZNjVZczJ5bCtm?=
 =?utf-8?B?SS9RZUtjNFNOT29BRnM5M1hmMnJDdnZURitJMFVJSGhUekNScElLQzBVTjVa?=
 =?utf-8?B?T09nYjRUM0ViYVNCUzdNZDJMWmYwZ2RJRi9XcUVxL2pVZmhqYlRDVE1sTzg2?=
 =?utf-8?B?MVBEVUtPL0NoUTZRdnBTN01HNVUxNUZmZXhhRUphVlR0VFZUdHROWWF6cHZH?=
 =?utf-8?B?UmxEUWxqKytXaFRaTlZzd2ZkRlZaVWlKSlZVNXNDb3lsT3p3WTRaay9QZnYx?=
 =?utf-8?B?aTBvUUpEQjhZMUh6Y1NsK0tpc3BuZGpmS3ZMWitsdFdWS3oxRDV5QUtuVzNr?=
 =?utf-8?B?d2hoTEVBUjErNldGUXZKbTk5MjNzdG94dWxFSDB3RnBrYzE4UGhCNHBIQlJm?=
 =?utf-8?B?Q3ZHTlJ1dlJYYXlTajlLTVVyYXJxSFlwOTZ0N01CTnluQUpnM1Vsd2I5UU1C?=
 =?utf-8?B?QXRod1o1ZCszNEZVQVNFdUd0S2RpR0xMRGxNSVNobjhVRWxOdzA2SllNMjlB?=
 =?utf-8?B?SC8xV3lEYWdra3pIbU16bWxhYkRsSnVuSElVSFo3aUFmdUJyc01sWktZT29w?=
 =?utf-8?B?cTRxVmNiUngyREk3citiZWZIRVVVMndvUVVmajc3V29DOG1xWnNBeGJUYWJY?=
 =?utf-8?B?TjlVWHV2dDNuU2VFZENYUjUxVnBiOXJoallLandHQWp3c1FUS1lneHB0V1Bq?=
 =?utf-8?B?elljMElHNytOc0Y2cjlSaUtiQUVRNm42NGdCSHIrUHBxN05aMzFtT2ZYNzJI?=
 =?utf-8?B?MksxTnYwMVc1NWZTOGd4TzBTcWdDSCtLdWJicnROZDUrYy9kRW9QanBwbXFP?=
 =?utf-8?B?WDRSenI3MmF3elZxelR2d3JFbmtIbURaOXpQM1FOQzU0MS9CdFliOGU5K08w?=
 =?utf-8?B?VHNMUFEwOG1sbFJqRzMrNU85RDBvOXFVb0xjTkRVTElicHdpb0FZNEREeEg2?=
 =?utf-8?B?dXpremU0RlVNWGxJT2JIUmc4ZWlOMzZnS3ZwdW5OUlVkMVZXb2lpNUVlQzg0?=
 =?utf-8?B?VjQ2eDZaeklHNWNTK21lajNiT2pxd0dZbnlUN0pVdlhIRDVFaEg3TmhiazIw?=
 =?utf-8?B?ZldZUlEzNDRjUVhwN1gzQmpNZUgrUlhac0VFSHhtcFFtd25rQlp4d0IvTUp6?=
 =?utf-8?B?QlhsUE9ibDZQcmpZSXZaYUREYWNOem9PUEFud1pKd3FPMlI4Tk5mTzJqeXdk?=
 =?utf-8?B?ZURCUkFUY0xPaWtsL2VlUWdweFZiSURZRXdHdkV2Q0l0bno3MmhOSHNMMzZM?=
 =?utf-8?B?TzB0ZUdjcWd2KzVGV3ZIL0ptSUtXdWR3OVdPVWFrT3hXWWVLREZpZzJqQ2Mr?=
 =?utf-8?B?OWpKMElRMWdCZDI0aVZZN2g0SFltZGFuS0Y3cEpiTjNPVkFLKzFWSWpiRkx4?=
 =?utf-8?B?WDNIMGtIb2dxMVhEdEoyN1RUbm84V3hNci81cU9XUWVDVEtOMi9qaW1jaFBU?=
 =?utf-8?B?WnFMYmkvcHdLYzVzci8wM1N3YzNmdEZhT3FMb3BpTk5FbndPMjQ4RlRBMEJi?=
 =?utf-8?Q?ehndvFPl2MGI9Vf+InReZ1Gn0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12ac9d-8334-4f78-303b-08dd5be9d826
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:30:06.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W09H50qYhukbPOSIDSvbAw/TMYvIRF9c1iIa7AcOWs3EWpPf6KJ1mqPb18b6d+PsNYFgKCTuUu9vcZwcGoYxYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11028
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
index 2afe9d38a0..54ae772188 100644
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
2.43.0


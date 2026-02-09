Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC8DEF06FC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BD383C23;
	Mon,  9 Feb 2026 02:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FQ6/4xVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F5D805D7; Mon,  9 Feb 2026 02:28:57 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ECF883BC9
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygsR5229KCj0ls1+CRGouKvQDqsEiEAA+N3B8KHIwYMBwODmuI2Z46+cZM6S4O4k7nGaWJDWghkvUGBxxMw9Xe+LhnETDJxx49CBNjSGNWK8E0m+JXQD+Jjd050jvJvEJ5i285bA7FaHwgHlP6aQ8H7lHCPT+t7wpxCgORN8l8ugxZOjzf9m7E3CYDdYLglIkQorYWhsQKSFsyhSutQ5/NKUcCnaT7JNBYgFW2zDECaOQQNHJ63mVqsQlDla04FzAGZmlrAyCRQ5GGczOCrUJ+GGWfL8heNOqE8U/szrBCMLhQ/9XmrDZUsmW+yD0fukMseXZ6PjBrl81D+h/qMc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXIalp749cy1dt2rrod5zpIWmAn2Ztur8mGaWhxYvzc=;
 b=AJOPWljyl3UkYFiP8C4DhQ2bthV76eS5sYs4NFswVUI5OnIjCut4igWY+diNV0yw9C510wEcBx2PX7MIEy1IFo5c5JUqJC167KpN4tHAnSvdyZ+fvvHFmf7I3mSCSEikHTBl3vAKhDVEjT1J7Y+SrMPZmdzKsZP0hP0zMf12x0yRLxGyR96L3Clqjl6l3R4+SDNS87j2HA0vK++SXcttwHbKZgKAgHB5JKNQWE/wCF3HQv3glz/bwbos+8BJTtuVrlzGFvvAoVcgwoNsaesQ5WcEVgbzS5vc5RrYWNy4Jk2FWB4atUB+7Y/yqR9+XTnUDs83j3vjCVahDHae0V8/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXIalp749cy1dt2rrod5zpIWmAn2Ztur8mGaWhxYvzc=;
 b=FQ6/4xVyA06RpE+cn/JOUWXOlqM5LfKd1+rc86xsklB+stCZY4L5OZGYA1+C+qlHdwsweMRi6wayFqor6YihKpU3D5a7Q2+vD4HZMeHZtVXtSezjWSHIpL0Ctxrj+c8rYcd4Lche5Uyjf+ZclL9n2UYb36FxfJvQRHQ0g+LYhM8X7rkIkyaigWeJDcfgF3UxoTdX78FkcAf/rJDsy8bDTB3OtxBuZGL803n4K1hkVgfu6PJlwlE1Nm8qXeuTborICD3uQEWVtd5Pox1z7DjC7n9egDwDLp3eg+RfrHMy8uUKFI5PRlPohOqr2N9Z3RWF9o/IZwE0FLaxgs+3nEfJnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:28:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:28:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:05 +0800
Subject: [PATCH v2 01/14] beacon: imx8mm/n: Drop useless files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-1-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 91332935-148f-48d2-bad2-08de677a95db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGg4ZEVQOHpMYXZYL0lGVFY2dXRWcVNPRmJUVno3Ymt6UXEvdEJPKytGZ0ZQ?=
 =?utf-8?B?Q1ZQbXRtdUxWVU1tRnB2NmtBTk03YWkwNnM2YzFPbTNlMVBFVE9sQ1krOGlK?=
 =?utf-8?B?MGxWT05QNm9aNTN0aU0wUVpBTGFYOVcrUTMvMGlrQkZudlQ2eU4wdXphQ3BU?=
 =?utf-8?B?eHJMR24yQU8xMlZuUHhTUWR2c0I2UnRRenJVTHJQRTRvRHA1Z0E0ckpzSmRZ?=
 =?utf-8?B?eTJhc3E0VTI1c3RsQkJmMzl5dkdVeThOQUlQVzFYM2JqdnFDL3RNVkpIekRk?=
 =?utf-8?B?S1BqRDdpY29sNkxpdjJtRnpzMUcvWWhWTnp5ZURhZnZaUE84cG8zWmZxd21p?=
 =?utf-8?B?UWJVclNuaHV5ZUI3OFBrcWxNUWVRVEVYU1FsdUh0UlZNUHR1eGJCNjU0UTNE?=
 =?utf-8?B?ZVB1MXZ3M1ZIZ0ZFMG0raXRlbitzYTdBUFdaYnljK2hMQ1NtblYwOEJsem03?=
 =?utf-8?B?L0RzYitLNnBuclVKUGliR2JWajNqZTZpMmNQZzZTUkFRZjNhTmoxNXRMd1Fp?=
 =?utf-8?B?VklMa1JnY0xmQzJ6MmM1RkcyVmVSS3NPcWlCYnVGMHZmUC9zVVNVNlFBSWhB?=
 =?utf-8?B?NU44SGU5MGo2Qk1tZ25DL28xSWVBUmgwVStxRS9sYzU2RFB6UmFvVlNnZzUy?=
 =?utf-8?B?UTdFTldIaXd3dVA1bjNEcTFTQlpSMW5JUkRZc1dUbjVZbVY1eXYydVVNSXdo?=
 =?utf-8?B?TzNMd3o5N25uN3FyMFFkZG9KYWRMTWxjZ1VXTmhpMFU1eDBQeWJFU1M1b3BY?=
 =?utf-8?B?TXBLb05CRjNJWEJYTzhhVmh3WHlZS3FxSzRETHBMbE5nSXBHak5oVzdhSzZE?=
 =?utf-8?B?QUNnUE9tZ0Q1cUhVRXNNSmdnN09lWHFTYURLOVcvSGpRSjk2dUk2REJOVkpY?=
 =?utf-8?B?ME01V043NjhaRzNkb0tnd1ZSTHR4L0QxcFY5OWZKSWVhOFo2YTlYL0krU1JF?=
 =?utf-8?B?U2ZXRVRLcDlMdHZSaExwSVBQTElCdm8zSC9tUlVYdUlUdEhwLzZWSlJveThr?=
 =?utf-8?B?bVU0em5UVnoyODQ2bW5HS2FWdHBNaXRxbUNNMk9qdGQ5Mm9ydnNzUDFOSFpy?=
 =?utf-8?B?dG8wUloxc1RXMDlmQmZldjV4WFJLYzBRKytndTI4dU1yTFpFclZqaVVQc1dw?=
 =?utf-8?B?NzRyMUdYUzA1SzlOeGdVZ3Fra0ZReUtzSEp5Y2JVcEhaZWlYQU9zbHl2QzlZ?=
 =?utf-8?B?ZHJOMXdGMkpOM3FvME4wMHNvSTVUNnlKVGR5bHU4L3dMNWRLbDlRSDltcm9C?=
 =?utf-8?B?YkxqU1ZwTmoxRE1NdzU5Q3hJUVJsME5oQkx1NnQ0SDJ1NjdkSG9UNUpTbmh0?=
 =?utf-8?B?VGk4dmpqT05IeE9GVGZaWjl6clFGVDBLSFN4M3ozZ0ZCeTc3TXIxdFZLM0dF?=
 =?utf-8?B?T0llVlFwdEdKYkViNnZEemZtaUJ0VkRjYXV3VExyUU94NkZvSjVCWnBuQ2pJ?=
 =?utf-8?B?THdDTTZzKzAvZUlBT1NxejM4VnNNSzBrb0l2WUUvb0J0YjFSZDNvOWdmSXRF?=
 =?utf-8?B?K3pleWJQWi9Pc2N5UnRCNHVpKzNZN0tyV0ZXZjRtc3UvN2FETk9MM0ZHdzVB?=
 =?utf-8?B?NWFGUTV6WFhvN2ZqMEdPZ3FkN3JNY0Q4TjU2WFJ0RW5LSDlkcW8wZ2pmdkFX?=
 =?utf-8?B?QWdBaVNaVUpsN1NNeHRhYlZhWlNwVU9kVHhnMHVGcGZ0amhuUGtSdWRmSiti?=
 =?utf-8?B?ZGY0cmxGdmwxQ0lvWEI2WEFiVDkvc2JRVU1kczVIakpzVjZxRExmWU1NeVlN?=
 =?utf-8?B?Y3U2SHJ5MU9IVmVJcHlzOUd3dk5pc1JBRTU4UDdMT0JwaXZuL3YzZjVGTG53?=
 =?utf-8?B?aEZKY1JLd1J0VTBsc1NLbmtEWkppdm1NYXVDeHE3dDE0OGVMQm9LUEpYM0tX?=
 =?utf-8?B?NkEvYzE5aWFDT1RtQ3NtVFg0OUxyMkZJRExUdWtZdGVEQm8wdGhtQTgrMjJq?=
 =?utf-8?B?SHN3UThpZkFoZGwza0c1STZGRUg0VTVleVdPSFpFbXNGbUJ2NTlPUVUyVUNZ?=
 =?utf-8?B?Nm9JN3A1a2hxcFFWV2hJdWdROEg5N2J0L3F4OEJjVnhQSXpaTVVmVXZld1pz?=
 =?utf-8?B?VlJEdEswb2FKTERtTEFOMjFCZzRMUHJhVHZpRysvRk85YU0zQzg4YlB0RGZj?=
 =?utf-8?B?YndtZGRzQjg1R3BGcFBwangyTm1HU2VjL3Zhc0tWWCtETWJYcWxMWVllQjh3?=
 =?utf-8?Q?co7pJn4t7ZUWjSQPHvb/W6Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1kekxqNGszMEV5M0tpRkhmTWQxWWJmdVM4dnBKd3F5T0g1eTNWd3lXK0xl?=
 =?utf-8?B?WkFsNnAwcUI0Z0Q5ZE5wb3JnSytmNE9nQVR1eTF0OElJcm5BSGtUU2puZ09n?=
 =?utf-8?B?N2xmVVZsaGVYZkk5MDFLWUp3Q3M4V2JuYit4ck9DaVlYRHcwMHNFV1JmWTVu?=
 =?utf-8?B?V2JFMGRVUC9iclNPUWwyZGNpdGZTODZEdlBJdjlqdFJUV1lpQjhPSTg5c2dk?=
 =?utf-8?B?aXFFZmdDR3lSTnZQU3BZcjNoMm9mRU1vWFhLYS91Nlp4dGc5cENWSVA0KzhP?=
 =?utf-8?B?VkxyWTdJbVJLdmViMW4rclB1UFRnTXJ2emRXK09LNC82OVMyQUt1VnU2dHJT?=
 =?utf-8?B?bFNGRmt6Yk45SENYYVFPTjh4bXYvaGg5dm5lclVGdXpiSjhJcFk0aU5kczM5?=
 =?utf-8?B?dGxLcTBud2p0NUZqY0lCaTdXaklDTjFqYzUyTS9KMUczQmt6ZExadzFMOG1M?=
 =?utf-8?B?VE9MN2hmZllQWlhJTSthVnZxN0o5VTRoUUlSMW1EZFhCOHdwNXk0S1dYblJE?=
 =?utf-8?B?OFFzOWgzaFlZZnhmN1lMWTVncGY3NDZkSit3Q3N0eHh3ZTdvZ1lTM1VLTFNE?=
 =?utf-8?B?VUNFblkxdXl4aUg3VGVoVFBtQUIwSmFOWjJkVHVFR2luRjV5UmNkV2RuN290?=
 =?utf-8?B?b2tSbnJ5TkQzNTA5bnV5eDVrbGdxOWNLTzZnZEY3M3c1MzFDU1B6WUtQbjlS?=
 =?utf-8?B?VkFWRDU2TGVUVFJObTk3VDlyS3VDVHI2NDdiZCs2Z21yY24wTnp1NU1uSlpR?=
 =?utf-8?B?aVcyT1BsKys3dFAxbHI0bFBwZHJKUWNhVkVtSTVkTTNvbXJubnNBVTlETDJ2?=
 =?utf-8?B?T2l5eWhaczBTOFhySnVZODJLa2U2emJoM2pINnQ3Y1BtaHE0TXYxQU1WNzd5?=
 =?utf-8?B?T2J3cnkyeWZuckdvTTUzV2xFREVibm9TcCs3SzdRMHJ6Z3o1TExJajQ4TWFM?=
 =?utf-8?B?VWtHSENNeWQ1VlVzeWNndmZ5ZlhRUHJCRlAzRjJmdjFsREJ4RlVqYVlkcSsz?=
 =?utf-8?B?UTF0NGllalhvdk9LRGZSNXdUUmhRQU9hREt3cTlhRjBpdEJxcWcrU3plZzFx?=
 =?utf-8?B?YjlMcU1NTm9GdHAvd0FDSENEZ0I4T3NSRXZDSGROb25weVYyNE9YZWd2TnhB?=
 =?utf-8?B?M1FrOTl6anE0SU9UdUN3QmQvUXNoa2ZHVnZXMFkwOVYzUG1HaTZ1WHI0ZXpl?=
 =?utf-8?B?RXluWUNyTzd1VVdlcjFwdHovcU1lZStqU240MXRCdnRCM2hhTE4wUmxlelZU?=
 =?utf-8?B?NjBaQVJESjRabkdvU211Nk04em9OenpSNzVrS2NBZGZ3VFdZeFBEZmlCeUp3?=
 =?utf-8?B?YUhVS2kwZFh1dnpZU0ZwQ0FLL0ZkM0tmU0xxUEpZelkzUEtIbEVNeE1ma3BP?=
 =?utf-8?B?ZXlTbkZ4MTd4ZnYvazV0U0FBa1hTWk5HNTRleUhyRjdPajIzSmFNeWxtSTBM?=
 =?utf-8?B?VmNsOGFYcGdMdTdWVE90dGE3d09YQnNCRTg3UHR3NkpqbDcvSTd2UHRDRUZw?=
 =?utf-8?B?ZytxVTA2SW42UHgzRHBjbW1KYTRCK1ZpVHlqb2FBeGx3dWtnaGlmQVZpRkQv?=
 =?utf-8?B?SE1YSTQ3ekVBMkxxZEpxWWp4azY0eGFzN2Vmc3phb3RSZlIxZjMwamtvUlht?=
 =?utf-8?B?UjhScnBuRVZlRjQwdmk3aUI3Ly9PeU9qdzIzSVZtWUg4QkZnNWtJT2VJakQ5?=
 =?utf-8?B?MFBLY3RGVHBydUVxeHZsZmwvbUM0bGpBcUFFMkVyK2RHNDA4eEdrSzNsUXJl?=
 =?utf-8?B?L25vdUV1Z3I1eW54bmNwOUpmYmx4VjNvZHMxZkR4eDY4NStHbHRDZ09IZURj?=
 =?utf-8?B?VU0zWjNUWk9Zcm9rdkY1Sjh1YlpxT005bVRWa2dsTzBsTVBSRWtzaTZLa1Na?=
 =?utf-8?B?NEVVTm5ralV0ZlFhMDhBSmtQOEJYTkJtbDRaTFBVbTlTd2s0Q0lBWXZOaGNF?=
 =?utf-8?B?SVY3VnNmaVRCa0czbmJETldlRG9pRHBDR3gwZHRzcHNKSkUrd01uQXhPR3hk?=
 =?utf-8?B?U3FKZG0vWHhYZ3lFOExQcEg3eW8yeFZjbGRkekZ0MnJSbXBVaHhTOHdUSytT?=
 =?utf-8?B?V1JDVkYvY1VScG0zUFZ3aVpVbXBua2RnU2syK05MeFNhdnZxaXVZaVJHTUFI?=
 =?utf-8?B?SUNxelgzcFdvS20xZjdLY3R2ZU1tbXRITWM5N0JPSlZIeW83L3pVck41VE5r?=
 =?utf-8?B?TmJLaGxvTnp4WEZMZi9RWGg1OVI2ZlYvdHVKNmJVVU5vT1ZTSm5BZXZ1c0tT?=
 =?utf-8?B?RDdYNUdETStsdUJuc3BpV0ZibnVHWVI0bVQySzZqQi9HYmYyaHhwdW9SQkFa?=
 =?utf-8?B?c1h6MCtJNy9FOVJZamtVdytsRDI2MFBsbU5ZdXVlcUI2Wkt2RVoxUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91332935-148f-48d2-bad2-08de677a95db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:28:53.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUnh41hplwdcoAC80wdCqMWoP8cgbvHjhyJSoiq1ifMsMU++DEdplcKZPgwe2d4PmZKpjYy24+cP5rmk5zxPuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

No functions except reserving gd in the board files. The files are
useless, remove them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/beacon/imx8mm/Makefile        | 1 -
 board/beacon/imx8mm/imx8mm_beacon.c | 8 --------
 board/beacon/imx8mn/Makefile        | 1 -
 board/beacon/imx8mn/imx8mn_beacon.c | 8 --------
 4 files changed, 18 deletions(-)

diff --git a/board/beacon/imx8mm/Makefile b/board/beacon/imx8mm/Makefile
index 8484b85ae1268b2699e442975a4e476ed31f2283..eb762504266de80bad014dba0868c231f63c9ba1 100644
--- a/board/beacon/imx8mm/Makefile
+++ b/board/beacon/imx8mm/Makefile
@@ -4,7 +4,6 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-obj-y += imx8mm_beacon.o
 obj-y += ../../nxp/common/
 
 ifdef CONFIG_XPL_BUILD
diff --git a/board/beacon/imx8mm/imx8mm_beacon.c b/board/beacon/imx8mm/imx8mm_beacon.c
deleted file mode 100644
index 6459a99cb9d72a00316ccba63daf8414551bdfca..0000000000000000000000000000000000000000
--- a/board/beacon/imx8mm/imx8mm_beacon.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2022 Logic PD, Inc. dba Beacon EmbeddedWorks
- */
-
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/beacon/imx8mn/Makefile b/board/beacon/imx8mn/Makefile
index 54735792b9340aba0cd02a53fe2be22e5bda498e..e8fe9f1822e802a9889d3b93291d911f2e555e5f 100644
--- a/board/beacon/imx8mn/Makefile
+++ b/board/beacon/imx8mn/Makefile
@@ -4,7 +4,6 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-obj-y += imx8mn_beacon.o
 obj-y += ../../nxp/common/
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
diff --git a/board/beacon/imx8mn/imx8mn_beacon.c b/board/beacon/imx8mn/imx8mn_beacon.c
deleted file mode 100644
index 6459a99cb9d72a00316ccba63daf8414551bdfca..0000000000000000000000000000000000000000
--- a/board/beacon/imx8mn/imx8mn_beacon.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2022 Logic PD, Inc. dba Beacon EmbeddedWorks
- */
-
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;

-- 
2.37.1


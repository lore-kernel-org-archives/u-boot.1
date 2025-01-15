Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24DCC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF6380713;
	Wed, 15 Jan 2025 14:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wM9/mkzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C877C8072F; Wed, 15 Jan 2025 14:29:29 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6B080713
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBaLVrQOCm4LxgHjJ4cux8+gyec6qkmhUllynG1QKQGcy9DkdzoadWucWHfE1auK2N/aGv3nJPGgEFSD2Hs23ib91hw38EoI3bkmbCdh1sLoMFc+6LZIYsRxZDD2Az+Vhp6MAr9Oa6jELsMcI21Sop8FmNODmqpxxFOAsexuNgMcbF8NZUK0idbtBhxjzDQNTv+o6tCkiA1bkD+48c5svFgPmBY1AFhCTG0cmoQBM+x2f6HMUrqDXbW1KILAnTEh0bUjZMRc3R5OhBi6++gz6sPzw0gPyNYaw9/CksvYv4k4iNlE1VztPOnhaUPTxfwjx/btTHWzLXo7TUG1PCr+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGrrBzVLqARlV1SjDpulGINwnVii/NH0CrD5m4XiP9M=;
 b=EHccwFaobCN/2Lnsi777o09D6br61vCzYac7GrFtM3vYrgMXvIdBtj+gC3OGnw+VxIC6zKirjN2oF+onddi9m9r/B6kLRgmG4QFsAN9KKFDPq1Uv8t7mvE6nVol/ms9kbxHYYotqszPiw6oK4g6eZD9cEAzBgwEirMEIz9A2Y7o6ajJOikwE9ha+zx1CPCy4RjB4QywQFvuFoz2PEg1lQOvLsKs522Jb5kYEMPrIAD0ct38KVaCjg5SkEzArcdA+UGHI3uXSbIFtK+fnPPko2+lWxcyXJWjMiKbSNf0DGBoExxIWXoNk6WH7+UMWttM6+N1jkZzmnXucp+jNLfdNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGrrBzVLqARlV1SjDpulGINwnVii/NH0CrD5m4XiP9M=;
 b=wM9/mkzjniue+4JlBh9BFBZXUNJj0Oa//7/bhBl+B+uPha/l070sBLayfqvr5cs1oHSzXYpMi1KkDSa7IrvGd1nXGnqw/Es4mzN9xnitUfiTg6J56juNyVqg3iA1p7paBXw6Nbrn7tKkCT5G72yQI10mooBxkqbaTkJsn7ChMmY99uvm9Na/aNy+ovzdpkBVPXHLR3Qvmnh49i0fqoXagsxW675cYYZkXvmAAvSK/lmMgYmv0t/IOFoyFpi86CkZsF4ug1vvUGxSLX70rqZYRLryUOC2x25/WiCWWmw80PgGDGRlltHcanofXtFdp3ZAWY1fnzX745LxgAWj5H18Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:24 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:51 +0800
Subject: [PATCH v4 04/20] firmware: scmi: add pin control protocol support
 to SCMI agent
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=2489;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=IYjORO63rT+Wdmgq8t1h04IAZEv8Je9fvEhorJrZViw=;
 b=OhAspBdxp9xM91kDbpWnjgQhxj0KIuT3iKQ1vwQaeLISqC3TFXoMszUlYtQ+7emEPFem6dqwD
 d3cw2LyZsSdD8JXNrGpo5JbTRoXJdYuxKHu2H/PFl1jZ7J5h5mcYYbR
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 7651add8-29bc-4461-6018-08dd3568a0a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkY0b2xjQ2JYLzBoaVRUU3BNMWdWL2NNYU55MHAxMDVRakRKSFI3N05nQ1FY?=
 =?utf-8?B?K1pob2piQng1ZUphTVhjb2IrS2xhZzk0SXZmSnUyVnhQd25VK2hVTWk3cVE1?=
 =?utf-8?B?R3V1azdKWnZLSG5TcXMxZlpOZWNaaVNZY3h1elFXcWdFTjhOeDZHeU1XTmw1?=
 =?utf-8?B?YlEvM3dkVUFJTHlSaHZOVTFJNllyQWo2cmJ3c0lEMlFna0lDQXg3TStQbUZv?=
 =?utf-8?B?dENqMURuQWU3KzJJTThVK0wrYWVkQXNIVnZvdUp5N2tuSkhFcE5jbnU2OTlu?=
 =?utf-8?B?R3k2V0k2M0JzZzBZTHBZb3NqSUErTmJPZDZ5SUwvQ3lCeUFSbWlsb0dOVVJi?=
 =?utf-8?B?QlVZdkdNaDNCSlZTNnc5SDFRYXNmazBLNmRoSUgxSVdmb051UVk5b0NBYkcz?=
 =?utf-8?B?VGVvc1paMERYbHNOZUhlTXowWlJNNmF2WGZxcHV1OGhieGMvWjJMNDN2VEMx?=
 =?utf-8?B?amVvbjhydGhDSUZOdnRLakg0NWhNbTZhZzZSdHoxOE5qZ2pXTTRWWmxiNWpS?=
 =?utf-8?B?ODhGLzBvaFhHcFdJQmtZZ0RxNlpvMysvMjVqanZRb09uMXVpaGZDemI2N2FU?=
 =?utf-8?B?TzZNMzc4bmozVmM1ejJlc203cVpIbkRvb2U5Y1c2UlZUb3B4elViMDZDSlZy?=
 =?utf-8?B?a3oya1ozV2VVMUptN1BCelB6YjFrWXllRVdYb0gxMWhaQitDQWUwOFpWcFRq?=
 =?utf-8?B?dmRzU29WQnRhVW5XSnpjbXNmT2ZyQWVhTlFnRm45OTdSNjI4SVlVMllKZGpy?=
 =?utf-8?B?MjJMM0tsaVR1ZGRaWnhMWndtRlNrWjhNNlkraURCUzVSUWtUd2R6QlRmakF4?=
 =?utf-8?B?Q2NyQ2h1MGFRaUgyZ0gwc2g1cFBGRGhOZFd3WGZNcWswcEJRY2hOZ3VKNDE2?=
 =?utf-8?B?dmZweU9XWHJPaXVtTjhhMnU3YjNJT2ZmbzJndG42UHBkeUI3VjhTZGpGRHFG?=
 =?utf-8?B?aE81bmtkUy95MVVsdk5vaFVRL2FHTzNBdmJQTUZpMno1N0xTSmowVnN6VDNs?=
 =?utf-8?B?b1VTSUxrMUV3a2VCSk1lZm9teWlFSkZTL09tVk1FU0FFQUtDa0NOem1mMUha?=
 =?utf-8?B?d3phSGZGWHBQWFFkaHpwLzVIbWRiQXdycEtQeGdaM2NHbFF4Yk51K2xJZC9V?=
 =?utf-8?B?RjBqVnJhTm1jdWZQRHBSNGNKUWpQR0lsZDBITkwwTzNsb3E3RFA2Z0djUUFx?=
 =?utf-8?B?eHpTWUdwcWdKZkV4dHFKVEJJSHdNWUE1S01vN1pYL3FhbGdPT0dlTjNDQ1da?=
 =?utf-8?B?SXY4ZE9Hd2c5L0lQQ2FJRVBSRnM3ckFybWE5T1FCcENYbUFjY0lNSGg1RkY3?=
 =?utf-8?B?aWJoRkNoa3paNG9SdjZMQk9VU1ZhcUk1Si9icmZIWlNjSlZvdDFwMXZWTXlh?=
 =?utf-8?B?VnJlN1RQZGFrajNSbGtGQVFVL1pjVHk4ZEhzNFdWYXBzMCs1dDZwcDloMVBw?=
 =?utf-8?B?c3FhYUd5Vld4UWprOXZpaklYQWx0azg4U1U4dXdBMXZVNWg2V0MzUkl0Ymhs?=
 =?utf-8?B?Tmk1dG05YThKT0NTU3dlcjNVQ0FMRDUreFFwcExRRldpbkdJaWhFK0hVUCs0?=
 =?utf-8?B?c3lhZXRXODU3azBnYldCRFh6WFJGdGVEVUYzMm8zZEVRUmZOSWNYaE11OWk2?=
 =?utf-8?B?WG9KRDgwZWZJUmRDZ0Vkd0poejJvVkdNNVZEaTVjVzYzYUdQWjBEV1V5YlNC?=
 =?utf-8?B?OHJ5cENqaW1LSFduMG4wZXFiTTY4TGRkNXhkZVcvWmp6YkY2UHBuN0ZQa3ha?=
 =?utf-8?B?aUpUYVY2S2c4blRXckRIVXk2T3UxOXFvblhSbE8zYXNtOGVORWxMSGowODZa?=
 =?utf-8?B?enJ3NFRobmhjNktrSmU1dDhHMTFHd0NzajJVS2UxZUxOSDhwYTNRcHpNTUJ1?=
 =?utf-8?B?enFkTFFMVnk0QTdzOGd5Z0wvc1JTMVF6QlN3RXVZUk5qaXp2QUErdXU4K0dE?=
 =?utf-8?Q?JAky6b8YDIZliaat/vvIqPO9X3caDekF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdpTjcwTWFpMDlwTHpQT1RwYm5URDlDWjdvcmk1MXNENTVhK2VWcW8zZXR5?=
 =?utf-8?B?eC9taWlpSkNONTM4UmgvTDcyalVTZHU2bTE0eGlxZVN4aVBadW1DajRmU0Ex?=
 =?utf-8?B?V1J3aG9LQ0p1dUZMWnlYWlFnc3cwQzhmbTdwc0ptUTZiS09PQ0xRU2REQkFN?=
 =?utf-8?B?SFlFaEJzTVpnQzIxMzgwQy9kU1M5SjVuVVZPZURpUUQzS2Fya1o3NVBLKzhj?=
 =?utf-8?B?dTZmSS8wc2hleE05am5PbGMrWW16NHBBdjE2U1hIZDgydFF3eXVsZFlmYU42?=
 =?utf-8?B?dWNqc2xMeHZOckxFNnZQRGZkQ2dzYndWWDdlSEN4clgzYjhOU05pUXBHMWFH?=
 =?utf-8?B?V2dWbEZhRUVQaWJNME1PNWNCUytlTEJPUkNsNkNFUTBzbFpEdCthaGdIM1c3?=
 =?utf-8?B?SG9hS0hiYTIvVGh4enBBSUdPK21yT3MyMm1ZbHo4K2x0clh4Y1ZmUkd0dm56?=
 =?utf-8?B?aHNGNzJwRk01RTM1L3hRMndWb0JQWUI5WmovTU1rV0V4K2VKbE9zK2krNDlL?=
 =?utf-8?B?OFVhVTZUUWJqZS9PUWdqOG9sSnA2RzJpVldjVHRqWGdTQ2ZCUm5VTVMxT2hM?=
 =?utf-8?B?eklUTFc1dUcwa3NFc1N4U1hJSXhEN2ZDRk1FK3k2bVRwNjVlaFpGWk45QUQy?=
 =?utf-8?B?bXFQdjl2YUJMaEpZazhCL2hpNDU0YUxyY3BORWl0UDloK3FlZzdMRThuWGYv?=
 =?utf-8?B?TlNKOWVTQy9RYXJRZ21RK1BsekFFbDF1N1BKMWp1UUV1UjRUbjZWeTFVVXdV?=
 =?utf-8?B?bTZUSkNTUVNmeEU2RDZWMzNXcjlFbzJqWkd1K2FDZHR5V3RkdVdKR2ZvanNQ?=
 =?utf-8?B?Yll3MGRTTGxQQUdDbzdFeTc2ZmJDUURpWFN6RjliMG1jSmx0OTEyT0dlZW5R?=
 =?utf-8?B?L1F2OUNHczRHems0SGNFZ0dRNEJETmRCcDZ4Yk4wTUplOExncGp4S1N1Zm9V?=
 =?utf-8?B?VlBDUHFtb0JnKzM1REl4c2poQjI3MVY3R0pwcEc1cG9HUVN6cWV6ejZheUFK?=
 =?utf-8?B?Znc4SHllamp5bGwwSmFPK3FnS2hLTktIZVBwTjQ5WFEzZFJyOXlnRWF1bGFz?=
 =?utf-8?B?bW8wOGsxdlFMOFFUS1BkcEpOVmtmSXhzak9xVnltWExXdUNxWUwxRUk2dm9a?=
 =?utf-8?B?NnpkeVpTVEJnODBmbXYzc0VQaDEvdlkrYTJXeDFUajltZFZHMzVkMHBQenRh?=
 =?utf-8?B?WlRjNGhORnJKM3lucXlOR0lRMDk2VHJ3UERlRWJHNFQ4NTdycitXY3MvQU1n?=
 =?utf-8?B?cXUrSWNjdHIzRFJCV1U4YzRVYVR0Q2d1Z0dtbjlmZmpreldWSTFZQm1HRlRM?=
 =?utf-8?B?aDRSZUFDQ2JQVFpqZ21QSXpNYWtjM3NST2QxWlZoZStidTVtenpXMnp4TUUz?=
 =?utf-8?B?MUlXZWpJOXFVMjFFS3Fod0h2VnA5MHFWaHpSbE9haFZiVHVseGRxRnNRUnhC?=
 =?utf-8?B?SFFNK3VnSXEvb3JMVDlZckJ6cWtMSkZUcUF3M29kV0o0Y0JweFpOdzBJK2Rn?=
 =?utf-8?B?dXE3SkZMM0czc1BiQWZ2ZG1BWGZFeUhmb0IyeVZwMlpCdHRJR1o5Rlo1N2F1?=
 =?utf-8?B?bXc2NzZVQzhwbUtad1lIZVEwbjlvbkJGam15Vzg2ZFJFUmxiSXVTZUdnYUlF?=
 =?utf-8?B?akpMQlFyemZpdHNtTGV3emNQZmJlNEpEdnY4MWQvaXRSaHhSZDJ3QmZlQUlw?=
 =?utf-8?B?cnBvOWg1eitOZG1JMEZ6STN2UjN0cnB0ckJCT04venpvN2ZzN0k0Q0xRTHdP?=
 =?utf-8?B?aUpNWWg3YnFNUXJpM3NrVXZWSHVZVWM1dW9nV0QzSVU5QXBlMEF3anVJTEVP?=
 =?utf-8?B?YnhqaThtVTdNRWhkc01rUkN1THRKOVVqRmVSZDVWemRqc2JFV2JuNkVlY1RU?=
 =?utf-8?B?aEtkRXhTR2pJejB4Nm5ja0lOMURub3ZvM0JSOERUWGtrem9NV3lVeHVoMnFO?=
 =?utf-8?B?aUJmUWRKSkJYVDlIUEM2djFOdy8waTg0cnBJanhFcFJGdEhUTFVha3FKaWsw?=
 =?utf-8?B?U3d5Z0JRQlJOMTdrcXRvNGxUZ2NzZGUyWm0zZjA3L1hoajhqZ3psSmlnOWpr?=
 =?utf-8?B?QzN4ZW9Zb2hMcDVvQ2wzUkI0UGpJNEpEdFJEWlpxb2ZnYWc1Rk4vQWh6d1F6?=
 =?utf-8?Q?1kxvIzdFB/kGa5o12sgbVZxQ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7651add8-29bc-4461-6018-08dd3568a0a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:24.6393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH9FeXhUo5IGu4C/ZpAItr1Ywa6I3Sibz/oCXzDy+IqprTECKJAU2yQipgUGwEYOJ5paH8URj6g1amS2v1sUkg==
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

From: Alice Guo <alice.guo@nxp.com>

This patch adds SCMI pin control protocol support so that the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 11 +++++++++++
 include/scmi_agent-uclass.h               |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b0328095c4b35ba089ed608fcda48b567..5f101f4ede8b585f8c562a42886ea7be4ef09953 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d4ae4ddaaa2cb3830c03cd7a559cc0..4beec43cb080b14a777cac1cb0f18ef53433596c 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)

-- 
2.34.1


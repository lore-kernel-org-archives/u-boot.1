Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D54CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826DE83321;
	Thu, 11 Sep 2025 01:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gClmAST3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD095831C2; Thu, 11 Sep 2025 01:54:02 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C04832DA
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+mryzqtfoC8G9neDxQseOl7oxIu6lBXoENGfVjdVfPzFaSaoSt+rGCowyxRxH03InIX66LfnRmCzfhOmguzkDLbLgocTaO6m/+hv/dPr48aI8jUFs05KPDI1+527Qb/f6XfQvK7sw73tkaiuGDsBMhG25Ly16UcMZwvkwwLRe5psePY4Xn7ZccCx38z4R/RiGXVKaSpBsPxrC/hxwpX8t51CP2oMmzD32AKtdXlE2ynsyZj1um4Eo0GPbQdvpTDMxOyMTvUmFo2+7WvB45JFTV1aBsN1LoUV3bS2vk0M4YbT6f8OW+FmqwYYj3M6tYrUCwiwUoGqycf+0K2uCYOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyB7jP56cSxSw6AvxmrGaIjNCMqmMf/WhzNOBKt5TvM=;
 b=Qvj6R8axjk5cmlBTCLBelv3zgriOXCk5kfDW0JzQKlMRQ+e6uL2H+bV+NxHiLL3gn+NQSdqa8oRbjKnPGT65GyRB/1o9+HZrjMoxnxZxdp+Bhe1UkaSlScipQUrnrX1vxIG6KlbUiv9nwje23WFSIAQBJjkjDRtLy2ksa67DaMeYRmMjYImX76GSQ6fP0f5XVUHmjLaNdh+/dg/PSULWsVE0pSVOL8E2uTicdOWOsYr0lQGPAMr0BfirlUNfsD5531z30gcBR4u8rFoOPdQNErr91eNeN+WtXhprnmA0vQVD31oO/xtNP4AEQPrSHU0Lmf/2oDGoI3gcOwQYlLXECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyB7jP56cSxSw6AvxmrGaIjNCMqmMf/WhzNOBKt5TvM=;
 b=gClmAST3DotoyR+TCiKt3xxkk7XkDZdymjP4xVELbiKLL2sSdhB74a4LsSgIqzYPkgXSxd1A5bbtek39IvNaq625r4/8OUNfnAU8odP9MWSauPP7rfPMpXoVNXBzUxlKoDhbZDyTMlFfKEJYFfMsEXRXBUSEIre+3vJBMj9yyNF8aBAykh+i6zLugv6eWynnSgJo1DWKFy/bd6NwrBtwPr2W0fYFpLTNjtkh2YvL5m5jymWhxnRXYL16O8fNNJUNkQSVep0CDa8VNu8BoChbjHteGm4wK1QKBTCJPObb6dWuUCztKE2wXMYTFXPETkCxCZ9IBNL7dCT6jCZZ7xef9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:53:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:53:58 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:03 +0800
Subject: [PATCH v1 4/8] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f24b34-5315-4235-3bf8-08ddf0c54ef2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTFKbU5WaC9SMHRsVTI1R2xVakRlcW9pODZsYnFTSnQwVE8zNzlaNUMzZ0Y1?=
 =?utf-8?B?T0t1Y2hncU0vR3Bua0gycmpFRjM5ZVAvOWtYNGtEcDBBQ2d2RXB6N3lnNXUz?=
 =?utf-8?B?S2ZqTGRpNndJSkpJUjV3NmZKeWo4WUFaOXQ5NWtuRTdNZXREVEwxQlVNOG5k?=
 =?utf-8?B?a3JEQjRNc1BtY001ZjhRVHRqMkJnRjZuNnBkM2F2WTBwUEc4QUREUnpteC9X?=
 =?utf-8?B?TFNkREtxcmQ0M2liRnhtazY1WEZVZHVtNTExa2dTZm9OR0VHdU8yRzQwUTBR?=
 =?utf-8?B?VEEzQkw3eFBqSFM1bnNhR0xYVDRHOE4xbXRLSWpVRHZxREdLNUVxSVRpWGN6?=
 =?utf-8?B?bGtGVm83WGZRMUswNnFYZG5FeThseUhsRHpLekRlMEM3QU1LTkJGS2hDbEhY?=
 =?utf-8?B?RlVqYlA3blh2MjRrcE12OWdESXZGeExHaW40aGlsblE0cGk3TEdZYXQxL25K?=
 =?utf-8?B?azM0Q1ZIaDNLbHJQWTdTUkhYMUJONVFPTHZtekRpdnd4aUF5dEFlc3IwbmxW?=
 =?utf-8?B?cFk2Z0FKbTA0UFFNS0trMFBaMERTZVNLbGdETXNhYVdyZTNDMm1VUGtCMmNa?=
 =?utf-8?B?TWI0eUJvaERMNmIvOHJUQUFhaEpEa3RZdVJUcUhPS2d0SUtRNmRRZUxxeXI5?=
 =?utf-8?B?dloyYk9VSDY2SFljb1ZWUnZYb2JWNmR1Z1pzMlRReFZUL3QvOU5uSWFDQXNJ?=
 =?utf-8?B?QjBKVDdDTnlxK3BzNzlXbGNxYVliUzBiczY2cFFQQ0lWRmNoSHpEZ2U3QTBo?=
 =?utf-8?B?ZHRUM0F5ZEpCUUZRMTRRQUt0NXl6QUNHTGl4Z2QzanRMajlwell2Nzc4NmJC?=
 =?utf-8?B?TUhKaEwxcnY5eDh5SW90Nnpob1FVQ3d4bDBCUzI0ejR4YzJCcFUrbmFXemJQ?=
 =?utf-8?B?NE1iWS95SlBzZGpGTVp4d2RKM0UrTVhZUEhVMHdtejE4VXJJQ051UmRCQnEz?=
 =?utf-8?B?TGthNXluR0tMUDRZd0VheTJKaXVwNjNxblkrK29aN3VtT2hqbnFucis3Si9G?=
 =?utf-8?B?dzVNSGVWdWhqWTZsSjNmQ1hNNnFmRkZBeXVPSUthK3FPUlR6R0ZOTmFDRWZD?=
 =?utf-8?B?K21vcENiSkcyVVdCa1JmejdwRWxScHVKS0VGY1VDZkxKVFdMUm5wUFZIS0VG?=
 =?utf-8?B?cXg1RkE4Wk9MSzE4M3FzWmd4QThJR29FMTJyRXB4bW9VeDhMcXlIOVlyTlpq?=
 =?utf-8?B?bUJBZW5MZ1g5U09Qa3ZKZFRhQjlTU0ZoTWFmTTlTLzZiMUszTk9aU0pPdkh2?=
 =?utf-8?B?NmV2eXl4QkJSMEtZV0RkbXVMSDYyV3ZYYlN2ZGhiWFJITWZBOVowMnQ0d3M1?=
 =?utf-8?B?S056ZGRhZG1qc0NkWDBJRXd4Z0EyQUtpWXdOK0tBMHJ6c0VnUjN3R2RzYWZB?=
 =?utf-8?B?OFR1UjBJZmV4ZnR3UENyOGYrV04wbHBkSFg0Q3hmaUpQbkFBUGpUeStVN2Fv?=
 =?utf-8?B?WXRjTjk5WTJVczB2emViOVNNeFdZejRzVVB0RmIzN2N6ZWdQUmxvUUhBTXpS?=
 =?utf-8?B?SXNCQTQvejJlSk5nQXk0a1pFc2hmWjFDdkVncUtSUUx0WW84M0hVdE1MSUh0?=
 =?utf-8?B?T0JTQlRNenIyYXcyNHN2V2xjRUMwZHJWcVk0aG1hM0ZQdlQ5NE1LSWtjUHQw?=
 =?utf-8?B?WnpXWkUrelIwUXY3WG5lYUFUbUYyYlBibCtNeFZoVFQ4QXdacVFBVm1oSE5J?=
 =?utf-8?B?VlFmdUJKYmN2cDAzS0NhUk9MYW5JVjNoT01jY3AyZ0YxR0w0V1c1NlBMa3p2?=
 =?utf-8?B?TzVzZ2U4aDR5WkYxTDNwUG56T1ZrQnNFTkdoSlB5dFZNejA0Y0tyU1B6bkRY?=
 =?utf-8?B?cytudzVDQ2ZHcFBIOTEzR0EzYU05TlFRSUJ5cUsvMGVRWWlOemtpNFMydGZZ?=
 =?utf-8?B?dVhGQTdBamRPK2x1a0pYcHZYZjlOQ3pOWnNqbzRDdWw3cjJxMEdzbHB4TEhD?=
 =?utf-8?B?cFZUSVF5dThQSExCaVhqdUthSjZxdDJrTnVlZ0xad1BiUnZMWWs3aFFtS3Jm?=
 =?utf-8?B?c1lFZ0c3ZUhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dXTnZwam5FVHBTanZJdEJVM1VZb09VMTJRTGhXNm85dzRKanBSd2gxK2kz?=
 =?utf-8?B?TkN3ZjBGTlovcEJBMS8vUSsrRnZOTE93cHBFYTdsU3BDbFhBdWZ1WVFPUlhO?=
 =?utf-8?B?MEkzTWlYaHluZkQrTlRicmRkV0E4WmpwcFZZdGt4R2JFQXp5Sk5HcFNCNEZa?=
 =?utf-8?B?di9IVWNiRzlVU1UyS0tPdzJ2dlNmYzVRRk5xK0tCRWhoQU4wa0N1R3NjclRK?=
 =?utf-8?B?U2RhTmU4WE5hMXFxbUR3cUtiYmd2WVZFRXZJZWQrbXJ6WWRSWXg0SE5aT29G?=
 =?utf-8?B?SlRQY3RxeXRuOC9pczNqaE9xUzluUmNVSG91bmJ0OGdlbzJTMHNLN0JuUkxq?=
 =?utf-8?B?alExbU9wL3R2WUFqTFNFNlJvZWZhSkkram9FWTdOR0ZWeEpabGZmMVQ3dTV6?=
 =?utf-8?B?UE5EcXhaUzhnOTB0U09nbk5teWM3U010VmhFWXIyUVBZS2c4V3gwTnJtcHRq?=
 =?utf-8?B?UUlMWXM1ZU1HbVVBVnZsaE5CQmpWdG1URExMOTk3dDZ5YnNMQXNUQUZobnF3?=
 =?utf-8?B?TGZkRWZOTnVsUUtwSURhajg1SzdWcVptTHdQSlBwaU1FSTB3SVY4U3ArVzZ0?=
 =?utf-8?B?Vnd5L05NTllEYUhaTmdGc3ZjekZ4VktPUHlIaGF5MHZBVTBnSmV3S01BQUZ6?=
 =?utf-8?B?LzVFWHdPc0NXTndpWnFBbk9HRUovcnp0S2tkaGJKZGVaWDNFNzlQMlNFbm8z?=
 =?utf-8?B?ZC9DT3FnS3dNUno2bGxRdTBZdTBacmRqU0ExcnJKTlVqYU55eGZWQ1BaR3Fi?=
 =?utf-8?B?eG9vUWVuellTdWRtbmZXL1ozMmtEUWFJOGdIK2VuTVltenF2UlF5ZzJoM0F1?=
 =?utf-8?B?SUQ0T0xGRFhEb0FhN1J4RTdHcnRuZEhoUWV0TzRUamM4eE0yNTZuY3RHK1NS?=
 =?utf-8?B?bHBmdVBJM3NtWFlTVUNXSW5iOU5ZM0doWHE4Q3Y2WWVwM2N5R3ZEb1ZHeit4?=
 =?utf-8?B?ajhMNU1LelFlQ0xneHZHNER2NWNSWTdDNGl2Z3Bza21ZYWpHZWNvNUdoTXVB?=
 =?utf-8?B?cVdvYzh0LzY4VSs4bnhEM2pZeDQwbG9NWmtGcDNvOVljZEdNS0h6OGZMdlZX?=
 =?utf-8?B?RStHaVZrVDRxL0pBV3VZSk03ZWp2OVdjTXlOK1h1Vi8xdC9RNXdSOUZPRmtL?=
 =?utf-8?B?TGdoRERlUmhUKzF0ZUk3UXBoWm5XYWZ4cjJBVHBIYTRrQWM5cWJYcTFIL2tM?=
 =?utf-8?B?VWJ3VDJxcHNhSWRUcnpna1JHY2JpUVczeEd5NXJ3RGlVb09xdnNLM0xpcW1t?=
 =?utf-8?B?elA5WVUxTlExUm5xd3d5ek80aTd3WlVRVDNTNGcvWVlmRUtMVElIMDR0Vmtj?=
 =?utf-8?B?OUhUTS9uL0tEbkl3ckpMS2UzeUFZNlU3RndCaEcwUDF5b0NUSjdmOVdJeGxK?=
 =?utf-8?B?THZMQjNpRmtZOWdqN21Yb1E4UFhKVG45MEhDYjlZNjVuTHVVRDZrTGxyV1Bp?=
 =?utf-8?B?ZWEyeW1mR0ZkNTdRcFNST1Q0WnQ3eGJvRHZvTmI3SVhPRnFHZFFNSFhIallw?=
 =?utf-8?B?MDh5TUtmeW1jTjdWcXBsWWRSMk9ocG5ZcVJlVnZMQUcvTFVrV2lzcFhMRWFx?=
 =?utf-8?B?NkVXcGxXTjVaSWl4aTVDRmE2cHRmUWduWWY5ZUYvc2Z1d0d0eXZUMkxzT0d2?=
 =?utf-8?B?Y2RsNi9KY0NITW9tTXcrWkxFZGVhczRvWlFreExBVzJzSlhwdm5oOVJ1TmlO?=
 =?utf-8?B?T1M4VVVXSW4zZU1na1ZNbkdGK3J3L0lLaTRVdk9HbEFhRFFLN1MyWXRMMEhx?=
 =?utf-8?B?ZHBOa1NoSEFCc0o4UTJHZkozd3JMYnA5WjJUTlJvNzBRcXhsTUNHQlE1RUpK?=
 =?utf-8?B?bUppbTRwdGJwTGpIQmxSTnQ3ZzArenk5azNuWmxScjlzZExoa01VTU1JYTBq?=
 =?utf-8?B?YVZDZUFKTDhCYnpzNmJ6ZlpHZm1VTEZmY1hzaVdtenllTFUzOCtYZ3FKYUpi?=
 =?utf-8?B?M2RacWxTb1pJT1hLUG1mZEtoQ3ZOa0FXZjJrbnp3Wk9kT0Z1UkRub0pNRU15?=
 =?utf-8?B?OUV4TEdJWk9XOVF0NTVNWEo0anRKOHYxSEdaZm1KN1FqbFpTQUZvVXphWWpB?=
 =?utf-8?B?RVptOTRFR3VUODJTbFhQaU9SbjR0eTVRR1c3QWRzR0pjTFFlaUw2dklCaHdq?=
 =?utf-8?Q?6gCJt6DFEnkRBj5JQMMNl2KEM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f24b34-5315-4235-3bf8-08ddf0c54ef2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:53:58.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyKDneCvXEvGwz4y/j2hDxk3wmRG+rN76OLHMsCKIjxwS9lloL6CrOzpoUt7PZ5noiBsmoCtOY3PcEZMjhwVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

- Add base addresses for WDG3, WDG4, GPIO6, and GPIO7 for i.MX94.
- Introduce common.h with macros of clock IDs, power domains, and CPU
  types for platform-specific replacement (e.g., i.MX94, i.MX95).
- Extend imx_get_mac_from_fuse() to support i.MX94.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  9 ++++++
 arch/arm/mach-imx/imx9/scmi/clock.c       | 28 +++++++++--------
 arch/arm/mach-imx/imx9/scmi/common.h      | 41 +++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c         | 50 ++++++++++++++++++++++++-------
 4 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 5127fe8f286..a44fa6663c3 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,14 +17,23 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#ifdef CONFIG_IMX94
+#define WDG3_BASE_ADDR      0x49220000UL
+#define WDG4_BASE_ADDR      0x49230000UL
+#else
 #define WDG3_BASE_ADDR      0x42490000UL
 #define WDG4_BASE_ADDR      0x424a0000UL
+#endif
 #define WDG5_BASE_ADDR      0x424b0000UL
 
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
 #define GPIO5_BASE_ADDR	    0x43850000UL
+#ifdef CONFIG_IMX94
+#define GPIO6_BASE_ADDR	    0x43860000UL
+#define GPIO7_BASE_ADDR	    0x43870000UL
+#endif
 
 #define FSB_BASE_ADDR       0x47510000UL
 
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
index 6e6541eaa31..1f071873dca 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -6,16 +6,18 @@
 #include <asm/arch/clock.h>
 #include <dm/uclass.h>
 #include <scmi_agent.h>
+#include <scmi_nxp_protocols.h>
 #include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "common.h"
 
 u32 get_arm_core_clk(void)
 {
 	u32 val;
 
-	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	val = imx_clk_scmi_get_rate(SCMI_CLK(SEL_A55C0));
 	if (val)
 		return val;
-	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+	return imx_clk_scmi_get_rate(SCMI_CLK(A55));
 }
 
 void init_uart_clk(u32 index)
@@ -24,13 +26,13 @@ void init_uart_clk(u32 index)
 
 	switch (index) {
 	case 0:
-		clock_id = IMX95_CLK_LPUART1;
+		clock_id = SCMI_CLK(LPUART1);
 		break;
 	case 1:
-		clock_id = IMX95_CLK_LPUART2;
+		clock_id = SCMI_CLK(LPUART2);
 		break;
 	case 2:
-		clock_id = IMX95_CLK_LPUART3;
+		clock_id = SCMI_CLK(LPUART3);
 		break;
 	default:
 		return;
@@ -38,7 +40,7 @@ void init_uart_clk(u32 index)
 
 	/* 24MHz */
 	imx_clk_scmi_enable(clock_id, false);
-	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_parent(clock_id, SCMI_CLK(24M));
 	imx_clk_scmi_set_rate(clock_id, 24000000);
 	imx_clk_scmi_enable(clock_id, true);
 }
@@ -49,19 +51,19 @@ unsigned int mxc_get_clock(enum mxc_clock clk)
 	case MXC_ARM_CLK:
 		return get_arm_core_clk();
 	case MXC_IPG_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+		return imx_clk_scmi_get_rate(SCMI_CLK(BUSWAKEUP));
 	case MXC_CSPI_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(LPSPI1));
 	case MXC_ESDHC_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC1));
 	case MXC_ESDHC2_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC2));
 	case MXC_ESDHC3_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC3));
 	case MXC_UART_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(LPUART1));
 	case MXC_FLEXSPI_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(FLEXSPI1));
 	default:
 		return -1;
 	};
diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
new file mode 100644
index 00000000000..df26ecff3e4
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _SCMI_CLOCK_COMMON_H_
+#define _SCMI_CLOCK_COMMON_H_
+
+#ifdef CONFIG_IMX94
+#define IMX_PLAT 94
+#include <../dts/upstream/src/arm64/freescale/imx94-clock.h>
+#include <../dts/upstream/src/arm64/freescale/imx94-power.h>
+
+#define IMX94_CLK_FLEXSPI1 IMX94_CLK_XSPI1
+#endif
+
+#ifdef CONFIG_IMX95
+#define IMX_PLAT 95
+#include <../dts/upstream/src/arm64/freescale/imx95-clock.h>
+#include <../dts/upstream/src/arm64/freescale/imx95-power.h>
+
+#define IMX95_PD_M70 IMX95_PD_M7
+#endif
+
+#define IMX_PLAT_STR__(plat) # plat
+#define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
+#define IMX_PLAT_STR IMX_PLAT_STR_(IMX_PLAT)
+
+#define SCMI_CLK__(plat, clk) IMX ## plat ## _CLK_ ## clk
+#define SCMI_CLK_(plat, clk) SCMI_CLK__(plat, clk)
+#define SCMI_CLK(clk) SCMI_CLK_(IMX_PLAT, clk)
+
+#define SCMI_PD__(plat, pd) IMX ## plat ## _PD_ ## pd
+#define SCMI_PD_(plat, pd) SCMI_PD__(plat, pd)
+#define SCMI_PD(pd) SCMI_PD_(IMX_PLAT, pd)
+
+#define SCMI_CPU__(plat) MXC_CPU_IMX ## plat
+#define SCMI_CPU_(plat) SCMI_CPU__(plat)
+#define SCMI_CPU SCMI_CPU_(IMX_PLAT)
+
+#endif
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f0b2aad8701..43aecca6f48 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -21,6 +21,7 @@
 #include <linux/iopoll.h>
 #include <scmi_agent.h>
 #include <scmi_nxp_protocols.h>
+#include "common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -176,7 +177,7 @@ u32 get_cpu_rev(void)
 {
 	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
 
-	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+	return (SCMI_CPU << 12) | (CHIP_REV_1_0 + rev);
 }
 
 #define UNLOCK_WORD 0xD928C520
@@ -437,12 +438,16 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 {
 	u32 val[2] = {};
 	int ret, num_of_macs;
+	u32 bank = 40;
 
-	ret = fuse_read(40, 5, &val[0]);
+	if (is_imx94())
+		bank = 66;
+
+	ret = fuse_read(bank, 5, &val[0]);
 	if (ret)
 		goto err;
 
-	ret = fuse_read(40, 6, &val[1]);
+	ret = fuse_read(bank, 6, &val[1]);
 	if (ret)
 		goto err;
 
@@ -458,10 +463,32 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 	mac[3] = (val[0] >> 24) & 0xff;
 	mac[4] = val[1] & 0xff;
 	mac[5] = (val[1] >> 8) & 0xff;
-	if (dev_id == 1)
-		mac[5] = mac[5] + 3;
-	if (dev_id == 2)
-		mac[5] = mac[5] + 6;
+
+	if (is_imx94()) {
+		/*
+		 * i.MX94 uses the following mac address offset list:
+		 * | No.    | Module      | Mac address user          |
+		 * |--------|-------------|---------------------------|
+		 * | 0 ~ 1  | ethercat    | port0/port1               |
+		 * | 2      | netc switch | internal enetc3 mac/swp0  |
+		 * | 3 ~ 6  |             | enetc3 vf1~3/swp1         |
+		 * | 7      | enetc mac   | enetc0 pf                 |
+		 * | 8      |             | enetc1 pf                 |
+		 * | 9      |             | enetc2 pf                 |
+		 * | 10     | netc switch | swp2                      |
+		 */
+		if (dev_id == 0)
+			mac[5] = mac[5] + 2; /* enetc3 mac/swp0 */
+		if (dev_id == 1)
+			mac[5] = mac[5] + 8; /* enetc1 */
+		if (dev_id == 2)
+			mac[5] = mac[5] + 9; /* enetc2 */
+	} else {
+		if (dev_id == 1)
+			mac[5] = mac[5] + 3;
+		if (dev_id == 2)
+			mac[5] = mac[5] + 6;
+	}
 
 	debug("%s: MAC%d: %pM\n", __func__, dev_id, mac);
 	return;
@@ -518,7 +545,6 @@ static char *rst_string_imx94[32] = {
 	"por"
 };
 
-
 int get_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
@@ -612,8 +638,8 @@ int get_reset_reason(bool sys, bool lm)
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
-	case MXC_CPU_IMX95:
-		return "95";/* iMX95 FULL */
+	case SCMI_CPU:
+		return IMX_PLAT_STR;
 	default:
 		return "??";
 	}
@@ -701,6 +727,10 @@ int arch_cpu_init(void)
 		gpio_reset(GPIO3_BASE_ADDR);
 		gpio_reset(GPIO4_BASE_ADDR);
 		gpio_reset(GPIO5_BASE_ADDR);
+#ifdef CONFIG_IMX94
+		gpio_reset(GPIO6_BASE_ADDR);
+		gpio_reset(GPIO7_BASE_ADDR);
+#endif
 	}
 
 	return 0;

-- 
2.43.0


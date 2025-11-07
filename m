Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85769CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 07:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA8183BA1;
	Fri,  7 Nov 2025 08:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g99OYv00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC6783C9F; Fri,  7 Nov 2025 08:31:21 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6710E83B49
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 08:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn+/awd27yRObDSN4aNelVQgdwBjCfXF7cI8xhtbatKufL9PWX23rhUFj2O482i0OLOZ4DQBQgIKhMHI/lP8o6/ftJ1izgRZMgsVO9547irSkLnkflfkCTSfUFGja/Wp8V05ENoQY48nVy2t1EoVJCmQ2c/qjS1YWpmu5RNvAEIkgrfRDopkP9VTB8Xc1l4XzJsYskVOPrh22VAf7XGZ9Li3ZBc3oUosu6hSdDOJRutC0NhbcPtsq/7nuP2mGA76Rm7U2pmFaAZCSBLsvIDiHkyKT1iqmZqhCc8/0Q1bBWZ8JvORX8Uym/UrvjGeGEWidO1ZFrHogNmdLwlnvixu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p4HMV+8V78sn3wCcoVT1Um+OQ4Reo7xOhs2yKWx/38=;
 b=Q7kN2DaA7IS/mgnm85eRpIHACi0HF02sARfpc3FUtQh+5mHZd9GBkjCdenLAJsNzunfOy0ZVUc3FiwwfaPBBPqU27AlmO1lzdYAQbUt5+pJFexH4p/gHJEB1R6CaKoCShC4cJb8u7CJsm2GBz3nL067TitYAMvAeRYomG2r/pLA0AQEh+KkZG7+Rwi5TsVuWhtam6buBeTj/rbHMNqFBgOuFZTVU59OqX0cZgeeSfu3H3c0qQIyyOcNP1FD7ihrPxQ6etuyNFsSWDZDKH/rhrdar4JC8LdT8idmEKSSPhMkDk3Kc6/X0LDLBaC1QjiHyUBXnbD3CT3gnCN6w2c+ZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p4HMV+8V78sn3wCcoVT1Um+OQ4Reo7xOhs2yKWx/38=;
 b=g99OYv003cmGjzbGBX1KL7OI6W5kxQmSmc6d/W3Scao0BCeB1byDJ32273hQ7lGX7GgelbLBC2EafLp2BCxG+GUGYrAz5epHJzFDs5Bcnmcg/i6JDswkxSrNDLJwGNuA8RBLe27RUlm+vdkYTjiwcXYtZIP8QKor7iZQvpvez9JaGMycfqei5CJGuWU2K8Q6J/lCs+Wz9+rwLsu0IKSgEHBLO1GmbHh493Me5taBJwHvIBR1QnwaUYVvricFSLIrodA2W0L3bwURICscFvPilvMdzVObqIE0gTVvfbYjKeObpTrtULh3wPop+m9EavBcz4sD4S9sMXPk8HOkE8K8+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GVXPR04MB10804.eurprd04.prod.outlook.com (2603:10a6:150:214::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:31:16 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9275.015; Fri, 7 Nov 2025
 07:31:15 +0000
Message-ID: <4beb982e-c07a-499f-848b-e88b8effea24@oss.nxp.com>
Date: Fri, 7 Nov 2025 15:31:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Dang Huynh <danct12@riseup.net>,
 u-boot@lists.denx.de
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <20251103085135.GB1698@nxa18884-linux.ap.freescale.net>
 <9039b700-16cf-44c9-8e32-dfdbe73f29b8@kwiboo.se>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <9039b700-16cf-44c9-8e32-dfdbe73f29b8@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0116.jpnprd01.prod.outlook.com
 (2603:1096:405:379::16) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GVXPR04MB10804:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac8fb2e-3770-4147-cbca-08de1dcfa25d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|42112799006|19092799006|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnNLMG94VEVuOVdRUE5Vd0dERjg0SVpyUUlPeUVsUmR1OEhqUXVxOFhsclpP?=
 =?utf-8?B?M1JhMHNTUzN6ZVFOY2ZJZUxDd2JWWi9mK1FrT2YvZUw0S3RRUUtzcjlZZXVG?=
 =?utf-8?B?U1d0bGwvcE5ubHRRL0lzQXpGaUF3K0dlTm5qSHltZnorTHVCZVVYUHgrSDg4?=
 =?utf-8?B?MEgvMGNScVpWRHNnYmhTK1o5U3M2VnNrWHdWOW5wU1dTeTdWZS9KMTRZS3dW?=
 =?utf-8?B?d0pqdXp3amkyak9XWWU4b0tkdkFEdG55dGNiU2pnU3pRa3JzYXdRNitOc1pn?=
 =?utf-8?B?WmtoeEhTelJrd3ZuUkZ2V1E4b3YwdWVlcGNCR3NXbU1KWkdtT0kwYWZ3UzBH?=
 =?utf-8?B?SGVFYjNhZTMydXFpNE9LeExqVXo5bGhZbnJPdzFtQ1ljTlZhSnpFUmthakhI?=
 =?utf-8?B?eG5yY0owbFUyQTRocFZtTEZTWGJLcS91ZURvOHNUZDlsVGM4cTVGZm1EM3ky?=
 =?utf-8?B?SWhJSlpJcnB3QmFKandWZUZ6TUllZjduTTFoTHdPNE9HUzlVWlJYUmFXRUNT?=
 =?utf-8?B?WWc1dHo3MXVkdlJabGtEcHhCWkVhQlFuYW1IZzN1Um1mWlJXUmFXcDJhaElW?=
 =?utf-8?B?MVUyczF2elppSUtwcEN0cm5pczlldU10Z25WUXdTOHJ6RE1RUTJsMGw1VTZm?=
 =?utf-8?B?L3ZRNnJHcDdnQWhzd0FaRVpVeHpzOVN4NlRYYnJScU1qbnU2aEFBTUdzdXRI?=
 =?utf-8?B?Y0VGRk1MZm9GS01aem1wd3I5MDRKRGlqbHVTZkNUTWFqaVVRdVViRktraG4r?=
 =?utf-8?B?OWFjVU91d2VCSTg2MlNNV2RQbnZ1ODAyVmN1OFFCR1lGVE5LMDgyeTNtQ0dD?=
 =?utf-8?B?NWQ2S2I3SXg0UUpZNDBNUVlxM0kwTDlYSHNoZGVscjVvY3RvQ1h0S1U5VVIy?=
 =?utf-8?B?WWxGUnNEdWNLbU05aW5hcEFIZXlyU3UzWlI2dS84M1pJeTBDemZESE1Td2FL?=
 =?utf-8?B?dWNicUY4WFdyUlNaN09OdGJCcEd0WjAzbVhHb0VWRFkxUUNCa2s5UDNQS2tw?=
 =?utf-8?B?QmJ5SUx5SWFYTnBCdjF4SnFlVjB6Y2VBYnZ3UFdoZ2F2MW9mMVhyTGJYSDJx?=
 =?utf-8?B?QU5ITDN1RE5TSjNTcTIzS1B0SzVPSTBWSWg2YkxGQjdHK2E0RExZc0owZ1V0?=
 =?utf-8?B?NUJlak82RkpYMXE0WmFmZXprbVJHZDllYlQwbW1lV25IeDdrUkhDTHUrK3Fv?=
 =?utf-8?B?RU9oN3EyQm5RM01xSWs1RFl4MEQrUzU4TTdWQVFma1puUTQwci8rdDhJK3kr?=
 =?utf-8?B?bi9oSFdEU2Nkd3JmZHZTbW0rYUN3RjFlNFJ1OWJTdUhzV0oxOXJTclVGM20y?=
 =?utf-8?B?VDFwZWdQaWJUZXk0cGlSQUR5bVRhaHJxSjdCYnRvdjJhUWFMNUZBZHp5Q0Uz?=
 =?utf-8?B?aXJFN1RZNkY5Y3piRWFPQ1RyZEZuSFQxOTlGTGZrSFcyV1V0Yk1oMGxlRFlD?=
 =?utf-8?B?Z09tcXdoaWt6NStlQTZnLzhRYzJmTWZpejVYVHVvTnpaZVFOaFpabm5nZnlv?=
 =?utf-8?B?L24vTmh3Tit1MnFUeVlNS1YvQWxWTTNxbWpCS25wcmlXajV5WG93YithUDRa?=
 =?utf-8?B?NlNSWTE3RXFrT2NJOFA4SldzblhhSjFRU3djbHltWHlhTnNqbVB3RExVT2lj?=
 =?utf-8?B?WUMzNXBhT2tyd3Z6S2I3VDNmK1lBUys1V1IyZ3VuTndUd1FjUkljYmR6L083?=
 =?utf-8?B?andoMlBDanBVaG1ldlc1UlVtVzdpaUJSdDRJWloxaWFQNHRVZGs1SnBEL3lO?=
 =?utf-8?B?RDJ6RG5CbFJiUGRtVWoyQW5mQXlaV2xjd2F2OXVrb05Kb0FSbzc2L2RWa3NG?=
 =?utf-8?B?ZEFjMks3dFAvZXFqQUsxTmRVNTNBdWVOdGFSQ2RXWGo4d2hQcTVyS2I4dU52?=
 =?utf-8?B?cnhDaUNjRmZCZHNHRG1kTUoxbHdNQkJLOE9zcE1CbTR4eklpUXZ6bGJMNHBN?=
 =?utf-8?Q?cn/QD7oxiRSgFM4Y78grcjXA6nudU3s+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(42112799006)(19092799006)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJBUzRxU2wyTnBNQVlBWE1uY0tEMDRBRi9zbWhiL2xZQlRjRlEwdVpRZ25w?=
 =?utf-8?B?bEVoQThLVVEwUXZiZk9aTVZYY0RYb3NMODNtbmkzVGRQNzVqZXVJb0JKNFda?=
 =?utf-8?B?OHhlL2IxOHdTWDUyRUhodkYxKzg5UWxlcjZCWCtjSDNDT2hUWjdHcVJOK3BO?=
 =?utf-8?B?TVBIYXNGdDNaQ1Naeks4aGVFa0dDSmNXNGxsTUtJbVQxdUIxa1ZoeXpuY2dN?=
 =?utf-8?B?YnA5NmJxK1pyNE8wUXoyNUxBZzd1V29ZRkpEYytod1RidGpEVlo0dTVCM051?=
 =?utf-8?B?WkM2RVdKSXZjUDRyeC9ZSUhXR1NPNFEreUduamxuSmUyRG5xS1J2Sk82U3Rv?=
 =?utf-8?B?Z0p3QzBVNTRiajFXODkxelNpVStjMC9SZ0M1YTh4aWVwVC94Yk9hcTQ5SXZF?=
 =?utf-8?B?aTg1KzBtM2lBNlRrZzR6L0Z3bFFUVFV5RnMxZGU2UlVVdXpYUkYzUE9GMnl6?=
 =?utf-8?B?M2xNaWZkMVQrS01ZV1NsKzZuV0ZqZ2Fock5XOWpWNUc0d2x4akwyN0EvWCtJ?=
 =?utf-8?B?ODhNYUhiVkxtSjllWUN3SkwzQWFPbWNjZnIyZk0rNnhuTHAxZkU5aHZ2cW9r?=
 =?utf-8?B?Vjc3bWdjTU0zbEhuRGdhVEttbnYxcWJKVmUwWjdUc0xZN2VIenhub2xSd3NK?=
 =?utf-8?B?WDZoRFNoazJtUk9OKzd4MjErcy9abXdoQk4rV3JLUHFhT1BRN2hqRzFGa3l0?=
 =?utf-8?B?Z0ZIRk5TUHFwSnV0TUNQT09wV3o0RGdHMHArSHFud3ozSzFKaTlnM2oxeity?=
 =?utf-8?B?d3FxYmlMWXF4YlVLVmxWMVlEUXAzUHRuZ0RYcUNKZ0dvZUY1YXl5ZkpWODhF?=
 =?utf-8?B?WExZY2dFejJURHlSbXFHd0cwMlRsREF5cDB6ZHI3QjE4QkhaV0ttTVI0YTBt?=
 =?utf-8?B?ZEpWZnFiVjNnS01UdmFwWFhPQ2VRbGxYc3ZpMEh5cGJ1d1dBbDJweld3T0Jj?=
 =?utf-8?B?RnNGSm8wangvODVTdno1T2k2UzU5WEVKcm84bmZQSno2QjZyOHBjWEVhMzBv?=
 =?utf-8?B?TE1DUGgyK285MTlNbVI3VGcxMlZ6NEptQjNURGtXSGFDRndUMXNkZnUxV3Q0?=
 =?utf-8?B?UTlwbnNTbU9wSU1Nak82TUFhRUVqdmk5cXRtRzIwMUZVZDBzb2RNNHJUYVBX?=
 =?utf-8?B?ODZoUTRRQXBQRHVNUGdUb0pPLzIyaE53ZVJmL0pKS0ZaMWdyeHg3UVNSQ1Jl?=
 =?utf-8?B?d25HQlhES2x2NTFhTUNEa3FmR0l1QUhqaVZTMldhV0JUM1JzUURhc09CSHJW?=
 =?utf-8?B?S2Y0VHNBQ3JSeXVNUXZsbUZwZ1ZWTDBjSngyNXNVMUtJNHFmcW9zaDJ2RGE1?=
 =?utf-8?B?TzRSK2NqLzRHalRSY0ZjdWhuckFEQmUxUzBWOWRGYXpkRjUyeHVQWEtJWnpy?=
 =?utf-8?B?T3FITDVkN0dZN0RaV0JiZDljWDh1blVJV2hXaEUxVndvd3NsakVSZE8wWXVB?=
 =?utf-8?B?NWwxcjMyNDI0NUNUSHBxbzJpZTZHSXE2Tkp1WkRtc09sV3E3UjVOSTlrS282?=
 =?utf-8?B?ZnVuSlBJQXQ2SmtXVUhtSkxNNVRENEhNTzNKZ0lzL0VXOWxBWC9oTHZUUk8y?=
 =?utf-8?B?ajU2dnZRbGY4NFBDYnAxakpqcVZXdHlJNDRYcmY5MFhPR1J0NHBXUUxPcEtN?=
 =?utf-8?B?bFRjR2RnR255R01VOTdVdFk1dUpCU2k0YS95NTJEcUJJZkJLYm5HWURqZUhL?=
 =?utf-8?B?ajlzQmFqTFczN2Y1Q1E2VWJFK3FZa2tqZ3FxQTJRSHV6NXcrZUhOMm9PNVFW?=
 =?utf-8?B?aW04dkQ4OE1oVEdOQ3lFK3ZFV1NLVjRuNTM4SXRGeC8vVkcySks4S0NtblVP?=
 =?utf-8?B?cDQ0bDlTVXZaQTA3S2VyTDVnSUNxWUJENWpRSmxiTmNqU0xrOVBmUVhBT2ZN?=
 =?utf-8?B?S1B3cElSUVdpVEp2amRNQ2hoUVZUN1d5NU1HbVFEL2dKVUhJTEZLQlc2TXg3?=
 =?utf-8?B?OWhNVnVaeXNER3JUdjFoUE5qZVBXSklhK3dLc0xscjNEV0RhNUF0Vnlic2Nv?=
 =?utf-8?B?alZUUVlJNjJFbEpvUmRmWm40QTNGSm9MOGhNaTVoc0tUcHZDQlZQUm52MHBn?=
 =?utf-8?B?a2krSVQ0aTZtZXVDVUM5ZEVLOHRMbldzWmxReTBlZlcxSWxzcWFldlN6QVdT?=
 =?utf-8?Q?lglWrqlWXTl5sKB9As1Mqbw47?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac8fb2e-3770-4147-cbca-08de1dcfa25d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:31:15.7113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKCfH1QtojLknBNPjradIvF8VVq9/sxCSxln01vjgZT1cuZqoYnQX+80M1ILCamn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10804
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

Hi Jonas,

On 11/3/2025 6:36 PM, Jonas Karlman wrote:
> Hi Peng,
> 
> On 11/3/2025 9:51 AM, Peng Fan wrote:
>> On Sat, Nov 01, 2025 at 08:34:26PM +0000, Jonas Karlman wrote:
>>> Rockchip boards may depend on a working MMC regulator in SPL to
>>> successfully load FIT payload from MMC. Typically, these boards only
>>> include the vmmc-supply regulator and not its vin-supply in SPL control
>>> FDT.
>>>
>>> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
>>> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
>>> boards due to now requiring the vin-supply to be included in the SPL
>>> control FDT.
>>>
>>> The commit also strangely enables any found vin-supply in
>>> regulator_common_of_to_plat() and not when a regulator is enabled or as
>>> part of regulator_autoset().
>>>
>>> Revert the commit to fix FIT loading in SPL on broken boards.
>>>
>>> If a board needs to have its vin-supply enabled, two options come to
>>> mind:
>>>
>>> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>>>   any board.
>>>
>>> - Implement full support for reference counting of regulators and then
>>>   update the regulator-uclass to enable any found vin-supply when a
>>>   regulator is enabled.
>>>
>>> This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.
>>>
>>> Reported-by: Dang Huynh <danct12@riseup.net>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> drivers/power/regulator/regulator_common.c | 10 ----------
>>> drivers/power/regulator/regulator_common.h |  1 -
>>> 2 files changed, 11 deletions(-)
>>>
>>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>>> index 3ed713ce5019..685d8735fa5c 100644
>>> --- a/drivers/power/regulator/regulator_common.c
>>> +++ b/drivers/power/regulator/regulator_common.c
>>> @@ -44,16 +44,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
>>> 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>>> 	}
>>>
>>> -	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
>>> -	if (ret) {
>>> -		debug("Regulator vin regulator not defined: %d\n", ret);
>>> -		if (ret != -ENOENT)
>>
>> I understand it might be not proper to enable vin-supply in
>> function regulator_common_of_to_plat().
>> But I have a question, there is -ENOENT check in the original patch. If the
>> board does not have vin-supply, there should be no issue. Or I miss something?
> 
> As mentioned in the commit message the SPL control FDT does not contain
> the regulator references as a vin-supply, this result in -ENODEV to be
> returned. I.e. following where the vcc_io is not included in SPL control
> FDT.
> 
>    vcc_io: regulator@ {
>    }
>    vcc_sd: regulator@ {
>    	bootph-pre-ram;
>    	vin-supply = <&vcc_io>;
>    }
>    sdmmc: mmc@ {
>    	bootph-pre-ram;
>    	vmmc-supply = <&vcc_sd>;
>    }
> 
> With the change introduced in this commit the core gpio/fixed regulator
> behavior changed and this now result in unbootable boards.
> 
> Other reasons why I prefer a full revert instead of a workaround:
> - The implementation changed core gpio/fixed regulator function without
>    any review-by or acked-by.
> - The patch was quickly merged after only being on the list for 1 week,
>    the imx pull-request that included this did not even mention regulator
>    changes.
> - The implementation is not optimal, looking up vin-supply could be okay
>    but not failing because it is missing, and enabling it during probe
>    when we already have working enable count and regulator autoset to
>    handle any needed auto-enable.
> - The commit message does not give any insights on why this is needed.
> 
> My suggestion is that this is reverted and if needed it should can be
> submitted as a separated patch/series with a proper implementation.
> 
> Regards,
> Jonas

Shouldn't the reason be the broken SPL FDT? When one node is used in SPL 
FDT, the nodes referred by its properties should also add 
bootph-pre-ram. In your case, it is obviously missed for vcc_io. You 
can't assume driver never use this property.

If a new change for vin-supply is submitted in future, how can it avoid 
ubootable with these broken FDT?  It is appropriate for current 
implementation to get the vin_supply in probe and only check ENOENT. The 
ENODEV means a explicit problem that can't be ignored. The contentious 
point is if the vin-supply enablement should move to set enable. I agree 
with this proposal, but it is not related with the boot failure.

Best regard,
Ye Li>
>>
>> Thanks,
>> Peng
>>
>>> -			return ret;
>>> -	}
>>> -
>>> -	if (plat->vin_supply)
>>> -		regulator_set_enable_if_allowed(plat->vin_supply, true);
>>> -
>>> 	return 0;
>>> }
>>>
>>> diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
>>> index 799c968d0b66..d4962899d830 100644
>>> --- a/drivers/power/regulator/regulator_common.h
>>> +++ b/drivers/power/regulator/regulator_common.h
>>> @@ -14,7 +14,6 @@ struct regulator_common_plat {
>>> 	unsigned int startup_delay_us;
>>> 	unsigned int off_on_delay_us;
>>> 	unsigned int enable_count;
>>> -	struct udevice *vin_supply;
>>> };
>>>
>>> int regulator_common_of_to_plat(struct udevice *dev,
>>> -- 
>>> 2.51.0
>>>
> 


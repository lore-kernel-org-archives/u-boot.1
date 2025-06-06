Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4FCC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2D482B0E;
	Fri,  6 Jun 2025 22:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lT+9vmQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6771482998; Fri,  6 Jun 2025 22:17:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C4B82A8D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKIoAly/ocAfTrWMtxGJhO/WjDBTsp2jXvGT0LtBN+ubKmXHcbYTfqiWkV2OUxuYm+LUqRCCcvhHELmPNxginGZrGDkgQOjZLGSUdGx++hxKybwt05b39zgm7BklaaXRCBsldVRWoyrq045kFM1ZAczo0HRq2foy1oW/3uLct4AMfDMzDxdxrwoMSmwAiaA/37yf98N3aPONgsNRRYtY9ck+52oFLmZWxEAbBS6uN8Wj+pw3cA2YZ1svy+48Ux5ATdMycb0NLpCzelN3RuSRQfoJYkP1AxO/LyLKpWa0xixdNwr31RmittXbN8M25XWCe8xtdtGPhFXbuqjbkA70Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMB8CB9HczPFtpz4TcL06ZgswL5lgA4s3vrKWxbkUD8=;
 b=X/FD++xmdo5EIkpuEVoiJ4jgFkC1Pdj949vWq1H8/U5ff2ZPcoCNQfpmJO2zi7LvEx8+1SqYQQRTi+rYis9p+IOQY4CYF9E1dLipRG/SNqN87NKdJU/PzRkmdfkrUVxJaLXJmZNZQ/7iPoggrlm9pZBFfwNEGvPUuLIVWP1p3PUONZ8ItLXwq0q/5+gOWyDgQp1TkqrrLG/F70WBbmu6i5hUFK8ove4mvJ9x+lg5xqvb4+F5+NrTFjbPvCEvzmc8eZN1rUZFPAnMDkyttRHRV2xnhZvfuPoQd/s+lJ6E99MPdJ7PZevp+CN/IAVAa+O2b7+DC3J3meSYc0+pEODk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMB8CB9HczPFtpz4TcL06ZgswL5lgA4s3vrKWxbkUD8=;
 b=lT+9vmQcgtKwvsqzEsbfDziP/LoepA3QGnLUKQiGCXHguGrg58Sst1kkAgJ0wRoPrz3x1iD6bkgwyI2VIRZ4QK1mrL5Jfx3JuUdRTWZmQFq5DtQ0xc94uH9uAy2tL3IYqV2+PE/91t53nFu4IBeMoVzXUEhtIb1eDQGn6Cm77u3VvKj88UGE4NhVY3QpEc6PepfGG4QUHXS/B5oT4r3jDSmr9CC+7Q7ImFKKqZq76Xqv3IVLUlSLPNtC6W3uNrmXktHafpkdhovf4V4oWWy9bODfSS+HynpoUyfsAQ4Olqpyc1H2dfhAMqqnCPkNuzQiICni+UZ4fFTHYnThE5xLQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:17:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 20:17:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/3] drivers/net/airoha_eth: fix stalling in package
 receiving
Date: Fri,  6 Jun 2025 23:17:28 +0300
Message-ID: <20250606201728.462664-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
References: <6843478d.050a0220.6e23a.5ec5@mx.google.com>
 <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM7PR08MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: a24fd850-19bd-4fa3-c479-08dda5372e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFV0R1lwTm5FSmlIS3VUeUQrMHNjdnV0TVNINFVRbW1sRmZMdTQ3YUNtQU5p?=
 =?utf-8?B?a2J4WkFjVTZvVHdrVzZpR3UreWlRYk1CM2xiT0tlVUZBMnlOQVFNK1grczNn?=
 =?utf-8?B?SWl1a3EyZ3BRd3lPM01EQi9UWCtEeDY1THBZbFRPNDZ2T0g5bnQzYUFwN1Ev?=
 =?utf-8?B?dWFWRUN3KzFjVU94QjZCNG0rdDBINWk4SHFhblhaMnFtY250SXZUaTRoTUFo?=
 =?utf-8?B?L21FT2diTkpXY240amYyaFFZREJBUUlYWGZFaTV2cGFkdE40KzFseGsyYUla?=
 =?utf-8?B?TVhMRnR1bWcreDJTSEFLRS9RSmZyR1kvMlFYRUVZRFdiLzBKTjVmK2FISVkr?=
 =?utf-8?B?elhNWlFtU0djM1FoRFZMYVlOSkJhQWUrWDQxV0VicWJ2SVBSK3A5YjJWUFNK?=
 =?utf-8?B?bktGR3ltd1QwQ3hjZndHRWtjUDVLQjhueFlnMlZFZU8wcnNXQUNuTjQyRWxy?=
 =?utf-8?B?aE1wOVYrUGZ3bE9pbWowVlNtaVNadzhLWlV4Z1NzamRHS0pEWGwvb3dZS090?=
 =?utf-8?B?SEYrY3hyczBnWE83VkM5T09STGZuUkpMTUNUNlovQnBmTDNreCthL1pZckNI?=
 =?utf-8?B?SlN6L2JaN0tSdjBvdzVPcG0xRm1pY09tYmFodXlCQjhPRU5IY1JKaG5TSk9N?=
 =?utf-8?B?blNHQ0VHL1ZKUWtoZHFKUDNJT2FXdmVrRWVnOFZub3l2MmhNOHhKVVRJc2xQ?=
 =?utf-8?B?RUQ3eFg3bit2K1NudHN3WjdBc2QxYUtFYkQvOEVlUm0xVFYvNnRwTFNLeG9B?=
 =?utf-8?B?Q1ZDRzVneWpPNlB5NlpxWDZWdHBWUkhBR1VGcUdMS0t6MCtNQlZ6cnhTYXJ0?=
 =?utf-8?B?eHFBMnhYL1ovaW5tTVROazZ6MEtLVDJWQ21rQW5JRGNlZDZqeS92Y0dqbVd0?=
 =?utf-8?B?OHFveDlEZXBXZzBIeVY1d01na0lpbjN6bXc3aDFKM3NKQTFrZkhPbTVadSt2?=
 =?utf-8?B?a2JTcEJseE5rT1NhUnlGcGgwSEdBc0F4UW81WG1lSHpKWk5tMVpiV1YxaFg3?=
 =?utf-8?B?L0dXVG56anNaQk9sMTFRc09LdUxKMGR6bVpweHZ0YjR1anRYeWZEMzhuMTJh?=
 =?utf-8?B?bmd3REJPbytubms1K25MZGJHb1l3Q2JIRHNwWVZtVW56RGlDcXNLRHdHeUFj?=
 =?utf-8?B?dk1IT1oxdUpCNU5yc2J4cE45R0VEbm4vWXdEeE1MRVV2ZzhRUURBV0lIblVZ?=
 =?utf-8?B?UnM2aGpQazlObmVqMlIreThnMWpWYkJJNDQrWFo0bnBaVkpReGlMS2dvWk9U?=
 =?utf-8?B?M1liREVzUXdaT0Qxc2N5dFdRNlhRUzUraDhxbGJZaE9BdEhxZ1llZDBBNFNS?=
 =?utf-8?B?NU9vY0ZoL3N1WEdCdXJxcTQ0dGJYclllTFVOVTNnMEhDWHlucUFlTGpveUwz?=
 =?utf-8?B?NVhVcm9QdDFhZjUzaEVrVXZpdmNMUFp0b1pmMmV3V2gzMnhUQ1BtblM3L0p6?=
 =?utf-8?B?NjZvS3FUZnJhTFdvQ0dlUHhoYXY5RnZNa1pWUGsvQXBKelI3clc0V2lqYU41?=
 =?utf-8?B?cS9JU2FuZmJiYyt3ZHBSR0U1bDY3alNodk5HcFR1QXhFZUxpUkNLM2I5amtk?=
 =?utf-8?B?QU5KK2Z2dy9uTnp0NDE3aVZtZXFXa05sWnhXSjdsSVNSVkFSVVh4SnlKM1NN?=
 =?utf-8?B?dks0UVhlWmFxQkRkT0NQNEdHR3FKVU45Y2Q3TTdpNy9jdlNwSm5sbWVoWmlF?=
 =?utf-8?B?T29CYlBITjFMNmtqTDNmV0s2Tm9sbmJKMm1acitPRVk2NGhleG9wZ1BzTkVG?=
 =?utf-8?B?ZytWeTRJVGcxN21FRHFDaVBONXVoeWRZV3YzditPUzhrZnZIMFVLQ3BRTGhC?=
 =?utf-8?B?R2V5dUlVaXlRNHFTRGF0UUJLQ2ZZeitmdjVaaTFuZFhtYjk3UkdxME9wcDV5?=
 =?utf-8?B?dzVReE5EVGNocFJmSFZYTHNnQ2ZkTXJKcndDbnVsd2RqYzRVd0xjRE1vN1Zn?=
 =?utf-8?B?OFhuS2dPbktYUUQrbm54alFpaEFGbVBNSnYvYzhFM0IxeU9STnE2QUZKWkNB?=
 =?utf-8?B?T0htMzhYZFhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1oU0tiUFluN3ZTS3czY3VKY3d5NFFGRzN3UENKK2NRSTJxdEk5eG4yVHhp?=
 =?utf-8?B?b2o5RS9zTm5oaDdFWE5nV0R0VWliRmYvM0lSWmZDSWJ1a0EvdXlNTk9YZklO?=
 =?utf-8?B?RXVEQlIrcnh5UG9DbEdoVXliLzFwVzNaK0N3QTBhakdlYkVieG1ObG5MKzN1?=
 =?utf-8?B?ODM4ZWVtR3dwblAyTndmeEx4c3Rrelgzc0FWaE8wUnhPVXNycy90ZXUrRkN5?=
 =?utf-8?B?Rjc1MHNMem1iRUdmd0ZYZndLcG9XM0NCMDlWUkE4eThTUlVOdGRzeVBnWFI1?=
 =?utf-8?B?SUJ4eFFyanN3VGFGaFFYaEV6UlJsdDQ5UFEwanRVTGowQXRBZkpoYytlcUU4?=
 =?utf-8?B?WFdFcEE3UG0yWlUvZVVvRWJ1YjZDTTJWbkpVUkxKejl1MlViZEpwNEQ0Qzdt?=
 =?utf-8?B?TGZId3p3ZS9pYkdGTHRTZURCNG9aRkNlS0pNUnBBZnRxclpaU28zVnFYQ0RE?=
 =?utf-8?B?YUxibnl3Y0l2VUFnK3QxVmI0cnJZM1dNMW5SQzNZNnpMckFhWkd1SXJmb2lJ?=
 =?utf-8?B?YktLM0pFQlMxc3hId0IrRGZodkR2NHhXMHlGNUN1QzZjenJhOGp3YU1UNDFO?=
 =?utf-8?B?dzN2N3RFK2I0MG43K2ZjWFB2N3I2ODd0WHRPK2dkZlNQaUJSSGxIczFsOFI4?=
 =?utf-8?B?dFV1Q2VBK2JHalpaTXZPMmhQUWozeVhGSjRWbVFOcXgwL0p4eU1Jd3F5TE5t?=
 =?utf-8?B?NkQzYnE2TlNMQXB2c3NCTzNaMEt0N0M5SE9FVkxhUDdwMVByc2tiL3BkbXZu?=
 =?utf-8?B?blVLM0FQMktPNTl3T0M4UFlaRW5LcUxYd0NWMHNNK3JEaUE3ZlR5bzd6WENu?=
 =?utf-8?B?cUMvL01UbGxNWFJUS2d0bE5wRStHYTJWWDdqYVIxYXJha0lxSWt2SzBOdm9F?=
 =?utf-8?B?WlZxVFFjT1RkWnlHV2NVUHRqK2hDRzNmRWFvTExyTHU1L3duemZ3TFlYZENF?=
 =?utf-8?B?RWl4b1RIZ0NlQzFhTkh6THVJQjhDZzNBeG90aGtaLzg0RTMrS1Q1VHVDb01k?=
 =?utf-8?B?RnNyTTRJT2RuZnlPUElUQzhpdCsraWtzOWZPOXJENGZtYnN5WjVxUWhzWnlo?=
 =?utf-8?B?ZkhkVDFxWk9FcFZNb3A1OUlLWG5xSjFOaStoeVpSRVYwNW5HaXpobi9vVGVm?=
 =?utf-8?B?aEJSWkQzNTYyeGliZXlWTVlZQThvTXVLdTlRL3poWUtMK0k4d3hyaWRoR1B2?=
 =?utf-8?B?VW9GY3c0Zjd3VjJRU0k3RGsvcTFrek5lN0hiRjB5c2VJSnNDTHlKcklqYWl2?=
 =?utf-8?B?T1h6TjVVbkZ5VzZ1dWZrYzVYWU9URUlrUEYyODE4SmVxOXBPeFVOeVd5K0h2?=
 =?utf-8?B?T1BFLzlOQ2lDczBHeHNDZ05XK0VKVmVGK3ltdDNJbDNhVVZXY3p2MkNqRC93?=
 =?utf-8?B?Y2w3VmhRelpwYVRJR2xGZElYWjhjRG9nV3p0WDMzT1lGZ2hRV2EzRFplZ3BW?=
 =?utf-8?B?QWdvanlyclJaQUZQdHNWQ3Y0TWVlOFhoZkJGV0FtOW1tTC9mRkFGN3ZRa1NZ?=
 =?utf-8?B?bVlIZG01dHRrTjArMWdadDZzL05vRjZVUnlMT2EzUjJyQ0Vhc3owSC9ieDk2?=
 =?utf-8?B?dWsrOWtDdTZ4QXVZUWV4b05ZQ3dnTDZtd2d1aENMdGZXQ01MT1B3YktmcW5G?=
 =?utf-8?B?dW5LbkdCS3hlbVg5RjNkcUMwS0d0OUhsWFRzaGJ4NnZuYW1RWWROZkZCR29H?=
 =?utf-8?B?U0F2TGowd3JjNXArVlF4dWJvRHZXMVdnWkxaMjBsamQ3UXEvTU9WcXlNUFV4?=
 =?utf-8?B?YzR2MnFNYWdjaFlZZUc3cVpuZE5LUzBYM3hTRDI2VHF6WHQybTl6aVg2V0pF?=
 =?utf-8?B?Vlg5aDRHb1E0aWNJaG8xMjBXSTNyajNPcWpDUmFkM1dqWXRQNmxjZ2d2Vnli?=
 =?utf-8?B?SjcvMnUzSXBmQnVqeUU2eGtTYWxEeFBIa2QxcDZXWGMxaHVEWHRSdURXdVlF?=
 =?utf-8?B?bVloZzlUMzQ2S2wyTlVmY0JiUHlmS1pGdUZVaFpjdlpJejdkZUNEUEJUSHRB?=
 =?utf-8?B?U1p3bi9NMmU1eVE1S2EyM094UkxtMWdBaTRucmcrV0lKYngwcVpQRkdNUTR4?=
 =?utf-8?B?S3BBc3JuSEllZ3RpVjBWOUdWdEZrclV4MTYyOThsTWdzUmYyeUVNQk1JOUx3?=
 =?utf-8?B?bk5lNEsyRGdNTEtTOVdpZ09TSEZMalR4VnhZZmRvbUp6M3JXVll3S2VlaWli?=
 =?utf-8?Q?prYeU1+r3ucscK85glA1F1c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a24fd850-19bd-4fa3-c479-08dda5372e73
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:17:38.0724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaNZ3XPJwt9RL4aZvO2NTpur9aIRC1r1dlJDcRK6oWXS7yaOPrtCqIUOZpi+Pl0KeOCC/QvYeYbBLfmcexIhURjRMcFHBryZtyTYjhiw9Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
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

ARCH_DMA_MINALIGN is 64 for ARMv7a/ARMv8a architectures, but RX/TX
descriptors are 32 bytes long. So they may not be aligned on an
ARCH_DMA_MINALIGN boundary. In case of RX path, this may cause the
following problem

1) Assume that a packet has arrived and the EVEN rx descriptor has been
   updated with the incoming data. The driver will invalidate and check
   the corresponding rx descriptor.

2) Now suppose the next descriptor (ODD) has not yet completed.

   Please note that all even descriptors starts on 64-byte boundary,
   and the odd ones are NOT aligned on 64-byte boundary.

   Inspecting even descriptor, we will read the entire CPU cache line
   (64 bytes). So we read and sore in СЗГ cache also the next (odd)
   descriptor.

3) Now suppose the next packet (for the odd rx descriptor) arrived
   while the first packet was being processed. So we have new data
   in memory but old data in cache.

4) After packet processing (in arht_eth_free_pkt() function) we will
   cleanup the descriptor and put it back to rx queue.

   This will call flush_dcache_range() function for the even descriptor,
   so the odd one will be flushed as well (it is in the same cache line).
   So the old data will be written to the next rx descriptor.

5) We get a freeze. The next descriptor is empty (so the driver is
   waiting for packets), but the hardware will continue to receive
   packets on other available descriptors. This will continue until
   the last available rx descriptor is full. Then the hardware will
   also freeze.

The problem will be solved if the previous descriptor will be put back
to the queue instead of the current one.

If the current descriptor is even (starts on a 64-byte boundary),
then putting the previous descriptor to the rx queue will affect
the previous cache line. To be 100% ok, we must make sure that the
previous and the one before the previous descriptor cannot be used
for receiving at this moment.

If the current descriptor is odd, then the previous descriptor is on
the same cache line. Both (current and previous) descriptors are not
currently in use, so issue will not arrise.

WARNING: The following restrictions on PKTBUFSRX must be held:
  * PKTBUFSRX is even,
  * PKTBUFSRX >= 4.

The bug appears on 32-bit airoha platform, but should be present on
64-bit as well.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e18816b2943..477a132fb1f 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -392,13 +392,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	return 0;
 }
 
-static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index,
-				      uchar *rx_packet)
+static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index)
 {
 	struct airoha_qdma_desc *desc;
+	uchar *rx_packet;
 	u32 val;
 
 	desc = &q->desc[index];
+	rx_packet = net_rx_packets[index];
 	index = (index + 1) % q->ndesc;
 
 	dma_map_single(rx_packet, PKTSIZE_ALIGN, DMA_TO_DEVICE);
@@ -420,7 +421,7 @@ static void airoha_qdma_init_rx_desc(struct airoha_queue *q)
 	int i;
 
 	for (i = 0; i < q->ndesc; i++)
-		airoha_qdma_reset_rx_desc(q, i, net_rx_packets[i]);
+		airoha_qdma_reset_rx_desc(q, i);
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
@@ -444,10 +445,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
+	/*
+	 * See arht_eth_free_pkt() for the reasons used to fill
+	 * REG_RX_CPU_IDX(qid) register.
+	 */
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, 0));
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 1));
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 3));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
@@ -906,6 +911,7 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct airoha_qdma *qdma = &eth->qdma[0];
 	struct airoha_queue *q;
 	int qid;
+	u16 prev, pprev;
 
 	if (!packet)
 		return 0;
@@ -913,13 +919,24 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 	qid = 0;
 	q = &qdma->q_rx[qid];
 
-	dma_map_single(packet, length, DMA_TO_DEVICE);
-
-	airoha_qdma_reset_rx_desc(q, q->head, packet);
+	/*
+	 * Due to cpu cache issue the airoha_qdma_reset_rx_desc() function
+	 * will always touch 2 descriptors:
+	 *   - if current descriptor is even, then the previous and the one
+	 *     before previous descriptors will be touched (previous cacheline)
+	 *   - if current descriptor is odd, then only current and previous
+	 *     descriptors will be touched (current cacheline)
+	 *
+	 * Thus, to prevent possible destroying of rx queue, only (q->ndesc - 2)
+	 * descriptors might be used for packet receiving.
+	 */
+	prev  = (q->head + q->ndesc - 1) % q->ndesc;
+	pprev = (q->head + q->ndesc - 2) % q->ndesc;
+	q->head = (q->head + 1) % q->ndesc;
 
+	airoha_qdma_reset_rx_desc(q, prev);
 	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
-			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
-	q->head = (q->head + 1) % q->ndesc;
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, pprev));
 
 	return 0;
 }
-- 
2.47.2


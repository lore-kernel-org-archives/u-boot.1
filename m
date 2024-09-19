Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A1CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0B18903E;
	Thu, 19 Sep 2024 04:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wysQgZbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5D789059; Thu, 19 Sep 2024 04:58:43 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7432C89060
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnneONlV0m/XflD+Z5gbVnzWgIUY2tBvQb6GcZd54zjU7lGaRAGKcaQ8fWgBJxOGErpSjYdBuvMcpETifRG5ZupQmr7NaMd/xBddNAuQ9ixFuGjTX8YbNCjZhaWDeb44qhnhdELrs+sFxQFODTuqbJ8mUNCNBcZeN2zqWewj4YCoeMz+cjebxrFFH3Pp7fk5bUj5CssV3wMl+UkVLUJCqeudq7vuV+RCWebRwC6NOcb4OakwqNU2Zj30sw3PKXc6BZ5p5YAiBf87865py0UlldRDpTRJNZlEZRYXYF/Kd4FKrCz06EGCDefarZ4TdfxwiZg8j6ZyHQfOtKjpio1NQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VttBnCDsUEbIfX+H2orlLJwqP6z406AG3Q1FHZMvZKU=;
 b=wbROM7iaIhsqCJH5PuZRxGrvYVxUoxz4eL6g1/g3aD5Odj+RBhvtv91l1NEhrLNImk//a0EFnSq/gX6euw2IrH7IftGi2/h0qx9aM8uFlVM7Q0r1f6FotAFmiiuH1o5neS/IshiIe1VNSRIJYEgx14/tWtoOZhO0oO4LW7jxsTXkGzGKbbRF+8h89/X9ifcLEss/yOyq3BV1mntLEPjcBVcogtcuw6f2+i0wGSlKrluc2d83WaJl/AEI1JCo/AJbTFkVF6ZMD6VRHqtiR0bTlKKkuAtW+XHYU99AOh4EJjbMGk8yn3XQDTwZknS+jq47eYxJ3RJ2sbrvkxklvEf3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VttBnCDsUEbIfX+H2orlLJwqP6z406AG3Q1FHZMvZKU=;
 b=wysQgZbNN808NbYWy5/doeXxOU+PhSs9UL2zHMYGCDsg/VNlYaCnzvc3RrFyta0pPE7YYiFVcFkLgzr/sFNjzdckFnxZUL7UzWkH4EzH3xDsSD/KFV1KcXUfOvA8Tm58EBgLPcXXVkcY3vTIAiQ1NDIuizNgktASd9Deq8XPRzQ9MpMZcP3PNcHGifMQabJS7e6RrkN42os4tQCvxfWy4ggKkBiw2DpdqdjXpNWyUGpvnRe2zPNo1TpPMmS6INXHYyKj7AkLXiqu59ScfQXJlZ6c2bS5PQd+AEMj7b3UOPHdpMbYSIdLYUK+zSWU/Q70b2VbBV3ZDSVcSiMkGZXmAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:31 +0800
Subject: [PATCH v3 13/21] imx: Generalize disable_cpu_nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-13-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a94d34-4a29-4f6c-fac1-08dcd856f560
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWRQaVRmTnNrT3RtVU91UlNybUFVK0dScVNzRkRhNEhlN3BJYll6TndIc0pj?=
 =?utf-8?B?VzNhZXduRVRBK1NKdmxuUUhybnNnbk9rNVBib3laSDFoZXNia3M3Q09EaU5R?=
 =?utf-8?B?YXMyVDBzYzJ3aFRsWFNLOW9PWlk4S1cyLy82azF3R3lVMXM4dHA2OVBZQlkr?=
 =?utf-8?B?WkNsV1R1dGdJOEtuNEJRY010VU0zZ3Zzb3hiaGlnQ1l1RVF6VGJuVXYwbUdz?=
 =?utf-8?B?MjVnTnA5RXk3dE5xckt0ZUNydXc3bEh4VjZ5U2I4eTRTTEUvN2NHQlg3cDJn?=
 =?utf-8?B?dHBpVk9JMTh1dEFaUHkxaGpSdGxUMUt4Y0srcTJ1WC9XeE9CVVByc0F5elhh?=
 =?utf-8?B?QnlpUU8ycEc5QmNwbkovWWo3OUU3cmJlcVVaUnFockFtQ1M1cEJaN0tpSEU3?=
 =?utf-8?B?aFphYVQvbFdqa0hVd3ArN2RteEZWRVNGazJhNWZ5REVqTkNNeEgzd0IzVFdm?=
 =?utf-8?B?RUR0Z0tlK0pLbGVaSC9BcUtaM1g2TWhFbnY0VTFOQXljY2tnQ1VuTEM3amVy?=
 =?utf-8?B?dThqTmZLZjd3MkRuL29JbkRjRHVTWXd6R2E2blpMU2pvWVh6SFRvR3ArZEp2?=
 =?utf-8?B?NGNORW1nai92eEh2Y2ZtcmlXbzNueUVmdnh6aStIWUdadCt1RmlBb1JvN1JF?=
 =?utf-8?B?dHRQWHhVVjY0VXlCajErdnBjM1lSbUhWNlBySXJTN1kyK2F1Ulh1OWVRNnRH?=
 =?utf-8?B?SVEzN05SL2l6ZFBidXlEQjliNFAwZXZkS0JoR1lnWW5oWG52eWpKZC9NelFZ?=
 =?utf-8?B?a1B4SGZxZVpuaUZPb3V0SVVFVDExSDBQUTlnTlN4c0FwNUplakh3NjJjYXk0?=
 =?utf-8?B?TEtvdXY3dU0ySlQzS3BlMTJlelA2eGdrazdodUhwRnlvWVRmc0h2V3VQdVl6?=
 =?utf-8?B?Z3ZHYm80dU5GeUdPbkY2dXRwUjdJUmRQczZSaDFwRjJwTHRjNERod3k5S2lS?=
 =?utf-8?B?V0tseHU4bkhhSzZzaWdCbVJ3c292c1RHdUF1M0YvWDVYQmZqWTZLYWFPZXAv?=
 =?utf-8?B?cW1SeEp2Uis3Umg4dHdpUjJmZkRzcElwaDllVkdaM3VzRWg1TkF2U1pWMG9E?=
 =?utf-8?B?bmdOUiszMEtOZVpIdjZtUFIxNG5yUVR2U0ZSRm5BYjNEZ0kzRXRBd0VQdGdr?=
 =?utf-8?B?R1REdmNzaVF6dHJUbFVnMlBJZEZTZ2dabTlwem1qVEh2b09taW53NUJhdjFs?=
 =?utf-8?B?YnM0ZGw0UmZ3QTI2SThlcU10clJiK05Rc0FRNnFxRW9yL3IvVkE0WDYyWWZE?=
 =?utf-8?B?cFF0K1JrSk1GWVl2Mk5BZlQzRkhFTjJmZzYrb240SXVRMXJBQllFV29WZ1dH?=
 =?utf-8?B?dGV0UUxOS1FUQlI0OTBJdStzbDE0MDF6Z3dwT3NEMDFXRFpLbk1XWStEaDIy?=
 =?utf-8?B?cjZUNFpJcTJhOFplVGdSZGthOXhhOWFGU0l0WlNXc3JkeVNTaGZ1UDgvSFpP?=
 =?utf-8?B?WjZLc0tzU2pSSThmT0d3K2E0Z29UNjZmWU5qTndmc3k4WU9NSkJkNUtsK3Jk?=
 =?utf-8?B?N0J4M1cwcGFwRU9WRFpHb05IK01SNUpLemY2SHY4Y283ZW1rL0JhenFDak5q?=
 =?utf-8?B?YjVuK2t2eXFmeGx0cnYzQnhIdXRTaGQyYjYrVmtTNHJrNkNTUDhnanNVRUpB?=
 =?utf-8?B?Z3oxYm4xeStUTGk1aHMxVHNtU2tobnBaQW16TFhhY2pxVmloQkFSVm9PVCt0?=
 =?utf-8?B?Sk5sZGJFZUlnVGZSWnJDb1IxN2xhU0ZVQlh0TzFZMHM5bFdVcXdWQXhJc3Qz?=
 =?utf-8?B?VWtIS0o0OS92K1RpbTcxSzhxRTdGaCtJR1Zoc1l4bUZnK0dKM0lRd3NnOENZ?=
 =?utf-8?B?R2drME5EMVh2bXVMekxmbVEvbWloV3lveDE3cy91c0FkcGhibC9Cc0JJQlBP?=
 =?utf-8?B?SUx3RXpyT0FzUW5BUDVXVnYzYW12OWFwNjhyKzMydW5MSHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlJWSsyODRRUVhkSFAwWHVVR3kxcFhrZlJXSyt6YlpOeFRyajZ6c0llMGRJ?=
 =?utf-8?B?ZTdxMHFBWjNxZU5FOVVYdCtsZ2tUSHlpS0NhZ0dTL2xFa3Bka3pZQkNvL3hY?=
 =?utf-8?B?NzYwTS82ZUdBc1k1T1FiUElEa2w4Y0REQXhuaEE3QkRZZlVObHlycmtSY1JN?=
 =?utf-8?B?VmlRR1k0aEpLTm41YldOYzhFQjhyUE1RQzVNS0dqQTZLMC9XVnd0aHZkMFJp?=
 =?utf-8?B?aytPN3FLbWlYS1pBUlIyNlRQZzZlaVpPeDlrOWdyOXIyYkc3aG5vaStyUTJ4?=
 =?utf-8?B?RXord25EMVVvY2U5NlE5ZEc3eWtscHcvaWpBbGluK1R3RTZ6ZVllU21MRUYw?=
 =?utf-8?B?czFQbDVtQXp6TTR3bzBIVVRPOVdYN2ZldGQ0UFF3aXFkM0dvNUdYL2FQanVp?=
 =?utf-8?B?SmlwSWVLQ0IzY1F2TlFsQ0FvcXpub3R1NTlwelV0Q01RWVpKQWNNWXRhdDdV?=
 =?utf-8?B?Um02V2FHSHgwbjI4ajdhOUxmZ1JXOE5aaGpzOFJmMWJCbVlmYVB5dGpmSnUx?=
 =?utf-8?B?U0ZBMkpTeXpONTZSOUhSVndFSW9YZVFiWHhEQ280NnpNbktDcGhJd0lCS0x0?=
 =?utf-8?B?ZFVhMmZDQVEwV1l2Z2JZVFJueTZmcDVaSzVWaEpseUhBZ2FKQU9BN2JvNyta?=
 =?utf-8?B?TjloVUxGSVRnb0tWNDNHN1JpdjB0SGpKcWJnSllsNnZGUlZvdy9PMlhYejB6?=
 =?utf-8?B?VEtDNHUvMjNQelJIQ0xOODY4aGFCWm84Q0hocVU3VndwdHJ2cTRwR290TGlm?=
 =?utf-8?B?cng5Zi92RUpMTUJPaVp5L2V6ZEgvek1QdWw2WnNWYUU5NjkzSkZqZlYyVjBu?=
 =?utf-8?B?cFV1M1lacG9zNVBoN09VdzlsTnVOUVErNHlkQUZVRGZGN0QvenFnM0FJZTNz?=
 =?utf-8?B?eVJaeU81RUxEeE1Ob2Q4blMxZlF6cVhjSVJmdlNYQ0xaNExTalZSU2NYZzA0?=
 =?utf-8?B?eVpZMDljcXQzNUR2SHNwMzIrYnFuR0N1di9YRkRUQUp3SEtGUllDazFmRVBm?=
 =?utf-8?B?R2tuUkMvcXhwS0UxMDViSk5tTXBwZm5DajdLY09xS05DVEl6dVBUdmxSeisx?=
 =?utf-8?B?QWxzc2NFVnlqVzNvVFJtUmVnL0NRUjNBTWpGNXBPbXp2SExoYmNOQ21NTzNX?=
 =?utf-8?B?ZE9rTVdmU0NHeFd0MFZFeThBSjFpVkRRd3ZBVDhEOVhldHE1UFNnUXRXYVl1?=
 =?utf-8?B?M2pDZzZFWm5JNWhyaXJ2R0JNSTRvVGlDcmhxbnBXWHl2TmE5dENxRE54cWF6?=
 =?utf-8?B?clg1Y1FkZ3c3dzZoK2RCR0kvK1BHRWttK0s5WHg0cnBlTkU0UXdoRk5Db3hT?=
 =?utf-8?B?aENPb1NDWFRwb05HOURuYVdyc1FYT2k4a0ZhN3JJQVpSWVZ4bW1TcjdZRmxJ?=
 =?utf-8?B?MWlYMk9jSHdSOGNqRkdGN3hiZXI2OTdNV3NQZytid1NCVklEcEM3TFR6NnFv?=
 =?utf-8?B?akxKQTAvdHZCMGpZV1RpT0p2ME1vaXN3bWlWcWZUVEF5WWE0NUVLMlVibmls?=
 =?utf-8?B?b3pnWnFmLzloWHhRZ2xPMi91UnI4Z1dwb1ZXTE5ERzhmN1E5K2Z2b3dQWnly?=
 =?utf-8?B?V3ZaRFdJRkJNSUxHWlRPekljRTBpYkhtTnZFZkw5eXpoQ1lVNVFhZGZSRWl0?=
 =?utf-8?B?S0N0U1NvVHlyckY1QmxNOThNVVVUOUFQMmh0Q0phdVFXWGExaDdzNTh3NTcw?=
 =?utf-8?B?Qk5qeko3Z0JQZ29TRldCeEZWa1lGaHRVdU1jWUlHcW9Va3VlRlA1dXRNMXo1?=
 =?utf-8?B?NG9EUjhJU3JyU3hPY3NVeXphSnZycVVidTdVb01hRVhFTDM2bC9EMkROYm5N?=
 =?utf-8?B?QVdtZXBaallaQ2dGaWpoQ3hXRDJ4ZUoxQkhOMFlITTY0WDM2bjZtTEZEQi9D?=
 =?utf-8?B?V0pEbDlieEtjTFNjNDFodjRHN0RNVERMT0xHYmpZS1ljOHQ3VFVrdnA3ZWg5?=
 =?utf-8?B?eE00eG9tZ0RpQU1UWmZZZzdiVFE0ZmdBZUtjUWZ1a1ZvcE5zZXQ5M1MzMnFF?=
 =?utf-8?B?dXVueExuZFlCc2pvMTFxUDBpQVFBRGZuUVh6MlE0WFhmTm5YN1Q4NVJ4RzdE?=
 =?utf-8?B?QU5pUklHaHgxdnRVM25FM25EdmpSaFJiZFVRMjJSNUNpMU1xV1grcTBtUTRP?=
 =?utf-8?Q?HxLHfp20TwfJiZ6iO73S4Xnyp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a94d34-4a29-4f6c-fac1-08dcd856f560
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:37.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REnuzoyecjyZHw+WyHRsPFDi+GTWcgArB3JQAk0OvJRaqN1hAJg+7XL28Qd69Vw8csycIiD6z+9/udwy7ZB6zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

disable_cpu_nodes could be reused by i.MX9, so move disable_cpu_nodes
out from mach-imx/imx8m/soc.c to mach-imx/fdt.c and update
disable_cpu_nodes to make it easy to support different socs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  2 +
 arch/arm/mach-imx/Makefile                |  1 +
 arch/arm/mach-imx/fdt.c                   | 87 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/soc.c             | 99 ++++---------------------------
 4 files changed, 103 insertions(+), 86 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 31ae179b211..d93e095e191 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -275,4 +275,6 @@ void enable_ca7_smp(void);
 
 enum boot_device get_boot_device(void);
 
+int disable_cpu_nodes(void *blob, const char * const *nodes_path,
+		      u32 num_disabled_cores, u32 max_cores);
 #endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5262dca4ffd..47e2cb8d943 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,6 +12,7 @@ endif
 ifeq ($(SOC),$(filter $(SOC),imx8m))
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
+obj-y += fdt.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 obj-$(CONFIG_FEC_MXC) += mac.o
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
new file mode 100644
index 00000000000..df6fbf51dba
--- /dev/null
+++ b/arch/arm/mach-imx/fdt.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <errno.h>
+#include <fdtdec.h>
+#include <malloc.h>
+#include <asm/arch/sys_proto.h>
+
+static void disable_thermal_cpu_nodes(void *blob, u32 num_disabled_cores, u32 max_cores)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/cpu-thermal/cooling-maps/map0"
+	};
+
+	int nodeoff, cnt, i, ret, j;
+	u32 num_le32 = max_cores * 3;
+	u32 *cooling_dev = (u32 *)malloc(num_le32 * sizeof(__le32));
+
+	if (!cooling_dev) {
+		printf("failed to alloc cooling dev\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		nodeoff = fdt_path_offset(blob, thermal_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device",
+						 cooling_dev, num_le32);
+		if (cnt < 0)
+			continue;
+
+		if (cnt != num_le32)
+			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
+
+		for (j = 0; j < cnt; j++)
+			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+				  sizeof(__le32) * (num_le32 - num_disabled_cores * 3));
+		if (ret < 0) {
+			printf("Warning: %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+			continue;
+		}
+
+		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+	}
+
+	free(cooling_dev);
+}
+
+int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabled_cores,
+		      u32 max_cores)
+{
+	u32 i = 0;
+	int rc;
+	int nodeoff;
+
+	if (max_cores == 0 || (num_disabled_cores > (max_cores - 1)))
+		return -EINVAL;
+
+	i = max_cores - num_disabled_cores;
+
+	for (; i < max_cores; i++) {
+		nodeoff = fdt_path_offset(blob, nodes_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		debug("Found %s node\n", nodes_path[i]);
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0) {
+			printf("Unable to delete node %s, err=%s\n",
+			       nodes_path[i], fdt_strerror(rc));
+		} else {
+			printf("Delete node %s\n", nodes_path[i]);
+		}
+	}
+
+	disable_thermal_cpu_nodes(blob, num_disabled_cores, max_cores);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 3a582cb43b5..b8a026fb840 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1184,79 +1184,6 @@ int disable_dsp_nodes(void *blob)
 	return disable_fdt_nodes(blob, nodes_path_8mp, ARRAY_SIZE(nodes_path_8mp));
 }
 
-static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const thermal_path[] = {
-		"/thermal-zones/cpu-thermal/cooling-maps/map0"
-	};
-
-	int nodeoff, cnt, i, ret, j;
-	u32 cooling_dev[12];
-
-	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
-		nodeoff = fdt_path_offset(blob, thermal_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device", cooling_dev, 12);
-		if (cnt < 0)
-			continue;
-
-		if (cnt != 12)
-			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
-
-		for (j = 0; j < cnt; j++)
-			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
-
-		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
-				  sizeof(u32) * (12 - disabled_cores * 3));
-		if (ret < 0) {
-			printf("Warning: %s, cooling-device setprop failed %d\n",
-			       thermal_path[i], ret);
-			continue;
-		}
-
-		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
-	}
-}
-
-static int disable_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const nodes_path[] = {
-		"/cpus/cpu@1",
-		"/cpus/cpu@2",
-		"/cpus/cpu@3",
-	};
-	u32 i = 0;
-	int rc;
-	int nodeoff;
-
-	if (disabled_cores > 3)
-		return -EINVAL;
-
-	i = 3 - disabled_cores;
-
-	for (; i < 3; i++) {
-		nodeoff = fdt_path_offset(blob, nodes_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		debug("Found %s node\n", nodes_path[i]);
-
-		rc = fdt_del_node(blob, nodeoff);
-		if (rc < 0) {
-			printf("Unable to delete node %s, err=%s\n",
-			       nodes_path[i], fdt_strerror(rc));
-		} else {
-			printf("Delete node %s\n", nodes_path[i]);
-		}
-	}
-
-	disable_thermal_cpu_nodes(blob, disabled_cores);
-
-	return 0;
-}
-
 static int cleanup_nodes_for_efi(void *blob)
 {
 	static const char * const path[][2] = {
@@ -1408,6 +1335,13 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	static const char * const nodes_path[] = {
+		"/cpus/cpu@0",
+		"/cpus/cpu@1",
+		"/cpus/cpu@2",
+		"/cpus/cpu@3",
+	};
+
 #ifdef CONFIG_IMX8MQ
 	int i = 0;
 	int rc;
@@ -1451,13 +1385,6 @@ usb_modify_speed:
 
 	/* Disable the CPU idle for A0 chip since the HW does not support it */
 	if (is_soc_rev(CHIP_REV_1_0)) {
-		static const char * const nodes_path[] = {
-			"/cpus/cpu@0",
-			"/cpus/cpu@1",
-			"/cpus/cpu@2",
-			"/cpus/cpu@3",
-		};
-
 		for (i = 0; i < ARRAY_SIZE(nodes_path); i++) {
 			nodeoff = fdt_path_offset(blob, nodes_path[i]);
 			if (nodeoff < 0)
@@ -1489,16 +1416,16 @@ usb_modify_speed:
 	}
 
 	if (is_imx8md())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 
 #elif defined(CONFIG_IMX8MM)
 	if (is_imx8mml() || is_imx8mmdl() ||  is_imx8mmsl())
 		disable_vpu_nodes(blob);
 
 	if (is_imx8mmd() || is_imx8mmdl())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 	else if (is_imx8mms() || is_imx8mmsl())
-		disable_cpu_nodes(blob, 3);
+		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
 #elif defined(CONFIG_IMX8MN)
 	if (is_imx8mnl() || is_imx8mndl() ||  is_imx8mnsl())
@@ -1515,9 +1442,9 @@ usb_modify_speed:
 #endif
 
 	if (is_imx8mnd() || is_imx8mndl() || is_imx8mnud())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 	else if (is_imx8mns() || is_imx8mnsl() || is_imx8mnus())
-		disable_cpu_nodes(blob, 3);
+		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
 #elif defined(CONFIG_IMX8MP)
 	if (is_imx8mpul()) {
@@ -1544,7 +1471,7 @@ usb_modify_speed:
 		disable_dsp_nodes(blob);
 
 	if (is_imx8mpd())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 #endif
 
 	cleanup_nodes_for_efi(blob);

-- 
2.35.3


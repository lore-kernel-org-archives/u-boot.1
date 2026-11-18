Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B1606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MNJLOlgb;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U1s6DDD7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46F7F810A2;
	Wed, 18 Nov 2026 05:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9wSzKVswSbn; Wed, 18 Nov 2026 05:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A0358108C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794979000;
	b=Ae+ZfgYgwqff98AFUYPbMQX2hLBko53wq7bEAnPfZFeA1QgpmOusxrDGBNIABsSLh6oG
	 Wq7j0lfLcLqJACvqEEkZW1z6BVEM053SCOd0P0Unl9o2hnxzbLBCVItxXVlTE0rCCgWBD
	 mZMDENl6HSpFpK+X0cyyyirVhkcsSglJbLMgojBTSFQiMjgpJMa7VJoKBe1n53WZYkJbL
	 I2x5LBt4MJqKiwc18F2vhnIhEaHMwOu592DAzRwKBvq1+CqlImgYNOzh0FpvSIC1wuiuJ
	 /XnwI7qCWtGBflrGU6BHMBIUQvJegV1lJBba7geY4FOicZqGo4Wbjt019liDJQ/MUdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794979000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ps1LH74mISkicV8GQ4lgq2Ah876HA5M8HkwvFUrfli4=;
	b=nGRrqcjddWsMNVYMSFXMo5v9tzLen/S1eASwNcU2lXdVlXl6MXUMxUTHHHiEqW1indg1
	 V1CNUPilsP4N3mghJ1xklXaXKpV+0HOPYW5eiCyNUMzOefO0D53g4QbvKkHrbmMTsWcba
	 H6v0GnOTVnAiU2UAebOJIFLf43BQxmHE3y0rr9kLOvd1Vk8B+9vS5y0zyIYrSbyBOBlLb
	 24IRlRV21m0sRxNEaVPvzVam4aNQxo2iY4r6Gg/tztdwTVroN/UDOXecj+dic8pg/QQF2
	 31VAf91vh3tFFlBVZ8skBSOnwPeEQKZnukBjQ6IBZ+LtyP4kv5Z/UhH+ez8a+FHOyBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794979000;
	bh=Ps1LH74mISkicV8GQ4lgq2Ah876HA5M8HkwvFUrfli4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNJLOlgbYz02nDk7ouMoKdrGjyIj3D5sVZh7GmHOpdtQKWUP0ZrnYkqnMqlWYUKDY
	 0imw8aFHDIwCiHW3cSA76FMUU29t5BzhTAKtTxLDz/SWGOmtqULis3yVkR+whUmaFn
	 3ljB8tBjg0YZkrOUbD8I8L7q+xkWgT2IRCzOKDMA4qQg3REPZYoL0nMnrOHMtz28uX
	 kiUizcom/a7fCNiK0zcOiOaah0hV0pMbegejYo/d7mE3ztGDJ44gNgVRct9SvFlqjm
	 +UtM1dXAFMZwAx2585fj9J4NOOCJ74Pnc9Qs6STCohdO6haoJ5/7MAeiQS87PGqW39
	 NHY4kGQInuiLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A0358108C;
	Wed, 18 Nov 2026 05:16:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4B93A32
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BADC06077B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmqMuHiFFh-f for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A43DF60743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U1s6DDD7
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A43DF60743
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps1LH74mISkicV8GQ4lgq2Ah876HA5M8HkwvFUrfli4=;
 b=U1s6DDD7XAvmxsC3oLadC8ZypSrLjkFmDXQCrseuRJg5BrRKEh9NSWtSVQ+HwB133pUZhZdwwf2byvT5weB/aawoZ6votgHOf3g9iOuEBDnwiA0duPDbFPNICav5vJXsbyuT+xstFKDHaMhQUFP17b86jOtyRp7TteMmEZy7JSwnedHcVn/v49BP3L9qpFtS5HitMHQE9JtUmZY9SeBd19QCL0bDWdwFg314VmK1cB+e2QYtPIcQWNGQq3X8kvg6rOq9fgjWBTgZoev+kvwWk1d0oAICUc/GcyVUkAftJUkJQrj1qjZ8TdWl9EJt5L2JQ2ArnFvfBeg+jJRrp8Ehcg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:16:34 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 05:16:34 +0000
Date: Wed, 18 Nov 2026 13:12:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] firmware: scmi: Constify driver ops
Message-ID: <av0zzVuK3_zbmMky@nxa18884-linux-1.ap.freescale.net>
References: <20261116173636.3487926-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116173636.3487926-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: bd104181-db43-470c-4f7f-08df45331d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: eAfCoqsvXV/pJUIT+AA0RXdrs/QhRUXLnzbhz/u9J9fMiBkwNQbE7GlZCx+rBP/lFIe0duQ7qI+V/3rdMCM43LUMXrBvQK/JkfZ7xXrURUn1i7EMwvHngvwZErrcFCHroRyv5S0HnmcTY+3N/BWPZvB+daz5AUGF2a0JRjkgTyQ4uaQg+MGOYPN+i/FJooGRlI2On23LXmPX9MNSfOxqupC9P4yyM7ygFBmkS7rXY/Dea6OG3M619o548kdrihPL0Wf1e8bzskSYrpd2wBgZ3l2A9K2GUiBMplN0ip27Jhmjlxq8FKPSwjJGXzLwMi1/M6aCZM4MN8dVpbz9qkYEfoYdNQV7u1xH+aGSvhywcqrmlKU3l+o8Ff3k1/HotkMEJPKvE466aXa2U5TwWWCO1VpXtqJOFMjBryVdrrYt9aVa8YJKvK5TZNwUdkEwPAv70J7kwWENinZHwdKvDtRd6KzExNjoOspJJLEtW/MJmt6w4bMZMs4F9mbfTv3eFieLcWkjgieVeW3v5l6nSLo7TREAjjQrSWe/co6bKz42oWUWw2ASYgNsU13T8TkkEhblOz5WVaXvmGjh2AzP5G7yASGToaD1AK8x5lXE9mtdMbZmFNXLZJzy+W2EuLFv21I6edaUnnsjgWynTAFvPwGfKlqSsZKX7Mr15GQsEkN3oyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/UjAL7DNoEg5kGaJwZezbVcpXqTWH3u4LGI8so2XvjZ0GOa/dQtemLDfRos?=
 =?us-ascii?Q?TXXyjeFJBpKULvos5pw60CH5tT+OGDx2chaVyP24s8NRyVVdXU1tRypxuuck?=
 =?us-ascii?Q?5gx6YWi1UiEzDrdsQPUalKF6SZN6ISOsHpvmOKFLa7Vuf3QY9MzM7KLDEJPO?=
 =?us-ascii?Q?ZQvrXlZyh5YVtujD/ATrXjTHNfVOOEUA9QB6Oly/Wu7rXkAVU61kNZQC5tr6?=
 =?us-ascii?Q?W7SyqM7jR3H2fWMO3V9TA3T+VtTElTq46qLJvxGMUh0P3vWJ/0odYQHVBNYf?=
 =?us-ascii?Q?PAqV4NxlCiFK83JH/jrdX0Sy36R11Eu7wkqhBuCvWhnm7+toOSBOTSpcvwg5?=
 =?us-ascii?Q?9118ADlrJUkZtjdBRPSli3WTk/UwofEUQ/h9QaROZghjBZETGERwvwRkuBm/?=
 =?us-ascii?Q?XFqN7/os8wh3TMVTQBit5191XFkqW4eU8XKIkE5GeKABBZ4pxJilvkMwylxY?=
 =?us-ascii?Q?MdOlaX1NRS6A1thYTJaOHyYyWDujaYRdRLmu1TtlloJ34z8tMckFoBBy8auz?=
 =?us-ascii?Q?Cb+CW2ImRi3q61LjagG9rsUgNg1hzgXPKAXQrm7qzzYOgYhM20LfjUQlUH2e?=
 =?us-ascii?Q?p/CyBlZs/zMK1GHSmMeNvea5ZzzjsrGPQsZ+VpFtAJJEsJfwHkIWRWnPT6np?=
 =?us-ascii?Q?jt34yFWYlgPgw6aP5GIgVvwTK7xCnt0ey1OX/hWoBJwND5ZStMbILXkIj3i+?=
 =?us-ascii?Q?rNvEfLoW91F8BQfVH/5LIhmVmSjT2Wfj85efv64s/RnMozjsSmBPlqQwjnVW?=
 =?us-ascii?Q?6AYeEchFyYAhOVOvcj4i/HY9UtZRTklhQvMgJ+qVXYBv6PCFid5DD0vwFvNT?=
 =?us-ascii?Q?bM87qYgOw4pLhiPoQOs+UUtzX7Ov6xEXMiRV1gIVB6m2RMMqESqtus3SXz5a?=
 =?us-ascii?Q?YS2LJ74aS5kYqi2gQGJ4CwbVF3mucS+vln3jvDsJoWwGSnKTYC2/mn8S6svp?=
 =?us-ascii?Q?Y6crSgAC0C0yZOpS6GqhUGMzVlv2CIpbWfNSv+DvkxhUz6BCR1aJu4NnlBHB?=
 =?us-ascii?Q?AhtB9/5cLExkqrKaHhIH0paeNBteb5E3pQSpWiybrdGdahBbei2m+GnfVO0z?=
 =?us-ascii?Q?ZpJcNmzS9bRLcfsiKPybhxLcU/RX3VmLkneRMjhnhCZdf3zYozqpIv91QkwD?=
 =?us-ascii?Q?ZkVK1uQbI053r0DZO4tgiGtRzjfn7StYlL48l+KcRK4PZYFKXhv5DvdWsvbi?=
 =?us-ascii?Q?DRdxGUPUAoc+U71sAcTv6e02y2NUFGU4nC1669fR3RIxne6WSmnR34NxIEgq?=
 =?us-ascii?Q?K/aApJLDHc8SxxyW+ua9aiLG5gECYPRrfaAuimp9M7BjyfFgtMIJdWGNHlK2?=
 =?us-ascii?Q?BlNGiRHTvHDY/uc6xNdwvd9RMXU30w/Vha0i4v/qV9T+HQB2UbJIyZ4+yJ/3?=
 =?us-ascii?Q?dFxK/oAKdWVqwPmxg/6o/mxMGeLL/FuwjvWXTnN5Q71ep8mcXj0fcy477y1M?=
 =?us-ascii?Q?rzBLXHC38Iy23RSKJ88Cc/ZC488tWvUcsGvTOZF7rWmJr8ZuvaTxGs6lF5RP?=
 =?us-ascii?Q?+Vm0nWH419nQpVpTvMUeygSch2AEo4Ma47quQZ5we6g1iWHcY1Yk4oO8PdE6?=
 =?us-ascii?Q?pGID3HgwnMz0CHzn8wguS5J35hkwUEmFIVW7ZGNHpJLyzPKu263BCIW+/+oV?=
 =?us-ascii?Q?NYhk28rVbO9m5P2hou+EjeaRzyTtiBgJtM1XMNwEVGqQr3hpYkCHNEVd3uz/?=
 =?us-ascii?Q?gF3gbz9Uy0dyz0F/6zsXhQjcaZAQcGik7uPltJ0CxOd9K+PYtncbvRNV09Yy?=
 =?us-ascii?Q?xBYp1L++a8/dq6WVKQXV7JBSFMc/BP5jkQr+VTYjIvgfwanGk0ng?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd104181-db43-470c-4f7f-08df45331d3b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:16:34.7520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKKSrvgYmf5Ud+y6LPN7UIhbh6ktPC6yfdNQqK4MdTH27oqW8UVZ+6Dhk/yjIhGPeqPszfELewKZ290ftAh3WDVagRwG4M9g984yZxAMTt9ikDmhj47H/tc42EGdFKWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:36:30PM +0100, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Peng Fan <peng.fan@nxp.com>

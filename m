Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A831606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SmcAjKGN;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=qCoPLwhh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4610081450;
	Wed, 11 Nov 2026 13:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YcBFfcgwa_T; Wed, 11 Nov 2026 13:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82074812DF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403875;
	b=IeWUpRtrBCci2E84DqAGLAJIBAB1Jr6XIcbDoMDrfSUNyXozEcPNsTAdWY/M7GJz7SjM
	 OVkDoLqClQXLWwwy6Xoqg0pO0p7goO3vX4+kabFqpNzFwF6jaWY+nZj4cIU8F71aYGtbA
	 e3hd9yWReOdIWoCYhUt7ICU4gBrVUoTJoQuJW4EBAA6hiWaH/BV/ffvmxdDw8tIIRoyVU
	 RfAi7s0MhxpHXgKtG34KwxtuIiiozjsS/vScA67SEIiqj8rPuXtJEc9HzSU6r5wK+CrVd
	 mQ+hTb1nHbILrEt/hknVZgcpLEXBwODup4qLtORf2P6igtOT2FyP/2KXQVAiFk8Vzrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=ztWVysdEgJFTZziKC+BRsOHQF1eqwPTYOVE7NCDr2iA=;
	b=PFvBaXUWnBVwXi/BFHdLQFASUkbh7yUhHdb96jyoXUg812w43ixLEMysofEahbfF9maM
	 dyC1OZNzVZJGu+4HeDrcUbtSQyFHWlmLcYMlqIk29n84217+4RVGPmyEdFmvrC/HNPpsf
	 2Ev7CcSC7TcIpwFe+4qVO4Qiga6F3qQXg3wh/wNlEyNKO49ipqN7fL+zdabQoE/pjsg4B
	 J0BcXRmAINwdZaEG6A72rDVw2C2DAl6UwDfbksgO1kHTtCh66oIoqIi7e9PvJMW2vNnah
	 /Zw4L7DY5wkAgJIbwXMBuffrR+ubi5Ta/oo7cx/Bk9Azpk8f/TCpBKT7CBrvr7aGaVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403875;
	bh=ztWVysdEgJFTZziKC+BRsOHQF1eqwPTYOVE7NCDr2iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SmcAjKGNMnjAD0Gz6maeFa5QEas/WYHLDTZ5UxuEDciqN1rUWGpTrQUUGhJQG2FuX
	 Ff1kWv/Je5MjLl41/sApHnEmGVGEuUBDsUo91sD+pfWg53y05O4Me/mNv3mGagSFGN
	 Mm3cmYTm+/8kCx0EcX+FPYWBASnrNeC8rJ5KYuqR8GlD17It86NxgcvHro8596ZpuR
	 BELz2p6BXVdJrhoZ+fFHELePnj1gRvbDda/OcNpg/Yq0PJbQwmo4G2Z8/e+iQDqPdx
	 C2EdcvogAVbQUCkVh5yBL2GC/Oa8Fnub9Q/WGEZRGA4UYbXS1QS2ye/TZ1BpIR7s1H
	 YetBGbEiDnCSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82074812DF;
	Wed, 11 Nov 2026 13:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E58D2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 901A960D74
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9MJLAu0KC1i4 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8EDA60D66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=qCoPLwhh
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8EDA60D66
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztWVysdEgJFTZziKC+BRsOHQF1eqwPTYOVE7NCDr2iA=;
 b=qCoPLwhh7unEpA0x69VIlXvrJt7Z7wZcYAueKwjeGmv20RPgT27v2xJtajOTHHiPBC/utuZ4Z/cUaO79hmNb2nBHFvcIS3X72SCFvtgQpO2kUNI8L/HJpe66HkbMxN/qWsAEBoHR9HeWCG9jFwud68ST6RummrdYAKcxPcEV+90hUX1l5Te2ecpmggBftBFozEcIjHc/Z4sr51XISShZ4nxUAR20siUuZplHbEkJN8eBfTo2BFjLl9WCLd0vRSRHJb/VLjQ259yWqCSNxPdYjRwJgfer+H2gi5ZcJWJxT23I2Cj9UDwJ4mhHa2HlEYO6AmT6FKs6Y80AzAKC1WRoPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GV2PR10MB7030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:31:07 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:31:07 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 5/5] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
Date: Wed, 11 Nov 2026 14:30:29 +0100
Message-ID: <20261111133029.2538132-6-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
References: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|GV2PR10MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d7823b-2201-4c59-a865-08df3ff80a5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|11063799006|261021121427099003|56012099006|261009223027099003|261022075727099003|261022115727099003|261021135927099003|261102123227099003|55112099003|22082099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: TcU9CSgOuUi8ySRBtIIdc5LOXdo6cF68yW9B7E+/FjYaOnfg4RfqEQXIjoV3Ny1yzUa6zkoiE05ymNbcIorEiMQ9057w7vwbG6Bfq9Pprf+6hKGUuCBR2NhtN1e/jVN5/qeI/oY472IRvxN7e8bKGH76mbtcAYPX3GHs7Lyj471tC8ZWu4CzvYydH0lkOuF6Myk/9nHq7b14Gxyj4EJYG4BibquT2MDNzk9khrWlvT8UwEvTv9yR0o6nuI8OvOIS2SfyDQ9OPQgc2FHFzDYkHxDxf6YtrNa/uNgS85p5rPdKtOE2hTxP+K/E4ymbzWFkem2wC7l6UdaoDs4JcREvGb5j2LD6G1o75jlS32hEinNBYe0YCfLYVFaWRYRl2L27MnAVDoLKR+b5NecS/RasZfSYx0RZvl66sNYyS6UncBknBJ3wDZ045X+4bq0JUqqoMXxYyXK5Ow9iK7wHy41Z4m74xU8cT0rQgwKIWH7e0nMQ4Npxtt56L1VqtTVAkS/Lxnsbnpr1Gd8DfQDSu5lpSY75dbrzMUP92DWvWfkbntICEMq8KkvUDCRDlm004V2VXY/n3N3/SkGQeC9N4B0xWrcAKH2qF2nywFakxKWy3SE3wsH4zTRGQe8bCwW2YTY9SU/lClkTl5MUf/6/I3+bmicOMIdPrV/WX46hMl69v+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261022075727099003)(261022115727099003)(261021135927099003)(261102123227099003)(55112099003)(22082099003)(18002099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zeWo7n6CCsUg6HesOY4YIoYPepxf7Ym0TbhHKKaFXEPoexOwUc9revcV8n7P?=
 =?us-ascii?Q?7K/dfHXkI0Bc34Lrze5pW+8CzkeSCRxz53GXqoux0YfI9+fTuPnmIY8KDjJh?=
 =?us-ascii?Q?HFUjFWRh8+yy7Owdbk8d38A5940141zQYkgiU62Mj31WgCGlhLPTzEWpkYha?=
 =?us-ascii?Q?MZQ4NuxLoChVMd3vEW0wB8gh2Qj9zlRyDd5O9kCtLmDZ85Rij0P/RDOsAA+d?=
 =?us-ascii?Q?4/RXuhw1zcEIrMjFRU3Wd5XZAn9sVulFBHGzVcsd4RRXceg4p+fUQf8YaW+e?=
 =?us-ascii?Q?vnH5AkYoEsz4c8oi1AlDdGDtXTl1rFgV5e6icm3F8PyXkg0egVSS7S5r62OJ?=
 =?us-ascii?Q?8QDiH11Vk+p8LLFKVmb6VhOFPet19a6blGhay9wG/Nb33czw0y6pgQRPwQ5v?=
 =?us-ascii?Q?N4srhKq1++SIsLSxZfWdQL0rNa7Czk0PcLjs6ydMt2QucaxtumHZA1uQG8gX?=
 =?us-ascii?Q?Ne7ZpOI2+QzXdcYK12s8Fj8eCCkwN9D5fO8zl6DioFWdM5eGlbXu5FeQYKs7?=
 =?us-ascii?Q?0LMQQzCheb+J9xnQ1vhPY9E83aAOlgTgwwzFmyvpFJLiLdktIrNOQR9sDoIm?=
 =?us-ascii?Q?wCd9oScbB/vispM1THPM4xASmH1l/q/m62p/rVhSlnc0TAgypTtWVbbi31Cw?=
 =?us-ascii?Q?kFzi0X99MEiTbUTRTPVbdyXh9pDaQfoPt2Q+1ECYehwgqPbu7OvdEh4Tocdn?=
 =?us-ascii?Q?mslxx0cdbn3pOY9yfa02FV7glqPbIo9o7y6EsyODWHVZIY2sUnl/eHOYoevC?=
 =?us-ascii?Q?RHRbzUSmus67/5NHN612IkGkOV4f6sKHGB/XgoIJKyjz2u/qqoMG/jjYFI4p?=
 =?us-ascii?Q?T2HSUq7z8k6mKhEC66WlTKd9nsti/SEZFFegX8k2DjMNAOVXsW3UkZIdw1y2?=
 =?us-ascii?Q?IDu5w3BXPHSJHLJwmXUqqnjar4sHcXKMLkyex+vZNmZQJWJ88ws6mc+GthAQ?=
 =?us-ascii?Q?VqK+N9GXZJgM4jEvLflKjauxnO4CTQ7Xarud+u5ZmgHw9FiUSbaQKRn0WiEP?=
 =?us-ascii?Q?qJFEsgX6/ZqciO6NB72DNsI26+FT+BwkamdwzUwLCajJeJY8lLTHRtS6GnUh?=
 =?us-ascii?Q?UvaKdCbYAxnOZR1jje2ZFuNpkmkjEzlw+b4UF68yh7y1eldtVYu3PLGEARak?=
 =?us-ascii?Q?wHXFBz4pRHjLsx1NxRCpuoCYLrGalOLdQkK10UDPyROsbyYBoJzPzRykn1qa?=
 =?us-ascii?Q?xe6vbzXCBhvH1TgoAvlvhqd6Qx3m+uTb/oWPa52Uc3w3+ydW75npO+hxxksd?=
 =?us-ascii?Q?+XADEqibz5zSz3wCogu8cpQ2iifQ9R8hRAmxwQ70db2B4V9/Qgb0EBFdVW3Z?=
 =?us-ascii?Q?j7gcD4M5egezVteguZ8cDVEjbl1pKDul00PJW1xOpbhBvp2p4qbrP207NNj9?=
 =?us-ascii?Q?7XrPcoo9OuREJdu/eSju0MB4YHD3jMMEMbBwS4jZZFwGWiQKwq+14Qjl9TFq?=
 =?us-ascii?Q?NFRwysxADWdKFkILg3VMy1Dc/pIlJYTWwrBoYtZpiHD866t5rcznf1ux+W41?=
 =?us-ascii?Q?kw0sMa9gEgUAg9U2uj7acbPnWz1YJRr7a1KOVYwrdzjDKIQDoeRdhfOZVw0r?=
 =?us-ascii?Q?Rb9FXwWdStGQ37Hh7xuL46ILOR4MMmqsK+qp/H5dl7FbHbgpP1S6BugAUR2k?=
 =?us-ascii?Q?T1xAr5IXXo3hqEEdTxL1PQlrxzx7nLLHhLUgwEc2yFQFrwztQM4HsECrDGgk?=
 =?us-ascii?Q?9SMlWc9l3tvyU+hxYHzPBSSFZ9IhRvzZiS8v/Vs5WjJhl8cj1Jg0okIRyypj?=
 =?us-ascii?Q?wdDgr5Hdb+ymyHBXdbAFn5/F/CxWAnY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d7823b-2201-4c59-a865-08df3ff80a5a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:31:07.0863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBQ6SZvzr8qT86trGUV4OW1GWb4OdIlhlztLxjfbB6EQFtjZ6rB24I57A5ptZZAeeLWstt+cFeFmWjP9xJiQgMvBL9LQdrq6JgVbss3Rm3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7030
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let users know that the protocol exists and how to disable it.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:

- describe the end value of the timestamp counter
- add note regarding CONFIG_HAS_BOARD_SIZE_LIMIT

 doc/develop/uefi/uefi.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..e3b671b35a6 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -1015,6 +1015,21 @@ So our final format of the FilePathList[] is::
 
     Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
 
+Timestamp protocol
+~~~~~~~~~~~~~~~~~~
+
+The EFI_TIMESTAMP_PROTOCOL gives UEFI applications access to a monotonic
+timestamp counter, e.g. for performance measurements. It requires
+CONFIG_TIMER and is enabled by default unless the board has a size limit
+(CONFIG_HAS_BOARD_SIZE_LIMIT). It can be disabled with::
+
+    CONFIG_EFI_TIMESTAMP_PROTOCOL=n
+
+GetTimestamp() returns U-Boot's tick counter (get_ticks()). GetProperties()
+reports the tick frequency (get_tbclk()) and the end value of the counter
+(get_ticks_end_value()), i.e. the last value before it wraps to zero.
+Applications must handle the wraparound themselves when computing intervals.
+
 Links
 -----
 
-- 
2.55.0


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF8606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ET5hLyP2;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=vLA9KloQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AA4A60D50;
	Wed, 11 Nov 2026 13:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3Ml5Ho0KORu; Wed, 11 Nov 2026 13:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC99D608A0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403869;
	b=OECIDskBPe96ZYqQnfkZNOnOIIqextu7EndZXvuURX5+uZdXecJ4r+fMdTKd9rhdH/Jp
	 DXWzamsA/qLxRVXl6wr84HBlrzcioL3Eb1YDsS4ZzLw1/knV74jOSdUcnzzmpPPC4cB4Y
	 EJDW0JfGE4BteYYMNTbQX5i5Bakkj+dVIPIUESQ8pr0ckuiagvhmEkCSYHuJeQVxTAOp0
	 tTCjHRbHtmK2Hn9XvTaLMk6SYLtrOAX+RSACpjMRJucQdPnsEAzm1NHrocr+Hs6+h8Dqi
	 aCOdnDoy+6htaQH9iXKD1Hn+0wxamL7C0WW3O0flbmDIA/rws7A4CTvVXSPHIPwcwpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403869;
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
	bh=iPpgdbHi6yWiXTV2V5Qp2GlD/f2lj29/dMtBqQ0cDR8=;
	b=speXHCWa5mEVZgpGM8lLsvCJjI46Cnyw4dBVVDtbsgohExkCnTCbIpIHUa2pfT61yeVd
	 sY/CSgsYebfPrWSDeEILIhj55letIrZahfbPawfzf3XwNIlDIud9sooz35BZ3q2EtrgdK
	 +oPhdG7Io2IaC2dTJDJaj1HczgDIrH8NfqlVztb9zaOYjIxXzIP/tk0khKg8Lp6wDXvXF
	 NtYEEzj4G3xoPkbn1LNutmiwdiNOc2kqFZKT0kYK1X0CtT3EKX/5/eT8dj8l56gtXDwgv
	 C5evIx2dYNzwhE6+rwkO5Yb4Am6VppBbyJ+kVJg++KpvOa79zx+LW8TvHR1xjqZUUZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=vLA9KloQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403869;
	bh=iPpgdbHi6yWiXTV2V5Qp2GlD/f2lj29/dMtBqQ0cDR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ET5hLyP2QGxrGJ7TciWSzimxeUV0RWrrnE82wWsq42KzSlCQyhUlKAH8KoHkDCm/4
	 e48oqBFtWYR4Plyp+t7JcdMy6XpbL75E8yLWSWb5P0S1xBVB08kToDu/949Ygx/9u0
	 a0QwD/ZxpdsOyZ5QvPCxrGhFhJekdLCIbbt7OuhINIIALyMrecLKQxyZjg09O6OhJX
	 CujQ5RhviJhAHWaZu6r2KcJmuaFfxwM6m9xNKSM7DCowkZUuGfdtWhNCjFjiNMEEcI
	 1EcGPP8GDfKTds0oWxbrpZZzezfKsTRhxUKVTGFhaZgmdyiCxco86pReTIkGB7PKcw
	 U52VQQQ8Zzv0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC99D608A0;
	Wed, 11 Nov 2026 13:31:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC800E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE2EE608A0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZfQ0RM7XHKhc for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88A2560893
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=vLA9KloQ
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88A2560893
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPpgdbHi6yWiXTV2V5Qp2GlD/f2lj29/dMtBqQ0cDR8=;
 b=vLA9KloQoakP0pdZuMwsuCqzSKa383sf2fK+bzTnOCyUut3YxTfd9+jFHFUAvXEUP5AILXaDOK3zlZhd30/ov/RneQqJ9CAERC2Nzw0gqH7HPy2QHJWKFBzOaz8RX47cAPEwR19tbGPCteChT/Y4p0FoQcoRe7wOKoOz+RCipDX8cBFwPMKsbJAdqkcFmxWsLxlXsiMOsLt5LXAgVZWoGZ5Mbvm9/5oW0QXKC74Jkl07emG03ntkTLlXb49qUEyPm04fTsqv5yp5ZjHGc2x5Vn6FiH0jpKa5MkkaK1JYsfZTxzXO0uqsA9rREm5mfiaCY9IcPSEFI/mwJChvYMkzAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GV2PR10MB7030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:31:03 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:31:03 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 4/5] efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
Date: Wed, 11 Nov 2026 14:30:28 +0100
Message-ID: <20261111133029.2538132-5-felix.moessbauer@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ef48c49-ba25-425c-61eb-08df3ff807da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|11063799006|261021121427099003|261028144727099003|56012099006|261026140227099003|261009223027099003|261021123027099003|261022075727099003|261022115727099003|261022105027099003|261102123227099003|55112099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6fs8B4ZS9QhUwesG0opElVLEKONPFnzApnPiBvCt3uI7u11w+ZIu7/G7uE8vBDbDb2CNP9IJfwUJsIqCXsUUW6Ja+5Z45dwMtQdlrhhZ7ZD9YMBYEbrSFrj8fXTV7GtMIktgsc6Z6bHIp6Gn/SAkXtY+al7eCgTRsF7B8JYLo8SfUS78Y+5BP0oR8P6pQLqAwNMZGX4ADIcEPjDJHLPeEfAXskKmowQ1hdJo2AcWj6s6LGSKiNQ4lTit+B5E+3AzANseWTWXS87aBm3i3GTY/W/Yg3yedNQRrgTc+XJ+4GeDdcg+8aQW1g0oB2bhultQsQY2JeIqXoBJVrH5Z3Ble483bbakFvuFBXz2YVNjNRrzwH9iQ4Bp9VV50pcgGM/P6hMY8kokTWaiEH6luwXjy4ZNw48RqJ04VPrl3vB6OwzfBfM8iL9s5L6tvHQC2NayDA0kBquJvb9g7Hlw8kD0usteQIbAg//1N8L8KAywlJsRAEAcuwU3kCS8gaSsfzncRrIFevT8qX1Tuu2xRG4Du0wzwsiUhcI0S2LsNCEFi3ZaJbEHNvdX2H2IRcJSQ8eLeArzCW3SrrSZwFTAJ7M1jxOi3g3PH4W0aiEgRgGoP5hl72HuIlbL9wrv+dWjgToPNnv+wWuA5qi/Yygj5p2Qwi+hR1lHrt04KnpCqai2fbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(11063799006)(261021121427099003)(261028144727099003)(56012099006)(261026140227099003)(261009223027099003)(261021123027099003)(261022075727099003)(261022115727099003)(261022105027099003)(261102123227099003)(55112099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPxnvy8FDVOwCEfVyTu/sNn2Jyc8SOYMz6vMKC1/ETqWwkCCfqTywFhWFhRG?=
 =?us-ascii?Q?CXWY3Bn4dubS9mrdqh6Yspj2GjqX5Gf0tv7c8hnJHQjEQqzHuqFxIOBUZYDw?=
 =?us-ascii?Q?t7R9vcgvivewe7F1Kh5cWgqkOkOD3U7vT5CYsKgYOi+qSt5bluSHpvaa0YEz?=
 =?us-ascii?Q?9D+cRmXfRdcwIjDOlw79owDFoH88Paqio0u9CW/Q60MhLvXqttOH32rspv2U?=
 =?us-ascii?Q?oPGZ0hE4O+E8rBrezGd14916Ccfbmye0nlgGnBqtGcXqkwV0pEgctxjtXp7w?=
 =?us-ascii?Q?IOc7xlgDaz9hVHrm8D/s8+7IbPBzykn0SN0mJ5Sx3QhNLNT8fInOIifM/X64?=
 =?us-ascii?Q?73EQLiC3ICbp4MCIVOvYgGFBd9Vz0dmIamUTjByP16JFL96Xpldz0c7cgFeq?=
 =?us-ascii?Q?r6vNXUI4gJnZWd9HXYd36k4b/3z6SJpxFiFlVcrrSqnSwkMqgl2sWNnkvxGR?=
 =?us-ascii?Q?qIaynuQgpYcxtUZ/Y/dd7x8vqFA6dFAy9CYEbzO3yxKqOc7hTSYJMcu8atp3?=
 =?us-ascii?Q?QwxEQKiV/0ifISaBstDe2IdzU4l6X9jtGTVzXj6nvRM8tlq+Ef0qjVZCrXBb?=
 =?us-ascii?Q?5ahkCMsr5D3hwk0L6TgKoj87XaNmr7KviQmajAYoy++SMjr/PW505r4oHZTT?=
 =?us-ascii?Q?Hun3dEIke8uJt8qhlexC3Xatep0MZto+aGR9zmtKBh++xGDGiXYF9Hf8I47L?=
 =?us-ascii?Q?OG8GpUqC7BWRbP5rpgxV9thLlpDUjF3uP+dm3Si4mjeN58RK2+00irw2GXkB?=
 =?us-ascii?Q?sKNXbYBA8Vq2+1L89L20RLkdj/NRXuR0Aq+NwX8PLmOP8oiaSrt/dHf88Qau?=
 =?us-ascii?Q?Mn7s53OEC3/Rkq1SGPK9owJDVfgiRmdeplOWNnPsrp2ccxeYjnaNYAJElM75?=
 =?us-ascii?Q?00AswUArWm8ImLRUGDjU23NRKAMM9MTsxYhmKXBECpOwLN+hgTPeLoc+SnRz?=
 =?us-ascii?Q?3+KiHTGz14YVGvv7FnP71iEI9f33ciy7P9nFrTrBcoYx/sNwT73IwWGgwPJr?=
 =?us-ascii?Q?sDFtrdAK2QuXNN0yTJJp2bt+yxUn7RvUImWbG0eHJDjATHVu5+bbR95siv6/?=
 =?us-ascii?Q?wEidkQEbtO3WCE3DFajAAUzrmFwFeUx9R5GWWwXstZwZiK+j3fFMurqMbs99?=
 =?us-ascii?Q?RmNRc3/+d1wOyLfobtLUJqA3p7jvZrsroWyWiFz90DqIJy6+pl41LoBKDMhF?=
 =?us-ascii?Q?l3MuKFovZwp9m0sNNATqHbyMZLFt9y3ExBPaqL4WB3Uhj1Ew/kmtqzyNjZd+?=
 =?us-ascii?Q?zvW4hxI9NwQjFsL+xpVD0e/rVlXXKd7GyHJ6RYe+jBxtNZRM0gbW1FtPO4mY?=
 =?us-ascii?Q?hkL915RYrJoT5fe7OlsyiOzwBI+5DDpvi1oHD+YoUzdEo5Dw+txka8a3yNau?=
 =?us-ascii?Q?wP6DTsjTGBuATSeZmzNzGDlw3KliyNoCDSFJ2x2krJ3FE9rnz1pdjpE7CLtI?=
 =?us-ascii?Q?1dMqNtcjAWP43TBuP+NJXMtaX6/G45+9XMrGNGfVxj/yoRVmqeChJJmDpV6c?=
 =?us-ascii?Q?uKNckJzBLqk+lk3xkTaVj9Qa/sFsAFKngi3JuUiSgkWwIYG2EFHEI85Uf+5z?=
 =?us-ascii?Q?DEysRwWyUQ6VzqJL/pH7rKeglVEGmNRCJFRCu5LA5V/vwLiU7wcFvk0iVRtR?=
 =?us-ascii?Q?7m42t1lYyOFivdSFWB9hc30X+Lx7M8Z9KR5jQ8oiiO0Bf6Q5xszntmqQEDGn?=
 =?us-ascii?Q?ZF65kept5kiSemgJTuJx+9gb/lLfe9PX9SfX8muspMobR/lExj5VDWuiQ2lg?=
 =?us-ascii?Q?ymbZnBPtTWimND3ZBVRCTp/wXiMxuWY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef48c49-ba25-425c-61eb-08df3ff807da
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:31:02.9914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/AKI8tEG0T8nmxJ/96TIKxQiLblmiAY84FOk4YE/I8kXz9NWDG+DOmA6teafTIl+2DvhxdAVss1Gf9i9qavVezJfB72mERBb0iQAtpBOgQ=
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

EFI applications use the reported frequency to convert timestamps into
time. A wrong frequency results in wrong boot time measurements.

Check the reported frequency against the real-time clock by counting the
ticks between two consecutive RTC seconds edges. Using Stall() as the
reference would not work, as it is based on the same tick counter. The
check is skipped if no RTC is available.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:

- no changes

 lib/efi_selftest/Makefile                 |   1 +
 lib/efi_selftest/efi_selftest_timestamp.c | 142 ++++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_timestamp.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 2fc7fffc423..14a656c94a9 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_LOADER_HII) += efi_selftest_hii.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_selftest_rng.o
 obj-$(CONFIG_EFI_GET_TIME) += efi_selftest_rtc.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_selftest_tcg2.o
+obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) += efi_selftest_timestamp.o
 
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 obj-y += efi_selftest_fdt.o efi_selftest_fdtlib.o
diff --git a/lib/efi_selftest/efi_selftest_timestamp.c b/lib/efi_selftest/efi_selftest_timestamp.c
new file mode 100644
index 00000000000..577622327b3
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_timestamp.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * efi_selftest_timestamp
+ *
+ * Test the EFI_TIMESTAMP_PROTOCOL.
+ */
+
+#include <efi_selftest.h>
+#include <efi_timestamp.h>
+
+/* Give up waiting for the next RTC second after this many polls */
+#define MAX_POLLS 3000
+
+static struct efi_boot_services *boottime;
+static struct efi_runtime_services *runtime;
+static efi_guid_t efi_timestamp_guid = EFI_TIMESTAMP_PROTOCOL_GUID;
+
+/*
+ * Setup unit test.
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	boottime = systable->boottime;
+	runtime = systable->runtime;
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * wait_next_second() - wait until the RTC seconds value changes
+ *
+ * @ts:		timestamp protocol
+ * @stamp:	receives the timestamp taken right after the change
+ * Return:	EFI_SUCCESS, EFI_UNSUPPORTED if there is no RTC, or
+ *		EFI_TIMEOUT if the RTC does not advance
+ */
+static efi_status_t wait_next_second(struct efi_timestamp_protocol *ts,
+				     u64 *stamp)
+{
+	struct efi_time tm;
+	efi_status_t ret;
+	u8 second;
+	int i;
+
+	ret = runtime->get_time(&tm, NULL);
+	if (ret != EFI_SUCCESS)
+		return ret;
+	second = tm.second;
+
+	for (i = 0; i < MAX_POLLS; ++i) {
+		ret = runtime->get_time(&tm, NULL);
+		if (ret != EFI_SUCCESS)
+			return ret;
+		if (tm.second != second) {
+			*stamp = ts->get_timestamp();
+			return EFI_SUCCESS;
+		}
+		boottime->stall(1000);
+	}
+
+	return EFI_TIMEOUT;
+}
+
+/*
+ * Execute unit test.
+ *
+ * Check the properties of the timestamp counter. Then compare the reported
+ * frequency against the real-time clock by counting the ticks between two
+ * consecutive RTC seconds edges.
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	struct efi_timestamp_protocol *ts;
+	struct efi_timestamp_properties props;
+	efi_status_t ret;
+	u64 t0, t1, delta, tolerance;
+
+	ret = boottime->locate_protocol(&efi_timestamp_guid, NULL,
+					(void **)&ts);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Timestamp protocol not available\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = ts->get_properties(NULL);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("GetProperties(NULL) did not fail\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = ts->get_properties(&props);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetProperties failed\n");
+		return EFI_ST_FAILURE;
+	}
+	if (!props.frequency) {
+		efi_st_error("Frequency is zero\n");
+		return EFI_ST_FAILURE;
+	}
+	if (props.end_value != ~0ULL) {
+		efi_st_error("Unexpected end value\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Align to a seconds edge, then measure exactly one RTC second */
+	ret = wait_next_second(ts, &t0);
+	if (ret == EFI_SUCCESS)
+		ret = wait_next_second(ts, &t1);
+	if (ret == EFI_UNSUPPORTED) {
+		efi_st_printf("No RTC, skipping frequency check\n");
+		return EFI_ST_SUCCESS;
+	}
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Could not read RTC\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Allow for the 1 ms polling interval and RTC update jitter */
+	delta = t1 - t0;
+	tolerance = props.frequency / 20;
+	if (delta < props.frequency - tolerance ||
+	    delta > props.frequency + tolerance) {
+		efi_st_error("Frequency mismatch: %u ticks per second, expected %u\n",
+			     (unsigned int)delta, (unsigned int)props.frequency);
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(timestamp) = {
+	.name = "timestamp",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+};
-- 
2.55.0


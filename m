Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25890606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hu85yQcw;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MybjsRDw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C4CE6065A;
	Tue, 27 Oct 2026 02:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtDIeAOnhSTR; Tue, 27 Oct 2026 02:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50D19605EF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793066923;
	b=OiJfh5bvhI0coDQeD+Mq27A4cZDf1PlwfGfk52GXnn5v+92MGWh+CXnkbHTHl5htf4EN
	 +hH3bg15/4GaVcAx3tAEphbsyOLFfln2GfBGsl1/f2qqMzgE6upGreMxPEFCxMj9LgGYz
	 PneM4ts5A9sCGzm5znofLrrKPUIYlmDF4SVJWv7My+eLuA6N3A6jkt3KJfcDbb37PA16p
	 kiYUWPfM3VLlka/AiJHZzF16jeHN0dAas8OuJV8TiWDQNP1qeCSDSd2U5WCXyO/z5jFqO
	 HfyHms49rQGRYRSuRBHxJpX/7kFDXbEZhEW36rUMCBhjrzdJwPfugQK6+BSJ7jBsCdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793066923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=XSZqTktWiDwLFmWaKpNFeA9DQjKZ5dXbqfVlML7FGsM=;
	b=tU48Z9eCB4YouDAm/JydSWRerfHY22PBtkLcckQtLnTfcRajz6SG4wIis3tgXjejRjg0
	 H5uNaHnH+9RjGSNin9Wim/haQCxVze6ZZyuH2jNV1freS+dcfhVJd3bc870DF8UQ7oWEH
	 M57C6laSF6Rv1kfd/VLf0h825Ba8IgsqYeYn4OylMvysLvMmBSvOetPlcbTmKyapXVa/Y
	 ALhMPabhtKWTzx7qCYNRuEXuw6F1rqa50JfiQ6BGsMBM5l4vp5ezSl1ZISqlQ0KYmbI3X
	 oY2obS45/iOsTHMbkoiu7ufwc5WZ8AqOhXbzfT0YdCNMpQn89xTHSIOU+MnHWlCsizA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793066923;
	bh=XSZqTktWiDwLFmWaKpNFeA9DQjKZ5dXbqfVlML7FGsM=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hu85yQcwXdL8S/1icScsFhcLJwPgye8zxHc3tWIeeZ08w683/2rf2E/3u2f4A0Ar7
	 GwVGhyIvEbPSGZZz/vLP5dvX2OlwmdC8UCTWK/0sFbqcHPFabyN1xqaNvgjYkqz6q+
	 09yUjgaaGB1AIwocy/aO+XCI+OVTtHqICffBpf4dyKHDwTxD6LE2J5flrIGo1Ldnho
	 KZ9BiRQLnrx7i5HM8ipgvLhbrCzDCbWXPrB69wOoYH0Uayi0RWtk5XzO+PMR5YKxyn
	 mp3oi+e0sUcHdgifQIYJsHlLXo83JVl7S2D9QYodXT4tUMA6vnu2ANmlG6GBGh9uA2
	 YQCwPgnya4BIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50D19605EF;
	Tue, 27 Oct 2026 02:08:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E4A235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7167E4023D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1npcfzaQENrv for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 02:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E170540062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793066920;
 b=M/PU5JAtsrvSY7Sc0PFXs+/kcinXGd3Tz2qyHKFhM/qPyWPCKTqFnn48fBunujQvM70K
 xmbonRMgbKGpK+6YMQGXrzaGvgUqEkP6sfpBelHl7yL7gKVWIXPp1RhMC9ukPAQYBwfJC
 EW6n7PvvyyJ13SYDmMI3Dz7x6AxwWTSy6j2FvJLotSZGQfBR5d6UZ+co5JuNSBhru+Au/
 7GD8Zgoy7gZhB5Aakf+eGVus9gIFj9W9FbzSdHtrZtHEVUzY/bsdXynMVGQEmZ/FnKkO1
 eJ0jDiF/uZNOArmlP2YPsylD/rEaJ/miCxii4SaeeZ77pal90R3tP4kV0nxJg2h0cHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793066920;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=XSZqTktWiDwLFmWaKpNFeA9DQjKZ5dXbqfVlML7FGsM=;
 b=pYlhf7io4Iary7/gZUpHMjyAQl3rqfv4CzPW2qjDkhRjT/b4pAVwAa3xvig0kwEyddH1
 M1Fmg6DDET4KHMEfIUWjLLwFCoCaq/0fThvQvlHnMPy+O9tnBb7o8yjLFUZFK9ZFYZiKr
 B9UHuJuvne0klhqrKSScfqva4oO0SMZ66NEyxSmigCLlrS+E3lJzMKOSeEBtt82c2u+Q1
 ozz/9hF7G9hXafHfPtryA8CSPUiaYfMQLiaC5B//DV23hG2PTTtzwcnnSpulW4Y1xASYL
 BeqxiCAHAQioj0IriVxPjsuUF5J5p+CyxtYm6amznzC0enxhE71ld+pyuu8u6wgmGjQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MybjsRDw;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MybjsRDw
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E170540062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKpkg54BEkEBat9/8NgCT6iImrSyeIGAQDrpTBAkbAMeRR+XvaJRwf5n2fu1Dx7uxpKgxwNmtrpaj1Ft3RalZzu3PRnhS8R6V3HCDj2wu4qqiOWjzvlml8Xk86nnNrwxWn3wiRLgbrY9Sl2IIcZ7kJa0iO7p6YPU+CJiwiFJWkiLt/M3u0M3p/p8XSolXQ1WvekyOPhJqMpWg8knxKjDf5t6tzv0+9dt72aJXKchxK2P632ogcWwbbCpgLX9P0JeVNuj8ivkB40eckcHB3G4znY1WqKm49BbW0UGdc4A6OLx+Q11NRg6s7gBIV3Th+n35MLHyArdGshsdckT3NU16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSZqTktWiDwLFmWaKpNFeA9DQjKZ5dXbqfVlML7FGsM=;
 b=pKxh+q6TWUmIzeXhGinO2iwt7Y4aVMzhlc6YR2/So0qrbu35IVx/PCtmBtdX8gf96KNPaTMnU05TvxzSSBqn8LFYR2oSlgyU8E6YhMComw3xEnruS/DZGlIVXQAdHd4POYuULaiHzAMaNsmkdSVy17LxxNmgrLx6lgOPZhStrkJfGUWeSNA9oq7ZQWS2EpOedsMT+HbTC042tMQK/bH8Q9OBGCwTtD7w8SwP5nnB9b7ihAJyxFjc04N/jUBHOlF7GALMxpjXCJTB0Q8qPfU0c/XhZjuPXK6fsYmVQbcz9BfulVuR8QKxpPOQvCSqyKIVOMZhPyIN2Hi8d2HBrdXybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSZqTktWiDwLFmWaKpNFeA9DQjKZ5dXbqfVlML7FGsM=;
 b=MybjsRDwO6JJSwN+UpbHKfSCxc9ZlMJOuIhki4UaWN9fmuMw5DES4Pp2KorpsaSxCHA/d3XMjF7QgkO8fb2AFdUyDQmC9Fllx7nY/SI6r5aT/bHH8k8rMRRfr3AwCw0oTQRkI67pl4Z1yY1IrPtUxAcyjwA0HBYYQJfUmuZz7ysFQsJlD0TlDVgA/wlcRx1BSlwpXSeBWBJXGVdqCAMQiBrQWeSFdZzCxGXVd8WIo+ArHau9OLO6ifW/yd61qk55Hyi972uoXRAKFI1cie+S58Wtnf3SOeIPlVaA9OG61Vbc6+T0BM/eYUgjWkRSL+ngeez0ePJj8urgKSKN6pCuwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB11354.eurprd04.prod.outlook.com (2603:10a6:150:29d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:08:35 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:08:34 +0000
Date: Tue, 27 Oct 2026 10:05:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <brads@mainlining.org>,
 Vincent Jardin <vjardin@free.fr>, Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc2
Message-ID: <auAG7y1hk1-bjt6C@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB11354:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ddf4f0-4bae-4f97-b502-08df33cf34ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|366016|1800799024|261026140227099003|261022105027099003|261009223027099003|261009221227099003|261021123027099003|261026121527099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info: 8ql8pLME22vRNXUJXDMFWGIV5AUivDV51tgqDDXKR/gl1YO2EGEDqByj5JKrKqtd0aMSIpXbNX+K71dVsmdhqj6XqlzCR1GSbnqlxyw/+3NGhkgUiUGcaDDCNxgJnTz6HQgV8HA6D1h3kbSkgGJaDOPzhwBfolt64xiwFb/mAuP3gk4785smmdF05VgeKdZSRu8zCvk6A3dL2zTiydq8hKyJQFGadr0HDuRHaIiLAQb0PlawHWoWtq2uOrUONEId4ox98rQftsC/FM8lbO2HMVGROYgniDGV6hEkQynws0WtzXubAHjttQqdLt1IMZmRrz8+dlN3YegpXUbDnbEZu5XKkh3PYP7qo59+JFSknL1Po8tmpIuJTU9nLyslEaWS32h2wxMnaxGmjsOL67YIuYtyQ5Hj0ZnuHyF11VL8QRCt2tXnrXFmLI2f9W9spzXvotBpfdEFDMgvm1OzQkcGQ0noa166h+gDBnIpLxK/3ZNf5U2F8MyzxsyYy8FsEzdU2GTxihsDr8aOnHQdouTJZLvYbKQwLXLseaMgP0vX+NvQ5SG2J53yq+5cBmcGbuZChGUlLibm8OG222Kz91nGqZycJBogijI5g7QollHv/o+/nQ8rgaEw4522wnrxDfgUeUgVdmFKYWDrmflaJ+RYPbAHqSKphogiuHBdlFZmBYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(366016)(1800799024)(261026140227099003)(261022105027099003)(261009223027099003)(261009221227099003)(261021123027099003)(261026121527099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZjRTjTLCPqNreyNR3gvii1bXfRtP5HfvH0uMZ2RNSNhgt0IoCWUJBfi38gV?=
 =?us-ascii?Q?nceWqIPWYI8QuKCsMueN/ixvQRihON48hf/zPICYwhEwwo8X/0GkDZZwTdkG?=
 =?us-ascii?Q?e/uZJYnQyS9Hl8s916a8zSSJu+0kdyNyv9SI0ewBJckPUCcDgwhftludmzud?=
 =?us-ascii?Q?yaAE8tTrVvJX6MkMQ1DNeaKit6O4TcUcjf1EdiT+7TYK7ss/8jjoSS0VUpCT?=
 =?us-ascii?Q?rhO5Kn7NnPWLODlmBsdswXNPBb1qPHztkTxXuRKh2KgQYVMu8B2A+WyZaf1F?=
 =?us-ascii?Q?etS+8UlGWC2RAt5DRmWx1OSZ1akIMXtmusGUvZWe92zI3ovA/H/fZu33wVbh?=
 =?us-ascii?Q?z61cH0DHLUpUkGAYkXfNl6HlaziOa9E4T++6FKEFEvNdnSWnuiWfDTrY0sk3?=
 =?us-ascii?Q?5lokBENNkQyzq+6h7U+Zx4oDCeA1vvhexW1gig6LHnNTcy6ODLtv8uW5Aau6?=
 =?us-ascii?Q?KeQtmPjE7RVWnpB+2v+eQC1Due9bQWguOozeFUCpPjgbJqYOQre3Nd0+BXEw?=
 =?us-ascii?Q?E8SVkd65wdDuPhqgjavSGzfoScVrn/sb/2inkvKRJKVQss08oIBfuJINZXOs?=
 =?us-ascii?Q?Gd3u7jR0WU1C079eTp0F68rBQMR6Jr6Xi8zNMNTwqTnmNL88H3g6sdclJnPM?=
 =?us-ascii?Q?VoJhmpptf3t2uplMB4hfdwUNKD0w3erMAWMBdbjKAk43hNE6oybWzSggsT3S?=
 =?us-ascii?Q?uYMvqZXkWRXoQMu1sif+eX8XAmxmR7ZxdP8reRhBtrFMRGtJ3RhJcOlkrF0q?=
 =?us-ascii?Q?IeY2uWHHusf3wP9fonwI4URS42QGqtYIxh1FDA5kudNUzte4MqR3WN7+P3K1?=
 =?us-ascii?Q?BAol4iEQDng0x8Xb1g62W9AEzZ5fCYft23aUg/UVDvRihhZO1uFb+Wlk4ij2?=
 =?us-ascii?Q?fiSdjs8PyUG2YpC2odwoeBYquEtdj8UPugumn/PRLDxgLgk3aQBE4j4tm+Zj?=
 =?us-ascii?Q?Itzy8bokwyegl4p18kko4Gwe/9ox+oepkmu9zJsahziq09OJemlZJ3dpvs+O?=
 =?us-ascii?Q?sYKzTFl8HaNrM1uguoJF0ZIO3WnL1cMbROd1ASF6VD249KUxQ7zC4Gt4awgF?=
 =?us-ascii?Q?GEBb63wSsL+GXbSEjD0DFbkMRppcyAWt2RpUCVwnDkwJJGHmLO6QwEsLw1C2?=
 =?us-ascii?Q?DLGN2/RsrmhwWK52FwgFjJzve9beHhizi4km5w9gZpZ4lE5FYvgmmKvivkp9?=
 =?us-ascii?Q?N9pNcXKIuwUyzIizWn+Cn6BApRljMg+hPuR3vxMP/h6dFw13mGQZv5NHDkay?=
 =?us-ascii?Q?CpzBeH+Y2WKssvFWX+gxj8dfpZ9oqoU7EXSKK3VMcAc4cfmNXgtzpvlPuaTp?=
 =?us-ascii?Q?9LgTded2SEIlTJPe5SikJxhph4gNA9A/tsRWbFSqcfQhoMEyT9yBhLudmD3O?=
 =?us-ascii?Q?8xsxO++VyXbat+sCihIjAipi6AiCNrprQIIy2/VLQmY59tk2VZTm3/L2bJSj?=
 =?us-ascii?Q?xE7cOUTGtlYnStnwtpAjWAj/wGjkyzwfsfbSnZ9d/SXIfcLGKaTeC4EqHrd1?=
 =?us-ascii?Q?J5841WVvrnsksKTDpNCVpiu9I8alxxeczKrcMI5X6jOjkfieoOoOnz3aFvRA?=
 =?us-ascii?Q?+z6YLD47H/uIEvPWRegKzStT+GBpY0i82+gHVDuh1mdURFsnSb+Y80shzh5U?=
 =?us-ascii?Q?qjwhpcGAiOtMGMNC4PC16hgmoexwaiE0O9aFoPpdmLZXTt95rpt6K7rmasbM?=
 =?us-ascii?Q?8cesxs5il3bMZ1iL1dLTj3nkYeRcJ7AA0wOilSm2+XVfZus162oOGAYiohdv?=
 =?us-ascii?Q?8jaK9J2Iisi5Cd3jXlAU4Bw5wR+vfqrlmwzL7hEKHYkw70G3ylWU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ddf4f0-4bae-4f97-b502-08df33cf34ac
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:08:34.8815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vv2V07Z8h1Q1UKA/oh8NU6MgZunShb0FChGBfmeGRGbIonQcCnh5cIsJ3Ha+nT1wAkYTKHiVesreu5a7DO1y+RV0lLxKuoM/qjs8R9KodtbHaLeG/hLQV2d2M9IRePb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11354
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull fsl-qoriq-for-2027-01-rc2

I dropped the PPC changes which needs more time for response,
only kept the change that Bradley as PPC maintainer.

---------------------------------------------------
Add Bradley as PPC maintainer
Make BASE_DISCOVER_AGENT it optional following spec
Various update for lx2160a serdes from Vincent
Check LSB_FIRST for fsl_espi
---------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1748

Thanks
Peng

The following changes since commit dfcfc4c9f78d1743f490a497082a4ec8e058aae8:

  Prepare v2027.01-rc1 (2026-10-26 18:21:37 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2027-01-rc2

for you to fetch changes up to 03dba82b4a4f79c9da908ff15fee97d682354f8b:

  MAINTAINERS: powerpc: Add me as PowerPC maintainer (2026-10-27 08:44:03 +0800)

----------------------------------------------------------------
Bradley Morgan (1):
      MAINTAINERS: powerpc: Add me as PowerPC maintainer

Bryan Brattlof (1):
      firmware: scmi: check if BASE_DISCOVER_AGENT is implemented

Tomas Alvarez Vanoli (1):
      spi: fsl_espi: check user's LSB_FIRST

Vincent Jardin (18):
      power: regulator: pmbus: check the device in the exported helpers
      power: regulator: pmbus: read back the VOUT_COMMAND setpoint
      test: dm: pmbus: test pmbus_regulator_read_vout_command()
      board: nbxv3: VID handoff writes table value, no droop compensation
      armv8: fsl-layerscape: icid: also find DWC3 nodes as fsl, ls1028a-dwc3
      board: lx2160a: serdes: drop the split subcommand
      board: lx2160a: serdes: rename serdes1:split to serdes1:100g4x25g
      board: lx2160a: serdes: rename SPLIT_POLL_US to SRDS_POLL_US
      board: lx2160a: serdes: move the SD1 halt and reset into helpers
      board: lx2160a: serdes: set SD1 with a table
      board: lx2160a: serdes: report unknown SD1 cases
      board: lx2160a: serdes: no SD1 config once MC runs
      board: lx2160a: serdes: add serdes1:2x40g
      board: lx2160a: serdes: enter a SD1 mode through the mode it starts from
      board: lx2160a: serdes: add serdes1:40g4x10g
      board: lx2160a: serdes: add serdes1:100g4x10g
      doc: lx2160a: document the sd1 hwconfig option
      board: nbxv3: apply sd1 hwconfig before MC starts

 MAINTAINERS                                      |   3 +-
 arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc |   7 +
 arch/arm/cpu/armv8/fsl-layerscape/icid.c         |  18 +-
 board/nxp/lx2160a/eth_lx2160aqds.c               |   4 +-
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c              |   3 +
 board/nxp/lx2160a/nbxv3/vid_handoff.c            |  77 ++--
 board/nxp/lx2160a/serdes_split.c                 | 532 +++++++++++++++++++----
 board/nxp/lx2160a/serdes_split.h                 |  16 +-
 doc/README.fsl-hwconfig                          |  70 +++
 drivers/firmware/scmi/base.c                     |   5 +
 drivers/power/regulator/pmbus_helper.c           |  64 ++-
 drivers/spi/fsl_espi.c                           |   7 +-
 include/pmbus.h                                  |  14 +
 test/dm/pmbus.c                                  |  41 ++
 14 files changed, 684 insertions(+), 177 deletions(-)

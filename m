Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3284606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A8MEPzBR;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mTI4s1mB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99D0A60829;
	Wed, 18 Nov 2026 05:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g9hY-wE5PH85; Wed, 18 Nov 2026 05:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDC706077B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794979051;
	b=q4XDnAiPzbYm781Cok1sFD6alluBE6Pj9Lfe/lMsqtapiajmRQLggE1LgTtSeYCJCdUa
	 Eg3huR+EHqkLfbgf5YhQQwEG9SH2D9PK71BLe4E98em2XhOsXbjhgK5vTLjNxfgdV8CNk
	 amNE3hfVqTQTIgRCrTQzf/RWY86mTNPa1H35RHdckomRgUq6KjHcsDXbYxYJqN9vqliCo
	 4I5I7rqym2M93GqSMPmFG+jgBJNwj5fqCQjJb316yz5drs+/+9C4SEov9wosal0t5VJkj
	 0ZgRQlQcGranFDxySDqqfNckV2T5w5THsAtAbgzY/ELJC+11929tuIQJTJH5Z+zSkqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794979051;
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
	bh=WwElh+O+lbz9r+pVJ2+K03/0Ter0QtWYbmHdJ2VxRgQ=;
	b=bvPim9nQANJs+VaJ/zKbxFY4HyPejQEzZOcOGd3OGIbfA0AOuzqp4c1ZNRyrb+WHPP6q
	 dQ+N2aLKHa1XqxoFgYO8DgbeH4ATD28zBfglbyMYmOnewzBrf4Dm36a+NHFqsOGZQI2Rt
	 qm1jIBXSVxUzrpbd3wdQ+CM3EovMsJ8tESEj1icT50Im7sem58IvptzlR3vK2niwsRtCM
	 HA80TZtsR2HAJFoAVrRFBwYjFPNm/ArlWLli7IF07V9f/DDUZetWZWrBKgxbrADlUVro9
	 2l1BWbmim9c4ZDH5F3qNfAmxFugny59wDX8rFdiXh7l4pJ8rKxC5k+4Pidq+r7K1QjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794979051;
	bh=WwElh+O+lbz9r+pVJ2+K03/0Ter0QtWYbmHdJ2VxRgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A8MEPzBRspZHRnfOryk++oTEZKhD5pK7EzcL/SJdE3T5iL92CCBup6oYPAdyV802f
	 lyptmb6a3wW2mTY62wtX0AniMCD18zeZN4b2/uA7G3VhdHKsLY5RD7AeU8dI7R/hhe
	 oQPpP54QY2LhnN/MwZw4VH/kR9IZg+8CTnU41zt8KWAHuoIxNoBbDvclgTmyk71lfa
	 5T+SUc252CPKVYXwk6PkVAHt+Iy7PaqtcCZm/GF79ftACy2XxfWZKSpYmnqakutGqN
	 Dm/vsPwJorIUFUrWKh6CZ1dfz/QkKfAOsNPY6xDk0K5iPWgXALREVVBSDsdUr/kyUd
	 aI0BftywUsDkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDC706077B;
	Wed, 18 Nov 2026 05:17:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96E8B70B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D4FB8107E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJ26Gg9qBjfi for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B332280CBF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mTI4s1mB
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B332280CBF
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwElh+O+lbz9r+pVJ2+K03/0Ter0QtWYbmHdJ2VxRgQ=;
 b=mTI4s1mBOkRNjp3M7zeEzZf0xDgpyACmpSzaJvsOrNtJHEH8tkcMR3XqHz+5NW6HYnnWpXGsMEu8VNtvVWTrQX+ng1VXg8E7BYediR6K3VO/97h/wlo1VU76JBP8PdoVRMjySkRATsdnIIZreqRcK7VHDAN87g5SWFDtmmgiAqnpdKLZxW7/U/7acX0w2ugbOGVWnDzPp2C7oLnJ7zo0GPhQrrros9ynuuAtU3ko0NVSIFkJU5ixVmPf/CSqe7NiKMrRINKj6U6BSjWRdnBKCLizsG2vrEewWoZBfBmzhXOEJF41dL99tsHFgcwmac9y6G7Z+RH4sKT9OPlLZOBdqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:17:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 05:17:25 +0000
Date: Wed, 18 Nov 2026 13:13:36 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] power: acpi: Constify driver ops
Message-ID: <av00AIVlqE5GeVfd@nxa18884-linux-1.ap.freescale.net>
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba5e2ff-191f-47d5-9d3a-08df45333b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: aSHrwD9J+lEkQFDAw3z2pBxqRdMJjbRbwVvi+IKizMJqd5+4fnKUt1VZH7R7NWhJB/Ht23csCWuFkoXiOWQ908Wot7z3Nna3+/SI0ND3pd5zw84SmaYT5LFwfv3d8dW1gAN696iK+hO6Sle2NHqcaG18ynzUH+MCDDmSkIUbSV4Blgn0b8fHh12lPFmyCULqd8+LJ/naw95PlHqddsi/S9lSMSWJUDhFb8Wy2UfDmmSmDrfntQG9eldJkNb8X5KId4vVBkGjWUoS5ApYAQ9AdXZ05B+paVU6Ccauf6PdlVF1waGKJUyqq1VL3IV0Vfy9rTtQQRH4a+76XwTbgBoLHOI2vH6RtoDjEXzFHWIv3edPzoDfiJE9ekdT/9oBjE/kya5Cd1wc+LmKmgAwYNmbkS25Bye5lh/7GHjU7/McywGPc0oPbnrQkUpnLMaLhYl6zqUMonQDOthQy5dli2LTy2AJqR6QxhKivA009PJXniS0tz2Zgcwqjv78atgd5I+ZnIZIPuevvFHdfinA42jFdMXg15026s5cN/ur9TXZrj2khRJ/qijT3D0Dz2y7LXXur0UL2QOu2E2yb8dKWhLmlZeG9UYRwC12E2lQzEbsrflI+2qFVFO8t1MHe6CdpQ4HnD97OLU7+LaDhuglDGpo8hvvYllDDK8ZqpSy3L1Zo98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOHAPEE0fv2RcKOA0hKjxXblIENvfyd1Q1tA4QtaZcU26awt8SbOuTdDnJ34?=
 =?us-ascii?Q?6Ti/WZdqcpHI8344aFk6EeTbWyrOV1TW0bRmdLgASWcK+jMYyTkVCMLnUUQc?=
 =?us-ascii?Q?5iekXkE1MdbAtCXZ32zOzczL3Km6LiZYBd2xbwNjWrT8f+izgYMvoOjzYjex?=
 =?us-ascii?Q?WP7bA8zWnKt4FXdIu5BDGT3ncMNObaC3z46pciO3qF0HnwWHe6abhujAMUhZ?=
 =?us-ascii?Q?r8W8RwohECnGX1+fWJMGHZm4M2ntxHR7YdyYnZN4B76D7L+ZFXsEwjA2urQJ?=
 =?us-ascii?Q?/oUOKNmdBShXiuZmkP1ZQlidRPfkmNNDYn9RVffpLaboQKyBG7vt2UXHKwN2?=
 =?us-ascii?Q?n7KitR/+iOhYeQueRvFm0O1/2pjUpNWBgO9WzSElgQcXW99i2zX+z6YV7pf1?=
 =?us-ascii?Q?2tvklOxK5+4S9HVUicVJXWoqITcx88DNKvWt6iXdv+2kDlnqnlVfWI2dxUBK?=
 =?us-ascii?Q?piwvCRVSsi3ZIXH5StXaIcUv5dIYUt2t0F/lz9ZK+I38VO7z/sZYuFbhUlNx?=
 =?us-ascii?Q?LOM97efCU6t2OfQkMMZkWa9oVb0WD2uCPqiyRAE4EopgYOE1ErIMiMdtqxNZ?=
 =?us-ascii?Q?8xTTMYfVuMUlgjg4f+l4tMGf9JxFaU1s5GHrMzHBp8mpHRIQ+eUEYDfvCgYX?=
 =?us-ascii?Q?qcnvzIEJg+zdvEyZEEW6kwVUkCDHY3wzUcGAWC0dRNNkmJjoFYwFZr9hvo5Q?=
 =?us-ascii?Q?pLwm9TgYqV+kD6ShhpaEWETMryw11jkJ2yUVP/L0phwwlE3HLpCq3aVTWPri?=
 =?us-ascii?Q?UfpRfbRG2JXpPKAVFBxWgcQSldKx8EfPqDOiCCwDqLQZTczt52PECWgER3c3?=
 =?us-ascii?Q?+x39qBIC7fJXHl/MbNbRx1liDccfM7421dBe0Y5vuMWRK9glYuOU+jN5crQW?=
 =?us-ascii?Q?YProd7mavlwZi/BVn65DDYzoU4kA8fNXWWDO7VYBKi8h1eq7usj3QlmgP7g5?=
 =?us-ascii?Q?qaeqC7s3llaXE6o3s28kqYoy+zZrtTmzfKctXgxPvxFTW9w2afM0mxKilc+A?=
 =?us-ascii?Q?PTn6AqepN2WV4aQVfHVZErDhDhc2gzLuMkNrQ3Y0aEQjbUC3Znwy9Mr1TzcR?=
 =?us-ascii?Q?gLr+bEeuKUPt3vrc4wgWj2H1xKR6vTw1zYcVQXXgynr3QzGsDGYWGLxyAZ9v?=
 =?us-ascii?Q?xLqMOqsW1as3qGlzbSb+aqhmzkDl2EO3x1sJlCMo/78qLI6whGlr1EWu5l5J?=
 =?us-ascii?Q?baT/GTXskUs6g0wApEL0RSORcWnr9nSyclDckFCn7mR2QRwg6ZsfnxFgV/gv?=
 =?us-ascii?Q?NUiysoH6JPLWLTkrNmhwhUcRpvHuZU/m6pJDcehDB5UN4azloBHi54bh0lTX?=
 =?us-ascii?Q?U1yrr9JVFwWXAz765MIi+cI2nkX8uIA1Hffz/TKOxQFUuY902VFxSNYpS/iD?=
 =?us-ascii?Q?sod99g6z783TBnxvLESWYJqwQ8c/zVkUZEkVy9NFMbAQ4fZo+lWAqKMwKG/p?=
 =?us-ascii?Q?ChI4Ck4exMZT+4+P+grWvJGyYYj5LyGGN9Ix941DzWKrO5OpxO78zsBUrghE?=
 =?us-ascii?Q?n/HsyvPWE3VelLe5uo9JZYbJuo4PL1mL60M0mpMTEV2dpvNs/YW5RhWDtdZF?=
 =?us-ascii?Q?xoG6rJs8mcoNIjwLGJwWOmDcLEtZM3OElfzLfJtNzoxDBWVkSaMNOAGexwMf?=
 =?us-ascii?Q?IKr9jHgBlvdQ1vdsf5jRP0pO19fvjd7S8yD+GRO8weWb9MLLA62bSbGFvZdc?=
 =?us-ascii?Q?9RqlKNAh5i7RsVrKeVPD+fvy13omL7gWRy0UhnaUqE4uldu7tRNxwVBEIcCq?=
 =?us-ascii?Q?Yj8yr3N6WklSBqKsMf+dy1SSvc8gERmolxTxDtJCymrmQhGC7pJ8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba5e2ff-191f-47d5-9d3a-08df45333b2c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:17:24.9404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OYQXLc7di9cVEv4FfJMwA6sT6EryE6Xw7Edla5RHUXORYngN+N2zyzLUSoOgZSrWauQcsLRtTEt6VogBB4Sir308IJehtPBJw1a6zWhiPByl7Al1S6BHXh6m4ekz4ka
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:41:23PM +0100, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

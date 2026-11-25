Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8771606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZnZfqbPG;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=htAY/2Vd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CEF640648;
	Wed, 25 Nov 2026 07:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DE7QH9uvh-m8; Wed, 25 Nov 2026 07:52:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E08B4061D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795593178;
	b=YyHat1cxAy5v+O897ED3ZoqAKFbdxBHMftlXCpmWknNO+M3arsnp+IDuu80HhUV1LEG6
	 CZt9MZzVI7YZt3T0vOM0neiHS/H4L+7bLefnfruKEzQtiI6s7UN0hkIyEVLQ+diqeKfVY
	 2dUB8aj6LuSZcOXXHnv9nCBA7JfGJvxcVxBI8DW2h6ATRO7iL5vLHIpqXOQ8DEUDPX9Gk
	 f3h5g2zW2kWZICuh5zLw0quSlu37PKD6xLliRDSc8HQz1Qd722xG4lY0RhOC0HFIYqgMX
	 i0XIH7guZSVEn4xpHL21qWkexx4cNi0h2yNqEDx2lpfeh9ssWGzY1T29amZWLWpq66Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795593178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=7HlmL7hP6H+AzVMRF5jV7YDsL3fAuhyIK3J90XSYF5E=;
	b=e8ltz5A4r+XAwyAu7cHzdmWpztzQ/5UoKoTiDMHcyJOmSoi60K1kbhZ6t7+w0SaJBESW
	 W+ukxFN4X9dEcEwcN22DBM8NJLL41MSvRfX8YsxFKP9kYjehVMmUSIqKiBGYrG0MTQSnC
	 rsWyHeuFc7hDOw8/bZaDuC4EarMPkIrrYPaQV3NX/lonl3HkSv1Yh6rT1WX0EXjkKN3DS
	 RsLHZpbepNar+bgpiBX25PQ2mhNcZC+T64Pdt85BBg8gnzDHTiWugNxMQAWTGVTqhN506
	 mv/4eUTuKUeEE4kIFGFFUhcPXpI/fWhQsJOD0sKRKHaaJkTf2CPbXk69HkzTv4taqjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="htAY/2Vd";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795593178;
	bh=7HlmL7hP6H+AzVMRF5jV7YDsL3fAuhyIK3J90XSYF5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZnZfqbPG3A91bhjdQxGDiCJOkzPNhZ9K6afi26SSAXf6yIIxUKh9UBWeySL/F9UBx
	 SzRFPr0CndbpmOriZ08URgapGz/H+1AV+byKkMwvvm1jtcCzWLO5MCVA95vJdR9ZlE
	 LQAlYuPFb61/0DDB3DBZ/KMxVaq53N+9FTc/FPno8IvXw4o0vu6407pwdYFq55ZsXN
	 L9af4rF7cHV0eQhvJUaMOA/ROHc7uZH2h+EQJBPPG4LZK49wRRp82zL4urAaasTyaI
	 +MrRGPBbT62EDGTNuzaVQj9izDOhlnYkLhDIEnxxjdq2aVRw6NKpqEUwOj+2z+tic5
	 2XPKWIB71KF4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E08B4061D;
	Wed, 25 Nov 2026 07:52:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F1501C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 654604061D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtA27Ik-CZ4Y for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F6F74061A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=htAY/2Vd
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F6F74061A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HlmL7hP6H+AzVMRF5jV7YDsL3fAuhyIK3J90XSYF5E=;
 b=htAY/2VdoyeHikN3lRdBvYDDaSK9QdP3pOHuH2njMJJvFZh5AT6/+6ov6tWnZ5swdDVF/3M/Y54JG62LYTikYUYRCpeysNH3s8mz3SIMOKeAyssC+NJSTC9/DmrTnXSOoBjgE9NwLGxtOnmU9c3mUTB/5ZzZXASEM5ZBN8PgY4O7r0zR2wn+jv0p7iSrTfkgblg0dDuYsb/pOfi51xu7dHN8n9j95Vf4ge0fxPK7tvoYUHYT9ZCxeJPgf0rsmDJVjfK8lW+hXT3n5tIe8/Ce+iAfAdTcqd0jkuBmLqWCnMfySEGDAWM7VBlBLpNPeWjgScdRZGEc35YGy+ttQN0fTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB12003.eurprd04.prod.outlook.com (2603:10a6:20b:741::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 07:52:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 07:52:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH] spl: mmc: restore partition lookup in dynamic mode
Date: Wed, 25 Nov 2026 15:49:51 +0800
Message-ID: <20261125074952.28083-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261123-ccaione-upstream-spl-mmc-dynamic-get-info-v1-1-ed7cba0804c7@baylibre.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB12003:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a388733-41c3-427d-6444-08df4ac91a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|19092799006|10067099003|11063799006|56012099006|261021121427099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qy18JMWNfMI0ctiQET0G59JdbYWK8bq0wxoiPVQV8h6qRhkq2AF3QpLx5Lq7eYIjrH34Na/1vfT6jeG+V/sagB1vvAOTOLmQMzgVC6Rr/VSHAQF2sLjqJStOa9VDSx9xOiL2iQPVs14+dY1mYe9pLalflHSZ6+zR13LX0/nzVQtOJLAbhBWSMMgGilHoIUh4jgXfOAgZW7qwKT7yKpjflRNze9NJS2/uiDkSIwnmUFu4dHjLPPTaP5qOw2RQECLU2Vdm6HQPb1UZzcF/qPXvNiW0GtoRQN1Y++711/MzEZZ2qqePcyy8fCdYCxMoFA40y4w7czsyaA91la/3p5rVbXFXML3TFBH97NF9kf75RObDK3a0sy9b9PXRFWWUBU+jKuZViN2F+76w5ezRsLZA24iA0R6ya4XF7FfQHQBCtn8hvnWfMrGWQXiwvDiss3CfrtZyYhkQDYzxBk2PWb5js+Q+CrHtrVOfO62fYcVc8gtNvjvcUQOnbRP+ssGqvCYJbcMscMgMeHcVTF+Vtv+XRepGbMCY6w74pVfxACvsC6NJnmu1XCmlOIKD3GYaBgma9+MzuwzzSs3tMg0JrHYfNE99dgiE19lKQILJJRzCLmNOPo4rlks65EumIkH6pxweRsivSiqgZFtOLaIU7DWF4f1OknJQICQJOKwejx/LI2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(19092799006)(10067099003)(11063799006)(56012099006)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utW/YZErO/TTzDPGKQnfPJodYba8XevwiI0gOjk0Bm321llOkPl23Q5SgDtT?=
 =?us-ascii?Q?jrkTwTeH8xmZOw1awwOJ4gfGODtA8vK4fXN5TfSgsLxDrWWTwhac5rpax71v?=
 =?us-ascii?Q?KxdxaW2kaKGf1nta9eeu61h0epcNcmGy+5KjUxSh+Ee2vqdFZO3AfY1Df5+d?=
 =?us-ascii?Q?x4jUoPVKBZuJuYtJ55AyKFdqh2mIANjeUKJXCwaNYDQz4Kf2dzU9ObD0fCBH?=
 =?us-ascii?Q?tB+enSekvTOXANOjF4yUroXhpdeFTN0iG2JyLBv9jkRmTMswEyse2ycY9wKp?=
 =?us-ascii?Q?M431TbpsLDbyisrFnUiHb9koWOkpqJ3HcjaabTwhqAJ6jXUBJlsPYtmT4/fh?=
 =?us-ascii?Q?dmGNnEG42vcD7XhMeJQvDXXc4VxqAs3sBSn0zSdcVqDTakyUgoC4GLJVB9xI?=
 =?us-ascii?Q?DLv0CkAMbxje5t+nvScrVnbARcO2FMN6y7w67inH2GoEzgPF6WG286OynFQ3?=
 =?us-ascii?Q?4H0qbotvSQ+aqOAmVE3CJ0ugSDudx/QeYleMLVDNk2n0+1udh7EIrzwiok5p?=
 =?us-ascii?Q?4ltR7BaCGTM+nM0W8/YqcplG8IRcgWLDX5lHDlzJuHbCV+mKGzpDGQQ8jyPT?=
 =?us-ascii?Q?b7c2ccxbucZ6s2poeyCa7QbL2qj/EQYEYYwAzfoJNItY+yAcBveVPQ1lT2QT?=
 =?us-ascii?Q?Ksmd99tzH5GGOxLFeddUGWEtnN/dPYQfbrlWPmZP2gcL5H3ltyQJR2GY/h4a?=
 =?us-ascii?Q?GU/bYJHGAkNzNSWAgwNfZf3SyqIr/XVh+wjDRu+Sj5+J+eo4pDlurJPTC9ma?=
 =?us-ascii?Q?lGkSYIyn46R6qL0zNQrbAJbe//s9tj+MHAuSh1kgosFxXeqkaPcTH03z2VCy?=
 =?us-ascii?Q?793102/NOhmc9tvTUSnSW82+b3wYFLNhj2fJ8PoJkghfULFi63g2QFuLi3CM?=
 =?us-ascii?Q?aJri8N83UEpW80G9jRsrhlTNqNZUV1j8mRCfi9Kjl6C9I3SG4ggSAhuNGtCe?=
 =?us-ascii?Q?mqE+3kwRIXg5ceMT04Ge3meaqUNku8nSMBOO7eL36mXBAeyY3nKNv6RFjUSX?=
 =?us-ascii?Q?38+srlvRAZCIvonxz/XeZeP3UHKTRd7UwQr7LUZrTa20Vl5T22eZ6DWRZ1Vq?=
 =?us-ascii?Q?ag6+JkOlwtO5d5Kg2sqfx9uOsYp6rgimCgGqMCmO7Rhwvrn4wHOIRI7dSe3V?=
 =?us-ascii?Q?3E6R/JVZEVJKRLJYedxJvzE1l+hoPw4NijGT0cCjA40vS/lmqo6ZR4iaPOAX?=
 =?us-ascii?Q?JoFjEMzbTxy0PoGXPCti3RzOQxgRRsBd6TXTJ4AvOHCKesR7WN7vBE92cHNv?=
 =?us-ascii?Q?MmiXJ3BS+P6q3kPaAwX9w7fBETU+HYODk+Sa+HdPOrUdfJq1gdJ21NOFthOO?=
 =?us-ascii?Q?XaDaUXXM/Bzn8RlAcIb1mZ1DpwHCvbTM+yF5cflo4Dghyu57CH8EDNDgf8bC?=
 =?us-ascii?Q?2P3ChUFQiugylc3P9UPUB3KQuHB+MO8jVgr8GKehpVVPzvSiL3vFVo1wVCCr?=
 =?us-ascii?Q?Mhee8iw2ORn/rb1eux2S9R9iHLOcwK0nU43yW5xPBVpcOvthVmRbkDKO0Jnu?=
 =?us-ascii?Q?oUO4hqUILKSQTKXkoUgnrb8xEGWPRgznFDBi4br5BwGsj630TmEyM5ij/rcS?=
 =?us-ascii?Q?RMlYOw5xryzMT3S7DKkFfUzFvj6G7a1cEQJMSAfUroL1z9u+f/xpWd1UOPzV?=
 =?us-ascii?Q?bjeAw38pBmgl3qzk2A3nmu571RtHCK4MbwXrIUUnXrKl0vZp6Kd1Mpk7YCHo?=
 =?us-ascii?Q?MnsKeG3EsMkh7mLuUKEShaLP3PQ/iwpfXlKpM64OCgi/7mjpsxIC1RvSt6oE?=
 =?us-ascii?Q?0p0fDXXWXDSj+a/BOBjR+9SjpAsc3sgIEENRZExX03wXUBkrA1st?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a388733-41c3-427d-6444-08df4ac91a5e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:52:50.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7x20Jz922UmIfp6x65I2II6UBp6X9QyaPFQmLBKCLz+eDjffj3fp7kecm2+8ygx2gIzUbXg7otBlpfUWZHw13HgGduAZe5Fq/t3Mlrw7ofOWBIEH5BMi3Y+3zPGRfQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12003
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 12:09:40 +0100 Carlo Caione <ccaione@baylibre.com> wrote:

> The introduction of SPL_PARTITION_GET_INFO left dynamic MMC mode without
> partition lookup support. The partition drivers' get_info callbacks are
> NULL, so lookups fail with -ENOSYS and prevent booting, including the
> Genio 700 firmware A/B flow.
> 
> Fixes: 8b5070034da4 ("part: introduce SPL_PARTITION_GET_INFO and select it from consumers")

Not find this commit in Tom's tree (:

Regards
Peng

> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  common/spl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index ef70e96ad83..05a253c9528 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -593,6 +593,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
>  	bool "MMC raw mode: by board-selected partition"
>  	select SPL_LOAD_BLOCK
>  	select SPL_PARTITIONS
> +	select SPL_PARTITION_GET_INFO
>  	help
>  	  Select the partition at runtime instead of using a fixed number.
>  	  The board must implement spl_mmc_boot_partition().
> 
> ---
> base-commit: 0b3875426f261150e6cf9ee14aacad9b76c07937
> change-id: 20261123-ccaione-upstream-spl-mmc-dynamic-get-info-ec88a5d5ee2c
> 
> Best regards,
> --  
> Carlo Caione <ccaione@baylibre.com>

Sent using hkml (https://github.com/sjp38/hackermail)

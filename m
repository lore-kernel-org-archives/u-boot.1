Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF2606D81A
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nAjbFCFf;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Nbl5aKcT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2D99605E0;
	Mon,  9 Nov 2026 09:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H_OweQLXbVaq; Mon,  9 Nov 2026 09:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BFCB605F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794217013;
	b=En/UB+PHHU+x1R1SA5SzcZYxH9udVwGUV44SybcuzGlApJ2ZI/fs/24W3EHcyETViiya
	 GwaJMtM9V1W2/aJnrXebdWcR9busyz2Vmah0nkWHjPrsUEorKdVIVEswZtsZrUuIde7um
	 6c9eUoMOMWFq7cfKYypyPBNacAlnFEyQ3rMiG3LI+SvX/SDpsfs5yLf+Os7dRtxUlNPBC
	 wE7TIKktWc5pSEe7od07jmC052eUvjxxgpezhSzri0v5IO2H2q1Xliedt+uHfEqNg0Cr8
	 C7kPMv+NlmVq9uSdFr+pYPeD8lG74IpnwBO9pawegRIAHc6vZBNjRsyvaZrMpzTwVzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794217013;
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
	bh=BEqRBsOHmO6LcCH95I6xGxrE5UofWPGLLfcliT3KZLI=;
	b=iJdeG4cgBuqmodACmAAqCITnTfZl9hC0X/U7hooxxx+LRcoajxD2jQ2iUeCdpZA5YU8s
	 KjdlgGsxNDhpdplx0sxsUMJ4sb3acx9YLVFi9GYreUo0F6+4qLnhJ5lC8MYaPflb5Mebc
	 HL70wrRPkXVefNvmalyBTkLPXCr293Ses1fsvtOw6vVZmbFDQny9LoiqiXW+cpWXasrWk
	 zugCsgLF++VvQ7Jw/m7ou3yjH/KzAzwsRzDC276WOuxwQIvQUfdH+fJZWB9I940Cy8kVk
	 Wg5wLqdVTcpXWGOfZD+n7Sp1gsBUJfQuKAFFdCsosQ/5PxtXYY0sJyYjTjzb7x1D4Og==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794217013;
	bh=BEqRBsOHmO6LcCH95I6xGxrE5UofWPGLLfcliT3KZLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAjbFCFfumbyuml3w+prbmVyG39jdZL3h8s9OijZnQQlaYx6GFN1SO4X52borKjNZ
	 A2SAo1Be27jee+5hdPbJFhBapz3An+0Fo3cBl4NjQo15Zp3tqljXLW6xY6g5k+eyEa
	 JMN6KJOm4PxgMQIDeFwdmJnGThg8p4rIXKHhXrLQsWnjuBYsX3WzRKBVVoZrMqr2Pp
	 vDbPbIj3iBny6aBHV7erWjd2UmPGkb0+zYzluHHPrqCnK7JOF9h4vsRLCr+c5gtAB5
	 Ic5aGoV93G4+W0vkryac9HRDXRV/pu2valgItF6E10eRqRcKUhQbZDnwXxdkS9eb2q
	 dv+hztt0RxCOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BFCB605F0;
	Mon,  9 Nov 2026 09:36:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AC052AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6070C405F8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xLG8Acv_poED for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67320405F6
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
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Nbl5aKcT
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67320405F6
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEqRBsOHmO6LcCH95I6xGxrE5UofWPGLLfcliT3KZLI=;
 b=Nbl5aKcTUv6nYMnkhszbpiF65lzGUyJCoRTXFq9jr3E9Q3VtU4oGd6/V/NhQR+R78+vF+lfHrU3lyVSwHlh0KITIV7pndIvJxqlgVh/VXeKX9oh+hXyoqeLMlxQbUM52ydAeWyq8D/s8b71j8abrKx1RE6D01gYWqIiOnQ5O23sb88XxYVyHr4KzHxyECq/7EqCBpcPxO53IiKFJU9ULagjjVIgZX3BDpkJeYFarKqjD4C/yJ+IXlt+9SDNOWBRFHXZ65yz8mhODfZCH5fRZMkTArqZPzqX/GEqdDWUA4t9AuKTBgPRMv2/41L4NFF8H70nt92ETpOfo7Pmc46o8hg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 09:36:44 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:36:44 +0000
Date: Mon, 9 Nov 2026 17:33:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v4 14/14] mmc: Always use a 512-byte block length
Message-ID: <avGTWpWhlxdGIwZc@nxa18884-linux-1.ap.freescale.net>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
 <6a4e3afb-4336-4e21-b5c7-b9ec88a9b6bb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4e3afb-4336-4e21-b5c7-b9ec88a9b6bb@gmail.com>
X-ClientProxiedBy: SI3PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:4:297::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a3f26a-0fe2-4b59-12fc-08df3e44f75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|19092799006|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: W2WEkKZ5sdXcwS2ne1IE5uAps+H0xvH1dYdJU/DOVKPPJdwexhsvAsakI8AAuOi5WimVj9RZq8BIRAPJ5ak87iKT7e4sHIrwqvhBimMGcdDldhM4LuCsd2s0An9lwRWZQkinmW7EXhDZom7/j+iOKyOIHnJB50KLN/Mfgf0pD0q50HLSrxjrJnxCCY+DHGY4LJsbWlOUNRTWlK7xw1LcWpN4p/Smwis0H8JhiNEeXNAEGFGgiIveC6ScnXNwTVSJFFhSwQk9USZfoquK+Lbg0TVp9OL6JsmeRGiLTKmtCVE37jx0LPK3wV6HRnL11YhlWCNEzpteG/2Ix5Wptp6TDmgFoSzpj9abhZM0JLAuRV7GEzvmaoqO6YiY6FapwXyYwfvGsYEBvplcn2Iduexs/58QssB5xLIv/L9oQowz4RJnGScWprhHeUvLNQ6K2waJfR7e76o2J5VW9nmusKX5EimMQkQetYfom7wZBrW5abcv4ZOlR3Jev9qgceaJ+M0ZF3QMWF5e67TZLkSf6rcds/bLvNWi+ihJPK655RqC8siBoMwUARDxmod17scMpKMNkxvk2rNXcJwW+jOEVAGtIY8LDvTmvhOchHBW1UhL1JvJ9sLX0tTA4wWu/EMajXUFiWV/LyU8F66dAh+njIWO9xT4bXkEHbF15JZASRqu/hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(19092799006)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8FR60SWh1IMETPmb1BdYKmzv8TyU9K2gxlQ30KA4TLU1wPvWF1+T9W0wx16E?=
 =?us-ascii?Q?Y/2RrF8fqUMaGUwYbPLXyaE703jtY0UYKlMYFDBWunkxlxT0QJLe79+4EKPt?=
 =?us-ascii?Q?7XxHuvBletE7evwNoluBiG/D58gBxohRXk1KeGJKANoFdxaCKmziRdnDpIpN?=
 =?us-ascii?Q?HUwJu8eR2b+ePQcOpD+c/YrJuwxYMHCLyfLTHucnCKG8GXB7tyqiSDM79Wq5?=
 =?us-ascii?Q?AUFag4OIFCju0ZU2WoKE5ckB+UjD5ArpNLZikgz97mKCWvl6NLjzqqtrb/4y?=
 =?us-ascii?Q?8BIG0bVxQO04TumdkjZwapTyjMIYp0N5RMBzSEQRw0oscFsoH7lCcXloC2/n?=
 =?us-ascii?Q?QSpTEll3Ss4D204JoVTxXlTBQqzbnMz5daXLeNmHWT11AM+8efucKZwbx+ph?=
 =?us-ascii?Q?n4boMV9a4NhHxvbUCB28JqoF+W4qX/uZ9EI7E3j3+RkAzy365EmVfSwnZRkX?=
 =?us-ascii?Q?PiBjjbZybhhuEMvJyXtMbZb5jkdrrmPSrzzPDmpd5qTZBa83gMBjai/CklSZ?=
 =?us-ascii?Q?dRqTM+JP6tSWPXgec+UGLl6yQYOnJ2GMWq8K4f1QBfzePQZSa/k5fuJ5qP4/?=
 =?us-ascii?Q?+9uMMuo96Gd4mx32LEujXJ4m6BQz80xy0hUMKvXxzSynMwgPyNeAHsK1XX7f?=
 =?us-ascii?Q?IaHMUTt/PD9WbU6w/wEhVIXvqFrqaWrrdp++9YJZXJRvTTDPJit1Zdbdsufr?=
 =?us-ascii?Q?MPQtt/tpM5ZadGypSRCKwABmwmaH7MR1C3ipQIQgpJ6oCtxY493smeBh7QF4?=
 =?us-ascii?Q?SgkbDttSl/chA7YozFZRZdk0XWrG3zpYnBRK3puCKUlIipvJzG5x2LkyGHpj?=
 =?us-ascii?Q?yx+T3Vh4jhGlkL/+a/nrlR7ffOYQoXJilaYORKp/3o0FwOiQxAdbKk4sTwFN?=
 =?us-ascii?Q?+aH/eqKLuYwsjF6L4yQdswsuj686j+HeKXDNdkBcS5NGV++o3vdl5He5m0xy?=
 =?us-ascii?Q?YncbmWxJlDgchGgBC4Dbp7nJfGUDIGpuFalbpSUN4hDAu6Av0V5JPopa1M02?=
 =?us-ascii?Q?0rJRy2ASMMv0dBhvU/sWLnXBRJirdqDeCuEzTZ19ccgDd2am5C19WdKP81y9?=
 =?us-ascii?Q?uQR8x0wwIqS4oycHgL4gh5RQBh7gusKTfryBdygepBCovsKFXBcY6dpml0La?=
 =?us-ascii?Q?xyJngKO2YMhe7SzYvPuaZQHnhWMPkN1aOIzDg9n1cAFGB/j97tsl1T9HEuwG?=
 =?us-ascii?Q?Rqeuo6yvt1R/iid2oOx+F8rUhxi8a3H3lyh2AP8Q1jUHTkbVL77CSQSD/3pp?=
 =?us-ascii?Q?+x1lsIVuGHKDRNLp5hw7d0JZCxese2URdrbS3+Qs7f0i6rczvVkg6pxn7znD?=
 =?us-ascii?Q?eBaCBss10a0Fyq2VvzftGSb53syBWjhWtXyuXK9om2VWLcGTXGpw7C8bgtYz?=
 =?us-ascii?Q?JCHCB0a9v5bSg/jQmDJ75B045NQWjHsQeIpq3BG3YuCdV2pSGLgfynR2sHwQ?=
 =?us-ascii?Q?x8GVkifqR/tNEITJ3K8D9R0tDm3lsLUfQTtMixdRoLPTWMZCtqU7skk3+Ya0?=
 =?us-ascii?Q?+MdoOZz2h2CeZWT9ts5Nx4Oeq191Dh0xb6Gy1csm4IZfXVfC3BTPq5HqNE8U?=
 =?us-ascii?Q?SNY93pG2aIiZULH8gwHq3HcuQeyFD81yzFV35IX8wijMCVNZHFozzx02eDaS?=
 =?us-ascii?Q?xFdZSz0phC11Jfic4h6O9HnI0JXEOyJw/ddhngSB57se9GNYr5mrqNv1aTqj?=
 =?us-ascii?Q?bmRXSNBI1iTbIY5II6/kXmg1zkDxRcoESWSZWhIFlXeyybrfu0na2v/Kfq4J?=
 =?us-ascii?Q?PIaWbMMQ31ofxvYkwsNwgU3WiqHEsZ7NyCDYL8PcAGuoZJmQRuRc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a3f26a-0fe2-4b59-12fc-08df3e44f75e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:36:43.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8MaaG4ut1ETioq1/N75V9wOX67rR3k0gk9ZMqqkgKY+hUIGkosYy4+N7pscPAKMlBfb3J59Kbk3LA3XOxhe0+34r3lMM5n1n48cojO4OFOZj6KOrQSdOy6HHhW/4tB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395
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

On Wed, Nov 04, 2026 at 12:51:52PM +0000, Ana Bobillo wrote:
>From: Ana Bobillo <anabobillo3@gmail.com>
>
>mmc_startup() sets the block size of the card's block device from the
>READ_BL_LEN field of its CSD and only caps it at 512 bytes from above. A
>card reporting a READ_BL_LEN below 9, which the SD specification
>reserves, gives the block device a block size below 512 bytes. A block
>that small cannot hold an MBR or a GPT header, and the partition and
>filesystem code assumes at least 512 bytes. Nor does the code bound an
>MMC card's WRITE_BL_LEN from below, though mmc_bwrite() then writes
>blocks of that length where the block layer passes 512-byte ones.
>
>The check in blk_post_probe() does not catch this. It is left out of
>SPL, TPL and VPL, which commonly boot from MMC. In U-Boot proper,
>mmc_startup() runs again whenever the card is initialised again, by
>'mmc rescan' or 'mmc dev', or after the card-detect poll has seen it
>removed, and sets the block size of a block device that is already
>probed.
>
>Use 512-byte blocks whatever READ_BL_LEN and WRITE_BL_LEN say, as the
>code already does in DDR mode and as Linux does for its transfers; the
>capacity is still computed with the block length the card reports. Only
>some old MultiMediaCards could have blocks that really are smaller, and
>the partition and filesystem code could not use those either. This makes
>the DDR case redundant, so drop it. The SPL does not grow: imx28_btt3's,
>close to its size limit, gets 16 bytes smaller.
>
>Make the READ_BL_LEN that the sandbox MMC emulator reports settable, and
>test that a card initialised again with a READ_BL_LEN of 0, 8 or 11 gets
>512-byte blocks and can be written and read back.
>
>Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

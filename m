Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C5606ABA9
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m3pB3fjY;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U8hmEDOx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93365607EC;
	Mon,  2 Nov 2026 16:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdbgrfQUXa0n; Mon,  2 Nov 2026 16:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73B08607F5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793636563;
	b=H1X9Og8x9U1mB0hXZ19ls6SRRfs6tk0jo+1kU+dpML3cJatnrEYe64OSQCPiVv99kQF9
	 GlgvWhJGt0HAMLi5ciOjysBt7ar86oO3kD731kAPmTrVpSEt2p/NnHa0+1vDDWbjOYDTu
	 df2FlBHOFsN9mqj2Mmh2dqW4Wpa1INVuYtIBpTsJAobkNYap9xYOy9jzt6Z46o7N3KBfn
	 pEJuh/ExUgHb+rTq9blYwRj1TvcKejIUvO11DTXgaU7LWzCaY0fra3arqVG1B6BDSk6Tk
	 +SZnpg5el4Tx2RooUk++pB6/GRja0sgpp4HzpfLUKIt2k7sk0nqI9vZXWI0zQsRGFNw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EYXEGksCO4rPk+y/9oeVx5bV/hhL8i9KkycFjD5KAeE=;
	b=CZs/N3k4NPw1cwUV4w/1BqyaSvuxXpN9Bnjg65Av8PcaYlekhHp4AwysuA2B5N6X+VSf
	 lq7CvCz1wS6EIOyBlKwAgaSSDEVyJkwhpVBl6HFdiEWK4TYV1WP9TexT9CiOkRf7KrgHm
	 MbxbpMo9iDyg+3DSy6l+rk7BiiffmkX7dPVe4OJR2VAO+fVe+d0Zcfv+Jg6+dM9wgLjMS
	 Vfh7lr5eqSCqM/H++nbCGlckVJwbG0g52o57KSQlhpRFiH0S6Sp0N82Jfu1wOBkQFH2VS
	 fbofLayAlujlg2oESezlTjBQFh9aFDXMq3P8Ti9VxgGTCit7qbLA/qXcaXXSfLeG/Qg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636563;
	bh=EYXEGksCO4rPk+y/9oeVx5bV/hhL8i9KkycFjD5KAeE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m3pB3fjY8L+Vcb0RyYBAsk+emgPuUHMkvVnoWtWiRbyndi0dYtEzHSLsjDHnD5/qP
	 D9jUurHDUJw3W/x6ipOmxtwnEVJveLkDnBcGZ5gHhqZ8jTB87KTX4W3O0+Wyi05utm
	 WOA0vD5mhMlKaLl0KhNdl+ll8wCARxNwpvk9ixN1FRYCn4cKf3tBshXkDTGQgqgUOk
	 7waOuiTnZOi+oBTvMXEFI6z0yenKVuHBpmsnUwK5yDeOszXqfW1ktzL6Aa/62Dh0I/
	 K/tg/pMgyzNtVN6+G+3su6BKnrt2b7acmUZ7XZdey0ULGe6mPyhxvSYdNi6cu5GDaI
	 8Cc1qX8N2MvaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73B08607F5;
	Mon,  2 Nov 2026 16:22:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFE8B2AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B57BD80D30
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFWWvWv3yX34 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 13:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08F6480DC8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793627081;
 b=DhRj1Q4alc+MIIvmkrr9Zuqa1kbRaHWT2k6JVtNyYCCqlUZWLCywg+hPZ3Byeh4yYgga
 CHX/RI52rApvhGP/x77oo7OmoW6JNBw+4Y5ZEgEZpomo+IF9M9gUmYREqUr4FChdxC5pK
 xqK2dUzsmlCXhJixmlTRbm80uBFksAcZdQGSYi5jSs3zeaA68HYACkPWq9q44Oanao8GT
 DT7p2hLEvn7qrzrFyiDp2HbibF92/yN1e7L3tu+D7eY8N1dfmRs6wqOo66P/6NYE7LEm6
 k9pwLUNdePNWWILz+04/UyTOlXPhredmBIvILlfyVbJUhhjNSbK8W9zjhVrkCEc2GYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793627081;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=EYXEGksCO4rPk+y/9oeVx5bV/hhL8i9KkycFjD5KAeE=;
 b=MBjaYO81oM/X3Sa3WxcnY0hVqrq9amksy5sKhO6jjXagdOp/Oi2F803HD+k03IX1zPXO
 K5FONzMaglj/GorBpRvb3MXrPrNUilyAx3iw19iqsAbvXQYzn03D6W63qUhU78ktESOl2
 wDsY0LF82Ga8GfImfkKRBz8mpslhsqMuy2HF781tTtARU8pc2RBEUutu6/ZmH2Lvuqnn+
 ADQHXJKrW5rMAH0H4HAn62toqPJkjpDREwIQYdUKNQavZchnJqtNwRW/IBu75628Y8xMo
 i5VXe3lcWCqs/7Irb2P9K4yKnB5f02CmmkdnwTbUMSGU1Ud8eFNs0Gdqsamtv2JK8og==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U8hmEDOx;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U8hmEDOx
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08F6480DC8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 13:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYv56XrUlyjWblAWEpYJCts2QH+DSBNbm1wO7MhyB4slHS0FnSNNGd7sH4P7l3I/kzZcfyWGxKEerrNGHoOJOMj2Be+sO54vKhOZUzdczaknEu4SAcySvTJaV3RA02RXfM0A9KOWN+UGFRV4krjTg8xerTa3SU2Jw5nBS1WOzCYohTUBRCXZc273uXhcwXRGIzjg+RrltQjxyg7M/mrxZ0OOJDuoJkyD5tw1KgwuxUBkRFm2tlNcNMT/gD307NfkLpPlxkrNgUsK+cLDSpRuBH2dXRPLLDrW7wXTSrwTOp2yY6fkhxbS3Qc9Aj+G/Bo/I/GWf6A4bfB//hbIQY0XEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYXEGksCO4rPk+y/9oeVx5bV/hhL8i9KkycFjD5KAeE=;
 b=sSy4a77gtFU1nYpCsYToabxS+c4fdwYMsbvzraKsoJQPXpOYjCUkBWOjDLIPFQa4GH3uEaBNCHgy7ZZfqP0wqOw0MiIEFfReD3grqdkiyJjF60Z+KsYHsgUc3VRD/sTgBq0IXPIxiiBkGdh7QLafna/iRGwB2HntNW0eSvFZvlkgXg+s7SdGuG85s2TCMaFPpKdu0bGALfJjBGkYuBCZ2ymABCSrggB8lvf0BdlJunFcnUjCIZJfeNymt/ZsYAisgfs4mNc6qDkwhbTfNsrCt9LJb0Tgp3MkgXnGul2N2sqGbGDyWYJ4wrQc1nwUTBVA2bxHM1Ii8jOcb4erEWcyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYXEGksCO4rPk+y/9oeVx5bV/hhL8i9KkycFjD5KAeE=;
 b=U8hmEDOxQ5U4YdIUm9NTEz5qmpkqtmr3tgFVT2hWYUTJYdPeFH88xQ3joAGAyS825nrKSgg7nVW8k8xfy73EwNcZ5ImvjAunktjx6cOR2EM7oMiC2CrB7agV9YVsuuxXqOUcT1XW7UC94eQGcpN7uV5mdyXPIcoLKCo8TWcUJprvrm+tYzVlErwlh4+nwB/iE/u9WtO+343VpUJ7xS76Y6a5XQbS/CCm4menu3aiPOu8V204Jw1/BPvqMbTW1+Dn6r6Qga9xmiKxZ4GIW6K1RuQuxcuABzGTJ3OzOSagSgyQcE6DCsFpZOmdKMyG7vcztPM62QrxH4A+ORUuYn2yCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by AMDPR04MB733680.eurprd04.prod.outlook.com
 (2603:10a6:20b:749::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:44:34 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:44:33 +0000
From: marouene.boubakri@oss.nxp.com
To: u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Guodong Xu <guodong@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Subject: [PATCH 0/2] riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2
Date: Mon,  2 Nov 2026 14:58:18 +0100
Message-Id: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::12) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|AMDPR04MB733680:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b4ffc3-63dd-4b24-bcf0-08df38e76d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|19092799006|366016|261021121427099003|56012099006|11063799006|261009223027099003|261028144727099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 22EkYzYb5sjzHW+98yOntb09+YgvY3q7LYfoCSRA5+O46oWHtO1zmcVdI11aqsF1472w1ib8BHUQNclacdYmByTgayL5wQAQOyaBHUkWBrEjb0YecvWXYuM4a6kYyCDmrzraJdFt6ykV3hUrXvtkHRDUERGCwRAI1zPX4nE4nLsCp18sO/4yGeQAYnH4fe28XL7VmBhtxuRrrNefFnb0d8YGyFXp2yguvQH/NDh03kkLCM3cJxGwM0m6Yz6qQfr1zQMPrzAvLydETjgwolEw2BI29XPL0LCRHb/InyE8Z32237A8MAIZ9v7tFPqIDTMkPSvXSlKxGgkvTLFxKv3C82x4E/7qCzY6uRLzXJYqCH15D06OOuxSpUPKoX91Bu8B+A33orbdfL4pmap1s/SNhLYkSmF2Lp8PNWfpEsVAoPlUXFOGdv3xsxDQDDtB/RIl2ajGOgqxSF5bcaQ8PV7Rq4yW8Aae190l69npufeCLauqBtdEUPEvcUWFdVyC8MZyHWVpO5nHO0EB0lSCEDyXIu9NtSmvGEgfFASf6KRRzpRbp+fJiCAGHXKw/l5ASQRGe2y2v7NsysuVGy43fblHF6Q/PsLfADU/Zeu07twd11AkOwBEAAABQewMhzRjw5iXDmxvYfJxvw2lOuwiX22GzbyP5/UHoeUXsKbVPts67fI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11203.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(19092799006)(366016)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KM1TnT8MomAQ3MKL+hBsL76F5Rwzn6+c3F3C3g/zo9iDRrNV8kxTZI3bydL?=
 =?us-ascii?Q?HgzTQzP+sEli9I765ko1D6pMo93HI5mSnTvAJGsUbPMfoSCjYQXkeL6AgjtC?=
 =?us-ascii?Q?9Bk2BUYeztLeh4fBQUtMykuFd7gjQXXZEcIlhHXI7vAmASeSoVXbl7pogGvH?=
 =?us-ascii?Q?NL+2kgMbeFAbSLL26w7P0v3zpg/Ly6zBTQ8tbQkPMLdodO1kOdHWjAcW+XF4?=
 =?us-ascii?Q?H4Ar/Z2zzMTNsn3z9cHH5wF3dsQdzdXPDRdSInOKD2Ze1Kl/4IIo25dSyFRQ?=
 =?us-ascii?Q?Fo4f+3B4i198d3rIuwDoFAVd5a5m7/XKcbRmdZli7AiOJ+GsIKt3eCowHcEq?=
 =?us-ascii?Q?lt3fqZle2zKLQSyf0sF7zAr8jytKE3rsMs9A3TSEDkzDtXkKokVz533nIfMY?=
 =?us-ascii?Q?iWkNjB6Xpwxp9ohZSq7x/bTnvStzFzD16ri5UkrqwY81j8tsK+rv4givAqoe?=
 =?us-ascii?Q?oL+IQ73/saup/Z4PsGx/Gji9FADwKwH53g2BvOGSBBaM9g9Qrwn+CiYmHXoA?=
 =?us-ascii?Q?P1HYv4oWeXJ0tPJmKue+tlNHZ8eepuMiWLRXozRkgZstOJTHH0KrhBkEtYvk?=
 =?us-ascii?Q?sd6qUh4lp9ex3oFjl+GNpJwcT2l52QYWmYUAHIGd4iimiqsulG7rLvtYrcC+?=
 =?us-ascii?Q?04Ca/TV7ed3wFb9sNTT07qsnBy7oTPJlfOS7lbjhu7Dn5BUq2wbu3bAAeduq?=
 =?us-ascii?Q?yBULhq92HFok10wbA110fywivHmXREK9MWCSV2pFIgCVoyfodvTiGetVoCZ7?=
 =?us-ascii?Q?RWuY+aU5fpEH4d6M9fPtak32m05LeGocgEdm+f9fBEH78fEdjQi6RbsUcCXN?=
 =?us-ascii?Q?SOEW1XMimao8glZf5zqih7hZ4F2UQsBqR5htbf1YHmrZbWQkc0B83GIutkKU?=
 =?us-ascii?Q?l2NXefzboFneyaEgAfFtrxHyuoWXgGTjRMFCpIPhYKoddpdYcMn2yG+F4bJj?=
 =?us-ascii?Q?cdw35inrit3l8uhfuTqx+37gnb2/Ur0eKov80jSSUKpZwklAL51i4rfU0L4W?=
 =?us-ascii?Q?TpmVidd4BlDhsazVTPsKCFeWkcdTMThd1Whu0jt9wjhgYUMqL932gsby7/5X?=
 =?us-ascii?Q?V0Lp/YasrYAvz1ZQac/gPvkbj5DlH8WE5xuN2jYoEi9MHzkH4efRzFWjF114?=
 =?us-ascii?Q?wWjK1HvBAhlq6IagoMqjdqvlXDyz7FvsjK5RTxZqVGUkIO+C6UuwpyCzsi5D?=
 =?us-ascii?Q?vDNoA/OBUcW7bvVA3ZkPKbdS5y0GFXfMicQlmi5ZGXMHfmKaxS9EBwwpAvcn?=
 =?us-ascii?Q?e1ItHnDz0Mg94Zz9QEvvCYIRHpHgs3cGZSvq/x1mtyBF2QM0Dd4Qp3rnSyPr?=
 =?us-ascii?Q?iYHfKaUN4vPLODZD0gMhK421lgvnw7bk6p/uP5gVpb9afqXRX9xH8Vwzu5Xf?=
 =?us-ascii?Q?xyGKb9O7YTnuAQ+Y01Y6u8HSbxMZtLQjD5nKs++Xy9NJ8+ftIm0kEqjbZqvD?=
 =?us-ascii?Q?+HKfdt/j7Dzv3M/LYY/u/LGlhhds259J3PQaZ4xXwUtp+3iskezw7uf2fPtV?=
 =?us-ascii?Q?djpjx9gso/J0gtFfDvn3SVuO62abxP/oTUiP441E1Fa6jx0563VrKJM4zD9/?=
 =?us-ascii?Q?UZ3InjB2/YrXv4PAdx8TF3LNOGyDtVRwg3dDYPWA9HDXXSLILw6WYUmXGK4M?=
 =?us-ascii?Q?kNBZ7+qGkaKbPTze4ud/oOmJrAFvI2Y7FjiGNg2meRf3XuCTAPgQ4Q8cCCMh?=
 =?us-ascii?Q?RuUtKEcTj8lehiam9/uie4Cvng9BT2nxTFXqXyhGjWbxOl3qCFeNWsM/pcV/?=
 =?us-ascii?Q?uHz/YUYxyOGOaBz/xF1ytm41jdZw578ZlXJ9dF8OOMIAAVIAxQZMYpcrMl6T?=
X-MS-Exchange-AntiSpam-MessageData-1: rSqfKu+wbjI4ng==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b4ffc3-63dd-4b24-bcf0-08df38e76d8f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:44:33.8841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRbg3R2aiUrdxrtqt0OmWS8804UkH8G4HiWB84tlYhFW+dwYwpIRPPSFYfhdcZJuwB7nt0x18RdAU0/sOFJsGpBMsAZnt3DIWuNkSR6FlFdzW/XGi++5s0I9DUf8RHPLq8mKKB2BE6hJACE6TlWWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB733680
X-Mailman-Approved-At: Mon, 02 Nov 2026 16:22:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

This series adds support for the OpenHW Group CVA6 APU, the FPGA SoC
built around the CVA6 core (https://github.com/openhwgroup/cva6,
corev_apu/fpga, release v5.3.0), running on the Digilent Genesys 2.

Both configurations of the core built for this board are covered: the
64-bit cv64a6 (rv64imafdc, Sv39, 1 GiB) and the 32-bit cv32a6 (rv32ima,
Sv32, 128 MiB). The SoC description is shared in a dtsi and the two
board .dts files only carry the core specific properties.

As for the QEMU and OpenPiton boards, each core gets two defconfigs. The
*_spl_defconfig variants use the standard RISC-V boot flow: the CVA6
boot ROM copies the first SD card partition to DRAM and jumps to the
U-Boot SPL, which runs in M-mode, loads u-boot.itb from a FAT partition
and hands over to OpenSBI fw_dynamic carried in the FIT, which starts
U-Boot proper in S-mode. The plain *_defconfig variants build U-Boot
proper alone, to be embedded in OpenSBI fw_payload placed in the first
partition, which is how the OpenHW Group CVA6 SDK boots the board today.
No change to the generic RISC-V code is needed.

Patch 1 adds the device trees, the board support and the defconfigs,
patch 2 the documentation.

The cv64a6 SPL configuration has been tested on the Genesys 2 with this
series on U-Boot 2026.10: the SPL loads u-boot.itb from the SD card,
OpenSBI starts U-Boot proper and U-Boot boots Linux through extlinux.
The cv32a6 configuration is build tested.

Marouene Boubakri (2):
  riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2 board support
  doc: board: add OpenHW Group CVA6 APU on Digilent Genesys 2

 arch/riscv/Kconfig                            |   5 +
 arch/riscv/cpu/cva6/Kconfig                   |  21 +++
 arch/riscv/cpu/cva6/Makefile                  |   5 +
 arch/riscv/cpu/cva6/dram.c                    |  20 +++
 arch/riscv/dts/Makefile                       |   1 +
 arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi    |   6 +
 arch/riscv/dts/cv32a6-genesys2.dts            |  29 ++++
 arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi    |   6 +
 arch/riscv/dts/cv64a6-genesys2.dts            |  30 ++++
 arch/riscv/dts/cva6-genesys2-u-boot.dtsi      |  47 ++++++
 arch/riscv/dts/cva6-genesys2.dtsi             | 156 +++++++++++++++++
 board/openhwgroup/cva6_genesys2/Kconfig       |  60 +++++++
 board/openhwgroup/cva6_genesys2/MAINTAINERS   |  12 ++
 board/openhwgroup/cva6_genesys2/Makefile      |   5 +
 .../openhwgroup/cva6_genesys2/cva6_genesys2.c |  24 +++
 configs/openhwgroup_cv32a6_genesys2_defconfig |  18 ++
 .../openhwgroup_cv32a6_genesys2_spl_defconfig |  24 +++
 configs/openhwgroup_cv64a6_genesys2_defconfig |  16 ++
 .../openhwgroup_cv64a6_genesys2_spl_defconfig |  22 +++
 doc/board/index.rst                           |   1 +
 doc/board/openhwgroup/cva6_genesys2.rst       | 157 ++++++++++++++++++
 doc/board/openhwgroup/index.rst               |   9 +
 include/configs/openhwgroup_cva6_genesys2.h   |  25 +++
 23 files changed, 699 insertions(+)
 create mode 100644 arch/riscv/cpu/cva6/Kconfig
 create mode 100644 arch/riscv/cpu/cva6/Makefile
 create mode 100644 arch/riscv/cpu/cva6/dram.c
 create mode 100644 arch/riscv/dts/cv32a6-genesys2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/cv32a6-genesys2.dts
 create mode 100644 arch/riscv/dts/cv64a6-genesys2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/cv64a6-genesys2.dts
 create mode 100644 arch/riscv/dts/cva6-genesys2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/cva6-genesys2.dtsi
 create mode 100644 board/openhwgroup/cva6_genesys2/Kconfig
 create mode 100644 board/openhwgroup/cva6_genesys2/MAINTAINERS
 create mode 100644 board/openhwgroup/cva6_genesys2/Makefile
 create mode 100644 board/openhwgroup/cva6_genesys2/cva6_genesys2.c
 create mode 100644 configs/openhwgroup_cv32a6_genesys2_defconfig
 create mode 100644 configs/openhwgroup_cv32a6_genesys2_spl_defconfig
 create mode 100644 configs/openhwgroup_cv64a6_genesys2_defconfig
 create mode 100644 configs/openhwgroup_cv64a6_genesys2_spl_defconfig
 create mode 100644 doc/board/openhwgroup/cva6_genesys2.rst
 create mode 100644 doc/board/openhwgroup/index.rst
 create mode 100644 include/configs/openhwgroup_cva6_genesys2.h

-- 
2.43.0


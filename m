Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C0606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p41rBFB0;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ro+cR5HQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14D8A81098;
	Wed, 18 Nov 2026 05:18:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxB9E_ijPq6H; Wed, 18 Nov 2026 05:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CCCE8109C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794979081;
	b=IRPwUF7PgD1SaceWOziFguW7V/Vfeq67yBZvicczOc0qbwboXApEx+0X+0t28tuMRSQI
	 bF9bFZXFyUXDDw1ugHK9g0nC3OQbjbCMYeYoGPBAEsGT7jJmfkGhWVQI8estAzH5wQnNI
	 z/xoznBAOMFQ5qrhAa77quNv2NyTwTCdkzeagVvQ6gIuFdznXyQcOQ9XWW7bV0FGpPpbi
	 /DHHXkSuUStBK58HHAhzt1JGAYI3fkH32LUzdfwUnSS5phsW+xd277o7Qn7TU5wvqMf8o
	 vL4TItDwVT2J7z4sUC2AD6p76eQBwiZl1RCTLDetHKmfdltv530fN3BcubeuTjvhccQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794979081;
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
	bh=aZ+kDZHk/DMUw4xhdmZaJwBllQaZMFIsNXDPnKG0f54=;
	b=eGOkvMXQWQng8ZFHvzLCvJyY5O7gBXyThGQEaKhw6iHAmEf+XPy6vDnlpaymtf/ziF0A
	 uef7mT+h7vwj2hJ+qL/2qMqUeUNkB5iOuE2/CaSSwB7nVMcmSXp3b3nYes8bOuAOVCto7
	 5OpIHD0cF0u/baSZZqs6ro9rtsO6b1AqAF0hkHTFkAz5FtJSUPkX5V6YtGids4kZJUv+g
	 zPXAJfRj7++BOZ+1SetNG8qHPc3r5xuBdJUt+nA4OLjf/5l2CugSBp/YdWTUxRj4XSaeF
	 4x+lE9B8QqR28k98e61cFwuGdu5jSkuzL3odWkP5vzhhcKXkAbbX6J0SsxB3W1FpKzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794979081;
	bh=aZ+kDZHk/DMUw4xhdmZaJwBllQaZMFIsNXDPnKG0f54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p41rBFB00xJO1proCRWZj2cxowjfOUmzw728Ra2QSF4rUIvX2uosnnqp1yWnk4JFl
	 eivUNUUvGjkS7i7vqt3w2BmJoIV7f9vCA7WnspctYFKMLHXrWlZFu8tZIcXqoqhJ48
	 7W4ojDvdKSAZV7T0f2EO4H+AglLp747VvV+tjqsoCnVMBwjs3AOx4/JtKSDW8ZAin3
	 FK/COQkqo3HIjEFDm1h9AsREeuUe4iV1M1bl/W3lsPPZ4KYfJ4q3fqdl6LrAPJ4L1n
	 bP8ZABzEbOaFqKM1f5Wp/ZrVqAeXxvVxzD0J+fpQb+yfOPVqQRFVX6cYE9q4TddaN8
	 OajeEWGXq3sOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CCCE8109C;
	Wed, 18 Nov 2026 05:18:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F7CD9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5560D400CD
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRimA3xyseVo for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 903BF4005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=Ro+cR5HQ
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 903BF4005D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ+kDZHk/DMUw4xhdmZaJwBllQaZMFIsNXDPnKG0f54=;
 b=Ro+cR5HQvArZKjPPNFTAYHjQTmkkowEd6kqVmP1YLHio+tSqTCQJy2VNIYclJ9XzawZFszf0Gc614v4iv1QKs73HnEAVwaww9Hu5ZBX70mY4K4xPz1HpcQD+IVJE+/wwl1nN1Zj8hTOOzAoW72RpyeNIrO3e/xYXBxUNw/WYI9rUwPhX4GHe6vNDmRqnhDRzS4GH8tNJaMiMeVSaTWP7hwmaNeuVXPsejhdC9++gishr+jDo78dRidiT+WoxFiERXAbnrcUB9Skog+pbCnLHmC5ay83rQ1FWNK/10NQ7kHhyBtKb//Tt4G3f/RTKE11IOW9v4LokVTZ5/AyPS2XzmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:17:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 05:17:54 +0000
Date: Wed, 18 Nov 2026 13:14:05 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <u-boot@0leil.net>,
 Ryder Lee <ryder.lee@mediatek.com>, Stephan Gerhold <stephan@gerhold.net>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot-qcom@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/3] power: pmic: Constify driver ops
Message-ID: <av00Haw-CJbkoerR@nxa18884-linux-1.ap.freescale.net>
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
 <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 407bac37-877e-4862-547b-08df45334c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|7416014|366016|376014|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: BKkOZFnWf7WGu0p6b75Kd80+5zAHzjzFyIpTHXQOK8feosgCPb3eKlRfWo0kiGYor5lG/tUyZDUyTkIjVf7uFxw+QTASWJOuShzaTdSoFBKIR4ydipTTs3aeBZiCI0DWEjU5jjbNm5h1fNmOhFKEdHwegp4n9lcERnzoGdxDG5vCK9gucsH2VJL/xV/yF3Iax0HdX544787ABii5ZLVq3BpSl1Ci5/FwinKOX5w9LoNSqwXk8fQOv2sDqn6JYezcHdygq0Hvw4o+jamQlpux3yHWm1Fb6c+TTuvvOCHwgWN5wSWMsx0dZiX8M/9uwbgbOiCEqaC8BlsAMp3VKBOAuiVd6/TqKLQVA0eVk6yQbWs4txJWQQKAy0d7uqp9BsNUCXiND2hc/iqmHnp//MEMdSrJIk6/BEUflp+/HpCRYuMd7+3WDzaRabOPNqnXr6aeTqTHygFK3L6vPi+PK/MsQIEF/SuW+gEd9Pvrljq1xj9SeQvDQMGaMml/ccgyzAyvUL4ryG94JqEwHbSbnL61LxIK1pDcf+yF62BPTuRni0k6Zre+CKNlkCqMQrjg8VB98FNzn/b4zk07LGaMb+nTtEngIZAKBX3sJazfOBOxAH2mV75GVKddntSTaW7DaSEry4ljKTmrvW4BHIfYpRyraZqnWzE2v/7KCEnUSngW0Oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(7416014)(366016)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUIkw3fTx1ehZHL6AVQk9mkB4nHnF+YngcSnvo4oPE7hWWYIhsFl3pM3IcuD?=
 =?us-ascii?Q?G2CmwR7vgzXsiKIuCZwKzuXm+qbUjixvoQGr+vSfAs72L5At8P6VczRiFNjv?=
 =?us-ascii?Q?3zYO/usBqEciCREAe5cE7hSTvjULrdJBX9+DDF/AXu9zT4od39pdUKEF5SLs?=
 =?us-ascii?Q?WtdUdpZwckZ1PfAmpIrmqgndpPyg89NueUmISw8IttvjTxTqMb4+QeKvTZjX?=
 =?us-ascii?Q?KCrcOfuYGzMAKJ+oM0a1RlNdnPbrG2o+3JusOOnw43sxY68zyu0Ly161J9TX?=
 =?us-ascii?Q?SJ/qJ7a1sdkv2ZLxS6EtmqaIq+K1LiTQe6lCxcr/PSogNIpeFDdbgDZHEplb?=
 =?us-ascii?Q?TeaJHHwFvU5C55Wi9R7PdkulJWlz5rFrSA5fSoVnfcasbs9zrYlKrw2YJUGc?=
 =?us-ascii?Q?oGOMChEocAZasPerWrx2Z0ssYJM1MnM/oPSl47WGL7zAYptnOuiAQtT6rAvb?=
 =?us-ascii?Q?CPXw4SbjVbenIMCXou8kgvQsdOvR29jhol2lgaaj+5Th+D3WaKTRniDTJYsn?=
 =?us-ascii?Q?cFOWDGk0/mGlA7pr2Uh2q5qGSKWleiiwYg+kkRIq6WZLhY4/IQ3iycOltCRF?=
 =?us-ascii?Q?Mmwd2wFpgQp2/NRDED3OmM87sj4Xwhrf1/wrQ5FKQxVXR4AhQ9Kd1sedy3Il?=
 =?us-ascii?Q?QW5QjhTP/uNjnjECRWAYqgDroGBeYWc1681PDkKAMTFBfuHB5m2l5JZRsT63?=
 =?us-ascii?Q?WhJmVEddJAJUE8N1FNGl56I0g15+4xeLydmHDlRRV3Fhl5Q6l/3CxKnNQw2C?=
 =?us-ascii?Q?7N8dDXkjewc6GUTOKehuSrg61/RJ/VmUFdg27Pf0LeiHku4pQTfHI1IAs0G6?=
 =?us-ascii?Q?12OJBuoKSLaEa8fgH0ANBHbKkSnys4DDFOtoaNvEGEUAd164FLhcCI8m+sj3?=
 =?us-ascii?Q?DYOX0AoDn0iHFqDz4rKCMflwy4FnuHPb9kv9kf94TGqKg2F1TDpx1GsZIBfF?=
 =?us-ascii?Q?lU0HZz1WsOIGW00sWF9lclNotUEW+VXw+4DfXYpWARVuz+hiQTPnNvj48nn6?=
 =?us-ascii?Q?jF6u7/v/en6yYCqcloapyfA7Nhrz9henHOEnueQy8Y4i4MDxAD2TbHZYBHYO?=
 =?us-ascii?Q?FiHtpMlmddkdcb5fbxtFeSPQ35wcgs+97clvt9RU14IyBPXQy7BqCSXDbfpk?=
 =?us-ascii?Q?AL6NyN/BTKz4Xx7CwVPdzOC7eX9AeT5Yi+u1V81s3S+NyWrG9gD/4OR7fDQH?=
 =?us-ascii?Q?GWe3gBO3rWpXyghgYY6jAtCIlchpqH2zhdpPRG6EsgZZdgYj9OdeFK/bE/+6?=
 =?us-ascii?Q?jY6H9bA60VW1Kw86iLwJ+6Lr6Y6D2KXjKHrO4OpbgdamqPstBad9olEHF8WI?=
 =?us-ascii?Q?Mbo7zFPrGignQ631ypZAHTNKuIba5/etM0NTqbaX53qRSQdrJo9aNGnxaxbA?=
 =?us-ascii?Q?Cmk0iNM77G4bzfeW/ouCULf7hXIBOpj5ydwVVQCRDkLKtwwii6nFZGBBnywE?=
 =?us-ascii?Q?uBxWXnlZ/xXdmwbRzzhFBjXOUdEhnTJza5WGpF84F+Az9sJxivtSScb/kw42?=
 =?us-ascii?Q?osG8YMwXtXFe62sPFFcAjjPg3R9gbHUur8VPli6MtBywODmczoVsSgxIRbMJ?=
 =?us-ascii?Q?n5boXy2lsMlSYON8DE0t0LzPADKn7a/2DAd5v4/U4HIk/Iyq4NOKJYEJ+o19?=
 =?us-ascii?Q?sjBk+07apTm7YVPBP+gc/7rFB09N0Zqi+s1Y+H50kfbIy05fpgQpXephU3HB?=
 =?us-ascii?Q?FLBEKxIReiuZbxBkX6RAf4Lbx7x8J7gjjZwQ4GfNCwVQ88wdXCE+ktBYvZ86?=
 =?us-ascii?Q?boQwJeD7pxr9Baek35II7VEj9HNDpuSYvkjvCTZ4PptYfxlmiq2P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407bac37-877e-4862-547b-08df45334c9c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:17:54.1920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6KtQRzBy2xHbeH3ePuayBvWqLLm6drppjvCXF12RjnT7qJ+r9RRkizWuwK4+wkwddEH9MDDHUzt1qWjoXlb4LM+/U8ZQtPG9r7HrVCr8v2je+BTpomHfyalgbQVo40E
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

On Mon, Nov 16, 2026 at 06:41:25PM +0100, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

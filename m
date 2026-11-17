Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB9606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pYTuaHxO;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=jyyASQCr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 413E940807;
	Wed, 18 Nov 2026 01:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrEq9UYYtF7g; Wed, 18 Nov 2026 01:25:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B03A40672
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965150;
	b=pZJM7XzpzkO+QMdTH3u0d30G/0Q1UoC9j35mYQ7U57f0cTUja0P3cobd9trRcXHZnN/d
	 d7DxIXDKShKnNFwxx2TydQ5+z1b6CjOMSJ+yTjIE6uBdTR+NDwxiTU6vAnurJAmhwTGMD
	 d2w7SuF7emm0hChTecKDMWYDouPz40HL49B2tBcNsqAVpPokpYstEUHnHxeQGtSDHs2X7
	 4NIzhgEAoepNNCkzAGMP+VwztYwewl06U/bPpLGEGuPXP57kBSBtEPThwXRJOby5CbUrE
	 pPqcpyygyvJKhMWZxYM2wMgjdvhV9+xyk/bO9wFxSLKyjCYPj4opYGz4JSX7asFTy6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965150;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dNJOHKcw4ghNVgTFaCiDkTprFsmBbrnUjTFF94r+qWY=;
	b=OOqqtxbnAIOvmacl7C7/3PKUhEjGsBnKW1DUlKH3FB+kVDpk5z/OA7YImSNU8gFYQZd7
	 mq2Ss/V0uGa2Jx1ix/AxBGlCeHncwzSzu7GceiFAJ9IiXfr7Q01FRbtNSMeSbOvFQ3L3D
	 nNxJse68BFb9HuGAF/JyuY2a24ALVkl43w/99nxLEW4U79KwBW9rYfKpTodYHqrvmU+N+
	 Y+bREkchOzjTbHKRTx8rPzrYtVs2mtnGkglJRsAnORxEiN/NHVkLOS0Wh1i1yuYQIbx9+
	 v7+7RWYJoFr1QN2+Wk3JXi8XOyYAQgL8xbiTzbi6/0BV4Ps76Hs9+wse6Tajr2SaH6Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965150;
	bh=dNJOHKcw4ghNVgTFaCiDkTprFsmBbrnUjTFF94r+qWY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pYTuaHxORt3oT2Ji8ieIkO4TjoGy5gTGPQGg2l2maSjfdSodF0/8ttSMi8+pQRoIG
	 sPMEjq6NkDmcBWgVbZCFmTcSEk+ZsBsDhB0PAgyIS9l/pKqjH2ziqpkB8PoR9Al2L5
	 WOWfUIhPhAsFVWU5g77OJT1gXLUfAd7Ox9+fR8ioF1nSxaV4RXPo19jekc7MTlkjA5
	 B5WiOGRiC9YfMRiEGWMh9+8ixEXV2FY/tnZejIm0H4DBbTJUHXmIHt05RH0eBGWxr2
	 UOHaELTTZiRZX4LbpvdLsyKV3fKLoFAp9aLZF1t6jOej/VdgXZ/l+Pnel9JCn5bqVn
	 8oGkujJ1wnhCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B03A40672;
	Wed, 18 Nov 2026 01:25:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D93C1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69DA780F67
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83_mYCw5yx5R for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F010E80F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=jyyASQCr
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F010E80F5C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNJOHKcw4ghNVgTFaCiDkTprFsmBbrnUjTFF94r+qWY=;
 b=jyyASQCrtcDYadD7NEdmHbGk946z/kRjoNpzxdBk7YjcCfEwqExE1Hgs4p4csjcJJX9NuUA4zlVc3hQWIJ+vv+BZTLGW0rs33E2uyHScpY3L+gSUbnRX+B/hw8bN2ri5woWzwi+9GCaK+NrA/0aDpjsdghcy4daXuuDokToglrmv8y+pVyx2HBZ+2jV5kJXcgfTulr+9nu5lqhHtNjmPkTiv/atLFtsQrdj99vqj4AdVMxd86UHqdSBZ72fE29fvXJLiXmOm5+mOFpzV/mGRTGAflWQvD+aG1lWOHbWridi9CHo4hhavtT4HOH54tT2f88hqCWtduzgy24Vg0MLeXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8750.eurprd08.prod.outlook.com (2603:10a6:150:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 22:05:01 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Aleksei Sviridkin <f@lex.la>,
 Zunyi Hu <roberhu001@163.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Mark Brown <broonie@kernel.org>,
 Yuho Choi <oss.patchbox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Cole Munz <Munzzyy1@proton.me>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/6] mtd: spinand: sync with linux-7.3
Date: Wed, 18 Nov 2026 01:04:43 +0300
Message-ID: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: d0eaeab6-378a-4819-3bf5-08df44f6d373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|23010399003|38350700014|921020|11063799006|56012099006|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|10067099003|261026121527099003|261009223027099003|261009221727099003|261009223327099003|261009221227099003|261009220027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +yHLiNEhFQF7D8idyZLCtoC88rQsiW4l/cU6y8BxLfDKItqShgFRz2E3wHjUPs6HcKkkLCzkaAk0YRHsfyr3b1D284ggyZXbzF77S6YpZ3wf1+/2uet1kPRk0hY/ug14MqgH+TNBrPlzD/ObEqIVFL42NutR748hqHRnLzTIfM2mIco/Iaepgzk8wlZ5rhi+ULAhU68cFT4tT8vBI3QmuxGyv+8iHXzDTyXP9IGVIl/TljO+1MdYxy59rwY8g3ralgP6penbrVw+vXpIBW2QN2fN7OHWflvpn0Qvme2wGNDFzqypOg6inMbITmuKXYSY8eQ/4FTFUbzZP+dGjja8+jIitaMSg4VSOTetEa1oYsjp+6Urq3TXyggpK47KQma4k1NpUUvUnKrxumMGI0qagJNut+rKiAuFfDu4Y6oBC6xbhTFPiZktoIciWxpcU5mBTLHR+IPhoLq285KC9Di4ZWpqJN+vzjKfGF7LNk5omwILptOnWjU/iPVSojoIRoASeQc/OqsiQg5oMOYwC404CB6rZ826ctg7D7gszj7ZwbD1TVZuggyKShNKKh8fmcKouhuydoIPYJX3yasbiPrK6QU2lfBmvquPrp9KzgOoI4ns7JO509oixPlslTouYYFH2LOz8qteaG8Js5s90Y5JZAR7yAbYS/jfqLlgegHjAtoLP65uArY5BH16akeKZ9CbmSaY/8U1dtb0Zb3AWSUOkzwSR6wcG9pkFakZlypmztA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(23010399003)(38350700014)(921020)(11063799006)(56012099006)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009220027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxBSJeY2IHBrYiAjX6CTpxjZimCiv3a4U8HKZcVmMAp2KhhYfW9dvZsp68b1?=
 =?us-ascii?Q?kPfsWo5amxeVKGRmCktkWtzM8/xajXmRMrU9FtisR7V7kwZI8JpYd6TJFFLD?=
 =?us-ascii?Q?gylB0YSfdYHClVQD0zry5Sgw1MWnT8zrpGPknqGeby57uj3EW7GL69KND4uF?=
 =?us-ascii?Q?hPRy/C31R3KBFHpwS3VtEw+OJkp2q8EcmBlakHX4QmVrtpTbh9qyYVYz32GB?=
 =?us-ascii?Q?pFnlxl51y8Xnb4Qs30+9RfyaEeZXC/DPZI/4PHUE38cCA/TIG6MmFSDLxTJ5?=
 =?us-ascii?Q?RqRGABse0SiUnUSspxi4gTzr6TpqIY+dmBBQ/6lCsZaqmFh3vmXa988hwG/5?=
 =?us-ascii?Q?o7WQ53b72FrhHAVvK/fkmXvqmu7bV2QB+bhwqEyGbzi+7anripZdfk04EtT9?=
 =?us-ascii?Q?ziROnIxV0QWEgCsYOLIJ7lpqQWtGluDys65Kq0kHrP1n3wRVAe1lTc6H+FAK?=
 =?us-ascii?Q?rziHBkupH2dh7Qm1ArDMk7lkZVhR876KlIzZzExqdR/snTiMUTRxyiOeFy+E?=
 =?us-ascii?Q?YgrQIaI4spVWadLHdX/NB1Ffd7WxNUDTqkvUgmh2hDK3mvQ/5/D83QsxorhR?=
 =?us-ascii?Q?ukhntQYNeuYjEVPQfr8CJDr2KF4Gkd3qNBF4/NrfTwqDacjDQetZvWo7Spy3?=
 =?us-ascii?Q?rAZGIXCPPpKq7MCNIsAllIIuHO/dVIfZ7+x4PYtgBB7iqFArhdFyKEAWSWr+?=
 =?us-ascii?Q?Nk3CtC3wXCKwrbhTWacCYP2AQdGk06XKeqHu384SEP2F3A6U/jFnOvobKHAt?=
 =?us-ascii?Q?WoyasDBUM5iMztnzmFntZWW4x8A7rwLLUjbHbZFXevTW8hI9FBl0BpuVS4e7?=
 =?us-ascii?Q?V1wCCjfrdY9bJ3aPDaERLCvLz4BhXckJu0jC08GgoRGRcytD45bZvrEse7p3?=
 =?us-ascii?Q?ySK7QRgp7ugAIRbqpnPZCajtIP5LKcLMXaKKBrwrmG9cgBVtYrtSLvp30LdB?=
 =?us-ascii?Q?FHD8G/ABDqgRPEzeH+I/6Yry8LEUzfw13IIwk6Ehm3+HkxZaHS8uDS+IMemV?=
 =?us-ascii?Q?yjBQAXcw1px0HgYbM7N9BgccBZx/OqTCeHqffJRXb4k1/L33oJhez7Wa7fk0?=
 =?us-ascii?Q?fl4Ze0EGgoSZufRs5Qkq5dBnfFOAaHBT6+1gZWStyaBBpCaUVvITwVB0+xpc?=
 =?us-ascii?Q?kcMRn/OtteBbDPCEPwa171vx1AKIdn0NzfvkiPXeI6+f7FEvcQP5hgOmEIgF?=
 =?us-ascii?Q?Zb4LPpSs38tckqyXUtx8pK0Lvc86E73Dpp2YzvQrkxk19Zmg4uxGr7sWWytQ?=
 =?us-ascii?Q?yRlaOojXt22vuBLIkpDCUJe9WV+jstMNsyDVa+OB8eTOxUQ6oqim3fG2k6nF?=
 =?us-ascii?Q?Q/FM+gY0Ogq0i97HE2XQAMbeT4jw/yTFDLDUmK0VqydnXHjuiDaW2U02uTYr?=
 =?us-ascii?Q?4VGWd8aHfyNUdwJjAQ89M+wXUm2+CvpFn6H4MCywaV6ciDjy6rNJWSTtI+wP?=
 =?us-ascii?Q?PzJtK4ABEwj9FW4g83wnvo0Z000T9On/iZxq1EN5fldskcvGYlYMC7aXnK1S?=
 =?us-ascii?Q?BN9yTSCeBb927fujaFX0crBcIew0VK11c0KOcW77cJgwSSVet0psik22/Ba9?=
 =?us-ascii?Q?Y6/abZmpDnTlep4NbvgxRj7FPKoGclE46EjXzNxjUjPiSdG1rTuiILzyZOxh?=
 =?us-ascii?Q?4YCEwwFDAYf4OPIRXBGNyEmKeDDO//gYewwu+g4H+9ZnRd2lvSNqtNcjMXru?=
 =?us-ascii?Q?HFXnPi/jn3KJjPQMKb4Y1VBjz1ulCfguLG3iBznDQTc9DgZ7DHvq0N6AnxEM?=
 =?us-ascii?Q?McpqT1xIG1qGnaJGzl/dsm24mr+954Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0eaeab6-378a-4819-3bf5-08df44f6d373
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:01.3371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0LuizioAFF7deE/7mZXbezH5Vt6rTHYl7jij0cuSAvXFZdNRgufKL/ewnnQn5Oqr+gjnlqtWZ8F7pbe4m7qBLFQ7lQ/ueb1Pz1InyZ9J/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8750
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch sync spinand & spi-mem code with linux-7.3. Here is a list of
major changes:
 * spi-mem: capabilities were added, so spi-mem or spinand drivers could check
            spi-controller for support of specific features
 * spinand: continuous mode improvements
 * spinand: octal DTR support
 * spinand: many flashes were supported

Changes v2:
 * remove dtr caps from atmel-quadspi driver
 * fix issues noticed by Frieder Schrempf
 * update patch notes a bit
 * split spinand driver update on 2 parts: core code and fash driver updates


Mikhail Kshevetskiy (4):
  spi: spi-mem: add spi-mem caps support
  spi: spi-mem: sync code and behavior with linux
  mtd: spinand: sync core code with linux-7.3 release
  mtd: spinand: update flash drivers to match linux-7.3 release

Miquel Raynal (2):
  spi: spi-mem: Transform the read operation template
  spi: spi-mem: Create a secondary read operation

 drivers/mtd/nand/spi/Makefile     |   5 +-
 drivers/mtd/nand/spi/core.c       | 504 +++++++++++++++++++++++++-----
 drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
 drivers/mtd/nand/spi/esmt.c       |  30 +-
 drivers/mtd/nand/spi/fmsh.c       |  72 +++++
 drivers/mtd/nand/spi/foresee.c    |  34 ++
 drivers/mtd/nand/spi/gigadevice.c | 117 ++++++-
 drivers/mtd/nand/spi/heyangtek.c  | 132 ++++++++
 drivers/mtd/nand/spi/macronix.c   |  87 +++++-
 drivers/mtd/nand/spi/micron.c     |   8 +-
 drivers/mtd/nand/spi/toshiba.c    |   3 +-
 drivers/mtd/nand/spi/winbond.c    | 466 +++++++++++++++++++++------
 drivers/mtd/spi/sf_probe.c        |  22 +-
 drivers/mtd/spi/spi-nor-core.c    |  20 +-
 drivers/spi/airoha_snfi_spi.c     |  10 +-
 drivers/spi/cadence_qspi.c        |  10 +-
 drivers/spi/nxp_xspi.c            |  12 +-
 drivers/spi/spi-aspeed-smc.c      |   8 +-
 drivers/spi/spi-mem.c             | 150 ++++++---
 include/linux/mtd/spinand.h       | 198 ++++++++++--
 include/spi-mem.h                 |  53 +++-
 include/spi.h                     |   1 +
 22 files changed, 1737 insertions(+), 298 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/dosilicon.c
 create mode 100644 drivers/mtd/nand/spi/heyangtek.c

-- 
2.53.0


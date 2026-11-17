Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF4606A32F
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vXJSrUx4;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=BfsLzglv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC701810DE;
	Wed, 18 Nov 2026 01:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6MxxaxZ9NY4; Wed, 18 Nov 2026 01:25:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E852B810CC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965159;
	b=Rd5mFYtqiorRuID+0QZLPUazcFBsTw1kDGufRgwuWKbnVM65/9MO507gG/DFaFRCk8QD
	 Ar16njUtwtyjBEDejEmXzF/Hz23DZWxZAddeYB4yLvWnNHH30ZIxors9lrp2Dnbyh/n/o
	 wnHqWtNVtkr/Hwc9f9egdul5J0gG4gQOpulD9JX6+ylbiqeOvbjSKG32hjGqvmoxN2KJc
	 LDIhNtKzaGUyo7NUhKJRSa3ig8rwwN8TPIbhE5Ku80B7jRxWXIh1E9r4zEVt1DsjibJ/j
	 VRFnFkiEH09lRxo3qkQ5yEHGRbw351KPg3HKkH/ZwwSdFSJ3AVG6ehRgaRdhIV33WIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965159;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cfE8i3qENWdxtFbhleG/9ctWm8k35U16sS0b8aQXEWQ=;
	b=rh4C75eOoH9Y8PJGJWb4djwZsVF4rrHbhgdS5QlPFxI51z7lX6xUQjAe9uLjR41c8ecW
	 hyVUoxuL0NFf0Gih7aPPaxeRuiaVpBxVowRgkLtrGIxhJ7Tb3uPjnjLXsDJHNDAB5N/+p
	 umWtgQrcJlshQAwXvgdD0tKA2PZirvv9QeBvoejWi0XJiGoejbHLgZpT2u9rJ/IdKQmjA
	 i6jWrn2szzUwvKQSVc+apFBL/Qvvl4KKxACqPDR+U9v1t+BgjEpNVsFN3sW9owX5/8Lgh
	 xtLjB9dJi3ZgghJmCQbmzE4lTP6ICKKcIzBYuKaaLrorXpLC8zM7c7bI4k9lakXoNEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965159;
	bh=cfE8i3qENWdxtFbhleG/9ctWm8k35U16sS0b8aQXEWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vXJSrUx4P8/KkpF2ElLU4fvioiLYr6D2VNIiDFg3nvjUnGVK8FGYHPZQc5kV0k657
	 oCMTIUqG2gAEKN1fDoUnCx8uYlHYxJlH3/QFW9PNjhKXdw7Sw7DrRHDtTADWjHZCEi
	 9Ss5xl0Y4CLFgdPoFohbNWCrYDE93j2ruoO51/z3yqRa1sIHPJiEvJG1JlRJIkfXPB
	 bEb0FnimtzSuh3nZW+Ba9Y1VFx2dgpHqNyfCE6aDwhYzDuY4FDT2JBN5XFGXp5n6KF
	 Y8D/JA2K5f1C8hkJnCx6DSBWzjd4cA7OzkZQXlVNVnSLPNJ0NDbNcaWFM1OsrcrIhj
	 qU8s5RTnSQu+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E852B810CC;
	Wed, 18 Nov 2026 01:25:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EABA1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1415640598
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-q4TItWzJvF for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 992B3405B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=BfsLzglv
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 992B3405B7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfE8i3qENWdxtFbhleG/9ctWm8k35U16sS0b8aQXEWQ=;
 b=BfsLzglvplns3sl9K7P3kMPUYAtkx/VAscc9IrOLlv38o7U64jmbc/Gl+XSIJFOxfa2c9OImAhNtzfX6F2UGEELdGrUlPfC410h0qrZh9y1u6l9nos1T8ZD9Lgn29zFj62/5P0c/I3ejWTBEYmbYuUSljbmBEwnl1M546hLrtrPES6W2UPaab4HfTiENCRFUPzO3RLlvbWqt3eH5RLbHxwerDqHsVL9OtwWvhS20fFu1IUKGuw3GKiV2Cj4pUHn9czoTldzxBZSZMMJR31wlnBlaLKH9z7gbJmk1nZXzbYwriIH+0XKlULCwlnRmvk9gLSV610ZbuKC967FcgkiXWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AMDPR08MB892675.eurprd08.prod.outlook.com (2603:10a6:20b:749::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:05:21 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:21 +0000
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
Subject: [PATCH v2 5/6] mtd: spinand: sync core code with linux-7.3 release
Date: Wed, 18 Nov 2026 01:04:48 +0300
Message-ID: <20261117220449.3134408-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
References: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AMDPR08MB892675:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d7cdd5-c079-4d86-dc76-08df44f6df83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|3023799007|921020|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info: liwYQhOcLt9H/B0r8FVn8pd5sQvO8rq+CfbnJhBDZ7KYKMZ165uWafLXzOdYiJS6F0hy79hgqB3Ahj2GKF1h1jjX7TIgh59uwIcDjeDUzwhHnjOoTNP65luY+jpKsAT+JREGlFzNy2tS6LGJmaaAfoumYEu77K3DtufhY2iL+Fg/SvuCAZ0GxiYikTQrEr7SN0k+H8YYEe6AiRRTXD74qMdkAVadKP/OR82JfA3BHQDa8T5wBX3LAFL1GOJXO31nIj9IBMVqVKIWOm4a+l+Ob/bdpe9zSNGXAkAkM6Yfe9MCUVMNibxzJn0isG89DFbePveY5D49GF7jv1fZpPW8dZDcVo17Xvsyn3vuEGvapwKfdZqZKd/TD0nyKeGhMeU2HzG9OWwgJFhxmtJfjf6btT271Qk/N7JTn6WxyKRILhAoDD6J0CZumEs8oyVmlMKRhskKxuOzZjzSzGVKUfnjP+9tYhBFf0B8nKrreP0HXfk/mUpXyfPv354OZTDE0qe6mSHnIB5UPnmHBgRRMnn93CwFCEiAXol1TrCc4ldDoS6WSY+3Uj8xKfbn9ndcrk6pfLJ3nWbkniDRz3+AOS+L0UvLrPwLA0x51k9JdF/QeAdgC4Zno3SPeMLYtECSBpKjpuoHXyaK9osRWpZsXABioVdu/bMLUgpmxEXYD92lCHR5MGT7ypRGb8Fj9/02GPXL9uAJP8oO0cyh4+O6krMrfL8P97yDhslIcIxzMhrpOQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(38350700014)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fk0Hsuot1NOOt4gHKoaN/VlFKj0/ypcBi3ioxTt6VHNevXrigB/o4ugbuA4E?=
 =?us-ascii?Q?B1Dzp69HtkikWxQCEfKQZDq5gvFx90wvosNbtN+bGr8X5C/ufROU97n3L9ju?=
 =?us-ascii?Q?cEBl3ACBmB1Lp/aspckNtBgoB8PBDTgcPNuzRj7oE9lQJrfSLbzwRKK5U5+Q?=
 =?us-ascii?Q?Y+sVcIbrY7kUgs084Eonvz5Tu6Rgo0ppZFDyxT97ti1pr1HDUazXDC1kAi0v?=
 =?us-ascii?Q?qPoEtt0Kt/50e/pc89XwWKv+pTYgHK/4MQPG2e8pJRs6psTd5i2hx0R7VMhg?=
 =?us-ascii?Q?B3PM/ST0m0CWgdNYLc85feZizY0dY0Es2fn2/4T2SwsjT04ipjOr9pwcPT/H?=
 =?us-ascii?Q?/9GY9tZ2i3YzEZezIzqiLtiUg0bIM4pKN30U7YP1tskPytvIOBRTOm3GH28d?=
 =?us-ascii?Q?f5pidc/YC258NnkFbInlb4Tfqhg9AixR9trU/EI013acY6TfSlhMxlKev6jZ?=
 =?us-ascii?Q?rNgRQxiEe7nZF7Td1Omks4SH+xXIIxeY4Vw+PJPC7d3mgrCkP4K4bxrZQk8P?=
 =?us-ascii?Q?W6l2447shgauB0jygN5vHgm7D8ipUVjK8unlIWBVDoTyzVtkiE2QT4LC2WL7?=
 =?us-ascii?Q?6IGm49a3PHAfT+FOBYpZAFQC5xiDNX5SY8A6yg2zdHdAtOLhEKNhI2sgRT19?=
 =?us-ascii?Q?SA2Q6Q7wo3N/Mi5paNkUotDwimLKIVzODrvg3/lAkC0bPJ1osUGMACS4FEjN?=
 =?us-ascii?Q?F1Izkfui4f5z39nn4410c0uu/AlHKyGy8sNokl8bW+3alYKkWTnOp+I2cPmP?=
 =?us-ascii?Q?a76TcryFYJkOsiXEEy+dC009NmkIySjsOCX2pZNKqVwgk8yhNw4m5mVxid2X?=
 =?us-ascii?Q?kBDjH1JZrUIFzmkPqxPzqmufikB65hx3+UmFCJW9ZszUJJpNdSb/JIQGOcDc?=
 =?us-ascii?Q?Q8K2c3rpWp4WnziPiJ6JTHmqzuNuGCrFt9Wpbl71ylbZAu7S3BrIWsmqRX5J?=
 =?us-ascii?Q?nrXB1v+pskQOEKNKElw+3E/rTXpkrGQ/i6Bwxxl5DRrJbjRIeQAVjhYFphWn?=
 =?us-ascii?Q?k5/9Cy3p03K9KEfvfL3osfliOVniw7QbabN8a4zJDw55lrU+CjAT36BUDG2H?=
 =?us-ascii?Q?+k6/5EpG5mGgSTfyczC2jADCrnxbKfQFEsJNblIihWbIDXq85GZ5TMFkxgdd?=
 =?us-ascii?Q?C/jk2TmeVll5imr/nscat15k2uGHDb/UX/EwU6k4ZaTfyBs9f3tClUEzsVdO?=
 =?us-ascii?Q?jekEi+gMDzirvx1zpyMc3TczZugutrZN2eWs1/KqbHMd/Td+sP1ctkcUSofO?=
 =?us-ascii?Q?NRz8zDs52m/Zkg3bNzOUgnt/cwCoWcDDgiYntMvOyXiFFVVTo2bvJNSi0/dd?=
 =?us-ascii?Q?JyLeji6yJx2IJKoHCt9LPi270EjnfzVJTnADF+TsLFHTqtw4v8m/Q6sqLS3t?=
 =?us-ascii?Q?YLUOXfZ27niljv6Rw3P3PLaFA4zMuJ3J73KM9IiHDDlBVRlnoh4DUhjSHrJF?=
 =?us-ascii?Q?vghpUbFMRYJ7BpYMAzz1kfFb8AwjBFyW4uM4EZpGZiBXwZqlX+7gRfGlJw8P?=
 =?us-ascii?Q?WNA3CtQn0+WEs6ZmAJvODTCDhZ8+lcLavQ5poat1ucslSC1BWqJ/ggP+0I+3?=
 =?us-ascii?Q?xBjDdd/G84dZENiYjnpHfigr3AZNrtgCugHgKaUL6zM7DmPl4Poz10NTiiGh?=
 =?us-ascii?Q?vhJ1jrcPHI5+9NQ3mxPDbItj/IqEUlAOZQnrwuClfmkTUZ7zFktXMhg/CCSp?=
 =?us-ascii?Q?cgdQcMpDzW7trefxn5jpXhairc1O5UAt2nz/dwIY/eZeAnN8eP4/5y1TgO4p?=
 =?us-ascii?Q?lQhEEHhi0EMe6ERfwERPqyuF6Xbt81s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d7cdd5-c079-4d86-dc76-08df44f6df83
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:21.5045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woBbcRF8IBw3kBDojqQ3AdKXNDwDVSlwJA9wQUI+PBL87yaU5pK3YmqA+T8OyM+abvv7qBVVp6VmJqSL1z0gjHJkpDDI8sCrrdi2SHzsL44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB892675
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Main changes:
 * add support for spinand operations working in octal DTR mode
 * randomizer support
 * continuous mode improvements

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c       | 501 +++++++++++++++++++++++++-----
 drivers/mtd/nand/spi/esmt.c       |   4 +-
 drivers/mtd/nand/spi/gigadevice.c |   8 +-
 drivers/mtd/nand/spi/macronix.c   |   4 +-
 drivers/mtd/nand/spi/micron.c     |   8 +-
 drivers/mtd/nand/spi/toshiba.c    |   3 +-
 drivers/mtd/nand/spi/winbond.c    |  19 +-
 include/linux/mtd/spinand.h       | 195 ++++++++++--
 8 files changed, 633 insertions(+), 109 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 14a8703d34f..ef899772752 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -28,6 +28,7 @@
 #include <ubi_uboot.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <dm/read.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
@@ -42,10 +43,111 @@ struct spinand_plat {
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
+static struct spi_mem_op
+spinand_fill_reset_op(struct spinand_device *spinand)
+{
+	return spinand->op_templates->reset;
+}
+
+static struct spi_mem_op
+spinand_fill_readid_op(struct spinand_device *spinand,
+		       u8 naddr, u8 ndummy, void *buf, unsigned int len)
+{
+	struct spi_mem_op op = spinand->op_templates->readid;
+
+	op.addr.nbytes = naddr;
+	op.dummy.nbytes = ndummy;
+	op.data.buf.in = buf;
+	op.data.nbytes = len;
+
+	return op;
+}
+
+struct spi_mem_op
+spinand_fill_wr_en_op(struct spinand_device *spinand)
+{
+	return spinand->op_templates->wr_en;
+}
+
+static __maybe_unused struct spi_mem_op
+spinand_fill_wr_dis_op(struct spinand_device *spinand)
+{
+	return spinand->op_templates->wr_dis;
+}
+
+struct spi_mem_op
+spinand_fill_set_feature_op(struct spinand_device *spinand, u64 reg, const void *valptr)
+{
+	struct spi_mem_op op = spinand->op_templates->set_feature;
+
+	if (op.cmd.dtr && op.cmd.buswidth == 8)
+		reg |= reg << 8;
+
+	op.addr.val = reg;
+	op.data.buf.out = valptr;
+
+	return op;
+}
+
+struct spi_mem_op
+spinand_fill_get_feature_op(struct spinand_device *spinand, u64 reg, void *valptr)
+{
+	struct spi_mem_op op = spinand->op_templates->get_feature;
+
+	if (op.cmd.dtr && op.cmd.buswidth == 8)
+		reg |= reg << 8;
+
+	op.addr.val = reg;
+	op.data.buf.in = valptr;
+
+	return op;
+}
+
+static struct spi_mem_op
+spinand_fill_blk_erase_op(struct spinand_device *spinand, u64 addr)
+{
+	struct spi_mem_op op = spinand->op_templates->blk_erase;
+
+	op.addr.val = addr;
+
+	return op;
+}
+
+static struct spi_mem_op
+spinand_fill_page_read_op(struct spinand_device *spinand, u64 addr)
+{
+	struct spi_mem_op op = spinand->op_templates->page_read;
+
+	op.addr.val = addr;
+
+	return op;
+}
+
+static struct spi_mem_op
+spinand_fill_page_read_packed_op(struct spinand_device *spinand, u64 addr)
+{
+	struct spi_mem_op op = spinand->op_templates->page_read;
+
+	op.cmd.opcode |= addr >> 16;
+	op.addr.val = addr & 0xFFFF;
+
+	return op;
+}
+
+struct spi_mem_op
+spinand_fill_prog_exec_op(struct spinand_device *spinand, u64 addr)
+{
+	struct spi_mem_op op = spinand->op_templates->prog_exec;
+
+	op.addr.val = addr;
+
+	return op;
+}
+
 int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
-	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(reg,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, get_feature,
+					  reg, spinand->scratchbuf);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -58,8 +160,8 @@ int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 
 int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
-	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(reg,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, set_feature,
+					  reg, spinand->scratchbuf);
 
 	*spinand->scratchbuf = val;
 	return spi_mem_exec_op(spinand->slave, &op);
@@ -199,20 +301,29 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_init_quad_enable(struct spinand_device *spinand)
+static int spinand_init_quad_enable(struct spinand_device *spinand,
+				    bool enable)
 {
-	bool enable = false;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
+	int ret;
 
-	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
-		return 0;
+	/*
+	 * QE is a per-die setting on some devices. Program each target
+	 * individually when enabling or disabling quad I/O mode.
+	 */
+	for (target = 0; target < nand->memorg.ntargets; target++) {
+		ret = spinand_select_target(spinand, target);
+		if (ret)
+			return ret;
 
-	if (spinand->op_templates.read_cache->data.buswidth == 4 ||
-	    spinand->op_templates.write_cache->data.buswidth == 4 ||
-	    spinand->op_templates.update_cache->data.buswidth == 4)
-		enable = true;
+		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
+				      enable ? CFG_QUAD_ENABLE : 0);
+		if (ret)
+			return ret;
+	}
 
-	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
-			       enable ? CFG_QUAD_ENABLE : 0);
+	return 0;
 }
 
 static int spinand_ecc_enable(struct spinand_device *spinand,
@@ -359,7 +470,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
 
 int spinand_write_enable_op(struct spinand_device *spinand)
 {
-	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
+	struct spi_mem_op op = SPINAND_OP(spinand, wr_en);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -369,7 +480,10 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
-	struct spi_mem_op op = SPINAND_PAGE_READ_1S_1S_0_OP(row);
+	bool packed = spinand->flags & SPINAND_ODTR_PACKED_PAGE_READ;
+	struct spi_mem_op op = packed ?
+		SPINAND_OP(spinand, page_read_packed, row) :
+		SPINAND_OP(spinand, page_read, row);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -403,10 +517,14 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	if (req->mode == MTD_OPS_RAW)
-		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+
+	if (spinand->op_templates->cont_read_cache && req->continuous)
+		rdesc->info.op_tmpl = &rdesc->info.secondary_op_tmpl;
 	else
-		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
+		rdesc->info.op_tmpl = &rdesc->info.primary_op_tmpl;
+
+	rdesc->info.op_tmpl->data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -495,10 +613,8 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	if (req->mode == MTD_OPS_RAW)
-		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
-	else
-		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	wdesc->info.op_tmpl->data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -524,7 +640,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
-	struct spi_mem_op op = SPINAND_PROG_EXEC_1S_1S_0_OP(row);
+	struct spi_mem_op op = SPINAND_OP(spinand, prog_exec, row);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -534,7 +650,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
-	struct spi_mem_op op = SPINAND_BLK_ERASE_1S_1S_0_OP(row);
+	struct spi_mem_op op = SPINAND_OP(spinand, blk_erase, row);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -594,8 +710,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_1S_1S_1S_OP(
-		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_OP(spinand, readid,
+					  naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -607,7 +723,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 
 static int spinand_reset_op(struct spinand_device *spinand)
 {
-	struct spi_mem_op op = SPINAND_RESET_1S_0_0_OP;
+	struct spi_mem_op op = SPINAND_OP(spinand, reset);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -719,7 +835,7 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 	bool disable_ecc = false;
 	bool ecc_failed = false;
 	unsigned int retry_mode = 0;
-	int ret;
+	int ret = 0;
 
 	old_stats = mtd->ecc_stats;
 
@@ -801,6 +917,12 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 	 * Each data read must be a multiple of 4-bytes and full pages should be read;
 	 * otherwise, the data output might get out of sequence from one read command
 	 * to another.
+	 *
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so let's only enable
+	 * continuous reads when reading within the same erase block.
 	 */
 	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
@@ -858,6 +980,14 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 {
 	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
 	if (spinand->set_cont_read) {
+		/*
+		 * Ensure continuous read is disabled on probe.
+		 * Some devices retain this state across soft reset,
+		 * which leaves the OOB area inaccessible and results
+		 * in false positive returns from spinand_isbad().
+		 */
+		spinand_cont_read_enable(spinand, false);
+
 		spinand->cont_read_possible = true;
 	}
 }
@@ -879,19 +1009,6 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 	nanddev_offs_to_pos(nand, from, &start_pos);
 	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
 
-	/*
-	 * Continuous reads never cross LUN boundaries. Some devices don't
-	 * support crossing planes boundaries. Some devices don't even support
-	 * crossing blocks boundaries. The common case being to read through UBI,
-	 * we will very rarely read two consequent blocks or more, so it is safer
-	 * and easier (can be improved) to only enable continuous reads when
-	 * reading within the same erase block.
-	 */
-	if (start_pos.target != end_pos.target ||
-	    start_pos.plane != end_pos.plane ||
-	    start_pos.eraseblock != end_pos.eraseblock)
-		return false;
-
 	return start_pos.page < end_pos.page;
 }
 
@@ -1154,6 +1271,7 @@ static struct spi_mem_dirmap_desc *spinand_create_rdesc(
 		 * its spi controller, use regular reading
 		 */
 		spinand->cont_read_possible = false;
+		memset(&info->secondary_op_tmpl, 0, sizeof(info->secondary_op_tmpl));
 
 		info->length = nanddev_page_size(nand) +
 			       nanddev_per_page_oobsize(nand);
@@ -1169,19 +1287,31 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
+	bool enable_ecc = false, secondary_op = false;
+
+	if (spinand->cont_read_possible && spinand->op_templates->cont_read_cache)
+		secondary_op = true;
 
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	/* Write descriptor */
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.primary_op_tmpl = *spinand->op_templates.update_cache;
+	info.primary_op_tmpl = *spinand->op_templates->update_cache;
+	info.primary_op_tmpl.data.ecc = enable_ecc;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	info.primary_op_tmpl = *spinand->op_templates.read_cache;
+	/* Read descriptor */
+	info.primary_op_tmpl = *spinand->op_templates->read_cache;
+	info.primary_op_tmpl.data.ecc = enable_ecc;
+	if (secondary_op) {
+		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
+		info.secondary_op_tmpl.data.ecc = enable_ecc;
+	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
@@ -1190,9 +1320,6 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
-	spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
-	spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
-
 	return 0;
 }
 
@@ -1217,6 +1344,19 @@ static int spinand_create_dirmaps(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_randomizer_init(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	bool enabled;
+
+	if (!spinand->set_randomizer)
+		return 0;
+
+	enabled = dev_read_bool(dev, "nand-randomizer");
+
+	return spinand->set_randomizer(spinand, enabled);
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1305,12 +1445,6 @@ static int spinand_manufacturer_init(struct spinand_device *spinand)
 			return ret;
 	}
 
-	if (spinand->configure_chip) {
-		ret = spinand->configure_chip(spinand);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -1321,8 +1455,104 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
 
+bool spinand_op_is_odtr(const struct spi_mem_op *op)
+{
+	return op->cmd.dtr && op->cmd.buswidth == 8;
+}
+
+static void spinand_init_ssdr_templates(struct spinand_device *spinand)
+{
+	struct spinand_mem_ops *tmpl = &spinand->ssdr_op_templates;
+
+	tmpl->reset = (struct spi_mem_op)SPINAND_RESET_1S_0_0_OP;
+	tmpl->readid = (struct spi_mem_op)SPINAND_READID_1S_1S_1S_OP(0, 0, NULL, 0);
+	tmpl->wr_en = (struct spi_mem_op)SPINAND_WR_EN_1S_0_0_OP;
+	tmpl->wr_dis = (struct spi_mem_op)SPINAND_WR_DIS_1S_0_0_OP;
+	tmpl->set_feature = (struct spi_mem_op)SPINAND_SET_FEATURE_1S_1S_1S_OP(0, NULL);
+	tmpl->get_feature = (struct spi_mem_op)SPINAND_GET_FEATURE_1S_1S_1S_OP(0, NULL);
+	tmpl->blk_erase = (struct spi_mem_op)SPINAND_BLK_ERASE_1S_1S_0_OP(0);
+	tmpl->page_read = (struct spi_mem_op)SPINAND_PAGE_READ_1S_1S_0_OP(0);
+	tmpl->prog_exec = (struct spi_mem_op)SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+}
+
+static int spinand_support_vendor_ops(struct spinand_device *spinand,
+				      const struct spinand_info *info,
+				      enum spinand_bus_interface iface)
+{
+	int i;
+
+	if (!info->vendor_ops)
+		return 0;
+	/*
+	 * The vendor ops array is only used in order to verify this chip and all its memory
+	 * operations are supported. If we see patterns emerging, we could ideally name these
+	 * operations and define them at the SPI NAND core level instead.
+	 * For now, this only serves as a sanity check.
+	 */
+	for (i = 0; i < info->vendor_ops->nops; i++) {
+		const struct spi_mem_op *op = &info->vendor_ops->ops[i];
+
+		if ((iface == SSDR && spinand_op_is_odtr(op)) ||
+		    (iface == ODTR && !spinand_op_is_odtr(op)))
+			continue;
+
+		if (!spi_mem_supports_op(spinand->slave, op))
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
+{
+	struct spinand_mem_ops *tmpl = &spinand->odtr_op_templates;
+
+	tmpl->reset = (struct spi_mem_op)SPINAND_RESET_8D_0_0_OP;
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->reset))
+		return -EOPNOTSUPP;
+
+	tmpl->readid = (struct spi_mem_op)SPINAND_READID_8D_8D_8D_OP(0, 0, NULL, 0);
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->readid))
+		return -EOPNOTSUPP;
+
+	tmpl->wr_en = (struct spi_mem_op)SPINAND_WR_EN_8D_0_0_OP;
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->wr_en))
+		return -EOPNOTSUPP;
+
+	tmpl->wr_dis = (struct spi_mem_op)SPINAND_WR_DIS_8D_0_0_OP;
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->wr_dis))
+		return -EOPNOTSUPP;
+
+	tmpl->set_feature = (struct spi_mem_op)SPINAND_SET_FEATURE_8D_8D_8D_OP(0, NULL);
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->set_feature))
+		return -EOPNOTSUPP;
+
+	tmpl->get_feature = (struct spi_mem_op)SPINAND_GET_FEATURE_8D_8D_8D_OP(0, NULL);
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->get_feature))
+		return -EOPNOTSUPP;
+
+	tmpl->blk_erase = (struct spi_mem_op)SPINAND_BLK_ERASE_8D_8D_0_OP(0);
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->blk_erase))
+		return -EOPNOTSUPP;
+
+	if (spinand->flags & SPINAND_ODTR_PACKED_PAGE_READ)
+		tmpl->page_read = (struct spi_mem_op)SPINAND_PAGE_READ_PACKED_8D_8D_0_OP(0);
+	else
+		tmpl->page_read = (struct spi_mem_op)SPINAND_PAGE_READ_8D_8D_0_OP(0);
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->page_read))
+		return -EOPNOTSUPP;
+
+	tmpl->prog_exec = (struct spi_mem_op)SPINAND_PROG_EXEC_8D_8D_0_OP(0);
+	if (!spi_mem_supports_op(spinand->slave, &tmpl->prog_exec))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand,
+spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -1336,6 +1566,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
 		unsigned int nbytes;
 		int ret;
 
+		if ((iface == SSDR && spinand_op_is_odtr(&op)) ||
+		    (iface == ODTR && !spinand_op_is_odtr(&op)))
+			continue;
+
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
 
@@ -1426,29 +1660,97 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
+		spinand->set_randomizer = table[i].set_randomizer;
 
-		op = spinand_select_op_variant(spinand,
+		/* I/O variants selection with single-spi SDR commands */
+
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.read_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
-		spinand->op_templates.read_cache = op;
+		spinand->ssdr_op_templates.read_cache = op;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.write_cache);
 		if (!op)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
-		spinand->op_templates.write_cache = op;
+		spinand->ssdr_op_templates.write_cache = op;
 
-		op = spinand_select_op_variant(spinand,
+		op = spinand_select_op_variant(spinand, SSDR,
 					       info->op_variants.update_cache);
-		spinand->op_templates.update_cache = op;
+		if (!op)
+			return -EOPNOTSUPP;
+
+		spinand->ssdr_op_templates.update_cache = op;
+
+		ret = spinand_support_vendor_ops(spinand, info, SSDR);
+		if (ret)
+			return ret;
+
+		if (info->op_variants.cont_read_cache) {
+			op = spinand_select_op_variant(spinand, SSDR,
+						       info->op_variants.cont_read_cache);
+			if (op) {
+				const struct spi_mem_op *read_op;
+
+				read_op = spinand->ssdr_op_templates.read_cache;
+
+				/*
+				 * Sometimes the fastest continuous read variant may not
+				 * be supported. In this case, prefer to use the fastest
+				 * read from cache variant and disable continuous reads.
+				 */
+				if (read_op->cmd.buswidth > op->cmd.buswidth ||
+				    (read_op->cmd.dtr && !op->cmd.dtr) ||
+				    read_op->addr.buswidth > op->addr.buswidth ||
+				    (read_op->addr.dtr && !op->addr.dtr) ||
+				    read_op->data.buswidth > op->data.buswidth ||
+				    (read_op->data.dtr && !op->data.dtr))
+					spinand->cont_read_possible = false;
+				else
+					spinand->ssdr_op_templates.cont_read_cache = op;
+			} else {
+				spinand->cont_read_possible = false;
+			}
+		}
+
+		/* I/O variants selection with octo-spi DDR commands (optional) */
+
+		ret = spinand_init_odtr_instruction_set(spinand);
+		if (ret)
+			return 0;
+
+		ret = spinand_support_vendor_ops(spinand, info, ODTR);
+		if (ret)
+			return 0;
+
+		op = spinand_select_op_variant(spinand, ODTR,
+					       info->op_variants.read_cache);
+		spinand->odtr_op_templates.read_cache = op;
+
+		op = spinand_select_op_variant(spinand, ODTR,
+					       info->op_variants.write_cache);
+		spinand->odtr_op_templates.write_cache = op;
+
+		op = spinand_select_op_variant(spinand, ODTR,
+					       info->op_variants.update_cache);
+		spinand->odtr_op_templates.update_cache = op;
+
+		if (info->op_variants.cont_read_cache) {
+			op = spinand_select_op_variant(spinand, ODTR,
+						       info->op_variants.cont_read_cache);
+			if (op)
+				spinand->odtr_op_templates.cont_read_cache = op;
+			else
+				spinand->cont_read_possible = false;
+		}
 
 		return 0;
 	}
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_detect(struct spinand_device *spinand)
@@ -1484,6 +1786,56 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_configure_chip(struct spinand_device *spinand)
+{
+	bool odtr = false, quad_enable = false;
+	int ret;
+
+	if (spinand->odtr_op_templates.read_cache &&
+	    spinand->odtr_op_templates.write_cache &&
+	    spinand->odtr_op_templates.update_cache)
+		odtr = true;
+
+	if (odtr) {
+		if (!spinand->configure_chip)
+			goto try_ssdr;
+
+		/* ODTR bus interface configuration happens here */
+		ret = spinand->configure_chip(spinand, ODTR);
+		if (ret) {
+			spinand->odtr_op_templates.read_cache = NULL;
+			spinand->odtr_op_templates.write_cache = NULL;
+			spinand->odtr_op_templates.update_cache = NULL;
+			goto try_ssdr;
+		}
+
+		spinand->op_templates = &spinand->odtr_op_templates;
+		spinand->bus_iface = ODTR;
+
+		return 0;
+	}
+
+try_ssdr:
+	if (spinand->flags & SPINAND_HAS_QE_BIT) {
+		if (spinand->ssdr_op_templates.read_cache->data.buswidth == 4 ||
+		    spinand->ssdr_op_templates.write_cache->data.buswidth == 4 ||
+		    spinand->ssdr_op_templates.update_cache->data.buswidth == 4)
+			quad_enable = true;
+
+		ret = spinand_init_quad_enable(spinand, quad_enable);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand, SSDR);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1494,10 +1846,6 @@ static int spinand_init_flash(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	ret = spinand_init_quad_enable(spinand);
-	if (ret)
-		return ret;
-
 	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
 	if (ret)
 		return ret;
@@ -1510,19 +1858,25 @@ static int spinand_init_flash(struct spinand_device *spinand)
 		return ret;
 	}
 
+	ret = spinand_configure_chip(spinand);
+	if (ret)
+		goto manuf_cleanup;
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
 		if (ret)
-			break;
+			goto manuf_cleanup;
 
 		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
 		if (ret)
-			break;
+			goto manuf_cleanup;
 	}
 
-	if (ret)
-		spinand_manufacturer_cleanup(spinand);
+	return 0;
+
+manuf_cleanup:
+	spinand_manufacturer_cleanup(spinand);
 
 	return ret;
 }
@@ -1542,6 +1896,8 @@ static int spinand_init(struct spinand_device *spinand)
 	if (!spinand->scratchbuf)
 		return -ENOMEM;
 
+	spinand_init_ssdr_templates(spinand);
+
 	ret = spinand_detect(spinand);
 	if (ret)
 		goto err_free_bufs;
@@ -1582,6 +1938,9 @@ static int spinand_init(struct spinand_device *spinand)
 	 * ECC initialization must have happened previously.
 	 */
 	spinand_cont_read_init(spinand);
+	ret = spinand_randomizer_init(spinand);
+	if (ret)
+		goto err_cleanup_nanddev;
 
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 6a46f3a3bfc..631b9e241be 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -142,8 +142,8 @@ static int f50l1g41lb_user_otp_info(struct spinand_device *spinand, size_t len,
 static int f50l1g41lb_otp_lock(struct spinand_device *spinand, loff_t from,
 			       size_t len)
 {
-	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
-	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	struct spi_mem_op write_op = SPINAND_OP(spinand, wr_en);
+	struct spi_mem_op exec_op = SPINAND_OP(spinand, prog_exec, 0);
 	u8 status;
 	int ret;
 
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 32fbe11e908..5e6ae0b184f 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -189,8 +189,8 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 					u8 status)
 {
 	u8 status2;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, get_feature,
+					  GD5FXGQXXEXXG_REG_STATUS2, spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -232,8 +232,8 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 					u8 status)
 {
 	u8 status2;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, get_feature,
+					  GD5FXGQXXEXXG_REG_STATUS2, spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index f21103bb15a..e2114b7b546 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -151,8 +151,8 @@ static int macronix_set_cont_read(struct spinand_device *spinand, bool enable)
 static int macronix_set_read_retry(struct spinand_device *spinand,
 					     unsigned int retry_mode)
 {
-	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(MACRONIX_FEATURE_ADDR_READ_RETRY,
-							       spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, set_feature,
+					  MACRONIX_FEATURE_ADDR_READ_RETRY, spinand->scratchbuf);
 
 	*spinand->scratchbuf = retry_mode;
 	return spi_mem_exec_op(spinand->slave, &op);
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 9af3e99664f..6dead65577f 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -143,8 +143,8 @@ static const struct mtd_ooblayout_ops micron_4_ooblayout = {
 static int micron_select_target(struct spinand_device *spinand,
 				unsigned int target)
 {
-	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(MICRON_DIE_SELECT_REG,
-						      spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, set_feature,
+					  MICRON_DIE_SELECT_REG, spinand->scratchbuf);
 
 	if (target > 1)
 		return -EINVAL;
@@ -262,8 +262,8 @@ static int mt29f2g01abagd_user_otp_info(struct spinand_device *spinand,
 static int mt29f2g01abagd_otp_lock(struct spinand_device *spinand, loff_t from,
 				   size_t len)
 {
-	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
-	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	struct spi_mem_op write_op = SPINAND_OP(spinand, wr_en);
+	struct spi_mem_op exec_op = SPINAND_OP(spinand, prog_exec, 0);
 	u8 status;
 	int ret;
 
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 2e7572d72b4..0a4cee673b2 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -76,7 +76,8 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(0x30, spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, get_feature,
+					  0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 01de6540f0d..7c457da3991 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -221,7 +221,8 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(0x30, spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_OP(spinand, get_feature,
+					  0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -254,14 +255,18 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
-static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
+static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
+			   enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
 	bool hs;
 	u8 sr4;
 	int ret;
 
-	op = spinand->op_templates.read_cache;
+	if (iface != SSDR)
+		return -EOPNOTSUPP;
+
+	op = spinand->op_templates->read_cache;
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		hs = false;
 	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
@@ -317,7 +322,8 @@ static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
 	return 0;
 }
 
-static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
+static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
+			    enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
 	unsigned int dummy_cycles;
@@ -325,7 +331,10 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
 	u8 io_mode;
 	int ret;
 
-	op = spinand->op_templates.read_cache;
+	if (iface != SSDR)
+		return -EOPNOTSUPP;
+
+	op = spinand->op_templates->read_cache;
 
 	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
 	dtr = (op->cmd.dtr || op->addr.dtr || op->data.dtr);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index e9561c0a395..4bdbb397826 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -32,8 +32,14 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)				\
-	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
+#define SPINAND_WR_EN_1S_0_0_OP					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x06, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_WR_DIS_1S_0_0_OP					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x04, 1),				\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
@@ -239,10 +245,81 @@
 		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
 
 /**
- * Standard SPI NAND flash commands
+ * Octal DDR SPI NAND flash operations
  */
-#define SPINAND_CMD_PROG_LOAD_X4		0x32
-#define SPINAND_CMD_PROG_LOAD_RDM_DATA_X4	0x34
+
+#define SPINAND_RESET_8D_0_0_OP						\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0xff, 8),			\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_READID_8D_8D_8D_OP(naddr, ndummy, buf, len)		\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x9f, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(naddr, 0, 8),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 8),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8))
+
+#define SPINAND_WR_EN_8D_0_0_OP						\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x06, 8),			\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_WR_DIS_8D_0_0_OP					\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x04, 8),			\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_SET_FEATURE_8D_8D_8D_OP(reg, valptr)			\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x1f, 8),			\
+		   SPI_MEM_DTR_OP_RPT_ADDR(reg, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_DTR_OP_DATA_OUT(2, valptr, 8))
+
+#define SPINAND_GET_FEATURE_8D_8D_8D_OP(reg, valptr)			\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x0f, 8),			\
+		   SPI_MEM_DTR_OP_RPT_ADDR(reg, 8),			\
+		   SPI_MEM_DTR_OP_DUMMY(14, 8),				\
+		   SPI_MEM_DTR_OP_DATA_IN(2, valptr, 8))
+
+#define SPINAND_BLK_ERASE_8D_8D_0_OP(addr)				\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0xd8, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_PAGE_READ_8D_8D_0_OP(addr)				\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x13, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_PAGE_READ_PACKED_8D_8D_0_OP(addr)			\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_PACKED_CMD(0x13, addr >> 16, 8),	\
+		   SPI_MEM_DTR_OP_ADDR(2, addr & 0xffff, 8),		\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_PAGE_READ_FROM_CACHE_8D_8D_8D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x9d, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 8),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 8),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PROG_EXEC_8D_8D_0_OP(addr)				\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x10, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
+#define SPINAND_PROG_LOAD_8D_8D_8D_OP(reset, addr, buf, len)		\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD((reset ? 0xc2 : 0xc4), 8),	\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_DTR_OP_DATA_OUT(len, buf, 8))
 
 /* feature register */
 #define REG_BLOCK_LOCK		0xa0
@@ -267,7 +344,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	5
+#define SPINAND_MAX_ID_LEN	6
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
@@ -293,7 +370,7 @@ struct spinand_device;
 
 /**
  * struct spinand_id - SPI NAND id structure
- * @data: buffer containing the id bytes. Currently 4 bytes large, but can
+ * @data: buffer containing the id bytes. Currently 6 bytes large, but can
  *	  be extended if required
  * @len: ID length
  */
@@ -410,11 +487,13 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
+/* SPI NAND flags */
 #define SPINAND_HAS_QE_BIT			BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 #define SPINAND_NO_RAW_ACCESS			BIT(4)
+#define SPINAND_ODTR_PACKED_PAGE_READ		BIT(5)
 
 /**
  * struct spinand_otp_layout - structure to describe the SPI NAND OTP area
@@ -477,6 +556,15 @@ struct spinand_user_otp {
 	const struct spinand_user_otp_ops *ops;
 };
 
+/**
+ * enum spinand_bus_interface - SPI NAND bus interface types
+ * @SSDR: Bus configuration supporting all 1S-XX-XX operations, including dual and quad
+ * @ODTR: Bus configuration supporting only 8D-8D-8D operations
+ */
+enum spinand_bus_interface {
+	SSDR,
+	ODTR,
+};
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
@@ -490,6 +578,8 @@ struct spinand_user_otp {
  * @op_variants.read_cache: variants of the read-cache operation
  * @op_variants.write_cache: variants of the write-cache operation
  * @op_variants.update_cache: variants of the update-cache operation
+ * @op_variants.cont_read_cache: variants of the continuous read-cache operation
+ * @vendor_ops: vendor specific operations
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @configure_chip: Align the chip configuration with the core settings
@@ -498,6 +588,7 @@ struct spinand_user_otp {
  * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
+ * @set_randomizer: enable/disable randomizer support
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -513,10 +604,13 @@ struct spinand_info {
 		const struct spinand_op_variants *read_cache;
 		const struct spinand_op_variants *write_cache;
 		const struct spinand_op_variants *update_cache;
+		const struct spinand_op_variants *cont_read_cache;
 	} op_variants;
+	const struct spinand_op_variants *vendor_ops;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
-	int (*configure_chip)(struct spinand_device *spinand);
+	int (*configure_chip)(struct spinand_device *spinand,
+			      enum spinand_bus_interface iface);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -524,6 +618,8 @@ struct spinand_info {
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int read_retry);
+	int (*set_randomizer)(struct spinand_device *spinand,
+			      bool enable);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -540,6 +636,17 @@ struct spinand_info {
 		.update_cache = __update,				\
 	}
 
+#define SPINAND_INFO_OP_VARIANTS_WITH_CONT(__read, __write, __update, __cont_read) \
+	{								\
+		.read_cache = __read,					\
+		.write_cache = __write,					\
+		.update_cache = __update,				\
+		.cont_read_cache = __cont_read,				\
+	}
+
+#define SPINAND_INFO_VENDOR_OPS(__ops)					\
+	.vendor_ops = __ops
+
 #define SPINAND_ECCINFO(__ooblayout, __get_status)			\
 	.eccinfo = {							\
 		.ooblayout = __ooblayout,				\
@@ -577,6 +684,9 @@ struct spinand_info {
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
 
+#define SPINAND_RANDOMIZER(__set_randomizer)				\
+	.set_randomizer = __set_randomizer
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -592,8 +702,38 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
-	struct spi_mem_dirmap_desc *wdesc_ecc;
-	struct spi_mem_dirmap_desc *rdesc_ecc;
+};
+
+/**
+ * struct spinand_mem_ops - SPI NAND memory operations
+ * @reset: reset op template
+ * @readid: read ID op template
+ * @wr_en: write enable op template
+ * @wr_dis: write disable op template
+ * @set_feature: set feature op template
+ * @get_feature: get feature op template
+ * @blk_erase: blk erase op template
+ * @page_read: page read op template
+ * @prog_exec: prog exec op template
+ * @read_cache: read cache op template
+ * @write_cache: write cache op template
+ * @update_cache: update cache op template
+ * @cont_read_cache: continuous read cache op template (optional)
+ */
+struct spinand_mem_ops {
+	struct spi_mem_op reset;
+	struct spi_mem_op readid;
+	struct spi_mem_op wr_en;
+	struct spi_mem_op wr_dis;
+	struct spi_mem_op set_feature;
+	struct spi_mem_op get_feature;
+	struct spi_mem_op blk_erase;
+	struct spi_mem_op page_read;
+	struct spi_mem_op prog_exec;
+	const struct spi_mem_op *read_cache;
+	const struct spi_mem_op *write_cache;
+	const struct spi_mem_op *update_cache;
+	const struct spi_mem_op *cont_read_cache;
 };
 
 /**
@@ -603,10 +743,10 @@ struct spinand_dirmap {
  * @lock: lock used to serialize accesses to the NAND
  * @id: NAND ID as returned by READ_ID
  * @flags: NAND flags
- * @op_templates: various SPI mem op templates
- * @op_templates.read_cache: read cache op template
- * @op_templates.write_cache: write cache op template
- * @op_templates.update_cache: update cache op template
+ * @ssdr_op_templates: Templates for all single SDR SPI mem operations
+ * @odtr_op_templates: Templates for all octal DTR SPI mem operations
+ * @op_templates: Templates for all SPI mem operations
+ * @bus_iface: Current bus interface
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -632,6 +772,7 @@ struct spinand_dirmap {
  * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
+ * @set_randomizer: Enable/disable the randomizer feature
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
  */
@@ -646,11 +787,10 @@ struct spinand_device {
 	struct spinand_id id;
 	u32 flags;
 
-	struct {
-		const struct spi_mem_op *read_cache;
-		const struct spi_mem_op *write_cache;
-		const struct spi_mem_op *update_cache;
-	} op_templates;
+	struct spinand_mem_ops ssdr_op_templates;
+	struct spinand_mem_ops odtr_op_templates;
+	struct spinand_mem_ops *op_templates;
+	enum spinand_bus_interface bus_iface;
 
 	struct spinand_dirmap *dirmaps;
 
@@ -669,10 +809,13 @@ struct spinand_device {
 
 	u8 last_wait_status;
 
-	int (*configure_chip)(struct spinand_device *spinand);
+	int (*configure_chip)(struct spinand_device *spinand,
+			      enum spinand_bus_interface iface);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	int (*set_randomizer)(struct spinand_device *spinand,
+			      bool enable);
 
 	const struct spinand_fact_otp *fact_otp;
 	const struct spinand_user_otp *user_otp;
@@ -682,6 +825,16 @@ struct spinand_device {
 			     unsigned int retry_mode);
 };
 
+struct spi_mem_op spinand_fill_wr_en_op(struct spinand_device *spinand);
+struct spi_mem_op spinand_fill_set_feature_op(struct spinand_device *spinand,
+					      u64 reg, const void *valptr);
+struct spi_mem_op spinand_fill_get_feature_op(struct spinand_device *spinand,
+					      u64 reg, void *valptr);
+struct spi_mem_op spinand_fill_prog_exec_op(struct spinand_device *spinand, u64 addr);
+
+#define SPINAND_OP(spinand, op_name, ...)			\
+	spinand_fill_ ## op_name ## _op(spinand, ##__VA_ARGS__)
+
 /**
  * mtd_to_spinand() - Get the SPI NAND device attached to an MTD instance
  * @mtd: MTD instance
@@ -755,6 +908,8 @@ static inline void spinand_set_ofnode(struct spinand_device *spinand,
 }
 #endif /* __UBOOT__ */
 
+bool spinand_op_is_odtr(const struct spi_mem_op *op);
+
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
 			   unsigned int table_size,
-- 
2.53.0


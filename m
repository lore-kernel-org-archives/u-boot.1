Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC3AC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88788895B;
	Wed, 14 Aug 2024 12:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="o8KV3hNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EEC889AE; Wed, 14 Aug 2024 12:24:43 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD82B87C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9GKUX4Q0cReVELQAJHjTYVIAhPe+Pcg1nqX+s3+KixVSy/bFLYxVrUIPeVykda4/7o0ZSdNvqEHO4nrtmbx5SitoGTp2j+1QzowD5X3RZQjhIafcBVaYtLdQTHp50GyFyC7mbYOCvCap18/rKrwktDpuIThdDMSVDxLKdDoduHDUhJj1z+sx17WaE91vhFUN5Q4nJ8m7VvNK2q/N2x0KSA1WRGkK5W0nI7JSkumJPkS3hJnRoCZAtmyV3EMrThQlLu+nEs4kS6FQvppfd0vQ55LjzWdWuvx8GJK0rRLvWldejG7G3s06C1QnZWhbxrVdDUNeBrJL8Q9FPb2dSmGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7+fZUwiyS1eHsmZB02Rlw5z7J4ySH6eGVerqeE2wJo=;
 b=ovSi1x7IQ23F/1iUgypOV4n2STrwNJ1m8dD3VNlwEHzDIRSZo+VoTfVv1H4sWMjCrQzFUqzd4p4rCJxlyt/KFaxnUZ3fRUCYukAHmLJAvrM4neAQBtNiQ1BK5u3PzYVawD3C3vmmhiFt7nZRUGtn7EXIVVVC6XDqLW2wzQWTh12WdZ4nYq4d0Z+qDrsM/3zCk9YM6kyT03AGxZIrjvVcx0OwWp6TDk1HFcxjbuVwP33M2svz3ujW0b5fyYq3uRv7kQzIdrsWLl7kWb238Tdrb1Uy+lQN67AYMlUMBb6fNgYCUcwz03lWH32DNr6b86WanfGFlKPHfwIY+PSpBtgFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7+fZUwiyS1eHsmZB02Rlw5z7J4ySH6eGVerqeE2wJo=;
 b=o8KV3hNLNEGf5dgugPEruglCGh2Z9VIN/hoYR6LaCPOISUENjHBtueyMC34JCh1u8UfVCX6FxyR902k9mVD/XpCgQrC1yaBVzMCxkzqwfiX+Xat7NUyAjSWN/oHFnG+bvcvZhYFW2NE5BIrEXiDf9YggtKCyXoCusWrAn7qaNzP0A5SdIIv7BdhXUInZC7x29UJa81ROi2LsCDeyhJjCddH8yxsWryZRV3my54IsIhhOweNzpLo0UZcqkq5uTshZpEUol+AWHEYA4shulZ/KIn9EFxFflEAaxtJY3IlkX5+khZaMp1F1zarIQbxTDJTkM/Fm8Sfyw/UqKkrlDQetPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8491.eurprd08.prod.outlook.com (2603:10a6:20b:566::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:24:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:24:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 0/3] cmd/mtd: add missed featuries
Date: Wed, 14 Aug 2024 14:24:25 +0400
Message-Id: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 569ed794-cf41-4559-59be-08dcbc4b4d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/NzDFftaotG52ymjBxLdcv9cRnT5qLekAW3/byTrAt0JKZSDRE2SJpoIlGEI?=
 =?us-ascii?Q?CxPdeOgj9gmLtUnQdOkVXvYOa+nExb3tSL4jCJNdO2w5rKwZVn3zg2PSTRsr?=
 =?us-ascii?Q?SOkm1iYHi2+IlhERdeWQVBmnpLoB+mh1tbl9+ioMvgy3RwEPw4bQBG2pXAat?=
 =?us-ascii?Q?7UHz/LcbA3u25tVEgcN3r9C5XIVZ2LCyI5yeRBHVWTUPZKT63cJfeqVChGKP?=
 =?us-ascii?Q?iBjYQHnaS23YjcbkkZ92oC1v5zhzto0KPec3jUr+K1XXtLE3lPLM7dvyP1qP?=
 =?us-ascii?Q?nPs6UldlbFD3PjVrI0eAUqEh7S9Su8+YgXue6lEb9jWghE9KRDGWMBb91HAA?=
 =?us-ascii?Q?Ie3xPXHEltfk/7GIesFhUEdlfvA/PVdP5iXe5kzzcoH40ASI6O+exi1nEbj5?=
 =?us-ascii?Q?1HbItQVV/utNhd6VK9ntynk2387UW7swkkPezGmpDO6cOx9vv6ov8fXnqm6I?=
 =?us-ascii?Q?w/0y+End0uQcCJrymmY22N9p6RcHtlZ3z1DDXtL4kXbXXk+2f0HSns/EtfIN?=
 =?us-ascii?Q?vJqePK9F1VrwayxKG5tvaEH68CXHx/+5vQYWh/9zcr4wlbsh6MIU02li/SH2?=
 =?us-ascii?Q?dnJRm3RPKj0rhAYvI4XZxH5eXcMOTHsQUoIqnYwmGfQJlnE+mCgdcqiXfnJX?=
 =?us-ascii?Q?IAsVmy07csewrHFHpTXjZETVhn7JJDNgFMveYG+kvyaOWRbKHofnDHz62sZN?=
 =?us-ascii?Q?r1sxQW8xIsxvXUPeBY0wNWcFXMDPvU1gN47jrxyjUaVUqlSPXd3G6wcAomSw?=
 =?us-ascii?Q?rPbYuaMEQXbPwIErcqi05Zw9YJWobg/S+9ch2lvLd+1F8bCq2atOsv4iHvI7?=
 =?us-ascii?Q?Jtw9jg80AUaee3GcGv0xiGr96r/UpCh7ms0EysGz23OSs2dIVrRZ9btTeAse?=
 =?us-ascii?Q?UkwjDGNS4JADzVoaG97siBmcwqHcuQMjSJbcMvKRyw0jhj5UKZHenzTWsGeq?=
 =?us-ascii?Q?MQ8YbNM6grS7BqegWvQipLOJ9nxiOm2yEjiCyecApxMF+IUODvxznjZyrq8a?=
 =?us-ascii?Q?npL0tegAt5sDgMXE+Bz4a1etdVgsBwbTu8UOufJbZjxA8IXibn86TzHMbtId?=
 =?us-ascii?Q?fP0RVP9ft3amnEVMQP7nMgx4Vd8xxTxnF7dM22lewpMy6Abmb/Ugrlm9xtyZ?=
 =?us-ascii?Q?E5eDGCPr6kaC5V3zQdAghEbO8q1YxspZRecuBfuVkTdzdcChFN2+YNgQfmNY?=
 =?us-ascii?Q?36/kMKYnR5O9MBDy2g2whefB3XGBTH78ewIlrmBSg31gzhIcUy+cBRr2odpg?=
 =?us-ascii?Q?U/hJaNLMx0sDuq1f8X5b6EgB9eJ+ue2K5tZlMTVxgKfhqkRFlCz6u7K8i9Ur?=
 =?us-ascii?Q?LqmTApwNO3d1IPZROGGBDtVaz0a0VQk1myDQG6Yn8Z2blcFgGuxV5p1dy24P?=
 =?us-ascii?Q?pTdMDQDbZfFMHr3nPSr1h2KSldT4IlEGlxRyeAfN9H15bZILfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SP5Spsxi95HjmA4CYtNtBioF0TgFTNwsrnwThoeg/Tmg0iEJNgTiN+tQKidL?=
 =?us-ascii?Q?rdC213TDBPnhd5KaX9We0wNePlH1WpRLdlHVhI0xftBXqqzino3imh8JijLQ?=
 =?us-ascii?Q?BRHeolo4pKmMOb+qm4xNxpkhd31NTZ8Mu7R3uVN7Wj0wHsE6s4OII47w4/hX?=
 =?us-ascii?Q?oEFJx8pV6sJbTldS5OX2tNZONRSicD/h4EkQVimI2VbxXMRxOiYDLDzSJYqd?=
 =?us-ascii?Q?lEpT1+DUcvHGxeMogLQ+zP6dZfN70IOVDb3LDT/bL64LBIy03kNobYwmODVQ?=
 =?us-ascii?Q?jZCy3kUeevWera2sHm3m4EBl1QiWZjLI1Zgq5keiOrdDUkWJ5RMebOzyhGFh?=
 =?us-ascii?Q?sZKQdMYDTkE6YVszJvCURDGfD6COxdy/6GwUFEw3HuSSUzzgMTzZHPGERAqM?=
 =?us-ascii?Q?zi5nx6DSRBYBgKepDlHfonjOKdZPkG4tA2ofYebdwSao91EA7dBLTM9ywkvF?=
 =?us-ascii?Q?1fxxUPgx6ZJk6wkxCDmgM8D/mABkAQ5323zqn+VQlHYbK2MGbPf+SWoSFw/Z?=
 =?us-ascii?Q?lr+tJvpVgWxl+SDstAgkwTT6hhbK3qbfQ3pc5xlXsRx0AzjeSgHZlvLcRjQ4?=
 =?us-ascii?Q?YkbCDIgIYwQfZ8bDsfi97td4lJpgOi5m/ZnGsom3fFGOFfeRCvRvd41s3rpa?=
 =?us-ascii?Q?wSMfU5WqA1KfikOlE5bInnhNb9yv4wm3pBhxTGcpWdAShr5nQkCZYozXPqEj?=
 =?us-ascii?Q?s/w/5bDjEWA9jehjfBt4KkP9rtoNB7os4+EeaXLC4KvmkrETU+AWX+htvNoH?=
 =?us-ascii?Q?6QF4A9QWZoup3GHML3KOR55ZH9NLxrNmjwhr+rOSB0No8zAaguHQNaY/m+pt?=
 =?us-ascii?Q?/U2pGq39Xx6xCFnWtVXfv7JQ0rJKdDRkaz8eOGx/SC2OUNbcxFaqkjXphEKU?=
 =?us-ascii?Q?VSvF21uIgp4ui7LPgXC4XntdLvSIdoS7yy+k0qoQQJTvvwO/VRu5pSW8Z0Cb?=
 =?us-ascii?Q?X1PY3EBuUfXDQ4a2cuS6dQeZmoG3f5bfG3PxEuXm8z/DEPXrGR+jeLshvhm9?=
 =?us-ascii?Q?H9T9gKHV6PJyfJSfDVkyPgCtq452S9k+cOMOBXNgU3IBCoi+Uibz6nPqM8nA?=
 =?us-ascii?Q?IiwqhI3Gel9YOlXWan1XGKYtwS5mr4g4g+DU9GEmf8dn1E3qjAFrKSH9T3BV?=
 =?us-ascii?Q?ZUdkWXg6mW1Xozv9d75RoLrF8POvIOmU2s99PN3oPfkH2TKRMD2pKZyY5IE2?=
 =?us-ascii?Q?d87iNgNzGJmtRLVSsxipLlNjTwrNYIwbkrrxDB3lcSl7eTSuX7rZHJihRdrZ?=
 =?us-ascii?Q?rnUQsFg9u4gWxgg0vOKX+vlajuFGwqffmrC7xeVDglgKqEAo/eXu8VjXSyec?=
 =?us-ascii?Q?LCVoEgCABtlrpy10VH1LvrSXWkBXtdOt8dbbDp0rE6ZWConMzkYEY4I809lW?=
 =?us-ascii?Q?medAGHxlL6Gr+IMZVGsHrU90AeJhUIHCZd0sMRiHKbHR08Z4HxCqOm4zqln1?=
 =?us-ascii?Q?W7v3qPp3Ko6fmij8oD6H+AHDxFH/D4hMSCVU2lj8Pyo6a4mKVP/h2xEPhQtp?=
 =?us-ascii?Q?vOy/goyBFpKBVjlGXujFH0bWnW2XXcR18sbjgJhhJsPaVIQ/INeevnrfShcS?=
 =?us-ascii?Q?aJ5PZpJcdKHZ9S5ERAuuPKSTCZMLoMukwqyGNInBQZEFPAXIc48bPD+9/HC4?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 569ed794-cf41-4559-59be-08dcbc4b4d96
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:24:39.3344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpVLqJzCEeCLtIUYYl2qn1/Cfy8dSFlWn7DAnIiOg/DX/bzQK/BlxJKCTKt71KER5Vzc/ETP8AF6rsBJ0rcautH42duIc2S5QYU/jvePU6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8491
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series implements following subcommands:
 * markbad  -- mark block as bad (copy of 'nand markbad')
 * torture  -- destructive test of flash blocks (copy of 'nand torture')
 * nandtest -- non-destructive test of nand flashes

v2 changes:
 * add cover letter

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add torture command support
  cmd: mtd: add nandtest command support

 cmd/Kconfig |  18 +++
 cmd/mtd.c   | 457 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 475 insertions(+)

-- 
2.39.2


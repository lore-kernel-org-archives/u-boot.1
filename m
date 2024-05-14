Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889E2C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 14:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6E988315;
	Tue, 14 May 2024 16:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="nXg6plrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C9F88223; Tue, 14 May 2024 16:04:35 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E48188280
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 16:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy61pZMn3pUb0JFgt6ls8re8t4YHKFjhOOpymZ8Zw6rrIDe3Jc9INSTRv9zT8LodrKR0+19M+NevyfBWgemIKDc2d5bsPM2AaLJggwuILQYhI71pvtvZXL5P1jdFNmabuxaYdXXoD04i5FzU5WBch6X/S7kn//3G9MLGA1MquJDAn0KvStGR3Mlt0ETciImP4cyUXSYJtzdiBUmaee9klNmqFU3C+53D/pjw2/byI9yuvllIIkHy7N1Zi5tpQFF/7o2+iSymKYLnWc7GMjKCkovw70dm40++YHLzwifwzuKhZL7GOmoRCDLXwNZudk0brtUHf8J+MlLH+WrAEZdldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQeKht4k6wOe+WLn+eCWNk/wvMx4f6ayFNFLUW2+Ljg=;
 b=Pllt5ha1TP4fBlumzrpEtPmQXQATJCuyo3LNVP4GjkFS+b4FSBr0AqLieyX/9hDt70oUsDIcawu8s4Uoq/s7LPfdvxix6sC4qZWLiy3g8QPzp5nzgt+mbyIF/dRZ1TfqZcM59h3K6K7titSPPfodEjn02TOaHwzcfecjlBm7jKuo5/TaZPNzOOnXKq8+zwEmeUnRZvlrMDCYnpeiAp+abgLC4iJxvmRTrlpfYnFCOgM/1jkgX+2w322aMX+elBTh2YDLt8AJT6Y0UVFlePBvIcwU+g/DCSlT4gNnfazi/0kWk6XLPcMYAgVxRofveydjCfj05loeoaWsM3BmHr1ifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQeKht4k6wOe+WLn+eCWNk/wvMx4f6ayFNFLUW2+Ljg=;
 b=nXg6plrM7i35tpKXtzS9zQ0aA4REivBQVFO0oPYSdWaNm7tZz8e3S43hPExfgwRG6TCzIIMH0rSHp6VbjRDhroAIDlgKqKxHgYTS+4Op1UTzjM8SrLrAfJTteYPIfeki4Dl01AM4hkbwNXBuzJDCJmPbbNAIgnZC8YXOS5+G3ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI1PR08MB10052.eurprd08.prod.outlook.com (2603:10a6:800:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:04:28 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:04:28 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Qu Wenruo <wqu@suse.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Tanmay Shah <tanmay.shah@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH 0/3] Add eFuse access for ZynqMP
Date: Tue, 14 May 2024 16:04:13 +0200
Message-Id: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI1PR08MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: daf27777-58a8-4793-1b80-08dc741ec4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9cRAVPKQqrTxocB8zdqjrmQqE2Qzlb2EJtS/lITMGBG0rWnxPh/dDvnQEVDI?=
 =?us-ascii?Q?ys98W5XDMl8E4IF8uqK/Tvd+MUtn639ZbXC4qUxfJqaUN2TWocTptwEunhax?=
 =?us-ascii?Q?HU5FTodEBjyXcKRHuye7sffA6hELAuXzXwle33m/KEveUMpIKrWx3CsMph/Y?=
 =?us-ascii?Q?PgEMQa5nfa1UZgEySG/DjmWZei8Rb6rzrhqxFSb2Iq2rZCPIroEgw0t/xbPU?=
 =?us-ascii?Q?TrKHWoLthEaCsAH4AtF1JzMe341vskETc0GhPkRGGvHV8GpVNE7zX526WgAo?=
 =?us-ascii?Q?5MkONyu7X/Wwv53cR8hMluCMjS3OuCy+dtPZl3k7+IpLo1ZiXIYwwfvL5eyw?=
 =?us-ascii?Q?Hmnw6diqoCVNJY/yykQZTfrSpKkr0EIqFWODn8UactgBOBXLwEfMRMLn5Tg0?=
 =?us-ascii?Q?g10HdZMgehaml91cjQ2OKjVxe0Suqo2EWSEarj7Wa8KycoD50c0FgZ2cRZzn?=
 =?us-ascii?Q?j73Wm6cN67t/ePVFGBZVHkqkwTuDsz5p5WYHIZGdTPBGNWCPXxUc4xpw7Oqs?=
 =?us-ascii?Q?YXiwb3AN3uSip/YyhymKo46FE8lNP1tUG+Pb2F0mNY3Lps2Cl2PYMf5u6gyd?=
 =?us-ascii?Q?l5zsHGjBHxmIbn2idwCQ1g7uju7jbIR2kb3kkNV717lL5g6L3iVpiWskuKeS?=
 =?us-ascii?Q?4oYzgJjVMiai+yXs72iPSxST4otrb8LJcHd+b0qTMaRxnOOYNxubUWDfR/SP?=
 =?us-ascii?Q?lHVHR04CI/ScFfZnaDp3bc/VSkHX0IWqWymlo5cdFnV2VkBBCRew8ILzR5R3?=
 =?us-ascii?Q?alHQEkwyY2OzuLPRoe6skMc9qY/KmaBpVw6PBoCE+f2J7pUcIQJ0sWTuhs4h?=
 =?us-ascii?Q?PA+YQbTsbaMsVEd6iu3DNhUBSlhYm1nbVxdyPwW3EePGKvJ1FiZA1P6yDHDe?=
 =?us-ascii?Q?LebHFkklgywso/wyEoQMyPS21Z0UIP/mgWYom1LGVwCIm5Td5LmKZwgledPO?=
 =?us-ascii?Q?+7TvL08/5nLpOL8gIIP4S9JQs0Da6WhXfMRyj/BxlrIzl6+mUBON4U+mgcSE?=
 =?us-ascii?Q?eyGzHsbeM4hXELmfEG393NSXMDBUf28/sDLRrVVQI3LfBmko686dntfS+kmq?=
 =?us-ascii?Q?BtYBgbA1xAsdlukWUg7wUrGfZ1GIJI+wJZICOGkZyaDQZcwVGMAeiqQZPI8t?=
 =?us-ascii?Q?RtUz3vDGcjupSsQpzKTtHY2PSCzLzFhHoijPxURyDPUWoQ4lId/x0kwLAsYC?=
 =?us-ascii?Q?POtBqvccfQj+aCioQzBdmeJykQsjBwgxWY42oUpk4roWfGAWyG+/B+hOzEM4?=
 =?us-ascii?Q?hsvbVZANj6AurLfqyS6o2/cRYxDvMPePlzeznSjsQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kd9Hwbofxmkmibsg5F/3RBF5F0lHJJHsU72TnICY/sNgovygdkoTXHizTWAP?=
 =?us-ascii?Q?pr9vozcjoitcAi4qHoITuvT+JOzMKabqymVoyJBCiA2d3ELSqyXqVn3JgwRR?=
 =?us-ascii?Q?c524x5T2Zc0ZcLxQcxo48tQrH3za7eJnnnT4hBYELQLD1hCP7yOVDUcWKOWY?=
 =?us-ascii?Q?MmyHjLpCXAi5eDXMRmR6yune7SFI1VYl1hODHOT0jTLHjcGGFgGDD40Al8TY?=
 =?us-ascii?Q?nQB16LwRGLXxIDLfXv8S+Ku8XtUwNvwp1fcUMgw3P2azkDK4mCcGA9n08HSq?=
 =?us-ascii?Q?KdR1EYLaNqhAu1+rkyiw9UYOCcV1Cb5fG6HHmGdh0zJdAZaWAIeXNNlFvM+F?=
 =?us-ascii?Q?CpQBqJAgibuRMShBBLCbjiaIxavTytuQz7N+woxvU86ny9AcBPn4BE314KZH?=
 =?us-ascii?Q?72mxQRUkQ20q6TMuHXgkxRqvacEXdJzxo19Ea4cYE0A+Cj6uvHObLVbOli5G?=
 =?us-ascii?Q?EFzEYHAIWgluGsMg7PDlbNY4zBUcJTQsrGY4fj3uud8hMhBJUjNFHTOkEpYw?=
 =?us-ascii?Q?OFwdBb9DGapVylhpVOWPNmoKjzzZWeS7l0gAh63l+Rgm5gVAAIjW0cF/IbYx?=
 =?us-ascii?Q?PeHJnWqgPhaGhLanYVUoAicoZ14U3ggrXwlv46krCS7b4zt8qhdvVMHP2Crx?=
 =?us-ascii?Q?muLXWMI9SEMhpp7wNOO5PqV63fY+RBpTfabYyknWDI+hDFFJVbZYmrW2tPHE?=
 =?us-ascii?Q?QdiPU5gZ/1RRJyLPEGffgS6uxo5AfvUlhJAb4yu0PUUSQ8Vi22+xT4BtsWgX?=
 =?us-ascii?Q?QMLA6nu+x5jMDSmm6HMU2tw/jrMpLjemQIihNAHreKWzi0PZ9cfmNFqGHpcH?=
 =?us-ascii?Q?3e/O/GRTGhlx66VU502IpNC1NmncrmYXJs979oNIxLyb8WTiO0yBZ9xCxMmb?=
 =?us-ascii?Q?CY/Lnl7F/zMx3lJ3n4wYRBpSd6+Bd6qDWPzUYsgtSRMZxe9QT5Iulz1H+a+Z?=
 =?us-ascii?Q?mZ5OvxG4Q8vSPKeCgOR+JzzR34QrpVpZtPNFUR8WaUbqWUYLvO1YTb0/pkp9?=
 =?us-ascii?Q?+ebcnjqnhgMSXbKRHkelYK0sCLb6/OHNxO7b/FacGV8I68Zq4errzy23dpQX?=
 =?us-ascii?Q?i6R8irCJp68uOXFZXkTbN5tIafechDMFGlOfyIXoAeAAQ4e6nq8D99POoISv?=
 =?us-ascii?Q?Yrn7ch8HHGbPS0lSNP1hPKp5E7G9VStRU69Iln5VmvBkBjw+4P/7J1gFBT04?=
 =?us-ascii?Q?WQgoGLVAKM31PPHOZo6TaqiMHdJXpCWajFiTBNShSqV2P/rRq6zr4IhlDGYW?=
 =?us-ascii?Q?Xalm9Dtntze19yAba6rKmZCp8DDxrNwMSpoSysYLS38orHVKFP1UcU7UvYzG?=
 =?us-ascii?Q?W0+uq1Cy0zhm1FFdzJRuQcCc/WniJaRKh45GsrJdSrHkELF0PAe9LuyGN0d2?=
 =?us-ascii?Q?/1/ek7XbKLrA4vuC7rU4SGWtO6Qn/l/+VVkTuWmxAFUiSDxKnPViyLfGUSvY?=
 =?us-ascii?Q?anTnPkEsga73gBtFnzaHlzH7Bqm4Xk67j1r/PfR/utzg4dYa6hiP1tqE0tPU?=
 =?us-ascii?Q?/uThnr2VzUCKUSJ459hTSi11vi603k+htedBWq0k+DseDKff3oL707d+I+7K?=
 =?us-ascii?Q?T9zRf5seHxRcodL43zMfvSaVMDRrswq8qumGQFl/?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf27777-58a8-4793-1b80-08dc741ec4fb
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:04:28.3606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3s43rE+ZN9Q/AOKRlxENObJO7q4+HWfaXa0pvyfdk+ub62qKQm8PeJd8sagWsHQtEpcojXB+lN3pyl2lRlx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10052
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series adds a driver to read and write ZynqMP eFuses [1]. The
driver can be accessed by the 'efuse_read' and 'efuse_write' subcommands
of the 'zynqmp' command.

Example:

=> zynqmp efuse_read 0xc 0xc
00000000: 85 66 b1 32 43 f2 4a 02 00 00 00 40              .f.<D.:....@

Note: Accessing eFuses requires eFuse access to be enabled in the
underlying PMU firmware.

Use cases are:
 - Reading/writing user specific eFuses to enable device specific
   implementations
 - Revoking SPK IDs
 - Reading SoC version/DNA

[1] https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/eFUSE



Lukas Funke (3):
  firmware: zynqmp: Add support to access efuses
  amd64: zynqmp: Add command to program efuses
  drivers: misc: Add driver to access ZynqMP efuses

 board/xilinx/zynqmp/cmds.c         | 101 ++++++++++++++
 drivers/firmware/firmware-zynqmp.c |  31 +++++
 drivers/misc/Kconfig               |   8 ++
 drivers/misc/Makefile              |   1 +
 drivers/misc/zynqmp_efuse.c        | 213 +++++++++++++++++++++++++++++
 include/zynqmp_firmware.h          |   2 +
 6 files changed, 356 insertions(+)
 create mode 100644 drivers/misc/zynqmp_efuse.c

-- 
2.30.2


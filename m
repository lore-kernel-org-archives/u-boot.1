Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2107BCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C59883FF9;
	Fri, 10 Oct 2025 21:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zC4SP4OZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DED83C62; Fri, 10 Oct 2025 21:09:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22FC84348
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EizwT0+FxKasBr7D2+kWlWD7cubpPXqXqP4KrP0dn7+HQ7d6jNzqisZtZbYzgfkgButPCAq6x43rR4geRjzCYNUkcdVK0GcO/KzTuxx1sXXli/gp5vYYuNLI4i4NlJD0zNZ8ex55JtYFIi2OE46lkUTNSIo+IRYFHX9aQsDNaKXjGh2QsY6AINFWEllk/QurCgQQdAGbzx+WIkqPSEqjFIZiosZfWEUff0kzq5Tu1MAdmLQnJSqLwNeAeowUO0DkC0hbj3TJzbAFD+NNk/hDsjA8INes0AXvu/r6VoKV+LjvaL75gGr6kOfeEAiUkZLavJY1NETNlCmiTrnWPlkiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ygz+JCFXu66Rc04WfLAp1SRIKAx19ZGEPTguS/+uhTQ=;
 b=ow0jnyA4qmAsMB3qjt+De6SUB8SWTasVomrQa8vKEp8btjcsCHtE5QndLIQgR4R/cQhhqThEDClj4mLodP5epsgEG/+/jkxw2LmifIK+/K6lqibwG9MGuQvmEy2AfcKjLYykLSICSLyhMF8fVDsONrhUPtCMoX1g6wFN9bQUKgbGg/PCv5z/VfQoucp6EQCAG/tpPRx1TvQaRv9C/7Mk1bZn7tzEABUL+q2bbDuH5pyswV8vjjbsUaAuFqh7zxRLdP7KAME3m4/Yf1fb+qptxFVEynzYJEsN6qdliQKwjtKIGH+QcHVpWQE9LwRWjzYq5XlwVMBtr50YM/Li4TasZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygz+JCFXu66Rc04WfLAp1SRIKAx19ZGEPTguS/+uhTQ=;
 b=zC4SP4OZHJSxmUwXH9XEO/ttkLb+G+Nz0qb+zLa/X+TZaqEZ4Yf6LdhYNYVyxRmFc8DUpDVHwKTYY1UqGWQd5libJhYEk0HWGhozrMmv9A8X+pDbpOKnozz5D1ExEmVus//7k4zsbbL6tDuaRogenoAF1o3ISAnreelzU1FiBqFZZbxl/Doy21yR14tMKABVKqFltx0P8xwEULfxfLtvwMp0vEvuW9lPXrg5KjUry/RHftTyHjqC2XMgdCFs36TYqLGSzG00/LOGYaROsf2edRSyemPzbaLtcPyXRfII0S9ay8Mr7VRxUOma6JrAI4NtrY8KHjtFkxB4gwrG/DTghg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 09/11] spi: airoha: buffer must be 0xff-ed before writing
Date: Fri, 10 Oct 2025 22:08:39 +0300
Message-ID: <20251010190841.1590130-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: b848c210-4b62-4d47-d398-08de08307662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KfhxXIVwpzUA7MZelG879lc8d8YtOjcFEs+hP7YVR1StoP64mDNKbxmhUItc?=
 =?us-ascii?Q?ulYqkpzLa64qckMzMq8VJrSrKiGXPs4OCS/o6++JVTkFa9WrKP2vtZFBnu40?=
 =?us-ascii?Q?94xaRyoURKo9q36P0NCjBLyBWwUQYDt+9Eb7pvVCSooIjv1QTGZCYLHmQHIp?=
 =?us-ascii?Q?B9/bNqDPH+7rrEiY3YsBttquzx9ocPVz6IiCtjSyXpPEuU43g1V19+z8TZQj?=
 =?us-ascii?Q?MOjarhlrGD65TsLWd3nY8rof/HcjKgRG8i2XZTVPzHPslIZQjgdBJmC6y9d/?=
 =?us-ascii?Q?JaP/Jkysqa8Wd7AZ6YsPLi0YNkmA4BbKi6hD4mpcDs11nZxMY1YtG9oyQu01?=
 =?us-ascii?Q?1Dd8lSL44rVJjdRtUuEnXuzRfTn7U22c8RZvwSImLMK4KGoIif55p6bDOmwr?=
 =?us-ascii?Q?5qcCCtUADTWQv4S/P9Or8hbJFIDQVQm9D4zZ8A7BB+WQFUW+iOKbHIzYnWE+?=
 =?us-ascii?Q?7zE8riPUREV5x6Hg4nNY81F+CEs4Ewx7IQdd+1RsDerffIuUp0LcCeaGcuPx?=
 =?us-ascii?Q?u7DltuRXeMZKg3US1cuPLNxA2OMkkWIagQAcqLpvaVZkc8cQlSgm19Ish778?=
 =?us-ascii?Q?B9tQh2tpI2sNM/h021z0fyy4ENMifMREc6WsSJlZNghLXmWQGZtRx7z6Pj/N?=
 =?us-ascii?Q?YAx5H8fGR6OeGHM3ONEQDUI76FhMaSBLQALxj+yOD0wWYIDpB6RLdf7yhZyK?=
 =?us-ascii?Q?E/GBz8RpbxO7qEuSf8oN00EQiXy75j9uUhx5tKVZMT9QDJMIn0evBxHXFvYq?=
 =?us-ascii?Q?t7xTzfemPnJVw3LvjYvvumN062Hh6VRcmKjHjrOk3IIby+sCCZuEXeuB6MFs?=
 =?us-ascii?Q?l6VzjVdv+gkfsp/yzevJda48+DmLXWSeCJFp5IY8gBbm39i3isFhgPXI5o02?=
 =?us-ascii?Q?rB+DOgvP6o0mhUNhRmoHraD8/sqaQx1fxHSc/i0pxywmYPxkA+GtBz3awEOz?=
 =?us-ascii?Q?vLUhPS+4mbaf0fIZG3shlJYkDfci2ium0PMo3CTMqjo2PQfVbOSMNBO2MFxV?=
 =?us-ascii?Q?JbEQu09MDhn1EmNaLoYne15x6MoxQuRaP973EFm5FKy+Xl8bdmEg7NP5dVBU?=
 =?us-ascii?Q?/XbMYAdlkDhn13jxwoU/TezRA6Jmjs+WwUn1WtTaDVO8h+VC5wh4kQmbLX2M?=
 =?us-ascii?Q?250BGpbsEQRklyddlEHincQTkwfAtq5ENrgnl63caCJQ1VbISELoSZs8UwgW?=
 =?us-ascii?Q?djJuakd25bRJQnfauvteLcwaDjHgIf2jtsun/BD8wFK+9SnH3hnltEl5oY8A?=
 =?us-ascii?Q?JaCgUAQg/V9halCd5xm1rV0M3wUXWoqoBWfILiifDr6wwIlVIbmWBgg3wUff?=
 =?us-ascii?Q?7vfKF1SWYub2nJJJf2BGlVpgpuav4w//vw8U+ULk86AW8Kgwc9Zxl1GomB5W?=
 =?us-ascii?Q?N16gFE2X7NqnbFOA1lKFaz/Pv4iJbqPS3dtmr0Y8iSx9SwA1uUBJJs0O5pH7?=
 =?us-ascii?Q?SYhScCwiw1l3jRopfPW9w2gAfhgAuqY+Mqe3J7plyh05L9hDUbAAlpfo+wi2?=
 =?us-ascii?Q?5tJBYt5Ubm2H4/c+VDd+5LvbJcRA5piAlcRh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vpf7T7Mb85vDurwWSOW8F55DeDneV0aVHLQX6i2Verge7XMsPN+RqLbf9KLo?=
 =?us-ascii?Q?qvCv2DGTERq9ay+gREDyazRWgIu+7HCZvJiHguwzmWZ8mRdsnaZxfod3k/9r?=
 =?us-ascii?Q?yd/jV7rAuO6iK7jvygVyS8ds/gLv+HiaKd2W9QLQ4FWRH7nYgdxN36ZVbejS?=
 =?us-ascii?Q?aKJpA7lcBuP09ZD8h9sptvELFVSIPs+AsyOZQP3w15TojR8qy0/PfGbAV3go?=
 =?us-ascii?Q?subvay6rva5/Kxhd81PMIu8NBH9qrxXFkA62nY8DjgbsdOPR2hHyfk3eixTE?=
 =?us-ascii?Q?N/xi36LxjWjfJf2KjPi3iWie957JvuVX8XhsD90J/1Q3WvCf27YMO/aDV4lb?=
 =?us-ascii?Q?UE4pPLwZIG2i/fnRgEBW+NSOyP2Toix1X/3v9tG0FhORtsNakXPrBDjFYcn/?=
 =?us-ascii?Q?drVt67ZSyBxuySmcMrmNIAKYDh8eYgCt1RxFtftDLldu6Z8AKNk4L5PJIvM1?=
 =?us-ascii?Q?nvagMSWdeNuZrvHG5xaEY7dygLxvaq9yKdI1IjsjRs08S6qBQJjLX6N6EXfc?=
 =?us-ascii?Q?jBFifjuJhMUSX5bnxIBP7Zh2IL0OFyneP+S1oihhMOxrLH0MsGMpS6FMNpQs?=
 =?us-ascii?Q?xFyRj4V0Hy3prKhaF29kYcLgm0vEemExbeV52zsWuXtPUoOoAAM3ynQJlFtZ?=
 =?us-ascii?Q?foYvVNak8klI1aPdU/vGaFc1+eVbn6ujVkeVjUqsqHAX/e8IVBTpD2KdcaMt?=
 =?us-ascii?Q?A8vXnbEBRGjnJHfBF9v/BT6qqefG366WHDsjiavzcJHQloXtPqt2A6eO+HdN?=
 =?us-ascii?Q?cPQj5FCjYJbje0qaWGkgRcocdNgltDOjUOUWY76WRdvORoeco4QOl8AIJtBF?=
 =?us-ascii?Q?rFEt0Ib/txJP0zlnDrTsbKyVgUuEUJq8TniHm42IKwUGYf+hGFSKzW3VK4pz?=
 =?us-ascii?Q?GFj31yV+++GLDQ5WqNb35QJOZ/qpcG7C7t0qL5kqWu+YAz/KOi+qlxHiXZwc?=
 =?us-ascii?Q?LATHId46GEoQIT38qcI7So/8WlsxmjqGoDUq8QLv20G1X3/IX5Uld8BJHinO?=
 =?us-ascii?Q?wy0kokVGgrdrwVmFh+fuywyGJPWJ3zuGg9bf2T7P1UEYt9wEu1D+NfBiKlqs?=
 =?us-ascii?Q?mxvDmm+ZKq14iyLTy9lBgDxmZO0Xo02u4prLEHNAQtGsxhSmIKn68hE5wbro?=
 =?us-ascii?Q?zGRXxMxR5YxIPKc8XTIwcQ1Fr4z3chkQgSmSqI1MiF4vhDdbuJ4gCkEmACJN?=
 =?us-ascii?Q?OP8Ty/AikOuFkt82LVR41hvhNHJIjoDM+sFfV2p+xI9BMioOhAAurpWuv8yW?=
 =?us-ascii?Q?Xq27yrbUHqiD9oI/x433bNVAsJRMYCh+ROZkWNXSc2ZmLLaCahV+8Jcjwwo/?=
 =?us-ascii?Q?5FP5B65temXeehCH0WsuMj/xjcyi6vqQGlhGBReoqDKM9K48PAfpSXSTYuud?=
 =?us-ascii?Q?tjGDogRdHD7cRUFh1qGgNtwmoGIKRe6jawl00QrsmX5nwE7L0lbheQS135gM?=
 =?us-ascii?Q?n6xsWN2TTvCb2MgpeMzFOjtR1Jy15J70WKMHWpP1v3AjU2K6vl90U/WZnQ7R?=
 =?us-ascii?Q?nQItWiYozS4kLSR7lyBQv86EQiyxUWnNSz6DGMTv+tXj0sj2B04QGA5OzUji?=
 =?us-ascii?Q?ENVPwoLFc0delOw9TGxW2Co9nYivFdk1tCla+S1g5jjKnH1CpuenMBFdI3Os?=
 =?us-ascii?Q?3jqJ4MjppLEsSSKwOP3KFZw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b848c210-4b62-4d47-d398-08de08307662
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:57.2929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJYP3YcjKFkPbp4oYTW7fhRGlpyPEHchZjfOo/dcydOSFTo4hNLzeOoullYkzIevARsjcpVDJ6q2bMOMNp2mFVbqE4doQ7bRdFCyu1xP7sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index f25c5df5783..9fc44e7088a 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -764,7 +764,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77796E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 11:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B8080717;
	Mon, 23 Dec 2024 11:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kPGG9gq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1653C806E5; Mon, 23 Dec 2024 11:59:19 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D7B80725
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhcRUXTf5L9JNSSYYCJCfollUfER9G6R0GSo1BBoQMklKJzjlAAwT0iHgiLjiGDSnTBWqW54cBJZizvLxH1Hl2X8XV3BVigFdXdNFsqe+vvQwOCBKqbgalYcOetOgeDMlgrdtvCgTSBCWS9t4inPsQB565uP35Pomx2aDMmrMVLHgh5ki907Xmq8X/EUcPfl5nldYNyZQhPLk2Wu9SdtQQB9gMW1/enlwQCYDO5C5luKw897dXKOI9xh0MtLhdKDT9dX7EmjYOvumo7eiz43TkXnI48l3yxJYSKcOfsIG6Zc9+q2JQ7vL7pzQ3E5ytLURkQrfILh6fpVY7+VYUTmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noby0rk9l0CeZ/ydWdJAmcMlgmBDvLDZ4iVY4bwdt44=;
 b=w1RXTeuAr5AhUO3BUgrYPNU3/EWC5/OTg3WalsHmk01SpkLxuSyOEcIIafk+4rpOAxV4JphBrcNaJRYXWgVDTGIS5VtOl2XrS5Gk3fhH/I2MaMxyV/UC2D4H5bxNb/b96RjqKAfHge95nNTVO+XcoSo4CI2b1ulf/2vCybx/GnCMCgYGTWv45P9ovB8yiZMB5AEDkPe2op95Rk4R8wl1S0kbmHsfyLmYw6lefN1tmGTBGW0sa4Owk6Vc2J/YSWmeo6SIrQ23XFroqXztrPIi1yii49ESkfUQpF6ZNULdVV+1RNRlcsVWXHF1DQBixIOhcatJ4wYEe48/QLRlFUWT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noby0rk9l0CeZ/ydWdJAmcMlgmBDvLDZ4iVY4bwdt44=;
 b=kPGG9gq4tzUUy6RMPMG6lf2+UXWYGb0k/Xwe6YdnELHkkt1r7QxbpfAX6ZFOSVbfOQaFj23Kpd4zvcfLUhIUikDYdgb6+uxD15KYgSCbSiLjXITfX/5bXOipsfrrPw7vgKBkOSiMS8lO0OAAkg+uQ1iDq5Ql84qyKBHksquY+Wn0exwf3x8D7MQ+OyDehVb+SlQKf3Whq8ybP5bMpdrstKFvyaqtdhYbpZrmdYHIiISDG/5hestJBqFBPXikSbdrXWh7LKRkT9IGTkFgkBFp6kZwgU7w7bOZp87gGAhml97GkC3AZ+bU4eTcIGqzZbrFpZDgeirYLc+3xyUyKfJybg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 08/11] test/cmd/wget: replace bogus response with an
 actual response from the HTTP server
Date: Mon, 23 Dec 2024 13:58:49 +0300
Message-ID: <20241223105852.1074404-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 80745b50-a255-4525-5353-08dd2340d472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ofmVTHBlReNX9fxT8WBpzhiwtI+puEGLoxH99cX95msfuI0USpVgIhmSJZLH?=
 =?us-ascii?Q?TTCLvJ7QbVeMSu2tnwclRHiGg6XYfhPLdBcfWmnYAMIg7oEXuGOBXs7Yivou?=
 =?us-ascii?Q?f+wMqFc0xniQmCmXGuqyJ3v5XP7ttnz/jput7RxpDOgDtW8d/keiAAHLLNAG?=
 =?us-ascii?Q?q687ED74HZsAIXnrb64/VqaRITKspaTpQOZ/Lw97BYsVv6TE/NcWlYjuWRW+?=
 =?us-ascii?Q?F1FvdvmO0cNtr/Jg5BcNG3/dhDxvPCJXAHSeX8wQVNAQXm++GyQhaporhom+?=
 =?us-ascii?Q?nYziqen479ulIo8Hwtj81ecoWPmJIQA61vtQx+JbPvAqkYJ8Vd+POT93WSAc?=
 =?us-ascii?Q?qm4rIWgVcfiwQUQftE+ZeATrSDlOmkWurofVyZy+mOvczY9OYlXpZdDv2BKd?=
 =?us-ascii?Q?mqNbJEQehV/Gko0AnnemK+uNjnshz0Osp6lEQlfzWey6BRezV2snWclm82i9?=
 =?us-ascii?Q?pQyTlhz/q2s9CtCkrQYbtVdw8oqnIoi/I8vLKp0I9gsYnpyp8oo2HbTBP0pl?=
 =?us-ascii?Q?AAZwAhKinftgGPG2mgh4geZQZPPU1x8opQFHJzYK3QvoARTlk6SHYS2m+Xr6?=
 =?us-ascii?Q?lemShP0kppgOxu4yFgTByay7MNn36lL15gZ0zl7DgZ/mWI2w1jZufkk6EYVW?=
 =?us-ascii?Q?xhhdUY6bARqjRNayvhNL/BDI7n1sNRisWA5z9l8WVe3r0eqdOh3FNvqh4eB2?=
 =?us-ascii?Q?iDtrM5t57jnEPbnseDc0pxVjM3ghUh6pkndpjs5uLqRfNgq8CeHEsv1j1v2K?=
 =?us-ascii?Q?FgDtmUIDaFpZrOPBxZenyAgoeg4XUOl1uK/D872PG1l/s8wMUxdacMKHfkIU?=
 =?us-ascii?Q?2TYiyokaRLK3xoaA4cu8DMpYoQrXNWjRRQ3VUNBr8ZZp2v24uUErNvm6imiN?=
 =?us-ascii?Q?gZEDi+nIokoMT2IaIiKa6chX0u9PcS7JuirENCgl+1kT9yBOK9W3Rnqu8IZP?=
 =?us-ascii?Q?+TZhDfOucRLkLCxfFwDk/f11kDmOh/MHpm7F2qu5dLKXT2zojqDTM2wasnB1?=
 =?us-ascii?Q?EThVT6WKgE/CMSYpcb+xn2A5bsFN47sW8T/2qB0oyqN+JGPrbLtgaGQCNyyB?=
 =?us-ascii?Q?trt40txyrxvKEjH0Lrby5lBAYfnQtG/mFdYJAfr9G9ubjRySq1U5hOyDDN97?=
 =?us-ascii?Q?owhVKUHfmfOgtsVaVT7Cwqf+rbwH/B+RLZCwr4ccRF9ikkntGwvmEeUm8e4+?=
 =?us-ascii?Q?tDDw3svlolr7KPRl5Xl4+ariBeQZpFx7UzwFw5RFcrBTC4QovN2nbYpShqVk?=
 =?us-ascii?Q?nfijXYFLSa9kXrGsZGKVPfw4OLvhz7KCjgC4J2whUQYkbFdXWty/M6dV5tri?=
 =?us-ascii?Q?x/Eg/oziuoAYic8siogJKMroSVDmO6dfoJMwbFLWlLh0PO6tz0Vgzu6Ocrvi?=
 =?us-ascii?Q?vt/rbZvMYlO9atlqmm6eRHobZTE6vf+a5Tgk2OB8rLpyWh6TYqVzr9Ca+GpC?=
 =?us-ascii?Q?kGjveqq1gPM8yr4+RZCMiJRlildawAhfHMctYLDIqraIuIf0ecx5qA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ig9mEDosa70ieUMz8bpdnzoYzgXpRYsFvS8agSAq/JzKAF0mJV6U8xgPpgYk?=
 =?us-ascii?Q?TzKgyn12K1keT8uYwFEEC8j1ToE61VWK54NtsNKKBOMy20ElkAe6KeX2qzsy?=
 =?us-ascii?Q?HkEeGLXT2RTXs9EiNvdNb7VPYhmxTXh6YiqhmfXXDsQKiC775AKUR58gi34V?=
 =?us-ascii?Q?CsSJcxGlZTqWePRilmr8xQL9WE72t5/+F3OhspP8PBdGQAS9g5K6bgC0OHHM?=
 =?us-ascii?Q?6obm6lZ6LIfyZ1W8Za+eGpOIWumnppFIRqxlm6Ako5Y5FEyFUgh99qcA9iRY?=
 =?us-ascii?Q?6peqPLOOsmG9CIUekwfQ6806xM/yXC2Z/6fN4TxKDK18eQANSm6e9NqjsB+7?=
 =?us-ascii?Q?AwlG9p4CSS2QragEDhBEf+5l45tE6RMNv78+EO11tPbxZarGEZnallpVU2Lb?=
 =?us-ascii?Q?6WzCH6AP3MeT1l7imo8f+wIVqSXpi565HPoVGAggeLql0+I7QgmBbzViCM8s?=
 =?us-ascii?Q?h+DHAT+h51ccuoqBtKzf3zFizc9nNTKsGoy1KESLjJrdfPs8WSoVWA0lRPPi?=
 =?us-ascii?Q?RmOorn5bbqmxjlGuiKkE3XH9FIAdKMsWUOUy9o5uQcvRTUSPisI/2GIc9rQF?=
 =?us-ascii?Q?uf6D/VJ/m5J1NX0pmPixGLhzsD1w4YnkGWBh89omXeG5DRbtUZ6ZkTunQdpa?=
 =?us-ascii?Q?hofzhOieGP6A2PK00PVtA9U4YAvlSyZgaB1pqGxvWQteI2QuFbs2/7J0yDnU?=
 =?us-ascii?Q?zcJb8Gea9ci/6RYe9un8uC6X5j4YJiXn7E2lcP27EUbbqj5yQC9VUSOC2M/V?=
 =?us-ascii?Q?GYW9yw8/0zntk705Y/TbNeOK9FC7fpE+/GQ5acZsMdi229vd4+Hq6qR5K+We?=
 =?us-ascii?Q?eNzZhiB+eEwflY13iygQClVNMvPsY2lRv+6aBW90yz/BzUUe4DUxfS+cX/V/?=
 =?us-ascii?Q?l6n6n06dkeOP3VosFmOq2mIvGKSH7Iy9Q2odVOOx+CdGRjyxm+//KaHZJaFn?=
 =?us-ascii?Q?jSU3Uh54jfumbpdc/taissWDtittcF70QO2EmizCZidH1mGGcSW8ydlPPiZP?=
 =?us-ascii?Q?zg4VaIXuRIz1YLFaDJFF45IMk9U7L/3OGGEo4lyifjQMMyG0Pqk/FI5zmRV1?=
 =?us-ascii?Q?kJZdStVWGiPLN6CZlbwDC92PfarEghzUz1GhXE0hrrqDhvd01jMpD4LXx+nl?=
 =?us-ascii?Q?tZEogdF2EgBSr2+4drym5ycsyq7pbphxJ7pcLUutbuvA1hQotJiu4HYMUJmm?=
 =?us-ascii?Q?tW+K8FZywauJuw+GnaLG1EtDwsw3sxQgRHxNvDCGupmOWxRrZLB6rz9oCYA4?=
 =?us-ascii?Q?uVKgaYdGl8Ph8UCwWBjxr/mPJRmFi//wpm22ptjLbRkAPVR+TXlZ/rDRT4sT?=
 =?us-ascii?Q?KMafpyl+NJqkpfRnE+c9igj3qV2SOCXoa8TLqhWMkT9uZ0K8Q7opKzgwzFGc?=
 =?us-ascii?Q?4EH4wRQmIcBhoSDUHcDYYtGK3GyO15bjmgbS6E9g2j6ML/6oWi5y4XspURdS?=
 =?us-ascii?Q?KyW6Uc7Wdf4ilcTenIvN/UqFsqjRzcx/LT3GWEHSOMrxARSpHmghsrlsoesv?=
 =?us-ascii?Q?xStNgL2lJNg0NQHEA1dw+DAG9D/3gBncIiJ0tpI1dEeSEmkBGp1omEqNtqXA?=
 =?us-ascii?Q?QorBo2oeAnuLOYZ06EasllaYPzwggFCIfF9PpV/Yivs9wTfj74zB7FNm3maK?=
 =?us-ascii?Q?K2a5fJbf/+BHOmxxnf6me6I=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80745b50-a255-4525-5353-08dd2340d472
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:10.6896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZmG5ohfCUdd0dJLZHuMfrVKhsxE3lc8wa+DM5Wt9mzDV5jFmZZOSClN/+8gdAH51WPVcAA+gIR594YmVGOLXZd0DXHDi2dyRrNvRzWOeyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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

According to HTTP/1.0 standard the HTTP reply consist of
 * Status Line + CRLF
 * Zero or more Response Header Fields (each ended with CRLF)
 * CRLF on new line (Response Header Fields end marker)
 * Optional Entity Body.

Thus in response headers we state:
  Content-Length = 30
but actual transferred file data is:
  "\r\n<html><body>Hi</body></html>\r\n".
This is 32 bytes of data.

So we get and check for correctness 32 bytes of data, but
 * The response we are used is incorrect, real server will
   set Content-Length to 32.
 * default_wget_info->hdr_cont_len will be set to wrong
   value 30 (used for efi http booting).

Fix an issue by:
 * replace bogus response with an actual response from the HTTP server
 * format response to show HTTP response structure
 * recalculate md5sum as transferred file data has been changed.

The server response was captured with the commands

  echo -ne "<html><body>Hi</body></html>\n" > ~/public_html/test.html
  echo -ne "GET /~${USER}/test.html HTTP/1.0\r\n\r\n" | netcat localhost 80 >reply.txt

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 test/cmd/wget.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index d51650d5854..b020d20ad70 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -107,9 +107,22 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	int payload_len = 0;
 	u32 tcp_seq, tcp_ack;
 	int tcp_data_len;
-	const char *payload1 = "HTTP/1.1 200 OK\r\n"
-		"Content-Length: 30\r\n\r\n\r\n"
-		"<html><body>Hi</body></html>\r\n";
+	const char *payload1 =
+		/* response status line */
+		"HTTP/1.1 200 OK\r\n"
+		/* response header fields */
+		"Date: Mon, 23 Dec 2024 05:18:23 GMT\r\n"
+		"Server: Apache/2.4.62 (Debian)\r\n"
+		"Last-Modified: Mon, 23 Dec 2024 05:04:50 GMT\r\n"
+		"ETag: \"1d-629e8efb09e7b\"\r\n"
+		"Accept-Ranges: bytes\r\n"
+		"Content-Length: 29\r\n"
+		"Connection: close\r\n"
+		"Content-Type: text/html\r\n"
+		/* response header fields end marker */
+		"\r\n"
+		/* file data (for HTTP GET requests) */
+		"<html><body>Hi</body></html>\n";
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -136,11 +149,11 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 
 	if (tcp_seq == 1 && tcp_ack == 1) {
 		if (tcp_data_len == 0) {
-			/* no data, wait for GET request */
+			/* no data, wait for GET/HEAD request */
 			return -1;
 		}
 
-		/* reply to GET request */
+		/* reply to GET/HEAD request */
 		payload_len = strlen(payload1);
 		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
@@ -215,12 +228,12 @@ static int net_test_wget(struct unit_test_state *uts)
 	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
 	ut_assert_nextline_empty();
 	ut_assert_nextline("Packets received 5, Transfer Successful");
-	ut_assert_nextline("Bytes transferred = 32 (20 hex)");
+	ut_assert_nextline("Bytes transferred = 29 (1d hex)");
 
 	sandbox_eth_set_tx_handler(0, NULL);
 
 	run_command("md5sum ${loadaddr} ${filesize}", 0);
-	ut_assert_nextline("md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57");
+	ut_assert_nextline("md5 for 00020000 ... 0002001c ==> 847d5e7320a27462e90bc1ed75eb8cd8");
 	ut_assert_console_end();
 
 	env_set("ethact", prev_ethact);
-- 
2.45.2


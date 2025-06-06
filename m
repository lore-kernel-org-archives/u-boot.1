Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A1C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1794D82AE9;
	Fri,  6 Jun 2025 21:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="tIuhBmLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EBC807B1; Fri,  6 Jun 2025 21:49:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F9181FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJsW1pbykf0quBDvPlb78qs2ojxFLUjOKh24Sy5xU9+byzt2kxCbJutl6fzXc+1DuVexSUuNcytjKq0nuM/mWZWteAcLFmq1yN/CMwBx96O6N11VdUlp9rT3xnLuZ9IgzF5akMj+ENCbVrBthSnAjlr+/goBoI14X59rpxoBc5goVx/2IJMq3M8bJMV6kmpe4G/Calie+f+pUxTR2qQr4bmZe8ToxvISg4dPRK3JlUODukVxi01P9Op5omITky0qOYJUa4LLyKo0126XYM8GhLT9oyXhys7h5h5Nd7MUrHKadnuAgmByWRJTSjXV6dEOpUNHXkmvl4RlHF/B8HmwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9fETcPtL5YQiOBzBCZmIIn3RTy+V/qG3xrwTzkQbDo=;
 b=tYOEZhk8aiMcFCpKL39woI8cB2WblC7JHqVyq8TzqbyWRbrgaFPVZcafRo3cfamFja3Kdtn1lEvGM+bg3fyh2lBu3fd9w9zEO/WFJQddMDUbxCLO9nKKfClIBMmPn3o6uzDZcR2J59IzdDesDmmgOvwI13wgPRmuTqEOgAd3QGB2fcJXruAGmZRnRg5uZSpleTeB6BzhqplGHI76KWtWu3bFsLarD/s3w5S9BCtWxKmYKZfhmBdj+drvpihFr2DPyeEbFXoYa5bL+iAEnkOkq9kKx7xjPSKGOLD0252CxaSUH0yH956aMH+/AablamwI/qKmCBP8fVYXkpcYQJahhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9fETcPtL5YQiOBzBCZmIIn3RTy+V/qG3xrwTzkQbDo=;
 b=tIuhBmLu3WeF4P1fcU67MDRAWddMszWXuT+lbhjMCOJ21jw/Zb+VR7Bl5FwrSXXbf+1E4n0HLgBLSCbh6GhU/SlwVw7B8Sjd9DhxE+xSjSMSBVsrX2ogYdPc9X+8KrsfOpzpF30b9YqdwHJF3xf4yksURqpvY5PTQS0oPgJUfbhVaO/6Wii1unPHEUPf3xzBHvteVbnnEL5TcBEeOJj8K0i1FlnS53LaoK8KJ0yE+dFXasAEaJdOTuu3fXSq8WVJmWec4g9NiBbxhTIs/R8dwgFCvpshanasQYQ5JPNlsXiyAX1+l6zud2XU02TyNC9WL7YVwBcE42Qwe/txs+Ng9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 19:49:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:49:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/3] drivers/net/airoha_eth: add missed terminator for
 compatible devices list
Date: Fri,  6 Jun 2025 22:49:01 +0300
Message-ID: <20250606194903.459732-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B62.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:4) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 7457f14c-675b-4852-6f4c-08dda53335a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fVb3I+1Sgo3iqxwPy+mwT8g6vIWrjdjVuEymzu4UdG8fm7BGgw/46Fpv2A4w?=
 =?us-ascii?Q?9NUt7xVJHoWI0xqY0c+5bxiP8+l3mqIe+5yQ2cXYC8D56Es1bJNTnhnWnkCW?=
 =?us-ascii?Q?PLmDMPHAaXIN0WJsdpXchpCGJnMWH9Mr7SDtusZD6JaA+KosHpRG++WoMglI?=
 =?us-ascii?Q?xiSi2jQ0/c3bgWSkQPL/gE0Vcz8AGGdfEcfqlksq8NAIzF1Q7N2Py+BRK/Uh?=
 =?us-ascii?Q?hulNzNcuSsJI1OmPy0IWWcw3BM8RTRskILLJL9DVkyWdwNsgBXjMq9X+56Pg?=
 =?us-ascii?Q?F2wdrp2xuP0YDTuuqFjW1BHUywj7TYhQ1GaF9AYDg8qPUgAtsCP/cdN2dC1f?=
 =?us-ascii?Q?kn2RDgpeFKHEFtNTE95avPKFmBGXXYYTAdxqhk1XxWk4MGslteVueiRHDa+h?=
 =?us-ascii?Q?DJt6tw7zKaHJqCZPdpjm/sDJySEPRM7UTfPhnL2xhp1OsKdUEM535KK7PRxH?=
 =?us-ascii?Q?C/DOjdhp19tQ5IgmmHZR8zBycNFEpaEAVD5JJwR50YfK6pBk1cgBowARyHcP?=
 =?us-ascii?Q?X76vkR5V6px0w6rKHZdxBmYgsrZEb0sRkrhUza+v+Qe8gATLv2HC9Gj8rAI/?=
 =?us-ascii?Q?l8sDxcDHM9h/grVyEe6Nd/RXNgnFdHAze/B7p+xbOH62Q7UxZkC70vB/ttVF?=
 =?us-ascii?Q?7XbA4dcZIf24YxSaKaTe7GMymkvunBcNn95A/ISr5p8SYII4pNv4XCRy76jQ?=
 =?us-ascii?Q?5xvmfrYrwDXFTwmzNW+pTWp0G+PgkLcTSrr4gaMBbJmysYXk9swxi4FoPgxL?=
 =?us-ascii?Q?MfbiHNNoANKO1J/VvyYaPxZvFB+as7CIL/L6Gt2L1jNlvkGdaClZQLbJUdH/?=
 =?us-ascii?Q?0PKtJSTYnxZG0uWr3PeKrdO7eZtRXWpAHdTISTR2MfLUq6X7GIDYggmUFoBP?=
 =?us-ascii?Q?OS/yWiOfYkj7vdq8lrLDcu+1C4KJqnSdc0SaEvaDBe7nWOMd7P0RGOSF1DeU?=
 =?us-ascii?Q?iej6XFmIoeKkrUsPgvTsUH9ulYfZkJ1IWHbiKvhOLa+J5P3k/nchfDZOQotf?=
 =?us-ascii?Q?Dg3Id0eaz2MQgF0e03dzFdKi+T+TD2njCah4e2eF7wFMYODuNxlccloPOrKU?=
 =?us-ascii?Q?RBkrlk/WB4f/+Xyv4hwK1NoIOxQnE5rg/+deSltFX0bHfIDPcJqpnFw5beYR?=
 =?us-ascii?Q?YBJ6VzCQpmklOLH+mdWuUnnBphA//KETLqF2YkYStw5dwpAOcfDFEakHWN4r?=
 =?us-ascii?Q?MPmJDaNYcasnDXGSql1hb1eSMZyHbPT2rndYOq/7NxtXv15X35bTTiENmoAr?=
 =?us-ascii?Q?rU4gBm7M+AUEuNuhvC+EE+UdJaAt+X3wAjqJ0gjcwLtQrAXvuzsZ0LJdx0c1?=
 =?us-ascii?Q?yCd5wYg8KCB6uzm8+MFQR6rgKgy/OnDDXl5mHPZX0LeTdxGdaypnVSZ9ZeyG?=
 =?us-ascii?Q?XBM+Ngx1q3AIwTFW4I4iYXrd5tGz0o4Wx1nhWiBPvd+AFH/aRGZzt1aJeNyS?=
 =?us-ascii?Q?SKBnNmk7SpCKzGTQcgQO+6oLXWPdKzR5av3PadrvkL3SZVxsN4A38Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lU6lMzeBhY1CwgAHLkmBEEpfGVTzcBSV+8sjBY4O77FQ0fH/sUtRNGfQ2OTa?=
 =?us-ascii?Q?8RjbRqY5TU8CjkIY9lgmm0LAp1psSxFd9ymGcOUPebrDbXhTiQIIb5ogV5v7?=
 =?us-ascii?Q?V1HW5Y6Ht27R6VtqZeWp1P+4REVBW3Rrr3v6MqzeEZa0/637jOEuDm5xYyjC?=
 =?us-ascii?Q?W9GKvG5aas+3cb2/0c7CeMyb0DO7eYseQrM17V9yf4hCEBp6gdJdV7OhvDPF?=
 =?us-ascii?Q?dz+CiuMHHfY4+Yq3qvwLyykU+e42Z3bJDoohsRpcYwaM8CKb30vtzBCEGLZ5?=
 =?us-ascii?Q?SH6Uh+IUtXR9uMvS4SN5Hff+Fo9Fl4OGmZC192THCuFjytGheSqO0mvu1a3g?=
 =?us-ascii?Q?qi8wFJIpGaE9G5hmwuYExT0/UHzxF3kEO6aVw7MZ+4LO+a0due/y7w+aCkH5?=
 =?us-ascii?Q?t71Dqz/YtCD9cQ5b4nwqDKFEoRmkxvvY7t5tMUmhSND+baDlOYUPJaqhHfJP?=
 =?us-ascii?Q?78Fh+0t2PZ8xmUEMtdeSiZ+7EQtiEEnAxbbFDm2XpgBo8yCEAFeuzN5LtZCS?=
 =?us-ascii?Q?vPVV0G/YSZ+/W0mEQabKvdhqTxylt80Dm9sIj+tkdikXthpSfLLLcdz3eEpV?=
 =?us-ascii?Q?7Do327A2LGHNjDHvZT6Ne5h/jRRgPt+GjxSV7EP+yUFQa9KtAuQIn5a8OYny?=
 =?us-ascii?Q?aNsXjOwrJFK5ss0vGj8wyfk1CSQTCAI3vQI4/dSM5zpqA8psmBGryreYyngA?=
 =?us-ascii?Q?Y/ONqRJkC0mSABEDCMgbnVlAVNPF3V3zP2Znn/S1aoJQx2JRqpioC7TC4480?=
 =?us-ascii?Q?6NtqfKp3ZdUu3/RB9ekRi2zT5lOs1ev1P9pAEZ8JBH7DqujJ3JKyZbzONA3c?=
 =?us-ascii?Q?ov0heHHjj6rQBXhgyuqimdj0H7oKd63DAAN2qQBWhZ9Ad+Gri/LJd6W+AOi2?=
 =?us-ascii?Q?6NyHDKC+hfTalwX4ZZWS1SNa40psA36sf+oqeg21xlkfBnuk6ZqxHDnR7C9G?=
 =?us-ascii?Q?OwhRSFVd1K2Xq5GPcO8NVvfab9ENmOcwx4SrLcsTeMD5DE4GFmiKllYzB9kp?=
 =?us-ascii?Q?zLx2zK1rc7DM6DQeSpEjuPML2fmHSLkkXUSFibGsinhdnKTFauTQU3aY4p29?=
 =?us-ascii?Q?zT67NNZxsl6DdvU9N9c7DosbJfI9Dq3RSPlkHI0la70362bhok9mgSBIIEkM?=
 =?us-ascii?Q?HFqUNQ4rcegL5AdA9Eao75B0R7kPMLNfO765g48z8qn2K6HvwCykZzQOcWW1?=
 =?us-ascii?Q?a+DYyZ98W2KwyvqMwhNSVFIeq9u8UdapTyZfTf3E25azhq/dCVnd9NM/CN4E?=
 =?us-ascii?Q?24JbglOuiSfYEpvlmgyq5/mNaMswdXGnFOPXtavc/0jJcfa66fR+YmLCzgDx?=
 =?us-ascii?Q?eNfQ61sWiQosxK68724G4Tsy/zCi8Vu8COQ4sw0eP7ClW1HcfFTvISKERHXN?=
 =?us-ascii?Q?O1EhTmI4V9NXqyDRui52jr+XKjPWgPLswh4lhVRZ3K4cOO67wwgbRfyWtFlR?=
 =?us-ascii?Q?PdBL/ZynwrezrAMLKFt+HX/BQy771IQyhO9kZ0JhB9Ge3F3IKTHfixBFMxSC?=
 =?us-ascii?Q?xqVHPF8vk+EOxH6eEWrixLwa1W0cqcG1aL3CDwWyKSX3MSbO5NVCSXCx2BJg?=
 =?us-ascii?Q?Xbeo3ZIOONk8/CYFTsZdNVArO9uF05vH8gXGR8Fa9cycrHoSChJKQC1j+wDi?=
 =?us-ascii?Q?PywShdAb/5+nT8OG/Xke+Q8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7457f14c-675b-4852-6f4c-08dda53335a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:49:12.3506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kstE6INHvKHMshcGRy7kLP5pyxkASFyDAkty3KW8XSJp+NEIm4f3XZf/ctToEVcZBOlwMoGxojmxhptj9/sUfJVuyGyUC1LeXmQwkvWLFCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992
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

list must be terminated

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7e35e1fd41d..86fd1616da2 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -926,6 +926,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
+	{}
 };
 
 static const struct eth_ops airoha_eth_ops = {
-- 
2.47.2


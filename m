Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6906AD3398C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0113890D0;
	Mon, 28 Oct 2024 15:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RkKe27m4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4B58907E; Mon, 28 Oct 2024 15:31:57 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6625789098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIyQjAH1UB3Zz+SeAjiwZWmBS1WjG48kbka5H90mXWYMPMr697791Aj0bcM2x8RERy2Iif77yd/Jmtp8lHL3xkkPpMTVGj8vUSxxjxhSMqwrnDvVdI6oQeDeLy9vQ7f9CGoZPTeL7BErOKqpeW9QtosGh+c76hg9VHW2kdJffzlFoOySokocyqQn/8jLi/N9Tx/VfvYBxrPltjB+s8Iyqm9Rrbey3g8Pmc6GZIkIaJ6ucQal9t+aMKzSq9SDvPQF2VUSbD013Ki1lsLAoiNasDQPEYp/8MWCdSJ9zyn8WbcrWlGZ5cIWLsvrj9rs+6Zjpl9USSZq7/CrKrkeDA6Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=C6PvHJzs/AQ9xKJx01kdhkwlDChtyCiNU9dD3d2I5VOB+ZlPyxxZbqZFbpm56g+BCgvYVpg7ZiEZKKdoOLEjaf4hqaJU1H0+G8Hg6A1+49Bs5xDrJuPSQhXeMNhtHWF0e8BDD0CVARzTEYmXq69ySPSTbsQJnT8HrvidONr02E7a5fciuJzwimtQLCQnbIjG8sobb/z8Jz8Iu2oc3L8hJfPYPVaueHQYfyH12o7hf5ykIboy6oCx6HCBHRxFOQ3vB5Iz+CbUlY+UvZ+IIf2UWpGAQg3DalVEyMr3Se1G46RJJZr863L/08yZvzIyfqiJU05BRd3+JQe33rwnWdB0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=RkKe27m4pOuaS6feESxUGpf7lGG5/Ei6N+UBZFjHslJeFM2SKlJas6zH1NfHSyZSzYQLlJx0S58G09LIunBei/kKFXmgj2lcqPoYULpKZCkSBW9HDebaDvH85elRWFnHcBh52cx4NLiEal46h+ZNzepGh/fshGg7MP/yHKW6nA5r76Hc5UD0+Agy789tPfwfEPqEMiUaULAebN6MVDdMr8F8I/wKEs/9aaYHxmQIBIxNES3z+PpexsnsGQBxQtkWnEllQEziwv8NoVgIwBL5AEQbpWRgcBfLyPvq4Vbp+4ehX23LFY9u2GNiR8b2KtxLt1jwJ8NpoGTRfAqigTDetw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:31:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:31:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 01/13] net/tcp: fix TCP options processing
Date: Mon, 28 Oct 2024 17:31:31 +0300
Message-ID: <20241028143143.1807305-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd3aefb-77cd-4ca3-195e-08dcf75d4492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJOHT7og8aCAUdnCZQtF7coU/gx/pOd1eSs0UvRsKkZeyt0wisxOe1M8QXip?=
 =?us-ascii?Q?B5u34Ksgp47+OgBtpBe1IoITIzrmqH15lfKHP8RddFZRzSGB3sdzGx1xq4yj?=
 =?us-ascii?Q?5+5szPHAVMmG9ImRinYsvcEWAu3O4EVDPoDR+CxLOfQ088Y1NiCuxgQYoD1P?=
 =?us-ascii?Q?dEdC/1TexWjlbbyWhXO5xrLEApG4BwAFzH4kdv2CRj1anx7qMDYrvz9wN8Us?=
 =?us-ascii?Q?Shq9qCMjGor5VAtwS0zyz7tei3av1+ib2oYvwOmaxjsnNXux6va29q3b3j2p?=
 =?us-ascii?Q?vXudM63lfrktpxN9xcsZpefeuNOCeXIVXlYlyW/5bshvZeqs0l+u7j7TuO3B?=
 =?us-ascii?Q?9BXJRoCK8aZBbLLtYLdo+0ODroD7u/t2TBrNxY1WOi5cxfNRwQrFduQTVzB5?=
 =?us-ascii?Q?SZr7+LGNVK16DGx8EP7DoxqyAlLRU6qCe3FBcEqRviHhSCex8SsUb91h5XvZ?=
 =?us-ascii?Q?7evIT0bOEHi+b9y1uvhCxcSmfBlftTxXJfIwwYmK9gowWD146xJt9o7q+IfA?=
 =?us-ascii?Q?G4NRhYf4QxCIv2zl9rNA2bIfUObY0VhFPe0GbM7/arg/b9YEG2xvXzWDBw0M?=
 =?us-ascii?Q?VZG1xlhmjcmebepNmVNkOABsgkJ6iQHAFOqHbM697OurqzL2dFIfi7bkhgVu?=
 =?us-ascii?Q?Qmyq6FV63j5yABFnhg/Rq/xAqFURJLmEDTjAfUvexzitJh/znmhsKhPeYtpC?=
 =?us-ascii?Q?PxNgQIOA1tIyY9MaLupN5BmcgUirinTcxpJWmLQe3XL/zEm1FZQxRkHFs7Rx?=
 =?us-ascii?Q?FnVv0/cGqzaxifVVnqwkWM+Yy2kNQGEAvXTz/JtCavF+BYIQLJE6bPXJBZgF?=
 =?us-ascii?Q?qux0nGq8fLby7LdimVpskxJmBJUmfuFG0laKT71v0Jl9aXw+mBsJz/6ccAPP?=
 =?us-ascii?Q?qAnP0c/1EpvaC1xyL6zPDZpq083LtKuXCoHCZ5yB2IQI2tQvF3E94a6qQmAA?=
 =?us-ascii?Q?CMVr4Jsub5wAkASsE5mf7JfXUA7jOtssJob4YEaWBPpxzKNtOV7g1B5F364m?=
 =?us-ascii?Q?qqpzSyRg8hIloc+tfsqEatA//m8JhivUs55qJPKsRbeBfUd10jz955O+U7yq?=
 =?us-ascii?Q?oXg3e62ISn+Z1ZRV1cHJge8GmYImsTCpQu1xnV2sAIC4NnmlFCDu7t5sZMhR?=
 =?us-ascii?Q?IfmRQ7a/Rw3pd8FFTTw3faAYSeds7R5kSqSx+CRlzt6SZ9U/opYWSQm4iZ0u?=
 =?us-ascii?Q?uLA44jVMawJmvLali3w4VmB2x3QKlW1cOiQsWr7C8JxNX7li4J2N15t2KHZi?=
 =?us-ascii?Q?z66CPRqdU+yojHY1CQPjqE/ZzFAUgC+Q2rQugMM42g99WzNzTf0ivrJLieRS?=
 =?us-ascii?Q?l9XxBbrQtwr8XWAOdRTeb3Jl2Rk2kP0heBtNZfFVIPPdwMluehNO7sRwjCgv?=
 =?us-ascii?Q?dru84+gc9bpYvkhJXVPREpvcPbpn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h3KNOctBqWaBwfXJ9U7HJtFXlQMvjjSh9Jvkt/D0QVcbh+I8icKl3v26/0GH?=
 =?us-ascii?Q?mWU7z0jAMAZqMO29wWEcDsEZJbZ5YqVkW+WeOCI1fWcmljnYYgKZRzVYNYBd?=
 =?us-ascii?Q?vrOdeAAJpsXLfgrFJS/gg9IFcG/LmbOHiEoUqyfyigryyOfzj3Fbo04InpmR?=
 =?us-ascii?Q?ILK0OgBZWo/V2UyYnL2EfQ8tzrSvrJuJfHUeXCohxV9hyc+Aq8FPQJ0gPMqd?=
 =?us-ascii?Q?7HJhmq/RhDTVi7UNj8SNW2MCg3IdiFBJhc15m6GkI1qFTNwW527erWHcMa8j?=
 =?us-ascii?Q?TuYkcYaauFwLnKRFqahBXC8GVBL44IKgHMKHq+xsHJvtN+qVDP3Ofg5X892G?=
 =?us-ascii?Q?XjLEo23DvijPRZjdnpXBOtyyIbtnS00FHEUJh4pHM4x9HBTjsIbgZyvexFNl?=
 =?us-ascii?Q?hrEOyTmeobmywFKRAOwz8X6T1maXIYRiFewYXCsRdwWGRLenV9m1UE3OOg+s?=
 =?us-ascii?Q?P7aQIkIol+GyXcm4dlEztsSJ3QZoBal4khKdtnBkj/ohByiIgpfyqdDQvhiU?=
 =?us-ascii?Q?ZymhxnbZCeba/tv+nx9qVqImYkn2I6bcTLgJfYCN4z0/8OcbDJHnBckv6zXe?=
 =?us-ascii?Q?xWycOaROHr+3A7W/EIKoVJT8cQ6xN7bFlz+GwqZBwKzrMGZfiZ/G8G7K6ffb?=
 =?us-ascii?Q?l1MK0Dps1HIgghjdYXdEXneQd2M8Y1zjLpefIkDiBSMpTIz+Kkuu6cSytGl2?=
 =?us-ascii?Q?jIITGZmUdPhCFVrXQjdASlqlGIy7KNlgiWr/7JGYFORSnbwrdP4rckyCv3oD?=
 =?us-ascii?Q?ERwO4OAYaTmpjd0B9PxOCmbtBMRbW1tVlQoOzRn1QoX3HKMeuwIdUcpeE2dE?=
 =?us-ascii?Q?iw26lBdLzNz+eimCYyI3hdLrMGa2YZ8ZWQolodFr90Tx+v/2qReUWLgOJu1u?=
 =?us-ascii?Q?vCoHHgaNNmYY6d7fgLJe8wzEb5+NzPLWP7Mx9rVIrwlC8F8q6F28Lvib3ZVS?=
 =?us-ascii?Q?deqUnRkxkXWpoHD4n+rqvMirBrmxQ1nIYTVBW7HdNQHv01JuCSgV3vM3SVpk?=
 =?us-ascii?Q?vl5w1XnPtushF0fOOROXKZ8EfkGUqTVQhB2vtjf7IC0d9qP9d9oAflEVv5Ka?=
 =?us-ascii?Q?FOrB58tMbQysM3xFbGp9FKX1daLli0PNg9qrxYoOmBjidvErBA1IbH7Xt5sh?=
 =?us-ascii?Q?mmhvBuTzRDvw3rMjDOp9JnvFCeh/OcM5vTeaZ6/CHNqipMdZjdV4zVqZOpKX?=
 =?us-ascii?Q?EsjXAI8qSjStY4sB2KcxngyJqwLGmftTEJX8mbTg5zvQ40olI84qfnAATu46?=
 =?us-ascii?Q?YRIS6p1ofA93FSGgA4MsImbWQUTGwFvxwvdlxioIJT/1g6pzSF79PXnfnahp?=
 =?us-ascii?Q?nnIAxMQgo6WrOwcY7Keh0KauWHDYgrjq0oCbaqQkgczH4uF/JYXBn4zbB06a?=
 =?us-ascii?Q?75lvgruv62JTCda108m/jxTnFvPxdq42I9srcEichdOs8fFZsE8Q+MLL24KU?=
 =?us-ascii?Q?HM2HLgU3Hvn7qNKwxVHDMmmrVAo2PvAiDE6S+OtAchh+o5mciaR//ABHgV1N?=
 =?us-ascii?Q?SvTrLTk9SKiDkirwLB146WfBH22XcgVksKGYbcYwPoOk5Gp4swMSbH5vNCY6?=
 =?us-ascii?Q?bODQniJ7wxxbjy98J7OZ86jLaFVacwI/IxJYOcYQwj7WsefBEEJiLKgR6rtj?=
 =?us-ascii?Q?s76XkU8SZOA0ZyvHwILpUEA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd3aefb-77cd-4ca3-195e-08dcf75d4492
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:31:53.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDQjvuB/VcFiopIfCL88HnOuRuu29EQbsGWgdoWTWidFW+h7bOHdEC1X/zNws818X574iUaOPdHJzJ4ikDWcHf1qF/jvVMTqVsWe7XYjDzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7714
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2


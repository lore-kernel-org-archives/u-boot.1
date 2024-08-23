Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905ECC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E881788B3F;
	Fri, 23 Aug 2024 22:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iyc/SUA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76F788B9C; Fri, 23 Aug 2024 22:45:32 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B098895A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAEe/L+6elaJH/CVEL4zm7PY7t9s8u0QyM7wHgVQft5bn3iQD2OTJ3g4tJ3K74H21NyQ2qcyBjsYXJaUjYuLZyaoDlFjHEhMv8ALXGp1amZgNaqc4gHCasRXCu9v3EucOBZkLAbrA7oCS0YNE6p7asmweELnzlgxf1/OJZH6CC6hBzA039VjvYA9qC+UZUXk7pQWwZ1rJkX5HaiOMikGv3nb8AQ86/mpEAgZ2NiiDluY9ziyW+4I3vv2QO7b1Ouf6DvGAH2MD4ToEq2VLL96xMjYQQgvr4CZgez2GQbX2eMjM9+k4dhe5NlwWJ7O9mVmb1amGeoIeppBo7AdTloKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5LDNcV6ld1fkkvGz+Av9Zyvf4dlWpsdwbEWmCK0F2Y=;
 b=HITUd7OLGwiM6r8oSuFP4qLZUGbUabbrFWKVzEMCFgh69N7MUn3eNOJXXMdKW8tjZFwGrdcYbEy2yAba8IbXQBUNjS0ubIQfs3MWnyG6eJjHc0HKN6p7VoLMUfJv2lxwy++JlH7Gdxj4zRtIx0w/r27rQsN4Ff0yEtbZQ3UaooU7D8zsgMSOc3+37FWE7RuKeRLf3JBbEPP/PRCePMNKU3PUsBWiq4lWuasjtSjNST8u/XiL7hj9JZTqxANDOlCuFjXREYh9a9vsFlvjkqaTKo4b8Mzqa1w9ODnXaQBiovO05bipP0ax94ofpfDsHsdFPGYTc0t7rhbje+ky1XEbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5LDNcV6ld1fkkvGz+Av9Zyvf4dlWpsdwbEWmCK0F2Y=;
 b=iyc/SUA3lqmYlKaio+xxRjlPHqOWGq4kIEVkslKaUa5Ar2aoJoAPjD0Yv2RwKGuAab8XIRl1/ma6A8dlRtbI38rcahA1moMz48v/TuaxNZkNmRlZiz5b3Nxxfkfuz1jPM+zMS42bLPiwhbxztug/2OIYu9WS6ltFwHcRaeaAFZSgwKRnyYz1pijsI1AI4p3m9Cynxy5Xt/ydNP0UBwt6RMsdqTy55qgwtMhkUUrM1Em5HTB43kv67mNvmZacKQ9rHN0gQRpEh6UtBf+ZL5uFi3lUiL0gSYE8vPHyf5xFVLsuI/lHxPXy0y5TAi8JZvGxkMkIR5a4/at7JWwf9WLHHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11224.eurprd08.prod.outlook.com (2603:10a6:800:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.12; Fri, 23 Aug
 2024 20:45:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 20:45:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 1/9] net/tcp: fix TCP options processing
Date: Fri, 23 Aug 2024 23:45:10 +0300
Message-ID: <20240823204518.1010194-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240823204518.1010194-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 94096945-2bac-4c50-e60e-08dcc3b4857b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XNmhnSTNbwWry/K6/bukKpzD/zxiIaWvfcfca6S15Tkd1PEt1607w8Kaju7Q?=
 =?us-ascii?Q?eBiWKzFaUtegYy+K7u3WLvNRw7xef0qC9kQe9A51OQIKZuPddPPyRe/QIiJI?=
 =?us-ascii?Q?rN0qcTMPI4OmCCoZDdaOVR+r43cEybQYcBpjQ7FMXFLclHW0O773rEkw1xZ+?=
 =?us-ascii?Q?3Rxoodid5CwI7eIKlEcPV3rS2Bb5vouxJQbKTpLL51I0/9fPRJYj+3Kl33Cu?=
 =?us-ascii?Q?ZETEN9EJO7WiilnvdiyVxw76GQUZc8NS7H81AfDD7mBDXwWXOu3lnbNA6b0Q?=
 =?us-ascii?Q?HFtaNrRLMaT++1vrdO3tUJ4W3oRWO74JfPFKRGBFPIDRHyyxjEObygGFDHOl?=
 =?us-ascii?Q?40VJTD6eebjHwJkFUgiUx3fd4Z9vdW90NjnbJ0V9nPMiU2jw8zwFQcugTQTU?=
 =?us-ascii?Q?FVM1qKAdE5AnyPuXbXroPEcSWcnQLqO4Q/LS0QQkp3hIhfujJYALc/V5ucwp?=
 =?us-ascii?Q?QRvnwA3HDZdsV/xGvY4kVV7dPyMird/PC+LP3kt6BPNnZx7Ayu+E7tLGpjfg?=
 =?us-ascii?Q?1/rU33CgGLbI8pF7Mb8uwXatyyuYQkBAfkwbESmeeDCnKNolm6VTErYC3cSw?=
 =?us-ascii?Q?AjGzrmcYoNshSfgTeCjJ3HOGGJEdcj3vY96W6j7tTS5BxcjSQ9QKpONr5O7t?=
 =?us-ascii?Q?P+MtPHjl6jwxIsWPTQFP9hZG1tbiz+zjT5SJMRBx7DjG4hmjic7QRorfxf9t?=
 =?us-ascii?Q?W1Gp/XbyEHbVzT97triuWfUyLPMpT3JBCJEBkXzI6A8SSMReHt66JBI9BEGI?=
 =?us-ascii?Q?gPhS8zSXuaEm4LIhovYR1AHRGdFQtqumOVmIWkfj8VsLA8Gn9sNtuVDn5H80?=
 =?us-ascii?Q?jkFnY7NeksKAeC1t+m5hIZqUM3KQLYjXZB+yeAfQJBLh+UrcnDw0OObujd5Q?=
 =?us-ascii?Q?sJ1kFRS+tpP77MhgRt2tFt5i/5cG9i6jHXu3FdYIipv+k6NOcoKH6TGQioNl?=
 =?us-ascii?Q?VRNMCdcr4VDq4KzwqJh1h9Zu+sJsyTwmnPx3u6YBjUIPGsTwQwnV8S2kYZce?=
 =?us-ascii?Q?LaMyJqo2KV/uPPBpF6FVzkyORvP+N9J/UWUK57M7POQ6+yZDlwr4pDTXk60I?=
 =?us-ascii?Q?ocFwvpF2GHz9P70ZWLNHMmKnnjDFRc/17AGj8NzCflEvsqTZRA74UDxCks23?=
 =?us-ascii?Q?oliVQ9TJZAmb2NCgPHQPGBSDjsvOkpmSxqcbkPi2LATTzJf647gfG6TURivo?=
 =?us-ascii?Q?kr+Tympw2bK+4hxeY070cBIw2goBE1lzIhhHLhrhiQqrlbaIDJIaT0IrDt5t?=
 =?us-ascii?Q?BJ1gTGiW0Cm8qGzlwzfXYo+66qMCbzxede1rkCGbZXz1p0+vW4UDO7VNl0v9?=
 =?us-ascii?Q?deU7dYpN+TT6G7Z0BR19NkMuOFJaCWBv1OdNaNrSA8mGI5g+PySUieTJYNPx?=
 =?us-ascii?Q?CPOFZ2mk5kOfEUlZGiL9IeVpYpfjgDoRIjXybRzjpM7FelwAOkYvyIWPJj+V?=
 =?us-ascii?Q?mvLwCX6tiwA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQV8u4AsmwViZUnRRxoVfzebW0uqUkB0tq0xX94j1WHn5kfnR2G47wfJh6JR?=
 =?us-ascii?Q?6Xyu3jRBE2+PrRDEuXxUeTDE6roTuBZ9BRMPs5UbMzO9SfVNdNbkJ8VQUKa6?=
 =?us-ascii?Q?SPXiGxE33k/BYiMyMjHFBjw+tstlQXgH5koMfUh3HnhMXZIkDKPR2Cg8pI9+?=
 =?us-ascii?Q?MnNDRXNR5DTdhI0NAYmsNq8q3nvFULr+978vsyIATrMtEMRcnlA6pbOuO1iR?=
 =?us-ascii?Q?WbOiGoezpC8TsFKbxYQEBVi9e8xmGJO6rM7EzSz7Y/o0lxqCy8xkYYaquk7K?=
 =?us-ascii?Q?zdL7rL/R655zeN28ViSwtFv5RK1B9ZsnuQ7ZFx67c2tuMHTM/M4Fz6Rg4ojJ?=
 =?us-ascii?Q?dPUWe9iYZDHFZKP6P8fOxVmMYBfhGxApxTxsB8QXYlNj33tr+8y+6fQGuDti?=
 =?us-ascii?Q?yl3+GaRU/OAr8mdI2kAy6ix4YriNPhvI3puj5nzmWc4QrK/BUT5ufmBPga2z?=
 =?us-ascii?Q?eoV3myszTrv3aF6h1pqlS3dB+DFXIr8N4zVWhec+QEnvz7gBUGF6kRPvKgbl?=
 =?us-ascii?Q?VL7cJvag1jashfINNdYuTvNwf1C+bnk4kQCJNSKu8GiI31xMR4GsIq49T7Lp?=
 =?us-ascii?Q?DelBaCBzQ7SxWIFtkkHJ6+IantAgk1Vwxm8uJeEE13UTGOMM1RTzi2i09Otj?=
 =?us-ascii?Q?iVSJ4NqqEHjVoeJSYQjdtp8AcaGMyGH5b3+08Idp4S6u2wlP1VQ/leGspI3+?=
 =?us-ascii?Q?A+MwBCN1JeUH3KOY2rx/Ip2zb123zKN0TvaaFHyJ0qlmSCDyhf1JVg8KdFRC?=
 =?us-ascii?Q?f7sVouTTI5CMl4KYnIV1RQ08lqL1rbgxc6wO+1kPJycUb4oV3C1y0fShEpVQ?=
 =?us-ascii?Q?uzB4XAsY3YAgV2E6dGD+FQfHfk0poKqtBfWi/pG7cMI+QMny0F668gD3/Vc+?=
 =?us-ascii?Q?wKAkX2IbulTkEsMs+NIQvboTRwE0oL62JtHzttyBtLGqvZWVKpVhetERqMw5?=
 =?us-ascii?Q?KXp6gYr7vtv2uf1cSZVAwFRv0YQRJ1AC5LX7RBJvdCzG/Eg2QoDefCBHYqWG?=
 =?us-ascii?Q?MhiQPDRhl9qj9E4qtiJ85HhItxCaoZ2bR/wIYUjgJOx7TAKVhm86LOeSwyuW?=
 =?us-ascii?Q?P7hckezeuyz7/0bv+NbJtqd62zJsHEDyT06BXnF0SmMpoTzbuyQCXgnMaizJ?=
 =?us-ascii?Q?mbof2gYDjTxsnV9FgH9xp4DRx7mrYBTiNEQsa5asOezL8xAkVcGg1RQM2zAb?=
 =?us-ascii?Q?KpjiligEBrtfGN3bLi90TqA+/Z+77pJ/Jki/iBTooSYvGkKSXtv4hWJb348G?=
 =?us-ascii?Q?r0qJljrJ+W8kC/7kXH7Fs+B/ZH5gDjMEHuDSsllax8kPc+HbSXJc4N0KonIb?=
 =?us-ascii?Q?JBn+uXhJ9waU3ed/dWqbUDBAA3l7j2hr9EBLcHdBxN1ahThzFOERpLaM7QXE?=
 =?us-ascii?Q?z8Kte28QMvc5lBHysZajvD8U9up9Bu32WrkIXX4+EDZ/IfUTNLLGM8gHz6r+?=
 =?us-ascii?Q?5h6rMHt30TUBt6CdEW8wX0hbz94ap9dbnyExNP2VN+1Zx4ZPXqXw1JnCqV8G?=
 =?us-ascii?Q?VZccX7Ar8rJqU6J+hFSTuh5A2qxtDZIlvzekhKSA05x3v1kgbCXxEvJgThKF?=
 =?us-ascii?Q?IACX7YRh32C3/mUHf1FNfXidvshRdogg+q2oWoRbXFIS/vASJBFEacfAvG9l?=
 =?us-ascii?Q?whCItBqK9TsGDwAKpn7I5hg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 94096945-2bac-4c50-e60e-08dcc3b4857b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:45:28.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qJQKh5rpIiod2WAg89KtQ/jgy+ItMY/XpsQEBTOGLS1NHaqPcFwSyVv65BakWl5pvtGF/kYQi2URCiCWWYGJ7H//xqqaOzi3xPmTjOYVsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11224
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
2.43.0


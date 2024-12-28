Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4210EE7718F
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66732805EB;
	Sat, 28 Dec 2024 11:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="IJzpqLsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB6C80431; Sat, 28 Dec 2024 11:47:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EDA80586
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wxebn+PUU0cdB7d+rT5NrNWIe8Xy1dKurb/j1dg5SXaW9kfKvwfkWqqHwDGScjUb2P6U2Hs0lJcQGcLB55zqzNELExKPx3iIWsJ1Mu3VAjeP3zy8W5gPYtESjb4gzoxLA4Uc9dPWI7a0tl/C9gIlFtWc+VYSHg44Jtw0E8dXGv6lt51cG0lYzSKXSa5Msca/ZMHE6N/wSvG7uYeoxRsNm1ymRyqoWM6r3lCMwKcFfpSN1K1bf+l9v6bQZxn1FSHE2ZlEtvL3fKYsyDmhhJei5yzR+EUEC9KT5oK4p/VHzRHiaB1BL3KaqXEQ7jLE+RUjkhrItleQvJ2IrdRLyTM3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noby0rk9l0CeZ/ydWdJAmcMlgmBDvLDZ4iVY4bwdt44=;
 b=CDCaDfwyUwanITrWAke22CKI6aGfclvgnaf6BfQF3qAAvQuu/WxKRhXRXorN3/sSOGXNtmsAc+5q35DuQ60hUbFYOirea2F/3dUxPRY+GnnneKj6oBDJrkfI36PkEQ0yYBMCTQYgTfO0LinGUTUW8y8jL/e2g0Lmn/HG4HZXBrKBLbZVJw4ygC9Kmsq0igHyJbY8G8xjHQAm7DTUzDmCBojqR1Jlwnnd6Z36J0UoRFX3kjFNdKFwnUSctbr2QO15z7gvQFdcJHStZS/9XPZwyfiKpA2PA9xfGMHmjLGJwAr4oUBf8JXiWVaXbl9AZDO981ipswAlCk8yaEeknn8n5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noby0rk9l0CeZ/ydWdJAmcMlgmBDvLDZ4iVY4bwdt44=;
 b=IJzpqLsNm/K++65E+Fl+mA6WM6fIqdFIg9X6NQqW9b15zsmDufl8TIb1onVhoIxd9iOaqCKRYUADVlhYve7ITsSzy18rNeo9Ss26HvO/RqhWcsB4ggQyDoyUCJON32JQZcjrPCaHs5sAevjA90oPjgfP7VECAjFk7Usljlyt5FXIBtD6pgdXax+0QBrHLlfZEwMp3wKvbkHF+XxMsXhqAvnGH3eo/eDBeraKcGSkkLFo150/Q4CPGcymkVDp3gFTrK0drYnKwPJIJFlYkKRXw5IO0bKPMqTD9XE6OfDdGsN+WrA+TgFWCL86UpBohHlxCsdL3w7IiiRQCopqtln2Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:55 +0000
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
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 08/11] test/cmd/wget: replace bogus response with an
 actual response from the HTTP server
Date: Sat, 28 Dec 2024 13:46:34 +0300
Message-ID: <20241228104637.4173913-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 67135fb7-b22d-493f-ecd8-08dd272cf275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?udQhgFujkjK1E1xp6k5LGsXy3LZUjV1tt+VrX+gSgo1bmBWYwkQK/Edt/Xsw?=
 =?us-ascii?Q?1CbDT3gDvU+szY8iB4MOtBAlFaQ/45xvcQsYtGWImQzqITZFWznnkpYm3IuV?=
 =?us-ascii?Q?GFkUknryO44DSkkRaKPYcl4XRmcVQoFlb8gtQX98jel3da4Ire432vxg4VnJ?=
 =?us-ascii?Q?nhjQQE3XkG6aRQ83vQIxfE7qCMeLGccTmOvMjBAP/PhAgFMUGZDm5EZASu9n?=
 =?us-ascii?Q?8ZyxG0atEpytp6NTY74qhnBeq7vUTo/YZodmwLiKPbNuSDbPTc/sQRUIsen7?=
 =?us-ascii?Q?7WgvFybiJHPjGYdtc8kBKfB0Gqi4pJpeHGKwx/TOyjnAXypwWflOPa3Owoqj?=
 =?us-ascii?Q?Y9tD285exZwdSrrOsZheRjbhOfH9j6zCJ3/kA17N3b2ik6FtwD4YG569008j?=
 =?us-ascii?Q?Y0ZD1T1dmuzdIqJ1bSFxFP885uGHyaL0CK1qiBbxvxq81P/1Se/0FKsWxy2L?=
 =?us-ascii?Q?70X8qmvMvHAhJBbfJuxc0N+Q6YF06QQiJGvPksGYlJHFoWOrUcEJAupPSAdc?=
 =?us-ascii?Q?jZ/8Wt2lsMaCNVXSHtj+nG1v2UouLbZSCVa0BM1qjlMuOl2HEV8HtLzKZvyd?=
 =?us-ascii?Q?OdEBRG/JSWBhLZx1NNtHnozbu5nQ6rr6sAHGX2s1I+9qTqcPCItydsFdvd0k?=
 =?us-ascii?Q?xvJ/rt148zBNgUc+UK5G5CFnnpH4w1S7h1M3yQXlQoQFi+Nn/fnyWrxUHCUK?=
 =?us-ascii?Q?lojOfvIitHJuF+CYOF0FHUn+fv0ZOXc5g3tN5f/aubNaEoAiT3Ba+MEdz9j8?=
 =?us-ascii?Q?HtGxlRv7QR+NX9y/QtYp+5lxtRui7fXfKQ+m9wNvFN+MsQM3XFluqLOpRs97?=
 =?us-ascii?Q?G7ql5u4eoz7Nrk4lw7Qp7j5bq5YdGkkkhrntnHKlea18+ZtCTF/bdLNNY68E?=
 =?us-ascii?Q?zZ6XI3KublgLUdMhhOVcb3dfwn4HtCWYsdSJd2xMgn9aUUZgfIHzy/3W//6v?=
 =?us-ascii?Q?0UbyOSF5zq126w9vRfah9DUzg2MU5OdBN11GEeA8032Pv4BWHHkUIYxCvhM4?=
 =?us-ascii?Q?/icj3/LLA5e+m8ocW6Orgr14uPfsfqX+TG8S2egOgtl8WnEyz6gDzeNjAHpy?=
 =?us-ascii?Q?ZuEDfH7gawYx/nppD92A8fGvuajHYUBRJV0VCE4FQJT9eR7GwaZAu0olzCc5?=
 =?us-ascii?Q?MOjGT+mL0fUBYkaUz3J4yS+VPdqC7ulZLfzKJSaqy5nK0ZbB71gcw9y3ObuZ?=
 =?us-ascii?Q?h1qaj3WwvI7iP3nvytSpSDbqFz0R0rojtjdYE6Z6H8z8IsSWRqnBhuKZfEYX?=
 =?us-ascii?Q?6B5+cKIwcbECRGgEI7B4ai/eV4TYUDh6+U8RW7x//a2FyvLgumd1M0q+IL5P?=
 =?us-ascii?Q?///TM7f+Nf3YTzEFJj/HMcP/O66ZpY76uUeCTxGbbJGkUJsfaN3p7cUpLonR?=
 =?us-ascii?Q?djvHpRtla2iSGbIa0K6FyxqsAhh1PTsXs8y+YYJwSpySci3zaXbH+r499/NZ?=
 =?us-ascii?Q?amymUT5jDL10AzNnYPJhRLxbfrzC0PdSShPMhaGa1TlkgLNExkbsbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVaWv22fsQWLvj4CMAs2CwwbCfao2AQuRsUe1D9S512k0yAOsgPsmLRMYKlX?=
 =?us-ascii?Q?8ak9RaE9msrgpMowVtL5aA2FQpUJZ5s08ig5m0eX0n4gHMpjE16PfZf7yevR?=
 =?us-ascii?Q?iffSMYl43QlUoPSIWbbowvO2Yy4pdZS1I5qwvLP8SyZLuDqsNd5kwZcPEkCZ?=
 =?us-ascii?Q?JJuD9euqJajacV5sWSfrDnZ8FjCWBH4Lp25iz3A6pAChiYz831nN0MOgwqav?=
 =?us-ascii?Q?ZlJjaKB/I1re6AAfIPK7wk0B8A4J1UzQ69SBMsJvBDsD33oYxejT9F0a4XAr?=
 =?us-ascii?Q?YmeJi0D2jZfptpCz546elc7jQ/564ATBALCu7/Ncr+aYlJmBSHHPKGnZi/Fk?=
 =?us-ascii?Q?ijxl8CuzT+QsqYUsu8NEbSaV1UB4ftGAD2HOfP3j/XQCF4Fl14JdVuuxg8Xl?=
 =?us-ascii?Q?GTOa5zbbl1bfj0pVWDy32EVRzCoUojdUqHCIzCeYXdJskOxqjFRPlbP00OHC?=
 =?us-ascii?Q?77bJDNwlpQuQqPPYs1odqQhIO68iKTnI4cUaACYqVUhntQ1O+zME1cmdE7HT?=
 =?us-ascii?Q?T+M5ge4xJjYmUZTtcB/FoV5mBfWTdPujtFkdJb0vivP6Tdcc35ucqpRpzD+y?=
 =?us-ascii?Q?guHh5pZDwwzi/wQ+Lhvngjr6IGkmWT+f7ybmE81ige8tpA/tOMsEhUVUwJor?=
 =?us-ascii?Q?waxnDvESgX5+9VK88BG3h6tFVRyd4IjV1KUpUQw2jXQ9HAo0Huh+8oUHFZD+?=
 =?us-ascii?Q?bjMXT2mCRwBW2KfRmw64RaQWb+eBLrafL1MRRHLlNe6p9Lvw4mcx+GiWymdI?=
 =?us-ascii?Q?1rFlXJApmNm6lI+OcSWMYPqWupu6z0ri3NnJaPf3EQS6NYDMbPFgI62UtWpa?=
 =?us-ascii?Q?t4lZIK/Z6ltjuPqRIWRDey204TJz1JyNAxr8wJidJwNQRx+Rk1ZYHUR8QJrb?=
 =?us-ascii?Q?0QzyyUIManJQqbYHwoB8Z1M18k4jm+5ka8R3qN9VGCNpxArd9gz9I0ePcqxg?=
 =?us-ascii?Q?4LWny6Ote7GLN7O6UfEUT9NR97eySxtOI1uT7LzmWl6A/EBlsDfSQjoQTGA+?=
 =?us-ascii?Q?UdbgTy+R+qaiPKKKiX6fYRfXeqrOda7piYB9gLLJuVw1hFRRrleQjyNnjRBT?=
 =?us-ascii?Q?Z3M5nuTRl6fTe3Ed8Ibk5W4Os7HL4MkrK4iIGNQ77FK9rCVANZAdsoP0oa6J?=
 =?us-ascii?Q?8jzyxznK8OKiemyRMWrlpTA4Lu/wEYWYKfq7+THcZonyI3mc6D3WRCKkXBxC?=
 =?us-ascii?Q?PhZf/w/42C827HRVHbHtbZll6SRjLkquUqBiWkxfiFMS+kfQ2Ux18j3TDRLb?=
 =?us-ascii?Q?S06tr7pdy4p9CMEvBO5aafxJ83zpr5sPoUXIMYU/KtpZt+jdfjm9WTc0/KQO?=
 =?us-ascii?Q?35JF/L9aa0R9WB6n8DIdC0pf9LbTxatcaKqMxoMUH1ylagZVRtg/KNvUSZfQ?=
 =?us-ascii?Q?72bpVTUsW+o6jB9btUjfG1FdwUPCKCIYpctH532WdK+k93lXLPFTSOC1YQCF?=
 =?us-ascii?Q?NJfYb7BlMK5SHY7a7k3vcBJIeq1oQ0/hHAzFIs7R76a048xBmFdsNtBxUNcA?=
 =?us-ascii?Q?LSgAZe2y2tA6REeQ+hjp8ltv/NYm8zvb8/IPVl0tdEQRF5N4agYXu0d+zIaf?=
 =?us-ascii?Q?bqOnBL5+qpqclaoCPU9wt7/rnlrPQq0d9KlaCTmqN4UAkdqmLltGwzoz8Ru6?=
 =?us-ascii?Q?ijBI2xNOKYxhYiKltPkMqe8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67135fb7-b22d-493f-ecd8-08dd272cf275
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:55.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEJkPRUelRgoW1+5g33b46ZcTh/kiumKthfiwysyrmq82eHJUl9hf1rMxz+pifiorfHqiSBxDpE7EnJ+lz4WnDvvNZg047kV0bP1do3wsBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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


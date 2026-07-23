Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B43DC531CD
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8C7340806;
	Thu, 23 Jul 2026 09:38:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJGp0WBWTCGY; Thu, 23 Jul 2026 09:38:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08B8C4080D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799534;
	bh=ATD2BYEeMU7dh//9gY3JukfZwAx9xXLweiULlIsaNxE=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DizUM1K2g+qjaEccjIGYOQ57PcSzFkE7MT89Zyl+LVRzY2QR2z2g7KPiW+FpQa3Mv
	 fC4riTjlAkqw26Q4FgWk9e0aVpr5piKU8klS+hp30pfDp+SBxdJrWAWFr1yNUR68fv
	 vYb8diGfjqopqyb+6ShMAXXmZ/wCpZB4Kluj5HM/CWIkjL3et7AwnsEYzixeEyM+Ya
	 0p3mpN9YAU8l5/loVncvQPsbdd7Z+r1oBdI/VImdn33CoY+7EPdBoOKxZE83KjH6pO
	 H2rLfP3BSNJmX5FfekRcQEGgUBx0t7hCzc9nHOP6Lbk9mAlPBZV4qCCUYuFZRTeFzC
	 dmWaL0VRBgxTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08B8C4080D;
	Thu, 23 Jul 2026 09:38:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEF2B347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFACD40363
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfr-JW9b9vrv for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 344164025C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 344164025C
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 344164025C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6Kixu/auM/CbaDHWEjjIoD1zrYNNgRQ6+J7RHGG/mqnS3YFvVHgSXRxu61kL0M1pWVtsDNVD9dL3K5dKC9bHv6pMtySniFn6RjijvlG65iZ3pnNlkepgiU4yJYlCjeYagDGrgXdU5Fr1dioFlQcqDl6LC+VYhWny/lYG4xsruwiYd7aYYaaKbRG8H7iyyEOYncEaCeSxDU575BnsqbOQunUQRg/17lU/a/g8ESTiaJ8YQ18NRqKvFbaDXYmzwt5CaaXLXeSR1IrCKnnZsXtsQO4BoKbQePPjgdfOK8szN7o0+GUwuJIr/8fJDfNymxFgiJXDnvqtUmlqlJ6tbaCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATD2BYEeMU7dh//9gY3JukfZwAx9xXLweiULlIsaNxE=;
 b=HSKkLKXtI6vquavT2uIaFpGGZF8TQzQbWswKJ/HjcQ4TpzbYqz+O6fUenQUh5pV1xDCgfXM+QjP25T6GecSvoEcYpOu6+8b25gRo7StaUGAAjvvkzOzexgHqWEtV5LG7Mca6D8rOekVD5STBNzZxqHxYOL1VcJjGebmFBtEo4B2bIf2OHvyBzc7VgqdAjnTOLNvv/foHd9HNQMyHDa23ee9hzRU45gdtjwpfimC5ZvFdtb/TcUZkgm47J9TjPnA4PgsiaLiqSN4wElZno4YDUwGiGTviFtiKKUftk+MtcQTGF0Sh34id0JmPYpHrUqc6ORQ7W50dTSKk6nwho+XcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:38 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:38 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 2/7] binman: x509_cert: allow and parse distinguished-name
 subnode
Date: Thu, 23 Jul 2026 11:38:24 +0200
Message-ID: <20260723093830.3132465-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c238d13-2736-4533-4f0c-08dee89e2bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: nPvNnbEzPN2WKRgBzncmWqOqCTukSVB3PGxpbuFNu67NvTQvEH0mFIvXFnRVcPLNoeT6ntwVfHMmIR3oYOHSEPkX5yjoihqdeHEvJPf3vTgmQYuIDOlhOdTHrLbafyTi7om8tmczVNo0Y546c37V9UaORRXPqFZ2T7+O97wHny5gp7aDsCHMqqf1voMVEtwckSAfC92BxKLzDKg2e6bX2vgsoN1Nxzv8tv/AywNtSLxhblLHuqf54WqkKTBiD4G6fOudZkLY5mjE6JpI9Y4hs02ctY/QDpG76Tqrlxy88bObEuvJe+TetDeWmb/1XcZEJQddmN9pI74fUipayAosyuNc97tNU6fHGgvGzdmu/bBYE0JgmFuYIrnZ+7JxsIZ/ODaJKCzQbkOleBFz3Qu70XmDaO9RPwG8VVo3ZJmZ7LrE9hnaAHHmhuA3l+N6BJRR7DwHmWq8kDxLjidGIvRnhknbJ/xgfs4xIpeOnEgIFkZH0l4sjPHXMhQpZLIaZJxmdsMtDg0svgMKa4VwWIBYSUjLBSK7ULSP0uto6PRnapghzygyLE35SYrCA1Nq0zMLeWcHSU1nnWIRgFbiRCGunjlpmKfoZAStS3ksDKI0Bsis9icUH78GYQQDr2BX6b+MVZxQH3XfhUk7liRQq84Dt2ll8EHTz+Gbimdmh+kivqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wtbbok8zYpillU7ixbXy+LIazaa4AHi0SlRcuFpy9LJvHkjvdbPJKHrxjhza?=
 =?us-ascii?Q?n03emg/H5k5211WRdGTHWlHW0OX6w/R9nWIJkRvNI78ZEWoeZ8rjeg7VtVwH?=
 =?us-ascii?Q?m/KVXc6QSqoXyAsDhUBzv3sO/Qe9czzVk3HzgYNg8qRrtkWSLkPeQnf6PY2B?=
 =?us-ascii?Q?3JLfkErJ1wo6LxmDwtAIyDHR0ktxLNVy0g5nIFEKbMugAeox3nrWGpiuia7N?=
 =?us-ascii?Q?uBURBhBwy/zUc9N2JKV0ffRyN5IpnoxzAU7me0PjFyV8IWle/ebsxOs6RffG?=
 =?us-ascii?Q?T/b57bvB581E0CxnECxWYOMMMmz9KHF7WLmYx8XeZ1jJfltw4za/1+5DMQ8r?=
 =?us-ascii?Q?Jss0ElmOdDjRcicoGBeR2mskeTg5XV2CHBu6GPo0mY1Ka114KCvUytgz7MrB?=
 =?us-ascii?Q?/+9u/LuPt9D1i1ONB3dLPnAyihLhFAF5ezipxIAtyBEWScKilVXrL1E1NRFb?=
 =?us-ascii?Q?s7C3E0RU7JtiucxeQlzh1DoGfo+3i5Uc16r4htFTOqM8MA5l9/JNAKeeTQUb?=
 =?us-ascii?Q?iNJw9uTxNpiaOmYHIjxo38tSTIU01775IVEkJzE3gvOWKPIHKkGsMbezWuDz?=
 =?us-ascii?Q?h0ZeNMXSU9es5+6onFcacKjIylBeNBWq0OsZoJap/zFVcr9r+JBXNhv5Icuu?=
 =?us-ascii?Q?Kr43mgcuKOtnKJfwmwyU2kqhID6g8o/42oikH6zJhQleuowkhbJbX+jlAsfv?=
 =?us-ascii?Q?k1AalXQOHL0mhSwGL5uCeyc3YI41U0bavFIAPnVwijKPpT6Yp3SxpPwvRXtZ?=
 =?us-ascii?Q?Dva+sDiB8IJmViFqz5WYwqQvUKyD+PEt2PCL8ywzgwnpQMoViQtIS7d4XElU?=
 =?us-ascii?Q?lZrfUdB+4NvTEDziQ64n9Pb38dOUp8JZzl0N4mo9cle/N9ncSWdmNONdgxDb?=
 =?us-ascii?Q?MTrJ8u4dutGbGvyM5wu+sjjtyePPKivWYI4jOWcKgvXIJ1/kQqPpJJMdL58e?=
 =?us-ascii?Q?5HFGQxHP9xdkNDh+ok6Mr94yePRBrfP0tFxpowotQR2hZcukCke6AezxYPXz?=
 =?us-ascii?Q?QrkB4g4NqNb23a7mB+Dr24gofAohdYuj3rTwUBb3HOCpSBpENbCLPkRwh7Tk?=
 =?us-ascii?Q?iz6nISLQVr97WbNS8FbuM/c884MtWWQQXc5FuFWilNoZhLX83kgSNHtZ141g?=
 =?us-ascii?Q?2KE9/P8iIMgG1wcIF5il1W4HZb74YcpjCousQOKF30EmcsPwdb8vHIJBAYws?=
 =?us-ascii?Q?QF7hYj1xIrf+1xWh7U1urTSLmjuK/gC79iZ/1l0Sx+4T1KNMmmHWyDr8HJN2?=
 =?us-ascii?Q?vq42PSIaadNywl9yeBJglU25LTqXi3zZ2jR89LS2rfGmvOpPVhnZWi5z7Qoq?=
 =?us-ascii?Q?c/3Ww7XXmtPVi9L8JF1cKS+fALZMlR3cHgCzFgFEmPEqobN2sio3J4X6kE4v?=
 =?us-ascii?Q?yT7MMoXerIuTJsWR5xGUAlwzsgHus7pFdsV5EvBdCchnN4zVBAKCW9LKcawy?=
 =?us-ascii?Q?SbvmvRbLm7sez49ZtZe0Q+44cLhOfxYd13Uf/aYv9DQJBxnbKJgRDPV/IqEc?=
 =?us-ascii?Q?cjPHBBAq9cGaA2iRaiMqGNmuj0xsQwBIImxUWYo5PZ2VK+F7s9vDV28q8MD3?=
 =?us-ascii?Q?92UoiyYSQGJKT0AXxAec5l/LoFS0z0W93zDbI9EoYkVKfsm5XE+OpN7GSiQl?=
 =?us-ascii?Q?N54H6OY2R1SLYgdb+L2VHiTLmUWOJ8IE5F+ywX2yhhHo0+dqMyiQ4Vv5/nf9?=
 =?us-ascii?Q?QAQfId8gIL9F1KocvRS6gdB4sWJJqOMkgZKQovz4FwJ6ZtmrwdZmRtmm+ofs?=
 =?us-ascii?Q?w+GKk8Hs9ak7HbMheGfttyqCJzEW0s8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c238d13-2736-4533-4f0c-08dee89e2bee
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:37.4576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+xD8z1n7fl3cIqLLSSCXCNPMzraavM5zqnEc3cukCIqumsLa8OvyKxBxZmPdJ/CquoKU8/ZWObx7uqCiB9zqCtwClD/I7skifKdQnua1pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATD2BYEeMU7dh//9gY3JukfZwAx9xXLweiULlIsaNxE=;
 b=aFwnast4UBCVIBiLFn+RCxJSV1iIEhMLVzHcJAgOXLWr9/SKZiGqSK5CzV7lGwiR1sLRSh2kJ7choE+appxSvU4rekgWYCp0AkgARR9xqJ/1Aarmoui8zOHktHvtvg/qs/jSVCraoNDHjmIjFvYwJWNmjFNIb6bKN6zINa/VOTY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=aFwnast4
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Currently, the ti-secure and ti-secure-rom types hardcode the contents
of the Distinguished Name section. Those values are not necessarily
appropriate for all boards that just happen to include a SOC produced
by TI.

Allow placing a distinguished-name subnode inside the binman node
representing the Entry_x509_cert (or derived classes), and if present,
use that information.

Ensure an Entry_x509_cert instance always has some non-empty
req_dist_name dict by adding a dummy default (because for the
certificate generation there must be a non-empty req_dist_name
section), and let derived classes provide their own default.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/binman/etype/ti_secure.py     | 16 +++++++++-------
 tools/binman/etype/ti_secure_rom.py | 16 +++++++++-------
 tools/binman/etype/x509_cert.py     | 20 +++++++++++++++++++-
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d9..b4e120917b1 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -58,6 +58,7 @@ class Entry_ti_secure(Entry_x509_cert):
             - Lower Byte - Remains 0x02 as per our use case
               ( 0x02: Move the authenticated binary back to the header )
             - Upper Byte - The Host ID of the core owning the firewall
+        - distinguished-name: See :ref:`etype_x509_cert`
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -99,6 +100,14 @@ class Entry_ti_secure(Entry_x509_cert):
     writes the signature in this entry. This allows verification that the
     data is genuine.
     """
+    default_dist_name = {'C': 'US',
+                         'ST': 'TX',
+                         'L': 'Dallas',
+                         'O': 'Texas Instruments Incorporated',
+                         'OU': 'Processors',
+                         'CN': 'TI Support',
+                         'emailAddress': 'support@ti.com'}
+
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.openssl = None
@@ -117,13 +126,6 @@ class Entry_ti_secure(Entry_x509_cert):
             self.firewall_cert_data['auth_in_place'] = auth_in_place
             self.ReadFirewallNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
-        self.req_dist_name = {'C': 'US',
-                'ST': 'TX',
-                'L': 'Dallas',
-                'O': 'Texas Instruments Incorporated',
-                'OU': 'Processors',
-                'CN': 'TI Support',
-                'emailAddress': 'support@ti.com'}
         self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
     def ReadFirewallNode(self):
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c655940..6c4e767c741 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -33,6 +33,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         - content: phandle of SPL in case of legacy bootflow or phandles of component binaries
           in case of combined bootflow
         - core-opts (optional): lockstep (0) or split (2) mode set to 0 by default
+        - distinguished-name: See :ref:`etype_x509_cert`
 
     The following properties are only for generating a combined bootflow binary:
         - sysfw-inner-cert: boolean if binary contains sysfw inner certificate
@@ -58,6 +59,14 @@ class Entry_ti_secure_rom(Entry_x509_cert):
     writes the signature in this entry. This allows verification that the
     data is genuine.
     """
+    default_dist_name = {'C': 'US',
+                         'ST': 'TX',
+                         'L': 'Dallas',
+                         'O': 'Texas Instruments Incorporated',
+                         'OU': 'Processors',
+                         'CN': 'TI Support',
+                         'emailAddress': 'support@ti.com'}
+
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.openssl = None
@@ -80,13 +89,6 @@ class Entry_ti_secure_rom(Entry_x509_cert):
             self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
             if self.dm_data:
                 self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
-        self.req_dist_name = {'C': 'US',
-                    'ST': 'TX',
-                    'L': 'Dallas',
-                    'O': 'Texas Instruments Incorporated',
-                    'OU': 'Processors',
-                    'CN': 'TI Support',
-                    'emailAddress': 'support@ti.com'}
         self.debug = fdt_util.GetBool(self._node, 'debug', False)
 
     def NonCombinedGetCertificate(self, required):
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb0..2d017b81456 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -19,6 +19,11 @@ class Entry_x509_cert(Entry_collection):
 
     Properties / Entry arguments:
         - content: List of phandles to entries to sign
+        - distinguished-name: Optional subnode containing key-value
+          pairs used for the Distinguished Name in the generated
+          certificate. Property names must be valid fields (e.g. 'CN',
+          'L', 'OU'), and their values must either be strings or
+          string lists.
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -28,10 +33,13 @@ class Entry_x509_cert(Entry_collection):
     openssl signs the provided data, writing the signature in this entry. This
     allows verification that the data is genuine
     """
+
+    default_dist_name = {'CN': 'Firmware Signature'}
+
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.openssl = None
-        self.req_dist_name =  None
+        self.req_dist_name = self.default_dist_name
         self.cert_type = None
         self.bootcore = None
         self.bootcore_opts = None
@@ -61,6 +69,16 @@ class Entry_x509_cert(Entry_collection):
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
         self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
+        dist_name_node = self._node.FindNode('distinguished-name')
+        if dist_name_node:
+            self.req_dist_name = dict()
+            for pname, prop in dist_name_node.props.items():
+                val = prop.value
+                if not (isinstance(val, str) or
+                        (isinstance(val, list) and all(isinstance(x, str) for x in val))):
+                    self.Raise(f"Invalid value for property {pname} in distinguished-name node, "
+                               "must be string or string list")
+                self.req_dist_name[pname] = val
 
     def GetCertificate(self, required, type='generic'):
         """Get the contents of this entry
-- 
2.55.0


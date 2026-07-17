Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9086C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E0D84E60;
	Fri, 17 Jul 2026 15:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kNExsFB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D0384E61; Fri, 17 Jul 2026 15:58:43 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DE984D6D
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppPFd8b4eRSCLBnW4m1LTY9ao+lra9JGfGPxWnclE2bW71PUu5zMuKNTOazPtxZGaoy7k5nT+vuGCngJLdTo39PO3mgvfSDCPCL/iFbvDZpsZMZRBCY93caO6QH6QqIzgI/WurnzaNw+YmlrtEQMJnwE5Y/G0PhY82kAB6mQraIV9DOTQnEnCCa1DsRjgFyuehlhPTwkyTu8M8qorBp2TAcZGZH7SFCbFBR+gVlCz0B2r08+0+eIUEo2cpoRTLqmjmBSmYSZabQA0JSB6CmpKqw1+54tZSsTWIhXJiaJSGYkb7EcGWaZrwo+WZ2XmVPa3GL3lCS1vLJh6npbbRVGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZD/x56+WByucamy8ZfPBblfY1zWxZTumUfum6ju4NI=;
 b=ScBZoREmp/1vfSORulUQFg1JwjwNJVBJWu0U1iAIzwISzlf3FHItn8yq9Zy7qdvxWVWOKhSCRufLtDqK+TKP9wcDhaov9bQDZrBfGbXLTJuWMewi3d2jGedl20AQhBp3edAKvQhVRNpc0fVenc1+X8MLzCnTQfg9n0a+ziGpd+64Uz5z23nr4wPy8nUUTIlw//GS57vuHXUuCjy3KmW3KHqSD/2qpQtsXbkRmnrqv6nz94/fMPeJQ1alA4mIsDXyUfFNjipCHTW0M41BWJ4RUcLvpstDBdgMVzjk8MhDDGbhjn5d7c6kghPXfbJbFOSb4vSUuE02lS65NWHfd4vy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZD/x56+WByucamy8ZfPBblfY1zWxZTumUfum6ju4NI=;
 b=kNExsFB4tns6k/rFk07/B6CRWsjfHUs0Yc4lQQeIoyLGHaihOevYm+51z1iIFB8kozBVtHtQMO1e8JEx6nif9KtJMIXwT/gwDbww1xOGmqmWL03mvXovRwc063Vg+LLd5/bDHXrm3R7KtaPTLekfe0pbl2aa7ELpY4A6eTfo83Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:40 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:40 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/7] binman: x509_cert: allow and parse distinguished-name
 subnode
Date: Fri, 17 Jul 2026 15:58:19 +0200
Message-ID: <20260717135824.2142135-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F690.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::139) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c56fe0-4bad-448b-91cf-08dee40b8179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: LLDkxB51oAShu5KOgOrfYDR0v3tk0PbOdWJXcyuIw4AAPa1Q6oac+w7xw3pw1u02gmqwayL1Ogc3lp7ZvpAfZpFBX9qWyIeyawqbfSFQx/FgVGqPJVhVYvUd8V45x0vGTNyHMkEJ3OK+EoCVg7z8DlP756MqYsx7TSpyQNhJkv8QBVz0QI0rOUXGgSF5u9Z1+nspBogP6q+BwNZ/PEqq0/nu8GMrJ+tCqrPTpvWDSzLpli+YOC3D0hgcW8H8gnvcaFIrVd2HetPMjVYHL95C9GN3Ue+TSebOW425hyXhfXf0y7nGgSZEJQj7994/YT5lGg1Y0BP3WlpNCAazlXI5qnK7hB00fsmJgWqRdNaEjaosjw9QfO2bDizZu2Y23KviRDgV7whrqn/tUbS0wQaHRmZ1w1UiVqTOS+5Dpitm58OtG+4T96vcZa5tFOse9xPHg+Mpo2g6fRABxSTOa4vjBTgopwfiUjsGinSyiP6GjE3Q1lL2zdg77FWU/zt9Dv7N/0RS6tk88+lH6juxLkBK5qLY5wgpz0y8mUAmCTSgu3OOZF3A3GT/NtD6Lslva4ksENiEbxwJqIkO7d+kDO5CrX2j6zS0PuSL8Wp/5dR5tB6qRJ5i/sGYQSxDyNSNbB0z9OR2zsqAfx0zxqqXslMaO2Nzv1VWBjlqN+ZPbnTM1k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TgGhwPINYTvMCS4HqAM1FjDsC47tr6PiLankrFjJ04iR+DlZ/1FwyQvyIWnk?=
 =?us-ascii?Q?8tS5pkOb3xs4ME+bolhTo1bYOhorrLyyoZIBXS/6vR0KryrIhed1XO7KWQNn?=
 =?us-ascii?Q?LvG9ZMgBGRZjKGPanAmJxxPIJbe3tqRpE4d4IEUOojadmxVZB8pH4EJeEN3N?=
 =?us-ascii?Q?/uxd3n5B0+8gkO142B04vhSVCd6/4HTQvcMtWYFyYPyi9VOmh3Mh1XGeOCt+?=
 =?us-ascii?Q?KV7lh9GV+uBImzBVimQYcwckxYuLLTIFhduwBJ3CzSdYiN1U5kwMXQTbvgDy?=
 =?us-ascii?Q?mPpYvTnsOpO5tlEIR23c2ITE/EsQ9rrK6C+2lNl/SExo/7Tv24xxXlO7zBFv?=
 =?us-ascii?Q?bN0dtcZKWtYfKkVLRZgQfpdry5gpsHcl3VHLnZewA/OfvbBUDOc2AOalBnw1?=
 =?us-ascii?Q?iJbqieXQPaN1WAXIoIpaVQ6FVUkb7xV3J0dqZD42iJmmsiMyVNdSo8mI1XEh?=
 =?us-ascii?Q?uX2Ln6RIgQT6OCfXaQsvp0/HoiNyd4kbS5AWTVpTXkeOR/3kzGr5OiY7FTUY?=
 =?us-ascii?Q?BbI41yLLYyRZj3VZ78guXUx/ymiOdMeP/TkHzZ1VBrJF6DU1wnxB6EgizU2E?=
 =?us-ascii?Q?3ujoPexhOY+vWh4iMLyoKfSRWcb62n8HFDal+QD+scBLfYkGRVuUaHCcGF2F?=
 =?us-ascii?Q?I6P7Mz9/SQzShsi5fDNbbDJxcKQfIeTpIPB/Dm8/Jb+gPZ0ZuR5v6R91RCDr?=
 =?us-ascii?Q?uqVY69FzgOLcYNWpge5tnpgW6GVezAbtHKsjiKFCxbigwEq1YzpHz+augs7l?=
 =?us-ascii?Q?aA3kQCwk1zviKmEeOulCWbEsmtp3p1eS/7jcNfYkj1Kf2FtXDHXLGVK66D1u?=
 =?us-ascii?Q?ZFrwQYT/uuA4UKhTyceB2S/j1IES09OY6cka2jtJL1pVeIq3+AU5gKcQ5NXB?=
 =?us-ascii?Q?KhnlyxhUPBacBKetri2paR79UVr5qZNxKwT+EduNXMUe8Wmm7Q1c/C9uh/Lx?=
 =?us-ascii?Q?VhsU86ja4fAQx3m1/0gO0eZlJ4M0sXPSSsslb5A//9U23ct9mg4siWggNyNr?=
 =?us-ascii?Q?qmkRhsaeo3FVYx1TCbh4Anu784pTPNsOm6BaOr4JxCedsAAehnIvpaLVbycK?=
 =?us-ascii?Q?MB6rlzLHWP8A0vnw6IT8mOvL6mxvQtnr/iwxbu1a55ivGTrRagS7OMs596yo?=
 =?us-ascii?Q?C484K4WPlvBGAsLoyVBt+rwRfFRHeg/xfpSVxJdp8x7hRGQHvEr0DpvEQG2G?=
 =?us-ascii?Q?qvGDkR3tUi6J+xSUF3uy+8jczkDxQFy9VTYmsPfvz3jvWAiDJ+9vO8LCp66B?=
 =?us-ascii?Q?4/30qEnBAxJ9/rkArLU7+VgEOGuACpP6zvHOqsdkqRZCTkQq0HnU3sLL8Gqt?=
 =?us-ascii?Q?2ZYFikBA4DjXJV7gLi1sdlgZrtAS17qzD8V2uqweX4GClGgMio5NJ/ObLFuE?=
 =?us-ascii?Q?RhE2LLaack1SfbE/5AJkA/rcwUCEuuTccvRrUt/82VicnCz4c6K54hXdwuAA?=
 =?us-ascii?Q?bfK2xDVZt0juedB8jWPR+x2dV5NHR2Ugo3asEu3GH8L435X5+Znje2/jmPfp?=
 =?us-ascii?Q?ocJ5T0Y3QSNrGhy0Om7aHd4nkgGLAUu+mtDIGs1aro4lltjolFmjyqcm1Z3I?=
 =?us-ascii?Q?mdNvWttOq1BnlIga1+fyqjEGa20yDuchrcIhzjRR1Sv0sFxhiy4W1XOvTk0F?=
 =?us-ascii?Q?66YH+LUCYB++ti15iWzO6CS3Uzvp6UCpNrNehURlQTAaadrzqqIAGfu96l4n?=
 =?us-ascii?Q?ufnUTRS9NC+HS0AHH0NANeuKj36gEarkPsGmT84MUxma3Rol6FTzgaVHgzmP?=
 =?us-ascii?Q?OLYEjTYCSLYguwCpX+BJCJXLRt8P8xA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c56fe0-4bad-448b-91cf-08dee40b8179
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:40.2352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3xJvI4X3jCYWHDc/2jv1AKK/qA62A0N+DHyiwR3ClbBVA7qmQcei+KExFLwBB074R4EGT3HGAeAOjICdbt5WODnzKuBS/T9zv0qVqt2z3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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


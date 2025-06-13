Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459F8C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7186982CB6;
	Fri, 13 Jun 2025 14:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RUSX4O6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F6982CA8; Fri, 13 Jun 2025 14:03:24 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE65D807B1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFi1YinqMNo2QhHGi/5l8uncCJ/5m9zqheu4HWM9dLkR9By1/2WDHEjBPCs7Du84nrXv1NQoCNjeiiUUzjUifI+Jgj+Myjr3l/62Pm4TE03CthW3ar1qMizLDi6+d/OOzd1yZSVzEE8c2dLzo199Ld+nt0lyU4raJ64C9uZPZrDyBRF3L84ofsKpl/WnrPPBsGMGH83hFhWKhmI9XPtQZOMF/MAkMMzpUu1YR81XGtpHwHHAqfReg48xp8h11eHg4t9AC0pWJF2WwYnFxdOlJrAS3rpYQxYN8+yoVFS+57d0S9+tem8krLUO/PiB5hB5wjorybm173/qEqA28XMASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSGfZ+znGwXEPBpw1nAonwoY4rxaK8WoQaP/HOjcULY=;
 b=s1581r4TlaR7vSLHET3GRgq2qcDu8eSHupBsHTCdNbSYxseIZbEqr2sacU90fpRMuUSRl4etnh7BrL6FpFBNLsxWWr4dj9irNu80F2xyg6Rqn7QkzQnvYdedqBMoSBaE4yxEXRM9ifRuC8GtH0Iw/5656tBoar6kngzACiTYeRZLGOr2xmR8x4GljHN8pvbFZpSN+8VHYYo1mQ5mdWVsXNL7MNrsMnDTmjcDAJFAcRvYxSd2Ej+kxNjIEOEuZu1s+5qJ/xffr/TxPj0nsyDiJNl4c9/OzefcXxhSyGMxXK/l9CbNfQ0uHR+p1wwQ/1x2oz3fuFEwxDF4TUGtnnlkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSGfZ+znGwXEPBpw1nAonwoY4rxaK8WoQaP/HOjcULY=;
 b=RUSX4O6IM01YcwZkZDX1fJrExzJKl39jnvTD4wARkaUsTTqZ5SXJO44/T/wmopUKDWNq3flTMPhHY3kVncXYqMQyycag2PQhko6tldc5Mf4Is02guTMCSJHWTZkb/ETTR3T5I5UASVHMVkjs5Lc0fcjOBQyE77vjL8JwF4D6/23Z/HkhmbY/3oBicH4+gGq/mVuWmKS8nf8jMSCgqXB2OXoAYzmqffcwZKHppzctt0vsCdhFPdWeCbzT5avgfrGyoi9+tbOpICNzA6M5YPTuxH+DDR3YoILR0+mZ3NCL8wx4GQD9RXk+k7KAUGVUa+NYUKqTa1BuFQM6oie3gLYaqA==
Received: from AM0PR06CA0141.eurprd06.prod.outlook.com (2603:10a6:208:ab::46)
 by AS4P195MB2036.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:505::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 12:03:18 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::78) by AM0PR06CA0141.outlook.office365.com
 (2603:10a6:208:ab::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 12:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 12:03:18 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:16 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 13 Jun 2025 14:02:41 +0200
Subject: [PATCH v3 2/6] binman: mark optional missing blobs as absent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250613-binman_faked_optional-v3-2-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=4003;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=JMLpptseNFpN60BiprAtFW4Laekd9VXTUv0p6I78g58=;
 b=sLlZ5MF9KCuCwJ9kRlwq3r6fFXJqD39AFVR2de20uKZWTQdnGRFxnu3o1UHRQy8MD6CveNr3X
 K1Ew2GUT7ClD/DzJ+xNCaf6S7Cw1kMgIfOpO+dskTiJj6+wQuZSB69b
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|AS4P195MB2036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f91010e-05fe-4c5c-b8bd-08ddaa724924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjBGaGtXdFZmS3hpTUI4TE1iZStHRWh1TVZicU45dWpLQlRQcTJOcVhVOVY4?=
 =?utf-8?B?aDFmTjdRTjRrQUhxN3BCZ1dQN0hQSXFRc2xGdWZoWk40Ly9DK3dvM2xYUFdK?=
 =?utf-8?B?QW5hRnd3dFRrT0VYVTRhSWFrRDlWUm9PL29tY0pxRG5tYzR5aG5aRnlMNFNZ?=
 =?utf-8?B?aEthZWYwQ2JCYzBnR2FmTHE1R3FEdDJUTVlkUDlTTVYxbVg4RnUzY2NDQmph?=
 =?utf-8?B?U0tpd1pneTJOaWZqWGYzUjJRWnBCT2Mra0hlL0EwVC9Nd0FtVDNpZyt3R0d5?=
 =?utf-8?B?Rzd1NDRNVnZmVVFGRkVCVHBiMm0yUHRHM1c4WjdIY3NtZk5IRTZLWFJYc3l0?=
 =?utf-8?B?UFE5VURzYkhsU0o4b0Z2cy9kZndNL2oweXE3Q0lLMUpYUkJzNjhGQjhhZTdS?=
 =?utf-8?B?OVFndlBDd2pGZHF3NFUxU0IrTHV2OXNhNjdJSlU3MDNrZ3B6R2dwa2ZFQ2xs?=
 =?utf-8?B?d3BhSnRBV2RFNENFTitSS2x1ZSszQWR3bWMyUmRjczdGOXJRMnV3dmZZaW1o?=
 =?utf-8?B?RUNJZjFvS1hSdFBFYkVhNjkzSGdLdENFV25aZy9QMlZzUXNEUXB0d1lJQlV2?=
 =?utf-8?B?dWRDVGZYVS9YR2RvcFRyMjNVSVFJT21TM2FvTmV1T0xMMGtjaVFNQVQ5QWp6?=
 =?utf-8?B?RFpXMUNlazBaYjFqNGwxN05NNTFBR3pYN2pOV0hjYUlxZVZFakJlSUlwemJK?=
 =?utf-8?B?T0xINHpUZzF5OEg0RHpzdE1Ca0lmRGEwT05wMldNeTkvS2l3RDUrQXRlVjRx?=
 =?utf-8?B?Q0piQjNWT2dYRmRnTGdTY3NMSXg3WXVNeVh1Y3RxVU00bVM0RkJIcTc2d1B1?=
 =?utf-8?B?clJ3SHdoY3FXSjhBTHZCWU1IbUhiS1loUGpNQ0N4dFo2aldjVDU0NUdsL1VB?=
 =?utf-8?B?emxDbW9OVzlEa0xIWlRsdEw2MFpMeGVKWm5zTGV1RHFPSldwanJwRTBQRUlp?=
 =?utf-8?B?Z2gySXBNdDdxNDh4VGRESGt0bHJ5Nm8rT1cySE5kM3MwdDhid0hiSVlwOWIr?=
 =?utf-8?B?NE1FdzNRaWxaUlZCNWhVbDhMWmhlVjlodlU4UHdnUTZOSVBEMjJEelFOYWl6?=
 =?utf-8?B?SkhRUWp4QVE1MVdBQ0pmRTF1d21SL3dqVDhteUc2WXRualc1aUdrckZXNTNN?=
 =?utf-8?B?TzdkNFJjc0NDSndKNzFJYjhhSmJCQVo2WDZ6am5aMWp3WG45a3RrSEc3Qytl?=
 =?utf-8?B?aS9sank2cGs3RTdZb29CV21GK1dSdTdkdE9ZVmFmeG4yQ1FnSXM5MGxvbklu?=
 =?utf-8?B?U2FZWjZPY1dHMGczL1o0WVNnT3lNSzl1WXBaKy9vcjFySVNOQ0dBOW1NVk9I?=
 =?utf-8?B?SXBSU2lUaGZ3QzhQT1lBVk9QK2xVTWRGeHpPR3piVWZKSGlmTGNsSFdHQTE3?=
 =?utf-8?B?ODQ3RVFSSzJnYTVjWlcwd0puWW1QeXgzUkorSUNoYmZVQWxCMExoaTQzQUc0?=
 =?utf-8?B?UC9oQ0RualRYQWRQakxFM1lsQ2tPOXdFTGlwT1ovaW9vVlozbDZDUmc1eVBv?=
 =?utf-8?B?eTZZWnI5b1c3TVo5eDB4Y0ljRFAvdldtY3pnYnBBWi8yZm1VWEk3eGJYNkd3?=
 =?utf-8?B?ZjhhSDQvMWhFSVl1RENLQWJYUnZ6dEJlYXdLTnhrQ1Nlb0J6WU0zQkozUG55?=
 =?utf-8?B?WFc5QXJCcFVQUTNRN21FamNIVllaSys4TlhIdUJsWWNCbmt0Rk45ZC9Galdl?=
 =?utf-8?B?b0JWTUF3OGR5UzRpa3lXNUs2VGUxaFh3RzFYaXBPNFo1Z2xhUnRsS2tYN3dx?=
 =?utf-8?B?dXVhUWdTaEhGaEJEYnhoZDFwVlN0b0xVY1lxc0xYS0MrMFRZQXdpbHlhMVJ3?=
 =?utf-8?B?Y2x6cm9XS0FYR3QvK2xOVlFaRWgyZE1iN3crU1lwbmk5Wk9KeCtQd0VzazVa?=
 =?utf-8?B?UmZjNXhacWNCY0VlMHB1VFZ1bkhiMElhZTBMaElGZXBYamJVMXNnYlI3Q0dX?=
 =?utf-8?B?L0Z5b2ZNTDJtcFlYZ2s5OWdYK3dscTlGNWxYbEk4UGhURWhUZnp1d2paQVEv?=
 =?utf-8?B?V0VNZWwrQ0pDckRnRjJpQW5qS3RaVFhxa2FTeTRWRmM3dlp1dWQzNmlzK3Nh?=
 =?utf-8?Q?lTrFBX?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:18.6172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f91010e-05fe-4c5c-b8bd-08ddaa724924
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB2036
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

Optional blobs should mark themselves as absent to avoid being packed
into an image.
Extend the documentation of this behaviour. Although the documentation
implied this before, the "optional" property had not been explained
properly before.
The behaviour will change as now absent entries are no longer
packed into an image. The image map will also reflect this.
As a result, the CheckForProblems() function will no longer alert on
optional (blob) entries. This is because the missing optional images
were removed before CheckForProblems is called.
Adjust the testExtblobOptional test case to highlight that we are
testing not only an optional image but the image is missing as well. The
behaviour for these is different where the latter will not be packaged
into the image.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/binman.rst    | 7 +++++++
 tools/binman/etype/blob.py | 2 ++
 tools/binman/ftest.py      | 8 +++-----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 84b1331df5c006f72167016b7f33de73f4a269fa..392e507d449c75eeba4431fe2db01d820bce8f61 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1143,6 +1143,13 @@ Optional entries
 
 Some entries need to exist only if certain conditions are met. For example, an
 entry may want to appear in the image only if a file has a particular format.
+Also, the ``optional`` property may be used to mark entries as optional::
+
+    tee-os {
+        filename = "tee.bin";
+        optional;
+    };
+
 Obviously the entry must exist in the image description for it to be processed
 at all, so a way needs to be found to have the entry remove itself.
 
diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
index 970fae91cd9b2a31b3f31d2ecdb77e27a89d69fb..acd9ae34074e4b4b9792b107cc80514dfdd88b3b 100644
--- a/tools/binman/etype/blob.py
+++ b/tools/binman/etype/blob.py
@@ -52,6 +52,8 @@ class Entry_blob(Entry):
                 fake_size = self.assume_size
             self._pathname = self.check_fake_fname(self._filename, fake_size)
             self.missing = True
+            if self.optional:
+                self.mark_absent("missing but optional")
             if not self.faked:
                 content_size = 0
                 if self.assume_size: # Ensure we get test coverage on next line
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 4cf7dfc82165b37752d048e5fa76da6860d2003d..4a8d330c8f89adc3c248199760a936dd243158a2 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -84,6 +84,7 @@ FILES_DATA            = (b"sorry I'm late\nOh, don't bother apologising, I'm " +
                          b"sorry you're alive\n")
 COMPRESS_DATA         = b'compress xxxxxxxxxxxxxxxxxxxxxx data'
 COMPRESS_DATA_BIG     = COMPRESS_DATA * 2
+MISSING_DATA          = b'missing'
 REFCODE_DATA          = b'refcode'
 FSP_M_DATA            = b'fsp_m'
 FSP_S_DATA            = b'fsp_s'
@@ -6537,15 +6538,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             "Node '/binman/fit/images/@tee-SEQ/tee-os': Invalid OP-TEE file: size mismatch (expected 0x4, have 0xe)",
             str(exc.exception))
 
-    def testExtblobOptional(self):
+    def testExtblobMissingOptional(self):
         """Test an image with an external blob that is optional"""
         with terminal.capture() as (stdout, stderr):
             data = self._DoReadFile('266_blob_ext_opt.dts')
         self.assertEqual(REFCODE_DATA, data)
-        err = stderr.getvalue()
-        self.assertRegex(
-            err,
-            "Image '.*' is missing optional external blobs but is still functional: missing")
+        self.assertNotIn(MISSING_DATA, data)
 
     def testSectionInner(self):
         """Test an inner section with a size"""

-- 
2.43.0


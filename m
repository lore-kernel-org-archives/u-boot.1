Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91F9D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAFA83B0D;
	Tue, 20 Jan 2026 09:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="cPoi/m55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290E683A91; Tue, 20 Jan 2026 09:12:28 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF10839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW7smJiELGM86XX2HBNyNUPBySvQlrJ2OWiyDkQRP+sIj1L46s+KUO4WYCY00y5Bkx136Chzb6zgHtRK+G72hs++YYcibhDvqp4wFhSI3VQbtUKt+Np4JjMfh6GAB1AA4Sqm/t/F7l7foFk4ZadS4p2Z1Q6OPz6BeL3jANwliw9oLR/D65+nhw8HJyaMEwZ/JYV4hWv6Qr0xiI63HjaNxbg2yosMwx4jTYLpbdLx30kJvZIHKG7861v1pJhIqWozuJM822xAKOX0+h1zCyr+riMOr8kEXJgCVz5DFP49UxEUp1AeISoAsoXUpDxXswkMTpWXXD3GGU6PHgveEf9yNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuIV2RzJ2pg56vOd1DMg1ZslHuV4ZpEJGbKpIfCf9Ns=;
 b=C0GWsjAkPZaWdbW2bhIOANc/+jr4mQg0kUGGjVI82BWxkRAhjAVvEXsleuRtT6wizR3CgKpyjFT2Bp9CS8eGGhqVYq/0sCQwjDKN2GlubFGhuaQLHqEa90EbvaWGA0ZW+wxx3W8HEM4Ur5Sa1HmfYqMTdJB1HurB/bvNpjIeN4Nhfhg9eRLWgH2Bkx1gi3XgKfnpnJysVdFPj9jandHBYwMBeQtjw6jTMHagLYGS4NG+08hJJgXfIMKDPh8oFatj/tE/zmjyzWhaDPSCFkWx9CoXkhYoFh/PmxTWIKT0u9ovuSrjZpuE3vcc8ByRyp2xqduu/753YSx00aW4qEWFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuIV2RzJ2pg56vOd1DMg1ZslHuV4ZpEJGbKpIfCf9Ns=;
 b=cPoi/m55Qa2o9O8Sw0rTYBxyqiCztLVO/obp+/8tJXCTyIv7Gv1yQrwCT9cXSfkoDSVJ0zTL6x308Kj5gv46znQt/mm74AjtfMR5XBOVRqg63UbgOV3E2RwY0r8MRR3150XQqef0S5Ksw7HmM+40R3Tf17XfGCzN/h2eGKqdoqcCvsZRX6X/RRdPOStXnmBQhCjHdTfu0YODB6I4tb1uar+AYj5lI6/oq1P4uGIDA7nw80kd6dJcaUoeB9yJJB4e44Z001qqcewXPcq8CVwe8kbCAJjeEZd9C+qUnYKpEC7LBWZOQWRaotfHErsH49BCXED36xrswIYjvpISiuIt2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PAVPR03MB9116.eurprd03.prod.outlook.com (2603:10a6:102:32f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:12:24 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:24 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 5/6] binman: DTS: Add dump-signature option for capsules
Date: Tue, 20 Jan 2026 09:12:02 +0100
Message-ID: <20260120081206.251544-6-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PAVPR03MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 621311a6-342a-4bc4-9937-08de57fb9efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RdZrsh/TUKsjoFtIcOC9H/c+ueg11RHO52a/7imPEQg/rypdQGzrt4GefWuy?=
 =?us-ascii?Q?627V/dRQrhUSljvg3h73zy9sfA57pHznHeuHc+NGrj1YEYdEGRMcoDUJ+4rU?=
 =?us-ascii?Q?evAdZYyeYZ6e8Do92lT1SQ1SCXXfkyI1CaJzgzo/ILS5H6PSn/yR6W8IiXbO?=
 =?us-ascii?Q?1uI0Wo0FhqzfGkECQSTijNrLj0bE+L/x4xDvm+NYSarcRuJyE4MydxDj1TvH?=
 =?us-ascii?Q?Abxx2mLWaciu8dbmM7iPtaXy1o3hxx8crugCmW2493f9/Bl3W1bIgp3xJIYp?=
 =?us-ascii?Q?577gSujNZvq5cgsQXuGoFMx/kKnUoWA01z96BmjGpN+hC5uc/IL9KKzgGx+B?=
 =?us-ascii?Q?2a8qGmaO0/pViE8MN8irR/OxWGtD+bdvlN4npDCRWk7H5gUEiURBZ3lGlpFs?=
 =?us-ascii?Q?dOasMoYEXrHZ3xgcMcDJv2m1qQZm+RbJ+BxZrPSPJ+EAMjAHEYQMYkKdnq1G?=
 =?us-ascii?Q?ixN2qOzZmVZNut5YK/q7MwdsumSrerxehA7haTR4DKBA/BjPk/J9sHAlc4e/?=
 =?us-ascii?Q?PLbXaI58vyl6S/OYB6sGy/7t6DcQcE3aLXeP7sl1MaO/YDSXzsCLBqM1KT03?=
 =?us-ascii?Q?DcxiM6sc2kJBisK7SlelcSIQv98YGEFfNzZmyC8EuBuJso1/rCIXIcXJudf0?=
 =?us-ascii?Q?FGJ6Po8cl5XHJgXjUxZGtEjvipFVD9E7CnxmOk4/CE+5kwrN9aaxEOMvaVxk?=
 =?us-ascii?Q?5ZUqMyZOa4OmwDdt08QH5bLtofOhrLWXK0WgC60g2PjP/Ly+dj5/DOrb8U/U?=
 =?us-ascii?Q?NlKMDcnVQjho9b6SNEAspy4qEOkh0tRw0phChPoEN+cTCV0P4o+ppvOGr3LT?=
 =?us-ascii?Q?amctvKdeY1Y4qilWBM4E8+KV+3n2rvcV6hh13uaDjXJWFfV75HlwIo+5TyGI?=
 =?us-ascii?Q?MlsmRsnO5yAd33z8l4uUSrKYTJeL7FtyaRMxCKRc7KFNe1PheVvqcEGXTUuz?=
 =?us-ascii?Q?5HrbTSi+5KJ0VEGI4re8//EDzzvweqjgllPKleNN0sPp4hJdABzMjCsiIMsq?=
 =?us-ascii?Q?reQ7Bb3kr3AQ6kBFuKcW/XNsLp8Qr1aiOl15NfoAI6SUCVeRX4Hl7NU7dn4a?=
 =?us-ascii?Q?Hi99znpGtEfBDg2z7SRa7JnJbfTd75aH7UxwdZIDtq+19E+WdbmV6Ijfk1Sk?=
 =?us-ascii?Q?ttdCJI4WRdOCzWCl2og+DXDUVGr9OqAu/0JdzuPLsViXzTf58LRCYzTDcHXE?=
 =?us-ascii?Q?ysOFriiJx1h24kILZKTgWh+NB0N8MmKgvmmXh10LijM1GLMxaGBQ27r9UTsH?=
 =?us-ascii?Q?DUoyORNGmB/Qn7btMRWgL6NYfKvjFxjDmtZzuQf1d6r0jAk9wwp+xB9cg8Ll?=
 =?us-ascii?Q?bdT3TfkdsRLrUqiZEp5ywC75n8IOEB5Er/SCnOZiKAWV5UezBhJGoO85aHfo?=
 =?us-ascii?Q?ql8KDLWAbOqFs3mdideDUYr+yHvtQL16SeMPlPSbiHOeg5S07uiWUcEp0b9D?=
 =?us-ascii?Q?dU0g2CKnU421WyfgljWuReaYsIXXkr0wk93gAR13HoVnhIiXf/9JRY0BKg4R?=
 =?us-ascii?Q?qXUm5hQxmGemPro5SycQXPjrkoLTxdvz83Hfu3z+3ISKW8K4y58WlteVlydj?=
 =?us-ascii?Q?lGe1itWVV4RSMjirdhtG8BlcJyuZEOb+JIV8wtVKiyPOa2+eFHlxG4voaGr7?=
 =?us-ascii?Q?Rq3T3OCAO6vPfQN8cvoa8XU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OX6zvCh05crWz4625TpKRuFQYIiWNAs8fD5fREC35x4cJnZ9glNLBCBMIrJD?=
 =?us-ascii?Q?lZwzqST53nKXPfFv59+tDIwX88V0k3USpYvFKGlEMnyfFaDBYdBsDL6hqQqW?=
 =?us-ascii?Q?qHT8Nuv3mUcJ7UAa/nVV2A0kmPk28/Yq7gIEGiauK0j5/EuHbg3OmAuNuEBx?=
 =?us-ascii?Q?x9Y8QasWIkD82IxakjM1WxpHh/BP+CW2jUA94LkgyXej49ufwSHVk9T+vLIy?=
 =?us-ascii?Q?BkErth/VNNDsSn4pp10aDjBbY28ZVKC/vF2TRcJyP6LbAW4YxVMYhmTaf5Q+?=
 =?us-ascii?Q?gZFudc1OY1sukYVeVEBZt5cuPqIU1+7WPviRLAhceQizLU1Wv0byYO5JNdqw?=
 =?us-ascii?Q?LwR0dDtbT3ArCt6EapHwNLCW8KnVfQaD0VS5KXo1dGC3LTWh6pjbGOHFkho0?=
 =?us-ascii?Q?58kXlPcOIh9jMR2CX4TCXL4uPAhXVKuN7+fpfLyj3nRiVO3usA6i+vbl5Lf6?=
 =?us-ascii?Q?l0UwwOOT8NNtjRErhuB4j2DsrPGVPHFKAKoPQc/mGHNFVWVIBmyA+5iVN2LF?=
 =?us-ascii?Q?mNl1b6WnE8bMP+As5XWWtxsm42l1oIxl4z3suAIrknafYYdNOXS9ga5Qq7Pn?=
 =?us-ascii?Q?UsEyqu38Oc9sE9CgefMDb1GnbDXTX8DbLJsS4ey+0tBX5H/4Q0OqHqSb95zk?=
 =?us-ascii?Q?UvneqQgv7ZnCSAs3dq820SWLMi7T7KB6svIgUkRuKbJbSw/5VbPd0u7a9BHK?=
 =?us-ascii?Q?hyMnaeFdA+A9i+Fd4gOixq/coPJuHxcXx/8chNv39uhmgqIXWQFAZqJE89Si?=
 =?us-ascii?Q?T2IqeE2DuvG/vAPlf1y/5aDTTsWHy4DkTU7SSmo6wvDpsQ4SYFLmdQsqoOH5?=
 =?us-ascii?Q?AW3vJeunptoCTLIVjGgjIBu4A/7d6P+7hCrIYMGp7ud5+11sygktJ2ygagqV?=
 =?us-ascii?Q?tul/bIU3hMogZR0LbUZbfDk1pktHeeSCdGmC+cn+9KAaJDpfghTTQ19/3uo3?=
 =?us-ascii?Q?eRphBFM5Pqqyi91IF/nBmvbPC5eKbozIX+wgVaOgulFprNFljCIX26o/qaV9?=
 =?us-ascii?Q?LzA6qRVOpwHdArWuoErvMYM2t+h0AROkf1VH4A1p03CUxrz/3Y0vMmEfU/i3?=
 =?us-ascii?Q?sqaudFnS9qf1nRumNeNQspiSGCAGJHHiBLzjmiTMYPeu5OBn5ZeiB7MSuLi9?=
 =?us-ascii?Q?vAfnNzfRXxiOwHFPvaQb8RHr71SDrMD7KsoMw28aImz+M9tX59oDqw8Nn5eV?=
 =?us-ascii?Q?NNyDVIT/Ig8D4EdRxXdvBaheYQOimoufdm4hXn3InKeMlUqOab4N2xA12tac?=
 =?us-ascii?Q?jTQTpODnbRmjqnbD4uWFaKT1OUQFDWcqLw6rOydyBRXNDJF9Naj4kdCvJeGk?=
 =?us-ascii?Q?nCX6rD7h6zzkhGy++CRrYPaSxtARP6JjO9IHinpK5lQX93RTNZvxACNU9qpb?=
 =?us-ascii?Q?g66SMDEuWZPWPNTRpM/8Nt+wRJkMmT+Vm67PMPdOkMh+zgTPUyrnYHImxgmt?=
 =?us-ascii?Q?PCst2CicH966XMe6ez9/iSvf5fManbVX+1bNa4T1ReTu81NUFmcyR555CF7f?=
 =?us-ascii?Q?DdPK8Pekc+U2KUXSV8x+UMZ6NHXiCL2DUQOtkrkre7T0T+yujUD5ivXY5M1q?=
 =?us-ascii?Q?rxyMG1Ms7AU6zK53yiEma+5rox+XHgHz/C/WIXDOg34jc0lES+QFA+R2JMD+?=
 =?us-ascii?Q?cbdJt2V9rGyXwWk13TY9bynGfF9hSJrS1HkFq/3w9EQLseZNbCmlmCzzKstw?=
 =?us-ascii?Q?mccdyuCTNo/cWb2TGbfXPzglhmicG0Ox0x+oskiYxizXWIETyJn/uGh2a4Bv?=
 =?us-ascii?Q?5o4Zh7msPg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621311a6-342a-4bc4-9937-08de57fb9efc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:14.9762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0ftTfqNaPtOZ5k0Q8AHLJxzYxw5GCKvkyjLugcFgZP21TFuY3y5Zptwd00mY6wPXHIIVOYvqD4y9QSASDlghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9116
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

Mkeficapsule can dump signature for signed capsules. It can
be used in test to validate signature i.e. with openssl.
Add an entry for device tree node.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/entries.rst          | 2 ++
 tools/binman/etype/efi_capsule.py | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index a81fcbd3891f..1dace2087a2a 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -552,6 +552,8 @@ Properties / Entry arguments:
     - public-key-cert: Path to PEM formatted .crt public key certificate
       file. Mandatory property for generating signed capsules.
     - oem-flags - OEM flags to be passed through capsule header.
+    - dump-signature: Instruct mkeficapsule to write signature data to
+      a separete file. It might be used to verify capsule authentication.
 
 Since this is a subclass of Entry_section, all properties of the parent
 class also apply here. Except for the properties stated as mandatory, the
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 3b30c12ea514..01d56723b98c 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -101,6 +101,7 @@ class Entry_efi_capsule(Entry_section):
         self.private_key = ''
         self.public_key_cert = ''
         self.auth = 0
+        self.dump_signature = False
 
     def ReadNode(self):
         super().ReadNode()
@@ -111,6 +112,7 @@ class Entry_efi_capsule(Entry_section):
         self.hardware_instance = fdt_util.GetInt(self._node, 'hardware-instance')
         self.monotonic_count = fdt_util.GetInt(self._node, 'monotonic-count')
         self.oem_flags = fdt_util.GetInt(self._node, 'oem-flags')
+        self.dump_signature = fdt_util.GetBool(self._node, 'dump-signature')
 
         self.private_key = fdt_util.GetString(self._node, 'private-key')
         self.public_key_cert = fdt_util.GetString(self._node, 'public-key-cert')
@@ -150,7 +152,8 @@ class Entry_efi_capsule(Entry_section):
                                                  public_key_cert,
                                                  self.monotonic_count,
                                                  self.fw_version,
-                                                 self.oem_flags)
+                                                 self.oem_flags,
+                                                 self.dump_signature)
         if ret is not None:
             return tools.read_file(capsule_fname)
         else:
-- 
2.47.3


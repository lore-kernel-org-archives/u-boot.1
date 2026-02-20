Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DA8C5516E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFD583EE8;
	Fri, 20 Feb 2026 10:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="dwYhWGzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B4B83EAC; Fri, 20 Feb 2026 10:15:32 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA7983AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edAK2NI9nqp8cB3jaOrwrnVTjm2AKicnXHyk1EAcyeogjykWMYfCBVXrnk8UNq+ESTeB2Rb6hVz0BYE2KRamwjjT+FiM6FG7ugLaPE7l5WFwEtOgReYxcKOnsu1v6TszAynmC0k4YsWCB3e/RLePyRQHxnr5uZxMPqO44c81PsgqTHg52cVcynU4Ms8XHHIeuQ2C1jZqhTFngm+zsVPrlNjU+vOE9HB4HCvDrf+Sm2N67oNuLfMNChOVFegUCU/XIV//MFM0jIOunATcDhp3Sd/UoVp6YLeisFrCMIkMg2qsBkJWmztClPV8klZ6YxwVQqCSg2Yd6+oPvNM7kNr3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvcDsHHKQBvGPhdBF15520xnz8aqRi4H5vfU0eJx9XE=;
 b=A/srxrZKPQs92ueOAoSVOLneYfuejEJ6ffQmuGnXZ+YGt0bGHBA5H1692yYJpmdQ4QNXhOZTYPT/WoL0H0YMLf8Nv/G0KrZfJeh2GJiQYhJwShkg/eZ9v1fLoL9BMGCQyOaf7kqi/N4frmn7+CcmPCcZ2HcS9GDZM9zvfvmmjXqZwl0fWSaxj+qc2zfJK0wfc/YglsCWZ+8wqStx9DcHl/E2VRSZPAHZLTzn8o1NWvQJuylky65fwbFbUiZhD7KKVwR4jPMe5j7KsddOpqGBax2ngGhQVhPL7fDBlN1kgli8e4K+1Uw0uoKMS3ll1BAClLdyoCXvv5Oln8iYyCfRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvcDsHHKQBvGPhdBF15520xnz8aqRi4H5vfU0eJx9XE=;
 b=dwYhWGzF4508zkymzdreKEBMTg+ysz30Y8rwxxxA4EqwAFCuON7RZOgSipkZMPaFoxcx+H5TDVDKWtie+pjLQy5Dv/R1fzcVx3gCTnRnmG9lXT+i7M8sopAP3WFy5Bf0d8wteZx9mPsRQTPhJrZ7/TS/NFINFmMwWFgfXumsAHOP6USt7GII86amol7X8cAor3up7MfBHKLO+ZMpPoyI/yR5KId+PUJVlUfI16VxDdKNMVWFvgAy1i+33kQbOUTZNVDlmceG79EXdooG0w5DGuzSAG2b1fF11kKMgvyzY54yp8bCVQ5dNgKkJcQsiW/yDMnKKgy+bC/hGnA8OabfvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8544.eurprd03.prod.outlook.com (2603:10a6:150:9c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:15:27 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:27 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 5/6] binman: DTS: Add dump-signature option for capsules
Date: Fri, 20 Feb 2026 10:15:15 +0100
Message-ID: <20260220091518.180641-6-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::8) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 906b3a6e-6f50-4e4d-448f-08de70609661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|376014|52116014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q8LbUYN8btzgiXcYpGHzIBgQUPcJiun8MEKSaIHgxP3Q45dWEMQr1tRzp41g?=
 =?us-ascii?Q?Uwxla9PGlkWW4x2kLjg63Z9BscH6qm+T1ZsFSTowk3bd1dHB8dmlLCEyw8io?=
 =?us-ascii?Q?x8Kz77BoCGBxAY4XQTjfCiRA9pR3vSP5/sqDkPlFIZkQdeccpPDjWV0/vCHh?=
 =?us-ascii?Q?BUhBcC4eCIT7SZs5cdGB63xMveZwsfTGpSJv5GWdvai/8O6uF1YEWyurXPr8?=
 =?us-ascii?Q?2N19Hi+MBtjOsY1GOivzDEkRy94oTbbeDXau3ktdmGS9voDjZPVn6IO+YBvx?=
 =?us-ascii?Q?ZP1HX/+Ue0F9vpUKXOVhVYBopovhPD0C6kuDUu6Fnh8okujd+rAZOr5KwXd3?=
 =?us-ascii?Q?CuWyt3/ZW87kF8rZ7HfkWH9CkeVgCKhboNp4P8bAJtl5DTaI5ERVge9DZF7i?=
 =?us-ascii?Q?v7QmrM+FlC9Xb7liPp+4GrNVfHqdwElBFIj8I3jPSOtccBSMFPgEyBtLC4yz?=
 =?us-ascii?Q?eQBQyLZLGIeYtj5IfTjMNp1Uc4PUTuxwmwyikqMb0B66yDOuLpNr5yMgl+x1?=
 =?us-ascii?Q?GLwjq/T4xrY7dtJVQnIp4P29yRw4Xaldx/YOVCctXiwNJskpiXFHfeBz3BSE?=
 =?us-ascii?Q?5+WyUpkbJzNXe3RRKm1siW4A5Unqz1fYSZ/iiYzwkaQ07le7wE5SMHsDdHfs?=
 =?us-ascii?Q?0yQYkXDhJc6SKC+XLAy1til8VEEJ19S1DlZCuPVGwRdCNzySbUgPjGRbKg1D?=
 =?us-ascii?Q?KknJbO0kvcq2kXqH2mKXm4FjR+qqnJ++W0oKQy+avK3uu4UN7Wa+A0S46m5z?=
 =?us-ascii?Q?w0aL7ob5Uy+7d5RbENsCKum/toLObS4QcxD45Cw9Y55eDmiwUfD7zeNcGvLq?=
 =?us-ascii?Q?xtlpdEgB9/Rmj+a21zlfgaIabpFe62jwGqr5opKNYn1Df85dm6Y4mSio5eFP?=
 =?us-ascii?Q?5wbmy0eS5nwhClwdxFY1yNhV69KdM5R5cN4CoR/LmWe8/nkAN8ip9URRicRQ?=
 =?us-ascii?Q?2lG3unpY99JssE3QtltAiYUxtI4bHiFaj/68lhVUkkNmt4Q0ceYcWj/wqpp5?=
 =?us-ascii?Q?/3McasaZkMXMVWfvFWAhtmTjQf6aFMST7npmmL4qRf2VAbo0/X2q3wIwDUbQ?=
 =?us-ascii?Q?XTV4lKOyZgv5jv59JTxOc/0Ezpd674uwWPf9lOAcF7lybcaulMVuRmWEdiRJ?=
 =?us-ascii?Q?iH0kHqoeyF3Rpn8yagViAi1JhIOm/aJHM/V9UDDkb2Ysdt1omYBWVt2Sh9iF?=
 =?us-ascii?Q?JAvP2ZmUwRAXlKExX5FhfD+s8/ujbV7B6Dh4mXBdkjogd90F5+j3vP23aD0Z?=
 =?us-ascii?Q?o9ZaKVt9mENJHTsI0WLLxRmuhS75LZSWRrRm6MV49DN8KPF+/Y8Vgh8BC5UA?=
 =?us-ascii?Q?mobZVRJsRaDJX2QglGZmG27bOPc9o9rpNCvdIeLOzIXZJB70IBwxcauTpJVE?=
 =?us-ascii?Q?QWBd3VhCUSKMPxvTA6gg4fs3lGjw9Qc3FUBXoXHdphE48CDWXNCvn8wgkX+s?=
 =?us-ascii?Q?ME/ldhAXzAVYg+hDmPPqTGsJCpsVmCGVsIGBHGPALEKdCKkGvn+i5K07uzVJ?=
 =?us-ascii?Q?o0iPFn+536P7WbgV4bahnFHEdIHSvClyBhvK7VtexstanCa++xzGGdIyZZ7J?=
 =?us-ascii?Q?2mFnZ5f+1Id5I6tmplI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(52116014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iChipkUA2WX8zhsM0e+FlFrrttdOlIvcHZm6+KcPKms68W/fxXAjOXIFLlef?=
 =?us-ascii?Q?JnWkaGhRqyc2TfRdOxm2qIIooMnhJbp/8gDDbfzmHcPYtuMlXIaQV9RriwyF?=
 =?us-ascii?Q?AkebfFTgnJuUPdatsv46x7AboM/LqRrxPKBJnsGkPDpm8qqgO9DDvqpKslPD?=
 =?us-ascii?Q?gBtNXicTzeXxYSsYJ7pdv8K39FwdUy5NaGEsatTNziHykWptF6vJh8lP6yOb?=
 =?us-ascii?Q?WFA5RMgnRF5qr9GXQsq1dcIaj9G/uchKqUKSyniQHHqvJQ54gZ0sVqeUnwP5?=
 =?us-ascii?Q?BdXBPfoRLylutKWOJrRGdlB7vek2Fu0DXn4lauovCHbwcupFjaemaoENCiuA?=
 =?us-ascii?Q?lUU/UoAXK5Di7txQeMLOxG8JQHUZTgful3O7+vFff3OIhQ4umD3Mz7h78SJQ?=
 =?us-ascii?Q?yroS6/KD5kGTUZJV/3jrWLfP9bSCV8NM/s5uoeT46l8doGmzHSOT2r4t2ASs?=
 =?us-ascii?Q?fhpuOZYrb6iidqbBeKUDJz4b/CSSWxUigy2CShPGOCW9orbBLpkfVW4sq2gH?=
 =?us-ascii?Q?NyPXv4jeVeNgIaGWv0wICSbUfUSjYE8C8cLcYetJoTyuThEvennCGdSLaOT0?=
 =?us-ascii?Q?3J8+9kkuyVZ0aEebsgUvosk+lH0MsEKub3jQVnLujfoqxWKvedfg01bVsoU5?=
 =?us-ascii?Q?ic5mioWMupsdpjxgoXXpgwk0JwdAPIW9VYcbUtNoFYeK8vNYbxXztuGLP1YS?=
 =?us-ascii?Q?pQpax2FHLLxlohCorh8ASuD1GdVHSZna6c7i3R/6KtEaIOGFWFwMpr8ItiEo?=
 =?us-ascii?Q?WVnqvMxkwappLjebBGNN/B9NHlodZXKii3YMasANtWUJHwJN8Mh74tFJTtZ2?=
 =?us-ascii?Q?dVPoikE3x8AlCl3Af7q7ELOOXl7YQCTdMcvKZJjjWUlX/U9jWr+Vq+HgJiUm?=
 =?us-ascii?Q?RdbrzOcpFB3JzqzvLhPgSo0n2w/6H8es4FE39tjntR3anV3sMaUDUEOkbGwU?=
 =?us-ascii?Q?F1beyFtVMJSRVve8me8iHatB3ho/46D86HLpGiASCk9XeccIWYiGxMYLVJCC?=
 =?us-ascii?Q?2InzOkl74ixQuRy2jXq2WqQYiKSM7Y3lkjPj7jjx8gtcDIrCKy1Tx/pRycPf?=
 =?us-ascii?Q?3xWB4Zpmv+ETNS2sxfmxS7y0LWyggUoVoe/AkzIWo8qoYvklrq1kZ4lpFtzA?=
 =?us-ascii?Q?T2Y7ziawUCgG83srCTHwrEp6qivg9dB0mgwdFUh1r52CAyT00ftMtaw/EFvv?=
 =?us-ascii?Q?E2F7O1Twe8KTsdD2mBiQLb6J+/8fa+uTepTW6esQcq3W60/QlSCCFZU+LmLe?=
 =?us-ascii?Q?v+3yOuUbgV88glWVT96vkFG0Nt0FFbDWjpl1pV4uWz2zlwtessiQDA35XVVQ?=
 =?us-ascii?Q?jiF8bP4q8eWlAmr8C0UQ47Fhdgq+vOSaVz6z2sNv1/PjuFdUOrFhwS27pqP1?=
 =?us-ascii?Q?M4GKRd42lN2w2k0JnKFtb105/Fg9fbDWnb/L+3xkFxz8u8SrdlqpkLAny7Au?=
 =?us-ascii?Q?nVICf+AwyyuSwKaYbnlTBVcie7Gwaa7q86WVfrhUTvQudsSOCU75mcSQbikP?=
 =?us-ascii?Q?yt28EiR45Oap+hmOz855hhY7xIYxOP7l0/+hJ4c0UBbKVK2EllnWXjJw4YaW?=
 =?us-ascii?Q?HPOqYzbp+nKnNDEzYcJM195ZgNqlQ+8amyQpFQI/u6UL9rsM0LiG3+YXnU3c?=
 =?us-ascii?Q?Ufxxh/lvKFvF0qeNPlUyy/I3XIPwjghLaTwbPvH1bEe14XwRdz2bR558YU4P?=
 =?us-ascii?Q?0KdKWqTMvH1kh9tsZmaaIlsanHvt+512/sVmmW2NruVbipfc6wiOYK/cR33d?=
 =?us-ascii?Q?Ei6fLiO05jpfwXg3rw5Sf43tcbEWGIb9B1UY3O3BwgfA0GzUXBUSkBucPzMN?=
X-MS-Exchange-AntiSpam-MessageData-1: gykNJwFRcJyFvHF0QFq/6CGoNbOL5TjhTas=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906b3a6e-6f50-4e4d-448f-08de70609661
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:27.6507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dABG+mEiYdxX+n1YalrriVxLhkHZde1nfxyt6ZNYmqTxylvEWRH9+rQjjHylwv+MiNj0Gr1oYJc8oVlCR7YTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8544
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
 tools/binman/entries.rst          | 4 ++++
 tools/binman/etype/efi_capsule.py | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index a81fcbd3891f..91f855f6d7a3 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -552,6 +552,10 @@ Properties / Entry arguments:
     - public-key-cert: Path to PEM formatted .crt public key certificate
       file. Mandatory property for generating signed capsules.
     - oem-flags - OEM flags to be passed through capsule header.
+    - dump-signature: Optional boolean (default: false). Instruct
+      mkeficapsule to write signature data to a separate file. The
+      filename will be <capsule file>.p7. It might be used to verify
+      capsule authentication with external tools.
 
 Since this is a subclass of Entry_section, all properties of the parent
 class also apply here. Except for the properties stated as mandatory, the
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 3b30c12ea514..022d57ee5519 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -53,6 +53,10 @@ class Entry_efi_capsule(Entry_section):
         - public-key-cert: Path to PEM formatted .crt public key certificate
           file. Mandatory property for generating signed capsules.
         - oem-flags - OEM flags to be passed through capsule header.
+        - dump-signature: Optional boolean (default: false). Instruct
+          mkeficapsule to write signature data to a separate file. The
+          filename will be <capsule file>.p7. It might be used to verify
+          capsule authentication with external tools.
 
     Since this is a subclass of Entry_section, all properties of the parent
     class also apply here. Except for the properties stated as mandatory, the
@@ -101,6 +105,7 @@ class Entry_efi_capsule(Entry_section):
         self.private_key = ''
         self.public_key_cert = ''
         self.auth = 0
+        self.dump_signature = False
 
     def ReadNode(self):
         super().ReadNode()
@@ -111,6 +116,7 @@ class Entry_efi_capsule(Entry_section):
         self.hardware_instance = fdt_util.GetInt(self._node, 'hardware-instance')
         self.monotonic_count = fdt_util.GetInt(self._node, 'monotonic-count')
         self.oem_flags = fdt_util.GetInt(self._node, 'oem-flags')
+        self.dump_signature = fdt_util.GetBool(self._node, 'dump-signature')
 
         self.private_key = fdt_util.GetString(self._node, 'private-key')
         self.public_key_cert = fdt_util.GetString(self._node, 'public-key-cert')
@@ -150,7 +156,8 @@ class Entry_efi_capsule(Entry_section):
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A97BD35662
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B287D842BF;
	Wed, 28 Jan 2026 09:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="ebFdGZaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1842083B87; Wed, 28 Jan 2026 09:05:34 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131FD84286
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/YQGj5aw6/XO4HAmi1MPkWCYCvV9ga+LdrhjPpsR3ntZqGsYKS56DTQkbf3Fe0GCj8wDAcd5TQh6F6khYYT3fdrB4WLFtybuSiCaZIO0tF26vh2qv8C3Itv6LirJEjF8f6Yf5RftWDIzbIY9GYXjjBYZ3muC+Mbvf7nsL61Fqekd52y2tSzy6U14lWFKj8rak7sRx4GHfe/2Bik/w/IZ+LBkcZKio9gBRv9490baoVJnsHIiAU4MDwHBjTlDHK1kQyNiYsZggTw2TG8RRlxZ1s8Ygsd/ZkC9fKvdr30B5LR4KpOC7TamlkQRVzN3fMyRW7cB3tP9QGYSjQogHmDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvcDsHHKQBvGPhdBF15520xnz8aqRi4H5vfU0eJx9XE=;
 b=ygP5ILGxz8C2hEO/geuSF/yW84kEgUx7S+iZlEV7OvRS+dtLSbJyBrUmZcBqUeiFM98bk2DjIR0jYdjr0PEYnpfCPYbn75pgTlPSVS1VrHe/JZzP525/u0ktuygebSaF5OU4+rjPgtaHQ09GWVWSoFBToUCo9yrwaEZsTVa86jTYCA7CjtKxZdoWjRKDwEBldIktJjKj4nOoCvVQnfQS5TwhpKxRX/hc2sdSu3gN27Xc0UpDCMHyVeSmB4s8AWx2W3ok04K3h2XW4KV4EiKYjXWowXmyEjAKTx+lrqkyFW22IqneebiP0Tj3Gh0Kgo3r1nn3fIVP8LIcN+pBkCF98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvcDsHHKQBvGPhdBF15520xnz8aqRi4H5vfU0eJx9XE=;
 b=ebFdGZajgdK3xoNN9RbUYk8oe+AW5oi8BN5rIkQ2KLEisUnlyCB3y8i9zBFZipWvlvWnUVvpSDKKhxEEq2fUhI3hrnHvsFK0+Ntjj/6uLW/TWoZz5NyD810OgEKTWWP5kHVQUtmpi79WFd5nKLj6KPW91uzfEuDB58k6MuF7QJe5Px9v/Wc8JJ53qbaa1LpI+cP/a4ZpJv+f74RgNSHCYTfZUC/COSudWIUZgGA3pGI6/sxFT60LJlUMG0TV8pafq1ozMGukkQmBSR4aES7Fb9JhpfdVlby++GR5FLrqRyl/XeGuEBNZdoJA5rBmOgiTk0jmRbNpzSDi90+x1JNcAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by VI0PR03MB11456.eurprd03.prod.outlook.com (2603:10a6:800:321::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 28 Jan
 2026 08:05:30 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:30 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 5/6] binman: DTS: Add dump-signature option for capsules
Date: Wed, 28 Jan 2026 09:05:12 +0100
Message-ID: <20260128080515.1275941-6-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0219.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::16) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|VI0PR03MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: ce48e48d-cff0-45b1-e784-08de5e440135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7vl6Ue9QXRgxwhay2ko+vCaQ+0CzcBeqnViAozg9iVnrnT/lpNany/lYJw2k?=
 =?us-ascii?Q?QkLlI7yywKNXEYEBQ7Jf7FiZFxVPT1qsqVtEwFqIBYGMriw5l6ESDxqZ0u7O?=
 =?us-ascii?Q?jTKveMTncJtRS7jb2WbnM6zCKlLZlUXl5fwFnzNwNoaqOTXxjeHs6AMt1/dA?=
 =?us-ascii?Q?7zA75MmIFqXX2xI4z3MaUBdzMxhS0AJwXR57j8TpkyGFbojoAPjrK//4tKaA?=
 =?us-ascii?Q?dZf4vaalmk+0RDDE2RNPhYNgJkEE7WeXPmlwudGho0+7g9oB2+/chcb57rxq?=
 =?us-ascii?Q?PUSR5IehrNozKXIpWYXqS3rY65p4OOpdAPZ60Vhooz/pinb+A5qFAgOOUbEB?=
 =?us-ascii?Q?WuMpwSCW7gYDsa51PjFpudUexl/El1CiddJy259P9aA69KMtl98xqMr3udZj?=
 =?us-ascii?Q?BPlEaOMfZ8GV7wHfqSLMA1Ai916fjbocH/O1EFsdLzwzzf5FGPcMimWcofKN?=
 =?us-ascii?Q?qxQJIzjtOnPUZB7f7G2DU99sao1PukiD7o2C4qMEtoCBmReu2EBcozi32w/w?=
 =?us-ascii?Q?VeAbGXDtP7xhWBdTe8GYDZL3L0Y6aR9SM0rZ1qnZFJnyFDXSsRdhChBNEwfd?=
 =?us-ascii?Q?uP++nHFvRyjEWX+hZOmiVzG6NaC3godYE3Eu7Dya+v9ukm03NHPzFim2BuIe?=
 =?us-ascii?Q?FHIZowSKBfpSh+1VA6mrzvyoz7oZKoc6ZidahGEThdeLNnn9HM1EJSQE0oxx?=
 =?us-ascii?Q?GJ0DxRZPIW0RikhLfbupewgqNBJFctnrL/66nigJLg3lIV5e5y6xxmRbT2lh?=
 =?us-ascii?Q?aRAcp6Yf9GUW7YTWRUppY8a885EooKk/tVuG8lA28mCnW+f2OpfeQMfMMiFx?=
 =?us-ascii?Q?ed8IMt7qaL2kTFjCwsB28Cb5e0k4jTr960jwjSPJwVQbckVWbo/W+r34yL7e?=
 =?us-ascii?Q?Fun3FsLCgOsHrtj73772n6sSZGT2eO1fTfvi6Zcnm4Bbnz7+Ob0zbFV83MNS?=
 =?us-ascii?Q?KmtplIkD6mIEBf8ESc7vLRzpw9eWHmsoXiWCJwWk8rfEUUtNs3Xkb/gIwFpb?=
 =?us-ascii?Q?FrrkiIZwfHQVwXqes+vNWxiuaTYF6j5OeceRm2YLLgMoTHH4Dc9BPBqHqRxL?=
 =?us-ascii?Q?JaZXlhmXjTtlYT7g1EL3xkUB3wNeHvv0BJbFkeu1UIgltML5ua5iN2RF6dZs?=
 =?us-ascii?Q?/6eLcGwEQuw5GmSoWuI7oFxnhLjQBdf1L6S67mZ+BTKZotfO/jLJHmDlo1zv?=
 =?us-ascii?Q?ePtFgGS43+RUXoZ4dgCBQa//gVQQQXCPESYrJ39ESUNIBn79uAoSGaeQN0AK?=
 =?us-ascii?Q?Iuf3Haj7PX6cB7nvJmxaECcEXA3BNw3gjEcYaGrz2Pc2YUfGN/IGUGn6WwJa?=
 =?us-ascii?Q?6HcWvFC6VVWRft27EbICFl6osXuA5FkPPxDCgLV/37GQo8fITcbIlJBcOiio?=
 =?us-ascii?Q?of52XV7j9n9o39erMN5qXe/01lsm0gvnMWRC8ZKO0bOV1Xscd/HW27iv5fIM?=
 =?us-ascii?Q?/sVLqjPE+1LCiOq96PGEXHXa8v+OVKp2W/S+BEtFIluoghFm3O3TiYJftIk1?=
 =?us-ascii?Q?+esFo/hkWUD8qPOsU82zMYp5He/69qG86L0BV8+lrCIgF4NqZYJF5QQ+F/Lh?=
 =?us-ascii?Q?NvhlqWWC3XSzixCr4ZFmmDQ0k24cBJ/CqRlcWEML2fFGkXyJn1iOoDtEy49w?=
 =?us-ascii?Q?/P/tj5tQqMJqE3/NkrokQg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uzX39Rdgt4iGU0GSALY1JFL6ak8MzVNEfatc4ReEwRocBXFT66WPdqLQhNLm?=
 =?us-ascii?Q?cN5X8+1KufNeR0Npo2FPoZZvQsTSeUY8dvTXWtP3EM1CpyzjVi74XYq+6TlV?=
 =?us-ascii?Q?AIF3gZB0MZkYSvRnFMQordgWl2q+/RSerd6A4tt0E4Wvy5kW3deLqBaEUKfv?=
 =?us-ascii?Q?XHd7uriwpTojtQGWdOrqi7dEhqaOm1eCrFzbe/NlIB5qLiZF5MFDdYzawMq5?=
 =?us-ascii?Q?bXUAvjoasjnn2dnoBSd+TVKJ1mvPOjyfi0ApfSE1OqmPs5PNNsr3uvv9+iYl?=
 =?us-ascii?Q?/I/11tY/+BEg1sa1MEnzfXosm0/9/yRoSVE5JbcFRuY6k2FfM5R/T/HmwJPK?=
 =?us-ascii?Q?CwSlerbp4bVdVvjV0jB/1lzKnG4bT0KJjPvJ8gaBgTYmTaokmT7NZMqPAChB?=
 =?us-ascii?Q?0NpVVCuAXWXO4ZkBPPdo/FbKnGYmVWvTUfj0NATvLeDKz3sRnou7Cg+lElT3?=
 =?us-ascii?Q?S4MkCgmGDiy/+EqSKV19zNef1Vi5ADCD7ohivdHWtA4olZ1LVxaBlABX52S0?=
 =?us-ascii?Q?VyjGcr4ngrYcu4/4nFuRsBekqJYj7oo39PIhR3wq9WCIZuFfQedm+eaC48Qh?=
 =?us-ascii?Q?mU/d3RCFUu5YyJ2wMjO1OZ7QrQaRgI+d4tePXaeRygFTbFjqNU0znpQWAPXr?=
 =?us-ascii?Q?rkaOTkzTYKapHu8swxU0dWwV9aDFirXtTg8d2dHHAZmGExHigsWlS+wcCrOW?=
 =?us-ascii?Q?WHS/JOsXRUgx27pwQdq9QFKEUqrPhJX9Ulha/49oSfcb1PHyNwMg3R1VaKWM?=
 =?us-ascii?Q?T/Ckr/JuGHFpEIgPNZgiTgwHav276qEGZ2i/nsIB+mMj8R3Lhuwb2biVLXlU?=
 =?us-ascii?Q?HiMS/0nfssj/dGQQPVFpjCmcnI01/m3fe79MxFk5ILogAWdebdI/To6SkLFz?=
 =?us-ascii?Q?j4KoC++4DhmHTAyIer2vQfm7FhKHtrNccgcFxS2OIWLjRJYNiaWjeUzRoScT?=
 =?us-ascii?Q?lm6Ab1d2hRYaOCPau7qcPKlQUJD+CcLZVfu+1y4frXC5uRB2PaemzN6Z7DPk?=
 =?us-ascii?Q?fPoG24E8cTFjkRC51HUTKlA47KGQVNzwusNoovs0YViGTl3cP1Ti7J0WHBRT?=
 =?us-ascii?Q?eAn9RfAB5CIib2Y8cOvQMlt0J2lJ2nz/T/7GjNYAxHWLd1DMHImLDDXlV8+7?=
 =?us-ascii?Q?DIurwQJ3U5W2tWFQKQxbXPCo/TgaD5YbJlDlMEESh3ascTU2YI25k0r04gcO?=
 =?us-ascii?Q?gbV3wRee/vUCKSRrkDNdhcGqQWSr9k1Xkgi+ai4FgcDvdmyInXAW9iqqj81I?=
 =?us-ascii?Q?0W96aZtZHaeuHMuhJdgJtdmGdVSrjySM3w7WKSodMmqFo++K5gJJdBM13jgG?=
 =?us-ascii?Q?s5gvIU9+iG0LHU2a2q1wdNS+HNZ9ZOHhgRvsxFUZcydNnlRlISkiV98wuTxG?=
 =?us-ascii?Q?cjdQRk15wkNnnbecj15sAhpEOYNjCDy66EWHZtXdl5orPJGLaH0ZYVye5JgJ?=
 =?us-ascii?Q?mKNKZjr5wT6cbvpFt1t5aqnXICPn5PQ0wMQhZsHlwPj0tCC79+KieQzOup49?=
 =?us-ascii?Q?znSzCAIwDt4iJWya30y/YLRcLaboEaf5zW37/ltIyZelYQcHAdhPD8BvPyrE?=
 =?us-ascii?Q?DzJUntnakF9x5tlNo9QDq1kaOuwPLMt4fwOVYHNOEEko6aWuOgsXW6fWHzxC?=
 =?us-ascii?Q?VLRb2o7a1G2iLzTHNvqQRHgczAd/Np2IRHHCviwIYhD089/MYURkqo2LZLE5?=
 =?us-ascii?Q?yBC2EAkg+bVY4WlYKC5Cjo3SLObpgDgXduIrxQUM17RJ3jc0xaB+J5XEwr6F?=
 =?us-ascii?Q?OVG8h87TWA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce48e48d-cff0-45b1-e784-08de5e440135
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:30.5101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8U7iBnOSFgborhsZ9Bhr39pvCSn7r1al0o10tDHtigDEaVgNCSayMdOUNQg1dpDCfX+z5xpm73EwkjXPE6cUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11456
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


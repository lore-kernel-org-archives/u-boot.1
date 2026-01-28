Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCDBD35687
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A812842A2;
	Wed, 28 Jan 2026 09:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="CegIl9hQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F54C84285; Wed, 28 Jan 2026 09:05:31 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31FA84253
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtoFZkP8fHu1IpOvDdYLnUzMGsO+tnjSxw/N58XfnQoYBRYtKSYAezw0/rqaapNEieUW3lnlzUiWGRrEz4iqInRiANzoV+NHl572zq7tFkm1Xq8RTbMw+Vx0TzNMU0FgHWNaX/cRmMWxXz/W7+Ob5VbLpaQ8k+vSzv/ZgpQip0iJh1E58b3rXQEzaalDZ33Ep7USzlGC4vTJyM5+d+7/wF0G+3Prq2hfXdTJdhkknLy0KO9hFI7PZxRgVAfNuji/bl8SzVH6XLwjHG0XU+mZUyx1GfNzzgdeho9q55SC2kNRuJzDB41mHHYZWbbnRD0xMHCwiEazF9oBah8HH1eDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=UVzRqWryn/mjeNckwLgLlaFBkLQGaIZgDv0CLdu7eHLtbKFtsunWoOFKdZA38QsTtaGyGUvV28GaUcKBjX6v1NldQVCdsvpkC8YXYgTSlUARk+0fW+xBeVq9Rtk8V6c79HZRZFVJxjG8kgXi95ZrvS68tMJhWfOz11Pm70sUbOCz7g8edgjcWrTcdy6FgWIaYsYoXp+rivJItyk5tiT29ADq4/ZaWm/S8NfudrxCjePymSCTm8ldBBf6cgZy7KPWbhT8OLqiob+1xTWsxLBg4LHWJ7YcOCBX7g/cMdWbTSbchktt/6nT7CSuHSp2WxgnzRGOhPUMz03yqflnfTsCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=CegIl9hQLzwiKilxkWyZCKY22qCeAP+crwJAb25tIIuGRLevVVbOgxoX6TU7+K4dY46tl1VdnGdWGFJNe4Wa3cH65VMMEo4jqVOXDI4v4IhAsq6pdSyWO05IvdzKOhl5K8D46WtfkC0m+RV1+pLxv7dJGhW/TpX6qwDbm77LT7SLNOoUBf2Yuz2ilFYk/rSYde2nHsNIlKCPb/Z0NHiAWB3zThujTSrAt92fi7zqL1CXizAuZfGseNPpAo1BNix9SwcszJ6eC4ohVuNNI/0LOD2pXh88DJegHrf9sIelRFvqHyTwP694uzp5GqQcUCPo2YjNTIhLKRNrsOXR6XBNCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by VI0PR03MB11456.eurprd03.prod.outlook.com (2603:10a6:800:321::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 28 Jan
 2026 08:05:27 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:27 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 2/6] binman: Accept pkcs11 URI tokens for capsule updates
Date: Wed, 28 Jan 2026 09:05:09 +0100
Message-ID: <20260128080515.1275941-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|VI0PR03MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: 378dbfbf-dafa-4c24-427f-08de5e43ff52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HF2w+9oYuwiNnmTUQ5h0/UV4y30pvLL9YveTvgR0mH+NPJ7PukaWofziQ0kQ?=
 =?us-ascii?Q?7njj5ujWpPgdi0c4eEiIu6kh6i7RJOk0HbLR9Blp1IqWsw3m4YdBxYdoIScO?=
 =?us-ascii?Q?hDfZUGCJ835x48gSYdgR3Raj+wSqK+kZN0qYJ7VOT1UlnmzI1FN+CEfA3ixT?=
 =?us-ascii?Q?xaxMm+K2UTdcRkbkCZuGUpGKLK7vTFHZu5pw68+u5RzBlif6mbaCpXat1NeZ?=
 =?us-ascii?Q?Vd+A0dn7+rHROETe4oGgr+r/fbCW/ZpCIilFtHxn/QD2UN5HlR660ouVUr4n?=
 =?us-ascii?Q?sDvyWmFB3EvHLS2Nap91zTPWqQNqQAC2Kx278DfwqUmpdFQLNW1Zp5GHpd8m?=
 =?us-ascii?Q?PMas8HYIHpQnpSrwvEYV6RHYS7ukoFef0zuyWpYi0A5ehaOUIv3Tl2KLzlWH?=
 =?us-ascii?Q?05D85o2i6mLcmyB9o73PdTmnEpj15XOOzVU89CZSXQc2uJS4R7I88EdSAJQe?=
 =?us-ascii?Q?lamOGB1LUMWsA7XsgtjAdJzZ2CVuF99R181ciVcU2YMCVdnH/HwYNKkZ6ju/?=
 =?us-ascii?Q?pwUsCRITPav2r0TBk51UYXGyzxcd0QZ5iCIysFYvPkAXZKEJHPkzH0lRZ4i9?=
 =?us-ascii?Q?FY1glmAl22WaIHpx6g036UjnsQ85JnxlcDosKyfkdrKr8IHMu/zqeRbA365l?=
 =?us-ascii?Q?MZ91Zt8zWGlshw0SOihapx1vo7UyovRU/vhHgcc2qaSYufB8qWoI5nO40QR8?=
 =?us-ascii?Q?heSWLjMZLsEfLBJPXGVh6m9Fs+S9apJjQeM6Tath53aRT21XfU3mAoHm/jiA?=
 =?us-ascii?Q?5hIjLZIhxkyJ6vtFvS0HbjH5/UtkXVNv6qi6jDorEMvqUFm1vwfNODHSYQaJ?=
 =?us-ascii?Q?pSZzTmklU8XrMsWYEKk6LRrtJ1XNCJzQzffHJODO8s+F5pbUa1vAgRRsmZ/k?=
 =?us-ascii?Q?4yhpvMFxqHoq404zfNSDamhg/mJZu4Ay0H87gYsr2pboyn440Ks8uuVJQgYd?=
 =?us-ascii?Q?zwBTuv5mdEeGOuKEYkyF7917+7dUwKPDJJdGyYM7BorVOG2rYgK0Cmnq7jxB?=
 =?us-ascii?Q?UV5zFT0aNQdbycDiG0Tobs/Ko0ltYJP9QwjMDE6QAPVo5SCizxhOb3YB9R1r?=
 =?us-ascii?Q?JosIQ0IDlt6rZHl5EvEnpgNCL8b8Fq5TL9OMnvjrsWwKOoaB1NCV9goz85Z3?=
 =?us-ascii?Q?Xe1uL+b+LTo1HacVMp7LpXra9rJFCGhnEyokTT1dJECBy0loIbKRZGQptl2K?=
 =?us-ascii?Q?QVZ3DDe0kOD1XBiEDiG9EH80BoPWjdrDyXQmbybokQI0RTNACEiDneIEmdR7?=
 =?us-ascii?Q?4+FMgWxd0340osDGegHFC4dmvK5HtZvPzrzOsmz+vg8PN4T2NI/tUfIxHvVe?=
 =?us-ascii?Q?bJlpLtMhY4V6U3JpvPvxgyjEbFta2ptS0ToHpLS6gSOUi4j9ChsTqy+boA8s?=
 =?us-ascii?Q?cTO/LvG4ch9zb8WqjvZITTRkwc6UG5oBctuaWDO7wXOkBXj3Yg4Xszth+meA?=
 =?us-ascii?Q?A8ab2kYDhTmb6A+AhV2290/yawfO3JGIWQFM+4xwo10qZ/mDYeBNmPYjVeo/?=
 =?us-ascii?Q?yFezIAns9sEzmBP39QAgrU8KxWWd22hc0fn0FE1eySxFx/M5nUMDKtfxUobY?=
 =?us-ascii?Q?9G8Ef9IQuiiOjuNkyn6VoTNr+quT5Z8uFjvo2WEU8kfnitcV3OrQ4FSc1GMm?=
 =?us-ascii?Q?rHj69tNJEH8MI8PFZmlZldk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vK6M8zaqJUhetM9tjt9lv/dhgR8smrd0BWoB0gfoEOmGYVaLwr2xFaGSK2lE?=
 =?us-ascii?Q?x3lhXKq9CuSFyIDwbL/gCO4bU2gvMZic8p8H7q6avr75u0hjR2uYjVumbDku?=
 =?us-ascii?Q?JcKzrUGWPCLGmlvY0/yA39qPJk8aMcgKF09YbWwwkvZa9GTBdfHcvg7PENHh?=
 =?us-ascii?Q?dqUGbmXYrt6JtpSPaeKSoutfPQGoSYwsHvVqDkrIa/3csVpHONP9t/U+1C8v?=
 =?us-ascii?Q?MgFfprCpdMnP9Yy4ubgkRLGkOI9h5/BLU8MRaX1DEeEiesRwndRjROFizfVc?=
 =?us-ascii?Q?l0rWgKyrRqkX0AhHqS31oxIl6EAbj1zM7bVbpRHVecsZDLepqJkP7Hofu+wg?=
 =?us-ascii?Q?oyi5aBtBYaB0k2is4D3xnKYKsVlRvKZ+GnjewCz0aG/s5yxOzvJlKDy7BmB9?=
 =?us-ascii?Q?IaIkLr+AGhT0YLBeV2iz8Sd16O6iA9LtMujVN5cjXnDXvckpe/4RGIUxY7Vc?=
 =?us-ascii?Q?Bej/l0ceung0sXSoZkWlhqVVyDmxYmBaCybyjGZ3+K0Lny7tsPBdvx6y5s1W?=
 =?us-ascii?Q?qxKOpMZ5N5+qXygdblFWvCLr0tHJtkPbJWj9I64mxNjqqlbE0/0vXjpQHOuA?=
 =?us-ascii?Q?iwhKQNR/ZNaj09JpcAmtz1PM/I9/2lMo6nZsrtlgzYfSMLCfOIFYacOpZ+X8?=
 =?us-ascii?Q?clftuPNCu6lRMqkFJw+nLn69DZiVfZoLq91duC3ksQEt8XQ+L3VON6BOZoMJ?=
 =?us-ascii?Q?YGmeW5EPkRXn7RDz8xYUMFKswKUlk6BtqmlqjgEVmemYwQ17O1WRDMoMZ+go?=
 =?us-ascii?Q?HJYrFAQqYy/gdMnsLCkdxNSaGvjMgLll2Dld+gzniEPtevxHT7zlQp44TNTu?=
 =?us-ascii?Q?06G7MFZaCi1/WI04h25lZr6jdbpoXqh9yjXzrtribtcTQ8LCQlsfLKadocB7?=
 =?us-ascii?Q?5EGmrRwWuQw5mVlZYIVW80jRUewoat/WxPbL1jUgZ7em5nCRit52TjojGmtR?=
 =?us-ascii?Q?BFmf9sTby2teQdceDO5ePw6aKw+aRU+UGhfxNSkrl1KI1k/C5aVVbLjOpcX0?=
 =?us-ascii?Q?cez5XGIj5bWfoxFmEU4hCSioO1oAFJHQPRLAcrR3WiG0VtOwfcWop1/f8ZC8?=
 =?us-ascii?Q?J5SzvlRoO8Q0nXw9DmOGjtX+ZhHj+WnhW6nnZYH8PkMwoXqp8C9BvhOIwsY9?=
 =?us-ascii?Q?yRqwDSZLZn8eZsggpZmqIYzOtHZnoXhleUCUq26tfpSYYLmdniXcisokEFTr?=
 =?us-ascii?Q?9qeNU/FdlyzR86KADRcYz8PA7YIYv3WVQ4DJYc/dBrli+9jReqK7HjOi8HQr?=
 =?us-ascii?Q?VTeHkTSQ/jwj9yIqPqVAJLoNBxrZxVMm5pt205XH2AXcxRhe0coAoExUwnJG?=
 =?us-ascii?Q?D5oDlfAYSRmHgH/ksQulQjElaGCjsOUXFcLRaCNBfXhiNe3Wd+eZTKFCxhty?=
 =?us-ascii?Q?+c6h5jMfIbWLn1UUyaLuuHf7VVkaycOQo0cfuXp4IUtSISfDRfX3o6Y1ohZn?=
 =?us-ascii?Q?YrCcgsHwimbdfqQjy8Yib2eu5aDEPhGj5ZNFBURvslIrMOKwUQAnewsSfepi?=
 =?us-ascii?Q?o6mqtzRM+LcuGm7mtzn7qBWt7CZxS8QQSiq6/7Pl/RvhM2Ytrdc+GQTutTxN?=
 =?us-ascii?Q?Q5EV6BVltNRib+mzenu4OKOZyZ9Jf2HfLCMcRFqkexqNiCNhPnpEitCgCaml?=
 =?us-ascii?Q?H5hoirMRdoNpqx5iCs5yTdKqii/5/DybpsxNH2XmdgS39qtPFWGjd7XB72YX?=
 =?us-ascii?Q?4jp9aGQqYf3mTw/5s5PyWu49Ga82XDdjIWkIAo/ksF1LUtoENUWP3wLJJBh3?=
 =?us-ascii?Q?GVELWNem3Q=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378dbfbf-dafa-4c24-427f-08de5e43ff52
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:27.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkAsy/z71OBT0Z22VQxmrMfm89Qb1HJiRcRKueIyJfzW/BUcPugKmf/uJBZ6tLC4i4rhqhKLWoK6KbIZ3C7f/w==
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

With pkcs11 support in mkeficapsule we can now accept URI
tokens and not only files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 tools/binman/etype/efi_capsule.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 9f06cc88e6e5..3b30c12ea514 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -125,10 +125,14 @@ class Entry_efi_capsule(Entry_section):
         private_key = ''
         public_key_cert = ''
         if self.auth:
-            if not os.path.isabs(self.private_key):
+            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
                 private_key =  tools.get_input_filename(self.private_key)
-            if not os.path.isabs(self.public_key_cert):
+            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
                 public_key_cert = tools.get_input_filename(self.public_key_cert)
+            if 'pkcs11:' in self.private_key:
+                private_key = self.private_key
+            if 'pkcs11:' in self.public_key_cert:
+                public_key_cert = self.public_key_cert
         data, payload, uniq = self.collect_contents_to_file(
             self._entries.values(), 'capsule_in')
         outfile = self._filename if self._filename else 'capsule.%s' % uniq
-- 
2.47.3


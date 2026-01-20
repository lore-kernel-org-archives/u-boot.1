Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56877D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9454683A7A;
	Tue, 20 Jan 2026 09:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="UybIjpWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B3F83B03; Tue, 20 Jan 2026 09:12:27 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BAB83A8F
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPGglnQwMEtLERjPC5ALMNeezaQDdHTt3/LzImA1hG7UOiOT3RkkioENSXYUEyiNflq6Gnxrhayu3rgXWdjpILgRXaAkQmY9TnLBYyJ4ZYEA4vzB8Z9gcPo4LCZhWCIWporRjHnk+zkDqg/SssJq2W0S5NirL3yJDAIEjgpxw/V9fDGwmCj6rrjjfy3D/Jx06O9PM7doi4opB7XbN/8H0VA59o7JH1oM1WVDGABH2uO8VuW8BiLjyTWKHhrgf1/EfMrqKKXZX45TRq4hPWxjvvswRQhayJggZj7zSJFVUQjA8JR1vA+4Shu2absQr8A2WQ3atn3SoIRHlBh6jIdsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=DtvL0vf13NlyHZwd91RjDWLKdl8CGWKzvSxN8N4dGe+2MWlxC/WlPgHVxGuT44qXr92KWtBD/6OLfRTWdDEQfvuqa7atwyLYhincTDDRp/HqGxa3x8a5NVpxetkzgYKlVE8IjGW7HojDeun0nW0buWMrEKlv2GFkF0iL1MMSZSn5Yq3++UaUAfauRK+zh5QrejNe5VyjRqpUXWSeSge8fPzqSOiO5Z3ottpCbGRzARI03FZbTsxScottUEA6WoKxkUY+KW1YQpIKfjIbr9x+zXnp/ihYA4GjEDYG+FquHDKMo2vna42wc/L+gUy2rYexzXFq5hB+1qH5CRwPfoI1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=UybIjpWXvDtAcTKHynQl5vnBnFL1nv0J+aEFo/bdIPPfyhkJWyFE0Su5duyCkykxL2KbCVqboF0BRxW3yMk8AlTSYXC4IyrUWy2Bi/LI5Wiuul8TGcX7x2hEljLfO+GNwnMpPSG7n7XDQWF54asydnsoF2voDZohIKO+0Q3Uimoz21xQrrSyjebfIP3fcpIwpwranS1JR5Jv+X+oVOnr9K2rHdI3lXcOhHcBmWvj5B2muuQjBfQzqcEQm0W6FweYbAvQtHWcQIT1VM6Ok3qJ4yEKBujFMjOjWjw+qkMEX8LZ0YSHw4dxqlgwXjk3o27fgkMMs/i4P/mzCajODCHUKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB6750.eurprd03.prod.outlook.com (2603:10a6:102:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 08:12:22 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:21 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 2/6] binman: Accept pkcs11 URI tokens for capsule updates
Date: Tue, 20 Jan 2026 09:11:59 +0100
Message-ID: <20260120081206.251544-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b75575f-c222-424f-3f30-08de57fb9ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OM+Ym4quJkQ8czeaYCzgxGHimho0BPnXty/RaAbnoJmUWBN6CxnC8CLUyq6N?=
 =?us-ascii?Q?bFPEi2vdSDZinQiJw9LzXsFUoCQKd/nruMYuEIhfkOlW3dNo3zMYFU2YKIu6?=
 =?us-ascii?Q?IY518zl+soep8kachT679b/NVAnlAkvaz+dXsURIGwVx/6sIjQ1gOR+Px6OX?=
 =?us-ascii?Q?PaAINF+ksUTEYSuQqXxLsHvYFAc5KUb/ojSiyPo8UvmjFjI31BpBEgHtaoIA?=
 =?us-ascii?Q?h54gGrruMSszZKshm6UTiNQnQl40wIRfIpWMKiF8MNWpYqPo9iA1GrZWTVny?=
 =?us-ascii?Q?cD2U6KF4fLb5Q5gIPzcTR/4sIy3s0TfhlfQdfV3FumexoECqSJGHJQhc/DFv?=
 =?us-ascii?Q?YePrnLQwhMb+vVLmVaJWZfiAXiOfWUR9fytgy/irw/exVUHUjzj0j91mgqYq?=
 =?us-ascii?Q?A3xevjia9WRiU6q7bwVQz+O547ekVauZPZ8NOPx5gUMJklcpCMDUErHlzwXj?=
 =?us-ascii?Q?n0wLR+smZvqKYaYJPnaVwgk85MtmayY5w+mFw4kRCZF+JsjFqdaiNhK9oY5L?=
 =?us-ascii?Q?qDVSquHP3VvWWf1H0OBQfg4vZ4OoewKtB947lZ5w9lOR2ZwGQGxDnMv75fse?=
 =?us-ascii?Q?X+iT4MvFAgSnwjq3jS+BasKtCYq9a5QW1Q8mZ8DcSjFHKZWMmvovc6P+QeNW?=
 =?us-ascii?Q?aPgfWGjNSW9m9sHg79s7lYQdviLEdCrLhYwZ1WsrQgpHH3L5RZuYvcf7fZJA?=
 =?us-ascii?Q?8vvrc6JfPCi+XOL00gdmWgP/utkz+mvxpaInKfDg2lJd/smGebSdhOpFRg8i?=
 =?us-ascii?Q?ic4vJYP4NwPfa0Xq99mnj+KqI6mBBK+eT7Pqgtd3h6ERcrjKcY+F7JE64qjX?=
 =?us-ascii?Q?KqwCzEObD6saipxe1TCpzY8nrsEGu2qAAb4Zt8xdTJjb+9L75igqOufywEsO?=
 =?us-ascii?Q?I0oHb323yXyS7a1WJk/P9t0kALedxbK3C/1ayzEJTxZzdEb1vjJ0Q472OYQ6?=
 =?us-ascii?Q?VK0D5Oz+wxZtXwlhur/6PNT192e602vJQHXr3HXDJpdRSr9zgJ30M2dQE5CW?=
 =?us-ascii?Q?ef5g6UDJfWbtj53iMt7nckfIr+A7xR4h+aqLwx2B/Jt3b5aCcMf4bSt/Z5dp?=
 =?us-ascii?Q?2MZw3Fr5AJUPVuxvicfvZA+w7N5KFT2HUFKL5pGWzKGwg/UnQ/VgdrUtttUY?=
 =?us-ascii?Q?TpiZqrABcMcvkaxkIbKvxXnmi0DB0FjRkGipOZviDfqvMDlSHQc5B2fakfji?=
 =?us-ascii?Q?YDhNz6598Fj9FfewokGKC7Z9EZCIluc0w+26k0on8Os/8KBWW0pddtqg+YeG?=
 =?us-ascii?Q?qS+4iEOfuLVYwTb8JVdFoOHmVNZgm44oY1c/LPj2qSe54VkFC3Cxcj+t7bDk?=
 =?us-ascii?Q?MxsPP1KA4SP8X8QumzaqsxLhT0kcemY2n/oMEfZA8kkhRWNHVuAzSbqdwVMH?=
 =?us-ascii?Q?Vy6MCZRUhvmNMngzvhe+pUKUxdyZ8ywL65iYE9/wNKVjzBAWDtlSJXq63/Y2?=
 =?us-ascii?Q?MXJsXnLrp0qsBGk0Yxj1XXKoeElCJXIYKwoxSuE9BT/+SbjwP2QRJoWNXhC2?=
 =?us-ascii?Q?5FlXuWKQqPayq5262wB7aM0/jkOzIQkVkzhBEc+why5fVCZ1lQHGZP1JrPVR?=
 =?us-ascii?Q?2gLSRYdD3pQDJj+J47ltIzaZxPAwtC2Ax6Mvu+tUOUbz22jfDm74/0J7u0mx?=
 =?us-ascii?Q?4wlSWc2oQbYDUuB41Lq9qgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXsf4mXjzvek1bvN4awYXWq8TBrBYFaOjK9NPavkvFvEq6jTTrSJqJVkI5sN?=
 =?us-ascii?Q?MLwjBVsQEI2aaN3aUd4pVT1eQk6RdAqdWsTMG9pkVHVimwjjg3vq6NFVdjYP?=
 =?us-ascii?Q?cmq9a4A16LKwMN6Uxna8QoWRtH/5l+MbPDAvDqYJwyeREdpNv4fJh91oS/3H?=
 =?us-ascii?Q?3anYB/uxNv3H3DkXoEtKbLy9DE+qxO44X33/YR8m8iO834elHyz3phUfu77Y?=
 =?us-ascii?Q?v+DeyjpTQi1u0d4KXuhoQdDCNS79SHV+5edQpaGa5yb3GwXNxgMiCJAqKQV2?=
 =?us-ascii?Q?U4oFzY9/CfzIw6QOUSxA7mKf6LQFrLZEctxPo5x6S6pU+oHw2diR6pPibLFt?=
 =?us-ascii?Q?4uXI6xHSIlR9BGsvRr6rpIed3TPHQKJBqtgsg83UB4u1J9p5bT8rGqo4iorE?=
 =?us-ascii?Q?YpvqOD1xYEWFt6pHf0leMXR/d2lFPia52j6sZHtku3fE7Hacp80behfQuGWx?=
 =?us-ascii?Q?8zIYZwf0Qv4pW2bNjv6DIzgs/5LZgjYbXGn4wlV5+lSqxS30E0JYa7P+3GZm?=
 =?us-ascii?Q?oEDx/OGjU1uxfV2IDhZ+E4aCnbzgccY+nHygrGj5LKA0HQ3QSft70q9fe0M3?=
 =?us-ascii?Q?rIAI5qm58UWWfe2RUu1WoYM2NjsRQV4Ou1qyoOdnzjdXbKgx6wfPlvsw1C/h?=
 =?us-ascii?Q?NLnGOFumocwVINs6LdR24V/QPCLSGldq8EseBCNNkKJAWSLgOiroEq4RuqKR?=
 =?us-ascii?Q?hl8213zXFGW7vtH5qwIxqaUE9qOwp5O5JPfS4rkRDaGJHkMiNBTLragqre9p?=
 =?us-ascii?Q?2kTT01d7QVU6y1LxQF8afNt4Rv9mSyC9Jm9iwcLhrpS6dkA/4Iz1tvoVq7CA?=
 =?us-ascii?Q?dGkHk5mSxYLWIAfLTq2Yh2/Og7yJhpstgS6M++RVAKQXUMGhwi0Nu7VwQiuu?=
 =?us-ascii?Q?ZWNjU83TFSejR10a+LLgDetwvqykC1AfO16QMMCNHkbPFG9qx8wnRsJLDXVi?=
 =?us-ascii?Q?MAvkNhtScQdZPfjMzEFJtBhCux+LoKMQPbeUBVQOrhtLwVbEMm/3zo+XEpml?=
 =?us-ascii?Q?Acx+OX+h43508WstwcRtp2EjQ1zxZYrnpURyjDzpnEPWxHfXU1OS/4XjSRTu?=
 =?us-ascii?Q?KK7kAOefGonEfcmLii3sW0BcO1/dbo2RSNplkGe42rms3ZDuP3lfrhdyGYOA?=
 =?us-ascii?Q?Nwe9V0h218s1E5PTrkZ4ROYI1iEvZ1GIfZQj5QxOOtp7wBGGAF/J22o8W4Ok?=
 =?us-ascii?Q?sAbOH0nHftLj91zWZJUuMEfEPz0DRTdqgCzsJ7IS6emA96BgPEGH5VVXWscK?=
 =?us-ascii?Q?55sk4hfBncfFGWS0Z5zXJz2EncfVEsqB9pq4tESYvaR+eVo907bO5JaZy3JP?=
 =?us-ascii?Q?X2zE+hJbyvLW0EQTR6R6wqteHZs4d9s6oJPh1IvMWWP5HA4Cq+RqCbc6oW0o?=
 =?us-ascii?Q?cWYxrCmhGutVieHLguVYrLz9BVz0Hc8RzYziCeWbfSbSW8vwX8/zhpLpZ5tp?=
 =?us-ascii?Q?osH37uqO6zcPPuBAOlfPxo16TXBoqZE2zgjx6eI7wyGf3i9p8VF/2hqHbEDk?=
 =?us-ascii?Q?PAQ3GecN8t1guWOB5ldZHXIIpsMx0FeYwCPppmhrFUAlMy023378fykSbVE1?=
 =?us-ascii?Q?8njRS/FeyNLNDpOij1+hSfu3BgcAr0vSNmWZMJrYNAxaj6gQ9NmjN8+gLaFJ?=
 =?us-ascii?Q?BXbKR6Tw6JFiiQA3Me/FyUj0P0Z5ft7pQruxGpY6RVVYRRvlGJbjEP5XMjC6?=
 =?us-ascii?Q?M99v2plC2DSe5QAq5uM7UAGfns13AxqLEDh6QdjmPLDWvHr2ipuCmwdIoYNh?=
 =?us-ascii?Q?UpWe6st12g=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b75575f-c222-424f-3f30-08de57fb9ce1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:11.4943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9H/c0tQ+VgzGcP/BJ+0BB7eRj8zwS9SqMPDVTlY+u2B3zWcrBUmKIgCWTgmYwBrsjHD7EgP0Jvw48/sPV1OWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6750
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


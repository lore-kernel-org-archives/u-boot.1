Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB38C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41BA82A76;
	Tue,  6 May 2025 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GnLhHVEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B8D82A76; Tue,  6 May 2025 16:15:22 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D771982A0D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCKtNwPkia50gbXjtCNfGXc9wqO+m+9rlsctA9VwqE2rWNhLiO5YII4dxUmzOM/WPASLJ879G8pK/ao+dI0b8ZpD63LvLNguyHImTZqx+HIF733HIsZPUvuZNl60Ll2ti+Mm0dnBRv3FKRJ2tnIbY161eWSK1zdKJn+OElJOlWPPX57RV3wTvMpxx/Uj3aUtcMKXzh5umWDeFpKb1sWUm5IiblW6jR0rXEzI/zOUwYB6OmR7KzG6lIk1PFbTMss6ocpA2xTw8KVdfgSBRKHOEJXudLkKnZ1VvYcBfy4aWHjeSu3/pEjUYjQwJ0+NyVKEGQyCJwdDwyowoGY3lf/AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwRSHFluN1WvN7q8S6JobgZuagE3i5pSFC9KrIOjwy8=;
 b=vV2YWEcfEV6bWNkuMAUYL/rGn85oLd8GFokj7fvVz9xW2gVl88KSZ9uSsddKA0ujXGVCYZCsCzOKSkLpTISv8b48gAO9ZmEqUha+cTDgzs1V8abqAC5ZDUb3Md/43DRqFqKafs4KWHcdVLlmfK1rNbgZdJc9eR3NNE+acDHbNSZO8VUV84ZByijTgp4VYQTF5nUCD/eOMhPRhPH/Vz8+vEN7m4mdP/UdWBlo7TJlGePtuKl6QJk4wTglRMXADYI676jrHTzUSara97SH+ZzQ7DVo/PxZF/C4zhS0n5ZtuZq6F2lcq7v2bxDIvQWIoPwc0jwvUrmvsqJbektFAlUoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwRSHFluN1WvN7q8S6JobgZuagE3i5pSFC9KrIOjwy8=;
 b=GnLhHVEZHGOe3VcOwFYAG94ikgnSlh/pIm0eOx/Cz+4bUsfH6ZnwtFkwfU0PhSuWCgpxTHdVNx6QHHhNaICLV6KLIqIbc9dnO9uuhJvbPxc4HB0StA06qFT8AwRDfWLKqAldIs+y6g8f/gtdGevFjR6ga/NfP1ovJqGRj2hYn3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by VI1PR10MB8208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:15:15 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 02/11] slre: add myself as maintainer
Date: Tue,  6 May 2025 16:10:26 +0200
Message-ID: <20250506141035.385756-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::13) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|VI1PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c83e515-b3e4-416d-0836-08dd8ca86bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5cZl+eK8VSBVencA3Luqr8W6zIY/EEAkVLX1pzyg/xP0NvOVbigTcmgDmvdZ?=
 =?us-ascii?Q?xlJwz8+eQxKT4kvkxq8D+iACI/sxg2hDEj5sPv0O2pxWT7CsnZE54I4UCo0Y?=
 =?us-ascii?Q?8rjZDnl9Bc74Qr0zX6d3c4bVsUVJCbkuw9W4efnLd9AMAawqNNwrU2CzANR7?=
 =?us-ascii?Q?etQv/5sRpuBEgypdSV+h18zukEf/hoCIj8i0fQsIkrloSeqqV7bR4zvwv7ia?=
 =?us-ascii?Q?eW0HYklHYwU+IkxsFWQBVBHLA96eaDWeiZDQuDFC8YFxXJZ6zeHdA9sX1Zg9?=
 =?us-ascii?Q?lO54b0y20q44b37L6NHNBM7g+LbZScAOYwaS3cy6WNcaUDvoZg5CulgELm4O?=
 =?us-ascii?Q?r3fDVzJ3Dr97qyvyz/qaACzq9twWL42ib+3XKyX3iGvbb67DRxlTI5QZkzG3?=
 =?us-ascii?Q?wGfAVohKPo89rIccasePjsXYdbAAJKyQlxdxBZ1puF6VXd1XFHUc9WSES3wZ?=
 =?us-ascii?Q?TId4LXbKIR4GCdzIVmwRikWQFOUYYJkDFu62cSIo6MHlm3W+um0XswIodqtH?=
 =?us-ascii?Q?/vZGEhg4royWfEt8tzz9y4OyEZ6zV6B/fIUPn9h4nLfFJsmKunQQn0hF7Oem?=
 =?us-ascii?Q?ygCAYEAzyc3YxhhLVkOz9qqc4sYsWg8CVhjUz2HqgJPIx8xF4kxRpQuceX4I?=
 =?us-ascii?Q?TUR4UGYxQZyoI/BWPNULctD7zDh9Hh+3D+DBob8VsGo1foOqtK15h2Cf9nUr?=
 =?us-ascii?Q?6/qb5v2bgJiVu6DA7kwbj1lTQO9ZH9Z4Xu4jKRjhx4HmZBR7262WbML4koFb?=
 =?us-ascii?Q?0G+w413RcH8izY5HN9vwu/0769W2Tn/DLHPqT+OmOUfNDByAI7TEXRo+kke6?=
 =?us-ascii?Q?1vN0vRksiaKynC6lXtOKFAZ8gUVEFoJbjKNJuW+C1cOP5H+VylZ8e20I8/kV?=
 =?us-ascii?Q?fETkX5r52SORA1Gs23Ygatgo42k/1ilBksYENp5qOXFLe3xudhL8UocZkyar?=
 =?us-ascii?Q?J0Ok2azvlGc0XznGKB4i96hYMZNvtlfELY6v3YpbOhuSn/ClaSc26IoCZmZZ?=
 =?us-ascii?Q?zQn1UBXmFsMPA90fRspU8cGnWjfNIFs4jo2p1BJ+s1hHXoohIR4hFemIoVvy?=
 =?us-ascii?Q?cVn/16PmS8Mpo3OYnAFHBWYKjDKxR1TPUF7Skyu3/1uJ36xOK/8zj9KLLlUx?=
 =?us-ascii?Q?PY7qDwMgGmW/jdLC8kssPsW5oQ7fMNioA5hS3F6jJqRNw6f4RUU8mp8zAM8B?=
 =?us-ascii?Q?rBdOhoHwYNBJNdG0cjEPnmsIKLtb5PeIxwbY3jPDqdDz0HJdKb2nA/XMCSRm?=
 =?us-ascii?Q?aNO54qr42+ZvKsMJDOW7zfRPs8KqqSbv4ZOAH4jl/PaHt6XqQdSEHCPIEejU?=
 =?us-ascii?Q?w+R6tEHpZj7PDqDJLeC0Jkh/qCtJ8A8iqRoIgOUe4h/DbVCyEa3u3JBIYAV7?=
 =?us-ascii?Q?o5DU1gq8YCorA/FFzD1QJXSO8uhvXxVcSgdKXvAv8B7WmG9CdEuuQkAW/O0W?=
 =?us-ascii?Q?iAP7xn0xVSI+PUnKweC7jIQwXeh9s75DMVSOXbLJU/x5xsnsi2oBZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RnFuaDMXTWIEjCGpw+eL/4SXcqwRp+vxY6ktThQ2Jf52Po0IlbYfBE9UvRPA?=
 =?us-ascii?Q?MSS4DB9w9WnuoxdloJXBNvYC744u5M+y0YcNElC4OuSWQs5yWA9atcS0tuij?=
 =?us-ascii?Q?MZaRdazwXweLk1qVEO76UX+QFq+iRh0ttLX5DDVFQm7KsET4eYbGpIwHioCV?=
 =?us-ascii?Q?cyuPAHgSEh4HCqtqpiFFlbXTzgYsBu5mztTsovN2TKfTPaooZcPbVkZeHq6y?=
 =?us-ascii?Q?BDOBxhInNOBanghqlm9DVJ3f8iYa6oMGsLsdpwRTfSP5665+ScjoAe7hbtWn?=
 =?us-ascii?Q?DTE9pgyQcQfaU0omNPVUj1QLOf4b8LCmmEb3HiBfpn+5WZY3EFrq/6xuyINj?=
 =?us-ascii?Q?8RbaWax5bdmQ2visPkg+EkI9iP0OSg8IrRO/pz2pYdgcKRKGnPlDO/xe1Dql?=
 =?us-ascii?Q?DLJT+6F9ZJ66WR+Wb51NVo0vUtz+gDQM8doHecVP/c1T6j3eQWNrQZX5waUG?=
 =?us-ascii?Q?xgVpCn+NWMlfQ9jXGi3wed1hvWKSTgKJzKfka/cmKTdigTdrGFVpNEtfw6Kk?=
 =?us-ascii?Q?VBoz5FpAChCKVUrqfn5dawZurpFlgX7abvaYXXvqWCEq60aMSwAjRCxAKxH6?=
 =?us-ascii?Q?O1pHPxq2axZKcjdymr8yZYYd6XrbFAuUtlpydDaZ3673TTdVSx/GknIA8ay8?=
 =?us-ascii?Q?V7mgZ9nEpd3E3Zpx441jcRLBKid9uXGiMAb1ixBO7rQZuWksiCaCVE20IEkh?=
 =?us-ascii?Q?bDTp9UXo9Fuf8Lj1MK4Zhd6v631mWF4Rj3lErdX42DH6+0FUErcalXpWKCbC?=
 =?us-ascii?Q?6IeciX/3Vf2cGMoRNv/iwnYTlhOBUWXB+w5bB3UNzQPUZRespi9ymnPhcRuo?=
 =?us-ascii?Q?TjCt/ILON5CwUJ2sfxhqcx5mMXkA5T9h8e4lgP9uXy+8bOX/KOcYJeumOMp0?=
 =?us-ascii?Q?RGdiL4a5YtDLvitrEhlYQDN9cue3/yxgjXF0WezObn+EgWJ7+G/T8j6yP0Fg?=
 =?us-ascii?Q?W70JCXnXparKyPj/ugzVudBkUTjcsLlAwnCnQo1bFu9AqNiapl01sHhKqqB3?=
 =?us-ascii?Q?t2GtkY8AazxgLA4Y00cD0KGIzqfs6AV0EIs5gnKwFH1d8ugjIXYRCBISRMwr?=
 =?us-ascii?Q?OqtuGQPq0MXa3ufyhbW824L9XajOvFSkzMjtnFJCowkqnUKTEE5EJjo8MYh+?=
 =?us-ascii?Q?MxT4vfXr062Wb8XKuN5+82ZeL859HO3A13R5FAbE7kTq2xaAZWyJWWV3Oox9?=
 =?us-ascii?Q?skUN8gBh4zwFXf9N8HNLmK9uVwkA1jSf+rhVg7nM+MwYGgAhV//pKboFrJ0B?=
 =?us-ascii?Q?fOr/nWyYV3x6Jwv4xvPlGPaGW67XDsAf5H6GteET4kTY2hTRh8DKHNuLerVi?=
 =?us-ascii?Q?KH9wM1cvla9VuufkPrOOT9lPI2xhcSGIOyjQ7ZmRwoBS425/C/kSDG2Lslxj?=
 =?us-ascii?Q?lkX8eL3DdR7raqJx7vs5fDDDVFkd469+q5YS3tW4WDu1aS8/P+d545ymqW0f?=
 =?us-ascii?Q?Yzn4+XI4MquDFtqg22LAzUtvFAsm5TsCGqq6Rf0AI6FXxk14If1938tn912M?=
 =?us-ascii?Q?coIzSxPTqTdqgBkEtyCFSArPncceAa1J3pvxasYOMAAI4J1NQbmCWs4BbhQh?=
 =?us-ascii?Q?U0NoTHfjA37DD7lrHKigqC4vuxaUVe33G7AFAK0hP624iSUqrcxPAKmJWGNl?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c83e515-b3e4-416d-0836-08dd8ca86bfe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:15.1918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A69tgdcpSxU2Lofee/ACPQk5DUZZp1EuM4HGIqVcDhp1MahFrPUp1WO/fHmTcZfV7Ky3KpNCmJJHcyJCR/0GAH4vHtXjzOZDwgWc0DXGO6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8208
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

I guess that touching these files means "tag, you're it". That's fine
with me.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..94c62daf834 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1628,6 +1628,12 @@ F:	drivers/gpio/sl28cpld-gpio.c
 F:	drivers/misc/sl28cpld.c
 F:	drivers/watchdog/sl28cpld-wdt.c
 
+SLRE
+M:	Rasmus Villemoes <ravi@prevas.dk>
+S:	Maintained
+F:	include/slre.h
+F:	lib/slre.c
+
 SMCCC TRNG
 M:	Etienne Carriere <etienne.carriere@linaro.org>
 S:	Maintained
-- 
2.49.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F083C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805C18059D;
	Wed,  7 May 2025 12:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="O1Q2PZ9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23F18059D; Wed,  7 May 2025 12:58:56 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25E9820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prtvYK7JhrMF+VL0P01fzRyBsLgleGzJ+nA+jy3QvJI5SHaFrxapm0YIxXZA7/JDc16jyn7Qovw9i67NYykOZTzfHImiZEtxoauTrg1vLefF/YLIaA8yUc4yIhVAGd/mv2NWgS5eC2uiKf60/Sepbl3HCQ1e2+gsncTirvYahn+y/+jGkL7FYx9iJ5zgWPwa75A401Q+DtR89yifveAm9Nr91N8bhzLIN4kI0FrgueWPKyqVEK7ki670ctcpiB9oJ/qh8z6fT3KJEw6YDLsXTy57dMNPWAbociBSYSL6wKsZAQKaUFQ/VYAM8uegKrJPITS3D2wTT0k51+n3z/E2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxNfStj7Y3iQbQzCZxpZD1uO2g8CoSHAsrJs73pnBw4=;
 b=OxQZWe0iCD8pb54vIpgucdVkXn0YMk2bc3uXN+v2qHPlaCHendE4Aajij34E3A0Nv9K0VGQbbdlefr+Q3GqAd97UcRGtEALFqlp/sKgCSkgWcx5Uj0N/iApsRMKdMVpqqYtvb6UIbpSPMV8MujpEAbn6F0Z3KgHdeWEnYXyRzaC2qIiFoYQmqVP9vQy/mwgKRdpRYy6Mpv9jIu7AL9WAG/ESgC9mrYUktiEn/EYf+UuoaXseVQY49tB3pK3o7T2GTHnudt7Q7jrwoXTpYjzG/F+e3LNBp7cE6kWnV1J1oAZQcObDRrk5hTEWqLAzXDNlpZv9Vqxuj0mnzNYZtyNPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxNfStj7Y3iQbQzCZxpZD1uO2g8CoSHAsrJs73pnBw4=;
 b=O1Q2PZ9QHZOigCD9OLxe1l/+mPxujZKMuYNIxwmxA7NRN0vG+bLV7ZeGt/5IXGmzLWLJjI6GTD9ZX3h+K1XupLSjDbLm/g/DwNLpLAECbMMESKGOKY0sgMu4ukHfsuQXJShgcm2x5PdipWmrswZ+Xkj+T2afPw1Z0knnqMUvZUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 10:58:51 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 10:58:50 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] cyclic: make cyclic_register safe to call on
 already-registered info
Date: Wed,  7 May 2025 12:58:20 +0200
Message-ID: <20250507105821.484442-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507105821.484442-1-ravi@prevas.dk>
References: <20250507105821.484442-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: c96bb9f1-3326-4fa8-74e6-08dd8d562665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C6adGbaYkLy/laf9XrR/Fy7MEm1W9jSq70ayw/xgONTMBJ//Tb4Elx/259qH?=
 =?us-ascii?Q?q8DYaQIodXolejrOxieGjhElRaxlaMx0Dfl2OKRn1nbZ9zMLSZnPPtym4M3H?=
 =?us-ascii?Q?meAbJcodWgQf/xiT/K9jTUdORF3XyB39l0e0zqsl98FJ0hOuKJrjnspCn+3y?=
 =?us-ascii?Q?dF0jgI6+2XVK8FT2KIjuPJc8UB9PQhooupe6wXZdRQbH6gDGZ0PCvgsG2Fzd?=
 =?us-ascii?Q?2EFfz6aS95JwI9HwKIQUIfxUzRrxWIbtGOVjQ/IuqIqWmkffOWZKjANIkI14?=
 =?us-ascii?Q?25gMfesQDpuPWvgpp4aMu6duSCzsNnTbpJfOi2baDWOYwbTR7D27SPugp+f4?=
 =?us-ascii?Q?OHuQ4Pz+XM7VrPyfwmZt+o6l3ZwOGVW+HV8OeKzxm19I//0XisXZZTkXrdwj?=
 =?us-ascii?Q?ZRJ55pZijLv/Y71PwGTiu83leYdG3tUKGbQKA5l9WM8oWHMuYDa1VQ/KsSxu?=
 =?us-ascii?Q?shX6zwsJu5S7ZpGB2DB6DgRpP4G4Y0ycejJcPOmMlound315IsiDUMja0eVm?=
 =?us-ascii?Q?w/xe1yFWSys0JlFZEZyZ0o5kABtlS43ZzeMqefgwsjqnXOyze0AA5jH7ZPTf?=
 =?us-ascii?Q?5FsTnJJZ2XAuzkFWl9dKSqIgAjKZOSYxYz8Bjuhk6hdhq7HdqZR9nzoR0g5R?=
 =?us-ascii?Q?7PkfG1yqanzpZwM7ve8mm44EumpEC76evZ0H8eM33NvbEqOEzk4JYCb1RuUh?=
 =?us-ascii?Q?w7xQhfw49nn876ppPIK/ZBWpHF01n04V3o1oMnHs6U68kluZV1/cdeaXes48?=
 =?us-ascii?Q?oLpNr36jLmsw8+52sZQ1NYynilGFGbO9v52MAipWi2h5JgSPMtZmY1DikteZ?=
 =?us-ascii?Q?UTHTaoloKqemqCTBkxk8IImLnW1ykIqL7C6ZXbIDzJoharMWIQMcD68hKRvQ?=
 =?us-ascii?Q?6lGs/0Mspxd5XvEu+oehxigwqeEHqUxAylzvCfs9lrvtH/zWzQjrS7ZHNvFL?=
 =?us-ascii?Q?gh3o1B3RfqXoiNIMhtWpWL6bSZDUseXVR8vRAz7q3IK8yFpP39X4/qXIvNRN?=
 =?us-ascii?Q?miHnG8wpbIZM3T90NOxXpzXH4G2py+EpD0sRPkYr0KIXSKXitDfMMiucr2aP?=
 =?us-ascii?Q?aLs5zi7gaHkeH4gGo3nPcI8yxZt16SWfaldp39jk2ObpIkge5sc7WXlIxhj3?=
 =?us-ascii?Q?0wMN0RvM/cGZzidx498akiwrAAryZOdmrSIhY5zjfF7CVuji9Te7CEX8BX6O?=
 =?us-ascii?Q?ywtAjJ3zImDNdksQLBTY9ByvhevxHzh4DytSHkRyEGPosGXePX2V1i3iAahS?=
 =?us-ascii?Q?wjZ/Qq0nEhKrS3jI9WNr/b2+88Mko+43i2t5L3cG5Pb/65pv1/ZSUadneZRc?=
 =?us-ascii?Q?zlz1zA7DQFTg9HDIYnG0Cc4xjltmoPfTbTiR5YwNRCxB2Qjs+QkPaKcbvqnN?=
 =?us-ascii?Q?9ZMwOoJoxIY5TQcvUVNmgCisBFa1Mcajv1e2PPMU5LGpGID0oXmWB7a8TJjJ?=
 =?us-ascii?Q?Mu5rR0QCE7Vz3fRVvPOahli7EYgGh9g4zYdPhSrclBUnxyNv9rAFitYo1Ltl?=
 =?us-ascii?Q?P65r6seALXCDAG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YqL7OgwHuqEPQ3RfUtRtIC8Lg//jWa0HGpSiBDpsPfHc+EWqVPVcGcpUhCJt?=
 =?us-ascii?Q?SvT4j3n0uOaU6+8xl/TIoviGfPqrfSxP0w83wa0FrknvOJnSpvQr2iV6B6Wt?=
 =?us-ascii?Q?W4rljavt0Aq4QaYjKD6xKP7hiOo5U7oENQdgHRVMQZ+YsNnZJ8BjhYiYH03G?=
 =?us-ascii?Q?nJR4pxX7qUKZTNb0boLQYKD+wU3wVHR+7/AeMVNse8pv8pjb5fNpcTMOT+3k?=
 =?us-ascii?Q?R0N83XGsW6gWLprw164xcoprDms2s6dKa/5ghZvpm+MGRJGYlChTX1m8hAOF?=
 =?us-ascii?Q?GBaoQ/H18NGmcjgE864834hinqCt/L3poTdi+LWChRZnIgVm+tSnN88oLXww?=
 =?us-ascii?Q?gwn+2BGV+/+hW35Urf1BB3PufIcDV+YmllDCaMklAWU0FAoiOGKcM2U1hcdn?=
 =?us-ascii?Q?gO0bAa0Pt+/klRfMyuNH6m4vnnTEnoGJ48N3127y3V7syynLjWhy0297VxB2?=
 =?us-ascii?Q?qLLKZ5N684XzlJFErP9eJtun/8IDdfGLbwEJTsdNu2Uz9bnbL2IeDWz0QIlF?=
 =?us-ascii?Q?ZSSfLl5a+GjoBIOtgMR8jpKbCUvIwtxwYlwScxvxAgB2sdjd2g2VP/GPeVK2?=
 =?us-ascii?Q?xewme3Ycj+v465h5/0gtMykw3ibb8s0kYe4dfzQDoE8VWo/GmPW+He5Hhywf?=
 =?us-ascii?Q?6rZVdATohfpQJ+QeLRR7h3B2PjL/k+7YCASIwunsPqHYtXinxIvpaiePi+gf?=
 =?us-ascii?Q?VMjjgtLrEWM4tmmhOH8F1h0bUxBTmV7DNgzNXTmg+Bh8MeQSaBmUNtL70C14?=
 =?us-ascii?Q?AM/jEBfVcdc/7f+lcKSHLLz4i4arYlUBUa8UjGIR4y4xje4BSDwoXLDlrGyQ?=
 =?us-ascii?Q?dyhdRc3pu3KdmhEjstbAtDWv4bYKBrn2JeY/X7uuzdeUt2bZP/huTSz1lMMh?=
 =?us-ascii?Q?i32EnUw9IhP6qmZq643gLCzNL8irlAe/t8G3mh7k/pnLNYBCaJ3kNWxVkKJ/?=
 =?us-ascii?Q?STeKmnaNAL+Uo70BqeWJlof0U5H44OEgfGF2iG1DoHoBWJxyVC9YNUKSD9KT?=
 =?us-ascii?Q?WXBKH2EfZjqKvSnFP+QXoEgISfGCkN+putApQNi8yz8P4oIfZ5Fx7Hg/T689?=
 =?us-ascii?Q?B7irTb4lE6DqEDHtLv6xvLZM+lGdVi+ZLhwDP3Q5mYjftqfDQJgDKXrguiOJ?=
 =?us-ascii?Q?Cxpv4sPUhJ8j4wkjO+wfmvll/U02x2mnLtTxqbAunnl8i56AZy65DeRP9y9/?=
 =?us-ascii?Q?XFloPlSsMI0sxYZESugjLO3UNv4otDaoPLwD303Dg+GQJvMJ0Hvusi4JGDY6?=
 =?us-ascii?Q?4GuH5AWe9UaJi/yNbrBnL/SigMVJdhjq6jQMAyTKE7pq+zVUUign3atxDcPK?=
 =?us-ascii?Q?G712CXvx4kcvp6skKzxMeqNmZipvPpCMGGcTTAem3IJ91di3u/X9CsJRRXBD?=
 =?us-ascii?Q?9m0eoERHN25ZQH+uZMYfd7KRqGYIOAPgOFICScBKKwqHwykO7YXnoNVBPk9n?=
 =?us-ascii?Q?ACkV3uOCsDFPMpvR6bVjvWZzbVrd4S5YuE9J5FPN1dbzzuv8++T0CsI/D0F9?=
 =?us-ascii?Q?Pj6zeI6VQ1dZKpoV11cBzAfDQVtsXBHVsBZNKvcK7dBrNG26SZaSRT0lTn18?=
 =?us-ascii?Q?2Tb4hTAn9uibpOHPqWQw1SZCoahbdVeVe+yQ0T3zASKMJhqVmgw02ksZ9Qr2?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c96bb9f1-3326-4fa8-74e6-08dd8d562665
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:58:50.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MKK9Zs5xpw7rDdYpwPd6KWFcy0/s3DpVfMrwS8/5smkbADGm9uK9jYKpFGbhHJxDtvAVOJl6KTBvUYhv6a1ha3pER6wIURG/2NzURVbpAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8807
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

Now that cyclic_unregister() is safe to call on a not-registered
cyclic_info, we can make cyclic_register() behave like the mod_timer()
and hrtimer_start() APIs in linux, in that they don't distinguish
between whether the timer was already enabled or not; from the point
of the call it is, with whatever timeout/period is set in that most
recent call.

This avoids users of the cyclic API from separately keeping track of
whether their callback is already registered or not, and even if they
know it is, can be used for changing the period (and/or the callback
function) without first doing unregister().

See also this recent'ish message from kernel maintainer Thomas
Gleixner on that API design for timer frameworks:

  https://lore.kernel.org/lkml/87ikn6sibi.ffs@tglx/

  First of all the question is whether add() and mod() are really
  valuable distinctions. I'm not convinced at all. Back then, when we
  introduced hrtimers, we came to the conclusion that hrtimer_start()
  is sufficient.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/cyclic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index 75662d9f613..ec952a01ee1 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -43,6 +43,8 @@ static bool cyclic_is_registered(const struct cyclic_info *cyclic)
 void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
 		     uint64_t delay_us, const char *name)
 {
+	cyclic_unregister(cyclic);
+
 	memset(cyclic, 0, sizeof(*cyclic));
 
 	/* Store values in struct */
-- 
2.49.0


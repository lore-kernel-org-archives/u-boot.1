Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E48C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26D180C83;
	Tue, 13 May 2025 10:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MHSS5Zas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8716B82AA8; Tue, 13 May 2025 10:40:50 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C65B8091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IH9p5hk2a3cCy203YhyGwE3fnDew2JJ0F9fLTrIoruSBbAuY2mEzm0lVBj63/Laf4VINk2SbaK8LdlC2thrgZK2mY3/rLLTZeE6Cwk0baHCEM2EPAPeFQV8PMobq66f0pcQ1YR5YTw+DV95Gk5fX5AIKhhQoCRUohXfB41/C4gtBqaXRrTXp47FNb2BXqGYmu1Q/QJZzS3AcmRUylipa/0Xi5veKrmYYkT3fIsPAwP/0b2QtqySLyTmaVKUic5i6hJizabxQxIml0BYwhgUxdgG5lt3+jt1aHs+z3YwQHNISr0pXjDxlqsfZ9RMvyiRsk/5LOSf+pkDxCRhPgYj7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvEVEKehv4QI7Qcn0yCqW3hNCXle6TaRnRIwgjrXn5Y=;
 b=upfbzWFX4hkl9d1YxTiesm5A7nuJzvvioTqTKMMj+ZbTZfOjJfODCcZXsmGaBWEl9eglbSpYHH4JSf6OV3fQzgv1s98pE+b4tWF7Hax6efVTmWq7p0EtNNTzANlPIUPMkx1pugx/mX2rhBCbdeahm6QV2zV3AIk1vXGwefY0XYoBSwJOQh0xww79eHkxYP913XLP9WE/E8KC6aOZwCJcXziq1+dZdHxug59tiIfmy32lAu/iNsoaDa8QEHAELscDL/JZ63XOwncXfwmxKSJlWQuezTf5GCpxa++qMGq80pT/bZSyashnLepru7O/4JmOSbppp23wFpBzHPTPNGsQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvEVEKehv4QI7Qcn0yCqW3hNCXle6TaRnRIwgjrXn5Y=;
 b=MHSS5ZasvIuT0QnTgkuntfa7e2jF4f9Zbg2TWDUES1j8Kch6wNUBXKqrvb9nBJlragoguaXjUR27n3t05UkHhBUPHVCTzkGwNxHO2hBqbyKoHgQUYXFSTYGPoRz0QajK8yYaclOPWyKfQiAW/Aw6LMWZWXfeRbsdmVwk6rKJrPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:45 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:45 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 06/12] test: slre: add some (negative) character class tests
Date: Tue, 13 May 2025 10:40:28 +0200
Message-ID: <20250513084034.654865-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ed02d1-bf82-4ef8-3d88-08dd91f9da40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XTLt5d80YeAPm8MbjyleRQn6mHKCT6zFYG5vJA4K7SRaXDXqKf0h+6JylBLV?=
 =?us-ascii?Q?5cxDAIe+8f8+1WmEU5uy59fFpURita1SVy/mzFn0qclMNpvZm5qCq3HJwcE9?=
 =?us-ascii?Q?K6btQmIbB4cDjv27GfHS2nyztrr/rx65poXfpzELWqucfOvpxb3jVr995uOx?=
 =?us-ascii?Q?Vy/5eLdmiROePYH93eN46CCgHPesEo+qrmHIvuuFnuyGanhMV8XyWoRNTqpq?=
 =?us-ascii?Q?wZHRL1ABhStW7PgH02vZNOrbpUk2aLHlfeEhoO7nV3svNxoXzVbiADpEuwHe?=
 =?us-ascii?Q?Z1xMDbdGx4nUPYQabvOdEQ6Q9DDaYQAsXkC+U8voKf89zAuZsTZaAXe57DfP?=
 =?us-ascii?Q?a/jbiXYMk4yBU1wHug3BQb8WVJsn5bI2+Molis6IgUOhP+sg2Wz9j4XSA2g0?=
 =?us-ascii?Q?3FkgCzgEtY1CTGypAzkHDVyJAvSTWwGhwiZTIkXIB7UvidDQ8S/4qlhbR6Nm?=
 =?us-ascii?Q?f3+74wS0Uptn0/y+SPcfl0EJ1dcbwE2+YiZd2SA8qsAnNGbEpy5nbbzlpMfR?=
 =?us-ascii?Q?Oi7dU0ynPkUVdLInlkpOLN6Y/IV7hU7cdBHHLomd6ROouez/HEXQ4XrK+QGx?=
 =?us-ascii?Q?a+BOBp3oMJrrzD+Uo/bpQyYq855KdeWW6cus1eNABshBe5g5mg63kewEjZsR?=
 =?us-ascii?Q?HEPZ4eJx+WAxw3kMoP9I2WxgH3CO+moF8Vk9qsKV5bI0mLoaZDFfA1Z0VBul?=
 =?us-ascii?Q?8s2kL4/aZm8MDjBMoLvMHki7UBTOOKBayghu2fPtNJBgF/O5FaGou8I10CuN?=
 =?us-ascii?Q?ZuriHdudhVdH3B8bdzpH3TqpgyaqU8V7VFw0tNoizgfuUzmIV94yA9n6nHbH?=
 =?us-ascii?Q?zm6brkoiBkpPZIGMFvYSXQh0m5xH07NSIhsoACoXb5JfkSwaR2k2roqJ/bc9?=
 =?us-ascii?Q?1cqCIVCU2aw4Efkh1HO36z/k6w3Ds/7XX9CI823oNZ7B+bgM9zhkX3MJ/PH1?=
 =?us-ascii?Q?/c8OzmAeoRMts49aCJz8mfBU7fT4kXg7JtVu4BdXArmFjokcmvcoi31hc11T?=
 =?us-ascii?Q?JmdAJAziYEKlU24G3P7vhqNdWizrORaotTNEnYJe9EzSaRj35QsKDZgKbFMc?=
 =?us-ascii?Q?U6eEb+be9BBPdf7AeuZ8Gdg12gyXBImUwUKe6y96KsMRkcH6wJIaW3gsqKHG?=
 =?us-ascii?Q?ABt/2W5BTsonns/BQzoz6OV+h878nBfpILjNL1GBcGgj2G+00mixvt0LP8G1?=
 =?us-ascii?Q?DnFIAywlZ+Q8nw7FAasQqaKPXqa5uz47XCEZX0pTFSUg/euKFa9MEsmExGIn?=
 =?us-ascii?Q?CfI4+8AeVEy/YgkkpOHquEJZwb98FeH+0gLnTLcZK+8RGMPOTI4wP1Vymg6S?=
 =?us-ascii?Q?UOBOCMiSce/QVH4NfMPfLcZlT6QDwGywyH89jFi+b/ANToeMcDcrztqTeDeX?=
 =?us-ascii?Q?jK4o9DtTKoXegImVa6SlZV7xC2QgVeY9jNBMc+YcGjYcu7CDA12Rsm50tFHN?=
 =?us-ascii?Q?BIXgJQOt+PANJQCwX2xegxlbrT/aJZIKXHR6pjoa1LmvUVyWXp+jOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdxUBDwUurPsCcmbr/qj+g3DWNuKSx4l08I6Uisy1N/5kuRXuAfUmLFnkdE+?=
 =?us-ascii?Q?AmWD4ttFV2xCzn2CKUjvxk6WWHpi98LuAn9mtXq6MIaaIzeokZZt590hjKxz?=
 =?us-ascii?Q?yirGO94neLqIF5BMaLBOUH4XO178Rm1pdvDQha1AgpTyMbTIszyGIme8Q5z5?=
 =?us-ascii?Q?sPQSR6L2bSoOu7mRhOZIZwITST6vXOl8VLSH2EZ86LMvgiMju4Tkc7EsxBS0?=
 =?us-ascii?Q?WC3uCtHTmb0tv4nStYBw0yCGp7v17iX/NsvLTwuFFV72PDYMMuYqWuTnrKNj?=
 =?us-ascii?Q?jHVoEzC/zIa3Dqqz1GWVa/iLaEasFs7R+aOvmRhJgxA/wZ4XujghEqpJ18Kl?=
 =?us-ascii?Q?596cn+qnAPqc4XojZx5rR3YpT3Tids8pqhLYsHAqWmNDfY8Ymvj1Z9vflayJ?=
 =?us-ascii?Q?AngQfUWGsc6eBLuyiUnSJcggSzmvOwJIR6WmGcHkbg8Z/3Ko2DOieI+SFf4F?=
 =?us-ascii?Q?xZYMlex9agGoTXQzzfAh6RhuSNJatNTyhSlOgAUVfm2/phVqq6OL+LBpN1+C?=
 =?us-ascii?Q?geOCC/GL2q3LRQbi5hDxXdUi4xXVLFqzQUoX5EXzFClgGHIwnwAZ5Bm2Pqh2?=
 =?us-ascii?Q?LUxmA5NbrfwsYmfb8opBXPFdIzNkGe4y9RkBfZQs8KWEfFbznJ2Lq+np8wtw?=
 =?us-ascii?Q?AtVFy9y5ZlmintC4OS3DvudZ9z1UfH+65Lz8+eH0hOR/0Q8RqSmYeJLhhBnp?=
 =?us-ascii?Q?Qi89LbC6D3s3kPRTzUnXYD6cNGhevR8Ms3RdOqBzsXFJLdKGxXRob1M2i5vG?=
 =?us-ascii?Q?QiCZUJ9jWcNvnPBzkggOEUD0pOtewlESzs87uHcjT2tOdc8IGzqLB8RNp8vW?=
 =?us-ascii?Q?UpHw944MBB8gJJ55G+kY2j+D5Jty34fDYWaIzNnLtNFJIM8RUbGtg118vWE6?=
 =?us-ascii?Q?RojurtvTxPn9CY5sBBsEI4gXe7PperI7dg0Erv5KhhAEazVPTHp35pcXRzft?=
 =?us-ascii?Q?heP+iyY7wkDNOgu1NjAbXWWzDQ33J3/joPqoeKdY05vpSC8z21wPK/nGFFNv?=
 =?us-ascii?Q?MKcsCNrmbR/tjAhAjdiFlcQoYJP4r87V0uu0ufnXt9B+db6R2sJLmQ5DZ05D?=
 =?us-ascii?Q?xvUkHEicYqj/AlPDhQt+u8icj1i5f20p7lwXioaFN3jqTVQSWepSiPEAYNXz?=
 =?us-ascii?Q?7gk9tJo/77IREWlet9GoBVlsQ5c+BVLxmZJNiSrf7WZ2Wa1shpSu/2LzPvTa?=
 =?us-ascii?Q?gJ7jNKu0MILSqko2EWwZ8q7ecPx+35yRjBMXySPVtXgJ9Eu4k/ALkvDp53k1?=
 =?us-ascii?Q?KNPvXabQz0v/wIPRCrvr/yOn8oyntMS/t80KLgQ0rvLMy9/aK3ahSOAmb4gl?=
 =?us-ascii?Q?/ouw/HMyfsGz+fHc6SGtH7SPyAaOJCjvMaYSWFaDdo6FrvnbdA1Yk161RZOY?=
 =?us-ascii?Q?WT9/jaORjgh4QwUvnEsTAhJFBtTZYnzUD1UpzUEAYHdbMZP94jBxIwHP5vuy?=
 =?us-ascii?Q?TGm9CqSWv1sNZNra391qlu+MNuC1J5gyBzbq41lGfxcNIMjsp3Mqow/vEh6y?=
 =?us-ascii?Q?8plG3exdbD/siDp6brxN2nvSO4isvg2xWrHdOoU7EUjUozhgyT+fiC+OMN9E?=
 =?us-ascii?Q?d5cZFvXVDBF6aaUSuk+tPMT9hqCBGQW4TU9dwEGgnJ2rtu/4F2kHSdJCcSUw?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed02d1-bf82-4ef8-3d88-08dd91f9da40
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:45.2464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J6k6L/Q9YJiqfzRcYnBQvQQvvpknknlWQJl8CKB7knlMq8wwL99xUh/oYnIugLjw4+c2aYpbKNGHLARWunHappcmWiZNFTyCHkzhExlIcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index b76d33475dd..9b41ea92f38 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -23,6 +23,9 @@ static const struct re_test re_test[] = {
 	{ "", "^x*$", 1},
 	{ "yy", "x*$", 1},
 	{ "yy", "^x*$", 0},
+	{ "Gadsby", "^[^eE]*$", 1},
+	{ "Ernest", "^[^eE]*$", 0},
+	{ "6d41f0a39d6", "^[0123456789abcdef]*$", 1 },
 	{}
 };
 
-- 
2.49.0


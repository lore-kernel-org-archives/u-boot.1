Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA9DC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131FD880F8;
	Sun, 19 May 2024 21:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="UKymWDOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6A8880BB; Sun, 19 May 2024 21:55:45 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25FAC880F8
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkJYKH7GLVMKGKPe5cJ/ea60uMt+5C2AgrDMQpGjLpUfOL4OUIpwA1uXx6y3q3bYctrQabM73fY91zwr2BDwUNGRVIwV5lBn86kxW/cM4NpiBs9U6C41+TGuUpwiepUetyWhvI/7JCVGiCF1r0dirc/Pk231ZK0ueDh8R+gekw1FVmL+wPsr21GCvaMlW59ydlv/IDc8MN8TlNk90WWnxBEIEHxfEUpUzIwa2dggdFphzAC7aLQndtwC34JZR23X/62CG9QmxkFYqvNnkgRAQJRHwl7ZBorqKHfurSyNCCSNPzw/p8I2QOn7Gaq39mhZhsK2zxMCo+H5ERZQblRvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8Ho54t1NYrivQQdHSCIjPJ6sgPJW+rfNBLqf8IZyPQ=;
 b=JlU8Bq5kV3q8Ul3scoIw29VodbEWrPmDuMGADAPqLwgxGlBxw3f/ivzIzyBUhSxZ0kRsM/JxzJffJKx579qEsBmhomG1fJf9q9B8ALYDWjfEJxiTl0HqpfuxcAV0zk87Rr8BDTVdCIVJ+PuSW3/v5iv4ZBrIIvASwce1i8NbEYqOrRv0QBM8LsH8bod3ZHfcB0q+frBxxUgzvUMHXHzU6Y9hc7PIIKhu5OMcXPUsQLaJ2eX7bkTgFneGWzwB5oHrutHlD7Drotj+9JsqN9KYhsVXBSr0CYdtltYR3OSrqdiVOkX4fkbkY0sF5K5ud0rk7UBfyn5YY2R9rpArNIVkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Ho54t1NYrivQQdHSCIjPJ6sgPJW+rfNBLqf8IZyPQ=;
 b=UKymWDOKsHsuCJZVTaWp4UZuteu8CiCpX0nPUO96kU1iSlL8x6Gpi5qFGYVW0Onr4+LSXFFij0vCC8G0s+xrF5mmTni5Kgsik0Z9XVwWqKejfst1PPkRYTwHVb4VEWuxCjS+QG/WG1505x4Tn+T5utP3eCCDnfVWdWukHg/lJcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 19:55:41 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 19:55:41 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 1/3] cyclic: stop strdup'ing name in cyclic_register()
Date: Sun, 19 May 2024 21:55:30 +0200
Message-Id: <20240519195532.1648830-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
References: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b086dd2-cefe-42cd-7003-08dc783da99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/GnTYTZHoni6qa3FWJdXFZiItRkGGhSIBD2/K36qSFTBCZTcBI5uvepWDO1h?=
 =?us-ascii?Q?UmFfeTiUDiV7P84buea+BYKB8KZl7wfvMzaQXgfhws0MP36ePLHh8L9ws3Wv?=
 =?us-ascii?Q?zeNL/iDY6gwrlahm1zw2xuo7pvQjwDTzND4PbiJEor2Oy5ocIFClWq2sK4BT?=
 =?us-ascii?Q?8AXc0s14B4Z36b7WtvmmrCkMYmj5z5hurMb9tTNGnqr6rc5sxZqXlactQUR4?=
 =?us-ascii?Q?4Ri0dPbNf3hsRzw96zvJwoudfTnI8j0Xhr7DoCjUehpcOpb2HYGa9uCxekO0?=
 =?us-ascii?Q?c/LYafgboRjqufgNiXL7VMWqdC5o1O5AkZxZhGifrlIrvRBQF85sEMYfxemZ?=
 =?us-ascii?Q?+tspAv+8/Nr+j+bM5R5eKa1CpN0SzMkfA/n7eQloGsI0bU2qgOy9mYMgHvja?=
 =?us-ascii?Q?eRSC9Xpcd6zqWadjvYIbD7S+GhSX74hoaXYAx+BtaUwSC3Qqgmk2iBffBgEH?=
 =?us-ascii?Q?OGNu7i67IvV4BOuDBC77D2vEB9gDWwJ45pf5psgrbHvelhMHC8JLIhGG5Udp?=
 =?us-ascii?Q?LuG8Sp6W8JFoBU6QFT6hFXXLsGukK5yqxJoRnXGPkfCntY1hsbYQZGmmJXzN?=
 =?us-ascii?Q?8BjZj9qDxFiEfHmKJ903uSBJAC2n/XhmjCLt/B/dQQPmFK/wyJ0byESEc6UT?=
 =?us-ascii?Q?Tt+Sm2fU6Zl6Q9a6q3ChF8oCyHU90YVteI3p0xehW6Db1XPveOtzDXI0skNQ?=
 =?us-ascii?Q?nn5nEwFagJARZO32/AVJvQLZZDbqaUjlBAF/4FHI1fDg4DkCvgiqDTlV3NDy?=
 =?us-ascii?Q?6nW1iqN83CXuCpIqVfYet9i4x/Q1mIn6/WYiUwnHW+t97WuwY0PZ+c39QWJG?=
 =?us-ascii?Q?VV/Cq5w1kFplUn+SOsSgWASWT6bqFxLzFDM5n/9CNYGm6y/TfLarVKjSE3vG?=
 =?us-ascii?Q?KwSOZBfGnFBanC194kNUwhp9BydGjdfu4cBAx/m26EH/EW9ykWHE9qScEy8G?=
 =?us-ascii?Q?mEodrXp/k7Ppq0zBrBZpPwUoeilynC3Q7w0a7Zmu4t2sak0qth4QQ2XypYY1?=
 =?us-ascii?Q?/XdwHlNCcBl8KETWEYNBF15FsjsDOrH37jqUp1+1embfZSjgG2NW/enRL2v5?=
 =?us-ascii?Q?ksYYHOqBpsPl84CXL7Lh/v4OD/rw5vRM321kTOVZqbsPQZnwy6YG5dEDIb1b?=
 =?us-ascii?Q?EFLFD4zkmh9amZR8/QYALwDnnPYBG3LvS3qzFSbb5Ql8Vhd/anFQB9iHICrE?=
 =?us-ascii?Q?RZZAsDDPIEGEc8f77PS9VnRncTLztbUTiXd8y2G6n88nulLor87aoYLAQGsj?=
 =?us-ascii?Q?A/KnNhuoHlDUqzvsIux7qVSF+EGnYJASXx+zdYXLlDQQUEZJ3YKYR7dQJsrq?=
 =?us-ascii?Q?nQ/oVypVRu0rUMCtLoP4049Y3Kh4T73kp4ro0dYvmFgO4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ti08GzN4AGZGwRBmc0USRBo34LACGDTOGQz1oe7QQIjmKVjNqTMPcckGW7n?=
 =?us-ascii?Q?TGUkLb1Jz2kRbw3zjOsBe08gWcdZsNcL+aEocb+3chj+C9pGd9nUA/3f1fMP?=
 =?us-ascii?Q?ZxfmB1jBFzkAMVIEej3olDHxNe1dzMcsCKs3Q5VQ/IcGfk3CgSAHIevKni4L?=
 =?us-ascii?Q?QLd5Ofi70J6Pj3kUkS8kZsMouTNG4+iP7Y9TVQ0TphoRLtqW7+h0odV5nkr0?=
 =?us-ascii?Q?qjPIDOSacVZc4s45GUqqm3pNpIi48nNHLK0vB3FhApbrK2MQWlBmHUg8rtZH?=
 =?us-ascii?Q?sb1oi4uh/9pKunc321JhuhZ8M6h5xq8AWv2ZzJSXwtuSxpHcENRoFhtZVt3V?=
 =?us-ascii?Q?sizyVcCVT/vdad4fnQhjg/PxdOJcoIVfhpmOGbbN9Rd1taqTfYfcifXgDKrR?=
 =?us-ascii?Q?V7beMApWmB32agMFbU4N8QdJApN5cvSQh+JIeP1erNH7sVeD5287S7qiADbc?=
 =?us-ascii?Q?jF5XzN9skDUNR8CRf7zM5s+3tI0Yv54lxzKCsxQm+bc5BQjgvF+a8H21KzUH?=
 =?us-ascii?Q?nGHO2nSWx8KbcqzUyQgGCnoIJA1WAFp5b4HjYt0bdSKQlVk0b03LJZeM6o6F?=
 =?us-ascii?Q?wM0nxIFVuDYce+7AY55v2odWCnwcthhMIxMQ3yWn7c4ZOgkrHK3JiSHA+jNQ?=
 =?us-ascii?Q?htGAoOXXbcrgKZcyN8qykC6+CONeFtC/KFYqn+43fwqEW86c1tNOpAdAMTBC?=
 =?us-ascii?Q?OuhpqX9dv8EhCQoRE2bl/33kpgvJ6UdCjtP84RHxqCjVJ35F+LwSSyp4iFvo?=
 =?us-ascii?Q?i8+YH9Ty5HrtMYq+LMWniTztPCnxBoscuQ7ajG6oicNeYp5gjdfuxLn8OeAy?=
 =?us-ascii?Q?DJbmrBlq3l0WqEIEAMBKag50d/UverGkfiQzm0T66agBQqJ+RQL+Smj6ex3r?=
 =?us-ascii?Q?dHiVXjFIAokgDQlda9CMzmlLOktcbdiwGwqjd1dM+ayw9G8L3FaMpUJ122iP?=
 =?us-ascii?Q?6TZ/4WTkZFpf9TPiVAk39wK5qW2Ft2LyRW33onbqd8PxewC1qlpNuHHLyXC8?=
 =?us-ascii?Q?UUtnTudm6aK/a7D2ppySx6Bymz53Hl+kTDm5jH7jrNahL4TxTqGckj+J1I7B?=
 =?us-ascii?Q?ZmsXg87GF5bI8e6iUULBrxrKH3I9ILqfu1BqPatJQ+i1FmsyeNaJQHotnYVb?=
 =?us-ascii?Q?598ZS3ii029iaD4ui5ZOU7U+BTbqlVWe+Fu2N7QoB5kkOkDQwLGmyXYmXKnW?=
 =?us-ascii?Q?/7Ds/BaTwAwS3NMczcLK3sn0fvxDg4oSlQ6WsllpGkEspnfIsZQ8sEVniGw4?=
 =?us-ascii?Q?iisug76AGHYPHyNIUOcLfz3ryATcyRY6JllYpkjpX5WiMwCRQ1FIkvBPprww?=
 =?us-ascii?Q?/v8RQlXMfML2gwaaXPc+f+hJt/XofM71Q0ornWTSE4Ny9/dAyfSR0Ri3RtNw?=
 =?us-ascii?Q?BTEpWEUJMQcELFJxZ0ZM00dgVznj2tPuXPI+14Bl3HVpvcwuQG9YCmm6CZyU?=
 =?us-ascii?Q?Th9AyykYlorxk5sTBjIJkYVWKQq99H2FM+1K8vXKjd1KuWAALQkFzn0W9n9Z?=
 =?us-ascii?Q?aG2GXul7qXkdMVBgO2OWHsMd+qQDcNyyLOWyq24fq7awT8PmxwKRjOLzSuyG?=
 =?us-ascii?Q?eBCZYcnK60l3jxgIwlo0IeWY69nmSyYamfWTz5paXcw7f/MHNy6YGsvjkLfx?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b086dd2-cefe-42cd-7003-08dc783da99d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 19:55:41.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y17XpW2YxGbL5qjY5nk5RZWOpzAjE/BOr8qapUb6Jjj8Ad+Snw6Jqk/ZNmBNfl3Dzh0pmZPVcc8t3LONI/UP4An3GDLqDtjoCpLUl/KCnBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3716
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

We are not checking the return value of strdup(), nor
freeing the string in cyclic_unregister().

However, all current users either pass a string literal or the
dev->name of the client device. So in all cases the name string will
live at least as long as the cyclic_info is registered, so just make
that a requirement.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/cyclic.c  | 2 +-
 include/cyclic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index a49bfc88f5c..c62e7fa7d19 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -40,7 +40,7 @@ struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
 	/* Store values in struct */
 	cyclic->func = func;
 	cyclic->ctx = ctx;
-	cyclic->name = strdup(name);
+	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
diff --git a/include/cyclic.h b/include/cyclic.h
index 44ad3cb6b80..38946216fb8 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -31,7 +31,7 @@
 struct cyclic_info {
 	void (*func)(void *ctx);
 	void *ctx;
-	char *name;
+	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
 	uint64_t cpu_time_us;
-- 
2.40.1.1.g1c60b9335d


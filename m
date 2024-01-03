Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62882C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B568187631;
	Wed,  3 Jan 2024 11:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Bah1rQzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA68871CE; Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEE1870FF
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lenYeyqMtDjEqkO95JfOr1GIOUmmvB71RAC/Pmp2b3ldkmI2Aen8u2USU/OKWwV15asvEUJbFjRVBmNXxqilZSvlozcJiQ/Ea91PcVF1pqHd6iu1eduPLqOp5G5Tbh50RO9jIndSGi3KNTxCIHhjW9zs+eRqBCY1dh7kZq1SdPzceOOyiikszRdJCl5WwB77fUzaSoIVC69f/Tc4dY/TPhvBSRvstofrpOlEhXZG31r9TXLhSphHAm5U/O5AkAXWusbUXqGRaeF0CHQ/rPbS+8JVeiDH8h2BIkMz27FTgQ4akQOL9x9MAq1bv9FbQKSfazZ26PzpeHD0mj9R4bnU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y3SECXyhGYnvtVHLhsIC0oq/DY+sQjSxK80LUIPtXo=;
 b=Q6KPHhqXKqwhVD42loJ738CkUBLegNKbHNfWq9W/5BpUZBxA5T3rrnynXSWVm2lJt0aUtV5Ael3Jd0vAkoIDrRtbNronCqrAlzapMry7/SZMuB1PlnWbDHdXV9vAZxxPCB5UcRc3V5foXqixX51WCDNzRHQwfuQWzGnd2/1nOaqyyv7iwvNCBKgvx1HrvZR2Ff1pNi5nfFHTUQWLvjPL01yXU4/sX8/SKqy/m0JckxS4kOmOAMOLFCiH6FlNxoIwWy+/PR/HrjXxON6abc8iPRXVDwMXbxfc45ig6HsTNwp3hroeM70eOjODcZccUFkIQAwj9rD7IGJ4GOJ/fpx/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y3SECXyhGYnvtVHLhsIC0oq/DY+sQjSxK80LUIPtXo=;
 b=Bah1rQzSVv8ig2U8VIjK9BmA5HOZyB21847/KK35kXBgZFUvMb3IEbhESOeTPCPc2hlonaLsHny8cO+RW9xKmirZPf69l65QLTP0Te1UjcyZZ7ChwH10ZZ2scjEHk4y94uGZQohYh63KYcto/sXrMo/KXvMWooreDyqB45cwjfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:21 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/8] cmd/mem.c: use memmove in do_mem_cp()
Date: Wed,  3 Jan 2024 11:47:03 +0100
Message-Id: <20240103104710.4185383-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 36879681-360e-4823-6cf8-08dc0c495caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i3zZ761nb1yylVRC6kJW+2kUaOHYCsoWdNYgCEwczgTkBNClwFsM24yoTbJEEBnhPFLc1Znlgz0c2O+7FmZ3Hmh9mntEBdDKZ7Sph7s94yBixNBciK6+kzVJ53f0pOmFYtJnTkufNB+ONT/o2elJiSGeBJs7STdzz5GwRMMvOb1H8Cx9JNJN2JtCklZv5jYiU/Lu13f3EJ2YTXbMI39P9I4B/sfrJv3peRiq2cBq9fiebKrFJ8dJUO4//FloSjrGsTZf+lrQR10IygXyY6A9EJEGm600+TnnWefU5mwuyCwX+iUhnb4KF0KxJMF1jccPlkcvjWI1kfZTYfpapQGHJhI6sc52Dl1dbHXBlBkSCxAW9cMrLjqGPMR+MUES8TTtaWBF9fwkyKwa2RNrR8clzBltS6uBAos5fpMG2DvG5bxdczNpj+U6nnGvthgL+NzU8RmENk8dWjEPH4XWUEYnK87Kmo2uo1lKrcbnzNL2CgJ767Rk2zEEf+pGHg53GTDB0IocIWqoYgIpux/nXuNiC61thTJwpy6yJivURA0NMUjqxdvlFNRolBmw9ECSXdrA17JPxBpFXMh4HR/p0veJoNo5IHN538vJ9rzK6zZ1aS8+pGsWEjmWsbS8PQoowet
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(4744005)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfLGTk/cCoVztgAa+8gjmKhAzObiIRxLTT6P76JWWYzHzZuxDIJwfQQyD0H1?=
 =?us-ascii?Q?6YWtOAP/YyfIENpsrxLaqjfwkMtQj4JGKMXVm65MekSKH4XoxayDRpFK2htB?=
 =?us-ascii?Q?I0afiqHQ4UiJFln2yx6DcVCQ0656FgAhMxlii+TrttxydnkuC5MkVrWac5pA?=
 =?us-ascii?Q?tmAZTn74ezVbdRwku7rCqgyaQi2q6lTsI5tLaEgz/I92/1qt77VbByVFfana?=
 =?us-ascii?Q?gd9gBA2tLPGxOo5q3RM0nwkzqkLRQ6cibflgMm09vtBjTzShcZGHmCalNPZr?=
 =?us-ascii?Q?94t+E00EPjfFX4h/A38cOJ9IVQkHC48WWIoz7b8uXYdHuQkWu53+06MCFfBG?=
 =?us-ascii?Q?3tGbIR64d5H5lKHFKAFwgT7+iXKoNCJrqfiGyZFwA5ewU/QSwaGODcEz5Wca?=
 =?us-ascii?Q?+z4BkCfYHahRFDVXhcOhFYVyPfVb8+xca/xqDA1vncFBsC4uCoTgbaCJe6Qs?=
 =?us-ascii?Q?EnjbEM9rGFcnAbrOorw8BAvHlE6WUpPghEuKhWocGQY7GIyFL53mWym3WoaQ?=
 =?us-ascii?Q?SaxtCzucNr6gtgZj9NeNHv97aOveflGZ2tAhNIbQ6tLUj3JGvIu2KxiZudZa?=
 =?us-ascii?Q?zbqAK2S8BJnz5C53PCOhOnLWNVvsR01uUZ58sXwp3UsHon5vpKqvbvknlwng?=
 =?us-ascii?Q?9eDYFRgNZUxzIECug5B2wEl+7O1JplR8Zstrm6hREPyxffnzlZF9nJA490Uz?=
 =?us-ascii?Q?VIbTVawxhPqTUNI9eXDgKS+gFlzgSeIMtCTSomuWZJFl05ZS2xrCcHjjLI/l?=
 =?us-ascii?Q?VyKMNVxnfgpI2Z8gd0t3km7VBbdR9MIjGDNEH5F/+lZ3p56yiblZpAt/wv+y?=
 =?us-ascii?Q?hWzclvPuJNNN25MjiA9Ro0HTxZ3/CQX2BNT2YwzlH3BxXQWnLYabA5Oq+pRP?=
 =?us-ascii?Q?SMgtRnuRZdCoTzNPR8KDdOUq2jRjwe/Z/qxCUqA/a3BWOAT6D1/MAobbeaHa?=
 =?us-ascii?Q?pVOEn1crhwWDvb3cSVH9kjfJy4FKkaTmB/s1wEP7SqouBf2vjzvcBs8u1oE9?=
 =?us-ascii?Q?7i7qpBWvrRNRR0GvUX6AG3AG+ObgN4KgN0vAeLHDshjQ0lSIlxtRnlHLDE0e?=
 =?us-ascii?Q?tFGnpTiKFfeerqFv82UGITrnTuf4RSm4RoO5dpl9ebJloTpNuicyUDlQ7jQW?=
 =?us-ascii?Q?osEYzKLLLkeu071jEnJ8tN9DL1STXwzW8G3HIN1cfcZGTvDC7lba4KQMxsen?=
 =?us-ascii?Q?7ewuCTt0K/G7E/f4lwWgFVC/QDgO6KCSSnFTV4zbdZnyX8KpQtVNGuAEHI/G?=
 =?us-ascii?Q?BYjJCWI7STyIYQd5lExnf1VBOp0NVDcLc94SJA+hpcGtJ2SZLYWcZMnRhnev?=
 =?us-ascii?Q?+ePvREaW1F4/b2V55jxCwX/Zhf+z/Y9LOKYN+FaaHqasBtRPV/tUKuzIakXJ?=
 =?us-ascii?Q?nX7ckLkZx7HOtl8LgN+sa6SgdhWmgtiqt6Jf0MQPTiIRMXcFPymWXkpj79kw?=
 =?us-ascii?Q?ivHUIxJKu1b5dALu3fsZvkIi2zB4HC5s3XcIN0yYDyHrh+CnuHCaPBLidtpw?=
 =?us-ascii?Q?wFG2SJuCabAlaGJ+ZJ2vxGucxZ9kXwjxsdcEBBekPhaKhuouizrTx/KdIBcM?=
 =?us-ascii?Q?oSTJNa1639taHTOzAllUPDQGBMyHFykxCJ3cXxz1RCvmTcR6ZE7StxG/oh/d?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 36879681-360e-4823-6cf8-08dc0c495caa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:20.8254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BelM1SlbjVurUD4LpM90NefPowh6nQDtvl/+v5jZKvWJHp6wcBtnnFC8XwkqQZwb16vFyA6vBG5wLEd8tu0bDTcuLp6HBtX2yyIMOLHTT/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7575
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

There's no 'mv' shell command for handling overlapping src and dst
regions, and there's no point introducing one, when we can just make
the existing 'cp' command DTRT in all cases. memmove() should at most
be a few instructions more then memcpy() (to detect the appropriate
direction to do the copy), which is of course completely in the noise
with all the string processing that a shell command does.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 cmd/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 66c2d36a148..c696b92a274 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -361,7 +361,7 @@ static int do_mem_cp(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 #endif
 
-	memcpy(dst, src, count * size);
+	memmove(dst, src, count * size);
 
 	unmap_sysmem(src);
 	unmap_sysmem(dst);
-- 
2.40.1.1.g1c60b9335d


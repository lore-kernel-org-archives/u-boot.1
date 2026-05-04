Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652E5CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 14:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D1B84374;
	Mon,  4 May 2026 16:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="HSb6glJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199C1845E9; Mon,  4 May 2026 16:45:07 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4CD84255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 16:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz4LhwwwvgjZVPK2UMBLMRn2N9V8khbenUMdWVOT3kytawHkigPHlHubW/zhXkGwkDWK0mpV3uRmpZPYsIlSeAHqh8cJSIHp8PzetdXmRGt6n4mTgLe+z2sqhX4taPCKdGmRGiK4ZoX1zSM3C2s7qewAmrJaHQrzfSwY3rvOamsBngdH+NOQhDoH6XYBvT0s0Z6gcDt9p2xp4GQDGgMN22KZDTEkatLjNjsEMF2A1Q+ddKbL3NKJ/b0L01nd7+6DWBPE+XaUA/bWCQ+b039vdfH1bqMnsTAUOejpbUk2x2zNVPgVOmDN9own0mmdcfd3iCrBxrqwgq0HXnuXZGE7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3h82BTIRWKJQuSDJeBFjIR+fNTr2s8y+uqx5QJimgA=;
 b=H6Fkm2H17gcya+/2akRUoReqOmLotjcyk4ANr3A1B15Attgd8+EApgQ5XK4mMdtnsJb03aDjc4EvLZdlYBX49XzaSiheb3lDnViSatpg8DMXbeauS6B18zc21eEWBdVrLJ7cp/vxIAdSdGyzerkIk+0sztUV8eHm38rI+OJkaco96sptQMoQCDGtjJk3E/lUWf1zVbnA1neVfZTKkE7IwcJGcgEN3FNhy7W3saJRyRQUEMF9KZctHBlObHQ80ZpPp/ujM5AmUpzDgUtoQALePzkZ/AOuWU00+2GQ61X6/1tj1zTnHC6A7y4b9kyVIMVRMyb8E6LRTKtkNklU3vxo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3h82BTIRWKJQuSDJeBFjIR+fNTr2s8y+uqx5QJimgA=;
 b=HSb6glJVW/V2R0Q5ZmlxF1jtNmhOgfkj7iOqdtJ0odRgK6Zt0TJojiNe/8YHdL3sjsxhgO3r3nvaOPMzROhLHDUD/yu+fUwBI0V272OdTzDPSYTDo+JNOTDxOBifSqtWEC+/8vZeX3tiG+Maaw3yLT+lknwtVoSvpFG0kiekxkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8976.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:45:00 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:45:00 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] boot: image-fit.c: check target, not source,
 for 8-byte alignment when loading FDT
Date: Mon,  4 May 2026 16:44:55 +0200
Message-ID: <20260504144455.3674272-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 782fae66-743a-44e7-e20b-08dea9ebb7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: MYtJnuo656zjnmBABUIJzsFzcJwrb6B82tI9KgrVEXj5cy3MdNAlNxIIGcwr0qJvIgD+GZ8tSo4NJk40HVVp1GRWF+RAxrQujoEmFybUqO4NHfuo4l2VxcYz1NXRV3kXf8AIsslsjAYeGT3ILbMaLnEecuaHx/V7SBMpJKV+lQO6D5B1UNYtWMyMSj70UdYky6vOPmfMBjwygNLnSNqYQ24Q12kG41BT3HDxKeq14umSVVDIUu6kiNgCn7wF4XrvAO8RA3AB5fIClAX1lIUQiucdp4kykb+pAUf425IUewQ1LuVXGeJJaO8n3MG55BHNm/FIGeFJnRF1XUSkDFZlE16GLg4WyqWHFo71N8g/J5SBtbVkJEdPnGs3C5zVS+KxgkN0yuEdTEXYPeJ+KfaYuEsO5oDZkA2vL7yvBy/8QtWjzvVGNw6CQ9p790aISxHXOsJy4Sb3buC5ENrVKcyYGELwXA3GzSOdJr0LPtQcpCzelSS3iJvMd7xG4Sju7ChBWbiNTLppNZn7ZSgwLl7RGfPWeYyss9OyXi19/CvSesVbcoY2ZyELR336JKr1rIv178DKL5O9USdXXr+oQD8T1iS3NiEPi4t5jH+1NlJQeLVd/FsK3ClwfImDYRENxw1fiCgdcLx1kGYZ9YqsR/LegUmMzsKuqQOFUtrhpu+t9nEuPnpGjcGvn3yRF7AErP8LOUwFx3VT0p7Y2R6vDwETg7nBtkMMl/rvCdYtvKyr6JI5UQmnEOBRETQfv7yZZ727
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WE64dfIqSt5MbcbLmgVxUBy9d+m1LK1TOrJ4+xp3+1NAtPAzl8V4nK1G+pIh?=
 =?us-ascii?Q?uXYx3Q+PD/30T3gA+DMVHkDsl4bOFLuj0Ad/HXx+3Pk3hJuGXweZmmiDGpd7?=
 =?us-ascii?Q?vN2z5LjKa7PtciUb21FJC1k9HC4J8GCyJ+uned/izmL5ES9kBIEiYglpaGG+?=
 =?us-ascii?Q?mt7pqkDIsXo750g1KtN1XbzNKuZwuSkZKBbuC3qnWco7K0JJHjE6LTmv7RCE?=
 =?us-ascii?Q?bfh3ummGYo6/KeW/V86kmOe/gNCfZ5GbvTcFzoqrwWHd6Fzzr2f8gsmnBAOn?=
 =?us-ascii?Q?f/wUWslRNJAro9zjdvMpkYb8xUEjt8nZgtorW+dM5HQg9e1kSzP+2sDNdJto?=
 =?us-ascii?Q?lSlv6qY3y3S+/+cH712vNZ5HXencozbfXObRTdN7VSMmplDkDpJXbwcfBFp2?=
 =?us-ascii?Q?uttBDtNLr65A1c6UNIeOsjLwPvAt7CkGbHmcUZQDyNt3wWOOD1ZHVM6Zzm5j?=
 =?us-ascii?Q?m0vaiJpRSTH/uOe7yqHstw5S0I8UNJAJjCbfybfvncgke21Y8cBgBj1voVkU?=
 =?us-ascii?Q?XVAnP2vvRT6HuIXtZ22gfduSRJ95EOVZRuZbkZux+0dkZ70QESO1P5+6CQp4?=
 =?us-ascii?Q?tMHL/vc/Bqy7Skk2rB7XliWLyWmMdCnBhcsI5glCsgz2ePnkiitrwQlxayX5?=
 =?us-ascii?Q?nr1MY0pAHytpo4VKNW3rWQChtcrafEgqAOiBVoNWZVpSF4xIXbefmsDOpz5T?=
 =?us-ascii?Q?KnZ2yeLnVPThe3p+kYKvHsfMUR4f4V4RqfJCI7H/EPqduySuNdaYTgTekhGu?=
 =?us-ascii?Q?ZmTjUknv69msS1RiVg3uFnHB8WCA+o7xlhf8NhWG/FKKEjtjFMmoEWVWLnhB?=
 =?us-ascii?Q?BpxTOxpJixbkOVC4P1KZWUWEQMDj22PAt8HoN8EtOrHMpKd+FPRa32FLNvyE?=
 =?us-ascii?Q?HM3opJbLcSgt7InXT4X+D50j+QNorPOmKSSXtCbtUc/eFFc9UF5179TOdRyz?=
 =?us-ascii?Q?U6zUFM8l0UpmWogXgqql9BkpcpSjMGLERzxJ8e85oy9BoEmqdw8ZnoBiRbea?=
 =?us-ascii?Q?F8use6cYpgGbqXqYmVBNtPacsGYLK0HS2ObrrSFn1u+G3pPKBT+qSOouYGtS?=
 =?us-ascii?Q?uxIvYGOVNIW4JTOFUOs0Id0o+ggciWTNzMvAxG1YvPqUCcQF6hMs5QUVp/7r?=
 =?us-ascii?Q?Kcinlic5dco4liWQH45iql6U9nld6UUyNWYztWxuKpsHc9sp5HhHnW8W6sWl?=
 =?us-ascii?Q?Fk7LNJuTNA50SgrjKRLDiaDIDjG6UYgIQUAGcYnPEWdBNBVFoImXFK8Jj4H7?=
 =?us-ascii?Q?oLm0UJFb1Ed87eLjovUutur4BU4rCzm45O9n32MM42cIbO9FHen/RG50TbdD?=
 =?us-ascii?Q?T4pi9+JfUvJecu4T7SpEm8l1VbMwKnWdi/8IAPZUSUip6oGDsGqVOUXy5eEf?=
 =?us-ascii?Q?xwYK0ZuydbCxP3C+Qc83qcxvsBM3D4kInHYg8kADRW1q/YwxcjeCp+1w9H8U?=
 =?us-ascii?Q?f5qCt7E5zcwuHtRbder4jY2W2RITX5GpQ1bTggp4ou3M5kYP0p8C9JDT8qSZ?=
 =?us-ascii?Q?WXo4f9ZFXwq2eL3RXMSFurtcBFIUg60Xc0/QZDtwVA/nlXoIiinb7Eq7tnWd?=
 =?us-ascii?Q?Z3my9IrFUR5CPNQod+vt3877nkJ8AN/Qu88xur7ZCkr+P3bXzOkAUeInpDDh?=
 =?us-ascii?Q?uELPmi6JNvJcwvm/p6VuR4b5EVqYCIc72BbLH0oLKVuamaRswIPzvYyjJS8K?=
 =?us-ascii?Q?xYgElBq+AJBk9alLB6GHEgkViQli/X6e5ak/M7nqlfeS/JPnufS8jP2QvIzs?=
 =?us-ascii?Q?9ZF1IsMCzGDjMkbsQeHLoBTIUMHUbZQ=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 782fae66-743a-44e7-e20b-08dea9ebb7da
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 14:45:00.2344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QQOovTgeBSeiHMSZAVbv/0t1chSJXnKn8HNcZb2kjxckbjmlV+aJfFyMBbraYfGuR4MeGYs41/ZnRcRD9mjZWkYxdQ6Iwo0d97kFzt60nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8976
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

A number of our boards no longer boot with v2026.04, ironically as a
result of the effort to ensure 8-byte alignment of the dtb passed to
the kernel and getting rid of the fdt_high=0xffffffff.

The problem exists when the FIT image does specify a (properly
aligned) load address to use for the fdt. For example, we have

	fdt-am335x-boneblack.dtb {
		description = "Flattened Device Tree blob";
		data = /incbin/(...);
		...
		load = <0x88000000>;
	}

Now, with v2026.04 and depending on just exactly where that data ends
up, in a good case we see

     Loading fdt from 0x8a8c6e10 to 0x88000000
     Booting using the fdt blob at 0x88000000
  Working FDT set to 88000000
     Loading Kernel Image to 86008000
  WARNING:
  The 'fdt_high' environment variable is set to ~0. This is known to cause
  boot failures due to placement of DT at non-8-byte-aligned addresses.
  This system will likely fail to boot. Unset the 'fdt_high' environment
  variable and submit a fix upstream.
     Using Device Tree in place at 88000000, end 8801af2f
  Working FDT set to 88000000
  Starting kernel ...
  [    0.000000] Booting Linux on physical CPU 0x0

and the board boots (though with that ominous warning). However,
modifying the .its file a little, e.g. just removing the word "blob"
from the description, we end up with

     Loading fdt from 0x8a8c6e14 to 0x88000000
     Booting using the fdt blob at 0x9df94718
  Working FDT set to 9df94718
     Loading Kernel Image to 86008000
  WARNING:
  The 'fdt_high' environment variable is set to ~0. This is known to cause
  boot failures due to placement of DT at non-8-byte-aligned addresses.
  This system will likely fail to boot. Unset the 'fdt_high' environment
  variable and submit a fix upstream.
  Failed to reserve memory for fdt at 0x9df94718
  FDT creation failed!
  resetting ...

Notice how the "Loading fdt from" line still claims to load the fdt to
that 0x88000000 address, but since this "else if" clause looks at the
source address (buf) and comes before the "else if (load != data)"
clause, we end up doing the "allocate another buffer to use as target"
instead of actually copying to 0x88000000, but then the "fdt_high=~0"
logic in boot_relocate_fdt() obviously fails to do an lmb-reservation
of that area, and the boot fails.

When there's no load= property in the fdt node, this should not change
anything. But when there is, it is the alignment of that target which
is relevant, not the alignment of the fdt blob within the FIT
image. With this patch applied, we instead get the expected

     Loading fdt from 0x8a8c6e14 to 0x88000000
     Booting using the fdt blob at 0x88000000
  Working FDT set to 88000000
     Loading Kernel Image to 86008000
  WARNING:
  The 'fdt_high' environment variable is set to ~0. This is known to cause
  boot failures due to placement of DT at non-8-byte-aligned addresses.
  This system will likely fail to boot. Unset the 'fdt_high' environment
  variable and submit a fix upstream.
     Using Device Tree in place at 88000000, end 8801af2f
  Working FDT set to 88000000

  Starting kernel ...

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

Note: We will change our boot flow and get rid of fdt_high=~0, if
nothing else then to get rid of the warning, even though it feels
slightly exaggerated given that we have in fact taken the 8-byte
alignment requirement into consideration in setting that load=
property. But this still seems like something that should be applied.

 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 067ad236081..db64a1ee46d 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2311,7 +2311,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 		len = load_end - load;
 	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
-		   ((uintptr_t)buf & 7)) {
+		   (load & 7)) {
 		loadbuf = aligned_alloc(8, len);
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
-- 
2.53.0


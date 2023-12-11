Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB6C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 12:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FFE87763;
	Mon, 11 Dec 2023 13:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="VrPNNiVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B9187755; Mon, 11 Dec 2023 13:21:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484E087756
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+IObt9TTov/p6EKxvZLYhV0KzGqi6jSP7ZI1N1GO8DMdy5hc4Qjqb7jCQGkXrqibyHfysNQbZMIb8YgHYB83VMvxXFPR5NlGH+ntwuKlmrrp6+qrxdLWsnTM/XMNY60fzLPfaA5aO/AeXT8S3Qk9blkV/CgjcUtfqbLUSzyh0ZnIl9yX0i6qfPME9me386gT0hsWk8defQ1GxL+hYDQ+qSsqALt6DkVZj4m9I1mmLLl4bXu0OyKnuj51gppDaX627s6c77Obqw7FqDFWyDOvkUI1FxKyxX8kY4zDQgSYCKKQPn4SGPfyo5zlkQjuTMzVfOLuiA+ugpI6rXuV6t0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFGm0M5hfzSCIav5hPCnoguRT/fdCiTRjbbghYqkZog=;
 b=mCDvrqFSLKEAaykBjIrfba1dNOzZbswTuHPYxfOq9iy5rwUcLhw3qiJzlQNlJk1nmMe1eTwIHa51v7Rjj/VTm/GPUY6w4ncC2nIfFnRUAfX29YBi9DTR5dmjKzk9ymVWFkyGKGLqVjD6Bg5ZJcbsyjjuR13b02LO2F7w1IMP24LeF3XqPOtQBGtT5WYmM1xT823u3CUkERdoWQ+3gMQ3JAf4w2kIuEo7pCnuL+p+Y/if1Caooa+2IIk6XANP6CEs4M10HditcSlj6tLEnm5bHZt2IuRdgoA/NMhKGXUwHM+FMbRFAkBTL/g8qcM98aU6DahcKQfG2i7k9UC+QWrIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFGm0M5hfzSCIav5hPCnoguRT/fdCiTRjbbghYqkZog=;
 b=VrPNNiVSap/dlYRZqQ+9lJlx8P50c2YUmq/tRfkpNGI58W6/WTbFDfAr1khKrYG0Wafkw8z689HdcTLDV/wP5IT0eGV3raTRr0b/AREN1DKyuRiQdOwehRIgwAlNnqUo5bgcVyT6JnRbg/7NsnIL9DCEx6OPJoH40WJHMvy9pBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB8168.eurprd08.prod.outlook.com (2603:10a6:20b:58f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:21:00 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Mon, 11 Dec 2023
 12:21:00 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH 2/5] linux: bitmap.h: add 'for_each_set_bitrange' iteration
 macro
Date: Mon, 11 Dec 2023 13:20:48 +0100
Message-Id: <20231211122051.1240855-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a98cea-b0bf-42e4-c1d2-08dbfa43a292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJLKmqouv68jWM+a7HEzH/cwK+CedrZNicxKTodILzyuKf7u55lDFYncQscGQ3NJ81BuSWUN1MT933CiOtKz0OjSpsoPusE34zOF4b03r243mI/3H0Xl6rUFtwx1v8iWyIMVFUx24UYDEPMZo0Cn5EOiWsIe1RIjzETLEMVW+ZSQen4GJORZObFF66bHy5QhepOV0sc4a/U4kN2gVJX3faGIAuu35YdIG9Yf0Vw0TNFXB3KQUHBdElLlXgrzdoKl81KaawOZdL8GRg9WgxYHVKnrJnv5X0jeL55eSUymN7TRo8jULSMO0SVLGLAR/7BpCaY+q/t1/MUbcMMDLIRzgw1gT5ON8DtvjgiA/ycSZdSGZTYLlJYaFDE4zXrTLvlLUwMGN9FlvuBmIDafXkOF6oGuadt6s/0hWI6UNfN+irahdkfAs731IazWaIjNpPUDRYPw0th4moZoaXd7JwR/4Ge89/6v0rxsEnAM6H+LsJ8H9+VGl4OIeyHEU5wWHuoWGY17OtmMmK3HS6M2fiqMZ/sgJReC4jbKqnKuOpiRuh+fZwU8/3dxlehHYRrWbb1fdO11OKLnRYm1cjB13rpupMK8/WQ+LlE0jUf77U/pFvAk2A66MVuTdf5axXPvtmjy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(107886003)(316002)(38350700005)(38100700002)(86362001)(36756003)(6916009)(83380400001)(5660300002)(52116002)(6512007)(6666004)(6506007)(9686003)(66556008)(6486002)(66946007)(8936002)(8676002)(66476007)(54906003)(4744005)(4326008)(2906002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwlMg3tsy+xL/JkKyvHgfh6wOiOfoi1NOcXsCKTKJo2pxozqatjSwXMcqPKK?=
 =?us-ascii?Q?+mxY1daIkcLVaWi9t+ANO48Z61O+H8QyD08dsXUl9Fr3Wntg2ucawX8bKTFi?=
 =?us-ascii?Q?NeV9ir5fsY8UWqlZhO10ELU6OxpbuKnfDc9PiZQ93V/fXiSLkmlmKsdK5Q7d?=
 =?us-ascii?Q?IBlq0ReNTyYyy0GEFwfp8wahg/Nd86DdBllL6jM+vQx21ZfGqUiItliOHsmY?=
 =?us-ascii?Q?NNyZ+y3TSvMxF2QeWj6uYHdycRG/VXQJv/HqfkDfpE8rjruAjz5wiBABTzIH?=
 =?us-ascii?Q?QYE4P3Dgp1c/Oq0Wk5pe7Mb572Gn9k0bIesWQlYxI9BL1qM/hkiL7B9s9DdX?=
 =?us-ascii?Q?ETp2JcgLLoG1u60HirG3UuxjcSI/V5CuL86GTpYM/Srkg+yEJqLJKQIt/PNb?=
 =?us-ascii?Q?jJL5QvTFmiWXFJXOzRr+uQRefJ55TxN1RlP0kl5pemfyt075FMbPVDxKUPV7?=
 =?us-ascii?Q?/Z45TwIgaqnBmh9MWKZcnkUw0bn8zemw1RGwDeWoqNk8IRM06yFdNNmz0GIC?=
 =?us-ascii?Q?Z9N9+EFmc7wAwdavnpIyTkClxGdFfswZW26S9CHGmpKDBict055Gcb/vN/UM?=
 =?us-ascii?Q?QYFLPnj8i8MKOillglwjy5A3DabLV3zG0g6YkaaCDS9GTd/9K1R9p2xk9lRM?=
 =?us-ascii?Q?o2TgDMX3f1xgyNeA0EnlwhD2p+PyCz7UcPH5absIGHL8WykQtfdmKN4yphYD?=
 =?us-ascii?Q?WFGJHYt6n5aI23TGdNwea3j7uRpZUJ7mymmc7Kc4x5lK+m/dEFglF0fNTkDp?=
 =?us-ascii?Q?eYNVtBJ1WL/I7tuoEsGPdjPHr3qOq5xewf4Awc6oAQgYNxxK5IZHy1z0yxZr?=
 =?us-ascii?Q?cDJbvfN5svBSy05XeE7mi89RlAHfD+5/tWxYKcV5pdo1O0tjwiphE45oeqRr?=
 =?us-ascii?Q?Qe3agE2/d3DSldjEfzql/H44dNQi1rGv2RhaZDyGu/jQ2ikEzhLvnaCvOBLb?=
 =?us-ascii?Q?pWyDezCndlff0GG7ZKg7x7f7bbIAuoeBHxF8o0skiPI6OH1oTcaghVpziCQV?=
 =?us-ascii?Q?cZMj7ksH05uFNudfqFy8NL07k7QwE7FaeWREKDIld+qvkYsGNQdlG/6w0eq9?=
 =?us-ascii?Q?t4gpR97mGbjNrdMKu4jkY3Cut1Ad41NFzAqnY9BLFyxt0RQOZkOqbrE2WeHn?=
 =?us-ascii?Q?T0mpkU3vKh2Kvh9PM+WYtwlP0jiDRmODq4IzuAO0xS4o7eEPJh9Iw5IPJr5+?=
 =?us-ascii?Q?WKaLqlR+K+NPV8XsHJPCiz6KzQUEusBrNmmKFjIzz+jVMezgyr5mEXN0ebCx?=
 =?us-ascii?Q?LG33GJT3cLvsIrjXEoyHeE5Snif9pQvn7fZNMPGmO9Ikgj+fL98gIsT1kaTg?=
 =?us-ascii?Q?ak8AUTKD7e0+KhxdxQqyo290pND+10OmcRzFhCyCrFeP0Qwz40zB/MZh18QU?=
 =?us-ascii?Q?D7/+q7HOoeT6wANOUGn3jThtE/UQzjjn6fpqr0Jqmwjc82X2OYqsUoLWft4s?=
 =?us-ascii?Q?2f5jDDW5hBKNBlSxLumkvUMUkj+aqejiml9slDsnwOdYS+QYZOSNIs4cmJ+C?=
 =?us-ascii?Q?UkHWWpX9cQFxYW5ElMPMr+jI6YUkg6YjIFj804AwfkZYSR7d/34SJvzwdg5O?=
 =?us-ascii?Q?fCa2G3QPXmMkfSb6UYCsicnnEUQ6WSEJFQbveYJLW9b7Z+csD7DMkuzbuMFG?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a98cea-b0bf-42e4-c1d2-08dbfa43a292
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:21:00.1500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIG9iHZHcEhW3tyZWbOhI9bAelXilNHsqql6r0++j/x+Y93xptrsZO4ygRgAHZ1Jfk4RgSj4wh6CLqnIrLBEZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8168
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add 'for_each_set_bitrange' (from Linux kernel) in order to iterate
over each set bitrange of a bitmap. This becomes handy if one wants
to generate a cpu list i.e. for isolcpu or nohz_full.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 include/linux/bitmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f..9714533078 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -159,6 +159,13 @@ static inline unsigned long find_first_bit(const unsigned long *addr, unsigned l
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_bitrange(b, e, addr, size)			\
+	for ((b) = 0;						\
+	     (b) = find_next_bit((addr), (size), b),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1),	\
+	     (b) < (size);					\
+	     (b) = (e) + 1)
+
 static inline unsigned long
 bitmap_find_next_zero_area(unsigned long *map,
 			   unsigned long size,
-- 
2.30.2


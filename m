Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF42AEED61E
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 17:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FBBF86529;
	Fri, 15 Sep 2023 19:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BtcdqG7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A1C864EC; Fri, 15 Sep 2023 19:51:05 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CDC86366
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 19:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDqVX2Mo9kF3thftoTNbny8ebJ7U9a6q3Sdn06wIcWvh+mSWTdFjik6wVAh0C153yPh6ZxD/Sqn2dnov7qH4q/ZgRqCMHmcHFOKurG++BFBgA8nrv4KyhWpUEiod73tfjY8afNUcdV8xmyFhghou3GFhb64KtFNgTd2tXJINVUZ8bNlS0Vn1WhHS2fu9juzrK4MO0rZlL4jODr/LZ4BiDCt4yG8PQi8TihNQLnwuC7lbmCzJhFQwiODNUQFQ2/2mPo+GQJS5brYdQYfdXlBAxT2aSoxczOd+0rQhor7KrKy12fXM1CrsUlRBR7B2v/azvFd5a1y7JdaJIzjpDpKxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puU3OdBt5uqfncjd8seh7PfUB3G8S8V98TzUb4tPwV4=;
 b=SSOzV1LMCZ9uO7GEXg65hJ0lkeyQ4BqrC8ETrNT2RhgoKcEwvpjlU27La6yF1/yU0psQf79I2+9O/iNOohVBKuujXzTETSgBkUGPa/QKMfAsVFKNeamkOlQG0vkw0dZtTn/nBkI3F3Lg8ZLyqZdNoXzFv8IagxLRph0y4rI3y1o8oaseATOGlKV06qFFDmqe7AkY+kvHD+MeA1hmomFFNfBWxXPLzkYbec6mdhreTH3GncQyKIbDC88nBo7sFAGMk97ZvEDRVDrVzbGi6orCombahssoJN3HmOrvk6VdCTH/wb4RoG1lcQ4x6zPxIbj5x+nfaqHo9duUD1DnvpdYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puU3OdBt5uqfncjd8seh7PfUB3G8S8V98TzUb4tPwV4=;
 b=BtcdqG7IKsJ5qhlcDF2Vl1aZNIfgR4uhYy1lcW+13g+L/16tEl5FAHTeEVT4llusQmm6BgcRfhiovdd9ieuqEBU3S4+Wn49iBQkbbGOoigpewEKrLYc7KCbO/RxOe2aJQEQyU0K//MjFeChC3gPVcsWMBH+3tzbJd5L8UdTKVCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 17:51:00 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 17:51:00 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/2] make CONFIG_SPL_SYS_MALLOC_SIMPLE &&
 CONFIG_SYS_SPL_MALLOC actually work
Date: Fri, 15 Sep 2023 19:50:48 +0200
Message-Id: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3970:EE_
X-MS-Office365-Filtering-Correlation-Id: 214519ac-d7cd-4667-2fb2-08dbb6145253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/QV7kiS7/t/mCGfi8KCnzZZfP2yXwcKgEUqxzVhaCUsoP14O2Ba63+SrQ+S5A3olkTtXH1o/0wRA45m3GXwSiAcYd1XJbsaGi8ZnQ37HrNV1TQgX89V7E9xQv8NsoeWyI9xI8ruHODflayUYsxKr8RA8ZeQ/1TVsFhAvf/cxYsVdYIGyi8Y0jbDUnC5TO98XeC7N1bB9Ds6E49PkF3EDc4AClE+AvZwUbHQ+LHkv7SS4aEC/QevnYMNp/PZoPFeq4zI0PsNSpjygiLDFKpl9GkLWOPxTTSKXglCw57Xoojx0mTw0XBItJgsJA3p7FK3n5W5XNtOYWLQYcC3gWAtXMc/58N9kD7nIQsNTwxzs/Y/cVo8B5Bwa87EHYWhqd1h1y7DjBNonso04+stI9cw37lbcHdhbS1aGZmQfGTaje1KVpklGpVZC01jD15CkIr3DVuDX0Im6fiozLYkVdtsr6mYtjEzlqmMq7Y05B0I8pn1EGgPvnACayGznwpDj/lZf6Q9MREFDvrMGF0DNGBJOOzc6KhFKHfK9kywcE2HXif14YzGpPo1nvXF6iZ5HP7+TiYa/ShifquWFQyg6wGCi+wzxSHjVTbulY5rtYwajR0tqAyVWXFVtLb6gc3AXEO1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39850400004)(366004)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(52116002)(6666004)(83380400001)(38350700002)(86362001)(38100700002)(36756003)(2616005)(107886003)(1076003)(26005)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(41300700001)(2906002)(44832011)(5660300002)(8676002)(4326008)(8976002)(8936002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1PetkaQki6UtOLaHug6l5+AF6jaqlVa4JPq1ZTsZm/C42wCvAP0+Qe0Vedb?=
 =?us-ascii?Q?CeaWRMcVHRrqbrTUO6V1t7FuvCGQdH6ml7WzDdE10rSbI0VpBYKpMwNxk9tB?=
 =?us-ascii?Q?+vYIhzbXeQjMl/S0+V8H8NiMF4ufU9rISATPvVR80MgTIg7sldQ2B/c7f2qU?=
 =?us-ascii?Q?iSYMui9YlkLhQ+XHbmkSbEZ9nY3OhFP8f9HrXxGKG18DdyJz7SeQ+8ZqPL+n?=
 =?us-ascii?Q?iSXB4DwAsN24zOnh1Nb1DQjpyaGB2A6vyBcjRl5xxFb8ky+pOyFyXye+t5hR?=
 =?us-ascii?Q?7Ouq5vDfk/GFo80fUq6d2YHjPXBtS7BmnCRCTEWg16MSHwv0/KQQz3f+sbe9?=
 =?us-ascii?Q?W+5B97mnJGVlI0NLmINfbrtyA/pKc58rZUJbAHIINL4tWhhUIyAJlJJlPxad?=
 =?us-ascii?Q?FAwv/Otq5I/EPYQqlXA3LzAlvrwR3/UJB7sHtaysUry0tWS1K1NVKHzidVmP?=
 =?us-ascii?Q?N4Pu4TANmQlG6z75W4IAXcAdqLKXpbDvNOqIN9uaZxwY6TA6YNB8wzlDBlmD?=
 =?us-ascii?Q?edi2IsGQTwq50gwWv5pSdmkxhfBkfSuXi3EXLw4cdx1EkusCasWd66VFkPe5?=
 =?us-ascii?Q?hE1gluU4USjSibPJsG8Ml7UTtGZV7MAqNYDs3hXfLq7nKDWperIDbWf5BjAX?=
 =?us-ascii?Q?Wm69ChBSDtKxug3vEE57vXCaZkMcH0tNhlFfoYKcUceUSn9N47tivUDKGbTn?=
 =?us-ascii?Q?48WmBcHQ0zt0SdG6R/fXPXDFjspaWFOMZhUFPAELvZY99BKyzg/ntCBdtKf9?=
 =?us-ascii?Q?/qheCJCiG2IQ5+O91q+adSA3rlwymls1jtE4YcBzyuxxE40a3/QxH5MZzAg1?=
 =?us-ascii?Q?vp8MpYTVPI/nnIb4Dol4nJ8CRkoRfjqMqU7EF0bQ24HYtZ+OIrqt14LQgDh6?=
 =?us-ascii?Q?lEPD4fX1CORe/h8KpTKgMIMQub2FRNAHRZt3IZXWnuXxeY2F+G1eaYMDwtm2?=
 =?us-ascii?Q?vGZA3d6cXEFYUz8lYQ/viQHvZIoq3rRRQtoGWlC+97fQEQ87ZXuDAt+MDjug?=
 =?us-ascii?Q?sbtuc9lK6Gao+WwlJ6VdZ3tWccNeaJQ1PuwMZgt71Eskkql+EmiJwF3bHWn7?=
 =?us-ascii?Q?HxlnnCzDQoa45LU1eG2SbbZNon9V6Zof/SOQvhZJ9jA9DKHShcOrSVBOnqQb?=
 =?us-ascii?Q?GLOok8O6iNPb+NrCKIUzP3nQHCtIxYYHLAHYKJJ4O/4j/CBT6eVI1/Yku6D2?=
 =?us-ascii?Q?XP40HZJMEAcMpUq6gvaWZF4ck2I+rAoRkmEJEbdQ4FiGQGm9q4qTPRAnFbLk?=
 =?us-ascii?Q?KGKkBvVB3q2DCqK3PLJg6E5iDAGMOBh5eYLICHOUwTSQS7iQdUnIl3ThKHNI?=
 =?us-ascii?Q?oulJm0xhXIPhn9Y5pyuBjubtuMOvZz9fgE4n1D75tUsySrr7GWh1//+B3cBR?=
 =?us-ascii?Q?p91Sv3AuaO/9ghxOzmz4vrQlzPz7nnP7D5BHteujsD/t2qmz1RZBH7A/lBfA?=
 =?us-ascii?Q?7iQO14xyIcaTfUu8QZ5Xco+tpwTTPzxjGr0wPg9JT0UIodwJUgoUizGgmrAm?=
 =?us-ascii?Q?2nQIdfUBoOdKKJBI7BMgiRHpojxey1sEny8lHEw6hp4x7WuXsvDaGV7gH33s?=
 =?us-ascii?Q?dHp931vxYkm1JvyJL9nw5IdiSt81ARm8QP5DS6ws3wJqqQJocEbQei7tuDNT?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 214519ac-d7cd-4667-2fb2-08dbb6145253
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:51:00.1658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kCM5PmKgstT01DwsaQZHsO5/u1a+8zCxjhuDU1s5oJhs90V1B0n+rXq1xpYBJ4MZQSArspAec91tRNV1v+czU3Br5+FnNZrOBH5ehijfQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3970
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

Currently, setting both CONFIG_SPL_SYS_MALLOC_SIMPLE and
CONFIG_SYS_SPL_MALLOC (but not CONFIG_SPL_STACK_R) doesn't work as
expected: The SIMPLE option means that all malloc etc. calls are
directed at build-time to the implementation in malloc_simple.c, but
the mem_alloc_init() call which is done in board_init_f() currently
calls into dlmalloc.c, and updates the variables describing the
dlmalloc arena - which is of course completely unused. And the
malloc() implementation continues to hand out allocations from the
initial SPL_SYS_MALLOC_F_LEN bytes.

These two patches are an attempt at making the combination in $subject
actually work as one would expect: define an area of sdram to be used
as a malloc arena, but still manage that using the malloc_simple()
implementation.

Since this now changes the mem_alloc_init() from being a harmless
no-op call to actually doing something, there's a risk of some boards
breaking. The solution for those boards will probably be to just drop
CONFIG_SYS_SPL_MALLOC, since that hasn't actually done anything.

Rasmus Villemoes (2):
  spl: make SYS_SPL_MALLOC depend on !(SPL_STACK_R &&
    SPL_SYS_MALLOC_SIMPLE)
  malloc_simple: add mem_malloc_init_simple()

 common/dlmalloc.c      | 2 +-
 common/malloc_simple.c | 7 +++++++
 common/spl/Kconfig     | 1 +
 include/malloc.h       | 7 +++++--
 4 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.37.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39913C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A005787120;
	Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hGIiIvTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AB386F64; Wed,  3 Jan 2024 11:47:24 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FB487076
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQkfbgABS/fjj4/w8VU8Rbzpeeku92sBZ8F1iIeF5IHD5yQg6Qb+psLmKoyNE+/bhAr+p9d9nwdYhE/a87KWu8oMDaOvoKlPjOQE4Z0Zh3rBP2WhH59oZijksNiFhKzJFKiIIfIAR5J2E68yCISUtRWsV2zLYgMzrKGi9+55AAR/dMQ8mxaQOfJuyDZ16Rb6VCAmmM4QJr7GlmzFMsTsNZXlWVe3DyRbF+kewGnOGoGmuUWlyd9vcRcwe6STtlsbU9OgZCEBPWzyQ8++h9b530gVTkulwcGN6p3bq2+NoDaiI9cK5uYq60cRLaH9ikKbj/XuRvCHprxR9mnOf1wDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5rDPd7FEntFZafWvimhE80fbPhIKfkq4hiID7HGJp4=;
 b=Tq1w+iioid1eJ4aHS5afrDvlL+ZWYTvGhCGQnGPnfp7SfgG+c0JrkI00euJfJxQV7eSBiF5MDzWSIsWCRZIqdAETr8AQdW9MN7Im5+0kvwzW7/Khg+kd3v9NZDMBqNb2OHeG3vOUHyDnHpOzcDHQhmsj9RatyxfPIVRgh+ZMeX9HyfPBR60sJODvCG6rDmLPR4Vx6YZSjmtktr73h68qN0IEKddPAbek+AOfkkN+AStoP5FaH5B/J83loWF0D4708nZ+a29tv4MxRYgNRQV3melUEq4t8LzT4I2Rk0o0DA1M8ljZSiqHaHe+N83KkRRBa/3PEha/RHisUZ0yJdB7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5rDPd7FEntFZafWvimhE80fbPhIKfkq4hiID7HGJp4=;
 b=hGIiIvTsYoipNevNX7Ig7CsjI+YO83B7Mb+gQnlgxR5Ou2vRtl4/o0IEWH+OhDA8Oh57A2JxNLR7g3jAjN9VHBuUp7kulJBAyjX39V3mzn/MDtsEEpx7kkHYm/OR0waIcA6OV6S86o1XMOdkoEmpHl2wxIpGM/sCGOZ59D4FrGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:20 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:20 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/8] cmd/mem.c fixups
Date: Wed,  3 Jan 2024 11:47:02 +0100
Message-Id: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e125c-6bea-4223-e593-08dc0c495c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFpxCim2syIF0sE63hxMRzoob7n4STrTIVLZReOyJHz3ESPN+DdQztnnBgQH9eBIxdvnotuUZomLIYSGJ+bxWqVAaQ4OfeDfkILz2Cctzdp2Jn9mtcc7VF4TPSO8S6Qh40pNH5jOdBurklNAMLsjXuLQYolZiLpMIIJkZsSBoj8c8bhdFq6GrxTaGTlwgVl4uRudO+heP0WuPELuatmQcbgMOJnfmfEOwA0cZwVUfNDCJsL2kDbBP45W3cL9U4bBywKd1HihY+ZN1IRnRuSI3QqJKvSClZSQV3sPJTIr7UCftnoDqub1EKMorlFpl6UCMXwW2ezYSQsvG6udmA/OaI9V09XKagm5ozo/phkRr33HVGpIuWIp4zVbFgjm5dhV1gV8u9Ogdm6Lm68L6493nGzcOuTU8827AppWrDaTNQr2PS7RJClf+AbIgcBn21v5vdnvXr4FaioDOrlTaTPIskhRgjhjiMXKkO1mCdAQvD5nxy/RMNLMo3U6xOsGuEcL4KHJZ/dlfS8Mclps4CtTndcoVspSbQTJbOaAO+CLQIDs/QLFslho3pIRbgIoTGk26PujeMZ2iWVbeod08KUOdaSyEF5q87xjoasn4abC16ztO1UzB7p8O5Xi7oDSU0XW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOv3hiPbb2LrWoyTHIZnfqca3ystu+0pS0S35HeTXMPKX1MVQHqWoHX3okrq?=
 =?us-ascii?Q?PdlRyajIuinWG25z4rsy4BNmoVzDsX54xdhtRawnl+uw39FkbxuL8AigkyGs?=
 =?us-ascii?Q?fh2LoFHalXVm9yYHMGYnOfRTxAQzanzseK+M9JH1nBgP/eojSB9JLGDHViaX?=
 =?us-ascii?Q?9nT00EEYXEtsvq3VHgEoOa6fhDuLmsf4/0BPYyQznzoMdKtrWv/uPfoqKs2d?=
 =?us-ascii?Q?WPklS0u+HrzbADKfGcSP4O5qr0Ip63JC49WdcdXXezdMiRWZYxxoF69BERpx?=
 =?us-ascii?Q?SgJdLsH3ZCOkQmn6HS91HU3gFgYNxacY6vF6PJN/u+9JTtTdblEsoUPMQS/y?=
 =?us-ascii?Q?iEj0Q+eLW4AL9d55epYZfBGFGS2IbVfg43V6YOfyqQMNsAO90aKp7L4dVgAb?=
 =?us-ascii?Q?tYpavt1uQh+KcIz1na3uMqjkK9zL7y3mqZz0Ule+TvK4+72gW9UK+B0uRBiq?=
 =?us-ascii?Q?8/3leuxBRNUHPt5bV6dFu4mHWU2W5Lta3sH06VJwi7KfpObAnQjog9vqKWbM?=
 =?us-ascii?Q?UGok/Z6fduPD2lNXf0x1y23aiLXyzrhjRemgl7JCPuhJb8YEGR6Y8pZKVN/8?=
 =?us-ascii?Q?uDC4gTTt33R5UJkUBr6A/yhrunTNfK3ke3jJXjjh8r5kpcAJl8UV0mMwcQRn?=
 =?us-ascii?Q?skqS+u/1hdUqvD/uO8Mf/6OfOvDnQNT4KKyv9bdofHGUYwH8/bkyWxjjfKZY?=
 =?us-ascii?Q?zPMJB45oxZeEMkNjcOqiTTUcV7Mv611QUZTP26C+KNYuF5DKqbsMs76779j7?=
 =?us-ascii?Q?nb7O/QfAq0YcW2ki21AvBPob7wBf/blTIGrWrBfDwW8boHTh4+iahQU6ZZod?=
 =?us-ascii?Q?rKciUS3fHsmDacJoGXg23Iregm1jfXnsC8apLGzaE79yHnv1YKvPL7HH7f0n?=
 =?us-ascii?Q?aG620zTjb689uU2OCpf34XT/VB1bsGKiGBJWCAIk5cmtQapkjisU/r8xPwCX?=
 =?us-ascii?Q?cd+gh71g7gKHzdmq3PyMZ1ygJ03FstTBhRWzpvYxdRomN6WVfcjie9Ke1WBi?=
 =?us-ascii?Q?6BUxdQKv++Y7Gb4TqczGJ6eaisI9ZGTnuz8COZdfaqupihDgNHIJf/gy4U7Y?=
 =?us-ascii?Q?RezLkQpC/7DylS9B8BNAnv74kbK2iwIg2mZM6jWqsrjsO1VAIRrkR3QVlUEk?=
 =?us-ascii?Q?1Yrvuxwcf6lG2CJs2eUiZHYRVxpqswdPUUt+S2dAQ0hD+H4CphgFQkDZa44U?=
 =?us-ascii?Q?KMm0ExW6WEyKU+iJn1fr8inV8PlSd+xUQHfspfCpGzshnjSnBZQmc9339Y+l?=
 =?us-ascii?Q?mSTxm2iilYQ4oOffMVdt59G+wfS0Sqa8+CeqfnbnU/SKgxIXCXy9z4HLnObu?=
 =?us-ascii?Q?EL5Mm+YhpNO2cdouLR0j84zORI9YpCGaZNkPhh4KpUlmQ5emxUgk3trzU23J?=
 =?us-ascii?Q?0B2WLSnKvNv2b6eh8Lx/QKauRys+r1iUsZ35tBc9bgYx3TLXxnwAUGLUXovF?=
 =?us-ascii?Q?i/LP3Fgn/733/uSnm4A/zQWcYO6qHXFk50GCCEUXRYL+66sBJh0mWOpy0lkZ?=
 =?us-ascii?Q?Z+JcFOmWLOE4f9QPvN3FDvzAxGt2IxPz08ZkkKI6JP9pLWIGS6WbxYMACn5J?=
 =?us-ascii?Q?zYRY3h6UKFqiVi8mT3zUpUHrc/HCoZ1xQEsREQhgMeFNOiVqiQbgNZdIYAee?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e125c-6bea-4223-e593-08dc0c495c62
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:20.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDsU0P1IbiEm5gLdSw1AQjfC/4tOuFIQlXLua3NDIb7k5LiNsnp2QhrlKv/O6xsPhOxxBtqUU3/yWjfoX8GSA5MN20n041xSpB7u2apVars=
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

v2: Add Simon's R-b to patch 1. Patches 2-8 are new.

This started as a simple one-liner (still patch 1), but when Simon
asked me to update the documentation and add some test cases I
stumbled on some things that might as well also get fixed.

Patch 2 is the documentation update, might be folded into patch 1.
3 and 4 are preparations for the test cases added in patch 5.

6 is an actual fix; 32 bit targets wrongly list .q in their help texts.

7 and 8 fix stale documentation.

Rasmus Villemoes (8):
  cmd/mem.c: use memmove in do_mem_cp()
  doc/usage/cmd/cp.rst: document that overlapping regions are supported
  cmd/command.c: constify "arg" argument of cmd_get_data_size()
  cmd/command.c: relax length check in cmd_get_data_size()
  test: add test of "cp" shell command
  cmd/mem.c: fix wrong use of ifdef, drop pointless SUPPORT_64BIT_DATA
    macro
  README: drop mention of MEM_SUPPORT_64BIT_DATA
  doc: drop references to non-existing CONFIG_MEM_SUPPORT_64BIT_DATA

 README                |   3 -
 cmd/mem.c             |  40 +++++-----
 common/command.c      |   4 +-
 doc/usage/cmd/cmp.rst |   2 +-
 doc/usage/cmd/cp.rst  |   5 +-
 include/command.h     |   2 +-
 test/cmd/Makefile     |   1 +
 test/cmd/mem_copy.c   | 169 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 196 insertions(+), 30 deletions(-)
 create mode 100644 test/cmd/mem_copy.c

-- 
2.40.1.1.g1c60b9335d


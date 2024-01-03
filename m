Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81AFC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79BC6876FF;
	Wed,  3 Jan 2024 11:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ATJPQll7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7C2876A6; Wed,  3 Jan 2024 11:47:28 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB57987509
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgD2qLSnuO1IAbu7Zvqt+8KEvzTOxJs4VvS0mtVjRI5J23d8tg2gKM6TGA9z8qjmYwrBZBPi8wjlStUF5M1wC9C8jxv4O4euK7BPorU4WAzRwlhicdTeK+DibSCGvPkVaIOQpW9caJ96Xnps3Do7LU1rNK8BnpVXKnQVy0qjalJ/52Wjx7mOUbnJNVln30DB4GPxRGdevZtO8ZmkR5aZCoUw0Tsw5xsX+Nd5qY1WgGvxlvZgXYlqqisHbDdq2rvdpq77krZ0hUomtFgzZNPExlmT+gNa74AfRZMyH07VbgQJyCTQGlyD7vxpBBI/cNk/FTVrVATz/foOa4aW67xX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfDoFfSPDEPkVmA0a/RQEnnEr8dW4WDLsjdO56I3VQI=;
 b=QgM72SMhzeVyuJP0vPD699sFKCEK1VJE/oJzaV0MO36HpTHHGOzycTM49IcUugjE86J/pNrpon7z041IRveJ2DDSf+rnWdeIrKzCXc0TpztEe+kSITpyZ2n/55pPnNwpgLi/Rfga0i1rMFQRVs+y8W+nkh3A9QHia48Aes5xv0fhx0Tf66WlJ6M1z3AiMfOUKZRyoGvhh3nA+nR+AwADu3vfuXhOTw2WTKDUxEBoFb9AUfUsRJY3u8vCqkLahNTVVvyGLbwNQpB+xcpVAaVW27RbBl2MbLv3ctUGOFd19bKlV/T/TP3KNqCi9G5ahSURs93ZWnsBT+mStX5uBvcEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfDoFfSPDEPkVmA0a/RQEnnEr8dW4WDLsjdO56I3VQI=;
 b=ATJPQll7Wa5iu4xDSrKcpC85V13qOTqQSwyj74qwdD3IN3uwyFu0iLrM1bZCxtMXXssBWk5KiBQ1lcu9uORYOiZND4wSFOzjLYu1FaVYZtbuoI9dPNNYSGKgaKtj/lTO20q3ATFBfj/IfuBvwqLjG8Pu4GjHrQb/TDVKkK/mnrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:23 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 7/8] README: drop mention of MEM_SUPPORT_64BIT_DATA
Date: Wed,  3 Jan 2024 11:47:09 +0100
Message-Id: <20240103104710.4185383-8-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: 273d7db7-86ed-4a04-3607-08dc0c495e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq+zDiRjNeqV5xPgWsZxxF4IsEwHHOH0IJg5pUtQejVnWX/7aQCiGJUElYuAAu9AmxjviqlCPTUPKaSR82bO7RWY+FKzuaRW6u+PzJWE27vVkoeqCZ1WtaZ1v0mb9FkBo+1irNVb2AxwBJKj5aO929oo2MG7bWLW3vCf1EmWLNnK414/1sygtJ1G6BvKkdPYZk7CWSs/rXhfiKKfnrEN71vYWFNwc9292as5DigAik/oZWgIP6QszOTorEvm9x4vfDSmz7/5Ki2brcIxmbAXtJ7Go95vb6is/mfras3f7bKeegKQ00Es7eRZRYF3tpUO6TB6mg/ySYOBxsCjMOiJbecwJCqhPOJIKAYho9Paej36N9j/L6PqEo8LcEBva9GHklnBNUE6/WNgNPErNxuH6DnIKYoRLAlbgcxnvO6Hk0HxK66nOPhQlx3DzytqCk19A0xE+pD+IAfLZcBEIySW3O3JdhOweH4IESQvHJY9VdgYRvtpx7eUTZTTfbcUj4o7Yrf/uBRJXzOhnU9PbYjbCBmJ65G9W9fzmNKAQXo6VqQxOEWaMha5/3bnGHHmHy20hbFFE76XFHTjgapdtU6tiRZGL91hbNxTOImbYwL+drMYO+JclMOyHA3iiqmrjsJN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(83380400001)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+468i0jQDxVnil/T+t+FDUJj03bB34+3fDqzG/8vlEFFu1WiXJwmQtvvFIwG?=
 =?us-ascii?Q?muE6txJ2BH9YNp7lCIicThU08M08OmJ3kP8Cu/l7Xm1415r8Fk8sChNfdwA5?=
 =?us-ascii?Q?GZR3ZhRms+s+gtgnSdvVnTB8K3MbYgvVp5/7Mb6dnsAOb6VHp9nFk0JArsin?=
 =?us-ascii?Q?c/rA7xEMea7lubN+wKTOtPrFmtAjrjqykb+vRoTt9O0AUMPwUkc3yvknf0Vn?=
 =?us-ascii?Q?8RA4MhkzvjGhnuXrtcLH5vrkDuRkQmaomSdIAVpmXFOps+uZfjB9WAt4oYjz?=
 =?us-ascii?Q?xdYOPntIIa1veT/Y81aH2TLNiMukRr7ZfWo3kziXcsBiplbvV0N9n7tilXAs?=
 =?us-ascii?Q?geRaltzK8ajzcktVyAluZKIkzWPOB8npbRq4XEqtjfrRP0nnwOQZK2z/aTuP?=
 =?us-ascii?Q?Jxs7mdtzuPu2i6E01uGUVRK0S866/Sy2pIo1qFOQKTTlyqHwIHxRlo7ZC5Vy?=
 =?us-ascii?Q?xah1YAb8/9E4c1eNZbf4yqJ7LvFgHLPTiI9FhZACf3EH87C/hrlES5c/D3SH?=
 =?us-ascii?Q?s1nxpyZGPGo/aOekS5GkAPdCcxXlOwXTcBskSj4SPvsWuXEvyXGZP0/oVDgl?=
 =?us-ascii?Q?qZIsr67eYrPg15KqZAZr6XA2ZPUYWTj6DMNJr2JGcysaIfbiN4UFDslCMXIk?=
 =?us-ascii?Q?r69f5c9A2TRZQR/O699YZOLZRHvLIfDdPfX6xBJtJvJSPNlEH0CEE0GGNeCx?=
 =?us-ascii?Q?UugKrdaebM9C6l/jKT9IUaSeub9e8uEGe1vaNH6s0uHaqzpBc3Hu4TbhR5ZA?=
 =?us-ascii?Q?hVLGMdn/iQwi0FMyLux0FHhF3/I0KCpSzS48woIQsmSZwXBgAiBBykMItCri?=
 =?us-ascii?Q?/hraxMZIbBXwjr6hFHanB4hwnljZrco2ghp0zhlahMldbkOrRFqfBSDfgnhh?=
 =?us-ascii?Q?i6mD6jVW2VUQWfQCIkJGaWk//s5Ckx6adFfA6jop1iMfuojfwQDjknl+gioT?=
 =?us-ascii?Q?K42iXicY0kkJBRcQuz6t4MCPbdAjNeBukodOOXjUeJ9CFvpVQqoKrgqt1BmW?=
 =?us-ascii?Q?q1HXNibNedKZhdUCMOIs3slgU4SkXHOds5M7g23+C/5ik/9VnUT0WGNSHR8f?=
 =?us-ascii?Q?JzmRiSawhgzM0eMbjFTXNC8cfptngerWf4IQWEC6AJzpcfWM9nHf6o02AsTl?=
 =?us-ascii?Q?+mYQg5sRykLbKulKiTCCFohMBLToQak4iAm4pkqxLTUTLptX7wDTuMPBn8u5?=
 =?us-ascii?Q?DJ0oe9Zmm2AF1AU4GQnO1OP9Q9UrkCKtTnejtUrquLHiNEwOLmeuUxi5fNNI?=
 =?us-ascii?Q?V0w9yN2ulfk39TjR4nxwqPM7Hs3bmWuIBwUGFotdBhThHxThOrHuuGrF6wgp?=
 =?us-ascii?Q?Ya3RIifdXc2IUIe6yNdsRre5MTcatYggSH6cIhVsZ9qXIj4P9oPhia/TjAcJ?=
 =?us-ascii?Q?Y0IMgsz5MheZevJCUKxKno7hY/xVT20D/9LdgOTer+iqR0CSvA6nbjUuS/Nk?=
 =?us-ascii?Q?prOCscxe9lo8mGLio5BFEtT2IcNWpLAlF0NRI4HV3/OvkPndu6Y/gfJ1TvSG?=
 =?us-ascii?Q?2kSYgMh1y3p6xoaNzyYypnqDWqTlobMSTfjjSOk2BK5dTJhYZ56usfzfp5Rj?=
 =?us-ascii?Q?9F+9vy4J2v4a19cPG4yhLfeviB+v53NZmK7LtRgdwH30j0g0zqYYEntu8LWC?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 273d7db7-86ed-4a04-3607-08dc0c495e74
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:23.8128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Owa51qVSISWfwUeP8MJM8B1SAhktVQ81msGjJ7VmocypyXV5B87dR+OwbH4aXV754l80gFYXuYGzlUlJDwF3EdDwJY2vZzmkV3HkybfOs8=
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

The first sentence is half-way true; the macro is always defined, but
has the value 0 or 1.

The second is outright false. A lot of code guarded by
MEM_SUPPORT_64BIT_DATA uses a "ulong" to store values, so if
sizeof(long) is not 8, that code would probably compile, but not work
at all as expected.

It would probably be possible to make all such code explicitly use u64
and thus make it work on 32 bit targets, but until that is done, do
not pretend that it's ok to override the automatic value of
MEM_SUPPORT_64BIT_DATA.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 README | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/README b/README
index 60c6b8a19db..bc7fb474348 100644
--- a/README
+++ b/README
@@ -1248,9 +1248,6 @@ typically in board_init_f() and board_init_r().
 Configuration Settings:
 -----------------------
 
-- MEM_SUPPORT_64BIT_DATA: Defined automatically if compiled as 64-bit.
-		Optionally it can be defined to support 64-bit memory commands.
-
 - CONFIG_SYS_LONGHELP: Defined when you want long help messages included;
 		undefine this when you're short of memory.
 
-- 
2.40.1.1.g1c60b9335d


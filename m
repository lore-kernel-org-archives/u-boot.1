Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B30C10F07
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 12:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA54B87760;
	Mon, 11 Dec 2023 13:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="OucNErNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A07F87754; Mon, 11 Dec 2023 13:21:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6202871B2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbsJZOZDuBWtEMLuHKB63v3lX7UUC1s4sgSwwXDGN6Yy8Mh8/4285oAxKDr4LIrif8ZXN2bWkR9e3YepGfqAiGtlAC+ytu4268EIAmL0n8APT78HeLFMBe83zUXMIevKo0zhkzdyO839yhJwa3ag3hao4AEZx6105HaDPAPXUiw72zm4g114Rm+B4KUz175NpaUdO1NJUwjmouhup0eZuq0s8ane18vRzIRaU/hSgoORY7mVOjRo+K2nDiJaURIiyfzy+VXiSeQ8VfKri8GvTeAy8KeursBJOuUhgiJY27KE5XcvZfFmWUvuxce2qtUC2kdKb28R08YTLfJxDJ5EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm41NzqUndYtEhnRadK56PVjs5aVfs/GqKh1fj/X0JM=;
 b=fk0pbe+JXVDvL8Pl2JcfMYgQPvGT3mmkwvSdrm9ClVbW3nTu85YLs4gJqrAnbnep4ayr/m2lHKaYn5Jio72GKsL6xCw3+X2oLgw7I/yvbeoQi8OnODodLehMuzjugpZvV8J6SCRA7nyTpweaRwloOR4GOWGiWAwFp/BimQ2N1AcgmATk6T6Y0AizqVU6nQDYfErpFSg4eDD07C3Ftra1dT2Ymd95QxEolexgtPX4eB0a9cpVjxqjli/2cOpoCAk9DORgQKG4qGvckuWJgnOMhIZIM6cYOaZwDqtCYO2GNkl6zSO8vGrMk8cWG65ahIRGko73zemjx/PN5KooCU778w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm41NzqUndYtEhnRadK56PVjs5aVfs/GqKh1fj/X0JM=;
 b=OucNErNF0yRufMlWF1UGjRrVs4vn5WlBe+uZN725Yp+RVROsQwzKVJFnzcMW9xaH6qZZX580OrXHGXlMEpImypxx5l3iyQ2hGt1l6VBMio5ZumdueZ/cXrxhgs90hF6R8DJdztd50zhE7NBPd9/YlvMa1gRcelUdqpBBKb9oA5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB8168.eurprd08.prod.outlook.com (2603:10a6:20b:58f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:20:59 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Mon, 11 Dec 2023
 12:20:59 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Roland Gaudig <roland.gaudig@weidmueller.com>
Subject: [PATCH 0/5] Enable setexpr command to print cpu-list like bitmaps
Date: Mon, 11 Dec 2023 13:20:46 +0100
Message-Id: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: df1e1702-3316-4f56-b2e8-08dbfa43a222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AK9VLDUjefEi39YYvHQrRBsdorQ8npt4EswZNSgHZyfIsfBnpLDRd9YtgthAudqu4MUTWyhfeo4skAI60igQ6qDCRHiHP9YfkLI5Cgu15Oo3/iqt1E7SsAicTIORCiCFjUr4vKU14Kp0hjDFZS1kwOumwEIgPeFuG2CE0qy80TL8kAr6oHsRrJggPd9/1fqXZFc1/jGOhC87sVuUt6K24Wpc3Bl4jQYwjHNPRinc1klXHQjZTh2v9NzfyBbTe0ZeumcBEOsH/PAi0a01o7wVJbahEOgw505xo/0ovtdhmkZaISvjODypXLUAkV0FGokdCsWGiwlAW+fD2JMG01VUfYsPy6e5OHHfGgtl43z+I442l4gxidw0g6FbTTNf4oJXvrHbfKA8I6oECmHHwmaC18lhrzPf50wCpd102D21j9u87+6g7t0DAbk4ec1BdGOe57A9UUz1VW/3UUqVl1sbU6PbX0CVWk1YG8WK6dlqKfOivRrlqfkMh5zf/PMJEthpfTu72HRSsJD9XCm4X7ORW4cSP6As1ZPbXUy1SeXy0FS6l6JL/jng7064OfZ7aS+hWJT5WzF9Jo1UdqhLIJTsdsPZ3XbmF4OpMveLcXgRo04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(107886003)(316002)(38350700005)(38100700002)(86362001)(36756003)(6916009)(83380400001)(5660300002)(52116002)(6512007)(6666004)(6506007)(9686003)(66556008)(6486002)(66946007)(8936002)(8676002)(966005)(66476007)(54906003)(4326008)(2906002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEcQVPm+TCi0k4ainR0JUkkeqV9WJHwXt2M0sRWXkoO+EB0K7m1PE5Gjbv7B?=
 =?us-ascii?Q?IUiW2gqQ665hYTBTmyjNbp5D7aFMbaUG9et/0QYpwBzVoKV6IqcbKxb/9iGL?=
 =?us-ascii?Q?gawYTMetxrpm5jQiH8PtUZ3IRoKUeagNDrLq56Kt9wSNWw64gN8M2Phg+Wlt?=
 =?us-ascii?Q?7HPwO9ljVpja+FxkseDDMf8Rc5TEdGn+2Dg3ZHmXBdrQQLCfWUBQlI3duO5L?=
 =?us-ascii?Q?eziFF6RGhV3mo7sGr93QSsbsvJP54Z0YPYtrGcc0xPWWJchL7OpWoKmzr6PN?=
 =?us-ascii?Q?AKeS02U47FGxeu8VCf1lxoVHGYkdEwcBKtCF2b5LkfpRfaMMqOQLbGBGW8L5?=
 =?us-ascii?Q?DS7415eQgfYM/HV/fZEl0TBMinyyTgejX+6h+k8ALo4M4zncUrSJe0PvDEqb?=
 =?us-ascii?Q?UwfX0s1ftVx+83hDLlde4W0xSlu3vIQf6rJnCGDGyjFdjvpXXet+lxZYJBsC?=
 =?us-ascii?Q?MmBQzaIiCAl8Oa/qOJERfS29usz6fucV4jGAm7UfUnVkUnNvY23sVW72V1gZ?=
 =?us-ascii?Q?qEGQtu4Qt/nYx8rkD/M0iEIlJ2KNlfGbkACXDW1jCqHU5fwt8LHCkyla+WhV?=
 =?us-ascii?Q?Kh8uKZ7k8D4kqiEary63GncuzTzrCY0Z3AgCeD8U72kSz5btNXEJzCOS8GIh?=
 =?us-ascii?Q?0hUM1kqOCJm5eEi044bhZTEikcygQOYFZQw9MLCAlB8yoLZ0pUfAq1r5LLDA?=
 =?us-ascii?Q?LHEq+WGNN3z0A/NmxZ15WT9hUVrJF57lq6SFLmpT+O1lL+ibez4wSJRsA4ig?=
 =?us-ascii?Q?p/Svd8vuRstFevgwGV2Dz7WleEgVh9sGOcIoUSZaqNPqgYpRAKBz86Gi59dp?=
 =?us-ascii?Q?++UBZbNnKM1QR9JhF+E1w3oy+AEXXBQ1PMF7Rxeo3NX8EEwguDLqmYdaLcJV?=
 =?us-ascii?Q?cb/cTzKzjsyBobBWMm9k3nnRx/5yINSvbsgB9uPgbV27yG0cDsePVyZoEYm5?=
 =?us-ascii?Q?Ma24Khkp0y6r0RHbst90bwegHlkQwqZtQk0J0md9QLxHF06dLYYIghvPcQFU?=
 =?us-ascii?Q?hRtscvGExkt1+IoL/5/e4nCddnhb9/cLE1TlBTUA7j6AlyUxECJ6mKJEy8MW?=
 =?us-ascii?Q?3EepsE0jENFf/Xf7y6t7cNVGHhbwEMRTprSSskeGziymDdCU9uBux82VIb26?=
 =?us-ascii?Q?EpGQs6B8LKQ0bGvzLnV+1RKMdyWio+/hFvk3aUekICGHUk68PrTxGqa9GMxl?=
 =?us-ascii?Q?VX0j6Hlk2L7uVfdg1OgyFG3nyGY/DLtEi646pELW2fC2GnfwiWoenF2++Wc6?=
 =?us-ascii?Q?EzcS1RgP0jpbcAzwaImmnA71icDHor/rJTYaHWzb6ILP6yDb+smMGclGHPEu?=
 =?us-ascii?Q?3CGyVLqxSzxtkTFtw4MpWl/IDiAZrqe+Eq0bcZZ3JEg4ynTk/NghtAZMtWpW?=
 =?us-ascii?Q?ltnI2KewI6dI4w2GByU5zmjj2BAR2LaMqexR29xmS9KlxsqfON8m7Bc97T0J?=
 =?us-ascii?Q?I+A7eIX3j7KyMYPk+4Ag3ITuoRlNlq0i9DAmf8oHIcrNgYGfna5bTEQ99sMj?=
 =?us-ascii?Q?cPA30QnHnpT7lZuE221F/R+7Zx/OnsGAlP9o95Ydl6GS3nOSdd6jdpaMozbR?=
 =?us-ascii?Q?Dutb9riNg1ODzU66bTqhga4tD12IhCj2k6qsmau3yf2oaE87n+a9EUZNGVaX?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1e1702-3316-4f56-b2e8-08dbfa43a222
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:20:59.4259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBMhIIJuTya1KeBmUTrY0UvPdkGzQKQXHhpobIJ5z/b0nbVGc1fojaM/MAAxWUuwxQshZ1a3es1yZDOe6j2w8g==
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


This series enables the 'setexpr' command to print "cpu list"-like
bitmaps based on the printk format specifier [1].

One use-case is to pass cpu list [2] based kernel parameter like
'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
the kernel via a separate firmware variable without exposing the
'bootargs' variable to directly.

Example:

setexpr isolcpu_bootarg=%32pbl $myCPUisolation
&& env set bootargs "$isolcpu_bootarg"
&& bootm

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt
[2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html



Lukas Funke (5):
  sandbox: add generic find_next_zero_bit implementation
  linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
  test: cmd: setexptr: Add tests for bitmap string format
  lib: vsprintf: enable '%*pb[l]' format specifier
  cmd: printf: forward '%p' format string specifier

 arch/sandbox/include/asm/bitops.h | 16 ++++++-
 cmd/printf.c                      | 29 ++++++++++++
 include/linux/bitmap.h            |  7 +++
 lib/vsprintf.c                    | 75 +++++++++++++++++++++++++++++++
 test/cmd/setexpr.c                |  9 ++++
 5 files changed, 134 insertions(+), 2 deletions(-)

-- 
2.30.2


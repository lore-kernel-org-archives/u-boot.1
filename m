Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3477C10F07
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 12:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655B287756;
	Mon, 11 Dec 2023 13:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="nWbXgKCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107F887765; Mon, 11 Dec 2023 13:21:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B40487751
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRTzeEBZl07TD6YX0uqmdUkY5SNhjIggPvMf3optHFmEMkWFbcZK1sYg/m0iRmU7K+kBneYi2VymGpNc50BpIFIYQlf9PPRV7ZA3JKgXXx9mYavG/FmFCst+6BniT7rStihUpBkxCBfO5Wo3Wqct8vzrBTSDffOhb0GXVUxtAoELPgN9yJX5HCOS9r0mQ0BC+r5m2+sae6gObl5RRwmnA1K0H4/d4G0dXMVEdRvo48aUNqmjTJfhV28HTLbt63Qzi3/GOKFx3tPGL5syub0b9zYyp5Yoom5kdZTZE4krxWiWl7jSfMlcWossmDySc2C/m+gN4x+wZ0Y0JdfA4/0yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=indKqBhLelG6FrygwGUwKHPN1lMOasaIyVYsp3KiezU=;
 b=BKncAMb8aAA6KisMUgi1FLcIAqecqnuHxXkZeQrcIOhR0FEQoxC6IlAIg07gBjkTj80yciKvft8Xr/dANyx5vGGLTw0L5lfCAgufoR8S1lTE5BmCOitKh7g5x4Vg7eRNkuFaYp73NwD+Wri8BYPIGraEhsey7N9htznqA9MIAx68DCe9UmvXYSNAdSVmZ/+III+1U8lwMVZZTiHadBNdPtXqvkjBk5QITZbQSSraVJaO98UJWyNxQ8PTC1DP5yHqWHI16XcwVurdrkPO5Xe63QTOIJHLoOBP1bCw4GLqCVZDTtZRTVk+FMw104hGlUAcFSD5mak8Lnw4j9qGiWOOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=indKqBhLelG6FrygwGUwKHPN1lMOasaIyVYsp3KiezU=;
 b=nWbXgKCqkI6okG8CriIarexJvpEPQWLkvkc0dGQVJY3/ITLXiu/AVVqq/17SU2VG4JVgpMgzCINpOg7SwG/T1KhyqcAhjAeJfKskTq8VlOsiUQp2V6pyzf0tEknVXAgEtWmJVR5D96sLF/BIDMlo9unnbnW2nTaxG2wMTDP/Rbk=
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
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH 1/5] sandbox: add generic find_next_zero_bit implementation
Date: Mon, 11 Dec 2023 13:20:47 +0100
Message-Id: <20231211122051.1240855-2-lukas.funke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18479101-51bd-440d-eb79-08dbfa43a25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu62KhYbZ9MbYg+lN6KFWFtTe27vSyhTzUDBDfDtt8VjoxueBiIOsUXrg6OEeSoKGlhKbbfGYwdoA8gEGHZiGUCUMynEDJ8GfPNcEPtXiCT3/In8v9uopoRXvGTc2MI6K7MVPySQgK1qJ+aIdwJG440waaVHCvA7gVTG+SdzjOrYd6YFBnHFI9kW7KNUZttUgyEElZadGqHyNzn4hb8s9gFSh3h6fCQAk5Zm2OdSJ25JQ94M4GsLfnukkEGFnrWrj9PNRfI3YFNNfKSu/OTZmFJQB6jDXuPoaxbvFkSswVD95Uq5ljWnStgpmA13UzhxZ5FqMRi8rSg63dmzpDdoEuG9Tn7Qz2RdYD6pdn8p0P6SIX9E7sqXOKd8xksolzUlgcMe1G6tcr6EpTwa9G9B6aVZDKINMq1SRUaPS0hG2UeuuOB6Zj8uTInmWdar0kI9BEHNg+UwpltFjUSqQWxaodfmnCLNAU3SMgXWGk0CUUfUIdwSToh2D3rITz3V+/u0XXy5WUph2C5Iq1vIe0GCjIAIgSg+Yq7FFC92kN7g6unJcjGZ3FbEFE0tG7qKp6nD+Gh/iqqdAIj+D9gslR1ohAhMB+YSLoyreFFetleUQPnntjt88jyy2krvk+iKjVAPJ3WjvoE+YZm+YkCE70aruA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(107886003)(316002)(38350700005)(38100700002)(86362001)(36756003)(6916009)(83380400001)(5660300002)(52116002)(6512007)(6666004)(6506007)(9686003)(66556008)(6486002)(66946007)(8936002)(8676002)(66476007)(54906003)(4326008)(2906002)(41300700001)(478600001)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fiapGU/56NsrqE2ZSIuJ/nyV4/KKOEunm90YiqWltllnnlDxjG7/3zB71iQo?=
 =?us-ascii?Q?crwnbkT0Cp0WcNY28kueUoczs4sT2udJ+7cWgdF3E1J+IZlH13a4rpL4InPv?=
 =?us-ascii?Q?DkkxcMlY+mcHxwA4kXnCAbnHF8BUeOI3iikfdtZFL+PMbEBiYGJHHkSilx3e?=
 =?us-ascii?Q?UbjV2j42EwrTNemSjQGa7AxTn0T3l84kP/2/XDsz3tmWdPSE1jndY6nrsNr5?=
 =?us-ascii?Q?tciZUmxMk0jZ1qs7qhvE5wx7y7/pJc4Enifo6y6StWs294pYQDwNu5zjWdT8?=
 =?us-ascii?Q?BEuDhSNqvAKerBrXHjxrXAdKvyaQjfojTnc0pmWKNofF5eW1iOxNdYCAz18b?=
 =?us-ascii?Q?84VfdjYPjhYGvrzdl2MfPXRyofcTNFieS5troz2nPfkSIL5Mfq1m7wRxCOn3?=
 =?us-ascii?Q?QwxaURuiy0ZlHQrD25cEkCsK0BJp5uhVkrTkj1Y4npWhp9jCnQxbMugD6WlQ?=
 =?us-ascii?Q?Hl46OxLQQMPtrB0CQFQUB10wbQP/K/UzNrfz9Jq5DFVQeBbKp1+/BYuB2uKM?=
 =?us-ascii?Q?JX52MloLGbA069BhNQW5nEiKZYbvsJFqUiCviF+63yfXoxgH4Kmk5hMTGNoh?=
 =?us-ascii?Q?FkXKVcR4y55fb8Du8UUJo52Jdf9dsCVsO4xYHDSIohT7S6ufNhAsB386m3IW?=
 =?us-ascii?Q?UsJ0+ntsIUh2YDfjy55eWJqw6OYad3u6+2zR5CKNxydOOy5phWIBW6wvZPsD?=
 =?us-ascii?Q?LXnbEXodOkBvWXARHWwKCnY5nMezYdL1oN2Mdi3yIb/vJFM4u1U9Z9RChXsa?=
 =?us-ascii?Q?Cp9mokfHvF8mGXA1JYycT389ypDltmq+XUsy2CD8rABJKjy3So0kcSJEL54w?=
 =?us-ascii?Q?YMIbGrXLUV5L1x4JqCv2atGJy8lpGBtUKhxjZ8SvbERbk7uq6SkxW+jB2ZGR?=
 =?us-ascii?Q?DVvUVzXuOSfqOUHFMC7rAnmUj2v21nx0jeu7rtIsvdmfn4e+YdU0QdRifKf/?=
 =?us-ascii?Q?buMqBl3WkZPawit9YSQboK55xevhSwPXzT8UWKnn2yozIM4mnQ7febDZELDC?=
 =?us-ascii?Q?2AdUtdLAIhZu8nHR3FA6WaLjhG0MEATRrBSP3HGpT4Ero5GXZUNdQdhXWque?=
 =?us-ascii?Q?OeEXorNUMEpcCUi94AFQb0GYCbl4SXfj3WndbrH7AP70fflmAnXQf2HBPFvw?=
 =?us-ascii?Q?lzrXkj777SCr8NiRtuMOBjVf8O0qjSxsISyeX1at3DfeGqbR50nsPm4L4iU+?=
 =?us-ascii?Q?4S4w44MpyEwIykJPKUJOLiAzD/yu8BI9j3Hc5KgZKgoJaRzWp+k+zbkukYUK?=
 =?us-ascii?Q?s08CtniMz1xJYldAfyCAvicamSvuue6opWNSgLAYYHAcEPO9Jaje+5xncXxH?=
 =?us-ascii?Q?LBFRU3gn/iRN/lP80d4TqdoH8qa/tq4wT4OQ2HyllDlcKzZcWrjETHiRwo79?=
 =?us-ascii?Q?v6U2Jcy/PYU0f9yGG6dW9njsEQSGGQdKFSZXWmJeIMHRIesH4OK/64hf5DD8?=
 =?us-ascii?Q?gBH3YGBuHvErXHHRorNR2Mmbbh4TStevit0U2ewzDmBeaGN6k1sDw+tKI6yv?=
 =?us-ascii?Q?+LgYMKyFSgKh4bcehqcvrzbZVpC+6opv6riqS0a8CGTdzY7//XxJPx7yXy97?=
 =?us-ascii?Q?YoYX3TCpSsWL6t0G+iie8T8u9jcQ7IJ6XQhicHbax/3IBsxrbzUk98z7PDO3?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18479101-51bd-440d-eb79-08dbfa43a25b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:20:59.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs6ioIONbWhn++TOf5Ie8Dl2BDeQFL0ecMpt7urom6/kjXgVCskB0EbZm4utuQRJq08AAnuroHxcHMSeT1dStw==
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

Add generic 'find_next_zero_bit' implementation in order to enable the
use of the 'for_each_set_bitrange' macro. The implementation is currently
missing for the sandbox-arch and using the function results in a linker
error.

There are more efficient implementations in the architecture specific
implementations. However, for the sandbox the implementation should be
simple and portable.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/sandbox/include/asm/bitops.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/include/asm/bitops.h b/arch/sandbox/include/asm/bitops.h
index f27d5e98c5..453ff005d2 100644
--- a/arch/sandbox/include/asm/bitops.h
+++ b/arch/sandbox/include/asm/bitops.h
@@ -104,8 +104,20 @@ static inline int __test_and_change_bit(int nr, void *addr)
 	return (old & mask) != 0;
 }
 
-extern int find_first_zero_bit(void *addr, unsigned size);
-extern int find_next_zero_bit(void *addr, int size, int offset);
+#define find_first_zero_bit(addr, size) \
+	find_next_zero_bit((addr), (size), 0)
+
+static inline int find_next_zero_bit(const unsigned long *addr, int size,
+				     int offset) {
+	unsigned long *p = ((unsigned long *)addr) + (offset >> 5);
+
+	while ((~(*p) & 0x1 << offset) == 0x0ll && (offset < size)) {
+		offset++;
+		p = ((unsigned long *)addr) + (offset >> 5);
+	}
+
+	return offset;
+}
 
 /*
  * This routine doesn't need to be atomic.
-- 
2.30.2


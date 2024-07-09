Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A5EC3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 12:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE7A8862E;
	Tue,  9 Jul 2024 14:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="f9wmjKR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27768885CC; Tue,  9 Jul 2024 14:21:00 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02olkn2080f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2e06::80f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE4FA883F6
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 14:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXwpOGL9FpGneziIgcfral4gky6ZQvBu8kZ6EcJD+roFbhlM78jWLjV49+SLyh9zsDz1eqMBa/0h072OCJOu64Gljfd3abgtgOen+VvZ7CSBMFAbfOqUri1rzuBX+30jkbtv7JRfoS67jD6oG+TtNhMlz8XNFVkntXx8l3IaBc++hsNOe+GXihH6ThIgioICruWHY9B1/1cX+smlTcIP8cgljJlHYo8h/88uKWFU9hhuoLrbVYkXvATWuoXKUm14e8SqYYMTTn9WusBfEGs6X2CWTKVsOWs9jsKa4GyTh5q1CAJ8/e98U3X8HrPQMAs+ueedUeszwej23v7cMAYpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJoiUClWb5uV5GguUv4TMYgSBOYrJHNI+dzwT50+4A4=;
 b=V3dWyvVHVE9MKuyQh0AFhr8J6ZR3pP112jCCo15CF1Rh0Gea8DJHsG5dOF+8eTZRdsAwiQ+HP4RBMXTtSS3wuURrNMn4RPjM/NiZvwe+CrE8sHyzb0lyr4S6i9mdKqBDO7xlwDztLoEXtCYzT3G7H6UU9SkP69lA27mj8HXzJUqFww3x+VPTHQEomZVQ/YJBQxvnaIPFPob9KAR5FIGv91FWXN/YZdtSDa5Fm2Eu1ZavyCovqPDzo5fh8LYxjgcOvMCJjp0JmKt7ThkSF3XCB9hJoO4ZygNpeK8NAjcyPiq3UF7vOFq3I2iBwSN3mtqyXnGRwyzeyzlNnsqvFGUCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJoiUClWb5uV5GguUv4TMYgSBOYrJHNI+dzwT50+4A4=;
 b=f9wmjKR5qJVmnmKtnIcWxruQBUEplFufPvSQUV+sjI4bVBm98o0ul8GI2mnRLuCqqKdAheBMhuVB/li4gkkK3xGHhoCXbJEnWGGsaq4fTSnomsaalgCzLDmj1ar+vRiveJmKfqhjIjEIE6x8Zd32tGtA7rzpEsi/9aNegsXvYFqfDnpOH3YJ3BrMqNUaVYJulZKFrctnEDHQvC9fVx5DB9vHDC7BFFUsSxNfz3HtVWWT2oyETYsKPYEtWJftt6d5eDNEyfjYgOMa+1M/N446B8ye3iwZAqH3Oe/ZcSKxeJYuPyJH7GkE7nOmTx+EW82XpX4kh/hlENtNdYMRoo8Spw==
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:337::6)
 by AM9P194MB1265.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 12:20:56 +0000
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::3a33:7614:4563:6c99]) by PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::3a33:7614:4563:6c99%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 12:20:56 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: mbrugger@suse.com, pbrobinson@gmail.com,
 Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board: raspberrypi: Fix format specifier for printing
 rev_scheme
Date: Tue,  9 Jul 2024 14:20:48 +0200
Message-ID: <PAWP194MB20554D5B2D9D47E02E35F062DADB2@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OW3+4x/ggnxck6W5cClPMrtPs6V/f7GIHxO0Q3edAeU=]
X-ClientProxiedBy: LO2P265CA0315.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::15) To PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:102:337::6)
X-Microsoft-Original-Message-ID: <20240709122048.681219-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP194MB2055:EE_|AM9P194MB1265:EE_
X-MS-Office365-Filtering-Correlation-Id: 5deb428c-4e5f-4775-23c2-08dca011957c
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO+6OrXo4kWSJtkKN4Lw3idvj65aNYqLBn3oxnCJKr3QTwM4TPXJY79hl55u2E/M45tszCkcSX1xGu2X4z9Foghwbv58MBumZo3Rf5RoG/ywP7hW5jlkgkyIdX1y/Kmj80ELPiKU264W03SId1Yx8YG/P6wMiSRyAxlaxu04neA9W4CokoeqaIkoCX9rq7/OotKCYHKiu5ytH9wDDoVVSPHpDD92Eg8tE2mYX1npE2/r+OkAIQnmyhJ1BlTCmX9HupAXR798OyDb/eRC8bKUOkFed6BrY7lr300q5RZVDeEvf61+aY0yJcRKac5/MVYZWwIy10g5yXBial/tH/BPJB+wssjy5vP7Q2Rv6UqgtF/+z1P/1CJOCWihm+jr9qjsbb/jIfkkl0VUAV/Is107YBdcJX7Ymo0WSjfCQLEGTqmu6F+FZtmZsZ1MyFQHdYPEuL2YltTwgWHu7yEF9QormZU9lfexAnmfvWNPRsE1YsTFiaVQkyzwpsv4ZFkyGpOSF8vmaMlGTO5M0iYOR3YCvHrEy5ukIEtJHU3/JSFYbGRD8xc0I7j3qctN1XRkS7rTYlCqiM6vAwpP/IgFbgV9rju/RWXT5dKGNDtw35olnorZ5K30WF85rWSOOhTkS9iebYiDEicTrR/fB/zGStXvJx/dHEBRMdDenbguHRiRESjnEGV7yPabackstSa91cA7XEr+bgkqykax2Q==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: 0ysiInwop57R3efjJDWs73ke1gJlE1KUzRlQdJVacMLaWyJK/a5fipFaw05yffatiUQ3LA1PCbOTi4k2hjjWE5LHUDb8hm8A5Wd4Zoojqyy8hhLT5sVBWjBGu4o9EuvSaRumPUhairsS2WV4fQ+EIHcCBj5vTrb+iuAAf0oVyZ4PsL46QWP9uz1uT+NHtZRWE/ioBj6KRC3Nr08sC2iDY0lI6wmsFPtwuEj3x2oRQSYF1St6Agd7x9Q5FEBFaqruCylZ5L1Brk4y0IQnGyl4AWww7sI/L84A+A61RYmpMFI53Zr1FQozCFsZM9kWKtnuna0HZI6JOYPF6ZbDl3beA9RZ9AkI93mo2DZCFFhdMFmr6ONflaCoJlYDeIfph/fOOTwZYt3BSpTcTZ07v2tC4oYD/GR8EET8mOUh4SGdeAg5PxqhhnWDl5RuKoi/EHatQ72Yv6QBvuo0pvPl1gQBkLDUxIW0XQT8f6467ZmH9rYPCw2SHPfobzrWWe4uxN7o4VbYTl8QOa4bt/ljNk5Akc8Y5f6K+liE0EZHUW/rLLGGUYht968kzVnRT4fU8V+mt6LSubmWsm0yWy2Fl5ThQOgQplAJb7M8hFfF1ohWCHRWrNbeOuDAtkqvraphvL/L/hm5zE9JApxdWoTiGMrO0TOWPVnaACcMBSanOFWps+V5qYlEMqfPZY8M93ZUwb3L
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7g822qaa1/Y0hRZdT50Bov+1LNwG9Qzgavmy8nTFJMuM3hE0fS9DIX/UrXoo?=
 =?us-ascii?Q?f66wQC5GZlvIakUrllVgCHJDq5v5IwojQlYIzIsfysF1OU1FpHCL5hoCaoYn?=
 =?us-ascii?Q?uZrGF5aG2yIr/5A5kXvT7iiyiOCJIY/xGC6ONeAaTqlCHT9dWhBkVyiXG5la?=
 =?us-ascii?Q?S4xjeOgWakGuws0MDmCCvLRUnJIkkGiOYQqqCHC9ae0Epq+efDJncqMHjJIA?=
 =?us-ascii?Q?+UsCj5UYr9NOOdqroG1uRem41HPWyJVc6gfFkMbLeXTB6QGRJNJ9eRdr1Sq4?=
 =?us-ascii?Q?rgi1b54ydDju7VZwtVhHKJbTR1Md9XjMSlhYHJEM11rIL//bTpFFPI4dIyOA?=
 =?us-ascii?Q?qjW53Y+e3HqnVknWxOorTwAN0LvRh/tzIHJH+EBq3T5CamKcek+5itneHcIn?=
 =?us-ascii?Q?gy1m/rfB8CqB4Zh9z6fgXB6fAOhbvgcEuj3CRHscn9dkONogEI3vLRrWz8OP?=
 =?us-ascii?Q?J47oWpc99KF13Sokix11mXdNiJIzSMd0soLWEP+XFLTzjWYBeeiqqpnFE+Nw?=
 =?us-ascii?Q?ck205s/1gFwrq0kRBjyqkZLp7WAG0dUB4RjHVxh4/KYbpukT5lmv/rrk/Yp2?=
 =?us-ascii?Q?r5S+pnqMOp1YpSGahZiCoq3K5nmnY+Mx/a0KmIa4X+LeoBpDub446QBc5Ugt?=
 =?us-ascii?Q?10WeqrgTj9gb7HOAH8NGl1dltyGpW+RbXE2WsZEp6mfcpcblfi//KlstMJjS?=
 =?us-ascii?Q?r72BlJpHBahsiq3mDiBCDcOKe1pAeVkPgVucarZCqhgJL3mo5Y6Co4RhfCz+?=
 =?us-ascii?Q?iz5NaMJ/krb9Au8CoC/HCmMY9oQK0brkAkgECYK1COCkwWYVFZvtLk5+xg3X?=
 =?us-ascii?Q?diFjjjZES8/bxFc/nX5H0U84XvqpLOa/QkiojhIvAJEzc4tyHf5g9UVvYk3m?=
 =?us-ascii?Q?4B+Ukkadh6t173cWchmb+P+nJWH0y0CKbz3gBAiuY5C5lDNJ5Mvhom2Ga5f4?=
 =?us-ascii?Q?4skUev2ptPcxn9LUEEKh0oxo6Fw6qe6bxawrv7lRCsAiFaoDUsiWpeh2lc/8?=
 =?us-ascii?Q?nyvI5mj/9w+UNHo8LGzjfU7IpJCmP5T9c76jynCazB5+k/KG3j8wI4FJ5pNC?=
 =?us-ascii?Q?7QhVe6TGDS7KcJB14aJLah3NeXUT9TcL0nWDewNwa6n5qPhQhoQPsFqd7uM+?=
 =?us-ascii?Q?AFfeUxDTnTDatLtSMpct7RjXflVIXE24eF4LSGatCb2a0f5Xo7hrbC8IWOQP?=
 =?us-ascii?Q?/YcFr4dIJ+tdLKphO+JrWqMImNsqOWRrshQRbUfE0e6IbvRUCphKKEGcnm8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-43ca8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deb428c-4e5f-4775-23c2-08dca011957c
X-MS-Exchange-CrossTenant-AuthSource: PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 12:20:56.7369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P194MB1265
X-Mailman-Approved-At: Tue, 09 Jul 2024 14:51:36 +0200
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

rev_scheme is an unsigned integer and must not be printed
as a signed integer.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/raspberrypi/rpi/rpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index d996eb0cf6..caa4483117 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -381,7 +381,7 @@ static void set_board_info(void)
 
 	snprintf(s, sizeof(s), "0x%X", revision);
 	env_set("board_revision", s);
-	snprintf(s, sizeof(s), "%d", rev_scheme);
+	snprintf(s, sizeof(s), "%u", rev_scheme);
 	env_set("board_rev_scheme", s);
 	/* Can't rename this to board_rev_type since it's an ABI for scripts */
 	snprintf(s, sizeof(s), "0x%X", rev_type);
-- 
2.34.1


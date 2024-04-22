Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE686C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 13:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903FA8879C;
	Mon, 22 Apr 2024 15:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="GJ5OdSPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A92C88415; Mon, 22 Apr 2024 15:16:29 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0701.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9ACC883F1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 15:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeSuMlelIrqH+uLrp9rjKs5MeP0yDP8FBFgex7hXnu827MycMmx7ADkRGxsxgpC9f7vV7X4/99cRdb3B8F+c1nK+D72OKTAMlotJ2NPngbpIN7ieuDfyoDk1vG0qSKOhA+4WWXcUPAahyJAJqsI7PiMPWNBMp0TgTFz+Kl2YRBsWuDC24zdBWARSQXkbfgagVtlSFXJEIQ6artaAtw8PBlFPFscI0bTdf1z1q5XXpwVVmysRF+vIQbRz071lUtZfDl0u3DNocPq0pcZbObwBvLOnqGa0qDTx7+uYG3y/r1GAXv30S88LdQ9uCox8omJGuIXMDT2qxPlh5MYnF5gjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLFdEuYkVvZbLoIzY4CjrrEHhqBHa7kL/1Rx/06Z0C4=;
 b=k4g9PUDvKNFQ8z1oF1uNvTM9zavbg5E9aMc8bxdLJpUilGT8O6Gp0QJsVAWRXg5ohEExuK0GwPp2nKghUWx9WcuSNmCrcNp9+jYE4zoeZWwlDSXzSOg5VPMOlngevEiGgGFN1pcZveP+Zks1iheAPz3quAgGtAJj1uXvvF2OyBLZ6SxyOxGVE2sOHPkizp2+efBW15tG4KcdTWw5BKudNMODj+UwKuoaYImSCJbfXgYBkLDFYAr20ehJoPZnLbja45ti0tGz7Im3KBdRzJHDFqaGcBRvmEPIx2B+MrIMyOvAL8WppQ0TV5APhTXQL1tHG64eDnskDCcQcNl201pRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLFdEuYkVvZbLoIzY4CjrrEHhqBHa7kL/1Rx/06Z0C4=;
 b=GJ5OdSPphIZe9SgLiLPVGCs/xlSERzEIrod4tUkwpOpL3CtU+TIx3kNBrS0iwmRi2yFNRua9Vjw8xDnNRw5V7AYG5o6rT0ywhbUMZrs0VTYWrbW1/eFCniFpZ96eViopnqK8OtpL0TQLKRysmuxqctYz1+OS8rTz3k6Y/Q2ty38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:16:24 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:16:23 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Green Wan <green.wan@sifive.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Tom Rini <trini@konsulko.com>,
 Vincent Chen <vincent.chen@sifive.com>, Zong Li <zong.li@sifve.com>
Subject: [PATCH v1 2/3] board: sifive: Call spl_dram_init() for DRAM
 initialization
Date: Mon, 22 Apr 2024 15:16:12 +0200
Message-Id: <20240422131613.84304-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
References: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: a5742d08-f851-4e8d-275e-08dc62ce68a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tc/vYIBHE5X2VgYhNtkueNx7eDryVKtqr8IbzX1MM225RehqCbDPC0nx60JY?=
 =?us-ascii?Q?1nVdJ14RAyXWvg0ZocnqlBtp8l7pp9DHzjsM/N445ldt2gnb6gQ1QfKZRd2U?=
 =?us-ascii?Q?O5Zz2BY5sGgVtEn8eMNtzkOpbPehkrINlTX0AoaDRB7uoSsA4A46VNqatRlK?=
 =?us-ascii?Q?1l77Z+u6cPmWU4rcMJoHkxmyxWV/M7dAmPl2T7Iido3fA3K3FlSynOXVt+um?=
 =?us-ascii?Q?fgQsnRPCyFdwGrQB8+M40HJgL1sFRdZAwK1aofwUHylr2j95fWNLJwUrevX/?=
 =?us-ascii?Q?HCTgdKe2sbEFFgz3JNUtNM4ltmDcgz4h0fc8B8lDJYSLF4+CHb/SAZxQHnJN?=
 =?us-ascii?Q?hzrEysbxTtQ2NbLsj7RmdtsO94M8gEMtBwupxEKLnlxRy26ey4qnAs8yHmsF?=
 =?us-ascii?Q?wMkS/03m0YPdu7iU1VTlKAE9oRskS9qm0IK/t7HmW6HGqU4kM9cBDX+f1Rl9?=
 =?us-ascii?Q?qC5UYz089cBOdp+21rvOnzBgy9So3ny2CC+ZW3kKr14l/G7AiHw+1BJ1O72Z?=
 =?us-ascii?Q?mrDCDyW5MCxIs8HTQeguB3S324S6tmfKxitn1up9vdZMWYVjlJ5eC7qMnQbG?=
 =?us-ascii?Q?4SxBG3wvz+Zun1oZ1//s+Qv/ofiX/EFATcAAj0zLptoG8kohQdiLynjc5EaP?=
 =?us-ascii?Q?n28U/j3ap+H716/MlmYoET3Rb1KXXMk7zrLmh8TSDM9Wey5igkq5ulfw+a9o?=
 =?us-ascii?Q?7/UyJ9tbEiiixjO3bJkxbQ4FmpadufkkUVnBH7h2SLhwvT+9dc/coxv996c2?=
 =?us-ascii?Q?XcSxGJHPOjk9Mvvl9KsED98xIpt9w9XfNW7UNerGy3XWiK7hZGxBBZ4n51+x?=
 =?us-ascii?Q?tS5abXhDRbiY+qTtgb+7zoxr7+fCVuZJoY41Y9wP3CHij64Ob38gfBGEztBB?=
 =?us-ascii?Q?Co0p6K2Lj9bzTN5R9p9vhVxowhAo8Hcc8QS/IJz0JFBl6RQgiasKurpACBeu?=
 =?us-ascii?Q?Zk+hJC4mnfqr4ETWfAAAobKON4GlqZmbAMww+nVg7su20KR/HeCxwOzwwEFy?=
 =?us-ascii?Q?YAsx4Yk3s8QE/62nPEwcb2El5Q7aSjVEsE0Zm7/DCzEDAscDa6VVrSULk0+G?=
 =?us-ascii?Q?Ud5uvoxsmBDMNiG3uEIGGWC9H03VzDXbX993f3sLS1kCu7BCAwwfLaeOaiPx?=
 =?us-ascii?Q?U6Eae7T8CfU+SArX3JtfVIkEQb//UNE/5+M1EF8wk9IH+96b9gHNLye24Zl9?=
 =?us-ascii?Q?ZoMUHeI4ugYF0dDorOFZxSP4dk/g0TZN0DW4WzHRBZTmEKuJsiAsWZTLsdjy?=
 =?us-ascii?Q?f6K4T+Kt5b3h8qgretrddFYR9DRZIfcBXCob3zZzn0kj/ClUtgvtZ7n92Msf?=
 =?us-ascii?Q?/36i7CK5Md6rXhyTZVYxLsq5ISqEmHgG7BaRG3Lm+QYi8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yeUna/OkF6+GpJmOgsLTC5aAhnfAvf48Q5VvdQiUSjNPhUp5gvSKbfDV/Sok?=
 =?us-ascii?Q?oPWPgOEiRCOdkUKg6OHcK4leSbzbygAT6xqLbnw3yIZk8a1PT5G9gFcfFLOC?=
 =?us-ascii?Q?llbE1t0if86DsosbPiLRM2/uiucs5z3jkI7DZ9To3VZknGf5fxC/0y35eRmn?=
 =?us-ascii?Q?DqxwOimhtXwUc3TAYJ8LDSp2qSJs2KuTDvwTXVrfLFiFZoTOH7IgO0q50YIg?=
 =?us-ascii?Q?qEQX0fu2XXpaCo8QgGsWcwjb009JWmimkT8tOoWBrLvS67D4TwdsK1sabM3f?=
 =?us-ascii?Q?fMVgxoNZQZHWClZybxzY8GI/kjGg1ZoCLrV7EkQzxMJqwc7T/dUsh0xq1lfI?=
 =?us-ascii?Q?SoUQKpZP5R7IfhbMqVN14OH6EDtugTxOJ/0jKeqqDTt16Pp2B8mcvCEYHwO1?=
 =?us-ascii?Q?q55YPM/xdUekKYHkJy2A9Wa/xjqJYKyU3kfVUdunRw/UxILGP3zlqVxevf1Y?=
 =?us-ascii?Q?FMNUxZWU5iYG5CUyL6rGOf6hnb9865rd6c7jShnF1d6YrW0VNuKoK96BNCX4?=
 =?us-ascii?Q?VUMswj6rdBSdgXdMuI6iS0dIdKEABzTsQJwtO/p4z+OcP2prCUtCXAwphe2I?=
 =?us-ascii?Q?k6RGq/x5JFwx+9CLp4sku01vacrk8wII2sNrZGkYXPmTgqkRIEDM3T3dt8SK?=
 =?us-ascii?Q?7Pxf1+DxfWv++IFiAUZrSTEHy6COB1od0K/6tCwjzFFA8dckIaWipIstcUnx?=
 =?us-ascii?Q?8ERvlR2PdNKacmNROHu4eGlv/z97ktpKVl19hAJM38CZgyOuEcj6IAkdW09i?=
 =?us-ascii?Q?uxxS10VjjhHSpI6qDibOqixgfvMtvT4kdqOyxxtgpLesWtYjp4GDTlbunU7/?=
 =?us-ascii?Q?EtiS9MmmMITFhqmOvmtlwaUyA3VtGKIapsaDtfDA7imTc53kuXqFbJVXIsjb?=
 =?us-ascii?Q?oPGCz2zo8FecgT/EKgQyWInuo6xtsahoCehupOPcZ+mgvWqmGCxGMzvhea3i?=
 =?us-ascii?Q?GEE/JjOfRV5My5qvyvMD7qt7Bs8P1iwbRZZ6qgtG6x+swLDATNxn/lgilkTj?=
 =?us-ascii?Q?4Xo6OotYf0WzggSEabnXx9nPgwYxEU+ngN1b9t0ziuubyB6AkhNA+xwxHmTt?=
 =?us-ascii?Q?h65f73c2PxKtQoTlWuxXr80TbvBkext+/Zx7D0jselEfzqYXniph4rl+qUor?=
 =?us-ascii?Q?L1IS7yZIz9OR+YHODLN87KmnmMh3/iIBcfRqADxmYTH3+6jWfyId4Th4Swsj?=
 =?us-ascii?Q?ZsXQ4SqQK/bMlI1F0SSQf7Gzgkuz7MA4AXupcbupng2y8TPBMtpawvlEYn88?=
 =?us-ascii?Q?uo2SERS1zCvg7QqqpzJ0e8tN1Y7sNp9j1l6tJD9k5xmeV2G3AXXSHZIKsntN?=
 =?us-ascii?Q?MncUrD7YJMYUVhnF2DUxKv0sv4CNKaX8VSm1HsIImq6NX1wWwVwlBTsV1Z63?=
 =?us-ascii?Q?SgTMN21fj+okxRcpjX4aTJ8Ond0HkJsSd4r3/qFAF2EmE1OmztzGO5KypMPS?=
 =?us-ascii?Q?jHTdW0CvEXu8ZHikNa++Xm7l75Z2jSa9hQW+IAMAFoNUbb1vP8I6R4Rvly06?=
 =?us-ascii?Q?92Fp/cMZzCz1STTtriBPA+nvA6yivKhYWy62KMGbp73i87SlzhbOlEgqxjBm?=
 =?us-ascii?Q?CQEGQ79ug0QXS+ZVaWM+Vtaj71vtWhTOuv55b0Cz5kaNtgD1M2pa9mHIsWsS?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5742d08-f851-4e8d-275e-08dc62ce68a5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:16:23.9385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TmDshZds0fQbggiERB9Lrt4GWwi6a4XM1JNhzEFBQG0q4dyyTFha7pq78ZgbmR1GExmTVWUKELS4I2e6cBo5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5620
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

Call spl_dram_init() since this is commonly used for dram initialization
in u-boot.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 board/sifive/unleashed/spl.c | 4 ++--
 board/sifive/unmatched/spl.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/sifive/unleashed/spl.c b/board/sifive/unleashed/spl.c
index fe27316b2d..d6725a0e0e 100644
--- a/board/sifive/unleashed/spl.c
+++ b/board/sifive/unleashed/spl.c
@@ -27,9 +27,9 @@ int spl_board_init_f(void)
 {
 	int ret;
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("FU540 SPL init failed: %d\n", ret);
+		debug("FU540 dram init failed: %d\n", ret);
 		return ret;
 	}
 
diff --git a/board/sifive/unmatched/spl.c b/board/sifive/unmatched/spl.c
index e69bed9d99..500f484844 100644
--- a/board/sifive/unmatched/spl.c
+++ b/board/sifive/unmatched/spl.c
@@ -134,9 +134,9 @@ int spl_board_init_f(void)
 {
 	int ret;
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("HiFive Unmatched FU740 SPL init failed: %d\n", ret);
+		debug("HiFive Unmatched FU740 dram init failed: %d\n", ret);
 		goto end;
 	}
 
-- 
2.30.2


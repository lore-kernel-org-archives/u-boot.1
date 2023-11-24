Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FFFC61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 19:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A958772C;
	Fri, 24 Nov 2023 20:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="U6/lslir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5DF87457; Fri, 24 Nov 2023 17:35:09 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD7087656
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 17:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.kubik@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGmqdH1kbaX5eRks5/la9hgRp5O9fh13NjNsCbmtrE3apvYrHVi2ohI1RrT0Y6Z5koT/Fjfvue+Y9zF+aTo00BUnQTOYxvezfKx1f7flBs0Nfn/xw5sN1TvTSVR1ca3/otUD+dQ5iVNX7oOQk0cZCQKInSi98zl/FLvpYGASmGWbnhSW/mFonTs0P8UxdLSq5bRTdIbkgcQVpuyWLAjXvKAtHSxUIShVAZZzUUrQ1H5VNX3KMPgCp1YC3TCwDb80KePlnhh6EFgVkDQHrd+1g40YncHFoxEf72+swOPe9AxV/x4SnsWt0Lm49zrsACXkA6H1hldlxZEKU21JvEPD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu5YFf1/BpKUZvz584w867EFpsoeN/5WarKB1hUCAMg=;
 b=XIZUu4jTnDZdSQ4Sz/y6aGJF32WCaV5YDSgMzyf85mUctxohM36ob08yDL7BnPsqsm4QrWlsfObLTyfY2u8Z6ffdxHRrzCcbOWk0Mc/60t9cTKHsD2lR724obNoK+fnLihmUGxjyZ84N7Z6Q8J8a/T9X2pH+EMeKeqMlHJZnLP1ssDZ6aOEgBTjk9CdbmbZi7XabqP36Rzkg5kkarhMzbs1wfJRHEwaGldF+FPmhhah/lmvRx7/y5faHqdLp39zVRvYB0FOYgEJFXLsk96S0R4NEoYbEb1rBkbteX1mgA/5OjFlVPIbFrv7dYBNcHxq2rZ99SuC1dJ1SjIS5iU5gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu5YFf1/BpKUZvz584w867EFpsoeN/5WarKB1hUCAMg=;
 b=U6/lslirWdVoCVmhIhujGOSLb/7+8vyI3+WP3w2zMTb9qfLHzxPDdhCyyOAkmitlyrO+r1u0Qfn6EYKiuw7Fm2z3XvEOApliMWYo7PiMDM9Tr1SshQXNirpqPCJH3XICcXjCfVQkaesxayLiUOgU0X2k9I5kh4B83DnLp7QJfpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12)
 by DBBPR08MB6043.eurprd08.prod.outlook.com (2603:10a6:10:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 16:35:06 +0000
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::f36e:3882:2fce:d775]) by AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::f36e:3882:2fce:d775%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 16:35:06 +0000
From: Piotr Kubik <piotr.kubik@iopsys.eu>
To: u-boot@lists.denx.de
Cc: Piotr Kubik <piotr.kubik@iopsys.eu>,
	sjg@google.com,
	trini@konsulko.com
Subject: [PATCH v2 1/1] bootm: Fix flags used for bootargs string substitution
Date: Fri, 24 Nov 2023 17:30:46 +0100
Message-ID: <01aeaae2b87933e8a33a575ec0d23e2d464d6699.1700843096.git.piotr.kubik@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1700843096.git.piotr.kubik@iopsys.eu>
References: <AS8PR08MB6806D08B61DB1A97ABF68BBDEBD5A@AS8PR08MB6806.eurprd08.prod.outlook.com>
 <cover.1700843096.git.piotr.kubik@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To AS8PR08MB6806.eurprd08.prod.outlook.com
 (2603:10a6:20b:39b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6806:EE_|DBBPR08MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bbecdf-cdc0-45e4-9aad-08dbed0b50fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HW2nYiAmNeUED7HNs/Yc+Cb4caPGVNtClQXS7AzNqZxRLvt0yxUoJTjA12Bgv2DnVbNNHSJjD3+0gA5lFQIu6EE7iMRQZdGmwYCL0dNZbSN15p/pKIr8uR+8vBX/a8HJ/FCufU9PWa/fdqR3xFRVTqx87o1tjKGEtDtRjSOaheIIEu4lZSUdBRhZ3TSrkBZlzqbLKzkTA12K7SrTd5af92Ny+iDeMXTIMaoDiWseMA8q7GbPl1FZW9YxGmAJRpPvsW+uD8z71vkVHq9yGYdOFdWEb+l0GYOzHxMwiPcZBq1dfJmJJsY8TZrryVLkgMopq44N2EWEnu4rMpwcqio4nv11UI4EcLGeGA/nMZYtLUyDGaPlKUySg+O/ChILxFKkYGzrOEIkvHkg42Pag0wX88EK7nbsL49mO7jix0c/lBd7tdAV33rIL0p6getvIGNHBWb6uTkj47JlVeZJxPFlKvJX/R4mXUU0Huhub6O5DLck+PSF8aZEHDFiSHuBghZRF5A1Yk+DYb5yzjVc0D3hFycQQDk623F1cmaXCgrPtt8OgEKmbsLQhGQUHZKHs1NDCiBFNG+78jaQxFTp7TbffixWccqVJJD4NzH7DlwxrOAd+E+R/KZz3Nyvo6/XVSG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6806.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(39840400004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6512007)(83380400001)(26005)(6506007)(52116002)(478600001)(44832011)(8936002)(4326008)(8676002)(41300700001)(5660300002)(6916009)(6486002)(2906002)(316002)(66946007)(66476007)(66556008)(86362001)(6666004)(38100700002)(36756003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZ40saniy3UIGtqZW0CZ87CI+xnJ7hT/3ad5KIRXuW5JcevcHALgoqUiSnrT?=
 =?us-ascii?Q?NO6Ha24fcHt0tBbS/0XX8xfU1xPBcE1wGVKkTwKosUNqgvrWEWWA5vsTPvsW?=
 =?us-ascii?Q?STkpaJRJS635GlfeG3wSZge/A0nrPt4Mg3r0QZ82NRbBq1YGOi3gF3RJ2pO3?=
 =?us-ascii?Q?RMmRhkdR1pAwTcHUFIJBWN0uYOIrzkEnx+i3so21m5bwygHHOlCSd2JVBZ/X?=
 =?us-ascii?Q?vwpP13e53+4e3e1rzvUkTEN8gypFyGdriYAEmklVFu4fUsdFFtET+kVcrbOd?=
 =?us-ascii?Q?cFfg4xHDB1Ca3ySCknxK41sh/2vSFMeOOp+sBh64n643LcDP8WC4vvfytvic?=
 =?us-ascii?Q?2EGeUUcQ9VmOka43lMq2weqfN2QP5btEkguZ3FafcNQ4+2iouf+U1D2KkAOx?=
 =?us-ascii?Q?c+AI93T6IkSRIRsIxcpxJbFG79v+Mv6BWLBk1xgCkMs/yt0Kod6YF+rknWO1?=
 =?us-ascii?Q?wktvWn3cT46oNLk3YdcJXzeQxxysrrHkIWsPrk/yKs8BJgCh/mkkIjQeNpzd?=
 =?us-ascii?Q?uUey6g7d3zmmId6EaU87cLE6kA17ncZfoaO7tQft8p1A5VBlWvNCs27mS/lH?=
 =?us-ascii?Q?O1gkk4AdEYRVJJb6DTTZyRhwNudRfqml8FTEj3029IUVUOsGzkhgdapf34Cd?=
 =?us-ascii?Q?czqKAxQ1eav6x6hxJ7HeZiaLtjhPmf4P5i7EQxPBwzGGNMU3GHFyTF+E5qCs?=
 =?us-ascii?Q?cdx1bhNyX10R2PilgMoMg7AVpg9qWEVnnOHqfkXiCMfklw65/BI0IwJoZPh9?=
 =?us-ascii?Q?lTIPPmXXSo8PK+sac96i1abWOVGFqWA7I6qTvRDuFYqAYCzi+F6NdxlSCVHg?=
 =?us-ascii?Q?GJdbhXIG2l53F8rKdSwyqLVYQ0icHJ4E1YRemPQUruf1H1Jg7ZzfUX+Ehago?=
 =?us-ascii?Q?LKGBqf1dfNLD8jAGJRQzDcuzo0zu2xSqxE75LLfOeZWowo6FkXnBSB8BRqPa?=
 =?us-ascii?Q?7PDXpTwNm8QQB2BICyPmJDb2DpbnfI7C7qnBuSI0Vz1YhF2Cq9F+SDc2Yk0M?=
 =?us-ascii?Q?r3y+XhtfBT7YUZ4e1yAVJHFfItmHlGQFGho+Crw896OSi38iKSEbnEs4m9EK?=
 =?us-ascii?Q?JfDMqdKFDGZkQYjrOjWj/W8+EYS6al0qMn17K8D+f1vTsC2ZqqlTt4vrh4BJ?=
 =?us-ascii?Q?r22NCVPypPxm3ZM9EL7qMZ7RnNuvhuctj9f5v84M/Sc6har73SGziF5XnsTK?=
 =?us-ascii?Q?GMeLV3T+AZC88O4znWDQl3sDd+qPjBY6sLb2C74oG8P85+4MakKys0Myb/Gl?=
 =?us-ascii?Q?2oahazblkq9EyCTjk8PfDVUh4dEQJnIx+n6YLmm94roxM9MACuXX1yGoUIj8?=
 =?us-ascii?Q?L4lBkptFLv2MMQof6MyMuts4gnDfilLsf5W3CysFCdF7fQ/QHRksRrH+5F+V?=
 =?us-ascii?Q?nzUiOy2EP50aL+B2Xyb3A0xLD63Opi1bPl2Zn1XJHbFvQv1iOsF2AdGsxtU7?=
 =?us-ascii?Q?OO5Fs6zAKpoR6Kjg1oDsu6rmrDXvGkkkJ5jHmIkg24E9DBPxTxaHU8XQyktW?=
 =?us-ascii?Q?xaVK1B8lgN6ueq2AB3wbf+NRW6JLEeiEVzMqxqhp3kmHOXrOZZWYosEwXxmS?=
 =?us-ascii?Q?BVyF9ZfGj6+8UyoqiK3Ml+aaFnRmGIi1xBxjsvr5?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bbecdf-cdc0-45e4-9aad-08dbed0b50fa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6806.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 16:35:06.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8JIR+qnD1sqnRSRfhv9P8cUjdgoWV10+PAIx2jrIMplSMAwDQ2NBTdWSHU10Rron+SVRUGTOMmjatxE/NjAIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6043
X-Mailman-Approved-At: Fri, 24 Nov 2023 20:59:31 +0100
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

Commit 51bb33846ad2 ("bootm: Support string substitution in
bootargs") introduced a feature of bootargs string substitution
and changed a flag used in bootm_process_cmdline_env() call
to be either true or false. With this flag value,
condition in bootm_process_cmdline()
`if (flags & BOOTM_CL_SUBST)` is never true
and process_subst() is never called.

Add a simple test to verify if substitution works OK.

Signed-off-by: Piotr Kubik <piotr.kubik@iopsys.eu>
---
 boot/bootm.c              | 6 +++++-
 test/py/tests/test_fit.py | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cb61485c22..31b0431e04 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -852,7 +852,11 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_OS_BD_T))
 		ret = boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
 	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
-		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
+		int flags = 0;
+		/* For Linux OS do all substitutions at console processing */
+		if (images->os.os == IH_OS_LINUX)
+			flags = BOOTM_CL_ALL;
+		ret = bootm_process_cmdline_env(flags);
 		if (ret) {
 			printf("Cmdline setup failed (err=%d)\n", ret);
 			ret = CMD_RET_FAILURE;
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index f45848484e..fed8cd58ce 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -339,6 +339,14 @@ def test_fit(u_boot_console):
                   'U-Boot loaded FDT from offset %#x, FDT is actually at %#x' %
                   (fit_offset, real_fit_offset))
 
+            # Check if bootargs strings substitution works
+            output = cons.run_command_list([
+                'env set bootargs \\\"\'my_boot_var=${foo}\'\\\"',
+                'env set foo bar',
+                'bootm prep',
+                'env print bootargs'])
+            assert 'bootargs="my_boot_var=bar"' in output, "Bootargs strings not substituted"
+
         # Now a kernel and an FDT
         with cons.log.section('Kernel + FDT load'):
             params['fdt_load'] = 'load = <%#x>;' % params['fdt_addr']
-- 
2.43.0


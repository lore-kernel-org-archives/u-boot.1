Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44905C87FCE
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 07:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F23830EA;
	Sun, 27 Jul 2025 09:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="G6BLyz4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B579B830EE; Sun, 27 Jul 2025 09:43:07 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E9F830C8
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 09:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q95qQhsE3A10m31DtkN1s5RWdTTXTi8pP52nApCj3KVRk9aBFYGoZsqnf03XiLMZdUZyhVPEi5YC6vLYO6VL159FzrbO3UmPEhXKH0yFRJ0yuDr3NVI1iTi9yO8Wcn39UDYewEbU2blM7wgB37X404TGMVPyrfE/f97+1oHVaaZR5ZAJvoUotkfuTzLjkFGnJAvxBGZSXJVvWmjXbuP0Gv8LEPSyEeIAaVka2PV+hGsbznOtuDVckE27D5z9quBXjw5612Q0pxof4Vb/n1D/2wWblpNG+NFb50kmBkK6qUv0JR/LrTGoXcN0kf4H2evY3u8uWLeAHqISsvhhNN9B/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COIrSVJwebMofSDKJcsShNbVi879/0GGwo5qoSZtcow=;
 b=sQOblEUP81yx/l1f/ihIqkST09pZyjuJC4qVYUaJIA2GPMJs1JR/ZQ6cRKyMskr8zY1ynb2AlV6o6+8rId8eybsyY6NMpKuoKum0wAtEgUAIVXaullMqh1xVQraEs/qpYP/5SEO87uB7HuwOaFclsg7kwxHcngewX0AobDI08fZyHG0pQl2mS9/kn/HnlidQT4PyKK5tclTTe5rktiMqDsk6v3So7TC0DRbdzyXzT8S9tjUughYly8iXerAvPW88vCMwCeHntnXssmsl6sGOvgBOMj2ZLIk138JF6rUmENoafju59YUpZKosRZX+nCyNaG8nZJpADeosM1Pic7BiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COIrSVJwebMofSDKJcsShNbVi879/0GGwo5qoSZtcow=;
 b=G6BLyz4aqgV/KWs6Y6kBwUpqndA+TD0CgWnNa/AQICzsWimkFPPVCjcCkWp9slEIsqGIP3TokK8/4gq/A15N+XueLcceyt/aBI6B+hZDZNj57EwIWgE042ramEUn7TTiPlUccMxAAdSupeuIN9oVQSFqLWxUevRX7kZrArqh8MKO+1MvDAAT9gyG/BdNYDiu93JLuhPNVCIx95MtWKCFBJuoWnvdnM+E5e/5wvfNRPJx+7OtXttc9Cn7ildkI4EH+6uBmyqev7gCM6zSU0hyWfdMO20RDfyidF4CseWjErxXAmvnseHvWeyEho026MtCNYmEtqISmmGxqjNxPe5Jlg==
Received: from TY1PR01MB1676.jpnprd01.prod.outlook.com (2603:1096:403:7::21)
 by TYCPR01MB11658.jpnprd01.prod.outlook.com (2603:1096:400:378::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 07:43:00 +0000
Received: from TY1PR01MB1676.jpnprd01.prod.outlook.com
 ([fe80::7b8b:3f71:75f6:fcaf]) by TY1PR01MB1676.jpnprd01.prod.outlook.com
 ([fe80::7b8b:3f71:75f6:fcaf%7]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 07:43:00 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] meminfo: correct "free" memory region size
Date: Sun, 27 Jul 2025 15:42:01 +0800
Message-ID: <TY1PR01MB16764FB6BEC2FDBCE2D96060BC5BA@TY1PR01MB1676.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To TY1PR01MB1676.jpnprd01.prod.outlook.com
 (2603:1096:403:7::21)
X-Microsoft-Original-Message-ID: <20250727074201.1074-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PR01MB1676:EE_|TYCPR01MB11658:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9e9dd7-97c7-43db-a90e-08ddcce13509
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|41001999006|5072599009|461199028|8060799015|15080799012|19110799012|39105399003|40105399003|3412199025|440099028|11031999003|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s2YoptQc9T3i1TUjhKYekL33AL6+6x2fbA3mCziiKmRJb68Jwcyi4fTDMYX9?=
 =?us-ascii?Q?g20FYWT7uNVXhJpk2bhYGd8/wjUYYg1XVXRJ0zSIyy810RLi6cWZsjMPRZuN?=
 =?us-ascii?Q?Q1Itj7JrAUvAOISCkr0ZOpIwuJUPcxTrCInxuFrVCfXU1ohADOHlBMdLwhJj?=
 =?us-ascii?Q?U4heYoSD6m1mqNdmkDbrTYUoK9qTajN8UgotOPLA0piq/HDNGO8HgOsWcALZ?=
 =?us-ascii?Q?xLF5Ya33fiE708LoAM7qSzCoqV6ZbGaahXzRWzdl5pIj2+wvgdUz0MNKs/44?=
 =?us-ascii?Q?f5CsuQii/64tbxauOW795fhRgIN98bezwMJjE/deVQ00fkW5TrGsy22getHJ?=
 =?us-ascii?Q?phaJfXitTe7WhWnK2Kf+RlWInvd8p0ppKWwdkTSl0F7Ia99IU6RsofrtjysN?=
 =?us-ascii?Q?QzD6VE+D95ryLpO1XWGNPE2Z+R/U9UCubCMAf7r9eDtoeLsB9Dq7KTdUHy0n?=
 =?us-ascii?Q?0rgbz0KWQfWU/bTdfTQuKS6QHK6wOsxfM629v0AgUyycqqYlWyxzo2M9rQH1?=
 =?us-ascii?Q?KU8xVEuWnhGjy6/rjRpxQT48uyuZMP2NVgTOtW9jC8YgkKGgEKluHLTivRTP?=
 =?us-ascii?Q?2fH7H48eNP7wyapU4DPjSVe2phWHG/hO9uS5yccu7mdy/Pcnp6EQKRNqZOi6?=
 =?us-ascii?Q?fRQP1Xjw3mY7VQW9vSdocyTqU1mJOVBbkX6PdoUAgBoFHUH6CwbEaBsekRL9?=
 =?us-ascii?Q?LVDMZmnSIxyXtZRNZX2r+6ZHxB147pIeiVpbhPiYR8mb1ImFBocRf+IKFYr7?=
 =?us-ascii?Q?OpVv3mVrm2KLnsuROiv/P6MnBwwsptxBnhkyX7/Is849VJkUVTUeiyOY+qoK?=
 =?us-ascii?Q?wAs6iJUSeJHXhO8QH5yC4VXvD8jVdZcZVCzQgzaX7eeCMfjf5tI0tV7NtoiM?=
 =?us-ascii?Q?kq0MoaJ7r6PCNHmIEk6UG1qO4GbO9T3swYFxOpVhSKv2kMYfqKjPZuih7NA6?=
 =?us-ascii?Q?8mmfZnhYtgP9Khp0w40dlcjinWOlIo4QhNCXA2g8rOZl0TtTVOXjHvAy3/E2?=
 =?us-ascii?Q?Yk7FMn/XPeYD5whF4ahH8GjSgrPgGpenqjZD9/K3/gn/oi++RktryA94z/d3?=
 =?us-ascii?Q?lekk3h0dlLYoDbqE8P6hO2NpV4ukwua7dyhr2CeNYH4akua1Y7DlPlaiJrDz?=
 =?us-ascii?Q?PhKQ3nLTjjqzxhp5KTryB+V+h9LGe4gCjTzCTVDeGllZBlwPuiQHgMkJGWfL?=
 =?us-ascii?Q?D5JjUVRhOYnOvTXb9v4CbJScaOib36yui4okoOLgWuwgVJt0vsQdATXxD0XJ?=
 =?us-ascii?Q?+cmx+vfgslZbS0ojJp8JDcp/fYB+QVobvHdxBbk8uPYUnLO+JaeDExCSRjok?=
 =?us-ascii?Q?yfU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aoj56TKocx7nJ+0u6BETkgc23vMenYf6j0588GfO7Ksk/LzD4tNmUQU3mtps?=
 =?us-ascii?Q?xZQI+5Kkym0KYA0axE0R+Ez+QHw07AhUYJ1MGN2+UJ4BNhyICdO3IUsSbTHn?=
 =?us-ascii?Q?HLth0SZoHkUxLqJL6Z6TNTvBR8dJSDS2B0YbxKwWMu9Tdi360lHKjrPqeaK6?=
 =?us-ascii?Q?q7mMS/tGNx5fWZejyTVmXCs4/Z1yXRgv6/LjAJ/ryg0SjiXBUeOElmX6Q4xT?=
 =?us-ascii?Q?pFcya2U7cDpKCAobe6v1u3tkcwuGAOJSmlJkWhxEXn2Sl8oHVeltSCIIirYR?=
 =?us-ascii?Q?sUj9XMUKooSbTpxJOufkFbc9fwCx64M/oxfebT75LEOr9v1TZug2qkhEi6Xu?=
 =?us-ascii?Q?SXzhR7d8zZl/aI9OdBSnZdWhUl04t0OvGeFtVujZlr3zSVtsAcIQkzoYWdDo?=
 =?us-ascii?Q?0nLLzKnXlSktEwdOThxj/e/H6qTH8g50pfFVc7GdpUfp1JgEQe3CtVu3PoPy?=
 =?us-ascii?Q?mdMiIEbaR8OW8nTcNNsuF/gM4lJGSEXkcavZy//IgIYelufTuIUZRs7BbKET?=
 =?us-ascii?Q?fzdjd19c/jLKT7qOkVru8J17bokRhva6dsa7DL2NEoJR7+NVU8Bj/a6KI3G8?=
 =?us-ascii?Q?OwmwZ4qvDd9md2ol74tbS6u4Ba1TjFWrHHOVn7v7Eit8phB06CP1/AtFeqsf?=
 =?us-ascii?Q?JcnRA0hWJ2NHUSC9FncoV3dz775mReEOhX26Olvh105nx2jG41i8/oLO3UzX?=
 =?us-ascii?Q?HU6A4Z67uod9hE88SR5aga4rLlsA3yI/aQMhRXxd2qrEApRBWzk+ZMQC8Nch?=
 =?us-ascii?Q?f5hnjYCdWjZ9rYyw44a1Czw2vLAheZl9iRuWUphBu3BftyyIp8B0oCRESOx0?=
 =?us-ascii?Q?tiwu3t2+l7VCeW4/VflhO0hgL4S5c1bpSw48+70xr/9EQ+46LsktmYa3RPdm?=
 =?us-ascii?Q?zXtqjjMrQ1+OL6GtjDNeT0UVcF7OpKFZfGDMdyaT27N2u/zZD6bPkQQNgWsM?=
 =?us-ascii?Q?vA9bgEZtwi2+EBJt3r/9KRAcegTctMA8f6hXYxm1fNknJhKfi8pl+acKWmpl?=
 =?us-ascii?Q?6gLqvG8GMlb/AsJiOosXOpmNOubOP3/HFO2uYqt3GuELTIHC0uj2oIYcc5xp?=
 =?us-ascii?Q?vEEx6ghghOsfogCRdwnchoNAkkPd+GJBgl2NXTeNOZ5Rk0kBex1ygHUOLE5P?=
 =?us-ascii?Q?ID6k+NUheeVspJvn1I0KvbkdhzX66RJXysSCVOzBAX0RtiLrLb5grm6Slq5C?=
 =?us-ascii?Q?HVbyBNG/tgzeF8U/QjqsT0hi0BmwsZXL29NiR74pV5Y00xs8rhkIhiEZ6xV1?=
 =?us-ascii?Q?PbCnqvL7FoWbgjSCVlkH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9e9dd7-97c7-43db-a90e-08ddcce13509
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1676.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 07:43:00.5150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11658
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

The size of free memory should be $lmb_base - $ram_base.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

Before:
=> meminfo
DRAM:  64 MiB

Region           Base     Size      End      Gap
------------------------------------------------
code         83fa0000    5fdf8 83fffdf8
malloc       83e90000   110000 83fa0000        0
board_info   83e8ffd0       30 83e90000        0
global_data  83e8ff10       b4 83e8ffc4        c
devicetree   83e8e690     186d 83e8fefd       13
stack        82e8e000  1000000 83e8e000      690
lmb          82e8e000  1172000 84000000 fee8e000
free         80000000 82e8e000  2e8e000 80000000

After:
=> meminfo
DRAM:  64 MiB

Region           Base     Size      End      Gap
------------------------------------------------
code         83fa0000    5f260 83fff260
malloc       83e90000   110000 83fa0000        0
board_info   83e8ffd0       30 83e90000        0
global_data  83e8ff10       b4 83e8ffc4        c
devicetree   83e8e690     186d 83e8fefd       13
stack        82e8e000  1000000 83e8e000      690
lmb          82e8e000  1172000 84000000 fee8e000
free         80000000  2e8e000 82e8e000        0

 cmd/meminfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index acdb38dcba0..aa3b5bafe17 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -93,7 +93,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 	print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
 	if (IS_ENABLED(CONFIG_LMB))
 		show_lmb(lmb_get(), &upto);
-	print_region("free", gd->ram_base, upto, &upto);
+	print_region("free", gd->ram_base, upto - gd->ram_base, &upto);
 
 	return 0;
 }
-- 
2.50.0


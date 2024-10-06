Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0919BCFB43F
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EAC88D36;
	Sun,  6 Oct 2024 01:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IJ2epK3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496E788D06; Sun,  6 Oct 2024 01:26:33 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D4588CC1
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRpey76ah9s9UoVVzgNWNRHFu1q8y/8sE6OwcjgEDuSq3f7x5MwYwdhzHf8rQ6SETT1S4llRAtGvl9MbtDIzg8R2dayz7L6Iyfp0vgPWdOELG34lOVwJaa7perTLBKOAx9A4rCJ7hMqsVDaSgwYbPNLhvjpXCfqtYPBr8fHVIgkksp9mxbz9ULDmoyvbPTjF0wlz+nyCleZI8IG2+5ns3NNBatOBUUd9v6tfTFAk0qrdtoP5csAQOI9MJJLev0oRrhiYIHSXyg0xCSJyVelcHXN1HD/PB7LTctqqTKm/uCZpck5tJOmCrQZmb4kOBZqFSJh1WDJV7zQgUf4zFYNSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYh5YMW6ApwRWBz7iywx8ZPBl7peUpifpLb4wM/4TAQ=;
 b=YMU0RczdlJlmpAekZMrSjX4mAHL68eKZBLbabCf+SnBeOhalSof9hZOHUcpiiuJpS7Y6aejSMsHESBw0GRTKZZEDiTxyWADEAvxGD2BQtVYQlz8xYVBDr4qvTK1ee9NW/6vmIu1HCnpCiGEIfr0lGdLxKLUzorpu1b3M+7L2jaOVb4bpfH4BWMfM9uU1edkUHW8vB4JCxZQwREgVFJuNOTMoNX+cFSiCBzI73WtHMlNyIVA/DkLhA0xmiLULrCIB5mnZMrXMj3nGlTbhufBhVunnfG7rXGpbE2t8WYzbjy1+QloDxLgeQPyWUQfThwv+eJoMbawW5+5qB1G/q5DLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYh5YMW6ApwRWBz7iywx8ZPBl7peUpifpLb4wM/4TAQ=;
 b=IJ2epK3QkWFtVw73lIlFZguBDnnedwtkmSnW8d1SUTFxjKkuufkg+7Jk+FCT6LMQww7n8Jx0UDV/Hkxv1ZaG52WcVklSZ7JGX1s9CoWyTU5R98UwVgjU2mP7hcGzBKihE6wQazTcvKyTIpMBuplCpglUGsRGaf0zeF/0l4MNPgukP4UPC0v5HtKk8Rm3Jt+hXWkBU/Aq5zMXske3gGVzsKZ6Z4PmahYG9tPkUXpe65yz3yCxrpojp1ZXkrMjtYfeYHzjErYG0+haS7A3VfMNESK4PEZuGFEfk/mVcaM36Qo57+TvoPZYFQPhU7yNxZeMfx/rUBydmfRhvMpnyfzssA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Sat, 5 Oct
 2024 23:26:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:26:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] misc: fuse: Fix FSB redundancy fuse word check and clear
 res
Date: Sun,  6 Oct 2024 08:30:04 +0800
Message-Id: <20241006003006.20162-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241006003006.20162-1-peng.fan@oss.nxp.com>
References: <20241006003006.20162-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5917c9-2564-4d7d-928d-08dce5952353
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yeOgqlNVYTlzOjeA4JGkaVS05xydd5YQgq41YbNnYq9UfNAjspXn+WWqt6Yl?=
 =?us-ascii?Q?2ztxjfm6gYrW93KNCW8miOV522khImiElylkqAoRr/5UCCkOpMThl+TyOXkF?=
 =?us-ascii?Q?Fwn/avMsxeZFn5CDyItrrHt0taS2NbMqfFXQfijq9CPQUN527pOZqEIaY45y?=
 =?us-ascii?Q?mYSs0FNuo9PR9u29mFveLQGOaQ8aEIaMsXal26LdjSiZaEWG3VxG9Lzyubc1?=
 =?us-ascii?Q?uZUuxlTBldihbHr13TPEln15KH3ysNhq3d+hAy+xcKeGoKEHLUAxzPcsAmJ7?=
 =?us-ascii?Q?a1y3mgxwY1Ht3R8jdcx0v4sCCFx8JvvRKJu5ONzzIOnhM79r2/ktVhE+7tyM?=
 =?us-ascii?Q?fFXiySSIuy2RVcTqZ4aR0kgOFRgdv4J1SIRqPvsTHuHwYhk2la7GT3NNYge0?=
 =?us-ascii?Q?/WSxHsMNvuh5gjrLmUTttaq8MCOBDIMG8pE9Tz6B+qGoM/DyzSBHNwglOVT0?=
 =?us-ascii?Q?tsqj+j5kwqsDFGzSYL62cijgRlJY/gYRIp1RYwTw1sRQwdkuT3qYVDxYmR+0?=
 =?us-ascii?Q?UFA/cZmyQWOmwjGNl1CXdwf+QhRCoahV5kjpWec6a3JJWUmhVmZEMrpyrtKw?=
 =?us-ascii?Q?5eO+adARa2EmV/iKk7vbdxaW9Lk4xNZ4LzpSxkZugWwFrVvmTMAxz6JOMFxw?=
 =?us-ascii?Q?8R8/pKFsQUCltPm/4M+0MUmiGgUzywcfLK/dFjNmB8TB1bc5GNrhmX8DpLO3?=
 =?us-ascii?Q?LhW0hNlL4mE8d1K1l4BLIb1RIvSIKX4ZKOtNj91W+lnI0PyA0XlLYaoJG24g?=
 =?us-ascii?Q?ijmSXDWBkR5mrIX+ao8LG6fn/4AonpgmXU3pF5zMQ4Lv1mZbTZuXZXtpUcto?=
 =?us-ascii?Q?3DDyDU/JoHvSOYIReU1iRvzTF6kgvoZjbZ8v8C3oBpWv5+AZmup+xwbXmFXO?=
 =?us-ascii?Q?YuCc+rFigpIPwcwa19Ojgck34oH5Pwvdc62CLPlOfLMcZ+u25RbygPSKzOJW?=
 =?us-ascii?Q?VCspftARDEgw9KgtXK4FRCT5/eENkhd7fAGu4yN+MOFdjLjkOuSwkfFiDRmH?=
 =?us-ascii?Q?L3scdh+mcRb8SPgKg46tPCkUmv8ZDd11KLsi8pCw8/u1Emei3gna21tzJOdT?=
 =?us-ascii?Q?n8mD67VbnZ6MdfvHsZxxzR03VFQlv2lX3Pz+BOJjLoiebpMPAYTA54oO+3bA?=
 =?us-ascii?Q?oNsse6xCs6f6IWTrO17lk1Fll0PduOMIVGN8Ulg3IKynCYcPCgyVtz1kNJJ9?=
 =?us-ascii?Q?5WwTFkiNIskqKmfpAvnegj4eO6fYcrrwOoIoeT8cy20Su/wfrxwXrjHn3jVQ?=
 =?us-ascii?Q?+x3ebQaPbZl1QrE9nf67/tuCV6VJrSj9pnbhk+8hYmegwJXAjoRsOuWK6h3A?=
 =?us-ascii?Q?pXTdC1zndxYt7fWbsDsZuwlUy8E2761r08kJMoqpZ9SJ4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?snBsDTwfzMmbPIjMCB8rRpXDh7zuYdvupvqIhxllHMSz4/urh1a0cI7fmoet?=
 =?us-ascii?Q?hsKb/0OiJKJueFsnK6YTpKOZVfOh6WTm5oyXnGdnJRA/2pmJB1aaFDcyLRUR?=
 =?us-ascii?Q?dBrHEl6BRkrvwuQFcHlr0SliOh5Kk0DcvtE96DhvIJ3zsarsnHtpCXV221co?=
 =?us-ascii?Q?JP/iHFB3gqEYR7gldS5zwkfh3TPlrXJ5/jGhBbPA6t3RmUagWIIr1b0cL25f?=
 =?us-ascii?Q?xAQ4wRzo6ehHGqbq11A77MGE8Y1Udbip9Fm8SGWPVcgf4pVoKrZ/wVlBdjnK?=
 =?us-ascii?Q?8fLEWEvk6lqiQiwJnT2oS8KuD/e1vkl0x/V3+uZRddy3hIxqBv9Yo6GmYCQh?=
 =?us-ascii?Q?w6CAfr6i9AvmTFFEvT1eKJ4V5jnzZ8TCMjjtl1j5SgryEZ8psOGL2WjityVz?=
 =?us-ascii?Q?Wba1m8lHK7Ap3pHsVYC9wKFew68qvT+FH3O5gZJMlBpYytQIA5iq0YqQ/3Re?=
 =?us-ascii?Q?JntVfn+YAL8HETK/0ZOAbxIMhqFhyJQUVpltE121dniCu4vMGlNX5ILDzWDy?=
 =?us-ascii?Q?IUvP+c78I7ku/59p/BbZGQ0R9rbikMtPWbdrXizd6hGpdJ65UeCQI0AFeGga?=
 =?us-ascii?Q?g9/5G66wf7GcCSJxB8oZxexyxFTM7HPbqXr0Nbey4hA3dnYu2kGhthkog+6l?=
 =?us-ascii?Q?XZV6VeRhrh0bxUBxiMysMd9doUUHHWyM+LPl3zw2hlV0NwXLBUwMmoZABKbw?=
 =?us-ascii?Q?QHjzkhh4EE+Z8yO3GkXzr2SMRyeiNCVhtRL3EQ8WQDZZi4sXI88DOOGS24qy?=
 =?us-ascii?Q?J7MfNZ9KGZvAnvqk+k/wWZZscWA5pt/4/ykx+zJaONVIrNwGuiSUXOHPEh2u?=
 =?us-ascii?Q?kTAOGr32KwpYJBf4wIJ1Rdf0ygwINLJAKc5Wz77PsZeYhjp/RC/qkkt2L5hL?=
 =?us-ascii?Q?i68EF3K+rx7QfvF7f/Ymov3s4H/RlQB3nA58UcYy3UpYBxJBgiFpRM0p4P3M?=
 =?us-ascii?Q?ZlL5bY6jg+1piz1Kkym0HLbmhOLTUwyc8wipozmg36fa402mnvz/xacZgYmt?=
 =?us-ascii?Q?WncxzQQx9t3WISI27MnpORGArs7si/qNwVNilgVdBhy5MeE4uQA9q7XspJqZ?=
 =?us-ascii?Q?g/IU9DqzowVuKlrPRRjLfJ88cUnXBEDdqG+ZUgmOrx82y7cFRhESqHdcceVp?=
 =?us-ascii?Q?DCPCIUx8HUixFwCeTKpOJCR4tBA2wkiVUoERmaliSSLPklJ8n9Zvek54X7ol?=
 =?us-ascii?Q?qGhFRpTE+n6fH6DyfH4Ua9gKCtK9ISn/8dU48ybQARHr6fQPeMkyqK3EUCOQ?=
 =?us-ascii?Q?VhJFSQk8C6+nudSQaFfiq3W9YMZu5fq4c7qtit9YHXA6a8E+iH5H4hbHxBqp?=
 =?us-ascii?Q?V9wr1PPlGb0xqygi1DXWVcTc62Q5PUVdrDlmZpYlIRvc1SrcR1SZvSjEWyWw?=
 =?us-ascii?Q?XJVPqvVDbNb8Ex/g+WKV6Nue4neSNYUs3DsZwFqQPNqQNvEfWQVr0lJ7MeJZ?=
 =?us-ascii?Q?kzaYKPMbyE6pIXb1mhzCSLA3ThSZimi1H7iMgTlhAr215c5vPcv8T7DFugx5?=
 =?us-ascii?Q?VCweuE0c2neYxtR7Uf9akjQEoFL7KkbbU2fMUfTgEXDmAIXz50JpsEuwD8oz?=
 =?us-ascii?Q?eXJm2T7fmoW8D+y/ovV9d2GwXsfTv7Vd4/GuwtMr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5917c9-2564-4d7d-928d-08dce5952353
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:26:28.6992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTLuC/VHFM2obGyF81h05TmkzvPCil2f6vwGDjpSMgyRzxKQnN1NENK93+x+4QCEq6Q3qvygXDohajTgUUf4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217
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

From: Ye Li <ye.li@nxp.com>

There is a bug when checking fuse word with redundancy fuse in FSB
table. The redundancy fuses are combined into 4 words, so we can't
directly use word index to do the check, otherwise the high 4 words
will fail to match.

And When calling ELE API, res parameter will pass to ELE API to get ELE
response value for failure. So most of usage does not initialize
this variable and print it after calling ELE API.
However, when ELE API returns failure, we can't ensure this res is
always set because there may be other failure like MU failure.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/fuse.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/imx_ele/fuse.c b/drivers/misc/imx_ele/fuse.c
index d12539c8aac..47880d8aeea 100644
--- a/drivers/misc/imx_ele/fuse.c
+++ b/drivers/misc/imx_ele/fuse.c
@@ -138,8 +138,7 @@ static s32 map_fsb_fuse_index(u32 bank, u32 word, bool *redundancy)
 	/* map the fuse from ocotp fuse map to FSB*/
 	for (i = 0; i < size; i++) {
 		if (fsb_mapping_table[i].fuse_bank != -1 &&
-		    fsb_mapping_table[i].fuse_bank == bank &&
-		    fsb_mapping_table[i].fuse_words > word) {
+		    fsb_mapping_table[i].fuse_bank == bank) {
 			break;
 		}
 
@@ -150,8 +149,13 @@ static s32 map_fsb_fuse_index(u32 bank, u32 word, bool *redundancy)
 		return -1; /* Failed to find */
 
 	if (fsb_mapping_table[i].redundancy) {
+		if ((fsb_mapping_table[i].fuse_words << 1) <= word)
+			return -2; /* Not valid word */
+
 		*redundancy = true;
 		return (word >> 1) + word_pos;
+	} else if (fsb_mapping_table[i].fuse_words <= word) {
+		return -2; /* Not valid word */
 	}
 
 	*redundancy = false;
@@ -204,7 +208,7 @@ int fuse_sense(u32 bank, u32 word, u32 *val)
 	word_index = map_ele_fuse_index(bank, word);
 	if (word_index >= 0) {
 		u32 data[4];
-		u32 res, size = 4;
+		u32 res = 0, size = 4;
 		int ret;
 
 		/* Only UID return 4 words */
@@ -257,7 +261,7 @@ int fuse_sense(u32 bank, u32 word, u32 *val)
 	word_index = map_ele_fuse_index(bank, word);
 	if (word_index >= 0) {
 		u32 data;
-		u32 res, size = 1;
+		u32 res = 0, size = 1;
 		int ret;
 
 		ret = ele_read_common_fuse(word_index, &data, size, &res);
@@ -282,7 +286,7 @@ int fuse_read(u32 bank, u32 word, u32 *val)
 
 int fuse_prog(u32 bank, u32 word, u32 val)
 {
-	u32 res;
+	u32 res = 0;
 	int ret;
 	bool lock = false;
 
-- 
2.35.3


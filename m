Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CA6C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 08:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38C586A28;
	Fri, 25 Aug 2023 10:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uNYmHFv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18CA86A4F; Fri, 25 Aug 2023 10:10:30 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4162869DD
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roman.azarenko@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPKgUUJLRi5tgKpoFQT+eAOa3Z6Q9ojyzPY3b0gbFoILid9zaMIzzQDNNdtAWHmySLG3PWsKdwQP2iJO1XL51VLaCUJdfPG/Z0E/uV8GOreuPrqjr+C5tg/TjMe1A1kA6BryEvXdqLl1W77W30GPCT46xQIuMQcoHekxTDKabKC9EQ2ggyfLINTkzHkUmhAwNNBi//nndPnahk4HqEj0Du5k1qjHQbA6YowFBVfktJ0wO6f9S553RvrO8KUXykudo+f5k8E5LXVvjDeaOmvXnlaBNRQa/PT8Zq8r41qBPpod7btQH6zqc7zc+PYYojNCzylcEOaHwuzCcPq+SOPr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuOx+3x4AlaAi8aAbZ4ZwAvRGXcfcr4RUtnuuEpODMM=;
 b=LqwTRkoJNcp27CSN96vLJYyPoi2W5JSD4CRfJchwY4RfTRkH0xSW0UptWwwBzJ9D5tYiJTUcEabglXcMnjX8kZUUGoKZEQAq4INmWS+juZjxhtG4oCXn+l95sE4CoFfkk/fh12v67PXhf611g/2br84z7nmeq7bsITknBVD4jxzTvfhlhU+efxiRv2ZH2x34OUTH3PUTd7qrZUGbzSawXTt8+La8CNsgJIBQrEhDr76Lf0oD2CevkVjSl81+/BGrR/qg36KGa9H9T21gsUWpfCfunYH5uV07K+Kt9UuioVvZU66eHrlEAeoUrhR+V+xDZPSi00ryZzDgiJ2XenrFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuOx+3x4AlaAi8aAbZ4ZwAvRGXcfcr4RUtnuuEpODMM=;
 b=uNYmHFv0fcySZ1yqB82AsmMiAoOEf7MsFMhDuseZ0fhALT6piYZyphMsshXMdbK25ck3oTVc/GhIqc674vxb29+PfMCsmSfvWYsG5+r9w/EqJxefZMcfezHwuDHKkOf8wn5NI0S7fyq8tmNcpjNVn7BM6hXSMIBWptdGc4S/Vm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com (2603:10a6:102:31f::20)
 by AM9PR08MB6163.eurprd08.prod.outlook.com (2603:10a6:20b:2de::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 08:10:25 +0000
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::5586:29c1:1bd3:dadd]) by PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::5586:29c1:1bd3:dadd%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 08:10:25 +0000
From: Roman Azarenko <roman.azarenko@iopsys.eu>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Massimo Pegorer <massimo.pegorer@vimar.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Roman Azarenko <roman.azarenko@iopsys.eu>
Subject: [PATCH v2] tools: ensure zeroed padding in external FIT images
Date: Fri, 25 Aug 2023 10:10:14 +0200
Message-ID: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::13) To PAVPR08MB9819.eurprd08.prod.outlook.com
 (2603:10a6:102:31f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9819:EE_|AM9PR08MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a2165b-28eb-4bf8-cf59-08dba542bc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIuEwEWKBxLJ8NSeRhAcTGEgY9VxjEXm8ezkOavTRvKAZC2V7W2Z4DQsW6dmV3AYMEtouWO7C7OLpiK+HKVGR04t6459sGZGWqJxtbS7j3LzHrZdGHzPXzeoBLjxo1/2Sh2x0q4fDdct1UTLezsCmKKVcGl/kKVinzg7SB+J4udajS2MENIwyRe+23da6OZcIXBjm3LCYOb0OpyyQo2zeR6dTpeslW6Folp2YA4G/4vHu8NjOUnXd0lKsr1btP3I/M5yOXdcA1BqGdxDxJ5VjusRqv+sWEJhtuqigxX6bS88EGp28mB+dtNP66ia+1uy8moTf3hKFh7/bqUMBNlDxCf3cyqYbXRf2HKt+IqjzTMf3yJTGPaRDZJHXZodNnDlZPtSJp6LMan6wuKWSGXjk83Y01weBUdKKZB7E4ZOlB/W5qfjqAyEzTb8iFKE33vZov33ogtMfPjnkCsdZrnO/DBpfIOVulUywYTk+ZA8fFXI/EtIdH4rphqSrTBDVu7dOA6hvFTxksGElqGYY/3c4X3yuEQLRb45HtQaaEyfjlS9FGTS7CPuiHWjHmTiw1n+1XqRgvwZe2b9hww1phfmErVyKnoyDDh/nWcQ5J68LqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR08MB9819.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(136003)(366004)(1800799009)(186009)(451199024)(1076003)(2616005)(5660300002)(107886003)(8936002)(4326008)(8676002)(36756003)(83380400001)(44832011)(26005)(38350700002)(38100700002)(6666004)(6916009)(66556008)(66476007)(66946007)(6506007)(54906003)(316002)(478600001)(966005)(41300700001)(2906002)(52116002)(6512007)(86362001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOBk4qdiUEz7Nb2JDuTMsq1IcKOGSnp7NOFE6YviCsFtCxPKiZCdTZM/YhhL?=
 =?us-ascii?Q?FOM1ZuecWLZeeGmgqjtJF2W+qRUffdVEuAUq4MaktCm5oITZdcjc2jEJeY3F?=
 =?us-ascii?Q?JGXVymM66aRZLpt8avKMLuOgFRpiiYptELieyqFNfCi9Ofs7h7y6yI1qKvAR?=
 =?us-ascii?Q?2LE2OaP1xgPyOHP76WApvHJOTqCrtzE8GHmHt3rRAoOigabqWa8Cyj8w4QKx?=
 =?us-ascii?Q?P/Qxa7BIgY9Th1ZsYcjbkMoCZ3v9ybpl+UkkQDuuKWAN+5VAcyWbk4a45LUR?=
 =?us-ascii?Q?oB3h2h+WHsin1LtG0bHzLCeRwxAVHs5oH6Np6wlDu0Ac3rCxlfR3QDm2LMZd?=
 =?us-ascii?Q?SZRURYm8rZGyTXIMbUrizog0edSABCDox4IiBoos0/dbieTfo5BrVvGzBK/t?=
 =?us-ascii?Q?V55acjnlvh/vhGb/nWvTDHII/26tcaGJ4ZLFtf5odWaA0P23bAcwVNc7IrlX?=
 =?us-ascii?Q?5F8PwgMvLn2iDfFCws4vTVFhExNZBCLdxRsM99h/B96zqOWY9J4HZM9efcWj?=
 =?us-ascii?Q?0jQcy4l2OL3YN8iShBA50ESthuFonvoSOK3IhVFhqR4qmQpp4osVagPETrmg?=
 =?us-ascii?Q?/hjGz2fObuw0pu7yyheE4mm/Pf0N5SKGPsDOxBmDnjqSgxXco106antbJ9zC?=
 =?us-ascii?Q?vqUaQWLF/V3XtjersXkia0ncw+rXRNoFo63Siv6pD3SwKXwkSKdXMD9/huv6?=
 =?us-ascii?Q?D2fGw8auLxSPmCVyy39I9xWUbnO0ho1LUjIra+kRefV6hRwK+qJpSQ5wHfRp?=
 =?us-ascii?Q?3HGl8RN5SQUe5bzykMnZJBc0AkuVHgAVwkSLjZ+ECFOUvqGwne9hzoLTe6LU?=
 =?us-ascii?Q?uHeWDtYs0c081LUNjodOM+JHezT5zbs2Ua4AA0EUInOB75Gjx1MPpAIYVkNF?=
 =?us-ascii?Q?wSSB8524P+FgDcbzJburgx2d12QHYi3Vxwma39SPKcxdu4gVbjj9y+z72UDS?=
 =?us-ascii?Q?J9lta3jg6EEvmeWJ6+75gWv1+IJTVQLLfDC6gpMYcLqnmX1uarbqVa09mn8A?=
 =?us-ascii?Q?4QNKMMiWIcFvofe3IQF2eyqx6VsWQ4MMGZ1TaBxhhlRWeE2iKl0KKzdGXKqY?=
 =?us-ascii?Q?cw+iFmB3YxETuuKpFHVn1MM6whBi0GQcPR+2RNBtqW3FfDNTig/5XmFEe16J?=
 =?us-ascii?Q?pNfYv+PW4S4J6MubwZYbr0UrHgAHN5/l4+40sylNz+p23Pei5szLAdr0R7OB?=
 =?us-ascii?Q?zrRaOfvrLi0pPdEZwEZrDTtVXHsqlUAQEtRT4VCJb1ljvi6ANshoBWlj2Jc2?=
 =?us-ascii?Q?SenKYpk+YXv8t/EQJdMnuCuLfONKq2IZ3xn+yDuJa59n19u2Y/7ID3RMt0JL?=
 =?us-ascii?Q?+ZMYO2ygaqBVwFc89VrtaQTIvx1KLDFOmMeOtPQzKXzzZheT40hPmIt75L8+?=
 =?us-ascii?Q?doaeHDpAkeolPIPsvus0F1GncBAO8UvoDuy/qL/uqgkJAJdrvB8SDKlQ6/Cs?=
 =?us-ascii?Q?jUE6e9KIuOVwHAQwvfIsySVTciH320FAsjMfZbgJY70rE/s210qWo6fURYkX?=
 =?us-ascii?Q?u86AodHpeakAq/2poUEkeLeP4kehl+kzIcjPc8p4HJ5B5AgAL3aksI8MNAfd?=
 =?us-ascii?Q?bwU26X2VcCdRcy5OgoossHzYTPwpoL3FguLfIWLNNhjwt5+I8bgL+l6S3KxB?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a2165b-28eb-4bf8-cf59-08dba542bc89
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9819.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 08:10:25.3941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dcLHTPLWhEPtBem5ZX682EZVlNLfcwLtz6tBUtCJb1K5sz5H04+Aa5R7WyYuRepL1tiBQobjpexPT2cHzrTOvyhyFi1HJ005UFgWAC3JDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6163
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

Padding the header of an external FIT image is achieved by truncating
the existing temporary FIT file to match the required alignment before
appending image data. Reusing an existing file this way means that the
padding will likely contain a portion of the original data not
overwritten by the new header.

Zero out any data past the end of the new header, and stop at either
the end of the desired padding, or the end of the old FIT file,
whichever comes first.

Fixes: 7946a814a319 ("Revert "mkimage: fit: Do not tail-pad fitImage with external data"")
Signed-off-by: Roman Azarenko <roman.azarenko@iopsys.eu>
---
v2:
  - Use memset() on `fdt` instead of ftruncate() on `fd`, zero only
    the part that will become padding in the new FIT file.
v1: https://lists.denx.de/pipermail/u-boot/2023-August/528213.html

I'm trying to be a bit smart here and only zero out the amount of
padding that we actually need, but no more than the total length of the
old FIT file (not to cross the boundary of the mmaped region).

See v1 for info on how to reproduce the original issue.
---
 tools/fit_image.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 9fe69ea0d9f8..d9da0ce8388f 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -497,7 +497,7 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 {
 	void *buf = NULL;
 	int buf_ptr;
-	int fit_size, new_size;
+	int fit_size, unpadded_size, new_size, pad_boundary;
 	int fd;
 	struct stat sbuf;
 	void *fdt;
@@ -564,9 +564,13 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	/* Pack the FDT and place the data after it */
 	fdt_pack(fdt);
 
-	new_size = fdt_totalsize(fdt);
-	new_size = ALIGN(new_size, align_size);
+	unpadded_size = fdt_totalsize(fdt);
+	new_size = ALIGN(unpadded_size, align_size);
 	fdt_set_totalsize(fdt, new_size);
+	if (unpadded_size < fit_size) {
+		pad_boundary = new_size < fit_size ? new_size : fit_size;
+		memset(fdt + unpadded_size, 0, pad_boundary - unpadded_size);
+	}
 	debug("Size reduced from %x to %x\n", fit_size, fdt_totalsize(fdt));
 	debug("External data size %x\n", buf_ptr);
 	munmap(fdt, sbuf.st_size);
-- 
2.42.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A625CE79BE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 10:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C38286ABC;
	Wed, 20 Sep 2023 12:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QO6UTMiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF1E86BF1; Wed, 20 Sep 2023 12:34:06 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CBA86ABC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 12:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No40dbfWdoIFPtz9oR9C/4YDwBMpQdFmRHFIrNu6/kvsTRrBZLImLBdDKSfwnvmnkT+6MMYN+F5b3wK49yvNTM+akq6z/M7TkDQwUjkvxiuXHQWMFgC9PIle7uOeMHPKt2kzrG1f150GDifTRJ9DHduHfMcR5M/9SmcvC8ZaOIQ5HtvR3e2qJdtuu6vlY4U5lQW1H4P/TjSFrgHllBaGeKOd15cZTJwZmH+oi+QC1kClynHSMasW0lbMYfP5r6fXcbeWk0Qu9fLdGCZqf3DljkdQf2gCKGwH3FAxIx8H+FOdDxZ5CwZbFnp+kWtEwnhFlwkqyvyCPapZsjin8+G5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzeQ/Z2iAZvFf1YG2KFd79SMNRcZ6KOopZ/sesqP3tc=;
 b=Q3L8CCldjf4XCLMczNBjhOODQVzOuSW5Ks4TXV5Jn7wYHCJBojCcbezVJx3sVza9iBlJdjhunJFZq+FXBw0RW49QFGYt3QdxPUBwHIKDdIM2hIvsHTtcuXqR1d/BRGMkbQZ+0i1/huNam+JU51OTE6Z6JacNxsj3OENHxWxsq6Y0rNI6uMKqQZltYoV50yYJY4wqFTfuCPyRw5uKoV+lziC1zh/yNIwO1Qs8MSwuuLGW507ewc2p1xKQAkTM3QLWB0C6bzYYyvj7AgDmZrhqBxyFDPzXy0cy7Bg+SXtjhq8lUIFlibqYZU83sFeRfchh2v5tEJ3JaRwGITFMhNiHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzeQ/Z2iAZvFf1YG2KFd79SMNRcZ6KOopZ/sesqP3tc=;
 b=QO6UTMiSNVLttZ3JRdX2QEF2DIypIO3OlUGxP9+UW0I2CbMGVnauIUcRzthcRdhLla/D2A4TnlDzYFJ5AzbykMFxXM3C726SHIHebx2TUUUdzLwI6F6zvTiuXSt0+URhjYs3KvZANQUSUZONdxWtQJhLHBvaK5a/9LMcC6ZZ9AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM7PR10MB3496.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 10:34:02 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 10:34:02 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marex@denx.de>, uboot-imx@nxp.com,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
Date: Wed, 20 Sep 2023 12:33:52 +0200
Message-Id: <20230920103352.154366-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0046.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::6) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM7PR10MB3496:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e67dbd-ab87-4b41-8c4d-08dbb9c51b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJNxopWazf4HjykZBhW5+BK8bvhpKoiur4syotLJOOMIauPKyZTd7kK5IkdaZ8WJXLJx/Enbz1e0mJzA/GWLCT3CJA6kTP3hqTfHRGQ1sFPvvXNBiy1dc1Z7y8vInzUg/nS177myhd+paHLQrSuxgMTKkqSyvul5LJeVc/DAQ1Xc2LpXBABpUR+aOmkB+dL3Kgq7L9SAFwBAPJ0/gw3xvUt6cTx/JAdsnpTjirJjjhbGGCaCVE2tdSmsNpoMmXL4BZLuwgTYbv/+iRfcHYUBsKbhOuuKX34g0LIoMIPIyIM8M9hIQhwd/HnC84dnNj6legBx8ntygrYbM9Mlet+QjZnf+pBfREAxj6Z4ar4hFJkCiu3+yLlAMbe1HulbYCNJ/Eo+YYV1jnidsHXSBYjOItwqC8OyMDRqNc3gX+hCj7PwP4KvL5aVYAE8kXMu9NfSeaJ1IpOpprGDhdPSf42LCvV+eRf+c45TGJC509cYcMs3K0Amhbb6YV61x/MbG2cixIqoLg1qXZXa7HshKDsFDZgKlrQovEiGejQzhM0LyBK91wZg8GZ+HpwVq1FHBH20xPP5OiBB4RwH1Ws7spWD0h3EZuYn6Vs+oPcqiTl3RfJYF02NROsoXfunbND/1xh2vbS3GYfycjeNi/ECnj3JAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39840400004)(376002)(346002)(1800799009)(186009)(451199024)(54906003)(6506007)(2906002)(316002)(6512007)(83380400001)(2616005)(1076003)(107886003)(26005)(6486002)(41300700001)(6916009)(66476007)(8976002)(66556008)(5660300002)(8676002)(4326008)(6666004)(52116002)(66946007)(478600001)(8936002)(86362001)(36756003)(38100700002)(38350700002)(44832011)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDDTACh9Bp3GByvWmLtX3O5SP70NFmuYFJk0LzJBf4OBMO/7nEa0/110H2oD?=
 =?us-ascii?Q?d7oWsxMKvEbhsLGuqv+M7Ha5nGo+e5KbZew7JeoA8O3xOpcyxH2FaFS+1UB9?=
 =?us-ascii?Q?SLSJlaPm+Y7LtUJboR2kanhaDU62kW5s/UCiy+hJZj3f6UfUdUkxoanqWuVT?=
 =?us-ascii?Q?268tsatP8jmLkWPkFxxzXn5sVP/MjjxUbzYPWfw8nA8wLAdepzppYSPEAH3u?=
 =?us-ascii?Q?O1+sj+kMzhtmnci8z32HvZ0Ae44xXBvFh2GwrRvrZKeCblQCltEv7Zdz2Typ?=
 =?us-ascii?Q?WarSpFjGOhsxzk1a9Eo6NHVGCnYKh6qYiLDnO4x/Wyn9uaRe2alNWfW1l7mO?=
 =?us-ascii?Q?ybjITeaokRStd41joSEY5h5NataoT8TAeLtk9+Wlrg/sn2rjC7/PoVW7Lp0s?=
 =?us-ascii?Q?VgaRg1oTqGF0Lha+F+SpCNE/orTTsL2OAcSzjqTOt8r9ok3Ie5dVUh4Xoid+?=
 =?us-ascii?Q?hG4ziyV3Q4iCp2MDVxTymEq2PNLpqCUcuyrw48Dme8OPtytK3bzcCswND349?=
 =?us-ascii?Q?x3t2f73LelDueVa5qw/ZyIR7YZbrn9cZTCaCEWXh7D1w5+L3OUWlgpOFfGVG?=
 =?us-ascii?Q?cBbTINQHhS95ZW6ol04Ta9nDVsTmSBcIxCtGk+BHQoHPFUq2BZz4b0VILsi6?=
 =?us-ascii?Q?XTPjXbuqadK6LsHK8ljuUXQ5oHFadGXbDViSQcZY7Xr7L6j/ElSd9EZjMx1j?=
 =?us-ascii?Q?15sko0/+UMNztCjjdzur3Y8RpSOQLlaNQS386NSVhcUbsdmdZDt0qQvZTf5m?=
 =?us-ascii?Q?8zZXifGKtLpXr/qtUAgVs58SoHxAyGW7yo0jGMEZPjVIeLjHvZcpxXyrxyAy?=
 =?us-ascii?Q?to4wC5CgCka/wXIi/6ewPf+ZBUXlv4WkzbcFkc43qL8YxcPLP8msATJe4rXs?=
 =?us-ascii?Q?1WaU60FEg7cHgn3+yghlfsbpma+7WctRo/vopSX7gzcXJz+Kk2HG+/sEGk9t?=
 =?us-ascii?Q?lhDDWVf+Rxes2Lo4/4Zcgz1Wx9blbHZEhDf7vzOQ7aoCNpxpkLlroIRnc+uh?=
 =?us-ascii?Q?MbRT3fEUVKZ94qUOmKRpdOnUbkn6vi7SwXLLEJPGwfyl/dQCb2fsMm+QAQK9?=
 =?us-ascii?Q?RBUckxXzQEr2LOAY5P43OsJHkMpnPkjl9mDb3qgdIHoiLkTKuwFk9DMn3zyH?=
 =?us-ascii?Q?xcVQg8ZjuW/whSgrslZg2X8xjRnUgNJHl11yu5J6N+LUee9huM1Napfs1BGR?=
 =?us-ascii?Q?Db6g4u1ioBLJJ/SjYHMRU//A4O+4GApglDbWMDd7yTm6Lcvp3nfBnhFanOT5?=
 =?us-ascii?Q?WCLjrHB7hnknSEBOzXBzuaZtNfzXuxtEnRVkfKU3tyMc+S6mNWy4C6O/QDOY?=
 =?us-ascii?Q?WLdUmhHkrTs5VYXLXUICtSD0dzqUrDObSYesvkJRY7PyUiMmijAjayzviV3l?=
 =?us-ascii?Q?5ZfFN4jkv4kMJq6GgFjyx8r/hxMvHFy6N2r9IScRM0he7KXxXvFn5JNGemjW?=
 =?us-ascii?Q?xOU46JUfbDX4/cGqXV2S4JL8tNyKjyoPzzYw4U5Sa6XuDNFTQGAMprejmCz7?=
 =?us-ascii?Q?hjXYb+KkblHQlN9/hUUY+Uv3gICVrXheIioqaDy2jAa1Anp2XQHl6/XuXZ3I?=
 =?us-ascii?Q?tVuD1tT9Pl0Rm+LmbwXFkGNEqHTmYTyiMIdcDwA++lEIrHJ1hCE1A3hlOFCt?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e67dbd-ab87-4b41-8c4d-08dbb9c51b2e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:34:02.0105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXBM03TaMO4vDJj9ruhPmWr1ZDcBw+U5MZbkjjHcNeS6HbqGHK1bvRv0+UfhiU0X1kiNrqPn453GBcUJs38VGmPIXYbJdeTV9/7Cptec/A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3496
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

When built with CONFIG_IMX_HAB, the full FIT image, including stuff
tacked on beyond the end of the fdt structure, is expected to be (fdt
size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.

Now, when the FIT image is loaded from a storage device, it doesn't
really matter that the flash.bin that gets written to target isn't
quite that big - we will just load some garbage bytes that are never
read or used for anything. But when flash.bin is uploaded via uuu,
it's important that we actually serve at least as many bytes as the
target expects, or we will hang in rom_api_download_image().

Extend the logic in the csf.sh script so that the csf blob is padded
to CONFIG_CSF_SIZE minus the size of the IVT header.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
v2: use dd instead of truncate.

 doc/imx/habv4/csf_examples/mx8m/csf.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/imx/habv4/csf_examples/mx8m/csf.sh b/doc/imx/habv4/csf_examples/mx8m/csf.sh
index 65c143073c..cd3b2614a2 100644
--- a/doc/imx/habv4/csf_examples/mx8m/csf.sh
+++ b/doc/imx/habv4/csf_examples/mx8m/csf.sh
@@ -75,5 +75,18 @@ dd if=ivt.bin of=flash.bin bs=1 seek=${ivt_block_offset} conv=notrunc
 
 # Generate CSF blob
 cst -i csf_fit.tmp -o csf_fit.bin
+
+# When loading flash.bin via USB, we must ensure that the file being
+# served is as large as the target expects (see
+# board_spl_fit_size_align()), otherwise the target will hang in
+# rom_api_download_image() waiting for the remaining bytes.
+#
+# Note that in order for dd to actually extend the file, one must not
+# pass conv=notrunc here. With a non-zero seek= argument, dd is
+# documented to preserve the contents of the file seeked past; in
+# particular, dd does not open the file with O_TRUNC.
+CSF_SIZE=$(sed -n "/CONFIG_CSF_SIZE=/ s@.*=@@p" .config)
+dd if=/dev/null of=csf_fit.bin bs=1 seek=$((CSF_SIZE - 0x20)) count=0
+
 # Patch CSF blob into flash.bin
 dd if=csf_fit.bin of=flash.bin bs=1 seek=${csf_block_offset} conv=notrunc
-- 
2.37.2


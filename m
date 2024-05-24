Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B3DC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490DC88254;
	Fri, 24 May 2024 13:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="a4BT8aFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3768800C; Fri, 24 May 2024 13:23:31 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163068830C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAvA1C2jBO/FmRabWKROkdaABSv04hebadaNE2OIrcIDftlM+46R2wruCa+SVxH1KcyYGrtuDMMwdxC7p3CsmyeBmTvVUKrOAO9j6mS+gbP8ivkWU1sQNR7RWEp7CxxcPskap5aFfrcEcOIVMzso+jndoOq+bYzjahe2sWaxJLpVTiiv0/6CtYT/rQ2XLKYNjUS7riOzel+RrCVb4vlOtJlYs4nRCxjKOIfCoAEr3KG56pDXx4tgnhdyuZPKjy0GSm64suYukpAp2TN8O+n9gocSyoATucQWOePFmNgiipxwKKsrX3cHRANqiMznM31smKheUpUp6sX3KoYjVD8Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbu8bm7aKlurJ0HpjV6U8+Dw41EfBkVKmqzNRJ7THjA=;
 b=fLByjdYj5E3Jb9V5H4vJbo9Rui10Lw4wVthsw7G0gQEV9uOGhk6qqtusbx82aw9XavcB6bmUiPvqSC2oXKWOEtRTddFJEPgMOJYy5m9hHtv5VCLVjhYZA9LlfA0M16FjmCogPbzIlWPAS1bBmKLLSfLcqDASkiqYqOkFb7gYRLXGzWVb6yoPUWcW9P0hKU0joJA5EypaNyQ7V87PuRBMti5IXwHLjUUh8C0kgBlCHDgLxHPk3UnEY7SXQXSyqNXp9YPpNKUBYUD8MNiQhq78jqFQ/H+v4BtlGNtzvtYkjuejT3QCv/TQzB5CqbTI1/Z8F9Dl3/Qcbq3bmMJzFUZE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbu8bm7aKlurJ0HpjV6U8+Dw41EfBkVKmqzNRJ7THjA=;
 b=a4BT8aFhaUsRQ/dPNnDtgioZFaqudFjKv1WJWdg4KoD+yqO1DB7aI/UKfr9ptjyHAcvHhAkn/7ORpgPcUfq+hqya8o+SA0nIenz6/czit20xhmRID2X3/De8sk/Qcm938IkJRQDdSIe/aJcrofgnalRg2bw4FxSF3t1xT0h/UqAy/Z2Rt9xvTWct0UJEO5/L/g2meoZJCuGKwB4omHtzqYOHyPkp6hnXwGOn4tuurIBAN9zoOJCaZrpZLYk2xE/A0xy1ABwTe19gzUFl/I77OHTDLKatNWdiYcRKRIth56mT2qWcN1R40PzusEdnV13WQhDaOhTzanNbmrVqspWL/A==
Received: from MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::9) by
 MRZP264MB2905.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 24 May 2024 11:23:27 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::cb) by MR1P264CA0194.outlook.office365.com
 (2603:10a6:501:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 11:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Fri, 24 May 2024 11:23:26 +0000
Received: from sahess08-ThinkPad-T580.softathome.com (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 570B420067;
 Fri, 24 May 2024 13:23:26 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 0/3] *** Allow encrypting data in FIT with binman ***
Date: Fri, 24 May 2024 13:23:17 +0200
Message-Id: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MRZP264MB2905:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 43abc509-37dc-4dd9-c078-08dc7be3ee71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yfrQKQlzSVlEBsMRMuu2mopJY2N/X5NqQhsaqL9cP9+7xJRCrg8FKOhjsSFE?=
 =?us-ascii?Q?vTDRZAKVUl60rdR1ocdRpIDr7ah2gCghJTfXE+QIpNBNbDv5P1j//X7b7zf5?=
 =?us-ascii?Q?PY4sXQ82vz4SAgfvby2V/XqYzszvYbxU7xm1APLIRDI49Y2k+Q17vlKgnjTX?=
 =?us-ascii?Q?kyGGhnfqJzen4RgtUQ97MAktleMHaBElf2ZTG9KoF22MGChCvmOJ5LbOEUrl?=
 =?us-ascii?Q?s/zFj2XBf0+3X5JCSFrMnIqCVrx1ggvHqt940rO7gIZwFAnDFw30iVFyQ7yq?=
 =?us-ascii?Q?dS0g0AlKnX+REJdjwjPTfA1J/Nor1QrADR11m8XlrvqTV5TLfO+bwMuMoo3V?=
 =?us-ascii?Q?FR2GdfittLyJyeBC4SPTJAE859o9lw9nCjj0j5TkouS0qQwCg8Ce9B8pCqR9?=
 =?us-ascii?Q?bQEe7L1ip+Xvtz8/NLeMkW7NtrgFY635o1kzLqZFEyxIga3FX79xDBqjbXot?=
 =?us-ascii?Q?w09tZnxX3AoNLy5GUlB7QwUrmiFU2d30WqrdARFSkg8/1QS5DZeyMjMJ4glm?=
 =?us-ascii?Q?mFqfo9+L/YIRfcyixmwpPHp6SpNBktYlg8UtSqYbHHsAQ/a/Btl9siMfX1va?=
 =?us-ascii?Q?I97P/BQNqpN98A4E01xCBvRFCz6uBVH+KrN4qYSEXioc/09SdX/sQlQiLJLa?=
 =?us-ascii?Q?T1tdk+gC3nt1cIKfbwLJVOYVVuyqyKAgZdCekgp8i0jq2jfoTtO3LHIzHOuX?=
 =?us-ascii?Q?eUS0z5APbWhy8vtJYZWbOtHSjdev2IuKveYpqyqPFNzN1scl+CPej3CjTXOo?=
 =?us-ascii?Q?MNGlJkwwZWmbnxWALjs5mNOXNe29pdKH6YN3CjdnyuHJJGxWBJCVDwdpjNiJ?=
 =?us-ascii?Q?AsZ31oebM6RXRCUNKYYVNgF+2p4g2D8Hx5vTqHfaVFh8nGuQ0ya5PJVtksPR?=
 =?us-ascii?Q?kJKysAJ/WA9/KzkQqf1y1OrlSL3FNyYe5KQyDtUA+9HcCzdbGaxluSxCllm3?=
 =?us-ascii?Q?lfBIL7HP0uL8s2pS0vTJTohKC+yzRCjE2VLyZXdfl9hIfWUyuy8iLAKhSL79?=
 =?us-ascii?Q?dbgpc2UWXiTJ+3Zgc6Cg9pCcI/5GXJqn1qy2JjastHi7Tv9RQZ1eD590Hz/g?=
 =?us-ascii?Q?8u2C/bCSLSsLU2vFxTi2RJ5uxSjRh7Pd7uvmMKe2cpAbP+1fa/+j3+Kt4HsY?=
 =?us-ascii?Q?iOCxF9H8ycSbpHryToX7ZP08AmOciaxKv239BKCtl4bzU9Jty9S+7lXWo5Jn?=
 =?us-ascii?Q?uedfpVYFIlyh5ip4R1Lv71AcRbLOR6+oeGVrK8W4Jy10T3kh632eak6BaO6N?=
 =?us-ascii?Q?F3zMmeXiz7OE9HvJlmlUrrEb+M09RF/Db/fovAivslJDKtzvNY8y0c7Pp28a?=
 =?us-ascii?Q?YCHtcA2JORHYTpdoCXV4PoJmiz5B+tT+9szN0LiQPF9Gpdr4qPnyu92p/PHx?=
 =?us-ascii?Q?RCeUKXOHWOhamgQeBUJbJoOJc+JQ?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 11:23:26.7367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43abc509-37dc-4dd9-c078-08dc7be3ee71
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2905
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

The first patch 0001 is required for patch 0002 as random IV are
currently only added to the FIT if the encryption key is also added to
the DTB. Patch 0002 then allows to use binman to encrypt data in the FIT
generated when mkimage is called by binman, when cipher information are
provided.

Paul HENRYS (3):
  aes: Allow to store randomly generated IV in the FIT
  tools: binman: Add a property to pass a key directory to mkimage
  tools: binman: Add tests for FIT with data encrypted by mkimage

 lib/aes/aes-encrypt.c                         |   7 +++
 tools/binman/btool/mkimage.py                 |   5 +-
 tools/binman/etype/fit.py                     |   3 +
 tools/binman/ftest.py                         |  39 +++++++++++++
 tools/binman/test/326_fit_encrypt_data.dts    |  53 ++++++++++++++++++
 .../test/327_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
 tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
 tools/image-host.c                            |   2 +-
 8 files changed, 160 insertions(+), 2 deletions(-)
 create mode 100644 tools/binman/test/326_fit_encrypt_data.dts
 create mode 100644 tools/binman/test/327_fit_encrypt_data_no_key.dts
 create mode 100644 tools/binman/test/aes256.bin

-- 
2.25.1


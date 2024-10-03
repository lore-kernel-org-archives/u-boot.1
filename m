Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173EACF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2BA188DE9;
	Thu,  3 Oct 2024 16:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bKyjjgLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF76888E26; Thu,  3 Oct 2024 16:10:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA36988DDD
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blD9It5yUE2MbibQ5W3ZLnlz7Xh6Wko7yfsdPpSouVLK+KvFBtj2dql1v7XzphWP0M+oY6PTmPk/0Lon4psGODVglSaNRT/lwkT9s2vYnEjPM9iin2ro5EM8xcyf0vvFzkajcNOR9Wc7i7q1AxjP5Z086/C5XE9N65b0xvB/Tn10CcF+RUbFksD2d7Y/d4X3Wso+rY5UpVpdLnuWiXDRJleYklyh8UbPjfx10UONOKnL2if+z4oLnz/ZnLWEUrJTL2B0M8aNHuhoekOv3+0r9zZXBVoKJI62jjhoqWg57TwukER0MdvLK1ZBFgeUP2f4cIBoMM1dojbE4hqSv/S8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAQm2QdmwzhD58O3Fa1jy5mMXe2cKFzxaH9s4s5/BBc=;
 b=QshEEqzWYjryXh6kx5kj/QImwdxIZMV5GkxHqLYhkk+yHg4nICL/U4c24MVtSDP3klghYvfjIYJY0FXOA7jCKT9/H79nCN8/4Wm9D65rVztLzD2QpEn2Z0l9riqXnDlMSMxa6n+YwNoBEPIiIf9nUrSeswoavB/jgP2+L7w46aeuH4eCxYSMhheAXyRssxCCJgyIH9PhrRnfg7WX2eAhzPdVdowEziOAOuHjaL+8xbWbaIOLFCvtzdM8RcLBJBeZkJFJ3DEwJKytFad0CwIYGDKnKjlmlsdC33ryPuhWhmKt9kbsqOjU/Pu+rAB8Kt0IGm8opEXqF6Q5cZFaWVRqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAQm2QdmwzhD58O3Fa1jy5mMXe2cKFzxaH9s4s5/BBc=;
 b=bKyjjgLMXfK3ouytRUAaMPK8ddMIfeMmfgAuBNGLR1RzVnsnFbGNCQWMy/1jX9edJNaH5fACjlmi7mV+10L+VcKR08+802S8Ancc3C3X6Z66lo1mS3H67e19vyyEKf6Z34jhUtw9SjNKI1+/8+Cq40VyPgrup83pbWw7FJPfz3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 14:10:31 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 14:10:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/4] serial: do not overwrite not-consumed characters in rx
 buffer
Date: Thu,  3 Oct 2024 16:10:27 +0200
Message-ID: <20241003141029.920035-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003141029.920035-1-ravi@prevas.dk>
References: <20241003141029.920035-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 924f1657-eb7b-4d79-090e-08dce3b52401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tDVMsT2zkbiejdXgWctyTUkQxgLFOtZ5LHZxI9iftCwCZNkRqWrblb0EPGW9?=
 =?us-ascii?Q?cH2FK/zKKRJ/Abe5KpoUGOvz27/gVpCCzc7VowpCPU/IkoT2R8yhj4yIpJ8U?=
 =?us-ascii?Q?nSNeTFRj16M/PjhXU61oY2M4YJg52/QQC71LNeGxXl/bsrFR1nHmXuzZq9eJ?=
 =?us-ascii?Q?DXYUSuLnAIokFqda6O7rLclLcYoH718LhioHEoSU4dex+1JulbiZUEQd6tin?=
 =?us-ascii?Q?Bg2KQYN+pUrwdJoo9bzdF8LKqiEvsc3oVm33hqw9N8zZNB95k470M+nrpEsc?=
 =?us-ascii?Q?QyXZ7Iz+HZENvQcHQvgtgcKo3+5d6VLW/WDdzRcGzZ/MfkkK7SMqV37D9atS?=
 =?us-ascii?Q?ERXFoNJo0juLJwLlA4iNYsJ8uyPAgzFoU3LgRg2tFLBSV8EX3aUl0bKtXhHM?=
 =?us-ascii?Q?AhNmv7xoRvG2SyDdekokYk+HSZ3lctZS+41QO+GqeK4ZGWEiA4ahU9pwzxRx?=
 =?us-ascii?Q?9ekYjuiBKiDg1a/T63hbN/FfsdsZ5uFlbeIlikE1WKsW0a6bsCANFFjndyU3?=
 =?us-ascii?Q?3ZhJb3ncX5nOq79Zjvr4OdzcHCtF+/aePw2qdOKHbmkSV9y3W73R/jyKaacr?=
 =?us-ascii?Q?lfhpToUYh1OYm57Owjs/+xjFn+R/EgJszneyMpMHWZZhPVI+rYYZywg9xADq?=
 =?us-ascii?Q?VXpzxS7YzwLYZmD9FzETdaQdwQ0tQF4nRgM0am4oUftT5Nkn5Zdwzi0MVCAD?=
 =?us-ascii?Q?zooO0SXBNYdOrQKRypDTBKQCVCSHpyVHjx71mAeTUBxdfH2FOZqqkjAieyWF?=
 =?us-ascii?Q?C3gHONkcCgzXfYIgecmIjX+eqboDhtPnUTxnGjj4wRzDQILH5G0CpYRbj/HM?=
 =?us-ascii?Q?ZBCRDqjZESv/uNeG9Q4Zq3Rjg4I8bD/ESTHS6N3CrIh6agErDMWgPb1PpOw+?=
 =?us-ascii?Q?6hoxo0zmkxcHbogyWnOSI7/IqExTb8FyxfTk3yaNELHPEBVy9e3FxDPXZ1iX?=
 =?us-ascii?Q?ZtEX3ClEflT9lzG6Yeavrq0edYC/VhArsGtxRB0h3WmQxYAKjC88i9wFhW+d?=
 =?us-ascii?Q?JSTpFMn54hzXlTSNXuFpzt7Z6Rw7RnIOSgbqxn3nG+oz/zMaEKI2bMsEzu+s?=
 =?us-ascii?Q?PDDqkAGDwDlIMQV6K78CGRwyinpWn4buB/vk4N2QvMCl9/mkBOE5dyNp6Y0R?=
 =?us-ascii?Q?mOsXkL+/bvF1J4kmF0+lPHXRPcW5oGRTLc3PVLJY/20xh+ciwl1mAmBlc0zE?=
 =?us-ascii?Q?3lGMknGJH2qwGw2UDEd+AjeM9VlutpsdjERdYgcHNJ/yKGTX45a+WJguf7nC?=
 =?us-ascii?Q?4K4n/Y3mdEMXKepSN6ehJRiXvK+y0UpqK8r8bbBCPr4pSD7lK4qr3E9A14u+?=
 =?us-ascii?Q?BEme5pWAd9FcO/g7B6BFfzTa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lKf1vbSow5ivpHpg/aeu0wGE4qTQajrN6wAMG5gdpKGzirs4wjosr0lte+I3?=
 =?us-ascii?Q?Z+ZUUjxZvEdqQfFHEiMb/5n2I+bn8yLiAWUnb53QDr+iXOSEH9dqxoOBMs4H?=
 =?us-ascii?Q?pwlIMMVFUDjkvPzZUS/npYINCMuf5d6sYQwA/DfkiP/BIwUB6q+QFQ4Jvt+C?=
 =?us-ascii?Q?b2LUVXApRT812LUV1n83voWwU/kzQNtS8lYqNaKAmC/oecJ6Wm1a9TJhgsUU?=
 =?us-ascii?Q?885jzrpqftsa1fI2W0o4WpO3UOW2BybHswbccQKeu152RT1lJBsCuVEHv3z4?=
 =?us-ascii?Q?ghjv9IrRKAHcGF5P992Ov1WDBga4F7Y+nlU27aI1PEix7dZW0ah2qmgsKAoE?=
 =?us-ascii?Q?TwfaqL5ndpIORUyHasDvbA1jVt2ZvKRdPlIQQEKPBomNXe1kaSSIeVjmdmaS?=
 =?us-ascii?Q?JGzyGLcC4mNUd2QfHQd/fu6kcMLzlOX0imK1EeJHO/lfprM4mV6d2YzXf9ov?=
 =?us-ascii?Q?4TctxjW+NrBJObnoXz0VYbXWYQ3U7E51P28ZE/5eZNOVYIuHPy5Fp75BeTsm?=
 =?us-ascii?Q?U+cIJG4BpoXwx1NLiUHIZValZ7rn9LoP/HRbq9BuMI5eyOdJ/08x4ennnlh0?=
 =?us-ascii?Q?cjAXij7yJzGi+dZ1zUkW9z8C5+zYR/kf2ROtN5348UYmwiDfX4F83jNm0Nhf?=
 =?us-ascii?Q?LROq0lA+s1BCDLm/8LU3JA9fhVV8iVEC/dx/lgPiLIuKhQopiIouyr5v2boG?=
 =?us-ascii?Q?lquzA/h++//0peMN+A9TaegWSQwN7cQ8nLIB7SyEi74WNavzkI3LYxBFK+0f?=
 =?us-ascii?Q?yfr03XMHRu8BvXVoaqJtq7J+errQiJKUnG/aR/UVXqyj7GEDplZ/qLn3OVMj?=
 =?us-ascii?Q?SoMeH4GjF/kVBn9W8p7Nf+6fM9hKyObyCeHmlRnLhcq7IBdbNTlll/jn1wRU?=
 =?us-ascii?Q?mi4K27IF7HjDEq0dRXNnuLxdTdGIDkCxTnF7gIv9XmGOUx1ehAE17ZazNptb?=
 =?us-ascii?Q?xNPDNQ56c0x7Nf+rVmeBBx1NID1UjqN0y2geCO+6Mjo9xHi8INbs4m+T8RiD?=
 =?us-ascii?Q?BzwwSfo5MNT72ZJFsig2ZjzjiaBqaPjGPjM3SJ96/LKdcnHfvwAPCtQZD69/?=
 =?us-ascii?Q?rUpG8rQtPf1XTJbBQUdXDoPpcQnL3RZZ0gXYZSny7A5PXttRV1NfBDNlzSXU?=
 =?us-ascii?Q?3FB68QuF5+TV4mVMD9C9GoJytbGWKzr5yL76z37TInsxITmq0QcwfGE1ngoc?=
 =?us-ascii?Q?7z3fnskYRASw3CY8xEya2mdyczNPAyVxNLX4mgKXOGXEZ6Oe6OPzMVeIPF1t?=
 =?us-ascii?Q?5CNRLcQTM40oBpXxzgeVU9azqk3Cna7Dm1H1iF2oSPr3S7J7lzNUdcHe8c1v?=
 =?us-ascii?Q?qIdFq2FKPYWQ3dPP0OR6fFv98hIMtDxN8ANgCRSRbjep1StqKh5kHCoP/x+W?=
 =?us-ascii?Q?mjDFYx8nzBX5/M+xgge3IBsmLvszjReOs7zylZNcNlGXKncqe62hJm2D2zuB?=
 =?us-ascii?Q?2ASgBjRH947K1/1m96MK3aRQTN7cOcd2sDk98ANUGCVm6sG3lbhi2TqsxCcC?=
 =?us-ascii?Q?STi3fDwq5+0pW27RT5b07y25DQv1W/4ZyPbmC1oiehu+MykQKk0y+MkC6yDq?=
 =?us-ascii?Q?aa8Y2jwvQXUn2m+n92ucXchZkUCvfTrreJgV6N0C1oH08pWtQOK56XHl9yYt?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 924f1657-eb7b-4d79-090e-08dce3b52401
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:10:31.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVIUN3OTsS2XeT0Gs7tOwh2yjhYGizFB/P6ZaPr/ieQJmmsMnVxQsaprNJ0ltwRd+UsSfbtqWR5W7XKui/ATyIA7NivYkDdZD/UzsEpU0sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6676
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

Before the previous patch, pasting a string of length x >
CONFIG_SERIAL_RX_BUFFER_SIZE results in getting the
last (x%CONFIG_SERIAL_RX_BUFFER_SIZE) characters from that string.

With the previous patch, one instead gets the last
CONFIG_SERIAL_RX_BUFFER_SIZE characters repeatedly until the ->rd_ptr
catches up.

Both behaviours are counter-intuitive, and happen because the code
that checks for a character available from the hardware does not
account for whether there is actually room in the software buffer to
receive it. Fix that by adding such accounting. This also brings the
software buffering more in line with how most hardware FIFOs
behave (first received characters are kept, overflowing characters are
dropped).

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/serial/serial-uclass.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 05fe9645bee..28d7a202afc 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -328,10 +328,11 @@ static int __serial_tstc(struct udevice *dev)
 static int _serial_tstc(struct udevice *dev)
 {
 	struct serial_dev_priv *upriv = dev_get_uclass_priv(dev);
-	uint wr;
+	uint wr, avail;
 
-	/* Read all available chars into the RX buffer */
-	while (__serial_tstc(dev)) {
+	/* Read all available chars into the RX buffer while there's room */
+	avail = CONFIG_SERIAL_RX_BUFFER_SIZE - (upriv->wr_ptr - upriv->rd_ptr);
+	while (avail-- && __serial_tstc(dev)) {
 		wr = upriv->wr_ptr++ % CONFIG_SERIAL_RX_BUFFER_SIZE;
 		upriv->buf[wr] = __serial_getc(dev);
 	}
-- 
2.46.2


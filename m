Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FD4C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6069880EB7;
	Mon, 10 Feb 2025 17:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="W8A/Uaif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB13B80821; Mon, 10 Feb 2025 17:07:50 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937BA80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxmrQ3An8d9vwhPqXuGpklo0Co+BoktMod6kI0Y3i+00gcx3A/PMZ5c80qP+gyEmxRLA5Y8r7tFk60tT/OmsD7/hoRvnwIBRGEYXDfkkYue+NlZoM4Fqt8rfs+WNR/8JAvIvXFi6mIUur/QqoGvNGJUtcRssW/OATLviee0WWozhabWr2VzvU4Q4KsXVwYbC6nvDdVR2AWazCOk2JcSaFYnc7mS359DNKm+RGN9eZr3E7PNHmSojFl+kztJPaw6L0keaegua6X3kR+CrVKhnEEIN7O/Ga7UuZgXQtrZxW/dhg/HYSG9eURx9BzSFF3C7nSO9aND32d17FSgimjIcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkhbid6qPb5SJ3URcRlQT4DVHv5mY8pFl8YWKimuaNY=;
 b=iJ+RHkrgWTjAaGiXv6Vqgm+HzdVHH1qWHL/G15OOyTTSnac2Lccy3AAcvK/qUsmci3LYEFNRCBZJnzBuDnVdYjx1lMw9bNvg7IA2CL7dWBZkV52d78Bbf00HKaoX6zkTbWeIHwGOryrYvN7uAFz9ev//Yt9xLRcfywMPz03FLiyJVPj3Q6LNDnhefArgz50M/xjq5ChjH8vnLYIqJTB8HJvUX7DxRWrjN3OH4eVX8PjjMSK4wnQzrmqre0cmQuB/Fp20al/uoEpAsGj/Jwj6TU/UozyhehMdYCDCP+XKf8mviGQUFISz6Oot+BdA2fsuCHb0trc2ST+B3Fgfk73CaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkhbid6qPb5SJ3URcRlQT4DVHv5mY8pFl8YWKimuaNY=;
 b=W8A/Uaif2V+QlW36Zjqxy9hJiwHyuwOod/Pz3CGDdHN8mxCcNC1zzy1V63Ok1aVzmEllYx3BhoQIsSFKwWwHWj88s9d55Eei58aCMXJRqWSC71v1cSlAL0IDUCruqJmSiJLmWNgRWOBLQ+1+x77xFHxqWelFPJlGFOJUK9vUwCqlkER0FPed3H16VpDeXepinOboy+aYjsuZJs+n4p9Mt3S8F5zn0eF5f4U3aexugvgON2+x3pr8HEMRo69bYRVvMBO28nMZ1XyekPrXV5MYtXX8OEFJ15prfPqFpAdLtDJQJwrs2rB1i2o4TDPfgDayiRXprwcmY82oifRRuib7lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by VI2P191MB2495.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:22f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:07:45 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:07:45 +0000
From: Pawel Kochanowski <pkochanowski@sii.pl>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Gabriel Nesteruk <gnesteruk@sii.pl>,
 Pawel Kochanowski <pkochanowski@sii.pl>
Subject: [PATCH] efi: Make FDT extra space configurable
Date: Mon, 10 Feb 2025 17:07:27 +0100
Message-ID: <20250210160727.30993-1-pkochanowski@sii.pl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ea::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P191MB1394:EE_|VI2P191MB2495:EE_
X-MS-Office365-Filtering-Correlation-Id: eb237b4e-1204-410a-c26f-08dd49ed0e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R59UFBf3N/2Bdo1EJGovjE+Sw6yeIgiLZiyeA6xNJLa6OAI3s0BC4F14y94a?=
 =?us-ascii?Q?SjXEkJf6+ezoSMdcZPYyvmd82SmrOLusG5my04N9vKOGdbsw28/dTUxzNa/x?=
 =?us-ascii?Q?z+GeiYJcX7j7RFXR5xXSTlhR83RYBgr5fcslSmlYDbLiP1eBugNg0lez8svr?=
 =?us-ascii?Q?KgywLieJEeXd9LXOlNC3Ixmg9XlllB2y8QWUkSfgBGwoOTfO3unx/ljr2MCJ?=
 =?us-ascii?Q?ipePpBKEIEvvzsYvdwtRy0u64k2FYizjA2cBEOAATN2fKQL2bJe8i77FKxlw?=
 =?us-ascii?Q?Iod2OfNd/8ubFnLKsxv6VPTd+MyXtfIz3m31casaw5Wrlaxpx8nBRLNNYSGx?=
 =?us-ascii?Q?rg5TQyg/nQ64siX94iT7Zedx0cvDa1TVtbCEsemnl3kv7ZDnqZWz/qgefiI9?=
 =?us-ascii?Q?OV4NsdYCpcdMmJxBbQ6PKjLzQHKBYMOphrUxpIg1/i/+DoQb7CqC2/8/hBEa?=
 =?us-ascii?Q?WaoVduSVLMhdXHFq3eQKZmh80x0mPxLR0YxQTES9SxyhUNtYkvy7gfG2+Ck1?=
 =?us-ascii?Q?x2GUp9TFqJmkfoXEqTSgK35RJnwQGrJOqPU4dT4WJTJQ2nCSZf5rPb68ypuE?=
 =?us-ascii?Q?yJUJpEriyDSzALiANGaHr8wtbjGaWp8m6haWYJnBgn2knMqYLk5lzx1YltlF?=
 =?us-ascii?Q?UAIgvuhnSoOUrYz4ZNscLF1Mylt5tDj9YOgrIncuhjSNlpYa+QxVhdM3Nw2a?=
 =?us-ascii?Q?OVHVT/5HsAu/HhFLE/MY0J2qJp5ekVoc+JwK0yrl5ZeZmJ1onSZdNqjSc7Bq?=
 =?us-ascii?Q?oObIRR1a82CP/lvVcSwD6du0JCbBZXU4Z042fpJu+emYoG8bliQ7W6vK2KeR?=
 =?us-ascii?Q?EPOuGddqwPIUUXHUSn2R7uLYFf8Khg2hSpAu9ZGEsTbHmi0Jo7c0wxNlmhzh?=
 =?us-ascii?Q?dk0X4Ldd7CohsH+0ZF6dp6ASnelGqoFy81UNG6RRlazFNcpeHU/lcQShYz8o?=
 =?us-ascii?Q?imrMsSPIiPwqemIY3M+O9frSSVz/2eywiPjExh9ridNaOxialYfw/7fLvuuX?=
 =?us-ascii?Q?hAxjgJZpuwDEHqQo3Z+s/KJqtRL45nKdqdFX4RUSo14EqL0818sivn0toR7c?=
 =?us-ascii?Q?XYUWK2ozvjnapj0WnHifbB0hD6qgQXvQ5SRRYx6hUhzEA/Vt9K2s3EU35SNS?=
 =?us-ascii?Q?jztscqRidMkFyhOggK+6vmcEXHrz4XfqT+hQ0KSF3ud6VXaq1Bl/renLlFlL?=
 =?us-ascii?Q?OPUeY+bpszFdbyizPdx/enpykcOVooAD2ygqxcTk0iLjjn8uXrW0afGnUHXt?=
 =?us-ascii?Q?0ISOp1CH/20KKH8PQU4XCPpcU8Yx0yPfno3UsYrIH7GOcXMsTgh/NhJiUYlD?=
 =?us-ascii?Q?anRK4z2OdU3u8sUAA5q0Y++UP1Yts7sgQc8pJrFRxCOA6BkTLLso4+PGrGTr?=
 =?us-ascii?Q?usrq6g0MPtQmgwN0VYrJGAqVplsulV8za0CQ/e1jF1q8ZXGs6mAxOTBPZhjs?=
 =?us-ascii?Q?0lYGlRTJ92NtJo6UgQWrQWjHrkU0jmlw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nEjsuMzlv0hghDsB1ZqAqZkQyTYToppqffR6CIGFUBNbdN6Nbq2kYIbNZyC?=
 =?us-ascii?Q?x0dfP5RL0pjCt/QNlAPX4ct0cdbuAPHN7Zm92SwolOMhKsWxlkcepYq7vDM5?=
 =?us-ascii?Q?6AdF6TLkFYQhUjWdqgdY6WgzU+3hj9QHIEC2dIe7IHNpajSYgKXZZidsfCct?=
 =?us-ascii?Q?ZqsTuAVJHYAafsAdK88Ig1OHA/i7Gf/qGQmbl9GtbMP+TmC4sqLiaU6bXe5A?=
 =?us-ascii?Q?DLeW2COURAYXaT3PB2ehP3rYsMe7LBmWjq73Jg7VQliPN8am3YpEZoKHBz8N?=
 =?us-ascii?Q?bR+lDjZXvTzrtG3cGFfOCxbPSbsbyc6X5qEfQbO85qg0NUrf6vUN3q7yIwEB?=
 =?us-ascii?Q?OxBK3eTVqeug6Oq2t39zQ5sSviOQKfT/v8E2SU6x9lJ5jhvDqEcJ1LcSElhw?=
 =?us-ascii?Q?SbqkNqqv1UXTDPuL1veiyTyZqwEBu44yNsMHjHP+qEhKHQCOqLdZkUQhtR/g?=
 =?us-ascii?Q?Li49ZrtStgnRbj/U772P2Du6EwXkO9TLOBaaCVXEwvTC+/4eye9k2RxD5mpG?=
 =?us-ascii?Q?2VbvTdyBZEKgqjTqZ6AsX+Qp5y+nycGYkDRqBk5aX39YNr8H5iRlWgkA3/QR?=
 =?us-ascii?Q?aAFYVhicMTMJU8NcH8E4+W55pDcg1tRRMciHD9TfnsSowS1dnKiN6z90XjZT?=
 =?us-ascii?Q?0Lo3peOiI08wnUpHomnz/0ONxd7IShs+DEmoXa7sMpFcO+6vYjEDZ3NHhBa4?=
 =?us-ascii?Q?d7PN+pyaZ/fLpAbR8jZGdHsp4WNVtezGVQ1mk2OfWSmUJoB+oRjmFg5wNSDF?=
 =?us-ascii?Q?Ghh6yZ11V5DRNMcIaQYEdeq+7R9+1n+lWqJX3mWipNVurgeSHabv/QXW/QhC?=
 =?us-ascii?Q?9GQmdH+INBwhponoCSp66aBZQdRx29i15FtMebotqZTdH/RshS/aC99UvIar?=
 =?us-ascii?Q?5DTF9PAtqvJk8mKUkm56reKfQfTHtxgfK6R+Lzt6MX+aT1PHEfyRFK/rx6ur?=
 =?us-ascii?Q?Cr7vo4xNswJMzSknZE37t7ZNw6YOH3kc8FQwbBlKWmtwECagexOdkJh+EHrY?=
 =?us-ascii?Q?8uGH3ds88DnwbE4iwGxcpw5poI57u0/+/KTJ5PKKu6qroND1I6lq1vzX3/zL?=
 =?us-ascii?Q?rZMO3U2NVHzhqyY8FeuI3s4e/4rsRuEJWSgEp68sEaCMRQ4h28AP6a53qfw+?=
 =?us-ascii?Q?SopuHKpAKOKFeas+EUJzCjuL53KdPnCNWh3WQw6L8gca7oICzxrmdi2dAP/7?=
 =?us-ascii?Q?3PZBZMWXmEULAG5FIFUVL6yQLljzKC1dDqhmUOUB9Ycoj+LlRbkWPqtnE5tA?=
 =?us-ascii?Q?GLJnBjkmrsUyQU7KMdaX6Yqgfr3CCT03+pvvoDh/DcO7CZ7eARdZ+5YexExf?=
 =?us-ascii?Q?4NTu7+ZmaXo/vFTEh2/8xrAXPacRGSvUsQDVx2YcwZWt+uIjvZIJf/zCtfIc?=
 =?us-ascii?Q?iXG6MWCm6RWAmyn+aEMrkYtOB8I2f3tgsATBs22HkTNCi+apbK+NUOJTTBrc?=
 =?us-ascii?Q?4AWzKkOIm6MDpCZM98Pl7yBN/jl+CAVG9W41z/LgZVzYNq/fxcLLWmU+Z8I2?=
 =?us-ascii?Q?pBM9andoadkzREzZAd8NiovJ1vqDwJ1+k5hkdpsW9x4zUQ0LGrTJx/Zx53Wv?=
 =?us-ascii?Q?voR+C56q/HCAL5WULOXTkcfim1iVCd6DTYLjZr1N?=
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: eb237b4e-1204-410a-c26f-08dd49ed0e43
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:07:45.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oQtaXtZccin7XCFKTqr6fe5CBBA+iL6xapIsoafimqwietoPQmVHtHZfCbyO6LmhL2o2/EJz7dBhFgIQmLMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P191MB2495
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:48:17 +0100
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

From: Gabriel Nesteruk <gnesteruk@sii.pl>

U-Boot currently reserves only 0x3000 bytes when copying the FDT
in `copy_fdt()`, which may not be sufficient if additional nodes
(such as FMAN firmware) are added later.

This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
to allow users to define the amount of extra space reserved for FDT
expansion. The default remains 0x3000.

This change prevents potential corruption when resizing FDT after
EFI boot, especially when firmware like FMAN requires additional
space.

Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
---
 lib/efi_loader/Kconfig      | 9 +++++++++
 lib/efi_loader/efi_helper.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d4f6b56afaa..bd2cbe995c9 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
 	  No additional space will be required in the resulting U-Boot binary
 	  when this option is enabled.
 
+config EFI_FDT_EXTRA_SPACE
+    hex "Extra space to allocate for FDT expansion"
+    default 0x3000
+    help
+      Defines additional space (in bytes) reserved for expanding the
+      Flattened Device Tree (FDT) when passed to the EFI system.
+      Increase this value if your firmware (e.g., FMAN) needs to add
+      more data to the device tree after U-Boot relocation.
+
 endif
 
 source "lib/efi/Kconfig"
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 04b2efc4a3b..91b2a5b8653 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
 	 * needs to be expanded later.
 	 */
 	fdt = *fdtp;
-	fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
+	fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI_FDT_EXTRA_SPACE);
 	fdt_size = fdt_pages << EFI_PAGE_SHIFT;
 
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-- 
2.43.0


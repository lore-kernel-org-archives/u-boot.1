Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A6E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF0E84183;
	Tue,  3 Feb 2026 14:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="f75HXpqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED21683FF5; Tue,  3 Feb 2026 08:49:14 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1393A83FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1Oi04t6Ij3w/lM7ce2tOC/BRzJjsylD8tO66SrBlXywEIMxnCYiws2rz5SGsL5Mx+BPtLAUG/E0+iCJa/8KfwMB8lQ22rYPnTzC83VUpT156bpU/LMbgZ/Ez+YZNU0W4m4TCaMwTxNP/KcMoGBnOC4z/LOfarLSdWdIp0YVxQFF3nxkK9bCJYwIHcmBklmOdoJSuNvwrTGXgriuMXur43/vJcYPM1POXdoaAuxKZykQ476BWWRPNwCYtVwtYvjdUvedxK6UNqgdrQkIoGd1ESH6Ze62nIVSADgxx60b8chpzNiLGEMe1Ld1F9NHVQaWHGZHkd6SZA34kOrGc3OQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcg7BQxvbcO1C3ZoEF0rBxT+xV0Ku9WZ5LGiDG9yUI8=;
 b=eNGXexiPIHKXiLbc73qvErn9n8OZUSrjxdUwrmCDMjmjC1czsRqYFpvZucWbElHt925FPa57Opf/asSTthMNJ/JvSdTnLUxWS+ls39LJFk9Ekl/96H+QVPwnzG94ASVoSUy4M7bcv3cmmmUcBXzJWX1kQ+CRAESVDyJya9c3KBMK+ti0qC5gZ5zHeVAuiGbwB4D0cSwsmPWkXDFXnmiqpTqRmtZEu93oi74lY4mm0ffvVPXRdyDwlLcZk3myvqj442tfxFMjBi5A0xQ4c4/iQQ+X7W9DNiEWGVf9TS0gTjzdyJbZ/eZ0HQl1IwwZSXM5qKlJlAw09QgPppTJ7raIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcg7BQxvbcO1C3ZoEF0rBxT+xV0Ku9WZ5LGiDG9yUI8=;
 b=f75HXpqHDtNtTgRMsjPpUpDre9ZNfU9TBzaK1qXVX/TosYnamL7+7NDfwnO7mC+VGPH6B1HHdCsKp+89cAWViIkkuBPbzaIrDDNSJ5Ze1UgeUYI+PjEENuHmVt3y+izz9u1MoCMCVPlYyUMX7SE0eTbgUTxkth4O7PY7iPuL7AEafU1sUH55ndmA3i0zgytehm34Rc+lhqks9L0NMrdHV8RlJLCOr+hgFscBinv3c8eslHVwsl3avqTIemQRxEzY/n4Bz29VicVEvPbdE3IBIDV+y/asnlx/9ZuBgSCbOido1WJPPzMKVW8/JTC6BpcpePsyDbb0IW6kxCdcUhuBEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV4PR03MB8236.namprd03.prod.outlook.com (2603:10b6:408:2e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:49:02 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:49:02 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 5/5] arm: socfpga: enable NAND support for Agilex
Date: Tue,  3 Feb 2026 15:47:21 +0800
Message-ID: <20260203074721.25520-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260203074721.25520-1-dinesh.maniyam@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To MW5PR03MB6929.namprd03.prod.outlook.com
 (2603:10b6:303:1c6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV4PR03MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eefa2bf-a0bb-42c4-0e6b-08de62f8b292
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fJ3fSrnKzuwUYR1vG3hwAwr4WMnya8SDS3x86xv4zzgGVoxFb/3Z2OhwqeUw?=
 =?us-ascii?Q?GeZO8wIow1dzePuzzJGZxUEoumpoxF98etT5dvyqIekR/TLQ2kr5T9hYHu3j?=
 =?us-ascii?Q?lp8rf2bI7QuS4nPj4VKwxi1FBWaWfnd3Us3J4FdGZINp+o56QqTgeBk4JhGR?=
 =?us-ascii?Q?oeHnwrJwYEfix06IHqeZPCVpMimfFouQqsPqCXEvgNIZuUR0RMgIXRoztETe?=
 =?us-ascii?Q?GBdjPSQj3cSOORf/Zt/F3JBm924IYFMCiQw99nYouHACWqvrs2aHKAUJnzmh?=
 =?us-ascii?Q?9vwzVTdQMAS41RxTA2puqQp6cA6b4CbQ/P6lJbNlNsXxxcubj4e8AoCMPwya?=
 =?us-ascii?Q?+MYbjE4DhXBmmBbP4eNfbeuE3fWMEv0DTQxVNJsXZUquEyBDaR8huyqud4vA?=
 =?us-ascii?Q?hvfk7USexq7PFGE6ZUykL7Tdh9QYefchXmQAyLShXu9Gi17QWRNQpXt7ASF9?=
 =?us-ascii?Q?s94Jzd8rTdX8VqU0WiIwqSxRSO2aVzvjlUZWaLVgDgJoZiaz9MFZSroDw/OW?=
 =?us-ascii?Q?gKZ6tPo5ARuTpH+AAtYt9TKR5WQDQNVP8chkY/DTJWpd6jXxonxLPZchd4al?=
 =?us-ascii?Q?Z0p98PCB7/bhVXeg6k7xFvdhHJKvjPC7y6UcShnJMfpfouyb95w+b0/5RzQB?=
 =?us-ascii?Q?0InNfn33V1ufzGElVT60dyQDLHaaUsrgeqE9zx4nKil20/u61GadHrdNaLDN?=
 =?us-ascii?Q?N9f2NAIJ3VN11WSE2rZK94bQjepM9VB6jP+3HPGFH7GjRA+bZGhjRtapt4ly?=
 =?us-ascii?Q?R0aeiL2y1Y5GuY70XNIv86zY8Yj1K8c1DRDZFp8rOBUZLNLlxW2GZAvE2vQr?=
 =?us-ascii?Q?EPPorlLvlZ5FPeZ2aPPiWDuahzMeVhpHPGVZnw9ATOzATsit3jBFFHT9jnzN?=
 =?us-ascii?Q?jVb2K7B4aRjBzQrRfqcYiLlb+r/+qgygwSRMPI5traEEUV58z1FNZMBJ8yf2?=
 =?us-ascii?Q?/NZ3edEdmOWV40IhP7BH+hh0wOQGdR0DiulbhuQaFxEWLSMYa5pykhRcXrVO?=
 =?us-ascii?Q?R7JEHzqSjkySLDX/QJtLw/Dsc5TRZcpX05EKbJe0KPNSakrpsv49HzqUH2uh?=
 =?us-ascii?Q?DrwYgKq228xHcbCjgKGUYcoVx2zjrNeWt4a7yJut9kMuX4maLBNv3zd4Gkm1?=
 =?us-ascii?Q?qlPoq64x4qN3ktmU01xOSMgnyEqP0ATWlQqeTOQkk+ROdQqJlPpKR20fyPBf?=
 =?us-ascii?Q?oQmUX4s3tEPJjTS9R7XMQ7qTppdGcCAwi3xpKNOu4gg3o24TgglhhjNZ65V2?=
 =?us-ascii?Q?knogY7JxfLG64fvq9R0WFTFEsoYidtv+MRV39MxPC2XTdlDOAtSeyvWA5Q0G?=
 =?us-ascii?Q?ZKKVJp7eueTSntU9zEpYIjOZBhkxLNIzwAKPrKG+dyQ/VaPjJp5bBCWMFArD?=
 =?us-ascii?Q?iCnRGAUbG2lpV989GIhN9+EbcaTXeyG+Og42Px33SaHkJTI1uBWbjd3gpK0b?=
 =?us-ascii?Q?9skBkDoqXWlrdUV5XAPfHW5l2Rf+YwUUvkX1IKene0zAWtraeUO1R3l/d9Yc?=
 =?us-ascii?Q?f8thBOH1/cwcF6N6c3e8+gFhNvCe8WKcnoZHlsj5UQR7tnWGF6a5yuO5ODtC?=
 =?us-ascii?Q?40AaGydOrPDATF32A34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hx5e1DoSLgiJGGgCKgwhQ4lcpZUOj6kbZvviF1WpPIlA7+3oxzeoNfbX26vb?=
 =?us-ascii?Q?OC8NW82KQ5zGjztkt4OhxNWzzoBJpMZUvaX5E2TaK0F5+/uH/+pdPGMy3tpa?=
 =?us-ascii?Q?ticM2hCNZmF+wjc7yaLL5StSD3qF+q3y/FgecD3BnPIb3mlz7y4QZLo3JrpS?=
 =?us-ascii?Q?bYhDLctSpp1KVKqS53rlj2jYuUEhjPE1oqh28wAVWXLOed50qgx4RIZcuoYa?=
 =?us-ascii?Q?gsJSYoiH+O7n0nr+QybUmw3S6LeBF6fHITHUO0iw+JNpx2E/rWB5FBmG0Xh1?=
 =?us-ascii?Q?qDGj65bqpPATHltbNL5ixs3NHLKg24A6t8D5pCs18judf+paULvyqySiCUH6?=
 =?us-ascii?Q?veVh8lpGWG342/gti3Fbsf4PI7lKmn3CIUqh/7WiWSgUsJEKrFCaqq4mKCTw?=
 =?us-ascii?Q?ITUtf+pHjNVN+2Z7DVOq4Wd2GdAZI86gzyhHTDb44Ca3ltBqBWmVjLS+lzLY?=
 =?us-ascii?Q?9Ehn6lNyqNw7U3o+A+LO8hKCBQUrfqrwKAAvHnQPv2eQnhUFtG9FzXW4gXNg?=
 =?us-ascii?Q?UZD4YXBle0tPd09PYe9TNnlcSemQrSuiu7FAGqyKFIFTgeJewWLm+rjXEuuA?=
 =?us-ascii?Q?faZ1K1Mc6yuWeOQtGARBNlDs+9ivabsoDjCreMHJa7hRDElybqrwFweXo6wx?=
 =?us-ascii?Q?EPSyTwo9ChwCpbAU7QQhY7ipzYUjlMg2jfonkxSbzM9VVVFcDbIdz2OF/3Ka?=
 =?us-ascii?Q?859XtEl3WFW3dl9ntFqWQUCkSXkzACwZbWW0wMugiv6fB1VXpX4Rt+Ivekaw?=
 =?us-ascii?Q?c5cS49YUkqavNKYmkBojfNJFmqi5IeWrkbv0KDbI5Q5M8UFrwEZ6L/hoHvRK?=
 =?us-ascii?Q?x/xSTD+bY/UBXN1Dd4Ume1DLykrCBgi9QIf7tw/2tff7MTn3toBN5z+zuaCO?=
 =?us-ascii?Q?+iRFlTmREzXRVdlcDUVC9rDSQaO+ZzWbTtn6zOl4kaseJAaVm0Zh5C7xXxMI?=
 =?us-ascii?Q?wsJzI1b+aS4L4oHZRSrgq5xGDczJLAmAhflk918o6DpfERrSgz9hM0j53cdO?=
 =?us-ascii?Q?dcYX04wpwXVHghKJsLdVuNv5Nx1QheXrPU0a9l1xR4T27mJMOS6gsVuaDpDP?=
 =?us-ascii?Q?le18Lm60iuGjjDL81FIiEIYu6meHxpYqAoE4UwpEVrTVoJDTTHTBb5qmp0JU?=
 =?us-ascii?Q?deNvZucL5pOLqiWM5KpX3J3+sT0ov0nXfRgFyNiuwhmxr+jux7RCJOwBhz+q?=
 =?us-ascii?Q?v//D9zgK6XfXXdremjEB9OTIb1+u8NlBVXxZSWAxpvLBpawdqySenjkEKhTH?=
 =?us-ascii?Q?ClkZGtFia5gkD2w+MZvndQP3dMmWGNXLBTHuVK4A4DkVz49JovJP8jZ3SleH?=
 =?us-ascii?Q?dLcq4a5pf4OtEs8p9INjSuYpCNpZCl5v1XlUkfwftKuRRlhIymvC36TZYnKK?=
 =?us-ascii?Q?a26Fe/aaHcYaRmXB822WVwatqrTDUpv6B0aFvX9FiBjkvKi6W41qEd/qra4l?=
 =?us-ascii?Q?Gw1rrwvqpwaAwkmeVI0nVxFDsrwZBAxFUCLOOtljG88riIG9vdZGv5EcviK+?=
 =?us-ascii?Q?hFgXqcv/V4Ql4qUlWCkEL1UEjZXxVP9Nadn3ypHudA6kdA+gxY4kNfb74jO8?=
 =?us-ascii?Q?SmXP0l/WLkZcfF+RVvAMqpzlAfO+94n/Ek1lJp4hnLutn8u/+HCi8RdwPr5F?=
 =?us-ascii?Q?KwprPw2QMtpXlJyRwXAtJVsI0D7c8A7d/8/BbasWM72NdEf7V9ScyaOFEG+w?=
 =?us-ascii?Q?FOqIVu/YKuRMV3Si8tNrwv/6aVQJZ2RXKraoqxE7ihKNOKebyRtLbNSiCMKO?=
 =?us-ascii?Q?Sl8UlxPJj2OgA4JR6mEy33mlJpogS3Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eefa2bf-a0bb-42c4-0e6b-08de62f8b292
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6929.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:49:02.8097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMakN1W6dukzCVj9sOR7Upx1LeoNo0TUXqbsfls/aYHRb6/zHTdO82naUWjYlQyqOShJRLMrHfCA8wM7/FOZ9qjvUEEhUIwJ1ASnmjpW89A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8236
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable NAND support for the SoCFPGA Agilex platform by enabling
Denali NAND, SPL NAND support, and environment storage in NAND.
This allows SPL and U-Boot to boot from NAND using the NAND/MTD
infrastructure.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index eb99392f0ea..81e33b02b93 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -7,6 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x00200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_agilex_socdk"
 CONFIG_DM_RESET=y
@@ -25,6 +26,7 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_NAND_BOOT=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
@@ -39,7 +41,9 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_MTD=y
+CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
@@ -60,6 +64,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_ENV_UBI_PART="root"
@@ -74,6 +79,10 @@ CONFIG_MISC=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_DM_MTD=y
+CONFIG_NAND_DENALI_DT=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
+CONFIG_SPL_NAND_USE_NAND_FRAMEWORK=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
@@ -94,3 +103,5 @@ CONFIG_WDT=y
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_MTDIDS_DEFAULT="nand0=ffb90000.nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=ffb90000.nand.0:2m(u-boot),-(root)"
-- 
2.43.7


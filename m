Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE41CD41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 11:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9444805D7;
	Mon, 15 Dec 2025 12:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L9mJ23dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA92D80050; Mon, 15 Dec 2025 12:02:45 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D806680107
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrnE27XCACMadNWn18ZdfgIcoCh5GYyln+NAPGSmIQaKeDai6iXMf9QsoNSFqYkAHS953p9plfA2LncmSvyvH60Lvg4T07RvheC9NEj8/0/tU/wKcz5OgdJRsLCEVqQeTRgK4sUvcU20xJnWgLu3gD8vEtAhiISbb9zAo3XIEkl/OKArSs5sSEoCbLHbs3frh1RYeGcKCPRaITvRcboBwif4BOuD16dnLjshkIaXLNRg5b3D3AlQohA3YBifhPc9XGvFQxc7aNoquedzV7IJbUo+PdfSflC809E6A7t9SGwgDPULIsHTYCVfEljsrymHGLS/i6/QPNsV+uSWloMkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzHqSoEOEm2PmTU1wQeNLBxvSSCp4vvDta4rACe0eRw=;
 b=XBRAYtGsjX2tAAmnj9EFvGtPP8zeFlpjD9bN7Amsz1O5Vpe7dbaDk9oe5+xSa7Tjjwh5ArvJVU8tCmQT4IUKhRWeI9ezzdm523gussREY8/ffMEuFmVCHTPSdMx2z0BRLmxj9Y0lrE1evWN6ONx8wJDTS3+DmP9WuXKliwTSep1V4ERjgBerGkE0GsFfMv1HdkWBI5Y0W/tmktc7R21TTtz+7uf9RFJY0KmPGY9lfr8EcUlvUBN4eXCPTBj66nyOL7CAtRkUZQD8l0lTcJSNJP4yBKasVMNMenTEqOluAfs/SddhOUrybTvlkJwTPwTAStiM4oQaFZhX2s/zPYRYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzHqSoEOEm2PmTU1wQeNLBxvSSCp4vvDta4rACe0eRw=;
 b=L9mJ23dg+EkSgc6WIRnh4hKTXs8ySWGCipascLeAEC1FuU1hGzMawnxniwcsKjyMUQW/YL3OAtlOio3wCRg4H9TnqtnJ+XdnjhYHAmH95u04UdHXbKcOwAREqxtvC6agAsE+KCcoCvVD+oZQHdPW1EFTfTi637jZ3bylrVl+EbdoD+ee+nCFbA47hMVRnyjkxVyH+eje1u5ReWXoHAqfsXTtMDnGzU5idcOiTDBFqqPx/5Z7mCHz3CFNAl3ASKO4p7N25bN6Y2RuQ6dTpHPgTCCSNYkwmp/2ww9gcFPC+3pv3PrmA4zK4uOec20R+AMED4Kg9/TqZRlZ8j/puWz1mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7658.namprd03.prod.outlook.com (2603:10b6:408:28d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Mon, 15 Dec
 2025 11:02:40 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:02:40 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 1/4] Revert "arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin
 as output"
Date: Mon, 15 Dec 2025 03:01:14 -0800
Message-Id: <20251215110117.19371-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3e861d-63f5-4a1b-b079-08de3bc975e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bcScArof0O1cZgolAilTkyU6ImTHEvRe83M8OWIzXm2gyxTyt8hZUBhErsel?=
 =?us-ascii?Q?jrgYyJeB6JNDkup9jTk9wDNTUOMf4bCkrlrDI0BTJohuLekZxmJdlzycFIxM?=
 =?us-ascii?Q?SivQFYbw8LPUXlWJGRNYRbZqV3trwP6lZX3onNq3jnX2rVekMQ9v5Rx8su+2?=
 =?us-ascii?Q?50w0w0+s1GV28gbWziRc08fuLviaNCw/bb4wA9xr9w4Ox8tFKZYpX8U6oDqY?=
 =?us-ascii?Q?PYaplAx0D9Xs+AEPY/YXtZoWsad89vecrEi/bcBgHcA/Ypqm92oqOkiZE9n+?=
 =?us-ascii?Q?UOcLodluhPxPGptRQ0A8J7C8gcfpA+EosEU/thnAps5SiT5sibeLeTm2LdFn?=
 =?us-ascii?Q?LMt3m+QNHOZeVVbDdG4Bi7mb36z06kuv23Vr67GZFuiqG8jX+IFSmwSUf1RY?=
 =?us-ascii?Q?TFKszSd3Z6GP1zLnMQvutiuNGEO0y2YBai8wDZs1mTZqO3aChtG53/tOgkvx?=
 =?us-ascii?Q?fzdX1xR3u6CN2JnN5Dgzry/D7BJr6ADApSeZZ2tr2pPjvqbr9zrbVg2+1LEN?=
 =?us-ascii?Q?E33ZQLi/9pI0Gu90ZXFlTJktUM+EPQYCV8+0uVrxDWZGYj1dW3sbfBtU9Jgy?=
 =?us-ascii?Q?Y0l4hjsYFrcERzDX4HSg6ukAW29cEQTajrN9CVbAcU+umnBwpT7BwlI+bDDY?=
 =?us-ascii?Q?vknwiyhhfjAYKcP8zbaW3NMYcXHGi/2XT6ClBSZB78HccYiTtJZd31u5zVdb?=
 =?us-ascii?Q?MmOLgofdTWOeVDVFvE8kWRbOIvELZhiRP2UvD7yLIs/4Hz76VCz3AnKj6T/v?=
 =?us-ascii?Q?1b/2O0kzC6HhZgFQz2B7cEoTNKMIEIEV/XbHs2N1NW164YM7ih3FQQXJNlNy?=
 =?us-ascii?Q?w3LcnYgDzjgcNCF8zSp44Ad5koZeJ6WVVA7KzjhOu2jmXI+S2aFLfcsTyXnQ?=
 =?us-ascii?Q?Xjyg4wJ6QKtDlqgD1Chj+/xWYFQzt+ByDuwY+9ibeMcjM67+PNTFXlAA25Y0?=
 =?us-ascii?Q?EXz6RZuKUhHEP3qbrUn+pxJbj2hkjTP3XXq4WaNp+IO1MrWI2eN8Qcd7WaMG?=
 =?us-ascii?Q?v2n6jZwWKoPMJPuTBkBq976X9s6hZnfjIbsr69C7Ipowp4FTJt/T9GTc/wp8?=
 =?us-ascii?Q?hMvodo1puJW/7r+hx9kpse/2I/4YjO+o75K5wwiX/JqJ87tJ3trxWDt3KruP?=
 =?us-ascii?Q?JEagcD6bb5eiNPbaraSRzvc8kqGcnOBrluqftLbhshk7LmVRUGXQOewzpeGL?=
 =?us-ascii?Q?KLpWxKdpMgh9bKrjmrmjhTduGf/ux5fjA19iX5y5XydYMkMQE9QsioX51bXs?=
 =?us-ascii?Q?/Z5US0qd7PGwvDUY1BWlzTP8n6Rj59aV1dWhnbM4C2wQvb7qYqv7GX06Zsb2?=
 =?us-ascii?Q?mkNrmfO0dQuQ1Yk3aYL9o+7QpCl+OFUuEjf9BSs83GxFvxGmYMlvq+n18LVx?=
 =?us-ascii?Q?eZu0pZwVFRT+HhHMJ14vCY78MjdY4ncuzCqle36LmoRzxBPj0iG8rVSbqzzw?=
 =?us-ascii?Q?M/YyfT7pCYxu57fRCWCjxdlIH+FwmtQy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBOwIGrEE1Iyb4czPy7s39gISzC1PPiuaXDQk6ltJHwcYeOHoBjrVzah3kc+?=
 =?us-ascii?Q?l02jdKLyxplUfYF6POOL2WWcm9RogbnUpZeQrQp4IGv+DIL2+tIFz7EWaAeH?=
 =?us-ascii?Q?OP2gHlHbDv2iDm84pGuvAM/Qg/lG2XSlTfJ8dbyR9BtzWm4AFIF0V143iMd+?=
 =?us-ascii?Q?XDgFr3P+PMabSdpfgQdBdUhV5xukU2eLOkIH8mmEgLNrLqHaXsPGw05HLnyk?=
 =?us-ascii?Q?W/ayiL2Yek5nagWLFIr3XuvMl0xJaehgtoNKyKQUKt1bmAhQmdZaWKKhgF9N?=
 =?us-ascii?Q?GP2/rzhci3HhZLhSeXs8mJBHV/oowMpgnuHB1eWMkaZ23yEFoYuTjkz9HMO1?=
 =?us-ascii?Q?pKgqJqJ6+8fCCiYnsVDnBOA+GOItbMJttqJhiU6ZxBUmNArqgtE4uB8GPIzo?=
 =?us-ascii?Q?QkXSmqWBMQr9hvPKy+6vzfRj4KM3VaaQK46oiVnmFVShztW9nGOuUziPXXjF?=
 =?us-ascii?Q?YztE1KsF7vDMGBm9B+hrTLq+//+SDzItXL/5nylZ13VR4+n0TXq/5MBh33N8?=
 =?us-ascii?Q?b17hf+/NtWQel2AZnmfXyqiPNGRVwmh6j5R41UHxzTyGMURnfO2UJ1oP0RFb?=
 =?us-ascii?Q?x+1Pj/f3bVGs5vpseiqAckGavmNvQXAFJGhR7AC3kdfGhb8f3MVNQk4SIfEg?=
 =?us-ascii?Q?1MTSIDg2Ik9cRpU3SvIZ/Dwd3nlyejyrocn9eGWjKoQVLqpKz454RVZ+N1h2?=
 =?us-ascii?Q?VEzqdr03Fkc8bP1kDENqmLOCvR4pn13I3YSlEVSetTUqOlO8NXFoSoDl6o63?=
 =?us-ascii?Q?LiZ9dZMTGFAwm4zwlawbwHc+1Ew23XJoxEuhSmvgHO8m/xWWcZcasUL3ewOZ?=
 =?us-ascii?Q?bbC6BxU0mebgPVwkIvdqHhawqi/CQoAWRA4PbxpspmJU0GUA7klc5lW2WyJs?=
 =?us-ascii?Q?5dCwOPX6pv1kpsMGVcdwpY3iuVyqR4t91cr7jVfdFbRNUsNAF3hnGYbBJ+Eo?=
 =?us-ascii?Q?0tk7C9tWmVZ0GH6K+JVewuUyCZ7k1YzHFFyPh+F4J6T7SDScV2GhGmrKYwWL?=
 =?us-ascii?Q?O7hi1/g+7zSNydT/wkPqO91Bbp44hB/EV4aBT+4ja1+zphMIyTQ1uiQlXQ60?=
 =?us-ascii?Q?AQwxlA+N8ZIH1WQMGCayJjTqIVOsFrjblDGh9ggvnn/hiESsQ94xfDMEV0DK?=
 =?us-ascii?Q?BItVXSArUZLJflCYOAv0bIAzAC62s6EwNsNn2uOjr7El07aP4EEkDUsUHxtX?=
 =?us-ascii?Q?0hl0UMnzA66s4tmFwM0Iiygoo/iJs2K7bAyY9PEIrJ8ZorNBJDQOtoG8pReh?=
 =?us-ascii?Q?YDVKxoyvaFm7qAq2lDaQRSjwqjjtkrir/zSIhht2lzYnUsZx760EkdcG/Rlu?=
 =?us-ascii?Q?lKfDjvSBbjMv0OcxDS09rrzwEToibkMoav/8KIzoqAVANhKbQg+xAQhn+lDQ?=
 =?us-ascii?Q?dGXlpTutBSCGVdLt8flVhBsdjXr48pm5UyniFKTrMF7SwySC0La+6q2SJBUE?=
 =?us-ascii?Q?Tw4h9ZDYkDHcI7RTbeAFAULisvV9k7hkdYPkF+y76sPu1mQlODZK/R6Tw+7U?=
 =?us-ascii?Q?//ts89HGeFSwYhwHE3riN5/5jyq/VKzt9z6WgEeLM2KFuXBnH1LSppT2iu40?=
 =?us-ascii?Q?kpLOObsUnR5xT1e7xdPfQscW1Z0MQWoHSioLMkW3J64b/MN0MLf5tD7NsdDU?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3e861d-63f5-4a1b-b079-08de3bc975e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:02:39.9499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFN/Ba/UOX15MOaGjiHQQxvs7hJjH55U7G46bhMLNo7aj4N5Dt+iNCm8PAlz+85fPEdz02wKy82iWQKbm0OLazbGeCKHJR9tkQ82Phrs4Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7658
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

Remove GPIO hog configuration for SDIO_SEL pin as it is now handled
through the voltage regulator framework for SD ultra high speed mode
support. The GPIO pin 3 on portb controller is used to control the
level shifter for SD card I/O voltage switching.

The regulator-based approach provides proper voltage switching control
for UHS-I modes (SDR50, SDR104) while maintaining compatibility with
the MMC subsystem's voltage switching protocols.

This reverts commit b0dbc9fcb7dfb7522be25ee205997be2fb5e1bdc.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 11 -----------
 configs/socfpga_agilex5_defconfig        |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index d51a9e2ff7f..35b198b79ef 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -681,17 +681,6 @@
 	bootph-all;
 };
 
-&gpio1 {
-	/* Configure GPIO 1 pin 3 as output pin with value 0 during GPIO probe */
-	portb: gpio-controller@0{
-		sdio_sel {
-			gpio-hog;
-			gpios = <3 GPIO_ACTIVE_HIGH>;
-			output-low;
-		};
-	};
-};
-
 &i2c0 {
 	reset-names = "i2c";
 };
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 64f2f1bf115..799ea910f03 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x80200000
-CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
@@ -79,8 +78,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
-CONFIG_GPIO_HOG=y
-CONFIG_SPL_GPIO_HOG=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-- 
2.43.7


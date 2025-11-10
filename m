Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C41CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6FD83AE9;
	Mon, 10 Nov 2025 21:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hG9TX/g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD90283C32; Mon, 10 Nov 2025 21:54:20 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C58683AE7
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrpOKX3ZUP5oCojcw3z0Sm6LaybUDR/IdAjkTeouPqPQUP0SyRa6BvxMK1b6UaJaFzZ+ccZw0IrI8cLXd5B7pA2rNAdIaTmq/1SMj2u2yrXHwqajOL3mNQ8bAxGItlqMC6Hqr0FR7ws4P4yO1z+M354dD+HAy3ogeLezyT1uM+UfUX15Ft0qD8yaDVhgKP5GCeeZacUe9XJ+OTnRSJb6POUXblyBgvsKjqxFsgh+C6+monw62Flt1tt5PIPOoUon7e7O4VSsDh/mr7n2MIcvZE/tSgMsJur98iVIS8jCrZLD/y1w1gx7aM7vpqXHttMipkiFrklu/WVo2XWgmqj5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmkfn3YIamgyoxDbnj8ptvDSGrjGyOr6AxP5YfOWezs=;
 b=KD2pyxg3g5QQmDJAPC7npOC3HuBX73JvJNsPcLfjfFaVuF6Aav4FUfVRA5qFFGtnRrBZZl9SdJL3IKgf2bEgzsN9yNh31CqNoKtNG74QUDKmvezSk6CkHQq7wW9hHaXhDsxhDWsTv1CGqFZlYuGDu0OP/6U0n5TkW/ObJIAtI/nw6vdZMKwidHhtOdzehR4J5F/2Lbm8TljN+6X253sn8gOUgLqU7Ke5bfS4+Z0i5dXTAp3cK3cz8gWIbNIdO9c3ivtL6MPgQSYzPkGPxXz4YjlfAzXQSvNsrYLjvnEI2N1uhPlRRVkahQTIBX6+/GcaE0WBJCiZmI1OePBCa8NAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmkfn3YIamgyoxDbnj8ptvDSGrjGyOr6AxP5YfOWezs=;
 b=hG9TX/g/YYzkE8hLJUyD1c2ucSRAQVw/mKql+aFcvDHKZqnNdi18zDlwd4O3AsXaSUSO6676oqlf6HCau0U526OSomvADJcEfP553z0Ktl8Ovgul+6Z/kEnrxknet+KqpOhWyqVsjpAhsvA+B3LHjEgVCundjn9q6ogld0c/7k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:54:16 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Mon, 10 Nov 2025
 20:54:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 2/2] cmd/part.c: implement "part name" subcommand
Date: Mon, 10 Nov 2025 21:54:11 +0100
Message-ID: <20251110205411.4075351-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110205411.4075351-1-ravi@prevas.dk>
References: <20251110205411.4075351-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: ae46bac0-4bd2-4dc5-0418-08de209b4f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UpNL+qdoRDe/XgHv6JqEvpAT7LZU6JBtMeypFUdNpIA6IcwTejtp9nXLOkMH?=
 =?us-ascii?Q?WcIm76TrtEbtV3Ra3lH84q6FfoAEA9Ecw7dRMTAdIXEWc3iFY44D2o5dfYdS?=
 =?us-ascii?Q?7Asv/AIcG9Bw14IpnxDs8jZMSKzPpD1mELDrXK61D7J2y+46oWD5bdsCuVCT?=
 =?us-ascii?Q?+ubdw+vLj1HSHZCbFDJkMZyF1h1y55JYrKtOzVrxuwkghl5UX09LYXb8pISJ?=
 =?us-ascii?Q?AcM7/m3Mpx5wDz38wfXVXWCUMzH87ixUXbV0+Qtrn+riau+4F8+GXl/xH9pB?=
 =?us-ascii?Q?BxiHcrsYcECBdZpb5HnKK3YDNs1nwT6M4Y0R41unK5lZYr5Y278bdqdTALNY?=
 =?us-ascii?Q?ezDaDwXtP4xFFhtVTHuS12nAMe/HrwkN+XVvug291x0KtxfBLTdpac74Dxv/?=
 =?us-ascii?Q?IKkQr2dg9suFGP/k9F9vBEtB62kIdWSFyKrx5nvlS/a+YIJXOxgmvJHVAJ/i?=
 =?us-ascii?Q?qly7j5WuwIZ40H5WNDRrMF7ExlUYAdJgPwTVWBIPabdxMKwm8OhB+TBFhsbA?=
 =?us-ascii?Q?hAbLVoFt935QhUA9C1qr5OngUuBX/DKMD58+kh0N97vAmvyxtbQnUrGpW4z+?=
 =?us-ascii?Q?tUnsxtxUSMOZknuIDIHqbSgzn6sb6kpZMMYD13HwUfXX23+G8lZ82AelXg+T?=
 =?us-ascii?Q?CmfXRFr3Wlc3IpuQ6lMnjpj8f6HUQfBsQlpjubyIF6IX+R1m9b1L4Qkjp+DS?=
 =?us-ascii?Q?nXvE/9R+b6rkrnqfp1WCf2f3nyn+/wm92JX9lo5UjyHKum8XZjAvk4z7mZ1Z?=
 =?us-ascii?Q?/XCYw85Qfb/eFx6YlzV2EeNuAzsn1Hu9BSEovzR98qGlh6mnZ8JZpAO7DGtE?=
 =?us-ascii?Q?sq9Gn7c/ACgElDMlC4J1z2uKK1On5073Q1P3HcvKCVF6x6IsXwXV++OwZIqj?=
 =?us-ascii?Q?nIRHWXtD6zMLA85Ojr09Kl7SMipDZXl0BNdhhO5HMasvffDiTu5nMt+Cl6Kw?=
 =?us-ascii?Q?R9fMoR8vtEYc05LaMhc1ScIsVgC0tKL+jSra44Vonu8/lzdQeFtWG/ekRifM?=
 =?us-ascii?Q?g1XS2FdMzvcQAC+phjSFti+n5IvYs6C6NJTuv0lmHVJLbu1qBhtKvJSVPkvo?=
 =?us-ascii?Q?NdGDzouQvPvnosaHIXYBsL8z2M1Trd2dG+Qz8AJ7uJzARBkvboV/PgTaHd76?=
 =?us-ascii?Q?vkuRxYrtlk0+dwN0fP/A56sgCZE19+MO6YS7fJeuEW5dJbvSJMQJLncoypJj?=
 =?us-ascii?Q?DTBdOo8jXV2ix8ZeW5jecapJSADHilzrIS1FqylzZWDVw2E3mFeEaE+sy1dc?=
 =?us-ascii?Q?B92IAFTUR5CASL39oO7yG6H4xr1f9bA88uMyp7ViFaIBDb0YSRlPTBW2MY/a?=
 =?us-ascii?Q?mghvXnuCcPxkLWxo2DqofvLNF0/ot1xq4hlWGpbMa0xwNwO42Kaq/rMBAKoG?=
 =?us-ascii?Q?5cFMBxTcmwWwuCf7JHgO9Km1wA2nuInzBQAdNJ42doKxxeqr9zkW7qyazUdt?=
 =?us-ascii?Q?cEZp4rRV1aRArE2NOKpzYxM+7cJEmGUmMbDn0KjNTnegztPPKmo6s1k3Vp71?=
 =?us-ascii?Q?90GJry4uXhzEKY1yhdnZD51qIqQB/knrshuO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3zPsR0EAmNCrrZrciiMv7TPeAtBZ3OW4f/kCZ+qmeLcoOoGEf7p1Q2h3sXY?=
 =?us-ascii?Q?niVxxUsbOUrtr7SuQXsWSaypfwLekRjs9+DPcyIpBSaXKftsjIhVgYNXfsiW?=
 =?us-ascii?Q?490wmBhcHiJfLwSSddbfsRmFxrG3oTg4wqUF0PptZ8LInlabp9cFqAlIhotm?=
 =?us-ascii?Q?WApZDqUuoyXUFAWTQ5F1Qvqu7ouPdjC4J39ROrBvlKc41CT4lSvH2EqA17Gs?=
 =?us-ascii?Q?SQgh1ZCN2Be3A+MMflJphxEpkS20uXZeDUe8sBma3oYxWUNJYgkox52AJQuM?=
 =?us-ascii?Q?0eFVsPBp+vK3BnGaSDYqQWlvvRVet8jRS2t6wyqNvgVu9MX6alPnOoRakd0g?=
 =?us-ascii?Q?fFCSBhP+Tloit7hQoc+3RXekjKN2MNG3tAKV/0sIzWQmnb9xtCZPdhBQdWxr?=
 =?us-ascii?Q?959eSyZSi34vYxJa53FSVapD72+kTyNIcVFfLObBvQGFE8WpEA3PaoUr/RRR?=
 =?us-ascii?Q?Kd4khW8hEJXZSDPCZTsJsdtTi4nadXsXuQwYfgKAK3LCLuRtdoJPtuyG1UKA?=
 =?us-ascii?Q?Q0+m4qo+5ZD5KT4qJGjRtklVy1iSa9QWRBFRcz+z5gev+gaPRSN3SXIribSq?=
 =?us-ascii?Q?j52pl42GzssIx6mWHBnwaBmsBVkQg1S6QrKm6eIQ85U9Bhvs4EZVCR88iZeY?=
 =?us-ascii?Q?7M7ijJWLcELGEvn1TlKgqTHyh4edrlxRjXJodsDje1UEen836aHa8ikcVBOn?=
 =?us-ascii?Q?b05stbZD8bp7gHlCiDiupBo55K09+mmu4tmgrovnmmF9GFMBy15ybirwmFd+?=
 =?us-ascii?Q?LCBiW60eZBlx62dKzpn2ehQCPKmyYBgPY3X3uYZgVYo/hEAlQPPkjde7Okhj?=
 =?us-ascii?Q?2AXDd6oMd+sNXc0Iptv9IVBqE0mdPePtvoRTF2FEph6SvSxk7L1XGY5crsMo?=
 =?us-ascii?Q?p9LnwfNKi59R3rxPSk0DulzlMwEcgXK3JzOPWIYUU//2rSMyugKL9duJyrth?=
 =?us-ascii?Q?aiRoS67Uq+Twu8s0sBYG4N/GzkYfhalQmS+zYi97lSWijXLQ9FL4v7WGClV3?=
 =?us-ascii?Q?8TFI0TDP2zURN9T1/XQfJyd/rWLt/aspo4jJBifhvzLEMIEyKBVK+plvp+Pr?=
 =?us-ascii?Q?LrB3PGb6F9Nl/SVjawaRwg4lUlWYyW2gjO1g9rtgvHBnGJR+/CYD/qXZgynW?=
 =?us-ascii?Q?WMe2rTo/V0vlHblmnyJ/PLNq8Gfb9y4Q3oSaLdtUluJqHLJFwLl1CtVlNDNZ?=
 =?us-ascii?Q?LisEyP1xvSsxMqQOMWKhfNHvNKp921ADfSUZj0MeF3Yikc4uQ+x2cqmrh/2s?=
 =?us-ascii?Q?MWgSFfG77bg6f3kxcsLw8Xo6WK3KZEEu3ag/kILQT0blqM5tTasPyOd2S8FU?=
 =?us-ascii?Q?v7beSneLAdkLv49n8eAqH97M/nVG7rrE1SrxZeaeYSncx0qj1un5EUjo7T6r?=
 =?us-ascii?Q?aNVTyF3+Qgpb+qcUQi/Mndfk9YaKukSNgbdB3fZdmtBne9Hdfto9INBYuURM?=
 =?us-ascii?Q?gqEVwIjfsUAVEZYuW6YgYY8OEb7wJKq4XrfN64QhHyOgL4Qq/odbdjfDvQRs?=
 =?us-ascii?Q?j/om1DXVVx9DOJhA91ximuzDBXfBbp4xDx1jJlmgbqwR/erouLtLlBvUjQ1j?=
 =?us-ascii?Q?tjSmJxMeSwdn/NYSN99ezmLu9WIZO3BG77cGmIAh//b0ucshYmmw7qYa/N2h?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ae46bac0-4bd2-4dc5-0418-08de209b4f74
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:54:15.9872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7j1Fa34T3GZlaM2cnUrpQd6c4Iq9MZVhLGfC4Y96CoOs+xC7eZag2y53i/aFpXNGv6xg7b/UEepnuLH8Sow6Oo/Fu0ldrQtE5sF0Y2WrNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5720
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

This is a natural buddy to the existing "part number", allowing one to
get the partition name for a given partition number.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/part.c             | 16 +++++++++++++++-
 doc/usage/cmd/part.rst | 13 +++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/cmd/part.c b/cmd/part.c
index db7bc5819c0..975a0a08a99 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -25,7 +25,8 @@
 enum cmd_part_info {
 	CMD_PART_INFO_START = 0,
 	CMD_PART_INFO_SIZE,
-	CMD_PART_INFO_NUMBER
+	CMD_PART_INFO_NUMBER,
+	CMD_PART_INFO_NAME,
 };
 
 static int do_part_uuid(int argc, char *const argv[])
@@ -154,6 +155,9 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
 	case CMD_PART_INFO_NUMBER:
 		snprintf(buf, sizeof(buf), "0x%x", part);
 		break;
+	case CMD_PART_INFO_NAME:
+		snprintf(buf, sizeof(buf), "%s", info.name);
+		break;
 	default:
 		printf("** Unknown cmd_part_info value: %d\n", param);
 		return 1;
@@ -182,6 +186,11 @@ static int do_part_number(int argc, char *const argv[])
 	return do_part_info(argc, argv, CMD_PART_INFO_NUMBER);
 }
 
+static int do_part_name(int argc, char *const argv[])
+{
+	return do_part_info(argc, argv, CMD_PART_INFO_NAME);
+}
+
 static int do_part_set(int argc, char *const argv[])
 {
 	const char *devname, *partstr, *typestr;
@@ -273,6 +282,8 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
 		return do_part_size(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "number"))
 		return do_part_number(argc - 2, argv + 2);
+	else if (!strcmp(argv[1], "name"))
+		return do_part_name(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "types"))
 		return do_part_types(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "set"))
@@ -305,6 +316,9 @@ U_BOOT_CMD(
 	"part number <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the partition number using the partition name\n"
 	"      part must be specified as partition name\n"
+	"part name <interface> <dev> <part> <varname>\n"
+	"    - set environment variable to the partition name using the partition number\n"
+	"      part must be specified as partition number\n"
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	"part type <interface> <dev>:<part>\n"
 	"    - print partition type\n"
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index 72f5d8b8de7..299f2ac15c5 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -16,6 +16,7 @@ Synopsis
     part start <interface> <dev> <part> <varname>
     part size <interface> <dev> <part> <varname>
     part number <interface> <dev> <part> <varname>
+    part name <interface> <dev> <part> <varname>
     part set <interface> <dev> <part> <type>
     part type <interface> <dev>:<part> [varname]
     part types
@@ -86,6 +87,18 @@ part must be specified as partition name.
     varname
         a variable to store the current partition number value into
 
+The 'part name' command sets an environment variable to the partition name using the partition number,
+part must be specified as partition number.
+
+    interface
+        interface for accessing the block device (mmc, sata, scsi, usb, ....)
+    dev
+        device number
+    part
+        partition number
+    varname
+        a variable to store the current partition name into
+
 The 'part set' command sets the type of a partition. This is useful when
 autodetection fails or does not do the correct thing:
 
-- 
2.51.0


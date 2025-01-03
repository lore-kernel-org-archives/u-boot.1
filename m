Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275ADE77198
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28CF680107;
	Fri,  3 Jan 2025 07:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vr8y0AQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A2E800D7; Fri,  3 Jan 2025 07:46:20 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAD580435
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLhDLsc+k+XwDM7sD8c1yB5LeLyl3SV5I9B/z8gdniiBgI+vV8hoo/igwN97ne7nWYWSV67JRgfyMh6wZPDiCMzUYT7/kubF7DdRGgn05LdXHhzFflt10KY7Xv/DvRXbjIIst/4UVxuJ5UsTOKklZ5tEbOfl/t6ZwnhYQdjMsr3iAczidc+/6Zgyg1X2iqn49++E7XecwHEtQu1D87s981OTgFB6gUSKqRJxfEUtgzS+fchWz5r8cmdKjNHoVdAv6Zrsed3HSLlpzoQgQ/RNMmioFji8MQas4bW2u92XKguTWBZLP95glOag9MCh7QjK+rh80sQMeso7kpZjyBWrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=jAaHq4PNg/xRq2qVZCK4dskFeP0Q1Qaw/FsIrSXmCDfsuMJtgQwawyc/vfgmHkT+SXNmKuzO+GSi7mJ1cRAoDoXv2P3YBL5VyIcRRbsUshpABYPwTQ7Kg7VOYqtiEotrXyzxwhRf3RZF4HDHj7MXn8xdbhWRBOYYk/DMNEk8cixbnPUTGTFJeyx71koc/zDeKIrmGVd+I7Gxg2ami0xLGI0EzJa2OZgJ7ul2JXRg3lJc0mSP+7/9BNgqyOUKZh0w0wum1GRt85DSPDWcvVOqHshlhgmlqyu9WMdzMxVGL+D3x8M2gZGMFh8RSZJPV8lo4i0eBIPLqq9Mgkc2LK3yJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=Vr8y0AQYjAsD4sSysTm5JYLolw3i6aGICFd9j//X+7eZ7gSUqCw24QZdS5dU19okFqAFXrf9yC3APv/zzhAVQfv/J+4WopjiU58FED44TqQkuiEELSVTmtZs78h0OFlDaJONOpVPHd+xipf+SOPP+ZMcE4T7djgHl5FMapc4pgcyF3Ll+i2a/H1xgZ1NM3akgV7wrHFhZbq2rAJypU0wdlDcqkA5CV/xbKIa2zS3AvGfagCbNkoI4l1fOqls3nB5Iu3hXjwDUVnFFWlQN0D9kCe0TuT9hoblvIFJdomRn+18Fmwo0S2qRndN1ppPw7hsF9Uxh6EWBy7j3yWlH8Fjgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:13 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:41 +0800
Subject: [PATCH v3 06/17] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-6-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=2503;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=l71ScTKWtHtOdfZx9OnBCuYLXxuAQFWJgqyLe8SCfWo=;
 b=8h2CIVq4mOMfYdPTLLLnms+nNjKJSTuJs9K2ahQ3F5fX0TH5fdquszgKvMfstxKpX9wGURZCX
 cADc0RubCkKBrEIyfX2JIwxex0mBwPGTjaqoCD1SUmybIMGS1M0B+iu
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fba42f7-4a33-47ac-a2ff-08dd2bc25091
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEtGQ2RDbGZLTFJWRk11c3MyOUFoTzI4VHJDTlpWV2V6VnR6OEJkMm1TV0JW?=
 =?utf-8?B?WUhJVkpYM1ZmUVRpQTgxRHBiTndUamJ3NHlzckxpU3NHMDFkQzdwL3VFYnAv?=
 =?utf-8?B?Y0ZsVDRvYVlHWUlMN3JHc2tJWW9BbDBsNWtMbUhsNHRqcUdaY0pWbVF4Yjgy?=
 =?utf-8?B?VWJGWStleGJWcUVBODJjSGNWblpDaWVvU3BNQlN0VEJBZzNQRFdqby8wQTRH?=
 =?utf-8?B?Y1ZEU3doTHgyWncybHZHRTFXek5Gb05adDQ0UGV4NzlhdVRuT0c0U0VyMlpz?=
 =?utf-8?B?Ym5teXBLdmYvcytDSTNZbk5xRTRDT29XNlk4S3R3Zk1qc2dhRUZ1YUZ0bDFR?=
 =?utf-8?B?MGp4MHIvY1ZCbS9rMmg1bkF6NXdVZEdBMGhmRVA4WC9rRk9xTnBDMHY3SEVr?=
 =?utf-8?B?WTlRUU9HM1ltOVBrNE95VU5ySE5FcDUvMUVGTzNTV2dKQ2hSaVZTRC9ZNlhW?=
 =?utf-8?B?U1VncVlvSzRkYXNuSkJRNWg3NzBlYURESUUxeVIvYlJzYy9oSzExSXoxcFRR?=
 =?utf-8?B?OWNEY2c3YnJVU2MwV2RtQVluUUZQOXFtd2ZGeThncjJhYjhBQk9odnJxNTRB?=
 =?utf-8?B?U25MMDVtTWV6MGFKak1wVUVWWnk0V1BseWVBUVptTWFuZFlKbS9EODhUcDRN?=
 =?utf-8?B?UDhiYXpHSmhxVTRUVVJuRFlRZW94Sit5SS9Jc2VCVmR4b2Z2VmsxTGtHTUxG?=
 =?utf-8?B?Slh6Y1ZWWjJVVFU1WThsYUVFNzAwQVJLUkVOZWNISXVXZDBXQ2VPQ3JSMnhC?=
 =?utf-8?B?ZFFPaDc0SG5mbEVVZXZTWjBQQUNuQTJNMEFOTExzck1mTmZXL3NTYXhzRXkv?=
 =?utf-8?B?K0NaQkhSRmJKMGg2b0QvMTZ4VmM1eXlWNldxZS8xL2RrZzVOenlXeENUMzZ1?=
 =?utf-8?B?SVJWSTZEUENETFpYdzRjMEV2OHpWWmI4VEtQNlNEUHFqbmZPb1RhaDRFSlVS?=
 =?utf-8?B?Zm92WFdnUi9WeVE5eDhobGhCcVhUbXBxbG5Ubzh2MiswSFpGbjJMN2tPcGJj?=
 =?utf-8?B?aVZLMXJVUTJkVmxIUTRwRkVXU0t5WFhjUDJtRDN5QnZOVG1ReHJZa2Y5MnZn?=
 =?utf-8?B?YjVlTElKVnNxT1VCSWhqNWhtWEtWZzFQcmRHMnRrUTVQWDRNY0ZsNkZRMU8x?=
 =?utf-8?B?VW1TdmtDSzJCa1FyMUhpTlhaUklLWVMwUGpTaW51emlnTEg3SG5UR3FaNWxt?=
 =?utf-8?B?eUV3SnRlV08wV2VZMm5XUmp6R1ovWTAvUk1YQnBkYXdOS1F5eHpmalBNSS92?=
 =?utf-8?B?bHFkZWREVnM0Q251OXI3SGNHZ1ZyMklXWFNZc1cwR1Y5aVlQbWFzUzVkNVdy?=
 =?utf-8?B?UkVHT3NpSlZDUm5SMk5KMHJJVUppQ2F4S3RscW1kYU1sQnhiQTNDemxZb29H?=
 =?utf-8?B?NWErTEliaTFncW9xM2swVVZlRHlSY3dYRCtSMG83NU9NV0NCSXh3VzRkMmNX?=
 =?utf-8?B?a2hhRXVQYXJQbDBZOUdWMTUzdGdwQ2w2MzgyWHVESTk2UW1sMVo3VmtzSHNy?=
 =?utf-8?B?QWRmaTl5TVo2UWNudzRVTmxWUkpyMGp5TVNJbkNBV0YveFhSMHJKd291M2th?=
 =?utf-8?B?bFdLbDdndUowV0RNbFlMTkRjSEV6WTUzY1pWOElRUTFIejI1b3JmbjlRY3ZY?=
 =?utf-8?B?NUJlNlEwbmExOGM3ZWdXbWd4WTFybUJMTzcvVTdXeUF1clpOM2lUb2QzeGg3?=
 =?utf-8?B?blBMRnhpU08zeXRMT2ZiSXJ5UGpsL2pEeW9RVC9SVzNieXlVRGRVenFKbTc1?=
 =?utf-8?B?S01CWW5VRzIxRVJKcTFPSjZBU05aSmJjL3EwQ0tIUGVVRXpsdE1oNlVobDJv?=
 =?utf-8?B?cm1vU29RSWd3YW84eTlIOVlOYitNWXg2MGNsL0QrbjhhOEdoMXMzMGk4T3pt?=
 =?utf-8?B?a01CYzdaUDc0NHVNdnlaZWd1YzFlSmUyaGRjUjBNdnVWaDJ4ZzRKSFExbVc2?=
 =?utf-8?Q?4U26VR6Q49HmpGwy3JdNXzKEPI1j8HHL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjN1VWlEY2I0SFJWaS9ROXVSb1hjbkpMWXgySmY5OWxzVDlwTDB4MDAxNzFz?=
 =?utf-8?B?TVEwcVJYWmwvOWlVWWkwdzZ1ZnhwYThPWkJKbEtmbUhrVDEzUHhXRjVzZlBt?=
 =?utf-8?B?dUNpaytuS3A1T1A4UDlYSW52b1cwUktrQ1ZHQUkxbFl3elN0NHZiNktMYlU4?=
 =?utf-8?B?ZFpDWm4ycjAzUkJEMHkxUU5zQ1lDUSt2S3V2cjVITjF4VDVZWHVCZzNzcjIx?=
 =?utf-8?B?SFh2NCtVVWY3K1d1NlFsNEMzSGVhM3ZjTHRTbkowVnZVbmVJaHJJWnY5b1VC?=
 =?utf-8?B?MnpLaFRBeXhmUCs3QzdZSzdoY1N5YVdyN0pmYXNMYTY0MS95anFKeGtjVEJN?=
 =?utf-8?B?VjlmTEF1TFJrdi9IWWR6N2taRFNBc2grVm5mS2JGbjVKazIyTFJTR3EyVk5Y?=
 =?utf-8?B?eDRVMjY0eGV4SFRGSElLekRFYWNmbWZhem0rSHZxTjg2cmdTelUvWmswUHlP?=
 =?utf-8?B?NE12aVozQzMxeGNIQzlIUnp2SUFwbGl2ZlFSZVcwQVEyYkVmN084SkorMk1E?=
 =?utf-8?B?b3hXYTNoWHNYbjlRR1FkYTRpR1JWYzg3eVpRb2dCblMreHJDUUlYNURqRmZm?=
 =?utf-8?B?MVY3aE9zWlhuU09BdG1pTGNoWGpLbFJqSkRTVklnYyt4bFZ6SGNCQ2N3aGNk?=
 =?utf-8?B?aExNSW5meStwZ3VUYXkxVXZPRW5xTVNJTUVCWXZWc2E1eHlCSEk4S0Vvbk1i?=
 =?utf-8?B?OXp6YmNreW5TTTdlbTRtbXhjdE5hbm12UHprRHdWc0FIeFNSeCtGVHVBV09W?=
 =?utf-8?B?MkpuWHBaMEFodTE2cUY1ak5XWVBWaUJsZ3l1OGl5cGN0WjhlUmxuTTc2UGRs?=
 =?utf-8?B?c2pHanU5dmY5ZTQzVVpKOGh5KzBrSGU3NmduQjlkNDZoNmg3aDdCZEJSVDR6?=
 =?utf-8?B?M0kyS2xJTzh3ek13WlE5aHRuNWtKd3VhcFpuNmpPNEpuSGJXaHpVczY1NHlz?=
 =?utf-8?B?bzBSRk1yQTQ3QXJGVUJJNThMZWpRb3RTQW9Yam9aWUZxaFVzWVY1TWFSUWRh?=
 =?utf-8?B?N0o1UFRJR0cxRFBSMlpQd3QzMFNmMU45N3VkRWQyMGlLeEg2ZVhuR3Y5ZmFG?=
 =?utf-8?B?MVpTMjRZdHRjRWZUZ0VKZklqd3M3dk5oTVZJekxHbjd1VjhMRFFnZTdqMnJO?=
 =?utf-8?B?OFhMbDNHTVJsS3N3MWZkRzVQYkRSSmxrd1RZSjhyeDZwYUpENTczMVpVMUNq?=
 =?utf-8?B?Z1JhL1ZMVVFMcnVIMGMwOXdhOXVvZExpcXBUY1AxdW9QejhhZW9zS0taN2ww?=
 =?utf-8?B?NGhKbk96RmE4NFlwNmVyaE9IV1dnWmF2NVFPdzJhaVJicVJWSlhxRHZvUWFF?=
 =?utf-8?B?Q3p2TUVEcmxuWFpUK2h2Wjk4M1RBaFBqTU9uQUh5KzRlVHFtUU9uYjVRT3BW?=
 =?utf-8?B?QUZyUnZKUXJkWVE4RnJmcnJHbUY4Zjc2WjBrWEZJUnNjSHRUQ3BVRXM1UzVI?=
 =?utf-8?B?bmVGUGNPa2Z0LzdEOHBIazRUMExJOUtEanVGY0RJMDRtNHZ5eHliNkFPSy9D?=
 =?utf-8?B?S1Bwd3J4elVDcHIxbkVHNTNVWHRHRTg4OHZacXg4d0xxMFJ2RjZScExIRGtP?=
 =?utf-8?B?c0R0VVh6dFI3bWZLMVpyR1FxV3B6VzFUWGFUajZUR2RqR0JUM0d0ZUFWNm5y?=
 =?utf-8?B?dFlTN2wwTGRSc2hsdVdXRkFxK3BqZk5BYzhraUtaVm9kZlArNStiTE5GdzB4?=
 =?utf-8?B?ZEV4Mm83Yk9HU21YRkZhK2twS3VjZnV0RmNkQUhHNHZmTUkwYWREd09XS1Er?=
 =?utf-8?B?OXhZRnVoVXV4bytqZ28rK3Z6V3o5M2gzd1cxNS9Va1N1WEthL1dzRExETVVh?=
 =?utf-8?B?OGsrNFJuUTFnZlc5RTEzL3M2M2ZPanZSNXJCVm9ROVRLbHJxYkQwcko0TU5G?=
 =?utf-8?B?VTVtUkpBTmFVV052ZDdQelBNclhOWTN4ajQ1ZzZIOXlnQ1RHcDBNQWZMc2Np?=
 =?utf-8?B?S3l2aEVmMThFZnphY0NtUnV0NEFzdmdBcFIrR0VBNFI2ejhFZE5ubHpZVnFP?=
 =?utf-8?B?M0RUTk82cGgrbnR3RnhhSitWSTZIV3R4UXE3MDRnekxNRlhVKzRvSXJ4WGdE?=
 =?utf-8?B?QUlxSDd1dlY2UHFCM0ljVmdwMjZXZ0I3aVU2bWlPblF6Z0JSTWtpODZGUkdO?=
 =?utf-8?Q?z0T41dWiJV6ANsH9lsPNehQBL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fba42f7-4a33-47ac-a2ff-08dd2bc25091
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:13.3309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FzEWEYXrRAiAPXJYnZ3uUeBN/7ACDkJ6+JNFiCzN9pIhjieDIk2Wm/pHLYGqPmEPvkbVxlIdAWYIhHTlOZ9vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
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

From: Peng Fan <peng.fan@nxp.com>

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45e011b751c19b395b6f99d5c54e78e..84333cdd0ccfe566c269f776f39725c69883c25c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 08c86a642844570424dddbfcf9670d1e6757d8d1..d529f8e2697472e60d0cb9c275f34ef0ecaed3ca 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1


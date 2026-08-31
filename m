Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A72C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE6FD60615;
	Mon, 31 Aug 2026 07:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MicZcusdrv58; Mon, 31 Aug 2026 07:42:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788162165;
	bh=8ooE5UtV6S8ufoBuRweLNeICJUlJ0Nek8Zi2OzStn6c=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jI9sOeDEcD3JxBgqiGa1lLxfnY6Xpv6sYZ3xLd0WImF5M05peiclhaYMM4gtzCjs7
	 kPsBLhxRBVdsAyBtXH95CQjpFZff4lQ5m2vZWiYSYtlZzdHdSsebFI4ln28Zk3s3Dk
	 2CKP1TuZ24aaAQnPlLPaIh/VASdn+g6Z2CwboD7hwu4VCw7gxS0g+vhtrHZqYXilhU
	 X87mOCpSAYGqqRJMknoRLy19BVaBSNcyHpM+vEvp42XpNBrGCdW3AY086VHazAcl0P
	 o/lxhvRrQzO1FnFy5qpkRbQsZWwckQJenG2wsSoy7js+8HZc7Ls7Jfqx7ZOsCGFwdu
	 tOH+lqqiunj5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8ADF605D8;
	Mon, 31 Aug 2026 07:42:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 048CA265
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAEE0400D1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rX03PQDyHYar for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:42:43 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hK4XWhsl
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA85A400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUGX3u2P4mU7PYm7JLgcCT8zJkqFyCuFTsvRGdoHGBSU0o6C7fRZhpTr1V1xQG8L4MFpJXSkPNf9VbLy3i/qCHWqqkU2eHQtzF2+w/Y9m9epJv0U0B6jCNpzcehNT1yae6XdnBhmgcB1LUMw+P7seKkKlmBu4W1bWLfSVeq3NPlICSSXnmmauLUrGW66hUcneHtDbYYqOydXDe2v/JzVyJXofTNi+T00kqS4t+Psa5DBdPByY6jkiPg86UB+oZhHdYmbvHtS36i+ACIkMfgruH3hSSUwLHL3HzsRU6NNrNeV6cuPph8bth6c6v1gHJQYui9zZyhhi6jVXam5WP0Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ooE5UtV6S8ufoBuRweLNeICJUlJ0Nek8Zi2OzStn6c=;
 b=nobPUNsfzUmIoPo3qi5ewLtZ5J5jghdSm75nj2BZSrHwql2+DEuI8m470RCao5osUKwTZ4C5bteY4D3EOIRokPh2wmdNLwjOnun7XwGNuTYvLYrm1gI6FZmVRXmsTb8XTzLcEAw1i8xtNhWcDU/6hc49q1D/68kboJQDcw8GGKFkJpgccJcW1xGT31mYWFTkpYWDlyqlUyjrp5SFrmV7cllvQok+1eb9mqslmgfKUrYdyrTrzzj7R/0Zi4duIqFMGB9eM+FlGKwVVFi+mtb257kKj/HpOlyL6GRJyBetxy2HZCF478KQOVvnuHi0dmXODAN+g/COMuH3d6C3TJCqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ooE5UtV6S8ufoBuRweLNeICJUlJ0Nek8Zi2OzStn6c=;
 b=hK4XWhslJ9gQAN+o8wsjfx0afLVS673q+doHGB6Iuc+ezkJ+PoYhUdRKdTkG6Juk8msfGovF5U4PsprfHMlJTpJxBZ1HiFRjO3Lkvw22/zHz0JC+ax50wm2wLNINqVacaP1plVWHLBCSO8tPDquMX1nN6Hk6OOJcuAUwOr/JakkZSFkFVdrmQFPpDGJGV/yLCoyxmK64csD/3d9cTiYKoKcEtTcOkMXrB3UjPp5PhS8Oe0gp3lDYRShkMo+7OoOl58aJLcJb65LmmuSDUkA3W1uHVOqsZNqO83lgbcNyOQNpE53V/jPlOg7Tes5aSnf3B0mYK6iIGj+8wcN68ykVZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB10711.eurprd04.prod.outlook.com (2603:10a6:800:267::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:42:36 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:42:36 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v5 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
Date: Mon, 31 Aug 2026 15:46:32 +0800
Message-Id: <20260831-imx95-v1-0-a5e482080196@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgxlWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2ND3czcCktT3URjU8OUJGPzRItkcyWg2oKi1LTMCrA50UplpkqxELH
 i0qSs1OQSkAFKtbUAQsUcG20AAAA=
X-Change-ID: 20260831-imx95-a351db37a8c7
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Ye Li <ye.li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: bedcf72d-1116-40a2-3beb-08df07336ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: fGJvv30HSCav/5bizZTvLgH9FvFMwpbQU6iRxPdue6Y3M/aDsS/5/fXjVaso+VBwDpjQzSPaC00qf2/2Ro6Xj7TCTESKAT5MSI5f4LcIN2xEz+gxuOTnBtC10Qt5rvloOtUA4St1yCj0UGqspc7vemuTLJoKaFO8GZHccHCgD9rty2DMgCK0ePtlyn0ZS0YbKia5IZmw3hN1Rc3uZ9V3A5tuUHwHrwT4rbFJ3LCmqRkjx5hSXbyX53iVUEuirPHcgiF14hJ3245Fnf8KiQ7yOHQVC8h4ytIwU89bKk6/p9vroihXGW8To1P6bJIFCUN0w0PXCeovXA2SRpDZc0xhn8/z0w4v0BE6vIyp+Ke6eRpKbRT6DNEx2hmRB2AE+9EM9yo7KdOLBNVM0ErIyC3g/awG7zcUQ8bcchhIkSyr5oLC70z8BaBY+AyQo7VPFxyJoulBuJdZl9sBZGCiX5eachC/fe0QG2quqADJFMKHXUC2UD6gLUAmMKzkMrtm551R/XIdrIWIFEW+in6vbakrco5lznbfV5B9L9tCDW6aMSntjbZXKdlPHoabkNt7nqy3mVL6eXr+UO3az/g1xZ4tHO2UGik1K3jF7dduQ+ZSZN0pjmXd5ywnzEyaxumBCqy1UwTFuZMLk0ffLTgOLKZSjKbItja9+yQWX7ZsBL/XtZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdwN1VoVkoveDVkZXM2dE01UkUzRlVsbHBlYVRTcW40U2ZyeC9xM21QQ3Fp?=
 =?utf-8?B?MnYvcU5ETU13STJoSDZGcEZkVW5zTEdvalcxM3lkZThVNDBMR1JJNlNRczJ5?=
 =?utf-8?B?Wmc2OGlBclo0TWRNMWVvM2h1SXdjd216QXVkQTUrYStWNzJLSm1YVytubFh2?=
 =?utf-8?B?QlVPYlNYZnhWcDFQc2F4ZVp1ckcvZUVsRzBiNDJuQVFyalM4ZmVLcms2VDFr?=
 =?utf-8?B?YXhmd0EvM1o0bjIxRjIwdk5UMjR4MVhvZEtnQ2VINUREQVRrR1UwUlcvQ2wv?=
 =?utf-8?B?Rml1SDVoVjBxb0lFbUlQM0ViKzhQVkhpaklpaVBDS1dGeDY1SDN0YTJ0cGd1?=
 =?utf-8?B?Q25ycFp1dzlVdkZQRlN6enNDWDhveUVQTFJrQ3diOGNNM3c5NldUMTRnNUFn?=
 =?utf-8?B?MmNtVVpDREFtY2xtR25GZmwxZ3BweE1xTE1OcDR4NDNHb3V4SnpGeG5nUm92?=
 =?utf-8?B?eG1BNVhQY2VBNVBXZXMzMURadU82aVpwb3g2T2FobEluaWR4MTNCVFNWdG9n?=
 =?utf-8?B?WFVYdnJuUmxxSGVYRlRydVRFblh2SDBBcXRaWVRGZmxPdUFRQ3ZCQWcwd2dl?=
 =?utf-8?B?c3RTTzVkVTdCWWRxRUwxeHFWekNLRnlyemU4dysyTys3ZHBuY3ZGWmdRUll6?=
 =?utf-8?B?RXN1ZG9TZDMybGVFZGNFM2E4bkFmOGNKQ1V6SlZubEQ4SmFLa3NQSGU2SVN4?=
 =?utf-8?B?T01vdmQ5WVdMRVkrZHZicVhzWHp5YmxoaU5wTlI5UjRHejdZb1B1WHpVeG4r?=
 =?utf-8?B?ZllkZlp6Vi9qeEt2U0hxS1hBT0lROUVNWXJBdWp3ZSt0VVY5MXlaY1IySWxp?=
 =?utf-8?B?OUVuRU44SnZUNG5iUWlGTmJWTTVSa1F0WlpWTlkzQnYyQkg0Z0tpKzRleVFQ?=
 =?utf-8?B?WWtFdTFVZisvWlBab2dkVUJmN0kybXIzeEsvWUkzUFRKL3g5emhSTmlwL3lq?=
 =?utf-8?B?ZWx4aUlmZE5hekF6ZzdRbjByNGwyWVBYTitzbkwzMEExMytvamdSK3dIMDRI?=
 =?utf-8?B?WjdPTXUxZ2dMaWd0c0xqU0RXeTV0bTVUcTBLYnpiQlRobVBEOGtZTXNxVXkr?=
 =?utf-8?B?dVBiODVXUkhVcjhyUFMzZ2p2QjN2K0VYeG5QUThkVXZsY3Z6bjcxU3l1b1hL?=
 =?utf-8?B?clFjN01Xc3paMzM2V0hqTStLeHVHWlVUOW1hbHpoUzZ3RENIMWxsTUN3YnFo?=
 =?utf-8?B?aGtCL1krSkRINHZPYmdXNFZWZEJkcUZRd0dkME5WcVJqdjVBNWROMkN0Qm1a?=
 =?utf-8?B?QjlsZ2x0b09VMFZaU1FCREQxbXoxd1k0TmtqQnhKRHpFYXNvK1NrZjNwSXBL?=
 =?utf-8?B?MkNkNGNCemJGU0hLSElVczBXSDlKSXhpUkQ0cUtlaS9YTkxyQmMzVWtNZkdE?=
 =?utf-8?B?TXZUQTk0WG1ZVjJSMm9TQjgvRVpHNHJVNWcycGpaNXdCZ1NKT2NTTDVBazY0?=
 =?utf-8?B?WXlQTUJxbHM0dnBHb1JrVXhUMk16dGxicWw1TzkrMHF6NzZmMFRRQnh6NTRD?=
 =?utf-8?B?dmkvS1RLcHRvbGhxL016MzRKOWE2c2ZSSGs1THltd05zUUZJVkVjQW9pS1ZK?=
 =?utf-8?B?cGxPdlo4ZmozSFUvdlRqVW9pWHJIMFNQcGRPN0g1OEdMRkVuNVRnbC9Pdzll?=
 =?utf-8?B?aEpjUHYxZ3UwWC9xYVJNMDg1Z05kT0Y4UlVWOHJYT0hFelhPQ1FZVm9mN1ow?=
 =?utf-8?B?M1lPNkg0SWJubWcrQ2NwblY3ZUphclRGWmtFZVp1Tm1wWncySVM1c1hFTjhu?=
 =?utf-8?B?VUxzVkthMXM2T1h5aEg2OUFRWWlWb0lqMGtSV2NkUGJvNTNvbVljb3cxQVR0?=
 =?utf-8?B?M3ZFeXZ0dXdmNGZpRFlJYUxIUDFBNHZ1MnEvZXBMQnRROTNGZnZEVDcyamZh?=
 =?utf-8?B?SkZUNVY5SGZVZ21BUUZaVFF1enFydmFwaUphbzU3cW50eEVEYnFPY2JEY2lm?=
 =?utf-8?B?OEtZbDhldWQ3REg0N0h2SWZYanc0UmY4NGloSzdrM2VZOTZ0R0xoYmJTcW1y?=
 =?utf-8?B?NDVvU1I2d1ZHTXNEQXd5K0JtM2NhcHpmWXd3TWJIK1JiWDg2ZVlUbXd0M2RX?=
 =?utf-8?B?S05jOCtUVGVuSzQvN2dIeU4rTmhoUEl4MTlYcmhPZlJuWHhobDREVmRKSUxr?=
 =?utf-8?B?SzJwa09pbDdvcWRnWmlkRXVzaEYyNDhRYXRZY3FxS3pXa1NnVzJHTDZDaU5M?=
 =?utf-8?B?OUx5cDRIeWdUZU1aOVphcnU1RVVvTHBibEY4S3NGN0RQaFFGNVFmd3JCamk2?=
 =?utf-8?B?NFZYVjJKNVdUWEppZmFqbVlwK0EzNDZ4NG5VQ3ZUbk5pT2h5QVRNTnVKTDdC?=
 =?utf-8?B?NTdybExHd2RNSlhZV0p6dVNVaFp1UEZyUlE2NzRHVVV2N3NINmFtZlpLeFZP?=
 =?utf-8?Q?IZrEXsgpANXGzYWixPa8rYJcgzY9EbpItGB5x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedcf72d-1116-40a2-3beb-08df07336ce4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:42:36.5442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aJRhQS32mBgmRGVWKfXyuWsfd5M7R7vavVGq3uZHxDzytXcjcc/+tcxCvisw9vr5qP+YcynWsNfsBG3kGyh4hlTFpgiHLzc+4W3DJcYi753nSzABRmBvMHqn5Mrvann
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10711
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Changes in v2:
- Fix CI build failure

Changes in v3:
- Replaced #ifdef CONFIG_ARCH_IMX9 guard with a runtime wrapper
  function, improving code cleanliness
- Added explicit 1G-only PHY capability restriction for SGMII on i.MX95
  (no 10/100 support)
- Added a new public wrapper xpcs_phy_sgmii_1g_config()
  fsl_enetc_xpcs_phy.c for better abstraction

Changes in v4:
- Move the xpcs_phy_sgmii_1g_config() in fsl_enetc_xpcs_phy.c from patch
  3/3 to patch 2/3

Changes in v5:
- Convert XPCS PHY polling loops to read_poll_timeout()
- Clear only 10/100BASE-T bits for i.MX95 SGMII 1G

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into helper function
      net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 Ethernet PHY Wrapper
      net: fsl_enetc: Add 1G SGMII mode support for i.MX95

 drivers/net/fsl_enetc.c          |  20 ++
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 696 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 635 insertions(+), 82 deletions(-)
---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
change-id: 20260831-imx95-a351db37a8c7

Best regards,
--  
Alice Guo <alice.guo@nxp.com>


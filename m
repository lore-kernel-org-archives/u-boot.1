Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832EDCD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3451848C5;
	Tue,  2 Jun 2026 12:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QuCV7mf/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5288B848E2; Tue,  2 Jun 2026 12:03:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA88848B3
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZkS316FF3qiSIH8clRkGf95laREHEyrMneKRtmDAr+6B5u1LX3Fq37wqFJusH0Cxa1kYPgMbnWVOpxhPxiT8M67Rb7X7INNfo45aZLJ8heI6h06FmsM6epccCdp8kN9VBjlYarD28+jlxBLuDVYtD+5NVnUqr1kGTEfqYvOtMtipH7TvLtzXDlxZ6FCnReEwLyfnO+cNAfiRLsy+iMWJI43J73Gi2lZo8/dgeFHzB6Zmycfeyv0n1IyVjhe05G9FTskiEfLZFh9Ru7bdvQQeIzMUyMNTpP8nC34E52EZXG7i8R9pEEiqPx7RJvkuEDfUBzCWsrVewZETNYfxrxyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35To7Us3xqLo0qpHWbV17XaIB7KXnXYDB5IPr2jrg0U=;
 b=UD56o8rNpRc3Dt1f1P6TN/WgsG84N1uKouH3j2qqto65YHyNxS9DGzqFkq6xeG7j5PZ0fw3dS1h9AsDmULWHtPGDrXkaJXQ3ne+6JTU9Ccnyy886PduVQeexaUWVzE8XRa3+fIfpoITOWlzrThRXq53DbHuDq5qn6F30dtK/yon8oayx7xSkRw3FYTKIdrFAkoFjx993YyQTbdwzUVUjcTpSugwcgGS5XEJASVP3M+fzyscuP1dLzAH+1DayxSNFrNiu6zUq1R6JPXi6JVfiSaMR3HHF7yTtc8xJqXMcKui2ZhbV3Ap/EZQcmprIcWlL265nZMROjXiA+Kz9zbSqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35To7Us3xqLo0qpHWbV17XaIB7KXnXYDB5IPr2jrg0U=;
 b=QuCV7mf/Mycs2qGMTmNH3EB61jvDlJfe/O7nVASAFxJCQGkMerovAe+ErjzC7WnJryjAaIoh20zjx7FHOx9KUSsdQRYYalEhv7xXwKxOYlB8PL0xSeRR2vYKoJS+ywrox6fwtGhvNS7w5oxMsANQI5MbW+RIV6575XQYCzZzqJUm6AhDINDpPpqexZrpmIOK85WEWq85TLiTOQk6hLYs7UtX9SlPVTBoMSVuzdBVUI2+n9sUpJTW1h43ZfTBgWoJi3NXgChK4S4MaAQJdTHNBeUAFgREBcKBEc0JSVGf0lUnPtaiULYgvJonAmu8fVwxRx7wVXCTjpHB3pAVAGfhjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AMBPR04MB11742.eurprd04.prod.outlook.com (2603:10a6:20b:6f6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:03:47 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:03:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:20:16 +0800
Subject: [PATCH v2 2/5] spi: cadence_qspi: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-spi-v2-2-08374650778a@nxp.com>
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
In-Reply-To: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AMBPR04MB11742:EE_
X-MS-Office365-Filtering-Correlation-Id: 988e756b-0edc-4773-bad8-08dec08e3bff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sH1F3b55PWl54bLPDkxsMU7o+asAmeFYO2K+/E0QPhxpXKHTIMFj39n8/1nDJuD2KSpCwCB7HVslbsBGr5qSXl8JM+eJqVfI8A5A65KUICjiMJf9uFAUfVyJuPLOtO6HqulCLIJXPbWCDJJK6pi7gyK7coy5bRK2UBj5QmoJWvDrp7DT3HgfBIShnRgvwfbisM1bCt2mcoNQUOY3SgSRMrJBxaX2tybdR97lH7SAFuRlOpnnpx867mLOwE2csnwOIqxVjdDlfikXVJHs59JgVGqJ4ABpzXTDV+2tEP9oBgzmGzCJRsLi1tIXFF8UI9e03NkbiLOtYQMetT2QZtFI98mjgya8JasEh+Z/W97kZoopV1e0H0XNX0imEQibtn4iDfwWqBmDkU8rYiq0BZuxW0dWaZAcjiv69l9rikZWGEXzkYYMSvYj2Z2ugM37JzpL04OtV2Kdqb4G8vZvZEWAZufZ7cfii4Q5hz1L6btYZohGh/a7IYrSackjKoLJxPnYjo4efage3/iQJCx+kmnAGMaghLR0KK0RoY+01UtBmIkaFOlgamhqtBAxsK20F6Q3chIfdoeLflb2EU4VikxqAW5tQmAYWeljbVU7BnoOSPuK027JABHqAiDfJNXUvMfdDrKXFufRlpAAuv3QplRi8dUmDuD94RPYSTdm39re7K7u+BqK6YrfOu3iw7Qho+m4NYZ6manxIrpjF3qSSGuPZzq/IfAvowE1Ei7UyU3k73KrpdZ4zQJYU4F/Go2m47W8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzd1SjZncWlaZGtFMkVFeTVvNExNeEFNclRvZXFUN1dTWkN1cER4RTErVmR0?=
 =?utf-8?B?UGUvUUdPVjZXUDN2S3BlNndhbC9JMjlJZityMnhldEdJRk81QzV4aVZ5RllE?=
 =?utf-8?B?Rk9DelNIRUpYaEVtZW5hTk85WWpoN29qWmt2aXRoc3dGS1IwZzQzTHg0eFpF?=
 =?utf-8?B?K1VIV0hpL01tN3lUaXVJYTNZbWo5dVkweDhmV3lJVmZMM0N1TitKSWcwNDVn?=
 =?utf-8?B?eWhkSHR6Tis1ZXBXUUdkR3EwM3hqeHd1eFQ3TGJQdi9tSVZIMUVtbHhhRzVL?=
 =?utf-8?B?cFZRUzArd1o4RldwazNYbTlxTzFpak4xRnNHYTkzeVhocnFmeWNCanVRTUVD?=
 =?utf-8?B?bnhqQnEyN2FSb2U3Tm9LN3Y4VXBZUm5xcnplczFwUXRwMEpYWDZ6S0VtM1Mv?=
 =?utf-8?B?SmFWZkpMYUxtYW5zeEdPbHZoa01qTnR4TVVUdnlUVlRrWTlXREVGRUl6ZkFw?=
 =?utf-8?B?T29vZG95K0h3cTNVNzlYMlJseVFyTk1iSXYrZDNSNDNydDFTOFdybStpTVVL?=
 =?utf-8?B?T1h2RlNHdm00Zi9PWmdYS0VVd3hSVERrR1oybXFUS3dQeGJBWi95eVUvTStt?=
 =?utf-8?B?Z1FuUXlLblJZMGhucWtBZnhuY3NLZW9ZMzNsWXFZYytyRTAzbjUwcGZmeWJP?=
 =?utf-8?B?LzliN2F0bWozcnNpMG5wSUR5NFVsMWpNZlpjNTM0N0NMNnFoUExmUld0V2lW?=
 =?utf-8?B?cEZmZ01ucEFJa3JZUUw2RS9Fc29LSVcyd09CRWV3VndrbnhGM0NuNTFyTitp?=
 =?utf-8?B?YXVMbnMrNVE4NTJsL2MwbHVCeHJqQkR2cDdRdjFDOHFIdnhabGtjNmFrdk9R?=
 =?utf-8?B?bHIrTW1YeHBRUWNJMkVUUEd4T1JMbVFFUFFycW1DeGFicHh1elpDeUhNTFpL?=
 =?utf-8?B?anNxWFVudXhuMlBDT0RBSVJvbXo3ZXREdjlVamhtRjQ5eHVKZFFScTNvQzNX?=
 =?utf-8?B?RTF3cjRiUFVWMlE2WkE2cG5ENENLSVkyYlZOcWVFcFZIY3lreUIvVVVQOXBO?=
 =?utf-8?B?c0Z1S1JHblQ1OEVKQXFXdVYrWFE3anExdFRxa0svWWxGaWNsYWIyK3V3RXpR?=
 =?utf-8?B?SW5UVk9zVSt3M3FkbDlvbkRNZFdLc0xZWEFNSFpxQVZwcjVoclR2ZXJkclFF?=
 =?utf-8?B?WjgrMUtjcDJTczkwMVk5emRSMGxpaE9aaC9VN3BOZFVPd2RrTFhvTzFwNXN1?=
 =?utf-8?B?MTZ0VlpLUzE1NlFKa1Z2UzJ5MDBKSmpzeFZWUzRSeE9ROU1DMTFyOVBuWWI5?=
 =?utf-8?B?WkZ6dUV4ZS9lTWhOMXNhQ2gvU2dndU9RdHpHeE9tdkI0NWRZelF4SDNDZzg1?=
 =?utf-8?B?QTBld3lVVEpXS2xXcWJNa3Y0Tm5qVnYrdDNJSGxFR3BIUDRvZ2xsTmdhRHZy?=
 =?utf-8?B?RlBBSDF1cU5BMFJJdis5OXY4bWl3UHJtbG1FTjd2TjNaY1lsVGYrZEJmOWVq?=
 =?utf-8?B?eG8vZUlkWE8rN0ZrdXJtM1BFL0Y5RVRJc1RrNWo0ZC8yMDVyUzAwQU41bnVm?=
 =?utf-8?B?dkNRTGF3VnVIbktGb2oxVFZFd3RjK2dTbkdXcU9ET1NzMFJ3eVF0VkdRYWVX?=
 =?utf-8?B?STloeEV5YmxqaDBHZU52a1A4eXJuV1phaENJUlRZdW5DdWxUTGQzOWVOY0hT?=
 =?utf-8?B?ZVFGWEhRcDFwTk1YcVhORDh1OFhEZHlWYXpBbGxaMm5DblFuVzBkL1VUK1hV?=
 =?utf-8?B?enBzeERRU0QydnRMZThFaWZkYmRLeERHN244VCtQVjRacHdxMTRwTzRhSDU4?=
 =?utf-8?B?bi9ZdUNxWmJrRnZ2TDdtL3pBbnJrSlhPcytXbFUrVVVoaGRFbmxpQmNGdk1J?=
 =?utf-8?B?NTh2cWFGKzV2bm14cnRjS1ZQOStBL29BSmpWSndKNXNBRjNqTXRkeTVPeHVF?=
 =?utf-8?B?aWNhb0xUWkpQOVhoL0NIM1RNaDVvZzBpR0Z5b2Y4RDFab1haME9qQzZ5RUsy?=
 =?utf-8?B?UE96bTRaczhIUmRlV1I5d2tYR0RyUGlKV1dSTTRtV1lyeWx3Qzk1NmloYTZa?=
 =?utf-8?B?WWk1M3BqU0t1a0hoSk1sRnVxemxEUzRjUWRYQnJBK1ZJSGQyYVV0WkJrTk1r?=
 =?utf-8?B?WHo3YWpnTW55WEsrMUgwMi9ZVmtMT2x2eURObHozWVhFdEFhVVdnc3ZaVzRq?=
 =?utf-8?B?SlJFOWZ5eEVUWDIyWnFoN2FkUXRIYkJDa1RNTUNjT0RDVXJNajNnS3RjVis2?=
 =?utf-8?B?S2VGZHlsNHN1QlJQS29DYUVSNlNaVVhQU2I1VmJ5cGwxMnhYT29hVEFNUzIr?=
 =?utf-8?B?aWxscTErbWlyU3BNbzc4UlkyekpzRk01TjF3K3doUmsrb0ZBVGVBb1V3ZzAx?=
 =?utf-8?B?TjZUd1kybE80MXNRUTRlaXRLUld4a0pwdzRleHlBWmhwZUcyaUVrUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988e756b-0edc-4773-bad8-08dec08e3bff
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:03:45.8564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Aho0VPbl6VrJ2Uav54aJYOtK0fC8NGMRq8Hc8lau9WmI0dgpOPejtylQpVkrL/2I1cALDOE4dpcDaq0WTZ8xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11742
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

Replace devfdt_get_addr_index_ptr() and devfdt_get_addr_size_index_ptr()
with dev_read_addr_index_ptr() and dev_read_addr_size_index_ptr() which
support both live device tree and flat DT backends.

Add NULL checks for regbase and ahbbase so the driver returns -EINVAL
early when the reg property is missing or cannot be mapped, instead of
silently storing NULL and crashing on a later access.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/cadence_qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 2a4a49c5f1c..20983fb7814 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -418,8 +418,11 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
 	ofnode subnode;
 
-	plat->regbase = devfdt_get_addr_index_ptr(bus, 0);
-	plat->ahbbase = devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahbsize);
+	plat->regbase = dev_read_addr_index_ptr(bus, 0);
+	plat->ahbbase = dev_read_addr_size_index_ptr(bus, 1, &plat->ahbsize);
+	if (!plat->regbase || !plat->ahbbase)
+		return -EINVAL;
+
 	plat->is_decoded_cs = dev_read_bool(bus, "cdns,is-decoded-cs");
 	plat->fifo_depth = dev_read_u32_default(bus, "cdns,fifo-depth", 128);
 	plat->fifo_width = dev_read_u32_default(bus, "cdns,fifo-width", 4);

-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B68CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601928394E;
	Mon, 11 May 2026 23:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="p5gbCmOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D293583FEC; Mon, 11 May 2026 21:55:37 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67098394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 21:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBJFLlfjOCfCO/rOqRKpGfnF9hDQnBIqb0r6Zo+KM++UZqIZI8Vk9HOeN/LLtWN8redDrcn+va4X+GbH2YLa+FsdpAqiaMUT2PySEQhlR1mnZ4605gxibg0iu99IXvpMPD67cwVaVWXhzsh8AQHykIQsAkhfqfs98lSB/o+Pj2Dfk0G9tt4jzVYnoYJqSSnOQ8yF8/mPqIDREGI7O6KobKit8Y03O3ILOrLYKdBrF5dk0ZXU9WW84fFzb0f4tcEtzQM78qng9BmOe5BAxhT63xFOB+K6BwsOgAUcCt40NJ0BJYEOF/DDIGWf9p8CTPhoaw55OwmSYB6LbyqSkDwnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md9L94xoKbZUQS2mByPfOl2LCAygmPM2RJ6bUn4V3ps=;
 b=QapfNDt17zFy4JlgtpQsAEoy90Zxxhyt0d58dTLlQrgVVUZBlWqZcf65mR0sthWXoUx2Af9Jyzxm3f1Lg9BzNkyfTqsaxkpaUM9OS5x5Ik9UZIOp36LVWnICw2iZOXvg22CLBPLlTMbfyi4bxwsO+vJDdjdOJevT96ligfuZEld8SNJbyp9J5N4tn6fxYe+PjTLX7o1GTVlVJD/eYbahLC7NJgBBX/boi5gP+fBsfSgH/4wHtP0t0Vpi6vvXcH/2BFECPU/aZ1Bm+4Ox/zbcY+qa0x6s4R2i48vKIY5TkLPcGRdc1a0LsagSaTup7P7riDPTddYVXsjoUELDKhT4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md9L94xoKbZUQS2mByPfOl2LCAygmPM2RJ6bUn4V3ps=;
 b=p5gbCmOEVdOczdETb+bWhmz9LDm/jp5jUyx/QvAmSx5BXA7LwYsQIMcoWkFKyJCJmsfj2ZNWKX1RofifFvfDKzdAyO8BpF/yAqTQoEq/mkyFlAbc905ubs9ySWf1HtuIuK5rY+SM1gBVAkQ3KT/Z4fdf1VaCgKxsXRMfgHaupAahYSrQqi6rxcI+B2Bq2wHlg5SQdIEyAL49dqwgmYmQKwbaXaCA1FZXubgfdxuamlGZme2nFUgYKOIq1WHRvtWwb9UECfnQZSU0i2wcx55Q1EAlYzaOJ66M6u2G7YL1SyW5r67AGV+xo1GzBjFwo7jp805xQjd02/6BotCypu5CQA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV2P194MB2966.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:304::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Mon, 11 May 2026 19:55:34 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:55:34 +0000
Message-ID: <BESP194MB2805928BF5055166EE7F0B11DA382@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 11 May 2026 21:55:31 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] net: dhcpv6: Prevent buffer overflow during BOOTFILE_URL
 parsing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0382.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::14) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <19c84e49-1d90-44ca-8248-a931ff9b7d2e@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV2P194MB2966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9478c1-5e11-4ae2-2d8b-08deaf97439e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|6090799003|51005399006|55001999006|37011999003|24021099003|15080799012|23021999003|8060799015|19110799012|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aElxM01nQ2pST1R4Tm5URGlFMUVMNGRVMVFXUk14bUxrUWJyaTFtN3Y2dEph?=
 =?utf-8?B?YW9XZHNHczdyUytHUkZWSGpKZk5yR2gzT3ZYREhuVlRDaVI2YktwYS83QVhW?=
 =?utf-8?B?VkhNUjlLSXI4U3JzemFhdEgvQ1B1OXdCbEhjN1orVUNKMi8reS9aN3FuVlZS?=
 =?utf-8?B?dlgwUmNjdWRSS1ZnSUcybmE2Y24veDZMYzhNaTV2SXB1aWVJa1JiZC9xaE1o?=
 =?utf-8?B?Q3QvVUtVWTJTa3JFYmlBdzVPYUlXMjFmSm9wcVB1blZYSDQ2RGFLNWVORTc5?=
 =?utf-8?B?cGJZWTFFVzZWM1ZoclF5VFdLNlh5QjhLRVBOUWJaR0FqSVdBZ1NhZFl0aytR?=
 =?utf-8?B?Y3dOb2VlVDJRelI3RTA2M3lVaDNuM3JmUDg4ZUJZZUZIVFlvQ1hOMjVreCtN?=
 =?utf-8?B?SGk3VHUwalNLMVNFaXIveFdncDUzMGxBdUNBTHp3Q2tTUWkxalEzUVgrZnF2?=
 =?utf-8?B?UGNoUVdWNTJJQnR1dzl5WVFRME05Q1EvVG5OWmN6TVNjRGhTUHdlbTJHZ0ht?=
 =?utf-8?B?UGpWNjg5M2tseDBTdUw4aENpS01CY2xBS3ZIZlU4bThEdEVPYmhsSGZYa3kw?=
 =?utf-8?B?THpFNmpkTlY5bTJMdjV4bE9yZzcyemMwNXJ4Y2VEMWx1QlY0ZXMyZVpKS0JF?=
 =?utf-8?B?WURkM3ErSkYxRlFDKzJUVUJGa1lGWFM1QWcrWGY1SGF6MjB1d0VMbm9UYlhF?=
 =?utf-8?B?QjJiV0VTeFNwTVIyMTJPOWFieEhJTVVJbXJUL2Q2b2Z3VS81YWRZTThhWmhB?=
 =?utf-8?B?YXNNanZLU2ZmcnJKRXlDMEFoQytVM0dPSmhPVFc1K3BCUjZPWGJESE1vUy9U?=
 =?utf-8?B?VGE0d0pzOGZGcWxqSFJzZmFxYVZscTlrQURraERzNVpFRHc5MlUrOXp6eDRQ?=
 =?utf-8?B?ZUtBOGRUVDAvK3M3ZGhNRG5leU5XY0dEdzAydUtqaUR3VGJPSHJOSjZ5WXpM?=
 =?utf-8?B?eXMvdC9UaTNXWThCSkI4S2tTVWp3YWdGNGhkRDAwaHU5YlNCQ0NZNWsxSkk3?=
 =?utf-8?B?MHlxdk5zaUdDVW9OdktPa2hpREsxTUFNZVBHUG9SRGV5MCthMTkvL3RJNHRF?=
 =?utf-8?B?K2tWS1BkUU5hTHdRZnB1b1BDYzZrLzZPVjdTVGVScUtkMGZGU2RTclFjaWdM?=
 =?utf-8?B?aTlmL1hYWjVIVE9HRDdUU01kU3BLaWoyMENjbTdZTm5BTzdHU2x0Q1lLV3ZI?=
 =?utf-8?B?dVVGcWdpN200L0czeWVhS05zME4zUzhnTVhlcGRXUkdvQWRyeXhsS1QzM2Ra?=
 =?utf-8?B?ZGNadjduNUtLZU5wdVV2MktSaTAzelZURk50dnpsdldwa1ZaL2ZlVXJPMFpZ?=
 =?utf-8?B?R3FaVlA4QkJhUkMwN1FpSmRiT3RCVU56cGZwQVdtUzdZWDFGaDBienhtd1FH?=
 =?utf-8?B?eGVHTm1qL1pLOG5RWUdndyttdjBmS1Z3dUVJZzlob3ZjWlkralRyZjc2em5E?=
 =?utf-8?Q?nP9pETUD?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDNoZHg3SE11UVdnVUIrdFZRWjlqMGpqelgwc2tIcWxIZVNJTTRTY1RpWmJo?=
 =?utf-8?B?MWtDUlZCTTcxSWxKSnhNVzl2dFloUE5BVkt6a3Urckl1OEFnWFFaYk9Xclhk?=
 =?utf-8?B?bmxibGxHTDdrOGlIRjAzOElodFluckdjLzVqYjB1VmZWOWJROUZ6RHN1dVlG?=
 =?utf-8?B?dDZJakp2S0NRUDJTRGNZK0lNWEo4QmdoMng3eWsra0toVmFWL3NDOFFXR3Fl?=
 =?utf-8?B?eEZZaUVoNEtEaUt3eTBodld6Q3JTR2ttaHdMc0huMVNxUElTMU1GbWo2alE2?=
 =?utf-8?B?NG1wVHovbkk0bFExVFJhYkhmYTdqZUw5dkIwUGdieHJTaWN5VEpLSFFSVTNS?=
 =?utf-8?B?cUEwUWZWRjFBQ2RTOEd0anh0cXFaWng3K0VkdEpmQjI1b3NlTzFvR21yZkJY?=
 =?utf-8?B?ZzNJY1hHWEx3YWZEU3QrSy92TnhpWUZqM0lYc0I0Z3N1MEpqM0YwVmtrRmZh?=
 =?utf-8?B?TjZmVEJIZ2tGN1VzSSsxNGJOZFo1MFNjTVRNYzRiWDdZa0ZiSjc3VHpPTXp5?=
 =?utf-8?B?SW9NZXJPbFZmSUorNWhFaXZtOEZZRTlCb3BzdXZwOWhid2ZnM0NDQjU5RUlM?=
 =?utf-8?B?TEJiN01oWGpSZ2JWUDVGdHdzc3hKWVJKWFhaTDJpRWw1YUxLZUU2TEFvWHZV?=
 =?utf-8?B?Q2hjTXlEb01teFdOc2ZzaVY3MDhLcjZsZFptZkxRT05nUXpGdVR0NUVsRnVu?=
 =?utf-8?B?UUlFa1gxT0NiczRheFpCOUZBSFdpVkNxQVA5YkFubkxtM3BlaWRCMStPM1Ey?=
 =?utf-8?B?UjNndnptZExnZlBKS0thTnh6Vi9SektlTFROVkt1RDgzVXpUOXc2TFI0TytI?=
 =?utf-8?B?ZklQUVBFUnlSOUE3Z09ILzVvUGtKT2J6OXV1clBqeDNSWk00eHBFQnFDVDhm?=
 =?utf-8?B?L3ZRS3FKY1YrU1h3aysvMks2QlgzNWZYMDAyU3hnQ2xmVWFDQTVraWFUa25K?=
 =?utf-8?B?N2V2WTh1UUZMWllzKzZCa3hEdHd1aGpSbXRrcnJkYnBUK1lTNUo3RFM3em5R?=
 =?utf-8?B?MUhFaWVLU3VWVlNQazk2elk0YzlHT01pUUdDejJMT0dycFNEV01xbmhKc0V0?=
 =?utf-8?B?NktEaHVMN3dBRFVXeTZBem1IVXFNOFpPelVTQjBBNGlGN3YxZTRMNFlhdS9y?=
 =?utf-8?B?VENDSGVqcll0UmQzaUZHWEJiMGZrQnFTMG5RYlpDUXRjVEQ4SWJyR0s0cnU4?=
 =?utf-8?B?Y1M3UXVmcDVtbzZkMDdJUWJjN0I2bmtPaEk3S2xOYW9RNzlvT3o1Z1VkVGF5?=
 =?utf-8?B?UktjTVlTMWZaeVR1bm1VbU5JaTlkZm53RjhhVmJqRVBaUEVPQjlGVk9ick9q?=
 =?utf-8?B?Q0VmZndGMU1kWEk2V0xuem1nanhlSVhLbVBDNmg3UTFINVJBZEV2a0lvSGpU?=
 =?utf-8?B?TE1sTlJZQkU3VjlobXFpOWNxR0xmTldsQjZjSWNwdTJNMXQxSXNOTkJxR3Jn?=
 =?utf-8?B?bUgzN1JMV1J1cHhzMDlpUUl3Q3JTUVpuOGx5U3JGaUtNZjY2RjJFMFZVeXBx?=
 =?utf-8?B?RVBqd2NzZjZQcFM2QVNSTnVncHBMRmRnd0NDUFZPek0vV2VJMXhSUHJ4K255?=
 =?utf-8?B?SXd1Q0NFdkhZOU1pdkRNY2k4Z2djSzQ4YWdPOUpRRUpRcWUreDh3Z0N1M0lI?=
 =?utf-8?B?NGxLdmRNSUI4MXNsTStEZnV1NTZQaW1zMHhrdnM0OGRGdE9YUlhtMWs4enlF?=
 =?utf-8?B?cUlEK2lHY2o5dFUrbnFlVjhlNHV2blg3VGgwTEJJV0V1UXlSUEJUZTQ3T1d6?=
 =?utf-8?B?V2x4dWx1VzVxcnFJaElQRFVkNWxoYmYwT2JXa1BvVnJkcFJMZ21BdlpiY3dQ?=
 =?utf-8?B?RjhFMHJvZmY4SjhvQ0NiOThvdlR5UWtoUms1VHM3SGVYS1htTEhpYVRYa2NE?=
 =?utf-8?Q?Q0KqShxt2kd4g?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9478c1-5e11-4ae2-2d8b-08deaf97439e
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:55:34.6582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P194MB2966
X-Mailman-Approved-At: Mon, 11 May 2026 23:10:28 +0200
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

The net_boot_file_name is a 1024 byte buffer.
However, based on DHCPv6 RFC, bootfile-url length is
specified by option_len, a 16-bit unsigned integer
(valid range: 0-65535).
Hence, one needs to make sure that option_len is less
than the size of net_boot_file_name array before copying
bootfile-url to net_boot_file_name.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 net/dhcpv6.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 5bf935cb6a3..51f44979f8e 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -377,6 +377,11 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			break;
 		case DHCP6_OPTION_OPT_BOOTFILE_URL:
 			debug("DHCP6_OPTION_OPT_BOOTFILE_URL FOUND\n");
+			if (option_len >= sizeof(net_boot_file_name)) {
+				debug("Option length for BOOTFILE_URL is greater or equal than %zu. Skipping\n",
+				      sizeof(net_boot_file_name));
+				break;
+			}
 			copy_filename(net_boot_file_name, option_ptr, option_len + 1);
 			debug("net_boot_file_name: %s\n", net_boot_file_name);
 
-- 
2.43.0


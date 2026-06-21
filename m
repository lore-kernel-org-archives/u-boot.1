Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF10CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7922849BA;
	Sun, 21 Jun 2026 02:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fd410MWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C98283FEE; Sun, 21 Jun 2026 02:49:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452D2849BA
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8pMj7EF0SFkEEqJ4qTpb5MIvL7fGpybnZJKznLIksv2ATwF/R8sarFjbm0XayzkkMYseSzbRzPgkh4zzJwfrMbpGpnGtnwV47SKMrnvv85knoaYWOu+/ljVCI36QJK+n+H4925Dk/0I30ABxcnknBbK0fnIBkChQBr8EDoZ8tt//MVMDlD/EkYcTtzS2VmcYI+O0Z044y3TI8ban4ceFWDa4aiNKM2VYg6V1ssLjr0Rxr3PAms0dRrsUgt4BUf8s0F5b+C4FKAtzHdVId7T+t1l7kIWodfsGHTYGVRWGnP1TT+qQV5L4ULkFT62B6nARETzxXDJRlRepAE8L0KCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcYYhTqjxzSz2wBLRp/CNf+2WRYcAhpFLYQ8RagNtYU=;
 b=QXxDX5IxonEquascJVwTW/f2ne7Hvoj8Z5PhZUdtWqVVb0QTdH2Y6tJ9/iO9AldzJAO3mb7X3BPSOlj2uWHVu1e3Bj8tkQq+bBTT7YtAf+P3mFgYigRsoIS0YSkq8YYCnH6NNOVLGF9530mczSXqXn1ElpfegOKPQpAUSR8aWf/9iCmmcke9UB/fIVLXo1MY+ZIAD/7auTzvjjYvqWXTCfKadX26D604PwCFdIEcIEkGMDnLBvs9io7aefYiGuXU9f2TtLCmZVWVmvJiBvbmALEYK2dKkLuvNLFpjPjv4iBlZ7z3keSHMsiBcat8a1cUyYvpynWx5wbRzyULlrLt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcYYhTqjxzSz2wBLRp/CNf+2WRYcAhpFLYQ8RagNtYU=;
 b=Fd410MWPs/TH7HTjdb0ahDasgrb2sygKWzgGfYA5TUE5bZaAxrstZmaLPWcwIr392OCpiKeSWAErbUVKNVb9JLdT3MRvYSc+CGsFGstl7QknoEBGy6Fbu2le6LvNmp4LWHDcpKasQRFUfYN//DwX1ZBcdTCdABHnOYxaki2hdBsxswPKnDfyvPRjO0KjDnejMqMJAHkmr54yB2NEUXd0EwUftI/Jz3sxLPVojV1xCRN9gYOY0j/50kfhCsE8pL6QUWaqiFVQaw4tRtScgHmnzGQJDyhrMufHOQASi3EAZsF56eNgOlAUhhnpF1LQeTcXK104dPCqbdFOrjsD7sxcPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:49:46 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:49:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:38 +0800
Subject: [PATCH v2 02/10] usb: tcpm: continue polling after PD negotiation
 to handle source messages
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-2-990ecacc111c@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2855e8-69ab-4c9d-a328-08decf2efdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: k8AbidPoE6JFeWCajrEO5A5CvsmXLw0rjl0p5nxgCGqxjXYfjziDkY2jX6alWxyAPnxpqtD3ep56Jbv6I3RlKhVhoMkPMCCNESlSHC4xVcuCVTOBr+g1O7UIyGUSmreOziKKvXXPUa/RapsJHfvZpagJkY6v6ANZhbl51K5IC0iK20kHLtVsf633ppwyJpgYS1sBSf81v3HE4A0XpPKmIbFvHSL9FJoIv/MCAa/NqrJS1ulH9JuD2e/xPt9LZuChVO3u6UV/zXqszgWPlHHl7GynuOOd5M/5FxYC+oJUTxTPYUeiIiIN75XkG3lYwIocdbzdRMm1scDmsYqLajjO3H2Csg+SQhrcKn6kU7Zigyo7YPTw85hVL7Z87ibaiYoqe6BJbHQv+tKAVnASZ6ak9Se6RAUkVv8ie3KQnyPp58l1PTN2JfbZ3wopiw9raN8JIsvCOEU+HDaUHUHO6falUsXANibiTff5W5ku+fFCsjtv6+7Fkwth1Ugwzffazoqb+slCDz5tk33MLfN43DatuCsHj5j4Q7bqaJBPFMr4bzNK2jSqkk+VVYbuCLYziS4Q/TfxM1yPTWIn0Ca5NxjlRj0VEsLeB8j9GFmR6OZHxI06W9NMgawJSzOSDUSL6iipM3TwA777MSJYbQTxQZP+jn8dT3K8frZxFaoLmlXUvyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzUwU0ZCYlczVUd2MnlRUDFTbk83TlM4alpOSnBXUm5HbWtzQnY4ZFByOHB5?=
 =?utf-8?B?L2NZU1BIS1hBZmJ4MVZWNFpjQnVDaW5sc2pxay9NRE9OcEg0S0ZkVWMzL09O?=
 =?utf-8?B?aDRpbDNUS2dqZzJJVWhDMWlKUVFhUndndjl5MkpZV0VWWXlORjVCbkdiWU1O?=
 =?utf-8?B?Z2plQkI1QjN4UU40VDE0bEZBMXo0aVZsTWRrQVpFZnZQaXVDNFEzWElQUXBr?=
 =?utf-8?B?d1krWS9MUG9iQ1B2TXJkQmtNZGEwRUM3RStRSGorbHcyWE9OczRLYkFvNU53?=
 =?utf-8?B?NVhwa3pBcE9obWdxL3I3VFBEejZjUnZHdjRiL0x2S1pwQWovSXFyNE9lbDM0?=
 =?utf-8?B?ckQ4b1R0bFJ2YXZoVTk3SDZjNmsxZnRNVitycE5aYXlqdTFuOUgybldIU1VB?=
 =?utf-8?B?TDd0U0VraWVONVlFS2V1MHdCTnlqV0s3UDZTWFg2Q01FQ1lmalFydEpoSUNp?=
 =?utf-8?B?UnoxZ2FKVTdWdlE4NzU1TTNWSjBYekRmaXhEaXk1ejNwbGR3MUV5Um5tK1Q5?=
 =?utf-8?B?d0tyY1dTWm9pb2FuUTYzWmozNllMOGRPME5WYlNOeDhudFBheFlPazhiQ1J1?=
 =?utf-8?B?MndBUHNLN2RldlhrMXNlc3B4NkRpODRVSldDeTUvMEtWYXc5QVE3Q1M0bkFH?=
 =?utf-8?B?V2p5VVVFYUh4UG1MQzVpczh5bFZ0S1ZieHZ6SFNQZlNiTGlLR1JDYlVTaGpr?=
 =?utf-8?B?WWtoYjlNWU9VcVVtd3YwTXF0RWpRZ2dlMDZPaEltYy9nQmdFK3RqNkd1aVZ2?=
 =?utf-8?B?eW9BdUYyTGlWM0VkMlZrS0txRGF5aENPbDhWeHM4WTNLWVp0MUU0SUFCc1E4?=
 =?utf-8?B?WHI5TDV2eUdPdFlNWlpZbWQxaFBJbHpWbjdqTmltdTNsTDV2bVVOem03SWRT?=
 =?utf-8?B?Z29ETlFEK1FzTFZDeWx4TlBES0dUNjg1UEF0ODFCc0dxNHZpL3lreDFYaXV2?=
 =?utf-8?B?ZGhFUUdqVExjbWtxdUsvUWJXRWZuTkZ4VDgyclZkeHFXV1hMQS9yeG5mc1Jp?=
 =?utf-8?B?QnpJTmdaTVRYaXVJWk9LdXppdFg3TFpyaG1DSlNRTStaZnAyU0NjTXFzWEI2?=
 =?utf-8?B?MzcvV085Qm1xYzQxK1VpSVJjdHlVVGFqbWx2WkJoMmJBZGtWZy8vdUU0RGFU?=
 =?utf-8?B?d2lDbUFsbFVUODFlbTU0UkZNdWpJcXNhV0RCWU1WakhwY3gzdnJXWHNyZERx?=
 =?utf-8?B?c09FZHFQMHl3ZWhHS2w3akVQNjkrc0l1T01XcTNBNzFvUjdaRjdOSjJkWVg3?=
 =?utf-8?B?Vi9uTGdnZkkva3dqcGlkUmxDYkhDTFFIUkFWTEFqQUQvdWsrcDk4RjdDSkN4?=
 =?utf-8?B?UnVVYkMwczdFdVNzN2gxcHpLdG0vVnJHU1dKbmR1bnpoR0JGeCs5NkZvRUZZ?=
 =?utf-8?B?ZVJ0OHUxTGZQc3dQMExtQmhtVSttdVJjTHJib2dxQlYyY2NHY2Y5cmJMUzdJ?=
 =?utf-8?B?RkovTTIxV2Q2OWQ1dnpJc1BkMWs1c0pkUHBYQ0o2ekduckdYMUxXU3BkbCtD?=
 =?utf-8?B?L2FURzNhK3pVeDJHVVRLeno4OXdSRTBQWGFYMnlSaG5BTVRUS0F4eUg5L3J1?=
 =?utf-8?B?SjlMM2llZzhaaGI5VGJVUGFYNWl3azNNV1l1YncrSk12MTZIZWllanQ1RkZZ?=
 =?utf-8?B?YXhDSExkTVJQOXJhdWtGSXFXaklTU0JiaVFWRHg4eHBWd3ZveHIxUWN3UWlI?=
 =?utf-8?B?eFhjNnpabHpHZkFOdzl5djdrRVBYbWV6d1paQks1NEI0djVQM09scmorcUUr?=
 =?utf-8?B?M1RaUWlobXcya1lhTTEwZWZZd2pDaVU1alVDTkdxc3RENVhaczFqSEROQnM4?=
 =?utf-8?B?V2JOeWpCc2ttSlh6eTQ5K2RaZjJLbEV2Um1TVlpzcXJWSlVWTHZDQUNPbDl1?=
 =?utf-8?B?cVhtSHV0UWZZMmpMMTBmK3lpNm9SR0ZmRVNGcjUzYmxMa1UrdWlvYThFN2o5?=
 =?utf-8?B?a215aTR3YXFuQkJXY0E0OFpuUWdQcFpqK2hMQ0hrVTZWV2dGUXdQTGZaUTBt?=
 =?utf-8?B?QWU4QjcxYmg0UStVdC9KN1lSV1VXSUFyYWtLN01Wby9naXV1Rmw4d0NQbUt2?=
 =?utf-8?B?VDBEVm41RUxxSi94S2JLZHpqWXRVNGZnblVLejJaSnNGMnVQQzczT0tNdjNw?=
 =?utf-8?B?UFBWdk50eXUweDZaZW5PcEtyT1BSOFlucjlFMW9RRGZCeVdxWWdkbDRob0pv?=
 =?utf-8?B?aG5jdW1DRnpmTjd5ZjVLakgyNjVOeWEyQUlmUGt2VHZVZStDbDVCUjNyYUJ1?=
 =?utf-8?B?Y21lTmk2Y3I3dkZ3OGJBTVFzRU9TL0RaWEdBemtTcU1wSDNRdWtnOU1uOHNE?=
 =?utf-8?B?bnZiM09qN0FqOXlNczRydm1ncEVlWW15ZkQ5aHhJZHFGVjNHbGIrU2NhM3dy?=
 =?utf-8?Q?iXxuQj1+RKnV9+mn/Aji9cSZ4VxwAVdQUQzNs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2855e8-69ab-4c9d-a328-08decf2efdaa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:49:46.6513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy3xFBynaspXBhoA8SCCf7p7On+WcaSef/NZPBkMliovnNp2JplSgT/FNyCNN9/srhQYX2X51EXJP6UtFyukb2zBKPlLJcvkjhUP0NaiYGtySHxH6X3mtwR7gmWiAs2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
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

After reaching SNK_READY or SRC_READY, the poll loop exits immediately.
However, some PD sources send follow-up messages (e.g., Get_Sink_Cap,
Get_Status) shortly after the explicit contract is established. Since
the TCPCI hardware auto-sends GoodCRC for received messages, the
source expects a timely response. If no response arrives within
SenderResponseTimer (24-30ms), the source sends a Hard Reset,
causing VBUS to drop and resetting VBUS-powered boards.

Add a 500ms settling period after reaching Ready state to process
any follow-up messages from the source before entering low power
mode and disabling PD message reception.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 25ff0926cdf..d6af0fae7c1 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2252,6 +2252,16 @@ static void tcpm_poll_event(struct udevice *dev)
 		tcpm_check_and_run_delayed_work(dev);
 	}
 
+	if (port->state == SNK_READY || port->state == SRC_READY) {
+		int settle;
+
+		for (settle = 0; settle < 1000; settle++) {
+			drvops->poll_event(dev);
+			udelay(500);
+			tcpm_check_and_run_delayed_work(dev);
+		}
+	}
+
 	if (port->state != SNK_READY && port->state != SRC_READY)
 		dev_warn(dev, "TCPM: exit in state %s\n",
 			 tcpm_states[port->state]);

-- 
2.51.0


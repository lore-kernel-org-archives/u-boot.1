Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94870C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9C68309E;
	Mon, 14 Jul 2025 15:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QO7HIlIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F7083022; Mon, 14 Jul 2025 15:31:21 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CAB883046
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wokrIiNUcyTgxM/mhYGK1VQqcuD+ivl0N7rvdH2tmfEPgrenxjE9CWNSixVhcrohldbJDJoK36PHCcLiXlm7LMxPukdgFAQyTOJrwqGj5m4cFJZ+Ly/iz6Nw1HMvhPI1uAke/nWJK8PQVcTiHpx9YcCZEHpS7jghe7RB84q/HjFMQ5UICVBMg++1esDEQyPoMhlOLC57wVYPrnm6V8BfwfHW0M+oQDK7VEysf8zw/YJ3IqaCDSo+OAZN7WkBwYIrAkp6lp06yACX4zR+XVUQw6Ce+fqOD2DS/0sg+wt/GgVebqyGhewRl0DqbaumWPsdX7/QVLpRorbzFg4uvf99Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJMKKNdKO0yPGPntQ53b5ZYxpCVXi7W27rgKWw6UJ8Y=;
 b=w9AXhedL8XXi/h8iA1XTMsKHkXVjzUBF3xEfjNoYW5AbKAKJ0Kpxej9a4O9VE0eAyv/tvHrA3432r6bhMb3LeyeOWlqRJKjABG1ztgrTWdj9J7avOfJeoI5HHkYW8XPwFl8X6qE31bIXYvTDnPER71WNUo8KqbqJtzPQbqd8Uk/s/5zweU+2BIOzunzb3eluIuJlVPxtXBbPCC/6EmZyMqcQcx0RfuZwKUqSOSMypfHf5aAtOLN4ro6CvUwy33aXb5uhzb76YDnvzZLcPgW0lq+RW3CxysVcteHt3Ed42VpwHosGfjzLb1oMJNgxC89G/gSQF7Bfo0PLOmcj3fApeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJMKKNdKO0yPGPntQ53b5ZYxpCVXi7W27rgKWw6UJ8Y=;
 b=QO7HIlIbybsPd75HjfnbeNKoXp5xojBGya5VHFNYfORrpmUPUTbO2f/ANYmZMciI3Z7MzJOqKMgrLYvNF6aS8k87LjfXvfcADXmQq5KR4UTMVX1vh+VpQTkmOpaVw7rb9Dnj2RbrPB6300JT/M/L1ryLLYTEkOulfPgIlctGtPH1KtvIBNCZU2kJ23vlC55nlpdoQZf3Nlz8mHBXbD4csdw1UiU8lnA1sagXI5SkDsxstv3Bg0OLxAs/jkeQLcelhcmfc8s6UaxyAKnkOuWFZ6dmvzYJ54/YhmqSc7B/b6nEvtqdUmidEE0n69fdB3VfNs1ff8q5lOvJUiJmxg/h9A==
Received: from PR1P264CA0098.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::7)
 by PR3P195MB0635.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:31:09 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::6d) by PR1P264CA0098.outlook.office365.com
 (2603:10a6:102:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 13:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 13:31:09 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:08 +0200
Received: from [127.0.1.1] (172.25.39.83) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:08 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Mon, 14 Jul 2025 15:30:09 +0200
Subject: [PATCH 2/3] bootstd: rauc: Fix segfault occurring during private
 struct access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250714-wip-bootmeth-rauc-fixes-v1-2-69d2b80e7606@phytec.de>
References: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
In-Reply-To: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Wadim
 Egorov" <w.egorov@phytec.de>
CC: Leonard Anderweit <l.anderweit@phytec.de>, <u-boot@lists.denx.de>, "Martin
 Schwan" <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.39.83]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|PR3P195MB0635:EE_
X-MS-Office365-Filtering-Correlation-Id: 235c5166-d617-4cd2-23fc-08ddc2dab1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3lWSTQrbzU5OWxuSkg1aGdBYkJ1T1JqZ083dmZPc0FpR211Y21Nam9WTVV3?=
 =?utf-8?B?NGd6TituejhFb2VqTEJKRzBaTmxsYm1TemVuWXpscEw4NmxmbTVQeVhXeVlU?=
 =?utf-8?B?UUpMaGIzM1E4alQ4dTJYVGtMbDZXZ1J2Z3pXWTlQc21VeWdJN1N4R1dJeDlh?=
 =?utf-8?B?NkhnMDF6QlRJaCtTcUEyTmpPR0ZUakZ2UUg2RWJqaWFYRnNZdmZOc2ZuQ1Rx?=
 =?utf-8?B?NVNrcnNyYmttNzNxWWQwMjhFQ0lJbXljUVZPNndma3BnbzFBRTdqUlFpYjg4?=
 =?utf-8?B?T2xhZE1rWjBBcFF6YUVocks3d3BiK1ZPQlpsVktqQzdyVk5IUHF5SWl5MExt?=
 =?utf-8?B?dmw4ajN0WEptQnJZRkNoQXNiOXEyemkrR0xCdnJlU2txVGNzeGdnNE5vZE9Q?=
 =?utf-8?B?Q1pJT3lXQ0c1eld3TW93dE5zTExhWDNsSndzbHpLVnVYSnlCWkJVbzJHZUt6?=
 =?utf-8?B?bmVSTkNJQmZyV3NVWkprSHhPbXlGQUFBTWRMN2VXcTNsb2tNUWhYbXUxQmNu?=
 =?utf-8?B?TW1VaTEzYWRUL3J0Vjc5YVhnM3VzWGhjSHBQQUxtekpSUWxxaElWSlh4VGIx?=
 =?utf-8?B?TStXUmtQSjVUbDZvMnFSdGI5UU55ZE5TWlZheU9uVjJTS0JRQzlYZmJSYUNT?=
 =?utf-8?B?bTB4OEJORkRXcmZZSHA1Q3N4OFJzMFlSTTU5MWxNZlNJaERJRSt0TEs5S1JG?=
 =?utf-8?B?SlR1OFg3V0NjeEFjNHU4b2ZRYkdXZ3BMNkdVaUNvTjhualhmK05PQngwcUpt?=
 =?utf-8?B?YUw3SjdzSEZCbEFNcFVvMnhUUW85Y1RkK05neEVWL0I2L1NkQ0dJczZETDBN?=
 =?utf-8?B?ZktKbE5EZ24vaHo1cHlNbGw3VVA0SGYwV1RiOGs2eE9KRDgwYVVoelFoSURq?=
 =?utf-8?B?Q1g4WHhVNG1WVGJEamVmNG5IMTBLSXdkRkx4V0JrNnVINnlvZjRmejZINUdD?=
 =?utf-8?B?eWN3cDJ1d2RYbWFhRi9oU3c2S0h4MUVzWitTVEdXWDhVd01XZkZhQ0lzN0tw?=
 =?utf-8?B?blY5Nmo3My94djRKN2c4Zlo2K0tqenBBdGczdWNFOVNsZmJrZFJMVmNwTHRw?=
 =?utf-8?B?QWZ1ME1ZR2VBcjJzUVRXdGloUnEwV28wYitIOFIvdENoNkIxUUxQUFFGTVdS?=
 =?utf-8?B?VmFuOWtXS1BjMzZGMzBLOTFjMVBOd0J3cFNlSDlXMEowYm5idzdiMmxRTVVY?=
 =?utf-8?B?Y25wUzBDNmZvOWxrNG1QYkMrMUhzQ1JRbmlUVGZSVitKU0Y2OGJNWTgrY09I?=
 =?utf-8?B?OUpHZHFGWkVjUUErUVkyRVBCNVdqYS8vT3pRdzNNbkpYMTZHNTdLMnFIZTNY?=
 =?utf-8?B?UHBiZmhuRHNHWm9OYWNIUzh0YTdVUXhXcWpSdldUbzZ4NEZsWVF2eC9RRlpu?=
 =?utf-8?B?TDF2MUtCeko0R3h2enlqKythVTdQcEUxTHVORVQ4TlFSMFdtYmVJWDVraHB3?=
 =?utf-8?B?MmRwbFB6NlZQVEZDbXYwN2p6RGFQVmpRRE5TT2tSV1R1RC9rU29iS1FUem5h?=
 =?utf-8?B?YnFzZ2xZODYzT21BQTZBbjFZS1JvQVAzVWJBSDNLTUk5emk0WUtmT3I0eDJL?=
 =?utf-8?B?elVyL3JjaUZyaWFVc0xvaE9VUTBJdEVET2RHMzFabStiQjJlcGlCc1ZYNXRz?=
 =?utf-8?B?MGJvaHk1OEVjaTNYclBucTBTTlVFSzN2SU5QWFdDcjZvK3R1ekxhVFdHTnhu?=
 =?utf-8?B?NmJKNmVadlFqSXdRd3ZoMXJnZ1E5elV4d3cxZ25iT09oNDRiWlhsbEJyOEpM?=
 =?utf-8?B?N2F0anB5Q2M3WEVWMTZoNDQvNnlDQmJPYWFiVjVNcklYSG5mdHQ0VllGcDB6?=
 =?utf-8?B?d3dCeEVlT2NBWU5zV1VIU05hN004c2V5S1ZOZ25EWkh3b05Ha3VmTTdnNlNX?=
 =?utf-8?B?MDZTYzhhYmZXU3ZJaGM3MnBlT3dHdjVGQlBZTTJiem9YMlhDWjlyRjB1cXdK?=
 =?utf-8?B?VTlOS0xmZWN5NFBhUm1mZVlsbUhjZ3ozTk5VOGo2Yk1ST2lRdy9rNnY1a3NP?=
 =?utf-8?B?WUtHZjdEZlJ6WUdmcGl1cnRvZXBJYTRNMFBqYWFGR21hNkRRMGNDTU04bWp4?=
 =?utf-8?Q?bUe9nE?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:31:09.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235c5166-d617-4cd2-23fc-08ddc2dab1be
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0635
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

Fix a potential segmentation fault, by not accessing the member of a
null pointer to a private slot's name field.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 6abbd25704bdf218bb0b3a02306993584088d2c7..72075c04de1c609da21b0277acae413d97875fd0 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -180,7 +180,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 			return log_msg_ret("buf", -ENOMEM);
 		priv->slots = new_slots;
 		priv->slots[i - 1] = s;
-		priv->slots[i]->name = NULL;
+		priv->slots[i] = NULL;
 	}
 
 	bflow->bootmeth_priv = priv;

-- 
2.50.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065FBCDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 15:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C19287769;
	Sun, 22 Oct 2023 17:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="oev3EiIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEDC87768; Sun, 22 Oct 2023 17:18:37 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A9087768
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 17:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1KIRDDHJtGf+Yb+uarH+kLEdQPfrQBA4eop0gyC/TW2nCT29tjlXYK2A45MUjG7GSZ3sdbWXhiVGweK8u0vOn1pPrUelkQdm/3mQB3WmwFEqIZDtX+3ADvNBhe2P9bzF9oveI8ZsImBYFXuCkTN7DugAI7+toDOOg3XtBxEvODf32wNL5euy6KPoSO6U5q74tp1jYvfINHQYpJm2/8a9ueUlE1iPuHujqGzn9IWmcoibXJ/2w1DwHhz3zBGyKnG4pIlnhLPm+Kcrc4Jobxq5c7791lOhLjYMcRSJuS660/x2HvY3/YEcMABvB9E5YMmD5dGiVXvLPmA6fDNwAAt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzl5T0uTcoc5JNJLmm9RWzKzm+GVLkmaR90/qRDP/0s=;
 b=T7+ltlP61/EyHvI3L7otIgPTOuLFKrj8u2Pw2J0gn9U7RENgbKe51EOmHqbDLQThFpEzhPzlCaXGUvvL+u5gbWVUQPTWzT7rCQDV4WJPyqjB+djJSNflCaC6BdSI4INZGfikGAe8lBxY3olkCy4o3C2oK4TNG32cjbAHYf96nIz1PSaneYDgyVLJaOumUlf9bhPPjKoFmkrq//5ZwNs2bQjGGkteIjPJMr8NPLhKX7m+A3nlQcGJI0cWKkFbZ11Z8iAhFUZUS/XDFCXAOIatxYn/psNm2ok6fw7eNiKPKJkZiLGp9scc42l2Eq5uhBXG0XCfX+UCvQ2yRtJGda/RvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzl5T0uTcoc5JNJLmm9RWzKzm+GVLkmaR90/qRDP/0s=;
 b=oev3EiIwEKRT+PY6NXdB63A8Be+dyd7RZORUAd2sR7zGnwyrGFP9d0VxxlIOSP9arkNaMxQuzNx7ofQeru82s8Y8V8/WOS39vCNwx4JguUE51U82eFwb78yf8hzTGm/XhUCVuc/cOBcemJr9Lm1mjknxgJaOV5zWdYoyisg87jKGwIjGago4cwlicS+0qxygdfcuXBXweQ3UUgr8Vh77cKZupVHzrjJLM0Ha+FiuJUuiOVElP73+CqvPcwxkSkMnUaMBmKptwORfy60hMR3z67gt3qc0MQp0Cz/A6+z+zSPBfg+zAbMijVzi3v/ydcahQubbvcINdIccS6eAZy3JJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 15:18:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.025; Sun, 22 Oct 2023
 15:18:34 +0000
Message-ID: <d1d6efbd-32f7-40e2-8c20-8eac06bd6075@siemens.com>
Date: Sun, 22 Oct 2023 17:18:31 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] iot2050: Allow for more than 1 USB storage device
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c7d4e2-0a0f-430e-6ac1-08dbd31227e8
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1R1N9C4Q1exSSY8Uj4kudIYS5lV3kf6vSXmqqRBjr632qoOxO2ayibXMO5r4pk8xqJZ8PHWIluUx45aP/hm6VEvmZ2aA8YojX4riJ1UMIrh+RHrHc+T7y5V/WlHi3SKzsxdYwaS+zcBbwi0neMWiHl2IzWUYfcyc0/btPNtAs97zjoJklrCTux34RRUkM7yIymTN4791JKUMk0F0ogHsOklaDWvojNY4SCfWhL5wvcDpKCfC69UEDrxZTtH5RNdb2Dfbh+i499ry15dnNoRZrI33eFTjSb5RDu6xEhkrfUdzft8Qac0Qb3gdq7hw0uzw40wfap3OJ6peesuANn/6ZV9/wOA5mtTBXdu97ZQ+rB5Uk0YKRlZTaWqpjWFKN5qpQ7aFjuBuccezKEckZVEkc3LsR0tCxUlMeLxIo934IZkRSygyDKwm0MRmcS4SVhDuLCWvANZjkYmOlfX3cfDGEU1IbpAe5lF3Jy2/7ZsVKRnx20t/tFTRNCDKMawK9N2X9RmC9zsNBTGqP0pWYmEYykuAiThsqOYZcEh/+1dVBQ9nhX/YhozjIAjwm7qtplgH/q4UhO/oF/AiQ7eKp0mmEq58DIHdutVC2GpdiVd+gUHQiy2naNpsn6VMWY5hOK/AUTmz9FVqdbTLZoSUkrKxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82960400001)(38100700002)(86362001)(31696002)(36756003)(54906003)(316002)(6916009)(66556008)(66476007)(66946007)(2616005)(6512007)(26005)(478600001)(6486002)(6506007)(6666004)(41300700001)(4744005)(2906002)(8936002)(4326008)(8676002)(31686004)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smk0Ly9PNkIvRnRTMjdyQTVBU3lkM0F0eWxqZUJYS2RZVWdFYXpSa2dCNko1?=
 =?utf-8?B?OUN2UTdyaklQUHZBQmc1S004amhvZThRaHEybnRGZEFrdnJWZTZvR0JhVEdG?=
 =?utf-8?B?amdQU2FZaTdMYXliZjExbEEvSjJBOUMzRVJUbkRrL08vYUhmTHBPS1hLWThO?=
 =?utf-8?B?R2M4UjZmeFpzUnR5aHRJZ1Z5QWJGL2lnOTEzME5VZExsT1oyeTZYR25nRVlx?=
 =?utf-8?B?YW5hU1h3eVlqZC9kVXFZdXpnOTJMTkttcUMwT1BMK0xWM0ZYTFlVVWJKOGpM?=
 =?utf-8?B?SHErTkI4VlBNL0dWbWRWT29xeXBSRk5ZcVpVV0RiZUhxYVJjeU9ReE5nMVVB?=
 =?utf-8?B?aFRyWERhSG40clhZbzlvNWU5cFBCbm55Nnd4TUdFYVJDclh3TXhrQjdES1hL?=
 =?utf-8?B?RmRBeTJmVTRuNmppbXlEbmwvdDZPeVZtbllYdFBHdFgxckdwajNkcFZpUzVN?=
 =?utf-8?B?YTkydnZrNitGSnB2MDdzN3VheUIyRTVjYTJoKzFpd0tNaFZYSUN0Q1J5dmcy?=
 =?utf-8?B?dmhtQXJjeW8yNzYxYjhLbG4vQkZZcWhqZzhUcjlBcWpkSlFwYm0xT1VGeXEz?=
 =?utf-8?B?WUUyNWhOYkdLL2o3Ymx6MzEvbEVOTW9xcTVxWVFxWjdCYldmSXdPRWlndEZq?=
 =?utf-8?B?OGR1c3JsQkNNZkt3aDAvLytzRlh4b3Vqd3pnajhxc3MycG56alRRZ3B5NG8x?=
 =?utf-8?B?L0cxK2ZBUUVYR2gyc0tsVTI5bEVtWnZBdnZEdEtWR21SUHdTRXluaHFsNlV3?=
 =?utf-8?B?U2taT3RrMFNCOC9DTWVLWHNjMlpJMDFZT0VGRXRDcXRpOGNVaGJzM1VwY3Bs?=
 =?utf-8?B?RllWekVkWWxsaGw1b254aGdaMXpuVUVoVGluZEl5d1BOeXFOL3BuMzF2OFRE?=
 =?utf-8?B?REZuMFYzWVpKOUU4ZnE3Mk9udzg1SVV2eTRIaXNWZmZqeG9yN3gyRWNqYzlr?=
 =?utf-8?B?T3l2OXRuTCtzamNXd2VRYkNkZG1SU3NJU3VWU2Znd0toczN1elRLWnNjejBH?=
 =?utf-8?B?ZXB6aTIvNWJ0TE1WTE40VEVzOXo1OGQ2aEl4OXgzb2ttMSt0OWxCcHhjbzls?=
 =?utf-8?B?RkVsaDR6RytHa21SV1RtaTBWTVpqbXZjdmFjbTdzWUV4R2JYQ0YzL2lBOSt6?=
 =?utf-8?B?ZkNqN2hIUlpmb1BTN2o4MDNSK3lNcDZtZHVaRndYMjE4ZVlDNG5sSm1iZjQ0?=
 =?utf-8?B?S0dTMXpoa29MR3JjQzJSSk80cldYc3VtOXIrK0JWcjBNS0xzb2h2L0gwVWxS?=
 =?utf-8?B?eUtYUkM2YXI4aGZlQkdWVnBSK2tpZ0VRT1BBNTR2Y0lacHFsd2o0Y3pKeHF5?=
 =?utf-8?B?dXVSUDNlWlZELzF3UW5GQ0UrSmkwZG85dWpndVJsU08wM2xjbHI0cUppT2xL?=
 =?utf-8?B?QnZZZllUejRtdnBBYkJyV3ZqVThXNThGZ3dZbC9TL1FqeUpPRG1pY0QyNHpV?=
 =?utf-8?B?dWxPbm90WVI4SnZIN0FmT0U4VGdEakhMSC85dFRiWFJhU3RkRDg2QzRYMWdK?=
 =?utf-8?B?ZUZXVjJOU1ZSSUxTREczZS90RUEvUDhKOGVNVFJwZ3hLRDloaGRaOHRYTE44?=
 =?utf-8?B?OTh3Y004bDhta0pIYmZkeEl0eWhtaEpXSTNYZzRpZDlsdnpuM1p3L1cxZDJk?=
 =?utf-8?B?YlJqSmdnT0RuMUtha3VwNGRMT0xVYTJiTDRWTzNEV005S3lwc2VrOGlxSTZv?=
 =?utf-8?B?VVFFYm9mTDZxU2dpdmVoMWk3ajFUc3VmMWhNb0hmd1J6ZFFzaXN1TjJWeHRW?=
 =?utf-8?B?ZDlnendwUUpDQitjNE9kVjFHeGYydWRPTDJraGI0MWZmeWZld2ZsVUNXZFA5?=
 =?utf-8?B?RVZVQ3dyMDdEQXBxZzJJUDgyQzRCWVkzSFYrcmFXTGxvWk1pWVV4YUY5SGpP?=
 =?utf-8?B?ZGFIV082YzhocUpUYStkSG92SVc2KzZHbStFL1JTSWtjVW5LNlkySTlYY3h3?=
 =?utf-8?B?aXZVNkErbXF5dU9pNE41d3FTNUMzL0lNL1I1aGs2MUxEalFKSG16dTl6ODFQ?=
 =?utf-8?B?ditNNHhGTWlhSkNBVEt0dXRtZnZqSWhOYmJqWjBSa2tRbVdUQkJDaGdCbVEx?=
 =?utf-8?B?b2JIaVFrUWMxT09jWGh6VU5aQzY3NnNLeUJJS3c4Q0tCT280WXBBK0gwbCty?=
 =?utf-8?Q?9HtDio7N2GakOzJTqsV8lELRG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c7d4e2-0a0f-430e-6ac1-08dbd31227e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 15:18:34.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naa8Xu3818/3K+LRRf7BubU/i+1x4tR2Tl2OdAwBdnHJjIiJCT0z626KrDMGYohTCb7hftbM4IkFQj78tDImrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6734
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This was lost via 53873974a4b0 while some users of the IOT2050 expect it
to work: Make sure that up to 3 USB storage devices are probed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/configs/iot2050.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
index 4968722d18f..1d444d02c83 100644
--- a/include/configs/iot2050.h
+++ b/include/configs/iot2050.h
@@ -15,6 +15,15 @@
 
 #include <configs/ti_armv7_common.h>
 
+/* allow up to 3 USB storage devcies */
+#ifdef CONFIG_CMD_USB
+#undef BOOT_TARGET_USB
+#define BOOT_TARGET_USB(func) \
+	func(USB, usb, 0) \
+	func(USB, usb, 1) \
+	func(USB, usb, 2)
+#endif
+
 /*
  * This defines all MMC devices, even if the basic variant has no mmc1.
  * The non-supported device will be removed from the boot targets during
-- 
2.35.3

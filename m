Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC63CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 18:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD590877A7;
	Sun, 22 Oct 2023 20:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="YOPlsjgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F6187796; Sun, 22 Oct 2023 20:07:32 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9093187771
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 20:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8D7LuQVoWCp/Z84t2lxwxP4GL1prBiN/gMUaL5fK3P0PXb31kMHMKfd/PikdofPcJqRj3f5mZAXJSlJ6fTXly5N+0jRyBjKQMArQdIcp5kgndbIDvQvLrwjnHgbjlCpfSgRGO2sGI6fUyIvV6XwNmMGw8ddlz2EWPdjwpClh36bOxka19VyRvQwY/ypzcm/l/ncYXkjLkFXq/J6AcpRp5TFv9kly/QZtl7d8NudKbMe3KyHGC4O/aKvKBHR3L1frQEYA8wZeyM207k8JCyYx2u9ijBZWNr6pnqsCW6ArkcW2//tbr8adLdQblRq7mFrRTJ5EK5Sh0iQrkONsoFPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxSfRVg+/KRiUa7Z8h5ezGPuZUnxGjYJlfoA8HCji+Y=;
 b=M2A2sjZUAT/6iJHJmaNvHTEBGbJaWX1mOPFucCLaLBCZ8bzns84s+ks9s0BMDWKz+QuIcyxZIOacrPOrwNip0BW3xsncbVRvw0jdqJx3iRLUsXtNu7nuyg1dQaGz0C03Fo1qiQB88ADr3J29AXCpwSfi1/1Us6jxZ6k8uJmSCtWnqeIOu6M5wDNI4yKvVy9rk/p3BiDyuOFjVYq3vaIz8zqCKqC5ool04S6FvRO24ef0p40Um57zVUZxYgDLf46qySAxdeETdQXMjWns+sw6P33KwY+NoF/JCzrq0bwhgkFpAS70kAC9X6SmcIETRXAEJvKuy9npMOOaBDUzQlZ6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxSfRVg+/KRiUa7Z8h5ezGPuZUnxGjYJlfoA8HCji+Y=;
 b=YOPlsjgEHGSUryUNJdHVTfVcE2EnuGT9w2xL6Sc/dHwWcxmqgx1xU1DPgGPOg7osLyeiB1/XycyzC6bY8m01vrSXJdg8Ezrmm8j/NDW6Q2yBAu3/qC9G4KmQ72mO1z3vF0vzKVc+ZtHM628rWVJRxA0V1SPVIrGspB0SsbeC6z43VaX629OyDweit46SlTTiwFUduL6l/5TkStyOrKdZMfKEp6f7NUcKPRsuZFujffdXTGBJCpau5mail8Xkk7KATruBRw1n19QGSa3G5Y2xEIheMvIGR+i04EGxpTSMpWeCuJLBjb0+HEKlGPDKG8IYZzzjatWHiJUq2W1yve3bKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 18:07:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.025; Sun, 22 Oct 2023
 18:07:28 +0000
Message-ID: <63976e53-eb68-4aa0-b407-2936e8d9f47a@siemens.com>
Date: Sun, 22 Oct 2023 20:07:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] iot2050: Allow for more than 1 USB storage device
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbd90d5-e986-4134-d8b2-08dbd329c083
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqm2K3H/My/rF27r+c80IbkkMbUUD/KivMQ+417AtJqhXoi8LsHV/ukpuozeOW6bHY/OOP2Wfp41nKMuGx5HGw01DPcyIh4lUVK20pSKiYeulxAeS6dqwkmmhIOe1z/+qFYGwQzpwQtpW3iuoseKbzQDzQEbRhJ1xcoSgWu0Pl96eBepTwkcvSQEXP9tpq9lxUeY1+gmVacQrheWQd5TUF/MnwyRt03Jy2x2H8j+d9lkDPwICyqlTakCWT2VkVC5Cf22mfL/LCd5ph4Mz0cg8P7dCqY53sszIl3bb5bq3iUbKp9de8KJ+LneRWmUcoxt5uArNfs1vkuKMZZZQo7h+9B7YyVYwQmZo5XJo0EvvfTzNwByCbKtZKukoJvu8cRjciKHeu89qOo6naAXbhO04jcp70mP5o0ykQpdqpBglP13ET1ZTLEUkYJfr8Broavk5JM/VsAdRfHFcLXeB/ggMZxQmNqKPVQUCqzi54wOUrOOUXKgV0eiiZFq8sjW+N/SjpzGlhWy9pJcS6t0BCptay/kwoI5vI57486u442ZbJSmdGlAiRIKNOe+KMKzyEk55r35UIxT8wcIgo2yJ/Lu3wawgLtC+0BJxIBzW9K0Y0Yrdq4VRgsY/80zcdy8pTK4veoV2sRmzVW9/IOA/EXzEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(36756003)(44832011)(8936002)(4326008)(8676002)(5660300002)(31696002)(2906002)(86362001)(6506007)(6512007)(6486002)(38100700002)(31686004)(6916009)(2616005)(316002)(478600001)(26005)(54906003)(82960400001)(66946007)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2o1d0ZsR1FCQ2FsSzNIS01Pc2RHem9idTVOSDZPeGpFQ0dwOU5NQzNHLzMv?=
 =?utf-8?B?d1Y1S0ozdjF4MUEvMmJqQURTTmpUTWlqUDlJQ241Ym82aWdIaDRUOXVWQ0ZY?=
 =?utf-8?B?VzhXZzIrelFTNC8zKzMyQVUvWWVsMWZqUy9yM09HVUZLVzhxdXFmM3VqdlR5?=
 =?utf-8?B?ZEtNdk5PVVJHUXpVSG5TUWl1WjJrM2xDK3ZYOWN0Z2ZkQ2pIVE5VaWE0ZlNu?=
 =?utf-8?B?NmUzVHdBMkxROUl2d1pudG51VSs4TG9qRVk5YndBTXdPcVhNZWJHZXY1VFNL?=
 =?utf-8?B?NEVZcnVkck8zS0xlTUc4UDJWY1RPZkZTUVMzYXM4dW9JdklFMS80R2YxTURW?=
 =?utf-8?B?eVlVR01TNUFhMzAwZ3Z5VWcycWJ3UjJzK0svRmtKaXpSbVdFeDAwVlZNY0F0?=
 =?utf-8?B?VXZzV1F1MW4xOXh0OU1xTitCVHpwSzMvbm0wMFMrNDdvakd3eFlTbnJLNVJi?=
 =?utf-8?B?NXh5QmhDUlg4VlpWMTZCRmZZKy9HL25hYjdnUm5YQ1EzOEs0b04xMEJzMjdL?=
 =?utf-8?B?bFc3c05hUDFwRTFSak5EOHVpQnVQc0U0NWpvTVZxaGdXYWRDd2ZrcTNxaG9m?=
 =?utf-8?B?YjM2dTE1MDk3eVpXall1YjlUUHQzU0o4cXp3NFdzWENkc0FUSmVSWStrVFV4?=
 =?utf-8?B?bklVekNuclVVcEpyT3dYa2tDa29LZ3BBSWpFaHBNZW0yY1EyRjl3a3lNRjlu?=
 =?utf-8?B?S29nblhzWXFFcjByOFdtY0xySnFXYytvVFpZYXFpSlY0dlo1aEw1VmQwcmhj?=
 =?utf-8?B?dUgrdFNickl2bkVrZkRWUWZrRHltbXdWeVRkMVpCYmFkRWFFUnpUOUNaZ1Jz?=
 =?utf-8?B?a1d0akRsVXROWlNZakZlSzFCNWNMYld4cVZadm1oY3BqRGVZU093VXhMQXNs?=
 =?utf-8?B?TGwrbVpuV24xQTlWUGg5RWhvVmVNOFRBMVA0d2U0UVBVTGZTb0cySisveTJX?=
 =?utf-8?B?aXlqbmtSMGNyMmk2bVJrZW9lcXYyM3ZVYXZkTFl6eWdkUGhjL3JqNkFKMHdL?=
 =?utf-8?B?NmNod3pncnNpamlOY0pjekRYZnZQWnFvU0FIL1ZGaG9Ud3JZVHk0TXNBSnFn?=
 =?utf-8?B?UmVNSGF2MTZRVS9xaGZkS2orYldoUFJrL1FEV3E3dUhsVmc5NVlrZURZQ09H?=
 =?utf-8?B?cmtEbDdNQmJSbHJxbFlMd2I1eUxMT2JHTjJpcXFObUlzdlhLeTdCRlBZYjdC?=
 =?utf-8?B?MllrczErNldRY1RBOEtWa21CcCthdjg0MGp1cFBaUkZ2dGs1YVFnSVY0V3Jr?=
 =?utf-8?B?NjNqOFpKSm55VXRvVUNVYnVTa3pUVFYxK2xrTkFibk8rZ1lFbTlOMVZHaElo?=
 =?utf-8?B?RU1sTXlubVlzNkZPYVlmbnFMRVBFTzdMTVlLMVZtYUpQeFhoWmEwbFdkbW9z?=
 =?utf-8?B?NDRRc0toUndDSC80R1cwRjJjNDdMb0ZQckM4VWhEdmNGWmh4clFEUkoya3Fj?=
 =?utf-8?B?V2gyZUhnN2tDUklQSUFVdmdGb0d4dEtGQ1ZHSEtJRjBVSHRhLzJTRW5GTnBp?=
 =?utf-8?B?Z09CZUhzSUxGYi8yRzVFMENqNEp6ejM2Yk1lQThaVEN4OFBUOVNzcldSZkxj?=
 =?utf-8?B?TUs1N1hKemxRYjdGSGhqenlqR0N6ZHdEQ1B1VlhtMmlDME1iZ2pUSWgzcnh3?=
 =?utf-8?B?eXRMR09nV1dBSmE3RHpmdVZiU2tsU2lDbDdNSk5NWjhmZUxPa0xGTDEzSW1r?=
 =?utf-8?B?UUpTZDYwUUtSMTZzemNlOVFGb3B6aHp2clozN2lGWnNOQ3hiRDRuNHllMVZP?=
 =?utf-8?B?UEc3SVZHRDhSRnBYTHhDNmtFYmRWYXZZNGE5ajhseTN5MXRKbnVSNVo3THJW?=
 =?utf-8?B?ZDAxbmowWCs3L3VJSmRpTVV2c1BkSlROd3NxUERwdVlpNE1yM09HMkxIdXdp?=
 =?utf-8?B?SUd3Zk9QOVNjL1U2QktIR29LQkU3ekhlRzdzNHhDd3h0N0JvUi91Q2xrcXNS?=
 =?utf-8?B?eXliRXd3bjZORzR2SFVvYXpXSEh3dGZkN3g0WVpHWE5vR1BnSWpjRFJqTCtZ?=
 =?utf-8?B?SnhxQVB2ckNUM28xTDNxTXlzaysrMzFSUjgrQTdoSlFMYlh6bVUwcXFEbW9v?=
 =?utf-8?B?ekRFQkswNjNKR0xXK3d5cEtKMkhrOUhObUpaS1ZHV2ZoQldEUkk0YnNNNkFq?=
 =?utf-8?Q?TSE8JIKMGsWlripsO6bPviU0D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbd90d5-e986-4134-d8b2-08dbd329c083
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 18:07:28.2853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWk0WAv2EjuBeHVbZYQp2hefQ9I/YV44bSz8Gt9oJZIpviVdDPp9EpcRmD/nMblVTSN7jT4vkVT0B7ThaQJQHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6230
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

This was lost in refactoring while some users of the IOT2050 expect it
to work: Make sure that up to 3 USB storage devices are probed.

Fixes: 53873974a4b0 ("include: armv7: Enable distroboot across all configs")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v2:
 - typo fix

 include/configs/iot2050.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
index 4968722d18f..94a9c767882 100644
--- a/include/configs/iot2050.h
+++ b/include/configs/iot2050.h
@@ -15,6 +15,15 @@
 
 #include <configs/ti_armv7_common.h>
 
+/* allow up to 3 USB storage devices */
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

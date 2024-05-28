Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4196DC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DF088489;
	Tue, 28 May 2024 13:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Zxwbv1pQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4199C88486; Tue, 28 May 2024 13:13:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BA288489
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOOsZYA6ayiP7+Cz8cFQlRlNyBPgehIGHttJOUau92588DO2zNL/rUpgfK9HReu/w+LRJsEmhonnD4OWi2CpVwkPEyMFW4ksS/HZWjXixWdSsIQGQRb3VuSUcfc9pH1pkUwm/6xPOVL9t1NogokESvj/tLVcd4zisuKh2LMdvxnUJrlYv4C2cN8YI3AIMLJjkxcIxe2pZrN1r4gZ5jNVnNdnnJf8EAX7wuh69SGkgvLkKFvMmoqMJvBUDoz9YrsxTG/aj8arvnxvjXqX8LArYspefW3Ig6r7TGS5Q71w9361QUcjR/u6GsgOSRH+ogHkZDGl0DWzxcrAlsvFVWn8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7okZQErW+oQrHBLID5S8qYnIgYar6rGEp/0C9EBxzs=;
 b=SvpUtLmp5nxKGaSU5WaKF5tXOZ3NXXckIAA2th9gW8ao6TrU60YLS6M4dhQ3+Whc/Z4KgK8q/yjskBTG6lAPTr4y1dhV+rXTGcgNxarjIBoPsELar2zO8rJ0UOSu1Gflw7Kc6fyP6Kt9ixEozhQq3yfIchAVpTqtZmVmeYRdAc0GZ/AX2oBvNk5hqMo0QFLoDwCGk+CmKhE+Ji43nmwKQPROMCRBEfmjFF1IiUuZtYDEmuz6GDJ8GAH2PzNhMaPDbIn0Brt/vfGwyS0Wh5znCioZuB4cXWUfTmQ1qBghsqVCE1HJKlZiSf8gysVFa6XZDJNcBTSk7yk94LjTSEVhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7okZQErW+oQrHBLID5S8qYnIgYar6rGEp/0C9EBxzs=;
 b=Zxwbv1pQgLCBmMCIqp1onGPsh2adS1S74lfC09KAzfNixOoyY4lq+ClKu2WnTTh8KCijJhInyNCD/0k4YEUVGZfzq3DMsbmH7pYO6/n50QgI4/jxfMue1UT6AXPWkmrFPdkmyJgp2O790CFSrzzW9nbbT9/ETnvF0uNGoqgIGZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:37 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 3/7] serial: ns16550: fix comment to mention schedule instead
 of watchdog_reset
Date: Tue, 28 May 2024 13:13:21 +0200
Message-Id: <20240528111325.2163560-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1ad6e7-410e-46f5-6b9b-08dc7f0738c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?abpiZG7LTqTnCobkxOmVpLyd8laEU6V4ycJs64W1SYbwQfZSAwNCQiXjBYcg?=
 =?us-ascii?Q?2sot/IgTeSbMuJZhJH2LadjCXNrqQuwnmaxaRzasDjyDCQAhW+pKpZ38wySU?=
 =?us-ascii?Q?lUK21bpOHYsj+mJuQ98fPLK8yjkE4jlJEpf3i/T8nmb9I+8ZheMXPZ7kqV2N?=
 =?us-ascii?Q?uHYPYC/xDMX3WEHb4yYsv+9S260CpIzRVB53r3faYcUb0qiFBaenz68U6HJZ?=
 =?us-ascii?Q?GulIllKIrBVPX8M3o7wckCv7ettVNxOz+ZwB80b33jie/N9JIpjyYGg+dVKY?=
 =?us-ascii?Q?Kx6UBKFGrPSzD2Mj8akoauiPMdqut/xoCUXr02xCUKgrBQsUbHSFC3TUeUah?=
 =?us-ascii?Q?/NfvQ4tSjJjOgrsqux0lZCKL9TcFxHBItQmvaX6hRZhz0q1jXrpCrrr6Ahui?=
 =?us-ascii?Q?j3Nk/vSdGiZsZy2CxnS1a3+R4SYVOJJufddBzj6iFTW5ZR0zFK+lqf2AAqoO?=
 =?us-ascii?Q?q6efIwkF2BXs1TKbiLTY693j2xI1EQeJfS+admFSewz0MgyOCch+d9zNJKCP?=
 =?us-ascii?Q?c92TJX5EwPy3Lc7V4928NumgxMFNFVf+Egyvp74Met7TUm0RfI8etkEDXYcY?=
 =?us-ascii?Q?p4kLK/MEbh9TmICyS7CPhfVRwlRWAa6ms4jFjjLg5oKM4Gnn+YGcxG5YHDVL?=
 =?us-ascii?Q?/9AbXJHfA8644lZ9Hf/75EOaqQ/TwOxRS0zF9kf7b6BUwJZjfLzvuaV4598W?=
 =?us-ascii?Q?qgnGXTMIQIVOsb6a4mh5RNhmUPVE31QubOXs2zkNbNLt6qRKSQSn9QTwfRUO?=
 =?us-ascii?Q?8uJZVl1LNuXnE+WVkMFhCAHfpLEcTP8YTKI78ZrIlZGmfPuLFhw6us10rlpn?=
 =?us-ascii?Q?G7xbWeNMFMyFAsw7Yu+m0O9dAQ3XqmwQeQ1rYVcf/POgZsSrkMWe/Urdx1yu?=
 =?us-ascii?Q?o2VNjAcoWjOc6UVzGs2ex6WVk0YV2QVrnffLtdRrpQLUuB+lp2jsi+L/dKuP?=
 =?us-ascii?Q?32dGwBV2eTqIq5mn+Q5d+E9U6n0msAS3z/QPSFfAL2C4lSVkHRcrTp0hoeDo?=
 =?us-ascii?Q?asxWEYJwWdVbnH+jGabnuewDG9kMvOuYW8d6tX1ZJV0v+v3CedcszY6OckYH?=
 =?us-ascii?Q?lX4cgceMbsU9vh/q2+FatO82Rt0feWy3h87zzu2eQDmcI3iUWCIZTg3hULwD?=
 =?us-ascii?Q?yAbC/AbJx6YM5P3wIUHYLnbUgntUIrZoL1vN3PfEB+hSGkkLT+XhpTouKlw6?=
 =?us-ascii?Q?IK8YqXCsPNgdtNgftOL18Ryxezk465eNBsCvTw/StBuIb5VxoeuaVMSVzUoD?=
 =?us-ascii?Q?KFGEE+Y+QgskI0diVKA6gDl/FW6Yprzm43IlL+VVuSmgzYFXtnmp+xzI1D06?=
 =?us-ascii?Q?gw15y7sm8MES1Eed4tWrDHnfE2YMCeGVYD/ZDVSYV6+0KQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hh7nEx10zDrAhm3i+7y8/+bfDwo5GbOW8Z9R8RzAia49D4Br8tpatDnWEAPW?=
 =?us-ascii?Q?4u1S9QD3W08czFrKNPY5dtKkqXVA3POhrofv40bcim506M8Y0HWeuHTTuJMQ?=
 =?us-ascii?Q?b4RCK8HbYGqiLMrzJPfQfC9QxT9F1ZiT2MZdaX+4KnvBpunieD5Xptc1pman?=
 =?us-ascii?Q?24QYUPJsVfm69MugMNT6hGf7lDVYrbWHpDjqrCxtpPSvvXz+Q6XBpUSLTJwC?=
 =?us-ascii?Q?c28F0uK093j4fbBwH3xKUriIhGZZZUVWjXg5DtXkAlWgchBFHMhJGpAuSypy?=
 =?us-ascii?Q?YptM/3322PxAcFMWuM4iATazQmT9T/9MJ8mqHZV04ee1ZNMcIBAiDbsnPigN?=
 =?us-ascii?Q?5Gozmt86xPucWQImz244zl4eOOiJV2WTTNWMjfBWeJuQFOVQ7BTjqHcuJKCS?=
 =?us-ascii?Q?1F+E2A+/eX44Uw+QljF5RjHbYVAGaIk1Ee1El3KxLyYunUiKHf4K1B3oNE9F?=
 =?us-ascii?Q?iq6dSM3KDfsa1EtiQx66JdL5BkVEL7Mrbz8gxdU2XkWqU0BbgR6R4wxPYf9F?=
 =?us-ascii?Q?p5N0FXmsa25gWkC/7nf9DfkcP79qK1pceLmwrgvEZma+QF1OvU3uwlnSrmw4?=
 =?us-ascii?Q?Xz54jj7dNyArNGfe4hvhmA5ll51iGRbhT9Od4mBTOz23Oeh88haJfIfnz+9p?=
 =?us-ascii?Q?pPe5bURG7eVfSs+1IJIDYD1ykk0iHLmEf/iYmdRJYIlFrZMMXBmu3nHlYBjl?=
 =?us-ascii?Q?AbuDorX1rDQlOW2I5OY41jXciJ0X8VCO+aeiQNgDBXt5T2P/P4apkHBXDRhZ?=
 =?us-ascii?Q?l5vRdM6mVEVVtAWIKim+sZFOhUKWalvadqToBANdIjANwlQCECvmsEgtyqvP?=
 =?us-ascii?Q?fXS2vLhfD0X/jWh04+D08BOSZowSQLcybe4BqVwdJHOrYqrbNZ6W6AF0A3aU?=
 =?us-ascii?Q?/fZzV2usFRRuH9Jm3PR2+jB290m4yCNyPzgzMg14fGmYHTqIxj8BnVOlGjZb?=
 =?us-ascii?Q?cxsjKV9WInQK5xhn4huyvLIvaLCAcFKfrNpw0r3FBTlPedzgzWyteNrJyzQx?=
 =?us-ascii?Q?jgjgleCvNl1jGmdQwCzQSvrcXQPbfVDad78Yp0SMQM5Mljp3f8XyA4bLMqbd?=
 =?us-ascii?Q?vbvv7jyO9ynElLcdGXjVIPSqEQX8383jC8yOpQODnkAaNe7+s+UQ0guQC6zN?=
 =?us-ascii?Q?D64cMAQXTWp90DPt/e7DTFfbxQTPbNZjyhUmSu+svVVskBGrGJzgwNfsjBxK?=
 =?us-ascii?Q?11awdZyKBdtDnSvKaWcCmO1h+d1Nvbd0JSiKhDWGjKA9cAGu8O37JLDYlRr8?=
 =?us-ascii?Q?J7YcXw5w8t1gn/9J1IBHLeVCaLJ6fEVd8o1MFmezjb7MW6K19FqTpraNLHMJ?=
 =?us-ascii?Q?HefV+ePz7RrgLuPJj4T8GSOO5IQUM/5oejAsYS52UZBsO7BDtjqRoNeD1got?=
 =?us-ascii?Q?+Y73EMtw2d2NfbvE0fU/+bqQ2GkKYzvjBQRlogwCYHACI3qAE5dhZdWGJO5b?=
 =?us-ascii?Q?bvDF9K9DXzgeW3SJo9vTHfrr7mtgueohrgwbVZ0cMLc6Kv4q5FX7okQi8GBI?=
 =?us-ascii?Q?KqtXeVAqSsP7R5j0no+4malCfdzQ1qzoamOjqOA1j3GrALWCUnSr79nIcP35?=
 =?us-ascii?Q?ys0ZiN/lDpXyUEVoICjrZ3LqLAYQ8ZbFKcFqVJN2DWnigrmZRkkOZHPolaay?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1ad6e7-410e-46f5-6b9b-08dc7f0738c5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:37.4803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6gZ56orFDlrR4FlUEluqnZNWWZWcsmR7/zjjlRw6wC+ifhP8gFBnSs5klD6f7uSHOCO9MDaVHFitNpU8QFloTrPVOBugFwhtO6RCCnBunk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
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

watchdog_reset() is no more. Make the comments match the code and
today's reality.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/serial/ns16550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 6deb1d8ddc5..2119eac15f9 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -291,9 +291,9 @@ void ns16550_putc(struct ns16550 *com_port, char c)
 	serial_out(c, &com_port->thr);
 
 	/*
-	 * Call watchdog_reset() upon newline. This is done here in putc
+	 * Call schedule() upon newline. This is done here in putc
 	 * since the environment code uses a single puts() to print the complete
-	 * environment upon "printenv". So we can't put this watchdog call
+	 * environment upon "printenv". So we can't put this schedule call
 	 * in puts().
 	 */
 	if (c == '\n')
@@ -390,9 +390,9 @@ static int ns16550_serial_putc(struct udevice *dev, const char ch)
 	serial_out(ch, &com_port->thr);
 
 	/*
-	 * Call watchdog_reset() upon newline. This is done here in putc
+	 * Call schedule() upon newline. This is done here in putc
 	 * since the environment code uses a single puts() to print the complete
-	 * environment upon "printenv". So we can't put this watchdog call
+	 * environment upon "printenv". So we can't put this schedule call
 	 * in puts().
 	 */
 	if (ch == '\n')
-- 
2.40.1.1.g1c60b9335d


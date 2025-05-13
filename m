Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCABFC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EABE82A59;
	Tue, 13 May 2025 10:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Jjb3GFPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A0B81DD6; Tue, 13 May 2025 10:40:47 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A2878295C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmRUW9t8NepVg4LwWuSHcfoJKhEUPiCh+D58fTIgRM6tFVXm4LiWOYMU08R2nvCNW0nzfIqZxenkJtPu0DiXhBjqi2W+2nev7KRyf2+PmCWlc2u94tENajkkQd9wFfT4NRliJh26sqGyMyZ8RxiW15EktT7+Xs4lHJjmewpVrjgr6JZocj0v3Bn/orj3xNwqXU8wJvjbjDRtKri+9+Cls0MvORGPurtrZ2oZEBetyZ9mrHLT/wyd2hC5BTEfteFeFcKhEROm/x0dZSPxRl5vtKpJZA/SQAVSagdqjd9SLAZisk4cZXS7baKU/SZXbPkLSkRC/wjKd0R7W1MywpjsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVJTMpu63qYG/JTyrI4yYI1TcnDDiearC/ulHgU/Zos=;
 b=DXvKisjBDmB94A2HMKKtQvfoYMJhDrywzMC+RkfVDaOG0N9ckmZsl8gECINov8M9cnhf379HavWL+XuwKN5urSBQ2XbBKvTZUieakR5g0OxOCXUut18dCV5AOOnYF974/E+Dfu5cnlfN+FZzwcMqeosew8DV316bOLKwfwO5lOalikimlw6sxusFKycnjSVCoHCj1KBqQnVZQGQzeFhT1tAAiETqPoAf7moMq6FFU40Vb20FJL1MaYaGWONb3YA0TIexjsZW12w7p13Wx1LIYEHxHgApHxuRIT1srum9BnbQxKdWIYspQOdEjgGJkA2pD+gs6jVOa/LQQPqPfbl5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVJTMpu63qYG/JTyrI4yYI1TcnDDiearC/ulHgU/Zos=;
 b=Jjb3GFPQUlrCeirO/nZiheWsi0yNOa9D8YKb69Rly7KbuG3L1Blaok51fYk1JoprpIJv/I/5l+rL7RhH8gb3exKlKFI3Y2Fih0ctYNA/p70Boa8zUIsI7SJ3W/xCUS0tZXRFA3Ekf4vmlk/czd/vWUdxPjkz9lpa49AAT+uDw78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:43 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:43 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 04/12] slre: drop wrong "anchored" optimization
Date: Tue, 13 May 2025 10:40:26 +0200
Message-ID: <20250513084034.654865-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a400e8-c9cd-4c83-34ba-08dd91f9d8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSTjQ4DROFhW5OmwwEhIQM/hl1NKXNLMZzmQVAExR/PVGxdWXYrhkJUy8yu0?=
 =?us-ascii?Q?c+pEjyMYv4ielMSqI/qYqW1CZDAA201WnoZrMfWqsWA/B/Tt3tMMu9yfqlgp?=
 =?us-ascii?Q?0NC+a16g/UDW2lqe2GiWs+gfZDYCdv2n/LjG7DcZA1COSyg4KCahoIG4wX7q?=
 =?us-ascii?Q?8oqNNsTfgG6u69fLmh7kMgRPcJvVeF9bcZrI1knFTmXP0yQW3F1Ir3nCSKyw?=
 =?us-ascii?Q?2WvWeSpxetTc1Y+WNVZ/jHvROIL+Mkti+EKKvU0I4tWuQl0LKAIbTcCbvseH?=
 =?us-ascii?Q?AaFFaJSAladSmCcKqZWNqf98akDVV/3sPXSQ4eNLllSp7Q2zqe3zVOZougQL?=
 =?us-ascii?Q?OVPgU7qxDJvH63UJiEFD+C26T9G4LWArRf1izprn92hPMbgKFFwZHY0FCB0n?=
 =?us-ascii?Q?t7ZWmsMF5zIXzGj9P8QuVu9N8DmTF/9f0NpY6wpsBq7CvnHlfLTPzx3WzWGF?=
 =?us-ascii?Q?g/76KkUZqsYFiXeoty4pz5jKpTSQvjbLP+3Wr9BgEs0szP5CpOqnw38YFK7n?=
 =?us-ascii?Q?ZQZLC1SVrz098dloctEGT8ex9LCvIfTHa7P7gINNPzvbeCpy56dj0IhCBKHO?=
 =?us-ascii?Q?v9P2Npy85kwD5bOq58PcjLZCg4bnzKl4qGXlMiDfnJUAjUJZA0QaMcxy3pOP?=
 =?us-ascii?Q?2d2GwnRS3QCrvmIeAket44dO3q+1sIxN3O7/NdNa1QZiVgke9zKB4wO8TVh5?=
 =?us-ascii?Q?AmvuiHxEMUd/tiJNuZl0eKT3s33u/hash06LBUC8FsTCuBt0YficQPZnjc0c?=
 =?us-ascii?Q?dvVqfX/1QwnJSBRzANbyMgauwGn6s8vZBRQxcBomDzpAwOzjtlJTqNsWuyeN?=
 =?us-ascii?Q?oEum8Vh5fpEa4FoXPLya6VKWTlNDUPI2NlpWhRxZhzRI/1HRSlbeTd1jbqNn?=
 =?us-ascii?Q?RkWxkTHrIwbhk+4Ph5+h0K8xgabJnpcd2v0Q1uElNvwTAdAsTCXToHwgv1FQ?=
 =?us-ascii?Q?QHP3jfjB2kQtJbCZakqn2yAt/RKvwYbkAB0ezDC+0ORL4eGbAuZ4ul01Ca/y?=
 =?us-ascii?Q?B7eTiRVg9NlhSau7/uTnzyPNTJZauLKVWsRUg1TxLQvYhKV5O5+veCs9L+cP?=
 =?us-ascii?Q?NEzTB5TTrbIsbUCrY6hpWMPtY++4lxlsSCFIWoa8s4aHO5WqxEj5uIb3Pgk4?=
 =?us-ascii?Q?FdWeopclpXjniy6p4tCRD1UzzjjEnfivCU3H1ZWCkcB3Z5mF3hvH/20wQFPF?=
 =?us-ascii?Q?MBYZyRKzKYUvlnvVeToNu8dVIiy4FFcWF5YqKOYv+4/hTTgA5XG0BWM4HnnR?=
 =?us-ascii?Q?jhuTudZFkLOtOIKqLNV7yWlCX+0Jft4aKEvoFwIjyMYEDAd4uhvtIhhW9/JO?=
 =?us-ascii?Q?ZvgRoznHWIYXrQKbtn8van6bjE+5bA8PporHSrNoZbK2gaspKWrqkjw5LwIG?=
 =?us-ascii?Q?MbIaYs/btVHwdGa41KZ7JVwEu753W3+BI6piOJbKyV8JnIIW06fR889U9RfZ?=
 =?us-ascii?Q?deEquAWnRolagwZGD11XEx8MdOpZDS+jeiv3LA8rSKK7BCLNsGD7Eg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lkw8f36iG0W58yIX3ErMu+MlHa3VvWpziHIBQpfVS6QcIF1evtYYQXZ6nMhQ?=
 =?us-ascii?Q?EyxOMjp0nACzIpmMeW39oC0SUamYULbLV7uNNvaQ7e2oiMoQhOSAuoOOrQFf?=
 =?us-ascii?Q?pUKPXmUKWw8ijwYurFnS//japV/PdD8cTv5jBkpABJc5CEyppNq+JqyHelpm?=
 =?us-ascii?Q?9dNoGl0g6gn6Ed5C2Lpj0ay/R9iEzH4GzxY6BqAAEU1mvjXWIGf09H6HqhXn?=
 =?us-ascii?Q?+ixt2mn9Gal7BxPztH+DaG2ef34zqZk6SsZ37UOo7Teg4f9nlGA01pfKms99?=
 =?us-ascii?Q?wITXA+P/rkFJSk/TQWBhnq9MOTCosmFidz8PQCIDHDlzFgYWo3L4RV8DlVG1?=
 =?us-ascii?Q?Pt+pL1ta/sgYUB57clDyJXamd+uSzPuXcYUzrUCSKJugbjgLNYeMB44sQaZx?=
 =?us-ascii?Q?KlV/PYVeWYiZh0t4ErfzCFz6TpJVKvEgZa4XDg3D36k4x52zTp1Gr8nFjUR6?=
 =?us-ascii?Q?lV11OGcBwo8jYpWWNHhiQifd+zB485V7yBUNt9FfF8tQbyfgQ8poRTmeIG13?=
 =?us-ascii?Q?zhvT7SPYy9xNy48jLXBnPcrRVM/nnhb/YYOXLTlv65AT+Tdrqx2TxwA5CWCY?=
 =?us-ascii?Q?f879HkPbrSGs+OF9PFTv4c/ito6+d9PjIlmU+qgqXaHMx0n00m4T1FLD8Kyd?=
 =?us-ascii?Q?+Hf+CSu2br7UCJI+xAA/Tm9i9Ev9+dYlMtg5W5R7GObYoWEe4w3bHAC54v2y?=
 =?us-ascii?Q?VKaV2PM20LZmOsywB+DL3D3uH8cjnZaP6YcdZ2K7QN92SMEvYmtU8vmBkDhi?=
 =?us-ascii?Q?7HW11tTICxvaBKjjxFlVgmp6Lny+l5Xsb0uBaKcsH424th/y/ZdnMHeq5VZy?=
 =?us-ascii?Q?u3s37Apo7/1ZsKGbjAo5xvW2/Udb8C/T3thHzTK7xoGdWTfwVKg/NE/1eng/?=
 =?us-ascii?Q?91+f/KY9fCCv/msTn4X/CPS3BYH6/l9/wxgoJNFr3HLbFAUWBV/L4tO0VB8X?=
 =?us-ascii?Q?1twtlGF7f/jmofcC2XB/b+jVBqjknpuNTiJ02Z8LIte+MJZhSAvefBKG7YeR?=
 =?us-ascii?Q?yHm2qbgllvNjhTUnb9RGIqxnmzwtm+vt9bZf/9PZEgz5pbky5tuVFbc6xXcD?=
 =?us-ascii?Q?NXzw4NnfOA3Q9JOur/Gy+jE+9fcwizTU8aIJcBQ4N5rtFz8vTBI4DIDUOxPe?=
 =?us-ascii?Q?ksHSBAosTlgIIosippYTJGa+RtDJvKtwgZmUkQEvjwcVpXj4ufHFmMTnwxwH?=
 =?us-ascii?Q?QcLrJbyR6VYGf5MQGEh5Im4pdhSgUMm/ForYAIVoHl/p3VKtIQxu0dVXbi0G?=
 =?us-ascii?Q?qRMtbDzpzyoRzq/goYdjo5tf5BiDQ/wXwfzuou1N63PbhRxYZ+4JMHLy4e/n?=
 =?us-ascii?Q?i+Pb1l03c6AQ7Dxu5JqdqiELg+645yAULnie6E87YjF0cPUQkNVxFH0WBoqG?=
 =?us-ascii?Q?7gsCzdCmpGoDXxAUwDPLs47PPrstJjMoPTn9j/2IPcrYe6Vq1HF22YlWOYRG?=
 =?us-ascii?Q?gJwFTzE6cIREICtIyjuRfwpr2TAMmT+gv1Eezm6onW8TjZh5abrsBjSXU59x?=
 =?us-ascii?Q?paie5wsg53UcvdRZd8Z1m2ftSYJcfBGUp/ZeiPGEwhHtkaD0+yuKZ2A+Yc/h?=
 =?us-ascii?Q?+8wSf3oBdgQrPZA/yJR/br7yb74aZynMwGIPlDiz95/ppvOwPcjjIft3gA+5?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a400e8-c9cd-4c83-34ba-08dd91f9d8e6
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:43.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mAPPYedVElHl3g+df281UvaAkrvOk3WqGwVgjUZXUZAz+EGGaBDpOYE4JT9BAaHynFXEGcO0RxXvKfkBsGmGANq25YO7r6SKg6FyKz3Xdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

The regex '^a|b' means "does the string start with a, or does it have
a b anywhere", not "does the string start with a or b" (the latter
should be spelled '^[ab]' or '^(a|b)'). It should match exactly the
same strings as 'b|^a'. But the current implementation hard-codes an
assumption that when the regex starts with a ^, the whole regex must
match from the beginning, i.e. it only attempts at offset 0.

It really should be completely symmetrical to 'b|c$' ("does it have a
b anywhere or end with c?"), which is treated correctly.

Another quirk is that currently the regex 'x*$', which should match
all strings (because it just means "does the string end
with 0 or more x'es"), does not, because in the unanchored case we
never attempt to match at ofs==len. In the anchored case, '^x*$', this
works correctly and matches exactly strings (including the empty
string) consisting entirely of x'es.

Fix both of these issues by dropping all use of the slre->anchored
member and always test at all possible offsets. If the regex does have
a ^ somewhere (including after a | branch character), that is
correctly handled by the match engine by only matching when *ofs is 0.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/slre.h |  1 -
 lib/slre.c     | 13 +++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/slre.h b/include/slre.h
index 4b41a4b276f..af5b1302d9c 100644
--- a/include/slre.h
+++ b/include/slre.h
@@ -63,7 +63,6 @@ struct slre {
 	int		code_size;
 	int		data_size;
 	int		num_caps;	/* Number of bracket pairs	*/
-	int		anchored;	/* Must match from string start	*/
 	const char	*err_str;	/* Error string			*/
 };
 
diff --git a/lib/slre.c b/lib/slre.c
index 277a59a03a7..4f455400d3a 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -413,10 +413,7 @@ int
 slre_compile(struct slre *r, const char *re)
 {
 	r->err_str = NULL;
-	r->code_size = r->data_size = r->num_caps = r->anchored = 0;
-
-	if (*re == '^')
-		r->anchored++;
+	r->code_size = r->data_size = r->num_caps = 0;
 
 	emit(r, OPEN);	/* This will capture what matches full RE */
 	emit(r, 0);
@@ -650,13 +647,9 @@ slre_match(const struct slre *r, const char *buf, int len,
 {
 	int	i, ofs = 0, res = 0;
 
-	if (r->anchored) {
+	for (i = 0; i <= len && res == 0; i++) {
+		ofs = i;
 		res = match(r, 0, buf, len, &ofs, caps);
-	} else {
-		for (i = 0; i < len && res == 0; i++) {
-			ofs = i;
-			res = match(r, 0, buf, len, &ofs, caps);
-		}
 	}
 
 	return res;
-- 
2.49.0


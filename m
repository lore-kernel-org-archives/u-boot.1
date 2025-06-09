Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F822C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C5A82B97;
	Mon,  9 Jun 2025 21:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cU5Uerrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45CE08007D; Mon,  9 Jun 2025 21:46:14 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5946582B0E
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpmQOtpV/ix9iGmttJFI3DCMtPtObmVi5NW4oi2F5sCx4RhU7qPDSsGzWSt2pFinnOzvg857DljcoSAEFXPT6vUUD7n7OhftYYHw5Ka4GxYUpNRE5/jgXGBHOw6x6oJCHgyc2JtkZ+NTJ/v001suAQglFQsjhh5eLPztBYxlDl78LYTsfcklZfFR16NA64HER11Vknx+ybwWtkqPpqc9gJVfCIXWTJUN+bSEDALL7/KOlmRkqUUzk7/FTT1MuHn+eYWjF9W4wn1SV33pJBdyuG7hnB7Mk5VxBkdQRFKAnyWvzmc+U1jv2lQi/n355TAjQh+INhFXNynXdMLGjwB7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbljTcmS3UGM9lIhUMPz2Yrsr38HFrNqK1n/j2Ca/eA=;
 b=eP2OeAP78ByFMkFdGlonsn5grRdGBxU3zeGx8K5kG9R2LckSnqpEeDp1+Bt2V9R4m5zKJwRZxys8+RjouKwCZPs08VAoM/E/T5M3OQFkjFM8TubiAToxpk8Y9QEz2AryMjo0Bc7adWA2y8GcsU8xz1MNDECtUJ/9HFW3J7kJYOcP/Lat3prmTL4nUB//xuQDbleg6J+5uR4wBRZ/EN9F/AUkedI0dqKt3fH8fvfa6v5q331xc7pStR0/n3D0XnZ411GrPTMdYDSd/FJvgi6JNBljXVl3AHIKMYy+kEQAaSRodHLz1B2BC4ft5/8jkQWZgAGRcEGF6kYfKKPK3VeZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbljTcmS3UGM9lIhUMPz2Yrsr38HFrNqK1n/j2Ca/eA=;
 b=cU5UerrsiUgUW1KwKkqf9Kj0LV+lEGsTu71hKgEtC5eMnWh15m8T0/p+YYnz6osPjO5l+ZkcxOCNNFs1/SCYTQyMjLNe2v1mzELhql9OQFtT4kcLNoYrZyZXav8pqjA3J4rjMBpTWON/1Ej2n/63umThZgkUjKCHm02/oDuovFVhgeZkuoA/eMVtm925PBfqT2iNpQTIsPZzWYx6+Pc+33Pkxz3kirEWmgEosnU9X762hM5jPGtAuIcAjE5ubZSHQ+erzEH7eg43rvQyEQOEue7sMk5WGucFgokJTzvr1KrzfTAxCSIbyMYQh7wm5WzbrjxO0RbmtSnL/wWoSzoUIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6047.eurprd08.prod.outlook.com (2603:10a6:102:e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 19:46:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Mon, 9 Jun 2025
 19:46:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Date: Mon,  9 Jun 2025 22:45:59 +0300
Message-ID: <20250609194601.987979-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250609164841.GU1382132@bill-the-cat>
 <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 962081f4-f86f-43d8-4507-08dda78e484d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?osIQF5KX0mv4K96AW/WAFMNQ6n1knaHFYXQxSczdHCDHEiWMRUGylX0UnYwm?=
 =?us-ascii?Q?MmZ1HpYz6p1dNrXHFY5MZ5iLVmTXu8VkYPvr8IGOfWzUyFC9VCi4+IO6PMuv?=
 =?us-ascii?Q?baZOGwKA3BnDx4eGp4aXescQuHkGK8eXmg3CITKgwOGPC9605nI6ucJJjNgZ?=
 =?us-ascii?Q?Z8/+ljWTvOXWeyY8/mMxayy3hWLNqeJclSROAgSBE8u48DC4aHuVImEXspYx?=
 =?us-ascii?Q?8U2s3Pdl3AagIzW5WVXEnIfSvhyk/V9pwLM6/3fgWjJpm+RWXc32KBscnzYC?=
 =?us-ascii?Q?tw2JkmgkQr385HezsQNVeHdgN83G87iGoZ5ODkKFHUossR9/lpYqggl9shzj?=
 =?us-ascii?Q?ceH9t5Ocxx/Ars11zFmyKXQwPioT+XOOjKamz+Vl15mOcxeP9SW03OMe2O+v?=
 =?us-ascii?Q?4CiqBozv7LWjWng3TK2N77dDlNjAjKd7XZgfG3FZ53Hh09vsR8DQqJaEb8Xv?=
 =?us-ascii?Q?YUhhByLeky/RHV5pjAwMmQYbXBvIzVQnkcBjaMH8WiNXlvrF3UIoSIq9JIIv?=
 =?us-ascii?Q?1cCYXE4wzea4ARaM99mxZwTvWC3SeAL7dDtqowOHssMA+nWWW4VCtOdgndtr?=
 =?us-ascii?Q?PwY0hzOQfnzk2QM0oXt9WaZr+s3aRMXo19xKbkDq0YDAix+RtOpamBCYtxl/?=
 =?us-ascii?Q?akBe1XEg7RQw677hSG8wGrXDQ0P8HAJGQCmMvEfwwJBfke5VCxMOdw8JBBNV?=
 =?us-ascii?Q?0nwMZXZPuzgSh98LhIcrW4E/WTLGqd5BCqSvBdRFVKDzTzNiw3oFY/J7VWix?=
 =?us-ascii?Q?h+W46Vq+SpEP2yDQjursn63fJCOKy2GecNoqCid7yR/4ZqlAd/r+68t//TRh?=
 =?us-ascii?Q?bA9o4ll71zu0kNhzLLM3H7b9uxuMBA2ecAt4ICK5vUmmYi9YNBKH1HN5zsf3?=
 =?us-ascii?Q?ap4AaZzKzGq/zeH8NQo9/qtrySCJbulB/9C+vUfUOK4ZQoDBkhjkk/dm2TOE?=
 =?us-ascii?Q?6XVyfRvMaQx2Fn4LieKzdjDX7HHXBK+ff146F+6Y1pKgmUjERq7B40D4uO56?=
 =?us-ascii?Q?xd85OeAtM/oJbDtyE4RhR3oegFgZr8rp6YcxSA9909rdo6xfJmNWuZwtnCPw?=
 =?us-ascii?Q?CgxnGYyahAwy+2w8Qi11Mjm3o4NT46M0LU+HXn2LHHyml39F5j0B3IdMe4Vw?=
 =?us-ascii?Q?HVdNbCAymlH9njQPQgyswDRHlAJuj67VGoc+SmzA9h4lCZfWf/lZ1GG2VZVH?=
 =?us-ascii?Q?/bPoPy5v2X06Ko7qjK/+sfSfmpjsyc9xolSx6QjMTpkzKfPYfXlU1EwbeIxw?=
 =?us-ascii?Q?YXXcE6GYch/vEZyqPJIfRvqb7mpdvktUuky8S1dKQHo512JZvp/fvM0f4mZm?=
 =?us-ascii?Q?NJkMwFxGxEbC0MSA2exk8I7wnkFtC57tp4HWhc+wdN5hy7WF67Wu7HzhVc52?=
 =?us-ascii?Q?NKCyCrmS2lGshegJQO0AuFwoeBE9yXlzXRfnLHc5aJqqQHN+X8ETlK0UqOdG?=
 =?us-ascii?Q?Rcd2RqRAfWqMKi++3pXYZ0td+1lKK9U4QQ+6Q3uLK4kkfxEL9V/pIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPL493XXY1o4926Zrt/YbFwYZmdyAr7KEVVfdrRxsZVFBcm4Fiq+weao9p7U?=
 =?us-ascii?Q?w1pZ98l1VrDUQt3JhndzTm6gbh7o3o2tY8Dq9ICXtkxmcU8x7vXrAcaSctqd?=
 =?us-ascii?Q?sAtbDUcpv2bD8nUlLWeBTwdSRWjC+fitlsHNAp05YMzfMOaJNhKvueGm8kAk?=
 =?us-ascii?Q?eB0lyobVdxIluPepUFLdtNitNoFQTeX7ycFx4nAMurnTVSBD5nxoEBtoWXho?=
 =?us-ascii?Q?j1qMgAlPG+N7LOytFmDxJXUaXzdtUl7akowS5BVEur9BBoHJ4s4XEn5ag7Um?=
 =?us-ascii?Q?UbuXLpADerYEw5J6hqorpBKQGmX8o8P/LkNoatN734an++hfRiIuIZwVxuVi?=
 =?us-ascii?Q?s5+ItXswI5ThZraB7rDqTYGzVLePQzIO17taIgVu2RYZy4bo+vaBlRjryE9v?=
 =?us-ascii?Q?D/njwa2mN0qf3LgfqXzSwEzKNSwRjoW7MAWyWqJgv8lN25HqioKWZrMBi+u3?=
 =?us-ascii?Q?9awZjPiyTuYC7hjNn7Ge9ZPJSxSe5frDTepEMA6fL0zC9GI3Xl/JHrXrnZWx?=
 =?us-ascii?Q?8ui6zrRyEhdvOyATECy00bJMhWYnWYN4pYsfLNyfgGQUb0+SefaXxJ+zXAI8?=
 =?us-ascii?Q?ZzcCyStTF017hruHeq63mah2s1UYBpl6FRs46xIlaEdZVNOxvzczaNAavaRz?=
 =?us-ascii?Q?AdEEEYriXnwcISC7irAXYXIQWYSQxK1G3tzuO/M0dYa7TwVHsmX+BhUehdVl?=
 =?us-ascii?Q?oPf4qrpWkUks3MXPNwy7mYeeBO1+7PNUxdJOP47KTM+8X8qEqAiX7R4t/Z3R?=
 =?us-ascii?Q?uAFak+CsDyFdw+QxP0DxRbCUywESggd1a7t16PH2e9zIGGxgPUeFIgFi39ow?=
 =?us-ascii?Q?gwU5ULomLJHLDV9tj6Db0UsHplm9q1Lt8ITYa/eOasXcxvmljvTPiUHs2RLN?=
 =?us-ascii?Q?LaVeANR3fMqfG7zyNyHKHzcGvXz8P5IBY2Q6wpenHj+eBVW5nWo0gTG0el6f?=
 =?us-ascii?Q?fVCPjCvNJGoNyQxx3MeY8XxNMc7WhUWB8+JSa31NvIkJ/56/l5k2UKjhT5gI?=
 =?us-ascii?Q?kWwIDLt8nxuKboXnQHoDZ7TySDu++jlq6XD/QImuBiB00S/gj2xOy+pFZ0u7?=
 =?us-ascii?Q?YqbAGfSsmob9UDwp5P3HrfWLNXxtDWAWGpNQsT9RoVEiQ4ESoz1WcguEq5m7?=
 =?us-ascii?Q?4/ooT/d9EFp9GAWr7T10lPoqzQs/Gvac+NMmUz+PGzcs7uhTHlimXxERzQjB?=
 =?us-ascii?Q?EF75Yj2HUjjUJCqFCZn5Ig4p1x/Wdcpn/7yGTP5iQqZd4xF/8kNvPe0Q2TGe?=
 =?us-ascii?Q?srPCOKdVzG2NBVgsjYQMQtLmzST/mCa0LC2hJLbg/mpK/9EaURXpr2ObQtD3?=
 =?us-ascii?Q?7jG9pYMomwtqGWY0ZyZlyvB+HzDitzBbZM1tLshctMrGx/qbq5fF3wpubxOp?=
 =?us-ascii?Q?BFBG3PvCPp/1QKpavl5IOKrYSHMQ0Cb68ct0x5Xdlzvs9iSvhOxGRDECN/Ab?=
 =?us-ascii?Q?fhKpQrWAKMrbRnGWmQmj7tQuqqx78mDvHdFF4/UjguKjdcP5vfb4fuG2/oU8?=
 =?us-ascii?Q?yJsCaWVkZaABK7bcP0gSId8DvuVJsKXrPVvTBT9e+0Y3lqEg3GKRyM29G4BP?=
 =?us-ascii?Q?MME0QolnP/vJgiTaQYvJRcOIIGYco1MN3hlChbsMtCx53V6jKv2YdcPQipOx?=
 =?us-ascii?Q?bBh0nzjV3bMQa3VhWV+eWKk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 962081f4-f86f-43d8-4507-08dda78e484d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:46:09.8459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJObXTxbhbhi6yizD80YLmfTblbUeo6KMlL7RPS6dEdcJHbjfp6TYgVQoQG8OxIhO+WO6Ywc0irO/BIlszgPphwbj8iN1TfntCbjIWFUQdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6047
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

The current code have two issues:
1) ineffective NULL pointer check

	str = strchr(str, '\0') + 1
	if (!str || ...

   The str here will never be NULL (because we add 1 to result of strchr())

2) strchr() may go out of the buffer for the special forms of name variable.
   It's better use memchr() function here.

   According to the code the property is a sequence of C-string like
   shown below:

     'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!', '\0'

   index is the string number we are interested, so

     index = 0   =>  "hello",
     index = 1   =>  "world",
     index = 2   =>  "!"

   The issue will arrise if last string for some reason have no terminating
   '\0' character. This can happen for damaged or specially crafted dtb.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 common/spl/spl_fit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 86506d6905c..ab277bb2baa 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 
 	str = name;
 	for (i = 0; i < index; i++) {
-		str = strchr(str, '\0') + 1;
-		if (!str || (str - name >= len)) {
+		str = memchr(str, '\0', name + len - str);
+		if (!str) {
 			found = false;
 			break;
 		}
+		str++;
 	}
 
 	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
-- 
2.47.2


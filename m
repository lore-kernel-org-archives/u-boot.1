Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E899C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537EC82B3D;
	Wed,  4 Jun 2025 21:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NAeU+S83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6081D82AE9; Wed,  4 Jun 2025 21:56:29 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E22F81E72
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7IX418O49w7Qt4PfTHCrTv6wJ6wt4PDC2XALDy6DpzvxEdxDa1ad2Ao2DIWDRwkI64T5mMtXcf14uHw74Hytnh2C5YIMxzYrwhr53NKrE9FRi/t1A224B0fYDZF2MqfeDNFxHOEw79M5In0MlaGFOHGXU5ZiYke9cWqPMetI0WH6H57fY0ZMF6Ykqttcl599MXY+ojQv9pAcLQQGhj5lLs5uY57eFAkHOzcqz0NtLRn3ZpMce24IjiibQRpVpnTwPzyJptvTi3U6kCsCVpUJwt5J+wm6ohDP6eSe/w2q/teeED+h5fzSV347DBmzkc+5oIdSuzkiuCYcIVMn+BE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv9RnkDsF6TvhA8P3TU1561BVZ9nHon+d4uCyToOlks=;
 b=KaJC07MduHV+sU1aPECmJwukU7xQz+ZufMh/Uv0bm18p1U/a7RZybBq9wFukNBnn/SfvxCNtjsXW2Hcx3RZG0uu++BS193yFVJgewY9PR5tDJHu9Ga0/V+11bGR+S6Hm3pTzk9/H6Tlu3+ZFbN9AlWVx2D3ckCOLaTnPzjww/gK9B0LX4K7OyVj/0gBMs42x2PL7DmS7aVVH0f9LY7SPdxmN8KQKf5zHw3py6diP0/q3r5cxrEq2YI3x21RU5gA4UYS4ucZa6Ticqy/xeSQ3N1H71BmCIW4aa38OWT9KsHFLKREYN3kGabgMwA0gVIsZhz/gahZ/ICN89rIRF6+AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv9RnkDsF6TvhA8P3TU1561BVZ9nHon+d4uCyToOlks=;
 b=NAeU+S83lrBIAYm/+GCUrgBk73eB6ae0QYY/HhP5naKqhC9tOfksidvxSRamQGlGuSD99woVGxAIZFi+c393RWtzLY7pJsYi+mELGkmROlGL6QMuyX5ypXfTfaOyuyaaKou7tdxwePKyr9Fm8FqgOwqzzdeavglhMGWV1ZlR2FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:25 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 09/12] efi: drop volatile qualifier from "save gd" variables
Date: Wed,  4 Jun 2025 21:56:09 +0200
Message-ID: <20250604195612.2312979-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f233120-6c60-47cc-9cc9-08dda3a1e363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SYac5bhZz/9O5sCBWHs+VpY3/7qzhAN6LxGz96VJqDUA3CsGnbRGocSy96N0?=
 =?us-ascii?Q?f1ilRmzDrpM/HyfTg5qoywX8Q7s5gCUf2AYePLzrFdxKrt48ZsuxtlrhkkR5?=
 =?us-ascii?Q?u3kPPW50eu9K6tWQqqrXiW7oyla9tcjyz+KbxbmMFwwmWdzixKo4xaCOUBzx?=
 =?us-ascii?Q?1Od8SWlcpsqC+ImhiuIGQ56ySHgmYminPxJcn2jq/KIngrJa9T6M2/8FpAu9?=
 =?us-ascii?Q?BWDtnTTU+tIys5+3k7VCeV5t29b7UMDiGiVpUe6+5wrHEFfRMey7g3XoQ362?=
 =?us-ascii?Q?jkAHctBgCpBsc0ZGXLiiNwLngGkHRQfwm+cGoS1j3x0yY22kIyWNjfY5WJe2?=
 =?us-ascii?Q?A8AdJrALCQ1vkb2F1lN3M2veb7+KSHbUxR7zCHcr+tYmBkL5w7SyBEi7XKhg?=
 =?us-ascii?Q?5B/B4XVgW88929oveur0KwrIOVBm9BvxrLChXTzBT1J6A8K7WRynYmP8kvVX?=
 =?us-ascii?Q?oNuM9ssFN6wv1Qg/Up8iB3ECEP+Jj28yjBDmCYh2PyZ9blH0sUILEW1j7Uq3?=
 =?us-ascii?Q?0oWFXIrpltxHAM9X7RZA4dOz0zhDZQGBn+la94ohx6KCp9eDoq9hwYFzo5K3?=
 =?us-ascii?Q?wkVf0JWNxnd7B02zkLDG3OYcu/prSkpmTh88ZCnwVi+XKC++TZJxwtkdto8b?=
 =?us-ascii?Q?Dz0NmhiU6aCZR6sX4OpSVEfzi/DV27UOmptm4ajEdJxhvLYyrfeQ7t6Ztmip?=
 =?us-ascii?Q?CP6bJBpg1+Q4tjhIDnM9XHvLybwjlLkXmuoqLIHqQEsugzme0W5HJNyqJjSx?=
 =?us-ascii?Q?V7Rmy0KT6mERbyOYnKuCqjmme3WUjwbewUGmYgruEFpLVXcWkQ+Ebo7hDsQm?=
 =?us-ascii?Q?ACeMTFax9yRRRDc+mNIFPU48n+Ry1MafQWG33vPpkIeZoKu/v53RVFLJiQsX?=
 =?us-ascii?Q?uBnEY2xYxWqgYp1CwsBz2dC0Ln50vSA46C8DmcPZrmoNrG5T4pl4HZwr23nx?=
 =?us-ascii?Q?MBRTWqYu794OUH0QlTlFEHLrlx1xBzsmhsDZ3QGAOwVW9tiIN3+qgbzOrPP2?=
 =?us-ascii?Q?aZjs9VAINlmmEJeD09d6tYfoMVBtzCWiBIwMyG7ZUPEEw7VoTNLpjdvHOIfR?=
 =?us-ascii?Q?2Y2ADQNxfINbBWSs15HarNJcNqRbZOIKnC4g+Lr6snGV51TbMjxn9HnNYabx?=
 =?us-ascii?Q?r0Pc82SdaUlHE8gA7nHqg9UaU3BUE3fsfQ1MbNrXqg8FhE56hRFIThSE0SxU?=
 =?us-ascii?Q?YfPPfGG6nELNMa0uNpzwyImSovRVfDSGymXKj0thbRzciTgh6lHHzNuYxQgr?=
 =?us-ascii?Q?7rfmvo69NsjVZ8iW1sRu35q1jxWVv2EXTv5i4HlXNPYeBxAXTEXrUwHJLAEB?=
 =?us-ascii?Q?Y1A5HiB1en1L1phSS6OJfXBAYVUfZUKUN6x1Mn8zeJaPZwf/JsBAG+MRRQd2?=
 =?us-ascii?Q?3Zp2ZbFzbN6eYn0goYn1R+ywOfSFc2TLryA2tz7oFrKSfJK9i1MBryj6kb+p?=
 =?us-ascii?Q?app1YgdC0EZiBG9rbvGrFk5+5+x9TNyp7B/uA0d6MRtLJdMD7dKfMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0DkIK9GqsvxL66cOwwMh4Vh/5WXteFQ+VVQKZIysh/tSeQgS5SjHtXcBXMR?=
 =?us-ascii?Q?WBVE6Eo11NjW4Gin+MUXJ9B1YAmD36mdxjqP7NpqRi+sFjACT6Par8L+IyeB?=
 =?us-ascii?Q?U1hJtNbeSkGkbdnc0yY8Pucrvb3lShKWHrBOnNXlXxRFmSk2q2QzMYlGBJ4j?=
 =?us-ascii?Q?fkXHHrlJqDGSOv8EoJm6XxhQX57dUzS3DKW29PFHtKKLSy5Z0vb61iGXseZG?=
 =?us-ascii?Q?/uVKdkMsZGwinEkzWCSd+bmrd7rupDlvUiAfHUgKvBYMhk+d7dhCs9yo817Y?=
 =?us-ascii?Q?Dy/Xoa1OS4yGrhHBlIEV2qVBjS2uWdsb6CM/CxnrxshFmHX0htwBu6gIAb0j?=
 =?us-ascii?Q?Eoua5L3x0K/lEDFJDgK02n0AwV4Fo6ND787qBOyT0Z1kCdfNLYiJIGeSPXaI?=
 =?us-ascii?Q?0TM0xYBvBocMbZ/ZpJzNtaiI0gh2ut3F7b8a14/qFYJED53NBoiOAKBh0X6b?=
 =?us-ascii?Q?cboYkAgV7z8qD4N2Yfjzv0sYkKnUd99aX0LOSEZyUXX/7tF/W+02ilxX2QcF?=
 =?us-ascii?Q?mEKRMRtEkBALqDZ4Y/RpAXfv8P8jZS+BwSMZamc4OaD+LFHfwgxvENGKq706?=
 =?us-ascii?Q?NdwMeRuYmNlcb6Sl/6nPzV/GtVpcjydo4RoVpLG4HK4K0s6XAneXZ8bPMv7F?=
 =?us-ascii?Q?Afh1ufw5L0sfRz0TcJs78jHdveuUkLZQNR6tQMJa9vziu65I8t0xFXjy7cKf?=
 =?us-ascii?Q?80QUEbThZSXt+MZ1pGwXJzln4bBcdZccQnDJMfDqbqUbS7cdsN46PcPmKarv?=
 =?us-ascii?Q?qrPOQ+zi06yAWdRzH308j9gDNlzOmEDnrx4IiQ7iiU5HGUARd4AKLCJUegHj?=
 =?us-ascii?Q?gK/L+d9wommp7v2Q08Nv7qZ3EeqSTRFvSS4BTLXvnU61RRH1dLcbnoFewsyg?=
 =?us-ascii?Q?/XaFyBYBUDELAj5/QAw6w8bIlrfOA7U84sycnJ21OIiBADV3erOLuBFiNcy1?=
 =?us-ascii?Q?BqEmu2yg/qAmEaYIFlYHQ0Bnt+DdtF+lW0uDRawiip3z5rIKlBhCu19aviaD?=
 =?us-ascii?Q?p1FKYVpyTzfRbY9VXKkAt3ZYTAF3TQbQXIQSWmGaUpRHWUBLS50km3pdD4pA?=
 =?us-ascii?Q?JqI9XwAnVqPAnEjFt/5cwE4OwZu1rlK8PBfChL7EnLjbPdTvsl+xGocKa1G7?=
 =?us-ascii?Q?7+0jYvd2kaeG0uDViqxojdGGDis6xusbFgpOmYKW3hAf+DqU9j2Suc7ee8Vg?=
 =?us-ascii?Q?bBmMyRN/ft+h/Z2qKI4wdYxGdGsWI9aoarLy6otkN8XwXDI/vMGo08Tklrbp?=
 =?us-ascii?Q?hDq+oE9lh7r3x+zFiq2mDj4XQRrzkA5+4sFVzuuYWdso7L0k3Hi5ak+FC/AY?=
 =?us-ascii?Q?fviphKksfbfCBuioluDEegaunXx4EP2pzVtvkN/6mAe9c+EyJlIMVdEgPm08?=
 =?us-ascii?Q?7+K6vPoX1QZF+viCLtKYgufu4TvNYg0sZauvc6pKESEOXcPbXMyV9J5x6Vdb?=
 =?us-ascii?Q?tWwkNkdvJ9y9hYSOBfCoNIqcBOu8YbS5mULRZriIWeqEPZi6gKFXCNRDqeXK?=
 =?us-ascii?Q?6Kr+vHNDai9g7vOLsJ5vzO4XB88qWSAkeA6mn0zlVqRX94A2hHKwnpUKtvV7?=
 =?us-ascii?Q?jxniuw2ZBmGkGUSpp9nZh/IZY4YOKr6N96ANKa5KytxYxBiVS/KzKCngX5nQ?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f233120-6c60-47cc-9cc9-08dda3a1e363
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:25.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8FSCvMu4QSIYTlPQlC/pIzxhBR6VLE/ZxV1bZ0R3cLViHmJfzutNxC5b6mj4j1ViqQu2oxJMr8HCFSX0TLxbgQqg/luhiT2jZ2e5wcstfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

The global gd pointer is no longer volatile-qualified, so drop that
qualifier from these bookkeeping variables.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/efi_loader/efi_boottime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 24b0e52a2a2..754bc6a6519 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -58,7 +58,7 @@ static efi_handle_t current_image;
  * restriction so we need to manually swap its and our view of that register on
  * EFI callback entry/exit.
  */
-static volatile gd_t *efi_gd, *app_gd;
+static gd_t *efi_gd, *app_gd;
 #endif
 
 efi_status_t efi_uninstall_protocol
-- 
2.49.0


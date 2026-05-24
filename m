Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0305CCD4F54
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 23:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413E8846CA;
	Mon, 25 May 2026 01:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="KmT+Qerm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F4E847AF; Sun, 24 May 2026 22:36:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79CCC83FF5
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM8tVNFE2hCbw+rxYznj57iErL7fmxvbtZ2Eik1wYkTTPgIzjSy01c4HxvUy4kkgcjG7YZ0uDf0zm2gkdmst2ZCc2LdMA3gpwUVS5G5Pf28rZb2k7RHkOCp/tdwe9k6cbxw1JzkBFeF2jbV8R+J0vBPK8tGaOGbrPHgtWJQ9XH0h78XrONLHV7iQpVKnZ2xJeG7wLlDqglT9Kp79oAos/QpjIMelNfRUrYPmtg20cBJBgJ5hzpEVB/XSYSyfNjCKz5mHVTqeT0hF+wl9cG4JZjDvxLhKu0OXa68t/EGpUYzDcFBGvgC+gDcvMDwHPZeelx81xuAPTzLU72z/cogDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieb2Keck5JcWgV5ruKxR2cgtcq3naDMBQrZ8zAESYNg=;
 b=IvuhFzShfaRadtWkndvfePAJyiohcvsZuAb21f78QzlYAL2E6tqP0gX/AUIP5tD2ZdazFXrpJ4hjczeOQ+NWVYW4z9XGXZQKmKa8EQXKBNDxQt+0qPNy5TAkydFy0ha6MvFUvuEjiZHz8zZDSzW+4NW2/3luVfsTkjqbyj+EHsR0TLHtBtSyRFEHFYYj+hskmwOF/0/BrKA5KhtMAzqZ9mcQ90oth1Ki6LPu4XrTjj1EevodjjIvu4lg0VMPznEHrMte80U8B+T55fup/4panU0LcsWnjWYsINT7oDpvoH+vMQbUsZDO6kiEtNHrW1vtf8hFk6lJTVM1V9c4hgpnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieb2Keck5JcWgV5ruKxR2cgtcq3naDMBQrZ8zAESYNg=;
 b=KmT+QermqA67zBuDTPT8DSIbsa5WYvDp5Q+AgKTgV+xMGPYZJfh5kzvpY+rOXDzVQ6Ylbw/9jn8KWW9y0b8/+LjP2mxGsE0GndZBPTmXzQa7CdjdyY1B4GW+g5RQ95D7idWHZAs3JbMTyJcKc8NgJzxwTLFD/QNW7ZT7UHMqNIkR+f2PxidiX0H3vUGqinemK/MSCt+B0rdOOR2zoqoKrExIiVp1cVAkX3yO+cXKhCrg0WVBtBkcQFLt2Y2On13j5nZbK8V1bezuoa56UFgTnSsa81uWgr7KkB1KH7S7P8XXYQrz54Gmg2qQ/wovyOGJvIRzejyWq1slI7DtUz8/KA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DU2P194MB1530.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:2b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Sun, 24 May 2026 20:36:03 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:36:03 +0000
Message-ID: <BESP194MB28052438C13CE26C944DB99BDA0D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sun, 24 May 2026 22:35:59 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] arch: imx9: Fix blk_dwrite/blk_derase error checking
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::19) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <c9ae80ea-38ef-4135-ae0a-b012743785ae@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DU2P194MB1530:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d12506-f239-4a4d-e4be-08deb9d41283
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|19110799012|15080799012|41001999006|12121999013|23021999003|5062599005|6090799003|5072599009|37011999003|51005399006|55001999006|24021099003|3412199025|440099028|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXM0OEFUQlJGc2V6T0hQU0Z4UXMwQ3NTY1hZVXNaZnUzZ3JmT0s5L3ZxRVNV?=
 =?utf-8?B?K3VuOHlQTDhoUGxINCtmU01DajZZYXpWKzlhNVNuRW1qNXlnN2tuTzZSR0lk?=
 =?utf-8?B?UHFWbk1YTEMrWkFrM2RWYTZaTU1lL3dtNXMzQWE5aGtrSkFpaXNDSkJZbG9Y?=
 =?utf-8?B?ZXpxQkRaQlk2WFNPTm1pay9YNlRDK2EyZ0hBbjdiU3B3Sk9qays1b0N6MkFz?=
 =?utf-8?B?SlNJcW56K1RqSlE5MlRqU2NoNkVaZDNhTjN5bHZxR3ltelBOYmVhK0JYV1Yw?=
 =?utf-8?B?cVdRb2o4N2FTZE9BelJ6ZDcwQkwraWRqVGJ0R1pybzEvVWVlcWVXeG5NTkxa?=
 =?utf-8?B?WFIzbFgzQ1NTK3NZNVdybkNNQVM3amwvYy8wb0h5azJ5bVJ1dXp3UXh3Q0wz?=
 =?utf-8?B?b3RnRzZ5MGc3NzdvbmJnR0wybXYzMVlYRGpmWDIrK1dra1YzZXhHekFBRHV1?=
 =?utf-8?B?Q0JKSlR0QmNGaG1ZbDdRem1kSEUxcm93NlhxeS9pc0lzR3BqVTlUdWxubWRG?=
 =?utf-8?B?RkhNOWNVNFdYY2NYYlYwRnMwMlhKeW1pcjdkMGZKWDBUT29vY0NpZERMSUpU?=
 =?utf-8?B?cElzTVQvMUtYREhjRXBLbll3TGdERmoySHVqaW9aZTR4bWZhRmRXYUh3d2Zm?=
 =?utf-8?B?RW9aczJwa001amx3QmJJMVU3MWRkZisvU1VOd2tzbVpjU0p0V1MxZmIva0FW?=
 =?utf-8?B?YnQ2MmZnNnZsYmR1RGtWT1dhU1lQTUR5Y084di81SEV3aHVYeldtUEdNdlA1?=
 =?utf-8?B?eER5VUVqYlplcXA4dGhHTmFKQjFnb2p0a0MwMmtYSEMrMzk3SGJhVDVHZ1k3?=
 =?utf-8?B?UTM4NTlTSExBekY2b2RISEl3MjNTWFdSQlNHOTlvcjhTVlVoR2VWeTkxSExV?=
 =?utf-8?B?dzJRaDFkL3hvS0tGV1Jud0F5WmNVOHdlaVkzTEp5TnZnMWhpS3pxWWVSYnpF?=
 =?utf-8?B?TmhSSnZ2cXNVcDNBT0ZlR0YvdkdySXVTditpZFcvZGN4UFBhdlZvOWViVlJB?=
 =?utf-8?B?Z2tqd1l5SFVicXA0aTJ5Rjg3V01jQnJJRVpWSXdaeTlsZHVOQXR4WURtTEZZ?=
 =?utf-8?B?Y2h3eGtnTTJRc3o4V09jaDBCZHduMEcxelRiWHJuL250UEo2cllnYjVDYXJ6?=
 =?utf-8?B?cE9NeFdsbE5VTHQ4eU5DOWhuRVBqNXR0S0dDeEhmWXJTSTRxUFAyOUFKZmRa?=
 =?utf-8?B?akwwZFNBZ1REYTVBU2g2QXNWMTV4NjJPZlJMN2Jic2UwMG80dmdtZ204THor?=
 =?utf-8?B?bk9RbDVwMWRsK0JtemtUL1Y0SlJyTVJrSzdpWThhdEVqT0l3WFVmclBHdnNo?=
 =?utf-8?B?VjRTSVhJVjY1M2hNL1NWSU1QOGZJd2pQV3U3Zkd5OExXTFNQUUtXNHZ2K3pF?=
 =?utf-8?B?U3Z3dDdsbW16UWRPbGNRdUs0NU1JclJ3bE1mVTdiTnZzZy9JcEpvODdCMmpX?=
 =?utf-8?B?UlB0SUhCNFphWVBTellSOUx5a25lTlFTODVhaTBITHJTUlpMRTdKa1ZtQllx?=
 =?utf-8?B?Y1FzYlhhTzFVTTdKMkJaN3o2cXV1MytHaVJ3Nytaazh1OG54SGk4aW1FRXgv?=
 =?utf-8?B?aGExZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eng3eUlhUmJJbWVac0R5VkJxdVVYNmZMV29oNlpISVYxNDZNU3FybHFyRGhG?=
 =?utf-8?B?VFhzanVNV0xyRTNMb055YWJBN3JtbGM1b0RwWUFlQkJFL3U3bzlwUWlGZnpx?=
 =?utf-8?B?QllNMGpFQnE0WU1rVmh2WE0xUFpGUTFUTVN5MkxJelFIMktkTlBLVUZEQ3Rp?=
 =?utf-8?B?Y0tkcnRMZklzLzRhaS9MdldzQWxvS09PS3FLTjZDSDFMSHNuMFhzRFh3aXdj?=
 =?utf-8?B?bis0UHF3RlBlekNISDBtdGZEYXBlYm9icUk0QW4yaG5VOW1BMjcwRjJZSy9S?=
 =?utf-8?B?Wm1GcUlBVU5zRGx4d0M0Rm1ZdDRDdFFxYU5JU3NpMjZBRUcvOVFmNDhqTjFR?=
 =?utf-8?B?UDlNMHNtYWwyY3p4MnpCU1FNY1lBM3dDdXFBN3h2eU13V3BoYVFYaGFYMnNF?=
 =?utf-8?B?SFRNeklQZ3hlQzN3YkpFdVowQ1hVcVNFdTQ2S01DQko2SlNhQUhZSmJId0VE?=
 =?utf-8?B?Zm11eHNpMFBXKzZ1QlR3eFN1ZHI0UHdFN1c2aTdXS3dKZDlKb21iV0dXT1Rj?=
 =?utf-8?B?U1BXZm9JSUtUY3ZOclllMmEzVVBVcWxzanhUbU1nUnhpNEJuNjZkRW4zdTVL?=
 =?utf-8?B?U01yQm1BSnBrOHQ2VmxsYmZVSUZhNE9mRFNpUkV3R0tuaExJeGhNZktra1dM?=
 =?utf-8?B?OGw3SjQ2cmY4MHZCYWlZa0dZWlltYk1wSktBT25lU241cVlwU1NNbkswNWxn?=
 =?utf-8?B?eGQxS2RYZUR3QS9ZckN2WlV6NmhGVHhFQWdZMXZPeWJIWFhkTHRPKzA4ZlJm?=
 =?utf-8?B?K0kxSDBiNkM2bWU4dXVnbzJkU3hjdGc4N3QwWnU1SkJoVVdhNW55aFBybG1U?=
 =?utf-8?B?SlFMc2tmSTJ0V2VRL3UxeUlSRTByRVFxTEZOR1NjZVQvRWhQOTVHSFJvLzhK?=
 =?utf-8?B?dTlzemUwenNoOGpab0svazdCRkgxTHliZUo4ZTNhc0xCQjJaQ2NUT3MwbEpa?=
 =?utf-8?B?STNYQkVmbXhUc25JVHhLTlkrSjVnKzA4ajIveXVNczVMVGVWZXhBdzNFa0Qw?=
 =?utf-8?B?QUF4SDhvWC9JQzF3OHZKK2toYVRTYWVYSTFudnNBNWJlNmxjS1FZRlNiVEJD?=
 =?utf-8?B?eHFpUlBmNHh6eEgxTWVmSFFwYU10cU9uZXZ3MzFHd1lyRFpJMnVsM2ljV1B2?=
 =?utf-8?B?c1lTSmFOSXRiQUYzTzUyTldUK0htbCtUWTNBWVp5L1YyenluSWFaS2VOME83?=
 =?utf-8?B?dVhCTXd4bVYyRVNXdkFQZDMvSitFQk41M1NDeVlkUnhBVnZiWVoyTktwUFNN?=
 =?utf-8?B?R05JVjNwR1R6Y1BVUVN3VUpkREFQR25nSDZJWjJnTmhjVVpmWUppenQ0NzJT?=
 =?utf-8?B?MVM5bWNiV3QrUHpjbzFSbTM1L2FYSTAva21jM3Ruc2cyUnRKRkZudjNsTzNE?=
 =?utf-8?B?NS9vVFlkYms4LzI2OS85SUxKSFpVSzE1V1hXdTRQNG94SG1MU3NUcVBaNkwz?=
 =?utf-8?B?NGIvZHNTWEVMWEQ4TW1vNmdMUyt6dTlXV204ek1TQUV0RE5xMDdsMG1EMTRn?=
 =?utf-8?B?dDVmRGdqVVlpdmpWVEEwL2VJbmp5K2ZTb0Uvc01nYzhlclRIbXphQWJxdnJW?=
 =?utf-8?B?SVVRRmRnTHdFRTc3d2V5UnRRbXdHMVV2eGx5UVM5U0ttVnlDdnc3RFp0RmI2?=
 =?utf-8?B?ZHRWTlYzaWgvNHFtZjFtZHkzb0UzN3BZV2daWG4zTFhtUWVUWDYyN1Z2cll6?=
 =?utf-8?B?TVRBRzlPVDlSWm5WcGIzQ3Vkck12ZTRTNWp6VThnMHhqNHBSU21qUHlwMEZT?=
 =?utf-8?B?VDRqYTBXTmVZVVpuWGlrblJHUG56SEFsamNSNTZQOS9HYjBjYWVsNCt4M3FX?=
 =?utf-8?B?SDdjQnJhQVZtRGswQm04aVV4RlZrdXRSdWt3MmV1cStmSnA3TFVlWUs5N1lr?=
 =?utf-8?Q?q8l2AqzKkVTy/?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d12506-f239-4a4d-e4be-08deb9d41283
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:36:02.9985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P194MB1530
X-Mailman-Approved-At: Mon, 25 May 2026 01:11:45 +0200
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

blk_dwrite/blk_derase returns the number of blocks
written/erased. The existing check allowed partial
writes or partial erase to be considered successful.
Fix error handling of blk_dwrite/blk_derase by checking
that return value corresponds to the number of blocks
written/erased.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 arch/arm/mach-imx/imx9/qb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
index 1a0a12de3d4..4f73db8e594 100644
--- a/arch/arm/mach-imx/imx9/qb.c
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -304,8 +304,8 @@ static int imx_qb_blk(const char * const ifname,
 		ret = blk_derase(bdesc, offset, load_size);
 	}
 
-	if (!ret) {
-		printf("Failed to write to block device\n");
+	if (ret != load_size) {
+		printf("Failed to %s block device\n", save ? "write to" : "erase");
 		return -EIO;
 	}
 
-- 
2.43.0


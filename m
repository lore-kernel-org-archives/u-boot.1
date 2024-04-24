Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E29C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EBFD88DF3;
	Wed, 24 Apr 2024 09:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="cSNuE68p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34FA088DF1; Wed, 24 Apr 2024 09:43:57 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0704.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77C788DEA
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztv9e4fzz+z3pFPH5N1zBInpn90j3RLnJFrdrSHY0MFxHXma02s1bHfkSGyaGUexvSxLBRkzUVpHunoct9b2ViSuv4Gr+9pLmUHQyKHCtrVkq7XW3l0BUn2vV9K3v3rvETKs9n9VlTHHPV5EISXA8wYg6BfxbcMOVL2C2DPDv3/YxNM8ECtr5uJCf5mSDMTuF3c2LD4DBmRir/60RYIXMA62HThMueK93KwWp7bel5pMN95uELvlCBsa+RcICgVD9HVTsAAkJ4WxyHeK/CyXYR1Tvr4p/1TCSpuyib8ml0qjl+7cMrM2JaLLXf9HZhR71Pk0Ig9hz/acmtHZu0yDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtx6Xck5sk2mGqXR6R49vaiJnJlYvtQg3H0wbaRamwY=;
 b=jFpLNe1SfJuQo2/F0mbt/fflbcwkVS/TLrep6aufcblHREkolpf8mHL6rethH9OzolbGaQLOIkMfP5kSVo6n+eSDUDZBqmbb1bMk/J1PO18AH8tl0VvLxVUE1x4bWUMKw6cvBFJ1/ndZbYlKThytjWCmIg3TfbCHdVR+tsc6K7APa4pIneok5qLxbQ8okqSmzxcusC4klZy98rXNJrEN9Kp3TKLXa495UsTVKv7uL6I2Eez6kE0YihfETJtG6P8ChIs1X3GI+6k0a/K9/NkpCXlWDowNFOwe2Lv23/Il7Y+1s/B8jOJBRkhQ6TjkfLeV53T+YGqJrv4M9AVwZys5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtx6Xck5sk2mGqXR6R49vaiJnJlYvtQg3H0wbaRamwY=;
 b=cSNuE68p+SCZ3e3JieL0r+Hq4NgBbOTxYZCdo2tP1UCnTCmIobO4t1W85oAsVIq+d71+L3UcsGJHW1Oc4HarYMbNVfkJATvp4uF1oH5tk30lcRmD8EWEl44duI6ykMMsHIKBPH7Eomaqy0PWMKSaHoLOzqXZb021yWAvaIhkmb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5844.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:43:52 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:43:52 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Bo Gan <ganboing@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v3 2/2] board: starfive: Rename spl_soc_init() to
 spl_dram_init()
Date: Wed, 24 Apr 2024 09:43:39 +0200
Message-Id: <20240424074339.210851-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
References: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: ba14193a-7e92-4d43-dc96-08dc64324823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xTHD9pQ4jI3Zzg5W4ISt9bbg6SLQn2/v9HCQBLo9QU/4SDrAnABfn8pfum64?=
 =?us-ascii?Q?5aTjM4bOaBp/I2G+5J1nPojeSkhcO5BuSyAy4dIXNNPUVq5Z7OYAW7PF7Dmv?=
 =?us-ascii?Q?Pxir169Y6WBb9hGhi/PFXZO/u1xjErtM40K2sN/QJcaOGhe1MtjEsmchdtuB?=
 =?us-ascii?Q?16xxcpOu7fQxN3krodhMv58o/IPp0ZFATIo2A8GiVeWc31AbLib4g75hI4XB?=
 =?us-ascii?Q?ZGoJNdE43Z5rBpSW7hbHXYBcjDtOifHsydQu8l+P/Z05/E8rIe2tvb9U9kxe?=
 =?us-ascii?Q?BkStAtSXxdPSm1FBwPjHs2O6+2C16Zq+5dS5N+1zcMUXNm+hx/dNjP/H/Wg+?=
 =?us-ascii?Q?mZSuRk7Vkw+7NpJrzHPAQ9Nr5gEJsB7dMkPaqL1dJIZaLVRx/DH+GKyAPhNO?=
 =?us-ascii?Q?Xh/rh8FdUSf3DqJwDOErPFY77bk0d37oaL1Pw6vzFZEAcLBa1vAStvU0L4X7?=
 =?us-ascii?Q?i0Fe/FGrawFDnDmAw/cgwz36ROkEZD1cyaHhYvkkDsttuEYzDHnzLJO7ia3G?=
 =?us-ascii?Q?QGE7hizc4lavDbAJKupT6GBSL6gebn9iPks2M20kUK9P6d3tDD1I9+0Nq9lb?=
 =?us-ascii?Q?oklx5mywIC26/CCPyGvkW/ht9nHaPGRHrxwQETMQXGOjWR0tmKOrl16LKPl0?=
 =?us-ascii?Q?L7wby5C5GvzgyWG4alUNXD0KSoU/laHJm9osb1GV3zRU6q2oBSR8wQWIYJ6L?=
 =?us-ascii?Q?eRdv+k/4MTh48zYelouiFgTKz0+lpCJtRa0UuhSFu3yWGi1pr43/rKrqEeES?=
 =?us-ascii?Q?zIQ362BZysMY+HCeCWs9KRdlQgqA/jT/EqB3IZCxPj8VMKVeN1s1KOkbt2/H?=
 =?us-ascii?Q?5uIkJLOFz7YypEF8Dps9AQaWM+Soq4xh2DIe04rTE7AhJ2dEuEbUMyeY/qOD?=
 =?us-ascii?Q?0OsMQ6jgt2ZzrLf2KBYr8F6VvBkUpOdVhRovwsFLkJAvm78lgmbjtM0b6+Cb?=
 =?us-ascii?Q?VUKAtw+sEnB2UlerFBh38AY2rVVR1VchnPXSRXckL/1P8l4xkZjmVaBz7zd2?=
 =?us-ascii?Q?VTSAEHaju8gN0ZUjsiEyGRcM+tzk6pz4kbRt79FFsiNtN/vVC+VubpaaQi8l?=
 =?us-ascii?Q?YbMBfsE4Mf5SSgR27xsybgqFEUBRvJT1Z2HmR4/jvY5dyEfCA4h0Sz9pHi/M?=
 =?us-ascii?Q?+YYJTfrnoz9jg5PuDhqg9hOb644nvYuK3MlJ4GZ4V7RoCGAl/a6wjwnBn6xA?=
 =?us-ascii?Q?mMWYaK/5rUjEky42rU51gxQYstu5GV6xQBJqaVeNJ7XGDXzJGaJW+OaXoI5s?=
 =?us-ascii?Q?w7SICfxRiZRSj+4Lqvy7oS/IWLBwo+UyBfaVVDYXNGP9VqqP/Gqn1EFZB75s?=
 =?us-ascii?Q?JmKSkWUP4zv8JRSWrixeav61BHXRa2pcKK/EpukDV2dkFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQ4amywtCai0IkWyAf0bmQqv3zWYBwxVQZjYA0SId6WxsKGbMyn+k8EtIVw6?=
 =?us-ascii?Q?tmBReuvIexjO9SSP4KBeFmN2aMZGxhbZENdfjf8TDBNGJGlXuxIYcKkJu8SH?=
 =?us-ascii?Q?mZAxDw744MB9tnGNPGgRy2TgxdEwnai1blcWLszPp19f38zKkMq9mHjSQHtC?=
 =?us-ascii?Q?1j53I7BdWTtPvQj1ulXIbtrJT7hhB1yvgOmPxNMJRSFL9tAPXNZqZ8k+My9t?=
 =?us-ascii?Q?xIkCK+4CJc6s02i3y05owjfH4iiCa9WS7AL/GmDLoUWL62qPaqaWHYUnUz9X?=
 =?us-ascii?Q?Pa+IeNCGZlBFOrvkYlQK+IgMFQ5jJWJ9Kh8UvyAQMx6M4tBtOIRwA32uMB07?=
 =?us-ascii?Q?fq7kc34VxzS0cOo79UIyP39pUyPfW2SM2hf91xY5S3uZYlZVsQRleYT7gFLB?=
 =?us-ascii?Q?VzlCvDaTnuhfj3wp3ChNLmyTAy7+qg3a6No1zrbbb7QfLWp7UmRFUmKniOyJ?=
 =?us-ascii?Q?TSLGoJnvRdmf9b0C/RfGleLgzJvJrokXvE3ibt72mZDFf9rd7oSaY1X6lpn2?=
 =?us-ascii?Q?j2iOIwLqWeMz2VmMjehWlviNoQTnfIYm+KgNX1p+4/cPOQMhnTXnPnpwpb5E?=
 =?us-ascii?Q?wikj2TZ6dErvTFzG+ynIS+LzGa4pILFQO3QNzurocY78J1KfsAxfNfTBq9P4?=
 =?us-ascii?Q?2IqDZQco/MkIZ8vKGS6HnfvMw2xJw6USeAfH7ZC7sMPYoQvG/4Ywdlzb3cVS?=
 =?us-ascii?Q?sKwUbFYlz4f3nI91Ix8Dt6oYppWcJyDZgz8NClNFFXoPGULrG4FJxKC4AN16?=
 =?us-ascii?Q?PrA5Fj8yer2e/gPLcZFnCIAjX0WXWjB6U9O7rwk/pcxHMQ4CBQaafDhh5acs?=
 =?us-ascii?Q?VN9PNuukfcroisJfYXlEU+4ThI7UO3WPMmHKACpn2+0E4lwY0Tfbbv3IdVgW?=
 =?us-ascii?Q?gWsEb6bqkv8lIUOSQ2+NXorVCB+1IPHmTixvTaGs8kY+rkCTzotABjlerdyy?=
 =?us-ascii?Q?sI3enMrjEWZQPS7cBFp82Id02n4fWrquo9La9dKqxn7Wx6CCP0fKCctuT6h6?=
 =?us-ascii?Q?VDSSO4JIeeVRWqDGAjEOJRcbs9i2r3EdhdwgIHbr++50YzGYcBGu0KsFCFfi?=
 =?us-ascii?Q?/KYU94k8FcmvCKdD8Eo5XhuSkjv9XNwCp3aT0GiN5711MJRxuvhZ1xAAaIYZ?=
 =?us-ascii?Q?o62bASysgQdIde91niA1dTGaUnPSwrRzcr6/j3YS5F8wNf6HBNVIzyiZc4QI?=
 =?us-ascii?Q?/kL5uAi4bYN6j5Qafv2eBcK2ctjeecFp0gj/msr6shtDgA2H9g+r68ZThdv3?=
 =?us-ascii?Q?E8iljlbgL+i12nV5aMNWHt8FbQJG6Tas1EDULp1MEfCXDe3LL4NouoMes+OK?=
 =?us-ascii?Q?z05LF0E3mthkkuheE4WekrlRk+RC64EXDES3cziqVbVTe9sST9zD6XGDewlf?=
 =?us-ascii?Q?5vLWGEPFgvK1EXKVIXjdQUKoLocoMM0b2h+/MdI7J1VkQSzAUYrHq7eBOuJT?=
 =?us-ascii?Q?gYf5mOdlqsfchyJYwPjgiwT850AAHKjwlgZ3Uajrxzc7/Qd/klz6d4VTFc4h?=
 =?us-ascii?Q?O2LNfK7BIWSkfak+QsG8xzMTQgcjRIyKsOUFmQLBkdvhio8bb23LnRNgr8y/?=
 =?us-ascii?Q?bhOdmn9cMcPVe0I3Pr1T1zvs1D9x1Jejh0Rz8yKfvhIjGuMQPB8RtnsIff5W?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba14193a-7e92-4d43-dc96-08dc64324823
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:43:50.1928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lyj8GeEUtwa6O/x80n8lZsRK82k6y38kEwUBhSO9Yx4YPfkQI2iP71SJqLdMEZQ0U8YDii59O+JEC1Otzrdnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5844
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Rename spl_soc_init() to spl_dram_init() because the generic function
name does not reflect what the function actually does. Also
spl_dram_init() is commonly used for dram initialization and should be
called from board_init_f().

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
 - Reorganize patches such that each patch can be built individually

Changes in v2:
 - capitalized acronym DRAM

 arch/riscv/cpu/jh7110/spl.c              | 2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
 board/starfive/visionfive2/spl.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
index 6bdf8b9c72..87aaf86524 100644
--- a/arch/riscv/cpu/jh7110/spl.c
+++ b/arch/riscv/cpu/jh7110/spl.c
@@ -28,7 +28,7 @@ static bool check_ddr_size(phys_size_t size)
 	}
 }
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/include/asm/arch-jh7110/spl.h b/arch/riscv/include/asm/arch-jh7110/spl.h
index 23ce8871b3..d73355bf35 100644
--- a/arch/riscv/include/asm/arch-jh7110/spl.h
+++ b/arch/riscv/include/asm/arch-jh7110/spl.h
@@ -7,6 +7,6 @@
 #ifndef _SPL_STARFIVE_H
 #define _SPL_STARFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_STARFIVE_H */
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 45848db6d8..ca61b5be22 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -285,9 +285,9 @@ int spl_board_init_f(void)
 
 	jh7110_jtag_init();
 
-	ret = spl_soc_init();
+	ret = spl_dram_init();
 	if (ret) {
-		debug("JH7110 SPL init failed: %d\n", ret);
+		debug("JH7110 DRAM init failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.30.2


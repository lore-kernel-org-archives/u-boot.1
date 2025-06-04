Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D840C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D3C82B7C;
	Wed,  4 Jun 2025 21:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="FmSkpdlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD6A820EB; Wed,  4 Jun 2025 21:56:31 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4532B81FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX75AEyag/B4lMsK9ewhbdIF66WnHqaGLjQcMkF0nVVRJITEFJHxaOAWWLegsK4RFbUIi6TUub1yXk6CLbDb3a0hALwWre5x25Ta9zSU+52gDQOaUtPdqtZda8vUfFD9onFnzQe33/0dsDxCJAoj6vtWKTOhhQesiB9jm52tBMLv1yLNwVcZHf6Hdr9sWZhavqodrATuBwPxc/269fm2r2rOybRELsPvaIvPCkVNbVTcHnB/dOsI4JJW/F5Vvlz+/6tATKJoew6fhl0gvP96oJ9t+4pojsm1xZ5dBmP4CPPqZc4ck/KwCl6qAUV4xi45bs3RgfoadQdXDnBHuYF0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkhVUxdZGM200CHt0vUHmfOsei8N9YtECSNOzSHX53A=;
 b=sRpCbZKrW0jrH8AxSEMMLddMJsx029WP3PfX2rbh0512kZc1TVTNvdLKPb66wNoZvIn0PKAd/jUFsUiWSLUySGUahvA6fAWOc8IchHwk94ucp9aFIFIke2aqEuvfQF+H3k0E1PWPp8FkNtdrBDKjFtnHZZmWIRcHefVOREkLYrG8LHFS0UBASakYgS64EQxofKOWCu0f1eWgkICvUW0tVuwwd5H4kbT09XJcxg7ZVDHOBSGri2v3uzPSZPNLMgid/SY/0NklF9SeIj9zDvMCRIvHhPbHZ0s5I950vxLtPrmJN0Avwn63M3SKWpRjRL8xfPFLEKDYWt0feaVnvVbeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkhVUxdZGM200CHt0vUHmfOsei8N9YtECSNOzSHX53A=;
 b=FmSkpdlWkmkG2smMa/q/u6rwZsi3i+bVFmpl1rMECwx8SK5LtdPo6ohPtRLlSbP+mZtfex4hA+z4lggZTEAUtqN+v4U82HnqrsG3WFSmtYa7UirzmnBR8gCaxXdF0XcThTVuBndveLej8K0VGoMemJZhxVcOqVilEnHLoJrJYa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:28 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:28 +0000
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
Subject: [PATCH 11/12] arm: remove volatile from set_gd prototype
Date: Wed,  4 Jun 2025 21:56:11 +0200
Message-ID: <20250604195612.2312979-12-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d57ae66-e166-440a-514d-08dda3a1e4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8g0EbAURaNX1DApt2pJC7TBVxdociA6kghrzDyat2rrok4wbphQfw3VBYzix?=
 =?us-ascii?Q?YqLkdan8aGsrOPH/8KFkydV8lwjEsscI7PNIkgHfRnXWG6OjilXIHQ3UiC+C?=
 =?us-ascii?Q?20VbJwBWU5tv7Q0TPn3seLZ86CdulZl7/feBvfoL+V3+f5gXQXR9/qqleh2O?=
 =?us-ascii?Q?5qOpS1srLb225sbtNQ/rwSc2LEb12xXRmJ7Lj1DlYhvTEuNw3CkZIacL4kg4?=
 =?us-ascii?Q?bk1weTCA95D9uarzPkYkt9pNmMPPSb7L41pg+u1//m2+r+dOOWlznqT6Kbqu?=
 =?us-ascii?Q?nE6iugMgso7yeov+usggYIKg/iULZZV30TjtAsJg5dnS0m451nlGw7SzvKX+?=
 =?us-ascii?Q?UtUEl2c5ByRVE2UccDAByZALMNBLGkZWVfoSpAUn7iX498k3+2nuSp5Lyych?=
 =?us-ascii?Q?mgMynDWhlGSblBg0ku3vLT1ccU5u5ZuZTaWopJc/4GyzT1/GkgjEanpPzm18?=
 =?us-ascii?Q?/HsYqUhaPPBjdEmg6Rk7MfSN0SACDYgtLUTTtQpVFxupJJtPMqWXGUlLRruK?=
 =?us-ascii?Q?03yg1tGxv4eBUusNDNweAlt48JBX5K1Xa4Q2DKUwQ7qiTmlm0cRlKG7I//5e?=
 =?us-ascii?Q?jwP2hUvvRyMX5IQzsSmro3akJRy2lKmwopHM6YeBk8JLIHee/dkVnOjycv1W?=
 =?us-ascii?Q?TF8QtHzWzRwIv4aO0aPeknNfGZe7aEykOkrruKHU7UMOkggP36xl5+cpBCMt?=
 =?us-ascii?Q?LfoqzGuvU3d01YL5s5UcIv9uW/yzWEAx+advYb1SSpP94XsyISgiIaCm2FOD?=
 =?us-ascii?Q?TAnkSUBDhakBj8TQgmSCshf4yvyj6s/5/delht8NMbSvN1+vXIej0uoZPXE7?=
 =?us-ascii?Q?elXetwH9TQAJiHwnroTD+zAs78V/2t60K8DkIXddmB8Fk7J7ftA3mgHTfUnT?=
 =?us-ascii?Q?C+v4sTg12FWwh+56pKwXTIzoVCWjoixrXpgqDZpJbuZjXeO6bPnJjWAVxg8Y?=
 =?us-ascii?Q?4pDjZkCAiqFeS6MZ50YYALfxud4nPvqihTjLimLlok+q2c+Je3ivxDV/ljJ7?=
 =?us-ascii?Q?m959ItAQUZJDAk7B9AUZ51VO+/K9Wfb/8dgvu1juATVhdTHV1Kj5OifjJD+J?=
 =?us-ascii?Q?l0y1yIXUve0+JUe6UzjUiKEUD2ubVmqGA56XCt++cUwlHpT9G4Vx9wnNXV/c?=
 =?us-ascii?Q?SCvvFSGMYyM0h/6ifA7bAVTKooXCSOp43UmWI6SIYF/e0Q6HPuVPFwklQNA/?=
 =?us-ascii?Q?bNZ8ELo/ufuWOdxHdpASU1GOIdPvRgCSEOz80CAj/c9gD52U8jVFCICXx+5e?=
 =?us-ascii?Q?mHIo/q6QeG+dZuJBvzOCTAO1Wnnm5A5dyUoE6hdLc4bftNTa5yD0+Asym8j8?=
 =?us-ascii?Q?tWD4UzQj67eDBXWK1QlU//GXruykYKOpNyvDhoopakHb3laN3SIePKYZ7npK?=
 =?us-ascii?Q?tBx6rfB/wyCeIhhulqSTsH+lXAhE8klImO4vUg6m/w9G/rMJNvsYSD/bhC1m?=
 =?us-ascii?Q?wd0xfi78dSlBYws0A5RLsQdroRTl3LWg1GrOQtHBUH+vwfehbSwRXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhXLuAGS1oThf3PkgzqFHoTCDvMvucoaZ45DjwNRB0SzwM7ubm5uDvqxcc1P?=
 =?us-ascii?Q?MNkhj1GyGQsDsZCRvzAOBjKQamsJHDiwt+LWD7TNvY7+hlai1Xn4oI9YTiRi?=
 =?us-ascii?Q?nCuCvQzzZfnHgRjW1MBffNI11rbqr1tzMX/U/j8pvaWj3YfumnSCJZ/f4IgK?=
 =?us-ascii?Q?McUnL/rhuOP6jKE63lSN8MT2cCDmINrcmTDRkJZI3unIU/2FtLOmt4JvUtwl?=
 =?us-ascii?Q?HITX6mYKgQbigdH6/sgs8cN8vr/24j02cuOtvWiGL/pByybA+rf1pKR9bsn6?=
 =?us-ascii?Q?2ptLD8b9UYUypfKgs/fQrr0qCCkwV/7WAD6e/mkEZ7WIBKufeVKlQK2RYlL/?=
 =?us-ascii?Q?66HfPCFvtjMGLOQMl7gj3Ie4ZKMBIbJhkznipU5PCleYH1rr46A5f1S5XutG?=
 =?us-ascii?Q?gPD5+1Qf6B5sAVhpbvQPCikqikfEsu0k1JUe3nMvJ/8xeZVUIpJFSaDVgvuE?=
 =?us-ascii?Q?ERc3Tsr8u/YmHT+Nuw9NWSayl66OgwrsP+jErrhMtHdUVBcXGbt2XbZ6XX5V?=
 =?us-ascii?Q?Y7GkcNzSJCRjyiUn55aTFUAj2jHpPwj2OjsfxwI5ZrRJ2UZ58k5NSRf2HWYS?=
 =?us-ascii?Q?HFQi4QUhfJGuqtFO9KYhSzns59xVay4GQKxkRgoT+u5ooGzip8trmJ6SVazA?=
 =?us-ascii?Q?fajxWU4rJOXPEzOFeVL9/4qe4p1GExb7ux06i8FrawJ7cvq0VX+ftju9VrLR?=
 =?us-ascii?Q?XMDNbb816TuvrjvZpgoa4qC3ewdLAJPi+Y77ee99bgARQ4kNB9RvIEevcdmC?=
 =?us-ascii?Q?YuE4+v/nDxqE6KZtbgc7wlLzCqpzZ3/HXOpLTofyG02lyEMVg7uzwQES2ZDD?=
 =?us-ascii?Q?/08oRzuvZr9JItryiq0HovuEhUtn5ovdo6q16t6KCx9UHyGYi+dw8TiDhGb5?=
 =?us-ascii?Q?rlZGdWpp5HAep8g3T3L2unM3Zo5fQrgmiJhSTzF7iY9qgFHKKE5RPMqnI3Ry?=
 =?us-ascii?Q?amsKq9t31Id3Wm+HwT7zIO5F5ewV4z5imBznx0uv57VayX36XBRAAxshTM3c?=
 =?us-ascii?Q?v92tKNkfAARYIv4EmGfPw09GFt5sEWypuV21krY4TuaIDo5ofRWv/gaSXuQo?=
 =?us-ascii?Q?N+zFsq4iKYwgTTDOfMNAjtrD73EI+DOV/fKTQ1ikyouj+j2cbMhLMbq4Ppeb?=
 =?us-ascii?Q?QIcbLvDsPPb2S2nSJ1p51CvWeAIkq/Wy4PDPQHZv6BMrLUEVQlIW8pR/3F0F?=
 =?us-ascii?Q?mgThysiD81yyTsA0fKQikon5OJJcQnSnEVGrf1+CwxOnRSLGmlwrBeZHAcs8?=
 =?us-ascii?Q?xYZbF1c91tbPImWg+QkH3zt8bwRiHzSt8cFXB7KSzv6tJHJ24cd2AxPPa3sp?=
 =?us-ascii?Q?lu5XtadetY8MvjCITSCRErTcOKVex3LwP/FSSnmRaN+tDyAdOlk5zrXSnX/l?=
 =?us-ascii?Q?dKMmW7Dn1KcNCnoySSjHTVkqxVuTj9yG7P/ctU8vZYavyVlOjyAclSapy9Qk?=
 =?us-ascii?Q?Sz5/4yQqCv/zHErSx9WucFTI3etIJ7ldJ4wTdmJs07n/uXq6aiJQGH5LrUgS?=
 =?us-ascii?Q?Q4LbyvFvZm/K/kbxvKi9C6rexENAqpizvzNawGJFXAIjQmZwCVQwceer0JUK?=
 =?us-ascii?Q?OuS3GZRBhEibUBJFUROZ3XBEhzB4YrGAR243OJT7LlXmemIZKvFO8M1MlPBW?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d57ae66-e166-440a-514d-08dda3a1e4b9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:27.9837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn/Yzdlf04t01o8LxJHXp9wYZ+G0sPKYk9ElVfNmFVn3dNlEnl8zkYQT1vJYiqgo54ooYiDzNh6myeuzjyTt4KKfanZ+nO/OO2TB9KZilKo=
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

The global gd pointer is no longer volatile-qualified. Callers of this
helper function have been updated to no longer use volatile-qualifed
temporary variables, so update the prototype accordingly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index f7a47204b7c..b2ec450f900 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -139,7 +139,7 @@ static inline gd_t *get_gd(void)
 #endif
 #endif
 
-static inline void set_gd(volatile gd_t *gd_ptr)
+static inline void set_gd(gd_t *gd_ptr)
 {
 #ifdef CONFIG_ARM64
 	__asm__ volatile("ldr x18, %0\n" : : "m"(gd_ptr));
-- 
2.49.0


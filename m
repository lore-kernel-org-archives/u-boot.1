Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43E6C25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 07:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F36881EA;
	Wed, 15 May 2024 09:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QVXd5qS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F3088216; Wed, 15 May 2024 09:36:27 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFC288179
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eovo64K3/TIOVzI4X7EX43NYmXZ+f6TM8/Nieas4NjyFUS3OGTKcWpvN1iHmNt1me4jLCAI22ThLF01AK4rqS0hCSMlPUtSIGRkEVQ2/py5qEmGuSR31jx4LmtBguJFgoEuXZGFg3p0Dc9qUjWUWjDIAxn8ZXBwECi0DQGp5y4WZBSMaOIo+0RyJknT03SYtP/RTRRwWWfa6ld2YGBIlboVlDFOwtXBtyq0AjdQoD6DYBdQfWLbH2FBSunSbw3E0L5ZbEN/bVMmSLW6F3UUykHdqiPq5Nh4h+BMyCtRVMLNGzkyv372ftK93WECDr2K0Sw22KIb50BekZqaVwErGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VutGjmpAt065YF+mDpuFPxFFRfB9H+i39GH1VWBCztc=;
 b=PIfGgDOHN3at+pA1YkOGojCJd3IXelGxYwDig9BcZ9EDiNGd1pBuPl6V/yq9+RA0QWHaTe2gppEaU4QjtqBJtCRuCZUI2rXyDooA6xIrsaTiD+Yycue1PpGQwWJsy5PAid+r3ka6xd9UeP2C4JTSznb4wbOslM4tt9mRXn1gdBe4/tEaxbfnRERd9fkhQbZtMIdKxy2bFn9jMC6CiVok8EdpqWmekkJne4hcj5AjQqisZkfrHHVOECiHAIlM+LNC/GxGiP3DNbodmZH6N9s57DZvK7s23VA/CdBV7ODUBhTVk5CRcLkKu8tarwUh4Hq8aYWYw05nrMNMiCSnoWelaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VutGjmpAt065YF+mDpuFPxFFRfB9H+i39GH1VWBCztc=;
 b=QVXd5qS/1vMjWo2y9x8SLVt3bu+zcBHbPmR3g6+h3Bp7J49NbGcmtMtbpXDl4/1l5z78HupADph41JSerqRDaHqhlC5ypviXutEqGpgmqKW+/6K266t4kgn88OwvRZ0Yg7UvXCKo8KOytKKJbkzHysRDXKVfrqhoj5hfyZ5eRo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA1PR10MB8919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:36:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 07:36:24 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/2] Makefile: refactor ubootrelease target
Date: Wed, 15 May 2024 09:36:11 +0200
Message-Id: <20240515073612.1511149-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
References: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA1PR10MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 068d8fdf-1485-4953-f883-08dc74b1b8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yniVXuHEhaEuWhX5mAUZHy8OqFHocBllbuZpgPbOnhu8zlGpv134TBISg+PR?=
 =?us-ascii?Q?7xhtTQEFNdeD5turk8nEFndHx89LpONC6mRMpsi2vUYH1k+2l8rHijF2eUbJ?=
 =?us-ascii?Q?XkdVF+AX0mOSj3XF7nz/1mMJDDQu8rG8p5hPY+U8+z33kLYhliXVozmHQ0kp?=
 =?us-ascii?Q?9K9lk3onWJYJONn+7AL4pHgMDmNepTdfRu7a/g3GcT8TjmYuFpvZloOc49ry?=
 =?us-ascii?Q?LTvAHoOgojic/4Dw2wXc/7uPePXWkSCOOe9a71Z0dSts43fQi7Wok1otydCi?=
 =?us-ascii?Q?S3qiWiQXi6EBeNb7K5DLFOZWrseHjQY6f+9WiHR+llJh2FBywTzo1pl8fUNS?=
 =?us-ascii?Q?LO5vLolwmJjENpJwLidz1HLrxVfnxITex+KO0HNnGdzxcPI4r3hEQP+62cCj?=
 =?us-ascii?Q?zqI5JDOfi6dwsQsHQUafSGZ6cLZASW6tWZifDy9eHeRV+pOx2Dm6os57kIWC?=
 =?us-ascii?Q?M8wVAVgp7DF6O2gJXPzy1rkf/PZhsybHTvP+UUzioAcHyiWoqxw/J+FbqRp0?=
 =?us-ascii?Q?Cis61X/eiPHkKNmCs60SmHAkm07XLyTXVEqMJo5EINZGo4Lg9yiYpegsP/iM?=
 =?us-ascii?Q?6fm35x3ElxM/rh1MAmXIW6FM663DJUTBzZmA6vBDFTTBPB5sWgaC5IjtoVLb?=
 =?us-ascii?Q?qAaBJ14lRsBqgfY2lA9dhynj6WfB6bPiXe8TuBBc990utqzAvEX6Q+Z8YlYF?=
 =?us-ascii?Q?i0f/ogSU66p0luRqToAmGaAJjXbt5EXr50swlB9661lCSAc3xeNmGT3VWzqF?=
 =?us-ascii?Q?wtgw94pTx/xkkrChbHRRZwTQN9W1LDTkVGB/NM+xghXr+FJLEZP0HSGNlbhG?=
 =?us-ascii?Q?STkQlFcnHu+T0oUaCjYmTprCMJrXMmO22cM5QR8cEyLX1Pd8HqOhvqn90KKd?=
 =?us-ascii?Q?9hksuIhfCnnSex/lLED6lSdokUjXPEJYJ8y7hmJYGsM8hViX+tTdmwtRjcwe?=
 =?us-ascii?Q?e6j5Zwmfg64o8p0tZcsvLai+9X9LHZ5CZRxtbrNvehysCZtkpttG8wyObYfX?=
 =?us-ascii?Q?i2/16lZCAk7UyiV7XZB0+nTBTkcXV2QWfrf5bVtwouTMp1aAMMl6/psAmkg1?=
 =?us-ascii?Q?j4A0Et47WZYGgGGFaDksIp/++OVVYRMUOwlA6bl8SEdO5F6UzYSM64uso2Wc?=
 =?us-ascii?Q?psFhYSfjHnm5yszr+sr4a4HGHAzbDRN+f5BJmKMkldTMlr0etZ8nDhnuSwOR?=
 =?us-ascii?Q?ZcyiAylXswlPvEmGOv+P96mYOXWvxtwsYDJTolDq/si7PZI5JJ7Ntgi6IWTi?=
 =?us-ascii?Q?oPEtfdaxZ+yYYkEbQXGl/A/vJruTTHCZIqXWoxdu9vKLD8R2XN4YWtU56twy?=
 =?us-ascii?Q?gwsr6psRC+PLrOfCWUTY5qhEULsBz5U+vLkQ09gsm/w2VQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ma2KBJ4XH5yY/i8qtFPoV+XEf/y0KU4Tg0HWgFxuq+wcuxSOa6o9IQtEPERX?=
 =?us-ascii?Q?kO7tXKWYkPtCFMTVKAX9H+ZgHa8BwR05wSSYIQ0qedWn0NeL89n1ZMXyQPZB?=
 =?us-ascii?Q?Qg8dQmK+j+/5nUNAgbJNbWdqOsYvqmMJ3dOXgwA2DSn5wTtvFJnfhdqAPLOw?=
 =?us-ascii?Q?l5ulXch7+iBY+pSNIJTmy8qAL5FtvM2ujiActgsy83zN5CQiTcVpPdwXMq6F?=
 =?us-ascii?Q?+DVGeKU3JQwLAnLG7CcIQzpHKrSh+oeeTHan3zsahjBPt68UuOADd/GOablE?=
 =?us-ascii?Q?vP5X5TvNYbRardxOX2M758RRVJcysU97OIUfTx04zWnJI70SfP6k4s7Ksezu?=
 =?us-ascii?Q?bFemyolL0IpSkG62wNp24xU/4EXUl/CG9KArWKmyisBljHHDYRFaNBAHTYYL?=
 =?us-ascii?Q?OyK5rq2cLrYeXTGNNAff6eNx6ppQbbN8CLqTqusQpBbgpxEorvTF/my9HG6v?=
 =?us-ascii?Q?vTVENbYh61hvx1yvLdXPZ/rSFUkwhHE9zKLa/5sm8MSNDTEWBfZJKKASU0av?=
 =?us-ascii?Q?VZbY5bTCEZ9A9CUretgL4er5iPUTAv45KqWQVxYwl1YsxFhNclMCsRt2Xwg9?=
 =?us-ascii?Q?AMa4KjgsStEBALW8GHjp+IhtR7s4vmkJHauq2lL56qIZXMOR61/kYHeaioQZ?=
 =?us-ascii?Q?ySML9ob1i+gfyhRaRoytZfNfWBjiMQZvcN1/ZXFoyPnXoTcqKUQYJ0A6UWqy?=
 =?us-ascii?Q?BatpxWbK1D7pn4k0g0sMrZQjLtg6i+DETrjvFkHpmtRhAcCNA1eZ5ZOF6KUg?=
 =?us-ascii?Q?1sVaiIk85Z04mst49kJZL/o2eaJACZV1EW/cpob0rXj2DcGQx38Jf32kGNIj?=
 =?us-ascii?Q?Ir2XVmZIncQiK+OvKIPV1LpEorvEfy4A7WDRJST0vAGDiwvb6orToTXlHrg/?=
 =?us-ascii?Q?7JB3q704TDcTkpCa3Jsjdb8TcP7wWH4nYeX6CZI6X0mHDgZhM/UWHpsBVHZI?=
 =?us-ascii?Q?mvs8qT+MsQxxTO7kB7z1LnALkBR1lnJ2DuwZrz76bwBVGSFGOw0viguM/vpf?=
 =?us-ascii?Q?TUBvLW6LDJt5f4ExxsDB7vzVpzXJPF8s9FilstFj9gsK3eQXzixbDx5hlIw0?=
 =?us-ascii?Q?tQVKrb36ZHQZgZekesjwjo8JdeJ6OIsIjVKQX1iMo0CItLU/JKMmll4IrSOA?=
 =?us-ascii?Q?sYncoJvWpJcgXSLQYsqR3uU8B3JwkK5zFT/iVekvbalubgKaMWjrPNjfyG1X?=
 =?us-ascii?Q?s7uTsEgMJMXgg9BrxtfOSxpi1XGRmk44Cs7fUAy+mpAGlQArq6ifSnw8dYfI?=
 =?us-ascii?Q?4b23oKLfwktYt9Iugdk+QQigY8CNNmig32Udp4hlog97O4xH4wic7upFRuPj?=
 =?us-ascii?Q?WitURgFE3TcZdYUl0wQkkngM9qzc+f+uzxqcqPRrwxiIUo3HQf7HqXj6nFBf?=
 =?us-ascii?Q?9t0sNH48TbKLK07DDOVRbAi7eIIZmbwE1baziqj+ziAmJ4unqIPyjyIos3LH?=
 =?us-ascii?Q?pgosD0Reo8dYMSRjDxOqoYUEo12Qll5D3HzUOzIR4y9RE2AmFp4xkkp6otg/?=
 =?us-ascii?Q?XZr/3I9K0waSNCNiJuFZRDnSyw2TCSIBCgKo8FBcK7CqgslAdKijU7K0C36v?=
 =?us-ascii?Q?4LXqt0YbuW4qmlwUyXfbawZYPK8CEF1CushWGdYgT88wcWgtZLsAuBIRB2iN?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 068d8fdf-1485-4953-f883-08dc74b1b8a9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:36:23.9894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pRyXlmvG0k1jI7CnfQuaup01q2tE/ZTklWldrKNhM4rLIfAIngJ9ZH9PT+oM8JkKCcU3ZW6Kbpyj48ormEwJjxxV/PQK5wB1CcS0phUYFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8919
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

Instead of duplicating the contents of the filechk_uboot.release
variable, use it directly.

This is preparation for the next patch which will modify
filechk_uboot.release, and reflects what the linux kernel does
nowadays:

kernelrelease:
	@$(filechk_kernel.release)
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 44deb339af1..efaf24e58e7 100644
--- a/Makefile
+++ b/Makefile
@@ -2426,7 +2426,7 @@ checkstack:
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
 ubootrelease:
-	@echo "$(UBOOTVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
+	@$(filechk_uboot.release)
 
 ubootversion:
 	@echo $(UBOOTVERSION)
-- 
2.40.1.1.g1c60b9335d


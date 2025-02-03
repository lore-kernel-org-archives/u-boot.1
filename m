Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B6C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3758039E;
	Mon,  3 Feb 2025 14:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="vqD4hcmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66C9800B2; Mon,  3 Feb 2025 11:41:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E012B80087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX+IL7Ot61isoQmlrGICM7ryFzQFYxyanZPoNAwQLaVKcZ837VxbPs+LHXVG5K/2ac0WaNLBR5f36Tk3Z/fcRn7Y/w7Ksw3xIo0OnGLY/d8uOGMxIMghtshZjU0lxp1B+Gg5oCIl4sN93oiwA5nkvLVSVnvcGVC9d3PQvxYp2Zj3lvETn3aypFTGKup2AskYG/mxOl/E4SoFomgKxWWHqdiQZnfR2XTukwJpQx9NzUpYgp+CfD/kyXI6WiEcEdRoRooxWnbRZkXXUikDPujL7CJlnR5sTSNQ/cmpJRi5OLdOcH6Dn3u0XVbvubEgVX0IG+Et5A74ufYBi02ZVk3Cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXu1wArD0vRGKHpB3UtG8n5zhXC4+qCkvDwTzkpl5AY=;
 b=madZG+JqfyZ2RV6EDr8H2wcVQXX1HK2aPc+W1DKGgf0vbwS0NopOF0bFO+RR26bktXXsL2NJaXzVFMgEjuCHnSX1P/FJ7g0KUSPZ9Wu+q2CyvEgU4BX0TIxXRtPeORcxPY4g393+4zHY920OEOlZqX13eyJU8pRD78ZxTmkhN1Hq7fyBBgMymQeMFqyPVAS9gduXC1hSZoAE05JRRZ+ktGaQF6kArCUrKMlIprKvZ8WkTrBhkZVQtb02fAt9I7GIx8O/lE0ExdgXNXcvfWZBxsHKlWPv9w7NDFXzMqKNaC7d6Nt7RL7sevDSLCv8Rk+AWzESSUOBD7Fezbsal6uu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXu1wArD0vRGKHpB3UtG8n5zhXC4+qCkvDwTzkpl5AY=;
 b=vqD4hcmFWz/EuB8dq9+GSHpF++Op/E0l88bKCTJtFcznWd++rgM/wfGXSpe9XS/GrtzIF1vFvxd29epC36+0P19TvzJr1HcPMtKqrhrzqElpPMV7b4ITaF7oe+N6MHT1J7/j+7tx5k1H/kkLB0x5vDFoFAtGg5FwrdGpNyGPU0vqDdkS9gZORFiPSomjlh9WF8qQrH2O0pXLB3MtKDLJB/Ytpi8tk8UWI0Q9d8n8PKW8jdMyujGUM7vNUKlWhTIt9QzQydNy3pcl9b2GDwYz1x5lM8BUjmK14dOFgPGGU/0n0BHXW1hQclOMSgjW8+9ZTGWIs6I0iWQZgFxeCnpHzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by AS2PR03MB9394.eurprd03.prod.outlook.com (2603:10a6:20b:59e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:41:53 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:41:53 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: Manuel.Traut@mt.com, burak@gerz.io, Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] efi_loader: Support for file renaming
Date: Mon,  3 Feb 2025 10:24:49 +0000
Message-ID: <20250203102501.35750-3-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203102501.35750-1-Daniel.Venzin@mt.com>
References: <20250203102501.35750-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|AS2PR03MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e55bfe-e412-4eed-6cc9-08dd443f5f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ZXk+Pc2BTyP4WkHAU9suLDdn8MdWXd4OC/Rn1B7UMnew2aIa+CvRoEmnBa7?=
 =?us-ascii?Q?Xs5LtaxazqBmPHER/1N4+udA14jxLpSnl2BlXQeciUWRsWSaeWuj31wzWZ7U?=
 =?us-ascii?Q?t1FTj3ApiUBbkdcpi/1tkUASfddbwlX+P93HW7Zbb4cX5Or7zVs55acJcGkk?=
 =?us-ascii?Q?eAsgOcEo/30g9vTHQ6iB5zZH+5mHkkNz4AZHxrrdnZtSba9pb/OyokzZq0I5?=
 =?us-ascii?Q?tkuTUUmtXrCC0XJk9k7yeEIAGZiw2m2w8e+Aa9k5agwm28dmof7xl7ErZkAK?=
 =?us-ascii?Q?sHdM1FM/sekbkA8Uv5+Tx39ah0tKyLs+TT6C3jz03fXAnQwrbcAN64YEgnO6?=
 =?us-ascii?Q?xIc9wQ1bygnSX0RgX6LqTo0NJLEdOK1k5NmUZMuItJTX2KuzVIrxf6yWOq8b?=
 =?us-ascii?Q?07eci304sZEjYU2wJgDu7kj2lOCD3s7UGi3RF/aco8JnlgdYvzGh7/MISjBn?=
 =?us-ascii?Q?klZnefy97ho2lfNW/GOqOltUajstAPNYjaSpa7V0cKzLPlR3p7crj8FUsvyj?=
 =?us-ascii?Q?vW00JpcQJfq+HURe9DXQsx+vtjUZtz5xM9ohBzN/Gs3TEBjwZTmmLn8AsAt+?=
 =?us-ascii?Q?r+xQ+19YJqGdwv9gceeaMt1oEneif6MT2+CMmTOMlGX8VjQUB+UyX/aG3yJm?=
 =?us-ascii?Q?c8B4l8hvHtKAqu1We2G5vfH7QjLNLKCubQ/0Z+pu9ceMMsszZaGpPVyqpMjQ?=
 =?us-ascii?Q?R7By0i5tgOLi6gPW3pnIB4joMf1z9ePTYwUtCPWYv6g71yh1aKxvYvMjgUMm?=
 =?us-ascii?Q?rXe5/kYFVFoGtGNGjZijrvKtNkUh3y2yFroHf744EGg6jTJK1YJU5NlvwtIs?=
 =?us-ascii?Q?XuYvj50VGUtjfm+l/FO0vSu1Jg38/M6dMWmLwg76bOHRo9dMR0l6PbBKai6n?=
 =?us-ascii?Q?SRBaNLFGIzWxtI8ubtxzQqAPkHD2hW1+G5NhoaPyqJSzLVVcTn6ohRB2qOTV?=
 =?us-ascii?Q?uXRcMF3JC8u5NdAGABM4XBLoAEFVUbARbsIHNp3jycblhYEXHzGW+M5kZ9KU?=
 =?us-ascii?Q?kwcJCFSdRc5XJ2xZh3VhTOtoYw1wJje1gA9hLnrdLGJSVlQEH/YbSUkJ3wWY?=
 =?us-ascii?Q?1/s6HTB/PascxW3z5LpDmABQKba/W2zW19BTJV+sq+/NWU4PqO/YDECGzzLd?=
 =?us-ascii?Q?Za2B+XiXgOWebo1s4cKJDgaVMDvNw9obLrneNPQ4xbZ0UF0xY8wMBdYpS/T2?=
 =?us-ascii?Q?FPst85qCc0LV/+2LTsNt9FZeefTz7FOdgtT1ozi1ht15CSoLEePBSI8q4BC0?=
 =?us-ascii?Q?qfGsqbD8QFfVmiETIii28Dux6gibvOlUuhhIPCzFHIOYPFCoqvaZOTyPwnkr?=
 =?us-ascii?Q?CEAaNTKgdhHUSuns0sh/SZ/GDUl8oV+AbXte+4QvTZAd9Mi1PsvUyBkXcw6Z?=
 =?us-ascii?Q?sp9z4S/kBWNXcNXu2AXeVWON54RwdJbXfiG9vfjIA8dbBTaZsXWXPI839KY1?=
 =?us-ascii?Q?ESdfB8DVFXAStQ7y472l0+KBjWVj3ZKY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CpZGisU8deG6LV1vLDkTA2sJBs6ECHXssCiy9CuCzUN3ac6YavjgDIGUE8D8?=
 =?us-ascii?Q?bgWU0o7Dr6RgvrzBEzvL0rFv9q+P2x2V/ymCR2jYVKJeBGhTI8JZ0Fg/XzYO?=
 =?us-ascii?Q?4RohWMaHpWn3DeZAxjATnmVme6Toy/mCEn5wL+coL5RHSisinPXj1FSp4wwB?=
 =?us-ascii?Q?ALGD8oMGzAU2rqz1QfVCzHxMTUlUpC7x2cd+EtCeTcPMVAavzRxceq20o4C0?=
 =?us-ascii?Q?QIYBQh3y2/f001VWOthJji6uJQF10/dsEBXDU1OuyAdwdzOAGOiu/RaOor+V?=
 =?us-ascii?Q?/k/3rIMGly8pTA95DBQd5QJ86++t0lwnhE6Tv+vghj2qJwYNXTm692TRb1Gm?=
 =?us-ascii?Q?8PRn00meX5UVOuy2/v47gTPuUUXl9rud5zroaz8IXnKRiekKhGITY7Z3E/Rw?=
 =?us-ascii?Q?0/l03GwZhDSyRZ21EWg7JFUjqUSEKF8E56n/hKu44j+0XGD2/jCn/nragCtP?=
 =?us-ascii?Q?LURAuD2oJoempaRbv5R3MRRFb3uvonI6vGUpii352fH3+EwqKnvJODs3plcS?=
 =?us-ascii?Q?aXewMq3NT9nnn1/X3chumr9Z03rXJWStSunNljZJMXmeIsPCx49mgnFG0Utd?=
 =?us-ascii?Q?dTNO+iZ8XLz9nEVzn8kvQw6GVb6+22OidvT83QPL3mxkGmrG3sOFWhYjkzn/?=
 =?us-ascii?Q?7raTTTqbyt0yJLFBAbikNbIRi89mVf/6AhMNcJoKblESJHDyHgBSYHz0bLq0?=
 =?us-ascii?Q?7bgUZsakh+kxQjTOsN6XbobuO38nDUgCOVn5c+FjFE5TELcT3rXlmOVyOILC?=
 =?us-ascii?Q?+RLa88Onm1nrniMvE3ID2bHWmKTsefWfIO7mSvTqcTswTE0V5aE+/0OA3lWR?=
 =?us-ascii?Q?Thv294toJu0NjF5GjqPf+A0HEiOCP+nogVdLjGQH1heOzxVCL679MLokVpX6?=
 =?us-ascii?Q?HhxssWVOxqcT4JYxej4zK5dnOTmN32I30Zawm5z/2uuZV4fjvSw8+MEY0euR?=
 =?us-ascii?Q?oMqpw4a7YyloCffTk3ACv9R8bOoDG01zmtMX0ANG5wLSHFuRbR4FFpPbSDqU?=
 =?us-ascii?Q?Rnouap0723DItyWsntPDFW41d/nOC5bJonD0tNi+HGwtviGEdyMBAkQ/FCOq?=
 =?us-ascii?Q?FwI0fjN1kWSDM4GY/KSCHoGnn8RnF61a6FJeBC639lW7p/6uaKEsGs5TwVyh?=
 =?us-ascii?Q?R/fmlI4UCQOsTeNLtCvdtS0alo95sNP1U+3/TyPfzkAcM/ER/QT4x5yvJ2ub?=
 =?us-ascii?Q?M3wFcEqezhz8XLOUgueDsS4t3SBQfhBCWlKO53H42Ac3UIZ+28HbsytBkMm5?=
 =?us-ascii?Q?UFj6hMzbeGzUK8aTBhmpluPIDwOSXPyM5x9eQaqAuilf0GzLgr26AIdr/4tI?=
 =?us-ascii?Q?DKT/Z8+w1aFDfXchyxj1djPp8Y5rlUt3kkmekLH6ox1QbsngKWg8R5aynSzF?=
 =?us-ascii?Q?CdE2cj4oH/r6X//gIeF/ob3LQtpu/WtkiyfZXhcKPhg9/NRU9kzaaMRFP8kp?=
 =?us-ascii?Q?VzBDfn1uIFrRtP/dQRbscYaQUZK7Rzt/rrAa/gyKa9H+/PidzdR4vQpX7gGL?=
 =?us-ascii?Q?0zTEdHhTbQKt3G+Wq5djja/UbOKe7Y7D7o3iOQeBe9HauMy7Q8ea7TtJw7w0?=
 =?us-ascii?Q?x9BHLz8xA25AqbOprIFr9XBsJ3VhLOEKXXFyeHPE?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e55bfe-e412-4eed-6cc9-08dd443f5f98
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 10:41:53.5331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvBpMFor+HZ0sfPRCUDE8YpKjYk+eHyaRLguEiITZjLkR9HV9OR8JD7eh2FWio+QmV0xpfVY3++M8mZBRofHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9394
X-Mailman-Approved-At: Mon, 03 Feb 2025 14:10:19 +0100
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

File renaming is necessary for features like systemd-boot
bootcounting.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v2:
- Use EFI_ACCESS_DENIED for unsuccessful renames
- Avoid using of "== 0"
- Move the call to set_blk_dev earlier in the sequence

 lib/efi_loader/efi_file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 201fa5f8f3c..9a5a345bfc0 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -969,6 +969,10 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 			ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
+		if (set_blk_dev(fh)) {
+			ret = EFI_DEVICE_ERROR;
+			goto out;
+		}
 		/* Check for renaming */
 		new_file_name = malloc(utf16_utf8_strlen(info->file_name) + 1);
 		if (!new_file_name) {
@@ -978,10 +982,11 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 		pos = new_file_name;
 		utf16_utf8_strcpy(&pos, info->file_name);
 		if (strcmp(new_file_name, filename)) {
-			/* TODO: we do not support renaming */
-			EFI_PRINT("Renaming not supported\n");
+			if (fs_rename(fh->path, new_file_name) != 0)
+				ret = EFI_ACCESS_DENIED;
+			else
+				ret = EFI_SUCCESS;
 			free(new_file_name);
-			ret = EFI_ACCESS_DENIED;
 			goto out;
 		}
 		free(new_file_name);
-- 
2.47.2


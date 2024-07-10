Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D82BC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE9588700;
	Wed, 10 Jul 2024 09:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cTHiW7sL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C782A886F7; Wed, 10 Jul 2024 09:17:31 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC07886EE
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnW43Wroawf8D96wZ1sXNemB3oXoQwgcQEj+V03ShlG00bzllq4z+cul+RV5V6q36i2zvp01f5d+Bj1EKKhDYVbSXvsYcNcMQ0W8yEftCdwgXc3p/Bple2BwnHs4VDXnv8RhLUCT9yQVROv20p17zkMDUGWOSIPWqBWGH5P9MIuRmkEnZ4wbbT+8JPzjU/tisb5YUwkR7ZPAAFrD2z8TCGjshf6B1evyZeJw852jkarv4icYfK7bPrIxU4toyPIgS9Dz1M8z6immQXGllzf8V4/rCW2KJbAX4nCGSIN8ReuoQTs+zr2YuRvkSL/1i9rMTZa4xA+FrDMYTwajilxQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY6Qbkw1e81XoKTGt/Ulrsc8W0IQql8CK3hIpR2SMU8=;
 b=PJME0d91oGa1FwGv8cHpwsynu+XLtVBuHZWLWQXfcF2AYWmzBy61MuNTBLwhJAvUnQ1GlG4iVixlhgiglc+932Z1utvWVbeXfCL4/nodU62qyFE8zlA8y2yOBfDhvKWMD+2IYpZ3bCSY8bcoTAbYErZrBJ7iZUTQsJQs+yA//wTTw2L2m5L6T1meOc2aVgiONzZ5UHQVoivv/EkIptLSuYfEAwdzNC/Ins7TnxsPKUO7uj/ZwjKD0LHxUfIdON+r2qgW7M+lexSwKjGulk84tKCl1LnCP8JkRTXW81KedJ4r3WqU2O1PUJNY7yTZCMvP6cz2UAdsOC32zWUWkrahdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY6Qbkw1e81XoKTGt/Ulrsc8W0IQql8CK3hIpR2SMU8=;
 b=cTHiW7sLYs0G31wn5SfEkmrjlzN/nfR6F00nqRLaey/H9F2FIzU1m82Ya5womzz7bEhXLNNihWGWkk90zn5dCKSHCDUqtGeJCg8BOHDVnWEyK/XEZ9muJFwV33A04wjXotTgDVZScZsmPt7fJwV+WfYHPGob2t0BeoYeQM7/ceQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Wed, 10 Jul
 2024 07:17:27 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:17:26 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/5] finish using .dtso for overlay source files
Date: Wed, 10 Jul 2024 09:16:07 +0200
Message-ID: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: a408c079-f0c1-4eb6-e5a0-08dca0b05a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KnedujvE+z/pWonBwliWH1LV/YvoLTwF3O/HgMEnmSNoPoRuRMDrttiCDyWI?=
 =?us-ascii?Q?0GRSZbzOAe/i3wB4uZpbD09MN4uYOhe5dFBQ70oOKr6Srt2Xr2whZToVk5jO?=
 =?us-ascii?Q?j8r+zOTa+6h7XBsIPZcuAbX01AwkkPiHHeRBb+3IxsOT7bxFsbU9EeFy3gxW?=
 =?us-ascii?Q?wENVPZbOfYHfASuUTyBD31EsBgQBlWYWtGXyb03MDyJAAceUy7A4DUU/JWEp?=
 =?us-ascii?Q?hGpj4+9vFYc0rzSPur3JoxOkqo1O72+3CxvyrOOb844jf6zaKT+8fq3T3EQe?=
 =?us-ascii?Q?WuwRCzdYNvfxyQYDdCAzumBN/x9z1KJd+dipJutwiTK7QWUKqiNLcOr6hQY3?=
 =?us-ascii?Q?IGZfvWYnqg5vrQmiXSlVHmF1CqhaiKqwunQIJQo5WjsK/RKlBRBX7lyWHTw6?=
 =?us-ascii?Q?MhZEZoF4dKUbH+UjBz2fxa5cS87wCv4xJjW9z9fabjP2zLpN905f/P3qkgKE?=
 =?us-ascii?Q?S1Bw7N1910yahOBKu6OLcoL7UIsg3beGG/sXhDHakQINzXDFvsE84DX+Yffc?=
 =?us-ascii?Q?4gMddBU9fj583hIBc8dpDujqrK19NagQgh4NhbUXgayrjbdW0HQ9DqC+fR6k?=
 =?us-ascii?Q?zmi55JKwawYA1quQqiazP412bQdHSTpVVyhaxagJATODEeeV6gK+jJfsMeqn?=
 =?us-ascii?Q?xF4JGhxodZHnihR/Yb33IsE/3XBadn0QfQFyTuqgHwGdZc4mtK59FN0QfuaP?=
 =?us-ascii?Q?LGQqbVm8IG4f5CBqXyaUIfQ/C3fH8+onpx3kw9X54fzzvrISA1vslEViYVxY?=
 =?us-ascii?Q?9dmrWUZfmqjIuB+tSkSCwfPuaMoqU+oUV641zrdjhluCKvqRC6Kry8VY8szX?=
 =?us-ascii?Q?xkUSIQIYdGCblC0QEB7vH5J3+kEnNOccWWXYOlG/xrVxs6aS/fuYepgRTAQd?=
 =?us-ascii?Q?k4MohpPeyl97Hrp4sj8LE1lYEcm8SpLK+ta8esrK7Wci/b0Vcw8xO4Uz8QPQ?=
 =?us-ascii?Q?4SgKaHUfCCq8B32lwYz52OBLxtIkn368yW5RguMLmswObgMbRUW/t17qcGPk?=
 =?us-ascii?Q?eDNdkJFqLp/EAuoOSfnYcTjW5PDxK0mCFq/dacXaxNor+10ECZRcMNTBq2/i?=
 =?us-ascii?Q?VPOa4EgTUT5omLOop/fOj9qrYVCF98PSKE1+GaIICQBuiBPWBW8dEqvMjzwH?=
 =?us-ascii?Q?omIDnNmxeV4dwcm7lsC5G7gLM+ZkukVmBduy5Db8WPcav3wObndRqSt+pU8C?=
 =?us-ascii?Q?RzAMR9Hem0Q6IMmRGQY9OCm211xy8QCL1F2igY3vDOZclTmBVDiczkFbtvIe?=
 =?us-ascii?Q?0aTWyNPIB9qWtuAcO3W7iQCRySzu3mJ1sa+y07sndeAYupgVL7ubQWdIYA06?=
 =?us-ascii?Q?EuS9+VAfC/ax4uCB7yFvc7c+G6PJFIJr8AV36dmK84CA3tFXSTVrzvdVne20?=
 =?us-ascii?Q?xS/yAFa7vX5dDfD7VYCR3ZPYbZh+BWbkTTJqto1K6gr6rP5Clg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLlGjXRTZ0BWY1a4yCzqsI0vhi6W250gS93V7wmLj7ndFlJAGGLyAXYg1JDF?=
 =?us-ascii?Q?NyNsa7jcaV4F+nQctJk7bZGCgm62C0ofZg+PEBgiR97pY9qOLlNF5YL+fWYi?=
 =?us-ascii?Q?AeSQkjoP7OkQaphvUVgqalIk0D9eBfikS8lNp4DBZBv8r8lWpnRxymrqlxUL?=
 =?us-ascii?Q?g/+DXGvAIwEJz/Gy5Efvof+kpzb2AHzoZTTTfYiMSiwz7DGSdoVcKW4idWI3?=
 =?us-ascii?Q?R1Rmb9Mg1+cLlKT1i2Qe5VKrMS1FcVEKqZ0kh2Zyo/yen07CjO9tN5ZKTWOw?=
 =?us-ascii?Q?c2mKhfvDJY3frIDokbhRNvkkMxTxlrjEbOboEUlRSdRD0xullCoen1JtM9fI?=
 =?us-ascii?Q?igUXj6AXFx99ZpO0VwXvm94R9ZxwVC8X2V3V8zT34TsxqO0CboF//chqwJc7?=
 =?us-ascii?Q?9/Uw795t+8T/Y+siz0dmCRkWI7y+pDVy7DQiwu8ATnUPLToNsqFEWyOO3506?=
 =?us-ascii?Q?vNSgz0etUrMpwU8244i/szkTsSWzp6MUvm1HPCsC7ci9ZCK7eg95XplwbTrJ?=
 =?us-ascii?Q?01XAMK+XQysYyHQOIh8x9JZhIkrbJpk7vlBNwgrXXDgnKusAUE2OI5GCY4gf?=
 =?us-ascii?Q?Nqw7FTKg7TwBqpsqPpjIuveET2TRBOTCFJi4ojdMkwi0iFmK657Sci0Vd2nB?=
 =?us-ascii?Q?ARA75xJgXcn3XxYj6oeWDyz2SBdPlxk3+TbFkG5zrOF4nx57ZeSTVtZRhkdf?=
 =?us-ascii?Q?wk/HJm1chAhOUW+kKqZ/bGgKLm0N+RNoBGxoww0Mt78mmhIWTX5hjHlPEK1c?=
 =?us-ascii?Q?2LkJCrR2k50BPS42RVmk/SkpXOy+P8fChTEM8FVQq8892Q2lKlnLJSwdcmkJ?=
 =?us-ascii?Q?O70t6vCCB4mokpx2/3IHsbiXx22BcBMc+CoLNEMvN3wdXt7gjEN+wgrR3ePj?=
 =?us-ascii?Q?TERRMslTWdcsJaiAytV5rtJhRUeEUmmsbafJrj96okz1ypvrv8Jvwltvll6s?=
 =?us-ascii?Q?Pq5U381+10FkVyXdrV/u8SN7S97EfuI/zk1I6vzzednnqxl77mlzoJhOSKv5?=
 =?us-ascii?Q?O182WHxZQ5kZtSQUKUZnhNiYAeXG3cc5W2RAjDK1AWGQy/dxW9VQApySyNao?=
 =?us-ascii?Q?SExQHwyfYJjKYa92q9ERK94Tn9I3DpehkJa7D5Kne/BxmAWJZZNwKyaa+wW6?=
 =?us-ascii?Q?mq732VmiZoFucSqNbXXUEuJv47k83E3/Nw3CI1X6LduljFYxb37iRvgPYFIH?=
 =?us-ascii?Q?OE/ctC+6byclw1UAUYotL01dEuD8R2MGz7dy0b9sH5rj7gb8rJEVOSQT0Ljv?=
 =?us-ascii?Q?xjN/4AQBiccbcpxwNb8NcLty3VqPplUBEYVB9w2q3VdTMUwR1OakOnPGf9SN?=
 =?us-ascii?Q?/YvSFkrGj+pWSxHWNcpvyzWye5S5ymMuzF51EcVBvsBWvu9wq9LLtYvztU9A?=
 =?us-ascii?Q?z6O9Bv3u8/2ZMCKS4ozpxUcYu7g1k00rV2MyOpjZ/f2enug9ILor7/yjEtyc?=
 =?us-ascii?Q?eVbNl2+Gs0LL6FnUXQEEqvmBf44O7c9avx7XLPgywAGAPvTvlntNTBBW1+1W?=
 =?us-ascii?Q?WjCca4W1xbl1dbgbugS10jtQDARI5JozJiP3RE+BsVOvHPHoysXFlejeGaF2?=
 =?us-ascii?Q?DbCgcr+7rlZ5lzBVvJ9x0ykm5uVB8++mUCX2p5xUUzxz1US7GhR4PPfD//Vs?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a408c079-f0c1-4eb6-e5a0-08dca0b05a10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:17:26.6793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpNclPPuPDBsBpVYyFoaL8XSL3Mo/IkXiukbC4+hflmIeui59pNgpEbWykJkfTusHWfpsUH4/HgXzzvG+TEwVAuhvV4xyKNb54NbTS3M05w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

This is a followup to the patches that landed in 2024.01 and nearly
made sure that source files for producing .dtbo files use the .dtso
extension. In the same release, a few new .dts files snuck in, and
there was also some test code involving .dtbo -> .dtbo.S -> .dtbo.o I
didn't really know how to handle at the time. This should finish the
job, bring us in sync with linux (at least in this respect), and drop
the .dts -> .dtbo build rule.

Patch 3 depends on 2, and patch 5 depends on the rest.

v2: Fix oversight in the imx8mp-dhcom files.

Now actually tested on CI, and seems to pass except for the known
cyclic false positive:

https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8897&view=logs&jobId=a1270dec-081b-5c65-5cd5-5e915a842596


Rasmus Villemoes (5):
  arm64: dts: imx8mp: rename DHCOM SoM overlays to .dtso
  kbuild: Allow DTB overlays to built into .dtbo.S files
  test: overlay: rename overlay source files to .dtso
  test/py: efi_capsule: rename device tree overlay source to .dtso
  kbuild: Disallow DTB overlays to built from .dts named source files

 ...> imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} |  0
 ... => imx8mp-dhcom-pdk3-overlay-rev100.dtso} |  0
 ...> imx8mp-dhcom-som-overlay-eth1xfast.dtso} |  0
 ...> imx8mp-dhcom-som-overlay-eth2xfast.dtso} |  2 +-
 ...s => imx8mp-dhcom-som-overlay-rev100.dtso} |  0
 scripts/Makefile.lib                          | 23 +++++++++++++++----
 test/overlay/Makefile                         |  4 ++--
 test/overlay/cmd_ut_overlay.c                 |  8 +++----
 ...cked.dts => test-fdt-overlay-stacked.dtso} |  0
 ...-fdt-overlay.dts => test-fdt-overlay.dtso} |  0
 test/py/tests/test_efi_capsule/conftest.py    |  6 ++---
 .../{version.dts => version.dtso}             |  0
 12 files changed, 29 insertions(+), 14 deletions(-)
 rename arch/arm/dts/{imx8mp-dhcom-pdk-overlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-pdk3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth2xfast.dts => imx8mp-dhcom-som-overlay-eth2xfast.dtso} (91%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} (100%)
 rename test/overlay/{test-fdt-overlay-stacked.dts => test-fdt-overlay-stacked.dtso} (100%)
 rename test/overlay/{test-fdt-overlay.dts => test-fdt-overlay.dtso} (100%)
 rename test/py/tests/test_efi_capsule/{version.dts => version.dtso} (100%)

-- 
2.45.2


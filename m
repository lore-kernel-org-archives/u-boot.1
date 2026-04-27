Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58C2FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C21683AA9;
	Mon, 27 Apr 2026 15:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CCX1heWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F228410D; Mon, 27 Apr 2026 15:53:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B3683693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNx78LBIyRUEA6qEf0aY+9CSM3iifTGR0eat6JYe4HcrR7Jg3ace3oz5Qtnuw+Dc5xEIEj0n7WddEpnAL9HjhUk/0PAjQdlXa8cCZwpq4l0AUOoroWcwvbp1f/oH5SosvHMp8JU1kkqt/aahHnO0KWEk5fFJKQSUBgyYjtJ1E4av8NADQ0lyvATPiAu9cEb2mWikLv6SbQfMJZIg4aJP+UBMkgaEfjS++Bt4dJU1Jftog2f7z165TZyWglpKnKlLxdscr+HSgFitWV1FGfH+iYwMV3GQFXjYMYWsoiwddzfkqffqvHdMNJcZVxK5u8a6600bxoBp7SH7qjGVsFLp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwGe5PCB2tX46TrPMTb6aMK+dy+xWmSJuYkaHQymUCY=;
 b=Hyq/9XRMuTGZ4NmlwAZMmuH6uRqFgm699/S3mWfoeDgR7uyyG96d/Rjg8f1Rovt6AXBXiuGVKlzE3hGk0w63PjyLhRRm9DVAiyz/7l8yKMoDJ9c+5HPJPTo6Kx8lGbPUPuGHGK83cQDDKPeyMfiPAjROGIET6hMw+0mjAYyNZM8QfEqbQrL8xeMDMlou0ILjYEYxlpNtJtCHsRcA6se6uiO1c9YPNKn3aqtAZrSMLeoQX046noicytPpyQjuF4N2c4N6crmKr75kFmfL4c7YiijIoR1qG8szSPU4r15CgnIC4ztDY1WrinPRA6DNor95jfiRHverD/nl24ysPDM4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwGe5PCB2tX46TrPMTb6aMK+dy+xWmSJuYkaHQymUCY=;
 b=CCX1heWxlpLP+HRxGjT3IrhXdVwVoo3SinyDc/PHOqh/E4iHSEQf115oacj3ezU9rj2wRG2aDWyCkjBmHHBYgExXxPnHdL1G3DyyX8UImET4MW5LEf2TmUYSNCXPyR++3PSm4/81x7FbPAAe7TCm0icLEwHxfQkOfZpPHGgMELJA/DFuZI9pxmRNK3Bm99nz/alxIVYx4jIzg2s/Wec1328sTQ27FJSSHabH0LSgiRZ29T6SYhOIr7ZuUSxPNGhF5ZC+U4S4F1KnOuVwW4a+hrC98ulbRikLKJtlwPr8z3p+o7fJV8Qzlie6GvBKfZDlt2RF3UI1omiKkkAOYIXa+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11519.eurprd08.prod.outlook.com (2603:10a6:150:2b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.25; Mon, 27 Apr
 2026 13:53:36 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:53:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/2] configs: airoha: an7581: enable position independent code
Date: Mon, 27 Apr 2026 16:53:25 +0300
Message-ID: <20260427135326.773903-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11519:EE_
X-MS-Office365-Filtering-Correlation-Id: d64a04bd-a90b-4d9f-74c5-08dea46460c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Kje8oo2temFtuCi3NK/SBl0nfzD1ErA9lC8qTG34fKaAN4NjU2W+xNsthx7MIpliY0ELyZTGap1fYrYR2+e3ujprXC9dY5l+xkvaQRGLKkGTVMJon5nwk/Taly/PeZ6nD2Yj+PfOAqjwxvBEuSfJbgBAgTKSAE6zCEXFP4ewpv1Kn8WKBowDVmyCTjVa0U99qXbZw66w1tbGI5qzQvQvLM1KaPonuQx+GImUi6mYcxdvEoFtGdi644wNecOfrjqdNJKN/7CBJ45s8vmpRWrD0WDsBFvqri1YO+hOZ2YSQMe5xEavspedJroNmK7X5kPBJiGoOEjzwkUfVccOA6kLUPpiNc36UnpMw+4/LxgARgmGN3bllBjcy51Tf70Eer6MPz4CnDVqzS7ftInntKSJQRO4pq9tDqTaOugMdi8oMHHsMiRq0l2Jkqi3coXeuvL7TLB6eQ46UsZDCEkPokkB7/sL43RijWjRooyuOFfTqFXv2KVyUGIJ5i38jdD6KZv9aYbGreJYvKFjzCzJw5HvDL7jU4QO6DDaorCNGXeVySJiHqb5OuCsEXp5ozCmwSUipNbex5DPqpczCc21Zzs+d9XY1WEpC7WW5VDG+f86qCA9MKqj5NhVRiTiDiLFkaSML+lPJ1PrCmHMXESJjUni6MvBEM9qsombIgsRHhy+3TKIfJqp8LfxdUEx+z5MEGttCu1CZ7A1bI5oYxq/WXW0uU0BKbPRLTsE4hE2mLUpML1x/0+ImQ/IHJmVImff3yTlMm6wSUKQI6pEfXPSkGXV489VyQGU+DFM/yYjxZxrh1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4eLM1Avy9xL+f/FA4gly+ucQYIkNha0jrPOI+wDMQGWteL8wxLJAAM9jn12P?=
 =?us-ascii?Q?kebTDhoi2dko30e3v9kqgE+Paj4kLGCD39M1e+jdiBlosIV2J43abtSZsjl4?=
 =?us-ascii?Q?unwE5khkoLG6RNoKgR2FKriWLty8vzcJkwXhPJqteQhtO4AWTyDmDmYzbwPi?=
 =?us-ascii?Q?ficpAc7Nk92bC6uEy/lB0CEtkvjMJakApig02IGWR786d8rWQIOOBVVQbecP?=
 =?us-ascii?Q?pHQ/fQzaJ/Fjkp1aSEztPhwYea9TAFKeNcFIY4vGGUmhNo+mvlJJB1gmo8Px?=
 =?us-ascii?Q?C0L/io15R1dutf4TIwZdnC5wfI7I+64n4/T19M03U2LWH+P3B+1KpK6oblfp?=
 =?us-ascii?Q?p6tT09DmQJ3DwEZeLbEUVNKzjY4lW4rVCFkHz1Ii0eH2hFBeV2ZuTRF6NlNa?=
 =?us-ascii?Q?RrX9J9HLfa6BN1EoD+bolFlLFC4cHN6RoVUjGfXiRWQOadnj6rxE9fHrGrZk?=
 =?us-ascii?Q?GRGzJqH2AC3N7RWS8ZYh328uTOe1BeytfXzBzgY3erB59qgdP+AmaXNJ26NM?=
 =?us-ascii?Q?Uq6aoktojWm2IynVuqKKTfFbxFRtEt3WB1mQxK64omI9PsXMH0iUIbLHIuLP?=
 =?us-ascii?Q?e9xB+fm2kiblNFZl694LiwYjPMtV54xJ1t/UbGWGFOSUHG0wFxgJNBklKVq2?=
 =?us-ascii?Q?0CVoynxhILm8O/Cq+YxmxISOrGOtJSUIZi9aZNsg7/V619dot1mkrt60zV6u?=
 =?us-ascii?Q?S30HY3HFtuBjvEZskY8Jo/spLyJu/ndUrIuNexhMps6SRA3a6GwHwna7vizk?=
 =?us-ascii?Q?O5Cv1q/sxIL4umazLr3sMQ8nDtOFKwlsGTqpeLCEM1IP/kOJJ4YcRWVz5Lw5?=
 =?us-ascii?Q?6/489XyuJ2cGCl7ERudh8DIbQAp6YkxNfrgz6c3SDbzBTUH5fid2EpGTWiyn?=
 =?us-ascii?Q?irE35lOlT25ft8vUK6YW4rTI4z+zsB/xfEQ+H5RCrVQvpKYx0/qs7z4VRoZm?=
 =?us-ascii?Q?E50ObAL3LMyhAXZtb7WuEVYoX0K+Z3YRMjC6ybPDvXz6WLc2isipLAUbGyYb?=
 =?us-ascii?Q?Nl7yyXpVkm3HLsdH0SKWu54VpGfi5FrslXB5gFjnphoCHDcSh0qUJLtTVsT+?=
 =?us-ascii?Q?yh+iXVpjJYi2nZo5ug+hW3Nvs9pVdgk2mQXLHhwmYZecDU8yWDu8ETUmsJT+?=
 =?us-ascii?Q?Dw2WyXwJKG2VWwGlO/kqFPTHkPjexzTe89KqT60VYMw5ywuGaRqPQj9x1L7y?=
 =?us-ascii?Q?G2ZLx4E38ng16nCoaLMzZ+DMWasyMB3TLLuCnMuDZ7f+AMT98/lWORwg2h8H?=
 =?us-ascii?Q?u2t0e1EYfMB/GH3WcIL/OguFxc0W9vvgZ5aC56cpEf0oEFA2eMZGc6W2Njga?=
 =?us-ascii?Q?Phj221aSgakQg27i74Vdcvcu4kIHH1pyHpiCtW1VzKm9JiabVSsrRuKsRIO1?=
 =?us-ascii?Q?sDUNdyFSrPDcAmIyOB3ADb1a7SC7/2UUElosWozHhiLh6oZedkk5I9fIVcXq?=
 =?us-ascii?Q?QUHRr8bpUa3g3VQITwulJv46tMfigT21G/MUsYJB8mvjbxfEC5ptq1iUIRMg?=
 =?us-ascii?Q?LhrUGfHh2EyNUYdc0sGVr3XfUufX21xXV301SIP8XHd7mMo2q9tVMl3jqDvY?=
 =?us-ascii?Q?iSaNQ4id+Qx3ipZYHfF7Ac/DrN4xRHubAef8LnbGnToDek5NgyABdm3C0wrn?=
 =?us-ascii?Q?6GvJDGMlywcjptA4icbr86LUjFj0MohFUAowi3O2H7/OYl8AX+3p9qCHELGn?=
 =?us-ascii?Q?pdfM7gz3F10l0t7qySSX8RBPHNPYYgzmEcK625zd9TAhv8p97j3pC6k0FgUY?=
 =?us-ascii?Q?SwYh2xI5ghZtKSy1Qb6wW896SE6zP5k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a04bd-a90b-4d9f-74c5-08dea46460c0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:53:36.2111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bccPusNruaXEKf5bxO7Muo4phh/iPxQGKDTkks0VtFaHsEzAxx6bCq9zoZqfPNi14ySno2obG4ZRzi957m98PkG2KnLXy0NKNINgF8rVew4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11519
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

This enables U-Boot loading from any 4K aligned address.
It makes U-Boot debugging a bit simpler.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a94730cf564..16100d00f98 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_AIROHA=y
 CONFIG_TARGET_AN7581=y
 CONFIG_TEXT_BASE=0x81E00000
-- 
2.53.0


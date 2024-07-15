Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211ADC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E63E887FD;
	Mon, 15 Jul 2024 13:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="ZQbV0co5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4D088823; Mon, 15 Jul 2024 13:23:14 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B57887F3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkTmSO90/o8EdD/smnhDMx0EA2Za9Cj3M0ZITKlngVwkcwu/ymJH7KtaMdFyx6+ArVa2RqWp1JbqNr3iuG10P/qhlji7a6ui9/d56i8o/xbdmGuAdYv/QlKjAOpsnmXeIh6zxkVtxhAXVXsCfWQpraX5eY0F6HEuaau3bhgMDwU1feOczDC8dh3QiCPiTFjYD+h/ba3U03R2iNDA5Kz+1zFrYtGmLgd38Y/4Y1heM8gTG3JQrVolNIPPONnGB2Nz8pF/DR3GTjKpNRmqPuqqDRtRapb+WEQP1qHusYHtwKs2JsNAtYbRbKa9mxPGId6xJdHZFI8VKZelI1vQlH82Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU2GpUo82ZvKhOrNGEhLvNKYs0nHzI7Il8b7r5yHO8c=;
 b=QbhwWlwfKgaxDaOCbbsKaz5GhlaHKVlXwVaohSfhs+Cn9pQFzo5MabltrsFdEEFPXyrcKEkNvsCGszQBkYU07YGaBA1pQY8lBo5oMQl6QnisEIZ03uPut+JQuYTXJT3/OxkMn+fSZorARTGOXTbkzwZoEtVguArHbuNrgpWHw2wDshB2jRqAMgYG/LgC08fcvnSlamVo+az8FX6IzfiSamRXBj4WxzJ0GNzg/vMDRgOiY4nE5M2XKwvxfbyhChs5vNWpR5r3cQXzqazoXUrnCYoaykaoRSKVMZMalcP2BXd0Q9tUmy1HE5n15QecucMkjWpWL0haM/JtWjtK4pifQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU2GpUo82ZvKhOrNGEhLvNKYs0nHzI7Il8b7r5yHO8c=;
 b=ZQbV0co5Wi4mSEmfI9j4spZUoGk9yiktGKZiSAPecKMCmXXR+IJJP/cdccwwXI2Lr3pbtpwt9FejzH+c4XK6PFmiFHINwpBiHVRcsutR0jirg3YyyjtCibD5XYOP27IGM/M0FyNdD7F8ONWBDucExDOTiPSMNaa89fewtpN+vRU4ut9LK/uU96HWffBiwJUREaEi0sUs2Bc358nh+xWASkRCH41vZbkALd+tYW7whABIqctXC1Z3zWN0XNIbYQs7MSLvUR9HKKcYCoFNvPbOL/4Bwules+i4JiSFl2/zKU4mKe34YznaoGrrnUQAXLuB6AFTNipMx+G/wbzIiVpBLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI0PR08MB10917.eurprd08.prod.outlook.com (2603:10a6:800:252::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 11:23:11 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 11:23:10 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] tpm: fix uninitalized field access
Date: Mon, 15 Jul 2024 13:23:00 +0200
Message-Id: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI0PR08MB10917:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb9a86c-8b35-434c-aac0-08dca4c0825c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L1mewDnk0gaA952JRNGzXf4jJ7zggOulmLYzlmKty2YpdNBQ7jzJjCZBw9Y+?=
 =?us-ascii?Q?JdnIeIQMiU+dlSo2YhBNLiy0EZHGNHO/pZDQ2k4/5ja2U4LdDs1DSRXjgGn0?=
 =?us-ascii?Q?9yK4sjGyNDGJY/AkjQ3qF90YyWDHQAOsoiL1i4BKrerj9zJsmW9i6kLIDHNk?=
 =?us-ascii?Q?K2+OuIwc0FzXKZ63dtghaPq3yRIURNGDsq2WRPR82x9pqZvAvFJxRD2px0a4?=
 =?us-ascii?Q?KMhhy5U/x9IPYkyfjsf0cB8vlb7ug4JLzoefx21NVielBx4KplxoBHzrqrFH?=
 =?us-ascii?Q?kX5RDFEBvbHNDdSZ9fonkKKsnK/JgT7du6cSnxzLVs43R4KJpA+VL0nFc1ZW?=
 =?us-ascii?Q?wv6TqAKNW9tCchSJZrwt/LCX3Axw3d3teY5x2zvBqEmYd4Yv23KEHY/plxd2?=
 =?us-ascii?Q?fRtdNKYmfseiqDWbTKBrg0jxlr6SN/cQYW3GrwwG6gAecLIFuPUzdQv06X/8?=
 =?us-ascii?Q?CVpEIoWGYBceWiuFy6+Sofxph982UakFe4jXv945lt8IqXwSI4cdBGQLCKUS?=
 =?us-ascii?Q?JSi5KGoV3hr5ciAnQb+DdPRsXVtoANynH2sDpwQPqeZ8bhaJ0TVyNCJUKeSZ?=
 =?us-ascii?Q?O8RXZV/a3nAkaBRZPAs6mVK/rXzwZhkPOerM/+rK+MLB+c73AfRz4wM8ts5G?=
 =?us-ascii?Q?uAxnniDenFPY+PRCo26kt16bckSbcch8r8ORNqtuYEdvn7SQH3XLy6vEnb6z?=
 =?us-ascii?Q?ta3+XXcbJ20XcdCQrGdxXGJlIkPReQcYzDV5WMylsUypR6qSftdNogBpnYa3?=
 =?us-ascii?Q?8sORZBgskPCEQ0ToS8BEU4nGLfC30MEWo4te4piZ/GD31QebNaQFLSfxoADv?=
 =?us-ascii?Q?f6LJzmoxPYji7C4XAoyAndSdXsuKRUBZc2ku2WWlvoSRjLQJJ2kn6knJ2Abi?=
 =?us-ascii?Q?NT2atYOFVG4n0b/iArN6PWM+o6d3H991PEj+PxiwidKMiY7bUdsEGCJhM5q8?=
 =?us-ascii?Q?86V9Gdl7lx9gNBA3W5n4reynuUZDJtYqNQg1eJIrgNA9es6ltCv61sglF7dO?=
 =?us-ascii?Q?SGtge7SAJlK+H8C0dlAQLsInZXDia4rnVxlb4ofH5/4es86pQTXL5mH/kfzb?=
 =?us-ascii?Q?y7hidNMepWAx4/66UaSyoqIXp7ooJR3J4APCAu8L6srOPWXhOgKlT2CUjPPK?=
 =?us-ascii?Q?nvFgdciVuBIFbJrBwrXzEHSD5aLo6EqGTRdbN1tx6w/N2W51nqWTMnIvKSKB?=
 =?us-ascii?Q?3qpUgGUPLfXS3wwtAthAPejG4o1lWjY6Rz7VOQJgqqtc3KU4KKfuDV4KsGFR?=
 =?us-ascii?Q?XVAHUVCx05REvnye0joOupGZnsI7x0ArtTYMSwdHcZGcch4IpVpaLfjSlwef?=
 =?us-ascii?Q?e3QjsnPVoir0TKZGaSivQKCJJ4cEfFTN2OxMBNvWKbvjaRKPWzx5IRI1q6Kn?=
 =?us-ascii?Q?XzVdzmIlx2y4ZyiyX1V/jdl7AjscB8bsuW9iSB3aPbn3GFYZXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qO9VkOFbxzTYWykt5dDLmKhjQ/znajp24QMnfo5KlJkxDN7DBTEKX8a8q51G?=
 =?us-ascii?Q?SQyo30e+V6P3+eiMy0RX6gTOAyuQhCXPxnz2vYiS7rOS/uaR4JR3CfsHJVja?=
 =?us-ascii?Q?sXNQGnInRuSesstgqHzZckK4ohxwHOXc+JBKRmjoTNVh36p/LrY14vahiCz+?=
 =?us-ascii?Q?ysylv5ctU6aTZVlitECssIAJeo5Dd/tBCNgRPVTZB8RIeUBvm9IsBozeyia7?=
 =?us-ascii?Q?TOzsNp1miJGw7vxrNanvfC9B07uUBapDSzBRzAnqdUJSq7f3Uvqx6WZZginF?=
 =?us-ascii?Q?VtJ1wEjRhS7AfNziJTSfivvnBrwUxdVfxEpLgkhaaljVRIkEYNUhdMr2kCeo?=
 =?us-ascii?Q?A/yorYlCHDwQLEm1M+spoc+GaXrFAOHPCjSmeljYSpgcW+c+Sayd7/ST5L+M?=
 =?us-ascii?Q?n+0WHkc3monK8IQd0SUBGG5jWenBVvv7Vr6sLV42ycPM4pHDYweGbOLm0LPi?=
 =?us-ascii?Q?/mpu39QTBqg7CQAbfLiC+IHaHJbLE9/7NoMuWc/9YATA0DCxL6BPf2GDXvNq?=
 =?us-ascii?Q?DHI/B3HHnKNfIEqOXpw6i5bHBPywG4+ZRPLtIBn34gk1FnusjCiYiB1OGZvx?=
 =?us-ascii?Q?vv3DmvDtyokC9CgvOD3gg1DZqJnqZ28IX04N7INL7uawrCL5UaY4QSu6XleA?=
 =?us-ascii?Q?PvfxDPNqimBCm/DbhDG6F9cBGDGm7GLKxSsxEgHmXfrYPPvmRCNa5rTWe0LZ?=
 =?us-ascii?Q?QVu5qjHHUKHbvXfVjEFjMx1z6wD3U54xBgF4KJhHQOanvfesQL8jm/np40rn?=
 =?us-ascii?Q?BkZQHwj2fT7C6JgF3sk5AD0gKQNhxL9u71y5LR6q7b66VSzi1NV0jOftEZ8g?=
 =?us-ascii?Q?9yl8TWTPMiW7vjC7pELBckRfBf/wcaTsEYVsKwa7CPhsKPpUgzKLnH7eeVxe?=
 =?us-ascii?Q?Wz/scX28HWcBjzLIuWeznKnqyDO0h8qKeto51BJA8YVImPpWt8JXtYkE0qJJ?=
 =?us-ascii?Q?PNa8F2Ypzpj6bw5w5zDgxtjrl+ZkrHFACkEZQiWhHGzUBMHDr67OBsAPF8NU?=
 =?us-ascii?Q?x7y6QDjgPUfOomlV73z/22swNYswKqvP2uyIw7lGNzG57Rir4f4Zumxj58by?=
 =?us-ascii?Q?HW1jg6dPpVl2V/odkJDdaTzwS0jxe6q2dbE0wfthOWzrkTMIAgMMAlbFVWq6?=
 =?us-ascii?Q?yBCgUi1QQId0dOg8srbIHUjEj0TQtNTQCQ/0liTzTIlygqvW+5Ln9ZYWxpp/?=
 =?us-ascii?Q?1fx8yzt5mRMi5jXvNsH+KfKd2/l01nUrSMwB+2xR4/9nqS8WXvG9cQlEW7/A?=
 =?us-ascii?Q?PlAMpSQQ+pOJ5TlBKwMbssHszestobqMYjKdiT29fxLnBvSdfx9GpxNnSJnb?=
 =?us-ascii?Q?2YDyxs/QyVbTfmbjR1qtm88MiEyV7Fh6CsEZPNGT+sqOfCoSW92oAYaE8Bf7?=
 =?us-ascii?Q?X3MlpTcbrvwj++zeN37+VzGDk91OAYNqR3Mox65TROffNv30HEeO6LhnsV4t?=
 =?us-ascii?Q?2zhC+U2VUsuu7nUdN/aDNAPJCAH/JbrOy4ZbELYYJkg1lDjCx4wCtvDlO0Yx?=
 =?us-ascii?Q?JQREhptl9nnfEpBtF+2VA6DALLm6V8YnrwDDpqqhqR+3zxd+6HHEtpX7RSPZ?=
 =?us-ascii?Q?pRKXuYLRNndacGJ/SHNB59au9hNMVUxeYOqnYXyc/9GYZGBxfD593bRW3smV?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb9a86c-8b35-434c-aac0-08dca4c0825c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:23:10.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4d4RnUB0+nWQIj3UeKL0e1e8WA2Rbb674z9UjMlF1mBEiUfYWHTHOBlf/DeX5CQmmm0tc15VBqVuujqPYgScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10917
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


tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
initialized in tpm_tis_init(). However, the init-function is called
*after* tpm_tis_wait_init() introducing an uninitalized field access.

This series/commit fixes the issue.



Lukas Funke (1):
  tpm: call tpm_tis_wait_init() after tpm_tis_init()

 drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.30.2


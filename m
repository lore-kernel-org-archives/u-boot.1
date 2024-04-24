Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DBBC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AF788E05;
	Wed, 24 Apr 2024 10:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="IGMbRnao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECD988DE6; Wed, 24 Apr 2024 10:23:53 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E1888DFB
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJh1Z0eUuT/eCNhMPracZRzlb8Ys3YUwAOgOfmH5+Ea6tOJnNKwLppMHtUPQdk9lBfgLNTKW1Y86eCGqTIdNZ1/93r9NYZ3EHsMhnVq6sVTQsv0nv4qLHjjWuhXm/RpiV+hW4803p0msnmhMuxMpY55s8H0tofveZ+9IFUS08DIsV4zz69Lyr84eoq7Smm58E8DX6ngu9itiVqQIJ8WcoBFh9c8RhUvZc5xiKzlep2r1odtXLTI0kZT9TYI90RbMgOqnxAncpDTXD2iKPdkoZ9w5HVlafRTcorZTzrDnhqTipe+tcip8tSCQXVQnDTkjW4NooNhclmQzesYyN2P+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txu0alTCWQlibugdRs3vnjIr1O1M9AszjAlhiQKPrZg=;
 b=VN4rTsMg5VPIM061bdfW1NaU1IIuZ1jPXSL+59xVJ4KnbjzUHWgml84nsOo4jDfiMQbDf6WrP9v4i0L8af6P+7KBYtXtsHlcIe/DoYVa4y4mA7+hiS4ZmmmNO/QUg772hTGB6R+LZCz9JSIs6i8yqibc/dOmXx2IlVIAl3Y+NA3eC/4KAcFC5/wcI9Cgf9FxDfHYp0ICpQ59sjRSA1piiPO9B4OTHOErokYCiHUnDZYutK0OXI2dy0GWudMiHuBu2af2YmaNX08POxgIG+xAU527xYZJrH9qaE9F0G0ts2FmrH8FBYfO9vNR1OmH2HzxibZ0He5El48lYzDB4nHiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txu0alTCWQlibugdRs3vnjIr1O1M9AszjAlhiQKPrZg=;
 b=IGMbRnao/ilNxlgnm21XXBwnTc7gN8zpqN4j+dGY9leC9+CVUywWVOQd7J8R5VxhrwSKWNA9+pbAUeJxMKaoWSmas4Ma4CCCeQfZ/Ne4siquosKK0LGsqSgGTNc55d0PeyxNZpNlbPlJ5YRu54PVO/t8gm2dJSylvWUsF8fxzlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5985.eurprd08.prod.outlook.com (2603:10a6:20b:286::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:23:51 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:23:51 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Stefan Herbrechtsmeier <Stefan.Herbrechtsmeier@weidmueller.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 1/1] mmc: zynq_sdhci: Only evaluate card-stable signal
 if card was detected
Date: Wed, 24 Apr 2024 10:23:42 +0200
Message-Id: <20240424082343.212554-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424082343.212554-1-lukas.funke-oss@weidmueller.com>
References: <20240424082343.212554-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e01c8b9-eb11-4f7d-bc19-08dc6437df3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEbILgGMlfWbGgGzs7UI0jIArW7o1qlCZ+l5glbEBc++wRrgNZMKabKwoxa2?=
 =?us-ascii?Q?NItsEh4//dNTMFdcLIC5mL6x4WMMw/gBWD0HLBbkDzQuH4cXm4zHJJ6UI5Oo?=
 =?us-ascii?Q?TFwCN7gCxYmtvc2skvYv6y6Xn6XY7SssUPo3SpHz1tkycDBgm8f85S50Ht3A?=
 =?us-ascii?Q?3GRKgoYWbUh/AmBMhW9i2cwyfULZOUJA+DjgE6HRftmtlxl7RLygopXcC8kH?=
 =?us-ascii?Q?HP5rhlqMdrcbq0nVY8JcFfDdRvIGwtV18SBWgEpdXEh3WGOMCvKOUY7srIea?=
 =?us-ascii?Q?LroW8PxaXxt3R85V/XiSNVcmgxE67uHfwC80mjDXmKiU5jbHtoPfp3gAkxeK?=
 =?us-ascii?Q?Syxf++nb5JqO5nsFuDcJqDWIgX46Ci47PWG4zUdbs31QD7uNsGPscW7R1i6f?=
 =?us-ascii?Q?hHZUVSvVRAelITyvjOe3j46Zkn+kecmpE51lGJf+Hi1Jr6YT6MUziBdSS7rJ?=
 =?us-ascii?Q?Fuo6o9dF+69m/PYxjXmzCtffoZ5gpOvMl0YhPi4oyIIQNo2agVCgfCU5ubYP?=
 =?us-ascii?Q?k5zVHabXsIScnKN8WX0Kser8P/81TzVWS0V9jc3JEL7pI0di/SLUPFpzMxfS?=
 =?us-ascii?Q?8xUFCpJ9Uxoim80//NbC8eHqrGWV2cguFPDKleR9vCV/uG9sFKqGYyY/aIEp?=
 =?us-ascii?Q?KnRgjMRBm2KymBwOxH0TL1AiSuinnFgHG8iP5ltR9u2sHXXpJd4fdupwRvFA?=
 =?us-ascii?Q?UJE2be8YvOFZNBKszYCaBGrddPqLo2vbrRfiET0KryMMRkpMTi3+6qBLn6Wu?=
 =?us-ascii?Q?X4z329RHSimwaXA2WPMtm25Azp25OOoOjGG0Sro5dZe1EKk7mYpnrRIxSiZ2?=
 =?us-ascii?Q?Jdu5+CPqukFH0qtl4kvoNwCGEKZ4AVk5KRGlErIK6I0aAnEsqoHxp8NFiKVo?=
 =?us-ascii?Q?waM/1MEEM/Ebe4oRxJnEYhz8CgcS9UM6bmHJZkx97IhG/LrIG2dPFOckr14x?=
 =?us-ascii?Q?QBRgGiTTC2obe9pTAbWLnKogdDOP24VVe0PGOVxZW9pVYet5130BhTqzAv+r?=
 =?us-ascii?Q?aojrp9EAsNBy0xmUX0Q6pKQHNL6Yhoq62RhQID3PFvnj1+EbCo9uinKpK3OZ?=
 =?us-ascii?Q?tRPpKZOfTty1NZYDQkZQj89Gp1uDrI8N/uKbisyqSKpw1oX4xwS3Z2UtYTRQ?=
 =?us-ascii?Q?v5yENuoR3i8C1OmwY9xvxukmfHJUE4GqnfyEHTL9fwSdVRxXwSZnHM6pfAxr?=
 =?us-ascii?Q?gddjwXQLczFs8NnEpsomxEOJC5reUkPU6fHs0ItJF9yBTwx84/zy8Y6IY7wR?=
 =?us-ascii?Q?2eGg788snGQDPwSLDuTrva/7h6oOxJjaj21xu+Fq5Nel1Ki1MZKk0x8F1QCN?=
 =?us-ascii?Q?pTCoZo89F/+/CaDFI+0oS8qymgRybnrWKi2e5TqYC/OU3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/opVUBMR69rQ+4DkUXrhz6N4r0qjKWbY0rXvfAk2vFaqvL8QXNgYjNO68hsb?=
 =?us-ascii?Q?xoJ9UQJ203oxGapDC7YgXCkoPEd0WFGWeyyxpHjf6nK+MF5hw7r9zOGUq8pq?=
 =?us-ascii?Q?+2ot3BCG6p7s8xO9emXotvq1M70fvTtyuv9/ZQIK22s3SRCUJU/6co7N/81C?=
 =?us-ascii?Q?4F4IS7aDeYlv42Ev7MugPJ+dpqldvOv/EXZreuIyHBpHvZJLyYVaeRSxLx5b?=
 =?us-ascii?Q?L9FzV0EKNyt5LGIMjLXOcYlDb+h/vnHgtV5dua8y1MYTvZgH7paKCxePpEW3?=
 =?us-ascii?Q?xRU5FCU8LfkS/eLg+EV3LzpyLFSD68q+kA+j6pfQYykedUixy4slAn/Q32yY?=
 =?us-ascii?Q?hXoTRE5YP13DglUFWMx747a7ZO9UK9acXBVM7LM5i1cOvoxSboczlqvxPxCs?=
 =?us-ascii?Q?0cqcJ+smRFPLom8WoPFAHPR3GUfChd2syCcbj2h6iwPpMgl5WYbJbSDczI/B?=
 =?us-ascii?Q?DXuDKCn+N+yYWQ6B+asjJtR51aE10DbTYShyp7zI8+1FcEw0wR90Ceg4KdIt?=
 =?us-ascii?Q?DlBfJjFRMS1/58B/L99CVvix2yMBp7BedUR+vZpPVXtN2xdzpYhgUbZUjD1b?=
 =?us-ascii?Q?C7pu9bHNe8T0wn+kmtQRccFs+Yb9ITgyNNjMXnzvBS+yxxdQ0ud2OW8Jp/WD?=
 =?us-ascii?Q?TjeZUC7rw1iqq8OQt7nMn6MKan+DJ2bOioHo5xCJ1w6YFOEXyKSVtp325RTc?=
 =?us-ascii?Q?DL5x6Y6iGrJPBEpd6qiRRz+gR8diXNsL0u91qLKqdHHf31C9oOaHG2DhfryX?=
 =?us-ascii?Q?8AGP8/x4xnhYyNUs9CxcJb9IxsL5K+HWxHjL31jRK7tBZrccaiYzZ/y2B704?=
 =?us-ascii?Q?SIcfr5+TuXG6BgEMaHW6fMy+17qhy9yene52RRjP4zb2W0XiLJ2q86brUfXW?=
 =?us-ascii?Q?LUMc+RAQKDsfddIlUI2l1jIMX1+FLLa+KYLrqLDk+fKoAcmylrM9tuRmq44U?=
 =?us-ascii?Q?peY/RoTuM+x5IOFeT9bMj9pY6XkwcnxsQhdw13Xh1TszeNEEDmywdbwD8fq1?=
 =?us-ascii?Q?iSy68ZDC1TZlmDJYwbwPDv90A4cJ6/hY8FAN3BFLA2sRZ9k/mdMUuFY5BNmZ?=
 =?us-ascii?Q?jjhu2RHmZXxURSZm0hzPiLIcxrgXrDFZvf0vMEEexNGSmGKGQyQT8dZpAjyb?=
 =?us-ascii?Q?GJD40ye3EiHtd11OXABkbLVu6PNca3SHNEqthOraQSQhv7IbNBxAV4zKYpKy?=
 =?us-ascii?Q?Dt81MrYxbXz0I6FSVkOBvnJvMiSMdKCZjpZtcifE0ZGfag7xV3UWzx45s4bz?=
 =?us-ascii?Q?1WSzuI+A2Tamlvw+eD6M6kGj9JOYngwug2vAm/pYMBAG1gdNggZcrtt0wAeg?=
 =?us-ascii?Q?ShS+TUcPEeeoz5s/0xeplxhsH9ZOo+waPiaIha92+DGmKfuEMOMlhtmzwCvq?=
 =?us-ascii?Q?idNNT+0MkRB42tJqlAs5nkGyCKgT5BGpTIAILIQGbGmk4eAaz5uOmiBM30on?=
 =?us-ascii?Q?XVOiiqI3qWl4/yPAewTdEXOksWeNSxYhf+cBHzT5mpq+OqPr7JuzWIb3ja9u?=
 =?us-ascii?Q?MMeV6/CsOE0ckpVUYwjjMt68Pq6zgdJJXginQUfL6PiPvqhfkyIeDtRlFQQ3?=
 =?us-ascii?Q?YSYcgEad6YnfASUrosAc/MA2tPwnlNWqqtAt3kEmnDAuaD410X053+4tFEBO?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e01c8b9-eb11-4f7d-bc19-08dc6437df3b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:23:51.1716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ6j+WacKaJhFZPJSBd/DdLxqvP8w4QLCRn2ElhMtfWvRiDvUtTnQXQiY/V/ltsR9Wr+loACpKii2qs6OSuBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5985
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

On ZynqMp there seems to be a dependency between the card-stable bit and
the card-detect bit. The card-stable bit is set *if and only if*
the card-detect bit was set before, indicating that the signal was
stable and reliable during card insertion.

If the card-detect bit is *not* evaluated the corresponding check leads
to a timeout indicating that the card-detect was not stable.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 drivers/mmc/zynq_sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 935540d171..d0bccd41cc 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -1168,11 +1168,14 @@ static int arasan_sdhci_probe(struct udevice *dev)
 	 */
 	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) || IS_ENABLED(CONFIG_ARCH_VERSAL)) {
 		u32 timeout = 1000000;
+		u32 value;
 
-		while (((sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			 SDHCI_CARD_STATE_STABLE) == 0) && timeout) {
+		value = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		while ((value & SDHCI_CARD_PRESENT) &&
+		       ((value & SDHCI_CARD_STATE_STABLE) == 0) && timeout) {
 			udelay(1);
 			timeout--;
+			value = sdhci_readl(host, SDHCI_PRESENT_STATE);
 		}
 		if (!timeout) {
 			dev_err(dev, "Sdhci card detect state not stable\n");
-- 
2.30.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C01CF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6BA88E3F;
	Thu,  3 Oct 2024 16:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hYCGoGm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69D888DDD; Thu,  3 Oct 2024 16:10:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2862C88DB8
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo8jJxjeG04THc+X5oBSpb89FmLsm4Srx4kET34wGuycuHob5aN/oGqfTE1bfSI28hp9shraS4R7RpV1dDqk8EPQ2Nnkpz6Hu9fZcvpV7wLq7lqLcpsleIq61gQ0drsnc/Ifke9pRxQ5jmaFzuWHw9D7dd8q4Rm73m8sYc+PhrDdp1xWzBW7BV9vLiX3koHNEhCFCTXHgpQQ+FL/AZ8JOjcF8w1Vz8k2Uhm2C59LXNp6K2kjA80lUKx5Rb4q1feAwUgYJ5klv6SRFuAnn/ptvrDOl8bAj4IfCpEG/PHe5SmHU8+eQa5XZoPG3Hu0/nCSrJByx0IpG8o6JLCvqB3aEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6CiovnDQRK/J7pEWujJRdTpdWqKYiaN0cK6Cb389dI=;
 b=FCZ9VXrrtpfy+RZYC2QAtreI0H+lJHUCpzh1OUhEliyruJe7Xfqs/AWYPQ3z8snuS+PnLwHfxsLPLpOUbkff8OfPGQWxF0Yt1fVrX2w7gRzrYG5Fm1sDzjh1J+waelAJ7UrhMcubkY6vAU5RuGNC878cU3gpkfv0Qari3Y7K4K2KOvXxo3Xy9BSDkfUKX6I1DGmY2yYxTvKyXSraV3FOz/UjKlPXeKcUM2E4lnhO0WSImR0txkGtkxCNF5vC/N6X4bjK6Phq4lgmyu7ZJT3JaWWZxstHeax2mgywMrT5yzebSgEFB0RAwAv5V3ddL5gWUqBqL6kdr+G5PEe56r3FDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6CiovnDQRK/J7pEWujJRdTpdWqKYiaN0cK6Cb389dI=;
 b=hYCGoGm9GN4urPXEnACj0ykMAoMivaaJT+DbW3KvprobdX5OpxsJTDY5x/CRSVdBaY4mTdoUKXZtalh5OaEe/Gzk2NS2oAxI49t0NUEV1UgCoL1ctuyiDzub4UYjgThPTXfv1UKTwqTeUMAlb0GpXOzdAGfdY3f7IuZY4RxWrFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 14:10:29 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 14:10:29 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/4] serial: fix circular rx buffer edge case
Date: Thu,  3 Oct 2024 16:10:26 +0200
Message-ID: <20241003141029.920035-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003141029.920035-1-ravi@prevas.dk>
References: <20241003141029.920035-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 3281defb-3f65-4281-61fd-08dce3b5230f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pjytDcb/41odhNo//ak2pIMjEq1VyW+B82ti1/G4xFLDQMrOge11tvQzCIhF?=
 =?us-ascii?Q?1ccu6ZyL+wTnWVCgSR89iKi/7Re8zHEqCZU9JbM3qTOly6jElgv97c7YgTKY?=
 =?us-ascii?Q?o76yHrBv7xUHS+I/DKzZ5phX+o69p/td6q+tgYv7dcYTaX2bZjc4Ib9cSRZI?=
 =?us-ascii?Q?rPHZs6J29FsuA2mU8scrnikgRbV+WiZAiL+nh36FRXBsATD5eNOsZc9s7ZBL?=
 =?us-ascii?Q?i98Jm/BAwbX+wra03qCTb0nh2C0OIPcizmeXuauiv07kzzxRzlAeKnAqTTq4?=
 =?us-ascii?Q?lRd1vgS0RYm+EIwWPaWZi+h/9Z26u92R1vVVefQ4Q+n8c1+GZf8OLPrN221K?=
 =?us-ascii?Q?RZdd9mSveIl2IIJ0Aj5SqRDbvdSAwPxEv7/rPCfsglbGCtFMLkPIOwcvksAF?=
 =?us-ascii?Q?0rEPoxDQuX6M6GuUQ2m3Gik0voIWSDj50R7eErqlCE2LUDGC2+nJTG3dlVZv?=
 =?us-ascii?Q?4nmJrJLG05h1KBgCxrxdkg46TFbtwgp5JCKE8oG2PTHVrWSP+WL5d2Lh14Fz?=
 =?us-ascii?Q?aA5oiMX1U6GuwWXgdLUTId1Svmg39HvnFGgwrbcJh/EAQqwgwGI8h6f/yuqT?=
 =?us-ascii?Q?VvoymYKI6VvYhGp1MVTpzviYuHWGNwsrum3f3EB+OVZ1lAJFTDypxBKCjSEZ?=
 =?us-ascii?Q?zbadi/SzwppMBGtHod62UT6OsqmU/eKysNzuiCtk+l/zX9QWjVhVSpHOTsX2?=
 =?us-ascii?Q?QpgSime+w8o1hvYI3/B27BoHMr5khLywYmO6YN58iIH/1V6S8gHS+LblH/hu?=
 =?us-ascii?Q?DOqRs4XNNuD1rgmwVauNqmIB3LEzlWefCxOLwe6EsdfXVtRuToGZ60d3fblL?=
 =?us-ascii?Q?MLjz7f886gj6f6fNVgbHstiLdaPqLIA/HITFgjuPIRekr3dKVH29WzRFNyS+?=
 =?us-ascii?Q?s31p5G0XMp/dqzMjtCCboBVZcMD4AESkyftdvwI8mK3fVZVMUMweWQcRfAz4?=
 =?us-ascii?Q?B6Rp9BDCC+0fsm/0w/Tquuw2Irv1H3cDM8YxmL4LwmdHplAW/glU7FtHDqEP?=
 =?us-ascii?Q?msFqmY5SXLJMgB9iNluyo3vnfn7TItgJQuhMhStAaj7l5uJoK+KjNmdgV8Zs?=
 =?us-ascii?Q?HEflanxpKn29H2owGmXxfgQKL2C8AfcMBcRNMRdEL77L/IeChg7D83qEVi29?=
 =?us-ascii?Q?HHUHfDxBokt7/oubzbzD+f/gsDSyiWbMFnYyB2rRPE8EjkWAbWY4+qyls1g3?=
 =?us-ascii?Q?kXtPs/TRJFjs9H/5Z6NdOcGuM/Wshk58qRQoVdDRojqxxi1MZ5KO5L6X05k3?=
 =?us-ascii?Q?vHjRQVQYyVb6iGrZjCyjoSj+ltIWpGYg7JmsEgXEcZLTcXna9IrGIYqEgpmy?=
 =?us-ascii?Q?xxyThftaCCmFXlPHlrBj2t4b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hnz+8aCpjJ8QX36B+2zZgWmMB19z0l0cs8jz+lSw2rO1fxcf3usjHVEUCEz/?=
 =?us-ascii?Q?21m7pszL0C4jIMkSDBXj+LwXcxQ46htYvV+2FE/32qINZbXvc3Ig8EtjQub8?=
 =?us-ascii?Q?XM9jzP3EcjiYZn/gTla4MBAPp9jet/mMkP8DaC3N6Tgpm4Vc91qQSpVB037Y?=
 =?us-ascii?Q?TWGWfrDgg/JBsWmV3uf3wTmxAHuBLCUQbuYHmNLWUU46zlot0GvBblyoi02M?=
 =?us-ascii?Q?FQqFCaYkKmxWGxwPkihTQfYGSoLBqwhiSf9UUgrB4bq1vXustfBVs9rtaYPz?=
 =?us-ascii?Q?ZzHqL35oeHnxzI1csZLKayMLRiHRF3xPUQyE+eeaow599j2pp3nHgZhHrvZN?=
 =?us-ascii?Q?MXL7+wHwvLsrB79dgq/VP8mzft5bYCF35DyyWBdm9iE/Zddc0LGoPzmUc+KK?=
 =?us-ascii?Q?nPwrnQLfGgVEztq0rrLZmDLDW9hB6oBGA4bO4zLSuPdp9YjS7Qce5QntvcRh?=
 =?us-ascii?Q?bK7cql7T25zIGdihz5yi4uDh0l/kIMytykIzGkB5U3PtBnnhQ1Uluau7f0gE?=
 =?us-ascii?Q?sggLJRV6mKwb7yem3ZJroAQIanDtOGgq0Lp675Q537G3qHU4tI4jyuk5e8aK?=
 =?us-ascii?Q?hV/Gn5CgABRRUIR+3/SBN86HfBjj0oapDRaliS3YNX8dsWpX2hjW5oO0+Hmf?=
 =?us-ascii?Q?WYwdx3AAKw2U1HI+FzuEIAvpbdR8YQEaJ9c32j6DKdAYX08S+805GqcUXPh4?=
 =?us-ascii?Q?hC5lpewffVuXa0B/Vf5eF2z5OIlOqxFqHlLAyRsWrGeWnRMAztTnLQ/4cx5Q?=
 =?us-ascii?Q?MRwv6aCr0W5pmHGTE1sbHITHXEwPvVmY07QLN7+LEJRPKqb6Y2Tnz6poegVX?=
 =?us-ascii?Q?f8hq9rAnu2/bBxCu+xlY3GRlNJAESJWyxsX23IJCmnY6dT/zgShAfAzovyB9?=
 =?us-ascii?Q?GOFOztd4VdXOIYjh1prvf9n9vW0QPCftv1fQbPsGHOWU547Qxb8Nm2Vq+v7+?=
 =?us-ascii?Q?35rSKfTE7OVhAioeVI5aVdHqqcoO7Bp7jnVXxCkLlQH5x2P1SEhJ1n5/swdx?=
 =?us-ascii?Q?a8BWVAbbbZ3ylZbt3k1uqGwDN/mHaFdJbYKjSjtYaPREJAZfsoECT+OVsX0c?=
 =?us-ascii?Q?9fD6B0DHL4Vai9REtuGPuWEHPAPQUfoVCz5oj40AkZ2uQiCwOWkBeFBBCP6j?=
 =?us-ascii?Q?TeFWf/1CgmNiIveo3HxkPXKPVhuKoxnE857zNlPvFuEA80TrsC031usuPF6N?=
 =?us-ascii?Q?MNjjXp6UnP542GCEW85RCdaNn6wkIlKtyyVLT5erwE5bQDxAi6gzf7pYD64r?=
 =?us-ascii?Q?sCTTdkVmsYeUJU8MGqGKO6WqQ+hUX2XkN1U7fT69bhVjzINID+mfJZM+hi8q?=
 =?us-ascii?Q?xqM8fo92zFDlhfi43mklHfGVXoL5uy6uREICNGVeGJo3QS1L71cAOYXGcFQ4?=
 =?us-ascii?Q?h6D8Stk1Q3/MTFqOqyt+ZuTcyV32i0xStDfSs8C+sc0Ut34/ATLjxUnCZZZa?=
 =?us-ascii?Q?zpEr+P6IFRQy4bqm+5uBDk7DVWRAqXlwPUl64+F2shmpL8BL2wNsm13XpFtf?=
 =?us-ascii?Q?EkLefcRZt1QNWHKlEKjG67Iw7JhsI4TxFuCcd/ookMVdO95KKJb5HAJPZo6B?=
 =?us-ascii?Q?R0co8ND9yVx8hrQfIRL46YI2uMUWRZJbUBnM+easH0w4FSAVqKwaI+HXMcpM?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3281defb-3f65-4281-61fd-08dce3b5230f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:10:29.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6En6UTKZSU3qPxUVpP6NumX/C3Nq3bTHUEOSRGfY3duqKj0+WThyyNCWXk3Tv+lYRtqIu7P62KZQ+x/CNeRtjXKv7k31UrPjeTyStopBhoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6676
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

The current implementation of the circular rx buffer falls into a
common trap with circular buffers: It keeps the head/tail indices
reduced modulo the buffer size. The problem with that is that it makes
it impossible to distinguish "buffer full" from "buffer empty",
because in both situations one has head==tail.

This can easily be demonstrated: Build sandbox with RX_BUFFER enabled,
set the RX_BUFFER_SIZE to 32, and try pasting the string

  01234567890123456789012345678901

Nothing seems to happen, but in reality, all characters have been read
and put into the buffer, but then tstc ends up believing nothing is in
the buffer anyway because upriv->rd_ptr == upriv->wr_ptr.

A better approach is to let the indices be free-running, and only
reduce them modulo the buffer size when accessing the array. Then
"empty" is head-tail==0 and "full" is head-tail==size. This does rely
on the buffer size being a power-of-two and the free-running
indices simply wrapping around to 0 when incremented beyond the
maximal positive value.

Incidentally, that change from signed to unsigned int also improves
code generation quite a bit: In C, (signed int)%(signed int) is
defined to have the sign of the dividend (so (-35) % 32 is -3, not
29), and hence despite the modulus being a power-of-two, x % 32 does
not actually compile to the same as a simple x & 31 - on x86 with -Os,
it seems that gcc ends up emitting an idiv instruction, which is quite
expensive.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/serial/serial-uclass.c | 10 ++++++----
 include/serial.h               |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 84f02f7ac76..05fe9645bee 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -328,11 +328,12 @@ static int __serial_tstc(struct udevice *dev)
 static int _serial_tstc(struct udevice *dev)
 {
 	struct serial_dev_priv *upriv = dev_get_uclass_priv(dev);
+	uint wr;
 
 	/* Read all available chars into the RX buffer */
 	while (__serial_tstc(dev)) {
-		upriv->buf[upriv->wr_ptr++] = __serial_getc(dev);
-		upriv->wr_ptr %= CONFIG_SERIAL_RX_BUFFER_SIZE;
+		wr = upriv->wr_ptr++ % CONFIG_SERIAL_RX_BUFFER_SIZE;
+		upriv->buf[wr] = __serial_getc(dev);
 	}
 
 	return upriv->rd_ptr != upriv->wr_ptr ? 1 : 0;
@@ -342,12 +343,13 @@ static int _serial_getc(struct udevice *dev)
 {
 	struct serial_dev_priv *upriv = dev_get_uclass_priv(dev);
 	char val;
+	uint rd;
 
 	if (upriv->rd_ptr == upriv->wr_ptr)
 		return __serial_getc(dev);
 
-	val = upriv->buf[upriv->rd_ptr++];
-	upriv->rd_ptr %= CONFIG_SERIAL_RX_BUFFER_SIZE;
+	rd = upriv->rd_ptr++ % CONFIG_SERIAL_RX_BUFFER_SIZE;
+	val = upriv->buf[rd];
 
 	return val;
 }
diff --git a/include/serial.h b/include/serial.h
index d129dc3253c..14563239b7d 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -299,8 +299,8 @@ struct serial_dev_priv {
 	struct stdio_dev *sdev;
 
 	char *buf;
-	int rd_ptr;
-	int wr_ptr;
+	uint rd_ptr;
+	uint wr_ptr;
 };
 
 /* Access the serial operations for a device */
-- 
2.46.2


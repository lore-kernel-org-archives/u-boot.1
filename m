Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA8FC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462268354B;
	Fri, 23 May 2025 18:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="vFDMwH6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801E3831C3; Fri, 23 May 2025 12:57:14 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADCD830EB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 12:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=wojciech.szamocki@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsZN19h6VYUzo4P21jx++vU0k7pG2iwYOFsqYa8jwOROoq6WfxnrEMe+PS+pWjCkBrDjAcOycTRjjrCdC5PRhfEbK0nMGGVW6VUGvVSDYV7jbzc1kacJtH/qXZiMskB5R5e+DMAHuQCD7NbC/+Pl1pLjDiwS9LfkkHRKNB+XesLxCV80YcAyJcnl3eocT3QSPLBLeItWPQi1VuY2CxXsBSw7nR/y5ggtwRP4RCTzbyZI2UVL4Rh/drJfrGbGmsKuHareM3s13eK14QNp/hXv00rLcMlWgQWV5tyEEtYAHwdiGqF/LHH93OFpfm1CKWIs9a9eETEL8CKYFL7Iu5Dppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSwnK4esHt68azmMtWWs7CTI0+57mctGCKojdu9bJv8=;
 b=T12xSuGLk94MA03CPyHRSkg3I37jwTg7JXzOfubZ2xl0I1ciznirrem9BcGw3qvzJx4C7/oNKxpraQDdKqKFCGcpcS5PZGY+Y4qasz2NwitThfURLCw1jhVJ5dUsUGGlvE/GtnGZWPEDhlKq1zGCULzYRbLEGtIE+IbRAyK9jT1sICn1SpemvYGGS3FvAnMlWJVes5jHR/gGq/hxXi7hRsdkDI7/iPqDN1woEJXxaq70cY586STY0h/jMO6FCq3gvPc4uB8GSg9d80VnmV4TfNJtPiIrhOTIau5spWIShaTXuJqypacMqxm6eGA3V1evfjoeBZX+AeGFTXWMgBReqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSwnK4esHt68azmMtWWs7CTI0+57mctGCKojdu9bJv8=;
 b=vFDMwH6rRu0GQQcoyZqj+uMX+QXEpvKrsUqTfa+uKVwOenOA26Bmtdodez+HDslMJVA1qahCa3Eq/JzLEgojnrOb0WM6299ppU7+o8nj+7L6afQlbRjX1Fgyp4kp7kJVL+wIFosXZZlqnp/qWyKJ7EYva3Rg/xeElmjmVluGqgP8jUu9EB7NAI3nAXGsq8Y4ssyK5zS1tDTRKDySk2qDlLLCTp5r0viv9UJqLtLak826Eyq1Bw5HW6n+BkokRlUV0PIqS5oOW0x8QoLuBEvge/ibnraORtPkDSOR/Ht53fkfpQDUiwXEGxtmCmIu3rFHygGXnp8Wz67W79Dijc59Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PA4PR07MB8462.eurprd07.prod.outlook.com (2603:10a6:102:2a5::8)
 by VI1PR0701MB6944.eurprd07.prod.outlook.com (2603:10a6:800:19c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 10:57:10 +0000
Received: from PA4PR07MB8462.eurprd07.prod.outlook.com
 ([fe80::586a:e522:8ebe:8aa6]) by PA4PR07MB8462.eurprd07.prod.outlook.com
 ([fe80::586a:e522:8ebe:8aa6%5]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 10:57:10 +0000
From: Wojciech Szamocki <wojciech.szamocki@nokia.com>
To: u-boot@lists.denx.de
Cc: Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: designware_i2c Return -ETIMEDOUT for timeout errors
Date: Fri, 23 May 2025 12:57:07 +0200
Message-Id: <20250523105707.16605-1-wojciech.szamocki@nokia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To PA4PR07MB8462.eurprd07.prod.outlook.com
 (2603:10a6:102:2a5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR07MB8462:EE_|VI1PR0701MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f95f61-62ee-4b95-f181-08dd99e890fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MzgwISzFl0145kuiZOp3evPms8Abbxk1banMw7kojVLIFI4gxdnAHlXNp75M?=
 =?us-ascii?Q?LC3KMdnvgI/dFJhq+wg9wx9hI0PzrH/kiOGo+Yt9CrJCEnHhcf60OU+JY5Ck?=
 =?us-ascii?Q?7yrRdwjv5HVwWj9TDipfUxji7KnLXw5/kBsKzd03GTQLgKbvqqxbQw6lKDij?=
 =?us-ascii?Q?/Gm5PiKh054FRp6aueO4wRI249lU90YHoMjH1EVrrX9cX6DIil/sgW1ZrFUl?=
 =?us-ascii?Q?XXZpvaVpfKVGNuDLnHmD8Se5FPlqKKM5djC3IqSNw+HFxXRHOlbGcJwTDO6A?=
 =?us-ascii?Q?Es/53AzsLoLLEo2oBlZo8SFUpGGxvenwuNNYatTupbpFXLDrKSeppwExp3HC?=
 =?us-ascii?Q?CxS8BjNY8/FXdgSDZcD9SXG0e4p7GkxCxeZQYfF/Oyy4FMcQAbmp4kB6ihMX?=
 =?us-ascii?Q?jVuSXVH2J9/RfBEGM5HCxZjjo6I7Rod+WwKtMVRJ6mdj2HOf1/1hVgPkRXCf?=
 =?us-ascii?Q?dt8K2o5gYYKDlZvhlY00FME22hcNkTkYZMOjaEeTr1BN/iWmA/9rf2eXmxPH?=
 =?us-ascii?Q?P8XbauI6TwW1jZwaP6jAOucOwX5B33Qzj/FiNYKgi2H65QynPmHeMDABeYz5?=
 =?us-ascii?Q?grYaogHmrWJs7V8/EIzBGaEbFpgAaxVGgZajKE+0jzPMqWJiVOcG5a2EAmPf?=
 =?us-ascii?Q?7/kS2CwKq6AeK83dNH9eeuQD+94HMu36mRlzZpIjdB2bbV/5OYEGmnrRbBBf?=
 =?us-ascii?Q?SvAyMzoqznS3Eg/ZJo0s6PPpgj1cuLEHxh5HMCxLHeesp7uh1ImjFsV8BbYE?=
 =?us-ascii?Q?0k/PyeZjJ5L2TOJPHyzJc/0UFNYnSBfDdbjphx6DOQ6ZiJ6jvNk/A4zSotGI?=
 =?us-ascii?Q?5OS2lswqCepg/PRNSJP0geznbuAMykkiLunmXQ8HhO9aZwE33MZLbHzOEW4n?=
 =?us-ascii?Q?hTUGUYcD+bXq8ORpn+xmWj3TzyIaDF9EKP7rEVUhpLcRlRmzqC5PzzEyjIF2?=
 =?us-ascii?Q?3pPM0PH8N5ra1bBcCUIW0LxQUhUjOvGYqS5RyRMI9NQ9P/xLvbR4K3utRcbY?=
 =?us-ascii?Q?lhERCzdq9iM8qopnbd9d1GoxWZYPdOi2qYwi6gBaqQiAYh8epwnHDxlmAlLy?=
 =?us-ascii?Q?SCJk2QoScZK2wVG8zQSCMrxD8KOUS0X9PmFxTd/XcBUQlrBC6rvEZ/CzCPmu?=
 =?us-ascii?Q?cukaWerhokxwOoEzeJkCv8Ve0Hng4MxJ9j0G2UhVO/VDNR6wnWTYKSAq8X3U?=
 =?us-ascii?Q?KCQlqX5SdYNQgV+XTcb0nslz/Oh+2brvndI89aZsT59XgXIVxtW2a/3ter/I?=
 =?us-ascii?Q?cD6ZV4gYraAnxgrEfQfaC1riwrevDHku4odAc6GIzLCoTLSVkOyy5lXjYZM3?=
 =?us-ascii?Q?C4ACaZA7+fm4fRNR0+kGJVdkg+UPsbHS30N8P9POXyq1sc0cJsHkOJN6hThy?=
 =?us-ascii?Q?9rULVFpnbxG7Fi1nR2l4T9ELMWezzP024240jO/4c5JzNcadwFMOlHUYGlRs?=
 =?us-ascii?Q?A7S++8Yhbxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB8462.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NF0K0fZQ5POcse+V9FN848Ewoe5A23+2DU1kLlxkQBQk/2Fo8yWV7QCxpEHW?=
 =?us-ascii?Q?lj1GmVeqEVaQ1HasFql5QUkrQK5PCz5SwlIUI3ksfJQdPe2BfjghzrTjSrWT?=
 =?us-ascii?Q?LnzJp7AvTDIA98xhM8AUevpjYNbmajCoXNl3FKYwKgB9s+NhyYaXtEKVArK7?=
 =?us-ascii?Q?UzW+TNKDCOYPpisQUdPNuUfXGbH5+NZYZdoiXsI9MTi6nGB/ZUMGfGRaDmAq?=
 =?us-ascii?Q?JvGn9fNGLNMsbzrc7hsYLmbfU+GBodxUgdD0mlKxYI8fN5JVH+ncVMkzddJn?=
 =?us-ascii?Q?PSae24DzLt4MK8SJyAV0p72V3BlnmfeAbs8lfmLqLHBJI/9VOnypxEZDSce2?=
 =?us-ascii?Q?TeeGgaRGqFP1kda1KIQw+H3KIBWewwY7aQusdp1AaL0AX+W1W844TOFnhcO/?=
 =?us-ascii?Q?9neB8qoTyWDrFDYQH+qNcVaTssAQGSLl/5PT0emINdD2F03UrRzrf4CG8/5Z?=
 =?us-ascii?Q?SlyxdWwnCLXqNLOQ9NVX+i4hClYdfxMeo2B3gDAmO8X1xFsIpuB3j01G46W3?=
 =?us-ascii?Q?acbAxGIrAP793RAP3UbrPQFq5CaeONQ9uDk3+7eODJxZqc5y6IFkV45N+iKd?=
 =?us-ascii?Q?t6V4HOncIyAfttbmOy6nhVqNF/ALIAILHa3aR/w5jdhSd1jlD5U7JGMRrzxX?=
 =?us-ascii?Q?2jK+nyZc39+SjOaSv0aq+ViToWcOGfSIhCMY7thO6GofoNdZ6pYrgOkJqwRO?=
 =?us-ascii?Q?uiORD4AHlIcRXt1RQFU6Q5dV6Bon7aOSOoMoaKIkOX8g4q8zGsScUimfNJkP?=
 =?us-ascii?Q?pRT3xjY4V2KGZtK/C/sa5oOccioRKpNw/8lxUGlPBCDxR/+CB4ei0zDeFpAB?=
 =?us-ascii?Q?q0FIJL2bWw7zL++dCt3MXXIY28Zu9wfTplr2KYYU5GFv8wCljga3EliNx8Bn?=
 =?us-ascii?Q?dxFHBQVQPoY6wjo/MxWHnzzauj1Ie6yfBq1dbzh9YMdE64scZ8n4ntGR4XiD?=
 =?us-ascii?Q?hb+6IPEKjOeW1FAga0sEDjKx4ng2pFI5IzQQRSsgPpe6uLoHigfI2N7NWhjo?=
 =?us-ascii?Q?H2q7m855IFVchVNmyfffCl0h9ASX2MtM918Ssp+Z88YTgMRlWxgJynW9/LFM?=
 =?us-ascii?Q?enBU0qZcBm48Q/qQ+93q/+3Zyjs5yhNaHGYpJsOzX9V1j9pwmJPv4s2qIP+2?=
 =?us-ascii?Q?mfHSR2FOLDSPVDh1SbgQbcQT++7I/jjmvhIOuoxL3Xaca/qeZCJqoovWF9gt?=
 =?us-ascii?Q?JRcJnJIcnSIpcIQLJ7lq9QtvAg/IPV5MCvVZsW4rMe5sKMS2v5zgV39SDxex?=
 =?us-ascii?Q?m2cL9VyqRcgDcHbK2y6BMEtOiO+fPdv03nNGjP320kb3Jk2gj0fqDeJm9Vnh?=
 =?us-ascii?Q?bzGkOUDby1pT7GmXId++MsKRzojv+Lb4e3HG2bh1pAsU2fe5u6U33R2ohbPv?=
 =?us-ascii?Q?sxSDIfm2hGUDVA9ZFwiA7p/8uoykarzadnwiMgp3R4jH1Ar10+D+DN/Nd/c9?=
 =?us-ascii?Q?eeHeEdY9F8lCedcAXyoK4x4SUI5OibZGRc4gPuUyZ8LKwvqxS7USIHLg15Oh?=
 =?us-ascii?Q?B/RtlHM+Vj3WgCC1WR6n6ManH9acAHIfk0jAHohZ3XUiYtHhoFVnD9oyahDX?=
 =?us-ascii?Q?BooHHoBu2+YBTgbPDneLLe6+ZISDcMHgQ3eR7vI1xAkStGOso6axFs3ozXFy?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f95f61-62ee-4b95-f181-08dd99e890fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8462.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 10:57:10.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6iOsZoP8AO90itSortxVFxELfg+3JIIQEI0vghIAy8eM6+RPbKJEDocb3c1oKKru24m9G2NSGt9yhnhl26pIc1y8ij7GyOHi18O3V1ljPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6944
X-Mailman-Approved-At: Fri, 23 May 2025 18:56:12 +0200
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

Change the return value for timeout errors in i2c-designware from 1 to
-ETIMEDOUT. Returning errors as negative values is standard practice in the
u-boot, which enhances error handling consistency across the codebase.

The current behavior can lead to silent errors when functions check for
negative return values to identify errors. For example, in
`dm_i2c_reg_read` from i2c-uclass.c, a timeout results in an uninitialized
value being returned, potentially causing unexpected behavior.

Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wojciech Szamocki <wojciech.szamocki@nokia.com>
Signed-off-by: Wojciech Szamocki <wojciech.szamocki@nokia.com>
---

 drivers/i2c/designware_i2c.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index e8c1623d41f..a54976e7889 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -404,7 +404,7 @@ static int i2c_wait_for_bb(struct i2c_regs *i2c_base)
 
 		/* Evaluate timeout */
 		if (get_timer(start_time_bb) > (unsigned long)(I2C_BYTE_TO_BB))
-			return 1;
+			return -ETIMEDOUT;
 	}
 
 	return 0;
@@ -413,8 +413,10 @@ static int i2c_wait_for_bb(struct i2c_regs *i2c_base)
 static int i2c_xfer_init(struct i2c_regs *i2c_base, uchar chip, uint addr,
 			 int alen)
 {
-	if (i2c_wait_for_bb(i2c_base))
-		return 1;
+	int ret = i2c_wait_for_bb(i2c_base);
+
+	if (ret)
+		return ret;
 
 	i2c_setaddress(i2c_base, chip);
 	while (alen) {
@@ -429,6 +431,7 @@ static int i2c_xfer_init(struct i2c_regs *i2c_base, uchar chip, uint addr,
 static int i2c_xfer_finish(struct i2c_regs *i2c_base)
 {
 	ulong start_stop_det = get_timer(0);
+	int ret;
 
 	while (1) {
 		if ((readl(&i2c_base->ic_raw_intr_stat) & IC_STOP_DET)) {
@@ -439,9 +442,10 @@ static int i2c_xfer_finish(struct i2c_regs *i2c_base)
 		}
 	}
 
-	if (i2c_wait_for_bb(i2c_base)) {
+	ret = i2c_wait_for_bb(i2c_base);
+	if (ret) {
 		printf("Timed out waiting for bus\n");
-		return 1;
+		return ret;
 	}
 
 	i2c_flush_rxfifo(i2c_base);
@@ -464,6 +468,7 @@ static int __dw_i2c_read(struct i2c_regs *i2c_base, u8 dev, uint addr,
 {
 	unsigned long start_time_rx;
 	unsigned int active = 0;
+	int ret;
 
 #ifdef CONFIG_SYS_I2C_EEPROM_ADDR_OVERFLOW
 	/*
@@ -484,8 +489,9 @@ static int __dw_i2c_read(struct i2c_regs *i2c_base, u8 dev, uint addr,
 	      addr);
 #endif
 
-	if (i2c_xfer_init(i2c_base, dev, addr, alen))
-		return 1;
+	ret = i2c_xfer_init(i2c_base, dev, addr, alen);
+	if (ret)
+		return ret;
 
 	start_time_rx = get_timer(0);
 	while (len) {
@@ -510,7 +516,7 @@ static int __dw_i2c_read(struct i2c_regs *i2c_base, u8 dev, uint addr,
 			start_time_rx = get_timer(0);
 			active = 0;
 		} else if (get_timer(start_time_rx) > I2C_BYTE_TO) {
-			return 1;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -532,6 +538,7 @@ static int __dw_i2c_write(struct i2c_regs *i2c_base, u8 dev, uint addr,
 {
 	int nb = len;
 	unsigned long start_time_tx;
+	int ret;
 
 #ifdef CONFIG_SYS_I2C_EEPROM_ADDR_OVERFLOW
 	/*
@@ -552,8 +559,9 @@ static int __dw_i2c_write(struct i2c_regs *i2c_base, u8 dev, uint addr,
 	      addr);
 #endif
 
-	if (i2c_xfer_init(i2c_base, dev, addr, alen))
-		return 1;
+	ret = i2c_xfer_init(i2c_base, dev, addr, alen);
+	if (ret)
+		return ret;
 
 	start_time_tx = get_timer(0);
 	while (len) {
@@ -569,7 +577,7 @@ static int __dw_i2c_write(struct i2c_regs *i2c_base, u8 dev, uint addr,
 
 		} else if (get_timer(start_time_tx) > (nb * I2C_BYTE_TO)) {
 				printf("Timed out. i2c write Failed\n");
-				return 1;
+				return -ETIMEDOUT;
 		}
 	}
 
-- 
2.34.1


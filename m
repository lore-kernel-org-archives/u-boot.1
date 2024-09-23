Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0F1CF9C69
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9254488D13;
	Mon, 23 Sep 2024 14:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NZGKyOnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55BE988CBA; Mon, 23 Sep 2024 14:21:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716D688D1F
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnmaCbi1ZUxkW67d3RyQ44wblkQNMgzUcNx7W0on4z/hMd/yyxrMI4qQvWonTIKRezOk7RJPWoCRj0VKS3gPxAPcoMBTJNJ4VxgYFtmDP5O2DJwcfdjoqYzKg6DMMW++oNg567zv7mCpSV16Hkm8325tF+NidsIBoKpNrUhyJJIFg0Dt41YqOXcCcJ4fsa1X5RMziaKp8hE4B59m4a2OAjnVMDHw2ZZcj6ybRt+4eUMgiybNxN182EbFVyAWH9KcitBqemlqkJAGJL3er4WZVmR/SgTvTt9WehDW5F1D32sJ0Sen3LO/m4mHPFZR9L29AGZkyWH3Kj39bVLew5SHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTAvShnbSyM3/iHpU0O6bG08zZrlb1hZs39pPNuEVgg=;
 b=RKEIdR3XqOwOt0tiUj4lrcPcDTTgf1asj5wnRStVa5iQ53TGngrB0F0/vymqQpzuDmCGCUbROtOyxLom40mTjB5n4XXEaUrTWJgc6yzIXfd7vcWxvOTRHm6dI9RXqheJacqO9Rq32+ghngG5vJer+MS1ZmV2e4qmv2a0QRDMrUZdNuWSQVtpiTGCuRxQyDk57WyIJ6A4xOg+dlxl2QoXOaAjBL6cJbV+uuq+G3H4dGp8tcTT//Hu4cZHwfu/QPERwm6jCy08hHoyb2iIs4RXdGIIrcEZxB23Moav0znnQc3fzK1aVwCfHa8PkHURK12pGq2OsoRbNAhFvtiVKGqmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTAvShnbSyM3/iHpU0O6bG08zZrlb1hZs39pPNuEVgg=;
 b=NZGKyOntZtp6XtKtajEUhs0x2nJbNX+NwjouAobtZ8wF301BtOKaXuIGFeVNlcnRB5zJNekxt3yi/EYpat0NmHqms70yYa+6W7yLKDg4a3RJ3jeanW95EMCQBhzghrF3aa2dy+SIJxmm/Azd/zEzWjK9bFhnnBcV2LN0VCGpI0FyDbiz6Ueg+t1pfG2VrHTUnEOpE17oGA/FNq4eXjWNjBCGrrLVhrPu0/Z7rxEOVyIvRb2QpkGLSuKrPbcq+h2oKSmmge97ArBaB2TIPMY1ly+vQ/7cEVi+CtC2ECWmvK4+ep16Ugz4dk8zVcIME2ni/OYYQaBZ+z7zLflx1Oy0vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 23 Sep
 2024 12:21:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 12:21:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, joe.hershberger@ni.com,
 rfried.dev@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH] power: regulator: Fix power on/off delay issue
Date: Mon, 23 Sep 2024 21:24:08 +0800
Message-Id: <20240923132409.28947-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e18f22-7330-4960-2445-08dcdbca3128
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P5KQDb7BkqnP4TfMILrr7/NQDUb7GOFf3xM4z9FYeqD79S0zUKR9e1Ng1EMe?=
 =?us-ascii?Q?rIBE5QlcZ6SRcIpZZDak9MxaEW8aaswq7jNjNswOV+nsyErD/VWWWY3e3puo?=
 =?us-ascii?Q?W9vI8aEPIm0Fw6Rdi4dQZyjLFOjW8tf5wJ0m4fScFO4DkOWaysIThc/VhOz7?=
 =?us-ascii?Q?yBo7U2N/72zjam2LppMx2wS+ceO5xPYvbbul2ZXk978Tifd5ELYhpj+ZDgJl?=
 =?us-ascii?Q?IJkkObhiXnOdaBoidub1JzGlYWyUmMrXdUDZIqCdWlO4xp7VHd1pTw2lM6qZ?=
 =?us-ascii?Q?MRHB3D9Eqwn70gZo8lwBTu3fYnWpLAqyuwKX84O5EIyGUNRyJ74s4UiFBTx4?=
 =?us-ascii?Q?uCc8diSYXyCnCd5GZLHkYrJvgqAZuGNRmpe9mweH75qZdG+Y2z7tvwM5oqJs?=
 =?us-ascii?Q?M6YYnLLvc4G2bqXybXHBAiv8niJbM9ABOcL7gqVKkwE4iVYRNbJhBKSB99b+?=
 =?us-ascii?Q?gndmnCDLd+xJq9zqb9I27SmPhZzLv5sVRP357+dcs9Ib10QW89mV+WyR1xqx?=
 =?us-ascii?Q?gotU3gposmpf+R28JpJEX3XkdbEvGISBxwXp26Ie+2EiwLvT2urmk0pXwQpY?=
 =?us-ascii?Q?haOA3RY0vKQG9+gkfF0dMb8kbIcvERKyIRZfPRxq/dJEjhtiJXzcQi9f8z/n?=
 =?us-ascii?Q?SBoVS+So4QfZ1XcT9df5iM6Z5aoUVs775qsS81H9oF0+koXVnCa1LWn+81Y/?=
 =?us-ascii?Q?8zpbyLpI8HgC8YSxoK3/C78lt4dMNGmDJPN8g/RZ0Hatwi3YpZDX6CHaQcHl?=
 =?us-ascii?Q?qBgbDjpwu9PKlFwAPmIUAT3l6WGNdZW7LdwaDcHt7gcxcGTYPGirYSDm2OW2?=
 =?us-ascii?Q?XcCmvVwMjzhD5e3Sozz6SLQ+fTwrNGb3Am5j8/db8z7hX6JahVjvVwRcw+tM?=
 =?us-ascii?Q?f0hqaQtlCwtdVGDalE0HuAiCjhFhJjnUqFizUKEZQViyvr05b7DjaCFE4RQM?=
 =?us-ascii?Q?IEXxxX6LLuOM5xu5948XO8kyoPffkFo9nvCGcubV5XzBmH321viVM71da3CC?=
 =?us-ascii?Q?ZYwTDt9ZjtbVLCGVBmESf0sYzlCCyhaOYGWi5BRoVZ8kojvM03rC1cNepvkH?=
 =?us-ascii?Q?0FnUQaKD0WwuodsHTIIpwwzGTA/ebBwSHXA/iX8ASx66xBUJ/YPpN3HvjWAY?=
 =?us-ascii?Q?uZenSCc/CEtXKe2N6S8oCexnxYgOVVqIU7Zj2ZJ9THyGM3UAUHpxlAKQ4f4E?=
 =?us-ascii?Q?3slh68vcqmZE8MAwo4kyJSIqVpPUeatD70oYPBx5ZqMXZySmgdcD8PSbc4gl?=
 =?us-ascii?Q?PJw63huxp31PFf0aM+w5yCEqUo1ZjLg0PstDW/dOk4DolGURCQYX3b2kZzxd?=
 =?us-ascii?Q?CCbRuzE7G5U531M1DurrAmFj79VDT5143DtC8sBabZn7VpAWI8BJMjLo/RNS?=
 =?us-ascii?Q?1fyQrt9QIpHJl8znVEFioHaPpfnprbFleStL0sK1MhMU5V/Khw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOQgqmSqDAHbOVBYl5FWJOg0mAz6hy9O4L+Gsv3guvRXjtsaQxqZcehgSlxS?=
 =?us-ascii?Q?IUagbdH43Dxx7oO9r0MzgEmSuYUzMfOEjTeo6MJtOtJMX7XCSAuWqDUNbvPC?=
 =?us-ascii?Q?s6leLkDjg7rgnYNMt8M3i98VyJ2My5jDy9nHWJ8a8BBeQjsZ2lax5vUmnpJI?=
 =?us-ascii?Q?fZAqi9amk/7aa+aT9CwYbkekAoSKZKT9cUpX8kZtiPFB6aSmgMFOqEJGE50u?=
 =?us-ascii?Q?T/OosPuZVuk03vKsUdWgb79FMFXDbwfTYAB94Otbv3NFPuWkkXB6jd9+qY3a?=
 =?us-ascii?Q?f9V2AmIb0uNZVGS7RkxCDLZ/b3psFykAmza3RoJcqEMeotf5i6qg1xcW2Svd?=
 =?us-ascii?Q?SHTn0C/JjnDe7NzuOwDVFnU422Aw7lyjvEqcb15nPCD7iVW8umbdWIZRUz93?=
 =?us-ascii?Q?XFty27hDfnMMHQG8MKYM9GdlyMrfB6IHQU1+FWnsreXQhmDL/RDWmjtK0k2B?=
 =?us-ascii?Q?6PWAMwlOqCEDj2mmd6mIK9nv+sScX9PfWXO+RIo6x5nXVTcZk2YKTZJBuW1v?=
 =?us-ascii?Q?gnthYEBDrNKSIVyI2G3ivFvFdmCps43+jG1vj9blGsY/M1W+tsHObop7vuOw?=
 =?us-ascii?Q?UtkmRVq93kd792y03sIFgIlUocStpRKhglWpw2SDk+WQWUZV9600oij4g6tS?=
 =?us-ascii?Q?Ab7QborP5u1I9xaafUm8/i4cd3PMyFWTqlqGTugy7imh0wCe01R4STYGRM67?=
 =?us-ascii?Q?scDSWAqmZl6M3sCxJ9Skgfl/rN3k1MBIcBC8cVowvOhsnkbC3dvILfhqIia9?=
 =?us-ascii?Q?0bqeyGznZ0PLlCWQK99bS6WyqTWFWks2a/C89IsVNkoRWe90MkMw72AqOPKZ?=
 =?us-ascii?Q?sCDKbphZXg6FhXDbNWzKkL5KQuLSBWBoBRZ0kpyyySsJyd7aHBVZaLUG5W1c?=
 =?us-ascii?Q?IvksxZc0a71vcPWhpechMV2xFNM+iFUdQidnCDx3XKLq3eUH03lHoyc4y1NR?=
 =?us-ascii?Q?/FYXmjJ6bE5+GA00W22M7uJJbmiIod4qV1QuzN/HWjSlAB+LJh7LsZmqA0pr?=
 =?us-ascii?Q?+Ek7MUWRLDpN2rBDqMu0bzgcdw0W3vinnl+d9gqyb0whynL5MttMXXBrQ1cc?=
 =?us-ascii?Q?2VA7kRyDetsyaBK15eWMKAFzgybSFfjjczpnofDi8y1fNeNwJ3rWXh1pECP8?=
 =?us-ascii?Q?jRad7SaMy5CWp4r9F9I7SXAxA1SAET010GpMC5y20sexBzFKNMdbmE+Mus3F?=
 =?us-ascii?Q?T4eDV9DcYwHpcLCRbnUHswiznN/nw1K5l/RtKlKPjYyg4XeXkHS8lHf2edTP?=
 =?us-ascii?Q?ZpVr+cA5P9Q/Qk00A1dwAR7mGyWhOpxnz0glCq/bihifm2CIz00RCggaXFsx?=
 =?us-ascii?Q?Aev7qHeRSoq2HIPS23xBcYs28CmWpKVzmMlcbkKsyF3d2dmRpCv3UiN3KAkn?=
 =?us-ascii?Q?fpb0Bgt9WbAPuWMheaEbkWIlZAsaDnsLwrFqt9Jwsrb2aLNIv+4u9AuBwtHS?=
 =?us-ascii?Q?TVXNAblfeeR+qawplGaDgoVUmvW7EY3yZNwUnJawRUnuk0D4Rkpbl4haEXzI?=
 =?us-ascii?Q?trlhvOvhtttRZq0aRDOyE0nstGsqCHjyz9pi6dtfGU8vbXKHJU4uY9LTA2n+?=
 =?us-ascii?Q?MckCJdOUdcvmC1XDwme3Y5VtCdxbSAoZ6xKVqcyL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e18f22-7330-4960-2445-08dcdbca3128
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:21:03.8208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfRLRui5Fov2G9BylIszzT8iRv9xkqjh53c24XWV0587XZj+cuI2AQzTUBqKhQQt+9ydwyhYfd5vKHcQgZO+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752
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

From: Ye Li <ye.li@nxp.com>

We meet SD initialization issue with some UHS-I SD cards on
iMX8MM/iMX93/iMX91 EVK. When sending operation condition to card,
the OCR does not return correct status. We find it is the issue
in MMC power cycle after below commit applied:
4fcba5d (regulator: implement basic reference counter)

When SD startup, the sequence of MMC power cycle is:
mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
-> mmc_power_on

Before the commit, as a fixed regulator, the GPIO is set as:
  GPIO inactive (in mmc_power_init) ->
  GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
  udelay(2000) ->
  GPIO active (in mmc_power_on)

After the commit:
  GPIO inactive (in mmc_power_init) ->
  enable_count is 0, regulator_set_enable returns -EALREADY,
  GPIO is inactive but NO delay (in mmc_power_off) ->
  udelay(2000) ->
  GPIO active (in mmc_power_on)

Because the lost of off-on-delay-us, the SD card is not completely
power off. To fix the issue, add the delay after the GPIO setting in
regulator_common_of_to_plat which is called in device probing.
So in mmc_power_init, after GPIO is set to default inactive, the
off-on-delay-us is applied.

Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/regulator_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index e3565d32a01..2192e900697 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -45,6 +45,12 @@ int regulator_common_of_to_plat(struct udevice *dev,
 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
 	}
 
+	if ((flags & GPIOD_IS_OUT_ACTIVE) && plat->startup_delay_us)
+		udelay(plat->startup_delay_us);
+
+	if (!(flags & GPIOD_IS_OUT_ACTIVE) && plat->off_on_delay_us)
+		udelay(plat->off_on_delay_us);
+
 	return 0;
 }
 
-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3384ECCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 09:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBFF835A2;
	Thu, 16 Oct 2025 11:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="fP23yfPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F4A835FE; Thu, 16 Oct 2025 11:24:04 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CECA9829E7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 11:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdjNvXhmwFMSiZZVJAE/C5huT+G8lA0eRxY6rGVFyf6OqDn7/RakSxZDoxXub7ln02DtzVn34+1baljwTtjghVxHEtvNDTHxNWATmKQ3/fx1xh2xiVzHcI7aCWc9k34yRTY0mwsk0O5hooJzsBSoh0WWD+l1pcnRiMDtkA4RCeyFzKmvfnxbP3pZCJHMZmT8Jn+ZsTpl7dPkutK0G25PJuOaAZC6I8zPdTEUGeS7dfVmerXXPjer65kWavm/8M+PMk/3RnlkxOcB+uTEiMgP0gW8mVDYeWcArxFjmeQdhm7e3bk8bCyOcsIKO0RJ9csyXemfpPBycJb9ZH7XL+oGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qMjojj0+My7DHpRrLFWuiNJbxKKkaWbM/JyJ7YW+aQ=;
 b=i3Q6HP00xMjjHD+LZFDA0tHHOnoUFoJHrOW8z0PxYIkA9tW08MRq8ox4r/aOmFOle/RAChDAg0zwR/CQ7XUHGlhY0Jvcqobs1ZFO9U7qfoHpzlz0bWpb2yh1hY78KtS5p+FlRGKVgoSBdYi1QA/d8N+E8Oe8BDaSYi6DbPwmbxjjf4x2lMgpWWqL0a5ZwYIfaf7y53zfLu7TfIhPln4nwZGpgT0avGVpp4cglpSflcD5fLXsZbuSSFOAMa9lYjT6OEC8TwHSMjaM5ALFPkcRYqasYMCyAnpUfdHEyQr4/xVRNAVpcx1iFQYhI+LNx912NQe/q/h8RP41lJ/wwUSXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qMjojj0+My7DHpRrLFWuiNJbxKKkaWbM/JyJ7YW+aQ=;
 b=fP23yfPr3MqQUxOmLWa9YVRf7tc48v62/apgG2P0u5SYUBbz6LdR1yTbKZWkj/62w82N790K4X27MMPQycm2ptuzZcqKU3GRvjunWqr56CE5+PtEqydXCf4Ec3IwfE9iAN6S2I6+zzVQa8uWtAL6ahZ5K9PR+LckwJx5fh+xD0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB6365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 09:23:58 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.005; Thu, 16 Oct 2025
 09:23:58 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2] gpio: search gpio-line-names property in
 dm_gpio_lookup_name
Date: Thu, 16 Oct 2025 11:23:55 +0200
Message-ID: <20251016092355.1569173-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: b22f99df-8ac8-4765-a573-08de0c95bc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NALnLDLikuMW0EgvIrdZsoMHXWV0peEyFUssVI86iItwcX1YbSIaqbHdLzUV?=
 =?us-ascii?Q?AZTaNvWf4whWfwXF+VJ8DdgiUmrK2BIogFtQGnfueupwSD0AdUHh+GygGgLQ?=
 =?us-ascii?Q?2NNK2vIUabLDGDvmefMFcoj8PPlV/G7/GAWlf7rzpznr1Y65AGN1HYGlFg1L?=
 =?us-ascii?Q?4ZvM0CxIQe12qxQwXCOXQU9GWgOvaefkoE4u5pUIazfM6uzC4PVCuZlxYEMJ?=
 =?us-ascii?Q?l2cOACYre4FpqP1dbxqYsB7Iw1sDwndAvfN2aHe0ZpqNcZX5f0QRauvXd/za?=
 =?us-ascii?Q?vcPP88T3E2qZVuVVdYFduY2K99jzT4Vp2xfS0V9WI8V9ng9DC2Pnb0RK6kEs?=
 =?us-ascii?Q?+zFAhttCcjjtIQi/QyVRCMyLHvPf1E7v398HzQ8vJDPQ9X2oENsrpVM8jEbu?=
 =?us-ascii?Q?Ywo8byTPNGAxQ/l854z0ZgwY4+swXtPIvejtCK0kwtOll6ZU71bRU+Ik+zpv?=
 =?us-ascii?Q?LbqrUSHZk8h7oZ7KzwoXUujvcSqo8mL5IjX5QGQRiNOPW3fvgpPF/WpQ02HJ?=
 =?us-ascii?Q?HGbW3loeAihxJjkROQQWwYd/2c/9/63A2dd+jC9GoJjmwPke+UOghZJvyuay?=
 =?us-ascii?Q?yNUj5q3U1E29zW7i0Qds5V98IDwVUIJY/ffrFthlTDYiAhSoVq5o9lZb83n8?=
 =?us-ascii?Q?1U1gP+ou/fLHzTHI2BwkUP717CYWTVR5lpgJjfIKTyZFIUGCVaie+sZIf69w?=
 =?us-ascii?Q?5tusDGxGZH6yQwluX5ZUwpRRekxo45obykNlTVWms4NyTdS6a7ugehkzu/WG?=
 =?us-ascii?Q?XORsToPDugCmAlWuq6beps57i1x684UP+Kb+7JwMka1EnKxJKudYuiT8P5Hq?=
 =?us-ascii?Q?IVBvKpgsKgQj0uqKdoroDajubaSEegUc4FSoaWoM9IQwFefFH9R7leGLD8/h?=
 =?us-ascii?Q?EH/roo2ZtCHPMsGuP0mdQ3lbtOwqT61mmPTLGbD4rmffOEMHHsmeEqaTcBe/?=
 =?us-ascii?Q?js3DLjkGew+Wv43KOQf+aV0vGCCceCLVEKpeCJ/+cL6iDU26tKRsxNUps0RV?=
 =?us-ascii?Q?ifjAAOsR0CbycW1a9oyBEPlVZkTa7+3N97/+OQjYAKKTJFGRRdmZfpXeXGxl?=
 =?us-ascii?Q?rWrRGVQT4oDSxhtFpHc2z2LTWhN1XSmuq8LwEso4ZR2pkJF0OFiNg2P2OXjx?=
 =?us-ascii?Q?D5G7XKG3NgsQLys6wWqYYEVXgyZfDYhfJ7g8GD8yCwEYVFtNrY0vTq9hyJ6o?=
 =?us-ascii?Q?evy0N6mnX36k+MCvk9XbzNWLOUSXqKj3S9pCr0fVW85usfdWs1Y9SciheiMd?=
 =?us-ascii?Q?heAs6QpJMd+1UlY3Pea2pN+iSMiZa0RJ28x2MkxcK33gIFQe0vFTOfpR1wyZ?=
 =?us-ascii?Q?+E/k55tXpbzaZQjfvFZU2eun4XESh/v0gUnvzJ4XJNZ+vqV8UikPo9qABy6i?=
 =?us-ascii?Q?8AmgrFw+tRT+87ojCgWko6fNCMHTTArK8hi7JFDRO6zZYX4EWUYHneezx8Fr?=
 =?us-ascii?Q?j0mzjfCCT6UzArrc7woZR42RdjXOLmIAFB1FwFJ9EKETmg8N+vdwQvqPa0xd?=
 =?us-ascii?Q?TaamCsehaJ2ceAcUVikaMo2Q8RE1ghYSnAZH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7uE3F4naPZPR6ZzmDVi4/Q4Ad4svQ04bStcfZp4XW9cB6Etc3uz27dVKazg?=
 =?us-ascii?Q?yLgy4iK75XUa5VAoI6ZBomxnth+Y5XX37lUCUt628xJpCUCkxOsSt5BrPm7Y?=
 =?us-ascii?Q?qK8g7n8SAGs2Qx01D+9eVO2imHwBHeTqadZTQxxfvZaD9RR/T7hwA1wv1EsF?=
 =?us-ascii?Q?5mb7ALJddby/1L8YB9B5eD6h/0iPgRFHhvFuHAU1d/XBghtbSfdt7p6Jdwz7?=
 =?us-ascii?Q?czPvyzXYyXRanNFBF/ir3/kzzCadlR5fZwdpqhpjVRkJeKRpH6M2M/07/Oml?=
 =?us-ascii?Q?I4LcZVgaAaux+o/4hEDejGaSBNvtKoSGKMdP2k5hJtPZOxJLCEMgFXxVsDt7?=
 =?us-ascii?Q?qMnjH1GTQ33ygZ5PkhYU2s9W6zbHcd8702W3/CFyDZnigPOcbCpXNT4qc+Q2?=
 =?us-ascii?Q?6xBlw3BuJQ80lKQMN9I1Bo4PNJE7uq5+sqsNhrg8yTPNV4WxNpoxcH3paMwy?=
 =?us-ascii?Q?wC6oq73TdzdiBmtEZT/vbV+iBqBt/fdji8HzvQGcj8IzbhEODysX2cYywEcv?=
 =?us-ascii?Q?YuUJKAHYEXBkTv/zzowzTPOL0L/yjHnrDmARUIXjtdy/BB23Xe9qdWWrDN2d?=
 =?us-ascii?Q?sykoRdgRADSyiTvzWRBFrO4BdLNyVM0wUoPi/ZOFyNzIsUF9nHdnjbie+3WT?=
 =?us-ascii?Q?LpKxIIy40CHxLatULkBf4MMVIHfNb4Ot6qJ3v31/twhSgYytwGZ5+uy5l55N?=
 =?us-ascii?Q?tEAggAXnHLT323/XjN5UENzTKM6Q2BpMKR91YVQdgL+OQyjVQ+NbVWR/a9b3?=
 =?us-ascii?Q?BT/0hHWsrixuEytshfffKG5TQyczJL0I+5pfBcwXD/OmeZ2ydMpnIQ5B2mZ1?=
 =?us-ascii?Q?aN1tbVidmWT9cVYwYT2Mce0jcJxbErN6zE6imqxtE2mAQrEObCyrEzOB+7TG?=
 =?us-ascii?Q?X5XDrq1uCAks1e0aIlMxj//ViVny6Xdtk8g0Tu+cAhdzZe4PD0mOUO2tJdxO?=
 =?us-ascii?Q?BmOFNZ0aQZAACBR9yhnThhiAtG0ObXUEDC2ads9A5Sh10V+86HUeWqdaM/Dq?=
 =?us-ascii?Q?F2RrTeILMykSCDWQ303gKDg2W+Y8AMMjqYHJddTNe4rE4Z2opXU0vsdtesr+?=
 =?us-ascii?Q?4F0VWUsORClEtmf1vXWiF+nOESDfvKlW2iJxA16xXUZzhF+Ju6GGLE58+5EF?=
 =?us-ascii?Q?+VNqGPbxgSGldr65SXWoi5PaPYUQLhFft7gP70M2utfn0vtWknGvhiGL5r7A?=
 =?us-ascii?Q?UhMWNm4JMAW6IJpB/5zVqIQpuNpUkJdqWinyyBT2vV805lTA3xTbB++oo8Qh?=
 =?us-ascii?Q?M9JJm3n6eQxOY+4ShqeG0+gR/LWg0OlItGnPt6tB8X5zoSu1mAcZctdGTFwx?=
 =?us-ascii?Q?6wL1sgeSSaBIbRZkMURlB4IDu1LnWv4p01P6tKeIC7HFBGUS6AH6EmeVehLl?=
 =?us-ascii?Q?/q+yPuzJLYq0DwJ6lvXD7V02gwzK9i4CCT9bQL4X0gh4wfhuTUGSJhalsFdY?=
 =?us-ascii?Q?8NPsp2nRNxCwXlZumSmki2KSrWxjjXfO3UskB+pxkoNHfKY0qAoRV/DrQAqH?=
 =?us-ascii?Q?qqbl58VKcw5IMybXOfHaTg13ZAzpnhwSvtsMGkTl5d3AgUNshzgwlKMF3LDK?=
 =?us-ascii?Q?fVtPTzIFDfHUEQlRAl3IiQpwuOR6NYneLdGZOf+aNeqIfgRzSrDp4K/rQFw1?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b22f99df-8ac8-4765-a573-08de0c95bc1e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:23:58.0635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjTGtkfN8npIC48EgO0mf6Xj5GylGpyQJ2v8XZfPLfyNqKeUXNlfaNHDqtLWZ4gfZDe8xKpNey4pfSL+iWW00WQk/NE0PddkZ2zE8gjZQQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6365
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

In scripts as well as interactively, it's much nicer to be able to
refer to GPIOs via their names defined in the device tree property
"gpio-line-names", instead of the rather opaque names derived from the
bank name with a _xx suffix. E.g.

  gpio read factory_reset FACTORY_RESET
  if test $factory_reset = 1 ; then ...

versus

  gpio read factory_reset gpio@481ac000_16
  if test $factory_reset = 1 ; then ...

This is also consistent with the move on the linux/userspace side towards
using line names instead of legacy chip+offset or the even more legacy
global gpio numbering in sysfs.

As this seems to only add about ~50 bytes of code to U-Boot proper,
and dm_gpio_lookup_name() most often ends up being GC'ed for SPL, so
adds no overhead there, adding yet another config knob (or two, if it
also needed an SPL variant) for this does not seem warranted.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

v2: guard the the dev_read_stringlist_search() call by
CONFIG_IS_ENABLED(OF_CONTROL) to avoid link failure on !OF_CONTROL
platforms.

 drivers/gpio/gpio-uclass.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 3d9f8b32b8d..f0d46417159 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -164,7 +164,7 @@ int dm_gpio_lookup_name(const char *name, struct gpio_desc *desc)
 	for (uclass_first_device(UCLASS_GPIO, &dev);
 	     dev;
 	     uclass_next_device(&dev)) {
-		int len;
+		int len, ret;
 
 		uc_priv = dev_get_uclass_priv(dev);
 		if (numeric != -1) {
@@ -188,6 +188,15 @@ int dm_gpio_lookup_name(const char *name, struct gpio_desc *desc)
 		 */
 		if (!dm_gpio_lookup_label(name, uc_priv, &offset))
 			break;
+
+		/* Also search the "gpio-line-names" property in DT for a match. */
+		if (CONFIG_IS_ENABLED(OF_CONTROL)) {
+			ret = dev_read_stringlist_search(dev, "gpio-line-names", name);
+			if (ret >= 0) {
+				offset = ret;
+				break;
+			}
+		}
 	}
 
 	if (!dev)
-- 
2.51.0


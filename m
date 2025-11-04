Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64299CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23A6836D1;
	Tue,  4 Nov 2025 18:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="TKOB1SRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B675383655; Tue,  4 Nov 2025 18:45:09 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E40B2832AD
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk7Uppe9Pdu05RtdVvphTcsTgXil4ECG+5UP3Cqp9O9aptoSnS6A7KZTvqIYW8M4bevZb+qU+qN5EDSNXJT29XmfOd/ZuISmht89qxvx3w5GbC6kmkLEh16Zf4KG0eK65/VXm1kEC+4kKJY3P0EoebHWGMtBYaSALsn9ryjnXpVXL8HjLmvqbTYn+RWUKwXPihF8kv4/LEHLsk6ifo2EDBIojN0M0y76VIDrsSHGyWToKel/muJfFR2p92xFmX1wqaQeczk0L3INHqAq4EKFO6jf3gXdO3hUASQMhi2bUinyeXn1HYG1fDXiQDG1Q1EuHyb9zbonGHQfSkDSqo66sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTgk74OZiItM4COAgSNGiRo+1yIDI19bDn/9JUOLP+I=;
 b=M1ZUy1c2oGKGbXU4oxiwaNVRor8192nqAE9WJlmPhs50445cdtTOYyIhaHNGcRHu8DAwXUEtk4S+98KSmlYji2lP9xLdTwiiFdlAWFfkGDjQljvFPr4AXUQdhnbAM7IaUKdX2KorNhsDPbq0hmXMF9uPEupd7FT7A9gsifKI7Vxo94uZEPdfJ7WMUitBDubr7jd2G3xLCZWCy0T0aaGYvhTmZH6UDOUqz2yDflCUrFHXL7pFDfVGakqekSbgIlssPALkjBAFZk0qzjAaM+5p37lgY60eW0hsKCFgBJ9JhHKl23Tz3t4qk3+2vRLhUUiwzPDyZT5o5r0HZWmyC3AlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTgk74OZiItM4COAgSNGiRo+1yIDI19bDn/9JUOLP+I=;
 b=TKOB1SRZMQ1V9sJLQXjNARjR2tKsQ0pxbneLYmFw/HqEqrdweN33gXOKiFSWJYTOIPevBuq+pMPyTzhikguVmw78Kfsi2y0khMVFfaiIJwevauq9bG/D8BCF9w36HXs1KTlIA89moJixjCQLI8vizncwH8DpLwZkGly1moR0Gg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:45:04 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:45:04 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 2/3] gpio: search gpio-line-names property in
 dm_gpio_lookup_name
Date: Tue,  4 Nov 2025 18:44:57 +0100
Message-ID: <20251104174458.3385564-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174458.3385564-1-ravi@prevas.dk>
References: <20251104174458.3385564-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::34) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bca591-49f9-4b4b-cfdd-08de1bc9e30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r6XHd3196ac4OvtIfX1V/WTfo9a8gErzpRn2OlISK/43zeIEkjQRmcZJXgdg?=
 =?us-ascii?Q?//wzSYTBIOquYJT0WgXAiadlplDPu/AOwDc9F4zKeWKw7HiTDtdbs0fmDWrn?=
 =?us-ascii?Q?IhgPA16pn+11PQ+tv/MZl6wBtqKGaMXvg+4+rAR3bEKqAOj5DFmO8eZA8sQE?=
 =?us-ascii?Q?NEgiXn280541pmHdZNuF7qNS5RnHcOWPvHc06/mMKhpAdbWbDogg+v7lpbBn?=
 =?us-ascii?Q?RVKAguMlwyuBMy6xSLYXrZVvLfKTrkSWTo+kk+ZQoo5rN3t2p+OaGt0AY6g+?=
 =?us-ascii?Q?DUnABWKcpAqgudeyEY3biBOK5X647Oiu5516KgcCkGg7MTT2CtdaM5Fpc0jv?=
 =?us-ascii?Q?rmsw5SzwibnOje7rqFMZxCXGN1c/CBdJUWWXie41Ju58E4MBYqf7SZTBnZEz?=
 =?us-ascii?Q?Tv8RfXbda/ME7fZM9PlWLMW5hhxHW/kixk6b3JCx/9zp1NV/tRYKtFYdHsW1?=
 =?us-ascii?Q?zsHf3UwVtkC2v3E0v5ZtSqABcpbST9QGvlQwu3efi8ghYZdNlWCvt/Eqofcf?=
 =?us-ascii?Q?itQ27eOO3lEiQXijgdh/s4xeV9JtD3cZLIXvVu9VOZtLCqJyUpFYG5ksS+Ev?=
 =?us-ascii?Q?y6StB4Os1YfJW4KvZ4xyJPRI03MMNTeoNobP/eoFzIKYWqLXHUOB4V/GBDh/?=
 =?us-ascii?Q?Q2xd/vtLFcxlzSOlUy6ImPxzQWbHojUnQgm1Xzn/iLsmPhvai2lwlhMOFD0R?=
 =?us-ascii?Q?ZypIvfuhNRJ7qARZvu92/nDzB7UGZPhHc3pxQ9jd0vHxo7VwG/HvGPaOtQ3Y?=
 =?us-ascii?Q?I+hDG4ARKB0GElmcUSqkZAi3A5uTA2V5q+pIjlMQU8hMz3InbOvGY6fDiooI?=
 =?us-ascii?Q?LGvZ0ElLWv3h/Yr7AI88Mc/zL6aHUfV4LV4K525ZoC0vxUcA2hG90ZPXTQFu?=
 =?us-ascii?Q?2VViPWzVOIMFtryVpEeBhB9bJdL5WbKKcnlJ4eICTnqt6A2taBzoKU4+u44E?=
 =?us-ascii?Q?k2/jNRgPdYAi0n6vZUhTJYB37oBEZUxOEEqvswQAqyZe3q/RypRjUb3iCuwz?=
 =?us-ascii?Q?GkhcbfsNe8Qj7GH/qlIDFnqaGx3qywDRj+2dPpgSa3QlGXNhxqE8IwAMAmKc?=
 =?us-ascii?Q?b95VP58e/gBkmtMk8pNzYngvMzV4csml9oTum2fgre7MIg2JH6DKoKFp34u7?=
 =?us-ascii?Q?dUfqGQkJde2tJpXXj9cl7xGypPcyzAqnHjHUwicM8lER/l6bgcx/UDV1GUeo?=
 =?us-ascii?Q?F+7QOrTeSUv8wYGZbSNAoo9tS7DR4H9UbOiBZ5kp+t14KgeyNrWT+bxjnVXe?=
 =?us-ascii?Q?/dfxkGyaLmsKu71Zc1qazuH1zXkfFcKXaCz1+5qwEG1pSgystBrZ1rc5mSax?=
 =?us-ascii?Q?B8Enz1dXaNBBFPq3K2LTbShGPc9MuqQHsXLEBG89d/c5GYd3FqQgvjCl6om3?=
 =?us-ascii?Q?l7gTBhPsAe/jexWt4tkcgZzOdLbrwt+12RovCg5hCp+mLp4NuzihJZxFRUCZ?=
 =?us-ascii?Q?0v171NZcEqtLenyUzPl0+hacWyxDWK22MGKK4QjQ2Y3hyGa/Sdr01aa5Rgvh?=
 =?us-ascii?Q?Go4fnZH/E/A3PQXRgiiPp9qPNpbO4QqigUC5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nn7utSOfowomfkDZJzs0d29DZ3ho7SsfP66jc4vsIgT8O88N/vCwSFvnFxiN?=
 =?us-ascii?Q?E3tbM5PGztoA9XjHzedkN1mVZRaC6sOTVqqp6/ap/6QEnQQV+DLBP3B4s1dz?=
 =?us-ascii?Q?3RKeoz4SPyQDBC7eIH91XRZqMzzMKw3xkexkbyNMKEy/4747dXd7GL/jff76?=
 =?us-ascii?Q?NcaG45zE7X61sqZSRgIAPezhGLAn7nl4NcdQ/wzvzmd2nXDmL6rg8FNFkXc5?=
 =?us-ascii?Q?OAApcY9IYjMgYUIfRJpGgtcwomeA+J6Mx+wUfaOHB95iyZORhlnWgGFUOTZl?=
 =?us-ascii?Q?+N9VL8C6+25lxZN1HUHIcdnKlaiVWq0rXCZWfvjP9NIR/5rPYDKs5NWyGFFn?=
 =?us-ascii?Q?c42dzaK+HTDucfK9msBJhAEQNp8JKUJRelgkda0Gk1thbhAEE3itLTx+ZS+I?=
 =?us-ascii?Q?7oYRUlAEtC+v5PH+rSVhZgmnXTktjw3OuAdQc8mGfFt0kleNIoEc7baq+VhN?=
 =?us-ascii?Q?exY2a5kIJpRXUGEI8L3tA62uKztoC4MilBpk6/z+H51RH9qx2DjhwbIFj6Rk?=
 =?us-ascii?Q?GpFhUlVNmIajv3bzyuunvSVdHwEnFLcg4Ho05PVyOmdFtLk/klp5rgxPVWLW?=
 =?us-ascii?Q?0l4OhcyCKwDq/dMzheWmZJBbqNuBGruX8XLa3On6gEC4z3YijgQmGC0hJQkx?=
 =?us-ascii?Q?SLiefqb/PcuoV+B/QWTab3PesMztf3wk2N77jrmzwgEG/DJjzwDJQcnroL2D?=
 =?us-ascii?Q?s3geXukM/SkNQY+/+UzdvfytJOxZetMd9h9vveZMPASBS28KCRDjj5gTcKaR?=
 =?us-ascii?Q?eUS3jeRctmCm0WiidMD1/NrsQ7AjZiQXbqaDq7vp3vscc1mqc41rktP7W2tX?=
 =?us-ascii?Q?6Wfo5FFmFkGnL9dRQ9XjXjdWHA238KHg9MwaZwTueF4qEFgyyxThUnlhethh?=
 =?us-ascii?Q?5MvauVZwEbtBIP7/kK5z+p2Otlhxb43dTtbXplqYJLELRNv/PFYI4CifOSLJ?=
 =?us-ascii?Q?HPDr87h+UU1RY93ThrxIUL00GxXeqtbeWYg2VwspEcK9HvurH5ym9FXzNDNE?=
 =?us-ascii?Q?Pavt9n0Z0nRi9m795GERntANrqlFKCdZ2sv1kvlRm1lhScYzeHTKFKfqPGxD?=
 =?us-ascii?Q?7dIggv43n370V9FRtah1HzBDqqcv6s344CF9s0WRuzmN8xL6hcYmHB0xf/GI?=
 =?us-ascii?Q?iNpTB6ZwC4+uZReEIcYw3dJfiIpyGyiUhkphx7f/A/ahI78cgmVziSmit7Q7?=
 =?us-ascii?Q?7xDbLAaj3mmUzsi/1qnkH8Wwl4WvgIy9/m/Vq7DOQKv5nxFvKd6VNwdujhmf?=
 =?us-ascii?Q?psRYM9veJQsxZqKbHcmQvh3tflAZCD+4qcIYRS6ySfUIiFj5IQ8cWAL/YFn8?=
 =?us-ascii?Q?u152fZ9TLoYpxqcD5CMQX6VECGBJan/3ZPRyjD0Qey2Z4L2csCoEWSLD8V5m?=
 =?us-ascii?Q?YXUiet6nTIi8k/T1hw3NKrlK+mwAlc2CKW8D7Hl9rCc7er1toPBM2e+UEahl?=
 =?us-ascii?Q?u7NsVkGwhsU34a23V17pJ1L29nSgO9fh0OUv2X23OibjREOROY7gdJyIhz/2?=
 =?us-ascii?Q?tzXR8yJ+ma2ya7oPCCl6uy2O3C+wWvUQIcPYl8PevFUjQMuPNvSJNyClwht0?=
 =?us-ascii?Q?PZXxBAn72NDYWfdsE5FUC1lYaSOEmZ6HvWSbk3+tO3FaP4zzhwVK5pOCxXUw?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bca591-49f9-4b4b-cfdd-08de1bc9e30c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:45:04.6684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTFRWi6e2kQLDlo2XTtO06cgj/A8HB2NLANUT+8JGsNl+LWhEz1VVD4erweaAjRq4SIfFnNbVatai+gSuKspI5t1h9p9WDkyJWy1Rt+5PbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6286
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

As dev_read_stringlist_search() depends on both OF_CONTROL and
OF_LIBFDT (which matters for the SPL case), we need some .config
conditional. However, it only adds about ~50 bytes of code to U-Boot
proper, and dm_gpio_lookup_name() most often ends up being GC'ed for
SPL, thus adds no overhead there, so for now make it a hidden symbol
which is merely a convenient shorthand for
CONFIG_IS_ENABLED(OF_CONTROL) && CONFIG_IS_ENABLED(OF_LIBFDT).

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/gpio/Kconfig       | 16 ++++++++++++++++
 drivers/gpio/gpio-uclass.c | 11 ++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index db077e472a8..a47c127d98c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -97,6 +97,22 @@ config SPL_DM_GPIO_LOOKUP_LABEL
 	  different gpios on different hardware versions
 	  for the same functionality in board code.
 
+config DM_GPIO_LOOKUP_LINE_NAME
+	def_bool y
+	depends on OF_CONTROL && OF_LIBFDT
+	help
+	  This option enables specifying a GPIO by referring to its
+	  name as defined by the "gpio-line-names" property in the
+	  gpio controller's devicetree node.
+
+config SPL_DM_GPIO_LOOKUP_LINE_NAME
+	def_bool y
+	depends on SPL_OF_CONTROL && SPL_OF_LIBFDT
+	help
+	  This option enables specifying a GPIO by referring to its
+	  name as defined by the "gpio-line-names" property in the
+	  gpio controller's devicetree node.
+
 config ADI_GPIO
 	bool "ADI GPIO driver"
 	depends on DM_GPIO && ARCH_SC5XX
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 3d9f8b32b8d..6f52fdf4ef4 100644
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
+		if (CONFIG_IS_ENABLED(DM_GPIO_LOOKUP_LINE_NAME)) {
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


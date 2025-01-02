Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060B5E7718B
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6F98039B;
	Thu,  2 Jan 2025 17:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="DsLAFRYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DF380352; Thu,  2 Jan 2025 10:35:22 +0100 (CET)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com
 (mail-sy4aus01olkn20828.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2819::828])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0CD80040
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 10:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujh2818@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGKFHf7P3tRTsomDUlkf0upZebfB8geFFeOwRruCDg1l3yOYgKG5WvH0p6vR/AK1hpR+Ez6Z636ZVQm6uziUVVFWKAOJFKuIU9DskSA5xzPh1v9oSKfsMyBsyoCPXg/jiyENXnt3a7JptXZIgNhoetU1Ef9dW/5VZUmQKr8nV6BV0ZLVb4oxVEMBr8HlSte13DyMwx8FzbPeby8LVdhPycMsQhw2n6aFPOEQ9meumMkXaPthiyEmqgsaEJv1pl8U++x3KqY7gPIWKgF6sDekbzN5mnMxMKFzg2Ef+Z5eLgQ5tQLzclnLbFxcKnNGSb3nUoW5jI6jc/5mQGvvjxAX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNZh7bOl2JwOL5z4zBgJLadAbW4oEmgV70BjoE9z8og=;
 b=eDbUrZsNCHbuEOisCgdsRFoCstOncOQ6SGmv5nj4Ewl7LSSzjOT2vfklF4pFVI3l84LsPJUzLqhtCiMz/PBNq3TagXMAnA3cFRxTfnesg8zzshqyhaCV2dtzYiLvlJw4Nl316xNj7nH+kn+qm/7/kwztQ+CtBajKNzS4XaBF32d6IG3HDK8XKakXeRf+mx80KD597MVazfMsbLXZrpnKRKZ6/gXbJJMGnIE/onlCN6I2ylE+fbLASRpnWldZJ/uPdmVYMsqSuvQQ/+hmhtVw1Yuw9F9JaRzn/rZ7dF7xKEOo40y8bY99G5vpDik75FSfeQMnP60S67mYzKF/OWH44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNZh7bOl2JwOL5z4zBgJLadAbW4oEmgV70BjoE9z8og=;
 b=DsLAFRYe/Ow/lGRBIugn844J1vMzQc6Wo3Fnt31n5yYCk2ygeVrIs5cpbO4CPk77zydRmY2l6wsCRgd6mssxO/+2Y8hHgWoRFdMRYQVCSpXGLu/7/XpVS3laZ5iRfZYARl6lDJSMZ9WAhYzhqtqhXIhB6p8PGPG6MalL7EuG6of8TdZdz2ZMUCdjQs9cyUWHwxUGrEfgm1g+gqE6ls8IWmhGXmZPFSxfNLpjfM/28msfGJPIfuk6Zo0m7QxlbZ7ChR12luBeAOhNAzQ4X1QAEDztc7q5nVU7eO1hdjimAqVs7vQ9XqbDpFkcWHd17V4GqmkcT2Xwn9u6SgP8NK7p8g==
Received: from SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:296::5) by
 SY3PPFD297AF705.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::4af) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.13; Thu, 2 Jan 2025 09:35:14 +0000
Received: from SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fc57:50c4:6ee6:c8c1]) by SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fc57:50c4:6ee6:c8c1%7]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 09:35:14 +0000
From: Liu Jude <liujh2818@outlook.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Kongyang Liu
 <seashell11234455@gmail.com>, Liu Jude <liujh2818@outlook.com>
Subject: Re: [PATCH v2 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
Thread-Topic: [PATCH v2 7/8] usb: dwc2: Unify flush and reset logic with
 v4.20a support
Thread-Index: AQHbWms+awUrzWRjmUu5L7HQJEeTELMAqRWAgAKVRYA=
Date: Thu, 2 Jan 2025 09:35:13 +0000
Message-ID: <352BE595-69DE-459D-A35A-9B3425D9E4AA@outlook.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-7-12cd9b8a2358@outlook.com>
 <8baaae27-8e42-4f5d-97e5-088740d0f40f@denx.de>
In-Reply-To: <8baaae27-8e42-4f5d-97e5-088740d0f40f@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0922:EE_|SY3PPFD297AF705:EE_
x-ms-office365-filtering-correlation-id: 4ae6f26f-26e2-4c2c-5db5-08dd2b10c25b
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|12050799009|8060799006|9400799030|19110799003|8062599003|1602099012|10035399004|102099032|440099028|4302099013|3412199025|1710799026;
x-microsoft-antispam-message-info: =?us-ascii?Q?MxT62WFjgD+Xpk3sFZctqOiOsBp9HT3OcpK/Q+pFAvobDq2FUf/oKNI/xLF0?=
 =?us-ascii?Q?8TA7paens3iBo9V4oApeI0xQ5RWmNT1kyEgyl2Zyi8Z89gzL9po4Xka6+pgR?=
 =?us-ascii?Q?sh4vJV9WPg9nEC9AK8WIOZH3WVSep5fO+ESMpHvfn1aUXDrVJMyg6wBE97Yq?=
 =?us-ascii?Q?PqB1e5EzdX2nxKO9ECjPxyvRZeNaNdCUJBH5zqT1EujXHgLwedxPcWtOe6ST?=
 =?us-ascii?Q?nhf1lU9MSggiVcl//4FtEm0fTf9XDVYes1gbQh5i8GvVOBT1UTqNorloY8WP?=
 =?us-ascii?Q?HDg+vO8bWd1nHrqw1S7vsEQCKdQkDSXhMGl4YsgOsmkcVG5tWhYzwrbGeTPb?=
 =?us-ascii?Q?DJ/Fxs+6UEEa+RiMEhWOFJPKNfyP2yM0HXlYIyrbe71szveiL/GwCng29DK5?=
 =?us-ascii?Q?R5llin4kB1OACHQv1TYJZxsiaiBe64BZE4WhoH6yXappz6lC4S8yByd98Ppe?=
 =?us-ascii?Q?Aba5ozbgI2Mi5dbOistcabOdVxH7HkA14jhWb3y6IM0nUZiMn1jfLW0hlvb2?=
 =?us-ascii?Q?gogRkUlTi//S4SE95PnxAvUFAAz5e//BHIbQkniadgMBYUyn7EWJ30NanIrT?=
 =?us-ascii?Q?pJGnGnF6e8ulJw5xZXDRy4bb1gODq88/7GNp4GkdT72U6Y4p1WfjWeP+BZ5f?=
 =?us-ascii?Q?pFclKYuHMZlSSTCEhCx3jXIsJRKOxGrUzOLjxC7o7gLlAdW9fK8JO8XrzXLw?=
 =?us-ascii?Q?J4xfMBACTwoNi3TsnGj/M0RdJ5jN1ow5Nv48Tn0XnFSb9Da64jwY0x/3j5HU?=
 =?us-ascii?Q?JwBl3R/63ek0tHrgQcOaOyayXdjqqGxEdUtY+EevyExmerMzIBNaYrtBHz+R?=
 =?us-ascii?Q?FwSMyPGUfc+C/wMTfVlsLbYgCyXhTgyrurGIBaytZ7U5u1xIo9Wo/9zlNxaS?=
 =?us-ascii?Q?4Ikum29vHt8PVrw1p+cq/PxY8S0zduCrr2bXZamy9v5CLXBRKyYVZ7qigJ+t?=
 =?us-ascii?Q?7096Fn9TZ2hbFti+1Ibvxw3yDqWjQpv9m5DN/GjQt6jLgHORZaxPjsVLPdub?=
 =?us-ascii?Q?QRkAuCJqrtJSGcNZrpuY1FeYFKxFJeMb1NgIZ6D7bQKLqdTEpbIJ9vqCk/Ku?=
 =?us-ascii?Q?9N9QA4FxVBr6IdFt42CYiUreiT4qvVwHFCrkm2SjGvSIdWBsqBkAZSAXb9YG?=
 =?us-ascii?Q?42yHo7StUuK5Iz/X5pJaW1Irw9Tt+zg9qvz/4qGTwp8LI5Zx2aQ+gvYV4Ads?=
 =?us-ascii?Q?eavH2u+bplThOjSZZwqz9xOEULV50uI7qOr59wtXu+8hheaDF2MSXPyAhLFx?=
 =?us-ascii?Q?x1GD4p1xD6xAuKs/a9Agy8uT1HaIZyTYXupreGkjzmXT53rEgsoNpuqzA5/w?=
 =?us-ascii?Q?nVlg+bf+xqtbjeJaaeXsWx8d8+uuBkdDA8n0wDB0SpO6TQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t33s1vLJfeBifVutsrKgkXNCBWbxRPys3HiY3sALzNCCkFijaREkk47MqxN2?=
 =?us-ascii?Q?hZJuALyfmCKRn9RoBmEP1dnWCzGib+rroEyPa+FK0YVMFQXJg0Xd8kSAgObw?=
 =?us-ascii?Q?TntIL68kaUr5YIHOyGZQrC4e+xkM4B271AuA4Xex48DQtOT29fxAELQSXmbA?=
 =?us-ascii?Q?xcoIrgC+UzlyQwZRunz5pnn50BmCKFzPqxFKqcdlqrQJZc/pqc065q29ueVP?=
 =?us-ascii?Q?7dtX/73jpY7MGN1XkWsMXf0/OVhLNOsyhFDFGAflTkTuy2hIU8WmdKjVIWV9?=
 =?us-ascii?Q?bBXc2Rh3+dL5xT1Yer3VnnDGcarsc2+JCUC4O3lmGtiufgRBp7q9OA/6DbwF?=
 =?us-ascii?Q?cB88GzSYFavbuqKE6ZkHCQ6doNuvjSTlHQZ/3nfEZ3wyIJeo7Li541J3KVX4?=
 =?us-ascii?Q?mXlHlQ0YG/ka0BwSOt3fRHG+3G97GjYgIh2jn1BqguaSuZnTbwalZgAWOUJp?=
 =?us-ascii?Q?+k63xt/+ywUYL1oFDR8/joE+C5j8Pn5GXANV//QuM8Ctdx5rsZCtw0gCCUCk?=
 =?us-ascii?Q?JR8pOeEJPoYS8LZD464OyGh+IKezQXOpRXL67X2y4KkHIfpXe9pnbAYCTuPL?=
 =?us-ascii?Q?S5NVZVv9UOs9Uu5JPE8MVK5d70RG22JpLo6/mEpNVgK+ZeGVaSFWinnMjQBJ?=
 =?us-ascii?Q?oM5Lin2zwMBsPmGKhCKltJVAx0dsuindRcZqL9WUByeI2TINqAr0atiH/WNr?=
 =?us-ascii?Q?ngNlFpIMzTle4jf5FMvZ5xaiLcneO/YK45ObG6JmtvfxmTUXTNVM/98gPMFY?=
 =?us-ascii?Q?BXFZ/oXCD9933EuXeRtiZ3I0jQ1QlOEjouZhoGWB3mZyJbTlU1KBidMB6Jrd?=
 =?us-ascii?Q?S14DgWveytnt1sOHvRb0TWiVKSA6/IEBseleKm6F2LZ/bpC7vlMViQJWgOGj?=
 =?us-ascii?Q?qIwMD/OS57j6QN3HJoZTLlLPyhNa7JgvoSswNA2X6E7BeEKCOws3EvpnI+zU?=
 =?us-ascii?Q?jF+bFvINiXr2tU6hbVWsJ9ja342a/ZOg63DhNFhUAPKTQnMSZLqR0E+t0HZC?=
 =?us-ascii?Q?v3N28eIlYNDNs7nUIOuGpcN4mRxneQ+0Qkzt9yb+31/kmo8SAMYb3eR1FKBr?=
 =?us-ascii?Q?jQOwGMVCwmPuiGZ93eIQITQ2F+0Ce66iTlXAvTKK2E7pYOHICBXww8qm/BDo?=
 =?us-ascii?Q?pa3vRTL8kIfkqPIaiP85mdpH8NtRrGCa458W5UKsyWY7vGJ7ADzHLFQkOksL?=
 =?us-ascii?Q?NpgLlKmd3bjD9mwrxLWPt+4bvwjs3Nvng1cK8OCSWcncDJ14gX4nHUdlyLXM?=
 =?us-ascii?Q?YaiiyW7XvpGZPYKAJ6IMUqcVwqshdboFCiCI2kNDP7vGA1chcalBGpp6MFr6?=
 =?us-ascii?Q?Dcw9YfpS6M9Eci7+mM3niNYu?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae6f26f-26e2-4c2c-5db5-08dd2b10c25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 09:35:13.6253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPFD297AF705
X-Mailman-Approved-At: Thu, 02 Jan 2025 17:27:20 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2025/1/1 02:08, Marek Vasut wrote:
On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
From: Kongyang Liu <seashell11234455@gmail.com><mailto:seashell11234455@gma=
il.com>

This patch merges flush and reset logic for both host and gadget code
into a common set of functions, reducing duplication. It also adds support
for the updated reset logic to compatible with core version since v4.20a.

This patch mainly refers to the patch in the kernel.
link: https://aus01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fc=
ommit%2F%3Fid%3D65dc2e725286106f99c6f6b78e3d9c52c15f3a9c&data=3D05%7C02%7C%=
7Cedbf27da9a1549ebe3d208dd29c6cb5a%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7=
C0%7C638712655996909017%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlY=
iOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C=
%7C&sdata=3DKBItz8KgYeDYVxFxg1ylYACf%2F%2FeGOxNmSVV3Ec9CEiM%3D&reserved=3D0=
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D65dc2e725286106f99c6f6b78e3d9c52c15f3a9c>

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com><mailto:seashell112=
34455@gmail.com>
Signed-off-by: Junhui Liu <liujh2818@outlook.com><mailto:liujh2818@outlook.=
com>
---
  drivers/usb/common/Makefile                |   2 +
  drivers/usb/common/dwc2_core.c             | 103 ++++++++++++++++++++++++=
+++++
  drivers/usb/common/dwc2_core.h             |   4 ++
  drivers/usb/gadget/dwc2_udc_otg.c          |  12 +---
  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c |   6 +-
  drivers/usb/host/dwc2.c                    |  80 ++--------------------
  6 files changed, 117 insertions(+), 90 deletions(-)

diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 11cc4657a0f403b84b1b8336781e1893d9c7a8f1..73e5bc6d7fdca692276e119911b=
47db4bf03586a 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -4,6 +4,8 @@
  #
    obj-$(CONFIG_$(XPL_)DM_USB) +=3D common.o
+obj-$(CONFIG_USB_DWC2) +=3D dwc2_core.o
+obj-$(CONFIG_USB_GADGET_DWC2_OTG) +=3D dwc2_core.o
  obj-$(CONFIG_USB_ISP1760) +=3D usb_urb.o
  obj-$(CONFIG_USB_MUSB_HOST) +=3D usb_urb.o
  obj-$(CONFIG_USB_MUSB_GADGET) +=3D usb_urb.o
diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.=
c
new file mode 100644
index 0000000000000000000000000000000000000000..323326e05d7b0318d883d4a3b81=
86b812c42f9ca
--- /dev/null
+++ b/drivers/usb/common/dwc2_core.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com><mailto:se=
ashell11234455@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <wait_bit.h>
+
+#include "dwc2_core.h"
+
+int dwc2_core_reset(struct dwc2_core_regs *regs)
+{
+    u32 snpsid;
+    int ret;
+    bool host_mode =3D false;
+
+    if (!(readl(&regs->global_regs.gotgctl) & GOTGCTL_CONID_B) ||
+        (readl(&regs->global_regs.gusbcfg) & GUSBCFG_FORCEDEVMODE))
+        host_mode =3D true;
+
+    /* Core Soft Reset */
+    snpsid =3D readl(&regs->global_regs.gsnpsid);
+    writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
+    if (FIELD_GET(GSNPSID_VER_MASK, snpsid) < 0x420a) {
+        ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFT=
RST,
+                    false, 1000, false);
+        if (ret) {
+            log_warning("%s: Waiting for GRSTCTL_CSFTRST timeout\n", __fun=
c__);
+            return -EBUSY;

Return -ETIMEDOUT or even better, return ret; to propagate the return value=
 of wait_for_bit_le32() as-is , which is really -ETIMEDOUT if the wait time=
s out.


Okay, I'll modify it to return ret;


+        }
+    } else {
+        ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFT=
RST_DONE,
+                    true, 1000, false);
+        if (ret) {
+            log_warning("%s: Waiting for GRSTCTL_CSFTRST_DONE timeout\n", =
__func__);
+            return -EBUSY;

DTTO, return ret;

+        }
+        clrsetbits_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST, GRSTC=
TL_CSFTRST_DONE);
+    }
+
+    /* Wait for AHB master IDLE state. */
+    ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
+                true, 1000, false);
+    if (ret) {
+        log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__)=
;
+        return -EBUSY;

DTTO, return ret;

+    }
+
+    if (host_mode) {
+        ret =3D wait_for_bit_le32(&regs->global_regs.gintsts, GINTSTS_CURM=
ODE_HOST,
+                    host_mode, 1000, false);
+        if (ret) {
+            log_warning("%s: Waiting for GINTSTS_CURMODE_HOST timeout\n", =
__func__);
+            return -EBUSY;

DTTO, return ret;

+        }
+    }
+
+    return 0;
+}
+
+void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
+{
+    int ret;
+
+    log_debug("Flush Tx FIFO %d\n", num);
+
+    /* Wait for AHB master IDLE state */
+    ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,=
 true, 1000, false);
+    if (ret)
+        log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__)=
;


Should this function return an integer and an error code on failure ?

Sure, I think I will add return ret; here in the next version,


+    writel(GRSTCTL_TXFFLSH | FIELD_PREP(GRSTCTL_TXFNUM_MASK, num), &regs->=
global_regs.grstctl);
+
+    ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_TXFFLSH,=
 false, 1000, false);
+    if (ret)
+        log_warning("%s: Waiting for GRSTCTL_TXFFLSH timeout\n", __func__)=
;
+
+    /* Wait for 3 PHY Clocks */
+    udelay(1);
+}
+
+void dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
+{
+    int ret;
+
+    log_debug("Flush Rx FIFO\n");
+
+    /* Wait for AHB master IDLE state */
+    ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,=
 true, 1000, false);
+    if (ret)
+        log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__)=
;
+
+    writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
+
+    ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH,=
 false, 1000, false);
+    if (ret)
+        log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__)=
;
+
+    /* Wait for 3 PHY Clocks */
+    udelay(1);

Shouldn't this delay be derived from the PHY clock frequency somehow ?
Are we sure 1us is always sufficient ?


According to the datasheet, the PHY clock can be set to 30/48/60MHz, so
1us is sufficient even for 30MHz. And it is 10 times 3 PHY clocks with
slowest clock, so I think 1us is acceptable.

Best regards,
Junhui Liu


+}
[...]

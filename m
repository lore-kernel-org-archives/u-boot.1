Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAAFE776EA
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0616842E7;
	Wed, 24 Dec 2025 17:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="TlNpd4MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ED184295; Wed, 24 Dec 2025 16:47:06 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161CB84261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjH2BEuLu4phdJHRrVrc9jKW72Q+zLnkjmT/R6whlBB81C2IcM8gDlWlfMjjeQZe709gYEtzI0uqCwD6rnvkaFU6xvFBUat91kLz8K3cpTwSe7pLMtXtB/1Ye3ecpAQoDi83dZJvG+4+908QOaL0jhCy/MhBdqLSn/xLT2NzXYQBHAxvs4q9ig6LHTV4CZ7/m4y3VLqcZYzgCu5n6ip1XGZO6/Pw9GlDwBUfXrxt8o/knktL/FQa7CQwu29igYW3U9ge0sMok2Lx4x9mCDIZyePHZGuTNpTksAuKVCD7eBD+SDFvV4jHl6fGASktccf5RdWvk4bHsWbvtUBFW4oYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0vhhQHEldMMMJaNwC8YJhrar8Wv0PpYTD9e1XoguX0=;
 b=C1viRXb+KHZQAbToVwfuodXf3KK0AHg4jjNmP6+kRGy2kU2I7nvYv9ZJaMaU83tOTwHve79dWfoNRVpfUMIAH1DrdNLfqphDNUIKzXW8+YWrqKVqDXU82ACAUZj7Qh+D13+1x78u2EpatIncstO8zcqXWiSoeVdIcnGwQ+8oFsuC42Af+8X834ihPWQY8uemCIGzq+jf2SPTGB/pwiE2ZzkJ6ExmJmVR7gdMQjjSHehasuuLwdiCOJyhV4v5kmobpJjyikMsyXReJg+pwMOpbGVpM8vDEbb5DDFLYfMWB0qQCAL6h4nuO++fji4Sn243x17FSN2ot2xSU6impJv5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0vhhQHEldMMMJaNwC8YJhrar8Wv0PpYTD9e1XoguX0=;
 b=TlNpd4MUIMO9lxFY/VFRPbM3IgtCsxlthgDR6PHZ1oNexfwy7TdPPr4J6vO0v7rcd4TN8bJKeElwvGkckxK3C8iiej6nNlzGr0EUm9G90jfytS5qnGehCSpj59fT499pInRDaaGp2B1dbW0waahTKgOz8dKgP/ehfEjIrYy8wJwqlE7VBcBh42bV4YiVJMBVwZvuppzk0ag40rCgUSy3qYdXyZ2s/ct2RN4hAo+528fLilYcklOESe6VzVA+pnwOzwzgoboqXsZjIDvgokfl4j8CPV89WmC8QVj7B2wXNxn5add8ApUOvgHGy0QlSmhz92Ntouw95KDNgE52E8jorw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:47:02 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:47:02 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 6/8] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v5 6/8] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHcdOyMJ2UnBhw+S0Gtr2K71CcxmQ==
Date: Wed, 24 Dec 2025 15:47:02 +0000
Message-ID: <20251224154449.946780-7-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 98422a22-0793-4fda-e681-08de4303aea9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rL2ce5bK3QUe+m5AZVjlIhK5PO5d6nhmxK22klkB8tWfrnvi1dA5D3nezn?=
 =?iso-8859-1?Q?s5Hyhb72/nZjLZ/240WST7iwfn2b6wO/NM13WnA1k92RI3EFv71c+4UYQu?=
 =?iso-8859-1?Q?rvj3dAIkeJuJnSRw03pwurmOzJ41MNzsW7UJXTPukrvI7PYtStw+Qt5Q0N?=
 =?iso-8859-1?Q?t2oOY0lQDBrh+sL+JuIPt8h2wkQYvqx6TmfGYbuYB2I/TX1VCYFNgh1i82?=
 =?iso-8859-1?Q?xMQU0gH6OrVLFRT402Ig4ofgnMUP5sGCa0HvQtiOfkmPRw2p+0DdfUZ/vM?=
 =?iso-8859-1?Q?Xr/FjURtBaqlg9lh8MydUmHvEaKy1re1pCkd/gUNWwjcxHf6Z6u8gKipAO?=
 =?iso-8859-1?Q?YGDH60Sa/b7VdMpu0qvzQiEJKUMpxSqwWwei8RcyFCzF6sBjkUHfgGeQg+?=
 =?iso-8859-1?Q?Nq+mqrZ2/1IXC9CTyuRT0xwifUH+rGa+/tV6t04l+Tp4qVOvo7EBiHyoTC?=
 =?iso-8859-1?Q?fqt42A51vSeNmhy5od1a6V/vNiMh/ki5VwFWfalxfqvs9Y7W1//Va74r/Q?=
 =?iso-8859-1?Q?1vcv6llFn9oSjpFd2BpKSo555t/VmVV913RpCh3vik9LRcgnF8a0kfMv7q?=
 =?iso-8859-1?Q?5AMc4sS55Sakl2MxvMEXCiBeSGPUtM0JclE4J/tW25nR+0CkJRay1tMrLO?=
 =?iso-8859-1?Q?P4tHuaxWQDHmp1PTJpVCsHzC6Lg4jIwGjTJyyTBlhH+34q1SbrdJ63VHdo?=
 =?iso-8859-1?Q?tIooCCTHZtvfqJfNPzTwol+upS+/kX31G/gwPETVu9PLjHIgrfb3jAhP5e?=
 =?iso-8859-1?Q?1UEv2QCuRCe7K+2YJ3bscw1nBgKutj4LQubHQvY5UdnGqJphdxeEgc7mvO?=
 =?iso-8859-1?Q?cuKYXYg8aT1Hw32K0OxoVG/oRvohlEDjRBHVfnKifSBK5fU+JcWQ9yBAto?=
 =?iso-8859-1?Q?xpyrgl6YwYYckUqRLYZpEDhWGXrVGtQgU8xOQhhCcIqXsrANI3HqvQu3Fs?=
 =?iso-8859-1?Q?KVViN/uuUM151bWyP9cGNV+Ghe2nvGuIpcSB97acxpWpRx7ob8CPrLDUhk?=
 =?iso-8859-1?Q?xfjhc9RhBnjnC1LyQWjTEWFw82gHA8p8JoZjVL4UfIHZYh+GP9ChkqTnaP?=
 =?iso-8859-1?Q?mC57g+sqVoUZEPWC73QH1cbBKjeFe9Yt7cL7uev5IL5IAnEjj+SS+gYLp8?=
 =?iso-8859-1?Q?SMmCQnjFNo4cbto9rKzurlVZU/80ckezA8JvOd62Mn6AnOo1qf5YAtRwow?=
 =?iso-8859-1?Q?Xn5aUFirOc2zqV8syzcbk5xixRR77ktitC/HGiKc1hHz5xPZHisvqFEfaF?=
 =?iso-8859-1?Q?mMV2TBEnoZTMm5guSTwzy574cT0DiMuztBgYUIi0AEWSK8rfSNvZmzftCf?=
 =?iso-8859-1?Q?sNHAx30x8CSHjab7pnGyYIJMUrjvIxv9RgVgyuu23SpcNj7CvplUMGd4HY?=
 =?iso-8859-1?Q?7T4WhSSK/NG/+RIAkTREkXTyLB/37BtTH1SAEj/82Ic6dxTKR/qBi0gkuT?=
 =?iso-8859-1?Q?qigxggGWamDkOzoWcpDBED0d/7l0yp7rAxwzcRxiuuFv4QzWYhSlgsN9NK?=
 =?iso-8859-1?Q?RObsxGgdcI9of1veYVzlenmfphnhV4FlM7MZrQK+qPP6VxbrJYoMIJSdZP?=
 =?iso-8859-1?Q?KJ0RoWoiYQV5BBes0xxpleO+g9TW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JnEe64rnF9Da1r5t4ShgMVQv6NdxKYtKv1vRbbc64Tys4klRcT1UZ9VyGh?=
 =?iso-8859-1?Q?dP0CwsKzI3ut8ipHCB9osrS1f+V02aOkRqrNQhiVH+DftdS0/B58hPxC92?=
 =?iso-8859-1?Q?ah3giWforoETfh+c/OD+WDDnF7AZM7x6CJETtzvW7uWk8hrQOVXhsrcKp0?=
 =?iso-8859-1?Q?p7ffoNrI/Y47Owq4GpvcbDI/2mTQrQiKi5N6bNrde7EyIpFwia60fAP7mE?=
 =?iso-8859-1?Q?ylKiB1Es+P4UiZueY0k3xdhoUA8SABVVhULNIuVQQSLj9Q5JDh1iOFsPko?=
 =?iso-8859-1?Q?nyKqXPccdx53n1F8G/pLy21WtOYOFTyz43sTiKyzijl9NG6owHgE8wPE2W?=
 =?iso-8859-1?Q?Y4EZnP8Z8k3buc+k09rxUIire8SGaPAYEX9gehySDzPc0j/gKhcnNKoeKV?=
 =?iso-8859-1?Q?iQXaykG1Xb972eRShcJxlqrzm8WyD0RM+KKTaOetZ+lQEL9JTUAC3LR7E2?=
 =?iso-8859-1?Q?9ikEtVWKoz6XqwVcAbAl26FBYPh1qbPeMECjymwOVChwvHCJDjirNMN9R/?=
 =?iso-8859-1?Q?6JF19WMYpkptRFvFOxrw+ZJwUtD91gsZTMVEevjkLMRGt0VHgKpcWj9+Xt?=
 =?iso-8859-1?Q?CeXnDyyxuXuGjfGhBCtfHsO7e054bmkR2sVq/pgXQYcIWLLjNWqjNJ4gMq?=
 =?iso-8859-1?Q?1yMJlmuGwYJl3Rg+CR4v9u/gZN0q28bDNePoDnVuSphLyPGrukBocxo/MC?=
 =?iso-8859-1?Q?iy//b6CQEECtRQjLTqHYhjKnzIGMvdQdFJyb5TpWa3vK+yk0wJHiA7sedC?=
 =?iso-8859-1?Q?8Dp/XccmP2zOYQiyW/1r7SgOGMw8EFw3zIgAJjUUfMjtq6p1G4ix8W/nL8?=
 =?iso-8859-1?Q?xXI4CGU0pWue2T9YkE0bl/uQWoX4b6lJpxriArD3vZbwzEEq2pmi/kn0+1?=
 =?iso-8859-1?Q?gEJtvOAa5LXE5be83CEsOSp884XGfxKD8MScZNaBLb0odSNT9bj8c1GsDU?=
 =?iso-8859-1?Q?uZxsRAynbja0DQiiljD3/9SGTjczqk0k3V7Z+v7TFIc8Y8HAgE+6XX7FgU?=
 =?iso-8859-1?Q?t5SmQPgca/niJucOBzotA9BXEWNup9DvEfiUhd7UZYI0+LCWK16eHt3QLH?=
 =?iso-8859-1?Q?FSOrbHdZcqy5NWDvl55LeirqvU2lQERSfGedzXyC58S/SIh2QU7vloUD4R?=
 =?iso-8859-1?Q?Q6yDNBLDGHWVEXOa4FcioCVHpP3VoAuG5OLKKYanMWwSlFcO9pOXmORlX5?=
 =?iso-8859-1?Q?VJcJgfHRrx9P7zcgXVW4HQg4j2ItKNOygx34SpQNTPys4eLghWBDToCTdl?=
 =?iso-8859-1?Q?QP9LKJKqgYkSPcyYB6uUdUSthcipOoyxLJsoV4VCu2CpvWtnwhExJ0G5Cw?=
 =?iso-8859-1?Q?JXdiYgppzg9NgUwUSD3YnzvXpD1czgLAh9PvjN1IMQQqBOCU89KsDcU/0n?=
 =?iso-8859-1?Q?CbknTPDVaMIIqCXudOrTnr5f97Qeae+vMr7fb+zRfq+Q7jjjwLBE7+4l4U?=
 =?iso-8859-1?Q?stNoJfO4TiTRmjNUoGb1HY4GHI0djucFO7LDUrEP0dZUCxKSWM8Kyxy5Tn?=
 =?iso-8859-1?Q?hfXN/VFCKpidD52a/kB52zdV8e8VDN0uXXzQCWxBlb+J4mvG+hGkWKZ3tC?=
 =?iso-8859-1?Q?K+JrUS/5kyaeqVvl5BvV5fPI6T6Sz4Nw0g9uVSWpQNh6/asJjugFuIF0Uo?=
 =?iso-8859-1?Q?F3FqhEDVJflCL0bhSBD/hRW07UqnJE3yd4JVIHITiuTwdoxRHOVwiXlwZ4?=
 =?iso-8859-1?Q?lb0KkOsKPvry5r+lUbXsa2h1+skk2A2p/VlnOqZ0K7swwxtrxCZShlW2YZ?=
 =?iso-8859-1?Q?EJUizGOOUNQvy2Aj5tJlnZyCX+wkCvgg+u6+TmvpXAIVyVbUjMzCHDbqYL?=
 =?iso-8859-1?Q?cL2mcJPjU5iIpupRxa6HPkM1yglYaek=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98422a22-0793-4fda-e681-08de4303aea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:47:02.7080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdlN5iV1cajL+43Tvzbo9ushR1ibOG2Qvk4PWQhvOooVe+PiwxIyS1oC8lET2KJejehkkWvySCsjUFDUtWIU4A9cPxiTR4MQUTCazOdZBXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

From: Chao-ying Fu <cfu@mips.com>

Add optional PHY reset support via GPIO defined in the device tree.

Improve robustness by handling probe errors and falling back to the
environment-provided MAC address if no hardware MAC is found.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig |  4 ++++
 drivers/net/pch_gbe.c           | 37 +++++++++++++++++++++++++++++++--
 drivers/net/pch_gbe.h           |  1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 68c5fc50489..4d55d96603e 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -40,4 +40,8 @@ config PHY_REALTEK
     bool
     default y
=20
+config TFTP_FILE_NAME_MAX_LEN
+    int "Maximum length of TFTP file name"
+    default 256
+
 endif
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index adeca3d040d..dea8ab828ac 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -7,6 +7,7 @@
=20
 #include <cpu_func.h>
 #include <dm.h>
+#include <env.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
@@ -15,6 +16,7 @@
 #include <miiphy.h>
 #include <linux/delay.h>
 #include "pch_gbe.h"
+#include <asm/gpio.h>
=20
 #if !defined(CONFIG_PHYLIB)
 # error "PCH Gigabit Ethernet driver requires PHYLIB - missing CONFIG_PHYL=
IB"
@@ -33,6 +35,13 @@ static void pch_gbe_mac_read(struct pch_gbe_regs *mac_re=
gs, u8 *addr)
 	macid_lo =3D readl(&mac_regs->mac_adr[0].low) & 0xffff;
 	debug("pch_gbe: macid_hi %#x macid_lo %#x\n", macid_hi, macid_lo);
=20
+	if (!macid_lo && !macid_hi) {
+		if (eth_env_get_enetaddr("ethaddr", addr))
+			return;
+
+		printf("No MAC found in either EG20T H/W or environment");
+	}
+
 	addr[0] =3D (u8)(macid_hi & 0xff);
 	addr[1] =3D (u8)((macid_hi >> 8) & 0xff);
 	addr[2] =3D (u8)((macid_hi >> 16) & 0xff);
@@ -74,6 +83,14 @@ static int pch_gbe_reset(struct udevice *dev)
 	priv->rx_idx =3D 0;
 	priv->tx_idx =3D 0;
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset)) {
+		/* Reset the PHY */
+		dm_gpio_set_value(&priv->gpio_phy_reset, 1);
+		udelay(15000);
+		dm_gpio_set_value(&priv->gpio_phy_reset, 0);
+		udelay(5000);
+	}
+
 	writel(PCH_GBE_ALL_RST, &mac_regs->reset);
=20
 	/*
@@ -450,6 +467,11 @@ static int pch_gbe_probe(struct udevice *dev)
 	plat->iobase =3D (ulong)iobase;
 	priv->mac_regs =3D (struct pch_gbe_regs *)iobase;
=20
+	err =3D gpio_request_by_name(dev, "phy-reset-gpios", 0,
+				   &priv->gpio_phy_reset, GPIOD_IS_OUT);
+	if (err && (err !=3D -ENOENT))
+		return err;
+
 	/* Read MAC address from SROM and initialize dev->enetaddr with it */
 	pch_gbe_mac_read(priv->mac_regs, plat->enetaddr);
=20
@@ -459,9 +481,17 @@ static int pch_gbe_probe(struct udevice *dev)
=20
 	err =3D pch_gbe_reset(dev);
 	if (err)
-		return err;
+		goto out_err;
+
+	err =3D pch_gbe_phy_init(dev);
+	if (err)
+		goto out_err;
=20
-	return pch_gbe_phy_init(dev);
+	return 0;
+out_err:
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+	return err;
 }
=20
 static int pch_gbe_remove(struct udevice *dev)
@@ -472,6 +502,9 @@ static int pch_gbe_remove(struct udevice *dev)
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+
 	return 0;
 }
=20
diff --git a/drivers/net/pch_gbe.h b/drivers/net/pch_gbe.h
index 7e0fdbfd5a3..dcbb94094bc 100644
--- a/drivers/net/pch_gbe.h
+++ b/drivers/net/pch_gbe.h
@@ -292,6 +292,7 @@ struct pch_gbe_priv {
 	struct udevice *dev;
 	int rx_idx;
 	int tx_idx;
+	struct gpio_desc gpio_phy_reset;
 };
=20
 #endif /* _PCH_GBE_H_ */
--=20
2.34.1

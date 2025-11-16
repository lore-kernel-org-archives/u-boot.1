Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD66CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 611F483A3D;
	Sun, 16 Nov 2025 15:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC66B83AAC; Sun, 16 Nov 2025 15:45:00 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F92839A8
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 2BAE5341049;
 Sun, 16 Nov 2025 14:44:53 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:43:53 +0000
Subject: [PATCH 02/11] sunxi: a733: config TF-A load address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-2-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=9i+O4rxJz6IjQYZzTiZcGUJRF7I1Fc6AQp33akj0+X0=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeM8cQYG0E9/UFjyA2hgO0X1l+t097a2BEwOZ
 PyyTTzymf2JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjPF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TjoD/0Z37qAdMP9StC34S
 RyPc34LLYRvy1q+7xYAvsh7OYyvHh/R9p05DQtdMXHHcqPpAs83yklZ5U/d3McCZJ9QPdmEmyg+
 XAriQplCDY1l189mLbAAKmwAqOtu3lLB/6V9AHJOkwq0SUXtKphEs7XPvq95320K2O5QvFi9Jiy
 EolBvbaWamLxWyOlXD7TbTD0FWcMVzZcbeVezCfhyK/1dWbrkVx2qeJ7bs2bICRdqlfY6oajsrv
 nGdgqe0dbwiY02v0S43otRH/dt/LEPipenv0fd+lnNIlcrpGQLZtwKJeEg6FhNOhciwHTq5Ys+9
 CMxZSBxTuIL4KyOcEacEPZbTQ8Sr1P+mMc6xDnnvJdVyWo5K+CHtXXzqypYeDvJXoU0LVUcTkJC
 MxZPrFQAZCTZ+J61JUiBqdgop7Bc34mFGzLpKaV2dwJ3T4f8UK1r/WVSZWvwtikUz47O8JAQYD4
 ph0AKMWgLAh+TKKB+dqZiSVrFID7YGfkwkrxhQWGhGwTjepjk2UB1PrPIQGzBZfbN+PJLNN5KZR
 QqJGWuv/UsomxOUHg5WcUAyxlr2TdABwI2qLVh4vrSb+VoXKcVC0lV3NS66UhvhruULD6lgItt6
 B7EzXDU6Taw4N+4ic+A5BVW9+T1Zfb0ly2VOyypOr4OxEIuPB3buid6zoLx1Ya+2kFpg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

To support running TF-A on A733 SoC, config 0x62000 of SRAM as
the load and run address.

Signed-off-by: Yixun Lan <dlan@gentoo.org>

---
Note, the address can be altered to other value, for example,
moving it to the DDR address space. The only requirement is that
load and run address should be matched.
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index c0b4fdaa370..d16ffddf482 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -259,6 +259,7 @@ config SUNXI_BL31_BASE
 	default 0x40000000 if MACH_SUN50I_H616
 	default 0x00104000 if SUN50I_GEN_H6
 	default 0x00054000 if MACH_SUN55I_A523
+	default 0x00062000 if MACH_SUN60I_A733
 	default 0x0
 	help
 	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.

-- 
2.51.2


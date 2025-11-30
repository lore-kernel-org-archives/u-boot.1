Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA689D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B70838BB;
	Sun, 30 Nov 2025 22:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0D7838BB; Sun, 30 Nov 2025 22:46:13 +0100 (CET)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702888312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 895E9340E36;
 Sun, 30 Nov 2025 21:46:07 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 30 Nov 2025 21:45:11 +0000
Subject: [PATCH v2 02/10] sunxi: spl: a733: config text and stack address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-01-a733-soc-support-v2-2-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=MNaDoQA7RAhDb+DVE75ms9l1oZHqoc+jgymE0b5n7xs=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLr7Ij7V2jivmcBM1XR3vxjJnZLL2Oq8lLtzb
 UveRDLank6JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy6+18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277QzpEACbWc87OzlTXkBSW+
 +XHZpCrCmcZ3+VEpPO97aIealkSDvui4oMIIK8IXyfYAeR5MGe/fcX/ccsSNU/GoIMHvw8nBgFI
 DuY2R2bU5rnOckadBkoXovLJolPgU85uOEb8UiWp/IEtCDjdcxkAAHJd4N88m9oa7PqL/AWUoCm
 qUpkXG+ywV5fvI5Ob1BJvTcYHBTHQCbHfOPZhmDPzpUCEoIJq1xewhsjRX3xSknA+lmyYwxi4L9
 D2HvU77oo6C5oyk2u4L1eEMN4v0mbuSF2atgJpvBLFEDDjk8rnna9prhy5FyPAwfaPI1aPV4658
 SsGOq9sYR1JeFk5mPL4qknABrBanDves1K1SwbHe/Hr2n6hs6b1j4GeL0NjE8DBScFN3+NbTjL3
 Mq0lsXiAC7jdAc+y2sOxx62HIDMzWZiDfiUdbWFa7h6PtWseL0N5S77Ug+na/QfoVarqbcuaYOQ
 BOQJHHmudPAod0Xk6Wv2jNt2K85JZCg9sZwVuKSLAeLlMIQmWSSEUqt80b5kfiYKfTuICqp6kKJ
 3334ICi0lD5sl1Q/jZyVXO5WCXtjsh4RV6/UQLrc/+nLts2110Emt0aPYDKSevYpnbxO69ehxpU
 Ys/W536Q7iwe0Z/wDklyfiO+VsPUxq8cUVbo+u+BbjXyVDkKK9r/Ge6/GMCl0uevKVPQ==
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

Add some ciritial SPL settings for A733 SoC

- Set SPL MAX SIZE to 180KB, 0x47000 - 0x74000
- Set SPL running address to 0x47000, with a header padded before
  the image, so the final SPL text address need to shift 0x60 bytes.
- Set Stack address

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 common/spl/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 24d6ce5d739..ba98b76bbc6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -81,6 +81,7 @@ config SPL_MAX_SIZE
 	default 0xec00 if OMAP34XX
 	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0xbfa0 if MACH_SUN50I_H616 || MACH_SUN50I_A133 || MACH_SUN55I_A523
+	default 0x2d000 if MACH_SUN60I_A733
 	default 0x7000 if RCAR_GEN3
 	default 0x5fa0 if SUNXI_SRAM_ADDRESS = 0x0
 	default 0x7fa0 if ARCH_SUNXI
@@ -279,6 +280,7 @@ config SPL_TEXT_BASE
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
 	default 0x44060 if MACH_SUN55I_A523
+	default 0x47060 if MACH_SUN60I_A733
 	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x00060 if ARCH_SUNXI
 	default 0xfffc0000 if ARCH_ZYNQMP
@@ -434,6 +436,7 @@ config SPL_STACK
 	default 0x52a00 if MACH_SUN50I_H616
 	default 0x40000 if MACH_SUN8I_R528 || MACH_SUN50I_A133
 	default 0x44000 if MACH_SUN55I_A523
+	default 0x5A000 if MACH_SUN60I_A733
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI

-- 
2.51.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FDDCCD19A
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7375883AE6;
	Sun, 16 Nov 2025 15:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90DA839A8; Sun, 16 Nov 2025 15:45:32 +0100 (CET)
Received: from smtp.gentoo.org (smtp.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22A383AE6
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id E9E0C33BF0E;
 Sun, 16 Nov 2025 14:45:25 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:44:00 +0000
Subject: [PATCH 09/11] sunxi: i2c: add support for A733
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-9-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=c5WUV631mjxWk7nHJD2D5wXi2wTPzmGJK8vTgmmX6+0=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeNSOTWmA0F/ixN2685HlEU/lnVCMkiPT0d/h
 35U2OiB4RmJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjUl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ceFD/9EGmJ2A0benICMks
 8ZzrQr0Jay7FMlazyv7wY/IS6G1vfQq3ISdYRvFBEX3CqrqCPRrBcos9gRqoOBTEnDxwCuX3Aqr
 J/qf016D00fNsoK+49UG7grm9URj3l20tfcflQSx8COpyL1A/jSa2CIN9v+69WiJdI+qBWJZWqh
 az0AYoHYAqmnPSaf0tHdpOx5dNjNzFJvFxoaomIkr6zckIgda3J7pvE+rvmDCAyWJTLooUVyxL2
 q56EwEVapgehVUXMzFLoLmqRxhmahGfWXpegBR4QOn71SAebpLwKo+Lfcaa197Kt88HR4YbxlO2
 6+dqMadMzkG6IMTM2ycEVK3o3CoOxB/3UxDCdK7TmRj0H+rv+SLzf4y34/ZmVYrlpvGn8IkumXy
 za18EZKw6aFemqDnqUxdNiXEPiwnAwZJ0CgFjR9ecUg18zi13XGHMilFSPhfZTEE3UufpDlG4M2
 mW0A/yA2nDfs2i4mFEKXHQ3t7qL7wTG4uhio5leNyCDyMwYaeXRavII899C41x+pjXZhSA0IuCG
 VGNW0LY4CdL2SG9daBR8ks11evn6eV4oyQAR3Iq45vAAbI4oTUe77G5FDUhdmscT3fFhbmonZif
 5Cs4UCoIUkhBLKCxMSX6WeikZ9FNlWpvL32zE7kZiFMiHD+bs8WD+b37579a27r/ZUiA==
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

On A733 SoC, the I2C controller's IFLG is a write-clear bit.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/i2c/mvtwsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/mvtwsi.c b/drivers/i2c/mvtwsi.c
index 44e8e191b03..9c1503b70a2 100644
--- a/drivers/i2c/mvtwsi.c
+++ b/drivers/i2c/mvtwsi.c
@@ -125,7 +125,7 @@ enum mvtwsi_ctrl_register_fields {
  */
 
 #if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || \
-    defined(CONFIG_SUNXI_GEN_NCAT2)
+	defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_MACH_SUN60I_A733)
 #define	MVTWSI_CONTROL_CLEAR_IFLG	0x00000008
 #else
 #define	MVTWSI_CONTROL_CLEAR_IFLG	0x00000000

-- 
2.51.2


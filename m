Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F555FEE4E5
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 10:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2032783CDF;
	Sat, 28 Feb 2026 11:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="HP6lOhCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1F683DBF; Sat, 28 Feb 2026 11:10:10 +0100 (CET)
Received: from 2.mo582.mail-out.ovh.net (2.mo582.mail-out.ovh.net
 [46.105.76.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34065801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 11:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director4.ghost.mail-out.ovh.net (unknown [10.110.58.112])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4fNLXv3pVjz5xF4
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:10:07 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-kqqmp (unknown [10.110.164.200])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3482DC23E3;
 Sat, 28 Feb 2026 10:10:06 +0000 (UTC)
Received: from armadeus.com ([37.59.142.101])
 by ghost-submission-7d8d68f679-kqqmp with ESMTPSA
 id KWVGAP6+omlnqgEAhthRpQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Sat, 28 Feb 2026 10:10:06 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0047943dfbb-e214-485e-89cd-eb7e8184b8b5,
 7516D313DA3B20A6C3503D4D04C05974B9C110FB)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 90.126.104.208
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Sat, 28 Feb 2026 11:09:51 +0100
Subject: [PATCH] arm: imx: imx95: Use arch override for env_get_location()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-imx95-arch-location-v1-1-b04896b35b20@armadeus.com>
X-B4-Tracking: v=1; b=H4sIAO6+omkC/x2MSQqAMAwAv1JyNlCDW/2KeCg1asCNVqQg/bvF4
 8DMvBDYCwfo1QueHwlyHhnKQoFb7bEwypQZSFOjiVqUPZoarXcrbqezd/ax5q5quTEVk4ZcXp5
 nif91GFP6ABLsoqdlAAAA
X-Change-ID: 20260227-imx95-arch-location-5e847e694e20
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.3
x-ovh-tracer-id: 13762718988311385630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGr08iqKjBWNTbcM+UQT1qM6zoW8gpEIhJIjzy8tU4wudoaZFqXp2q8fkYxMHRSqXXq7ZejZvLjVxdV8bQqG+1VcbsREyM0gUbNueso1am21YG51W6u0vtxujmA/FrL3nJCTyVxYaTdKEjd+jnCAVwD6J8F38SBfMTKzuT3o0+Nf8uiyodLYXkRVv412bAj9rkZ/S+Zf2IHFwaEr6eTtGJkmYxQnrZtNeveJZXa11ohb9LZOLxl8vygaiQ6AQysqhKKJbEzSHSk3yWWJXfodJGoR81vD5oNAq2V2X0/w/8UIRywsUHTGON7nkSycbcRKUGvWmIhFP1b7+86j4SBoHTUCHLUuIm+eTPvIOa6UKKwwzubzSz3F6XR4PgDZh5yEysLEsqZwggzn4QNZ31SGdTC6CiG0P/wVLurZ8MEm+D/DjNIYz09Pr+EN9QSc4/UZHdY0slVsxWxFYXhGOYvX5CtU7Vun9ZG/THZdEaM9cvTEn1RyI/EEIBKY2wmi+TZqvH4wLzoPT4N4cwY5RvpEFS270f8W/a2A6t8X7zraUgbb1iwo7ZSKaBjzLGO15dCdcT27PehFjUOC2toCc1iB5QDTjFgo7zN5oIq0BMN5p4A2cYFkGscK8rHtAEx8fZhAIy462F3ngBBgGGfOo+IjpO0l62EmyiS5DlHazY1NgARVA
DKIM-Signature: a=rsa-sha256; bh=DLuV5ysfzw4pPO3AecX6+AhD2UiTlAfmPk3LElJaWCo=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1772273407; v=1;
 b=HP6lOhCF2JCK38LkoAb48LYDMR9FtbrUn+n8/c51DklgFKDMDzNBD6LTWwx4A7LfkTlX12N/
 T3brYNphpTmiXPolZxMxsiawMJDZ+S2XNhU8xsMmUV1qAAhxqHMQhV0Tym5X+qJJeB3qFdwl3Oo
 mfQsfxhCiqyHB86x9797w/NGD/3nrO0bYBUSYoQf1kWk6xf38BRNl15HUcd79ll5V7wWm8Y5BK+
 bHUO/J4WuCr+YcVB/ZCds4rC0XGAButfwpZ9hrb3iPEBuAOetC0BGFenxsFig7fqtwekiQb9IOZ
 dNmFXOmEAyXJdEr00Ka1wY7Kd72Z1tBAxcWcLffONhOhw==
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

Like commit b9e48705e0b6 ("arm: imx: imx9: Use arch override for
env_get_location()"), use arch-level implementation here so that
env_get_location() can be used on board-level.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c1458ccca3c3..17269ddd2fc4 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -820,7 +820,7 @@ int timer_init(void)
 	return 0;
 }
 
-enum env_location env_get_location(enum env_operation op, int prio)
+enum env_location arch_env_get_location(enum env_operation op, int prio)
 {
 	enum boot_device dev = get_boot_device();
 	enum env_location env_loc = ENVL_UNKNOWN;

---
base-commit: 437ea9f8be5afaebe2d8cbab6242f1182857f21e
change-id: 20260227-imx95-arch-location-5e847e694e20

Best regards,
-- 
Sébastien Szymanski <sebastien.szymanski@armadeus.com>


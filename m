Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B89FCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD49848A1;
	Wed, 10 Jun 2026 16:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YbSNlo5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271668489F; Wed, 10 Jun 2026 16:17:19 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B528489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 62B03C58472;
 Wed, 10 Jun 2026 14:17:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 641595FFC9;
 Wed, 10 Jun 2026 14:17:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB9C5106B9A05; 
 Wed, 10 Jun 2026 16:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781101035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=wMSCTYceRfsqmT8mpdX+c1U23s4x0LfJK9zuovUanhs=;
 b=YbSNlo5mFIl4VEhuIPHTI9tTpxvjH06i493ZX/ZRfZQTlyxdjrOmcthxKllWTdqZiHEwWA
 bcPcqs1+gyUMG8B24+83032Ze7fojL4D71HF5sCInpYgytsR6EPK9CvbU0jaNg588wNanr
 /l9dKrlilfD7b+CKpBLg6JU18aoE1UtL92OtgeOBgOtYThlxdp1UffAo8PrtX4cGIvnvV0
 /3OHqzhPay4cLQKCTotY8eGAiDYsYj7HmnbBrgk4nxuhoapKKP4LCP7Mlzrcf7cGlpdtRE
 VJ1f/ENz7f/Nz38nyG6Dv039GmpuJvbYVYDU+KdQ8x2MUpx6lF1KM2cP4nvXNg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 0/2] imx93: Add support for OPTEE
Date: Wed, 10 Jun 2026 16:17:08 +0200
Message-Id: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAORxKWoC/x2MSwqAMBDFriKzdqAOtKJXERdSnzoLP7RVBPHuF
 pcJJA9FBEWktngo4NKo+5ZByoL8MmwzWMfMJEaccZXhdUiL4uT9SABPejOc8Ra1WGkc5e4IyPp
 /dv37fj8susZjAAAA
X-Change-ID: 20260610-mathieu-optee-fix-e60c5e725296
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781101032; l=730;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=j6rQpBE/wENuFe5/v7SoZkbIQE2+3WogUR6YX3rCiNU=;
 b=QxgQzdyZNUZy+UMZO7SusgOKbeNyCvSKnvSkGoHE1P13KzyWWquWUZ8Jnls9kNrLh2bjdFF5a
 YYlVdzNSkKKBsW/6ueU5OUL8emGBkfcyAbhSDDkGwtNMJnSrQHNhjsF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
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

Changes in v2:
- Fixing build when the optee image is not present
- Link to v1: https://lore.kernel.org/all/20260414155928.1391211-1-krzysztof@kd-solutions.pl/

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Krzysztof Drobiński (1):
      imx93: Add support for OPTEE

Mathieu Dubois-Briand (1):
      binman: Add optee binary to i.MX9 platform types

 arch/arm/dts/imx93-u-boot.dtsi      | 3 +++
 tools/binman/etype/nxp_imx9image.py | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 1a8b7ad50aed5f5f0a4ccbfd455233919c097293
change-id: 20260610-mathieu-optee-fix-e60c5e725296

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


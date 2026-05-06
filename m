Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2AACD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A517849AD;
	Wed,  6 May 2026 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UIdKeo8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129E88488B; Wed,  6 May 2026 13:42:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FCB848A1
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 13:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoine.gouby@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so23422305e9.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778067753; x=1778672553; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ffZn3zok47jjOsSDQkgjApq5BXX+auLc3Pc0wpXex/Y=;
 b=UIdKeo8O3s07g4MJRq7HW74x/B9gmSLmm4CAnDsAvJUmwqa9ljKQNGPGRnXVrzWM8q
 1BFUriNolx63lNt6HmofVGiHFWgM2yJp3mOdh2lxZRkiTPLek0q0LlnGrH+5SehU22eB
 EDpTT+I0MMFbYopePg1vmCYuBkh+I0QgRnbCp0+GtKvtXYlIlmp/ngNXIUj6N/AWTsv9
 ctmVWzE/vIfULDvHnIG2uFRSUYNYsQ+kvlVMMH0vXd9QaK8WfD13EvCJZgMIMvOWa/mI
 Px81t/7cBwL1jXWBI82bDPGQSaxTKEIr/OGcIPxzPYGfxPWmuc3Bf2Niq9Sf/o4yapOJ
 kQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067753; x=1778672553;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ffZn3zok47jjOsSDQkgjApq5BXX+auLc3Pc0wpXex/Y=;
 b=SibJna+n2J1Wv+rafvMQ5MhPh9JpBElPNgiUg00GtkyJYtfQ2PekjtXjMldFHhB7JM
 rltwhSeGPm+h92lMjTKI0S4eFIFUIB1Zqgu3Crx2weSnFRFuQu68sEiga2/rEzk+cyoe
 SmyQzUu7R+Ss/eRI+p4VgPEhs/tyy8fGYV3sIqBSzdnh29GFBw1KrP7Y5Ol10wq5QeDt
 EGfpsa3mntVt7it0KocXtGxtlI0zdiQU5VsJy/3IgvMLerAbLSH31zD5VtNzsrYuP6D4
 n26bsJW9+C37c01XF00yZuky2VgzefJ0WZ/g0WrCO5M2i05aQs85QPuJZyN4HVeGeQAq
 l0tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uO9KW+LnB2x3jnb0h2L93i88VzrSjK04xRekre7zG1Xrji4/IwpacLIdFPVdl7zg/LRlXsjU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9l1YDsji5dVpjy97zNUJ6wAZjSIRtLinFWRlhfkNToCHdjofi
 mnLI5lXwNUD890IwESn/fARbZhEQAa+P5ynIEhYQhZDl79Q6QL84I+RM8KPNbI2f
X-Gm-Gg: AeBDieuJlHm7uZtTV7czOsj1rGoV5hY26yRb0R1bbu3zdjshZ/JysG8Q1JF4O4S0Ynu
 6/IeM/xv6gopfieECNqZDbf7SxmuGDi9NFQWCtPTAMgI3GYNMaM3+uPr+8PfFjZpet0m5z8l7vb
 Y1Pp1e9o/qqzuaV5FDfJT/S5ayrYXtDBqxGUyZUzkCUtjsjvLXxmLjaIcChjX7ibzKNPcNjl4t3
 p9qnwNv31Qkt8MBWtp3FBeWvG7jG9wM1rRuAXuS9gGq1sRFjkE5QlAz4+RBtoB9N05Yn2HxYRzo
 dXwnnqm3mMERslpX2wFDv0WvmG7l7i1NbpbiKxE3DKVzqw1LF+EPrc4vSFQZFVxtTspMdte1Mpl
 pG6KuGnEa3cG8aP6g/JYFpSizdi0m9a2oBfw90CEaNtyyXXExlTnmMt2VjQ76yultej3OI0ldW/
 BTw2aQFs8phlH3dCLtZnt7W8XD8Sl4VM1EyZho5VGMPepxCvQF6l3jeOdOr0z2+JfqY0ICvlIGQ
 ADy/iwu5lVmC2KfNHsMrAa1zu/r5+3WILjokRqx39JByf75yfq1DlRvg0ygcw==
X-Received: by 2002:a05:600c:354b:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-48e51f427bemr52815875e9.13.1778067753363; 
 Wed, 06 May 2026 04:42:33 -0700 (PDT)
Received: from [10.0.1.145]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53157734sm14458305e9.35.2026.05.06.04.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:42:32 -0700 (PDT)
From: Antoine Gouby <antoine.gouby@gmail.com>
Date: Wed, 06 May 2026 13:42:20 +0200
Subject: [PATCH 1/2] board: toradex: smarc-imx95: remove gpio1 reg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-v1-remove-gpio1-reg-v1-1-d5e09f936d90@toradex.com>
References: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
In-Reply-To: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Antoine Gouby <antoine.gouby@toradex.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=804;
 i=antoine.gouby@toradex.com; h=from:subject:message-id;
 bh=K0NQS74Qwopp5hAPiJAxP7XPptzMi9KTPCkfktLe9n0=;
 b=owGbwMvMwCWm0rPo7MxLN2YynlZLYsj8ran+KzugbrPMtIuhAiybJhm8rXNzty0U0up1/Wudz
 /SP9XB7RykLgxgXg6yYIkvGE1VBPoUQWQ+O5mSYOaxMIEMYuDgFYCLHQhgZ7iVlfpObX9f4IG36
 HOEtSR+9t/LvPWJZWanJ6bFdl+XEBUaGC6a1zG81xXZ/OaInsd+jeHKvIuML1Zv1k+oMYww475z
 nBAA=
X-Developer-Key: i=antoine.gouby@toradex.com; a=openpgp;
 fpr=68E425110E20541D48088363248CA2CD99D2D899
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

From: Antoine Gouby <antoine.gouby@toradex.com>

The RGPIO2P driver contains legacy handling for compatible combinations
that expose two reg ranges (dual base) for i.MX8ULP and i.MX93.

The i.MX95 GPIO controller exposes a single register range, so the
dual-base handling is unnecessary.

Signed-off-by: Antoine Gouby <antoine.gouby@toradex.com>
---
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
index 97ce7402e503..24952579a670 100644
--- a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -10,7 +10,6 @@
 };
 
 &gpio1 {
-	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
 	bootph-pre-ram;
 };
 

-- 
2.53.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C82CC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A262F846A4;
	Mon, 20 Jul 2026 10:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IcPvSYld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E3182991; Mon, 20 Jul 2026 10:23:41 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875AA80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso14560005e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535819; x=1785140619; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9MDlPZED3jHAcqD8bKnGWT+4fhedRFJDTkKzhwHFfgo=;
 b=IcPvSYldfzZExP55YH0zkUzzhkUctrkfHFnyzEhWGmFSctkTp4S65aE9Z0nE5N/DVw
 wITQHTAX8lvOMYM77OiVr9+XsC8Tk3BuHojSYuV0Mh8tBQDGAAEm9CRXLeNrJXVQmJ8g
 zAqRD7dvtMIPFu/Bt72K+rlA+qhI031rFGMOyFjVaGVzs2MeUrHhr3tyuprlMfEJTpv/
 eT9q4sQFL2gTFgvr5l6BMsZjJgfavCVOxCB2KT/Ol5cQdKbcA5uioWrwxHP7bhZ2jXiP
 fL5jx1j/f3bWztC78X05MzhDQ5d7epR4HF0qGv66DiRRByI/bhIT2v2KtcPxPoN5fELf
 o4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535819; x=1785140619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MDlPZED3jHAcqD8bKnGWT+4fhedRFJDTkKzhwHFfgo=;
 b=FBBNNmZpE/RucpGb2p/hH3laq7y7vPCQojl1zy0BNfr0Ahmqh7HtKy85VpZjIRjw1/
 grWGeU1pIs4wkdxaumEJdetBW8KIa51SYsrLaoWWDvdMp45GPFD+DYDSelbLW3axsNAG
 EHtCF+JpGbD98WlIauIcBNFyzUOlhxojaCQIGw0xQafuBr8pvRTpl0rr7TuJaztMuYkU
 E8e2oybjHNxf0o47N9J4W1983H6UPcp+4sJvin3rzXybCPFGu6oGoqpoFJUK7zhBfQqg
 5BY4wAUhfz2O5LLH+UxNSD30zGE1Gh6L0lk/28suClKcUSLaTBbl5XzqGVrs7v+YyFY2
 cq2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqahtXMjDgLMeJMZj37VImsfTtoUEohVJz5gwOpM8QxYdK1I0LgcWFC2pBK5/rslysxBxPEq0w=@lists.denx.de
X-Gm-Message-State: AOJu0YyvdPELEwPWVLTc1shVrMcRR20T+f90FHzlOjebe/diDW3z1MyI
 Wcy0e63hCZtUwzzPtN55FW4RQf5+LQQ9ARz6EUFHwjbBWuD2DejWdVa1r4xfWGDk06w=
X-Gm-Gg: AfdE7cnNNec/ugPUumaf5JTczGTSrbmY9vnpLZ46uqcu53WRbD1i59egrEFH0/T7RFX
 vaDmYy0XGKPGTOkPHG6BjDbOXl3rFB5d7/dpsf8AYU3qwToWTlsYeLPRAYtPeR6bqx6gt7aPAdt
 w6gkoaLtGkkzSZk+ld+V08QLmP1YMFypXm6aZGl6e1l/J3q5GTTRMeFtyBZLsXs0SsncEmGEwZl
 3pRB4xLYoq6C4eyF6FbFsPDiJ/niznqgZE+H95gGZOXnBUG2WedmDNGGOG0USO2NHBbUnSt7Eml
 FRb1xYgaYjPoDdPr0gneARXtok/IQF3oavrDP2a9lLIP+FeFfuZTYHhMrJuEzRbaUQzsobUxAjk
 KSPEui23MUfM3H+bkHIerUipK+Kct7vOy+be5bOkUk3/IGJ1Qa0WXWr8FxHP1NxcgSz1jLvbbgF
 Le6dmst6tIA0FF3TmpvlrBiRY=
X-Received: by 2002:a05:600c:3512:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-4954a3ef7dbmr136301305e9.9.1784535818837; 
 Mon, 20 Jul 2026 01:23:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 20 Jul 2026 10:23:31 +0200
Subject: [PATCH v4 3/3] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9Mw4bjjARb8IU+h1qKxNAa8MD97n8e0w03TNpZEhGLU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqXdsF9+xs2JQuBf22kiPHQibGmOZd4nZ3Y9llsoVJ
 n+6yvpGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCal3bBQAKCRB33NvayMhJ0Z9UEA
 DJ0WRbSiRFiWIoMzRFXOC5U60y8OJRR7IFf03WGv6WhZCKXMB8YJtYEOiXkUhnSQ94mCoY74Dc+cWU
 KkdcJpIGBjnDHAlVDAjp6BXW6bfMnAhvESQ0ix5sQYJaOULXkQbN7qMZK+lbSUGZoakMJqix6/8gcN
 WGd85rdBByO41wDq1vCkqoMtGqIauo7qr3obXak/b0hp7keHgrLkSEERtz7NId8gAb5dO57+mrxfRE
 vqE74pz9FYeJkgLwaE72a/EcrOgWXFCWNP8uRzVrlpEcdduIKUo5KW98lppVumysmfjrbhx6TY6aDp
 krSYsePQq/9AMCFgNmTC7mAlFo7qDW0xjf/O3nxeZWF9OrrHcsvhVKDAOIsfXBVZoIZbPUDcEIHAyC
 3Bh/96VmyFfWXv0nL1Q+5wtduhr31Y5SVXyygcmksGDO0vNLHm6Fsxn/3t6kjGkMBqZE13FEfq7tzt
 nrGn3+kZNiprITUGwpW3lNKh3aLguQkt6Ac5bswDY5ZnFJMPGdWtTU3zc9pkqZ8+/hkgJa79RvEMbj
 ULhEiuxUGgR3pLzvm+6//oFB40D/NJCptWZGGlLFK0RYbygcKlrY9IkHCTYeG22fJ4JwWgDm4gdfxR
 VoVGy8qXyNo0ng8EsIMOuECqnQaCAQyFbaQsugdpfHbDmpnXRvsKs+M0TS2w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of list.denx.de to the new
domain in the main README and MAINTAINERS files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS                   | 2 +-
 README                        | 4 ++--
 tools/u_boot_pylib/gitutil.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b2a2e373c..177bc1fdc07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2022,7 +2022,7 @@ F:	test/py/tests/test_xxd/
 
 THE REST
 M:	Tom Rini <trini@konsulko.com>
-L:	u-boot@lists.denx.de
+L:	u-boot@lists.u-boot-project.org
 Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git
diff --git a/README b/README
index 472cf37d9cc..51e98d0f4cf 100644
--- a/README
+++ b/README
@@ -45,9 +45,9 @@ Where to get help:
 
 In case you have questions about, problems with or contributions for
 U-Boot, you should send a message to the U-Boot mailing list at
-<u-boot@lists.denx.de>. There is also an archive of previous traffic
+<u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
 on the mailing list - please search the archive before asking FAQ's.
-Please see https://lists.denx.de/pipermail/u-boot and
+Please see https://lists.u-boot-project.org/pipermail/u-boot and
 https://marc.info/?l=u-boot
 
 Where to get source code:
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 34b4dbb4839..59688aa7147 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "Please add something like this to a commit\n"
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
                   "Or do something like this\n"
-                  "git config sendemail.to u-boot@lists.denx.de")
+                  "git config sendemail.to u-boot@lists.u-boot-project.org")
             return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
                           alias, '--cc', warn_on_error)

-- 
2.34.1


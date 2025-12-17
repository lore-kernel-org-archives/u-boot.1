Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86687D6554E
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 14:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD9183B55;
	Wed, 17 Dec 2025 15:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F98183B55; Wed, 17 Dec 2025 15:02:41 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7365E83B21
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 15:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dWb8v19KGz5S4;
 Wed, 17 Dec 2025 15:02:39 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dWb8t3hcrzSgs; Wed, 17 Dec 2025 15:02:38 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 17 Dec 2025 15:02:27 +0100
Subject: [PATCH] doc: pytest: fix typo in multiple config options example
 for buildconfigspec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Nz3ZT8ZN2CypLU4hLdnPLMAl3LRGOTNCNDE1OTZEsloK6CotS0zAq
 widGxtbUAXVhFz2EAAAA=
X-Change-ID: 20251217-doc-pytest-lwip-9a34f21454c9
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The option should be 'net_lwip' and not 'net lwip' (see all usage of it
in the test code base).

Fixes: 2bac578c5aba ("test: allow multiple config options in buildconfigspec")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/pytest/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index df3821da20d..924bc185b51 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -546,7 +546,7 @@ either of ``CONFIG_NET`` or ``CONFIG_NET_LWIP`` is set:
 
 .. code-block:: python
 
-    @pytest.mark.buildconfigspec('net', 'net lwip')
+    @pytest.mark.buildconfigspec('net', 'net_lwip')
 
 The ``notbuildconfigspec()`` annotation can be used to require a configuration
 option not to be set. The following annotation requires ``CONFIG_RISCV=n``:

---
base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
change-id: 20251217-doc-pytest-lwip-9a34f21454c9

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


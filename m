Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC88CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C497983A79;
	Fri, 31 Oct 2025 18:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F88839DF; Fri, 31 Oct 2025 18:08:48 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE24683A5A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cynWK2zLRzZZd;
 Fri, 31 Oct 2025 18:08:45 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cynWJ3PdNzmn; Fri, 31 Oct 2025 18:08:44 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Oct 2025 18:08:24 +0100
Subject: [PATCH v2 5/5] rsa: update doxygen doc for RSA signature
 verification to mention PSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rsa-pss-always-v2-5-a29184ea064d@cherry.de>
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
To: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alexander Graf <agraf@csgraf.de>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
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

While the verification step originally only supported PKCS1.5 as padding
algorithm for the signature, it was later extended to add support for
PSS but the doxygen doc wasn't updated to reflect that so let's fix
that oversight.

Fixes: 061daa0b61f0 ("rsa: add support of padding pss")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 lib/rsa/rsa-verify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 0d618f15ea9..e7e612a4688 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -310,7 +310,7 @@ U_BOOT_PADDING_ALGO(pss) = {
 /**
  * rsa_verify_key() - Verify a signature against some data using RSA Key
  *
- * Verify a RSA PKCS1.5 signature against an expected hash using
+ * Verify a RSA PKCS1.5/PSS signature against an expected hash using
  * the RSA Key properties in prop structure.
  *
  * @info:	Specifies key and FIT information
@@ -388,7 +388,7 @@ static int rsa_verify_key(struct image_sign_info *info,
  * @sig_len:	Number of bytes in signature
  *
  * Parse a RSA public key blob in DER format pointed to in @info and fill
- * a key_prop structure with properties of the key. Then verify a RSA PKCS1.5
+ * a key_prop structure with properties of the key. Then verify a RSA PKCS1.5/PSS
  * signature against an expected hash using the calculated properties.
  *
  * Return	0 if verified, -ve on error
@@ -423,7 +423,7 @@ int rsa_verify_with_pkey(struct image_sign_info *info,
  * information in node with prperties of RSA Key like modulus, exponent etc.
  *
  * Parse sign-node and fill a key_prop structure with properties of the
- * key.  Verify a RSA PKCS1.5 signature against an expected hash using
+ * key.  Verify a RSA PKCS1.5/PSS signature against an expected hash using
  * the properties parsed
  *
  * @info:	Specifies key and FIT information

-- 
2.51.0


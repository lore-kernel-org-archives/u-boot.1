Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658BFC83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 08:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08BAC800D7;
	Sat, 12 Jul 2025 10:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="DgJ8DWed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E92800D7; Sat, 12 Jul 2025 10:27:28 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF3E8003E
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 10:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sputnik@on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 s=protonmail3; t=1752308845; x=1752568045;
 bh=mWiuyGuinScLZbudRgr7phTnsO7h7TayldLEIMkMfaI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DgJ8DWedOmHPNLqY9XyCFg0JCicrIgRYvJw42kfN6gpBSAT2Pz7ITWloxe7HWJ4Pg
 t40DRMs8OXe83klIo19zpkhglaLhyW4fRq+WaJMWqMQQ83lro5lVPwjrR2Y1F82F4q
 dofDHi+jITVV/6BUiRd1YFMtXruHFUqV1QVxtJWTWsp6c9Hws+MTPnC+DhnSMipvBy
 xHhwqwQEyoNe5MYsA/vwXYkVfammTd5KwfwrWhq51A4F+j7fgYPjTqn19P0qQI0InE
 a4YzMcReTDTHvGRnnA3HTIsZrkUWlHbXdg5WuwOVZhNpkTb7A7RscyhZen1aZWat0t
 rc1Em4Rw9os2A==
Date: Sat, 12 Jul 2025 08:27:19 +0000
To: u-boot@lists.denx.de
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Martin Herren <sputnik@on-the-web.ch>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] riscv: Set SYS_BOOTM_LEN default to 0x4000000
Message-ID: <20250712082540.14091-3-sputnik@on-the-web.ch>
In-Reply-To: <20250712082540.14091-1-sputnik@on-the-web.ch>
References: <20250712082540.14091-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: b61900abc8e592727ca1ebb27147fc9e8a3b5ce4
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------574b71fc2f0fbf58db5925c28f5ffc8518d11175f8317f28341d323e368d4e30";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------574b71fc2f0fbf58db5925c28f5ffc8518d11175f8317f28341d323e368d4e30
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Martin Schwan <m.schwan@phytec.de>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] riscv: Set SYS_BOOTM_LEN default to 0x4000000
Date: Sat, 12 Jul 2025 10:25:22 +0200
Message-ID: <20250712082540.14091-3-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712082540.14091-1-sputnik@on-the-web.ch>
References: <20250712082540.14091-1-sputnik@on-the-web.ch>
MIME-Version: 1.0

This changes the default value to the most commonly used one among
existing defconfigs.

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2ff6f003738..54ef7052c5c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1057,7 +1057,7 @@ config SYS_BOOTM_LEN
 	hex "Maximum size of a decompresed OS image"
 	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
 		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
-	default 0x4000000 if PPC || ARM64
+	default 0x4000000 if PPC || ARM64 || RISCV
 	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
 	default 0x800000
 	help

--------574b71fc2f0fbf58db5925c28f5ffc8518d11175f8317f28341d323e368d4e30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmhyHGcJkIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcme4SAbM9U9Rb2MQHZdwKrtYFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAD3SAQCeYdstfc6xIYJYMbRHy+igjrJ0uwMD/XwEKhlK
IiwDSwEAnkiR8caGgIB13m80NMKxj0jae/ajoiZbR3QKEnh+1gM=
=HdLn
-----END PGP SIGNATURE-----


--------574b71fc2f0fbf58db5925c28f5ffc8518d11175f8317f28341d323e368d4e30--


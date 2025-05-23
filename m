Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785FC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3852B83303;
	Fri, 23 May 2025 18:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="TUIyOIuG";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="rxykHew2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276C28346B; Fri, 23 May 2025 18:55:18 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5289A833E8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=TUIyOIuG9ukcjW4qTJFXTTbtKVjKOHhdCa3tWD7w+946viy/DR7Mta/1XkR3jAtKORPntDGcVJxCaY8Dvx//QQzH8Lx2rtNwCiwnWM/wEVhjXfsUGlYjIkMb71Xv7F/9jKUr01Fj55qV6VGRvDyjCKClkvj42eXA7pFsexoebv+pzV0T6Rv4wfOWJVnuiMiniaKMcj/0QK4zzW1CrGI6H4CCztn0VOVTbd20/RKYfz/cmW6G3jzdfWvwjPEJ+tStmEM+wRmFAfBNdc62SnPBRSwSuza2u4bD39tYRYkbva4X1Afvergy8yzqoRsIaueQpUMwseK+hzA2hY5QqZcS4A==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=CFrSQ/J4doRprQFZguCaK0dERH3Z3cZ2bpZ657iBGEc=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=rxykHew2oHICGge/5ZWXzRjuPogad6Ioz+S9TuGaRsymyDb/dAFMUmGYYVV9EBEbbhwQDHHoCGR/zr2XhvgNerUmSILRyIsGalkrPUB19BC9D3+f+fk5JrQGxboHbHfLkoIUckblTunRer+XI2KCdG11kSO1jdj4pS5sLcVh1oRUKflccjbz4HGrPpmZne2VrsBH3NtJA5Q1Tn5rIL7mV2K6HTEar3O41vc83vRq4zmZU7V51Kdux7B0TBmdGkD92EOfXe7b+ndFf+YxeZxgZGGz2rzkFB0jqNWDnRZoyFcHbafP6HpFa3tbtC69esWvZic7tVxn0NpHBwW+awHlqQ==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=CFrSQ/J4doRprQFZguCaK0dERH3Z3cZ2bpZ657iBGEc=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2127220571; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 23 May 2025 16:55:07 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/5] rockchip: rk3399-nanopi-4: Allow MMC driver to control
 SD regulators
Date: Fri, 23 May 2025 16:53:40 +0000
Message-ID: <20250523165406.40915-5-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250523165406.40915-1-justin@tidylabs.net>
References: <20250523165406.40915-1-justin@tidylabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

This change removes the "regulator-always-on" property from the
"vcc3v0_sd" (vmmc-supply) and "vcc_sdio" (vqmmc-supply) regulators,
which otherwise prevents the MMC driver from being able to power cycle
the SD card as part of the initialization procedure.

It also removes the "regulator-boot-on" from the "vcc_sdio" regulator,
which could theoretically damage a SD card that is already initialized
in a low voltage mode.

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
---

(no changes since v2)

Changes in v2:
- Added patch to remove device-tree properties that conflicted with MMC dri=
ver initialization

 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-=
nanopi4-u-boot.dtsi
index 75736124996..ba2b73223d4 100644
--- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
@@ -19,8 +19,11 @@
=20
 &vcc3v0_sd {
 =09bootph-pre-ram;
+=09/delete-property/ regulator-always-on;
 };
=20
 &vcc_sdio {
+=09/delete-property/ regulator-always-on;
+=09/delete-property/ regulator-boot-on;
 =09regulator-init-microvolt =3D <3000000>;
 };
--=20
2.45.3


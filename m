Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A7C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED9080944;
	Wed,  5 Feb 2025 18:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="TfI7gt/1";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="QvhwtBkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDA4807E0; Wed,  5 Feb 2025 18:19:00 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368DA809D0
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=TfI7gt/1zd9DVYEq3usChW8/ZFgvzfcn0FvuC8t1AAWFJ/Ff42Pxg17QeaCR/ixLBNXO70/g8U9PeD41zpbT24tkLi0y6rdi5rlkQfBWQemMt9UJLmbVLRkmOTJDHuxAjvi0fg5h+aPwSYhXIdPBNjIbSp02ezuShlbpwrpRPzU0iGfN5fxxkuc2wVK4jOCjFBxcrJlbPS4xOtDqOqGo4x63RCi0OBcluIhAUNcxRKkum1juw8vXrNQN2qJaQyPQ2k6LRWq3P/i7B0g3Y26jBjNQpeQm4ZBnIqEjvQo+y+kw/tOa0BtwlzommLkVTDrcsGWpdcqXSoq1fOpEbnkiCw==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=CFrSQ/J4doRprQFZguCaK0dERH3Z3cZ2bpZ657iBGEc=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=QvhwtBkce2Uo0zRTiLTYRfUZW74Q413cuiFqkohj0OBgL8+n3PvAX+NO5mRQHoUAuQMe2cMNCNL8Gb8dpwZMbDdirtL/HBCATTVi5dYZagICg38PfBQURVTt2mC4BrH+UK0YgqOt836H4hfAaQRgIHiE4bKEhNX19YWUYG3f37yzCnBFSCUb72WFEUE2fKdNexvcjHVys0ofiMWSLKCW/YuNuF2JjuLY/69WTv1OUTCLzbNprlRSVohIJ8r18jmBy+2dvC+S7/1thQhgWFNj9JyTEe/LGhPWxEmAOYS2cMiEcyHionGGY7I5eKqU2HAlx5rWjZL9z1lgWg78pHa/zQ==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=CFrSQ/J4doRprQFZguCaK0dERH3Z3cZ2bpZ657iBGEc=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817051443; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:18:42 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/5] rockchip: rk3399-nanopi-4: Allow MMC driver to control
 SD regulators
Date: Wed,  5 Feb 2025 17:16:14 +0000
Message-ID: <20250205171634.826560-5-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250205171634.826560-1-justin@tidylabs.net>
References: <20250205171634.826560-1-justin@tidylabs.net>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E283C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C568083C;
	Wed,  5 Feb 2025 18:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="XD314qUB";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="fWtuYVXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20A380815; Wed,  5 Feb 2025 18:18:55 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB1180977
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=XD314qUBGyh7ZULNrmbSQLZp8W+jn5LCBoSq179eFJDbEKQb20eKMnCnMXPmTqzfiTsQ+hKI4iAR5NREMnu6xk+iwrvGrXTIoLbeg+Y0aA5CMKTioCjPhFubC5jpeSYWW80wLRbd8h4Ln1p5vad0Kflwj1G4iOVXS4hut1BMMX58ryHkMa5NIZlVIJW4efo1uVES4S3BLFy/af3A5deL6UpV8r5ujC+NISV4OMVvz7obBblLETHggttl2Yn7T1VqzyI7ovIbpHhXNOU5kym/HKmlm4Y0dCjbYnr6aylRLGNHCCMfeteq7xCRR3DpaPuXLenc5sfamq7JRmQ8ZUhNCQ==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=DclHk9Gd8sQIRGBYfsdQxJhLJOm9hFyIN8F/+zGqNAk=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=fWtuYVXmpFyyrgyslBtjf3tNzSZmkJmsLHqbKMmyZW7VfDfTAshexVnS+mNxv1v3aE6fUKqRuiwae4xehbFOJhzL3ncj1/jJrUSjg/BGrmZWco6AFPifb0d9EoJ5Jfz0moGUdQ4xQzefWJhOZGhsL6wt3U+qqSuwpLxgijbx4SkIdCmk2+t2a2rJpI0rX/F8fAZ1KzzpuS9ey7IepmtBFCPMiF4hvqXyEuXC874wMJHxZGIbzZSP+NX+3oSmso2aChgHaZKI0iinxTnXRa8rz9Is2bYMRuYwxnjOLH2JIuZ5GB80MshXAATRFIB2OOzOp9JqVTfma4VhbFe+WF7lvg==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=DclHk9Gd8sQIRGBYfsdQxJhLJOm9hFyIN8F/+zGqNAk=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817051443; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:18:37 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tien Fong Chee <tien.fong.chee@intel.com>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v3 2/5] rockchip: io-domain: Add CONFIG_SPL_ROCKCHIP_IODOMAIN
Date: Wed,  5 Feb 2025 17:16:12 +0000
Message-ID: <20250205171634.826560-3-justin@tidylabs.net>
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

Allows use of the Rockchip IO-domain driver in SPL to configure
the GPIO to match the voltage supplied by specific regulators
(e.g. "vcc_sdio").

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
---

Changes in v3:
- Add depends on SPL_DM_REGULATOR

Changes in v2:
- Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig

 drivers/misc/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index da84b35e804..ea0ca764300 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -110,6 +110,14 @@ config ROCKCHIP_IODOMAIN
 =09  for the IO-domain setting of the SoC to match the voltage supplied
 =09  by the regulators.
=20
+config SPL_ROCKCHIP_IODOMAIN
+=09bool "Rockchip IO-domain driver support in SPL"
+=09depends on SPL_MISC && SPL_DM_REGULATOR && ARCH_ROCKCHIP
+=09help
+=09  Enable support for IO-domains in Rockchip SoCs in SPL. It is necessar=
y
+=09  for the IO-domain setting of the SoC to match the voltage supplied
+=09  by the regulators.
+
 config SIFIVE_OTP
 =09bool "SiFive eMemory OTP driver"
 =09depends on MISC
--=20
2.45.3


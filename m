Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FFAC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BF28338C;
	Fri, 23 May 2025 18:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="J2Zle9GH";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="sS0z3SM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D38083394; Fri, 23 May 2025 18:55:11 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8380583278
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=J2Zle9GHgwFGxl0VLdSLvvawHHsYbXdCy2H/MQw2GRlp1uZUIMkMuDVPACrTP1vxhgDLI/jCIdEYDfENimGItzXnQWogTlYg494d1D7k2w99cMGSIBkFaAWvBndfMTpbSnTWE8AGOOD1GrDU38K+lhE+OLTm3qYHCRmYcNJAZDCVhdNcG30lTpCFJvLDuUK3SviurZN563doLiZbQ5f5eLu6AeD6J/htlfAn0L8jU6I1Akhk6dj6KzlRg1PF7lcWkr3LbNG+4NO/v2DeUgOw4SVrO+G1MUMQzTg9aKQDWLQnS/HvdMbPI6nl9mrGFtkyglmmWDSPOal6D5UBHC5e4A==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=e6hj/PvbW1Ah0z0WAifjhNCO7YVwV9oiSb5B2cu5OJU=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=sS0z3SM/P96GOaj201WzTAIeiOUfoaYMDVs5zPDFYfa0LqDOPOqNWXhGRUC7DBnshBNK2z6bzc9R758it2d1HWzfkI//DJnqTcPr/pnJOWVoqf+4hUfgFmcWw/qeCt0nvM+9u2/EevLRVtItDvN2Q5qaTRKK2OcLgzaIqk9pUA3ldCpHdo9ImWTCBoRIcpUIafwPzLzqaFPE4wav9zOL7lZostosS+N1OFbUPjMngI1TeNrjGIVQSm6azHHIHgU8Q+PMA2JeGNKJ7vOclydvGmS/G81m+lfilMOra+t/YNaqZyn0mCcJqwb6eJZ5q9z8Efoj4utPeEhT7VN4HddDRQ==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=e6hj/PvbW1Ah0z0WAifjhNCO7YVwV9oiSb5B2cu5OJU=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2127220571; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 23 May 2025 16:55:05 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anand Moon <linux.amoon@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Harsha Vardhan V M <h-vm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/5] rockchip: io-domain: Add CONFIG_SPL_ROCKCHIP_IODOMAIN
Date: Fri, 23 May 2025 16:53:38 +0000
Message-ID: <20250523165406.40915-3-justin@tidylabs.net>
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

Allows use of the Rockchip IO-domain driver in SPL to configure
the GPIO to match the voltage supplied by specific regulators
(e.g. "vcc_sdio").

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v3)

Changes in v3:
- Add depends on SPL_DM_REGULATOR

Changes in v2:
- Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig

 drivers/misc/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ffc5868c0dd..8b8f6309ada 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -114,6 +114,14 @@ config ROCKCHIP_IODOMAIN
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


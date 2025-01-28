Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B94C02192
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 21:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22EA81F71;
	Tue, 28 Jan 2025 22:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="Xm1U4vvk";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="EUc19vYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B3E81F49; Tue, 28 Jan 2025 22:39:29 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478E781EE5
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 22:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=Xm1U4vvk42TsS9tjcEAW5hEIwtzo5H7L87hkHJqrtn3e+lyLLn2a5zldBpc2N6kk/5dhqwU53m5kSmvnVo/R+T2Qz+TkkwLck5DxnyxeB7mTSXaq4Im9vKlFtSuGCzMjMLANcSNhS6m37BaT/YvIUfq0ia45DB5TWpBkzT2xffIe2jaJqpSkYU+UHwMH63fUV4/XHK6WFKDvzB1MtMqFb6yETBSDlkKsRBLoGtqP2RSxhXp11hstYnR51IYesWqd5o6YtVORO7koMB1Ex/ITxoZspBzGJWuMD3Pu2txfnb0VcWScXT3phGjgWFFmy/2f8OIl9hcSlL2Ac911FpSXjA==;
 s=purelymail1; d=tidylabs.net; v=1;
 bh=slTDxYHq7mEJiC9kZrRRmLt5x8+aLBUiYWJ3JeHkWck=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=EUc19vYW4X64kZ3xUAtyvjcnYexWlr/61ZyFJyfePvfQXu8M5I0lfxXEto7uaKiaWRyx5YzmBWVQWJoP+s1KvDrqZ0/mhX4kRfu0RP/j+gBHKVHJglaNsUjtzHxfMY6GIQYvr4Nk0Vrgd/9+mtDZ79YPLaOxKK8zXWa8LhmIP5ocZtRGFhEG0vNlW2qTLGPRXgcnQYy1GZsJ0A43HuxkLOQ1okJ1bvtrHw3V3iDuB5nT9w58PHdhnwBiteYer6mv1yqD8Nzeh7b6eIdbNMqxnLQWO0za0DV/gcTp6LH6hsN1Nk3dX3Q7WBtOB8toqS1NKv8SgsjoOIw/Spx86SsGzw==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=slTDxYHq7mEJiC9kZrRRmLt5x8+aLBUiYWJ3JeHkWck=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -499528210; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 28 Jan 2025 21:39:23 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v2 2/5] rockchip: io-domain: Add CONFIG_SPL_ROCKCHIP_IODOMAIN
Date: Tue, 28 Jan 2025 21:37:34 +0000
Message-ID: <20250128213852.465664-3-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250128213852.465664-1-justin@tidylabs.net>
References: <20250128213852.465664-1-justin@tidylabs.net>
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

Changes in v2:
- Added separate patch for added CONFIG_SPL_ROCKCHIP_IODOMAIN Kconfig

 drivers/misc/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index da84b35e804..ad935b81ae1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -110,6 +110,14 @@ config ROCKCHIP_IODOMAIN
 =09  for the IO-domain setting of the SoC to match the voltage supplied
 =09  by the regulators.
=20
+config SPL_ROCKCHIP_IODOMAIN
+=09bool "Rockchip IO-domain driver support in SPL"
+=09depends on SPL_MISC && ARCH_ROCKCHIP
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


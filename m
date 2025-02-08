Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBDDC0219B
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 22:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5336A809A5;
	Sat,  8 Feb 2025 23:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vETH6UAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A0F808E6; Sat,  8 Feb 2025 23:50:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4575B80840
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 23:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1739054998; bh=Fe0bG0acACZPPWf0XtlyxZO3tBFKJj4u41ugJfl7D3A=;
 b=vETH6UAdoad+bn6FFcXXREhIgqlqq4DnOZEkjcCopctyrKdR0KT+aC+vHjRP6lwUz4ghv6ANz
 +h7nCiGi87AdtQN1aPBzkXitBXTuqwWFGWWzam5RaapitpWUGVPC7ICcryjaqyR8tXmHWsc/nS9
 jnal0y5i6oerWrjze4ILhsjxbiWIcZLod+zy5SNBbOV6jYRqd+ZH0+pefyC7z/5K5+984YK8gCl
 ejnoDS78y+gpDeV75Psx22Gu4mH6Kw+vUa8AY9b2q8eZMJi/o8ciQ5b9EgIJvgPRXIm8WCPTG4P
 BXgDZ2Hj7U89HWa35AdE+Rm8qoIGqg8KnAkUtQJ6ZH/A==
X-Forward-Email-ID: 67a7df94771e645baa15e2b6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] rockchip: rk3399-gru: Enable TPL_GPIO for bob and kevin
Date: Sat,  8 Feb 2025 22:49:39 +0000
Message-ID: <20250208224945.2641933-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250208224945.2641933-1-jonas@kwiboo.se>
References: <20250208224945.2641933-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PP1500 and PP3000 power rails must be on very early for the U-Boot
TPL banner to be shown on debug UART.

Enable TPL_GPIO Kconfig option for bob and kevin to allow use of
spl_gpio.h functions in TPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This fixes a linking issue that otherwise would happen with next patch.
---
 configs/chromebook_bob_defconfig   | 1 +
 configs/chromebook_kevin_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 1b018ef4d7c8..5b8c0d35de6d 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -35,6 +35,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
+CONFIG_TPL_GPIO=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 1ee0c0e6c9d8..a29a04aaddef 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -36,6 +36,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
+CONFIG_TPL_GPIO=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
-- 
2.48.1


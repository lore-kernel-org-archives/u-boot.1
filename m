Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F0BCD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7603A849EB;
	Sat,  6 Jun 2026 10:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ekGEZg2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272B28495C; Sat,  6 Jun 2026 10:48:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF92084963
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A522445F2;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BD99C2BCB9;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735671;
 bh=amQjXmkE5+gqa/kjhdud58ltbnhr8g0lAZngcAPqXk0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ekGEZg2kfOou4reZpDREUK/4q1IIEyJs2RquSs1x0jypswALBuB98v+umzKuNCSlz
 2wTDEs2I2g7k0wADocrtjLUyJ5lb49AoHXv3IRRnUHa51H0YH+4lKia3jFi3YDl/cv
 OH/DKeC0OQpaAys0VguofFTGyH2YLd0yQPcbgmivPDD7hBYs4gbAKw4lDj++BUUVhE
 GxpKoZ2c4pBIPOdGLsCOX2gKnySpGYjGTcyMkt3eWlUzperOX4hWYzvFhBVyKojo5k
 Nlw4WvE5UA39j0hloXKmnxmaBmr1+BqJc1Rj/tCqaktznw4sbo1qtoNkhc6gA7S32A
 hay0Q9vKz/s9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 73BCBCD8C8E;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 18:47:42 +1000
Subject: [PATCH 11/11] qcom_defconfig: enable reboot modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-pm8916-pon-v1-11-170c9cbe5099@samcday.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=957;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=6f1OuGxeonujGdNlEVh+jzf0dFHrklDHSXYNPJd0nUY=;
 b=SchQyc/uCwUW+6VAAh/iwLzH4Zz5t7R+sJErLbjFAKI6460+mJ0LRYVOqig8ufvAcU6Lo7Ri2
 jD5Y9w9RNMRBL06ujbgesZLAkMam279shW8hP/+mPBqVzNtTbksUiNz
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Now that there's a PM8916 PON reboot-mode driver, it's worth enabling
the reboot-mode DM uclass. Additionally the newly introduced fastboot
support for setting reboot modes is enabled.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c7bc6829014..736a9424c3a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -80,6 +80,7 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x0
 CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_REBOOT_MODE=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_MSM_GPIO=y
@@ -124,6 +125,7 @@ CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_REBOOT_MODE=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_MSM=y
 CONFIG_SCSI=y

-- 
2.54.0



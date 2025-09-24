Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C6CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC0D83677;
	Wed, 24 Sep 2025 17:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="lBzWT9rF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3DB833E9; Wed, 24 Sep 2025 04:05:37 +0200 (CEST)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CC480107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sajattack@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1758679534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qwfziAvLCak5iQtzLYbg6LzitEoDdZoTukVQPN4Jfxg=;
 b=lBzWT9rFToAybbWrKlAM1u31oBYKFqjkgb72S0yRL39TJP2d2nh48Hh208fCq18k/zpGJc
 QklrImK+mbDkB/CvT38vgnNEsaIG+rehVPMr+dYQv/4lbRgMmtu4a+YnPX8HZBr7EjvJs2
 fAzhqdumyO55FudSVE4fmCIed8FG9yL7wIRDh6OqQYsK6h17mCaVK/vhSxzsj9V754tWbz
 7M8JrxeUzimLfZ43nLGEjbfd00+nj5ESvEJesxSC8wvdfkj8+A9TUSxTv8rYF6Xr7Eallq
 01on8EkONZJZ085VqLSgkxvVt7Yt8imllNxpQl6rr5+ovJvAsNrv8I80adLKWQ==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Tue, 23 Sep 2025 19:05:19 -0700
Subject: [PATCH] qcom_defconfig: enable watchdog command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-qcom_config_enable_cmd_wdt-v1-1-70cccf9f01e3@postmarketos.org>
X-B4-Tracking: v=1; b=H4sIAN5R02gC/x3MQQqDMBAF0KvIrA2YERf1KqWEdPKjAzWpSWkL4
 t0bunybd1BFUVSau4MK3lo1pwbbdySrTwuMhmbigafhwqPZJW9Ocoq6OCR/f8DJFtwnvIyMFtZ
 PkcGeWvAsiPr959fbef4AA6peQGwAAAA=
X-Change-ID: 20250923-qcom_config_enable_cmd_wdt-c31e1a5f2e2a
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758679531; l=1155;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=6ROoP5sB/ZaL2PGmLNOxxuR/k0rrHfE5cgLSO9m9+ts=;
 b=FA8z+UyL0aU8Y01nVhe8deAjIq3SyaEj/nQVNoOFrMcKW+VXl0RURlFAWXDy7DFTcQAzwWwa1
 0KXgLiPMaSwDjHB4aoJzdzh4RN4wVYziuF4h4SA+kIW5fTHlYTmVbVj
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:26:11 +0200
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

CONFIG_WDT and CONFIG_WDT_QCOM were previously added in
https://source.denx.de/u-boot/u-boot/-/commit/530764de9fc8539cd2354501e9c42804bc4c4dac

U-Boot and Linux pet the watchdog by default,
but it's helpful to also have the command to control the watchdog,
(CONFIG_CMD_WDT)
so it can be manually disabled by the user, for example, if the kernel
is expected to stall during debugging with kgdb.

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e7746e33f4385ca78c839b43319cd861..88595e5293418407dcaf1e7f8ee1b2b5f6bda4f5 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
+CONFIG_CMD_WDT=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y

---
base-commit: 4d84fa1261eb27d57687f2e4c404a78b8653c183
change-id: 20250923-qcom_config_enable_cmd_wdt-c31e1a5f2e2a

Best regards,
-- 
Paul Sajna <sajattack@postmarketos.org>


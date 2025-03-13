Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE38C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062B88191C;
	Thu, 13 Mar 2025 20:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893276;
	bh=WZXLKXMMSM+AA68rs6OuvdKYkS5l2FRe/NoWAjohDZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hty3cWG4Ykia40gRBFltRTbNJ7Gn+FV+SxK2EE6Px7iDDSNgefITjRM9/lPFFZ71J
	 5kPjtEpNU1hfOtx3vQLZWWdmf3nGi1s+EAKgWDDzSBaLrwmWj+cbBBSW86swjYCukG
	 Ya/e7lESB4xFV5jRuV/slPqKECUgmvu0tYTihr0lv1VjMnYs5/LSF73ddM6KSKFzN6
	 SGWw4yC0JwD6UCx9M0Z2DBIm8sHbs3Ja2CeXVl6VJkZ0N80qQ4CduejW0QHMNZObbi
	 gkStKkeBWzabPOBYjm8zJp5OjLR+QDqpifCuYywv4thyESVpL2P74trpNUNdYszg5r
	 7vXNca5QjNoQw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C20A9810E8; Thu, 13 Mar 2025 20:14:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B157381E13
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eP/nXCiK"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99E66101FF348; Thu, 13 Mar 2025 20:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893263; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=WZXLKXMMSM+AA68rs6OuvdKYkS5l2FRe/NoWAjohDZ0=;
 b=eP/nXCiKaC82+UQZbCq246ADteSHGQEGY4csCFn+oly9sJYw2+Jw4OpZGJzR9lTWJn3Ag8
 GfYXaPUDsvd39D0wwdHXeun5kB3/e2mrjr8wcegiH6TmCbdVL8zzyddiO6FkWrWanFJaGf
 rInBqXp5IsMFv4ENkbVWfxJ8yTLfZqAMfmMb9/ygyoVFbD3gk0M52rnVSsi7bs42hJRUK0
 WLHcbGcgILvCj8WxsSJX8mYPgKxFumtWZ93zP8w5J4H5WXtrhzOKEhpW6ZUENM7G5EogSN
 03XdEv9QfqUFEpo8NSl4Uq7xKfibczVwEteNdLGQjfYUf6FMxhykpsQtUxxJkQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/11] configs: sandbox: Enable exfat support
Date: Thu, 13 Mar 2025 20:13:26 +0100
Message-ID: <20250313191348.170054-11-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313191348.170054-1-marex@denx.de>
References: <20250313191348.170054-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Enable exfat support in sandbox and sandbox64 to assure build and
test coverage of this filesystem on both 32bit and 64bit builds.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 7960b2ef42e..1236ce474a6 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -267,6 +267,7 @@ CONFIG_WDT_SANDBOX=y
 CONFIG_WDT_ALARM_SANDBOX=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_EXFAT=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 0b3c765389c..87f21fdbd12 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -352,6 +352,7 @@ CONFIG_WDT_ALARM_SANDBOX=y
 CONFIG_WDT_FTWDT010=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_EXFAT=y
 CONFIG_ADDR_MAP=y
 CONFIG_PANIC_HANG=y
 CONFIG_CMD_DHRYSTONE=y
-- 
2.47.2


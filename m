Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1BEC28B28
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E65281761;
	Sat,  8 Mar 2025 21:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464988;
	bh=QFNgM+GgPFFgMYCIJYQKLvQ4FYBtpwGJdV/OW7vY86Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJhuDbDr1Ihic8LUsZ70xPLi9N9/UN1BM/g5X27/2u/RxUFEjiL7UfzlzZy3QZsNb
	 uOJmK6FgG6ktFmuPh0pMidJIxmu7zIpCQm3AXDp9jilnXOaYJOMOxbYG5Spmlxmz+z
	 f+SrU1vGziZbgDz2aWZNUDB6Xi2yCymjt0+3Rq2oY+HaK/IiD/RPomhA8hCvt4moyF
	 nYJE+9U0NyIVWT0O+ucUpGbFs/vSr/YC66R2OTaZTodSYbwPgC66eotKE7JkUxIaUy
	 X+cV33MmkZPCz09KwvhwDm/+Emj/IAZsQZdhOpslaF3bRHdM9j8NoVZ9UmixLOgvPz
	 wiXAoszU13dHA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F9C98175D; Sat,  8 Mar 2025 21:16:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A7581545
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Fd7B3TMT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9991B101E8802; Sat,  8 Mar 2025 21:16:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464983; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=QFNgM+GgPFFgMYCIJYQKLvQ4FYBtpwGJdV/OW7vY86Y=;
 b=Fd7B3TMT82iLIxVuoThT4uxn0w1Es66+ufR8lxrkjmUpCa1yJerbUe1sAByAE9Y59N5hdd
 mQDjPimY9L/JIALBX68AUCNVYkI4eKF3QIou6bYNhkViDF/+ah8uG2v3MBRF7qBm9z4cgZ
 UPw9Oyg3ewbrQRkapxgu/7ZDEMed8VwmA5lBRNsKgcZ0lE7TO3+FJ8292lW55nKb5SPlpN
 qFgoWl3/Ql8AnmE23xWo7fFrQWnmC85awY6AxQUw+rxOT+G6RHN/mm8d/8afQbPaOS97+c
 jqv2dGEybnmctSMdX1Xqi+KwP1ByubuV9QJ9IzdlORcLH9de6GnWx3Wl40r/jQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/12] configs: sandbox: Enable exfat support
Date: Sat,  8 Mar 2025 21:12:14 +0100
Message-ID: <20250308201533.1315951-11-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
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
index 7b35ad8a88f..cbffcb73858 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -350,6 +350,7 @@ CONFIG_WDT_ALARM_SANDBOX=y
 CONFIG_WDT_FTWDT010=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_EXFAT=y
 CONFIG_ADDR_MAP=y
 CONFIG_PANIC_HANG=y
 CONFIG_CMD_DHRYSTONE=y
-- 
2.47.2


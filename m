Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A22C28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A14A81A04;
	Mon, 17 Mar 2025 04:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181308;
	bh=uGsMTgJg1KIv8URSJDzi7OVydY3qJEKFfmiztYY9qCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wQsncuaI2hikKIB3/QxOwFG11UbSvnfMKLb5JUzw7ccl07Qohj8LRlVjg7aA2EJlO
	 7Guo3nlHzCAiZNlDv1UGEsVdjsnqrqx0IEwWptFZogB/tL3wc8eCC38Uww3GaG3u6b
	 mC/mFe0Cp2OTaB3MeVq2jPM7GCM5YDsG4T5IB/Dewe47T+k1wE3PcpSXQ5v49AyJ6d
	 K9kKXIhvB6Mr7hJMbhRWCvXYfAMfWTHf8RmGOqvNGQPkz82j5yfqHFzg3I/njptwkD
	 58NGVQ71BAutx13+AqLuMP8A4v2BqFyn1mxOgxSYKKjw/6VyotfIFiVEq50H8NsM/H
	 JdmQPjjWitrWg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98423801DE; Mon, 17 Mar 2025 04:15:06 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7E7810F5
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Bx+1l7cJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EDF19101F7A3D; Mon, 17 Mar 2025 04:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181304; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=uGsMTgJg1KIv8URSJDzi7OVydY3qJEKFfmiztYY9qCk=;
 b=Bx+1l7cJQ8lzPJ7/K7KnS8oeO7FrWUehNgkYSLdS9Y4IrGD9vVnqNymlBOhDjVtBLgQCT9
 RmoK14pLgdigOvVgVD/mnbNB02ufF0cMZEuqTssvtFIrFdoR0jN3EKoSH4Lpc96OpnFe97
 BhziHd5oPBS+R9K4R9zu9FOAt9NFccD1hmcNGQVnOKkdcg2x5zdc10w2htTIRD2upEB8Ie
 h/nFP7kYPN6zEsW/TqI33Ty8R+ks8D9ZmC0LocGjKR3UX8NX+S5U7h/ClHavKmHq6LYDb2
 MdgFOhisuShbxFl6kGaJO1qHVzRGAYIyTBR/fHzv5fq/vgCEd8CUWiylEocKFw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/11] configs: sandbox: Enable exfat support
Date: Mon, 17 Mar 2025 04:12:49 +0100
Message-ID: <20250317031418.223019-11-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
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
V3: No change
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57701F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05014844D6;
	Tue, 21 Apr 2026 00:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lWFWpSnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C250084485; Tue, 21 Apr 2026 00:03:33 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213CE844C7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3B48340D86; 
 Mon, 20 Apr 2026 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722608;
 bh=UsVES2WRDWRsaZU2s7OBoi8bSxA76ph0jeqfO8CKmA0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lWFWpSnnr9QHUaJhOINSvjYk7mZglyTiivwlC7lJGMW2BdnTUNCN4aIL2VgTD2kaC
 yTwqiyQvExGj5BhUKG1+MvNEBIfA7SLblaegmFuEAPUVz8nfQ/G3+/MFGn00VZnL01
 UBoax5hFTfCqAmQ6HYe/mFc2Q5fngHUltv0TNuCeWoQfclrCZCSHnPOplwKF7W0nXz
 /JvsXsoT8b6okebyx01Tbvyr1F0WLduOKMdqivUAGh/m9UYTIXFFGYgO7NvoFphBdy
 o8318pJgLNlNuieT46sUeRtk8rq/YEy3mXo+QD5WXoSn47SkRELLaVYpkcGr+Fo5I9
 LTkbsOv7lfOyEACP9fZZRDGALD82jAOohyAf9+9401KHexJRCpGAn3JQ6lERvqfR0K
 ln7tBNo8zJ9bz+RTRACopEkO7/30yBA6+yoU31uuQepdrFWQCX/McbrTkXccqyCwuX
 sXe4/dF3aCdt9zIvghv6gGOfXOslfY3tX3/6S0IlGaayTg+pl0jcasXrCdh+GjI8fU
 1FxCMaybfqxCjB51axOtJrSyrKlzpwBmClC1YOymIbEP4UhfYOlF5pX2OmTHZFx/F+
 UHKiugmszTqkKgDfN9efnDv5T5IPsl+mIf+P/QhDP+ii/ilnYy+2OXE5/B/yiyoNi8
 580toXMpvb4/L/bQoaSgr7uw=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>,
 Ying-Chun Liu <paul.liu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] efi_loader: correct efi_binary_run_dp() return value
Date: Tue, 21 Apr 2026 00:03:20 +0200
Message-ID: <20260420220321.71147-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
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

efi_binary_run_dp() is expected to return an efi_status_t value.

Reported-by: Simon Glass <sjg@chromium.org>
Fixes: 6422820ac3e5 ("efi_loader: split unrelated code from efi_bootmgr.c")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/efi_bootbin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b394f0d60ce..144266b785f 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -227,7 +227,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS) {
 		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
 			ret & ~EFI_ERROR_MASK);
-		return -1;
+		return ret;
 	}
 
 	ret = efi_install_fdt(fdt);
-- 
2.53.0


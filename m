Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35002C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C0184AA1;
	Sun, 19 Jul 2026 20:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Bpqn8kxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E3284A29; Sun, 19 Jul 2026 20:04:11 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3D884A4B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7dbcb505578so57975377b3.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484247; x=1785089047; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mWN9pmr7vz8H7nsn1WbxcWQeC8EikMbPM1nKJYcRrWQ=;
 b=Bpqn8kxCbXLP6ihTuEfitMOPTIxuuRpVzUO8fLnx1sTb5SVnIFgsW8RDxF7npOFDdW
 /SIIvFF12Pn9SRunYTOJyeKp13AkxgS8XOvFD4wI71uAI/vrRTHLGDYDRLWixe271DI+
 K6uWLYUFoKVRAjOqJTw51H8FazevWwtf8q24OO+iIm+JkNV214blqzdDwIc/2e9MAQUR
 F7lurnSEPJappgzBFjpFDjE6497RbHMWqOIiR6tPPK2+fQsjL7xTLjn/LYw64kRA5QYI
 81pLPaWn5YGoO2vO9nLeTgrGThox2Bhgx8wpWpD4Cq9pk+oBuG/J43WxvHOK7SUOEglR
 goiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484247; x=1785089047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mWN9pmr7vz8H7nsn1WbxcWQeC8EikMbPM1nKJYcRrWQ=;
 b=XYQH13+3uv0IXfOnYzoBV4sML0lC/X4IQznUnLAph8H7Vx/waMKS63r9zZOC3t27wT
 JotUA0119QljdJVpgMv+r+hrPTnw1ZEKI3WMG3a2sRG7X0bAT9232PSDp/3Plo/j/2wg
 6rZ7fw69cIgey36N0XUNVwvzb2eBdhVapDgkD+xiCvUDSW/VprU3VIWivG9HwxGP5LnS
 hLvjdg8rFpx273mQh/rCP1+C0iMPSwD7RVcUe40AOqBje5oBwjahWiz+B29YrJoDvYLG
 2HMM5iWllD5Zb+GGWmnMLFQg6n0vSUpKkvjnn9ZZS622k6yxTYjmFcBtD1mMZXzrij89
 g2bg==
X-Gm-Message-State: AOJu0YzFyov70tmTvWQcuAbiqjyEm3EGBidMJf1m9EdroJQPEcx+T23N
 DB3y2YoldAmv8qOCmfwk29DfMz/D9CMWM8C1OxT6T3BO49NeeZd3P+j2QdoqyRbvWKY=
X-Gm-Gg: AfdE7cnnidOQ4LtqkKHl+7Cwid8axBBGrs/tY175jm7H1xbvpoDN+47xbDbCcMjFxUe
 HlV8VPDyhsWGkgOph2ujOH3r1VnO/JnnF39i1WQRc0HR6wBo+tOJBUWh8Rurnhcx2fiAEpUIeAC
 E7mQCUMALRfbvRY2ny9jKv+roX1mvF22VqNd88ZyLvldukUQb/cJZl1lCTVTU48r0XHrnhTp69l
 b1be2kOT8RHFwHV0/9BFa7O9pOhYzt59ZfAWBgxxTdFWxHtxcG5KF4yimV8ztTX/p6Jh/86JL+d
 XIjZvD9BUJYD1TqnR+UecMf9Cbj6GmDDgc/OoDKUppgqRbQ2vq60GBIbrXj0pCIcVlfu7x3YGCG
 fpYVIuSI8kPD6kEmeEkB+SxQOXuvVf0sMMqUgjSB65/H1RRN1t6DTNC6BrgG/MfQHcc67rIpbG7
 LW5LtHfsviGXE3EACPSjszVXvts8Yu40SVQ42MtIBm1+gkvDCF0ttNoA==
X-Received: by 2002:a05:690c:6107:b0:81e:6d9b:154c with SMTP id
 00721157ae682-81ef2604973mr35398277b3.55.1784484247254; 
 Sun, 19 Jul 2026 11:04:07 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:06 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:32 -0500
Subject: [PATCH 1/8] bios_emulator: select X86EMU_RAW_IO only on x86
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-1-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

X86EMU_RAW_IO mode can only be used on architectures that support port
I/O like x86, so don't select this for other architectures.

This was also suggested by Tom Rini [1], but was never added in.

[1] https://lore.kernel.org/u-boot/20241117025353.GA3151182@bill-the-cat/

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bios_emulator/Kconfig b/drivers/bios_emulator/Kconfig
index 3660576772d..5afea87a2e4 100644
--- a/drivers/bios_emulator/Kconfig
+++ b/drivers/bios_emulator/Kconfig
@@ -1,10 +1,10 @@
 config BIOSEMU
 	bool
-	select X86EMU_RAW_IO
+	select X86EMU_RAW_IO if X86
 
 config SPL_BIOSEMU
 	bool
-	select X86EMU_RAW_IO
+	select X86EMU_RAW_IO if X86
 
 config X86EMU_RAW_IO
 	bool

-- 
2.43.0


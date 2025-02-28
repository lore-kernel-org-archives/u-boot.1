Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ED4C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7848B810ED;
	Fri, 28 Feb 2025 13:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dr+d6a5E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PVYnPJw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D34C810FE; Fri, 28 Feb 2025 13:04:12 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C27C809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z46Lx6PfDz9syt;
 Fri, 28 Feb 2025 13:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740744249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/O3Ps/jHgEIAepTY5W4VxOvYvSdsESTeWR62fNUrEEU=;
 b=dr+d6a5EwnSQ51MfMDmjERK2YFaIgOuXW4qzdFayXHimEKx60+26CDNXKyH1/sdpRXInZN
 vRuekw5vWTpCdyo0S9FAILTOMIcU1zOq2kq48xjGxOdnUc0K4K55Xml4u1pnXWkiGmzE+k
 Jx2416O8BTojUTX0f3H+CPF2KcQBXE8LFLyCgk9RbIFJBuVRb/tMWBc1l3P0/YPQlddpVu
 Apv3TvRg4QefMj6DMUtjwQslCtotmfrmjU6Rc4j3wmKUwKHx5mOSt40Tq7a1QhAbmzPph7
 3tQMaLPN7TQsodfEEu/YYPhVbrt/hGkJ+PVgXGVYk/NfSDhsJUJzWt2OmU3kjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740744248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/O3Ps/jHgEIAepTY5W4VxOvYvSdsESTeWR62fNUrEEU=;
 b=PVYnPJw1jjSFR01M4AtCrP2QTkeU9W0ZvHhiyGjIesPTh1NUGtlSeoAtUeOPlpVApqpQSr
 JpGZ+mp598EHNKSOlqElOEpZDWi4u9XApdex+Q+E6gMjJCnt5m3GM/wCICvhOd3EzRb+hH
 croAE40kbR9/wf58FNxixhFiIeh3cO1kcsIt8P6BWV83CMCjdrPuCbz16GzKEdtF3P1INW
 xwShK9BSO/m3TZ6hPb30e3FlySAlGCiTTKpGnCqSn8IRzoarjYf4sOTq2CXdVahblkDCnl
 RRhnQhDexJHFmXBuZQ9lnb8qxaSbGIDvdVvdWHyWc4Lx1UzxgSD2H3h5AkDJkg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] pinctrl: renesas: Drop special RZN1 entry from Makefile
Date: Fri, 28 Feb 2025 13:02:52 +0100
Message-ID: <20250228120354.38997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pcunnjty98ug8bekmrnwg34c61ose9zb
X-MBO-RS-ID: 296ee4ef0941955c0a2
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

The RZN1 symbol name is CONFIG_RZN1, there is no CONFIG_ARCH_RZN1.
Since RZN1 enables CONFIG_ARCH_RENESAS as well, remove the special
RZN1 entry from Makefile, the RZN1 pinctrl driver will still be
pulled in via CONFIG_ARCH_RENESAS.

Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Drop the Makefile entry entirely
---
 drivers/pinctrl/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 634047a91f4..5e76c860727 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
 obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
 obj-$(CONFIG_PINCTRL_QCOM) += qcom/
 obj-$(CONFIG_ARCH_RENESAS) += renesas/
-obj-$(CONFIG_ARCH_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-$(CONFIG_$(XPL_)PINCTRL_TEGRA)	+= tegra/
-- 
2.47.2


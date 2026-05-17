Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F246CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BC2846DF;
	Sun, 17 May 2026 21:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="eKsW38nS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C3E8466F; Sun, 17 May 2026 21:25:08 +0200 (CEST)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A3E8465D
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id BB720C009E;
 Sun, 17 May 2026 22:25:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-eb68QLvq; 
 Sun, 17 May 2026 22:25:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045903; bh=5CRIIZs/2nTEK5TG5ua38aLnRifkp5pjvqavzkMx78k=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=eKsW38nSjPVE3MLRxClZXvvdXA/zdHeCuSP1IUCXqU4j8R3Hva8l2aW6RtCCNFp5a
 ZSbofaMtT4vueg39bYGkhCD51XQQ4mm5oSaUD0nF4xCvEcgjG7Dqkt5azdz1NkNY5Z
 A92Q/3aXeozJ0j6fMWFGPp12Cis2ECRzD91XT6x8=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:36 +0300
Subject: [PATCH RFC 10/18] ram: rockchip: Add missing bits to common code
 for sdram driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-10-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

Add some missing macros used to retrieve SDRAM initialization code
configuration from global info. Extract PHY and DRAM ODT enable masks
to separate definitions.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 arch/arm/include/asm/arch-rockchip/sdram_common.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/sdram_common.h b/arch/arm/include/asm/arch-rockchip/sdram_common.h
index e53e5a9ca58..84fbbeb8d8d 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram_common.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram_common.h
@@ -45,6 +45,12 @@
 #define PLL_SSMOD_SPREAD(n)		(((n) >> 1) & 0xff)
 #define PLL_SSMOD_DIV(n)		(((n) >> 9) & 0xff)
 #define PLL_SSMOD_DOWNSPREAD(n)		(((n) >> 17) & 0x3)
+#define DIS_TRAIN_PRINT(n)		(((n) >> 19) & 0x1)
+#define DDR_DERATE_EN(n)		(((n) >> 26) & 0x1)
+#define DDR_PER_BANK_REF_EN(n)		(((n) >> 27) & 0x1)
+#define DDR_EXT_TEMP_REF(n)		(((n) >> 29) & 0x3)
+
+#define DDR_PAGECLOSE_EN(n)		(((n) >> 3) & 0x1)
 
 /* sdram_head_info_v2 define */
 /* for *_drv_odten and *_drv_odtoff */
@@ -69,10 +75,13 @@
 
 /* for *odt_en_freq; */
 #define DRAM_ODT_EN_FREQ_SHIFT		0
+#define DRAM_ODT_EN_FREQ_MASK		0xfff
 #define PHY_ODT_EN_FREQ_SHIFT		12
+#define PHY_ODT_EN_FREQ_MASK		0xfff
 #define DRAMODT_EN_FREQ(n)		(((n) >> DRAM_ODT_EN_FREQ_SHIFT) & \
-					 0xfff)
-#define PHYODT_EN_FREQ(n)		(((n) >> PHY_ODT_EN_FREQ_SHIFT) & 0xfff)
+					 DRAM_ODT_EN_FREQ_MASK)
+#define PHYODT_EN_FREQ(n)		(((n) >> PHY_ODT_EN_FREQ_SHIFT) & \
+					 PHY_ODT_EN_FREQ_MASK)
 
 #define PHY_DQ_SR_SHIFT			0
 #define PHY_CA_SR_SHIFT			8

-- 
2.25.1


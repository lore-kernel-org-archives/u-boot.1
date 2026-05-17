Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B2BCD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB86846AD;
	Sun, 17 May 2026 21:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="Zx+BaDCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43BB984693; Sun, 17 May 2026 21:25:01 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308BC8465D
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id D786680707;
 Sun, 17 May 2026 22:24:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-1BKvp3ne; 
 Sun, 17 May 2026 22:24:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045897; bh=MxZMCsJCvxKIFwRMHp0Bq6fOTGBw0W8U4AhEwQJD300=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Zx+BaDCqNkSqIMHRQ3AGxmmUOtpGT6NNS0naTUQ6POk+iLuIWeDqf2Lcs41suLvXG
 24FsVLCaU2PGH6s+DfxkiNTetZjKaYxsdvIePLZKGae+iSRgLE7A5RwJI/AyYJTx5D
 oN5Jy/RfhSpqxoSltafdKe7Lr20osa5sMDmVmcZ4=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:31 +0300
Subject: [PATCH RFC 05/18] ram: rockchip: Update ddr pctl regs for px30
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-5-a24e16302a13@ya.ru>
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

Add RK3568 specific bits.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 .../include/asm/arch-rockchip/sdram_pctl_px30.h    | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/sdram_pctl_px30.h b/arch/arm/include/asm/arch-rockchip/sdram_pctl_px30.h
index 3780dc6ea5b..62ea55df744 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram_pctl_px30.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram_pctl_px30.h
@@ -37,6 +37,7 @@ struct ddr_pctl_regs {
 #define DDR_PCTL2_RFSHTMG		0x64
 #define DDR_PCTL2_RFSHTMG1		0x68
 #define DDR_PCTL2_RFSHCTL5		0x6c
+#define DDR_PCTL2_ECCCFG0		0x70
 #define DDR_PCTL2_INIT0			0xd0
 #define DDR_PCTL2_INIT1			0xd4
 #define DDR_PCTL2_INIT2			0xd8
@@ -127,10 +128,15 @@ struct ddr_pctl_regs {
 	((0x1000 * (n) + (((n) > 0) ? 0x1000 : 0)))
 
 /* PCTL2_MSTR */
-#define PCTL2_FREQUENCY_MODE_MASK	(1)
-#define PCTL2_FREQUENCY_MODE_SHIFT	(29)
+#define PCTL2_FREQUENCY_MODE_FREQ1	BIT(29)
 #define PCTL2_DLL_OFF_MODE		BIT(15)
 /* PCTL2_STAT */
+#define PCTL2_SELFREF_STATE_MASK	(3 << 8)
+#define PCTL2_SELFREF_STATE_SHIFT	(8)
+#define PCTL2_SELFREF_STATE_IDLE	(0)
+#define PCTL2_SELFREF_STATE_SR1		(1)
+#define PCTL2_SELFREF_STATE_SR_PD	(2)
+#define PCTL2_SELFREF_STATE_SR2		(3)
 #define PCTL2_SELFREF_TYPE_MASK		(3 << 4)
 #define PCTL2_SELFREF_TYPE_SR_NOT_AUTO	(2 << 4)
 #define PCTL2_OPERATING_MODE_MASK	(7)
@@ -150,8 +156,11 @@ struct ddr_pctl_regs {
 /* PCTL2_MRSTAT */
 #define PCTL2_MR_WR_BUSY		BIT(0)
 /* PCTL2_DERATEEN */
+#define PCTL2_DERATE_MR4_PAUSE_FC	BIT(13)
+#define PCTL2_DERATE_MR4_TUF_DIS	BIT(12)
 #define PCTL2_DERATE_ENABLE		(1)
 /* PCTL2_PWRCTL */
+#define PCTL2_STAY_IN_SELFREF		BIT(6)
 #define PCTL2_SELFREF_SW		BIT(5)
 #define PCTL2_POWERDOWN_EN		BIT(1)
 #define PCTL2_SELFREF_EN		(1)
@@ -159,6 +168,12 @@ struct ddr_pctl_regs {
 #define PCTL2_SELFREF_TO_X32_MASK	(0xFF)
 #define PCTL2_SELFREF_TO_X32_SHIFT	(16)
 #define PCTL2_POWERDOWN_TO_X32_MASK	(0x1F)
+/* PCTL2_ECCCFG0*/
+#define PCTL2_ECC_MODE_MASK		(7)
+#define PCTL2_ECC_MODE_SHIFT		(0)
+#define PCTL2_ECC_MODE_DIS		(0)
+#define PCTL2_ECC_MODE_EN		(4)
+#define PCTL2_ECC_MODE_EN_ADVANCED	(5)
 /* PCTL2_INIT3 */
 #define PCTL2_DDR34_MR0_SHIFT		(16)
 #define PCTL2_LPDDR234_MR1_SHIFT	(16)
@@ -183,11 +198,16 @@ struct ddr_pctl_regs {
 
 #define PCTL2_MR_MASK			(0xffff)
 
+/* PCTL2_RANKCTL */
+#define PCTL2_DIFF_RANK_WR_GAP_SHIFT	(8)
+#define PCTL2_DIFF_RANK_WR_GAP_MASK	(0xf << 8)
+
 /* PCTL2_RFSHCTL3 */
 #define PCTL2_DIS_AUTO_REFRESH		(1)
 /* PCTL2_ZQCTL0 */
 #define PCTL2_DIS_AUTO_ZQ		BIT(31)
 #define PCTL2_DIS_SRX_ZQCL		BIT(30)
+#define PCTL2_ZQ_RESISTOR_SHARED	BIT(29)
 /* PCTL2_DFILPCFG0 */
 #define PCTL2_DFI_LP_EN_SR		BIT(8)
 #define PCTL2_DFI_LP_EN_SR_MASK		BIT(8)
@@ -197,6 +217,8 @@ struct ddr_pctl_regs {
 /* PCTL2_DFISTAT */
 #define PCTL2_DFI_LP_ACK		BIT(1)
 #define PCTL2_DFI_INIT_COMPLETE		(1)
+/* DDR_PCTL2_SCHED */
+#define PCTL2_PAGECLOSE_EN		BIT(2)
 /* PCTL2_DBG1 */
 #define PCTL2_DIS_HIF			BIT(1)
 /* PCTL2_DBGCAM */

-- 
2.25.1


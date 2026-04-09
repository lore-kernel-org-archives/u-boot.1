Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E42DF364B8
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C6A84207;
	Thu,  9 Apr 2026 22:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Dc/d+aEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D4983CF5; Thu,  9 Apr 2026 22:32:03 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111B884105
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46fb6d65c28so524923b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766712; x=1776371512;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=REtHP4HXTTdrcW5eTixJnqRZv7uJJY9N1GnHuBAmNUM=;
 b=Dc/d+aEBjrNpt8yEXqAe1gebwKFpBY0Ser0Gd9/FRW3u9dIdF8Y/bUTbxvoTpDROPF
 S26Nvy0N1rYa3TM/qrFel1cVCB6KKUrRcIXoJRccPshXoQE1uqqyWlQVpDhxOuBtqpUN
 SpszWq04ynSjC9flxu77t7qFC3zSHQprF/puEvI38cCZdtAJZX4OxcaA0Gi9G//VaW7M
 TOryGTZinNqcYQCW1kPV8TRo4tJNCeyJg5+MvsfXrqkXFrBSxhKzVh4XMJMwhbj7/Idj
 Qkcqe+2nfhnjvtkYoKhyY1smVEjYdQz41XqU2RwzprqHWH4NMDR/Zj9DxxX7d5Ht3rFr
 HCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766712; x=1776371512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=REtHP4HXTTdrcW5eTixJnqRZv7uJJY9N1GnHuBAmNUM=;
 b=Rgiyb6EuX0wpgFmwbVBjbrHPfTQTLz6y7bEUVvqvJX4fmG4EqZwCMw3ABaloUROpY4
 JwhedlAfMKB3b157WFK5kkkJQ3MEhXJUEdXlzRFrmE/ipu4O2IsWZel07vZBJf6X0gMx
 bUGrJvj/c5La8OlXKOw56SIkxiP3oxd2amsJPKMIDdb+yN0cfVzLKo0vDf0OV47OKHiH
 YSlRukm/yS+mH9p4yP5K8o8gCgGMc8mmzDBFMKmOCOJDKV3+5kBlHPqD+cePPrqHtJgB
 nn9/ISG4rCKn+ryidiNx7XnFblkbygvEK/gGrtlA6moUX+O0rSuE71eVu+paxTz9Y9ab
 A0MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1oW47E4SMbzb3bxh8n40ZfSekHVjaU8pbutkion8aYzIU/w4x2Ln1+JPFXQmZSmdlWMjj9kE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu4LFBQ9mqbcuQbKqbyc8xzj0prfnDs/Ls+E5FbXdq9e902L6j
 yiUyfWnMe3IZd9pE3MfeScTNffjJG7yU3BDZgHxcPCBch/1Sv8mAlwS+wpFQZmotD7E=
X-Gm-Gg: AeBDiesxuCJH9QValy6ZCacUKl1HKKFBVpB7Rz0vKdeqitvI+sMv/J3pDbZiJovKTPF
 t5GSWQf43/g3J2fSrwTKQvMTHY9YyiRxxuqysIPs0zA23YiL0ahs8Rsh5h/2VnZwtTyPeS0aIeu
 ck5e0i2kCuOfUIxOk5HUI0DAPGHl/qeIni7CF1PvoNLEHK9nLGaWH2xoxTAK/kDxcr8IZiUsPyi
 +mwU9NpLITOMcZ9kVN1QQqyNXCUy/nXyuvfADxZVxWH5NyIiX19KFrmNToEV7BVN1kutxAjG3kc
 xKdBUSa9tAYaKZVVugVSHEgIun7XdxtvqQxCv4e6rOXeLAcbbW54cIiSHtQdQA+N+GDdrovj5yb
 EblRhrI50fUJsb6trl0jVO6eTZ74jl7OpHlL/kPuSijEJcHoW1K38ZdLmyHhvL+BDT0fyjI3J4y
 XnRaEthUFyzOTAgXLM1SJUIgTyq8yn
X-Received: by 2002:a05:6808:3096:b0:467:db5:8b21 with SMTP id
 5614622812f47-4789ab812f4mr375141b6e.0.1775766711717; 
 Thu, 09 Apr 2026 13:31:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:34 -0500
Subject: [PATCH v2 2/8] power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-2-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2lvJVhfGp/yo3OXiCpcwVtZvhnSasMbjw4S0ciI1nQQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2AyDNhoSIQc0fmLQ+NoA6YYhbU5DEbWPpASgW
 Ar4xK8efdSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMgxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApDEH+wWcRdeXLv2oIsSyh/QIrt0UDWnKJxQ9YvEvsJW
 8XkhrTcF9M8IzCqAj7IfNEIbn2pgn4rYP/6xMFq2H0inAi0mDqUfz1ZtCW5ia8ivfIdv68BjG7a
 aHYgKsPxLAC6NlxTRf5guAkOg8wC3pjcGqMGPgEiykVbpE7JBph6KipeMIG7TzpaSeWO5bojAfN
 PwayYc7FHxxEMWc24iizoA8vcweAiZT+IeaiFb+rRsWdceE6xL822gssLOdE//spYPPjQw/z9a9
 bwdAbf37zXOa/dTTvREMJumuYOWdu9lmQs2Y2C5VIE8WITKR5yZliVg6ymaBjEh032lvypqNYh6
 V4bk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a PWRAP_CAP_WDT_SRC flag to indicate if a PMIC wrapper has a WDT_SRC
or not. Then use this to conditionally enable the watchdog timer.

Prior to this change, since the register was not defined, it defaulted
to 0, so the wrong register (DONE2) was being written to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index f4dfb48e93b..3ed21dcf2ef 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -60,8 +60,9 @@ static const struct pmic_child_info mt6359_pmic_children_info[] = {
 
 /* Group of bits used for shown pwrap capability */
 #define PWRAP_CAP_INT1_EN		BIT(3)
-#define PWRAP_CAP_WDT_SRC1		BIT(4)
-#define PWRAP_CAP_ARB			BIT(5)
+#define PWRAP_CAP_WDT_SRC		BIT(4)
+#define PWRAP_CAP_WDT_SRC1		BIT(5)
+#define PWRAP_CAP_ARB			BIT(6)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -755,7 +756,8 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	 * Since STAUPD was not used on mt8173 platform,
 	 * so STAUPD of WDT_SRC which should be turned off
 	 */
-	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC))
+		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
 		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);

-- 
2.43.0


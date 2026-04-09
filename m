Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29716F364B8
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9909B84106;
	Thu,  9 Apr 2026 22:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mioGa8ur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F7083DC9; Thu,  9 Apr 2026 22:32:11 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95568421D
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4670676ba03so513508b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766718; x=1776371518;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B59owVGMhDtPxM+PIrhPmg05Qfua3FmzdcXaoyMLa2c=;
 b=mioGa8ur3tV8wQNWtH58BuCVtU4Tf3pJ0MF+sov7ItJUwR3ZfT7oiI2/kWDK60jed/
 9g1/0cTGA/9OeO5HKpOq2/tHXFFVqLLGZ+c6zip4qmbJkPyNVphioUa1rZjnJX+LPMXb
 sr2qOFyoGY2MTW9fNSAxE/pFtTccwKGp575MgTHPxOcFdpdmruQZusQbSbyBDkF5mb83
 yDeSnQHLnPclfAtYFsxs861Egb0a4bzReHWESpZdTgyjnmE4CK4M33sJOwXNYyO5WunE
 A0xT+Id+BwCjpgOBitWkWV/sJNL2D85Cyx0biTecn6cs0oYgPDHbkQ7RPamsn0N/ck6u
 eh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766718; x=1776371518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B59owVGMhDtPxM+PIrhPmg05Qfua3FmzdcXaoyMLa2c=;
 b=lKKkWBHaemijucg1emn+KIRS72RokF0oRhAkLFgLQI41po6FpN/I3/xoC2QY+ZvVJF
 un9wn8EEY4qPIcEebz7qbe/X3H9A02yHbJssJnEUZtXuOlPIPwwIJ1XDFvxydQ2bUuWW
 GdgL1AsW6VGUH7EL+WYHWymKIF0qyC0y9eeRTiVw67jjaFMUxveljiWAUjKPRbxeJt/3
 J666DkrkDXCh4ZJNvZiwSFvmfOTYbqelOTLNRB4WiS2qpX1L1B51t2JnFybqa2XO2IyK
 PYKl9+Ncjq2OY4q9gAEwXB849gBUHMc6e6l493aUyCXqJ+yxnkJ9jwHbIgHc7k+MgsW9
 SPAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzgJnSEa7Ho0ugRGsCx+u9hGCCsoHMmTO5UtSvlwjAzs2MFoGij+pXwNM9YUhdbdO/WXGmUEI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2Va9D9WOq0FAkQo7GlkxiH0OXCbPKZAbaOmJT+8MsYmUTQCab
 I0K6gqTbWW5P8I3dXP+PsI81GlOatF8/BQfnQsCVMPgz/RXPf5qVeC2P6TpYhbD+yEM=
X-Gm-Gg: AeBDiesdqhwWMyZYryWSRiDLqjCcyGwuy4iOd1JfZWrBuBJa829N8aadOqKn3rTOlGa
 etKuGmC83FN9VUV2zH9n6Wmjfot+X0hIqaLKW77K875aQIM6QVM7UsbysU4kG46QXaOn3+weFeS
 4cK27L0QhHBqrSDNUNtz8L3Bhnydb79y9fpN0gcpZCY6WYea6F7WDT14rMpCEJ4IVGoNbRtudNO
 X8x7MbIrJFgZ8BemhVTBt9E5BIBvz+2Mxdq8aymgfDJOG69fQOJOA61WrBtP27MsyNvPV2xzecH
 5zcAz18et5dpIj/g1+jU53NhovHNNAuXNnLWEFFIUxtg7Oo12Z14L3DIVPvqoK+eMHAqGJm0zri
 11VQIxbE9VSSOXOEm54FmFRNuzAuO7vuuSI6ZVBDKF3LNNej4GonLfmGbDyqMHyJR+4QUVww0MZ
 YVO+oMc+d8fn6B97sXOYj+Mw5TszYI
X-Received: by 2002:a05:6808:e8b:b0:467:ee:7a2f with SMTP id
 5614622812f47-4789fc08fdamr365399b6e.28.1775766718322; 
 Thu, 09 Apr 2026 13:31:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:39 -0500
Subject: [PATCH v2 7/8] power: pmic: mtk-pwrap: use tabs for alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-7-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=jw4QHidYQ1i0FNQShuNY+39UIwQO5POPmNcER/g+On8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2Aym5/41Djj8uabdW8oF8u/fV0SS/8DNzbCDa
 Xr3q72iD12JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMphYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AonQH/AjMH1b68+OwUGs+D8A84NYuxvvTH4EjnQzKtFg
 RRubDlEHyO2ZU6nv8IsPRL3fQz+VrPZc0KOvbheJTLIPihsoTi09H+JJBafy4OF/2AiU3OO1BuC
 NTmqYCyK1/LNmRhiQ2mR5xNpE8fzmEToq51fXiiA8sY/VbJ1TLyo4ENifze3Oc5FWqUxBvmFHFV
 JCQ2jQdjqfI3CRl+ukRQKVf1oTRDzWbLw0uWAMzCwtl4k5Bdmjs4StpgDJWIVuia9edrMPLTN3+
 VIkYLTRLEkk80KOnmTe2UooBpEQ8ze5i+oIiscnTUKpigKH0Oe1S05EyiZQ0iHq60ruOT6o/61e
 4mVg=
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

From: Julien Stephan <jstephan@baylibre.com>

Fix mt8188_regs definition to use tabs instead of spaces for alignment
to be consistent with other definitions.

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 7d84ab1f6d3..b05c6b88157 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -252,20 +252,20 @@ enum pwrap_regs {
 };
 
 static int mt8188_regs[] = {
-	[PWRAP_INIT_DONE2] =            0x0,
-	[PWRAP_STAUPD_CTRL] =           0x4C,
-	[PWRAP_TIMER_EN] =              0x3E4,
-	[PWRAP_INT_EN] =                0x420,
-	[PWRAP_INT_FLG] =               0x428,
-	[PWRAP_INT_CLR] =               0x42C,
-	[PWRAP_INT1_EN] =               0x450,
-	[PWRAP_INT1_FLG] =              0x458,
-	[PWRAP_INT1_CLR] =              0x45C,
-	[PWRAP_WACS2_CMD] =             0x880,
-	[PWRAP_SWINF_2_WDATA_31_0] =    0x884,
-	[PWRAP_SWINF_2_RDATA_31_0] =    0x894,
-	[PWRAP_WACS2_VLDCLR] =          0x8A4,
-	[PWRAP_WACS2_RDATA] =           0x8A8,
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_STAUPD_CTRL] =		0x4C,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x420,
+	[PWRAP_INT_FLG] =		0x428,
+	[PWRAP_INT_CLR] =		0x42C,
+	[PWRAP_INT1_EN] =		0x450,
+	[PWRAP_INT1_FLG] =		0x458,
+	[PWRAP_INT1_CLR] =		0x45C,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
 };
 
 static int mt8189_regs[] = {

-- 
2.43.0


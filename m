Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41E3CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DDB984A48;
	Tue, 23 Jun 2026 15:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h0Z4n1MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8461A84A2C; Tue, 23 Jun 2026 15:22:37 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A67B849ED
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso38990865e9.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782220955; x=1782825755; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XPIuf3aeuSgL2monyfUCi1aJow67ShsME9iLAP6rv1g=;
 b=h0Z4n1MKJGfrlieDQP9NwMVy5U8c1kxeE/FZaoyPEB6qM86MDy9HxlAvfIb2TiQc58
 Wv+m0fJJ/GDAB5EJvbMZLRr0fwAvlOIvNPlz38Td+JdXhERZDgCOwIYbX7WQuHwDcL7k
 ZJQ3XWBq6mzol9tV1I13vzXMBMc7t29qA9AyPlRc+obVObeibUcJ4vjXNZQ4EefULCPK
 mMaf60YX7FJa8xn2+DSmWvdmOlSfaFhQxkYiYHR6atTXUFa4oeQmD3ttbGmnJqCj27iu
 lk5+EM5fmSC1E11vPnvHrumRGrVDxq2nRe9nDHitVN9sMCxsHKtJ8kbmYlZxyNuHMchl
 2uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220955; x=1782825755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XPIuf3aeuSgL2monyfUCi1aJow67ShsME9iLAP6rv1g=;
 b=pWQlWTe5F634yRbqZ3byo5Yk8d8IovvpSudDlk89FajhAR3He5NyL8rRUb+03UzeXG
 VVmgerPwX5meLOTH0ZxBbz5+UjyjsW6zE1y9g5DxxrS9mMy6LADmKj2cmEZeNmeq7IFM
 45XOwSGVvRwgq1+gydv6VrREq8i/tsE1wehVKZQapw8HeChvQxpYVsCeGp8mN4aI9DHn
 CB8JOfjChVbQYAWdaoDIsbDKIV83NLA+0pTVF9owOZjNSUpdjE56IAFepLQYjWkWYoLx
 1x86Y+CrW/6ml4BJrnAQ8/WxCO9rWzyqCO98MvyL5S3S2xy6sL8knxvjXQVs/W/6Kn5G
 Mv9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lQBSJz79Q/8Hcq5yQDDX1E0QZTlxPJ0/fSeF+Im2EC1klPMSP/cinhVCrOAdav1zKWp5JWJE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0sdB0m8DOg9Bq32qCgZ3SX/ACtRttIU5c04WVchBg1n+HoR2j
 /ky8qeMd6T1nN7cNkUDih0GB21JIbshPacJvUTE9hO252rtJcTPU7HalJj07TJTJL2U=
X-Gm-Gg: AfdE7cnaPn5BpSRjjrwqLYdy+uNXzBnfq4z4xhDyfxysnQd0sB+443opx0JY+gP7fe1
 VU7Lnb02yNe59Dqad8BNBmtCE+5zjci1xBJnpsZ9+6mY4RPZfbYxuJaaFRY4H+kEpaIUkHyl1AG
 p5YAG7x0/5jzXdBdjN5S2/IaPC2fR7oRB0hskdfVTg5vjfHWczmhl3Z0B+fdARiUVG+tf0/kOZG
 9D0PEP1NfhjPiefEFyB8cQKF+EKuVIcveMVg2AXWW6sfFuXl3LMavbjBy51DP4+Z+I1Xkc+A3cW
 42OQhfcAflU7jLLHYx59VfAklVnxw0otRFkK4xBn00kLf6lrvkVGiaR9p4Qp/QnWGTKyNYaaoRh
 GuvLLSB+TrrmX8/3ETUsXsOUSA11XBLNLBzM6S0n1NLVU9YMzpflRfpWVQ3gt+h8YoSroScH0Dg
 B5NWQuxMNvHD6tZp/Te6XEstBxzh8=
X-Received: by 2002:a05:600d:6402:20b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-49240eb56b9mr227531085e9.37.1782220954523; 
 Tue, 23 Jun 2026 06:22:34 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm349965745e9.13.2026.06.23.06.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:22:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jun 2026 15:22:27 +0200
Subject: [PATCH RFC v2 4/4] all: Fix lists.denx.de links to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-osuosl-ml-switch-v2-4-28fd46e89e46@linaro.org>
References: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
In-Reply-To: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>, 
 Simon Gaynor <simon.gaynor@ezurio.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Yao Zi <me@ziyao.cc>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=H9bxa2Rbb1NemaWmXnPOUNy8TPmQhCx3hYP2F2d9EQI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqOoiSaGBz2DKTifD4SVweNChjr51Fmaze5iZLkAIv
 pjztV0iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajqIkgAKCRB33NvayMhJ0dphD/
 40fAXkOgMphReSumT9dm9Gr3OyAtIVZy5UUqYLBcp2LDf/MI/Ys0a/Fwhy2CZZRrEpR+bOTYcPTolT
 vnyhNqJBBicRgq4csZXxtKpzWo01uW2ubSqDuibBmgmrLJy4+osLhTxa75FK8klIk7tuje0qZEPGd7
 Z8axDonCMSQqmlVZ1Zq1AaCyVB1qo4tQHwiF/B/Q0d91P7s+0HXYvx6AcQapVi0OlUggVtePFD53rC
 xTATidLlz3SHw2GmXeb1el4XLBetZ/LUzokHgqoHPoK8x6G1d86vOg+Ih6WqY6YAlNAqHIOiiwPUJk
 Ryhtgx9IK3u5dTtesgO5y8YnFUPsRuArqyUPCDeepjfslxkvHbaI+Z0U01fI+FGt6QotDaQf6VRdzB
 1/rpDImqEYt64xhIRzGEemG2XkqmkBTf9UdBlqTZyawJvr8YPTT7TEJSfV+4Okk131yPs8xpsRkGPu
 lfbux+vdLEgMP2q7OXQJ+fD7Y7UJBsU0yXeRKfBjy5dJ5utk3K+pon5yhfqM1EpG9jGrgA8xdMdwRN
 HAUuuF5lRyxjOpypcGBWihu9+kabuThiDgU67THujIVfnyK0Ud36iKGxuylUHapTzO8JfwKPOD5zIL
 Oj+N+fyPUWDXsQISYxTVIHatff2L/Yh4c0cAxnkZ5fRwF4Dbgn4LS2/EeMmg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so fix all the links in comments still referencing the
list.denx.de domain to the new domain.

The URLs were manually updated since the mailman links don't
match anymore after the archive import in the new mailman instance.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/powerpc/config.mk           | 2 +-
 board/boundary/nitrogen6x/README | 2 +-
 lib/efi_selftest/efi_selftest.c  | 2 +-
 tools/rkcommon.c                 | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
index 6e30df6504e..26fcdc4e884 100644
--- a/arch/powerpc/config.mk
+++ b/arch/powerpc/config.mk
@@ -32,7 +32,7 @@ archprepare: checkgcc4
 
 # GCC 3.x is reported to have problems generating the type of relocation
 # that U-Boot wants.
-# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
+# See http://lists.u-boot-project.org/pipermail/u-boot/2012-September/135156.html
 checkgcc4:
 	@if test "$(call cc-name)" = "gcc" -a \
 			$(call cc-version) -lt 0400; then \
diff --git a/board/boundary/nitrogen6x/README b/board/boundary/nitrogen6x/README
index 0b59289e7f0..ea92554287f 100644
--- a/board/boundary/nitrogen6x/README
+++ b/board/boundary/nitrogen6x/README
@@ -17,7 +17,7 @@ and saving the environment to SPI NOR.
 
 It does not support 'boot from SD' at offset 0x400
 except through the 'bmode' command.
-	http://lists.denx.de/pipermail/u-boot/2012-August/131151.html
+	http://lists.u-boot-project.org/pipermail/u-boot/2012-August/130745.html
 
 2. Boots using 6x_bootscript on SATA or SD card
 -----------------------------------------------
diff --git a/lib/efi_selftest/efi_selftest.c b/lib/efi_selftest/efi_selftest.c
index 2b95713afb4..41638dea7fe 100644
--- a/lib/efi_selftest/efi_selftest.c
+++ b/lib/efi_selftest/efi_selftest.c
@@ -284,7 +284,7 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 			 * implemented we should call
 			 *   st_boottime->exit(image_handle, EFI_SUCCESS, 0, NULL);
 			 * here, cf.
-			 * https://lists.denx.de/pipermail/u-boot/2017-October/308720.html
+			 * https://lists.u-boot-project.org/pipermail/u-boot/2017-October/308144.html
 			 */
 			return EFI_SUCCESS;
 		}
diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index cb2d30bfd57..77e762b1f27 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -205,7 +205,7 @@ static int rkcommon_get_aligned_size(struct image_tool_params *params,
 
 	/*
 	 * Pad to a 2KB alignment, as required for init/boot size by the ROM
-	 * (see https://lists.denx.de/pipermail/u-boot/2017-May/293268.html)
+	 * (see https://lists.u-boot-project.org/pipermail/u-boot/2017-May/292692.html)
 	 */
 	return ROUND(size, RK_SIZE_ALIGN);
 }
@@ -328,7 +328,7 @@ static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 	 * to determine the size of the next-stage bootloader (e.g. U-Boot
 	 * proper), when used with the back-to-bootrom functionality.
 	 *
-	 * see https://lists.denx.de/pipermail/u-boot/2017-May/293267.html
+	 * see https://lists.u-boot-project.org/pipermail/u-boot/2017-May/292691.html
 	 * for a more detailed explanation by Andy Yan
 	 */
 	if (spl_params.boot_file)

-- 
2.34.1


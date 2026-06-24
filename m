Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C386ACDB481
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4344E8460E;
	Wed, 24 Jun 2026 16:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OFAFKwNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119708460E; Wed, 24 Jun 2026 16:39:48 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75DF280398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so761454f8f.2
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782311985; x=1782916785; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hlMFXNryErR3yH5DBObe1aU+Po4eoGJiESXSOZEFhM4=;
 b=OFAFKwNL36dgXkDi5ph59EEx5wE/glxXqCwlf9nGvkEKAdynQ7J3TBOXPFBCTGoh1a
 Q+Xob0EJR3tPuAYAKKXFWMyeeHLfYCtpyp9SfpW6b3rPxYIh5syf2OAoZv45YhaB/+kg
 Qi7K+Ke3hzxtgUmnjjpLNyJv7JvbzqiL+aWxKK9E7tnDsLuXa+iuUM6Laoz2bTObRH/t
 l2X1uE54gfYtx7pnUHsDIc3n8NpGqlQS2MF3tE1mshngFLDY2lSXi797izwq7Qbh7Wbw
 i9XYDoB0hj4PmUjNW1hhxxtn/lgV4qAu2VsfM5mnblg5apx9vgON06Ee0UN1m77ggsoL
 P8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311985; x=1782916785;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlMFXNryErR3yH5DBObe1aU+Po4eoGJiESXSOZEFhM4=;
 b=VPQGSOjOpz4bP6mJ7/mv9TFdrVNzLjnWrQ30/tZgxLNKawEdwSQ9zs1I+I6fy5Szso
 8k4Sr3ekpFZPLrE6AyDPs9IWKujKbjMuc9aw7m08jC0UegCXYrfRDQY8TbGl+8eIzX8U
 34dy2OX7fdQMe4ZDeNRFm6URAcQ5/kDHov02yxKYTYOJY+edj97N+ZD4J5AXvMISEL0c
 oWQ0FbrWYkyguA2DJTUq4r4jld8OCJ6ZHtSgTqRv+0Z+ybXDpcxsruyOVPItrpQM7bv3
 YQKRyelu6d0N1VBTKr03nr20s4BkbYgZ7tkfbasbUzEz/pI3IzyjV3Ym9KE39dp75oRQ
 X0Mg==
X-Gm-Message-State: AOJu0Yxz/dX2g2ZXFGptt6d3nF+SQSZbfx+1R1Wca8J+kSB/FWW4y82R
 JZu1kHKK8dMC2bcTmQP94TDuKpb3AkCvzq4kgI+Ffke3B+VWUL/OtTfYy3ty852LTJE=
X-Gm-Gg: AfdE7cn1HT948ZhNA/Io4Ow+GsGdcWFKu22HzicphZFEr4dBqYMs4SuW1XWogn6mYvV
 7rFoK2dQmxjCXyvEcyQ152E6YgChQM5a2tKjosa5a0AobrRGAto/Ky8vH/7fvkVn3RrIieDEVYX
 Bj2b9HjwreCmxuiTmIQ5gukid/lwk0pDkdoIWcNfy+1GTw/ix7oba/ZksUoe6KYvvAo1yCyOarM
 /e8K1q8Lr1W1g2KZHha7QqHg99ZCFBPs+PaJLHUW9EC8k6Ff8xba8DIYWRuOwGpTxILAxQOhyc6
 r/+qIB7Ic0x0/N+1BYmhkyu7fjTah7j/u6FdLGPsTcoWoxoZYF9nRQgpCrjK2llHzr52TpH2q1A
 34ZUkewMAVGQXq6vNJ3Byv3O3M3xfuJgd3dHunIkdurN6jRMYK2vYRpTXEDg8D1okxB9sNQSl7D
 YwPEDkymKn9XKTcAo94Fb6H6MWm8g=
X-Received: by 2002:a5d:5d02:0:b0:461:a1c5:8348 with SMTP id
 ffacd0b85a97d-46c0cbecfebmr5752878f8f.42.1782311984638; 
 Wed, 24 Jun 2026 07:39:44 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22b73badsm7392450f8f.33.2026.06.24.07.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:39:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 24 Jun 2026 16:39:42 +0200
Subject: [PATCH] treewide: change email links from mailman to
 patch.msgid.link with message-id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-ml-switch-ml-links-to-patch-msg-id-v1-1-da694b9ba71c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC3sO2oC/yWN2w6CMBBEf4Xss5vUVUD9FeNDKQusYiHdekkI/
 06BtzmTyZkJlIOwwi2bIPBXVAaf4HjIwHXWt4xSJwYyVJiCzvjuUX8SXbemXvxLMQ442q3RNs2
 Rr5TbU1mZiyFIojFwI//t5P7YWT/Vk11czTDPC4pgxTOGAAAA
X-Change-ID: 20260624-ml-switch-ml-links-to-patch-msg-id-e925a37b0802
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Gaynor <simon.gaynor@ezurio.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5896;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=I58Ebvnr2pgXEbzA70fg/oyQy6xycjsf8UdtJyLOyaE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqO+wvcETMqh+5PRjDqnfgmkuT8NoZO1OeKbWyq702
 LVTC8t+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajvsLwAKCRB33NvayMhJ0dbPD/
 9Z7FOy5N3WOI3YA7L95gTODsSA5rM/Lsot6ddKYaf/5cDUSBZpCxkDUbvX3MVpWsyIj8E9ZO6uJi7+
 3QfUFodKd00fSZPgHP1yFP/PpVOh/gpPPns+wGqYZKioIbcKe/qRlDPckMpkcoTY3xLz51VK4nlydI
 w150PT3dlufVtpZ3OPUOMR0Yo7QdcHl3EQ6/jSTVvok2WcXpvaYcLTCNbvin/eMG9eg81kAaGPD9bD
 CKK3gc4hcDwYu4/QndRIENB9XoyAcebNLQMvS79bEpoNkQDDe2HDlzKbqtVehoTCcIyu/gn2wMUS5K
 bw6iHZu7mK3SBlXP2UX7c9/0Lo9Ii+RaGhMIsqLLZn7sLn5DfZIXm1WS5O3f+sbOyEeyThe9JGvH2N
 GqrKGGzopP4TYP2FbULoeTAAoCHJonl7L4G7w0cvIP1dMyOBJYnbe7ibjA/xm2Vc0qOgkYM06+QvO4
 N8TdBarCCbBugc4N/eTsHRuHc2tl66MLFlXJJDDzTq5KCW3uC0HLnLFnZyJ9XliZMAzAG7do7Ob04E
 f2rQCyf8/VF10JZ0cvOm8xKvPJZeRQba9AZ7uYKHQ89KgpoYm04xAz/Z0S6ZVnC5++SRvfKNLo5Mb1
 4oRErDyTuoB1sbRBU1pVUYG2EDPaYZBD1WPby/3gREExQ2iC6dXv6Y/eL29Q==
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

In preparation of the migration of the mailmain mailing-list currently
hosted on the denx.de infrastructure, migrate the links in the code,
comments and documentation to http://patch.msgid.link to be future proof
and always link to the expected content data and uses the message-id in
the URL which will help find the appropriate e-mail in the future.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
[1] https://lore.kernel.org/all/20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org/
---
 arch/powerpc/config.mk                   | 2 +-
 board/boundary/nitrogen6x/README         | 2 +-
 doc/chromium/chainload.rst               | 4 ++--
 doc/develop/historical/generic_board.rst | 6 +++---
 lib/efi_selftest/efi_selftest.c          | 2 +-
 tools/rkcommon.c                         | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
index 6e30df6504e..18aaae037f6 100644
--- a/arch/powerpc/config.mk
+++ b/arch/powerpc/config.mk
@@ -32,7 +32,7 @@ archprepare: checkgcc4
 
 # GCC 3.x is reported to have problems generating the type of relocation
 # that U-Boot wants.
-# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
+# See https://patch.msgid.link/1348500648.2514.2.camel@petert
 checkgcc4:
 	@if test "$(call cc-name)" = "gcc" -a \
 			$(call cc-version) -lt 0400; then \
diff --git a/board/boundary/nitrogen6x/README b/board/boundary/nitrogen6x/README
index 0b59289e7f0..114f81f1d1a 100644
--- a/board/boundary/nitrogen6x/README
+++ b/board/boundary/nitrogen6x/README
@@ -17,7 +17,7 @@ and saving the environment to SPI NOR.
 
 It does not support 'boot from SD' at offset 0x400
 except through the 'bmode' command.
-	http://lists.denx.de/pipermail/u-boot/2012-August/131151.html
+	https://patch.msgid.link/1345062683-19134-1-git-send-email-troy.kisky@boundarydevices.com/
 
 2. Boots using 6x_bootscript on SATA or SD card
 -----------------------------------------------
diff --git a/doc/chromium/chainload.rst b/doc/chromium/chainload.rst
index b00ee94eaa4..0f61e020db8 100644
--- a/doc/chromium/chainload.rst
+++ b/doc/chromium/chainload.rst
@@ -42,9 +42,9 @@ Nyan-big
 
 Compiled based on information here::
 
-   https://lists.denx.de/pipermail/u-boot/2015-March/209530.html
+   https://patch.msgid.link/1427703262.24522.59.camel@collabora.co.uk/
    https://git.collabora.com/cgit/user/tomeu/u-boot.git/commit/?h=nyan-big
-   https://lists.denx.de/pipermail/u-boot/2017-May/289491.html
+   https://patch.msgid.link/CALr8Vo1WvO=m1W2zvT=MOQ3k-fNtcCtBjk2+zgKha0j28s8g6A@mail.gmail.com/
    https://github.com/chromeos-nvidia-androidtv/gnu-linux-on-acer-chromebook-13#copy-data-to-the-sd-card
 
 1. Build U-Boot
diff --git a/doc/develop/historical/generic_board.rst b/doc/develop/historical/generic_board.rst
index 12550a140e0..17a92687c5b 100644
--- a/doc/develop/historical/generic_board.rst
+++ b/doc/develop/historical/generic_board.rst
@@ -64,17 +64,17 @@ separate function calls so that they can easily be included or excluded
 for a particular architecture. It also makes it easier to adopt Graeme's
 initcall proposal when it is ready.
 
-http://lists.denx.de/pipermail/u-boot/2012-January/114499.html
+https://patch.msgid.link/4F019ABB.9010201@gmail.com/
 
 This series removes the dependency on generic relocation. So relocation
 happens as one big chunk and is still completely arch-specific. See the
 relocation series for a proposed solution to this for ARM:
 
-http://lists.denx.de/pipermail/u-boot/2011-December/112928.html
+https://patch.msgid.link/CAPnjgZ0jesqX1Y71S5xoYQDGPuARfOX48RGbU9Mw=P5HGYcOKg@mail.gmail.com/
 
 or Graeme's recent x86 series v2:
 
-http://lists.denx.de/pipermail/u-boot/2012-January/114467.html
+https://patch.msgid.link/1325477374-6417-1-git-send-email-graeme.russ@gmail.com/
 
 Instead of moving over a whole architecture, this series takes the approach
 of simply enabling generic board support for an architecture. It is then up
diff --git a/lib/efi_selftest/efi_selftest.c b/lib/efi_selftest/efi_selftest.c
index 2b95713afb4..ca23438bb94 100644
--- a/lib/efi_selftest/efi_selftest.c
+++ b/lib/efi_selftest/efi_selftest.c
@@ -284,7 +284,7 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 			 * implemented we should call
 			 *   st_boottime->exit(image_handle, EFI_SUCCESS, 0, NULL);
 			 * here, cf.
-			 * https://lists.denx.de/pipermail/u-boot/2017-October/308720.html
+			 * https://patch.msgid.link/44453b06-5a09-ee3c-0a6a-b54bee9020e4@gmx.de
 			 */
 			return EFI_SUCCESS;
 		}
diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index cb2d30bfd57..b39777fc060 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -205,7 +205,7 @@ static int rkcommon_get_aligned_size(struct image_tool_params *params,
 
 	/*
 	 * Pad to a 2KB alignment, as required for init/boot size by the ROM
-	 * (see https://lists.denx.de/pipermail/u-boot/2017-May/293268.html)
+	 * (see https://patch.msgid.link/CANbgqAQPw5Dxp7Qm_aZoL1nggg9Mm1SQoKvx=V5a8p-9+DTDNw@mail.gmail.com/)
 	 */
 	return ROUND(size, RK_SIZE_ALIGN);
 }
@@ -328,7 +328,7 @@ static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 	 * to determine the size of the next-stage bootloader (e.g. U-Boot
 	 * proper), when used with the back-to-bootrom functionality.
 	 *
-	 * see https://lists.denx.de/pipermail/u-boot/2017-May/293267.html
+	 * see https://patch.msgid.link/CANbgqAQ5p-fE4T-Ye9UAMs-nRGU8AP_yxDf+5SbZbP8bxLa0dg@mail.gmail.com/
 	 * for a more detailed explanation by Andy Yan
 	 */
 	if (spl_params.boot_file)

---
base-commit: f072620dc9ffda00b010783da27c41231c3a439b
change-id: 20260624-ml-switch-ml-links-to-patch-msg-id-e925a37b0802

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>


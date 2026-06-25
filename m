Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C6CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1923B84962;
	Thu, 25 Jun 2026 17:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d8RYBM6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D9E84968; Thu, 25 Jun 2026 17:36:22 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4C884894
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so20845265e9.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782401779; x=1783006579; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=05luFp9g6fBGFg2OMnBuz/K0CfShmXphyS0RZ51O6SY=;
 b=d8RYBM6KQB3/99kot/vphQZE2yGH2jNpJk1SA9tNy8lNkslv6MahjACIQjZuybf9sG
 h1u+wIp5qlGqZLjNaqvRdNPREP2I9z39g7q0ohAp1cTzB7Vb+aN4JrJ3CyldpnOtc03i
 oqkXjBfAIWHtddRx3/IXRQIcPnm6Mucu2SN6O3EMWUOgZc/A82KcoXnWeGO9vYaSjGvr
 /x48naZHrxAIJ8rerDIQeD7W4fOsGyxnkbseWaOaVnwmVsQmt8fOSrt6mifB/PXpLUPL
 lG4orm+XTCSL5TSBf8Sqb4LBZ/UHadXK0vcmoenRcUzGFZWZp2j2pQoREarDxvC2+w6T
 7v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401779; x=1783006579;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05luFp9g6fBGFg2OMnBuz/K0CfShmXphyS0RZ51O6SY=;
 b=WUwpW+uRJABFryTKqy2JrsXRKqlDXbtxwH0TweQqQVsvTcmsD5kqW9mPUAgvwKfzZ7
 Qa+ChaGZbXh2ELekCDaFF8AJ5yqo4o2uiD+QoHCMd2HA/mQ7cOVRN+puouFFJ3gnMm5g
 j+CccFewkie1/Bmof69/YeUvP8MMLWxOCkVHBTbu8OAKxdio79aChyZ6g/EVOLKEi3jb
 n8YecCwkV882sCNw4+eQMuf0/D+ZRf9ZutCCSRDcqiXQ1UhXaL+ux+cM2JHpxjjcR7mM
 KZ2CuP2FksPxwFYIrNUWPDgwGM31CS9mrA7mnUrRITeDCTbfmbJEgowmhOW171lFZZ6i
 22cA==
X-Gm-Message-State: AOJu0YzIYLmh7H6yHu2XpQCCkCBL3KxB03wJfzGBaWl4Lxky9R0l/D8/
 hEMxiSyOyP29uI5P+HLod70ovx7bMFnTarjbZyjdqllw/P1jItfrio0t07E3jjbPcTQ=
X-Gm-Gg: AfdE7cloxbzV1n4YOJBfM9RB2T3XpqWSZaRYpOzoqHuO59XAkl/OdEnkZgqAFzecZMc
 xKLAhcaTKuwsBLBFShDusDuabs3Fnlruf0kDqL5jqQwFZmC1uuoDgty8+Yq5vTqzKnwQzitrCLv
 0K2Gxx7gyWGKbwzh306qZwob0BI7iL/TG9LGfLF4rrmC1Y6U5JqBPfiwz1Izm6RwvEj4fOUtqUW
 n/nDKqHjkHeqsWt081gOHw61/YLcRUmN1r0ka3si4Vy1MXAjfUTMweOAlqEeoG/g5RxWTZ9Dzv6
 lrOx1uaJCIFEHCv1AZg+cTUApzc6n3vDzJ7OnuFX6qHI8gXO81zVR3bsCMPUf6Y6HIonf2Iltce
 Xf0TVT4e2bvZcyASJvpl4bjbQSIKYSlb5gkJqc7a7v17/RFIw4L0StBNzjOWW5zTueT+g2V+Mim
 CgC09YIP3ZLUSqiI69e7ScCa9JJKWcMi8Vvw==
X-Received: by 2002:a05:600c:6748:b0:490:c024:2eba with SMTP id
 5b1f17b1804b1-4926688598fmr42063365e9.22.1782401778272; 
 Thu, 25 Jun 2026 08:36:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269071c9esm4761965e9.9.2026.06.25.08.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:36:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jun 2026 17:36:15 +0200
Subject: [PATCH v2] treewide: change email links from mailman to
 patch.msgid.link with message-id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO5KPWoC/5WOQQ6CMBBFr0K6dkxbEcSV9zAs2lJhFCjpVNQQ7
 m6LJ3A37+fl/1kYWY+W2DlbmLczEroxgtxlzHRqbC1gE5lJLgteyByGHuiFwXTp6nF8EAQHk9o
 SaqMOtpJHdSg1P3HJYtHk7Q3f28i1/jE99d2akJqT0SEF5z/bF7NI3l+DswABjSqqXFdalcJco
 qe82zvfsnpd1y83dZs45wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6110;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=d5rjdVUT/xSrPXpHiNBCvMT7OHXKYGkVa227y4FDKkI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqPUrwaLExEOxpZuwI8X+cAO4BKdfhi0iQCCmsX6g4
 jNBinJeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaj1K8AAKCRB33NvayMhJ0QJKEA
 DKcY+AFK9FWI2C+wA1PUCcF0NTJEUuc3VAvkL1JjateECxZ3lCZOItFEJcoSd8HxYcPL322Hr07nF3
 VJdg0iv6spY0KAj6nkoAFQLI9Zi2OG/wkZrbVW3e2Vv0Gmfu0robNvxQ+kzKs9bUzlXbDxYyr9/Jbk
 NKfvgg/kwjHyBZyNdZ/tgFCjF8e4uiD9dxlb2YVZNVuxBCX3yq4mWxHpB/r42HhDltpbj7CTUUJqU2
 o/zM9EAz47ujeKUCaAleelNGXrssCNUIIOBSMdgRvlKJN2WfSvFjdH8/AF+q+HrWvQm+EwIcPGZa5G
 07Y3HQJ41nZhH8WFpqLKydtBbxDtBtnl6Tx1rno/H7CfBT7Z8eR+o68eToCMbP3cvg0sWnP6LejYua
 aB1FZsAwag5+erc7PBz2xVhjYOA6Oe6yDmfObNHHkrrVCXk/SbL/BIcTcXqjfjXQb/E9gwe5zLUcYc
 qiTtXmsWRzo+FUCw7Ct5ZO5uSupQkooRxU9hq44YzaKr1LjsrkHedZNmNjXrJbf2X+SZ21w0Q2gkbg
 SQhdA4FKFxAgz2BrLFfCsYcfEhHd+xHo6hM1HBQ+l7azn5ya5DmZUhU67ynjRbfOahuZyLRmOONuEc
 Y+H9/LG2EO71zbtiq/mnjyyVAgxhFt5frfMIKW0IwtOgW/TBWm8ay//KEL6A==
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

In preparation of the migration of the mailman mailing-list currently
hosted on the denx.de infrastructure, migrate the links in the code,
comments and documentation to https://patch.msgid.link to be future proof
and always link to the expected content data and uses the message-id in
the URL which will help find the appropriate e-mail in the future.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
[1] https://lore.kernel.org/all/20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org/
---
Changes in v2:
- fix commit message (mailman typo, https)
- add missing / trailer on links
- Link to v1: https://patch.msgid.link/20260624-ml-switch-ml-links-to-patch-msg-id-v1-1-da694b9ba71c@linaro.org
---
 arch/powerpc/config.mk                   | 2 +-
 board/boundary/nitrogen6x/README         | 2 +-
 doc/chromium/chainload.rst               | 4 ++--
 doc/develop/historical/generic_board.rst | 6 +++---
 lib/efi_selftest/efi_selftest.c          | 2 +-
 tools/rkcommon.c                         | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
index 6e30df6504e..32e86d84a12 100644
--- a/arch/powerpc/config.mk
+++ b/arch/powerpc/config.mk
@@ -32,7 +32,7 @@ archprepare: checkgcc4
 
 # GCC 3.x is reported to have problems generating the type of relocation
 # that U-Boot wants.
-# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
+# See https://patch.msgid.link/1348500648.2514.2.camel@petert/
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
index 2b95713afb4..b284132c0a2 100644
--- a/lib/efi_selftest/efi_selftest.c
+++ b/lib/efi_selftest/efi_selftest.c
@@ -284,7 +284,7 @@ efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 			 * implemented we should call
 			 *   st_boottime->exit(image_handle, EFI_SUCCESS, 0, NULL);
 			 * here, cf.
-			 * https://lists.denx.de/pipermail/u-boot/2017-October/308720.html
+			 * https://patch.msgid.link/44453b06-5a09-ee3c-0a6a-b54bee9020e4@gmx.de/
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


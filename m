Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135D8CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 22:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD2D8460C;
	Wed, 13 May 2026 00:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mQV+FBoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E12845C8; Wed, 13 May 2026 00:32:29 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7F484374
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbec19732eso5709933a34.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778625146; x=1779229946;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZSEmvXbMRuLU0H96KtONU3pa0R6xnrcMC0CK26Pdp64=;
 b=mQV+FBohPbqNizOS2zKyEQIfnKOiiRkEo8UB8Pz0KHzCPqrciG5pJGcaFAt7uksTEQ
 zIJuG55W5TdHpdr0gn2xk/7u4EeuPbc9ewbvEbMuF/dq73Xz+QVyBJXXRZJxp9jzgzh4
 XokUoOEyEIeoQU2KyAzj0SSzxwXq4lLaEnWyo8Lx1un5d+d4m3LE500WiA+slt1DRd1i
 OhAyI+wNIUtnHIfycYC2MtneCVUY3gtyC4Y7Zm4En8y7P/wT3DzyGasl7KTfhnG3O0l6
 1LZ1mAO6CGNVZOZ26EGz9x3vgA2wZOd9gFTdVNtYlb1vH1D/7GSRIxAmyh+GBnSZG3mE
 Gt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778625146; x=1779229946;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZSEmvXbMRuLU0H96KtONU3pa0R6xnrcMC0CK26Pdp64=;
 b=Y8GGcuXxU6gOAXEL5ESLsRvCJZ+OV6Lngd5F8V6M2luC/RmEKn7/D4kovOwlDh6uaN
 IHx4hnLhiDtOz3R22pr2KKiWrUw9IB96Uqj7mHtZL8WQYfViGex7OZkYuaDV/4hKNloH
 lCcOT7Q7M6g5EtD03v21HiEXe/urO2AemZtS9tnaRI8FXS5Iy0DB0olhDS4bztsCyAIf
 AizRfo1OZ/AuPcCp/cmsDRpe+z45irVd5cPrEIpVo8xykiiUnqOLpXBjpxFFZLB5SdEO
 ttkOkbXkIsb5vrFhzgcu22OL9RACSCbqeVaQeEQrs18svyEetH8VTt8jOA/f78oqkmLl
 5b/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zCakvzgXSTlq5SeDMoQmh6AeH6BJpWsUDFUyELbBWFMWD0Z+Himw9JoXOzTMDLJVxsdApOL4=@lists.denx.de
X-Gm-Message-State: AOJu0YwjEeSRJyqjmJ8q792Uusc3d9VBPPtoIGbeTUAS7oDdwdjrtdik
 yNCziJ1bkCx0EfEniP/tvDiPAdROZyy7kO6isJ4NETIz1ScouXmFkR6JVOQWb2gmdcg=
X-Gm-Gg: Acq92OHxggjEGmH1UAmND0jfEDKRH3BT8P+QJPStaCkQnsb50WS0GkA6eQ7Od/4eTvd
 DLff2ua8d69pc+ClOpfBlLWyD06zkoqtLOO2yIbEhJcXq85c/aKihzr4HgissFXhUOJ1yCUvZ+u
 RpeVlc+KiJMVb69kbiTM4q0K66PRgd1LNkkuDyySeMXb3gWGtl64y8Oc0dWjS/TNYA5uX1C4UdX
 s//OIfA5glDtW6sPraLbayUaRn5kRV9/cCrrgVkFnNOvEB4X+Zi5SemNbE6J1DAmvjJDvLTal6W
 cpOtpGIYL9Jvm/WS3rKEXbD3drgYMpX+zrV78F2lZMoilwJuuFmnC0oGlgXZqkhOabnm67wF6Ez
 PSotEPva7aXk93Q6I5hzxuc91DS1K7TUmSmDnmtHsxfVHtj2LfzkeGuA2lo+tJq8F+nDOGR89iP
 RdobOhEF0pE+wJa4fUuWy7HoYu0amL
X-Received: by 2002:a05:6820:4b8a:b0:699:b131:d587 with SMTP id
 006d021491bc7-69b7aa00a50mr45499eaf.11.1778625146379; 
 Tue, 12 May 2026 15:32:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dc0193sm8334545eaf.11.2026.05.12.15.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 15:32:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 May 2026 17:31:53 -0500
Subject: [PATCH v2 3/3] configs/mt8365: enable bootstd, FIT and DT overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mtk-genio-defconfig-v2-3-bf4c30ef7f14@baylibre.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KnNMjkyQdVy22iQ7PEDMDSIZohvBmGjfR5hlBxCKJzM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6pu4rv9+qLlg/7nUUOnE+8VgusCkDqFqx0Jw
 Zcy3h/JWIuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOqbhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8eYH/R3IiQDcYEh7i9nf+B3Rm6cqGKROmhbEIWXrQmw
 cL3+iu4iGFQRU5GN4tnHlNR0siok500HRs9B7AF5uWbkW03MGyqxKc1V+Ew9IA3rula+s2jj+ss
 lGwODx8lRTm0f249Zu/CU80W35YR3fTBSIql1/SrE53Hfmfa0wKF+KD3VrVogP4/jqjrxV9h6bN
 g2rS8LI3CZfOw8nx8b/IpXiayuPTPNdVeRTxeZJNLoUcjAYd8TzlBAcqvAVlBdDimHZowcYJyMt
 +26C9tfkesJPkl7oA7+gohCDEpmvhAG0HRWRrulaiun9nhgyvAdUZDMaNFZ+KGftJmxAegDjmej
 Y0rg=
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

Enable options needed by the default board support package for Genio
350 EVK board that uses this config.

CONFIG_CMD_PART is selected by the new options, so is removed here since
it is now redundant.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 1a385492547..202879ba66d 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -6,14 +6,16 @@ CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8365-evk"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8365=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_UPSTREAM=y

-- 
2.43.0


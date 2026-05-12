Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A219CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 22:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24A683EF9;
	Wed, 13 May 2026 00:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="thxUTZ3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6462C83EF9; Wed, 13 May 2026 00:32:25 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF22883E36
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-69489b43d66so1743012eaf.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778625141; x=1779229941;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uvE5xnCuwU4CVV6PP5CMALjZpQHbyjhqVbnPD0bn9Ns=;
 b=thxUTZ3Crc3y+asy1VOpM1gdePhROCoCnYcQ6VQOFWNiGazXnvFCJsnWGBCVgDWGIb
 EmqbEgeeZBx0O02I+kxoiPnaJGCtqwS1oh+caVEZ4aXFutiANupJ391NqWleZSWasElW
 RUnlGf1+8xsq3GkTGayTA2cw//N0YK8sS3QcJoDjxpX1vxcZ7av7CoQ1A1P2j1qIRaEs
 MLeCKCivHn+aB9rFCowCvGbZJ17uNH/Gjvc/WA+2wDh6HNog0jY+lDNCBbmfubjCssk9
 ysnYVc9Xc7WqIo9Z3zsjwbcfvxRIWS7RUTojPwb2CJ/k+FepTPbJbvU3AQnReaKbLXP3
 ZN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778625141; x=1779229941;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvE5xnCuwU4CVV6PP5CMALjZpQHbyjhqVbnPD0bn9Ns=;
 b=cHujZ5D7UHQClpxBZJ80CC2RtkR9nLB4TRUrBNbtpgQoyWHlJBNCZD9UMLWRrVEcms
 yzZcvnILcDF6noh746PfdrhgTwX/RTyCrOHLvNQ5gzilL8QYVHaxeY0Na+3E0Z8O8MMs
 TddwJmUPUFlewAtyEMRLzl9X6LsqeGhY4YT42/9tP/spLPRdUQIrwtCqo8ZuXZkcvdJg
 y24O1JV4jQPp2bOmnf3M4GzuExeE3g3fsdiblvEKpqERWtcUqoQZ3AmDxji+mnGG7wQL
 E8Gbk4wYkHCuGX8cqY2ogKY/tDSVfXkBEoLDYXamurHXR5itER8U6rTyS6eRfk1+u57O
 7P0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CwTEoBUT1DXT//GXlGsFqMzIprEVXNfVzsy8RCOLlCTlRsuiUqflVfg1/i9n20To1JgEgj3I=@lists.denx.de
X-Gm-Message-State: AOJu0YxP9KL5R0gyonxTqohMefoot+GQ5ilPZLc+l9CaTAZcqqnmONON
 glrRPROkfFY4IlxhKHkfcPrSCAzQIERYAT6c/dgI3FczFCRlbnEjEbyClf37Ee4MbKrR7yisv7n
 XzGbi
X-Gm-Gg: Acq92OGp84bM9qXYkCnmqgaKKTMPypGdvsVfVRUv9lVYQ288BOg0FZODqm5xjpk4M5y
 HcbZjtfxdLrZQPnzk/qMUf6ArW7IR/E5iK/gML+9WuvTb3Miy2i84wia2Hre1Jks5TB2gH+jA3O
 +gwrH1xk6eOurRhfKT2zRFW/BATXamilzE7xcT820rnMwwx51FNAs6pnjJuK/FrxTL/AqB/iWNX
 U6GbYZvPq8+PYywflAWo/IehRBsxy+Qlgr8wv190PZpkjzmQpLQZfnHLlRPWk2uZYQLK6cyXTpl
 BtDuvSMIiMOGui47hzBQWRlJbaMYvlBlLNOk5IWjch5nw5924SLc2hbh7I7xiUAFfV3rjovZcVh
 iPvVDWsBoBQP/a/EGVo5T0t57lYLBuswDigTM7tW+Q0RsNDH09wX9T5Ioy0ua73CxRqcjqtyVnb
 BEvPho0iX7jI1eUzOmEovX5sF6Z6lN
X-Received: by 2002:a05:6820:f034:b0:69b:4186:164 with SMTP id
 006d021491bc7-69b78e44f70mr437434eaf.59.1778625141274; 
 Tue, 12 May 2026 15:32:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dc0193sm8334545eaf.11.2026.05.12.15.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 15:32:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/3] configs: mediatek: genio: enable common options
Date: Tue, 12 May 2026 17:31:50 -0500
Message-Id: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2pq2poCu/A/Doo8BRqU1LRIJ6
 b8LuHd5knPPXSBhJExwKRaIOFGi4FeQhwJsr32HjNzKILksueIVG8YH69BTYA5bG3xLHauMKJW
 rT7oWEtblK2JLn716a36c3uaOdtxSm9FTGkOc99tJbN7/h0kwzpTVyil7VqU1V6PnJ5mIRxsGa
 HLOX/ZeLc/LAAAA
X-Change-ID: 20260507-mtk-genio-defconfig-7b165d83a812
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HQ0KuFsH5BfjcDZVH3nEMN+PJfLnL3KY2KBe8AhuDCw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqA6pZ/fFdEEONTROmVhKk6GXkmg0hL0Zwj2CmN
 i9jwVBK7pKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagOqWRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1xAH/0/KCMBGZhy+evehw6d9uS0z9ZH2O+oehdg7TVp
 31zecXXBfitd9P0dTIzwdyoRqPzkIM4xVLC9t+P7939TsgNAoBA/FZq7MwH7CdrcpS67va8FfTF
 JpXnAa+RByJ/lFsK9P1wk0/q7RsH51E7lLILYf5fKEDAAvFgKES9nL7l+370OiG/Bm2AkyPEUcB
 HbbkvCHSLVmNmGR6/zkmSCh07x5yImGLlrB4zCdO+rjFr6NNY+MZjNJMcuyyi26HGN6sMQfVMNs
 oG6EccMeNHTpL04iSvnJgYssBsNC6fqoAsPxzXTgiP1oFUGBlXhWFDIUvDdco5XkJBsaPNFyYvT
 HAog=
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

This enables some common options used by the default board support
package for the MediaTek Genio EVK boards. These options are already
enabled in mt8189.config for Genio 520/720 EVK boards. The patches in
this series make the other recently added boards match that.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Removed CONFIG_CMD_PART from the defconfig.
- Added a similar patch for mt8365 (Genio 350).
- Link to v1: https://patch.msgid.link/20260507-mtk-genio-defconfig-v1-0-5ca5d5c956cb@baylibre.com

To: Macpaul Lin <Macpaul.Lin@mediatek.com>
To: Tom Rini <trini@konsulko.com>
To: Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de

---
David Lechner (3):
      configs/mt8188: enable bootstd, FIT and DT overlays
      configs/mt8195: enable bootstd, FIT and DT overlays
      configs/mt8365: enable bootstd, FIT and DT overlays

 configs/mt8188.config        | 4 +++-
 configs/mt8195.config        | 4 +++-
 configs/mt8365_evk_defconfig | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: e662ef4ea8e18887f97c07f64f2ebe17bdb15cac
change-id: 20260507-mtk-genio-defconfig-7b165d83a812

Best regards,
--  
David Lechner <dlechner@baylibre.com>


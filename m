Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA3AC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D30E860781;
	Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2suXmqvTqOw; Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816128;
	bh=h2wIaOTSt8cvh5EshwNY3XCnH0J1Nw6CFs1rIievgpQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sWa5FkFpmQF++QJqFVAELnZL1ty4PBX8v0B9YEeIYZp8NEPaZ6aOyXmvu1bXjOUWZ
	 fsEBx9J2BcZ5UOqWo+QQJd/pyhhuzifFBOpO6ucKa75z4+MMH9Z5W+PTLL0XEdZNj9
	 ZwU63+EElJTw5Kn/Dkbsm+LCP2hDjA/POi03UnylnQSNm6HOMD/4ujQRMUxHlKVur6
	 K5qgaeZJANLRNkeh0cV9Hu1qreq8tYDmfO8mSfo65MAe86Us3dyfUGb5oyN7sp5Cij
	 5LzOk78LpNNicAOz26lLtfvk5+r4b6UPcGEvyg+499bswz/r531U/m12EXGdP7ZMph
	 jJfh6TNBzm1fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBEDF6077B;
	Thu, 27 Aug 2026 07:35:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28BCA1DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17A7760778
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYyiEZjw7v2d for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WH10jsDz
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 872CB6076B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:22 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso948277f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816121; x=1788420921;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h2wIaOTSt8cvh5EshwNY3XCnH0J1Nw6CFs1rIievgpQ=;
 b=WH10jsDz2GZli15pNooaEwfQPP3/6t3+lbiUU4hbqRGucdhLDAemYitcbX29YbjkTy
 ibLoT+6YnjgVQsrasuZ7ilHbR5M9QeDe+bF9TIODCXUGS9a0xymioV6LzzHjkROGHQSe
 qRYllgFPeCBhRgdJ5GgTgPaApn9dFrQCfyQ/kdmRJXbpAVhDyBqt301471XWVMpUVuUb
 LIF1/xFb7ELOlcS+xz4phzsETR1jQALsdjWhUxFdNvhFluE/fEhq/2dW3N/KY8AKt/eY
 qBWp96LUng2R29zBQs+Fvu+zN5ObIyEhtnFCiz9MSppk6gYoRTJd4qpKb5/6O8ncNBvz
 5PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816121; x=1788420921;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h2wIaOTSt8cvh5EshwNY3XCnH0J1Nw6CFs1rIievgpQ=;
 b=oLW77m2oUtElP5t/6+JyjTdHEQJRVhsQU4e3nVSvdU5vDa0HML4ym2Rl65JrRssTSX
 R9+dpeqwbwImEflRYwZZk/D1rA++QhHudmgOHMnK55fznvZutNxsbM+m6iH3GAMLY10W
 eUtbELD5NsuTsfuV7Kfjd773t/SS9A6kH+nrpTIpSMmqZ9I0RdWHmgZlcbScOAa8oLFD
 JGtrT14Meg6NVZg1i8frT19MMI59d+fs31K1Awx0xM7nvkceOx7xm8Y1qL3l6jfa+axH
 Gus3QNoK3X3uIGQkBZDbXRYPkhbPUunoMCC/TfzMw2mSjE9WrBNgdeHukN5jkLRsZ/2C
 X7DA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVb2X1YHc7hZ+72DK9kASrItIcMzAoTGwh8wFClNw1No93qFMlXhMhUkb6RAarmZ6Zj1SYMhE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mlrVtSGjcyrVXyaj1B878lGWSpQ4+4hg0cuhov2E76wLZDI4Jh
 937l5i1e/2/DtJYG05R9oCalBQrPiV7Qnc3rBiY9Auj7Vy1+zNJdaPdEH40me8IYywQAXSGmKnx
 gSenA0bk=
X-Gm-Gg: AR+sD12cXTHUCHwpzClkQOjFkiLlHjtrG3Zl76yuwRCPQsEymqzXlsaZ+JrghWjO2+u
 AzasKi3/eWaAi87kQ88LO4bzzrMn8PNuh1n8oqLIEg0jaK7d6PSfX8eSpHh1VmYflSvmm6a7QnG
 tlHxFLNjAe9+Nsbfy2J53V5tkyYa0NmVk4PpVEvG75uofgH3uBRTToxnewuypL01L1etLdMZp0B
 /JG/qdlzkGh2fXJga2JcoY/PRMq7PLKRmMMZynl30YCGf2xeUZuVCBjPo+lGItJIRfAu8ETOtMH
 M+QJ2/WJYg2+bXlP0ttA4EYCabDdPRIA9U8mSLLsqyutENUSghHIRYd95JYVuV19tbmn+M68hBj
 80OIESk6+ItSF9VrDcEWzd2Bwb6s1W3PvE4iq33evYdpVBIAdiUHoHiLVd8IkQGlaz6IqDkiFif
 tfMEibxuVs49PGL4XABv5UlXD1fKRFYqr4QnJ0JUN0CzomPPjtU8M/EWHeGYaJg7HEGMs210QnY
 SsvqWXRbqoAXtZoQ6cpmhP+khVoAcMj3dmGCSb246/W871SvTOy5ZUuyN0A3mgFTyVyEI9IKCjA
 SO55dAEp+w==
X-Received: by 2002:a5d:5f83:0:b0:482:f09f:b262 with SMTP id
 ffacd0b85a97d-482f09fb318mr3969241f8f.20.1787816120803; 
 Thu, 27 Aug 2026 00:35:20 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:20 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v5 0/6] Add Genio 510 and Genio 700 SPL boot support
Date: Thu, 27 Aug 2026 09:34:57 +0200
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33N0WrDIBTG8VcpXs+hRxPNrvYeYxdHPa6Opgmah
 paSd6/pGCuj5PKDj9//ygrlRIW97a4s05xKGo51NC875vd4/CKeQt0MBLTCSMO9x3ohfhrLlAl
 73k9WdYKX8cBNbLVHCSG6wKowZorpfNc/Pn92Oblv8tNKro99KtOQL/f8LNffb8lulmbJBZfQt
 K4NMaCK7w4vh+QyvfqhZ2tshgcOYJuDyhlEIRqlGyPlE049cEpsc6pyFqJTziMY1E84/cdZqbc
 5XbmoYwedsWg6+scty3ID0PbKG8gBAAA=
X-Change-ID: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Genio 510 and Genio 700 boot chains use a platform DDR loader built
separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
the shared SPL devicetree and configuration needed to initialize the debug
UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
bootloaders GPT partition.

Add an opt-in binman description that generates the images consumed by
the MediaTek flashing flow:

  mtk-boot.bin
    MediaTek BootROM wrapper containing the platform DDR loader and SPL

  mtk-boot-payload.bin
    Raw DDR-loader and SPL payload for external MediaTek signing tools

  bootloaders.img
    FIT containing BL31, OP-TEE, U-Boot proper, and its control DT

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v5:
- Explain the SPL BSS placement and guard area.
- Use the OP-TEE v1 header for its load and entry addresses.
- Use MTK_BROM_HEADER_INFO for the BootROM image properties.
- Rename the binman includes with the U-Boot devicetree suffix.
- Scope the SPL binman-symbol default to Genio image packaging.
- Link to v4: https://patch.msgid.link/20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com

Changes in v4:
- Express the DDR-loader/SPL handoff and firmware load addresses through a
  reusable Kconfig image contract.
- Split the binman layout into shared includes and rename the packaging option
  to CONFIG_MTK_GENIO_BOOT_IMAGES.
- Require bootloaders.img to be a directly parseable FIT.
- Link to v3: https://patch.msgid.link/20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com

Changes in v3:
- Add Genio 510 support using the shared MT8188-family SPL configuration,
  pre-RAM devicetree annotations and binman layout.
- Make complete image packaging opt-in through CONFIG_MTK_BOOT_IMAGES.
- Keep the binman image description in a separate optional include.
- Leave SPL binman symbols disabled by default on MT8188.
- Add optional RSA-3072 signing for the bootloader FIT.
- Emit the raw BootROM payload required by external MediaTek signing tools.
- Document component-only, unsigned, and signed build procedures.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com

Changes in v2:
- Clarify that the platform DDR loader is built separately from U-Boot.
- Fix the SPL copy-window wording in patch 2.
- Keep the SPL annotations board-scoped and drop the unused pericfg_ao tag.
- Normalize the firmware-stage names in the board documentation.
- Simplify the documented build commands.
- Remove the redundant MediaTek documentation maintainer pattern.
- Add links to Genio Tools and prebuilt images.
- Link to v1: https://patch.msgid.link/20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com

---
Carlo Caione (6):
      arm: dts: mediatek: prepare Genio 510 and 700 devices for SPL
      configs: mt8188: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 510 and 700 boot images with binman
      arm: dts: mediatek: support signed Genio 510 and 700 bootloader FIT
      arm: dts: mediatek: emit the Genio 510 and 700 BootROM payload
      doc: board: mediatek: document Genio 510 and 700 SPL boot

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  11 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  11 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi       |  94 ++++++++
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          |  12 +
 .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 108 +++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  32 +++
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi |  27 +++
 arch/arm/mach-mediatek/Kconfig                     |  38 ++-
 board/mediatek/MAINTAINERS                         |   4 +
 common/spl/Kconfig                                 |   1 +
 configs/mt8188.config                              |  27 +++
 doc/board/mediatek/index.rst                       |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 266 +++++++++++++++++++++
 13 files changed, 629 insertions(+), 3 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


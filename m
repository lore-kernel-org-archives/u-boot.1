Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A233C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1AAC813A7;
	Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yX1eWOOsSfC; Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8002813C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718891;
	bh=Y+zn1VXSUwiHDNX+0qVxj2LCBHXRHTNLE5Og3rsTjYY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SLy5ZQnAAWcWQCGHIlrrMOZQB83jAwaUJThS1cyFYyLHnle+dFN3F3SFyyA3op/hy
	 0Z6YgFIlzP7eY42YgE0a94YyZhnQTLoA8TYjz9p2ltZIE4seCHdvM92Ls9yP16LRu0
	 PV7d0mm9unvKcyRL39AjG1Ts8SMpVEzadiQg0QpPADttZF3ZQj5u9gPu43kX0YjcZV
	 Lq/FOp3yS83aeqCUT3nLHRMlA6xq+sxrsRCl7THr1ZM0WTXvQF25sjjIAMBiclo/H1
	 OCd/5bL6gNX0NIW6PFZrQL0FC8SX9QpYoclaQ3UKrbYZ6PVS5vi9Lr2QjQ4HS9OMO1
	 OzzGa24aSm5aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8002813C3;
	Fri, 14 Aug 2026 14:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41D3833B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32F6F60866
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VWLXTzvAEorW for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B1E20607EC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1E20607EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=exiQ2YLE
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1E20607EC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:07 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2020421077so197524766b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786718885; x=1787323685;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y+zn1VXSUwiHDNX+0qVxj2LCBHXRHTNLE5Og3rsTjYY=;
 b=exiQ2YLEoQx3Thu/fKEYTY519tP061vSGUtZVzeKJ3aLGG9bOH2cwbDNkDgQrjUl7q
 1CcCkRR3CyACvX2OiRSNm8wWA/ddaiWYx3Rrb72QMkIAHmi4EVgz6frPRRF/nvu/vajx
 Uwn53HIu9MIcD8NAUu3/6Fhfdkpt4hwcv34RQA5vohuAFdx4Psg3Dno4znG5s7ZfiGWH
 wxCnUU9u8e+Wg4/liBi5+wWOr3lobmPZDJlmA+oQ5zduQMY7LMLG2isJdaRoEIwc4lnq
 dIwODDmY1Of7NK33rWRTV573Ro2L+ubEAQqIoHh/b/G9WU2ewnwdA1gYQJLjwcCuBM/n
 VrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718885; x=1787323685;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y+zn1VXSUwiHDNX+0qVxj2LCBHXRHTNLE5Og3rsTjYY=;
 b=iqmISAg/gKW2coMnXCuj+UTdFBzVp/Obp0Gc+o+IRBv9vEYSbVUiz9YCw2R65sbu6a
 OQURqkhdbNtYW66L8XiH+dwQNLQjXGif75vzhNdIHCoCKsgEeaBDTbZcBLSBleilHjl7
 Hev5YjgRCafjKKMErGKM5ER4u81YRJEvH9LBvAwNewE3xqfFmfvypyBeZ0nKnjaOJ/u1
 /ZUpcnFgtetwwPtwA4IiVSG6G9L/ABavffJg9lt1FsRGH7Vr4+wpXSIar4Pj9kkEfSWY
 kTKNZhN+Pke7yj2z8yBtvLzbRr+Fv3xmlQsBSBmIncZMMbW95lwFUVHPMsK6ST1rYkUg
 kulA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyZTZS+pHBSOGPpXJimWKhVE79tQw/AOShxtxCTj6G4Dl677ZdHVCf1H5LQsbnxualCfv1430=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwhYN8c57eOD09C3vtc8kyVJzTUaDxQpx0xAWYN39NE/3ireTRO
 ZKkZLWfywg0XPEcOCwtSk6PgvB3WgNS7T8aqjwnK/pAyP9QddxBYE6gJ91ic6SfZ0j0=
X-Gm-Gg: AR+sD12YCS60fMu+nC3o7YRZnmeQpuANnKu9U+e2hrIowGhJ5+1WGkAhcgkb+sKBHY1
 wE6/ZYFya5Wz6rjjAXRNnb7PIcFaTUg9qIEbPqcxJlI9RFy7R81qy1ETIfIPozj8pmA9TvkcATl
 vtH1Co8yiODdWOme/mIG4Di9ROcYq3e+WzMhlZzgEYnTk8re9IA4Xg1v3efJHz2LWjWU9OTvr+4
 2e3cfBPTJ950HyauogzKDfUFAP5LAiJai4pqYD/gqswuthXiS1VeoNuaZ04qE3mz6WqWK/x3Rk+
 4dVILUhj8ClAi+LmO4TFINTj0aLEkRhTZ9TB8+loMdytf/73vTPunpje9smz3+oJMeCNT+HnYjf
 7KIZKicv+7RkvCF315KM6DmAu3nZ3S0+tF69ecLuWri8T0+AsPZ3rJ/rFY5tYi6W3/dYdpGdqhd
 pLl83P7ainxa97nAE/qVHNwv7oTSCwo9F27jt2/pHIXR6BJ2fWYtrBOTUigCqcK9zYz4Aqq2RFt
 zXtA4b05lb7G/530RG0N7QcYuzdqRZbHmQVvI5AZkmULnEqZs3bHFPQ9m0=
X-Received: by 2002:a17:907:a88f:b0:c15:e33b:8c4d with SMTP id
 a640c23a62f3a-c2129ac36b2mr273168366b.4.1786718885290; 
 Fri, 14 Aug 2026 07:48:05 -0700 (PDT)
Received: from macbook.tail959722.ts.net (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d9fcsm114992666b.34.2026.08.14.07.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:48:04 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v4 0/6] Add Genio 510 and Genio 700 SPL boot support
Date: Fri, 14 Aug 2026 16:47:50 +0200
Message-Id: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQrCMBCF4atI1kaSSdtUV95DXEySiUasLUkti
 vTupoogIl0+eHz/gyWKgRLbLB4s0hBSaC95FMsFs0e8HIgHlzcDAZXQUnNrMV+IX7vUR8KGN32
 t1oKn7sy1rwqLEpw3jmWhi+TD7aXv9u+druZEtp/I6XEMqW/j/ZUf5PT7lOrZ0iC54BLKylTOO
 1R+a/B+DibSyrYNm2IDfHEA8xxkTiMKUaqi1FL+4dQXp8Q8pzJXgzfKWASNxQ83juMTY1HBOHk
 BAAA=
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
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi  |  11 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi  |  11 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi   |  94 +++++++++
 arch/arm/dts/mtk-genio-binman.dtsi             |  12 ++
 arch/arm/dts/mtk-genio-bootloaders-binman.dtsi | 106 ++++++++++
 arch/arm/dts/mtk-genio-loader-spl-binman.dtsi  |  32 +++
 arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi    |  27 +++
 arch/arm/mach-mediatek/Kconfig                 |  43 ++++
 board/mediatek/MAINTAINERS                     |   4 +
 common/spl/Kconfig                             |   1 +
 configs/mt8188.config                          |  27 +++
 doc/board/mediatek/index.rst                   |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst        | 267 +++++++++++++++++++++++++
 13 files changed, 634 insertions(+), 2 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


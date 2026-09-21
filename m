Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEEDC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 23:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE841606B8;
	Mon, 21 Sep 2026 23:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5F_qRAOaXkdM; Mon, 21 Sep 2026 23:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 92DB96066E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790032394;
	b=ak8nOdF7fmts8pYCQWOPP2kzw6QQtUrDITrCPj4xZzQOKETtbpeFx2yt8IZl56wDfb4e
	 oY6LyV7zWDLWbYh8DCx+XkF4U8yQf6ManI77N+pPOz8jWtVT4H6ZuDfOCKGYE8kNjcm2B
	 rOBHf/JiSp/7UgkYkwgH1MvmAKetXmd7Uy2B9Rz/6Wx8eqBSrAt+I1bevlD0LO5LtPr7I
	 XglHH5CdtTUAlxPbwOmFH6iHzLewb5KAY9WauTp36Oppkrb5gUaEfHQTfpHuBy61dtb+w
	 zO2JDLTrVhMdl3G3XZYbgsyQ+3AWe4oR+Z4jdmrLPFcmDr8p7xbVWIc4t7S4naaxuhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790032394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V1fnlxAGgepeAHRuwVz/oKcXG3s/bL3b6nH9WtTkafs=;
	b=ZaMk8SKPMJj40KzgxGSTBa86mLLfH/LeuS6PpJMTC+CTmmHTasXVHgjVTNojAJzzbxaf
	 diEssCtFrbmJWREVeHx7ZUNf9hcWjXgJYvp+pjzzjkKObiwYmU2rdH8YUrHJN/WC72iTD
	 iA5KvomZXhPp2uhUgHWrWsljK+CpJVZ1FkSpqoL4rm6U3/MEzzskwI/ITG7I0MmcxYqE+
	 Y9XqYyvhwWxF2s1GD76bPJEpCGGfsqyR8IM/nfp3M46wjmDw1l5ZABWV/PyKnq7ClCVk4
	 q+1d8Akvvse+m5wVdus3ZmrcTx3JOgMj/O23mYLlWmigIhBkhUl0OPjk0DqrixVjoXQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790032394;
	bh=V1fnlxAGgepeAHRuwVz/oKcXG3s/bL3b6nH9WtTkafs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y+v5heAUm5mg7rYbSDbKuH5HN+DWx0gQQE3t3x39qUPoVLmu97HzvifJlcty2sxgD
	 LCtUedJf15ZsIqvp4nLj32+LLmTdoFdfIIjq+xE6HCLP39DJwxHkBFUOmKm45VW3er
	 bRwv1jzbBRmRiu36tbW60THTx3nz6l0FcW9yHXUvSu6yVgYA3eCPU4ILgy0VsgPt8n
	 rilXJ7SD6c+WsyYUVOUFQXi3pYG9N6av29mzvnoiHYG3xpXDhw/6uNHPuVrVMfS+Dj
	 1mBOoD+ya3SJ3EGKpVafR69XyBZ8/90fW0RPFfVP5wLz+WimShaAXGb711ByBz/DTd
	 4iC+XiJJTJMaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92DB96066E;
	Mon, 21 Sep 2026 23:13:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16B31371
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 23:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF8DC40116
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 23:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_DdhGSsa-Lt for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 23:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 86A4C40112
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790032392;
 b=tSQVYDwSSTno0m/WiBzbUZ0ZK3JlLGFRw+4WEhx3SRjXZayH+DO/hyoCOhcXHrsqqkHD
 Dx0qADeuMi8PPPpy6KRQHBjkBOC8Cf7WqXyzLbwFXwBr+6K21U5Ad3LEPaT91Fh2s40hG
 xzsncWAWU262U3N8gLhvp+lwHGppGnz7M8ABeKmIzEet2AiSm4SCe9XDZNVVGlf7SiCz4
 655SjhWo8aPyiw5wfn1Pdo2Wx5ZossJZinKJrMJZe0zB7vNSuapNjZAj0E/VvWiPAVUeF
 cI2WLJbEXAmZitk5qzpwKGXycvug+23i8AjvHLnbFrxKb1XlkRZ+6HVxl0JRNwm0Xhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790032392;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=V1fnlxAGgepeAHRuwVz/oKcXG3s/bL3b6nH9WtTkafs=;
 b=dIhUSbog1cR1BpB3ASCXMoA/DHHS9HKXuNqJCB5dB7/nBS/POJSLzyxOt37EF38A0h7l
 zOLS+H4lkyykUs7B974vBzLXx+0UXrKopRMxPRxD56NtKjKpsW3dA77/p6GqNfJPWs6uw
 JTFw7BI2mMMvC99eGn1K5vAjS1p+Xzba2pQtUmCYwc+zyeyFMrTmvi5osyMW2IfuK0QJv
 /2NcqMSyLTPUoGTmnbuIW1M36qtCmgwQs9vjFWbrx5ylzfg/4uUy+KLZPvFMF6wTW4Bi5
 TGxk25J9FmHXhD3r5CUV8bcaAIHNRjuLZJWQC7ig8CtBqvF+Ov7jdHzL0ng1pnaXxFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XDLt5UvK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XDLt5UvK
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86A4C40112
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 23:13:10 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a30eac5so1937619b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790032389; x=1790637189;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V1fnlxAGgepeAHRuwVz/oKcXG3s/bL3b6nH9WtTkafs=;
 b=XDLt5UvK0K+c/BbWNfI3R5ys738IyLOeWK6gYEhO1+1RKQbqhJumWT3eE7ZQF+1Fri
 Sj/W8zFOJrPimKIgz9KpKExkwpQhhK1t47lIcZB9tcObO0Do31VtHWL6sl+z6vn2rxbJ
 Mk569tGMZE/MF9IbQVBYj64rsvZwjdz9Sps5vZBVYWw2wAg948fD9BK58QWtLo+T6Nm2
 XxfnbEiWcp2fdXOr52lWwVPF1zXozrpnoJcp8P4toyKuyMy6a2BgDouRiZ5+jY13+YiL
 GfytDrrQnrO/Ep5f8fO70uuICmhjSY6fQnJ102h3qRCEKCXsTFEoecjou1T7W4ZEgK5z
 CpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032389; x=1790637189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V1fnlxAGgepeAHRuwVz/oKcXG3s/bL3b6nH9WtTkafs=;
 b=lJI1Bgbk+ouESUktthaxSHoepC45DwwFA38WTtTqPk0WAsQx+3MkyzPaF5ldDt6GA0
 seY7+ibUrRnF4i5IUhS86mn4DCxsxk22OXo0Lze7EezWH3h3zmGjZzxXY/KO3rYXRiXO
 rOS8dHBPlB/SxYOt9/sZiwW64i6wnmLFu1iTDEMBDLYRY6k23hXRzPXVAxX6kZrAp2sy
 OQSF43MmwNVhnMkeqSoTs0O4oN8af0JkQGh65TzqNgW4XJqHQiFuBE/cEcfgqvKOJC7/
 6hKEVsS9qeowPlGTEOk1ZodkPBg8QwLRgnoaWIxlR1k4ryxUyJHn1EI3Blv0UHbA7p7I
 HCSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDnYqnUZY6z2sEImkkcM8yUdrdfyZsuk+BoVQlPAPGbERrkQirJWYqiQX28MNiBfP7LCGi/9U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lonW+Yja9E+Z0BcRx5w51337YflyiEbxa5FVElf4nS228yIOvb
 pECcYZ3jcJwxeeXp0W9HclcsqZylM9JzrNa9i6XetEnFW3bapIMD0Qo7d2IQW4K25kI=
X-Gm-Gg: AYBFou3/JO92whH1vYiz/Tmc4s6NN3rZgV/W8/VlyvQrBg9XL4jlouRt0XPqqMqKrT5
 bAvmJlDoygRAu/UgoexU628YSo/UL+a8X0kQQTAkU4ZiEDqN7kPiscf9Jgf6DGLf4zHBoAaPP0D
 PsDBmNRtPURvcV5LJIJdB2yBzhoeHyjqb6ASIFXOCJnxW30byx8kI4WCjIk1hpuKFPXR1HbaIkr
 fr2pzaPBZXoY3cCI/80cPzPcckuOaiKvxoUjuQ+9YJbDyhn7v8kxg94Gt3X7nnrbtXhAHx0UVGg
 xdwtKAs+1PKSTUMb5RvBA6OxSh8gcOAV4tXbJJOanshkdBtuQwU4S0t2jRdeq/azIOTE3kIu8Bz
 b/aWfffBh+a7zVZV94tT3iU7RePHQRNX9diT1im+CMQJ5S9RaakNMhEmQAh59Abyyfde55xfhi9
 K5dj5n5VuvJXc1qSDV83nXtLYRtj6nBpO7i7qgxWHWe8ahLIBbVgZMnfENqUo6DKyrx7VuVAEc
X-Received: by 2002:a05:6808:1510:b0:4c3:6c2:4f29 with SMTP id
 5614622812f47-4ccf7196a65mr12517491b6e.16.1790032389372; 
 Mon, 21 Sep 2026 16:13:09 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d486d0f627sm327271b6e.2.2026.09.21.16.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:13:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-09-21 into next
Date: Mon, 21 Sep 2026 18:12:34 -0500
Message-ID: <20260921231304.3565381-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The following changes since commit 951132236b9adc592c2e49faadd103c6a355cac3:

  Merge patch series "spi: Convert drivers to dev_read_* APIs" (2026-09-18 11:18:46 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-09-21

for you to fetch changes up to ca1c29c01bbd03f89cd86159b2959b4e72d41aa9:

  doc: board: mediatek: document Genio 510 and 700 SPL boot (2026-09-21 15:15:23 -0500)

----------------------------------------------------------------
* New Startek KD070FHFID015 MIPI-DSI panel driver
* New MediaTek display PWM driver
* Simplify MediaTek power domain Kconfig
* Support two-phase bus protection in MediaTek power domain driver
* New MT8189 power domain support, power controller node and defconfig option
* New SPL boot support for Genio 510 and Genio 700
* Document the Genio 510 and 700 SPL boot chain

----------------------------------------------------------------
Carlo Caione (6):
      arm: dts: mediatek: prepare Genio 510 and 700 devices for SPL
      configs: mt8188: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 510 and 700 boot images with binman
      arm: dts: mediatek: support signed Genio 510 and 700 bootloader FIT
      arm: dts: mediatek: emit the Genio 510 and 700 BootROM payload
      doc: board: mediatek: document Genio 510 and 700 SPL boot

David Lechner (7):
      pwm: add MediaTek display PWM driver
      power: domain: mtk: simplify Kconfig
      configs: mediatek: drop no longer needed POWER_DOMAIN options
      power: domain: mtk: support two-phase bus protection
      power: domain: mtk: add MT8189 power domain
      arm: dts: mediatek: mt8189: add the power controller
      configs: mt8189: enable the power domain driver

Julien Stephan (1):
      video: panel: Support for startek-kd070fhfid015 MIPI-DSI panel

 MAINTAINERS                                        |   6 +
 arch/arm/dts/mt8189.dtsi                           |  52 ++-
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  16 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  16 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi       |  87 +++++
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          |  12 +
 .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 109 ++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  33 ++
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi |  27 ++
 arch/arm/mach-mediatek/Kconfig                     |  41 +-
 board/mediatek/MAINTAINERS                         |   6 +
 common/spl/Kconfig                                 |   1 +
 configs/mt7622_rfb_defconfig                       |   1 -
 configs/mt7623a_unielec_u7623_02_defconfig         |   1 -
 configs/mt7623n_bpir2_defconfig                    |   1 -
 configs/mt7629_rfb_defconfig                       |   1 -
 configs/mt8188.config                              |  33 +-
 configs/mt8189.config                              |   1 +
 doc/board/mediatek/index.rst                       |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 281 ++++++++++++++
 drivers/power/domain/Kconfig                       |  47 +--
 drivers/power/domain/Makefile                      |  12 +-
 drivers/power/domain/mt8189-power-domain.c         | 421 +++++++++++++++++++++
 drivers/power/domain/mtk-power-domain.c            |  30 +-
 drivers/power/domain/mtk-power-domain.h            |  19 +-
 drivers/pwm/Kconfig                                |   8 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mtk-disp.c                         | 187 +++++++++
 drivers/video/Kconfig                              |  10 +
 drivers/video/Makefile                             |   1 +
 drivers/video/panel-startek-kd070fhfid015.c        | 268 +++++++++++++
 31 files changed, 1669 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 create mode 100644 arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
 create mode 100644 arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
 create mode 100644 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
 create mode 100644 doc/board/mediatek/mt8188-genio-evk.rst
 create mode 100644 drivers/power/domain/mt8189-power-domain.c
 create mode 100644 drivers/pwm/pwm-mtk-disp.c
 create mode 100644 drivers/video/panel-startek-kd070fhfid015.c

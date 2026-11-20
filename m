Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB5606A688
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vj6Dxn1T;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q0bFqB8F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B37B181750;
	Fri, 20 Nov 2026 22:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kyUgAAQu3Q27; Fri, 20 Nov 2026 22:34:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C21338133F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795214063;
	b=ZAxaY3SKlUzR/y5ZCeGrWcPlDOl4N3r9bYsKqq0vB1IJPU5Eo7ckVzQwmPQm73zUJiSh
	 Sjg+8pCWuKN5xKmCaRmi6BBoTZrGQqqJ+GATsH0dkVMBWmb8G8Ga+8gQOWM+hCcjnc1x/
	 XGbme1FesSFhr/eB8HMpRK/w553qAlxX/IeUD/P12r00e6rsYb3jK3eSM4wtrCa3LF5ON
	 omK3rnM1U76ApXJtZpj4wjY27WfBrmhx+4fXN7fuXjxJH9WE/eRVV3nMnUhP0c2Czt3NX
	 oP2g4rZCDt1F++4uy7jlJxcr1LeQr3F0t1mwecXl5ASGI1q18LrZZuwEfRXlllhHXPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795214063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M3JebDv/H/a80Td2g+dDf+zq5ldxC/wVJG8tsisLTAQ=;
	b=c51s0ndV48J/UjuUd85bemaCnkm5r+mlCiHH2z84sQCefVUzvc0XJuQ29quR24/35N7I
	 exWbZXCqr1h0S1g9zKQGCwqDLz2F6ONhitS7tmm0KDl6t7/6GD1s1IVM5+rDdIQw+uUAN
	 eDgUwdVQcFNKPW5QpAlEPQpAKHP61KOhzDgyev9w/h4X2r7VS+UeKhy58bXP4GN9aY1uY
	 4u1SaRcdUMaBGY+p5puOEpbG8Io9IOgIqHLmWJyLjpSnybCTNCal8zomi8QzXJD24n9oN
	 hgAYZuzNhJ3Opmz8bPxqY3/p94IPb09PoL9I5Ae8TJVldw5LHV9CSsnjPlsa9hAiWbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q0bFqB8F;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795214063;
	bh=M3JebDv/H/a80Td2g+dDf+zq5ldxC/wVJG8tsisLTAQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vj6Dxn1TAprJz7sm7OAEUkbWe12ykqbbToA8BQpAD6yA1Z5LzRAyfmzWh7YcD/j6C
	 S8CEn3+2d1Q2D1bQ8tv1mOJkPURnvW4tRF5kazNEFu6vBqVJTC7B5ODd2hnpRSNIh/
	 DHorOjaAToIh/UJtLoG2Wgtg1A5lBWxcVztpH7w1Nbj5UwZ3V3/wS8H3IqEc1L08wa
	 8MpvHWxbLwBPDmiC5q8KZqjqG6/fHVBlemeO4w7hITWgkJYTJUmjGTQzect1jN/5lq
	 XNdyl89AkCDt9waQ9xNSUplh6yJifRZFpCGMvwvWIDeM6VNKQogFvC/6imhRHhuPpm
	 9FLC2U4eGVWhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C21338133F;
	Fri, 20 Nov 2026 22:34:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04EA4465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 021128133F
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdGfUg8oaubA for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0EAD9811D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Q0bFqB8F
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EAD9811D3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:34:21 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-486f013db83so532596fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795214060; x=1795818860;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M3JebDv/H/a80Td2g+dDf+zq5ldxC/wVJG8tsisLTAQ=;
 b=Q0bFqB8Fd7RyR2ZWerA7USLf4kQg2toYveXeScITu05NTj/kL9XY1M2MdZR6mfCYeR
 Un2uQ/mHDsQllOSWoUdO69Gm0idYL3lFfT4Sew9j4CQbW5oFujE8E7qMIKmRYRWOpN2L
 YTcLE+bEJix4AVIfFamPLYP65WKwXpAT7hIHHI4sKGQdBjY5cyAyeGtCDKCPmQx7WJ5e
 2r73QsJWeKJ/TAvGhkn/SMTvhe3RLI5S/7eiUHa9fGU48WzHdN2sv1eH6rcKcQSl6hsI
 RQVuBIYzgvZvqZooYFPKfIngvuCmwIyOhmOAkqf4rVR8sGNylnpRUswON/ILek4PbTTO
 yHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795214060; x=1795818860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M3JebDv/H/a80Td2g+dDf+zq5ldxC/wVJG8tsisLTAQ=;
 b=2hctnHZWuz7aZgGNMGM/XC+vXPtRsmKX5zRL/ja3UYFDb6OUiahif7uidMjhxdG5Zy
 SzNAUgiJb9xR9J6bgYaxOuFDo5GT4EmTPWI57Z9QklWgMB+o7EmToeLZtJ1Yaysj3vJc
 3mVFobuvyp5P6TNY1fHZtkN5fx1ZI2iXqazz3ClLht8fFBAIz34DOQg+AzofRmYqCIKY
 QBmzdHodEUzK+KxwUeMPFsqU6HpxbpywmvZZWN1DaUEGa9YZQPTjroWw5npZAAZ/gEya
 dRY6zY0QtXeTh5HnI8msX7LFBs5LQjc4dkUPfbTBiHcuGOWrjH8PD6uBWMiKFXomouZG
 f9xw==
X-Forwarded-Encrypted: i=1;
 AL+hErFA7meVoFa7xpyWeGsZzPYYcP8f2pRp7zB04svV7jN7sC/yie2iXECEXu30QVBdcWqvbBzsGrk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+cZOhxluauaW7z/6a4bF+r7LnVFjHCA8zQONwTKcddrMg++Loa
 uZvOgEUdkThOEO9LHvj/s+GOq+7ATjWeQ/vLwdWh5qkr6BWenz44auufLO0U7CXwaY4=
X-Gm-Gg: AZFdTZfJtbA6yTcRZwLWsEeOwoPoKZuWKU+4SXOJ38QKdpogbPzEGk1/2dXvciWPmR0
 toRSos0vKct/gC+oDEGJ/ClfT88bfPTuiaIsFfMml2qPtEqTJywY58kALe+xvLOv75BZSdneH1m
 KCXgjykqnUGsPA0prI5ecmMZPn+p54XiBy9RbN1WwFAQqxbp1i33k+UQx7P2yCXCwj5tNfkcs2V
 HVpUxwxyt+P7KdIqlrxn9YmdnEisa57VTGnCOOo6KGVf/QiwCBmbUFJlayHSEHmfy0cYyhfGcHH
 U0RpDG3M/PB0wP05dheEyNAscU20bp8LVx9tQIPqEf+QmAaTBHsOzp/bggYY56rIgEw2rIFO6Kf
 AxccZrObs2iSUkx3MWFNoiVMXAT1nPL3FjxOWceU81swaTr69Nd52FmzUsPgykPAHtBLpS/M5dT
 Z3QgvKfBWMzhh64uk4kxA+JybSaNB/h2rA9M86uTsQS4BmpOWyfGtPg61c7rMl1r73qOptIj7td
 W8e00MBjNo9cnR5VNkyEUyNshYHTkIDdZijTajE13BaNMVRf9IKS91URFSbKIAcX9yTVrkh4hgl
 Hdw5B+C2I6Rlktccmn0APqGcsLKQxQ==
X-Received: by 2002:a05:6870:c34f:b0:4ad:5a7a:f7e5 with SMTP id
 586e51a60fabf-4bc821920acmr4697259fac.18.1795214060147; 
 Fri, 20 Nov 2026 14:34:20 -0800 (PST)
Received: from freyr.lan ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm3903911fac.2.2026.11.20.14.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:34:18 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-11-20 into next
Date: Fri, 20 Nov 2026 16:33:36 -0600
Message-ID: <20261120223414.3914-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit d22f61a39fb68bc697e67df45f2e3103378bc7cd:

  Merge patch series "Prepare devicetrees from FIT configurations with fdt fit" (2026-11-20 11:47:13 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-11-20

for you to fetch changes up to 80d7646f39e7b610a838bb5ec38f7f618387f92d:

  doc: board: mediatek: document Genio 520 and 720 boot (2026-11-20 16:12:05 -0600)

----------------------------------------------------------------
* Drop unused fdivs_offs from MediaTek apmixed clock trees
* Drop duplicate dt-bindings header from MT7986 clock driver
* New SPL and U-Boot fastboot download agents for Genio 510 and Genio 700
* Document the Genio download agents
* Fix MT8189 reset_cpu() prototype and use phase-aware PSCI reset
* New SPL boot support for Genio 520 and Genio 720
* Document the Genio 520 and 720 boot chain

----------------------------------------------------------------
Carlo Caione (2):
      arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      doc: board: mediatek: document Genio download agents

David Lechner (7):
      clk: mediatek: drop unused fdivs_offs from apmixed trees
      arm: mediatek: mt8189: fix the reset_cpu() prototype
      arm: mediatek: mt8189: use phase-aware PSCI reset
      arm: dts: mediatek: prepare Genio 520 and 720 devices for SPL
      configs: mt8189: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 520 and 720 boot images with binman
      doc: board: mediatek: document Genio 520 and 720 boot

Julien Masson (1):
      arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700

Lucien Jheng (1):
      clk: mediatek: mt7986: drop duplicate dt-bindings header

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  64 ++++++
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi      |   9 +
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi       |  81 +++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi      |   9 +
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       |  14 ++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi   |  62 ++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |   3 +-
 arch/arm/mach-mediatek/Kconfig                     |  69 +++++-
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/download_agent.c            |  85 ++++++++
 arch/arm/mach-mediatek/mt8189/init.c               |  14 +-
 arch/arm/mach-mediatek/spl.c                       |   3 +
 board/mediatek/MAINTAINERS                         |  15 +-
 common/spl/Kconfig                                 |   2 +-
 configs/mt8189.config                              |  34 +++
 configs/mt8370-genio-da-spl-fastboot.config        |  21 ++
 configs/mt8370-genio-da-uboot-fastboot.config      |  29 +++
 configs/mt8370-genio-da.config                     |  12 ++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |   2 +
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |   2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |   2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |   2 +
 doc/board/mediatek/index.rst                       |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 135 ++++++++++++
 doc/board/mediatek/mt8189-genio-evk.rst            | 238 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mt7981.c                  |   1 -
 drivers/clk/mediatek/clk-mt7986.c                  |   5 +-
 drivers/clk/mediatek/clk-mt7987.c                  |   1 -
 drivers/clk/mediatek/clk-mt7988.c                  |   1 -
 include/dt-bindings/clock/mt7986-clk.h             | 178 ---------------
 32 files changed, 908 insertions(+), 199 deletions(-)
 create mode 100644 arch/arm/dts/mt8370-genio-da-u-boot.dtsi
 create mode 100644 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
 create mode 100644 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
 create mode 100644 arch/arm/mach-mediatek/download_agent.c
 create mode 100644 configs/mt8370-genio-da-spl-fastboot.config
 create mode 100644 configs/mt8370-genio-da-uboot-fastboot.config
 create mode 100644 configs/mt8370-genio-da.config
 create mode 100644 configs/mt8370_genio_510_evk_da_spl_defconfig
 create mode 100644 configs/mt8370_genio_510_evk_da_uboot_defconfig
 create mode 100644 configs/mt8390_genio_700_evk_da_spl_defconfig
 create mode 100644 configs/mt8390_genio_700_evk_da_uboot_defconfig
 create mode 100644 doc/board/mediatek/mt8189-genio-evk.rst
 delete mode 100644 include/dt-bindings/clock/mt7986-clk.h

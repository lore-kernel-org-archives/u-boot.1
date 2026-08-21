Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63D4C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 615F36104F;
	Fri, 21 Aug 2026 13:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTMTBdVQsQyw; Fri, 21 Aug 2026 13:17:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318077;
	bh=RL/69i8TbXeToJ/clC/EM1MXP2QwwjK6LtZb5BIvTZw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZNzgZ2J7hsi9Rz/kXu1zS2lTuiO/5jFFF5zbgh2zdGalvrzyFo7hbj2wkk/Zs8VvD
	 xb2o6edtDtyJZ2QBo7c19+Ur4KkfOJWl1S9FO7GbU/D7sXKDVA7WOheeQT46OPKxPM
	 Ll1OUxzk0BbEbbArnJyQJAsR1laAkKprhgx8T/prVojGPkE3f3oaK3eDkiGdpCp+5n
	 QrtCYDNp4zJUPaBXv9JMq1EWdDVaqyLHURmW03OGqST7dEvreFgZL5qbDZ5KLDR+1e
	 hoqKIi6yS55I3mvYG9Lmi5/RIMX2gxR7AuFBiBW7CStkyTjjwznTkLhMC3MyuspVpW
	 mzUyxe90x2QNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D005B60DE8;
	Fri, 21 Aug 2026 13:14:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF1A0263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0C0D81137
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoXsJdMbV1bg for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:46:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.44;
 helo=mail-wm1-f44.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=linux.com
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7E108111A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso4763465e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301967; x=1787906767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RL/69i8TbXeToJ/clC/EM1MXP2QwwjK6LtZb5BIvTZw=;
 b=rXH1tt5ZXXUhwIoAyG3pc/8FmRFemzKQ6IR1u92rMxcoqoktEW3xxRSqVkl+eXTiPM
 x9UfPi88WlfpF7ZLahAVSQu4ea2dVrqGEA01EPXjU11YpBaUAOPRi/QwzsyS71SxlBCf
 iiYbR02fLhaHat0L4+1ddxneAJj5c1Ba+AlE5RyBrc7bugWwS3j0qg+eaTRPIpsK0Gzj
 AL4nsytyMeos35iOl/Y9Uwny8FzUcum4wx+qcC8CQ7QTXIPzXynDLK61Kf6dug51jsn0
 DhoBqQpy6OQz0c8m/QVA/XStC89OV2ZouwWu7i8GN+9qeduN+5XgIbwNEF1pyLGP+PsP
 Uqbg==
X-Gm-Message-State: AOJu0YxvEsQ1RRG1KLjbpyuomtmDMRXnotzHprPyEIfDAMUDR3JhX3Sl
 vzsv7tCNCTCRJrimJf/IkFXDOHlN8EP1Oh5yhvilae1eSqkm9X0KqMV6FncioA==
X-Gm-Gg: AR+sD12WPOgpijHvLgd2NrZNQGWqHMDEp3KxJUaDi4za3ljsOvXayCgzL6EMLE5zL2h
 ZDFXETQeAJZVAV6Fjv+E3n14JjXrv54FG7V/S4zqo5jcT8LgoFtalKTRckVtwe7TJwmOF6Isiu0
 ZjAOtNth4vRNcrbYTjpySyG6l7Ay2adU3cInpFFFoYAHA2A/4lLVFg6qE1MLvx+9SUOIyMzbHt5
 cf8aIUeqa0XtMIxKiGbKo+8aFBiUjoOVS9tONAbMom+wdjbjBzYqVtTtgUq25+bJohF/6JplfRh
 2iUNIdVL1AIvGLzx99D6Y+ucTQXjFMA4ek1eLg1PwlumCDvm6xI8N+lKD33KmR32kJ1yXzbYZDf
 pEE3K0K+VwI6KFc7sgG93kIkwQIPvhWMxCjibX9B+RqRKdAAZTKzBVg/SkNXTnGmqU7YjpbcKZf
 g8sFdemeLfPrfZgoMv74ZmE5oATZLr9BkbLfGyvyuqnrGvCGJMUCvLCSIuuIIfrgdu2O7rKK8Zk
 pANszjfyeQNTu8eduJ9Prh+nN0=
X-Received: by 2002:a05:600c:3107:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-499b82b4bdbmr60131615e9.7.1787301967403; 
 Fri, 21 Aug 2026 01:46:07 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:46:06 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io
Subject: [PATCH v2 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
Date: Fri, 21 Aug 2026 09:45:59 +0100
Message-ID: <20260821084603.25974-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
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

This series adds initial mainline support for the Amlogic T7 SoC
family and the Khadas VIM4 board (A311D2):
 - S4-generation UART support
 - the T7 platform code
 - VIM4 board and defconfig
 - VIM4 documentation

Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
(tftpboot) and cold-booted from an SD card.

Changes in v2:
 - move the T7 register and reserved memory defines to a new
   asm/arch-meson/t7.h header
 - shorten the MESON_T7 Kconfig help text to match the other SoCs
 - drop __maybe_unused from meson_init_reserved_memory(), the
   parameter is used
 - move the SoC-level bootph-all properties to a common
   amlogic-t7-u-boot.dtsi
 - drop CONFIG_SYS_PROMPT from the defconfig

Lucas Tanure (4):
  serial: meson: add Amlogic S4 UART support
  arm: meson: add Amlogic T7 SoC family support
  board: amlogic: add Khadas VIM4 support
  doc: board: amlogic: add Khadas VIM4 documentation

 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi |  16 +++
 arch/arm/dts/amlogic-t7-u-boot.dtsi           |  14 ++
 arch/arm/include/asm/arch-meson/boot0.h       |  18 +++
 arch/arm/include/asm/arch-meson/t7.h          |  25 ++++
 arch/arm/mach-meson/Kconfig                   |   9 ++
 arch/arm/mach-meson/Makefile                  |   1 +
 arch/arm/mach-meson/board-t7.c                |  82 ++++++++++++
 board/amlogic/vim4/MAINTAINERS                |   8 ++
 board/amlogic/vim4/Makefile                   |   4 +
 board/amlogic/vim4/vim4.c                     |  14 ++
 configs/khadas-vim4_defconfig                 |  26 ++++
 doc/board/amlogic/index.rst                   | 119 ++++++++---------
 doc/board/amlogic/khadas-vim4.rst             | 122 ++++++++++++++++++
 drivers/serial/serial_meson.c                 |  51 ++++++--
 14 files changed, 437 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 arch/arm/dts/amlogic-t7-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/include/asm/arch-meson/t7.h
 create mode 100644 arch/arm/mach-meson/board-t7.c
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig
 create mode 100644 doc/board/amlogic/khadas-vim4.rst

-- 
2.55.0


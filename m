Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D5EC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6D28796E;
	Mon, 22 Jan 2024 14:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yld6+wtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DF48796E; Mon, 22 Jan 2024 14:03:06 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB1487960
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3ae9d1109so7504715ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928582; x=1706533382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g4WWq8Z1wj+yoT2vDtBlhYNpKh3Ops0F94mi3mHupXk=;
 b=Yld6+wtOEKQ3F/9nmeRguAGQuEIVx70amGFQ/gDl/GrKn55CLObBzje/W+3Oszk4f/
 QyX5B7Mo/ymEqiRxIeSizCFW9NalSu2q3ToV4G6FUqDOXfAOndod3wGWWIUGGyfKP7uX
 XbQ1x6tZ83XCym+SECkpbSWRAnir0BBG5yuEeL3ZQ0ATA1ezGzzvrrROywMSlujXFj7W
 ZpwcqAVmP75CBDUbvN9NyybPNdaDGaOMZ5owrjxZ2yfxoHiflJDQlgvck3Fx+7per3iD
 KnQSAX4PoUHJWUMoE+3RY2PUxr4ZauhDWKjfLGVIsWtagq/AfPlw5LP1LbNcW9j3xT2g
 iMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928582; x=1706533382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4WWq8Z1wj+yoT2vDtBlhYNpKh3Ops0F94mi3mHupXk=;
 b=VLVJOBYBjROGkQ04NIuziDq1c6fua6yB0UK1knDw/LD75aM+6jMnGZaduQ0zATb5n6
 +i4VG3znmtgiq1FLbmHVQwSlD55D7+5RfVWqUbh7GXT5S+bUQh911EKmHmNaMMLFpmrI
 iNTs9EDHKctnBqU8DjkD7LjW6tsTwi3ilJTe/60oUAtX/aNZ66/X6gmySb+Yi9LPrS7B
 3BQ1/Y+yc4ExkDPCtzhJNsuYBv+KC0RbAt+GA9rffU/Rp19gIJir03taTRdX2q22gGdE
 YYzKmVaDP0DWH0HLJGI8l0800C8JEVcosaGga6pTxxZrfxpvlXVlLE6QQivhrsDq4DdF
 iZ/A==
X-Gm-Message-State: AOJu0YzrCBJgZiUS9Il9WJPrDSSJ00EZrmGW6qdTuRjrUSAPYMXg8Frw
 UkZmVmzw++or09NP1Ds11E7xr7pNxEmMMU7m0w9ZlsYkFreM+Z8CvjD0Rai9
X-Google-Smtp-Source: AGHT+IF1ftPqM0zug5l/wZ0ZsHao5ie6i8jBzZmXwQwq0hcTuUl10+eBNS0XK2fsO7l+d994uAg2SA==
X-Received: by 2002:a17:902:ee11:b0:1d6:f13b:e58e with SMTP id
 z17-20020a170902ee1100b001d6f13be58emr8440352plb.2.1705928581951; 
 Mon, 22 Jan 2024 05:03:01 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e37a:e59d:de82:7f2b])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a170902ed4600b001d73ac05559sm3006662plb.184.2024.01.22.05.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:03:01 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-20240115
Date: Mon, 22 Jan 2024 10:02:58 -0300
Message-Id: <20240122130258.1161602-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx, thanks.

The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f78:

  Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 11:39:13 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240122

for you to fetch changes up to a80e0e7711a2b2890a583d88dcd9af978ddada32:

  ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM (2024-01-22 08:40:02 -0300)

u-boot-imx-master-20240122
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19406

- Allow i.MX8M Plus DHCOM to operate in overdrive mode.
- Allow i.MX8M Plus eDM SBC to operate in overdrive mode.
- Enable the 'kaslrseed' command on DH i.MX8M Plus DHCOM.
- Select LTO by default on i.MX8M.
- Convert pico-dwarf/hobbit-imx6ul to CONFIG_DM_SERIAL.
- Fix 'reset' command on wandboard.

----------------------------------------------------------------
Fabio Estevam (3):
      imx8m: Enable LTO by default
      wandboard: Convert to watchdog driver model
      pico-dwarf/hobbit-imx6ul: Convert to CONFIG_DM_SERIAL

Marek Vasut (3):
      ARM: imx: Enable SPL_BOARD_INIT on DH i.MX8M Plus DHCOM
      ARM: imx: Configure GIC clock parent on Data Modul i.MX8M Plus eDM SBC
      ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM

 arch/arm/dts/imx6qdl-wandboard-u-boot.dtsi  | 10 ++++++++++
 arch/arm/mach-imx/imx8m/Kconfig             |  1 +
 board/data_modul/imx8mp_edm_sbc/spl.c       | 13 +++++++++++++
 configs/imx8mp_data_modul_edm_sbc_defconfig |  1 +
 configs/imx8mp_dhcom_pdk2_defconfig         |  3 +++
 configs/imx8mp_dhcom_pdk3_defconfig         |  3 +++
 configs/pico-dwarf-imx6ul_defconfig         |  1 +
 configs/pico-hobbit-imx6ul_defconfig        |  1 +
 configs/wandboard_defconfig                 |  3 +++
 9 files changed, 36 insertions(+)

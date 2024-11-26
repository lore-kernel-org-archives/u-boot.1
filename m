Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F260DD5A6FD
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDD6895E9;
	Tue, 26 Nov 2024 09:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="ZPHAFMk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE11689BEF; Tue, 26 Nov 2024 09:27:50 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6355688F55
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dse@thaumatec.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4349e1467fbso17276245e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1732609668; x=1733214468;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tmff6E4D8IbI63OAVf9Rad5IjnVp/1bJxUQNXfpsBKE=;
 b=ZPHAFMk5+tFhoU4hCkaJvhcihsb5jXqYLBuqcRbwbFL6yARcMquDkHBr1Wy7il8JFW
 DJYnVOn/eBP0VmyEqo+nL4qiM4bssy5pnoz7ZBuN3Te9rn14Clp1QOesNnNbqHqVawDL
 OuuCfuvboRoFY2eGYAgtMF6lq6KSdgHDd9fehfw63hIJb+7n1PuBB3/aAQC7L+4XAMXu
 ZWegtw5/OaYpm22OFL5ciAsVR/vagTgOzhBIMKlJFXyjjDkObNF1ePSPC1JOMH9oLzkL
 nNRx5llW1n+mEg++bFVVDuHqSqah1P/QKNEhFztqcGMz93tsKH5k0SjdC/lXOI2eY4cF
 ueGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732609668; x=1733214468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tmff6E4D8IbI63OAVf9Rad5IjnVp/1bJxUQNXfpsBKE=;
 b=IqAUDRCAa8PuWpekbktv/Vj5MWxhqKvJE5cTBvcrzgCxi8KIRrUrcefqojNAZqe1NP
 y3oXTyxfMMGwTjzQKKA7ltoG018Ac6t7gaIhfWTVb+DLAQy6Py04vO5FauMuJiWEl+cD
 emrdnzZ5zRIEPwmU+EDD6JmHCmwII311G2qJbr1/08qaYdASQYBQufC7EXq/mAYB1iBx
 X1bTSyz4ZnJAgpqWjQ2oNHDzVrxDZIQ/y4N52bP32hsHFXBI6qqqkcd32fUah7B/YFOZ
 hjOkwoylRhc3abIlzf5jKVWF+vcV2CTYqm+OTeUDR6p5qzJ2WmXVO0xB6ImTHa9kxxku
 5QwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYpHru9apeGfZCOq7eWxRq9bGnxXTVXsSwzoAncukDmLte3cfxCyJ0mgAofIW+pNsXTM8vUQI=@lists.denx.de
X-Gm-Message-State: AOJu0YzBaFQEJsHft/GfALSEqEQyIRclzya6tkdBIjupIaYuby9qw8d7
 RXKWIiJLIgfEk/o2jOwuIErXmCToBGDSSi9Nfxp0h4RuUA7kWgis88Zl7+t+lks=
X-Gm-Gg: ASbGncthb2StjFA/QwSpEIug2fjId0VlJbkK8jkQwrItbGTiJW5AVKjgH5e2g+VIZC5
 0sLsWEpbPNSEkOLhtd86ibaFl962rr0tDlj04rzyKku2x6thfwbQtf+2QhBj1MxBzIaoFRkmrC0
 fHsRvyRGCwURn6KTpNB9AFtJwh206Wijq2rOw7Hxl7HMDy/5dwxVL/9sHtUQKqB0lNfpe2/N17u
 j2KSCMNpZhjNr0bB9r6bEtth4fMvksHUKLHtJKP
X-Google-Smtp-Source: AGHT+IE7yB2GXBGUIDLgUPtwdxIKR03VILlv6Z7q/9HU8QTsgWw7KV9gwRhIHXTTliw0W3wS4HADdA==
X-Received: by 2002:a05:600c:3d0c:b0:434:a781:f5d2 with SMTP id
 5b1f17b1804b1-434a781f76fmr6987715e9.5.1732609667767; 
 Tue, 26 Nov 2024 00:27:47 -0800 (PST)
Received: from fedora.. ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349f9eca01sm64228875e9.29.2024.11.26.00.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:27:47 -0800 (PST)
From: Daniel Semkowicz <dse@thaumatec.com>
To: Klaus Goger <klaus.goger@cherry.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Daniel Semkowicz <dse@thaumatec.com>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] board: theobroma-systems: Update TF-A setup steps for RK3588
 boards
Date: Tue, 26 Nov 2024 09:27:15 +0100
Message-ID: <20241126082738.14854-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.47.0
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

ddrbin_tool interface has been changed. Additional chip_name argument
is now required to modify ddr binary file. Update documentation
to be consistent with the new interface.

Update BL31 and ROCKCHIP_TPL file paths to match current version
of binaries available in the rkbin repository.

Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
---

 doc/board/theobroma-systems/jaguar_rk3588.rst | 6 +++---
 doc/board/theobroma-systems/tiger_rk3588.rst  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
index db15f945d3b..cba4fd066ab 100644
--- a/doc/board/theobroma-systems/jaguar_rk3588.rst
+++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
@@ -40,10 +40,10 @@ Get the TF-A and DDR init (TPL) binaries
    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin
    export RKBIN=$(pwd)
-   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.38.elf
-   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.11.bin
+   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.47.elf
+   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.18.bin
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
-   ./tools/ddrbin_tool tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   ./tools/ddrbin_tool rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
    ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
    export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
 
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
index a73eec7fb9b..a01c0500b49 100644
--- a/doc/board/theobroma-systems/tiger_rk3588.rst
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -40,11 +40,11 @@ Get the TF-A and DDR init (TPL) binaries
    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin
    export RKBIN=$(pwd)
-   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.38.elf
-   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.11.bin
+   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.47.elf
+   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.18.bin
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
    sed -i 's/^uart iomux=.*$/uart iomux=2/' tools/ddrbin_param.txt
-   ./tools/ddrbin_tool tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   ./tools/ddrbin_tool rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
    ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
    export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
 
-- 
2.47.0



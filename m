Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42B606A6BC
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cj79x1nM;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KrCdv34e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA08A60EBF;
	Fri, 20 Nov 2026 21:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1eZ9wsMxSrW; Fri, 20 Nov 2026 21:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C553160E89
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211463;
	b=tJYt8g4tUuSOz3Bcx17n1/Llm1PuekJ0WUQuUlweQwu3M/92JOR8oFAegsigGmzXuzs+
	 4Bzvr0375fI4LKypvNfQBxJphtMQFERE9ut9lhItqq0U32KQBH4TfSduilMlfzvaBSMu0
	 2rueyMZW+jEfhts/Sd6jXuT3IvcORQbiaa65+BOlFtriJC1IIvpA2LASIE8iE7TKDkXKA
	 SPWTybeyotO+E8xsGBiqYqyDe/xTLQ/ghvhSqk5gUux7d+23c2R8gelQPhy5zXaCUvSH8
	 W7kdaWrIGUe/xtETkE+FhZlLUoVfeAtWzeYYiGcjjOtnJ4Uai4n4RH2xFNlvX9SYybQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FEV3Gem3e92b7irjNq9uhQ3MhVDqEBz9l/Equ95OouU=;
	b=F5i0v7oMsprZMoLmL6N1ZottRa8sqJp1iBtBomNpP7jJGjm2sXGbFfXgciydMcu5U7z7
	 3yJjzZH/Aiirx4TZEmcv0hT5pYwQF8oEqdhntBzmmZJZANFNYeqGA3mQOzoXySXjk9PpL
	 l+dAFAvFlz2flhccWvUXmjtrCANzrUt77yP8sdY6TM75XR8BrzHuSEZ/yj3xNmI82GHkh
	 KirI9bc7YgmtKEQGA5gpXVqYY4EH5nFVS6SEitXpVpQjn3ua7tJ6lUVXaIj4JUN65D+/R
	 XD3ZfCtpXi2KEkbgSLX3T2oxTlz4NJMU93keZSzJ+WMf1uiPKQzvpf2JxPAjwb4dXRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211462;
	bh=FEV3Gem3e92b7irjNq9uhQ3MhVDqEBz9l/Equ95OouU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cj79x1nMkYg9Y8UEZVakish29G4HjcUd6WZC8MFzoO/MFGh9D92F0Q++Zzt59Iym9
	 6kobqUEhC0LlM3yCo6tIkT7VOmsTOHblDIxBZRkpbYJV+PpgKRwXwdTIpzR8ayFS6E
	 GPOfYG0F6kyzeOYMY8m5h2U3JRNxhldmFintAV+c93phBT0O0lsQcL4RUiyOJCKhPk
	 ZsMmd4XAL3ZfpDZqlBuy3Q+VYRGqiMC0B1LgTEpFkrc97EYK6WFF9cRIo7MS1otuGX
	 vUkNpQZGb+b/zsUO4a+inrcTFpLQCezz/2Hj/3wU0uukFrtYMPB90PDkW8cFiIbLWw
	 Ct15/9Aky5Gbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C553160E89;
	Fri, 20 Nov 2026 21:51:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B4EC465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7170D81858
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsiZ-WI1IzZ6 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62B8E817B2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KrCdv34e
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62B8E817B2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:57 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-71ad1db7e31so1719390eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211457; x=1795816257;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FEV3Gem3e92b7irjNq9uhQ3MhVDqEBz9l/Equ95OouU=;
 b=KrCdv34eguwtfW3Tmq7va5bRHQfryBliWumNKzVm+M+THlk+tIHElhbKpvxi7NYXVg
 JebhJiiFEE+IexSZe0QMR6pS1UESZNStZTUXNfMWlSZI3ZrpA6azcSHN+smEMp31pzVw
 io4PnJgkZ7qXh9LqZhPI4XlVvgAYKMMlrGhikmp7vBbXNKenEEbRLE/oO6zKDjml48g+
 yquNdWbU6Vwb0bOYYtUWu9BtL1UTTkwaP9+XErbF+kpkRaXGngHj3ERAWhAXG+MgK2km
 2e8XGGgOs4lRJAxZBBqF0wjdrst6phs1CeJfPTgFzy91FmgC6PPAcbkF4ayXJb9gb9ZF
 D2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211457; x=1795816257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FEV3Gem3e92b7irjNq9uhQ3MhVDqEBz9l/Equ95OouU=;
 b=PD7VnyyHrfyJhy85qva7v3kqIgc7s5YVIKRzn8KNDjWvmwjKBPg40V37LQ9V7Wwj2d
 27Sj6h8yIZaUWJy4V8xYDZ1sdt+pwDB7AvJ2N6XYEPenXs/FzGc/cTvj5HSLTP8kNOqm
 GkY8BUBsG5G9UtHYR2oXt/bBqezPn2dPf53yLa/KUC/8XDQZNhDMtSV5FLn4nuvvjjO8
 cuh31Y9JIBUBQSK2pFCINHk+MqNVdaY/cG5JnXoOMW9peI1Yv+JA2vwFDqvlmb47Yq5n
 MzBcku79K3+OJ/pGcAJcTqjeMGdEqNnONYCPDvrq5yCXVucHzdysVYPHgP0wuwJRUdP9
 0IeA==
X-Gm-Message-State: APuU4Z8CqQTh5khpIIJ5mP9Hzhb1Zn1ToD7176xAXw+gJinzeI0Xfy49
 XnK20OTmtEQUbGDJTizk6YJn/OaOGvhLeok0/8fcwYtdX+1DevVBHnDv6uefE/QVCa0=
X-Gm-Gg: AYBFou2Qir8E1tK6NtK09lkY/p8FPPEFXFNhuLjEp28UANwiDLpeXTjhVU48tWzlgPr
 jviGUMWDsPNCHaoCd9VSX7q7HmKVnUmNTpVTgBAOpXoh2j8CIIbOUViHwflABWNjgXZvk5RDeJn
 dNqVf06Z5fgTc0YHgkFIP1J8y9i6cYKWRtmAstHA0vwwvathrApQolLjA6Ly3y7Rjlp9XHNeqG4
 0gwnA15PurLdwwK5rsQ7UFTvVl+BLJRZCMENJKsfW5pldw8il7m19QRX9lB74LiAwf0WJp5Tf1x
 H6y/kJe6r4M5uEYlU5bbKxM91I7/AHF0B+ytaGJRjSvyCG4HObFs7kqZ/vYZzgnbGexa3o2tVSS
 sf0B8YuuiYsTuM9o7PYP22fZ9S/m63vEBO1CcMiTmwrOv1uS8IHQTCwopbMX7I/+4XQ7gS6LpzE
 VKH6W81Tph4PIDyxhFnFhAcAOHTG182gAP5R4bEekC8SPjps3hIKYw5FGOPiI3aVikO3a1RWLkQ
 Wu8U3knuXQTIjRuEktbiU7EhTthkQacwJOf2BbXkVY95k8g6gObmNxdkAb7xRINPB5EZuYH3r9q
 KkJc+H6BDBUlL1+7MvSUdrfmcqQ1Lhws
X-Received: by 2002:a05:6820:8c5:b0:71a:f676:6153 with SMTP id
 006d021491bc7-71b3267b78fmr4528238eaf.13.1795211456790; 
 Fri, 20 Nov 2026 13:50:56 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:35 -0600
Subject: [PATCH v2 8/8] doc: board: mediatek: describe booting Genio 520
 and 720 from UFS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-8-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5710; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pqVRJot5K2TOrpLMr5SB79f0TyjR8TeSnYbx0LLG0IM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMClRH45kN9x9lQRid3n6hMrYCCHf/2rS4+rm
 B3mAss9jeSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDApRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AN2AH/Rf3ce+cBpvtnSmHoLJ9PM1vmy6T4MsknyZelzn
 LmrDdWY31JdkhGtJI6qf0zVArfX55hpgTigByecF5PTIZuZzPpYrUVl4X0aN3BIYgzEe59YVrOp
 24g6rgxzfH9y1r+i8e63uiZEti+UhLoABA0tOGjxc6GjZEAipdZ5Zi7xOZvCjHwIs0sGIFQcXpr
 iFZF2GiM03CdCyZugy4JvPTmtErsCk6CgAsK+FwyvW3v5zFLn3Lj3lg508moMsdOMS7y6fEybVv
 gKvP5M/r5AzetJ8lZB3zOwwtzcGdxMe5TG7mmEEROGL7pT5dCxjNyFqsJZm/Rg3rsUsVwpvh4JE
 0xNU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how to build and install the firmware images for booting the
Genio 520 and 720 EVKs from UFS with U-Boot SPL. This needs the UFS
config fragment, the UFS devicetree and a DDR loader built for UFS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/board/mediatek/mt8189-genio-evk.rst | 49 ++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index be6c9986fa8..69b696201e4 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -99,6 +99,15 @@ by name.
 Make sure the DIP switches and jumpers are set for eMMC, and use the default
 devicetree.
 
+To boot from UFS instead, set the DIP switches and jumpers for UFS, add the
+``mt8189-genio-spl-ufs.config`` fragment to the configuration and use the UFS
+variant of the devicetree, as shown below. The BootROM then loads
+``mtk-boot.bin`` from the UFS boot logical unit, and SPL loads
+``bootloaders.img`` from GPT partition 1
+(``CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM``) of the main UFS logical unit,
+which is SCSI device 2 (``CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM``). SPL is built
+without MMC support in this configuration.
+
 DRAM description
 ~~~~~~~~~~~~~~~~
 
@@ -188,6 +197,7 @@ Setting                                Value           Size
 The DDR loader must:
 
 * initialize and train DRAM,
+* when booting from UFS, leave the UFS device powered,
 * copy the complete ``CONFIG_SPL_MAX_SIZE`` byte SPL region from
   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR + CONFIG_MTK_GENIO_DDR_LOADER_SIZE``
   (``0x20a1000``) to ``CONFIG_SPL_TEXT_BASE``,
@@ -202,11 +212,12 @@ The DDR loader must:
   register convention.
 
 SPL obtains platform information from its embedded control devicetree and
-initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
-drivers.
+initializes the console, clocks, pinctrl, watchdog and boot storage through
+U-Boot drivers.
 
-The MT8189 BootROM loads at most about 930 KiB from eMMC boot0 and does not
-start a larger image. The loader and SPL regions together occupy 896 KiB,
+The MT8189 BootROM loads the boot image into SRAM, so it loads at most about
+930 KiB from eMMC boot0 or the UFS boot logical unit and does not start a
+larger image. The loader and SPL regions together occupy 896 KiB,
 which leaves little room to enlarge either of them.
 
 The DDR loader runs from SRAM at the load address, and the SPL region stays in
@@ -223,7 +234,9 @@ firmware images:
 ``ddr-loader.bin``
    A MediaTek DDR loader which initializes the DRAM fitted to the target board
    and satisfies the handoff contract above. The input may be shorter than the
-   configured loader region; binman pads it with zeros.
+   configured loader region; binman pads it with zeros. The DDR loader reads
+   its DRAM calibration data from the boot storage, so it must be built for
+   the storage that the board boots from.
 
 ``BL31``
    The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
@@ -260,11 +273,23 @@ Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520. ``TEE`` must be
 set for both configuration and compilation. Do not deploy images if binman
 reports that it used fake or missing external blobs.
 
+To boot from UFS, merge the UFS fragment into the configuration, select the
+UFS devicetree and pass the directory holding the DDR loader built for UFS::
+
+   $ make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_GENIO_BOOT_IMAGES
+   $ make olddefconfig
+   $ make DEVICE_TREE=mt8391-genio-720-evk-ufs \
+         BINMAN_INDIRS=/path/to/ufs-firmware
+
+Use ``DEVICE_TREE=mt8371-genio-520-evk-ufs`` for Genio 520.
+
 Binman produces two deployable images and one intermediate payload in the
 build directory:
 
 ``mtk-boot.bin``
-   A MediaTek eMMC image with load and entry address
+   A MediaTek BootROM image for the boot storage, with load and entry address
    ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. It contains the DDR loader, padded to
    ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by U-Boot SPL padded to
    ``CONFIG_SPL_MAX_SIZE``.
@@ -289,8 +314,10 @@ Use the board provisioning tools to place the images as follows:
 ===================  ================================================
 Image                Destination
 ===================  ================================================
-``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
-``bootloaders.img``  GPT partition 1 in the eMMC user area
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition, or of
+                     the UFS boot logical unit
+``bootloaders.img``  GPT partition 1 in the eMMC user area, or on the
+                     main UFS logical unit
 ===================  ================================================
 
 For example, with `Genio Tools
@@ -301,7 +328,9 @@ a prebuilt Genio image for the target board::
          mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
          bootloaders:/absolute/path/to/build/bootloaders.img
 
-Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
-the platform recovery path while testing.
+With a Genio image built for UFS, the same command writes the images to UFS.
+
+Writing an invalid image to the boot partition can make the board unbootable.
+Preserve the platform recovery path while testing.
 
 .. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff

-- 
2.53.0


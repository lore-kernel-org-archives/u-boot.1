Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8D7C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 12:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14AF98209C;
	Sun, 27 Apr 2025 14:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TynGzl1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2900780C93; Sun, 27 Apr 2025 13:25:34 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DD780F9C
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D3C83A43097;
 Sun, 27 Apr 2025 11:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C492C4CEE3;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745753130;
 bh=TpB6jitJMIGVpdwdy7qxgOqOgCBFafe139KZgj6iPf4=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=TynGzl1i/glodqKvkE6gOouB8P5V6BIib5pebu+iUNOavDLBhv5jdd8dGVOhWeMB/
 Jb+EBJIonwnxnfuzxYe8w8ZclfyyCZRZGLHCGT0ToPSTzSDPCGwfeM+iYi6le/o7zD
 sssePPH/0gDaHJgM5HqaS3UzjJw6NidagziKqkoi7p85vuI2nhZKgQSORTCCMIrGXq
 yplWaIH1173Jhsyk/ab0JXSw9dyr26Jp4nSsbkuDtklpDiAVsdwUI/bnOqNtPdvX3W
 /MteRWsiVfFMQ9jBYvo2Mk3+cbIV/jPGkPk3Ko543uaNH56TIWf6YWnBVsCGXuSW7w
 qUjhJbCD4chCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C2C369D1;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
Date: Sun, 27 Apr 2025 19:25:19 +0800
Message-Id: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8UDmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyNz3cS8lKL8zBTdpPz8Et3U5KQkczOL5JREcyMloJaCotS0zAqwcdG
 xtbUACT5Sf14AAAA=
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745753127; l=2260;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=TpB6jitJMIGVpdwdy7qxgOqOgCBFafe139KZgj6iPf4=;
 b=PKQFLxaHwapPNwtomlArsob6qBCMQHL6B86lp2XxK/EhHNCStBp4W4NCLvPWrZAV1CNYBV/F+
 KfDauO/9OPvDzFBfoihz347uBkPcXmxXIjM6PQCOQ/xDE2XXcGoygmu
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 27 Apr 2025 14:43:01 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is a series of patches to enable chainloading LineageOS on qcom SOC.

First patch is to workaround kernel/ramdisk invalid addr by identify
its physical memory address out-of-range. Since qcom SOC usually have
0x80000000 as start/base/real memory address but androidboot img
specified to around 0x0. If other vendor bootloader behave similar then
this patch can also workaround it as well.

Second patch is enable bootmeth-android to have chance for extra mem block.
Usually the fastboot mem block, to hold androidboot img, and loadaddr for
unzipped kernel. If other SOC have extra mem block available but
fastboot block, we can add extra logic to take care of it.

Third patch is optional to enable snapdragon board to have extra cmdline
found from original bootloader that is required for LineageOS boot init. 
An alternate method is to put the append string into a dummy device-tree
file, as /chosen/bootarg ofnode porperty, that also contain msm-id. Then
encapsulate as androidboot img and let u-boot as kernel binary. Below is
an example for Xiaomi Miatoll device.

/dts-v1/;

/ {
        qcom,msm-id = <443 0x0>;
        qcom,board-id = <0 0>, 
			<0x10022 1>,
			<0x20022 1>,
			<0x30022 1>,
			<0x40022 1>,
			<0x50022 1>;

        #address-cells = <2>;
        #size-cells = <2>;

        memory {
                ddr_device_type = <0x07>;
                /* We expect the bootloader to fill in the size */
                reg = <0 0 0 0>;
        };

	chosen {
		bootargs = "";
	};
};

Signed-off-by: George Chan <gchan9527@gmail.com>
---
George Chan (3):
      boot/image-android.c: Workaround androidboot kernel/ramdisk addr
      boot/bootmeth-android.c: Reuse fastboot memory block for unzip kernel
      mach-snapdragon: Add support to append string to kernel cmdline

 arch/arm/mach-snapdragon/Kconfig | 11 +++++
 arch/arm/mach-snapdragon/board.c | 97 ++++++++++++++++++++++++++++++++++++++++
 boot/bootmeth_android.c          | 12 +++++
 boot/image-android.c             | 10 +++++
 4 files changed, 130 insertions(+)
---
base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
change-id: 20250427-android-boot-ecbb768cda72

Best regards,
-- 
George Chan <gchan9527@gmail.com>



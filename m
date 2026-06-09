Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5C0CD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C6784704;
	Tue,  9 Jun 2026 18:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="XX5PisBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD3E84704; Tue,  9 Jun 2026 18:52:34 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A524A846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b43e2b95so47868795e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781023952; x=1781628752; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mq2sHihJxzxI1hpICD7lR8xmK8wNlzvf9yIb0tfZBds=;
 b=XX5PisBvJATHfvXq8cHe9ZJSBrMl8dw05Wk1beY3peI1O7KwhWkNL1WWwjCGdzdXks
 LJr+Yzqzsa1V6cX0RSYqX/lyoHmxj/drNIUmYGZpyv3q5U3q2RF9nwVFuUBH04iuebr+
 MGClMtozRvIFcE0jjBo36nSNIBMfDMkWieI1CobkDkKLwK+1Tiyfp2nRU8pMHXMp8sPc
 6OtDoPUoxqT7ppAtMqRpKo1TU3ZHb3FYV5ZibFe3ZB7pWf6xak+9t7Gd/PP6TZwHvPpF
 ojQrL8MtYpMdtS49Vl1DZUbYG1ByBahT99tJNapk9v8O+1K24ednOt/zEuUD2tLkrIFU
 eo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781023952; x=1781628752;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mq2sHihJxzxI1hpICD7lR8xmK8wNlzvf9yIb0tfZBds=;
 b=MRAwktwkMomovxjaAAelKWicYPNkQ57oRGOKIpaKk+8YyO0pscNblszN1CHopb53PM
 Wo6n4hMdF3+hqlMKgwUDXpfATaDs5UJEQVLrLCdyviCenfvqo6250VxkIewwn6LlaRaa
 b4OLrH/fAceGbeDMuYji/3/ak6lR3r2u5kcThRZ5fZaMEOYCtEqGqZKrTahLlKfmG25S
 zaBjrOWyPADIICwBAbSVFmd5BEr55sROHs7UGh8Rklp/3/m8Me3p6xbpPzQ+MHattVzQ
 92ubAb3+PclBk5P5VL6mdCsuQMWbhVj4UE5RrgIA8oQUrgIIxy5fIJIExeFKpwoSurHc
 M0BA==
X-Gm-Message-State: AOJu0Ywd9pItUiTrED2qbTiDRUnnIuYemcq2lVDeYOBe1A7rvVk6XjBp
 ITpw6aCjBQuGRoQLoOlyhShAulSs+2IxLRzpKyzZZNVkFYuU+fUasj6pyBJJJLL3KPg=
X-Gm-Gg: Acq92OH8tvhoxqfg4Q/+lLpT8emyXFhMLrcpR6XdQMkl9pMwNkErmVCup0jx2lw0fKZ
 RrGr7CNh1tx0za8VifE/okZ/dxsAuedF4uCrp0YF0wzGkEO33yfv74eu+IbyM0UvHEcEIsPapQj
 o3kZdqrK4uCOOY00ZmC/rVevz+VexxXlpy/vbV2UdazI6YW/Lu3ay7OBhF+lIAU4JJdfVEBmaAg
 k1aU4zJJm2+D8yKBn1G/Wjvc0Pq/ixVUJWI+gyH9uSWkxO4997OV3cttPvkFFg0ugKvjxaE4Sia
 UdJ8LZFA0vFhDoPRaw55KqBmU0RSL2UrYJtry4fHGDQzkbcecmyY0tAoBgnlOVlIbkESRKcx1y0
 +6NIV/xV7mSeamePZzuMYFr1H+0MfSaN1875LQ1tINgUFCQ8pu6xtUBVUSE2+AoKujIrcWMP2lx
 CZHddrEs7FJUm/lrGpanqgCIiug/8LH+nUJUkNH1crcdWooPYTnmY=
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-490c25f67d9mr343076195e9.26.1781023952043; 
 Tue, 09 Jun 2026 09:52:32 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b06sm450121115e9.3.2026.06.09.09.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 09:52:31 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/4] spl: Add support for Falcon mode with ARM Trusted Firmware
Date: Tue, 09 Jun 2026 20:52:23 +0400
Message-Id: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNL3cSSNN20xJzk/DzdVPPU1DRTkxRDs1RTJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAMSZC1BuAAAA
X-Change-ID: 20260609-atf-falcon-e7eef54d16e5
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MHhw/apc+dErdCEmb/f2LIGlM7VMct6L/xgUExAYAHE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRpuJxRi4j1KL0wTejbPvXuzc2eHreV9/SsDp4T9Sp0j
 39doaxpx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFMdcYeR4W1z+rw/hou7Ns1Rj1d+lr79er6gZuSE8z+tBYScFstXVzH8U9r0Ssd
 j+ZrnXMLTEky7GubeDZlvNCHq3KMPdgqvr/sxMAMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Some of the modern SoCs such as Rockchip RK3576 require ATF to be running
to provide firmware services to the OS, and current ATF loading code in
SPL only supports loading ATF with U-boot as BL33.

Extend SPL to support loading ATF with Linux as BL33, and add necessary
hooks to enable this functionality with RK3576 booting from UFS flash.

This has been tested with an uncompressed ARM64 Image as the payload, with
a manually pre-patched DTB to include the kernel command line directly
into the /chosen node, on the Rockchip RK3576 based Flipper One board.
Booting this way lets me get from power-on to the kernel barking at me
for giving it a wrong rootfs argument in 3.5 seconds - without any extra
optimizations - which is pretty impressive. Full Linux userspace with
systemd and graphics in about 13 seconds (ext4 root on UFS, no initramfs).

Build command is along these lines (native ARM64 build):
$ make -j$(nproc) \
        BL31=~/trusted-firmware-a/build/rk3576/release/bl31/bl31.elf \
        ROCKCHIP_TPL=~/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.13.bin \
        LINUX_KERNEL=~/fit-artifacts/Image \
        FALCON_FDT=~/fit-artifacts/falcon.dtb

Loading a Falcon-equipped usb472 payload via Maskrom directly to RAM is
also possible:

rockusb download-sram u-boot-rockchip-usb471.bin
rockusb download-ddr u-boot-rockchip-usb472-falcon.bin

The caveat though is that the boot ROM seems to take a very long time to
verify the payload (around 6 minutes with a 32MB kernel) when booting
directly to RAM, which might be due to CPU and memory clocks not being
set up in Maskrom. Once loaded though, the rest of the boot process is
blazing fast.

This may need to be revisited once/if we get opensource TPL support for
RK3576 to set the CPU and memory clocks consistently at boot.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (4):
      spl: atf: support Linux as BL33 with ATF
      spl: ufs: add Falcon mode load path
      rockchip: spl: default to Falcon mode boot in SPL if enabled
      rockchip: binman: Add support for Falcon mode FIT images with ATF+Linux

 Makefile                           |   2 +
 arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-rockchip/spl.c       |  12 ++++
 common/spl/Kconfig                 |  18 ++++++
 common/spl/spl_atf.c               |  45 ++++++++++-----
 common/spl/spl_ufs.c               |  57 ++++++++++++++++++-
 tools/binman/etype/falcon_fdt.py   |  26 +++++++++
 tools/binman/etype/linux_kernel.py |  22 ++++++++
 8 files changed, 275 insertions(+), 16 deletions(-)
---
base-commit: e91911169bc737ee4a79963a1cba8db2aab7c1c0
change-id: 20260609-atf-falcon-e7eef54d16e5

Best regards,
--  
Alexey Charkov <alchark@flipper.net>


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E1BC61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02CE580C73;
	Tue, 25 Aug 2026 16:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lXPl5TngHJ3; Tue, 25 Aug 2026 16:55:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676928;
	bh=V1dGo743iGoIJ8l9JpOe/wJtD3245inBG2cDI9eAgZ0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gDSa+lhAxTGBEpYDN/yCEm76swFmn/Ma2Hb5UYQbuqWq/58FgxnEN0NwKs4KcGvjg
	 Trz7r+uQwtHuSXEhPy4x0AmkeEoHHsB5uhN7P7RuWq3AqkK1hqprhrvDs8WoIosnDP
	 CfLtYk13DU7vfyhJvzxQz8Ejrvs8SL6sbj3L7zFtPDiX29Di4vNmeC1phQ0FJbkKP7
	 KZGKK4fXFgs1qTKW5Y44TMSGom8u9nAyKso4gzkZCKb4zUtTtK5VWL6EOZXRhTdKHw
	 tD5CwmJ/8+/MHCGPbB46XSymwgHYgsY2cYthgoCeaFnGozR2XshEqUeuzmAPADy2Mr
	 QDOfHpDNt0zKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65E6880C2D;
	Tue, 25 Aug 2026 16:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6E763DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8ADE606F6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NTD6xKu3bIb1 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:23 +0000 (UTC)
X-Greylist: delayed 314 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 16:55:22 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=ImXzXjui
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::42ac; helo=smtp-42ac.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::42ac])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9D88606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:21 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv093LbDzhpV;
 Tue, 25 Aug 2026 18:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676601;
 bh=ci6J8cBsOM2LnWWByDQQk9zsfw0lIS3Cq+IRORKHfPM=;
 h=From:Subject:Date:To:Cc:From;
 b=ImXzXjuiMHtaHlmsyquDdIZ2fG2R6VhuzOjTAxSSDxGTdsD42GVBRdlPRRRw7wzHm
 SF/rp74Qiuh+n29A18uaa13C8nNpZbKNI95eVR8zpf1jDxBuLYbKkhC/p9RE8UA9K6
 Oxoo2rBNYVAOYpsPbZRBbZUp7HUgc2ziYm3XgkrxKAJoHx+8qPlDDoiEz1pReY4te3
 39XShp28ZjyZHeCAPNciJp3qzTfG4rvunC8AG7WiZqey9GBy+NR4tLGwl5cCJIZ8aw
 +LCaxNi0djUZAN9UMsxMEqGZY+ST7RUY6DXSGLb2uqRT5JKPd3Gn3PV7dTFfhH+sKV
 3EtDqZ8UeozTQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0465vkzxZk; Tue, 25 Aug 2026 18:49:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 00/45] doc: fix some issues reported by linkcheck
Date: Tue, 25 Aug 2026 18:49:37 +0200
Message-Id: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBQFryJvbSD9BFt7FXGhybf+KlESWwTx7
 kZdzjDMhshBOOKdbQj8lyiTT/DIM9i+8R9W4hKDNBX6RUaN4gfbsx2UexpddETOmBKpnwN3sl6
 vCp7XBfVt46/9sl3ODfb9AAKr/41zAAAA
X-Change-ID: 20260824-linkcheck-d7406f22d449
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

Saw a dead link and made the mistake of running `make linkcheckdocs`.
Now I'm knee-deep in it and cannot ignore all the dead and redirected
links. A day later, I've had enough so this is what I managed to fix in
that time. There are many URLs still redirecting (could be fine, but
needs to be individually checked as some big companies have a tendencies
to redirect to generic pages instead of issuing 404s...) or returning
4xx. The issue is that those 4xx also need to be individually checked
because since the AIpocalypse has started many websites now have web
crawler protection in place and linkcheck will trigger those and be
denied access (or be heavily rate limited).

Please be mindful and only run this script once, save its output and
work on fixing individual errors without rerunning the script, otherwise
we would only participate in hammering websites even more (linkcheck
runs multiple workers in parallel and retries when rate-limited).

Note that linkcheck doesn't check for links in code-blocks so our
instructions may point at dead links also.

At an attempt to avoid tens of people running linkcheck at the same
time, here's the output sorted and filtered on !ok status:

(      android/ab: line   77) redirect  https://source.android.com/devices/tech/ota/ab - permanently to https://source.android.com/docs/core/ota/ab
(    android/avb2: line  181) redirect  https://www.op-tee.org/ - permanently to https://www.trustedfirmware.org/projects/op-tee/
(     android/bcb: line  102) redirect  https://source.android.com/devices/bootloader/boot-reason - permanently to https://source.android.com/docs/core/architecture/bootloader/boot-reason
(     android/bcb: line   99) redirect  https://source.android.com/devices/bootloader - permanently to https://source.android.com/docs/core/architecture/bootloader
(android/boot-image: line  158) redirect  https://source.android.com/devices/bootloader/boot-image-header - permanently to https://source.android.com/docs/core/architecture/bootloader/boot-image-header
(android/boot-image: line  159) broken    https://source.android.com/devices/bootloader/recovery-image - 404 Client Error: Not Found for url: https://source.android.com/devices/bootloader/recovery-image
(android/boot-image: line  160) redirect  https://source.android.com/devices/architecture/dto/partitions - permanently to https://source.android.com/docs/core/architecture/dto/partitions
(android/boot-image: line  165) broken    https://connect.linaro.org/resources/san19/san19-217/ - HTTPSConnectionPool(host='connect.linaro.org', port=443): Max retries exceeded with url: /resources/san19/san19-217/ (Caused by NameResolutionError("HTTPSConnection(host='connect.linaro.org', port=443): Failed to resolve 'connect.linaro.org' ([Errno -2] Name or service not known)"))
(android/fastboot: line  290) redirect  https://developer.android.com/studio/releases/platform-tools - permanently to https://developer.android.com/tools/releases/platform-tools
(        arch/arc: line   32) redirect  https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases - permanently to https://github.com/foss-for-mips-arc-processors/toolchain/releases
(      arch/nios2: line   12) redirect  https://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual - permanently to https://www.rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
(      arch/nios2: line   33) broken    http://www.alterawiki.com/wiki/Sopc2dts - 403 Client Error: Forbidden for url: http://www.alterawiki.com/wiki/Sopc2dts
(      arch/nios2: line    9) broken    https://www.altera.com/products/processors/overview.html - 403 Client Error: Forbidden for url: https://www.altera.com/products/processors/overview.html
(         arch/sh: line   75) broken    http://www.superh-linux.org/ - HTTPConnectionPool(host='www.superh-linux.org', port=80): Max retries exceeded with url: / (Caused by NameResolutionError("HTTPConnection(host='www.superh-linux.org', port=80): Failed to resolve 'www.superh-linux.org' ([Errno -2] Name or service not known)"))
(    arch/x86/x86: line  344) broken    https://uefi.org/acpi/specs - 403 Client Error: Forbidden for url: https://uefi.org/acpi/specs
(    arch/x86/x86: line  348) broken    https://www.acpica.org/downloads - 403 Client Error: Forbidden for url: https://corpredirect.intel.com/Redirector/404Redirector.aspx?404;https://acpica.org/downloads
(board/actions/cubieboard7: line  114) broken    https://pan.baidu.com/s/1uawPr0Jao2HgWFLZCLzHAg#list/path=%2FCubieBoard_Download%2FBoard%2FCubieBoard7%2F%E6%96%B9%E7%B3%96%E6%96%B9%E6%A1%88%E5%BC%80%E5%8F%91%E8%B5%84%E6%96%99%2FImage%2FDebian%2FV2.1-test&parentPath=%2F - Anchor 'list/path%3D/CubieBoard_Download/Board/CubieBoard7/%E6%96%B9%E7%B3%96%E6%96%B9%E6%A1%88%E5%BC%80%E5%8F%91%E8%B5%84%E6%96%99/Image/Debian/V2.1-test%26parentPath%3D/' not found
(board/allwinner/sunxi: line  278) redirect  https://github.com/linux-sunxi/sunxi-tools/raw/master/bin/fel-sdboot.sunxi - with Found to https://raw.githubusercontent.com/linux-sunxi/sunxi-tools/master/bin/fel-sdboot.sunxi
(board/allwinner/sunxi: line   74) broken    https://github.com/crust-firmware/crust/blob/master/README.md#building-the-firmware - Anchor 'building-the-firmware' not found
(board/allwinner/sunxi: line   87) redirect  https://linux-sunxi.org - permanently to https://linux-sunxi.org/Main_Page
(board/amlogic/bananapi-cm4io: line   32) broken    https://wiki.banana-pi.org/Banana_Pi_BPI-CM4 - 522 Server Error: <none> for url: https://wiki.banana-pi.org/Banana_Pi_BPI-CM4
(board/amlogic/bananapi-m2pro: line   22) broken    https://wiki.banana-pi.org/Banana_Pi_BPI-M2_Pro - 522 Server Error: <none> for url: https://wiki.banana-pi.org/Banana_Pi_BPI-M2_Pro
(board/amlogic/bananapi-m2s: line   32) broken    https://wiki.banana-pi.org/Banana_Pi_BPI-M2S - 522 Server Error: <none> for url: https://wiki.banana-pi.org/Banana_Pi_BPI-M2S
(board/amlogic/bananapi-m5: line   21) broken    https://wiki.banana-pi.org/Banana_Pi_BPI-M5 - 522 Server Error: <none> for url: https://wiki.banana-pi.org/Banana_Pi_BPI-M5
(board/amlogic/odroid-c2: line   19) broken    https://wiki.odroid.com - 403 Client Error: Forbidden for url: https://wiki.odroid.com/
(  board/apple/m1: line   50) redirect  https://github.com/AsahiLinux/docs/wiki/SW%3Am1n1 - with Found to https://github.com/AsahiLinux/docs
(  board/apple/m1: line   64) redirect  https://github.com/AsahiLinux/docs/wiki/Developer-Quickstart - with Found to https://github.com/AsahiLinux/docs
(board/armltd/juno: line   17) broken    https://developer.arm.com/documentation/100113/latest - 403 Client Error: Forbidden for url: https://developer.arm.com/documentation/100113/latest
(board/armltd/juno: line   59) redirect  https://github.com/TrustedFirmware-A/trusted-firmware-a/tree/master/tools/fiptool - with Found to https://github.com/TrustedFirmware-A/trusted-firmware-a/tree/main/tools/fiptool
(board/armltd/juno: line   74) redirect  https://github.com/ARM-software/SCP-firmware.git - permanently to https://github.com/ARM-software/SCP-firmware
(board/armltd/juno: line    7) broken    https://developer.arm.com/tools-and-software/development-boards/juno-development-board - 403 Client Error: Forbidden for url: https://developer.arm.com/tools-and-software/development-boards/juno-development-board
(board/armltd/vexpress64: line  114) broken    https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Arm%20Architecture%20FVPs - 403 Client Error: Forbidden for url: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Arm%20Architecture%20FVPs
(board/armltd/vexpress64: line  115) broken    https://developer.arm.com/tools-and-software/embedded/arm-development-studio - 403 Client Error: Forbidden for url: https://developer.arm.com/tools-and-software/embedded/arm-development-studio
(board/armltd/vexpress64: line  117) redirect  https://trustedfirmware-a.readthedocs.io/ - with Found to https://trustedfirmware-a.readthedocs.io/en/latest/
(board/beagle/am62_pocketbeagle2: line  120) -ignored- https://git.ti.com/cgit/arago-project/tisdk-setup-scripts/tree/create-sdcard.sh: service unavailable
(board/beagle/am62_pocketbeagle2: line   13) redirect  https://github.com/OP-TEE/optee_os.git - permanently to https://github.com/OP-TEE/optee_os
(board/beagle/am62_pocketbeagle2: line  145) redirect  https://www.linux-automation.com/en/products/usb-sd-mux.html - with Found to https://linux-automation.com/en/products/usb-sd-mux.html
(board/beagle/am62_pocketbeagle2: line  146) timeout   https://wiki.tizen.org/SDWire - HTTPSConnectionPool(host='wiki.tizen.org', port=443): Max retries exceeded with url: /SDWire (Caused by ConnectTimeoutError(<HTTPSConnection(host='wiki.tizen.org', port=443) at 0x7fd0c271ad50>, 'Connection to wiki.tizen.org timed out. (connect timeout=30)'))
(board/beagle/am62_pocketbeagle2: line    3) broken    https://github.com/openocd-org/openocd/blob/master/tcl/target/ti_k3.cfg#L59 - 404 Client Error: Not Found for url: https://github.com/openocd-org/openocd/blob/master/tcl/target/ti_k3.cfg
(board/beagle/am62x_beagleplay: line   19) redirect  https://beagleplay.org/ - with Found to https://www.beagleboard.org/boards/beagleplay
(board/beagle/am67a_beagley_ai: line   19) redirect  https://beagley-ai.org/ - with Found to https://www.beagleboard.org/boards/beagley-ai
(board/beagle/j721e_beagleboneai64: line   22) redirect  https://beagleboard.org/ai-64 - permanently to https://www.beagleboard.org/boards/beaglebone-ai-64
(board/beagle/j721e_beagleboneai64: line  251) redirect  https://beagleboard.org/ai-64/ - permanently to https://www.beagleboard.org/boards/beaglebone-ai-64
(board/broadcom/bcm7xxx: line   82) broken    https://github.com/Broadcom/stblinux-3.14 - 404 Client Error: Not Found for url: https://github.com/Broadcom/stblinux-3.14
(board/broadcom/bcm7xxx: line   83) broken    https://github.com/Broadcom/stblinux-4.1 - 404 Client Error: Not Found for url: https://github.com/Broadcom/stblinux-4.1
(board/broadcom/bcm7xxx: line   84) broken    https://github.com/Broadcom/stblinux-4.9 - 404 Client Error: Not Found for url: https://github.com/Broadcom/stblinux-4.9
(board/bsh/imx6ulz_bsh_smm_m2: line    8) redirect  https://github.com/NXPmicro/mfgtools - permanently to https://github.com/nxp-imx/mfgtools
(board/canaan/k230_canmv: line   46) redirect  https://kendryte-download.canaan-creative.com/developer/k230/CanMV-K230_debian_sdcard_sdk_1.3.img.gz - permanently to https://download.kendryte.com/developer/k230/CanMV-K230_debian_sdcard_sdk_1.3.img.gz
(board/emulation/qemu-arm: line  255) redirect  https://github.com/stefanberger/swtpm.git - permanently to https://github.com/stefanberger/swtpm
(board/emulation/qemu-riscv: line   84) redirect  https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md - permanently to https://github.com/riscv-software-src/opensbi/blob/master/docs/platform/qemu_virt.md
(board/emulation/qemu-riscv: line   84) redirect  https://github.com/riscv/opensbi/blob/master/docs/platform/spike.md - permanently to https://github.com/riscv-software-src/opensbi/blob/master/docs/platform/spike.md
(board/google/chromebook_coral: line  442) broken    https://www.coreboot.org/images/2/23/Apollolake_SoC.pdf - 404 Client Error: Not Found for url: https://www.coreboot.org/images/2/23/Apollolake_SoC.pdf
(board/google/chromebook_link: line   25) broken    http://www.coreboot.org/~stepan/pci8086,0166.rom - 404 Client Error: Not Found for url: https://www.coreboot.org/~stepan/pci8086,0166.rom
(board/hisilicon/hikey960: line  118) broken    telnet:0:/dev/ttyUSB0:115200 - 
(board/hisilicon/hikey960: line   97) redirect  https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/master/docs/plat/hikey960.rst - with Found to https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/main/docs/plat/hikey960.rst
(board/hisilicon/hikey: line  116) redirect  https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/master/docs/plat/hikey.rst - with Found to https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/main/docs/plat/hikey.rst
(board/hisilicon/poplar: line   47) redirect  https://github.com/Linaro/poplar-l-loader.git - permanently to https://github.com/Linaro/poplar-l-loader
(board/hisilicon/poplar: line   61) redirect  https://github.com/Linaro/poplar-arm-trusted-firmware.git - permanently to https://github.com/Linaro/poplar-arm-trusted-firmware
(board/intel/crownbay: line   31) broken    http://www.intel.com/content/www/us/en/secure/intelligent-systems/privileged/e6xx-35-b1-cmc22211.html - 403 Client Error: Forbidden for url: https://www.intel.com/content/www/us/en/secure/intelligent-systems/privileged/e6xx-35-b1-cmc22211.html
(board/intel/crownbay: line   31) redirect  http://www.ami.com/products/bios-uefi-tools-and-utilities/bios-uefi-utilities/ - permanently to https://www.ami.com/products/aptio-v/
(board/intel/crownbay: line    7) broken    http://www.intel.com/content/www/us/en/embedded/design-tools/evaluation-platforms/atom-e660-eg20t-development-kit.html - 403 Client Error: Forbidden for url: https://www.intel.com/content/www/us/en/embedded/design-tools/evaluation-platforms/atom-e660-eg20t-development-kit.html
(board/intel/crownbay: line    7) broken    http://www.intel.com/fsp - 403 Client Error: Forbidden for url: https://www.intel.com/fsp
(board/intel/edison: line   58) redirect  https://drive.google.com/drive/u/0/folders/1URPHrOk9-UBsh8hjv-7WwC0W6Fy61uAJ - with Found to https://drive.google.com/drive/folders/1URPHrOk9-UBsh8hjv-7WwC0W6Fy61uAJ
(board/intel/minnowmax: line   21) broken    http://firmware.intel.com/sites/default/files/2014-WW42.4-MinnowBoardMax.73-64-bit.bin_Release.zip - 403 Client Error: Forbidden for url: https://corpredirect.intel.com/Redirector/404Redirector.aspx?https://firmware.intel.com/sites/default/files/2014-WW42.4-MinnowBoardMax.73-64-bit.bin_Release.zip
(board/intel/slimbootloader: line   92) broken    http://downloads.yoctoproject.org/releases/yocto/yocto-2.0/machines/leafhill/ - 404 Client Error: Not Found for url: http://downloads.yoctoproject.org/releases/yocto/yocto-2.0/machines/leafhill/
(board/kontron/osm-s-mx8mp: line  104) redirect  https://docs.kontron-electronics.de - permanently to https://docs.kontron-electronics.de/sw/ked/docs/docs/
(board/microchip/mpfs_common: line  271) broken    https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/boards/mpfs-icicle-kit-es/updating-icicle-kit/updating-icicle-kit-design-and-linux.md - 404 Client Error: Not Found for url: https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/boards/mpfs-icicle-kit-es/updating-icicle-kit/updating-icicle-kit-design-and-linux.md
(board/microchip/mpfs_common: line   29) broken    https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/software-development/hss-payloads.md - 404 Client Error: Not Found for url: https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/software-development/hss-payloads.md
(board/microchip/mpfs_common: line   36) broken    https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/boards/mpfs-icicle-kit-es/updating-icicle-kit/updating-icicle-kit-design-and-linux.md#eMMC - 404 Client Error: Not Found for url: https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/boards/mpfs-icicle-kit-es/updating-icicle-kit/updating-icicle-kit-design-and-linux.md
(board/nxp/mx6ullevk: line   45) broken    https://www.nxp.com/design/design-center/development-boards-and-designs/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK - 404 Client Error: Not Found for url: https://www.nxp.com/design/design-center/development-boards-and-designs/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK
(board/phytec/phycore-am62ax: line   12) redirect  https://www.phytec.com/product/phyboard-am62a - permanently to https://www.phytec.com/product/phyboard-am62a-development-kit/
(board/qualcomm/dragonwing: line    7) redirect  https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf - with Found to https://docs.qualcomm.com/doc/87-83838-1/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
(board/qualcomm/dragonwing: line    7) redirect  https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf - with Found to https://docs.qualcomm.com/doc/87-83839-1/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
(board/qualcomm/dragonwing: line    7) redirect  https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf - with Found to https://docs.qualcomm.com/doc/87-83840-1/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
(board/renesas/rcar-gen3-install: line   27) broken    https://github.com/renesas-rcar/flash_writer/blob/rcar_gen3/docs/application-note.md#341-write-to-the-s-record-format-images-to-the-serial-flash - Anchor '341-write-to-the-s-record-format-images-to-the-serial-flash' not found
(board/samsung/e850-96: line 1053) redirect  https://gitlab.com/LinaroLtd/e850-96/images.git - with Found to https://gitlab.com/LinaroLtd/e850-96/images
(board/samsung/e850-96: line 1054) redirect  https://gitlab.com/LinaroLtd/e850-96/tools/dltool.git - with Found to https://gitlab.com/LinaroLtd/e850-96/tools/dltool
(board/samsung/e850-96: line 1059) timeout   https://source.devboardsforandroid.linaro.org/platform/external/u-boot/+log/refs/heads/wip/sm8x50-gbl-fastboot - HTTPSConnectionPool(host='source.devboardsforandroid.linaro.org', port=443): Max retries exceeded with url: /platform/external/u-boot/+log/refs/heads/wip/sm8x50-gbl-fastboot (Caused by ConnectTimeoutError(<HTTPSConnection(host='source.devboardsforandroid.linaro.org', port=443) at 0x7fd0bd90c050>, 'Connection to source.devboardsforandroid.linaro.org timed out. (connect timeout=30)'))
(board/samsung/e850-96: line 1061) timeout   https://source.devboardsforandroid.linaro.org/platform/manifest/ - HTTPSConnectionPool(host='source.devboardsforandroid.linaro.org', port=443): Max retries exceeded with url: /platform/manifest/ (Caused by ConnectTimeoutError(<HTTPSConnection(host='source.devboardsforandroid.linaro.org', port=443) at 0x7fd0bd90e350>, 'Connection to source.devboardsforandroid.linaro.org timed out. (connect timeout=30)'))
(board/schneider/hmibsc: line    7) broken    https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/ - 403 Client Error: Forbidden for url: https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
(board/sifive/unleashed: line   55) redirect  https://github.com/riscv/opensbi.git - permanently to https://github.com/riscv-software-src/opensbi
(board/sipeed/maix: line   21) redirect  https://kendryte.com/downloads/ - permanently to https://www.kendryte.com/downloads/
(board/sipeed/maix: line  696) redirect  https://github.com/riscv/riscv-sbi-doc - permanently to https://github.com/riscv-non-isa/riscv-sbi-doc
(board/spacemit/bananapi-f3: line   39) broken    https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout - Anchor '21-firmware-layout' not found
(board/starfive/deepcomputing_fml13v01: line   28) broken    https://www.starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf - 404 Client Error: Not Found for url: https://www.starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf
(board/st/stm32_MCU: line   26) timeout   https://www.st.com/en/microcontrollers-microprocessors/stm32f4-series.html - HTTPSConnectionPool(host='www.st.com', port=443): Read timed out. (read timeout=30)
(board/st/stm32_MCU: line   27) timeout   https://www.st.com/en/microcontrollers-microprocessors/stm32f7-series.html - HTTPSConnectionPool(host='www.st.com', port=443): Read timed out. (read timeout=30)
(board/st/stm32_MCU: line   28) timeout   https://www.st.com/en/microcontrollers-microprocessors/stm32h7-series.html - HTTPSConnectionPool(host='www.st.com', port=443): Read timed out. (read timeout=30)
(board/st/stm32mp1: line  839) timeout   https://wiki.st.com/ - HTTPSConnectionPool(host='wiki.st.com', port=443): Read timed out. (read timeout=30)
(board/st/stm32mp1: line  840) timeout   https://wiki.st.com/stm32mpu/wiki/Main_Page - HTTPSConnectionPool(host='wiki.st.com', port=443): Read timed out. (read timeout=30)
(board/ti/am335x_evm: line   62) redirect  https://www.ti.com/mysecuresoftware - with Found to https://www.ti.com/en-us404.html
(board/ti/am6254atl_sk: line   13) redirect  https://www.ti.com/lit/pdf/spruiv7 - with Found to https://www.ti.com/lit/ug/spruiv7c/spruiv7c.pdf?ts=1787607945585
(board/ti/am62ax_sk: line   39) redirect  https://www.ti.com/lit/pdf/spruj16 - with Found to https://www.ti.com/lit/ug/spruj16c/spruj16c.pdf?ts=1787666228238&ref_url=https%253A%252F%252Fwww.google.com%252F
(board/ti/am62ax_sk: line   71) -ignored- https://git.ti.com/cgit/security-development-tools/core-secdev-k3: service unavailable
(board/ti/am62dx_evm: line   50) redirect  https://www.ti.com/lit/pdf/sprujd4 - with Found to https://www.ti.com/lit/ug/sprujd4a/sprujd4a.pdf?ts=1787675383080
(board/ti/am62px_sk: line   49) redirect  https://www.ti.com/lit/pdf/spruj83 - with Found to https://www.ti.com/lit/ug/spruj83d/spruj83d.pdf?ts=1787675382783
(board/ti/am64x_evm: line   27) redirect  https://www.ti.com/lit/pdf/spruim2 - with Found to https://www.ti.com/lit/ug/spruim2j/spruim2j.pdf?ts=1787675380084
(board/ti/am65x_evm: line   25) redirect  https://www.ti.com/lit/pdf/spruid7 - with Found to https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf?ts=1787675379324
(board/ti/am65x_evm: line   29) broken    https://www.ti.com/tool/TMDX654GPEVM - 404 Client Error: Not Found for url: https://www.ti.com/tool/TMDX654GPEVM
(board/ti/j7200_evm: line   27) redirect  https://www.ti.com/lit/pdf/spruiu1 - with Found to https://www.ti.com/lit/ug/spruiu1d/spruiu1d.pdf?ts=1787675380744
(board/ti/j721e_evm: line   30) redirect  https://www.ti.com/lit/pdf/spruil1 - with Found to https://www.ti.com/lit/ug/spruil1d/spruil1d.zip?ts=1787675380782
(board/ti/j721s2_evm: line   16) redirect  https://www.lauterbach.com/ad3780.html - with Found to https://repo.lauterbach.com/ad3780.html
(board/ti/j721s2_evm: line   23) broken    https://software-dl.ti.com/ccs/esd/xdsdebugprobes/emu_JTAG_connectors.html - 404 Client Error: Not Found for url: https://software-dl.ti.com/ccs/esd/xdsdebugprobes/emu_JTAG_connectors.html
(board/ti/j721s2_evm: line  259) redirect  https://www.ti.com/lit/pdf/spruj68 - with Found to https://www.ti.com/lit/ug/spruj68a/spruj68a.pdf?ts=1787675382134
(board/ti/j721s2_evm: line   33) redirect  https://www.ti.com/lit/pdf/spruj28 - with Found to https://www.ti.com/lit/ug/spruj28f/spruj28f.zip?ts=1787608802464
(board/ti/j721s2_evm: line    3) broken    https://software-dl.ti.com/ccs/esd/documents/xdsdebugprobes/emu_JTAG_connectors.html#cti-20-pin-header-information - 404 Client Error: Not Found for url: https://software-dl.ti.com/ccs/esd/documents/xdsdebugprobes/emu_JTAG_connectors.html
(board/ti/j722s_evm: line   26) redirect  https://www.ti.com/lit/zip/sprujb3 - with Found to https://www.ti.com/lit/ug/sprujb3c/sprujb3c.zip?ts=1787662792674
(board/ti/j784s4_evm: line  311) redirect  https://www.ti.com/lit/ug/spruj70/spruj70.pdf - with Found to https://www.ti.com/lit/ug/spruj70b/spruj70b.pdf?ts=1787675383450
(board/ti/j784s4_evm: line   33) redirect  http://www.ti.com/lit/zip/spruj52 - with Found to https://www.ti.com/lit/ug/spruj52e/spruj52e.zip?ts=1787599944317
(     board/ti/k3: line 1241) redirect  https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html - permanently to https://sourceware.org/gdb/current/onlinedocs/gdb.html/TUI-Commands.html
(     board/ti/k3: line 1333) broken    https://github.com/OP-TEE/optee_ftpm#building-the-ta - Anchor 'building-the-ta' not found
(     board/ti/k3: line  663) redirect  https://dev.ti.com/sysconfig - with Found to https://www.ti.com/en-us404.html
(board/ti/ks2_evm: line  136) broken    http://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Getting_Started#Installing_Code_Composer_Studio - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Getting_Started
(board/ti/ks2_evm: line   13) broken    http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx - 404 Client Error: Not Found for url: https://www.advantech.com/en/errors/page-not-found
(board/ti/ks2_evm: line  141) broken    http://processors.wiki.ti.com/index.php/EVMK2H_Hardware_Setup - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/EVMK2H_Hardware_Setup
(board/ti/ks2_evm: line  142) broken    http://processors.wiki.ti.com/index.php/EVMK2E_Hardware_Setup - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/EVMK2E_Hardware_Setup
(board/ti/ks2_evm: line  143) broken    http://processors.wiki.ti.com/index.php/TCIEVMK2L_Hardware_Setup - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/TCIEVMK2L_Hardware_Setup
(board/ti/ks2_evm: line  144) broken    http://processors.wiki.ti.com/index.php/66AK2G02_GP_EVM_Hardware_Setup - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/66AK2G02_GP_EVM_Hardware_Setup
(board/ti/ks2_evm: line   14) broken    https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html - 403 Client Error: Forbidden for url: https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
(board/ti/ks2_evm: line  152) broken    http://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Exploring#Loading_and_Running_U-Boot_on_EVM_through_CCS - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Exploring
(board/ti/ks2_evm: line   15) broken    https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html - 403 Client Error: Forbidden for url: https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
(board/ti/ks2_evm: line  208) broken    http://processors.wiki.ti.com/index.php/*_Hardware_Setup - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/*_Hardware_Setup
(board/ti/ks2_evm: line   20) broken    https://www.ti.com/product/tci6638k2h - 404 Client Error: Not Found for url: https://www.ti.com/product/TCI6638K2H
(board/ti/ks2_evm: line   20) broken    https://www.ti.com/product/tci6638k2k - 404 Client Error: Not Found for url: https://www.ti.com/product/TCI6638K2K
(board/ti/ks2_evm: line  235) broken    http://processors.wiki.ti.com/index.php/ - 421 Client Error: Misdirected Request for url: https://processors.wiki.ti.com/index.php/
(board/ti/ks2_evm: line   27) broken    https://www.ti.com/lit/ds/symlink/tci6630k2l.pdf - 404 Client Error: Not Found for url: https://www.ti.com/lit/ds/symlink/tci6630k2l.pdf
(board/ti/ks2_evm: line   30) broken    https://www.ti.com/lit/ds/symlink/66ak2g02.pdf - 404 Client Error: Not Found for url: https://www.ti.com/lit/ds/symlink/66ak2g02.pdf
(board/toradex/aquila-am69: line   22) broken    https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads - 403 Client Error: Forbidden for url: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
(board/toradex/aquila-am69: line   24) redirect  https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz - with Found to https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz
(board/toradex/aquila-am69: line   25) redirect  https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz - with Found to https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
(board/toradex/aquila-imx95: line   26) redirect  https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz - with Found to https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz
(board/toradex/aquila-imx95: line   27) redirect  https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz - with Found to https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
(board/toradex/colibri_imx7: line   32) broken    https://www.nxp.com/webapp/Download?colCode=IMX7DRM - 404 Client Error: Not Found for url: https://www.nxp.com/webapp/Download?colCode=IMX7DRM
(board/toradex/colibri_imx7: line   44) broken    https://www.nxp.com/docs/en/application-note/AN4581.pdf - 404 Client Error: Not Found for url: https://www.nxp.com/docs/en/application-note/AN4581.pdf
(board/toradex/colibri_vf: line    7) broken    https://www.toradex.com/computer-on-modules/colibri-arm-family/nxp-vybrid-vf5xx-vf6xx - 404 Client Error: Not Found for url: https://www.toradex.com/computer-on-modules/colibri-arm-family/nxp-vybrid-vf5xx-vf6xx
(board/xen/xenguest_arm64: line   83) broken    https://source.codeaurora.org/external/imx/uboot-imx/tree/?h=imx_v2018.03_4.14.98_2.0.0_ga - HTTPSConnectionPool(host='source.codeaurora.org', port=443): Max retries exceeded with url: /external/imx/uboot-imx/tree/?h=imx_v2018.03_4.14.98_2.0.0_ga (Caused by NameResolutionError("HTTPSConnection(host='source.codeaurora.org', port=443): Failed to resolve 'source.codeaurora.org' ([Errno -5] No address associated with hostname)"))
(board/xilinx/zynq: line  102) redirect  http://www.xilinx.com/products/boards-and-kits/EK-Z7-ZC702-G.htm - permanently to https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards.html
(board/xilinx/zynq: line  103) redirect  http://www.xilinx.com/products/boards-and-kits/EK-Z7-ZC706-G.htm - permanently to https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards.html
(board/xilinx/zynq: line  104) timeout   http://zedboard.org/product/zedboard - HTTPConnectionPool(host='zedboard.org', port=80): Max retries exceeded with url: /product/zedboard (Caused by ConnectTimeoutError(<HTTPConnection(host='zedboard.org', port=80) at 0x7fd0c2252360>, 'Connection to zedboard.org timed out. (connect timeout=30)'))
(board/xilinx/zynq: line  105) timeout   http://zedboard.org/product/microzed - HTTPConnectionPool(host='zedboard.org', port=80): Max retries exceeded with url: /product/microzed (Caused by ConnectTimeoutError(<HTTPConnection(host='zedboard.org', port=80) at 0x7fd0c2252030>, 'Connection to zedboard.org timed out. (connect timeout=30)'))
(board/xilinx/zynq: line  106) redirect  http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf - with See Other to https://docs.amd.com/r/deeplink/unresolved?ft%3AprettyUrl=en-US%2Fug585-Zynq-7000-TRM
(build/documentation: line   43) redirect  https://docs.u-boot-project.org - with Found to https://docs.u-boot-project.org/en/latest/
(chromium/chainload: line  231) broken    https://www.chromium.org/chromium-os/packages/cros-flashrom - 404 Client Error: Not Found for url: https://www.chromium.org/chromium-os/packages/cros-flashrom
(chromium/chainload: line   29) redirect  https://drive.google.com/open?id=0B7WYZbZ9zd-3dHlVVXo4VXE2T0U - with Found to https://accounts.google.com/v3/signin/identifier?continue=https://drive.google.com/open?id%3D0B7WYZbZ9zd-3dHlVVXo4VXE2T0U&followup=https://drive.google.com/open?id%3D0B7WYZbZ9zd-3dHlVVXo4VXE2T0U&osid=1&passive=1209600&service=wise&flowName=GlifWebSignIn&flowEntry=ServiceLogin&dsh=S-231341599:1787675256634161
(chromium/overview: line   54) broken    https://www.cnet.com/products/hp-chromebook-11-g2-11-6-exynos-5250-4-gb-ram-16-gb-emmc/ - 404 Client Error: Not Found for url: https://www.cnet.com/products/hp-chromebook-11-g2-11-6-exynos-5250-4-gb-ram-16-gb-emmc/
(chromium/overview: line   54) broken    https://www.cnet.com/products/samsung-chromebook-2-xe503c12-11-6-exynos-5-octa-4-gb-ram-16-gb-ssd/ - 404 Client Error: Not Found for url: https://www.cnet.com/products/samsung-chromebook-2-xe503c12-11-6-exynos-5-octa-4-gb-ram-16-gb-ssd/
(chromium/overview: line   54) broken    https://www.cnet.com/products/samsung-series-3-chromebook-xe303c12-11-6-exynos-5250-2-gb-ram-16-gb-ssd-bilingual-english-french/ - 404 Client Error: Not Found for url: https://www.cnet.com/products/samsung-series-3-chromebook-xe303c12-11-6-exynos-5250-2-gb-ram-16-gb-ssd-bilingual-english-french/
(develop/bootstd/script: line   27) redirect  https://www.armbian.com - permanently to https://armbian.com/
(develop/ci_testing: line   29) redirect  https://azure.microsoft.com/en-us/services/devops/ - permanently to https://azure.microsoft.com/en-us/products/devops/
(develop/ci_testing: line   43) redirect  https://gitlab.com/ - permanently to https://about.gitlab.com/
(develop/coccinelle: line   78) broken    file:line:column-column - 
(develop/docstyle: line   11) redirect  https://www.sphinx-doc.org - with Found to https://www.sphinx-doc.org/en/master/
(  develop/falcon: line  197) broken    http://schedule2012.rmll.info/IMG/pdf/LSM2012_UbootFalconMode_Babic.pdf - HTTPConnectionPool(host='schedule2012.rmll.info', port=80): Max retries exceeded with url: /IMG/pdf/LSM2012_UbootFalconMode_Babic.pdf (Caused by NewConnectionError("HTTPConnection(host='schedule2012.rmll.info', port=80): Failed to establish a new connection: [Errno 113] No route to host"))
(     develop/gdb: line   64) broken    tcp::3333 - 
(develop/historical/generic_board: line   67) redirect  https://patch.msgid.link/4F019ABB.9010201@gmail.com/ - permanently to https://lore.kernel.org/4F019ABB.9010201@gmail.com/
(develop/historical/generic_board: line   73) redirect  https://patch.msgid.link/CAPnjgZ0jesqX1Y71S5xoYQDGPuARfOX48RGbU9Mw=P5HGYcOKg@mail.gmail.com/ - permanently to https://lore.kernel.org/CAPnjgZ0jesqX1Y71S5xoYQDGPuARfOX48RGbU9Mw=P5HGYcOKg@mail.gmail.com/
(develop/historical/generic_board: line   77) redirect  https://patch.msgid.link/1325477374-6417-1-git-send-email-graeme.russ@gmail.com/ - permanently to https://lore.kernel.org/1325477374-6417-1-git-send-email-graeme.russ@gmail.com/
(develop/package/bintools: line  258) broken    https://www.opendnssec.org/softhsm/ - 404 Client Error: Not Found for url: https://www.opendnssec.org/softhsm/
(develop/package/bintools: line   45) broken    https://www.coreboot.org/CBFS - 404 Client Error: Not Found for url: https://www.coreboot.org/CBFS
(develop/package/entries: line 1830) redirect  https://github.com/riscv/opensbi - permanently to https://github.com/riscv-software-src/opensbi
(develop/package/entries: line 2223) redirect  https://software-dl.ti.com/tisci/esd/latest/ - with Found to https://downloads.ti.com/tisci/esd/latest/
(develop/package/entries: line 3203) broken    https://docs.xilinx.com/r/en-US/ug1283-bootgen-user-guide/Using-Authentication - HTTPSConnectionPool(host='docs.xilinx.com', port=443): Max retries exceeded with url: /r/en-US/ug1283-bootgen-user-guide/Using-Authentication (Caused by SSLError(SSLCertVerificationError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1082)')))
(develop/package/entries: line  564) broken    https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf - 403 Client Error: Forbidden for url: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
(develop/package/entries: line  611) redirect  https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf - with Found to https://lin-gitlab-gl-prod-gl-uploads-ap-southeast-1-074697959899.s3.ap-southeast-1.amazonaws.com/%40hashed/56/ed/56ed85811d53cda50fa0583c7e3f4fbde02c759b1a0e8fd00d75dd23ffa37631/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf?response-content-disposition=inline%3B%20filename%3D%22mbfw.pdf%22%3B%20filename%2A%3DUTF-8%27%27mbfw.pdf&response-content-type=application%2Fpdf&X-Amz-Expires=600&X-Amz-Date=20260825T162739Z&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEEAaDmFwLXNvdXRoZWFzdC0xIkgwRgIhAPMf%2B%2FpQ5kBX2WHs1A0i1vIzBZmgz25mcZpMYy%2FZNOV3AiEA8RInM9%2FK86mf%2F86PqWTCtkAvMVuQGsSZAOePVyypQMMqygUICRACGgwwNzQ2OTc5NTk4OTkiDOJVoyBuvxM2uFN4mCqnBUqLV8UnaWl1mweoxvsLmMbDnlc4hvBFoQ93xCVjFxXoCQDm1JpzcH7pAZrrhOb2F3QL5qJBC4EHFNDIM8mAEWk60JuxeuFOhwIU1%2BOBHkA4zVPeIO1GAXCzRLtkjyDmvUxl%2FHNAjPlV3kdyAAPEYCl5qGp0%2BBrxJsIRC%2FBRCEega5Ti1rpaanUI5RPARP
 qe3OQxbH4SdRo2qmcZsim8SilF%2BtQv5SZCPCBhcZbccaJjPCbApb%2BlfWT9KkspAe3WAscjY5MZYdpk%2Fsd1kx7N6edRWlRux%2FzEgJH9%2FZZsXyic5sZfybcYF86FXk6igO80ClHA6KT%2FLY%2F8F6TG7PrRz9oV0O%2B2gfl%2BFCjpf7oFmwQeldEnNRBn7Zsvz%2FMdncfWqoY9BYVan5esy6isbnZc2JSkTgwW4sDUla3kKA%2Bhp0cqlTgntQPnNDWW0OjZvcAUbKuN%2BZJIKwbM6iLM1yLtqWIRvrMiaDHJbVRMX%2BasSErfbT2%2BhOwqNqn%2FpPBTibXU5Gy30RLZDxlDnVXbzbDlaZSHb20L2LgRJKUE4vAvtyOsvyj48DgelTRX2owIccXHsUdCBMY%2FT8CmFuidmokSTazkfNH0fVseIBOoR41X1Mg9srEDZBG4QccR8ZI8BZV5S7NTtdu1Oi5btgHHRY4Z61FYwWTlYhpuWKZNemtbnXS4%2BkwEZwQQd8me7bKhUIQF5yxkCmfDqkvdPXewtzElY7wp9VBUWcGv1YcYK6jmbGEiWpUbytFX6Qwt86Ah1R6UBCRu%2BHB32QwhaXUfZeBgLSPPG2rAQJ313Mvfud1Yn2b4YFZPMgPM7LBDLdXzagaBNSqqbEt0H4Fozi7aVSr%2F3%2FbOLXAmeb42Bdg0wXPPjbhIvrHU3j3oFWch5kiDd8jHqpXOiY%2BWZ1Qw0ve21AY6sAHae55J5F3KhCZ9%2FU9qfeJe1TP1U5x42JKAw6HKdj54kaM%2FGNTOzeEk9d1z3appMMTYjpKfbAwHd3naNoOD4OSzO2%2F4LuN3XH2Yym0DzgY%2BIaUUFZCXfMXjaA%2FX4iGelwu6P0T614X4aKcbwj5IBFUGTOi9vMoLovIkHEqYew%2B%2B3YEuFCJk8KfhXUyd3bGb5xSlPQHp36zbrfc%2Bw4XdK
 U1da9LwraFlxb1Bum2uJk8u%2BQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIARCZCYNHNQN6EK4B7%2F20260825%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-SignedHeaders=host&X-Amz-Signature=69230228dc66b6cd6bb2d7ade53ef7a76c465bcdd1932c7c3116e019fdd4395d
(develop/python_cq: line   15) redirect  https://www.python.org/dev/peps/pep-0008/ - with Found to https://peps.python.org/pep-0008/
(develop/sending_patches: line  478) broken    https://git.openembedded.org/openembedded/tree/contrib/patchwork/pw-am.sh - 403 Client Error: Forbidden for url: https://git.openembedded.org/openembedded/tree/contrib/patchwork/pw-am.sh
( develop/testing: line   80) redirect  http://www.tbot.tools - permanently to https://tbot.tools/
(develop/uefi/fwu_updates: line  196) broken    https://developer.arm.com/documentation/den0118/ - 403 Client Error: Forbidden for url: https://developer.arm.com/documentation/den0118/
(develop/uefi/u-boot_on_efi: line  376) redirect  http://www.qemu.org - permanently to https://www.qemu.org/
(develop/uefi/u-boot_on_efi: line  377) redirect  https://github.com/tianocore/tianocore.github.io/wiki/OVMF - with Found to https://github.com/tianocore/tianocore.github.io
(develop/uefi/uefi: line 1021) broken    http://uefi.org/specifications - 403 Client Error: Forbidden for url: http://uefi.org/specifications
(develop/uefi/uefi: line 1022) redirect  https://github.com/ARM-software/ebbr/releases/download/v2.1.0/ebbr-v2.1.0.pdf - with Found to https://release-assets.githubusercontent.com/github-production-release-asset/132763627/c53ad724-a4ad-476f-9f1a-df9f6e224906?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-08-25T17%3A12%3A42Z&rscd=attachment%3B+filename%3Debbr-v2.1.0.pdf&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-08-25T16%3A12%3A16Z&ske=2026-08-25T17%3A12%3A42Z&sks=b&skv=2018-11-09&sig=Xl6nRtNX2lVx64DUfn3phh2lAk3cg9vbDAAiJMh6Ork%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc4NzY3NTU2MSwibmJmIjoxNzg3Njc1MjYxLCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.V57Gd405ZGh-cB_1F5rqZo4eNFWAAjFafbKnWQBxARM&response-content-disposition=attachment%3B%20filename%3Debbr-v2.1.0.pdf&res
 ponse-content-type=application%2Foctet-stream
(develop/uefi/uefi: line 1024) broken    https://developer.arm.com/docs/den0044/latest/server-base-boot-requirements-system-software-on-arm-platforms-version-11 - 403 Client Error: Forbidden for url: https://developer.arm.com/docs/den0044/latest/server-base-boot-requirements-system-software-on-arm-platforms-version-11
(develop/uefi/uefi: line  200) redirect  http://go.microsoft.com/fwlink/?LinkId=321185 - with Found to https://www.microsoft.com/pkiops/certs/MicCorKEKCA2011_2011-06-24.crt
(develop/uefi/uefi: line  202) redirect  http://go.microsoft.com/fwlink/p/?linkid=321192 - permanently to https://www.microsoft.com/pkiops/certs/MicWinProPCA2011_2011-10-19.crt
(develop/uefi/uefi: line  204) redirect  http://go.microsoft.com/fwlink/p/?linkid=321194 - permanently to https://www.microsoft.com/pkiops/certs/MicCorUEFCA2011_2011-06-27.crt
(develop/uefi/uefi: line  694) broken    http://192.168.1.1/foobar - 404 Client Error: Not Found for url: http://192.168.1.1/foobar
(     learn/talks: line   20) broken    https://elinux.org/Boot_Loaders#U-Boot - Anchor 'U-Boot' not found
(  usage/cmd/acpi: line   37) broken    https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf - 403 Client Error: Forbidden for url: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
(usage/cmd/meminfo: line  107) broken    https://developer.arm.com/documentation/ddi0487/latest/ - 403 Client Error: Forbidden for url: https://developer.arm.com/documentation/ddi0487/latest/
(  usage/cmd/scmi: line   36) broken    https://developer.arm.com/documentation/den0056/e/?lang=en - 403 Client Error: Forbidden for url: https://developer.arm.com/documentation/den0056/e/?lang=en
(       usage/dfu: line  336) broken    https://dfu-util.sourceforge.net/ - 403 Client Error: Forbidden for url: https://dfu-util.sourceforge.net/
(usage/measured_boot: line   16) broken    https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/ - 403 Client Error: Forbidden for url: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
(usage/measured_boot: line   16) broken    https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/ - 403 Client Error: Forbidden for url: https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/
(usage/semihosting: line   26) broken    http://www.arm.com/products/tools/models/fast-models/foundation-model.php - 403 Client Error: Forbidden for url: https://developer.arm.com/products/system-design/fixed-virtual-platforms
(usage/semihosting: line    7) broken    https://developer.arm.com/documentation/dui0471/g/Semihosting - 403 Client Error: Forbidden for url: https://developer.arm.com/documentation/dui0471/g/Semihosting

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (45):
      doc: arch/mips: update link for Buildroot toolchain
      doc: arch/x86: fix "link" to IRQ router DT binding
      doc: develop: sending_patches: fix links to pw-am.sh
      doc: arch/x86: fix URL to em100
      doc: arch/x86: update link to DediProg SO8 Testclip
      doc: arch/x86: update SFI link
      doc: arch/x86: update MP link
      doc: arch/x86: update link to SeaBIOS
      doc: arch/x86: update link to ACPI
      doc: arch/x86: manual_boot: update links to slides
      doc: develop: uefi: update link to ipxe git repo
      doc: board/amlogic: jethub-j100: update product page
      doc: board/amlogic: jethub-j80: use redirect link directly
      doc: develop: sending_patches: update link to Email Clients and Patches
      doc: develop: sending_patches: update link to GPL license
      doc: usage/pxe: use redirect link
      doc: board/google: chromebook_link: update link to blobs
      doc: arch/sh: remove squatted URL
      doc: develop/coccinelle: update links
      doc: develop/coccinelle: remove dead link in supplemental documentation
      doc: board/nxp: mx6ullevk: replace broken link
      doc: arch/arc: update link
      doc: develop/uefi: stop tripping linkcheck
      doc: board/allwinner: update link to MTD utils
      doc: chromium: update link to Developer Mode
      doc: chromium: update Firmware porting guide link
      doc: chromium: update links to slides
      doc: develop/driver-model: fs_firmware_loader: update link
      doc: board/tbs: update link to TRM
      doc: bootstd: update link to BSL
      doc: learn/talks: remove dead links to slides
      doc: build/gen_compile_commands: update link to point to the right page
      doc: board/highbank: update links to cxmanage and ipmitool tools
      doc: board/siemens: iot2050: update links to files on GitHub
      doc: develop/tests_writing: update links to new GitLab
      doc: board/renesas: update clone instructions to use new GitLab
      doc: fix broken links to mailing lists
      doc: index: update link to mailing list info
      doc: develop/bootstd: fix link to distro_boot
      doc: develop/sending_patches: remove mention to the test mailing list
      doc: chromium/chainload: update instructions on booting on Snow
      doc: develop/sending_patches: use link from ozlabs.org mailman archive
      doc: switch to HTTPS for a few links
      binman: btool: bootgen: update link to user guide
      binman: gbb: update link

 doc/CONTRIBUTE.rst                              |  2 +-
 doc/arch/arc.rst                                |  2 +-
 doc/arch/mips.rst                               |  2 +-
 doc/arch/nios2.rst                              |  2 +-
 doc/arch/sh.rst                                 |  1 -
 doc/arch/x86/manual_boot.rst                    |  4 +--
 doc/arch/x86/x86.rst                            | 20 +++++++--------
 doc/board/allwinner/sunxi.rst                   |  2 +-
 doc/board/amlogic/index.rst                     |  2 +-
 doc/board/amlogic/jethub-j100.rst               |  2 +-
 doc/board/amlogic/jethub-j80.rst                |  2 +-
 doc/board/google/chromebook_link.rst            |  2 +-
 doc/board/highbank/highbank.rst                 |  4 +--
 doc/board/nxp/mx6ullevk.rst                     |  4 +--
 doc/board/renesas/rcar-gen3-draak.rst           |  2 +-
 doc/board/renesas/rcar-gen3-ebisu.rst           |  2 +-
 doc/board/renesas/rcar-gen3-geist.rst           |  2 +-
 doc/board/renesas/rcar-gen3-salvator-x.rst      |  2 +-
 doc/board/renesas/rcar-gen3-ulcb.rst            |  2 +-
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst    |  2 +-
 doc/board/renesas/rcar-gen5-ironhide.rst        |  4 +--
 doc/board/siemens/iot2050.rst                   |  4 +--
 doc/board/sipeed/maix.rst                       |  2 +-
 doc/board/tbs/tbs2910.rst                       |  2 +-
 doc/build/gen_compile_commands.rst              |  2 +-
 doc/chromium/chainload.rst                      |  2 +-
 doc/chromium/overview.rst                       |  8 +++---
 doc/develop/bootstd/overview.rst                |  4 +--
 doc/develop/coccinelle.rst                      | 10 ++------
 doc/develop/driver-model/fs_firmware_loader.rst |  2 +-
 doc/develop/driver-model/virtio.rst             |  2 +-
 doc/develop/process.rst                         |  2 +-
 doc/develop/sending_patches.rst                 | 33 +++++++++++--------------
 doc/develop/tests_writing.rst                   |  4 +--
 doc/develop/uefi/iscsi.rst                      |  6 ++---
 doc/develop/uefi/uefi.rst                       |  2 +-
 doc/index.rst                                   |  2 +-
 doc/learn/talks.rst                             |  3 +--
 doc/usage/dfu.rst                               |  2 +-
 doc/usage/pxe.rst                               |  4 +--
 tools/binman/btool/bootgen.py                   |  2 +-
 tools/binman/etype/gbb.py                       |  2 +-
 42 files changed, 76 insertions(+), 91 deletions(-)
---
base-commit: 2d379a529c257606946831a6dac1c37de6a3f8c0
change-id: 20260824-linkcheck-d7406f22d449

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


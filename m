Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95736606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FV590ELV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxpiA4Ry
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 680D64068D;
	Mon, 26 Oct 2026 15:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dlrWFDr192K; Mon, 26 Oct 2026 15:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 512F640647
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030394;
	b=peRH5edDQmKZdNyvnf/sBvMe11pjv6huzWC96zWk2qYQ8dcxpzKnoLIx5Bc2mPbpZLFt
	 PTWs9CE4w8kHL2B19zYCRIuHjfPUT2+KIrOju4xANGM2i4TB5EaOX0pfRHLz/Epb7wWJf
	 DrovJqoCHEYP4/47vZ9eqn0Tk9nMvfLbSsHvFSimD3huUNfJ710zJE1WERJveXJz+spk+
	 8D1QfoDuu5rr11auEuJvqU6i5lzG5BVM7HSwHSewoPqVrLoSdXGyggReBAmyhzVSjOhIW
	 +gOsev6SkMnkSWY8jNx6hKVuS1vWGkMD5nVwOMrYezhi9BP6doLtwBe1TMX5EI+WjRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lvovhMEEyFHA4av/105WIetmQlX7gBeFwJKL/7XBFj4=;
	b=L1su1Ic9slMsjcQsHJYNHa4idUZ7yUSaMDuYjGshu3ydvZFuEYgeg7jETvKcozA8d6zp
	 N155uiG/YYCUIUTlZ5QJYqhkOjA51zyl8GyhZseXBqF6ble5jPAZ+8dblakXYiPQsNh/E
	 JidrCQr69MBi7C/M1iERwWv/WEGJfCMnGCOfSgoTbAQiEbYDcptdGjI1Tgwoyem+VlB9L
	 4T2t9EZSTulS4ennFsxRFEqPpOiBlQdz4Gihu/i7wSR05E/0/IUVxUk0mXROElbLPbQB4
	 il/gZX/qCWcy7d1aCiJdoDU3iPG3LkxO3XRYLgL1PLhNgkthyzFURU5lvlLj9taCQYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxpiA4Ry;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030394;
	bh=lvovhMEEyFHA4av/105WIetmQlX7gBeFwJKL/7XBFj4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FV590ELVz3a9sRSlOhT9YQ+WK55Er/TZ/VgXlWHO5+6o55MNCaNg/uAPEoe+peHjn
	 uBBRixUksXFtovXOvdwpdcGYY19nDdrLjA6sK+cVaPz2LX0eyzeRP0/QZF2BVvrAQw
	 ZjQ+/v7UFk4xVmQdc7aSnjicy2uIhTJRomvlZsd6hY8c6R5g4t8+Km0zP8MY+NEvb4
	 TE2lHxm4JIjv1+1TCUcMmKQoRr5Zm8LGjeJF7TvKmABEi2u70VAA3zyNFrTlRyx6IT
	 XReJwdMGXDKjRajMjyuzbx+sKxmlV7S6tLkSbyY3StKz3PiOxoLEha7CBuyly7wOc0
	 LP5j6+3L15r/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 512F640647;
	Mon, 26 Oct 2026 15:59:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 51511235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EC5040647
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yb_lESDS49Ex for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17E5E405BB
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793030392;
 b=gipjL4DuhMDwAfXrf4BaK/1doaxKIQ3Cqr1WNOV0OWeRAvsC6J7I4dVOXN03x2njWap2
 Cls8R3WileBk/7x2VK99Y9PKCeqSgwsJpuFJaRz9tEtSJMBiptd+gbaDp0rh0Lrzoee2g
 nryhSUhTTFgVaQSIS4DRelG8yDoVpOLgw+GWg1UmLPNxPaemcyPhH8h2nQss2GDrzn6d8
 4KWNAi3nAhjfGrPJU0uyoYzytgbFl6fEo64JH8yBMyx6/1h2wqFpf2DGJZ8sQm5YmRwsL
 dV5nGjAIem/cvEOGQi2mb8TUEs5Uh9NGcRKmfxMmctpitVnqAkvnVGiTIkYImMbmodA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030392;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type;
 bh=lvovhMEEyFHA4av/105WIetmQlX7gBeFwJKL/7XBFj4=;
 b=g44qXVrlyLHvPh6zrhApz2vMqqJAaav9j4BM+eAJG62Hy0Ez00NyOnJaeg7MrE7rexHl
 CDH4LQI0tiKzK4/MnTv1UyZGOP4VdbtawMcmw2cQfIknrtIeNkYLC2sDiV1aDpJCRuQBY
 EVJ5qZQz1X2CxkLZ57k5SKl3AoO1Dw0jKDwAdJTP4KfUvUA9n/Iau/5XbjuPLDlknH7hS
 PZh/amSa3eBIwHfF9mBIufmtKi2W+Rbvkq4Cjgt/earQSDiTgAIoIqDqes/DJmEh7nxD2
 NWz6Vm6IqKqsTRqpH3Er6kQISpe/l59OCGp8XpKEL5mYWmj8xX+R2jTLaimfp8YI67Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oxpiA4Ry; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oxpiA4Ry
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17E5E405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:59:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 006246022B;
 Mon, 26 Oct 2026 15:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B591F01825;
 Mon, 26 Oct 2026 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793030389;
 bh=lvovhMEEyFHA4av/105WIetmQlX7gBeFwJKL/7XBFj4=;
 h=From:To:Cc:Subject:Date;
 b=oxpiA4Ry2EvY4FsKi/e0T/RFGe361mQ6L9giy4bvOOfS6CUD6uERJdD+d4aQVYTlb
 A6BajcpPGiogNoMbtNxzPsi+l4thy/ib8ECTayPtrKRXyKg44aKbfK5aRWKepGCNGx
 DvqWYGiGWi37HgTDrv77eSOZmg1G2eE6h6rNmUBhWAsx3wqF21cLBOhNTNIsUocbvn
 fOxTVAQBfpZzRAxsyeApQ/rAlVhXxgZu2l8LvBrAsDPtqn5gMG+uNfBMU2cwuLUsuq
 AUJdwfbUNhXHvZEj8xbOHDRrJdU02M+LYCuh03Ni9NPYJqg50NeCUUOzzOq+Dioo49
 c5NAJF7Yqj2Ag==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Jan
 Kehren <jan.kehren@emteria.com>, Petr Hodina <petr.hodina@protonmail.com>
Subject: Please pull u-boot-dfu-20261026 into main
Date: Mon, 26 Oct 2026 16:59:47 +0100
Message-ID: <xhkdbbj8g311o.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Here is a PR for main with the following:

Android:
* avb: Allow other storage mediums (virtio, usb, ...)
* avb: Add lock/unlock support via OP-TEE TA
* avb/boot_android: Fix TOCTOU in bootmeth_android
* avb: Improve pytest suite on sandbox with dedicated mmc12 device

Fastboot:
* Scale progress dots to video console width
* Add flashing log/unlock/get_unlock_ability

Usb Gadget:
* acm: Do not requeue failed RX requests
* f_mass_storage: Improve CTRL-C responsiveness
* dwc2_udc_otg: Bypass debounce filter on force session
* dwc2_udc_otg: Fix mode initialization by waiting on debounce filters

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1732

Thanks,
Mattijs

The following changes since commit fed92546960a92177d67c0b8d7b22385f50fed29:

  Gitlab CI: sage: Update for labgrid 26.0 behavior (2026-10-12 11:13:40 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20261026

for you to fetch changes up to 974861925ede465ecd780e000a98d64c32181abf:

  test/py: avb: Fix find() logic when matching response strings (2026-10-26 10:33:58 +0100)

----------------------------------------------------------------
u-boot-dfu-20261026

Android:
* avb: Allow other storage mediums (virtio, usb, ...)
* avb: Add lock/unlock support via OP-TEE TA
* avb/boot_android: Fix TOCTOU in bootmeth_android
* avb: Improve pytest suite on sandbox with dedicated mmc12 device

Fastboot:
* Scale progress dots to video console width
* Add flashing log/unlock/get_unlock_ability

Usb Gadget:
* acm: Do not requeue failed RX requests
* f_mass_storage: Improve CTRL-C responsiveness
* dwc2_udc_otg: Bypass debounce filter on force session
* dwc2_udc_otg: Fix mode initialization by waiting on debounce filters

----------------------------------------------------------------
Fabrice Gasnier (2):
      usb: gadget: dwc2_udc_otg: bypass debounce filter
      usb: gadget: dwc2_udc_otg: wait for mode when digital filter is active

Igor Opaniuk (5):
      cmd: avb: add read_pvalue_hex/write_pvalue_hex
      cmd: avb: add lock/unlock commands
      avb: verify the boot images in the buffers they are booted from
      fastboot: add flashing lock/unlock/get_unlock_ability
      doc: android/avb2: document the root key provisioning and lock state

Jan Kehren (3):
      avb: Drop the mmc naming from the block IO helpers
      blk: Add a name-to-interface-type lookup
      avb: Take a storage interface in the AVB operations

Mattijs Korpershoek (10):
      avb: Use map_to_sysmem() for flush_cache() address
      test/py: android: Move android image creation to a dedicated file
      test/py: android: Drop verbose printing and unused return
      test/py: android: Use for loop to create the images / update disks
      test/py: android: Add create_gpt_image() for image creation
      test/py: android: Add setup_android_v{4,2}_image subfunctions
      test/py: avb: Use format specifiers instead of str() for mmc_dev
      test/py: avb: Move mmc device number to a pytest fixture
      test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
      test/py: avb: Fix find() logic when matching response strings

Nizat Mikayilli (1):
      usb: gadget: acm: do not requeue failed RX requests

Patrice Chotard (2):
      usb: gadget: f_mass_storage: Remove useless rc variable
      usb: gadget: f_mass_storage: Optimize CTRL-C responsiveness

Petr Hodina (1):
      fastboot: scale download progress dots to video console width

 arch/sandbox/dts/test.dts                   |   8 +
 boot/bootmeth_android.c                     |  75 +++++-
 cmd/avb.c                                   | 166 +++++++++++-
 common/Kconfig                              |   7 +-
 common/avb_verify.c                         | 272 ++++++++++++++-----
 doc/android/avb2.rst                        |  93 ++++++-
 drivers/block/blk-uclass.c                  |   4 +-
 drivers/block/blk_legacy.c                  |   7 +
 drivers/fastboot/Kconfig                    |  19 ++
 drivers/fastboot/fb_command.c               | 389 +++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c                |  22 ++
 drivers/usb/common/dwc2_core.c              |  45 ++++
 drivers/usb/common/dwc2_core.h              |   1 +
 drivers/usb/gadget/dwc2_udc_otg.c           |   8 +-
 drivers/usb/gadget/f_acm.c                  |   3 +
 drivers/usb/gadget/f_mass_storage.c         |  11 +-
 include/avb_verify.h                        |  77 +++++-
 include/blk.h                               |  11 +
 include/fastboot.h                          |  14 +
 test/py/tests/test_android/android_image.py | 116 +++++++++
 test/py/tests/test_android/test_abootimg.py |  77 ++++++
 test/py/tests/test_android/test_avb.py      | 109 ++++++--
 test/py/tests/test_ut.py                    | 129 +--------
 23 files changed, 1386 insertions(+), 277 deletions(-)
 create mode 100644 test/py/tests/test_android/android_image.py


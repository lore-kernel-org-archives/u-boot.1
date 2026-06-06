Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6B8CD6E55
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84E8848D8;
	Sat,  6 Jun 2026 06:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i2guxuTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F2584962; Sat,  6 Jun 2026 02:52:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF219848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E65440B26;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C6B2C2BCB4;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=ODQrbTXJbY1PGG3lHlFJSANiRvb70foev7oSN9WSeRM=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=i2guxuToYQPmUlc5ey93fdNnd3lBT6NzLLJvuepwU9UQZO7sAcXAZFrL2QKUUpvak
 EAeewWcGmdSBVxuf/n8xkFAJAt2HLd3BXgcKfM/iZ8ZT2n177fM3rNSuqGwja59rOI
 I2rOjkDKr1r/e/jm8MtN4eL9fQGOzfAAkg/zliphKpxJyJiMnKo7c4VTfzhVNFjz/F
 n6wmO0bgvh4phbJMbm9h4SU66IMKVe8quc3zdqm6fu0qO5w3GNdmTGY3jmFs2I+Q9h
 nWVFgO6xkEXdNOwO9v/fgwp/h4xDWJaMbiLmcqXq13tsvwFB1gxRnljM3Ar8DlXYD8
 Y0C9M9Z4z3mTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF7CD8C88;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Subject: [PATCH 00/13] Generate Android boot images with binman
Date: Sat, 06 Jun 2026 10:52:34 +1000
Message-Id: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgtVi1KvIg7RpJrBVFoQQby7x
 fEN/z+QOQlnGKsHEl+SJWpBU1ew7qgbG6FiaG3b2946g0opCplF9EA1SAO6Ljj2nqBEZ+Ig9z+
 c5vf9AKuTJqlgAAAA
X-Change-ID: 20260604-android-binman-ad7a43f4e99d
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=4605;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=ODQrbTXJbY1PGG3lHlFJSANiRvb70foev7oSN9WSeRM=;
 b=VbDxWUJGpWOfYtLnlL5X089FcG53VTycqbaVoNyxDr/iuE9kKmcMwfP0zrLcyklGlIscrWZ9s
 4cyJ2RRjXhhA1hT274oZcgG57NQD5L6bW1+34wH2B1ofPqQfFM1o0kb
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:39 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

U-Boot is seeing increasing adoption on pocket computers, many of which
(sadly) have fused bootloader chains. Many of these bootloaders have a
very rigid definition of what a "valid" downstream payload looks like.
Sometimes it's just a boring old v0/v2 Android boot image. Sometimes
it's something decidedly more grotesque.

To date, this last-mile packaging step has been trapped in downstream CI
pipelines, blogposts, documentation, etc. This patch series aims to
gather up all that esoterica and institutional knowledge and codify it
in U-Boot's build system, using binman.

Put differently: an overwhelming majority of these pocket computer
devices have a "canonical" payload format that U-Boot currently has no
support for. Let's fix that.

The first patches in this series introduce an `android_boot` etype. To
begin with, this is a "typical" abootimg, as defined by canonical AOSP
sources and reference `fastboot`/`mkbootimg` implementation. There's
plenty of devices out there with a sane(-ish, nothing in Android-land is
ever truly sane) bootloader that will happily chain a U-Boot rolled into
the kernel section of an abootimg.

With that out of the way, the cursed bootloaders are next to be
supported. Binman etypes for Qualcomm's "QCDT" and Samsung's "DTBH"
formats are implemented. These are non-standard vendor-specific
devicetree containers, which the previous bootloader uses to pick a FDT
to boot the downstream with.

In both cases, these vendor-specific formats are tacked on to the end of
a v0 abootimg, with the header_version being hijacked to encode the
length of this following payload. Thus, the android_boot etype is
retrofitted to allow these shenanigans.

Binman configs that produce flashable boot artifacts are introduced for
the following devices:

 * google-sargo (vanilla v2)
 * oneplus-fajita (vanilla v2)
 * samsung-a5u-eur (QCDT v0)
 * samsung-gt510 (QCDT v0)
 * samsung-j7xelte (DTBH v0)

I also successfully tested a vanilla v0 on my samsung-expressltexx, in
conjunction with the qcom-armv7 series already on the list. However,
since that work is still in-flight and the expressltexx DTS is
downstream, I opted not to include it here.

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (13):
      binman: Android boot image support
      .gitignore: ignore binman-generated blobs
      arch: arm: qcom: google-sargo binman config
      qcom: arch: arm: qcom: sdm845-fajita binman configs
      mach-snapdragon: enable BINMAN
      binman: android_boot: vendor-dt support
      binman: Add QCDT support
      binman: android_boot: SEANDROIDENFORCE support
      arch: arm: qcom: samsung-a5u-eur binman config
      arch: arm: qcom: samsung-gt510 binman config
      binman: Add DTBH support
      arch: arm: exynos: add j7xelte binman config
      configs: exynos-mobile: pull in BINMAN

 .gitignore                                         |   1 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/dts/exynos-mobile.dtsi                    |   5 +
 arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi        |  24 ++
 arch/arm/dts/msm8916-samsung-a5u-eur-u-boot.dtsi   |  39 ++
 arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi     |  39 ++
 arch/arm/dts/qcom.dtsi                             |   5 +
 arch/arm/dts/sdm670-google-sargo-u-boot.dtsi       |  27 ++
 arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi     |  25 ++
 arch/arm/mach-exynos/Kconfig                       |   1 +
 configs/exynos-mobile_defconfig                    |   1 +
 configs/qcom_defconfig                             |   1 +
 tools/binman/etype/android_boot.py                 | 408 +++++++++++++++++++++
 tools/binman/etype/dtbh.py                         | 173 +++++++++
 tools/binman/etype/qcdt.py                         | 160 ++++++++
 tools/binman/ftest.py                              | 127 +++++++
 .../test/vendor/android_boot_seandroidenforce.dts  |  22 ++
 tools/binman/test/vendor/android_boot_v0.dts       |  29 ++
 tools/binman/test/vendor/android_boot_v2.dts       |  46 +++
 .../binman/test/vendor/android_boot_vendor_dt.dts  |  27 ++
 tools/binman/test/vendor/dtbh.dts                  |  29 ++
 tools/binman/test/vendor/dtbh_bad_model_info.dts   |  19 +
 tools/binman/test/vendor/qcdt.dts                  |  20 +
 tools/binman/test/vendor/qcdt_bad_msm_id.dts       |  17 +
 24 files changed, 1246 insertions(+)
---
base-commit: a4c8728f225b0d7d591fb9199ce7efb72f48290e
change-id: 20260604-android-binman-ad7a43f4e99d

Best regards,
-- 
Sam Day <me@samcday.com>



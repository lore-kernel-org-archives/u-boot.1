Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E79FCD8C9F
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AC484839;
	Mon,  8 Jun 2026 01:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LsAplAjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF07784825; Mon,  8 Jun 2026 01:37:19 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C90B838BB
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 420C240BB6;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BCB0C2BCB4;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780875435;
 bh=C81nZ5K9hUVCD3CApmHBUe1kenGWfpFK6DioWeuIilU=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=LsAplAjCsQnRmJOP+wtHwlFdej6jm8GIwHHyjjehw+c7zDBrQ4zQOImwNCpYv7TGa
 N4cqZrcbD/o1sMa6REj5GN93aQbGww5+p/+PbGpVrgMHSeiwZE2lTkkehHEY9mOPsD
 KWsh4MdETCWHNy+mTUzYfxznD/x10F55dXemHVjddEENuJ3Z2atHTKfx6k7rhYecBV
 6RLqAvBBeGJ672/mkF2AdsjabIpLCoPlmPJNU8SQIL3Dm+tp+0kB2xX8mD7qYZhKXA
 ugYHdBLAl6MVet4bXajdiuFjoqfQPyVtfEcPBsn+Hz1MSmq0t7CN86JwAAV8p08Q2c
 eBNeiWBTl2aYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E17E1CD8C89;
 Sun,  7 Jun 2026 23:37:14 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Subject: [PATCH v2 0/8] Generate Android boot images with binman
Date: Mon, 08 Jun 2026 09:37:09 +1000
Message-Id: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ6CMBCF4auQWVtTaAPiynsYFkNnkFm0Na0hE
 sLdrSRuXP4ved8GmZNwhmu1QeJFssRQojlV4GYMD1ZCpaHRTatbbRUGSlFIjRI8BoXUoTWT5b4
 nKKdn4kneB3gfSs+SXzGth7/U3/VHtf/UUiutXIfG1Xa8oKFbRu8I17OLHoZ93z9soC/7rgAAA
 A==
X-Change-ID: 20260604-android-binman-ad7a43f4e99d
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780875433; l=4789;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=C81nZ5K9hUVCD3CApmHBUe1kenGWfpFK6DioWeuIilU=;
 b=YdyN7J2oadMPl7h6tT3JkFLmIVhkgxi3CQpx2d2T1E7Xofp2D9t9YLPLYcHfepXZxWR9/bK+q
 tUNCF0npu5VA3YOKuHCNjHfL/11V6sAmH5W3DGHPVCVxaXJy2yRexXp
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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

Note that, I dropped the commits that introduce this support for
Qualcomm devices, as it was NAK'd by "Qualcomm". I still think this is
worth inclusion upstream for a couple of reasons:

 * It's still useful for Exynos devices.
 * If/when other non-qcom devices with fused Android bootloaders come
   along, it will likely be useful there as well.
 * Downstreams can easily carry DTSI overlays for qcom devices to take
   advantage of this new native U-Boot support there.
 * Maybe the hard position against binman will change/soften on the
   Qualcomm side, in which case we can simply start dropping in DTSIs to
   add support for those devices.

Signed-off-by: Sam Day <me@samcday.com>
---
Changes in v2:
- Rebase on next
- Drop all qcom-related work as it has been NAK'd from mach-snapdragon
- Link to v1: https://lore.kernel.org/r/20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com

---
Sam Day (8):
      binman: Android boot image support
      .gitignore: ignore binman-generated blobs
      binman: android_boot: vendor-dt support
      binman: Add QCDT support
      binman: android_boot: SEANDROIDENFORCE support
      binman: Add DTBH support
      arch: arm: exynos: add j7xelte binman config
      configs: exynos-mobile: pull in BINMAN

 .gitignore                                         |   1 +
 arch/arm/dts/exynos-mobile.dtsi                    |   5 +
 arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi        |  24 ++
 arch/arm/mach-exynos/Kconfig                       |   1 +
 configs/exynos-mobile_defconfig                    |   1 +
 tools/binman/etype/android_boot.py                 | 407 +++++++++++++++++++++
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
 17 files changed, 1108 insertions(+)
---
base-commit: 9e87893c24d1f21350e69bc222e6a3214c933b3b
change-id: 20260604-android-binman-ad7a43f4e99d

Best regards,
-- 
Sam Day <me@samcday.com>



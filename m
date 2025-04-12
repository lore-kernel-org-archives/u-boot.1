Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C243CC369AE
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 19:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CAB82E9F;
	Sat, 12 Apr 2025 21:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="gwVa/t3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F399182E2E; Sat, 12 Apr 2025 21:39:58 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B243882D66
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 21:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1744486796; x=1744745996;
 bh=JpH28LeiCFYLgUEyGc7KyE1JR4XeTxxbc/HvnIrlKMo=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=gwVa/t3f9NaLxa4eJIljzklpUR4XBN7xpebe/bn9+lMWzTh8iK4Y4/Q/vJ3yrVOK2
 pRd5ShUM8+7HnJhWJgN9xUgLDoypmctAFOJ99XG7FCSVtVyqDwEDpUVilwP9k+NPqT
 hzUoQLK3SUr7+eZaNog2fVuiie39jR1ZKa9t9JYW7MhQdZJ2M31Fn4vCoPAOeuKSlc
 wtM/b5pdAG9ZULwOctN4WnOpffteWMtcsPOhm+0DF4UjLlb8IRlTvxc0bWj92WtreK
 Dl6bGIwngPKrTTi/nwkJqz1RBHJOsyOSatAW+dcxMjvI+YwfRin6lh7NDskxeB2E/C
 qbcfgzCbhmXOg==
Date: Sat, 12 Apr 2025 19:39:50 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 0/3] Support MSM8916 USB PHY + UDC in qcom_defconfig
Message-ID: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 580ee48cd55de41b5e7e25d28f6f79635853dcf9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The MSM8916 SoC includes a ChipIdea UDC. The U-Boot driver for this UDC
is quite old, and did not support USB gadget driver model. As a result,
it could not be built alongside the DWC3 driver. This meant that
qcom_defconfig could not include support for USB on MSM8916.

This series adds support to build ChipIdea UDC with DM_USB_GADGET and
ensures that the newly introduced driver is registered from the MSM EHCI
glue driver.

The ChipIdea UDC driver continues to work without DM_USB_GADGET. I
tested these changes by building dragonboard410c_defconfig (which does
not enable DM_USB_GADGET), booting it, and then chain-booting (via
fastboot) another u-boot build built with qcom_defconfig. USB gadget
mode worked in both builds.

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (3):
      usb: udc: ci: support USB gadget driver model
      usb: host: ehci-msm: Register ChipIdea UDC from glue wrapper
      qcom_defconfig: Enable MSM8916 USB PHY + ChipIdea UDC

 configs/qcom_defconfig      |  6 ++++
 drivers/usb/gadget/ci_udc.c | 84 +++++++++++++++++++++++++++++++++++++++++=
+++-
 drivers/usb/host/ehci-msm.c |  7 ++++
 3 files changed, 96 insertions(+), 1 deletion(-)
---
base-commit: a40fc5afaec079ee4e621965fed18dcc94240d8c
change-id: 20250412-msm8916-usb-a1dc93c01bd5
prerequisite-message-id: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.=
org>
prerequisite-patch-id: 006e55423a2d28cc23ff11035da672b418ebec51
prerequisite-patch-id: 8c51357ca78f0465407e0a74fda666a3e540f6d8
prerequisite-patch-id: 68d707d65315e9ea7c61ba97c58257ea9a3e3152
prerequisite-patch-id: 514522633917dd1efd2380a53949c5e7ff5ff0dd
prerequisite-patch-id: 9ee7e8f41aa3070f802d087bd763ab384e681adb
prerequisite-patch-id: fbfd19c0f729fe157c31bc40d48d19d0083d23a4

Best regards,
--=20
Sam Day <me@samcday.com>



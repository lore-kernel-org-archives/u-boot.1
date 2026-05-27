Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAF3CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAEB58491D;
	Wed, 27 May 2026 03:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="X/7AiNFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CF384855; Wed, 27 May 2026 02:37:44 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B782E846A5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1779842260; x=1780101460;
 bh=TTXSqybppNqAETHFG+S0nDPXvJABxTND5ErbWAh13RQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=X/7AiNFoLdkYLXmSLKZ7fUW6JYVeqqwRRQXyi11Kjm9Bqa6N4kXOpnueQUgT2m6MJ
 hTUxxDEET0KgRkEPUU36ov1OGP5/c3HyFp2fAFgRZkqLGrcGmNtSCyAqTMls77C0U/
 pxD8YPZVPGzhWPZKLCHoSvbFC90b2nUhb97Ah8Ngrli1LvZ6yKTy6HpzvsigMGEjRw
 VErZED19KgSzCdLtKO9Dsi41iSFS3vYjO0vSGC8yW4bjbPjfKvXsY20KzhMOKihGJq
 XOpNMgShEzfgFJkDtQl/BnoYe5/BhzjyBVvL6VI6DOQeaWUnDInlO+DycsCchlUvQ4
 bo/n4U/WRWf+Q==
Date: Wed, 27 May 2026 00:37:34 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?Q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Sam Day <me@samcday.com>
Subject: [PATCH v2 0/3] Support MSM8916 USB PHY + UDC in qcom_defconfig
Message-ID: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 9ee74081064ac74c62d5d5b6bc53209b10b024f2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 27 May 2026 03:18:29 +0200
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
Changes in v2 (thanks Stephan):
- Deduplicate CI UDC setup/teardown paths
- Formatting fix
- Regenerate qcom_defconfig with savedefconfig
- Link to v1: https://lore.kernel.org/r/20250412-msm8916-usb-v1-0-2925239ca=
f4b@samcday.com

---
Sam Day (3):
      usb: udc: ci: support USB gadget driver model
      usb: host: ehci-msm: Register ChipIdea UDC from glue wrapper
      qcom_defconfig: Enable MSM8916 USB PHY + ChipIdea UDC

 configs/qcom_defconfig      |   4 +-
 drivers/usb/gadget/Kconfig  |   1 -
 drivers/usb/gadget/ci_udc.c | 118 ++++++++++++++++++++++++++++++++++++----=
----
 drivers/usb/host/ehci-msm.c |   7 +++
 4 files changed, 107 insertions(+), 23 deletions(-)
---
base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
change-id: 20250412-msm8916-usb-a1dc93c01bd5

Best regards,
--=20
Sam Day <me@samcday.com>



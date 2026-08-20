Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50AEC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1303E80F35;
	Thu, 20 Aug 2026 18:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mr7z-UW5-bCB; Thu, 20 Aug 2026 18:09:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787249344;
	bh=+qb+HDovWAb5J7CjruI/xcjm/2AkxgSozyIunC16/Mg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dcQ/0tvUXA1N9ONxUoPiHI3kC++zsszJGiB0Jr+gV4GgmEFCb18wVprvLKpZ6Q/fv
	 IOgh5Q4Wg8CjCvwSAP2toQmAn1SpJeMRGzdTWXrWnQqknSZOy96ta3EP18WEG4ZCmg
	 M1zmpaHRsMwe91XZgiktcXqPX7zBgXxT+QPw4HkR46Px4pWxjX75dTBCkjswOuhZIU
	 fMobG+o7fiEjyyBjT6yBJuPV4f1lwGw1Ui0deITDj04Mt3aODvcsY0IAmJQXD++S75
	 Xcqqo51QZxs1UDFN+DgHV9BeGsa9D187y/B2iFhUdEWg0KiKTl48E921cO6hbujoIQ
	 5Bsgd+tzA617g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01AD580F0D;
	Thu, 20 Aug 2026 18:09:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F4A81EA4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E14AE607A5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8v6FPEXCLYez for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:09:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pNYsxvDg
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 889AC60871
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:08:57 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so140561f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787249335; x=1787854135;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+qb+HDovWAb5J7CjruI/xcjm/2AkxgSozyIunC16/Mg=;
 b=pNYsxvDg8o0cHQ/BXxddCHH81njc3MfYERiJ/aAs4KkWoFt/zmA3tj8U2qfSPzeFcC
 HK+AJf2iUrMzGIZf1iVhJn8flkNfrWsfbBSBV/DAXJ4e4bnESEPANvCw711cOKPekFTQ
 JaQV4DZNzqFqtzL509OITJkEvMMcWpornfvht1D1if52fPk/zbedWw7gSQNh0EZwXtE1
 ql3oisxs+TrEmokjS33ExjawdQvDpcmvBnkHTsEg1jX/KIRrU1XS8GbWmTL6EonTMr/q
 UmVWrpzWgSmZ0mMciFDLCmSdoQXVxaREbjub5qsah59DwLJ/IwIuZ4Kbq2NLW0U+qp4I
 bJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249335; x=1787854135;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+qb+HDovWAb5J7CjruI/xcjm/2AkxgSozyIunC16/Mg=;
 b=SP+vxBslOfmckg9dsTHy3k8WeAzk6vNHg8GlxtzzfyZQ84pNXFRLcPFW1wPxfhZyqK
 RlsnIXgFF19y5JXAlzNV9oc6XzM5kdZ5eKWCZVwq/eSBWMM5Cykb+FDWs0/1a4YlyXWd
 T0A3ZupRxjpqWZlg01/WSD3EjhJQ/iNwCa0jzJ2R0GxZoYEJj8z13Iqs4prrBYmuvuEs
 QG9eKpB8jCtr+sRhOg8tyMvcxhYCKOLSHMSbsM2Dr6dX24sMbRb2IUVZ6opqqM6jZ1Aj
 zNMus3zkl1jaG8s4+9tq8qTWCJH4+GnpSGboJ6kqDG11padoeafdsBk1Hrzw+7yHxSEU
 X1KQ==
X-Gm-Message-State: AFuF++lBKeGbWpPjq6mbmXoIBu/uAY3gMBeX7xOFMk/zO3G0DH5H1nLG
 EA7mBSewWXUEg8yqLi+qGCPhrVelOkRytNhu23RqlPVQipx8rpxZD3APhuKk3/Ib8jA=
X-Gm-Gg: AR+sD10clIdmp/5JUkAijK18YP2KqFoQZoJ0oVUGk2iZP9BAO821X4cXCoMQIefrc6U
 /2/bN2r8cLNZZYb3aBezQrUn+9P/Jn+CHsrkqvzh3+WqrQPiuLJ4a0yY9pSxmxNmiSgyuHXtlh7
 rpdUTdFEZvNka1fqe0Y5psOqWMr+gDVmLDsaM6gqxL9siWIVvnlvAod8JT6Zg+K26Ro8PGLEo/K
 ZizkRy3f4Qbal0zWmihp+ClkNtndIOmbFCz8wmYz2bXhLfY0ZZeDeDdZPNGbdlFRbxvhEkgmnIr
 lwYD54rvLnT+rbh2qusIQ6lVGiNiS+FU7U8das3CZ7eqbz05yvjiEnlGqqQiVOqrCJMSzbFbf65
 KUdMeHdZrIRO8Cd+QxJUNOQ9ZsHDPVfneXtLaMdygXQFv8r0uwDQkQCtN40cjLoZ949F/micEM3
 H4iLBMR/vhhxjdMNDiC/A0sNH4f7fD8iL1rj2i8hES6UXu0tM7GIuUpdF7//kYsCU/w1DrE9RF6
 /BlOvpWQfkIn614xxxAI0PxGoVF4s6EmvhWQ4WVPbXx2E3KC4aYW0CcFJjgwWX0sGKVa+R9oloh
 I6mhZA==
X-Received: by 2002:a05:6000:4b1b:b0:482:bb55:8bda with SMTP id
 ffacd0b85a97d-482c0b5bf64mr1080896f8f.5.1787249334983; 
 Thu, 20 Aug 2026 11:08:54 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13443810f8f.27.2026.08.20.11.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:08:54 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v4 0/5] Add fastboot to SPL
Date: Thu, 20 Aug 2026 20:08:24 +0200
Message-Id: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOQWrDMBAF0KsErTutNXbiOqveo2Qxo4xqldgyk
 mISgu9eKSUQSsELLT76el83FSU4iWq/uSmmKMCBRtPnrM5TTEFoeBvIjeplo4LMLjo/5ssmR9P
 T+CXgjqWMFe6qVr+DMZQrAo/XEKcTWIqJvU+gG0vIO86nKeQUxLrLff/z8Jvjmb/FpIKWRu9i8
 uF6/+CsS++x1a1szRo0mI6Jt1wxtfjBdD05DvJq/KDK3IxPIOIaiFABMtW21aZBNv+A9RNY6zW
 wzuCRJYu22WInf8BlWX4Ak4cHm6EBAAA=
X-Change-ID: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

Some recovery and initial-provisioning flows need a standard host protocol
before usable firmware is available in persistent storage. U-Boot already
provides fastboot, but the implementation can currently be started only
from the U-Boot-proper command line.

This series makes USB fastboot available as an opt-in SPL service,
including MMC partition flashing and Android sparse images. The interface
is kept deliberately narrower in SPL: it does not support the boot command
or filesystem probing, and reboot support remains platform-dependent.

The first four patches separate the generic preparation from SPL
enablement. They factor out the USB session runner, route USB reboot
through the common handler, make shared fastboot configuration phase-aware,
and add phase-aware sparse-image support. The final patch then contains the
SPL-specific Kconfig, gadget behavior, and documentation.

No fastboot code or supporting library is added to SPL when SPL_FASTBOOT is
disabled, so the feature has no size cost for existing SPL builds.

---
Changes in v4:
- Drop RFC status.
- Make the USB fastboot helper and gadget build rules phase-aware.
- Use a separate command table for the SPL-supported command subset.
- Document the commands available in SPL.
- Apply the requested Makefile, annotation and preprocessor cleanups.
- Link to v3: https://patch.msgid.link/20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com

Changes in v3:
- Rename the USB session helper to fastboot_usb_run().
- Initialize UDP and TCP sessions in their transport helpers.
- Remove a redundant USB session return assignment.
- Collect the Reviewed-by tag.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com

Changes in v2:
- Split the common USB session runner into a prerequisite patch.
- Route USB reboot through the common fastboot handler separately.
- Split phase-aware fastboot configuration and build rules.
- Split phase-aware Android sparse-image support.
- Keep SPL-specific behavior in the final patch.
- No functional change from v1.
- Link to v1: https://patch.msgid.link/20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com

---
Carlo Caione (5):
      fastboot: factor out the USB session runner
      fastboot: use the common handler for USB reboot
      fastboot: make shared configuration checks phase-aware
      image: sparse: add phase-aware SPL support
      fastboot: add SPL support

 cmd/fastboot.c                  | 53 +++-------------------
 doc/android/fastboot.rst        | 31 +++++++++++++
 drivers/Makefile                |  2 +-
 drivers/fastboot/Kconfig        | 92 +++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/Makefile       |  9 ++--
 drivers/fastboot/fb_block.c     |  9 ++--
 drivers/fastboot/fb_command.c   | 97 ++++++++++++++++++++++++++++++++---------
 drivers/fastboot/fb_common.c    | 23 +++++++++-
 drivers/fastboot/fb_getvar.c    | 19 +++++---
 drivers/fastboot/fb_mmc.c       | 36 +++++++--------
 drivers/fastboot/fb_usb.c       | 66 ++++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile     |  2 +-
 drivers/usb/gadget/f_fastboot.c |  6 ++-
 include/fastboot.h              | 10 +++++
 lib/Kconfig                     | 11 +++++
 lib/Makefile                    |  3 +-
 lib/image-sparse.c              |  2 +-
 17 files changed, 360 insertions(+), 111 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


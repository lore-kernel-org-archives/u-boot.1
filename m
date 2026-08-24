Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDA5C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE1E2808A9;
	Mon, 24 Aug 2026 19:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vfrvhgjGlrW8; Mon, 24 Aug 2026 19:03:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598234;
	bh=9kEeGp9V70F32LVDbwR7RFUkC9sPWMUzCWDvpDhjvv0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nHI1EWoo0seK9qBppcWiGpwj+KaSVTX2xXb6KGhu2BdVNabPiMooIQ+CYDC1dOsSf
	 9hpFy2IYBefjrG8R71LwUZDvNYPJn0abAzhCTry++ugm6GHN2BkHNE34M3nSKiX+zL
	 P4CYaMweYKtLsbTAQdV1RK9HS5W9DAZ4EP/Mjtzury0L2nL2LLXQ17RxTpg+DWUyLc
	 2eVBJ+CDCGWcI3mDOYlWiILbjtOUO1pEH72XfelEuWH8Z5RVlge5xd6WFij2SumvLU
	 e5yAH/ty6LFSRZ7MKMfDI8Tm1q7jvMYIuupPcCRxCrh/rqC8kKeGHDEoAWg+D2hyQo
	 pdYq1LiB1s4Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19063806C0;
	Mon, 24 Aug 2026 19:03:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D48274B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA4BB405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m1K2uhQIKNeY for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:30:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F5EB3rq0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B88134059B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:30:52 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso589852566b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596251; x=1788201051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9kEeGp9V70F32LVDbwR7RFUkC9sPWMUzCWDvpDhjvv0=;
 b=F5EB3rq0CPbr6hKTZL2XkjvWSVwmjQSods5UG1U0VrZLXlQlT0WIb97uL9qI7qS30F
 plqyZfLpJ9im665o5DeA3wl3pCPxpn0IG5wj74l4HLxoOdxTQhuv/ftJqL+PbNasyh/X
 pIbUZnit0wrisB4U126rNR/KDSyBCYe9LvRVXhDTQas7A8OjS+Ajm5OBS1CxgS3L40gf
 X4EEjai4AmOPfY3ya6tKpiPlMpFqzc4zZ6b1bAzJ6NEm3/z9QKh61CXDG8sOoUsXHsFj
 Qh5OvCQylDjnJxOgJqw0/PbnE6YryufAl3hQi5LFYQpnKa8QGXdDnInBxHyWcGzEJU6B
 6DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596251; x=1788201051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9kEeGp9V70F32LVDbwR7RFUkC9sPWMUzCWDvpDhjvv0=;
 b=C9ELkidEHH4Lgh5LH5s48goW6ITLpcbp7EHfNDJJZgSJsBYXOdu0QnZ05IA236SM/K
 pH3kg/UmICrW3GJfCLk8/Ej8CGh6Cfu6Vmth8bD2nAj4ZzYEFV7sNQEDb7yL58Yjq+Il
 nLY6+9xHlZZG37QAk2X93trYbM+TeLEkIeYSOWSRXqHQiMd8nbNp07SWdz94IiR8lZAa
 ThvMPS5qGfZe23P33Onn3VTuxqU6MObj3rxuwI9qkXXCEm5tcKh/Lc+CQD6SJhTD2k+x
 h3SdVmfOT5xIiXdZfiAiLCHV4Zccufb7vukM4LW+VeFAMaQGr1meUrB0bPrQpwQaZwbb
 G3GA==
X-Gm-Message-State: AFuF++mCQfAoi5TsOwKvU/bZCA9oTAJhS6u/E/GTc3jJWOYFudSqEYKu
 XZkn818whNeAQq4FylVTGf9yUkiaRgslvIRu0p1HJiSG8oVyCA1MhKGB
X-Gm-Gg: AR+sD11fIhVQdbGK68YNExOZi2dRsLbM0KwhQyE68977DXkRn+JNe60bs21Ei68IcAa
 v2Cb5VD8FjuuF1SUtWKYPkUsGNDamncsTgZmmIUSfsboEDdstxRs8bV1lgxwzyncFPq8iyRMwu1
 UT2Ply7R9WNmC1gy8MYrBI9hHMKApI8WpoeOEylIP3AjAO+Fk46gAbVTTZyo+yXIP56mHGX/r0c
 1pUNz5MggIdCiVG4JzYlxSgWj8ZnlnujYKl+Uy+q6TTHc6aBTOxDOGhMjPbjVLADqp9l26t7dlO
 dF6sYW4kO2TwT5YxkQIoZXj6tvWKYBLovnKrKpbXmHUv0fpqozbLc/4Hevi6YdcwXEjkb6cpzt1
 10RKJFoBa5w3nzdX83+pwm3diGSg3K/gATnMoRQ7tBShU+uvBGfT2BUJKOHWANQkMs+L/qoNAnO
 yi6CypnC4XLsUhI+k9oQE694MrY3uinJvLjY4GVn2IugVDAW4vFmtye6E=
X-Received: by 2002:a17:906:209c:b0:c24:cc3c:db11 with SMTP id
 a640c23a62f3a-c24cc3cdcf3mr646060466b.21.1787596250741; 
 Mon, 24 Aug 2026 11:30:50 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:30:50 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/6] usb: fix DWC3/gadget issues and enable USB on Toradex
 i.MX95 boards
Date: Mon, 24 Aug 2026 20:29:08 +0200
Message-ID: <20260824183048.419198-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 19:03:53 +0000
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

This series fixes a few USB issues that show up on the Toradex i.MX95
based modules and finally enables USB support for them.

The i.MX95 has two USB controllers: a host-only DWC3 controller and a
ChipIdea OTG controller. Getting both of them to work together in
U-Boot requires a couple of fixes:

- Combining DWC3 (host only) with CI_UDC as the gadget driver, while
  DM_USB_GADGET is disabled, currently fails to link because DWC3 core
  provides dm_usb_gadget_handle_interrupts() even when the DWC3 gadget
  driver is not built (patch 1).

- The DWC3 reference clock lookup added by commit c6583354b7c1 ("usb:
  dwc3: Look up reference clock DT phandle in both controller DT nodes")
  resolves an index found in the child node's clock-names against the
  clk_bulk of the parent glue node. On the Verdin iMX95 the two lists
  have a different order, so the wrong clock is picked, which shows up
  as intermittent enumeration failures behind a USB hub (patch 2).

- ehci_gadget picks the first USB device it finds, which on the i.MX95
  is the host-only DWC3 controller instead of the ChipIdea OTG
  controller, so "ums" never enters device mode. Skip host-only
  controllers when looking for the gadget controller (patch 3).

The remaining patches enable CI_UDC on the Verdin iMX95 and turn on the
DWC3 host controller support for the Verdin iMX95 and the Toradex SMARC
iMX95.

Testing
-------

USB was tested on a Verdin iMX95, a Toradex SMARC iMX95 and an Apalis
iMX6 (as a regression test for the ehci_gadget change) with:

  usb start

and with:

  ums 0 mmc 0

All three boards were enumerating a USB stick and appeared as USB
devices on a PC connected to the USB device port.

Stefan Eichenberger (6):
  usb: dwc3: core: only provide legacy gadget IRQ handler when
    USB_DWC3_GADGET
  usb: dwc3-generic: fix ref clock lookup indexing wrong clk_bulk array
  usb: skip host-only devices when picking the ehci gadget controller
  configs: verdin-imx95: enable CI_UDC usb gadget driver
  toradex: verdin-imx95: enable DWC3 USB controller support
  toradex: smarc-imx95: enable DWC3 USB controller support

 .../dts/imx95-toradex-smarc-dev-u-boot.dtsi   |  8 -------
 .../arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi |  8 -------
 configs/toradex-smarc-imx95_defconfig         |  4 ++++
 configs/verdin-imx95_defconfig                |  3 ++-
 drivers/usb/dwc3/core.c                       |  2 +-
 drivers/usb/dwc3/dwc3-generic.c               | 24 +++++++++++++++++--
 drivers/usb/host/usb-uclass.c                 | 23 ++++++++++++++++--
 7 files changed, 50 insertions(+), 22 deletions(-)

-- 
2.55.0


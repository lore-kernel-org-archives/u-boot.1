Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D0C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DACF480B5F;
	Mon, 14 Sep 2026 14:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qig_OX5qA8Wi; Mon, 14 Sep 2026 14:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 22A568091C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395433;
	b=i5OQwE2M/RCkSGJlEvH0tRLo7VwkqH7QjiCblwrHazqGJkfcZNBSILfHTybLkBdV0Xvy
	 fdxxn+khfz2jz85j0ibYimjylERUUy06MTIz79TyqN/fBhGMjyS2d3dCf/ga5UKYJy50v
	 TA6FKe7Q5htXJfIEWP06meDAb5Jfv65in/uZwlaK4FrtDLpF9wkjNZq7G11wVm5FWcFgF
	 YtbK++uwXYZt39ajUyh6uByutU7aYtCUNsgwnQkBAWIkWKPEatcBOogq+dOFR0daFKdRt
	 NC2b5CtVGBAslPWwzFurhXWYV2URQrHcF2o5zkXPwFvSqmRE2o5pcTWpDbTwt3za1IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3CkrTD4rGSadAKAeDBnqPoHeHUdLQ1PZ8sXWDM11g+U=;
	b=edsAZ6K33M25hXqQ4He/zQAJ9UFVDGPkhxb2HB/Sbw36JTwEf/IIoGB23trVQt/w/YcD
	 k+DFjZHfa0CSSF/z4nq6/yf2LXjIK/IPdFFA1x7vHYcCCVJpE/oy5KTExh5LbUQPMTuko
	 ogPiTeRbIex1BWUxafRsbMG6dq0B4orwMxHf0ZiZrzTeMCsQMIWfMKwEGlA3DIj1TtCMB
	 bo9BWDQHijnjM16gEMLjhSM7UzYcE8Nm7ozLIwMtWAb0K/KzxNmaiU42AYNUZPif9NFuU
	 Z4IZ9svVwMP+jx8BF82fhvHQP+/v7aahehWNVpvAPj5f/92reG/I7s0iy/Bnr3Ben5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395433;
	bh=3CkrTD4rGSadAKAeDBnqPoHeHUdLQ1PZ8sXWDM11g+U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N89qVSvACmzL9uXj+t03nP04n5ii9CJAmN/uZiQYvdOcAQ+zPQPddeTz8XVcIT3gp
	 HvYqgz8wR9rtUtiR0LirUntgVSxN0Rt7aLHjAMc4wduKpku+UGsbLLsEyRmpmfHLnK
	 kPQqlLjU2Q8c+Y68pegPKH3uC/vo9wpbCeBPioeXT1UDMbYhwkjuQHTaN6y9uf5nDD
	 HW8sBXBgq6HUfS0Z7HF8dh769mzD3DAwIq5gioTumdH3GEPGeWR9vMzgUbKW142Z8V
	 VOtKw2nIEfKTYSxMblGB4kMRT8Zu9WhlLqhLjxxLfFyYAYqAuY6KBGoKkFoOy9Hot1
	 s0txg6UqzepGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22A568091C;
	Mon, 14 Sep 2026 14:17:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03100224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDB03400E2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MiKiNVk7jy1y for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E768E4007C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371800;
 b=B2sWZhs2hMSsvIl7ZXkBvvOCao27aMFHZ71mcpoNkcHOOdSdd1wj8mMkwEu/OJ/0ZylQ
 Ug0IdZPTuSqQYYiqW2eTMuqN1FSIJvmUTDY7UP8qGlmEHc6QvIaRtI9/ywpprCS3ow1bk
 SPribdra+SkP7Rgh/cDugK/34rTSpQ3R8fyhUdJEnebrA8VE5K3/mjv6YWi7jMXUYbhT6
 2Fqi1Q1Kr0nIAR/eIRsSpU/smZq+Gj0J84dXEDPtb3UDiiPu+omE/NNwBGRzy6a4TeTST
 9tAACJ+oC7ybxUTI22eM+vL8mdOEblx/ZVkYSfsfSuO/RZ1Qifsyh4CGyQ9rKM1bIUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371800;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=3CkrTD4rGSadAKAeDBnqPoHeHUdLQ1PZ8sXWDM11g+U=;
 b=osqremMlXQ2/KV886UvyqeXM8gwF2EloAwXwO17jEUZ/rjCHCbVY8C4PNMCvo5R6GW/f
 3hMF6AIx/3TVJ245EJSCqSiO791Hyqx1FWDZA4AS0d+zyU18X27GAUqtVjSul13dyMVRg
 mq66E0CaR2dMlBCDQwNhR+6buwBT7Uuxt360DL5N6L00JZwIg96ONDl4O+y8a98x0Nnck
 TuA2O8I1wHY/DfMqmG3Tdprjou7aXOJNAkzYjGL0ZWV0bqBp/JxG/+V6AqjK7LYvw9d3Z
 Z2PvQLDWP5w28j2+MkV3oinMDSLm8plqjAHKtK3TzBSgm2wav1jr17itRK6MLgj56GA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pVTf653T; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pVTf653T
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E768E4007C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:19 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49e717c9841so9135575e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371797; x=1789976597;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3CkrTD4rGSadAKAeDBnqPoHeHUdLQ1PZ8sXWDM11g+U=;
 b=pVTf653TFq6xA2BHs/PrRkUgt97FTpJdQfqJwCMduiPvQ7Obz1Mc7jO3SAaAPens2n
 /pkKZDCqe1KaIL0/r2HkPT9PFQsjgMRZsxIt32K+vujtIyya8sO5wdKR8rQqH35oTa2k
 4TzszV845EfRTdndhdSWXFgDkIQQ1dUFtksEdRSrLREcNCOPgeapkWPcNNtTvgCcL1yB
 pPKD33bnB4LfZstqAiE2sbYTww7QWrnTMdvGhWkc1Pw5UsB8tEwrXwKF66OfNf4iGGve
 LVvHkbVm+Lq8U/U7yMOrdY4kg+k4d+y9E5SS2HdeM4wSXmLWpKuee3CynXyCJzWI2hHR
 IoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371797; x=1789976597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3CkrTD4rGSadAKAeDBnqPoHeHUdLQ1PZ8sXWDM11g+U=;
 b=cI1dz5RiMEKc4GGZS5REJzab9r+SlB4p/An4HdIvkxvDqkmrGSvRKd6WhENrote1g9
 /yzBasCV87uEdSYqfGuWDVz6SOFKNFtw4vVclRtaXP+HFuaT6HVAbY7pQuyLm9xouGde
 PC4HZ27FFEKg9esjAln6lltPj696tJOrp+UVVQQQW3jLu244XBBCMeY7fZ2ypEHGUqUA
 VXuhaNGcyNct0VzysYmdYK8z7GFLPhBvPTkrlTXQOYhCjN0bJsIi0KYJJxbhGAc8T3Xj
 s+z8ypOui+ODG0YtjBS9Ico6zxQJ0gkU4YCzq6q1XF7ZPwBMXxMOsT41qy+Dz3innbMe
 u9TQ==
X-Gm-Message-State: AFuF++n+oCWn7ceQtOJZIM7XJAuCtVzVFY+mSZ7U9aGrvEwzIlOIySE2
 cKrIjCCLIk+rQKt1KIP2T38qV1lTTgLl0bQJFgTPjhCgTqC3KYBqUvek
X-Gm-Gg: AYBFou1DUKP8P+DV4tSOruBoC1ZiKWrwuNqoJ9sJSXfwFRPBuIFF+PqM5fGsnay7/Eg
 315pTafbW0ME7aZFnduoTeiIDGp+j1XRM3DLXNDXdmaHnd6EJMpR6NgeQW1mGvv5/oEKPx+8xk0
 VNRYBEITJk7js2DxHhmOe0yj37M6vRouIniMd5AWfUx2R9/go2PTrDac1PHv9wOcgJUXPJMaIsp
 b29rYAKEd6KagqIiDViZKPZ1nQTyQ7KnJTR/HS+uu4BowTvXe+ujDmzdWfYQLw1wodNsOwzXEYm
 w/ueg4QGo0v8YDBRKenOLm0Owr9myrWNA272/NhSrGm3Bpn9i80Yfi58OHJLYcTp83zGpeLjxuO
 0COMaBCcPdPJaQZ99NHqhiXvaqXLN7HOTYs4NCOQMnmlQOF9I5KRqduBD6JrZ/H/EEZkl30tH+4
 JipsRvkZ/nQBk1W9NbkdEzbzEwCnUHuKChTIw+HZzTQIpgVDSbBen3AgdaMS17hw0+t2LWInUTk
 Z0=
X-Received: by 2002:a05:600c:1c11:b0:49c:fc6e:a3df with SMTP id
 5b1f17b1804b1-49e7a67e4efmr16347155e9.30.1789371796921; 
 Mon, 14 Sep 2026 00:43:16 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:15 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/7] usb: fix DWC3/gadget issues and enable USB on Toradex
 i.MX95 boards
Date: Mon, 14 Sep 2026 09:42:42 +0200
Message-ID: <20260914074314.12522-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

- Add support for the driver model to the ci_udc driver (patch 1). If
  DM_USB_GADGET is not enabled, keep the legacy driver support enabled
  so that boards relying on the legacy driver still work. The ci_udc
  driver does not bind independently, but instead relies on the ehci-mx6
  driver to bind it (patch 2). I'm not sure if this approach is correct,
  but otherwise we would have two drivers binding to the same compatible
  string, which does not work.

- The DWC3 reference clock lookup added by commit c6583354b7c1 ("usb:
  dwc3: Look up reference clock DT phandle in both controller DT nodes")
  resolves an index found in the child node's clock-names against the
  clk_bulk of the parent glue node. On the Verdin iMX95 the two lists
  have a different order, so the wrong clock is picked, which shows up
  as intermittent enumeration failures behind a USB hub (patch 3).

- ehci_gadget picks the first USB device it finds, which on the i.MX95
  is the host-only DWC3 controller instead of the ChipIdea OTG
  controller, so "ums" never enters device mode. Skip host-only
  controllers when looking for the gadget controller (patch 4).

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

Stefan Eichenberger (7):
  usb: ci_udc: add driver model support
  usb: ehci-mx6: bind the ChipIdea gadget driver
  usb: dwc3-generic: fix ref clock lookup indexing wrong clk_bulk array
  usb: skip host-only devices when picking the ehci gadget controller
  configs: verdin-imx95: enable CI_UDC usb gadget driver
  toradex: verdin-imx95: enable DWC3 USB controller support
  toradex: smarc-imx95: enable DWC3 USB controller support

 .../dts/imx95-toradex-smarc-dev-u-boot.dtsi   |   8 -
 .../arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi |   8 -
 configs/toradex-smarc-imx95_defconfig         |   4 +
 configs/verdin-imx95_defconfig                |   3 +-
 drivers/usb/dwc3/dwc3-generic.c               |  47 ++++--
 drivers/usb/gadget/Kconfig                    |   8 +-
 drivers/usb/gadget/ci_udc.c                   | 152 +++++++++++++++++-
 drivers/usb/host/ehci-mx6.c                   |  38 +++++
 drivers/usb/host/usb-uclass.c                 |  23 ++-
 9 files changed, 254 insertions(+), 37 deletions(-)

-- 
2.55.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66A9C5AD48
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D443A60699;
	Sat,  8 Aug 2026 13:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7dLLfMxiz14h; Sat,  8 Aug 2026 13:40:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CBB860686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196414;
	bh=+puZJ7mgm7ThgozhQAjX+LMIWYV1n+P+Tpv1Tg5t1VA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N82UMkkvq8B/GuBGaE6GALhZ1hOUpiHFac+4JCiskDx4OKrBDflbcxsLwHOYvRpig
	 d/OJ2A5Rg+9O4zqo+7IsejB3Hari3kTHzIGCanaDFph1tWYC3vZUkRIW/36yMyx/LY
	 FGmfcX0gq7cj8W1Hyl8bMsqRFGIlf69Y7j9P9Zt/N5B2+pRRtmT1FW0fcupF7RLAJB
	 BnQUDVyTS15BgcmUSU0e/D98WhWHJoldQRHDPyv7VU2WYlIyssIDOsgKIu1sO5CpVC
	 FC0wADUeieQ9NJufSlPG38kEN9XFh2XmqSjyEjU5qef4AZRjsWb3yFtgl/mm+jcu0D
	 AhEaKm/MCEJvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBB860686;
	Sat,  8 Aug 2026 13:40:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93BB6282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85CFA80DC7
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id shSLLHvMr799 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:40:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 424A180DCB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 424A180DCB
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 424A180DCB
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:09 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so4558225e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196408; x=1786801208;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+puZJ7mgm7ThgozhQAjX+LMIWYV1n+P+Tpv1Tg5t1VA=;
 b=oAkSUZsy+JsQGgra46TJ/6MhuXo7sIMNFpSuLD63gwf4YsmiR5SCO5qfwc5oXpH3xq
 k/DiReGIRc6DPirO01oNFAX4RlDr3jgwuv98caNuDmyc5R2/36c+JA97K/j9wYaBvdm4
 jU/nop8JdfiWbY+LI1UmXrTAi3TuyDVbqjPU0ZpQAh+3hk5A+rElzY/MHJjJlQUPdnRQ
 khqdksKR6lTrCi7QkEmjrL4HFyaZP/7RmLOnc44AnAuNv+CgYhzjOMlpypyz7NZv9jGJ
 IDNqRNghU/kI8G1bmvzzPh0iDmE7v7R9iGbbtpLn5h9RdMNKS+wTRE7bBvScxY6A1qRB
 7MrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFhD6LTVL9NH9oBu9qf5BMn+ZZNwDOtmmhUnSzh+khlrAEeJ5Lq1A1a7UeuTnlEs+RUA+oENA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxdFFTtyKtjCPaEqfkHeIZ9DjgOc8BvDFUqyl2KJtiE7/3TcTg3
 0LF7OnGvZkjn4FS1jMUkHM2l5Np/usQW6aF20eEmFgVjIuVYxLjH8MFcztvQwdAU/1s=
X-Gm-Gg: AR+sD13k6yrU24Vpsar+oV0qMgjF2vzLL+3watMnwkmlHGPmlSN7tWe7r7o0H4ZJq2w
 qKDYg0D8WVk2pTA1wdzcAr4xRT1JiJwdQLtTMNMsSZh0MmTdQIhAMd2xHEkR1nlQAF2wco7J1HE
 lkHFzawfDLrupbTuvWBhTvf+KftMKQdPb+AgGbeb5kMXKrFFFmFfQt3eIPsQFB0P/p2kga76aVD
 osZumrR/Mc8GwVer2Cs17nvJ7f19QAkQSGCk2AXF+CBddTXtHJSiqkBIJIYQ184XzjibhrIPWEW
 zHHLAemDtWZXbh3JJbiZ8xnSvR/U2qUKJ+Lh3eajbLb75Ena/LCssIbrzGcMcOuzc78LVGbaXGz
 eU4pzMK67nVHQLzntcZtSQgWsPQ8VZWAemXOB3seEaqsRtRpwC5khNi5k3W9Oij4ZI0BOa5GfFe
 I7VKMAsYtPGyEcPN21ivlSQzCXKeC1FC1DwpHld2Wym2ERSetdlkvFLKhWkrmiwLUwxA4rVfkgS
 VYEzjxWOqfAon032heKo6vpm2LGp6tceZQ4EASP
X-Received: by 2002:a7b:c7d3:0:b0:496:c977:3b6d with SMTP id
 5b1f17b1804b1-49959e2f01bmr184561205e9.12.1786196407386; 
 Sat, 08 Aug 2026 06:40:07 -0700 (PDT)
Received: from [127.0.0.1] (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm15587361f8f.14.2026.08.08.06.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:40:06 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v7 0/3] Add support for the MTU3 upstream devicetree
 binding
Date: Sat, 08 Aug 2026 15:39:57 +0200
Message-Id: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQTW6DMBAF4KtEXteV/x2y6j2qLMZmTFyFgGxAi
 SLuXpMuiioWdPmkp++N/SQZU8RMTocnSTjFHLtbCfbtQPwFbg3SWJdMBBOGWW6p91AqSMc+Dwm
 hpe0wSpr7K22gbnCgALKWlYeaGSCF6ROGeH9NfJ5/ch7dF/phcZfGJeahS4/XDRNfev+YmzjlV
 FuQKGoGwrEPB49rdAnffdeSZXESa/O4wxTFtMGUVygjtK42TLkyBdthymJW3IeglONGiA1TrU2
 xw1SU0cryKiiPHtBtmPrXPDK1w9TLf3rpDHql0OkN06xNs8M05U5jkEsJygUOf8x5nr8BMt96i
 YkCAAA=
X-Change-ID: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786196408; x=1786801208;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+puZJ7mgm7ThgozhQAjX+LMIWYV1n+P+Tpv1Tg5t1VA=;
 b=Tt12TmFdqZRLJl+hYqD5oVDjjm88tKBr4SH8PgeiogOcrML12nfpiCIpSI4uxB8fNm
 xM3fWFLEbTbqqtJvBAcxwBmufzpJ1l32rsqT9RZHFkyirZn9ES+R8bGU0rJqQNCY9f93
 P5OezlOqDyr3RSPegL+9odGpE7sNWmN3S3qQT++6VEZRJ7Mx5n3U8OTNcAP2U8DdQfEB
 JJOfzIBQSJ85i8Y878iYfZvo0cZsbhbgJye1VvXkD6uog8hmCKbangf3Z0LGcRiDuQs2
 W0UmaNdOn45f0G40mWzo93Ac41T7jkkaqiiMZ/l7KlZgk0Xfpo6GF27INGZwqBzKJfvf
 ZRSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Tt12TmFd
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series updates the MediaTek MTU3 driver and in-tree devicetrees to
use the upstream binding, removes the obsolete U-Boot-only binding
documents, and adds phase-aware SPL host and gadget support.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v7:
- Add phase-aware MTU3 host support in SPL
- Build the shared USB helpers for host-only SPL configurations
- Enable address translation for the xHCI child resources in SPL
- Link to v6: https://patch.msgid.link/20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com

Changes in v6:
- Remove the obsolete U-Boot-only binding documents and use the synced
  Linux YAML schemas
- Split generic SPL gadget support into a separate patch with phase-specific
  Kconfig symbols
- Drop the misplaced SPL_OF_TRANSLATE selection since SPL host mode is not
  enabled
- Include the returned error code when binding the host or peripheral device
  fails
- Link to v5: https://patch.msgid.link/20260804-ccaione-upstream-mtu3-spl-gadget-v5-1-5c3b6ec44eb5@baylibre.com

Changes in v5:
- Use separate device-MAC and xHCI register resources
- Bind the gadget as an internal device without reusing the controller node
- Bind host mode to an enabled standard xHCI child and consume its resources
- Honor dr_mode, including its default of otg
- Reject the legacy combined-register child layout explicitly
- Enable address translation for an SPL host build
- Keep MT8512 peripheral-only until its host clock and interrupt are known
- Convert the in-tree devicetrees and update the binding documentation
- Keep the driver and devicetree conversion in one bisectable patch
- Link to v4: https://patch.msgid.link/20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com

Changes in v4:
- Describe mediatek,ssusb as a legacy U-Boot-only binding
- Fix the MAC resource error and remove redundant ofnode initialization
- Convert the MT8183 devicetree to the upstream MTU3 binding
- Link to v3: https://patch.msgid.link/20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com

Changes in v3:
- Remove the temporary platform data and derive the binding during probe
- Use dev_read_addr_name() for the MAC resource
- Link to v2: https://patch.msgid.link/20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com

Changes in v2:
- Removed typecast horror
- Added platform storage to pass around legacy flags and device
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com

---
Carlo Caione (3):
      doc: usb: remove obsolete MediaTek MTU3 bindings
      usb: mtu3: support the upstream devicetree binding
      usb: mtu3: add SPL support

 arch/arm/dts/mt8183-pumpkin.dts                    |   4 -
 arch/arm/dts/mt8183.dtsi                           |  17 +-
 arch/arm/dts/mt8512-bm1-emmc.dts                   |   6 +-
 arch/arm/dts/mt8512.dtsi                           |  19 +-
 doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt |  46 -----
 doc/device-tree-bindings/usb/mediatek,mtu3.txt     |  79 -------
 drivers/Makefile                                   |   3 +-
 drivers/usb/mtu3/Kconfig                           |  39 ++++
 drivers/usb/mtu3/Makefile                          |  10 +-
 drivers/usb/mtu3/mtu3.h                            |  12 +-
 drivers/usb/mtu3/mtu3_core.c                       |   4 +-
 drivers/usb/mtu3/mtu3_dr.h                         |   4 +-
 drivers/usb/mtu3/mtu3_host.c                       |  11 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  11 +-
 drivers/usb/mtu3/mtu3_plat.c                       | 227 +++++++++++++++------
 15 files changed, 240 insertions(+), 252 deletions(-)
---
base-commit: 6a77840b2f01e98bbad157fd1984a2dce2a3eecd
change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


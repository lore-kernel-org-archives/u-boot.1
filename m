Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940A7C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 12:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39DDF405BA;
	Thu,  6 Aug 2026 12:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WxQZaVeasQmk; Thu,  6 Aug 2026 12:54:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83EF1405A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786020888;
	bh=E2IG3E67gkxPOEy6yjbg542RRs4+Fy0abd+CeKTGRWo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fWykx+Gb7wxSEtgOSDbtu7CYjoH5J5PKHwaF6RejZq5X2Vdz+BgHrhDuX837QCjbu
	 q+TZr+L0SINCBUyNgtznMDiVB0Ex6nazici9cRXTfaP5RmYZc4FSaaHvL+NShtiT+j
	 3bXpUMmajwHNKNhLU1Mrh1bcVz5aHGGP7ZmaXAL8HtTQV0zT7tD5dfv2l6Mc0U9blH
	 ZZ8a58qt9uMgQgOnhTIKSh60nLKmijL7cVWsGna5wWbWQwUB9uM+wS4/dG6DSWQKcM
	 /pFXvLu4w0VxcvtFwAySY8WyT6QFyZc/iSh+H3ASYtl36mliw6B5HtWa23jNyzXNfB
	 SptjmuSDCDiFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83EF1405A9;
	Thu,  6 Aug 2026 12:54:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F555397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 250086072E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kawLgHXyT7gS for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:54:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 58250606FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58250606FF
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58250606FF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:44 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-495590dde14so24607285e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020883; x=1786625683;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E2IG3E67gkxPOEy6yjbg542RRs4+Fy0abd+CeKTGRWo=;
 b=FQIjbnCFl9TV8zmGDCjRMopRvWi8wLUCpORaZiV3qmwNde2cMO9dxY0TI2ID5mrJeW
 PP+Odk1v9yb0E0V+C/1Ju36urCjg6WYiehG9rX7zgfeJYa17CIBGUW8+6ytU89gJcJxO
 2+N8qDFHFlX1/0eNcMSJcVkiLncE9SiCQJlGF3Opb6toeqKquovRoCt0AhKd6LzzA+aC
 JGtdMH4Qx6kirkRBfCqGWBgaVH5rOpdHom8rZezgp0dHrNsbTy1olkxT8Yr7gObrcsVX
 u7Cie2kl4P+iYvSQauwbqG3A1xrC6InRvu8Oa1ckTTxTL+4zxHRGz06pI8me5k0ltaf5
 SvVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfC12pbwIH5FNGgY5PkP6XGw3vtNBavRLWZB+zTKQD3daQgSqUX46BL1Bqorrhuiagoel6bFQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz+cvv/VktOGYMwiF37Ph5zjS7qhcJzi1aq4/nqzHbJAdKmjlVx
 14wCeDBZEUopF3QX/5t8zr3qUR6Qen1jqhPm4Sr6xG6H0f1uRni/8E0J7HkQ0x1BtvA=
X-Gm-Gg: AR+sD11jOEF3zXZiI4HObMQcGoURZwAeU2mBhjZiJuQwxUGNsyp+RixALPGHa8Cerhv
 h/OwdbGGfSwbW9TrmFbRdLHHUxHHeIwGNs4dbGAJT97JyeQ0/s6N4EqIXpoEth5zYTb4X/4AS97
 b7vQbdKFSdQ8c6ZgRganjpgyU2P46MWFEmCIlSbnBJDXtdzBvDyt8eKNugBtdiocMVYGRlmFtwU
 SChkRscAyBRoLZt9aTcMFng5wbiT0qxeNmZygIBvq/ws5+b4Ti/5zJhBhizwbkDwRD0W91WiMbw
 yO02g6rzcp1g5UJmcydCiEg4yIeTlXKyqOJTO2K92vEDcnO4njQcP6oc/iS8SpRFtdlumJ05Dc2
 D86RU9VDzX2+5V44aORpEvxEldKWj80w0M4OtE9F65XeXlIMFoC/EbEVZUeA2c+yj5lkeV9SHrd
 CZeOdPs7IWOf1mjtTbxKCFq/slBQK/NYo7elS1+RarxmHfThDBsVN9ZM188i05dRQkbNoBA3pfl
 sPmGScg4ivwi3uizsaBP9TSWyfIydcwKmPUNXJYkGA32zGu5/VwzZ1+eWAHsfqz8RVI6cYXHoOG
 32HUzw==
X-Received: by 2002:a05:600c:19cd:b0:498:519:e660 with SMTP id
 5b1f17b1804b1-4994e72f7b6mr189245025e9.4.1786020882920; 
 Thu, 06 Aug 2026 05:54:42 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542133f0sm69292995e9.5.2026.08.06.05.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:54:42 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v6 0/3] Add support for the MTU3 upstream devicetree
 binding
Date: Thu, 06 Aug 2026 14:54:34 +0200
Message-Id: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQTW6DMBAF4KtEXteV/wlZ9R5VFuNhIK5CQDagR
 BF3r0kXRRULunzS0/fGfrJEMVBip8OTRZpCCt0tB/d2YHiBW0M8VDkzJZQThSw4IuQK8bFPQyR
 oeTuMmqf+yhuoGho4gK50iVAJBywzfaQ63F8Tn+efnEb/RTgs7tK4hDR08fG6YZJL7x9zk+SS2
 wI0qUqA8uLDw+MafKR37Fq2LE5qbR53mCqbRe3yK4xT1pYbpl6ZSuwwdTZLiXVtjJdOqQ3TrE2
 1wzRc8LKQZW2QEMhvmPbXPAqzw7TLf6L2jtAY8vaPOc/zNxb4b/w1AgAA
X-Change-ID: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786020883; x=1786625683;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E2IG3E67gkxPOEy6yjbg542RRs4+Fy0abd+CeKTGRWo=;
 b=OEeu1NLo2ZODmIfv4K16YbQH6+J+IF/sLz/vIc1p+jJG/tqmSFApW9EKqU2HJpR9hX
 xPbtHcWSDmJ1lAja2QmFeqcfj41Nbsl6InEL8sMaw+bf3lsAVkxEjXkfkHXlDTtQ/zwx
 /NY4bhJhlsboXFuXzbT5+Yjh8jWUg7u4Dh6u62yXEYGP2WX2I3lwwMEN9ynE3cYt1fmg
 5tzq2+1DSnRVuTTvB4uMkwRfHqJRAhMV5gQrDNBz4JWlgW+B0XOAgSInxINRTFzv3Ume
 2y4rZjp1hde8vsvMHHtCOcsWpWZcZ3z/lGkI/OhjHsFB0T62wYIu3jPJqCAaNuBU9wB3
 Cb4A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OEeu1NLo
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
documents, and adds phase-aware SPL gadget support.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
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
      usb: mtu3: add SPL gadget support

 arch/arm/dts/mt8183-pumpkin.dts                    |   4 -
 arch/arm/dts/mt8183.dtsi                           |  17 +-
 arch/arm/dts/mt8512-bm1-emmc.dts                   |   6 +-
 arch/arm/dts/mt8512.dtsi                           |  19 +-
 doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt |  46 -----
 doc/device-tree-bindings/usb/mediatek,mtu3.txt     |  79 -------
 drivers/Makefile                                   |   1 +
 drivers/usb/mtu3/Kconfig                           |  20 ++
 drivers/usb/mtu3/Makefile                          |  10 +-
 drivers/usb/mtu3/mtu3.h                            |  12 +-
 drivers/usb/mtu3/mtu3_core.c                       |   4 +-
 drivers/usb/mtu3/mtu3_dr.h                         |   4 +-
 drivers/usb/mtu3/mtu3_host.c                       |  11 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  11 +-
 drivers/usb/mtu3/mtu3_plat.c                       | 227 +++++++++++++++------
 15 files changed, 220 insertions(+), 251 deletions(-)
---
base-commit: d0c49353a648e135f269a2953dc9326505ba87de
change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


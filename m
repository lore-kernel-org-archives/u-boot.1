Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D97EE9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AF183A47;
	Thu, 19 Feb 2026 11:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q+kLKiZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8088E83D17; Thu, 19 Feb 2026 11:03:44 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2547C83A47
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43591b55727so755088f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771495421; x=1772100221;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pbc5WfK0ONtMIMsmtHAmx9doJ0IvfOqyCGNjm4dKZs4=;
 b=q+kLKiZ4vn9IB83yY62oyjnM4YDezrNn6ItATin716iHEG725XGaoXbjrMuwwmd2P2
 X54BOlQ+YQha2kkRnRZqCZ97TeHSEyLcpnHwOASvcNFujR4stSqM608b/ng0Z5INNdeW
 p8munzJuS39kA+deynUoqN4sri6rMzcU1iPjL918X2UZJHF6O82zuV4h8bv9Y5t7ucYs
 iA3TnQDv+15+LG6gZSxUhMcSYuXSaRqWS72B1na9DDP6bT7o7w5mpmT/EkzpTf67Oo1E
 FuGe7u0/zWYsXuNSFa6NcNfLMkjXb7QPcU5w1nmByaau674KIQEP84twbivU3x6YbI+j
 GTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771495421; x=1772100221;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbc5WfK0ONtMIMsmtHAmx9doJ0IvfOqyCGNjm4dKZs4=;
 b=c5uuxkqqzuudD+rUHKrLwUwOTycs4sGgYzGzObNa6jBBJwVgNrkbExX6OVU2UPxbvd
 VUhWqVAALs0PF7Snbln+clTfO66VsxbStzZr0YqhoYESK70Ar3HueS9cmWWMlGxcWkz8
 ytvGXq+rmia/rGR4Gxtw1dRHmpEA+PvqT/tHheSpTVDD4wmQyduC069u29aqrpCz30rm
 yitP6IFOHb5DFfbaz4i1GvtejYNgRtzL4ttD4f0EE7cC+p46x+GQX4wowoo/ZOscJcqO
 +VeSdIeLxyStDWVIGsQgzkdpomR45/l1dy06amOcwdPdvdVNVg/XkfriE/Ohg97LaKWB
 Swww==
X-Gm-Message-State: AOJu0YycW/3awBfYPJPUs2B0EHApK9YlHeDG0T0LcrTfk9p58A/RQv0r
 M9NPKLW3bnU1PsuwWQ0dKiQI+O+9iDFFOJRZdlFzJxf3CtPEvkF+PgKKFj6Bp+JeAHU=
X-Gm-Gg: AZuq6aJmW4rEXrWQtkl5mgYywJlxvETEqMyB3NnfAuXRVCAQ5zxaAS0HM916awI2yxe
 Kyq9uiv+wX6qf+pULTCIhDzdeEWsftHUu+FXNDFccmteYVStPE85jpd2XdCeOSQyXOy/vN69Dvz
 IBR66+yWebv8RLgp+crlEQ/mW6UGGP8CQoxEi5JJxCcRkNb0gTBcZwx+PRUfWqqYOG8XYrTHnXC
 ky5sE1g6YmZOd7jkYA3IM8XU5JTPv3QzA51silQ0gJ99aw+BsYgZTDJRuPF91wr4RwMA5qIJHEX
 ydnpcAwzGtuANqkIAln5cdFhtzkyJx73o5G3znWdHnDNuEX5IzO50vGMHsx9zYBSZcrsDc/lV95
 lhVzZKZIFV9sFEpcAXq5uCKlmQIAckX8z85JFOeZUkwWfi0bz+kTYqpwfXlqfiFZhi2iOnn44/z
 7YmDE3KMO/nkczQYYjyrGjk85GzDhUkKvKZb4+5a8Ur5tQV5XW8qnlTQr9xwgqmjuxI/PAIiI/j
 oNImcnMortSorf2CHtdzA==
X-Received: by 2002:a05:6000:2dc5:b0:436:3267:3ed0 with SMTP id
 ffacd0b85a97d-4379db61f4amr32090850f8f.20.1771495421407; 
 Thu, 19 Feb 2026 02:03:41 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74918sm47885240f8f.17.2026.02.19.02.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:03:41 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/2] Add MediaTek MT8395_EVK board
Date: Thu, 19 Feb 2026 11:03:36 +0100
Message-Id: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBREf4V07TVteYS68j8Mi5Ze5Eah2mIjI
 fy7FRYmbiY5k8yZhQX0hIGdsoV5jBTIjQnkIWNtr8crAtnETHJZcSEVaGthmOpclYDxBqqs2kJ
 pWXeyZmn08NjRexNemp09Pl/JO/3KnsLk/LydRvFtd3+Kf38UICDnhbFF2VVcmbPR852Mx2PrB
 tas6/oB6S2fjMQAAAA=
X-Change-ID: 20260129-add-mt8395-evk-956c49a28f28
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Hello,

This series add basic support for MT8395_EVK board. It is based on
MT8195 SoC.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- rebased on u-boot/next
- added missing CMD_PART/CMD_GPT/CMD_MMC configs
- Add entry for MT8395_EVK in newly added file board/mediatek/MAINTAINERS
- Link to v1: https://lore.kernel.org/r/20260202-add-mt8395-evk-v1-1-304bd45f609b@baylibre.com

---
Julien Stephan (2):
      arm: mediatek: MT8195 fix mem_map
      board: mediatek: add MT8395 EVK board support

 arch/arm/mach-mediatek/Kconfig       |  2 +-
 arch/arm/mach-mediatek/mt8195/init.c | 21 ---------------------
 board/mediatek/MAINTAINERS           |  5 +++++
 configs/mt8395_evk_defconfig         | 26 ++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 22 deletions(-)
---
base-commit: cf6aa7cf731d3b1b296802e47e9800b0d6bed65a
change-id: 20260129-add-mt8395-evk-956c49a28f28

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


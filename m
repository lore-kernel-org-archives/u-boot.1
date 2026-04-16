Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C044F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE99842E0;
	Fri, 17 Apr 2026 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQcwWhI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E44841D5; Thu, 16 Apr 2026 17:38:54 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519FD840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d73422431so3834752f8f.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776353931; x=1776958731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1TlE0kIBuJVztMBWtVSZnWu/j+S0P6f7pV6CVW/LMjw=;
 b=kQcwWhI6q7kLU96ZTO4fTQafX5BsZngKow8qdKy2hpIEQVT3WnZqZcACGJxYNpMkmG
 DQI58OWG7wtuxFtcNU3TQfyiCjMSCywdng+O1unvL8iN3mCKai0bG4RTzDTrcSmbn65L
 CapIaHddytO4iy7f+diM+n0MlgYFRgoACV7u0mcSnOzs98CBYlmTrv5bf0Uo28zjYVl0
 hkiQK/bUVPSjLpRVq6WI92wrO5KIDZqQ6El1kaFkrYlcM6FgrUwWtwl6NunaBOOpayiy
 8oYsKQoTtOMfnIy72KcSAJJmVYYxueEPj5Qk8BjwzzRQo7988XnmpGvZKHQPerkp9x+V
 S5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776353931; x=1776958731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TlE0kIBuJVztMBWtVSZnWu/j+S0P6f7pV6CVW/LMjw=;
 b=SJVE+vk/KCUBJ/+AlfxwuRRr/ebGEP43ZEPWTq5v3/usEMtXi6OfRBtbjiRew8ndZg
 bnqNPgG6J+CSawn5D12EiM08+0w3jdZhcb6R/L0jJMwUZ1bGvqNSy68D0I+8X+T9lZb0
 PP7aSp2UmroEkqiMx4xoajZlHuyedj5d/X5jbRc6DIBmvyT7t9PpPSTe9N1szU7PC2Yd
 ycZnD41mmusFvoLLXy5E4qPrnGwT+hoK6hVTRquPwJ71lRC6KqvDUBXeln82E/PyPK3j
 99kQmLHG/I3kF4vB8MKzcgxSqtVlHHdqdDt1pqW/5WaBJsIg95TscavuMLKkIjKQ+rvw
 6vXw==
X-Gm-Message-State: AOJu0YxIX0vLnPRe/7KQoXq669dhK1k4T+itKHll8GkrTUz+JKb9G9/f
 NxaQ6y+T1XwJRdvIH46I1FaSSOrfrA8v3Uozyj7EOaVJEhxvLFgsMJqgiQujryBQ
X-Gm-Gg: AeBDiety0Yy4Ml2r/fgO3GizULhplO3pfWxt5+k6t07TJ9hGJikscG9zlvokt4uedyk
 44c9GuMXogWvhYORdcX2HOrT1MZN+abeLkqn9hrf4SgkFC0yB/CduRyDJ6E+8KrY4ar105Qr16f
 cMDB1mF3k2hFV0LnWsFqn4ZPiUj+hurhbECXDlGXIK2hachGWbmPWT9oJU0vzIXOMvmLRBkI1tp
 KGFMw8PpCicvtfSbwT7IibOHYWNGj9h8sfBFq2bFfmCVqLl0uHDaWbp/6M9mRdSBFO6exulWYsh
 DYUzljEn6Xm/L80Dl4usQ9nnmv9OKY+/VmBIEXIEkUlPvzFtLt9nYENv/LWYkvjJR4gz1oZonwo
 7Ss4kYb7oa718dRT0/9OjN1rgYrjTYDqk22rvXCFbPFPsRrLMNX8idnbSeaZPL+a3O3gNcl33h9
 RBKPD/EDDz/AkoXATgoMDq8EuOf5NVCkM+xBTd2yhklNu4kNOwST8=
X-Received: by 2002:a5d:588f:0:b0:43d:7c91:49c with SMTP id
 ffacd0b85a97d-43d7c910714mr23484386f8f.44.1776353930728; 
 Thu, 16 Apr 2026 08:38:50 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm15663463f8f.18.2026.04.16.08.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:38:49 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v3 0/2] Changes since v2: Added missing Signed-off-by tags. 
Date: Thu, 16 Apr 2026 17:38:25 +0200
Message-Id: <20260416153827.14256-1-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Changes since v2: Added missing Signed-off-by tags.

Technical Justification:
While the Linux driver for RZ/G2L relies on DMA, this U-Boot implementation
focuses on the PIO path. The refactoring in fifo.c to use byte-level access
(ioread8/iowrite8) is necessary to handle trailing bytes and alignment
requirements specific to the RZ/G2L bus.

Additionally, explicit reset deassertion is added to the probe sequence,
and a re-entrancy fix (usb_del_gadget_udc) is included to prevent crashes
during repeated executions of gadget commands like 'ums'.

Michele Bisogno (2):
  regulator: rzg2l: implement connectivity notification
  usb: gadget: renesas: add support for RZ/G2L SoC

 .../power/regulator/rzg2l-usbphy-regulator.c  | 10 ++++++--
 drivers/usb/gadget/rcar/common.c              | 15 ++++++++++++
 drivers/usb/gadget/rcar/fifo.c                | 23 +++++++++++--------
 3 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.34.1


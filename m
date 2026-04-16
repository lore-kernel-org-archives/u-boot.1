Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2AEF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E0484246;
	Fri, 17 Apr 2026 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neIxPuQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBF384201; Thu, 16 Apr 2026 16:44:55 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155B4841C2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4888375f735so80932945e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776350693; x=1776955493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pgNGs8KazQCXDiltWvsivJhWjPK9KqU0TGKUkElm4fc=;
 b=neIxPuQnX0q+yza+QeNnh8Am10iyC69/aSsrGYnjSSQZ5A8JHo5APWzrGb2ugcGisl
 1+NNgXHB4pIZJkM1CI6uSlXlmjLGNXDY2uJ0AWnNxkECEVvVFbVp4GGqpP6V7j3/5K7v
 xQ+cgzmTzP0TDVfWIPr5+9htnRIY1astO8ahr+CG8xssCb0nDwIK/qPcv7lFSPQ/pje/
 Hdk4asXRViB+MJOYoqOAzf5vZvW95cpbyXU/loP4kR9FF/oRodZBYf17JcKLrI3lTm6u
 HOw/fItnVBTQd2tbC2mAxZWJl0ZtFvrPsJWoRXeshw9SmuCS90dXH5PFpaQkfUVMOKMQ
 XHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776350693; x=1776955493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgNGs8KazQCXDiltWvsivJhWjPK9KqU0TGKUkElm4fc=;
 b=q76PfE7NBpINyH0PxTIm4gNkJUqUfNUw2MvjWSEPR91d7CbAeshp/Na6hMDB7yArlp
 XLiA8tRKlrq9ZFDOfMt+PeWFKo8DMOa+7rsXenhWh9cv1VJ0BNsbpqmXAVoAOZS4LuC7
 QIiaOsTKTXsqcOoB/MO1HpvPY/msi2KIDtOipksQvWEL9Y/jiHlE2RhHYvtcVYkUyELY
 MnrRA3loIleA6pnLwtk1GLmMKqyHoOKciBnxR/seKjDD2cw/iQ131dFAb+hk4a5f1vUu
 4g/2xC9SxfngRgHAKuiKzExe7s8kGTy/YQ6N6kGJptkKTRanVBpSEbbbN9oeJDBnBGDQ
 bM4A==
X-Gm-Message-State: AOJu0YxcVIC8NGOed08D14Q+9mjWR4GXjGtZNVuJYKRhWiyV+dJuBxxz
 Yv61UTxKtLOSENdhz81kPWyasjYuhC6BLDb85cw24Vse2+hF5hhLnuTGOmDsFVsJdek=
X-Gm-Gg: AeBDievdlBjWWoBiaCBnZCC79KzwU+W+6Ez1yOQTvTfOqybsUtaeS0jAuQzQ1g2rt3D
 XSyJFH1UMWipST81vOX7coE0UFpvHDiM1r5rL7xwHbWmmKQrY8X46xuqmgnj/8fyq7G1YfbUJnn
 Wnog/J7GaqEKPGRKVKMF7dst/o+a/KqrK+cKYAWYSGcnZdPYztKslfTr+mKvhAXvTzpCAfLABfQ
 UEJFQ9/xaMsbWc3JUXonWVX2vMrQOshwJmBaN+YVXsq9icbieTNSWRM4XjsccRhChCgEv3MbR/g
 yroB4tXooSIFVllHA9iAw70Y0Ybfym41fokOs7DCSlR0z83b21T9D3j+ppkpGS9CT2umn/124Q+
 92UO0nG9rZDGOX6Cy1MMPsPvzWDEttWg7w6r0TpYptonT84uPQizVclFQuvVipiPUgcQA6gYI27
 PidY/bMD9aa9yQ2zo2KivSkhdVLDtdHAdByyrF4VQp
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-488d685b577mr308027665e9.21.1776350692907; 
 Thu, 16 Apr 2026 07:44:52 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f58163cbsm58756775e9.1.2026.04.16.07.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:44:52 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, paul@pbarker.dev, jh80.chung@samsung.com,
 peng.fan@nxp.com, lukma@denx.de, mkorpershoek@kernel.org,
 trini@konsulko.com, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v2 0/2] This is version 2 of the RZ/G2L support.
Date: Thu, 16 Apr 2026 16:44:24 +0200
Message-Id: <20260416144426.12728-1-micbis.openwrt@gmail.com>
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

This is version 2 of the RZ/G2L SoC support for the Renesas USBHS gadget driver.

Changes since v1:

    Split regulator changes into a separate patch.

    Refined FIFO PIO logic for better alignment handling.

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


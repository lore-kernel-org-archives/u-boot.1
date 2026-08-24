Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6545C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2661080E34;
	Mon, 24 Aug 2026 19:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29-r77vl10Fp; Mon, 24 Aug 2026 19:04:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598241;
	bh=mq9khfZB/C90iA3znsoFwn8zV5JL94aRstxZ5j6hi5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ygQ51MYkj+YsyXWOXNBsU7BDoLJUdeF+ruj5Vz+aHTEmzIdDHWirGMIJOCCzv7ZoY
	 fYSC2Pbr4FBiWr40tyuhnEDDygFQ2TT6pvooz9Nc7aKaMG7GzRx/2lxmc3Tx/fF60e
	 yqxHsVKAPdTO6x6fRHED/JsHcmQNGXD6RMgkK/A1//1kGy4lvReJp/KaaaIxQHXqwO
	 X7EknpU7de7Ht7/9nWIC5fuy8BKAiE5hgYptpHQXGI48/ytgs1lGcXfHlz0yWDOnJJ
	 OlVo4iEYKHLUP2+P73Nd739e70CrlUb0jOQLYeCHoJPTvNzppIpisoOcSBof6q60iO
	 Bzx5j0cveUJ4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A18BA80E13;
	Mon, 24 Aug 2026 19:04:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D1182FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33163405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79rfL8JYslht for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:31:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Fq9ZOo7c
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E1D74059B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:02 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15f020a223so568706066b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596261; x=1788201061;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mq9khfZB/C90iA3znsoFwn8zV5JL94aRstxZ5j6hi5k=;
 b=Fq9ZOo7cUDawB8NrQL9PwMxwxNe50DjsY45RlVOhn8truKtqCygrQGnjHJnvB+qb0Y
 mRmpKpzd55WFT6fGqjA8avfoD/pAdoGALUAjWITYG5oV7gwm9yGhLHtNfae7HIuR/bQ9
 ih9YkGzm8H27lDYMf19AWglQDCRB2LKqgfl7baaIjUCJYjZ9NkbUq8TIEGEXro28tyb9
 6hhdnMHDJfr9V8j8oEwoP2wgmWZshJ8HYzlnuS9v3fYYmF1snLJHWjmxwHn+xmFKUrCy
 7MAZD0COOtweq0YGsYYGuGmCCNYR/dNuIcBvmYFBZSxpf6RfNoU0HT8mKP/yf9IHs0Am
 z+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596261; x=1788201061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mq9khfZB/C90iA3znsoFwn8zV5JL94aRstxZ5j6hi5k=;
 b=eLm6WpyixAIqpMqVJEZlHoFEptuvsnv2DuuZeWCBpZEAIh33tP4fYhE/cHKxNpVoB3
 pvPUnt1k92t4C6ZiRafU/lRt5gl9CisRcCY93SaWiLCNAzl1KXSjeCCNgDtiyAKIaOYZ
 vrLQhdw22JeBJqnvNiQh/Pn5ou1eCHz/sHrxwkMKjXXG9is47YnL3D+rIMEQWGwLR+X5
 kYj4vGUm1hmdGXGmM0ygsVZBLTyC/eJ88rbbLwQm82cgMBBv9sX7J1WgCN70QzYztt/l
 K/xvR6pxZpPYfftOkejfGy6ITIn+jMVJVWF8QN+VQeRQE9Ffoqjb40n3Av2p46MMya/Z
 Xxmw==
X-Gm-Message-State: AFuF++kyjQIvug/BjpbmlkF6RDp5AoPQG6VDKMZJZUsGFuTvtSRsMiQX
 aEHbUREBTI7BIJtPkrFRnFh939wesPJl/WgGAxQRoDic0ISDwxmJIF+Y
X-Gm-Gg: AR+sD13YV1vRJF6azPQYBZjQpbo8kW7WxlKR2FO74HS16QkeWkHushqerA65Ss7vQ9/
 EDd2IBofdBcPXP8/7nB3DtkMvMc6htZ1EhEE1YZz8tD0Rl6hZ7nvR3ItQ1A73Bq9CEx/oD0ESab
 oDDyqinTW8MY90EjzTNiZgqGvYhVcyu7JSQWotwJDtCp8SaNA6aI0Ni4bbslyqTH0ZDLinl8lfU
 znJhiJUT1GACHOGR7ffsjbhT1/p97D6vmijtvzCo2AHP6PSwCudrrrtagkc8lFOx4v1BQyMkSUW
 2sL5ZloskKJywW8/DBKe0n/UyPLbjxIDTOoxMJV9WxwA2Yk0//gEuCsoUGn4fQBALe21s4mXhtF
 mHvuoBpbAEwRF+m73dbrFFO8pO/sv8p8raLXt48pQ6rjPCIdWGZozZkM3vTasM6hnIpqcy6XMsC
 PhZqUymFiqCY1Auq9ihFILPy8yGQbn4nPTNDMpiqKqb5q4HJWN
X-Received: by 2002:a17:907:a602:b0:c21:167b:47f0 with SMTP id
 a640c23a62f3a-c246a4ae088mr3641466166b.2.1787596260759; 
 Mon, 24 Aug 2026 11:31:00 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:31:00 -0700 (PDT)
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
Subject: [PATCH v1 4/6] configs: verdin-imx95: enable CI_UDC usb gadget driver
Date: Mon, 24 Aug 2026 20:29:12 +0200
Message-ID: <20260824183048.419198-5-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824183048.419198-1-eichest@gmail.com>
References: <20260824183048.419198-1-eichest@gmail.com>
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The i.MX95 SoC has a ChipIdea USB device controller. This conflicts with
CONFIG_DM_USB_GADGET. For the Verdin iMX95 we want to have CONFIG_CI_UDC
enabled and CONFIG_DM_USB_GADGET disabled to make sure the ChipIdea USB
device controller is used.

Fixes: 60d8255d8dc0 ("board: toradex: add Toradex Verdin iMX95")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 configs/verdin-imx95_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index daf41a8b830..2635d899be0 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -167,7 +167,6 @@ CONFIG_FSL_LPUART=y
 CONFIG_SPI=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
@@ -179,6 +178,7 @@ CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_USB_GADGET_OS_DESCRIPTORS=y
+CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
-- 
2.55.0


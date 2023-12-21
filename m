Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BBBC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1521187880;
	Thu, 21 Dec 2023 01:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tnBOywDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C6D87880; Thu, 21 Dec 2023 01:41:34 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC788786F
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-425a116f1cdso1519121cf.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119289; x=1703724089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+JawORSw3adUuJQkLX0kmXXKADD/mZLY5GdmSpzMXo=;
 b=tnBOywDx+zxP69H1gIVTCn9GDyz7Rcs21hrMtCPNNR8pSgwkJOcRRYZy78nsvCZ8dX
 AcBCmHaTmGdj/0+uHIA7lM2WBlKFvgAWM5Or5PAB3OMv12NIEln8bVRZi+eg+nJJPf58
 bVSEpk2iFfWJMvRj3vjcPAKI+RtsVFJre+PHruHe2xa6aJ/4+w3LlFA7hFNmlulm9pfB
 voV0VZiNQAbG910+FGQuH1NwzdeUdboZBRFO8oHS0wXQu8d3DF52oPiB9P2KeTMQdUI/
 WSiwSvQ7or0tEetJtfQ+vPwDZNXvrFrtOzxQfPwStORsTIpbXQt2wvHjz+gOZ/ZIQ1h+
 LKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119289; x=1703724089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+JawORSw3adUuJQkLX0kmXXKADD/mZLY5GdmSpzMXo=;
 b=tniwrcyv3UzNpGWdLAdYbU6jUTM6DcCLC1HOH7I0Q0AMBqUQ77eV2hV5OuHgQbXdnb
 GWabi+myDVMYeoUiOkGRtfbD9DNqIahe21duP57uxkmH08grKtNdbf5+7MqamLAqZ8kT
 YH2KB/sXuKwX5pil2HD/vPMJa/pndphw7j81V08rPBtcQgXz4/prQWXWKN1Qh+gHfzpQ
 iEPEMTt+4c+EEEIKeWlX5fnB/tobPPnQ2U7wdIPD5ebYIpwppUxNjU+aWFRvVIS06IHC
 Gube03uIho7yhaX2gJDDSK5bTMBCod4YsXUieDbZ7kQ5FM5msv5rXA/pX8Svy7hprMsD
 AcDw==
X-Gm-Message-State: AOJu0YwuEe2NoK2Gt1v5Jfam3t16+8pjKavhqO09VIyuFPOiU5xL2yoP
 i8L9Ufy3821SdNLwPvO1LAJdbRFuDOlzER/t/kk=
X-Google-Smtp-Source: AGHT+IFltAOlMnJAa+cBy2SpZqdvcSCHLmytEMracaS0uYBBs1U8RXERUlCIhcDxV6C8Q70ikrQxEQ==
X-Received: by 2002:a05:622a:1792:b0:412:395c:e794 with SMTP id
 s18-20020a05622a179200b00412395ce794mr28255003qtk.50.1703119289674; 
 Wed, 20 Dec 2023 16:41:29 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:29 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v2 9/9] qemu-arm: get FDT from bloblist
Date: Wed, 20 Dec 2023 16:40:28 -0800
Message-Id: <20231221004030.581388-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Get devicetree from a bloblist if it exists.
If not, fallback to get FDT from the specified memory address.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Refactor of board_fdt_blob_setup().

 board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 20801d0750..6af7bdf4d1 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -143,9 +143,17 @@ int dram_init_banksize(void)
 
 void *board_fdt_blob_setup(int *err)
 {
+	void *fdt = NULL;
 	*err = 0;
-	/* QEMU loads a generated DTB for us at the start of RAM. */
-	return (void *)CFG_SYS_SDRAM_BASE;
+
+	/* Check if a DTB exists in bloblist */
+	if (IS_ENABLED(CONFIG_BLOBLIST) && !bloblist_maybe_init())
+		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	if (!fdt)
+		/* QEMU loads a generated DTB for us at the start of RAM. */
+		return (void *)CFG_SYS_SDRAM_BASE;
+
+	return fdt;
 }
 
 int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
-- 
2.25.1


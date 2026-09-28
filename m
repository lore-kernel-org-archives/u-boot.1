Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD4CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E42405E8;
	Mon, 28 Sep 2026 15:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eP5r39oT4KX7; Mon, 28 Sep 2026 15:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 90EA64069C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608002;
	b=OLKYIt5RsX8IRn/WRALMTNB6kcuzfA1xTk8OIzMLnj03kFXHBAemnn2DsZrNDCbjfB5p
	 unEW2wokiYbskYuVxaHa700R+a4LUktzwKNIANGWN65XVbxaVVVzDILv1pZVMgK0ca/W+
	 8/BFE/gkDWf66g7Y5g1YkkU670/I8HnF75207OA4FSfR7R3/XxHfovTXFosIPED5sRpgo
	 rNeT1iiVBjcZ9xxkRwcKoUM+ECW/NNTO1bFDR5adB5EN5/zxdZ9PYvMSj5nnv4qAv0Fjl
	 AQkeAJQ577snu4f3P55GCHY1Nw1nZxZZZPWq99jvUvyOmnaAg6t9wvOZxigmAREIV5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z+ooHAHYwmQD4289DkAWTOrznO36GjUKRb+DnXhnXsg=;
	b=LC2Xbj9/uUXDAhwjV3W1P1N14mGxW3NG5DDHgak4Z5sJWRyVWmSyA3zgh357ciS+9WHo
	 pNSbhKYcjCsQcJbgjQRgBLc6JiSYGzjGpuxVyWmlqIAWVIkF2W1LA/EYaRwGuSxi72kMG
	 /7/9RnZUNvp3xS4ZJc3vBPIjRQRKRuYyOsA+dGoFbEQUU+vyjCfLY8krOEs3BhejzTQLK
	 uiVchFLPfIIH1KtAVy1EfK2LOh+4li1fCzMPnEgGLf6bvJ6gmHIxGQ6ILDwFDZXxZGdtV
	 YnT9oRIrnRnfqqQSLIke70hGMgpA5F9GJeYyKewKnQlol0WUSNOficckJQwBOI0sVDw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608002;
	bh=z+ooHAHYwmQD4289DkAWTOrznO36GjUKRb+DnXhnXsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXs2bIvG+VZvaobGJLjkftD6Lw0oBRjdA2S2SI+/5hSS6zBsZkmZLCWuQkNw+owfW
	 9G/covyw3X6c0nvWRNlWXNHbsqgv76/+KVeMHyeXORM2VCj2vl6EDb1q4ygaXv31Gp
	 YNXGUyY45DrrwgA8AobzuxXdC42NqqzhIuNnM1csX3+oSWsOMehXbB/bFooLcFzRvp
	 ePS77xWor3nD3nUOPtBbmJarAKdZhHlbQz+wcpt0VAm51Yd1ph6veAGuWQltlVI6mX
	 d6CLNDrZrC5UMtB1DhC/H3dSFLErV5YR5nbW992vmW4GOriH4OCaiy5hGRd5YDuFCm
	 FrTHBxGOFEQWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90EA64069C;
	Mon, 28 Sep 2026 15:06:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4E8F3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA2C8606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoGAyOHuznzh for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 602C3606B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608000;
 b=cC+W+ciuM/iEQbeqVyRmLjYfGuaXrxPxkEC6hkWFrDi8dAF0yAp4g6pmxHHKEdJf20P7
 P4ToSdFDiiTCxxx8G3VaA6HeWhbviphKDrZ4lunOkQAu1t1PfEfMFXJ2OllXBZ0S0TRUn
 coGpLgPb5pAEdBpFwdW9lB/11Yi+aiM736wUhN/6nCJMVYUJnq8GlbeY8fsibDuXyt8is
 OySX4lJwwu7mk+8qjAn7XV0OBj1l3OQxGRqugim0+3/WF66DCRHUhabxwE3VXm9WDsd19
 4hUc3euI6NSlTleW6ApxdWUZlaSkXJr9BWjm5Z1c7VdFEsa7mUFOr6dN92FYdpsSV2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608000;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=z+ooHAHYwmQD4289DkAWTOrznO36GjUKRb+DnXhnXsg=;
 b=AqZt+HtvQ9xCqiHhNxlZXQrNFy+efJft5MqXv67aAkuCRXHAuUfweccwe4qisKyR5TMC
 hD3rz8+XAZoOLW+AAO7ctNBgBbcmgd1O/ogLNATCZFaYUzgP/+3A1FM+R3yn7bwWl6wkf
 +w4G2cHytICVwEhvcwKCmTWWt+SWhin9BaatBrO8f88FrIvD+O4eHHwJ3J3ZbDTuT9UaQ
 +gMHdSr2RYVftyk8MVftYtPmInY5Tp7nkVeD/907+paeookX13HGlg/tmNxsEpoyJ8O0P
 yAAR6WMus4DB7Hd66yaPfZNt3Ibg0IS1+o+t8ehPnErojCJtKdDX4YMpElH33jJBXsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SRlosJGz; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SRlosJGz
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 602C3606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:38 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso34059865e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790607997; x=1791212797;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z+ooHAHYwmQD4289DkAWTOrznO36GjUKRb+DnXhnXsg=;
 b=SRlosJGzSTmXDxmCR+TK43p4y7lco2CVhfe9RY44WS772dKfsxa3oaZ/xOWtSa2ArT
 KmgyirXav5MB9jJygekAdjDrhdRN2NVHCS9tITu/W+3wf5Vmc4zUxccuc5eUBihZmpF4
 ZgB5ht3vSWtQdduOxaSgKlDU2wQ1srRca6IP9ZG/8c1Mx7Y/51pYHzczmdb+P1+VX0v+
 8nz6gcGTMezukgWuZg2W4dyzcDiMA3V1rpWPJN+K3zHLLtk2xMtiB37FhRyb8rH5iuGJ
 sVpmrYsHQKxW1pzfrLKnzu/k/z+kYOrm93Bs+Y2HX8Zzo0dTHVPOkhoN+AOyNO10D9YF
 IvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607997; x=1791212797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+ooHAHYwmQD4289DkAWTOrznO36GjUKRb+DnXhnXsg=;
 b=ZnJHVYPK+yoKCs+hz2oQEkTZMYnKxb/QUBeH2JyoEWUqmERigr5cqkqw/lUkz/+/3u
 xgGQvQaZQnL5TJgr4r0BmCeMFZDRB3Ojm0IKJLzPzQr4LnTwQUWLLltaPmOBbFA9g/C6
 r3pOw/lyYcPTzZ2/PDk/1E6nmt5w680WeaRlq2xPDc/XQ2UdLoGrZaWGr0R4l8mJ8CWE
 Sp47FxWr/eUCm6axUWjnp9qp/QTy3vqMoqYa7xxVeQCRCmaUbGp+gfeVGuzmN0S+pXaz
 QbYf9rypa5djoNjuC1Zqf7UItXfvx64w8YtJn9fr7I7ZxP+Q9iAPpj/N1EG0HcAKMLIh
 vr9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq+IZxR1Y7Cu8RHU6aGgt0HmqxdvoGpEtgULkGUCPgol7+qVDpXTOND6Yr1ZO89iz6HU5g1JE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mYapDgFhwk2FvXfjJhJRx2znL3oamS0geSi8uLs/qsf2rOYwR3
 yvVrTKZ2eHNYL9I/V9eKQ/IbSxDzT55K6lmTFmz6L3AUE7QX2TVNtvaP0KOgFKhu2iM=
X-Gm-Gg: AYBFou2/txC3rBjjb0hW4phTakIJqR0SeDXjeh8Qr0cNzCQE/lazPZEoczPLsWG87rc
 BYLJcWWAZHjUdnKuOgnEDc1DxmZKhjkLj+Mivuz4dBXzCddpDZvzp2ftkQSSa274C45Rr4Xv1Zc
 nUMXU0XXx5Rh06fDhen2qgVhtPms/RydqdteSyMlXwVup1FsKxZfgA4dhxo7m6y9lJocDn4bGc+
 ItvaMs1Etu92WPuNWO6HBtkP+LLf+py8Zs5J+Lvv53wDKZGcUpLbywjAxbii4LzDWRmxmXYjzZ6
 RdDPQgsXDXRR6gI6qMu7Z2Xr/udZ+RFaw2/rpd+DPe6ozKfzhVs4ZQsvrTHh9Vd7VAFA+TU/0Xb
 TbSQkS+2v5S51bjP7pzXBy4mbPSi1+n5rg1IwP6FxfdS2BTJeq3JEx2VLjz/KZIVPpFTCQ87yQf
 rFXrH5XDhYn0xs7XpIH9E3T+aKxQmEBrlb3jQKH+5egL2UYQuMVW2kpKi6SUkSgdG1RMb/1uj6J
 9sIL6MGaNVVk3DaDksb0yducQhqN1HjxWxrltQLiaIIIteI4yyHLZQsBm8f5TVlmAdIeYqtdtgk
 iBRjtgElHLAigVwc85kOgTvzIGcbUfIbK+SAwy/7lVne1sDvCBCQee4=
X-Received: by 2002:a05:600c:621a:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a0011a804cmr75250965e9.7.1790607996826; 
 Mon, 28 Sep 2026 08:06:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:38 +0200
Subject: [PATCH 01/13] memory: mediatek: mtk-smi: support smi_common and
 the larb ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-1-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

The DMA masters of a display pipeline reach DRAM through an SMI local
arbiter, and the larbs themselves through the smi_common block behind
them, whose clocks must be ungated as well. Drive it with a second
driver in the same file, found through the "mediatek,smi" phandle of the
larb, and reference count both: several masters share a larb, and
several larbs share an smi_common.

U-Boot has no IOMMU driver, so those masters address DRAM directly: add
a helper taking one larb port out of the translated address space, which
the overlay calls once its larb is ungated.

On some generations, such as on the MT8366, the port mmu_en bits of
SMI_LARB_NONSEC_CON live in the secure world, so clearing them from
U-Boot has no effect, as the Linux driver spells out:

	/*
	 * When mmu_en bits are in security world, the bank_sel still is
	 * in the LARB_NONSEC_CON below. And the mmu_en bits of
	 * LARB_NONSEC_CON have no effect in this case.
	 */
	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_CFG_PORT_SEC_CTL))
		arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
			      IOMMU_ATF_CMD_CONFIG_SMI_LARB, ...);

Ask the secure monitor for an empty mask of IOMMU ports, matching the
physical addresses U-Boot hands to the DMA masters. As in Linux, the call
is only made once the larb clocks are on, from mtk_smi_larb_enable().

Four compatibles are added:

 - "mediatek,mt8186-smi-larb", the generic fallback the MT8365 larbs
   carry behind their SoC specific string, so a single entry covers
   every SoC reusing that larb generation,
 - "mediatek,mt8366-smi-larb", which the MT8366 larbs carry on its own
   as that SoC is not upstream yet. It is the only entry with driver
   data, since it is the only one needing the secure monitor call,
 - "mediatek,mt8365-smi-common" and "mediatek,mt8366-smi-common" for
   the smi_common driver. Neither node declares a generic fallback, so
   both SoC specific strings have to be listed.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Kconfig   |   1 +
 drivers/memory/mtk-smi.c | 223 ++++++++++++++++++++++++++++++++++++++++++++---
 include/mtk_smi.h        |  19 +++-
 3 files changed, 229 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index a3b7c722070..772b315d41b 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -23,6 +23,7 @@ config ATMEL_EBI
 config MTK_SMI
 	bool "MediaTek SoC Memory Controller driver"
 	depends on ARCH_MEDIATEK && DM
+	select ARM_SMCCC
 	select MEMORY
 	help
 	  This driver is for the Memory Controller module in MediaTek SoCs,
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b90f5cc135f..caba8b5c72a 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -1,47 +1,204 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * MediaTek SMI local arbiter (larb) driver
+ * MediaTek SMI larb and smi_common driver
  *
  * Copyright (c) 2026 BayLibre, SAS.
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <errno.h>
+#include <linux/arm-smccc.h>
+#include <linux/bitops.h>
 #include <mtk_smi.h>
 
+#define SMI_LARB_NONSEC_CON(port)	(0x380 + 4 * (port))
+#define MMU_EN					BIT(0)
+
+/*
+ * On the newer larbs the mmu_en bits above live in the secure world, where
+ * "the mmu_en bits of LARB_NONSEC_CON have no effect", as the Linux driver
+ * puts it. Which ports of a larb go through the IOMMU is told to the secure
+ * monitor instead; U-Boot sets up no page table, so it asks for none.
+ */
+#define MTK_SIP_SMC_CONVENTION		(IS_ENABLED(CONFIG_ARM64) ? \
+					 ARM_SMCCC_SMC_64 : ARM_SMCCC_SMC_32)
+
+#define MTK_SIP_KERNEL_IOMMU_CONTROL	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+							   MTK_SIP_SMC_CONVENTION, \
+							   ARM_SMCCC_OWNER_SIP, 0x514)
+#define IOMMU_ATF_CMD_CONFIG_SMI_LARB	0
+
+/*
+ * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
+ * handles them as part of its SMI/IOMMU framework (its mtk-smi driver);
+ * U-Boot has no such framework, so this minimal driver only ungates the
+ * clocks of a larb and of the smi_common block behind it, on behalf of the
+ * DMA master sitting in front of it.
+ */
+
+/**
+ * struct mtk_smi_common_priv - private data of an smi_common block
+ * @clk_bulk: clocks of the smi_common block
+ * @enable_count: number of larbs that enabled the smi_common block
+ */
+struct mtk_smi_common_priv {
+	struct clk_bulk clk_bulk;
+	unsigned int enable_count;
+};
+
+/**
+ * struct mtk_smi_larb_data - per-SoC larb data
+ * @port_sec_ctl: the port mmu_en bits are controlled by the secure world
+ */
+struct mtk_smi_larb_data {
+	bool port_sec_ctl;
+};
+
 /**
  * struct mtk_smi_larb_priv - private data of an SMI larb
  * @clk_bulk: clocks of the larb
+ * @smi_common: smi_common device behind the larb, if handled by this driver
+ * @base: larb register window
+ * @data: per-SoC larb data, NULL when there is none
  * @enable_count: number of DMA masters that enabled the larb
- *
- * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
- * handles them as part of its SMI/IOMMU framework (drivers/memory/mtk-smi.c);
- * U-Boot has no such framework, so this minimal driver only ungates the larb
- * clocks on behalf of the DMA master sitting behind it.
  */
 struct mtk_smi_larb_priv {
 	struct clk_bulk clk_bulk;
+	struct udevice *smi_common;
+	void __iomem *base;
+	const struct mtk_smi_larb_data *data;
 	unsigned int enable_count;
 };
 
+static const struct mtk_smi_larb_data mt8366_larb_data = {
+	.port_sec_ctl = true,
+};
+
+static int mtk_smi_larb_bypass_iommu(struct udevice *dev)
+{
+	struct arm_smccc_res res;
+	u32 larb_id;
+	int ret;
+
+	ret = dev_read_u32(dev, "mediatek,larb-id", &larb_id);
+	if (ret) {
+		dev_err(dev, "cannot read mediatek,larb-id: %d\n", ret);
+		return ret;
+	}
+
+	/* the fourth argument is the mask of the ports using the IOMMU */
+	arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL, IOMMU_ATF_CMD_CONFIG_SMI_LARB,
+		      larb_id, 0, 0, 0, 0, 0, &res);
+	if (res.a0) {
+		dev_err(dev, "cannot take larb %u out of the iommu: %ld\n",
+			larb_id, res.a0);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mtk_smi_common_enable(struct udevice *dev)
+{
+	struct mtk_smi_common_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* several larbs sit behind one smi_common, only the first ungates it */
+	if (priv->enable_count++)
+		return 0;
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		priv->enable_count = 0;
+	}
+
+	return ret;
+}
+
+static int mtk_smi_common_disable(struct udevice *dev)
+{
+	struct mtk_smi_common_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->enable_count || --priv->enable_count)
+		return 0;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	return ret;
+}
+
+static int mtk_smi_common_probe(struct udevice *dev)
+{
+	struct mtk_smi_common_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+
+	return ret;
+}
+
+static const struct udevice_id mtk_smi_common_ids[] = {
+	{ .compatible = "mediatek,mt8365-smi-common" },
+	{ .compatible = "mediatek,mt8366-smi-common" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_smi_common) = {
+	.name	   = "mtk_smi_common",
+	.id	   = UCLASS_MEMORY,
+	.of_match  = mtk_smi_common_ids,
+	.probe	   = mtk_smi_common_probe,
+	.priv_auto = sizeof(struct mtk_smi_common_priv),
+};
+
 int mtk_smi_larb_enable(struct udevice *dev)
 {
 	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	/* several DMA masters can sit behind the same larb */
+	/* one larb feeds several DMA masters, only the first ungates it */
 	if (priv->enable_count++)
 		return 0;
 
+	if (priv->smi_common) {
+		ret = mtk_smi_common_enable(priv->smi_common);
+		if (ret)
+			goto err;
+	}
+
 	ret = clk_enable_bulk(&priv->clk_bulk);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks: %d\n", ret);
-		priv->enable_count--;
+		goto err_disable_common;
+	}
+
+	/* as in Linux, only talk to the secure monitor once the larb is on */
+	if (priv->data && priv->data->port_sec_ctl) {
+		ret = mtk_smi_larb_bypass_iommu(dev);
+		if (ret)
+			goto err_disable_clks;
 	}
 
+	return 0;
+
+err_disable_clks:
+	clk_disable_bulk(&priv->clk_bulk);
+err_disable_common:
+	if (priv->smi_common)
+		mtk_smi_common_disable(priv->smi_common);
+err:
+	priv->enable_count = 0;
+
 	return ret;
 }
 
@@ -60,23 +217,67 @@ int mtk_smi_larb_disable(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "failed to disable clocks: %d\n", ret);
 
+	if (priv->smi_common)
+		mtk_smi_common_disable(priv->smi_common);
+
 	return ret;
 }
 
+void mtk_smi_larb_port_set_pa(struct udevice *dev, unsigned int port)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+
+	clrbits_le32(priv->base + SMI_LARB_NONSEC_CON(port), MMU_EN);
+}
+
 static int mtk_smi_larb_probe(struct udevice *dev)
 {
 	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
 	ret = clk_get_bulk(dev, &priv->clk_bulk);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	/*
+	 * Not every smi_common block is handled by this driver: where it
+	 * isn't, its clocks are already ungated by the time the DMA masters
+	 * run, so having no device for it is not an error.
+	 */
+	ret = uclass_get_device_by_phandle(UCLASS_MEMORY, dev, "mediatek,smi",
+					   &priv->smi_common);
+	if (ret) {
+		dev_dbg(dev, "no smi_common device: %d\n", ret);
+		priv->smi_common = NULL;
+	}
+
+	priv->data = (const struct mtk_smi_larb_data *)dev_get_driver_data(dev);
+
+	return 0;
 }
 
+/*
+ * The MT8365 larbs also carry the generic mediatek,mt8186-smi-larb
+ * compatible, which is the one matched here. The MT8366 ones only have
+ * their own, as that SoC is not upstream yet.
+ */
 static const struct udevice_id mtk_smi_larb_ids[] = {
-	{ .compatible = "mediatek,mt8188-smi-larb" },
+	{
+		.compatible = "mediatek,mt8186-smi-larb",
+	},
+	{
+		.compatible = "mediatek,mt8188-smi-larb",
+	},
+	{
+		.compatible = "mediatek,mt8366-smi-larb",
+		.data = (ulong)&mt8366_larb_data,
+	},
 	{ }
 };
 
diff --git a/include/mtk_smi.h b/include/mtk_smi.h
index b0166b37538..4c904d8bfe1 100644
--- a/include/mtk_smi.h
+++ b/include/mtk_smi.h
@@ -15,8 +15,11 @@ struct udevice;
  * mtk_smi_larb_enable() - ungate an SMI local arbiter
  * @dev: larb device
  *
- * Enable the clocks of the larb so that the DMA master behind it can reach
- * DRAM. Calls are refcounted, so several masters can share one larb.
+ * Enable the clocks of the smi_common block behind the larb, if any, then
+ * the larb ones, so that the DMA master in front of it can reach DRAM. On
+ * the SoCs where the secure world owns the port mmu_en bits, also ask the
+ * secure monitor to keep every port of the larb out of the IOMMU. Calls
+ * are refcounted, so several masters can share one larb.
  *
  * Return: 0 on success, or a negative error code
  */
@@ -27,11 +30,21 @@ int mtk_smi_larb_enable(struct udevice *dev);
  * @dev: larb device
  *
  * Drop one reference taken by mtk_smi_larb_enable(), and disable the larb
- * clocks when it was the last one.
+ * clocks, then the smi_common ones, when it was the last one.
  *
  * Return: 0 on success, -EINVAL if the larb is not enabled, or another
  * negative error code
  */
 int mtk_smi_larb_disable(struct udevice *dev);
 
+/**
+ * mtk_smi_larb_port_set_pa() - take a larb port out of the IOMMU
+ * @dev: larb device
+ * @port: M4U port index within the larb
+ *
+ * Without an IOMMU driver the DMA masters address DRAM directly, so their
+ * ports must be taken out of the translated address space.
+ */
+void mtk_smi_larb_port_set_pa(struct udevice *dev, unsigned int port);
+
 #endif /* _MTK_SMI_H */

-- 
2.55.0


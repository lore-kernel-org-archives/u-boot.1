Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D169C561E6
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 901AD60802;
	Thu,  6 Aug 2026 09:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJGlVMXY5QBP; Thu,  6 Aug 2026 09:27:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CCB0606F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008441;
	bh=4l/VmowySPL1pNENjXzm0eqg//6HxcXVZqY6xzZg0BA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uTdZtZxYDnMtYXkCA3rDWulTOGORtjFT7/VB3t/iv29BA3tXxBQpc5zvUuxKtBQWV
	 HOoGs9HYIcWtHAQdm3T1Go/w+usgTOl8EQx/GrcNmyu80rtv/Jd4MWCOFPsmSxdz5d
	 S//KyJUZ+RvtWTyssXdxSDQozZOoNhYSxiHgbKfUoyhtj+vxTsPG3MpSdU1bV2to6b
	 Jg2/Of5kx1mlf+L6pIeLuIWy075G2a9To8K0k72kkoHhb0EF2lNBdjU0VeaLBBQRHa
	 T2DPCO7VB+st4MsH6gTh5xZXq+3GmQcqt5bgaw8wvz9YocdD72kzkUky3jOKHj59o2
	 OAJOpTLnDwNyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CCB0606F1;
	Thu,  6 Aug 2026 09:27:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CEDB3F9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E74E7606E1
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYkiZ_Mg2yPm for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A5D4C605EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5D4C605EB
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5D4C605EB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:16 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47fde295992so603444f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008434; x=1786613234;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4l/VmowySPL1pNENjXzm0eqg//6HxcXVZqY6xzZg0BA=;
 b=s3hzIxAGhRHIg1cA8OeaD9WXTPkip0T34HsrMzBOw7VLQnOH0GXf5rhNUJpcmzqpne
 D8OZtt4h1Dk/6Qcu4Iz0XDumW9rvSOffIfyxEJxRbtYkAcqMD62oY6Z97FwXgolXpJ+4
 +plf6vuSCWKNOB4+HrS6ZFzX//UFut+QCeGjRxGB63tzgdE/1LXK5jbnDjywyzXrzB44
 YipaXHtCVFdyYvMPKf/zVXpCHq/MVxAPl97a7WtIcMbmPsRwd4C+79VR7DsvtYsH0gSi
 waBXjhhCOkIvFeLHjPVeTSeB6yG7VkmhcuB/Jg0PsWu8BuIeepCgik79V5A3/j3DtOz4
 jK1A==
X-Gm-Message-State: AOJu0YwGJJtidXl196DZeGO+srD7CjjW5vSM3O8vubp4N8Fs5PBBaoTg
 I7Ell8oXh4uCgppHSVV47uWozKF/ESQjrJINb2AzQDF5jXVvlB+ICt5lD6Y/vVzWOtzFAE3wFDn
 xw4hGLQo=
X-Gm-Gg: AR+sD105mnQDr4qqFiMo4sSgUNFPYCefATocbfwtoGxGTEXpzX8Um8/kEN5mufLkD1m
 f6/m9kLbHsThH96EZ8VCx9nhRYXKt6oNPorXUBVsT5magz0VxUEwTp4UaHdXOoTA+07498Ua6fZ
 t1ms1ylEQj5Vnb61J+QAxrXdBM+rzr95BPySm0etBNCZYsopmI4yKxN0QLXOP4WMGOmzkvZDvqD
 hVal7fxUFtueU39gN8sL9k/vWo5rXZ/KJwYkPo4WDAVb+x0iMiywvyRP5lQ6dMxe0+jm3O9IddU
 4UftEQEe6aPw84Lhi/yuVRdqLYzHgswmZS7idBSVay/r113/HNGE3krzF4l2VmJwEpNqJaa/hfO
 mZWgI4RDECwdv4FAMgIIDZ8Mrj25eJLyLi8lEm006YMC0AEr62VW6Bu6AIQkutxeSPkQ5I9NZqm
 ooirTBIM3wRq/xvHjLAA18uK04k4JnrMlJoaZzG7VplgitpWcozI/qh5RtqTJrTyFC6nJAVX5Ll
 ZOGupBUQ4T4fQ7IiEzmJVUYtquFzmcOCpRuU+JM558Sm/xtZ2rv/PR80nrafQSNLVHsjV8nlZyK
 K4XSa0rUhwIbzn9nE6W45mD0jKbfo8OBnJCC/83IIRI+EA==
X-Received: by 2002:a05:6000:4617:b0:47f:70f2:ccf6 with SMTP id
 ffacd0b85a97d-47ff86a9d22mr5171211f8f.6.1786008434496; 
 Thu, 06 Aug 2026 02:27:14 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 11:27:07 +0200
Subject: [PATCH 1/6] mipi_dsi: add mipi_dsi_{generic/dcs}_write_seq helper
 macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-1-6b533788d0ac@baylibre.com>
References: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
In-Reply-To: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786008434; x=1786613234;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4l/VmowySPL1pNENjXzm0eqg//6HxcXVZqY6xzZg0BA=;
 b=F5QsHByAgtbzRkonqJILFkWXj/3I46akwo9GErpRhvwaKRz8ahh1IooRVe9GwfS3Vw
 Ce9NLtRu8GPg802UQcIEvqPXFIHN/Rd33+BasTlCUTn7W4IZUAfSxFj+H5zr+nphP9U+
 cdfqtvYDYA0wt8aEE1i8hZsWEPFSurrXLwBhdzJckUC8CQZUaRqWA+MUgPLXMJyeFLks
 cc4dvh2Q4zorLM8buoGVzwun88F4WQTHX0l+FfjNTcecluMtSCe/Mvd2pU15ZhbTLPb6
 w/LjambR4+eSnQyDFORk7DAcCoBSXb910cfEcs9M1eqGTPCGvB16vVvT7o3aYJHuFCr3
 uyQw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=F5QsHByA
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

Add wrapper mipi_dsi_generic_write_seq and mipi_dsi_dcs_write_seq helper
macros around mipi_dsi_generic_write and mipi_dsi_dcs_write_buffer to
mimic macros defined in the Kernel. This helps porting drivers from the
Kernel and avoids the manual declaration of static arrays in drivers.

Some drivers (hitachi-tx10d07vm0baa.c, lg-lh400wv3-sd04.c, mot-panel.c,
renesas-r69328.c and himax-hx8394.c) already define such a macro, so
this will avoid duplication.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/mipi_dsi.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/mipi_dsi.h b/include/mipi_dsi.h
index 4ca05f71e29..fcad42d5145 100644
--- a/include/mipi_dsi.h
+++ b/include/mipi_dsi.h
@@ -267,6 +267,15 @@ int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
+
+#define mipi_dsi_generic_write_seq(dsi, cmd, seq...) do {		\
+		static const u8 b[] = { cmd, seq };			\
+		int ret;						\
+		ret = mipi_dsi_generic_write(dsi, b, ARRAY_SIZE(b));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -303,6 +312,14 @@ enum mipi_dsi_dcs_tear_mode {
 ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
 
+#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
+		static const u8 b[] = { cmd, seq };			\
+		int ret;						\
+		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device

-- 
2.54.0


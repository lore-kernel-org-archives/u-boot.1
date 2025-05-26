Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D28C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D14483754;
	Mon, 26 May 2025 12:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jiXtM6on";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA628373D; Mon, 26 May 2025 12:16:21 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA0882B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85e73562577so211690939f.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254577; x=1748859377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29xgby+oqHrUSn86GtMCmqwv0zNSCxfpL6U6hCFtXIo=;
 b=jiXtM6onxUg1YPmgvjHpzo9vzwwAhM/BrwaBxvE8ptR9kf/A+kMBVFj86tW2ZKwoEb
 sbV8q3P73pS+YZfAtKdkP28+szmOvcEbmKiMFZBmaNerty7lFKLTUqe/xwNxnaj0Dy5Z
 PQR0BZXu3Y20JBRtRR/+JthEjRj6Ls88ItQpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254577; x=1748859377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29xgby+oqHrUSn86GtMCmqwv0zNSCxfpL6U6hCFtXIo=;
 b=E7fRgKf3UZSV40mEru497ro3YpvYJvoENI3yFpxs8JXMOr2ZFtvl2Fi0J564rYgKZC
 otBJcrcQoDfxVljrXl37R3kEx8d0b6392MOQa896Zub8EfuU1m7/7HCUjyoGbHMwug+d
 hE7WjkT/6q0x+OP4Jcbpookwii5LkZcqke460tHLkE6jGNs8k0keLaLZuYkTSGiss0a2
 PLFE7bQYk/i0Ypbp+4S1Zl7vg4be5METJ14kM81ysp5Ovok5kvkBCtMpgTyCuBfGPJ8U
 5+d9HC/3j4FuA9AiiLbzNgaV1H4Di2wrOfBuau1GmN/myJo4MMCsx85VNZTf4bGk79GU
 +sSQ==
X-Gm-Message-State: AOJu0YxAGgviz+v2JIwJhE7Z6/jVOeZU/onvtkYMRcRt5m9C07DmRGTJ
 njiIuLrEI1qQWCXtYOSprSsI9MZ+Aw6SE3lBSEU9oDtCIYZwXN3hA4z2aGu9FEqvM/zM/ObusmH
 34nx++RfX
X-Gm-Gg: ASbGncv6DQE6q6TvRAHDkMf1380U+rgMhBDUkdyuMvS5e6YGxfTetUCXVPWklClfRss
 m35LJ3WffqnJJVGALwPV2G4oRjTUqcWZb0R+75y+yPIXWF7fJRyBeeXeSy6SayAaEUCp0Nk1WIr
 NnhOYdKOZ59exOxx+s0W4ofhlVhvMFwCFfMYRIKiJ9yhS+PXElRyCKk1Kd96e396ld8txGVhPBL
 qZiKtdwUpAClKsqqUmK6qES9RplAz+HEj1HDMOhOvIKRzhHW1goHemWM3TX0RQMKDgmqac4YXRd
 5N2IogVL4Ecqiqo3Zfm0RqcFBuRRK+cjMLkMze51F5LDfbl85TbZZlXvtBnK+Vi7rDGklENjko8
 NWFnipzyHBi8U
X-Google-Smtp-Source: AGHT+IFCxDz8V5O6slFMOiS719l6qv1uTGzMV0hla0NJvqpsYP0lnjKQLL39ImEZFNCKBlHytNi1jg==
X-Received: by 2002:a05:6602:3817:b0:85d:f316:fabc with SMTP id
 ca18e2360f4ac-86cbb8a2d4amr790415139f.8.1748254577652; 
 Mon, 26 May 2025 03:16:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 09/25] rockchip: Add a template for SPL
Date: Mon, 26 May 2025 04:14:55 -0600
Message-ID: <20250526101541.3254628-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

The SPL phase has a single SPL binary plus a devicetree for each board
we need to support.

The devicetree is run through fdtgrep to remove unwanted nodes and
properties and reduce its size.

While it would be nicer to just have a single FIT holding both the SPL
and U-Boot images, there may not be enough SRAM to support that. So we
end up providing this special image just for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Use FIT_ARCH instead of ARCH

Changes in v3:
- Move template to the vpl file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index dc1664d7b2d..9604972543b 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -66,4 +66,47 @@
 			};
 		};
 	};
+
+	spl_template: template-2 {
+		type = "fit";
+		description = "FIT image for U-Boot SPL";
+		#address-cells = <1>;
+		fit,fdt-list = "of-list";
+		fit,align = <512>;
+		fit,external-offset = <0>;
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+			@fdt-SEQ {
+				description = "fdt-NAME";
+				compression = "none";
+				type = "flat_dt";
+				fit,fdt-phase = "spl";
+			};
+		};
+		configurations {
+			default = "@config-DEFAULT-SEQ";
+			@config-SEQ {
+				description = "NAME.dtb";
+				fdt = "fdt-SEQ";
+				fit,firmware = "spl";
+				fit,loadables;
+				fit,compatible;
+			};
+		};
+	};
 };
-- 
2.43.0


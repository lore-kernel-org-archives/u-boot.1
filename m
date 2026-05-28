Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77780CD6E45
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08668485F;
	Thu, 28 May 2026 19:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PyraKSwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E14984862; Thu, 28 May 2026 19:11:17 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF2A846A5
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7de431da8fbso10703103a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988273; x=1780593073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29xgby+oqHrUSn86GtMCmqwv0zNSCxfpL6U6hCFtXIo=;
 b=PyraKSwlvBUYGLmDSEomHU90ywD3JoC2WzuiJgNcNBTxm+G1jgkjIb0SuxkOslV164
 LMFt6lrDD1Yn+j1hhmzjyHj4RHARHGduwktNekBEqxuXpjAvqkgN8JsHL5HKQJ4dEhOE
 tA5StSWVH5ExZuxOQIo3Grv4lxCC4W8fRAbzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988273; x=1780593073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=29xgby+oqHrUSn86GtMCmqwv0zNSCxfpL6U6hCFtXIo=;
 b=G4QBsRjU4MEI7Jhc731ESwyYUK0u5hJ6z0pI9eKO2ua1B91gaLd6TX/cWgc0DHu65p
 snwfmPfvz0a5wZOxl1SR82a5pg4CpdCI6JxNpcxIN7UB9eOf77uFeoCEdCAvlx/Hy/3Q
 uWtg/+lCiwkPNOlUHH+5hsCvWTd2fVTpZpnb2qhjk/qrqeNd5cdoTKL+86TNft+Y5O2j
 TGiYDSFdAjh/Offxcj6cP+WYg6FP00LUzHKQHc9dLXvfSpkWyFEY5IVjvpGODnMb6vik
 0iXf2f3EPgTjiP5cQeySo/LyEhmBNGBeODhQpWfSLPWcz8IDwwV5FsNMolREcqzPC1vL
 u+zQ==
X-Gm-Message-State: AOJu0YxCiL9Ra/vnjPPNEGesKPj3Gv22RjbkiE8OmBa3vsB1Cv1dreWd
 cL8doI2gd+DtywEOhQVIwpe9FyYxRCgssFLs+ruMIvjRmbbnC3MxZTaqGAoPiqecA6+1UqdoTRZ
 x4YaDlnwdOt4=
X-Gm-Gg: Acq92OHG1QgFTSZLgnNrN57/KuFjMXuV234caslDglxLv1TklBi97Ij52PAEABe1bR9
 Ww6IBtmKERLV5+jQm/Hj5DQQISVe0sBNKYTgvoM58qnAwDnTQHpKEsGXHfYIA2ihzkT8aTqWDF6
 PRglBGqfMkDQydp5vOUsVKLd78t0JUmxOiHUyHU8yObdwujD45FCDjluC9SLzGLZy2RTXPu0CCk
 WCwnVbUM1JAJ9wxgyN/qhP/6NEsLvSNVSK5492jm4TJpnq66rjnZFHoGKx9lKT8hOBkDVJscTSE
 ifrEPsZQETVFaoTVfjUJgEIgCSG+a/G85mic6XOmRCA8+87+JyFX0oLpxzvPukKG+jMA/7+4Xrj
 s5biHXw14m6YJR9kO55o+0AFD+337n+EqB3aQ05TD29ufjfhaoq9SCOe88uBIeHyyuBer4tMgkT
 xcWS3WhGy7QwEhWmg9gto+oBDnECd2
X-Received: by 2002:a05:6830:2b09:b0:7d7:f5d4:ef5b with SMTP id
 46e09a7af769-7e5fed0d1admr18927680a34.7.1779988273476; 
 Thu, 28 May 2026 10:11:13 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 09/22] rockchip: Add a template for SPL
Date: Thu, 28 May 2026 11:10:16 -0600
Message-ID: <20260528171043.910264-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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


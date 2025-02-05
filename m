Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63321C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE19880934;
	Wed,  5 Feb 2025 02:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S71GnfUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE55807C0; Wed,  5 Feb 2025 02:57:27 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E308070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5fa9778fa2cso3025579eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720637; x=1739325437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJtwLbapHsvCsFbJNVICQFzs4Rj4TrFw2W/PAD2I4v0=;
 b=S71GnfUdREtlBdjz+J2fUPLcIWlaCiax4lKlqzPNlLtCXa3jpfvnnIM5+bCnrYbFEG
 gf1H/2lwfdK8RLoJpCS3RU72moUKgLB3ka4MPZVnUPMRABfOJJ4D8XO7oB/bar7SBNcc
 1M6xt/B5s9u/6q67gggX3SNfxxKXpoBfTqyCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720637; x=1739325437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJtwLbapHsvCsFbJNVICQFzs4Rj4TrFw2W/PAD2I4v0=;
 b=h8G2OnT9PKQChXIdd9Jq9qJxF5o19OyUp6KMSEgMz7GIlQ8BeaGEAlypvthIGKhD36
 07qPy+qgsA2ITgyGM8dcgKCd5DdfsRrJJsI28g268INq4YJ/j0tLLDUXuWp8Rp4i+kjP
 EE4+bpFIL1/0ZoXuT/9WVCWYH5xnrH8UTRGs2H/MNcvq7jvzWWMSGv1w3TGc+H4ysZdQ
 dgeDxinY46SULFr45R3hIcmAFUqjbBlF0Zwt1ojyGONZLg/mVgf4+Y4mZDwQVYeSepea
 2Ua65yLmV7fb1H+Fy4bx04cQpFOiJzQoSHDz6cTWXjbOKSusTYfjqjOI0M3SM1ND+85p
 en7A==
X-Gm-Message-State: AOJu0YwqB7J/OQfDsrsY2ZigE7J/mvStwexClZH/I6lfh0Pt8qiJyNx5
 wAFCLSGMTZea2gftfq4EFeHXU4DjUdBbf0kLrzVFFZU+Mxddr1HtS+Qi773gFpMj757cC7PNZrw
 =
X-Gm-Gg: ASbGncsPE9F7mDbBkaPaufa097wOHkZ+89GfnbqKW3/7gR4ghjQ2pCRlUzDpFYBqLUf
 2FE4HEi7rBTWw6Up3saHg4GaX8mBUjjoarmSRVKyw4qaBVnBr5Vfkk03n/Zsmg3jgoSKGq8Ai0O
 cMLTeE4j3Zb1wvA4/4+a6NjQ2xa/VVO01B1WnZqYJ+Ql7EC/hT9dTSloQkTtUflNs/sR2vWMKHy
 CavSbTuddRTlBZYgYu3LZtquFrg1/gI/nB4xIcJbcI8PLBXOAbxVHr9wI3swxGmio+saGK/cUmx
 +rtUcdegC7V3H3Y+2OKr+VpbQ9gjb49LMJa+YavjdgB59/SF+yNe
X-Google-Smtp-Source: AGHT+IGQAEIBqv6evwCGOmZHy7f2v6mbCaq7ICqc0TG7vMUZJfdUYTeLQb4yVWIweUBM/Q1Gkv1lSg==
X-Received: by 2002:a05:6820:2787:b0:5fa:6805:645b with SMTP id
 006d021491bc7-5fc479cbc96mr845753eaf.6.1738720637637; 
 Tue, 04 Feb 2025 17:57:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 17/29] rockchip: Add a template for SPL
Date: Tue,  4 Feb 2025 18:55:07 -0700
Message-ID: <20250205015606.2686149-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

 arch/arm/dts/rockchip-u-boot.dtsi | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 6871260574d..c87d17db00e 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -204,6 +204,49 @@
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
+				arch = ARCH;
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
 #endif /* HAS_FIT */
 
 	simple-bin {
-- 
2.43.0


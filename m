Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82277C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F7B8091B;
	Wed,  5 Feb 2025 02:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hojX0ZIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43B1807E0; Wed,  5 Feb 2025 02:57:34 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C695807A7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5fc0c06e1deso3062875eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720644; x=1739325444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1OUQSDp6UHYPK+qJWEegoxCnj2XkIK22eE6uJrHUmc=;
 b=hojX0ZILgGgGIDhfIbfujN1RPjx15c+LbtiEuAiEoh9qu7LAhyJD3Gig66lGyKZx7o
 ijlNi++2Nio+/1HA3E/SuXzBqCmAo3JA/1OgZ2XAa6Koa6uOTH4ucywn2LjacaHSRtnu
 yeWb5pDZkKAc1YuvnjHkPdozlf+omodZPXL4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720644; x=1739325444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1OUQSDp6UHYPK+qJWEegoxCnj2XkIK22eE6uJrHUmc=;
 b=oLvz2tv8il/ymfJ/Ai/ZYB+fRYYg5droLaJNJCck1YI8Ba36N1fucSQsH25wgc2NHy
 eU1Ccn6pq4lBKjr83BFdmane3NWvQyiFAs+97m83TlH1xD3V4+zbMF2zP7VE7jlvP6so
 oTz1frhCnHIfNffTTXdgFcMMi8jq5Asygt/feSNisNtMyqWEz07gK4LS0o5/wFYQnP+0
 1gVWBMUE2R6T7sbeABTC4FVuvx19Nhm+ubr//Rh2gf8KKhVrqJH8T8UVqfd8QmWtrQWo
 Gcjt+cYKsIb4aajy6eRTNdA1+p/Huzq4Dq4QKqk8Gex6TwglZGorB0SAqkEcx3scS7Lt
 nojQ==
X-Gm-Message-State: AOJu0YwOUBEjdxXvQiGa0x9OfSRg+l/Z7VzpZKCNimnuN4sfDMgQiS0L
 1gn2p57DmsPeENOaV/8lYRIKJWzl78SSkm2aIPDPPb3fMRNfj4BlraxT56LnvHf3RPC6bn4+j4M
 =
X-Gm-Gg: ASbGncs7QaUfUpNGjFasWMCjeNJMuILDOC/PmgGfLgyfwmixhXFwk5HcinE+jtTigz5
 mw8GFXlG+pYfyZivkXKuaqV0oxa+BkTviH2AZVZKrDm7LldYtzHhyYWk+KSoN4DPZwGFG/qRUnv
 UCSy67cBJL+ELfnee1+Eehtwpj7U0q9pUXzum+1r1RTzJEP8VNfqTKx9mOiVxwn8N0UO0lIk4ER
 IInoklSCU1ooWsfr/Es1U8qLbySvEMewDPQ2ITwnpy+AXoWg2FvWrpVrC6EF+xSczvQOv+M+jPb
 OHRwll4e4KjmWfW0jfzo5COZHAUmweZYTj3+Vktcg2gtgM+KLjGS
X-Google-Smtp-Source: AGHT+IHo4kU1IDgil7B1zOA3VxwFg0yI4cQA0Nl89DJh8afFUNFM7jcdWf6j8Vnn9LxutROZgXqitA==
X-Received: by 2002:a05:6820:1896:b0:5fa:643a:f60d with SMTP id
 006d021491bc7-5fc478f37edmr854424eaf.2.1738720644301; 
 Tue, 04 Feb 2025 17:57:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 19/29] rockchip: Add TPL alternatives
Date: Tue,  4 Feb 2025 18:55:09 -0700
Message-ID: <20250205015606.2686149-20-sjg@chromium.org>
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

The TPL image must be built for each board we need to support. It is the
only part of the image which is board-specific.

This helps to save space and reduce the size of TPL, so that it can fit
within the internal 192K IRAM.

As with other phases, the TPL devicetree is run through fdtgrep to
remove unwanted nodes and properties and reduce its size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 42 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 0611533a310..f6348c532a4 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -254,23 +254,23 @@
 		pad-byte = <0xff>;
 		skip-at-start = <0x8000>;
 
-		mkimage {
-			filename = "idbloader.img";
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
-			multiple-data-files;
+#ifdef CONFIG_VPL
+		alternates-fdt {
+			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
+			filename-pattern = "alt-NAME.bin";
+			fdt-phase = "tpl";
 
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
+			mkimage {
+				filename = "idbloader.img";
+				args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+				multiple-data-files;
+
+				u-boot-tpl {
+					symbols-base = <0>;
+				};
 			};
 		};
 
-#ifdef CONFIG_VPL
 		vpl {
 			type = "fit";
 			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
@@ -361,6 +361,22 @@
 # endif /* VBE method */
 #else /* !VPL */
 
+		mkimage {
+			filename = "idbloader.img";
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			multiple-data-files;
+
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+			rockchip-tpl {
+			};
+#elif defined(CONFIG_TPL)
+			u-boot-tpl {
+			};
+#endif
+			u-boot-spl {
+			};
+		};
+
 #ifdef HAS_FIT
 		fit {
 			offset = <CONFIG_SPL_PAD_TO>;
-- 
2.43.0


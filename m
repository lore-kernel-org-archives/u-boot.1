Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0E0C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BD780834;
	Sun,  9 Feb 2025 22:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ps3BP4QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3062380834; Sun,  9 Feb 2025 22:16:09 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9D080EAF
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso39535345ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135765; x=1739740565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhqYdvAaXnzTfAw4S2aiPh5alTCFQ+7VR5CNNiaUbhs=;
 b=Ps3BP4QFIdCEtS54xPUERhMKmeRC1braxnOAexaYkuySiyxfJjOcPfPVm/XH04A6/m
 +0sFDj852ifoIy2HaGshDldrS97C7ZM1+jKFwgH9wYdBF+dh2p7ug7XS/GwlryI06NqB
 xcEWs8OdRUmDVxByU9Ct5gE61dLpwyXhU0/zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135765; x=1739740565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhqYdvAaXnzTfAw4S2aiPh5alTCFQ+7VR5CNNiaUbhs=;
 b=KCenKhgzy/VP2hxkVHSzeMnUmkk7D3/DgmaKsZ8UEz2Ae2nxqA92vpYUuPcDgT9cIh
 +SOk/R5Da2FJBsLMkDZVLHaPwm8uiTGe3RFjawI++RUlBe/zLHBGVfrRquqGKttLbhyl
 0o0Ts7AZ6yWknBYKKpYXs3T7PjMTgHGQhNOzC+8VTkm7G4ykdLFPK/gU1lIwGZFVHATN
 beIz/Z70CpXnwub/BtN3TdBHD4t/KKt02ab9Qs3Ap4IJl3HgU+5MxQC9QBLEExbCcqhF
 mzTSZNwBqPqP7uExO2m9AblMe5aKf5XesCuPRP9Hddz+3ljH7LksvdWCM0Uq5IjiH628
 EuAw==
X-Gm-Message-State: AOJu0YxskRfhWGZP4C7rsKq1j4KuBBrWgSekpNNTRuiS5SYIF1ZOgNT0
 Pj2pRJb0YKvAczIzyn18EQHUnBOmWunPranal0VEcmQZNHRLSqzk39FtJoMGZu/zrHp7QzA671M
 =
X-Gm-Gg: ASbGncuK8HRkt6o30MC4k1wnp2IEPREoi1fSU/WmKRx56leNm3GnYp+9RuuGKNd1ZvK
 daQkKNxaoEsV5yz18VZgd+FHKb+G7UMnL+r1uBPUfnvWhRpOfp1zyBxBkfSAj9Xeygzd/32mMxt
 Q862bNNkbk+mh4vLhwJ+5TmIRHBXjCEopwhuYWYO0/cX/J1vLR5MbmVAXo2eXos+xVVu16sClYC
 m378p5NRV066I5ay4xhn1Retk2QOPiWp9sZSDJIwlpZjRutAaU4NbR+o8Y4CO9aD9slB3hpgsoU
 gjH91q93oz8PoeYeRHEtBslhKggiUIWS/lGCMJHmfETi04XQ4Z1w
X-Google-Smtp-Source: AGHT+IEJZoTmY2sg7avwwTGBdHBZ2A4ZhNFRY2aOHhXSps88ezxN2yYWKr8FNrbDtodJgtybLNMHBQ==
X-Received: by 2002:a05:6e02:378f:b0:3cf:c8bf:3b8a with SMTP id
 e9e14a558f8ab-3d13dea9ed2mr94520665ab.7.1739135764745; 
 Sun, 09 Feb 2025 13:16:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 17/35] rockchip: Add SPL into the main FIT
Date: Sun,  9 Feb 2025 14:14:38 -0700
Message-ID: <20250209211502.2299245-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

VBE may want to load the SPL image from the same FIT as contains U-Boot,
if there is enough memory, so add it.

Changes in v2:
- Move VPL things into a separate file

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 26b77e67c80..325c15f9fef 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -29,3 +29,32 @@
 		};
 	};
 };
+
+&binman {
+	template-1 {
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				phase = "spl";
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+		};
+		configurations {
+			@config-SEQ {
+				fit,firmware = "atf-1", "u-boot", "spl";
+			};
+		};
+	};
+};
-- 
2.43.0


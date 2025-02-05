Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3963BC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1ED2805D7;
	Wed,  5 Feb 2025 02:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+r9Mxnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4E3807B9; Wed,  5 Feb 2025 02:56:44 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F821807E0
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f2e31139d9so2927972eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720600; x=1739325400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdwwBlcxfPaV/d3/33TkAKk10TnHAeiMJTW8FdrFj3o=;
 b=P+r9Mxnbw1Od6Bm0ZZYYt/TWALZrflHeOm2G/a9akIYd2j7uSCETGD+qdMvGzt8Tby
 34RNMfJymLw18sk7mUpl6QcM5Vyxne1qDZgV0Ke9meQukvVlpbF/66ykRN4ox+N232l+
 7rQiA62VByajCdVs6nCsv5cQ8PCPD+d1+5UAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720600; x=1739325400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdwwBlcxfPaV/d3/33TkAKk10TnHAeiMJTW8FdrFj3o=;
 b=BVRf5YEht0dT5b344gSNPJBZ66fmJx+men93T3UvrOTJ9Yl1aXoQ21U1IG2TUUPDFl
 OwcbCDIGrjWRHbpFMMvoytuii9woZPibsG6uJtETszMQQiPOE52cNgIKI1TZuHjgCgft
 nXXIwEtEpSximgNkWrDoRSgx3N6jt8JFvARIhyGkvcGV6Cl8wQgMbKIMwZkYR3qdN5ne
 3EAOuwiWzAfbQQVC3VHwvfVNEoH+rgSfxvlnH0zvZM1MIvqmFLVPQLtSocST3GKXUJ5A
 cbw2SLa5urrNnq+JfBxLPgCMuItWRTK1pGNPRpcqpOnJWYklyybgUxoti7tfzKwWdyKr
 /LKQ==
X-Gm-Message-State: AOJu0YzN9s9J4AGj2KbpTufrwM0aAyWnuZKOya+p/0Hhrq+3Jcre456Q
 IsINC3nsC9535OU+m8FjPsl4FUv9oO9gBKD1jbdOD5aV5MnWk2RILqrYDX9X2Kg1HfM88DLjUho
 =
X-Gm-Gg: ASbGncv1vJKiuARd0tc6BM1EFxYteOtxSQWovNjvAfbVcqONdKfaCln1ZAXimfPvt2b
 0bLX0j+cnIEFLppEzIaPbmmZEOeVnSPmRK4og5Y2sdD8BQl8tZcmYhYQNa73vyziNKQzVrq3vA6
 f/CPedkEhvNjwfQyDVhOyyaWptjHnQYKd4ZxT2OLAJt3tb+Y9kZ6iAebnfywtehKCRTUq5JlnGb
 UWpVQP+yz+YeLHbwkqHfnlzNVLbwJzSoItHJAZkHZXnc0VmC9L42xuIVMhEGFeBpsvGr4tW7b52
 YD0ApjJXl/OLMjPkipbHCuZIrDvJk3+qBPsErZmcovZk7CLUnKaZ
X-Google-Smtp-Source: AGHT+IGoHIF9xXD1Uj3DaDAU9hgfFsN1f24Z8deYcPqMCNaVwrDny9OMQNCGwNFywrOhLWxeYJ1hdw==
X-Received: by 2002:a05:6820:2208:b0:5fa:9407:a416 with SMTP id
 006d021491bc7-5fc4799f449mr776961eaf.4.1738720599989; 
 Tue, 04 Feb 2025 17:56:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 07/29] rockchip: Add an fdtmap
Date: Tue,  4 Feb 2025 18:54:57 -0700
Message-ID: <20250205015606.2686149-8-sjg@chromium.org>
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

Add an fdtmap so it is possible to look at the image with 'binman ls'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8d6b2184f43..da0ac078cb6 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -170,6 +170,8 @@
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
 #endif
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -203,6 +205,8 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A15C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB2B440340;
	Wed,  5 Aug 2026 19:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsMPNVhXBARv; Wed,  5 Aug 2026 19:51:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF77040411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785959483;
	bh=XSDQZ6ZMdEuikDNh99ivaJ+rUHGrOctSXGP+49bddug=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DhUgmmQjFSLQ+dDGFzo+L3RBxIhekrIDUbto1wEWRCLXKqXyFxzXjog3k3UNdBkEg
	 MZnQ3invLBy3zGWOtCMh4PNx0NjTEKHQ3AtXEyRt0xFA1MgU5dQg1APFwStMv0QqeM
	 I/XqYKif1ngpF/NFNLCwdJwzILYpy8SqiqcVBbS0pBCUluIVPfWS01n8b51Uh6woSF
	 T8evC15QLPJr4p5/Fq9vSxUc8pYEr82bgpvUjz8yzMEHov9X+VUvzsGGThPT35z+gk
	 zXmwfBs7tT37Dfgf+4rXH9KWLvBpTT4QeIQ0vrO7ioA9PxRQp37C57Pv9aqpJnTTKE
	 qR1JeBtPulncw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF77040411;
	Wed,  5 Aug 2026 19:51:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E947D2A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF1E380CDA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHzEPUtNi5-b for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:51:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B572780CB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B572780CB9
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B572780CB9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:51:20 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so995352a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 12:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785959479; x=1786564279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSDQZ6ZMdEuikDNh99ivaJ+rUHGrOctSXGP+49bddug=;
 b=GOHefwIMkwGGk5iBGHDLPzGzK5w4K4a2GfbDyORTvWy57j55xJW+NuFjLAD0l4Yvrw
 7Qu3zXsDUbHk3kFq5/fAzhv5anMY2LiD0LcslArKSPU5C7N/ePCgWUaMt/YMvJ10PUxt
 JF7ExhwF/ohgeQ9+pCWChMU+Jrq0NbqHyrLsW7AIJRJteK7ziIVHHpXrFvQVdT41Iuir
 RnoyuBmMe4KSjKEPw7InnGWIRgOuEuycaWXr5O2q4l9PFVQ8TaOQchHeDojp1vFV8/gd
 stdEFtiWZHgEApsjlM5KBYG/3Eslw5yGVrsiA9hTnDA6/b3BsVa3AUImJ2OBltZuG0X4
 o9xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL+4d3FxmMhkxjta6TTCrlzI3sThHxo7G1X23JFr3Me5lcofkMiJZUXD3pkG1OQoQEQ8nF4UM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyaEqvyZrBm3RsrA8ZfjHRRJ5BWT3SnUxaP/6Tf4NiXp0A6sOsS
 aX4S5bJK6m71j9sMews/OV6DcfvwUIvFMg7M/ZFGswJSL7sHDrfPpauELPhbYtNlmHDP/z5Op74
 NYwLukno=
X-Gm-Gg: AR+sD10thVpVglo7xUHF42RGKoW3qBT0RylE8sIAI1jCwlCHiUkDbeMBOwOhmPYdAqG
 uH27HtokCAzrgPLGv+uHlmtm5x2048EW+uX75ofT7LrbyjelFCNczZAAos6IINbvTth0F16Tu14
 A/9KD90LGlZjmLy6Uqhf4Bc7vBnqO3mjTN0v3PnmFiYkNT9WqRdoj9zaYzpnoUIxmVTRzMVP5Sv
 LZajB7I22kGKIhEMbotyeeD3Jayud6LuGaznsQGBVpbt2u6Gm1BOarBB+griQCHFeqXSQ5ZOVzH
 GbSlutmgpHIAtaqZgIz+VmxYzwUCtBHj+ZX85dxp8axCtepRBGi+YahaTk7XxZgvI8Vq9wkZyGy
 kTkt0AgwkREWTBcoL124eqI6+NMDJLB9R48+Z40ILyOPnyxYPDOZlqx3TBEZKqaZv+a4eQTbABC
 hLFkfNq30NUczCGo5pUMREVH5pdNhkZ0OQPqfGMjL2GEZJq5HPnAyNNCTKWOJlXFfcFBpyMrdBZ
 Q==
X-Received: by 2002:a05:6820:987:b0:6ac:b5ae:65cb with SMTP id
 006d021491bc7-6ae96d0b098mr4667741eaf.14.1785959479487; 
 Wed, 05 Aug 2026 12:51:19 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599e5b525dsm3332468fac.10.2026.08.05.12.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:51:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-main-2026-08-05 into main
Date: Wed,  5 Aug 2026 14:50:45 -0500
Message-ID: <20260805195116.2512286-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785959479; x=1786564279;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XSDQZ6ZMdEuikDNh99ivaJ+rUHGrOctSXGP+49bddug=;
 b=TExQZi8ZyEFmbAS7mvmn1078htXVigffjxCI56CP/tVslWGzzRiEIhvQyk6/aIohV2
 y+H3b3R7SsAbfqtWSZ/uQHxMMEbXhNa4osoVZ8iS1Irv6Z3iXV0SjIm9+1l4O/+VuvZ8
 C88O5YW3XIpPYlth5uB/wfgjNccl3FaB033nRVHZtFjHufVmKkf5Jn+lg/UzX6rC5SNy
 RgUuAmql72jibgqCqp/zwVCeUZ5cJ1P8sPgdMW/6IczcyIttFOlKsGb7qBhTPj6UQCku
 D/TjP4kOeQ67TywIR94x2DFxrMLbzcBxObAI24UXPYa6wO8fIYyOVTNZF/V6FEpkWVAM
 p62A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TExQZi8Z
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

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-08-05

for you to fetch changes up to 164113e995822052aaac44b34b238f595596c264:

  clk: mediatek: mt8188: fix top0 gate polarity (2026-08-05 14:46:59 -0500)

----------------------------------------------------------------
* Clock fix for MT8188 (Genio 700/520)
* SPL support preparatory patch for MT8188.
* Compile error fix for when enabling LWIP network stack on some MediaTek targets.

----------------------------------------------------------------
Carlo Caione (1):
      arm: mediatek: use phase-aware PSCI reset on MT8188

David Lechner (1):
      cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME

Julien Stephan (1):
      clk: mediatek: mt8188: fix top0 gate polarity

 arch/arm/mach-mediatek/mt8188/init.c | 2 +-
 cmd/ufetch.c                         | 4 ++++
 drivers/clk/mediatek/clk-mt8188.c    | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

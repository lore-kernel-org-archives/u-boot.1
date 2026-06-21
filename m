Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC5BCD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 15:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DB3849AC;
	Sun, 21 Jun 2026 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kB70pC2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DCF84844; Sun, 21 Jun 2026 16:39:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2D083FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 16:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B86A3F282
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782052791;
 bh=wV/RIxCdT0KwhLETM2EPYQAdo2k45BP9knJVn3iYk3E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kB70pC2h2DKSGjmTpBS50ee6SELvie4MIaDyyGtje21ABetwKWRJXv4/ScrFAiCLe
 hdWhntj+tjaCBPXGeRCnNPlC7qirDlQiEjtBU8XEWmUy6B7RcoKBX5M0TY8T18P6A8
 psUJW7g6v0Dq+pKDG3TxtxmnBQCvKQaOYVjPEFtP067pvRp+TDrO0sed6gKmj3oE5s
 qavR0E1x38StLb2W4hYJ98aGswM3srMLMhEKfCM/m9WBEtD+anIjI1wRZVQBSKetIL
 6q1qEhSSXJEu/t3SXXvL8nuopRK+Nkk4chfZzIskruYaN5Cd+XwlUmZSWTSDyrbY6W
 jUqcDjsJfEJJgWji2S+TgmEGQpsuKJLaVwGqGVHEpr1fSAnLFJfFzutKODtpor7KZ8
 TMDzcqBDoG5MzMx6il+QBwv/8z/+GZE3SXrFtfR8FMa3I+7auxQ+MYpJM9GTeQWKKt
 Bt7xYDr7w+P06cbnfGRhvoOpbn8pmSJDosRHGlLQ3ID8nRsE8hZbenjHw14X8smktj
 GTK8oTcFWisjaWLAOb2bh0cOehYsyopNYvWZvkQID7GWnm+wBQY0fZadyJjKyBOEsa
 HFsHNpFLGaKW48BWCExiOlzmqxRSeFreZLY4VmxyxkupzzmysoaIkLh5Roq+t/Kwu6
 Jg0s5mDO42GPlBLLVkwMmx30=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d98b76d12so2417703a91.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782052790; x=1782657590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wV/RIxCdT0KwhLETM2EPYQAdo2k45BP9knJVn3iYk3E=;
 b=XvQMqCZWX0XBp3Qg6xdxmOJb8IQJWhZ970qD+2HIBjjB76CCoqctsCyPRcu/ufsxRr
 ykJaTjNG0h11FQRuxgPuXvpwF2z0fqyiemGxtIW6l2x7Of7h3he+ljzGSiPwSPBZi0m6
 i2IgKAvRFq9BLEcntwR30qLXOyQ0v5bzP0UVjtgK3oz6/Cb2eKxHx649AWZNbIfXauJJ
 xDuze5cNc0v9gHrl7PSbEobXKB8pGM/2oB5KYkULZTuDvzlickbyoO8IsZGrNLftevhL
 pkTylmsdOe317whvJ7T02rWbuT+sujP58PM3byKzKcKrvl8snmLIY6rWHA4usvuN++CL
 gt0g==
X-Gm-Message-State: AOJu0Yy+QQTdUDczoC+o9cNbwEW3C2kd89BPnDzD7MywbVXgfMD2Z2rC
 e49H3kE1MgsHQjIPNd5mD/IMrXFFL/mLlOXpptiiG21/QshNNzgJgJ4BQ5SxT6ECebaSP9Mxw/5
 2k2rFSHNdOywQMegIFSD0OO31aSZPeu14SangwQAht52vRjAH7ff7cqFiwnk5nqgV2P3E3PrMKn
 xWyhNTng==
X-Gm-Gg: AfdE7cl5bOFaYdkGxfRheQkYItY8yoaRzMTs84ZR9mSYox8YjvBJOHzW2tb0tVgcclP
 0078a9aEi++lFfXd9mHqZqa78jJLc4wyVzvcIO27k2EvOnfsbibeNc+aAYvet3QzF/MnuOqvTl0
 F31relGBdlGaV9s5I2QbmHqfsYnG24hGzb+1zDW9e0NBOxpZrVp0AW2vnDLEEEuhv37XeFucZs6
 ziZOQu6aq2WCnDfbwLXoCcS2nZXSEIzc55XmcO7s8Fr96G94GhL3IHYzQZZYeEsecNb4hitrd03
 AbY0gh02lNHj6AP5uRpK3VJPW+fouBblRMNJHbJjB+C6lihEkUSBJKYxV/hVcpAm/EifO4ItQoB
 pdlJZ2VO0XhQVlse74b84v2dosrZjPT5EXzkSy45L17nGYSuftfyE7Uj/wFIepA==
X-Received: by 2002:a17:90b:35c4:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-37d1e8d2625mr11819797a91.19.1782052789636; 
 Sun, 21 Jun 2026 07:39:49 -0700 (PDT)
X-Received: by 2002:a17:90b:35c4:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-37d1e8d2625mr11819784a91.19.1782052789312; 
 Sun, 21 Jun 2026 07:39:49 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc31728edsm4485367a12.11.2026.06.21.07.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 07:39:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v1 1/2] sandbox: vbe: size firmware1 area to fit the binman
 fw-update section
Date: Sun, 21 Jun 2026 14:39:33 +0000
Message-ID: <20260621143938.2863-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621143938.2863-1-aristo.chen@canonical.com>
References: <20260621143938.2863-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 21 Jun 2026 17:24:44 +0200
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

The firmware1 node in test.dts declares area-size = 0xe00000 (14 MiB)
but the binman fw-update section in sandbox_vpl.dtsi is 0x2000000
(32 MiB) and the FIT inside it carries ~16 MiB of external data
(spl + u-boot subimages). The FIT therefore extends past the
declared firmware area, contradicting the documented contract of
vbe_read_fit() that the FIT must fit within @area_size.

The mismatch was tolerated because no caller actually bounded the
external-data load against area_size. Bring the devicetree in line
with the binman section size so the FIT extent stays within the
trusted firmware area, in preparation for vbe_read_fit() enforcing
that bound.

state-offset and version-offset are left as-is; they were already
inside the FIT data region and are not exercised by test_vbe_vpl.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/sandbox/dts/test.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..37a36705b36 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -176,7 +176,7 @@
 			storage = "mmc3";
 			skip-offset = <0x800000>;
 			area-start = <0>;
-			area-size = <0xe00000>;
+			area-size = <0x2000000>;
 			state-offset = <0xdffc00>;
 			state-size = <0x40>;
 			version-offset = <0xdffe00>;
-- 
2.43.0


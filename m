Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F131CD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 235B9848DF;
	Tue,  9 Jun 2026 18:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="8LliXdEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19FC84942; Tue,  9 Jun 2026 18:52:45 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA88E846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso67050765e9.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781023963; x=1781628763; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mNswqHa1p9DQnP3U6te/m2X95mvm5hsRcaDLjHqSfo4=;
 b=8LliXdEke3bZRkI+WS4VWjIE4xtGQR5TUYgmpY6w2nFmJ6j289dPtOgzUJcThO3aRF
 7Ho8h3k9SCGn6Ij+/8HgONT90LI+mUwiScLTJGMoLSuC2dJcsz64LkZz8NMUxn1HOI5r
 guB9vgNY0WJXANmXQRz6+2CMaaNCzhweByuwu1LH+4fxyqHoevOMAcQcTkqNxsnwOqU+
 Sdolz3PbvM582pGdZAouAuyPqEseEZkQTGK/+hfM+BI+Wfs/ELi8ig5GWjWaLg7dXOWC
 BnaG6+FtJV3ZxOLRUxX2CEcaZ5Hr6HBqGLzZXm85n9FNeUzhc7L4wqFSkjqIU39lDLGT
 sdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781023963; x=1781628763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mNswqHa1p9DQnP3U6te/m2X95mvm5hsRcaDLjHqSfo4=;
 b=hni4ti+Yqlcr0S+BaKaNAElyM4f6hrDdMp/5y1/mg2hPbBlCc1ziT4ryLSC77+Qlei
 FPWE44CfYGppHNPs3suW9NLG17LPNtJ36IbqS+OWmeKsa9KQlCLLX6/lpVeA5r1IDreq
 NVqVvvMGyyrTSY/ek9vxdN8+O7A2fdjpNtKjKP4zMrjHZxywtkhEXFE5KM3pbRlC8fFD
 sJ9DrwEni2KUhxCjSikdpH+F+736DtSacqFS9ujecttjjmUNLN3Sgo/9VkrK71QlqSZD
 spuCQRx6v/2gGeWyyCSk6WnJ584tj9Munxw/oNFt0CNyICkC9fPSKrG/XEZTzxSSDIMq
 zs2Q==
X-Gm-Message-State: AOJu0Yw9c9gOM8iesH+MeyVSj+mCuua0UYnUw39UhxeQFlGviXXuWL9E
 TMHOAojURSZg6xje55lDGYoqcE7x34Qp+UbCrTadN3W7iiBy/p7wZzYnb/MGlbp/6PA=
X-Gm-Gg: Acq92OFHuOIR+mTRb14gbBF7NmA2xHp21vhoNVWCnBV6ohkQ5wEPqGsxJPHOJeZGyVW
 ngoyoatRjaUFqbtYw8m+8rzfp5OTTjCTbjVuLPLhX+XzxsZFP4s0sV+PoXMaNB6ESBF6CDFubYo
 ZOx2A2uG9itkSbNlkpoYNl/Rp2QQAlfbZdFoSLkYgoT7c7z1EYWRixfu6RaKjf80rW8LzuydMPb
 q8QDvmPoY3wEmLcANyWHPD6KpF/3k/j7iLSsuAGOvFBohpSlznaNcKPWgdTxh+zBFVMTYZMgnCk
 KDWqlkw25bJ1tELx/lbtygWbQQ6UoKhUag2aFpyXnuzlA0tb2Yr/U3TVdWJLs/p1vTBTuJzsbG/
 Xi0voIxvSvx7sLa6gHJ1F65dI61jtY5wejhBve8CISKyoj8+weABxbo9LGkI2RqsFN3OkI8GwTa
 +B5mcJkO0g+Gbch7k2Iy0/GEgMnx9I2QGg4yRsK3eH6VcrejwM45g=
X-Received: by 2002:a05:600c:a086:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-490c259f616mr350740095e9.10.1781023963189; 
 Tue, 09 Jun 2026 09:52:43 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b06sm450121115e9.3.2026.06.09.09.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 09:52:42 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 09 Jun 2026 20:52:26 +0400
Subject: [PATCH 3/4] rockchip: spl: default to Falcon mode boot in SPL if
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-atf-falcon-v1-3-2b20c5e83615@flipper.net>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
In-Reply-To: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=alchark@flipper.net;
 h=from:subject:message-id; bh=8YLYUMRSCBSbu9D/7YXdCA5wkl3EZvllB2AkBzhFfnw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRpuJz5b2/KWeO8+2biC50QednDyaqZrMxB4Xr6Cvnfv
 ArTnAQ6JrIwiHExWIopssz9tsR2qhHfrF0eHl9h5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmGolH4b/NW/ndB8Vfnzfwldi8fpPapX+34MVc1/f+yoiY75gVVeIPMP/yAvSS3b
 Nl5f/NdP7kGrkidklKh+7ZxzbdXwD11I/1cA2FgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Common code calls into a platform specific function to determine whether
to attempt OS boot in Falcon mode.

There is currently no platform logic to drive that decision on Rockchip,
so attempt Falcon mode boot whenever it is enabled in the configuration.

This can be overridden by board code if needed with appropriate logic, such
as checking for a button state to skip Falcon mode boot when pressed.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/spl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079a..604199f72a0c 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -153,6 +153,18 @@ void spl_board_prepare_for_boot(void)
 	cleanup_before_linux();
 }
 
+#if CONFIG_IS_ENABLED(OS_BOOT)
+/*
+ * For Rockchip Falcon mode (direct Linux boot via ATF from SPL), always
+ * request OS boot.  Boards that need conditional U-Boot fallback can
+ * override this function.
+ */
+__weak int spl_start_uboot(void)
+{
+	return 0;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(RAM_DEVICE) && IS_ENABLED(CONFIG_SPL_LOAD_FIT)
 binman_sym_declare_optional(ulong, payload, image_pos);
 binman_sym_declare_optional(ulong, payload, size);

-- 
2.53.0


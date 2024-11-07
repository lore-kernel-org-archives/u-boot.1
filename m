Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFF3D5D688
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E996189083;
	Thu,  7 Nov 2024 22:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dUrQ7SzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E868878A; Thu,  7 Nov 2024 22:32:09 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C7888E00
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a6adaee7acso5280665ab.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015125; x=1731619925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbfatyAXrs4s7Gt3G9iTgDgJAawmN4+jl1dticW00ZA=;
 b=dUrQ7SzRLw//c8m16D0nR2xaZoLqzhj/zujp/oq1WZrida6cQttMGvxgkNG8zpYv65
 AqO2dbOxifROuKf/PNdqawC1Nom825pl9Q6XNa6EGOLSFOqB8qDi7dsef6FaeK0mQn9e
 Ur3uhZ2ofUAIiMBkMra8enAEKNwYM+32UAtu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015125; x=1731619925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbfatyAXrs4s7Gt3G9iTgDgJAawmN4+jl1dticW00ZA=;
 b=caEdg9MCptbwpoWd9qzPg7f0rV2TK1VI0tmICPQYW6yF+CoOtXpBDK1SmYN7yuIome
 OvHL8aLKH2a/bqeR2gy+AmC3TyBUI7b4p/izfEK/r5qV4xwLFuHxreKj4u6TKMyhPoi/
 V8OYAiwtpyEENXs7DCmskmV0JzEHLkWhvF54Z/U5GJO/LNQdRkvUyaEIeyGX0cJAHXMY
 yO/MEZuMgLP6QTXc6QHfhIq/ltfNN6AMPLkQE93Nh+X4E/dR/zybtcIx0+kseoEy+MUv
 u7oXP+Lvy7TUw9f/HWN60KaB4FRLZLHaYecPrivovq71jxN6l6DfgpwDMd6U5gNDKlUN
 bndg==
X-Gm-Message-State: AOJu0YxeOV1npR+Jr9rV9N0wPuomkIxkuo+1JTthsbZldToGJMRqUpKp
 gv4xjcDCeaqw+kOqMlnK8h8wBLTHBzIdcvAsT3KGcKm2f4wnq6RL7jxCKludmhBIZB+MRbY1soA
 =
X-Google-Smtp-Source: AGHT+IErGn1UxcGmBXRkCoGC+0S4HHZQFX50PaoI8TgHCDJgbRbhAeMe7/ST8Uvu22322s/YuzQ3RA==
X-Received: by 2002:a92:ca46:0:b0:3a6:b34f:c1de with SMTP id
 e9e14a558f8ab-3a6f19e85aamr9225005ab.14.1731015124797; 
 Thu, 07 Nov 2024 13:32:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 02/10] sandbox: Add a -N flag to control on-host behaviour
Date: Thu,  7 Nov 2024 14:31:42 -0700
Message-Id: <20241107213150.1711962-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

Sandbox is its own architecture, but sometimes we want to mimic the host
architecture, e.g. when running an EFI app not built by U-Boot.

Add a -N/--native flag which tells sandbox to reflect the architecture
of the host.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v8)

Changes in v8:
- Add new patch to control on-host behaviour

 arch/sandbox/cpu/start.c         | 10 ++++++++++
 arch/sandbox/include/asm/state.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 81752edc9f8..2940768cd1c 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -449,6 +449,16 @@ static void setup_ram_buf(struct sandbox_state *state)
 	gd->ram_size = state->ram_size;
 }
 
+static int sandbox_cmdline_cb_native(struct sandbox_state *state,
+				     const char *arg)
+{
+	state->native = true;
+
+	return 0;
+}
+SANDBOX_CMDLINE_OPT_SHORT(native, 'N', 0,
+			  "Use native mode (host-based EFI boot filename)");
+
 void state_show(struct sandbox_state *state)
 {
 	char **p;
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index e7dc01759e8..dc21a623106 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -101,6 +101,7 @@ struct sandbox_state {
 	bool disable_eth;		/* Disable Ethernet devices */
 	bool disable_sf_bootdevs;	/* Don't bind SPI flash bootdevs */
 	bool upl;			/* Enable Universal Payload (UPL) */
+	bool native;			/* Adjust to reflect host arch */
 
 	/* Pointer to information for each SPI bus/cs */
 	struct sandbox_spi_info spi[CONFIG_SANDBOX_SPI_MAX_BUS]
-- 
2.34.1


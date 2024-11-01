Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DD9E6F06B
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8AF892D5;
	Fri,  1 Nov 2024 16:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mjqHQVnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B29388CC9; Fri,  1 Nov 2024 16:26:30 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886AC88E2D
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cb74434bc5so2461832a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474786; x=1731079586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVkqanoExg/W5ZFXEjGqu/ADcv5p/TLMf5DbkvHyR+I=;
 b=mjqHQVnPwpG90Uoz4K985jrIp0u1+Z+/0KJ2P8/HhB8VF6B4XY/1enNYgCq+32CuVD
 SXUtUVh7TnfbHXxmi5XoBKWrjoFauOH/Tick7a5qhlIHVqoy5UMxI9ZumHRANuVJjs6x
 3DUVbV3gCAoEttQAO7oYSIBdHjhxlN5pkM/5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474786; x=1731079586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVkqanoExg/W5ZFXEjGqu/ADcv5p/TLMf5DbkvHyR+I=;
 b=JBs5KTlc2vLILINvRmRFdTcPPYFmcc/LbMWy9dmbkzFtCS2xKUCSk1ovyEJzDcyAw+
 TE53Nh9+JHSa1v/c4nEKucznV1qZigxvxdKaZOu8r6HeQ8j0JyDm9/kwAaKopgXXD/Vg
 Svjjx2GMvlvVp2r7xaPo+i3My/HT3yyisz7qPkaWo9IJGux6iA5mHwFdcMEOjGmaknNT
 lbVHEu971Ns0FU7DGCADOlmFH/WuclmNq8ItbbVVgGwmkgenAmRKUOs7lWeUdyG2lBIV
 XNzXNDJ2Mv6Pi/DwTYcrZ3fZPskUJ88UwCkOj5IAp5hb6HDXyFOHjx3GcfM9AxoV/zGP
 NqDA==
X-Gm-Message-State: AOJu0Yz7qCFXsgARa76juCZnDm0nd0ApYgLXcwKMcZ8x8w2QBbVh1I/f
 P4Xz7lE2SJDyMVmhLJsq4UeqmV7aZHyhGTSM0WtZGBkLX57pzt/W7co71JxQw1jAjFRzN8YY1Tx
 M9mIc
X-Google-Smtp-Source: AGHT+IHdjyyEYMHRWCR0ecuus/TcV0I//tPqBOYoLceCxp1JiQOGu8xu7qWoCOO1lebqsmjTQ04w0w==
X-Received: by 2002:a17:907:9603:b0:a9a:3da9:6a02 with SMTP id
 a640c23a62f3a-a9e658084cbmr344489766b.60.1730474786182; 
 Fri, 01 Nov 2024 08:26:26 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 03/11] sandbox: Add a -N flag to control on-host behaviour
Date: Fri,  1 Nov 2024 16:26:01 +0100
Message-ID: <20241101152614.238747-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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
2.43.0


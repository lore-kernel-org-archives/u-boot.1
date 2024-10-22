Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BC7D3C932
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843A288FCF;
	Tue, 22 Oct 2024 14:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j7a8QWfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726438905F; Tue, 22 Oct 2024 14:00:45 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F76488F82
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539f72c913aso6413289e87.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598442; x=1730203242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDQTnVD57zTzzdd8Lp8++6fhuQQU+nwTWxx2H4CIMNg=;
 b=j7a8QWfectwiSBPDQqQzyc9/20MPQ8nE03tnkQoTEjsLMK8lm9SyMFmMj67w4PGuCR
 Rz3ug5B1CdUI1MsKP0H4armiWLa4T1N62ftwUB73NN2DRj/XVn5P9nxiHSFGvjkApgYn
 GSXJqkxAOV/XAHH25TikMDcGJV1RbSoiExlXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598442; x=1730203242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDQTnVD57zTzzdd8Lp8++6fhuQQU+nwTWxx2H4CIMNg=;
 b=PSAG5ILxXoSf9A+yUv+0AUp6jFG+MRg06/HvGGknjiV6UyYgEXyv26v9sAEzB5WXbL
 qPKwd4JcsS7bR/jvEvNRUH+2DZWQXzelAox/piPsFGipARHdWK0QgGjGHy0xK4aMtpAW
 Q5EQgCYY+2uAgPl/+WYSVA9zoHpp9CJTE0sCL/+MJws6gKrqO2mo5mIRxp3M9vAY/+8r
 KWbnv10r5NHzoiVOvxVoh0xcyXvRnkXtrFC/V91wAvxa1RMHoIPhWklDU1G2C5VCvi2p
 ICAL+m+XxcI1JFytNmHYZxltoXe1XixEMWsgfd0y2DXS3PV71Rqewz3YEjvOtba84Cfc
 NVrA==
X-Gm-Message-State: AOJu0Ywro5OTIFkpUmloxjya9toSwsflJsxxPBn0sa7A4RNpyVhqyxBD
 0orF4AXQqDJkvX+I/O+GAsVMTuqNpPd/73OMeGWbMjypWercaXXKzMhPObyXTOjcpOPpHPXuekj
 +RX77
X-Google-Smtp-Source: AGHT+IEzYrpgG4IcYhm8EM/PiH6muP0dL7eE70P7hJN+eXYNSBxFbGpaO7WxLwM8hbKJtz5141I3YA==
X-Received: by 2002:a05:6512:2316:b0:533:711:35be with SMTP id
 2adb3069b0e04-53a15229c20mr8007686e87.26.1729598441810; 
 Tue, 22 Oct 2024 05:00:41 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 4/8] sandbox: Add a -N flag to control on-host behaviour
Date: Tue, 22 Oct 2024 14:00:25 +0200
Message-ID: <20241022120032.196311-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022120032.196311-1-sjg@chromium.org>
References: <20241022120032.196311-1-sjg@chromium.org>
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


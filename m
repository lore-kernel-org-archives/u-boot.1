Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77EAD3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0362891BB;
	Tue, 29 Oct 2024 20:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E33eE5qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91209891AF; Tue, 29 Oct 2024 20:22:36 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AFA89198
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso6841812a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229753; x=1730834553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVkqanoExg/W5ZFXEjGqu/ADcv5p/TLMf5DbkvHyR+I=;
 b=E33eE5qiaCLVJ1K0SxzN2WQRpBFIJyw14hy7vMPvrn/7H68Ng1NUGZTZ/LN1ifDdR8
 IXaqPFzlMymGr5wNBTSazrCbSD+DVZVmdyuM0jTMq039wf/QD5q7dkuLrBDLOwmY4FP+
 LrIlxpJqqLgyTRItoSsOXzPBNVlrG2+5pFW1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229753; x=1730834553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVkqanoExg/W5ZFXEjGqu/ADcv5p/TLMf5DbkvHyR+I=;
 b=RjmIDZoGuOfOqEvv1qhcc7QHjKATKiCsSqEutu5N2ioAhOfpaxfERgzBb90ovXwVcB
 OX3Q02nOaqD8ZEVkeYgONK1+nV9ix4W8XP16TxeGAZl7INKBeE3WbWYcAtIuniF3kn4/
 SsI9MVbAP+2h9X8zcfHh03VNO9UPJyzJEuuQEegrzufuaJmKP4akpB3y+ArV/EMJViMy
 OsVfx+cvbPNoCPfh3X4CdEc9Uumvm0xa2Ykjobez7tirF2YMveLa3iRtRvKDJqCg47tW
 eiuU63X/3Pfj6Wb2IvROl6fOcN6GZz3N9VKdQV7jmsPGpr8SKn7AEoyEfoLp5wcLLr71
 4KmA==
X-Gm-Message-State: AOJu0YxqPyfY70WWyedp1X9GQ72oETPAU18LzNXsffSfaz0RgBAEBclB
 g9C1xNgvsVALrz5OJbkPFwUPrTzVpi4WRp48RV1CjeQ1u8QK6DYno4ijb1K1OI3FgJ7ZA+Emkdj
 uOIES
X-Google-Smtp-Source: AGHT+IHi+CCXV80fuqDfO252cJPyGYJ4E7G9lq1FMBOQS1L+9egPifPglyKtDKYEELxiEhzPCDh88A==
X-Received: by 2002:a05:6402:34c7:b0:5c9:5c40:6d9a with SMTP id
 4fb4d7f45d1cf-5cbbfae67ecmr8079139a12.34.1730229753351; 
 Tue, 29 Oct 2024 12:22:33 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 03/11] sandbox: Add a -N flag to control on-host behaviour
Date: Tue, 29 Oct 2024 20:22:11 +0100
Message-ID: <20241029192222.362445-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20937CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A3886DB0;
	Thu, 21 Sep 2023 03:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gNVJ6ptj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A278E86ACF; Thu, 21 Sep 2023 03:58:24 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1250886DDC
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-452863742f3so258664137.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261493; x=1695866293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1dM9JMmRW8yQ3TFMqGkJLaChsjSR8HioCbLG1P0Zyg=;
 b=gNVJ6ptjOf/CHOu+ynItz/SxZrneIOLuRTLYhD2R06eaGYtz2t/h4yiUlyr7WBs1Ek
 7Qa83hvMAGgeBnNrixj/bGRoMqT/52w83zY+C37vKbMQsNd/AVuf7qp0ivyV9sWLkhzN
 VdaobklgSZkrD7k2JGdVw+jlayGN09USBe7QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261493; x=1695866293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1dM9JMmRW8yQ3TFMqGkJLaChsjSR8HioCbLG1P0Zyg=;
 b=LG6AtEWd1Z82cCSgsWl5b3VyIIzzxtHC582uJrGY+e2JLSSXTs8wXcUWZglD17wCWq
 dMQLQiP7u0B40pRTZIjHVupF7/L1qZM7qAOApeIC2ekDpMyMPhn2W/JajAVtBhRJjQi7
 g2m1nhJV9Lh9Y9VR9oNluJTeSfT7bIf8C48W0c1Wy37byKk6OwLI3Tj2p34AKy6N0xW4
 yClIIJJ2cgRgxL9AO4Zdu+tdSmn3AXQO3/oXDH+u4U27dPMGf9xbkl/TsRDr73cw55EW
 Z5o6Gdzia14X9KYUBPT5hGnl8QI0jl1QbJcBbvSyxOg8VM2Xfhp3sH+F+SpQ8pW12ous
 vbRw==
X-Gm-Message-State: AOJu0Yyw79cIoNd17tbcvbMfVzu+F+x3uWzxZEsu8mxikmHvDVL3ZL75
 CSKbtcMJPYSesyEyCzpDkXpvD8aBzBEi5dKWlN4=
X-Google-Smtp-Source: AGHT+IH/+o8zKhOyMsV7+zwOochivMLWZ1O3f3JqpIHt7oAKyD/WvzJXnqVEn3AgNW6QA4K288oEJg==
X-Received: by 2002:a67:ea94:0:b0:44d:5a92:ec43 with SMTP id
 f20-20020a67ea94000000b0044d5a92ec43mr4283206vso.24.1695261492798; 
 Wed, 20 Sep 2023 18:58:12 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 27/32] sandbox: Only read the state if we have a state file
Date: Wed, 20 Sep 2023 19:57:16 -0600
Message-ID: <20230921015730.1511373-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

We should not read this unless requested. Make it conditional on the
option being provided.

Add some debugging to show the state being written.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c | 8 +++++---
 arch/sandbox/cpu/state.c | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 5dc4db8bf605..efbc60e66805 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -522,9 +522,11 @@ int sandbox_main(int argc, char *argv[])
 		state->ram_buf_fname = NULL;
 	}
 
-	ret = sandbox_read_state(state, state->state_fname);
-	if (ret)
-		goto err;
+	if (state->read_state && state->state_fname) {
+		ret = sandbox_read_state(state, state->state_fname);
+		if (ret)
+			goto err;
+	}
 
 	if (state->handle_signals) {
 		ret = os_setup_signal_handlers();
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index fcc0028ff4a2..e38bb248b7ff 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -521,6 +521,7 @@ int state_uninit(void)
 			printf("Failed to write sandbox state\n");
 			return -1;
 		}
+		log_debug("Wrote state to file '%s'\n", state->ram_buf_fname);
 	}
 
 	/* Delete this at the last moment so as not to upset gdb too much */
-- 
2.42.0.515.g380fc7ccd1-goog


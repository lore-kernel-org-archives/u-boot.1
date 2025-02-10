Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD61C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C9A80821;
	Mon, 10 Feb 2025 14:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A3aQLNQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B79080548; Mon, 10 Feb 2025 08:28:44 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1D0801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so25776285e9.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 23:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739172522; x=1739777322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3qmidA3HCzyydVtQlLx9P/rFb4Bn/lkizVFmGF8hecI=;
 b=A3aQLNQzQuq7XuEnrnjxz13gYCK4gUl/YMt0Y8d1g4wZEWBEdSgksXT43qCqi2jkut
 0nJh1UfzgCNpTm++/mi+vWA3CQSZwMjucsVwhY/IgG0IPbhUvr4S9plaTS1SjdQaxrRV
 Y31mpv1BpbBdk1HjTfN02F9TFz93lw69aa5zWCS3q6CqjbuaGtUEUJioT9wYHdLDsGFx
 xUW1BrnA4G8iqT+8ZbEP4AtQaaSq0EZdJCXWkRQ0TqLoYaSw1JGq5ZfAFHJd4ChbJ+4s
 7kB5s5qUSQDqIGkIvo40JP/LdCAX2SdfUFfmWnKXg9tpnKAqBWuQJQtfaMzchR5LFiOB
 I5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739172522; x=1739777322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3qmidA3HCzyydVtQlLx9P/rFb4Bn/lkizVFmGF8hecI=;
 b=hqMoZwXOJ+hoPSqbYwgujNCRlUN+IkDMnYnIt29UsLjIBgLPqY+Uz8dkw0QWj+9qoS
 KcDQmblvTF0LkXXVh+MzQBvktXwXt+wzFTWbtRj35ER0D2q7vOzaCE+jGhUpEoEXAtIv
 lM3+SRdSIbDyJuREau9PB/JvUir2gzRDCgUtMfT/vstzVCyxox5E9U/At741JlulD3Yz
 UQ7CfEvWgrXGt1BofkXqKz0f9c+ZBaEBS4Lv6wSTx62dLwqIEIpSd7W0kJrujNhEOVmg
 OxjARIbstG+QRh//m6bg5BHtQZ/Ps7JfEzNcNi4bG89gY5lsmIAHr2AeGfolPQNOJO1i
 +fqw==
X-Gm-Message-State: AOJu0Yz92LZBrjfWNL/FZxjQIec0ojlGBKuu92nHf7kylOYOooQXklx9
 6k0oKrdiltov3JuoESqK0pzc6ZNO9K4RSWH7eV2KSXBYi0S6QpoY
X-Gm-Gg: ASbGncueksYrsnGGfgNrQRPlZvrTJVbCxDQfFxCvFnWhLb2qFyep6qAuCL5oS5RslWi
 uJj7Vajh9FfWEAjEYjWEtgxa7/nrD+DJT3+FvpgMpTj7WJh9O8faTUJ6IiifbrFUgQ3Zvqrcs4N
 TggoQlJoV6/QyrCKwn/jcyvO1IN09gCBjIBmpvuf8bkHL8ki/NRSJHTuARhUPQzPSi5j2DJY7zZ
 0Vk8TvmbPjqjZvBtdvyYwZ1EbQ+ox8jbhyDYqgDzx3Xvo6oq8YUdQPKMjmlNCqv/TuvSRVGIf4J
 NPilpZ9lY33/ulZx+UXrIg9ZO3u90WY=
X-Google-Smtp-Source: AGHT+IHFOmHTkUWz7PeC8BooCyeH6F+q7UomnUAvCnv6CkPcz8lwCUmrkAVI2qCr5sms986HhnQu+w==
X-Received: by 2002:a05:600c:358f:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-439249a8ae8mr79468715e9.21.1739172521882; 
 Sun, 09 Feb 2025 23:28:41 -0800 (PST)
Received: from eichest-laptop.toradex.int
 ([2a02:168:af72:0:1e6d:7190:f4b8:8cea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94dd1esm173168185e9.16.2025.02.09.23.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 23:28:41 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com, s-k6@ti.com,
 w.egorov@phytec.de, n-francis@ti.com
Cc: u-boot@lists.denx.de, Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] board: verdin-am62: add dram_init_banksize
Date: Mon, 10 Feb 2025 08:27:47 +0100
Message-ID: <20250210072834.9135-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:33:36 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add the dram_init_banksize function to the board file to properly set
DRAM memory sizes during boot.

The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
common location and Fixup DDR size when ECC is enabled") relocated the
dram_init_banksize function from architecture specific initialization to
the TI board initialization code. As a result, boards relying on the
previous setup now require this function to be defined within their
board file to handle DRAM sizing correctly.

Without this function defined the following error appears during boot:
    ERROR: Failed to allocate 0x1000 bytes below 0x0.

Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/verdin-am62/verdin-am62.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index e948fc16ba9..b80b39b6767 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -35,6 +35,17 @@ int dram_init(void)
 	return 0;
 }
 
+int dram_init_banksize(void)
+{
+	s32 ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		printf("Error setting up memory banksize. %d\n", ret);
+
+	return ret;
+}
+
 /*
  * Avoid relocated U-Boot clash with Linux reserved-memory on 512 MB SoM
  */
-- 
2.45.2


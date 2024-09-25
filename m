Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80702C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870F988D69;
	Wed, 25 Sep 2024 14:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WQ8nj0EG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE65C88D61; Wed, 25 Sep 2024 14:58:22 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52CB88363
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d3cde1103so634124966b.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269093; x=1727873893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Z5mTb5Kqhi98+XQRaZBTn0eHUYzRmQoAD5zXBOnGW8=;
 b=WQ8nj0EGdpijsi3CthrWVrjjmCFErByCKdmMcZn5Z1gnW3IQmaaey0dwXsR6+tpb9i
 6DAz3YwmmtDcKDdiTMI24XOxlCJnnkMEJSmvZOyW/bBZhWJ5dFJ+smteUnjzoKMZoKaS
 w7keTwe7shDIR6LJE7neYA5wV6vCNVwGQM0Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269093; x=1727873893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Z5mTb5Kqhi98+XQRaZBTn0eHUYzRmQoAD5zXBOnGW8=;
 b=Ag+nJXNcXAZ7JET0TLM0o75GNhCuck90/ekfp6BkniuLTc0E00shWBHWiQUfcYDn8Z
 Y4BXPl8icFKRcEupStwMzYgp2SXAIVt3KrdwaSbPeQ3BwPxOdFyXkJKs2Xt2T7McIOuk
 I+QDMAQ++1mgJKm33k9ymCAxQrnQrmJLBTgguNpoJx3w5rfS6boqK13w46i8fSrV2T7x
 s+jXVZQAk89/PO1Cb3qI5hS5B9BaFrGblQ1rmQXyCz5ZYDRN4tr6O0bmmmegMcAPMUMv
 d5IfwEMnRWtJ7y9dAd6Xw/gGrNSVTssSICU9Jpzuc4LKqoTWhbj3HIkWXhOhjlpqP4Mu
 ZGoQ==
X-Gm-Message-State: AOJu0YyUiGxPIae82IRT3dGgKFn6I9lbvrN1hPk3q8g00afbYopaUbfL
 SWQy7DGVR4SbMaS5AmhrzeQMzJvJxhY5zbN0dB4K/Eod+aje9k3L+uFN6GWzP42VvnW1/smDyT2
 uoA==
X-Google-Smtp-Source: AGHT+IFIQiAA/kOfvoZNsWQ4qIUXY8HRJzkxUPPHQC1/0+bmJszFKWznSddA6tc/hd81/XldlyWUMQ==
X-Received: by 2002:a17:907:7f23:b0:a90:b73f:61d7 with SMTP id
 a640c23a62f3a-a93a0617d22mr261871966b.42.1727269093184; 
 Wed, 25 Sep 2024 05:58:13 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 14/19] spl: Add debugging in spl_set_header_raw_uboot()
Date: Wed, 25 Sep 2024 14:55:40 +0200
Message-ID: <20240925125622.197915-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Add some debugging here so it is easier to see what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 878036210c4..75fa1a854d9 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -276,12 +276,17 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 		spl_image->entry_point = spl_get_image_text_base();
 		spl_image->load_addr = spl_get_image_text_base();
 		/* if needed: spl_image->size = spl_get_image_size(); */
+		log_debug("Next load addr %lx\n", spl_image->load_addr);
 	} else {
 		spl_image->entry_point = CONFIG_SYS_UBOOT_START;
 		spl_image->load_addr = CONFIG_TEXT_BASE;
+		log_debug("Default load addr %x (u_boot_pos=%lx)\n",
+			  CONFIG_TEXT_BASE, u_boot_pos);
 	}
 	spl_image->os = IH_OS_U_BOOT;
 	spl_image->name = spl_phase_name(spl_next_phase());
+	log_debug("Next phase: %s at %lx size %lx\n", spl_image->name,
+		  spl_image->load_addr, (ulong)spl_image->size);
 }
 
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
-- 
2.43.0


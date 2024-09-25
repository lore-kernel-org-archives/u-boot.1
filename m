Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F199C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF99588B79;
	Wed, 25 Sep 2024 14:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TjKWpVIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C3288C37; Wed, 25 Sep 2024 14:57:53 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F4088363
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so102379451fa.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269067; x=1727873867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMHmGdxRW6equVHL1dqGVz92squyfxsDWicYH7fDlpg=;
 b=TjKWpVIGBskVrXTqImAd36mmBG9WGSvqDmYspzhYiJrqlwftZc3NQdvj7dCVo9DKQy
 YaXrvsN5PhI8hCDtM+AxnYogXP+MPLO0iVrAq0cY69e91Is00IoOAyDSDFv9Yu1vCKf/
 hgVJNNxARgjbiTHv6kVV9T8WwZqBvrjdHvpYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269067; x=1727873867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMHmGdxRW6equVHL1dqGVz92squyfxsDWicYH7fDlpg=;
 b=PHGihxqhAgumijkV37PVEJyO5r/T/5RaGiC+gUYv8cbFoP/rMseZUWjl0tBLsJS9O2
 wfRgV1m59XKaBzyQAWlfhO/H+bHRYtLS8jinzEUlwIzulcWS+0LoDSC+XRGvee8XfuHj
 +CYTepD7KLrS3IVoVgguutmARggxNZthOE3uHePdFx+GQ2zkYNS0z/kFBVx7Q1yD0MMn
 uKVou334ulRDadpacuuqsxsnSy6TFH2KZsSraJCkrz6unl68ZF9y95zP+LnUaCaTfD5L
 fdV4LVsZe6Trs8/L7ie6t78ConKDnjHUCBrs8DACBDM28XszJkpjtXMUP5dsbulAxt1J
 Jyyg==
X-Gm-Message-State: AOJu0YxsSfr4RBwYYy3n3Va+vkbwPVYlVlNI/2GmoeLew3RsZ7hUG1iB
 jH2HHhlq0a9wSuTz3H8EwG/TqElORYDfeCXrV41x9tHLIP+e1p7yAy3x4fvOP0cmuTTTfdpeHz1
 0ew==
X-Google-Smtp-Source: AGHT+IG5T0NNocePDgfxM4WDpuOScua2NtFsqFIteJIYRiOiTixKD60zM+r2H0l1cATIUc8MZc5pgw==
X-Received: by 2002:a05:6512:a8d:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-5387048a6cbmr2160673e87.11.1727269067042; 
 Wed, 25 Sep 2024 05:57:47 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 01/19] spl: Reduce the size of the bl_len field
Date: Wed, 25 Sep 2024 14:55:27 +0200
Message-ID: <20240925125622.197915-2-sjg@chromium.org>
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

This is a block length, so typicaly 512 bytes. Reduce the size to
16 bits to save space, before more fields are added in future work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/spl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/spl.h b/include/spl.h
index d90eed956af..1cfaa08ed6a 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -309,7 +309,7 @@ struct spl_load_info {
 	spl_load_reader read;
 	void *priv;
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
-	int bl_len;
+	u16 bl_len;
 #endif
 };
 
-- 
2.43.0


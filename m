Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576E5D0E6FB
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3C188F91;
	Mon, 21 Oct 2024 13:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XXVUvsBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D155C8932F; Mon, 21 Oct 2024 13:42:53 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F148588F49
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso700453666b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510971; x=1730115771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nTAAcsOw7wkAd5ELjgqraL+vUmz0NCt0LJelZjDH3eo=;
 b=XXVUvsBvhm46sEXNrfgjdDHxtsy6DcZGvS9Zc7EUaW+U4AmGfh2htE+kxvOCXwHWNn
 rBbQNc9j5CzbaLwJpMMSJ6ydA2EUS56Oz2Xso/ni+TFT6x3yo3AdONlLQfD5PPwV40e7
 cYa6r6rf6Jh383/8d76qvBSugjwYIXaAK0CZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510971; x=1730115771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTAAcsOw7wkAd5ELjgqraL+vUmz0NCt0LJelZjDH3eo=;
 b=tIFWmB2NCT7h/qEJrOP6jH7nayw7yT15As120iUnBlr7ckPw/1YfxIw/xQErsecApu
 KDC1PXqwjWz7MRlsYCcDizq1nTl7y/OPYlok2qbNpv2ydGLjr5JGvrd9+ORsj8NPRwpU
 /fM7kN6cHvlakGzerCfv0fmQ6jz6ruCjTt1M7Crx+TKNufjhSQjQxZe2b9jp5GCoI7FI
 IuZ3JxRuC0TCEWXkSztqOpSI9e2zkuBN86R/wvrxlYbKX4m2tqAdkDxJAAGnk/HB/N01
 OvAI8NhwEYYcUmt7bPacuKPof7CHrITSy2Tx2jmKjb3EMGokSBXur+lRrbi9FkU74z63
 SiYg==
X-Gm-Message-State: AOJu0YwrnQaRzfEfKHi0rtlGeHKJwo6a32Ag1Sx5EznIAD9WfOQGP7Zv
 OwR5Gqfmr1MogiMcltRGnpTSN5Fr52TXMitEDXNWmMhYk7QQg38DAFbkmOAfXZ3VEKq5pMOvT3C
 b99+5
X-Google-Smtp-Source: AGHT+IFT5PAwmHFrJxY9EZoebkxeJO7Z85Onza7ez6diepSMKcFeGRAhh8cJSPc9bMjPfHSrWzwnFg==
X-Received: by 2002:a17:907:7b9e:b0:a9a:72c:f36f with SMTP id
 a640c23a62f3a-a9a69c9bd50mr1029208266b.50.1729510971150; 
 Mon, 21 Oct 2024 04:42:51 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d5fcesm195080166b.26.2024.10.21.04.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:42:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] fdt: Correct condition for receiving bloblist
Date: Mon, 21 Oct 2024 13:42:37 +0200
Message-ID: <20241021114247.349863-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The condition for receiving a bloblist from TPL is reversed. This was
only noticed are the other fixes landed. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b0655988029..60e28173c03 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1677,7 +1677,7 @@ int fdtdec_setup(void)
 	 */
 	if (CONFIG_IS_ENABLED(BLOBLIST) &&
 	    (xpl_prev_phase() != PHASE_TPL ||
-	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
+	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.43.0


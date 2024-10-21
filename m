Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D5BD0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A7988F5E;
	Mon, 21 Oct 2024 13:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AIgp+Dc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1970A889AE; Mon, 21 Oct 2024 13:38:59 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BEC88CFB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cb74434bc5so600412a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510736; x=1730115536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdss8yE2/awIEEy86I7YaeWMYJdbjKgylXCFi3piogU=;
 b=AIgp+Dc+JssOrRr+cp8maViBwqlDClwcMfy1knQkMtM297z6JZxAiuojls0xXqSbOX
 9EMYmzUl/gf3DqOoyfRFLYVGJq6F58jwxPpmgPFYD0/G/pDPXSg5y9wb8w5uLEKy6X8K
 pHXQqLryYH3mav1qVn2NjUhsrS0V5RvqPmDmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510736; x=1730115536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jdss8yE2/awIEEy86I7YaeWMYJdbjKgylXCFi3piogU=;
 b=MviHHNierd3O1wJh6FdEeJY5PKoAGLz+Od2sEK7R1bM3/m2bkdtR4NRXqcflJLzBUo
 ovQidgtu93gKN/c3BK4ZC0S7hGLOZ2gu8a+nFDNa/zb2mOctulT0IvDWRQn/pgHtdokv
 0huKvbOtBC44Vwb+cmaA3gFJI9Zpnxsa0o/jBrXgOlhWllM2nZ9f70V2m8V2m/PFDKqU
 gDn+gj2Eh/Lr+cVtc1ZoBlgdFUv9xBpn9Ll2q5l8PhOpmJVRhtUo2CG/J9YIgZ594DCw
 p1ZlArR8qBIIBrUfovC+AU5btIZgHNjQ2dt3zvYE6smVA435Ths6sFwXwEv7PhOnxBcr
 Ba3w==
X-Gm-Message-State: AOJu0YzdkM7m933OejxVqPv67zGT9Crhy8cEmnFPgQAp7kA7/o6MSxYV
 0GH6rXsXCjkLoth8DgNmz/Kj1+AUHnMPu0gO6pZjIl/ObDQ+Fa1vlmQa1qk+kQLmvVe+SIwu53K
 eLd1C
X-Google-Smtp-Source: AGHT+IEWRIXixVBTnk6RhRnYYf5XE9wNyuMWyLcyjfIAXTh0o3cJ7yGssB2JmJ1xourE1VxYRHnmdg==
X-Received: by 2002:a17:907:728b:b0:a99:e5d5:5654 with SMTP id
 a640c23a62f3a-a9a69773f30mr1248489066b.6.1729510736368; 
 Mon, 21 Oct 2024 04:38:56 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH v2 07/25] arm: Drop old LED support
Date: Mon, 21 Oct 2024 13:38:15 +0200
Message-ID: <20241021113839.318572-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This has been replaced with a new LED framework, so drop this old code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/crt0.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index 3e4906e273d..a691d844847 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -185,10 +185,6 @@ here:
 	movne	r9, r0
 # endif
 
-#if ! defined(CONFIG_XPL_BUILD)
-	bl coloured_LED_init
-	bl red_led_on
-#endif
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov     r0, r9                  /* gd_t */
 	ldr	r1, [r9, #GD_RELOCADDR]	/* dest_addr */
-- 
2.43.0


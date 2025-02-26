Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D338C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1795C81110;
	Wed, 26 Feb 2025 23:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U07DOuKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2309F80F88; Wed, 26 Feb 2025 23:16:15 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C145080FF2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220e83d65e5so4317545ad.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608171; x=1741212971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwIxKDQaEvHVl64FWnDS9OedBXtOLe+lLdJ5CCVW/48=;
 b=U07DOuKKrXOFoqg3zFL8q/IDw7ykXtdfaW4whW4Xl9ZNJnPBRdKXkhjdOP7saTpKpH
 2VXvUYqA8A9VyjAobysoZmiBHYDl0aep5gBpeWGrevTAvvsR/icEdn3MGCbWNQBp+x4i
 l3LzOqtdwMZX4y3ETp6BaH3PgFY/AuceYc8Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608171; x=1741212971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwIxKDQaEvHVl64FWnDS9OedBXtOLe+lLdJ5CCVW/48=;
 b=B2CI65nxE9z8cMUniMcbZzAePg2nLmLwgJDmk1uqzhbCLzYyNdzZ9kx85+3sUR0Ea3
 SIZ23Am1ChGfQH4o6t394Bexo32Rcv6DFZuL7fOFCG0Z8P+hJj3F5khYRTCGuIibFllB
 h0TaN1mf418bNTJ3/v5Rblw9gNvmI9OXPhC2FovvRFD6mD3JBjTSYi6lmvA9knA0CxHk
 uXWBMyIguWrB3rFSH32FlTWCe6GDhH5VQyBblfnHpiOrk2HE7wy7bt1zoNklLMMVaSiu
 ha0WEKW7XIP3syL2xLClQNAqa2dVTXwPELRYZswuh/y/4PifuVgUwNLDm+yIZyhaybBa
 0rfw==
X-Gm-Message-State: AOJu0YwES/ycS27faXo+nZ+5AyNFPPffhFhGVImfnzXxZcbMASIWz8/T
 k7cGdsWaD75q04ZatbFzf6i/M62U/ZL9TdsJv4dYhF89bXQCj34BFpx41VSIMb9UgjLMHZxMbkk
 =
X-Gm-Gg: ASbGncvxWgBuQVRVqoIwNADre6NzEKjp1hCiIW/ymbucPNnHyRsAcc3HtUzYrpuXwMK
 kS/D+fREoX2Z8NBrObUDWlhsle2sZz+c7zs7tcstYRVE4Dt0HklDb6iURL8Q0epI/XTAmVwc9Kt
 UMRmKKVDhS6gNhn1bJi1ppaf/sMJSuMuJnbVHSiAvmf0mON8jp4gAamPbhrbrxoZsZALP2pnSF/
 B89KsjRIxRSwLi8aJMfTmP/6gR25hy75W1+mmPU7JmrKtm3aQlWpoNksxNZdYwhUQGP+gCbuR6W
 OL4A0NrDiz4p7+T5DG5CSSmtbuYM7N4wfANfkvo+mY1htlYKrP6QRFwBmXWXcDu+WQ==
X-Google-Smtp-Source: AGHT+IFTSRs2aNAFpVx+gKM0Jk8b8UTwzmcFHOZ3ObRA7HZcJnACHLtyHIom/pCOdwjLwK2K8nPnTw==
X-Received: by 2002:a17:902:f706:b0:215:b058:289c with SMTP id
 d9443c01a7336-22320061fd6mr69903665ad.8.1740608171117; 
 Wed, 26 Feb 2025 14:16:11 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fe825d2bd6sm2376524a91.21.2025.02.26.14.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:10 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 01/15] bootstd: cros: Return negative error code
Date: Wed, 26 Feb 2025 14:15:47 -0800
Message-ID: <20250226221607.1283592-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

This should be negative EFAULT to indicate an error code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 boot/bootmeth_cros.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a0..d4c4ed328bd0 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -340,7 +340,7 @@ static int cros_read_kernel(struct bootflow *bflow)
 
 	/* Check that the header is not smaller than permitted */
 	if (priv->body_offset < PROBE_SIZE)
-		return log_msg_ret("san", EFAULT);
+		return log_msg_ret("san", -EFAULT);
 
 	/* Read kernel body */
 	num_blks = priv->body_size >> desc->log2blksz;
-- 
Sent by a computer, using git, on the internet


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493CFC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8824188BDC;
	Wed,  7 Aug 2024 19:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ygTGhNTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169B888C05; Wed,  7 Aug 2024 19:12:43 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B9488BD4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so695315e9.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050759; x=1723655559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3p4Z/bdjZuV6/Hz4Fj/7FWj/5Hu0091smaG+T0hGbo=;
 b=ygTGhNTnbVv1S7Kc3oD0mr4nyyVPoWbXDi6kz9ipMlPxhqb+zgfzSfAbDVkDLpvI3f
 f4TTg/JH5Upob3C9JoYI8tNxHXaRaVhdPSdOabRK4P2MXrOce6XhvnwYFt/9+BR+W16g
 azHxPg0z0+uDl4N+qoOFHkgqJR1Fnba3yb5A6A/oPTl0YJBSfzNqVSk9f7TFv3XFbmB/
 gASdoMOlM+nrCtZHHyn6teLX+r9dHJnDcNOXZn0KFQxH4nHg8Yz8xdu9yRyOLrY7P24v
 kqGJH/jpkdUrZyawPd4D+mdp8OZFkpfZi5CpIUMUzF9xQYDqU0OEB3q7A6k214koxkn4
 MKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050759; x=1723655559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3p4Z/bdjZuV6/Hz4Fj/7FWj/5Hu0091smaG+T0hGbo=;
 b=kT5Fmab82Tgr2JJzLSdtVssaYxGFI/qEg0XksvwOJ/v0Xo30PyRTUfFPY8esKIfO0v
 4ZYgw+ZKJy01sJrbyr7Kvhz0qX0akZLrBUatnBgdxeEr0m1i8y+rLDC0FP5n82u+8ekd
 pen6WUU0hFfe5tZPYgyArhBOpYmA68FbkGSqGNiTh3RHNilsj7w55jMQ91z2//WnjtGX
 nFa5mfF3KS+pjbo+CUxmRP2X7x736W7JNvPmfpfaAdeYbQONxEZHjoOvM7boEfWqHP9C
 XRL3jXtLMsUesGDbFvggh/iX2oVhdunWw5+GwQdA6RhKeEdurzuephgG2XHT6mYlPG0d
 BTwQ==
X-Gm-Message-State: AOJu0YxMkGwF9CGrMzl4UpuQ3TKFK6WekWInaD/1wL+KgOnVYxLjPH2J
 WpDjCK7YoLGigG8HFvvHrMCz0xc96EHGf1rcHTm8+6dP/6RupM51j81YhAruflcLS4mKKKNaAjv
 Jw6yC9EQb
X-Google-Smtp-Source: AGHT+IGq9NUec7H4aKRUjlcrnYSxV5n5Z3JLDfxI8oGciOjcBm2T65v3LqLOMuyXxs8PybvKIro2hw==
X-Received: by 2002:a05:6000:1bd2:b0:368:4492:eca9 with SMTP id
 ffacd0b85a97d-36bbc0e41d7mr11437185f8f.20.1723050759351; 
 Wed, 07 Aug 2024 10:12:39 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:12:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v8 02/23] net: wget: removed unused function wget_success()
Date: Wed,  7 Aug 2024 19:11:46 +0200
Message-Id: <23a2099efe241dd512a615e51e85e1941fc20a0b.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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

wget_success() is used nowhere so remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/wget.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff6..0e4dc5159d0 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -199,13 +199,6 @@ void wget_fail(char *error_message, unsigned int tcp_seq_num,
 	wget_send(action, tcp_seq_num, tcp_ack_num, 0);
 }
 
-void wget_success(u8 action, unsigned int tcp_seq_num,
-		  unsigned int tcp_ack_num, int len, int packets)
-{
-	printf("Packets received %d, Transfer Successful\n", packets);
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
-}
-
 /*
  * Interfaces of U-BOOT
  */
-- 
2.40.1


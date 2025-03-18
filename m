Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD00C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202DB81A0C;
	Tue, 18 Mar 2025 16:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rd9NL1v8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4130481A04; Tue, 18 Mar 2025 16:21:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440C6819B1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso23503465e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311277; x=1742916077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5G0c6s07T6l8Fba1mu8R4y7wBSJsYcHY1XAB8O/WOE=;
 b=Rd9NL1v8hYkpwjwjdm3LNagsW7r3jZPCJ3g84nZR6N7NLC3gO7DiIBvY9Qf1Ah78mO
 Y0YJ/5aGMFGHkQPVfdkxcpKfjTl036wo050COlMfiyOEKXVE7QSS5fOe0M7o/Dq2epWF
 +S75Bl5n4dQwKTt+9aXPJnQLF0rXYOLW7YCYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311277; x=1742916077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5G0c6s07T6l8Fba1mu8R4y7wBSJsYcHY1XAB8O/WOE=;
 b=FMOezVOe5tyUnaw+bB2MK1yrZTZ8+CT/TI2zvVqBVpZ3s0+FAg9aop9ghbzc9CJoe/
 054Q4vuXklTulOFF3gEroz1pRHEMJF5eLFwxvg421mS1+TOpVY8I+dBZyUS+Z/aJ20ua
 vITqr5c6gXO6oJwk7lCToxh1Hr63g4SoORxctPeEBzGzUFjYzT8xCo2j+zlZ0SBCSTVt
 YMdUuON9oNqADArQy92s/jOT7g0QtOTCcLM1Q3S0BNV31lov6gC8K56MFOXze0TnNNdo
 sa+mIe6GebD5uB+IT9GTwmy5F7D5axJ8vDkeE8/5P5p8R0WrTJN//P8KSG+pV3pelO9r
 b+5g==
X-Gm-Message-State: AOJu0YyJAcWxsKRn+Z9XRG+wXWMRubH0Dvfw71k9VE0u4NUX1UisHQVn
 0fPYak24RR5ETwVyKoc0wJvVbJcoWHQMediM8fKCFfiLy+T/2bvV0FZmPw7YLACcFKvpbGIq2wh
 VXmYB
X-Gm-Gg: ASbGnctL/MWhoXNKs9SqFsjooNWroabmKy0kUswZQh+J9fdWpD83FIqTq1ohzhX410S
 H95E0gXcvs0uBmvn7K3gGH/xxdKSQXylBc5bJ6cmD40L5AxzbGZmgc/X5Z8GL9KyO1Hb3jDVLE4
 Sd9mHgicTwmlAJxL7d1Bm/P/RFEwJZFaNyY8Rjau3ReYYtakSUhtrCwzqwzF6N83h/ll8AGh3u7
 cABMD3/X+sWK0anRb08SSm9Gpd5CI147nj6Cq3y5HsRyJIuKF/ti+4ggnQ9dCTOhkaqWekLS8ao
 lqp/+Ee7kz1e5ep4tvngxAZXyHElKvABIKz4qAuksXRMqKZU0rxh
X-Google-Smtp-Source: AGHT+IEd0mlV0e4N+CVHRu2xcxO9InkA5MCJLVFueVMbRWAlMgkXwvsoLks97N05A6GBP6RKAQeCmg==
X-Received: by 2002:a05:600c:5106:b0:43d:d06:3798 with SMTP id
 5b1f17b1804b1-43d3b9c09bcmr27070735e9.20.1742311276718; 
 Tue, 18 Mar 2025 08:21:16 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/7] membuf: Correct implementation of membuf_dispose()
Date: Tue, 18 Mar 2025 16:20:46 +0100
Message-ID: <20250318152059.1464369-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
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

This should free the pointer, not the address of the pointer. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/membuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/membuf.c b/lib/membuf.c
index b13998ccdbd..695d16d051e 100644
--- a/lib/membuf.c
+++ b/lib/membuf.c
@@ -384,6 +384,6 @@ void membuf_uninit(struct membuf *mb)
 
 void membuf_dispose(struct membuf *mb)
 {
-	free(&mb->start);
+	free(mb->start);
 	membuf_uninit(mb);
 }
-- 
2.43.0


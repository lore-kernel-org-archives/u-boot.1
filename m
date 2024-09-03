Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D8ACD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8718088CFB;
	Tue,  3 Sep 2024 10:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ylRWDEDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDD888C30; Tue,  3 Sep 2024 10:38:58 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FB988CF3
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42c2e50ec13so25658025e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352735; x=1725957535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQRratDTux43Q2ePlyrz4FZtTR8e+cQ86jEMfNCxWhs=;
 b=ylRWDEDU/D5tMcUHyyXuyncyJ7Z2ZSBmyo2EduQyBGuaZOweKTj3pTtPuHQ4I40WPk
 56wnJzL9sdfIann44Aa41Om60+Ld+Df552vzZ6DALQCZhplsUXZoBDxfJAw2oDmR9Dda
 3mGd2rZc0J6DqjGckKKZDxXwxaYaXG0W61jhbbtNXwxnWldPBN2tIgujVP2J3yIL7p0A
 ajRdwaBiMEKXzPJKeyYGz7sZUPoWKa0FvurUgdND2psKP+lZTAIYlDAYIhlKXQMUUV4k
 zuELaxZ3jCYC8Io4vbrFd8voJreC5QmYIoFYmCOeGvGeBOFnrwe7E9ukcV855kcidtHs
 zBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352735; x=1725957535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQRratDTux43Q2ePlyrz4FZtTR8e+cQ86jEMfNCxWhs=;
 b=HI1e22Ktk1ricMAdDPLcyfzVR28ooXdXHBkGyXHycNpSqNQgCiPw5awnCeCm9eB8Rw
 AvgYny5et0NC/3k/JWWOdCfAY+8S9LhzS34msr2i4v47m+aPKprh4cJMAVhewzaOo2/4
 r1J1RZvaN3sAznzbTGT2jlmTvgHqIxokT2akAFYpsoeRGIhlg8NQYbzc6JIEhXJmhlff
 xIPNaByKeZGLYQvVogWwr5pLWzk0r1ggQNxjMWjUSDMLcSuV4/acmX71FXTOdiWo/u4R
 587kMV5FHYGLY/YAUa4jQwCr1iDJPplLA4cJn/uOhcIqo0o7GwNR8CJEAz6d4ikIBJtG
 695Q==
X-Gm-Message-State: AOJu0YxX+fPOiaaX7I66r6BzQNkqM60aAUqvTYVP2D8AyEFs3kfvKEq3
 KlRMP/TznQQKO9KnLq7fp53UxPK6y2vM3keOLSBtZh+aNaAfbXiMJRWjqDHNQq+rlLdta9ec/3k
 aE3oEbA==
X-Google-Smtp-Source: AGHT+IF6XQuwcEKfSceDHCGPOCSniwpPkwiiwhI+Bk0r2mnTdetcrGz2kNJ6JTgYDSuOi216s8vkpA==
X-Received: by 2002:a05:600c:511c:b0:426:5b29:b5c8 with SMTP id
 5b1f17b1804b1-42bbb436e23mr93243215e9.28.1725352735307; 
 Tue, 03 Sep 2024 01:38:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 07/16] net: wget: removed unused function wget_success()
Date: Tue,  3 Sep 2024 10:38:04 +0200
Message-Id: <11aad5fc807a2b544fe364e233c9a0613d18974f.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
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


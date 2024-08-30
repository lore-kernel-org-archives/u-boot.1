Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119C7CA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441CA88A92;
	Fri, 30 Aug 2024 12:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pNYtvCQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B8C889F8; Fri, 30 Aug 2024 12:17:36 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA07889C3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bbc70caa4so3523175e9.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013051; x=1725617851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3o66Wp/cgY/BOAgJXuexd8LFm/1I5mfAo5SsoYZAPUE=;
 b=pNYtvCQuQwmfI+AVbHP5r7GYs3WQshTk5uHRWBvoEos153D4ojlrbd1+3ee5GP2Zsx
 //ZXqiUoJ61Kk0ZuKEB4bRDLYg9y6ws23Vz2bR3uxfP8UE1CLgnOkv5YdtGcqJNXEXCH
 SVN2rddcNcD0XEcjFm0VSPIS1xa8kEQb1k+K/+debRs6QlbP+9mE5rBa9TWF1hHMNmnF
 UealmR8JtemeqO82aSVNYVjzvw8WEZxWqftFxqp68oMDOwcdM9SrDRiwNfUi++uCnZAI
 iIXPKaMsLJG0GacE+DCU9IVvrRDYOHOzjgHGR2+xZpurOGE4k5Ug4HnbKwAo9a/5QQjq
 BkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013051; x=1725617851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3o66Wp/cgY/BOAgJXuexd8LFm/1I5mfAo5SsoYZAPUE=;
 b=TGteUdxnh0C2lLfL3KGTRF3wSaUGaESQ41dRRxLBAYO67WH+ZNkf2j9XkL1Dj0nPVk
 RZCegzCOgkBynvXu1lGXAUmdEtjaAhga3Gcl7JGBF/oY0yHrHklLnUTd7UkxDJdcUyYu
 d0pAAWzmyQZ5y/F+q26QGqDviYYDzwIewyyVeRRzQ7m0zMsCgvFc5wFR4tFdkmFAODhH
 axWfP6Jlqnx1bPHjKlMml5jAKTtC9MR6+xdxNjWQaSdww3iiU3cPh6ilVXyF59HylwcV
 XsbvYEwBgQiiGa4QHE5zHrep+zRwjpdOmIU9PY8omySmMirmHK8LzFOhshzVhDhIh0hC
 /LOA==
X-Gm-Message-State: AOJu0YzNvgfynRWMPZb2MU8yNLJ06fJ6Z/6vJ7Tp4kr7GzSA0NZzaEvd
 +EBkZZTVn7megjvhDq9RHBotgIopqOltLlqjsp+JNltDIjR9JSd9qXVoOD2GttzcIxxu0ODYhSq
 90+2CyNSs
X-Google-Smtp-Source: AGHT+IFaB2ugFnCy5HXgF10ETc3/v2dFnIT7jjIiGJrQcMRWie//MuGgGN4R8rd5oz967hupC37Hkw==
X-Received: by 2002:a05:6000:2ac:b0:368:255e:ab13 with SMTP id
 ffacd0b85a97d-3749b57eb7cmr3891789f8f.50.1725013050700; 
 Fri, 30 Aug 2024 03:17:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 07/16] net: wget: removed unused function wget_success()
Date: Fri, 30 Aug 2024 12:16:50 +0200
Message-Id: <ea4b1b685604aa435b5c589dac847d084100e597.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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
index f1dd7abeff..0e4dc5159d 100644
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


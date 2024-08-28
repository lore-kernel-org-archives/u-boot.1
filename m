Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EADC54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C6988ADB;
	Wed, 28 Aug 2024 14:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AhS0+4xx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19F688AFB; Wed, 28 Aug 2024 14:10:50 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F9488868
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3719753d365so3729798f8f.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847048; x=1725451848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GuQLY2YZQmzPr+GaKiym8bRViMHsvubT9envaMps2A=;
 b=AhS0+4xxSD0FxYCsXmnhhUyg9zWL3M1ViG6/iZgKNcMoZpPxh0m1xNeQsh/izWJteG
 C9q9ea1eGedyKTyqqDnDemQE2ApNRD632pZ/YtL2rKJSZ4ZrH8vHHWLz0lA8WMmizaTf
 fHQfvNjbxhjBSkpDu7VS5KvFw2SXxsEogMUh0TYe1BumMKDk0a3ONqALB6/P/ZpBq5ip
 SzUSW86zinH0JE+ZVUgL1xWKdkYy6hRtKoKGGirN900EtGlOMAYraT8xbSr27W5N7UhJ
 j3eH4gBB274PcJQzG5BMUtNNoTC2ZfODa9UFB0ZzKOtlX5X9jQpGcWgbwzFsH3fJpuVY
 SQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847048; x=1725451848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GuQLY2YZQmzPr+GaKiym8bRViMHsvubT9envaMps2A=;
 b=E3O/4cZmTKIt01Gcp8P6q5+FT1s5UgwEIsRq4tYF2KS4EXAkglbj8oQwaEwScqBmnZ
 XV8j2ofOBqvmU8w7+Xr0BCKDsH9tLHQ057N03m6SJ63dVMPWxn+1XC99VMosyFhLm0om
 mVCfrf4/SygnNyNqR1boWaUwBajE33tAFOtXHtVtiBP8WGXDu3z9Ls/b8tsfnCslmWSs
 OOjhRCbvn+CtAot/772+hK2pgCHfZx4m8ugJJ1FGVUE0sKxCesgr0PJ6UoJIg2WcE00R
 e5fxHEV4TyP36y3EUbTxMnw+vyWSMlFu4VRLXdmbc7gHnKbwcDxMet6q5AGDMXUO7+05
 YK3w==
X-Gm-Message-State: AOJu0YwWjIgOVQsDvbjmZ3ZElsspXU31wfA9IzEgjaIRHmyyqsLWyecl
 IrWPYwH4iZ3gj1CrN47ynGmB/rRkPJ6t8muJvBHhKlBluvbrtlc/EYRQa4GMBSfkY5p5hG1/J9K
 as2LnwA==
X-Google-Smtp-Source: AGHT+IEwrbbX6cUmsSc3AR8G9T3DhYHPZLGr/SSn7/RBnl4g+z5NjQSY37FzXaVBb15hWJXVKMdchg==
X-Received: by 2002:adf:f547:0:b0:367:9621:6fa with SMTP id
 ffacd0b85a97d-373118b9b3amr11180450f8f.37.1724847048037; 
 Wed, 28 Aug 2024 05:10:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, Marek Vasut <marex@denx.de>
Subject: [PATCH 06/13] net: wget: removed unused function wget_success()
Date: Wed, 28 Aug 2024 14:10:29 +0200
Message-Id: <5f77c205f646201b5d68f65eb8872475d18d2836.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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


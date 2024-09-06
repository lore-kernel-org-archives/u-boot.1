Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5659CCE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A665D88D56;
	Fri,  6 Sep 2024 14:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ifChex9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2858188D01; Fri,  6 Sep 2024 14:35:45 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5544388D59
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42c79deb7c4so14946605e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626140; x=1726230940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJgJyKf2hgj2NwtVc1eR/E8iwPMAwTPP4I3hf6px6RA=;
 b=ifChex9/hx7OtTowK3CYxIn7drszExOkMsjiiqwX8TvSLvnSEuPYTrIztAXADDtpdk
 PjtuoviZRuKWGUkYVwrdCLG77qUdQjTNOcxRk81IIKEsQ10GyGky5C8C+z9WNwCtq9Je
 4qc4mpJy9cdqZiZ0UmzoUjFI3f1qX/6ugumc4dTOz6Fes/zjloIUyUP85bx3iAk+tTf0
 01T/KRfeGRrZqRzSqs06Mljpf6G07VP0K7MI0CAn0WribiygkHtbEGY6BXLXnsRFfKz/
 BUyTfr8rBh6y9a1iflH6FLBjAzulZRH6nurZDlvx304g7pRPN8DIzJp23gRiDsAKTfiD
 xO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626140; x=1726230940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJgJyKf2hgj2NwtVc1eR/E8iwPMAwTPP4I3hf6px6RA=;
 b=Q7/9ywpCLySKHJ98rUBA62tP8lcsap4EX1nRYK0Mxyx/I/qPEvTqb0Bap32vHtMl0E
 7pK2zHNEg1Hp/Nfz5UseTS8EhB5Cuuicm6cj+gTuLEY7QKnSeS6V/6zX/AFfr/DIHA0O
 RVowy4M5pAfN/D9MHVfH3T+5Ods9W5aFwlfaeoA8Cfobvv4BMY0JYQd3Q4u21agVwEMG
 zgjuSj59QacTXX4IuMio/kBadCzs60JxSW+qeNi9QhBois6AdtxfG7KINOtsHtBfFiN+
 KDMQS2flUHZqiCiNqDTQetsGEJecVb/JrEbnQaSFhQNv9rZuhE0o6WRnXOYeUTYlDs4P
 3wlw==
X-Gm-Message-State: AOJu0Yy/BHpVbtFECI7k5vQaoP23GvtxJK97PPLL0KBFPAdtYxIAGJ4e
 DDAQRCNKc8sHOdK0bSbcZ8eLLUYOb6kgRAggTLyk6/cOfB/88XzZM3zB8+uL/hOlxnX9K4K5VEk
 eGdMhSonz
X-Google-Smtp-Source: AGHT+IE8KNciu3erNYKuAM2a28t+Z92EL7XOCx6DUej16yo4NTlzdyzP32170az4RuCoAHUvJCtulg==
X-Received: by 2002:a05:600c:5250:b0:42b:a356:a75c with SMTP id
 5b1f17b1804b1-42c9f987f95mr17894635e9.21.1725626140664; 
 Fri, 06 Sep 2024 05:35:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Paul Kocialkowski <contact@paulk.fr>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>
Subject: [PATCH v10 25/25] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
Date: Fri,  6 Sep 2024 14:33:41 +0200
Message-Id: <8fbbdba748190de13a9e39581e9c58b576a570e7.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
NET_LWIP so default to NET in this case.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 35e34e16789..e3796e397a1 100644
--- a/Kconfig
+++ b/Kconfig
@@ -756,6 +756,7 @@ menu Networking
 
 choice
 	prompt "Networking stack"
+	default NET_LWIP if !SANDBOX
 	default NET
 
 config NO_NET
-- 
2.40.1


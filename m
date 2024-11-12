Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4006BD42B9B
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 15:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7349788DEF;
	Tue, 12 Nov 2024 16:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JlFnbdNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B823488DEF; Tue, 12 Nov 2024 16:45:10 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA2288DEF
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so49781505e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731426306; x=1732031106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+IJluINCicvYulMvjf2XKqIIkEt1uTzbWhFIVUUbEyQ=;
 b=JlFnbdNdwVE8F93bOd2lokWsWbToe6M+qnA3ZqTSg9k8YJaYgk9Yfh8d46khxR4F9q
 sAdatgDgRc3PHQhUpoE+7vkTZDARYiFl/BLvi2j/QnR8W4enwNqw4N9/spjLi+mremG0
 SDk9dwkM4nMfsWexFwyNhCWqQllhSNPbugyrnDJhKAD6BwAO7vIB1RG/F7Jkl/rcnkUU
 POdt2JK7HjEpiiwQzxEzxlW+eQpwv9vCr7bac7RV7y2y+9vldL6RFV5XjYsYgytVk6db
 8hF2oc5YF1doFNYm/wI2drMp/AidlJRT7XV9NrDEm5DXGh/AukiWb6xJgglJ0mbwyzob
 St6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731426306; x=1732031106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+IJluINCicvYulMvjf2XKqIIkEt1uTzbWhFIVUUbEyQ=;
 b=c69+IfQU+DLyIKkQ/ESbbgJlRZ9yTjXhA/AVDp88jNq3HVpcS1BltLFwJ7tsOJNkwu
 O3cpTw7Fp63n7EWTg1Mo/ht14pHqy7qWvveevDXCnkSsOYU7k5+He5dEHzwSIoRnvVgr
 9rmznmQG3RyCSWMttuTNg/U+PJSIRa+yKD3Zl/QFgg1l5JjgWk8fhFLTxj8lr4fsPk8S
 56E5SgBU/VlpHm9pWoKoSmChR4DrgikKs1YOhNZH9qqDFtise6YIHjwrSfTfMHbzbQ8n
 z2QTQHlZN971EELs4NRubXQaJqtnfc6nKy6NzBWTkT0dTUjaYlvBG0uxCc7LwMJCBj83
 V0JA==
X-Gm-Message-State: AOJu0YzLEbSYgHV82avQhBFcGDIebj/YunZ9acxmBnJC3jTt9oa04ngA
 lzgiLtIDggXd4aCmM2HTgUxw3Gqyn+9rN/Aup83bk10azx79aww+ZNMVTMmT2kfIoRgRC6MOzJh
 1XfE=
X-Google-Smtp-Source: AGHT+IF6dJVcYO8eto4UWhWc/Jff/2F6sXjtLucPLvZN9KVrembeDoIXAI+lCFB6kVOXAiJ4AozvpA==
X-Received: by 2002:a05:600c:34d1:b0:42f:7ed4:4c25 with SMTP id
 5b1f17b1804b1-432b7505ad9mr147488225e9.14.1731426306238; 
 Tue, 12 Nov 2024 07:45:06 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3aa3:af95:97ed:dd98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d0289f02sm9709715e9.1.2024.11.12.07.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 07:45:05 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2] Kconfig: describe NET, NO_NET, LWIP_DEBUG and LWIP_ASSERT
Date: Tue, 12 Nov 2024 16:44:29 +0100
Message-Id: <20241112154429.1532647-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Some Kconfig symbols introduced in commit 8cb330355bd5 ("net: introduce
alternative implementation as net/lwip/") need a full description. The
NET symbol needs one, too.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          | 5 +++++
 net/lwip/Kconfig | 7 +++++++
 2 files changed, 12 insertions(+)

Changes in v2:

- s/linrary/library/
- s/own/internal/

diff --git a/Kconfig b/Kconfig
index eb55f2511d9..1f5b0f1972d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -765,10 +765,15 @@ choice
 
 config NO_NET
 	bool "No networking support"
+	help
+	  Do not include networking support
 
 config NET
 	bool "Legacy U-Boot networking stack"
 	imply NETDEVICES
+	help
+	  Include networking support with U-Boot's internal implementation of
+	  the TCP/IP protocol stack.
 
 config NET_LWIP
 	bool "Use lwIP for networking stack"
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 8a67de4cf33..5d719a1e420 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -6,9 +6,16 @@ if NET_LWIP
 
 config LWIP_DEBUG
 	bool "Enable debug traces in the lwIP library"
+	help
+	  Prints messages to the console regarding network packets that go in
+          and out of the lwIP library.
 
 config LWIP_ASSERT
 	bool "Enable assertions in the lwIP library"
+	help
+	  Compiles additional error checking code into the lwIP library. These
+	  checks are related to conditions that should not happen in typical
+	  use, but may be helpful to debug new features.
 
 config PROT_DHCP_LWIP
 	bool
-- 
2.40.1


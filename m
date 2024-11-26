Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E22D3B998
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34B388DEA;
	Tue, 26 Nov 2024 15:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zLqQBk6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABDE88DF1; Tue, 26 Nov 2024 15:45:29 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF48E88360
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso3928115e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732632327; x=1733237127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QeRR32QADWCZ+aoxZbvsQewxa+eh8ZGkU57utxJF+WQ=;
 b=zLqQBk6ou1sRAY9w7W6bZDEnbk96HdrCppv3mCCwMfSOWDeDj/UpWFsonRn6q1A7dp
 E1Rs7MimhADPwPiyzCG1GyykpIXrG09kRKYhDlquTkJ8kzlPBJIg+4lNLEwbc6Js5SZy
 oLRF2NQ+RbUhAbOClDDR3tkXXxoKvbNqNAw9fOlHjKr/fPdcQa5peIn9URGJJDFw/wwp
 6dN5VqXI3xx+aUh7/MSwAbbKszPXcb/K4kaXWn3IrQy6wjIIly1UdfEWjfbWhwO//0cV
 cJz8sLxHt7FyuHqZ/0hz+a4e2KbEKxgkA1RzZDim1AFcNZKbgcpSgTm8TJeXyCZq1n3o
 9ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732632327; x=1733237127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QeRR32QADWCZ+aoxZbvsQewxa+eh8ZGkU57utxJF+WQ=;
 b=VYwp9TYNX4A/ZjyQcy/x6NhOmaO3Dprt8ObBSw1xeXDIE/dJLxZNuaDdt3q6K+Z2uW
 /T1I7uFohSh5ZM/9k6gaVQh8EJ92XfH+6/0QD4/1mS+PPhRSQS7F/6lhdJ+PEOKkOq+x
 feSQth4vS2xXeqT6QBe/E6FAaQ8T35feojpEUuk2d1mbtbOFK4s6Hu0yyBfDsY/oZn6E
 2LjkYfvWYjFfdCI21jGQsOJ7zvqoZSf/1bwp+DnXDV+AHpeL8OKvESKLLUPFs5TBaA7w
 ZgiU5VW0rjC/eU32BPCPGaX7/0jsKA5GD9gmrHI05ls1iDTxiZl3o+AZl//yGgT4fRXl
 Y3aQ==
X-Gm-Message-State: AOJu0YxGfn6433x5+vNx9qnSrNiFC1J2kKhL/zU2Pkjh7c93OIuWTL0A
 Hn0pl+IuEwS+SIez8rX9T8Fxn2OXDkuW3pkmp97e7w7Tr+Y8t6fHS3I4mEX/Eif1mt+LqtXfQ/C
 Ynro=
X-Gm-Gg: ASbGncv2p/c7+aXk+iYhfUX4QuT2E5suVhq0q3KTnda6FsL29exIEckwKVyJfAKHF+9
 CMJvlvZEMcxxCF/ziLLPKAJWp7ruFTe8OEKk2Apb9YWrWrPNUX8Gi+5r0PmganrdmAw+dYd99vy
 8ntIboWW7zAP1wyHGlR7TW8OqEnL2MA/wht/sCNdmNUS3pXGRCo98BHsWDLeKXwdpS2u2mX32km
 9ejYE9sB6EjWjEJ2XmmJlLao2Wjx5Tq4DQbNvty6GgJxaOKQ2+apEi4Xw==
X-Google-Smtp-Source: AGHT+IHF96//jdvypB7BE16ZRmvmw8D+mSbldxtag9FxVyWtFDk2uX11et574eAZJjN81foWp1rznw==
X-Received: by 2002:a05:600c:4f86:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-433ce48eb82mr133462375e9.25.1732632326724; 
 Tue, 26 Nov 2024 06:45:26 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d868:8373:c88:a797])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349f9eca01sm74615135e9.29.2024.11.26.06.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 06:45:26 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] net: lwip: wget: fix legacy syntax
Date: Tue, 26 Nov 2024 15:45:06 +0100
Message-ID: <20241126144508.501779-1-jerome.forissier@linaro.org>
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

Commit 356011f7ac25 ("lwip: fix code style issues") has inadvertently
broken the support for the legacy syntax:

 => wget 192.168.0.16:test.bin
 invalid uri, no file path
 Invalid URL. Use http(s)://

The reason is two calls to strncpy() were replaced by strlcpy() without
paying attention to the fact that they are not equivalent in the present
case. Since we are using a character counter (n) and since we do not
depend on having a properly null-terminated string at each step in the
parsing, strlcpy() is not justified and strncpy() is the right tool for
the job. So use it again.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/wget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 062aa7c44f0..5501ffdd004 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -161,7 +161,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 
 	if (rem < n)
 		return -1;
-	strlcpy(p, server, n);
+	strncpy(p, server, n);
 	p += n;
 	rem -= n;
 	if (rem < 1)
@@ -172,7 +172,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 	n = strlen(path);
 	if (rem < n)
 		return -1;
-	strlcpy(p, path, n);
+	strncpy(p, path, n);
 	p += n;
 	rem -= n;
 	if (rem < 1)
-- 
2.43.0


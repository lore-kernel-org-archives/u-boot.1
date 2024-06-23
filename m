Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0019C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D71CC88433;
	Sun, 23 Jun 2024 19:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ejGUDiaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7B188549; Sun, 23 Jun 2024 19:53:27 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E46218845A
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3748ebe7e53so15114525ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165202; x=1719770002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=ejGUDiaAuPUB3432+0FSvH3rjCew5Sht+ERb/3Nh9+lvIWrHwu8sKdRLLIkcg8wSyh
 qkXk0YRYZAR9zjjon/28uTYVe7z3JCP5GOae2XERcpacNeLDFtUFWm4vo2D9HHXU9hnh
 U83eHVInTRd6hgDZ+MT0q0FNHpJUsY6xTySjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165202; x=1719770002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=k7nCFr65VSPid52AFlf++yGp1Id1QaVTNtn78QxHyV4yRHRAIKURPAX/gvWLmZyKOC
 3mw0eaKEZb3jy1SaYqp/NlMY/T68IbqvCpgmR8NKf4u7GwIk8QuquVKOaBqIFBw4hhtQ
 Vjm0Kg9zBwXUjIEORw+ap9laAQ70ELTPRlJPDeXOTxt07/JN8mKBaF+2zcr3X0gzvDo/
 cMUahafe2Zqd2bqh8Y9aySatuZ5AVgkMFSu4gqHuq6rFw7b/N9GZBWXyawvgdoWpswHe
 9Gc9RtHvpz6DY3bT36WjcJ5fE85RdoW9uv+W63yUbWoqeBHpeqyQd8KoQb4G/61vmrlu
 H+WQ==
X-Gm-Message-State: AOJu0YzAFPLOx0gHpcf4Wfdbs5Ud2pxVYejR1PDk7469+un6radBmKx4
 6pQRs6Ye9NOLPLFnlzKXLv6KTxMsHkedKICwGavm7em+TYJXXGQFVNnVf/Rg39nl6VQqCw6nT5F
 l0g==
X-Google-Smtp-Source: AGHT+IF9gFFYiRStUoYz0vCQg1wFmK77YS4dAn1l+ODDNBhVlLItnG8RNej0J6Q/pdsAhcz5UzAEwQ==
X-Received: by 2002:a05:6e02:1c05:b0:376:4a18:a4c4 with SMTP id
 e9e14a558f8ab-3764a18a63bmr4534965ab.3.1719165202427; 
 Sun, 23 Jun 2024 10:53:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v4 04/16] binman: Return failure when a usage() message is
 generated
Date: Sun, 23 Jun 2024 11:52:50 -0600
Message-Id: <20240623175302.1463973-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

The tool must return an error code when invalid arguments are provided,
otherwise binman has no way of knowing that anything went wrong.

Correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: fab430be2f4 ("tools: add mkeficapsule command for UEFI...")
---

(no changes since v1)

 tools/mkeficapsule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index c112ae2de8d..f28008a0829 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -977,7 +977,7 @@ int main(int argc, char **argv)
 			exit(EXIT_SUCCESS);
 		default:
 			print_usage();
-			exit(EXIT_SUCCESS);
+			exit(EXIT_FAILURE);
 		}
 	}
 
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8B5C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D9888609;
	Sun, 23 Jun 2024 19:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DY3KpVPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B4088609; Sun, 23 Jun 2024 19:56:30 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B97688271
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-375daa47685so16185865ab.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165386; x=1719770186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5OHXOcQfkRf+5uJltTrJiDlKttdfw2vieWhkYRN+W8=;
 b=DY3KpVPEGi0QTmIYNW6eM9NkQYVVfpxsP7kUcZLgG00moufI3tHzO9FH6diXWpEwwK
 C8nYCRW/uAED+mrtF2RLNDSTiqF8svyS0ITBh+6oWBb118Jt4CcTGc111oC1Oyr9RUnA
 X8MuVqlR1wu4dh5MJaQSMS2rPbzLwTjAc+t2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165386; x=1719770186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5OHXOcQfkRf+5uJltTrJiDlKttdfw2vieWhkYRN+W8=;
 b=DfwoA1INZpDOjjUkguyiSAKXHY+DMx0Uqx0dHirtWrIOe8oproMXlnFbIb73wmHKkT
 f0WHz507wZnLLy7qOi/6t6sPFn6piueysk+pGU0ZXwXg90D9l6oQEoGJRHSWwVZDkOWp
 OJRXEs0LQTLmFW2/FT86DKYWnRvMmuQ6V1TnrhEwK3pe9dYMXcVAl5yo6WNC9FLeNUaS
 jXbEMrKJA29+XvcK5wezjr74SRGL2slM4Y0y82jtQeUGu7OGPVbSqXYB9G4nLBhIZw/q
 icjTiOCnzbogB8nIQxYYD4i4KRbZLzIHp2hFJQFACvNH9KcSVRTHk+VMl59q00qcdVls
 rFaA==
X-Gm-Message-State: AOJu0Yy0rbTuug2ug9pYw9Wd74/Vs+lU4wofPBn5xF9J8FE8XszDz9N8
 Xg80jsOYv5CMsFt6miV0YqJj4ntiZMCBI+irlGNQ+o4N6c5xEQYC+VGvYSAoGt9ncHUlSXQkqCZ
 eCQ==
X-Google-Smtp-Source: AGHT+IFjWgqp7g/VMse2LGJotvwLcrLCHt6ioBFpPFZbbQE0eo4napAhNmxxnlQ/N5+yU1xqQskhXg==
X-Received: by 2002:a05:6e02:1a28:b0:375:a50d:7f45 with SMTP id
 e9e14a558f8ab-3763f5ae01fmr32006345ab.1.1719165385913; 
 Sun, 23 Jun 2024 10:56:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v3 1/6] buildman: Add python3-coverage
Date: Sun, 23 Jun 2024 11:56:17 -0600
Message-Id: <20240623175622.1468600-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175622.1468600-1-sjg@chromium.org>
References: <20240623175622.1468600-1-sjg@chromium.org>
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

Add this package so we can run code-coverage tests for Binman.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add to buildman requirements instead

 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 4a31e69e4cb..564e54898a4 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,3 +1,4 @@
+coverage==6.2
 jsonschema==4.17.3
 pyyaml==6.0
 yamllint==1.26.3
-- 
2.34.1


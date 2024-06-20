Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2FCC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CDC884F9;
	Thu, 20 Jun 2024 15:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gOSKJvFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C3C88532; Thu, 20 Jun 2024 15:19:54 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E468846F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3762abfe005so1337755ab.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718889591; x=1719494391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y33pMt5dN4bzyeC10EVwpfzP4S/ME5jzzKoDBLaDsqQ=;
 b=gOSKJvFGNPKB2jxXL5AnaNfdl6IGmUi3BmsRsqIJVQhB8pcgvBeapKBOrrG8qZLJzi
 5kDcDXsMsEafey9j9YQFkkKCuTXecYGKAxyDx5RKu+LZUApsCAOfEY/ml2bxigyT+73+
 pMlnYx/Up4iN2GBiMtOm0bqYzY7sCm95fIdTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889591; x=1719494391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y33pMt5dN4bzyeC10EVwpfzP4S/ME5jzzKoDBLaDsqQ=;
 b=QDqUAuxTOYh2gYHqm3jcqyy8dxbuqswy1V+24futV3gcVRwMc6+9dzVrCYIaoASFLH
 GQivktNakaNI3TcXUYv4H3iKVQqNyGpTtPV1khvUxUwPRu3aR4tX0a2X8M5tY8g930xA
 uou+WIXBNr5fFQMj3LCHopEpYFS06CW08djvj4DoKdetGFzEOlMslOW/eObm4TdoJB+9
 KkI1ogzOgM0EtMj5DnjEtbh2vl6yTz+5qcIHi31b3TYhF99C8F3DEp9eU9IR1TGHp3Wj
 zJhnsPSuKsYJChwaG7wdZPzv1QEzsqrUnUID+kM4pOojU1VGTRBTH4OO+5JWp8MRdeRg
 2AVA==
X-Gm-Message-State: AOJu0YyZ57/F7N6ezSiKe7lTk1dgAExfjX4gvupGsB8rhLdeYj1MpbN+
 cqC9AOgL6pFSMlyZZgvvrILskYtwMV5gxzBpIBLycfRm133Knm2vG5tbSlxmbZfSwSzGHr/WCoe
 2eg==
X-Google-Smtp-Source: AGHT+IHl4quBElpISYuf2Vh44lF6guJsPPvp6D6zN1GShDAIRJGEqHpRB0HBcOsLl/wSAzzRZPkCCA==
X-Received: by 2002:a05:6e02:1a24:b0:375:8b0e:444c with SMTP id
 e9e14a558f8ab-3761d67fed1mr56024075ab.8.1718889591280; 
 Thu, 20 Jun 2024 06:19:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d866e260sm31807865ab.7.2024.06.20.06.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:19:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/5] Dockerfile: Add python3-coverage
Date: Thu, 20 Jun 2024 07:19:33 -0600
Message-Id: <20240620131937.1130446-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620131937.1130446-1-sjg@chromium.org>
References: <20240620131937.1130446-1-sjg@chromium.org>
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
---

 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index cda87354566..0941b0f6952 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -97,6 +97,7 @@ RUN apt-get update && apt-get install -y \
 	python-is-python3 \
 	python2.7 \
 	python3 \
+	python3-coverage \
 	python3-dev \
 	python3-pip \
 	python3-pyelftools \
-- 
2.34.1


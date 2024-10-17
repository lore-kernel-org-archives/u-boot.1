Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D2D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707DF89275;
	Fri, 18 Oct 2024 01:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AnfntUy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A497891E5; Fri, 18 Oct 2024 01:25:06 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8848921E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a39f73a2c7so7135655ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207502; x=1729812302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2A5oKK1EJD4rFIlUfshnMHcd3WYtyh0Sw7pTiyO8ko=;
 b=AnfntUy02q//by6yHaB+74wVBRKkESG8kPajvXB+TPQG0ZxByKfCjY/aSUbluTwAwq
 o7ovAtIydgM3KYBv/fe5Z3+k5x+o5M9uk8Zo7AQOVzdWeoNp7vN0gMY9k1nIT7AAEuyk
 xVIU9uHxALFtIrqGaOet34JxFchNGYd5lYOUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207502; x=1729812302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2A5oKK1EJD4rFIlUfshnMHcd3WYtyh0Sw7pTiyO8ko=;
 b=ifZjlpwyxqzxaZfeBw9Pb2RPyx3Mp3TBtrkauJLCAOqOSaK/3YiwLP11lDOsgP5r73
 VUM+2X74Dtc5Y3eGlBn9tm4M28XlpSNyEL65V5yn1B1nSSh5pbC1YWfNputq0JuMwPPA
 ofjzCEQOi1/lTCqb56xc2EqGVShyWcLKr3c+tmS5SVTPRzKFV6LX90UdWilx+1V73tN5
 hcC23i2LXQsSSRAW57S2y72YlfOS1RXVXIh5DfLCIptAiOmdwKkBYWoDFpAsWmwIIn90
 3+Xw95pp6Ek3RZQrlGq6qYOLI2pqPy4SWMqa8gQZNHN3B8lKGKpwXZbvMefk+JOxrUD/
 LmCw==
X-Gm-Message-State: AOJu0YxqnZZv5pQ4zuMvdSC+BFMOsPAgnSKx5pjIKh3QKcfnN+KUQ4GE
 NN/UWj2XzPSh3bYjHNGSGYCJe/Cpfmtb/AU1ARNB55ca/rJWLjjUgnAomHaKhr6RrmR+8n02nu4
 =
X-Google-Smtp-Source: AGHT+IHKc7NHGrznFGKyquPdg0V+npSKVFVE3aCiHskuTnAdA5RXDX2N4OZ6mGjLoZNMQ3sDctT7cA==
X-Received: by 2002:a05:6e02:20ce:b0:3a3:5fad:77b4 with SMTP id
 e9e14a558f8ab-3a3f405022fmr5624015ab.3.1729207502384; 
 Thu, 17 Oct 2024 16:25:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 22/34] bootstd: cros: Correct the x86-setup address
Date: Thu, 17 Oct 2024 17:24:01 -0600
Message-Id: <20241017232413.724808-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

This should really use an address rather than the buffer. Update it in
the command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 5f656814b29..3e9769e0d42 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -403,7 +403,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		puts("(none)");
 	putc('\n');
 	if (bflow->x86_setup)
-		printf("X86 setup: %p\n", bflow->x86_setup);
+		printf("X86 setup: %lx\n",
+		       (ulong)map_to_sysmem(bflow->x86_setup));
 	printf("Logo:      %s\n", bflow->logo ?
 	       simple_xtoa((ulong)map_to_sysmem(bflow->logo)) : "(none)");
 	if (bflow->logo) {
-- 
2.34.1


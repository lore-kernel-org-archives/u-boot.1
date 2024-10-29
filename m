Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90503D3A692
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD7E8919B;
	Tue, 29 Oct 2024 20:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TpEwAvO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED48E89197; Tue, 29 Oct 2024 20:22:33 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A40D89191
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cb15b84544so7359687a12.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229751; x=1730834551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ajO0kE4L7pLjYAYTWLV7R8mXk5S+6K44+EJo4R+uIc=;
 b=TpEwAvO47m9y363VySZIkMZueM42BMpRX5o0+pGLC8QSHhZgu07mwPzR5vuF1oAatF
 FNx/Hl4lu1NvOt5yBQd9TVlhDtBVRIumF4pDCS41yQMnKnHScb4kTwS7jjlzS3Qx5VXP
 4g8z1nESNvq8UflwIwKj0nTo4z3CIlP+LYCus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229751; x=1730834551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ajO0kE4L7pLjYAYTWLV7R8mXk5S+6K44+EJo4R+uIc=;
 b=oJC5g1kL22QBcioZ0kGHPFJ7AWdRvlDP393FCsuJugqX474WIJh78wF0AhJecz1G2n
 qKYGTKp2FZvSyilhNSZrrMrefz9IErXr6ezCrE81cY+9nRr22YTqwxJA9AcqW5PyHgv4
 V+2vseBpnTHHgr1odEtVOnFn31CjGRF+izer6d/NQes+phZkC6YANFgYCNCRqUNL+h4v
 z90NYFvy0LGUM97Lpv5lpfPB5JEfQiGogGAFUriqJjTYSRyJ0c8UgASm9ngbjpaNKZL5
 9eQjRcdN1t7cGKNS4wgWuxlucvOv+OOvFZtOFJN0sG+BSq2jbAwWgUe9wJzjiq3NEq3u
 mAVA==
X-Gm-Message-State: AOJu0YzxW1rYBgK4FwJFDFhRia//1VpDUUvvswOAyYIMr1RFsiy9foLG
 rJOweBOjtBNpccfllDkbGH1rjXclFCZqoGqoffE3ogl2UIOv2wQfWSAdPnnIwxX2bh3nzPGTn+O
 e1Hth
X-Google-Smtp-Source: AGHT+IHzLUrc1JpcrXs9DNvlXG5WoD88sqMCSVSu7SlWrSX36Z7DTlTy0aj0Ip9izmeIJ70nDOCFCQ==
X-Received: by 2002:a05:6402:3584:b0:5cb:6709:3cd7 with SMTP id
 4fb4d7f45d1cf-5cbbf872064mr8633863a12.4.1730229750935; 
 Tue, 29 Oct 2024 12:22:30 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v9 01/11] test: boot: Update bootflow_iter() for console
 checking
Date: Tue, 29 Oct 2024 20:22:09 +0100
Message-ID: <20241029192222.362445-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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

This test checks console output so should have the UTF_CONSOLE flag. Add
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 0d4e966892e..841729bd1ac 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
-- 
2.43.0


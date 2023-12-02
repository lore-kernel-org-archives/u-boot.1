Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591BCC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 15:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBAF8765B;
	Sat,  2 Dec 2023 16:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BDYFmDqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67427876B2; Sat,  2 Dec 2023 16:34:34 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CA98763D
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 16:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7b3b78e6729so143280739f.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701531271; x=1702136071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAlTImgRSMNNWC579DUnRVywUq3hqABA0yjS1Q3jE60=;
 b=BDYFmDqzjF31bpSl/HLB8TU3cfcrhTfETek5+bpbZEVHcRWVacOgEZOf6XhdGr8npC
 DVPig1u+nz36yhJePTSo7nTRw1Eik1GVw3z0HP8WPzhEScG6bKqV1+owk+gDpBN0PQb6
 34IB6jVtZ7O8s6Whk0iGyJJ8Zz+TzZ9f4oeRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701531271; x=1702136071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAlTImgRSMNNWC579DUnRVywUq3hqABA0yjS1Q3jE60=;
 b=sOGzil8RVQc9UGzjkvL5y0lhiwHV1u6QBEJnZsiTGnbYCbKVDLgKLbrIL9Vx/n4Jdb
 htDP+YJdv4h9N7rlUQJdLuf1iCGMWA+xrId/crzJWxHRY/KIAGzQFkNLASM7f4f/0zbn
 MiHmswbWDfBqyrDQ2N/pIuQTH92WhIANCDcMFWgn3/ziNjFqum2m6jxsz2rGbB6iKbbW
 MnmZpXyDJ2ArXRzqxRxNT5HStbgtFZsaqHzmPIUcAmNZ+uUPQO1P8xuOzDm2t38qIAg8
 azGXcziTAbRoXltqrCe9bVEcGJunKLyCEXrGzuKDmPkvcui6YI6cD9FtyRFOry39qv8/
 olXw==
X-Gm-Message-State: AOJu0YzbDIX1mEFVoljuhwmyA0Wun86+vqI0LKvFuSOQ1Ozddb9hctl+
 JDABsIYl8ODOT0VQE8a3J5jJ9pRF+oKhJpL8jAYWMA==
X-Google-Smtp-Source: AGHT+IH3QhIEmhqw3njEngaO4iDlkMrvCClp6l9MdNWk9PLrQs1EntYx2UYvKhzrau2UwvweBpC+gQ==
X-Received: by 2002:a05:6e02:1d81:b0:35d:4890:8eea with SMTP id
 h1-20020a056e021d8100b0035d48908eeamr2231561ila.6.1701531270909; 
 Sat, 02 Dec 2023 07:34:30 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d30500b001cf8546335fsm2869217plc.5.2023.12.02.07.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 07:34:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/5] sandbox: Drop video-sync in serial driver
Date: Sat,  2 Dec 2023 08:33:52 -0700
Message-ID: <20231202153400.537050-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202153400.537050-1-sjg@chromium.org>
References: <20231202153400.537050-1-sjg@chromium.org>
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

With sandbox, when U-Boot is waiting for input it syncs the video
display, since presumably the user has finished typing.

Now that cyclic is used for video syncing, we can drop this. Cyclic
will automatically call the video_idle() function when idle.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix 'groth' and 'work-around' typos in cover letter

 drivers/serial/sandbox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index f6ac3d228526..be72fd2c65f7 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -139,8 +139,6 @@ static int sandbox_serial_pending(struct udevice *dev, bool input)
 		return 0;
 
 	os_usleep(100);
-	if (IS_ENABLED(CONFIG_VIDEO) && !IS_ENABLED(CONFIG_SPL_BUILD))
-		video_sync_all();
 	avail = membuff_putraw(&priv->buf, 100, false, &data);
 	if (!avail)
 		return 1;	/* buffer full */
-- 
2.43.0.rc2.451.g8631bc7472-goog


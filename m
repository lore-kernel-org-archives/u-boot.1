Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2D7CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53042831C2;
	Tue, 26 Aug 2025 00:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzkyHAL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9108830A0; Tue, 26 Aug 2025 00:34:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93321830B4
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b55ed86b9so16067905e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161279; x=1756766079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrqks5cuodBwWrzZ3QYVXeUoHwmJ3h/7re/PCMABahc=;
 b=dzkyHAL1Cw0x0AtXL+tVTDEqBf7pJTcQhEape9P8VM03VuTMuVFl9JIPStOVide51l
 PbkACSt5Bez2peo4EXrONLGAesUTyJcxckG9RW0Fmlk5LC1YYeqPDE4BNPsSNZYOWhTA
 Bh03/yIJh3VZN1A5cvEgQo8FSerhtW4DQM3X3KAu2lhtrvr9UWl8QPPrWFJOegoX8XHd
 20CarVn1vkRHWhsOhc63ChDRs5hFk/fpXGlRnbnOEqidp5i5rqwcqKbMF3tSMxt+RUBy
 qAjrS0GcQ4wBDgRYMss+T8tfCv42fPHdtsNSv48aOrUn2FvDh5LgQIbytnkwWHoav9tC
 NEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161279; x=1756766079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrqks5cuodBwWrzZ3QYVXeUoHwmJ3h/7re/PCMABahc=;
 b=lFgHORxReDgz0BQWimGjFMSfGDYJupsud+v/ZxBw+anEwDYq1TbfK0Xor4/CvbvOYD
 6KU/PezFbwesc+Wz7bu7ooGlJEn4EEgb+PN1al4d46F2MCrDr23pG0wotDinx2gQmB20
 u0PmTzA0w8Ga17ByIcRjZgpNetWV6jXfg1MkbIUZv3brS8LQXbLzLPcyYxsirD+5I+/Q
 K93Jyusvu4auTrf/Ue17a2zamqMjx1kn3h0R/P7ika/hif5UjTUhLnJBBTy1rCUbHShd
 faXFZCSDQmc7puPABe2VwmqoU7ZkqXCjksGQmrdrwV9u5YPRjep5+MkjhJg+BNFLY1Zw
 462A==
X-Gm-Message-State: AOJu0YzEqag5DssqAp+o4gFOSCgF2HlamgOtTl2i7Vic3b2R3mZhETad
 YtvcvVRgReFI8SA3F/4W5bgrOLqoGh8an8hY2F3qj4BmEo9S+PS+PxVQ8pZcWHmwX9s=
X-Gm-Gg: ASbGncuqnHTp3uqtXd3tR1Ba21GMokpwSMHnI9fClPmG/45GSvXTpItlzEoLCngD62t
 wM+79l9dbq5jxZo+S8Lk1h+liEy7tJDBco3RBLpZ+BBszHE53fpKWaCLq5kmAmIT8zmfNC3WeNB
 co4FW1pfmOIRVKgsooWUot6wQD8bdrlHdfMdqw62jraSwTLvm/UGrbNFPXyVSMqRoxptRAVh9zn
 je7mNUnxZlgQ3U6zEfLCmXb29dfI1lmTckTPB000CEh0W/DTc0EjipTpbqi+xxytPFhWaJrBBM4
 q+R9rKGG4TCrIT7lFk/pmzH27e3uBpMUm0mIo1gVfHDpp26kwiA70d+bbtGRVXWlA+uTiEA8Tu2
 uRj6a2H7opfm4ubxocM3et6UMzEFqBUXzxMUQLrE=
X-Google-Smtp-Source: AGHT+IH8xOqE7wZujLhQcGSrwkdPeTFTRjybirr8RCy1/Qy8srmkeI6jM7rn4PqF6lnGUWH2Mg0x/g==
X-Received: by 2002:a05:600c:4451:b0:456:fdd:6030 with SMTP id
 5b1f17b1804b1-45b517cfeacmr115627925e9.19.1756161278718; 
 Mon, 25 Aug 2025 15:34:38 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:38 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 10/10] doc: Use a em-dash instead
Date: Mon, 25 Aug 2025 23:32:37 +0100
Message-ID: <20250825223251.674591-11-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In the browser, a single dash looks sloppy.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index dee95847175..f6112c7f88c 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1373,7 +1373,7 @@ Using boards.cfg
 This file is no-longer needed by Buildman but it is still generated in the
 working directory. This helps avoid a delay on every build, since scanning all
 the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag to force
-regeneration of the file - in that case Buildman exits after writing the file
+regeneration of the file — in that case Buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.
 
-- 
2.48.1


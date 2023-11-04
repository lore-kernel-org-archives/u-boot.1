Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3E9C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643EE86F63;
	Sat,  4 Nov 2023 17:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XHrltmjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2513887116; Sat,  4 Nov 2023 17:25:44 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F54870C7
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 17:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so124035039f.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699115135; x=1699719935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdLQeaquFN2tPTpV+3ME1D5CN7YUFaJKOmoc6l9Dp9w=;
 b=XHrltmjKt+ozmXOATXcS8nYZHlWL9V//UcvdOYdwb5x7doEHvk0z6KMJUMFwo5+nzB
 pvEix17tvPVQFAUIfBbLSmKbPt9oVIjnlPSoCzdOl69/OoxY8l6tUKj6EUJVOzZDbZKp
 /yFETiiSIHybw87uOaGzg4HV4XRMaRRUCE+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699115135; x=1699719935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdLQeaquFN2tPTpV+3ME1D5CN7YUFaJKOmoc6l9Dp9w=;
 b=D3Ru/pQ4GsZ90zBJxno2Q1xLWpWPjFkJB4qn4sqMDA35PtjRr4e37PePTitH+6blaP
 yP04wBE3QY0HsBGRzbCZ+Qtz5ilDj0w+QpBEflY+6QdoBUWb/cwVL4R0mdz/PbmensiN
 nEeu8kC1vJyQn2jNsryAd1v1QZjHz+CbEWZKVk4tMNk2/AFNHF8zT1cn0fq76C/brBmP
 2ks8LgfsOgGqvUppvexQk6OOjTLRBahh683Bhlk+cKdMZznTtBOgoDFO//HZkaZD7Q4v
 ZaU4au7KJx2suyrC9o0VoMkzdNgD/gZciS9RW5lMTdOhF3tXnadHFEX3HYYJCWnjXGVK
 Cn7w==
X-Gm-Message-State: AOJu0YyN0Vsn53JG+zVyk2bQpKG2CUPyqjzUVncmkqyZN/t/ZWEimEtd
 FVMamwNZBLs79heD+YyuYuzQRh8nF+5fmaj8eB0xJQ==
X-Google-Smtp-Source: AGHT+IF+tOaD9nzWuWkm9acu8fz5o7E0Mj8JgYPr+YQDu3pR59vflDKvSEGUe+r9fF4H8Ou0ciGEoA==
X-Received: by 2002:a05:6602:3fc3:b0:794:eaef:f43e with SMTP id
 fc3-20020a0566023fc300b00794eaeff43emr34061562iob.1.1699115135287; 
 Sat, 04 Nov 2023 09:25:35 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a028784000000b0042bb296863asm1119013jai.56.2023.11.04.09.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 09:25:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/5] patman: Avoid using func_test at top level
Date: Sat,  4 Nov 2023 10:25:23 -0600
Message-ID: <20231104162527.1736401-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104162527.1736401-1-sjg@chromium.org>
References: <20231104162527.1736401-1-sjg@chromium.org>
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

Import this only when it is needed, since it is not present when
installed via 'pip install'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/u-boot/-/issues/26
---

 tools/patman/__main__.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 3ca858cd3157..d53f686a2d45 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -24,7 +24,6 @@ sys.path.append(os.path.join(our_path, '..'))
 # Our modules
 from patman import cmdline
 from patman import control
-from patman import func_test
 from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
-- 
2.42.0.869.gea05f2083d-goog


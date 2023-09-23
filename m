Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E25CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F111B86B70;
	Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V676cx+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6566686B74; Sat, 23 Sep 2023 21:44:46 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC45486B3C
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so12018485ab.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498281; x=1696103081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VammdYrXLZ6Ir2JQmINbsQFPB0Cvoj6/JLXkoaV6lfQ=;
 b=V676cx+W/YmabuHUIB6rsHq5UqQsQ1CfX7hs7TFQWzCIb7b3Qa+NEg2a0uNKWXZ5DJ
 4puZ5zbE8EJmh74uK7DaAaw0/JMqibKhbNkrJmMJ1yuKY9G1OHS1eAvFNm7xfT4rnRUE
 k1tbgZlNHLdbZnLl9HbW4zm9w3ZrAj8nAdC/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498281; x=1696103081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VammdYrXLZ6Ir2JQmINbsQFPB0Cvoj6/JLXkoaV6lfQ=;
 b=r3d92icVrec/KqulvJEYdTFwswZ7dd8Tlh2ZVMk3zhec3yoqv6HrFHKrvTqGVFhRF3
 RySR1ddnLtfUYBzkdwzeho3GeEiuIEwK4jiOU4QVUoZ6/nZftFzJ01bUTg2phi43Sfb7
 ohjaIhdhSc0oWppF5YbBcQDM8MwdLdUbB3pVJ4f+9qcmSD5nYeISm/BYrysn6XEgV0CT
 G/AarrbAqC0RyJN0o1ro3RyCWobFj4RByftj4JuJUaXdUBu9hkKbQECm1IMGKTJkxHUZ
 5QhVI0oc7prFbTcKh4Po4nCUSkuAE+fgFIW0xqPMbrYXoXb5rKEAvCxNOtikfwfz3qS4
 aPTg==
X-Gm-Message-State: AOJu0YxcpALokX/DYbX5d7TmaYJdHrB3wQADvLIVY4LJL1Rc9rylkzXQ
 pPxd/lB8uT1frTByZ6oZVUSTxaAvNNt7JTlLQP8=
X-Google-Smtp-Source: AGHT+IEuix12PH2VLrnMpWZ90V57UlYSu59w0yBjWCKKTmgDRTtNeTm6ar91HxR0YvAJReSWio8NLA==
X-Received: by 2002:a05:6e02:ec5:b0:351:c42:f6a0 with SMTP id
 i5-20020a056e020ec500b003510c42f6a0mr2852337ilk.20.1695498281484; 
 Sat, 23 Sep 2023 12:44:41 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 13/27] moveconfig: Correct use of members not declared in
 __init__()
Date: Sat, 23 Sep 2023 13:44:02 -0600
Message-ID: <20230923194424.1739224-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Fix these pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 2234f28a7724..1dff89159312 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -410,6 +410,10 @@ class Slot:
         self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
+        self.defconfig = None
+        self.log = ''
+        self.current_src_dir = None
+        self.proc = None
 
     def __del__(self):
         """Delete the working directory
-- 
2.42.0.515.g380fc7ccd1-goog


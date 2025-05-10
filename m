Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC7EC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA01682A46;
	Sat, 10 May 2025 13:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SGUueuNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D619B82A1C; Sat, 10 May 2025 13:06:02 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77800828BC
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad241baf856so18295466b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875155; x=1747479955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQKC4L5Na4vwPGCQfrWt7S7akBeyCAtQ1RjjOCnhGiA=;
 b=SGUueuNCbyY8UHe/E11TutvFJgNcZGXms4Hmr5SaP0FPagklJb4CvxCC15XRpbblN5
 c9mYOg8DmZn2fcMq0PArtF2f916Q1hfVbtJPYnBx4I8EUQysGdUMeMa6Xq9bDLoUlQ7N
 DapOv4cjwjPG/oYXP4gOTEJT5sd+7mSVWCyr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875155; x=1747479955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQKC4L5Na4vwPGCQfrWt7S7akBeyCAtQ1RjjOCnhGiA=;
 b=JtXXmC6c06LLqLfa6fXfZemDAvWmvKHVoXpjCF6YoBDPFMSoDd/qJ/mFxFGM3QcMQE
 IzxA/L0GqhtTydcR1kNKcJ4/gWVdSPV40i3fH4881RE5dQbatu6slxQFFhsgt7II6fQY
 UZWWfxsPh3eX0hnfMk/5BYWnE+4F4RqzFftALKZXYavsieYLQrJXX+JKz1SRbW41LJPn
 X0RJsfrIuH0Q3b2/lFIG8ERz+f/cMWDaRNODS8v/24/SJTqLWz9LDWThgwSNkIFpFQEe
 d8La7yRoEi4vs1vYcZaCjfNaWxe4RXUJ7n5E0Tk54MZTHKLX9kZV+VQ9fuKBkziX8dkA
 W2FA==
X-Gm-Message-State: AOJu0Yzhq6us55q3szIik9VYgwiXLLrZzJXXKUfeceXrbyxRYC4pYvTD
 B2h/gqVFzMI0sXBR4vZDZzoK9ZYzkNWaoHTAbdd8KS7xXJQ8caRJJaUdfUU2PEndw2i47D7ZNSJ
 DS9MT9DDrOg==
X-Gm-Gg: ASbGncuQMCIQO8lSCXvz2PJydXOBjwInJ0Czo+KAIFBgAyiQWl6lEYuJtSFCPMEk72S
 mMJk8ebNThgoIy1vM1JnAm6lIcB+wKQi6PBTpBaDSTwEBTYENoPXOS6U9Y0SlZG+K7rOIYrMKM0
 7csDO+mfQpzp3gV72k/EfT3CaHPNBLAPA9v3iW2Znr4cDvs7KBiwmogyN9XvkcjSO3KSlIBGnjN
 ERDjkSrG6HGcfDJVIdlvuqDGpxIvxMhmwYOORMp6NTckfP8X15SinfWsf+Lwtd4E+uV+/HKyouT
 D39tRwm5E9emW3jEt3krVD1ta0qMRh6YrS2dq5ofyJhfKh0=
X-Google-Smtp-Source: AGHT+IEpy6HpK69yfncdzPDaxNKaZDdF91tWDWJmoUfR+QDqWsd29bId4X7USFVaytL4qs8MCgohpQ==
X-Received: by 2002:a17:907:3f25:b0:ac7:334d:3217 with SMTP id
 a640c23a62f3a-ad1fcb7e51dmr1109726566b.12.1746875155415; 
 Sat, 10 May 2025 04:05:55 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/25] patman: Use python3 with /usr/bin/env
Date: Sat, 10 May 2025 13:04:57 +0200
Message-ID: <20250510110535.1453745-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

If python2 is available then we must specify python3 here. Update the
test to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 00aed8786e8..da81101ea93 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -637,7 +637,7 @@ complicated as possible''')
                              'check_patch: False\n'
                              'add_maintainers: True\n', binary=False)
             tools.write_file('dummy-script.sh',
-                             '#!/usr/bin/env python\n'
+                             '#!/usr/bin/env python3\n'
                              'print("hello@there.com")\n', binary=False)
             os.chmod('dummy-script.sh', 0x555)
             tools.run('git', 'add', '.')
-- 
2.43.0


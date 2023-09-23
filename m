Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC841CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0DF86B79;
	Sat, 23 Sep 2023 21:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mKFalQWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F91C86B89; Sat, 23 Sep 2023 21:44:54 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321AA86B68
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79f9bad1a44so94221939f.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498288; x=1696103088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHzceu5N/PZnTDDkKCz1uu6q5p0n+A9NM7no+uv2zCA=;
 b=mKFalQWEL9J0AUFftIv6c7c4AMQtDlDe150vkEy2bPbeUS1QjBBBqiZrrDeP+JQYr1
 6q9fGs9AXsbAC6a8YNYfmVRSq9XnBXA1vxVa7TMaLbSRkM2N+ODKfjLcWGvFTkLHXoI6
 /nsSXZjOXwhx3MTJXHkF64DI4AzD/otuoz4Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498288; x=1696103088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHzceu5N/PZnTDDkKCz1uu6q5p0n+A9NM7no+uv2zCA=;
 b=CubrSTNfOKMd59gFdQiAel6QmW5ljNd4JWzZ89D6Az1YyVC0mM5B1CDLk/EeMcAIWV
 iuZ09KblXZHK2g9dYH4/fW9mfKIislNPsflaFxJTExr3IQV4958leWseuUdeuOfN/NTl
 DVVn/hiX7HinIaRqYPalfkLMTfRs1BGzTvifhXUdDN1z3kJbkLlYOTsPpewL9sD2XpGp
 mCdZfpaQeBxNErDTMmLcwk2pVXgALUIFDUCYMdbyERCGxIkKhiiYIJQul22l9d+N102I
 Ph+JT8tJH26+hWxxOPY4P+zq6QXCkDzDJgMi9DLwqcF2pASgGYdLfclxcY+3VvQjNe5/
 JP3g==
X-Gm-Message-State: AOJu0YxRf39iQWza/x9Ea0PJP0iEPK7oUjt+U8DwYlCWCe/2CG3I4L9F
 a4wE+Hbsg3HfYguN5hNy10f9Yo/mfnIltaEFzyo=
X-Google-Smtp-Source: AGHT+IGC9k9ZcOLVJIBC1aEweiAlbNwZlAqg8kOsEouV6hQ7a8hD3evm8Oi+pm4TeYScR2dRomO0Xw==
X-Received: by 2002:a05:6602:1ca:b0:79f:9b45:3365 with SMTP id
 w10-20020a05660201ca00b0079f9b453365mr2805605iot.17.1695498288276; 
 Sat, 23 Sep 2023 12:44:48 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/27] moveconfig: Avoid showing progress at the end
Date: Sat, 23 Sep 2023 13:44:08 -0600
Message-ID: <20230923194424.1739224-20-sjg@chromium.org>
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

When the process is finished, moveconfig leaves a line saying that all
boards were processed (for better or worse). Drop this, since it is
unncessary.

Future work will provide a summary at the end instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 9d228720c739..0131034a3787 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -282,7 +282,8 @@ class Progress:
 
     def show(self):
         """Display the progress."""
-        print(f' {self.current} defconfigs out of {self.total}\r', end=' ')
+        if self.current != self.total:
+            print(f' {self.current} defconfigs out of {self.total}\r', end=' ')
         sys.stdout.flush()
 
 
-- 
2.42.0.515.g380fc7ccd1-goog


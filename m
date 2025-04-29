Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B39C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9575482935;
	Tue, 29 Apr 2025 15:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="itpH20Na";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56A7828A2; Tue, 29 Apr 2025 15:24:08 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8076B8215E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72bc3987a05so3427444a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933045; x=1746537845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VKR1RgmzuZI2D29FSveKpt6lQNW/1cGuSob7qHt3Ok=;
 b=itpH20Na8pOd2CmcPiUCdMGWc1tmIWQ/QOlYZdxToyJyUj67gfjH9Bd5wCak11Ys87
 7OTmSFkA2zX7314I136yWTxxFfft/eDJFctrsD4xzKyHVRKPncoNLfbYE+el7d5ELOAq
 eu3odyguElC+W6szTqTTPqKAibgfOvq7ds7eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933045; x=1746537845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VKR1RgmzuZI2D29FSveKpt6lQNW/1cGuSob7qHt3Ok=;
 b=cZ6XTkUnGehBcgkoLgysVxsHT9sXV6sAB5FGYuz2+vRmI67vINTjiV1z1Prp3/g3HW
 XZB//XzyPSXyUZz7aOb9E+UQxfhAZQq6nfgC40muUpG/E1q44ZnWU1xIBYVQFGh4lurJ
 tcmUG4kANS0mNlLagycBANaYgTixxAH6GDL0APtMtc/g5rQBgsuHF57W4orWlds0IHEf
 uG0AQw9keAGQeoZNZoLxsAIn65ftzhFcTKjvNfK7aMbajRiI7Rqk3FS5aP90KfeVGofb
 JRSZQkpMi0IZNb1fbkriYWP7TcOQbHGFp1ijvmjC3rTIdNMKKNlAskJZdM+XqoEu4Wiz
 zspA==
X-Gm-Message-State: AOJu0YwTvD+NLaRxwlGELtggV9K9RADrJ0L9lM9ydk57rUAy+xuhbxIz
 3yt+oF7VmDaoeOYW9j8tZ30vWWMHhQ5NGu8kuReGs5Jd/1ixwWGj7mELnCsaItHrMboluLiflto
 =
X-Gm-Gg: ASbGnct81H57ggYg5VH9/9a3peszin77vjBw4NoX28TQ7KoYuV1ZhK45NFt73Yh8q0D
 K1PhMS9Jl1I+3eMXuV3EbGZy8ldlwqKXm0x8+QfT74BzH6Y6MTBM0ia8hfmdqHQK3bfyMZ79xL9
 nOxqXK6Ipo1NG6lI0tIG9gJZs6V7Z8lMqn9Frm8XP74QdDdhYJdPHmbEW3ZO990sUu/xcR/EzsO
 TY7dLm5Xuaj/6HU4zTRH8/mi/gJaLoxglNuR9bD1QY0msZIB4MgamYcbIvI6TSJ4Pv/8VRfpisb
 n6YTQA7Vh7I7wWrCFC2dLDCSELMsQy1f22BZ065cKt4p4RTAK9D4n4TlWDa3M2G5GZ4qSSOXreL
 zsA==
X-Google-Smtp-Source: AGHT+IEy3K65oqdt9t2ojmUMi++QMFNXr6I/0OG6gDbtZI90+/l5zQt8gl/oJCZ0oWuaBafiglGd2A==
X-Received: by 2002:a05:6830:2a8a:b0:72a:b78:1c5a with SMTP id
 46e09a7af769-73089916ecdmr1975385a34.10.1745933044720; 
 Tue, 29 Apr 2025 06:24:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/30] patman: Correct a stray quote
Date: Tue, 29 Apr 2025 07:22:07 -0600
Message-ID: <20250429132239.251756-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

A quote character was added a few years ago, but was not intended. Drop
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index a31c950051b..161b5ad4288 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -152,7 +152,7 @@ class TestFunctional(unittest.TestCase):
             Commit-changes: 2
             - Changes only for this commit
 
-'            Cover-changes: 4
+            Cover-changes: 4
             - Some notes for the cover letter
 
             Cover-letter:
-- 
2.43.0


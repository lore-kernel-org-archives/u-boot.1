Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C67E8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAE984563;
	Tue,  3 Feb 2026 16:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s2z73HEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D249845A3; Tue,  3 Feb 2026 16:13:14 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0359C84548
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 16:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d18d9503eeso4256589a34.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 07:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770131585; x=1770736385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8KOONkl9ZRu8F5z+rn/DgGM7+ATca7gsYhfpN+Rs/T0=;
 b=s2z73HEGsXY2T5E+NXQwQ4Jifx6Ym8gnCrFEDvnWUW+X8xAb6r3vWYndN5GMMSCYAr
 Cj2riJTX7R5VxSvioKkGxWiIFS4lGSGsp8SZOYdUpEh4DGHgI/W4fZADUPG4GEZ6bjLn
 HfOD2gS47xzIPNQSltZ5gHqcTfhzqhZrk/u/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131585; x=1770736385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KOONkl9ZRu8F5z+rn/DgGM7+ATca7gsYhfpN+Rs/T0=;
 b=a+uusF0rQW3/PpMY3PSZhyeyohH4T98hm/Rs7N1//EKSQHElZpUUG0zUjtC0sJNNYE
 szMJfN/kJW47tGAfohy8ZTRFiq2EGgYcpl/RZHtNnt1YQyB52IkqWhddFrDtBUQ3uzpq
 ctvERAV59S7CbMxxsnueEdOeur++DUuDtsDqpFjsnI3bHy3DcEEKZvOY7Y5/0ABJwenN
 Y+OWvUKZcp8NfC6IXcW83Ta1XxgLH7K2ycx35uI8IcU9BpYi6qLCoDtsjBjOBVDzwIwK
 FW6ybZb3GHAZY45OWxHfZvjU17z9Y05tz+tsBMnUJsYe5QD13n5iuPvsOLoca+KL0ey/
 dPCQ==
X-Gm-Message-State: AOJu0YyHG+SZZ7SlQkYD2nDuC0JaV7E1WeM6UkXdxvfzt5uOSFG7YP0u
 X/ILcK1h8lVUAUAefzdH0R9V5nhyppzpKWr5z7x0LSrJlOY+wk/mD610nN80jpk3zQhEa3qzpUs
 R8Q7IPso=
X-Gm-Gg: AZuq6aJka25pDC9L/T1NMrpJBYgvGYQvNUoB7+9+QchgFsLBPHjUi2hwg8lz+Pl3ll8
 5TJbwip+K54shR3+rGi/Lq7JnQCVLUGOuUfRhDlRHSXQ+A1Cilly0jA++RfhRESstVlwVAqFXEo
 djm2Wpk3hwnYBiY8Dolgt51d2u85rj+9Q4n4nrvfqpnlPWV2EqxbtaanpHKAIRBZglQne6xnMVM
 WjRmvvdCiFDTLJEeYCKNJJC4CRupHNzfoHuPNrGJ2eK/fVokydbSS2SIiF5MMwZAm4Tvf7DP7+9
 Z/jQwW6RbZTxVyCpJc3B8FYdIjaMAHDmvx8CM6I69pnjqHpgu1jsq5rPwbDUE+jcNzhBWavb1cA
 pZZ+oYxgM3/8H3lQVJWdh5iqg9W5GfLohH3WaEigghnewStqaFrt9Xt4Br+i2AsrOm0+q+fsFcB
 MO177WEF5DB6OvsgYV5Xd6CFKXYjYC6TNWJBKFWypcoIerTr14h2ZdXGufLSd/SEHPLLbmvMjzB
 GkK/r32km18wDWXXEkEvLzz18pxsOZRQz2AjYm3S4ESWn971HTb
X-Received: by 2002:a05:6830:6d0e:b0:7c7:2c63:f2d6 with SMTP id
 46e09a7af769-7d1a52974d1mr9694133a34.11.1770131585478; 
 Tue, 03 Feb 2026 07:13:05 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c7ffcc7sm12596665a34.23.2026.02.03.07.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 07:13:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Remove pip from requirements.txt
Date: Tue,  3 Feb 2026 09:13:03 -0600
Message-ID: <20260203151303.1418027-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Our documentation does not require the pip package to build, so it
should not be listed in our requirements.txt file here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>

I noticed this because GitHub dependabot filed an issue on pip, but we
don't need it. We've diverged a lot from the kernel in terms of how we
handle docs (And this is fine), but I think our requirements.txt file
needs a closer look.
---
 doc/sphinx/requirements.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index e313e4f09468..c616c75fefc1 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -8,7 +8,6 @@ imagesize==1.4.1
 Jinja2==3.1.4
 MarkupSafe==3.0.2
 packaging==24.1
-pip==24.2
 Pygments==2.18.0
 requests==2.32.4
 six==1.16.0
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74015C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E71A8212F;
	Thu,  1 May 2025 03:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lXnNLxOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C084807B1; Thu,  1 May 2025 03:06:09 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59143826F3
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so1542845ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061565; x=1746666365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AONkFk15e3mWWkotOK4kZeX9poimPH2DQLiLHek5n5k=;
 b=lXnNLxOgYWC/KckyxtD3DNtJhiMzNnOEvEPwCF2UHeHlZQcJZ8fS7PQmAbv+qzEeWx
 n37OxEaBB2mR6YyWm2zOo+DvUSkdeH3owZw6OSajvqm9lj7JKkccutvZ/ooh+qasFvxv
 mKBRtLV22uZK/mcHZrTX+JUyqd+ksKZ3lFaR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061565; x=1746666365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AONkFk15e3mWWkotOK4kZeX9poimPH2DQLiLHek5n5k=;
 b=ie/Yg1jt1aAevGLHj1UQTnV5QUlnfnG2bE5OtJXqw88gHYQxd5WK1isJUP56MGGYrv
 aQGs26TcVo3xlnrTlzUlvOQFvGjjIgHS+LjstCyQw0neWAnWTcsGfjZRyqQSa0ztFCHK
 rZxqCccSeBYDhUzb4Zxdu+uqEvFtgE+/ja9ZqeP6TKoEg9adyLmt2+Lxmt9XdfvL3GQG
 MngjTmP8qKUHcZHFdcf172jOeWEpB7YAFzvbDdqcEgvKhM+Y5x8aAea0TUEuI/YAv+4F
 D3/49Amj0IaJG05HydoIJXs4oedNCLfpkUk5HmlJunoqEK5oJ1gDFndl67uh1PCmUlqc
 Zp5w==
X-Gm-Message-State: AOJu0Yy2yAllaX0UPTVwY6wCP/07aBiPSn849ec2kbFjDwoi3ys+3kfi
 YrkmNEVpSnOxvGAf39jLrDo8dwoZmIyXOWL+G9eI1XJKI9AmxwrNmhVT3k9LVgq+P2L5wmpTEhM
 =
X-Gm-Gg: ASbGncuJR0wxY9YDnWY3afMXos7erDqQGFGHav9v/FJ4xyd0OKFRh9ZJXl+2m2YKSiq
 3C+0kQYiht4uVTGr5m/Al8YyVrdGtOK64NI13QtqVcAU9FmCMnRx6Iyk+Nj5hHXUuG4IoctASnr
 v/WWVSIgE0f6ETFQTq/a7EJxYWfGwzjlW7Su+xI//As9NC2n0f09znTn29rZb5poIcW1c5VSwUp
 w91dMrBUI01e0/kdyVw8NpSM0Y8r0RjeswxfNDYwsXFzFT2wVaBRzt0cfghpjdZ4tBE4AvWO0Sl
 mMP9+e8Pl0wUCLVZFlUd1Fhi87FQYOdMS1f6z7fmM3wh4C/aF/vp3RmaDlLPGs11CfymF7OYnmY
 Thg==
X-Google-Smtp-Source: AGHT+IGZFLgYBzPTOmO9FD0AoZW0r++76NahO6onzwPvyt/msECyUjiL3KoWrZAv24HAVjB3xQBYgw==
X-Received: by 2002:a05:6e02:b4c:b0:3d6:d145:3006 with SMTP id
 e9e14a558f8ab-3d96f2529f9mr16398185ab.20.1746061565543; 
 Wed, 30 Apr 2025 18:06:05 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:06:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v2 18/22] net: Include byteorder in net6.h
Date: Wed, 30 Apr 2025 19:04:43 -0600
Message-ID: <20250501010456.3930701-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file uses byteorder but does not include the header file. Update
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/net6.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net6.h b/include/net6.h
index 1ed989e584a..2709fe9c4dc 100644
--- a/include/net6.h
+++ b/include/net6.h
@@ -11,6 +11,7 @@
 #define __NET6_H__
 
 #include <net.h>
+#include <asm/byteorder.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 
-- 
2.43.0


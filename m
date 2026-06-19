Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03AACD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 08:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225FB847C3;
	Fri, 19 Jun 2026 10:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PPQD7+7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D1A849AA; Fri, 19 Jun 2026 10:38:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16823846E1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 10:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490afc47455so7334695e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781858314; x=1782463114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=edNs+LLcJfsNAKWxRc38vPdq/2nK/HXOEC7okINGLs8=;
 b=PPQD7+7h32P4bDmv2Tw79kuMyBLmYt/fp1RStRpzRwIHJ2qnXrnV9c7z4c4zAObcTj
 ClENsJUcJpeqeqes3VjIGm09MyfCQPRc6iKd/5tavFlzJTOCQ30VlhRPycyKLqc9XBeU
 6CVwr8hxLREHYWMdCva0sk81rHktMBppFfyBTHOwe3tNMaDXyZ39I82GWTzZdLxjIn3C
 S5Hnf8PBSacadW8PzWHWBYsEFnaO9z0/7jTUhXtlLTG3DnjybzCtVtDt3BHLAXuDScTU
 hv0Zlvd2PWN3ew8T6ZF3RdPg2KlZUaPbQX9AIvFVWw1CKHmMNqeG0Bcidu2+L9NW+Hjj
 Gwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781858314; x=1782463114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edNs+LLcJfsNAKWxRc38vPdq/2nK/HXOEC7okINGLs8=;
 b=lziwUlk6Vl40Y2ObhPL8Y5tHeYIbhRt4hCz7hLrkaTF279dTJc6KXsufT5kS9FhSLE
 7ogcwZ6XrCVA0cuR0p6MATsWylxpkfp7RSZHhJDLzGcQdyRjC9Od6+smCIjhRMSamQeW
 HuEbT/1Ig62mZpz3VIdBQiTbpxRiQToVAzreKd9LmP/4ciJcm5SIC3PpHdH3qbuxEgMq
 OkOHyOK/yby+lP6ObXxW9f3hmJZOIvcCypVSRRGLXe59THS2rxkN7f8ijMwjLqEON1F1
 7c9EhztJk+iTiatFeGpmSCAOYxaRNEEImW5uNiLbS1u+7eqZ6NlEsRK3SPLBbDBW+oYO
 AiqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EalfqxpQHmaB9UvPiT0LBrnAi5AfZh3p+bGjsA/H10KP3JwqW1GEYb1fqAkEz/cV5TohSyLc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3xjsx24RTuOFrG0drFaYToz424bBk2oLpUN4g3W5sqKKmS6Ba
 oB62thSzmnKeW99DyCGL3ENVWNhhJnwxLC+QRJ0McAhi1lW2t1Hv/b/SLS89U7f+cPc=
X-Gm-Gg: AfdE7cmIU9Kw5SFcoueVKQAVxaCM6UDDl7379GlvIsR5XV8cBbpXzHAE4Z0F9IR9wmY
 dbehNif3aP9MT8+Q57TaO1od9mpNkjUyJJAuj5/tH0nFwUicI2XhGkgjKbGTRCf0amkXICGUnko
 khIn4a93z9LA1FGHS7JKWkVzgqGROY2fhZYAUUqZAzd4MC7c3oSaCJV5zS32IWy1tmqcYevo2op
 lDJm/DmlgMQDLnKMAAIDk5p6ODi/8M5WQHnthsgpazHOvgOGhQWC2yu+YdSW8mhxClFWmTs7Fyi
 tphZfXBz7hzUharauOVM6CbjuWOkshVrDLAtH1T9dFmEwPG/GT8VVVzcc0vfoifAloQYXJnGUdd
 nP9P+uD9SZSpJtcktHbs7R9Js+30RjPNBUQlPLk2XtZvsW3CcCsDtWr7Lk4blDrbju0fsFzI87c
 KlCT8VG0OgCyFhn4Is8hUpRRfdRpPTrIH+oqww97xHKDf2rHmthvOUIw+rhaPK1Ny6BwnOS15BP
 VADBdkWUYBRMyKTDgfg9ngeebuO29BCXb6aLjDc41vYLq+aaVix6nki5rsrmMJEz/Sg3LW+Z7uE
 +x86BbBQc0upuXOlFmrM6N1TZATjuCbRjlMSFFGuip8fe+vFI9e+DJPwdPhiSRTR1wBEPL2w0Uu
 k/wtVDm7O+9mbtf1t4YxgSnT+2/mPTIzdRX3bVmkmuSSScc79blY7YQZ+TOUcJdohBhq0ol6xNZ
 on8uUcEaS9bLJaEvkNr2l0FhZgUDH6EquAhgFpPnLss8HEiO+E8rmKv/ChIMjHDSV5B3nWhAWYG
 uvkovf2eGFkvOVhZA==
X-Received: by 2002:a05:600c:c4a7:b0:492:34f5:94cb with SMTP id
 5b1f17b1804b1-4923f584b83mr44766965e9.26.1781858314484; 
 Fri, 19 Jun 2026 01:38:34 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1f886sm48074975e9.4.2026.06.19.01.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 01:38:33 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: fix memory leak in efi_var_collect
Date: Fri, 19 Jun 2026 11:38:29 +0300
Message-ID: <20260619083830.128164-1-ilias.apalodimas@linaro.org>
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

Barebox has now ported some of the UEFI code. In the process
they found some bugs.

In this case when the variable buffer is too small, efi_var_collect()
returns EFI_BUFFER_TOO_SMALL but doesn't free the allocated 'buf'.

Fixes: 5f7dcf079de8c ("efi_loader: UEFI variable persistence")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_var_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index d63c2d1b1cd8..e51b21fe0b0d 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -446,8 +446,10 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 		efi_status_t ret;
 
 		if ((uintptr_t)buf + len <=
-		    (uintptr_t)var->name + old_var_name_length)
+		    (uintptr_t)var->name + old_var_name_length) {
+			free(buf);
 			return EFI_BUFFER_TOO_SMALL;
+		}
 
 		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
 		memcpy(var->name, old_var->name, old_var_name_length);
-- 
2.43.0


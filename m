Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3672DC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E9682F2B;
	Wed,  2 Jul 2025 12:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f8XQO7Nj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6480682103; Wed,  2 Jul 2025 12:01:40 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E5382E86
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso3547063f8f.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751450498; x=1752055298; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMR1oUA6TQGAR4iTFIw5ejdvQT0BUyM5ny8jOmkstL0=;
 b=f8XQO7NjgbdlE6XjoSk9y6fq/4KBDvHdjK6YjOvFZqea5JQtFKl8bn0yZH0fmx8wCd
 qFO9IArNdvjVWigmKNzonnAF1JZNark486+QBc+PkarONu/jf6TAiFzMZ6I4BSTYvRj4
 AI7wT/r2rXp7g1l6Kjk5fRmIW//KORJrcLWXopZgxOcDkg0wsGLsOA9AtkLQGil5o9nq
 dFY7lAOC3+wrhCQVV3BlNeMf0pv6DSwzxKBDy2vi0iO51rUXzeUOZ957H0uEyTTH+JkS
 2UUsSMl6qiErLUeGgkTXOCMND/ZIxLYUonsr+pZ+5hso3EKC0o51mc5oUa+LI/NjPvck
 mMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751450498; x=1752055298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMR1oUA6TQGAR4iTFIw5ejdvQT0BUyM5ny8jOmkstL0=;
 b=WUKGs+LZ3pJrhOcnNuabPZhQw1CGxvk8JhAS06T23j2Y2WHBC+XnSBExyZUGitAJIr
 wx3oklLHTwjVLdH8VkD1GPs+BMgIFq+EDcJmnoO3Wm3ZZtXhV76NLV3fu7wly99eAPqd
 cugz2wTj6ZaFcL8U5vExbIy5uTmY1MwiQWVrRXEC8e6ol6/0XCt1O0ctzRYldkLNDPQf
 aO3zxAdAPRXSSevdTnr3akAxegrXHiXlQdMyHCzL7tvLump1GfDJ2m/eNBJmXKr20PSU
 pnc5A6htfGOcFLOIzx+eco9GQcOoT0F/+++9smF6n5jwOxOixEWBcb65mnt798zex62w
 XuwQ==
X-Gm-Message-State: AOJu0Yx5pTO+U9GWgphKR29SwoJ0+pR211Tebpxc0D7Woy2Rd0WpK5EP
 tFtKwSSsIIncgFtBZ3Ue02fxHSJztL9mRdopBCvfX6EGu1/7CrBBKOoGxNWRsAGF4E8=
X-Gm-Gg: ASbGncvwm26AU/43yratkQBrLjrimgl8iAM5gYie3+lWHTPfDEpWLYsqdSKylyOvZkI
 1aHtAVzJ1R2kbwBU6r5lOw+7Kk+jayg9TSd7p5p5EdJWKZKgaurMC/5WSeDo1ixwibnxWKRf+Yv
 Kfpu3bBg4gzWxBHZd/zLBHR6dhIwHWBYawnKS1m9XUWqjo3m2zNBX+9cU7h+v68talU+XsfqTfd
 PWfsSImQcLx67MUfddqJNJnI6xRIoudl8NMX0wK7OjJSx9D+Bxd/2GOlRW92ZBsfpKoHcluLp33
 YLGqYKLXb4eKST7nfLaXXSmPENbHH+Mols1m9jVrFMzPGD4/UvLcE0SdtEUBroMYWZj3nS3H/1C
 DpJJfIh0jbjWs2sB68HpUMswr
X-Google-Smtp-Source: AGHT+IE9C3e1oE7Pj2KVvygpS3sIYXYXKvQHkiVcxHIHqLlkqOfxFOvRjl57ruTFTHd4kEEAYtBUFw==
X-Received: by 2002:a05:6000:40de:b0:3a6:d296:feaf with SMTP id
 ffacd0b85a97d-3b1fe1e72c3mr1727316f8f.24.1751450497835; 
 Wed, 02 Jul 2025 03:01:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e74fbsm15850233f8f.10.2025.07.02.03.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:01:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 02 Jul 2025 11:01:36 +0100
Subject: [PATCH v2 1/3] efi_loader: Prevent dereferencing NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-efiloader_fix-v2-1-eb6db16bbe4e@linaro.org>
References: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Taking the first goto error: in file_open could either result in an
attempt to dereference fh when NULL or else free fh->path which has
not been assigned to and so will be unknown. Avoid both of these
problems by passing path to free instead of fh->path.

This issue found by Smatch.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 7d81da8f2d8..19b43c4a625 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -248,7 +248,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 	return &fh->base;
 
 error:
-	free(fh->path);
+	free(path);
 	free(fh);
 	return NULL;
 }

-- 
2.39.5


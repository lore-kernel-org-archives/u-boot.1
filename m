Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FDDCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF0184825;
	Thu, 21 May 2026 21:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N80NqpLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B44484852; Thu, 21 May 2026 21:14:10 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC3C84825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a8ee4b703fso6137991e87.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779390848; x=1779995648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDZAYi8yIJ/8A0Nx1ZG4oLzaZ5q/mJz/kedXaoGIVv0=;
 b=N80NqpLj1WKhtokrTuoHAwOo3a5e90jZ34S8N+J/c2tUAsMh/iJjwQbjTiGYOQXLXO
 e4rTUY4VjSbA/SFx+w2zCOg35jZm/Q9H6ukJ1+dnh1Z9Ntdfgcq1tWnrm4PW5W0kZFFD
 zx3y9Wf1rrqZ9g1TKr93FJXYDLoDE0eLkkZXYIAUIHOCa60msi2VQ9G2sgtoBmkfzl+6
 RGdBV3HiOihJB9Y8CkikwtiwJnMDpl9Fqa7DQCBnSeEqKSopar735M4gL4uwjBj1G+Nq
 lOUYLwVs2RsIUqKEWwOv2nEwVo+5EaYBXcP3HTqKEn7FzLFZ6OXLjzI59ltBe1U/LRNh
 +dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779390848; x=1779995648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDZAYi8yIJ/8A0Nx1ZG4oLzaZ5q/mJz/kedXaoGIVv0=;
 b=qjF4FZVMSpfLo2IjIipLlGsNS/O6Iy8QNYui2quGlEFtJX3hVxfotRAlawwsemP3ZB
 /BDXAhrraiCqPO0Iu8iEdn/3h46pbQBYbcHXfZ6WoAck7ycfSq/lI7fJBU1UiP8kO23w
 MGFH1AklDl/rDXxW1Akq+xjYdMIonVJQ3tIiSMILkUSbnUfTHt61sQ+LsMsfX5o42w4x
 R+xGgn8lAXRTIzsyUcZNGiS1w5Dq9IBt1BTJVfU4EyZ3lAy05kukJl0SVkXOq7yMAxgQ
 Ww2kGRLk2sHbxueVo0xJXwmiChObBiequjPlbayf55meqWXSFmYdxn6KRi2yWBlmw9nz
 Nq2w==
X-Gm-Message-State: AOJu0YzglNDHsKOpdAyrACNJth3XUS/YOJ51GXTAOKHfjVQ8OKkAwdIa
 0pNMACMpWo7TnarsrP7wNrAbcuO34UqiSEf7F6j0NWT9/o0yDmRgWCLT4akY9NZKfsqpnA==
X-Gm-Gg: Acq92OHQ4YRRyxHCpobmwpPjuj3xeuj7du5ys3+9sgQE4shMcmnby2Dhmfcgz7CldlV
 bcryCwpWEP4SzgIo7dF0ZXoMA3rp8vad4phHDI1PGw4e2xEUTXIV6qvxzTG6ChuMyB6jw3A8KWf
 3v9yjLVCLPi3tlW6ZSEr/uYT9SdcE8bPpazt3k3Da5Co1dl5m/kH5SvQ8u6petY338htWvBq0mo
 xQmhSklnqaaOjKcoOvJwAz7eDi2rSjcxlR/fx0YLbEBBpuBofQ2gYQKXTdQLRZuqxqk9xbW1PYr
 AIloTW+FOAchKsxpS6hAZIPN+8VbynLEOpEH4TJteWJNc8GHqwJahqo21lOPpnPqmFgBh3O2KbS
 12CUxe8vQI5PSOqeWaUrmSR3cj3yTsT0eOg76EwJMXTbyT0U0151eROWLdkOU6/jTX3zlLfYfiB
 WfVUz90GYlaNkGQ35cAxrhshbnTAEYfw2qg4vNZ3Hz5BnOuNRnOHf9WX0ogMIAZ2UWaM4F1Pv4t
 RIWwO8T25chWAfSsvlAoQvOHEip4etrFWI=
X-Received: by 2002:a05:6512:3981:b0:5aa:2a30:217a with SMTP id
 2adb3069b0e04-5aa323dbef6mr9784e87.34.1779390847580; 
 Thu, 21 May 2026 12:14:07 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-125-213.nat.spd-mgts.ru.
 [109.252.125.213]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d9442ee3sm38701fa.6.2026.05.21.12.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 12:14:06 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: fit_common: fix memory leak in mmap_fdt error path
Date: Thu, 21 May 2026 22:13:58 +0300
Message-Id: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 21:28:08 +0200
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

Static analysis reported that memory mapped by mmap() is not unmapped
in the error path of mmap_fdt().

If mmap() succeeds but a subsequent operation fails (fstat, ftruncate,
fdt_check_header, or fdt_open_into), the function jumps to the err:
label which closes the file descriptor but does not call munmap() on
the mapped region, causing a memory leak.

Fix: add munmap(ptr, sbuf->st_size) in the error path, guarded by
ptr != MAP_FAILED to avoid unmapping an invalid pointer.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/fit_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index d1cde16c1cb..24d985207da 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -123,6 +123,8 @@ err:
 		close(fd);
 	if (delete_on_error)
 		unlink(fname);
+	if (ptr != MAP_FAILED)
+		munmap(ptr, sbuf->st_size);
 
 	return -1;
 }
-- 
2.39.2


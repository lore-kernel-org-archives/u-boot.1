Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E05CF34B2
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC9183EEF;
	Wed, 19 Nov 2025 15:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GWAK861A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2891983EFC; Wed, 19 Nov 2025 15:33:04 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB3083EEF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450916d8698so1279673b6e.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763562780; x=1764167580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dcho90NiX3b67QNaxE2kPHVdQWSpacnIPMOTEc/NHDg=;
 b=GWAK861AOshOpZwUWIJHYGv2VQwWLiDEAHoi8JpHGw1/mQ5Ju5UpzlMML2vdbaWZUJ
 IYku/HQnNq7qesy2oUhvCbbv/UsOzQ7dkDGCLuSGz9laRYBN9DxOiSBPkert1cLmkEQB
 i2dudeDI6075uwLoY9+/LiitbtCAU+/AnPyvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763562780; x=1764167580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dcho90NiX3b67QNaxE2kPHVdQWSpacnIPMOTEc/NHDg=;
 b=ros7n9uNs+fQZ9lsjg0Pd3TZAvwVIWhh/U1DqkOYjPqg4Vm4aiVhn0ZV/ADzMn+zlW
 h4T6/zoNMfJqxW6Gh6KxuvIAN2u5QRsJtxhT7KxQFv5Baf8fGS/mwFTVeM8Znzz3cSGe
 NQ9L13JLPGZjGmJyQbgqi296HAmZfoH/+PULmM1LQUEcoR5Z/WxoK3g8WVMnbhCVZdfa
 HJkXqwW9sqrqhWFaWr9rZhP7jw2YD/4kdCYEEHjkbnREWIylZXTLMPjbAK1iLswGqgKA
 /fsoT177sVWzWluNX3KV4VAWcjvNjGlC5sQpLfGisvrMLskLwl2ngTSUEcROZVkfiXrL
 AA8g==
X-Gm-Message-State: AOJu0YyLV9czVmO9sZYKtc/EpuhLvnWrN+OSezkK9PmERZ2HuDQFAFII
 YTMHX+XB++G7oLg2GEslI017R90CETgEmC1sUl3R1JV6BKDa04nv4tEoZWe+QnBN/d9R+84JPqh
 KkUEO7wJtfQ==
X-Gm-Gg: ASbGncsRUNIGGxIoMr4w6pkXV28HbDhPEl2fFpOEJZqOsPoSI+vrKEs92997Ke2pqes
 pQmAFC/13j9t3DgWTtxBjoSbiPh7e/1/0tmusiS8TA+IUBZu/ZBRJ5uSijbLC7G5ZxhKJgDFm8S
 0IO1zeG65Iut3nBSQwINf8qfebW0NGOMeaPcZM8jrvTHYq8J9IqJW592FiprogEh7kGsLJaYWnQ
 Ay2ENTx4Gc6qbNo3DHPb5rG/S0d35dSz/PXirWY04QEYBDwpgo2QQQkmlFNnV9+2RxHFJy6oYpx
 Mnp786qUdlcad0L9mOZnx0sRcNBgnVOXspPa0AbzefHgZESOVfehF30LyJGLUKtYO8oHV1AlIr/
 G58o7bDW+Ym+i/An2pUBJ5efyLykaxzVQSkw3Y7xFkPfNhoHo/9j2MQGMSwk0hrGD4+FknK2JP6
 EZSVHu1qWgtACgYP2t4j5+85TvDZ5xpPFgt+rvWjC488JWoRY+ToyS
X-Google-Smtp-Source: AGHT+IHKzr0foMF6dfEES21KF7tfPyof7x0Cdw6JUhwvBHI04qlEhRN9cdxhUdDwxuX5DleoDu1Cwg==
X-Received: by 2002:a05:6808:1905:b0:44f:ec23:2375 with SMTP id
 5614622812f47-450973b51cdmr8669622b6e.3.1763562779508; 
 Wed, 19 Nov 2025 06:32:59 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a55548csm6009098b6e.10.2025.11.19.06.32.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:32:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH for v2026.10] Docker: Update QEMU to 10.0.6
Date: Wed, 19 Nov 2025 08:32:58 -0600
Message-ID: <20251119143258.838466-1-trini@konsulko.com>
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

The QEMU project has the 10.0.x series as an LTS release. While we are
not doing an LTS ourselves, we can be confident in the changes between
10.0.2 and 10.0.6, so update ourselves.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 58f2a28daa0f..92be7f763417 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -220,7 +220,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v10.0.2 && \
+	git checkout v10.0.6 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-- 
2.43.0


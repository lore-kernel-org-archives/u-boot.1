Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D36C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 23:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B60882D7;
	Wed, 10 Jul 2024 01:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NvoTuJZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F2088671; Wed, 10 Jul 2024 01:07:15 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35345871C7
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 01:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d9c487b2b5so341585b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 16:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720566432; x=1721171232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=C8XKCuU8t1AaZA+/vPeMo8A/cekbc1mN/lba/Hx09VY=;
 b=NvoTuJZw1m1UDJSN9IbfmsdzkoKvkh6++RPk7sfsroD6CJ3oLeSISSb/qm1EKpf8ms
 6l59nBRxMLIu7md6B0aXwoXAWopcfphGca8fDfWSkpOUfDkbsfhej/yQ95t7MTUMGXX6
 EahFQu/q6vB5erg3H4JBPPeKHucuGZZWQRDOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720566432; x=1721171232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8XKCuU8t1AaZA+/vPeMo8A/cekbc1mN/lba/Hx09VY=;
 b=iF/x7g3OmNvWkoIW8LeU52xXOPcxWTs9CSAi79FQr6PUwJjCBEr37ZKNdOfNSJeOtz
 /V/3NN+MO8IIMiwo0h8uvjVJxU7+C/VcngHKCMoMj+4eq1m244jxYqqJUr5ZjR/kkDY8
 9Ym3rICNuOHcMbfv4PB7t9zbtq73u5CjaMNSEroQmBgIUcFFUtIoXvuwrg7PzJRU3AxJ
 FycC5MF6hf9P6X5WNh1tP1+Zsh5OukyVwGfg967O5NTrOBb/qoFWli8UKjPFA8Ssws3u
 8C0AWpj3iq6ML3ni9dJ0Sc/H0xndiOGFh6n0AMLWtX9J2zDsQuEjVviH5LyE2c/opv5V
 uctg==
X-Gm-Message-State: AOJu0YzfhgzZCwWiBFpuGFz5ilQDTpstJRLHgk8q0jzzFffWeHupIh+a
 1N/++yBRAHymudR3ZwA2p1DCJI61R8C/ErS+bbGg+NSz0jahzGLMcfuPY7CUHYato69/YJ07a1I
 y8cIemA==
X-Google-Smtp-Source: AGHT+IE5G2pMlQSoRxY1tPLvSuAAYKcJMY/nwXdqg6TzgGB0BX261zm2wYLXZvro2vXdtAtuEE5wDg==
X-Received: by 2002:a05:6808:1312:b0:3d9:24b1:74ae with SMTP id
 5614622812f47-3d93c041072mr5063792b6e.23.1720566431914; 
 Tue, 09 Jul 2024 16:07:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d93ad145c2sm586452b6e.21.2024.07.09.16.07.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 16:07:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py/requirements.txt: Bump zipp to current release
Date: Tue,  9 Jul 2024 17:07:09 -0600
Message-Id: <20240709230709.2228061-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

A security issue exists with zipp before v3.19.1, and the current
release is now v3.19.2. While the change in versions numbers is large, a
manual inspection of the changelog shows that it's not as big as might
be implied.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index c1dd636931f7..6d3030cf90cd 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -27,4 +27,4 @@ testtools==2.3.0
 traceback2==1.4.0
 unittest2==1.1.0
 wcwidth==0.1.7
-zipp==0.6.0
+zipp==3.19.2
-- 
2.34.1


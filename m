Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E93C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A739282C8A;
	Wed, 11 Jun 2025 14:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="syTSUzhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D3C82C44; Wed, 11 Jun 2025 13:51:47 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB00382B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so2949536f8f.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749642705; x=1750247505; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5RiFnkvIlhk6BdZ/7EheH/iHdA8yHOq31HqJ3ysZvRY=;
 b=syTSUzhvBoBAlK7pOxKMSqzce0sSv9EwptN/mBIlijpN9bR95v0WgR1CDP+tSUCUUK
 H/LTawk2X9wpFL0YdrdUWa1ONyoaQ9ol3APgYhXNoNSHNzlmiVey7Qe3/oWLPae5bt4G
 0EBD5DZZGNwyORrj6lzHB7H7eVr88MJNLAo1c37HmEeMZPdu4JJUUEVVYkly8Gag1k3q
 3w8/UqY80pad6ktNNNwQURemazxG9d/5jbtxgpJ1dJHXxBi/k2i/KnQIu2DOu8q2bTux
 ohJEYv2QJLEMxdIRp6LZzgVunfn+OO2REoZemIndMTMYj3sfrhb6bTeCvB4kjpWPwhI5
 Ekfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749642705; x=1750247505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RiFnkvIlhk6BdZ/7EheH/iHdA8yHOq31HqJ3ysZvRY=;
 b=N77Zw/r0u+UjI4rmDII7dRnI7rNnYkeDUAQWpuDjoQmWbSwL13Crap36uokz5TSjvA
 oDqlMN9cJ4fZkOWuFvpWUD+jA+I/UFjGrjXYFClSxHTYUh9mW5QRlBJ3jstVAtYAFv5/
 Z6RWb9L8WWhM3rQoutQouQjNkrTTNEjpF/uUHg6j2aMvC5It3IVd5KA7U9fvulJuwg6e
 6+LAw7ibxk/9unzd2WYyJC8LqwQNuvdjFfm4Voos6y1+bR91hdHvgQVKqn90rRWxGM3q
 nnpzAVnM9sNSxNgM0HTjEW7NppEtxatmE1AbcbubSDCPgeBXEwRDjZIdF8g4E2q3kauE
 t4qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM1NxmOk+8bx914CJFhlE/k3e3hBIBRDftEzZxFdBgAtyPkNDQKMQ5gUxTW9Q8KlB6f6xFNXM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4cwBcyy618/AGcH/s8uPoMgKbJ0XAO27gTt9N5pTpfXy+Kha2
 L0n5onaWIR3NB+ftCW1Fx5shgKoEYJ1Pom9Sl1sC2ap4hjPIzoCxur53aLr9VTYgGOXuJDjIXqU
 LLOGmEu8=
X-Gm-Gg: ASbGncseiu5UYQE8+twsVZZEtlve22hJ0MYem10be4KzQ6QcX8n+5TZ6AIMaVxbj4Dr
 hxaqL/W9QIpQJ6Bb6cnqdx68PmzpQYZuLcuJwc6Avy1bRsaXcgfJWD+QA0HuioQ8fyvyS0aV+WR
 LhE2dojjDV7Ajzw5GCszxZz7chM53EnVlGQ4DP1+St3qJDVMubRYMXWZE8M60ZHAojcLjsxWdr2
 e7QWKORTz78JVK1oB2sexBU5iU26+NZeGx8liZ2qyCASPMvscKdyh67iDwDSdlHy9tlOAOTI3xz
 i9h9EtFfYOApLOWp99EsBjqUoQkUhSK2EQHz+m2nH05OqnAlNntjEo6hEeaJwB+nPHQ3AHtrp02
 Le4AABWLtNroQjjVeoLZKffrjGBCMaUvfRHNA1NYpNWg=
X-Google-Smtp-Source: AGHT+IGRrdsmFTL0fXQeVRX/LK34WOdQrHQ4+kgNypZ65cc0RJ6mv+Y87nvCSyN4pKP/G3pXDtGaeQ==
X-Received: by 2002:a17:907:3c8a:b0:ad8:9ab7:a270 with SMTP id
 a640c23a62f3a-ade89714558mr314688866b.38.1749642694118; 
 Wed, 11 Jun 2025 04:51:34 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d75467fsm891666166b.14.2025.06.11.04.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 04:51:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Jun 2025 13:51:25 +0200
Subject: [PATCH 3/3] doc: board/qualcomm: Add example for boot image version 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-qualcomm-doc-update-v1-3-5cf8cd94974d@fairphone.com>
References: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
In-Reply-To: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749642691; l=1056;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=9DfjA3DAju/jtaMSbu/b8NfCyDubaoJupj2Bt8qB5EI=;
 b=vsuFexAiY6tm/U8lHMbTNwis1/KLrvJ7AFYa+J7efIAb8DjNs6jNDwuLCrhud9IyN6ALAxXBA
 ZNxV0wznJ+pCcvHoecR952hsfPZ+OA1++5Zgk/wwxnNCgmMARVH68j0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

As required e.g. on Fairphone 5, add an example how to use boot image
with header version 2.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 doc/board/qualcomm/board.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 23159f2091daa0def4cd005c9e413aed6de7d4a7..642c50952617e315eb461972e29a179836bd6e07 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -117,6 +117,13 @@ Or with no FIT image::
 	mkbootimg --kernel u-boot-nodtb.bin.gz-dtb \
 	--output boot.img --pagesize 4096 --base 0x80000000
 
+Other devices with boot image version 2 can be built like this example::
+
+	mkbootimg --pagesize 4096 --header_version 2 \
+	--kernel_offset 0x00008000 --kernel u-boot-nodtb.bin.gz \
+	--dtb_offset 0x01f00000 --dtb dts/upstream/src/arm64/qcom/qcm6490-fairphone-fp5.dtb \
+	--output boot.img
+
 - Flash boot.img using fastboot and erase dtbo to avoid conflicts with our DTB:
 
   .. code-block:: bash

-- 
2.49.0


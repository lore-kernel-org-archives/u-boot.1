Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9E606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RUGuWur+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S/DON4JW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A1D4810EC;
	Fri,  6 Nov 2026 07:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXVMBDZV7Y5z; Fri,  6 Nov 2026 07:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6128810DC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793951473;
	b=ageYZJqatArbWsxKKwV7ZNe9xAGlQDSTh29NuOCNuc9xB1Age67XkjYxoY7YL0JEZvt/
	 xFeWEmDmYb3Q6B1sZbekqdM5HTwGhZPT2WhMx/jY5R+qfg2BaCQ68I9yc8VBgpvzwINTz
	 swl7j8QTa06QYn5qTqNzTUZAOFLt4pyZgm9Kg4OJzZbChHcZvHIB+Dr0Qr/WMoOWbzh/b
	 wlmy0t0UqKbFw8g2tqdKmg+0Cw9nfw8C36jHlbHshUx3XHKHESPYgfoCBT1YmG5QGuK5z
	 KCZMjUAT6d8CB4QYiAjApHhN5cz+WunY7RSAkGc/ITdn8bzSLPXhvrlu5103gn71glw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793951473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dW0UKV6co7MR3MqHOYP4l4CQax7cWdMXxbFSJQi4BJ4=;
	b=dSXmScARxyuBJ1+5UZsxiM/1PgSxxZIbzgZqVB3ADjmphuqXyaOEY0GL7ezGWaLZJ1bS
	 7h9C5i+SYejHmmy5V4pbvFAt+o24GHqfLx1Ezkr+AtO3pCe77joHZH2xZLlIklxdibeMe
	 /Sos2HJ6blBavNFEpJ+NCUNNcSFp5HA9lvlMzvAp6IOJmjJKR4/V0u6T/4w36LxFQ4Twm
	 HXmXb+u8932FI91Xb5Cu3TVVmzbtb9w5/tYyeCWMjYjRt/Y685orNzbUPJcUGmKt5cz5a
	 knqH/TBb8h2Wb1sFpnle1RsmC+qRFuy7A+TJNZP0+qoXTXUKE3UkWyN8AGBHetib32g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793951473;
	bh=dW0UKV6co7MR3MqHOYP4l4CQax7cWdMXxbFSJQi4BJ4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RUGuWur+uEorCRKt+8IGG4u/8q9tVXSmwFFbt4ChdFnTTdNPoOJxFp14WYxDBYgEX
	 8VikssoX0lElNCns7iTDMVhezsxnO3A1igA1T2b/pwlQbZPpz1uq7S1rXpLZeU4qmR
	 jabZUrqxBWpwJaDTixPxuS479bWcsuiaYOMzyY1eP8qHY3TZMVYR8zYx2Wzg0/CdiE
	 TWKVXpunLCCGtYM+BzkjLiyvj4129gP1VVJaC10xk/7GYi60onXANSbV1w3J0fNs9G
	 6B19oOKeb1fAQt2qURHn2iY3DRelnfG6pprdYWvuEKdz88iGt0HjoxrMeO1hxMCSbv
	 mjs7QO9Srj39A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6128810DC;
	Fri,  6 Nov 2026 07:51:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80CB22E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65155403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ylco4_p8-ecx for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 57C08400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=S/DON4JW
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57C08400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:51:09 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-49231763f81so174280f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793951467; x=1794556267;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dW0UKV6co7MR3MqHOYP4l4CQax7cWdMXxbFSJQi4BJ4=;
 b=S/DON4JW2CVXqCLI6TzmcavtfixkcIkVs5ln89SVpm/2gT55diz8VoFCZsf09UtDtX
 xN9ta22Iq6J1zjk2hb/yHBfPTwDBDcGRa0IdjAsxtxKbNIUH0wy1rcfTIUbP2i7Yh1JO
 wmptol7cQtN+b9rnBXMAciFpedlhc9q3IGzEKhHV8mRqr7v7BOqceGzqsfHgRxupgG5U
 S4nY55A4AcJ57ZtYkw7WdkOq84/HGiosGLKaBwnAh3uXgKHn6+dCfPlCExVPyjD0PXFc
 /i0R8smBcM65W0weDdyeLCuCTA8A3Y6mPk/ubrnOTH0OySj5sXXEi+i1tHxOYSCtfU7y
 UnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793951467; x=1794556267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dW0UKV6co7MR3MqHOYP4l4CQax7cWdMXxbFSJQi4BJ4=;
 b=W+UAHb3js3UYu29ojCVzIL2ktrs9OuX6GneW7z3mYXo0hEvSpjsEVp+0Q0uZCPzlFh
 zuBjMEMNZqLJ6j/88ZvrwY5OWWI/JWkTchEB4H4fiirUVVWkt3L1ZwBSpv0pFbLB+XWh
 gSOnO8D8JpQ/yy91Z11LkdVbpVw0H1tz20Pw+OX3L+7oKnxf6gjWk/FylqIe3eyGgwPP
 bQY0KU2hynDrmi87Jko6VIcf/IiUI+UfqKNflWGGSTpYPMphiiWvcCyn6iqS7O3dTTJU
 /Zn98hgg+ZgZm6ofwEctaML4Dc0oa78ev5zSb2aeyV6OCVRteKUZvWHUQOF8uQ9PLwo3
 eQkw==
X-Forwarded-Encrypted: i=1;
 AL+hErHiAR18/0zGIH9UQRBxTdXXZ5siION9ksxPot2QhUcG0ARUSwFKIYB+5JuHfV4N4qgHXbBXaqA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z82/176WlQKkc39/lqGbOqJ2zYqVQHhlJqF8cBgCYR4+N8LC6Za
 zjNy4ceqn9QTNwqUzUsBdF3r5UdhVvGAh7vMGVH5OId3412pngWo5HsslpIBzJlnySs=
X-Gm-Gg: AYBFou1TCT1jB3c66ejaWEu3zEgHezzyZXH5hMNpzX5ZeZNbOd9b2t6W0Lr0rqU2CBb
 ATaD+045ZnrmVI8qLTFJuwKqauKBeAFnwn4WhZLF3S2a5NDesIxWxqFDxeOuDDwl/0u36lwFVBV
 LiWZF90Nk81wVaUapkhtD4WJDL21UmtefiSfkDQwklwf5WyYeTpbIDNSNMAQU7okFzk2NrGmttX
 sJdfh1ThoTeQiBli/VOvCa5PdGqWmZwYWq+FSNiM8qHQ1A5noSV703BxPYcyuKD87O1KxcAZt9r
 fcPgIeUBS2aT6AeoYPrU2TZkFDPOD0U6oF8CdhYBNfSPmfvDqNWT/X2PMH9dLzfPcI1y7Aauog7
 3w/poDKmeqBTQ6x66zqsTQHj6G3kY/n95mQ4yK+kvFvVPuYRDrd2QeJWnlkLITDAE2vYAkqfl8o
 Fa6KxPFJKR6NFq/8TE3rKxd/s/i698GISPzv9OgzCgZYVRmUUtKDbhEC3yx6MK4ftj14OFvY4Kh
 9kDMaViPtRuuqO4iTLTWQtIUlF1xKUMToFAnJsKlU+/5CrppCXQWBTYYZO8XKeWUXNMHg/KFR9x
 rtxUG/uYDir4KukmOZpW5XafE8Itvq5b02mNRwBHL2lPEkoDGyV+xt0BV+59mdT4XxedS0K70vL
 n/MACUISaBVo2A6ERRasl5X3wosqc6JEfGMhrPtHpHVQ16MWPa6hUisDVwvR4OSgQZknPE95DZf
 Zl/MV11n9sTjY78yLdbM3P1HWgGTOSHGTHbMYDOM/CFUY8Ddxssh2ZNdLEsQ/r2rBm/TCwHAMXB
 aTd5TWMuLlwqp37cyZOG253M+Etjm7o72TXRmvbF56pWzC8+9iJP2IJGVUDyIsbrYYBE6Yh7P/x
 vTzNtZ3q4NJHIrCiLM5rJ2IbzGFXk54IUBk6mCeRVeWoBvUPDTRkfllxdNCeriowrtHZrKPvy39
 yCsgYY6lkjYo80xJlWAgozp81oxcG
X-Received: by 2002:a05:6000:2306:b0:48e:cd3:b3da with SMTP id
 ffacd0b85a97d-49272a3a830mr3708996f8f.5.1793951467105; 
 Thu, 05 Nov 2026 23:51:07 -0800 (PST)
Received: from hades ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d63accsm2209685f8f.17.2026.11.05.23.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:51:06 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: pbrobinson@gmail.com,
	mbrugger@suse.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH] board: rpi: Move discovered_ram_size to .data
Date: Fri,  6 Nov 2026 09:51:01 +0200
Message-ID: <20261106075103.567763-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

discovered_ram_size is an uninitialized static and ends up in .bss.
U-Boot's linker script overlays .bss at the same address as .rela.dyn,
which is safe only if nothing writes to .bss before relocation completes.

Move this to .data to avoid corruptions of the relocation data.

Fixes: d19d9e1c064b ("rpi: Add a local get_effective_memsize()")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/raspberrypi/rpi/rpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1da5df92351c..3928726a0325 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -39,7 +39,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 unsigned long __section(".data") fw_dtb_pointer;
 
-static phys_addr_t discovered_ram_size;
+static phys_addr_t __section(".data") discovered_ram_size;
 
 /* TODO(sjg@chromium.org): Move these to the msg.c file */
 struct msg_get_arm_mem {
-- 
2.53.0


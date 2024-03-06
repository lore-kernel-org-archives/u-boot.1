Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114CC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E5C87D64;
	Wed,  6 Mar 2024 15:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HbWW4Rd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3677887CAC; Wed,  6 Mar 2024 15:49:02 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A327A87B07
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC84F3F630
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709736537;
 bh=I0rbxKBVc1Wqfq0Iaj1Mxu1ojVjdekVxQiqXPTc4CwU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HbWW4Rd+vQUqZt9n/xB2Pi3e9cBwVDEmiviYe6aK0EVQQqAczh/j/UZ6E2moe0Sqq
 J7TALZCZvIsX21oKdr0QAIq5hwZ28ZY7Tpii893DWUEX8TdvNjD1zgiExkBbli083e
 GEdIoywd5bLSMj+9IC+URSR4Yhr0KtheYvksqZ/htfLJ2HMOPtP63wL8Fs7MeCbFMi
 8lWK1uPRwfReX2yOWcLRRi2KoSs9AK1AVwS2FyJwCAvIk2ibIBRQPOu4oCUR9+zvfw
 E542k56G7gMDr0bgRZP+BsywYKuHIaAKgpGPGlYy+sREbWbt/AIzqbo9bXICBIzqx/
 Tko5Ya4KB4LTw==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-567b193c8eeso924853a12.3
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 06:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736537; x=1710341337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0rbxKBVc1Wqfq0Iaj1Mxu1ojVjdekVxQiqXPTc4CwU=;
 b=bVu5M6Cdn96RKz/vCRlakV6hPX2TF2R6U6tPgQO4c9mQGlGrXjsbGljjU64dAbYECZ
 b7J41nh7BrQhHFClz7QEOIU7jxGXB07S5kZOo9XtQxEGGc7DF3rEdTJQE4pbI3atP+Sx
 8nd7bBmca/Coru7W6Ah6kpFQdtOUgJssKN7/oublgAFkERn1ALt3pU8PVZySqG+TrmfK
 MNvtQItAM/6bdu8IglutyKFF9sbpOoTAblkg03BDLQVNUSnB7bp0PPmJZpepaxP+GKYb
 90pq8A1WW0VY6+xix8eQVeJ8pVwtRlIGWXAOHtF3osMIufpiZXMsqpLlKm60bBh6rISg
 m5oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzikvhJKnXAo5tcr1i8t4StV/gSujiB/ofvwJ405bAyFfkWgD/fvbgzdzhmlcS53xiuuV8aTgFQ5qOX5ULSoNlswBpHw==
X-Gm-Message-State: AOJu0YxnRTFYYag+ERsS9IVRd4gj/VpruN1ibdi0xUDEHSle502fK+6K
 wINQcJcw1hjuzXZWI5x055qXjYWSeUgM4xk2qe8tOBGuPk+sU4kTQknX8h+gZs6R9uMcRv/aELb
 HlIPURnZPRfSZjrbo1qX7X7hVTrGsd7q9FU/wBwSVCyQw3x5D/iHGC04JAlRgkaJy1LM=
X-Received: by 2002:a05:6402:323:b0:566:a822:990e with SMTP id
 q3-20020a056402032300b00566a822990emr10171986edw.38.1709736537367; 
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6jISJBBX4a/OaIhVf6HGZdu8CA9zD7Odkv5Q6SGsDwMk3EtE76NUOPLlNRYWx+NlAjgsbBw==
X-Received: by 2002:a05:6402:323:b0:566:a822:990e with SMTP id
 q3-20020a056402032300b00566a822990emr10171974edw.38.1709736536994; 
 Wed, 06 Mar 2024 06:48:56 -0800 (PST)
Received: from workstation5.. ([2a00:20:9:393f:a428:922c:8eea:8ca7])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a056402517100b005671100145dsm4814647ede.55.2024.03.06.06.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:48:56 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: sbi: formatting PolarFire Hart Software Services
 version
Date: Wed,  6 Mar 2024 15:48:52 +0100
Message-ID: <20240306144852.176337-1-heinrich.schuchardt@canonical.com>
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

The 'PolarFire Hart Software Services' SBI implementation returns the
version of the incorporated OpenSBI. Format the number accordingly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/sbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index dec7dd651d6..628ef3a591c 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -80,6 +80,7 @@ static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
 					break;
 				switch (impl_id) {
 				case 1: /* OpenSBI */
+				case 8: /* PolarFire Hart Software Services */
 					printf("%ld.%ld",
 					       vers >> 16, vers & 0xffff);
 					break;
-- 
2.43.0


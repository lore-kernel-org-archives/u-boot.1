Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05027606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jOCeVV+F;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OUYQm4qq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB9DC407E9;
	Wed,  4 Nov 2026 10:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fhsl_OSHUELg; Wed,  4 Nov 2026 10:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDA98407F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789978;
	b=gCfaS6JGLzWINRQEJ0We+XTujbWEYM2LwI7wyiO0yjUYvvm/SRm8LBce7pqZCAoisfzF
	 td+EFNMeXEYvxr6+fhsbBtbtCscs7hrT2vLPEfd43L3FW/J4h9xVQCfG9hI8RKgOmZEyT
	 XHEoSHPFAvobxvvubS19uqipFPi7+fJgBuOVB3HfRmimlGH0R1aRrjrY0c7u2UDCRHWoJ
	 LZ0lmOCs0JBvA9PLx678cHX5ZQZyUtkv58YcEZ5U8Lt+rTI2Py4B+PtTDZCRwXZx9JYuC
	 BxtfaThtpTLs2oYqQiYZLdTE2QlnB8n9/zwLR1u478xWPUgv2Vz1RxTbaOqGm8IvecQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uncUNe3anLZgV1VKR0Rg9r2ghCrEF4PGyO+9cw8tzrk=;
	b=h2snKys91fV/ihSYbMgNjduy17AVcJMfLt/Fbwu6mwVjmuQ4utGPxA5DBtjkg3cGjYGv
	 fuZEdM99o3B3/vqXInhTVOO+HTbzWXxBCURSOER8AOriDcFVJ/1r8fawrRccCO/l6TrUY
	 +O4XRaLIIryRfii41pbEcXu0Uwacw0S+Rp5DroDzNSEolakdtbVgITRkYEt1ovwSMyqn8
	 pUfM2KgDfk6AAMiBCXhf6fLK7YahCkE+EIXABvZ1T0E8olByobYwffioj9Agms/2I93g5
	 dUIt7RnltoWnQ7EWk+xzTs3WlDTTvflxX8cx/dIaWTzEwx9uvII498JENTUzYJBoHbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OUYQm4qq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789978;
	bh=uncUNe3anLZgV1VKR0Rg9r2ghCrEF4PGyO+9cw8tzrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jOCeVV+FFCfJzw9yMz0ltavmiI+pgoee/pqjFFTbXaiwzmKtbiejTiP/cbnOTUS/q
	 zsCUz0GLvDKwMaft5Edk+at0C3yb3bIBvCBYvjfNCww8TRmuXNDo8kQ9xeOqhAXhzd
	 /EHritHyGUHTpJ267fgHJmdCll+0ohc9Meu9pB6pJOoesicFTrw3qr7p2UJlZltZ3W
	 9vVnlfdW5MqsIJA+tD8Nup0pYeIzTgowuPo3aqpiRE+EDY9YDRx/zvh+0CupdMfNld
	 XeAW7FK21UISfdK2siVReMyqHARtG7EJqCYWvBSdP8qoFADpbJEolyaEGRI+GXX18v
	 C+96C8+kI4qKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDA98407F4;
	Wed,  4 Nov 2026 10:59:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 381C92B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1505D4048A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wv4kgBkzNR6 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3ECB4046C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789967;
 b=YH+tzMp2vBCRoPyVnulc4GzDQoNCLe4u4FmDgqhOs+BRqulQFqR92ObtvpeQJw6M7Hgi
 Smli97X5QmH4aVOVK2ps3H8NhGYbtAuNwjsUIVlxJU4jIo3iQCCHi84HawV7mBiXFrhbi
 2G0U5Qq5oD0OYyXN0eeAz2KNusxSuDJRnT7xPWitRHAs/gm7t4Eqte6XU6tEV/LhOm4On
 q68nzDfcFQpuoejtUO49stwsQdqK16ALOeQeF5n2lJhYdxz9V2lw+qJz3Owju8lij85ly
 sN1VfnDXqHtVZJZ50AwfW79yD8UsSalj+3fXzwdw5C1ATZKJu2iPhUkK211Iflo4vIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789967;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=uncUNe3anLZgV1VKR0Rg9r2ghCrEF4PGyO+9cw8tzrk=;
 b=fhzeuXCXPMKSjwGg7joYuZyY++cbEt27/PG05GA3l9j1wPG8jusHHVvbsFfXcOnveSeM
 1pIZh1vQCoB6seCdThhfqjowl1ABRQJWeqgKPSa/iI36WV/wttPoA6SkD/lvm+hUG0Epn
 fjxX6Pm0ClYfClNHzMm5ava2okOiOoxMinmMD5sOACuM3l58K12YoLTPIu6ajwvn2+jLe
 50A3QBYTjlz0nx0rW4EIlLGGxGpKhnE0yW2tQOT87bhpXkpXkLRBPUMAT9RAY3hm7Y3nK
 NW4q6RgtuhbVH4ckTVXTeBEqhh8P9fAl4+PT6uSc4K1igdiSR7UIxmIlMMwBf0vPQtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OUYQm4qq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OUYQm4qq
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3ECB4046C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:26 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso976170f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789964; x=1794394764;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uncUNe3anLZgV1VKR0Rg9r2ghCrEF4PGyO+9cw8tzrk=;
 b=OUYQm4qqR8o0qiNWneBTEr0QzsRUplV1isw8ZA+7x4aPCVgwTkbJq45IBd5WzyagzP
 2TIDQ3ti5/py1q5rJM1ttSxbYWIERpiyKQT+cH7aRLsPjGYVLlyHLO4UqC8rBqG8ORNK
 RnU8Kjv8uk9eXDWAz1u8M6K1yAOr3mU0o5edgcUe8NAbI1ktsMG0Vb9N4QSVuY7IF32x
 wrpBPZR2OHRMAGcHgQ5TGiJVW87RHYT9jbeIlwqb6D2hq6gdvDeDa9SowEnGG3fupd+K
 vVQxuuiWdwoD1fqb0wUs3ScLlxn0cIa097ky8tZduOVMnrLaGv/7s20sMXAveo44Ci1B
 EL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789964; x=1794394764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uncUNe3anLZgV1VKR0Rg9r2ghCrEF4PGyO+9cw8tzrk=;
 b=j8B7Mx5v2voohdpbtKGmLkwJyWD0SqGozgH58N5O6VtMy1aVYfl4XeHFxIMZDSbWhE
 q9z/umwUlWC87Kt3qQY5KdbHCd1+sNz8npjrVH5GbBURE9VpG60DTO44a6OYHotRFCYh
 t9kmJCEppmsPokyQXW64P9mtyNG0ELH7Be5FWnApKs3vu7CJCkHZ1pTvd7ypOMrt3X0O
 xPyboTz00kOOX4k2vPdlOs1zSenWKZkQU5IUZWPWWxVmRY8Rno4ktrFi44G0LDfS+JA+
 VmYRsC12pVc5wGwjrx07epJZRUl9jzjz0GTEe/gew4sXsL1jWLgVg3TygwhM2GsK8QPY
 NMUg==
X-Gm-Message-State: APuU4Z/ZkrIFv9byM5U3BRqWGjxOJCOS9OZcgbE1KYXLAp1BZMnbjZQS
 GmmdRFTxcZ1jbHVGsUeZmyuBgpg1zQhw1CrMNXamitWBoNhA0zcVDGcYGNyVb18MIBs=
X-Gm-Gg: AYBFou0rqfYuTJ3hBrpWfQDiFK4aDiROqd8JeR0jx729B4R3ahVODlDg/klupdbUvr8
 cECGQlN+z3LbX1BSoL9V4S9HnvQndrBK+MdrzgyRrL8s4+Hqn0O83GrRu/4dTgDB7mkQJFzNc0L
 fyIFBPh0n6XyhHhiRBsc3u1BCojF0YcMPDBGOs4nKeuXgs0j4aeOGRRJuL8D1hXrwzypHJmMlMn
 7FqcDOx9MR9psltE8AiMonqERbIUEP0VxM1EdOLYJYr5x4XS5Y4Y6s+mVMDihSWWep6u2ev+1qh
 UpQYwcWL+cOxWuDI440qAm+kOW5JLJQsCNTZxMuhlhGp//1JZy9W7TRkT5y80gOvdELf2MDiq0G
 DgDXkQF3XYRFLa3LRUmGP79PtMDSBM+TBuK6pS0KsyWYmmJhIqpqGbSeiGQnk4zRLgTr9Tsn3X+
 DL/HbKwlLr6aolPdPGmaw7xViiVUjnLjXw45wTCl30J0C5KJuSH5tr0wr2BRRo7TnVdLiAn76Hw
 N9bnRI0W6fNj84/ZiOOB2CvVCTjIqiG98DZOtCjsaMygr2sQB+HJ8b7uxts9rEmUFefMU1c+cHP
 mysJT2Gxdo+fvDIOzkkHu+OAwGDlWTjs8Q==
X-Received: by 2002:a05:6000:18a9:b0:48f:8eb6:2327 with SMTP id
 ffacd0b85a97d-48f8eb623bemr9796997f8f.2.1793789964250; 
 Wed, 04 Nov 2026 02:59:24 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:23 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:25 +0100
Subject: [PATCH v4 7/7] arm: mach-k3: j722s: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-7-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sg3lkzX4qTkbN28Lo8gbKgY2HeWNAsc6ZM5jpzA1nVI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzXAgwc3WXfJLu8331QfeDO+JF3Q/Qjj08RLn6XjwcYn
 9zVHirSMZGFQYyLwVJMkaUzMTTtv/zOY8mLlm2GmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 gQwdIwYuTgGY6ixWRoalz2YuK+mJUbxVMFFyx/5rJxIXzTlzpPZAws/3pWu/nOFMYGT42Wsr5mQ
 hZBTg/PxcY+r2v9Uv90cruU9u3bPKeUbiu7U8AA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
ctrl_mmr_unlock() before anything got probed.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Richard Genoud <richard.genoud@bootlin.com> # on j722s HS-FS
---
 arch/arm/mach-k3/Kconfig            |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 3c567f50b223..a952638fc282 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -33,6 +33,7 @@ config SOC_K3_J721S2
 
 config SOC_K3_J722S
 	bool "TI's K3 based J722S SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_J784S4
 	bool "TI's K3 based J784S4 SoC Family Support"
diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..7b09691998c9 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -70,6 +71,20 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+/*
+ * Called by spl_early_init() after all devices are bound, but before any of
+ * them are probed. TIFS has to finish its initialization before CTRL_MMR can
+ * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
+ */
+static int k3_spl_dm_post_init_f(void)
+{
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
+
 static void k3_spl_init(void)
 {
 	struct udevice *dev;
@@ -84,8 +99,6 @@ static void k3_spl_init(void)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)

-- 
2.56.0


Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21003606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JeOCJ5kF;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Dt14lLCQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF15081125;
	Fri, 30 Oct 2026 12:28:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LEU2Ru9PViWI; Fri, 30 Oct 2026 12:28:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03CCD809B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363327;
	b=duCcJ2dKAYFtb8dv5thw8EyCz6q9u1XK+xh2R5jnaLYhGxlE/dzmDQYUxCvPefTL67Gl
	 Ix8FhkrJUsMje+RfznJ8wvZ0fZunyVqDSra4upml6dDuXdk5uB5MsuFmO7JDlYC8AE0Up
	 9KdAUP30nPe8mXtVznUBoydYE1pZfL0IFmZG1T8qZQ6JevESVSys4uoWwVl+9vDewXvgd
	 0ymbFcnd+X6XjPSNAkXWyVgFZD7ZG5TE7qA9PiKNC/vSFrzoI7nDGkl7Q7NPHRudcTVwm
	 U9SVfeGckb9gxfjIXfYi5APxJm+EfUUrrn/+S3IuspLpov8KQRBheGCsr0gVTb+0oqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
	b=tHrgAqsWk68D0KxZfcFhS0o+01HOKIMuLXOfRVJZP9ymLpC+Ht0fJ8gvgvYrvowtq7w1
	 JToWOViFZ/6IdXFtVbsz0J9BBYHKmVoUSBeUxy4iD+qswQP8QcCHAW8Fprd8C0XHHjFhK
	 KgmXHsns/QkxGXemr8R76197opwiJzMsUlQv6FuVLZV6KwVhMAfuyBHQ6nn0oR0pldpiU
	 9yM9jd7srSqPZg+a2D4K0aKZjPh0LfKhzYh8Z1llCl94dO2o+QVqGkTCbJA5iITaD6DFX
	 Mv+3mczSdH8TGL48Ot8D99y84R1YMbYv+On7/FMrxQdLvo3YKTYK7aNDlqKO0vXNUbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Dt14lLCQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363327;
	bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JeOCJ5kFAEDfZLTMObb2XUMg077Se0uTkazyh8ba44Vc1Fg5AjOhJQELavBdUtaHa
	 RjI+tHZc61uSpS12jzQBk0yu21SW8Dan/KTRxC9aM19Y+CuvNzCdw5+cBWY5Wmi+6X
	 8L2e5JZgNkmAXVfWis92r5CAcfzrDgsCyhd+WanXq18QkdbDYx3PfCoyf2D6c2hsdx
	 ROpVKnQUC0Nxil6FDYgg/sAqMolkPamXCsnSYqRtuYYwJEx0WLUHWCyQ8kj2SfdLXZ
	 Caenonn2PYVTk2xr7Ze8sHvCGYzDhwSiRv4qkr7otbgQpNOOYAsznCS4T/PkWjSuQR
	 cm/7AQWA/1BeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03CCD809B7;
	Fri, 30 Oct 2026 12:28:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE9A5362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD25D8083F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id saHygR0cBTjH for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B2C3807AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363319;
 b=eyu1i2iyrfg7a9Hb8yuC/DOnBBHBXr4c5FrNFLhmzKfGOPx33zb9UklcKfEduUk0Ujl7
 KsndtqUaFZl40ctW1kQqBr+i9PmLHBNa27k3NtmqKC0u8DOIzs5ceECFSm93eFCCTDlEy
 sGAbTU1kKBOYvsr6ZzGJ/dmcD1FGXQYiApQAwqgc4ztgZSnbBYJz8mc/4vtxWgMCfVtzt
 uYbCLpaotcUR5L8kkAF7KXsRtDdDtC1/kUfCFOTh+PBJwT428YXLh0xZwLCkSbkQ18peu
 kU/DaDoCDuKv8Ij+qZSQVe9urRAI4RhJPJft0HV/Vt7AdVt40qSHElucE7vB9ZACefA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363319;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
 b=QH0IiswZMgyfM/FIyomo1Z0gV0+Pd99XfVFY+9l0HSi0Wwd1t5dR7JTNgwk6fSikoeQ+
 +aIXnDBm9SGq2GPtZGa7AtyztjGqYcePqkmyqlJnJYUEkmAAEbOCQ6UjKhj1drAP6ICQK
 V5oDbHWw95WPyxH+5t3rwMUbN617mteZDkTQ44IRxIvY2NVWLiWeO0/hz0/BA8tcOV3Cz
 Ut4UDR7qEt8So36NTTbyXnd5OVFSdE7uCPnm9MIGqdYEijbzGoYggX2WlcSxodxAX1n+m
 1BaFlEMv4AkSt59E5Gfvk6Z1SJatI2udrVRx6koK47JquchAP0VxkBritSdr4MTVYYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Dt14lLCQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Dt14lLCQ
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B2C3807AD
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:38 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so4699565e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363316; x=1793968116;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
 b=Dt14lLCQxFvHg7/PipTEwLJtxDKd6Pkw7ru5/17XEeukeWTTSkaC+Z2W2jUz5QorBz
 YSrwxPiasIylR5MWQfImoIvifCtLlKl+KiRNqTiNwYZkueWAsRNsXusTEcPQjX6xe+8G
 qqYDYCjayePC6ra4tRlCHrac6/rPr54JK5FxCZ4T7EE0UjfwA1h90Vwk63cXWnM/UUlY
 PInaYDR4LHDpBUaAZscoXAvAZiddJhlFZERKeig7bGIjGC03ySw8r6shRHch8VZZ1B3p
 VFCm+jyG+Jrscq/2fVUnotzZeOhyHTWN+LYHendNkW4xMaXM3FR4NeVhPsbmwB4+vnRc
 iutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363316; x=1793968116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
 b=WFPDpTq1IRpFK0NKjJDD6EFdYncuoGtBMwE7sFtZCJrDohxzslPvI/Olu197eGvsi6
 MfI95EkSxz2Fp4RbRZExnMfEbTj1MoxvEoO1piIqqgirekmnMxvBM2ZRk+6okZtJVf+I
 8VbLswNjZWN0fZAhpEKPZPDbEyswkKhepj9ab/Pj1g0W78wUc5UTko3MTTq6zGLU47mG
 sRFKhgItzrjGO9Milyz+zl9fFyW6s8Lzps5WXSrd5jK31oj0L3fURjoe+7Fo5BC3G2TH
 IYZFKYpprbGBzrvls0gpAvoaLTVKapr7d8axDrMZkJk+D2iLcpj13MSgXW/frkdZgCY8
 6lUA==
X-Gm-Message-State: AFq9FYKsZxg7x/3h1TzqTDk6TWxPV+GhWSONRE/a0WW21IJv8ckkTuui
 7r9wd/ZRLUWnHbsXnA8eyP59zPsCRfvpXopTQdmni37ZOyl3EkWgjySBHZfLFYyZUTc=
X-Gm-Gg: AYBFou2gyJfZIDyAyBvOY0UH1ewyINxFHR21si9m8oQztuHrYf5oxQwVAbxO8Vi+6sn
 mr2/nRdrvpBAVkvksrncRfdgNGPmb5STxouKHV5ryqKOvYDV3DebF1PlhWFy+yx3Ev/F4gjwzWQ
 MlgzLqHhPCpJFAsayONaN0ItCXLnNiZZ8Q+lRKt5bKQ3EBsaaX2c2HbhP/SsdpwFpslb4NKvH2/
 oCPpSk+xq0KyzobVzVBhXjfzmL7Wk1KCnIvul9T/xk1VExN3kYPkp/6zsNico8buCgOWT9K6HcI
 w5ce32sGNeUYprXbmUKvqXIPlJMXX6ofasoGc5ixBEDUSXNt6I8WkSIiNhp7SDgivD0rugW17Go
 32iTPI5dfxf2eHFf7Mh98XR9wZUzqBSK301RpJetS4CLV1Lows2IqRHuwwZO9F5GZabyxAmpAl4
 7T93GKfPGPZHOA3GtSRTj8TXR3du8FwJrp4vRSJIuH3SrkYjxsD7txSTUn7WPjMQLpf17hp1nPi
 qP57TaFEArtjrH8k6rKYP2bN8OyWR33nudn0md3JcnbYTOLQArHbXcEBMObhHMaeP8jE9Pn8Fzq
 JtQA+7M7UJLpbHZhTddA7bdrGwtEOCbgk7rObVYoFSSX1pc=
X-Received: by 2002:a05:600c:6095:b0:4a0:1b21:2628 with SMTP id
 5b1f17b1804b1-4ac18b7e1c1mr44480485e9.23.1793363316052; 
 Fri, 30 Oct 2026 05:28:36 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:35 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 30 Oct 2026 13:27:42 +0100
Subject: [PATCH v3 3/6] arm: mach-k3: am625: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-3-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=msp@baylibre.com;
 h=from:subject:message-id; bh=iEHxOrUkc7tloY6uwzR21m6RzTCnTR/7QF0QDllvKPc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvTHCsuf+1j+yOW6zfqv8iU71va7rLib3zKq3fScY9
 3erKvv0joksDGJcDJZiiiydiaFp/+V3HktetGwzzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVFtOZ2ToilimN0HhvtbF+5MZlbe2tOZZ1P/yXP8xRq7CdEYk68PdjAyzpv0/F7w
 7QbbQ6F6k4V2zmd/WRJXZSmVt84vlfuzmM4sZAA==
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---
 arch/arm/mach-k3/Kconfig            |  1 +
 arch/arm/mach-k3/am62x/am625_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..b1f290c1d765 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -6,6 +6,7 @@ choice
 
 config SOC_K3_AM625
 	bool "TI's K3 based AM625 SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index decb50bf853d..c7e976fe5ca9 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -100,6 +101,20 @@ static void ctrl_mmr_unlock(void)
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
 static __maybe_unused void enable_mcu_esm_reset(void)
 {
 	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
@@ -158,8 +173,6 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 

-- 
2.56.0


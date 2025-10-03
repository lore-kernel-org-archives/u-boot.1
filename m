Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EF1CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430B3838EC;
	Fri,  3 Oct 2025 22:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oX6ddvEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022A583942; Fri,  3 Oct 2025 22:39:39 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34D9838EC
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-4291359714eso22574675ab.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523974; x=1760128774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=d03Ox+ntyAJwHkxH1YBoOkJm+EXHAG3cFG6gqTcw7zA=;
 b=oX6ddvEUao8+4QKOAiLHryrdQJ+6Rhc9lj544T5SZWlIiaXhOyJwEDItzC3D1ROgTG
 bQLxtXwCmBS2JVXB8yM/RsE0sNFO48WvB7neb16Is8h5NyZdAHP2AvDt3/EO5XItx7ta
 VqJDx3zZsRs5QqsvJWI75ZfPEyR3UZWTcyVec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523974; x=1760128774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d03Ox+ntyAJwHkxH1YBoOkJm+EXHAG3cFG6gqTcw7zA=;
 b=QUp0sINdxHmAuTDSoqcvrbZq8OB2HOrBFZhA/kGiWXG0m3N6/BtUWJOQ8YSz+MAnrW
 84DPkbuhYrX3zmqyDV2MYPS8p58j+oqzP+C198sDrzMncm6IMudsmwEZQHNOHLaYboAx
 3xRvTpe7V8vuk8/b7uBFMriO2bPuLoDuww2ZotGJTALmlXadWm/Lpq+9LMKkCHTg58AY
 9yxdHT4HawlOKjU5JEeH2wMt66Ct3z0HJg681wTJeQazyYqxqQIcOtPr8MUAOGTy0cqH
 4Ulkq//nEUMwxy2mFH8Sh4RjCMXtZJdjZDG/+jYNx/QWx5D6nuEVQJ2GTuB3gT//+U+p
 2oqw==
X-Gm-Message-State: AOJu0Yxt9yWSBINBtpo15h5O80Z5Bu7+Kh1rTHD52js37lvYvj2cO/oH
 XAvMhL6du6u/8LIaHm7QHPuOJgro2hH3SJkKlAm6xbxz8NXmjFV3uFx63FAr+lnFoJQRb0EEZ8F
 ijarU9pY=
X-Gm-Gg: ASbGnctjRyl1KmqP8W2z+/pCuRzbezVpXXkwTLLmvPkpm4fbfcmKvI1hmoi107/UG92
 V5RQ6MGmxQPgWdiuQ1pcEknIarDcnsBilCilRTpfQMKaluAj7zvXtIHJZqIy/mw+XiXXAGUzEmN
 mjSoaQDb5gr4L8Tu8WSfuot7mayFSnFuOKjhwa5r+5yFlpQHYWHWKZVElXwhoWIFhUULaoJEkCa
 XdQMXpu0DX6UjxtVTQMmtlOyL646xgElEHPXGomJaB20tjVt8PUfqiNpTtuZTF9IWbnV3BbwkOf
 Y9hTZ5m724fbOBWblB6r1Tkvp6Qf6J5tQu0I9rXKbNjHda6TmX7uX6wdWTVm4cbwKzJ1pcHCEoZ
 jZl38XbIYT7sEd2TGfC5GucothIb92eCI22GhD+Zj1bU4fe+/sBAs9ci1B8C6cHupetHBaVf4lg
 A/Q3jLgjftVOULorWVEyjJxeE=
X-Google-Smtp-Source: AGHT+IGJ2/Mq+RAPqi8UMBNY/q9GJeXtm4h1Vz9VEWfitJ7kE+IySLZ0aZyMa7rdszvyr9PfB9zQHw==
X-Received: by 2002:a05:6e02:1fca:b0:424:2d4:5844 with SMTP id
 e9e14a558f8ab-42e7ad05028mr59842295ab.5.1759523974281; 
 Fri, 03 Oct 2025 13:39:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5e9edd9esm2256736173.11.2025.10.03.13.39.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Make SANDBOX_xPL depend on !COMPILE_TEST
Date: Fri,  3 Oct 2025 14:39:32 -0600
Message-ID: <20251003203932.1030103-1-trini@konsulko.com>
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

Given how these options are used in the code, it doesn't make sense to
enable them for COMPILE_TEST. Make them depend on !COMPILE_TEST.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index d61a327f151a..e0c70dd31424 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -27,14 +27,17 @@ config SANDBOX_RAM_SIZE_MB
 
 config SANDBOX_SPL
 	bool "Enable SPL for sandbox"
+	depends on !COMPILE_TEST
 	select SUPPORT_SPL
 
 config SANDBOX_TPL
 	bool "Enable TPL for sandbox"
+	depends on !COMPILE_TEST
 	select SUPPORT_TPL
 
 config SANDBOX_VPL
 	bool "Enable VPL for sandbox"
+	depends on !COMPILE_TEST
 	select SUPPORT_VPL
 
 config SYS_CONFIG_NAME
-- 
2.43.0


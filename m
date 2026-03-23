Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAE1F483EB
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47318415D;
	Mon, 23 Mar 2026 20:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AP4RZF37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93DDA83FDC; Mon, 23 Mar 2026 20:51:12 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C128412F
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d8b285601bso1599859a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295469; x=1774900269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UspXzVSCRzdkOIYEtpy3MJajUNj1/ZI1fusA4MiJN7o=;
 b=AP4RZF37lSBGhtBfBkd5ExcrFX82CJorH1vYwgrmdAaFfx1BNojtsiSwtBXaGnVA7k
 n6c34QdZIWfY04k1xrTTDO3LOCF8LwpOX9rV70C+UijD7TRrZYL32wIUrJuvjgntE3Ws
 ehMU4frmOubXVWiH9ZGz1HAScJbV45PdqFIns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295469; x=1774900269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UspXzVSCRzdkOIYEtpy3MJajUNj1/ZI1fusA4MiJN7o=;
 b=Ev5QGfn77z79izKuRFV1pSSgqRN3VLINAVP8dR0MTiY2jl/iOlMEN2+S2FhPcQTv7m
 vF5bog7i1NzG4mQlMb0URX/aS1+vXgTa9+0lmgmpfbiCFRDNEnQVm0vWgEzsm4/FVzQJ
 rLZOsfHJpnSINE9N4IWe0ah4AjgRJ1iHS9/nmrLIUVEX2NwnZ5qPh6Gm8XojY96GG98F
 okoa77esHd+GQfrvp8DOv/GQ7A3vGVIxpYG9KiryyL7CMEHxzIq+G9EPWHMpv1iF39hr
 7e+HfSh+1vcaly7V2tTSOo3uLr6cZdunlKPajrL/WVLrFrDdRvK7KyWPY6x0r0QjeIx1
 /ugw==
X-Gm-Message-State: AOJu0YwIo6/v6ak7rEhc4RHQeahLLCqK0y4+PBBurUc6r0FGPCvEOidx
 EJwDaFiS4QxZxBFGejlEr8mwe7pwKJjAX4BHjst+q005yHcn9sq/Bo+UW4CvRgUNDmBB03mrIgE
 Qup8tPuE=
X-Gm-Gg: ATEYQzyVdEDYPne8qe8QVcys1jfI6bzNgdWVcD5Y2S00CQT3dI639r/ps+W0yScYn7f
 LG/8JWdd2Cb/aztBJMirlAqKSSR3dzQXAxv9l/mZfhr/bR8pjclgZPdeOiCqSSVSv02NpKY3CGB
 8BvUeh44Gb+VzHJ8rnaK5Y0ecSRPhydhoqti26WamnUe9cdmZzvvHwM1L8pfL96IWSGEfG+OJsv
 SLWo6QVtzwswKGuIDnJhc2s5VZ1aPi8Kpe+HI5UR1xAuoGg87C/A7S0AEOU1uT/oGvh9LdKjlBy
 p0rujB3qHgXVD4bBt410bZvhSlcmH2VkjnwSqYAl0z7YIhg7ScuqrsuMEEIDnyJBdo/1fnBcqcS
 VIWyqVrrGE3+dX1s7Dtd4SaW/W5cPDiEjzJbC7IfSHTcWRTRHiRVvQz47dInGPRXIJYDKkP1IId
 HQLKkT0HEGhZeKFJCZEhl2L0JRyXpjMWR9YxYUAQl8gjqlFDzc29LqV0RQRo8PvbGnQMlsQ3nnm
 V0hs5SgrSVE/m2epJUZ+xHrnlFK9Ff0U+eN2ML1J6s9dwPtTyc=
X-Received: by 2002:a05:6830:6d18:b0:7d7:d0a3:eccb with SMTP id
 46e09a7af769-7d7eae61eb3mr9811110a34.3.1774295469205; 
 Mon, 23 Mar 2026 12:51:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadcb757sm10388721a34.15.2026.03.23.12.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:51:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/2] env: remote: Disallow CMD_SAVEENV
Date: Mon, 23 Mar 2026 13:51:06 -0600
Message-ID: <20260323195106.2362981-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323195106.2362981-1-trini@konsulko.com>
References: <20260320205335.3788760-1-trini@konsulko.com>
 <20260323195106.2362981-1-trini@konsulko.com>
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

Looking at how the saveenv portion of this driver was implemented, it
does not appear that it could actually result in changes being saved on
the remote end. Update Kconfig to disallow CMD_SAVEENV for
ENV_IS_IN_REMOTE and then remove the relevant code.

Signed-off-by: Tom Rini <trini@konsulko.com>

---
Changes in v2:
- New patch

Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 cmd/Kconfig  |  1 +
 env/remote.c | 13 -------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index bf47b440756c..24dc7fa54273 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -717,6 +717,7 @@ config CMD_GREPENV
 
 config CMD_SAVEENV
 	bool "saveenv"
+	depends on !(SRIO_PCIE_BOOT_SLAVE && ENV_IS_IN_REMOTE)
 	default y
 	help
 	  Save all environment variables into the compiled-in persistent
diff --git a/env/remote.c b/env/remote.c
index 0cc383c23602..5dd929155a43 100644
--- a/env/remote.c
+++ b/env/remote.c
@@ -31,18 +31,6 @@ static int env_remote_init(void)
 	return -ENOENT;
 }
 
-#ifdef CONFIG_CMD_SAVEENV
-static int env_remote_save(void)
-{
-#ifdef CONFIG_SRIO_PCIE_BOOT_SLAVE
-	printf("Can not support the 'saveenv' when boot from SRIO or PCIE!\n");
-	return 1;
-#else
-	return 0;
-#endif
-}
-#endif /* CONFIG_CMD_SAVEENV */
-
 static int env_remote_load(void)
 {
 #ifndef ENV_IS_EMBEDDED
@@ -56,6 +44,5 @@ U_BOOT_ENV_LOCATION(remote) = {
 	.location	= ENVL_REMOTE,
 	ENV_NAME("Remote")
 	.load		= env_remote_load,
-	.save		= env_save_ptr(env_remote_save),
 	.init		= env_remote_init,
 };
-- 
2.43.0


Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA2606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vboBuRX7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfI59Efg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAF5680C41;
	Mon, 23 Nov 2026 09:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EWrkN3kshU2f; Mon, 23 Nov 2026 09:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F302380C43
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795427437;
	b=HLI6PPj3gTwB250EMitgU8b0khCH7psuBwrMbtoTBcVbC2RXdgdNIMeE+u+C+9q1l7de
	 x0rqZAlZ+tdqrXasAhPKlrTXJKMg/S2bzeFHXj2adpqWjMiM+uGvCNAFOziDXKPFWYu1G
	 AY96SoZa8muTKo/FgQm5EmyS1kc/L6jKwfa7FzWzY4Fv82sAYlGMiqkgoJ63lf6/vLxlz
	 ss0U1zSCGzXs2gAHjHEh5DHkZMquWcqQUHKi7e/xB6Yi8v4GgvrPqf4poe9vpvNY+yPSf
	 WzcUz10v8afXKQEK4j1XfraWEY7l7C3OLYqqnUObJ8SxoHMT1qoaW7OhgmhKUuesNag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795427437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5K3M9msUSNvLizTuJl8INTIPFQo0ihf2Zc7p98JZtrA=;
	b=PXWhRN8/621q06ksHaAyGqHshDIxQ96nT85yrkwLyKvRPqC6Z5yQb4QmH7o9w0KP7Bis
	 OkXde5u1cevxZPlBDPK0IP2+DAkV5P+uwivaFd2ZzYo/ttanodhv6UM6zSLqj9e6mNR/Y
	 wZ5VXocxXbU/J1AyylDRbuUQnlwhlaX4HOlD6h0dcNMkKoSxyvQzImEX0OAGYUM7iDUFy
	 qTXhW9RPvhr4FBKwsTAYVC8FBG6ymxRlGEqrZnD6IMeGg1BzOlW5IXkdFDf26c4FSCnX4
	 5wm4vYtMoftFvlQSFROg3Lev5lTh0MjcUVdbXsRWzu2Gxaqxl0XllDWE47JAMsBtpiQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfI59Efg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795427437;
	bh=5K3M9msUSNvLizTuJl8INTIPFQo0ihf2Zc7p98JZtrA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vboBuRX7BBxxRb9u5zv6tpfCstBBEvR2m7dzlWJVbDLFNi35MbiYmxTCk0CWwEjY8
	 eBofeSJl1jJS7ZNv9YMJuxoMS6A5JrCBqMEtKnyNgQ9yu7/HSUHXFkKGbnVQNv8WaR
	 pXY9j7PmqiwYz2beFAEAwNtO0lJA89aS0lpgKcWAyMnmNVri+n5n+lji6qaXbUYxzF
	 jHeJIM4xFsgsA9qMjHr/iKMncG1bUhaedbJS8FFshwNyiTf1BfaWEYZa+uhp1cirfZ
	 W8f8i2afo5cETaLoi0InhhAsILKRfvOua7xrjvVhMPoT96Gfq0exJO6EWAi4if1wIY
	 e5NTBQkau3Crw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F302380C43;
	Mon, 23 Nov 2026 09:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 741241AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59FF680C43
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wwPGFnn8AmtN for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:50:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6AD6F80C41
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=hfI59Efg
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AD6F80C41
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:50:34 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so1587475e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795427432; x=1796032232;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5K3M9msUSNvLizTuJl8INTIPFQo0ihf2Zc7p98JZtrA=;
 b=hfI59EfgUVm5BocGu5mS0k0eiaA8IiD6EpU0SfflasaXAMNmjf01YWHG6m+/k/jloj
 0N+2z8gl3FzrMM2bc+WN+EP73gohGAPxFZMwftFM/2o9tHCQ9Fe6EHc12NrJCLFsCAH7
 1+XaX5cVuyk8V3ml9iBRCxjuhGxHqc3mLWA1/mIt9yTbp28Mc4LIrnRBfgQtEgRgHQSW
 WJ2rNKlaiCtceOIr/pZOkDdEtpHBMwL61zTCVhBrQD+GHwG5v7Pe6DyGXqdeEL+kLeJm
 Lm8xIOqoP18HaYKQO+hRuw38LrOySInq/nlQnhvVlsUB5oP5RplApFOy++ApjBbDR+eY
 5o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795427432; x=1796032232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5K3M9msUSNvLizTuJl8INTIPFQo0ihf2Zc7p98JZtrA=;
 b=uhuGoDssjVeQT+Mh45qlW8mlxqgpaDoPl6e+YBrJYMP583oE5qXaxNji1GP+SNu+VW
 UvAujMFFV0e2RZYD7xwGlcQQM6spqy2/opkLXHyW0yTGEjlokPBwNQSMhNV5fu3cg5eg
 gq0/fKOHfVoJ3Q3OOf1JM99R9s499UTZYMbAQ7gxvpUvKgK5b1c9PNqaZUZ5BTchMcUI
 xroNUf2FpmhYW5AeDp2TgAeeFcn+DYMLLBQ/4Fru2r1/SYRnuBUJ6JvtV8Erml5qbUPf
 ORiEEPGBJHb1Qp4E11rY6Nw0ztWy/2+Nas9X2TBoeqjiQxhNfY0sU7nI6sX2FDfAr6+p
 mSww==
X-Forwarded-Encrypted: i=1;
 AL+hErG7LvvEB7GcoUUMvDFVKU8pjtQrO12jNAI6vhAdqMv4ykjdG/TeUJfQgtBIlhM4k8PTypRN6l8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z95lKOCUciDyWfsy9ZPDSgJFMSCMRDpd+Xc5CJAdhqZQv3b/Je7
 CzhpDM+IUBtHCLD2OwvwfgyhnHFTXH3NvEvRYRG7JIBXTwMT/8SsF8Go
X-Gm-Gg: AZFdTZdJWWvqGnDgylg1Re8xZMYk7kpho78zRqtMuC8w3sg+I0ffzTg9cTryRJSffgT
 Z6UqphCw/CJP3Usiha1G2bCTbSgeUEkDQFLqo1z2B6ARTqJbKhLfLQ0LbDgi/+6YhVN1YO7lxwu
 CidxgMaD93l9GCTLJRem8/iKti9gFwO4LBV3GXNj7S+YcjutsxbnxNOIb6vLzoBYmxgdEW2LID2
 scD6ivcW0u7bxDI3axKhXtyuY316o+HyK8qyyLzZVD4TdhveUszf5PqVt1MXsZkoiKL4gycuJak
 miR/vWWxBkM2nIf3V9TjNCjkSsjxENjeT80kjTATqwA2LYer9xI35iMKf7TkS6c//5jJJ6+Nk7k
 9Ni3tIbdIn11lKdz8bgdL6hAtmGxhXbghTnXZaHGkETzsf7e5CeCVYRqJBG/q7mbmI7aK43HKVp
 YHS9rnX2A9zZwn/m5XJkvbQtVy0Ixog4hCG9vV19q9GtsLWqiph8BhFhxHHgTW9Kb4Nza9FZDHz
 E9B8Bqw8Rk9xvSjmOS7ncfpDsoMVNudIPlspckyyIUw9k1DkFd2xoCECtSwlNloyp2gvzpJd8k3
 MAi2AT20QlfxRS8ZFD4GV8g7547mKnlfkiBHR/abt3km0zFrjASecq3wzSdp4kV3gipKkV116+t
 mwGtdOdBy5WzawsNhVrczCqvGJLRMSvgfUkC3VbH4y5M2vDdq910bdR63bdgc2AjCRlsk2y9F9v
 ZbtlAu6v9CI1yE
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id
 5b1f17b1804b1-4bb88819940mr255363495e9.30.1795427431869; 
 Mon, 23 Nov 2026 01:50:31 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm299646975e9.9.2026.11.23.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:50:31 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] Makefile: Move PLATFORM_LIBS outside the the whole-archive
 region
Date: Mon, 23 Nov 2026 09:50:24 +0000
Message-ID: <20261123095029.3014205-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LTO link passes $(PLATFORM_LIBS) (-lgcc) inside the --whole-archive
region, forcing every libgcc.a member to be linked. On AArch64 this pulls
in members needing libc symbols U-Boot lacks (__getauxval, abort, stderr),
so the link fails, e.g. on p3450-0000. Place $(PLATFORM_LIBS) after
--no-whole-archive, as the non-LTO link already does, on both the main
Makefile and the XPL Makefile as they both exhibit the same issue.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
- Also Update Makefile.xpl

 Makefile             | 2 +-
 scripts/Makefile.xpl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 519866b82ea..e31b43c3d10 100644
--- a/Makefile
+++ b/Makefile
@@ -2093,8 +2093,8 @@ quiet_cmd_u-boot__ ?= LTO     $@
 		-Wl,--whole-archive						\
 			$(u-boot-main)						\
 			$(u-boot-keep-syms-lto)					\
-			$(PLATFORM_LIBS)					\
 		-Wl,--no-whole-archive						\
+		$(PLATFORM_LIBS)						\
 		-Wl,-Map,u-boot.map;						\
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 else
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 77746ec07cd..3b87586fa7f 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -521,8 +521,8 @@ quiet_cmd_u-boot-spl ?= LTO     $@
 			$(patsubst $(obj)/%,%,$(u-boot-spl-main))		\
 			$(patsubst $(obj)/%,%,$(u-boot-spl-platdata))		\
 			$(patsubst $(obj)/%,%,$(u-boot-spl-keep-syms-lto))	\
-			$(PLATFORM_LIBS)					\
 		-Wl,--no-whole-archive						\
+		$(PLATFORM_LIBS)						\
 		-Wl,-Map,$(SPL_BIN).map -o $(SPL_BIN)				\
 	)
 else
-- 
2.56.1


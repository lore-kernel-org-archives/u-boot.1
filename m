Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064AAE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 18:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C4180283;
	Mon, 16 Dec 2024 19:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xw/TgstS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB99680219; Mon, 16 Dec 2024 19:07:59 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC71800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso29148765e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734372477; x=1734977277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXTyJT8Kh3DOrL1JtSrCwhbCjoUD1hli7zLJmiKB3T4=;
 b=xw/TgstSA/1iHe7dZ3O2mv9z0pmUQwjswshY3qKQAtHIKkdtCbWRlBYHX/im1cV4zV
 +ZQEQfgiv/9gWfx+wfO/EeWes0i6rlllUCKAggi06ZopJVIVKKFZZAe3SjhtgUMCSUUu
 C/0Zz2hC04FqkcikOAm9d/mZMC2aIBtnj8fFbQ9mDnJ5rbpEaKxRYJMWdhpfNOod18sD
 EoBSaK0Lu2Ik53po1RiHb0DEMQtR17yV0GWDPyzPxE3hXXtMJ+n6iscTVRIk+6j1m7rV
 gLH/vj4zywC9pe/g2GRRgi6NtySWQf2yW7E/FJRyz22O8RIhdqnv/mAgXpGCHDWeJArA
 88PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372477; x=1734977277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXTyJT8Kh3DOrL1JtSrCwhbCjoUD1hli7zLJmiKB3T4=;
 b=T8SVHa9MwGRtTlsYk+L7+FnEtlfsLiy2zpqaImC6lvqwUfQpZPQ68crn1586NsBbM3
 TUg1yAdLhII5cesy0AEMNSSOLuAk0cdK+w1bdd4eZ+BS8o/hfUqMhQfQuiqhWPQWuWw8
 jtd+jms5jphO6Hi+0emTM+N1n6S18sXZCTlIWLWpJbOMhuZnpBYLOfBW5uUlQ40KfXnK
 Hl7gHqoOUr0WNnbuJ+i3saWNERGp7xpvw09m5LOwpLKTdBMCQW86pxwYrYO1DJigqKgA
 spXGD2RXS+JXelG7Ei2FZlSUxY9KB8OlTR5xshNj1YKcgn/B4PiV/oh9Or+s2ugQO/BC
 lsuw==
X-Gm-Message-State: AOJu0YxH/Ny1Lvx/qFvCbP1bNdzK8waBoIxRZNQhPrCoy6W1TrD35LPu
 Z7ebGF1kVNa2kYSIeUE7dDGo4giEz/DsD6pZmpmZje+7HC0x+W6BsHT8HCa62LF0GjJucc+OODU
 yuEE=
X-Gm-Gg: ASbGncsEW4vglsvB98Pcg2/ZdpNNPPcb40wIM/llW+T3xcbQNwnHAaGgBIGRkndZhP5
 CSfdtDlfvgya09Vx8leXlQSH+ZafKayov0rmZjYVo1ITdTzivsL1S4QkOoJmbLLckSffStX0sXt
 e7vM9uNlKqSRWoCJUoCtTEtBjszwjI/2i/P7cL97pT0P3nLVPe9Yv0hyhfk+OE0anOKoOhbjiTX
 pfeui+o6Ay81XpaiKVdXUt/SL87K0dOwK/X10LHEHJzt/bVDI39D7lTsRNQ97p6CCk/pnfhaGSd
X-Google-Smtp-Source: AGHT+IFRDuIyIkaow8dJUlt5UJwHdVTAHBBUgZNbaORX58umyHuQj2oIMdB2wAbfJU5jgufoUUtgFA==
X-Received: by 2002:a05:600c:510c:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-4362aa3e398mr135996115e9.16.1734372477303; 
 Mon, 16 Dec 2024 10:07:57 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:ee3:c001:477a:6a2a:86f6:a454])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436360154absm91501605e9.2.2024.12.16.10.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:07:56 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 2/4] sandbox: select CONFIG_64BIT for sandbox
Date: Mon, 16 Dec 2024 18:07:34 +0000
Message-Id: <20241216180736.1933807-3-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
References: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
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

Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
static analysis tools.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

(no changes since v3)

Changes in v3:
Updated commit title

Changes in v2:
Moved select of CONFIG_64BIT from SANDBOX64 to HOST_64BIT as
suggested by reviewer.

 arch/sandbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 1c8353d615..db29ca14bd 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -46,6 +46,7 @@ config HOST_32BIT
 
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
+	select 64BIT
 
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)
-- 
2.39.5


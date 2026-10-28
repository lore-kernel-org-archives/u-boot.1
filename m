Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lnkh8feB;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSfWwky0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 328AB605DF;
	Wed, 28 Oct 2026 12:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8CSrPiKB9pAR; Wed, 28 Oct 2026 12:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64617607AD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189611;
	b=YGQSV+fAIE+3wTZoLzzpPo8tGFmdAI/ZiBdSRa/HzZLiriQSr/vLFm2sGEb7XGS+A3Za
	 Ng6kgQeGzjZfVD0dVzO54CJjza+arU6blj+2HwhPfXxueuW7dZc/sUcY+BMC+zXJHKyGv
	 HaacSm79mSJq/n3vhqvT9FRnpiCOvIHL0UsFbGDPV/6r/0euQfhNy4YKr7u/pv9aU2xky
	 SwEbXffaqJ0gGAaNOfS7zDEFDpH6hoCeWdlm9oMYIN0f8XjZXgK3kMQuTIMNeZm6IONAl
	 lRICxIa/QVq8LjLCzHCGVLTlcTMzNtYT+pznja8cPj/DAAtIRndFKQa3jysPkt82mhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=71Dg0LOSZPun/xu6CZ6GxjUfRhPjZ9G0kuedCGV5cEA=;
	b=J+YsZlBiCKF4AREFk3cb11LEFaUnngLKf/Y3WFA1RanWZMN2miY6XQu7rEIqcm6Bpmc9
	 8x4x6sWr4G14cJxW9pAxQbNKfFX0ORRlXXFerM9kLEHKiSRvai/CEnEbpWZ9KiP0cFlPc
	 F1T8rIYX94qvWBPWPfuqgYxHNkj0nrgpDhkeTE9PPjsPwocm7O4eIqut2JaXmyUxTU1e9
	 jwaLQT3r0WfED1WFL4NwRCBSDRVep1e+XqI/5/3QbVb0/gWEjO8JfMRNJX7XGWTVjFZtm
	 imNTke+/r6DFPyNQZDex/dgeHGAlnYEobmmGRwmsAUlwOVTkUIwz2BIhGWmbFHeYygg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189611;
	bh=71Dg0LOSZPun/xu6CZ6GxjUfRhPjZ9G0kuedCGV5cEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lnkh8feB1LntkW+Myx0B304bZYp4xqjedd5RliqKyh9AgWIyd1CGDjPuXCG/wN6kk
	 39YvMvsobGI0mvXrgRSkRJeoJJz4RiNlzEMBodtX6C1k5nuI5BHzUKNibMihe36VkQ
	 Ngz6jDDoAWUyPhnGj9cjT5IBEXNn2ggFVsJTqS5hlvcvzk2+isgapJywi/3/mX8/LT
	 l4zzczYBCNAjf9hVQp/btSbTRTUUV2Nrcw1FoQ9eWKHraQ5QtaqwOZ/Yxva1pvSIlO
	 d0ELQZuYJVCD8U0J9tXJVrAtYcnBeKWKwm3Ff4PcRbwj4AE4QlEqJn3XlbdPM5zCfA
	 0dRNAhElH5vHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64617607AD;
	Wed, 28 Oct 2026 12:13:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D6FF356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03B774006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZE4JNvOzjuOb for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 27EE74009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189602;
 b=EcQqOKPOVFKJcDdcx7K6j2hmbCjb0wupg0kEj36Zhv6AUh/6SRDxWUz+0HPo38qpeh+2
 XTdncu+wBkJZYoP8n763t5RLVXe1AgRDSkou9Ct3RrKExcqdc1j7y1trDRsc5nX7sjY57
 /LNqbfx0N7Z0RIIuDCJCjk4ke904Sal0qqHbWR+AQjI/otoUSbfsRTg4sovFgaBeoOBXO
 6h+ezfwGeFMIS0f4rayHLlAxV7Bsi0rXR9LaMTeoC1FY14mbCvFQ90o3H1UpIuH/++mzZ
 vTcJMso3UMOdvHuSvzZmxnhrW0moMIf5Nj3jO/sB7BzvMZvwX+yVf3QTeptnFhfEjxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189602;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=71Dg0LOSZPun/xu6CZ6GxjUfRhPjZ9G0kuedCGV5cEA=;
 b=g9UrjzkL+9hB9ZjwDBnCN5SDJb4gVo13CeS+sSJGPJO/RPDwpI7p57vjzAh8yEnd+95b
 EL/SJHM63Rhbx/3qE1dPCSggkvhDE0IcwGXJOc6+N44n+FIalHJDKlfqZ8tRSa6FVQlUN
 fopbwM9TH1t/Rjx3PHQyA/OUQZimH9/3O2eJwEHTM2fPJ5osmGB1t7JNA+rgDuv2TJZh+
 jk8lwnfwoQdZOyD/BaKR5ZikuLYrsQFY9WE6B7ugxIG8ZpewfLpTHo4CrXrQBq6N/bTDT
 Q274Mgv2Fjtj28oaciYl343Yljh8caByLMXKRrsWXd3w/XGwOPK4EkXD30N6qIi7stg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=LSfWwky0; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LSfWwky0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27EE74009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:21 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so9152775e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189600; x=1793794400;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=71Dg0LOSZPun/xu6CZ6GxjUfRhPjZ9G0kuedCGV5cEA=;
 b=LSfWwky0rOoVojQYJH9+R/iv5bBdvvyzJ2vkRxbKr+G72vWnyHIVF4uRgIWRSD4JvS
 ikiugVx33ViOK6RFzKsamXUEwiZCWF5hoLXDB38XekLkBVSdpS1WF+g5+rQh3fb3eLGG
 FByxwW1H1AAgiPFnSCSGIKtB+jO4sMV9OYlfJ9i8trBugptsffx6jbgDn6QwsmkFZrhB
 56yNzNEiH2YKQM2l9+ND6ltboig+FizDrwjhYzVM/DCMEHlyCm/gLKCSVeKJc2Ed7i1v
 tBCGKDtPFyDb1NJLVghuy80j0KZHF2xJ+akliByRmBshM0tKdPUju0AmaZcZr5u0PtYN
 dmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189600; x=1793794400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=71Dg0LOSZPun/xu6CZ6GxjUfRhPjZ9G0kuedCGV5cEA=;
 b=p+B2FXjICSVDZsmjVLnKThbOAKAsCK0qvAn7HM7f/gJ+G2lAVZ0EK/FT7MM2zu+7ol
 8o9EeNTsrBsGqyJEalPvvxMQCNlJHTUNyLl6+SAMyBW6n3dzscooYvR652gyBkWnCqxn
 kyfWKYkZsKrQuv3jA3mXWHZCBfKGFhP0ZKD1lP148v00NtQAFPMTPQ1TzmwbUTqlfFHF
 37H9D0spx1Ql3dW2pJskkLRwBy2She7ZLOSjF07vX684LEz3KgTz8T45pwcUc4CYyNBq
 tM4QTQdAaib5+1ehx9+otVi1TeCOVN1YI4KVFA32xRugflnpI2N0xgqtwjB4jjieVNqn
 3czA==
X-Gm-Message-State: AFq9FYKScwmHAXpplVj95gfF/ySwOvwnKgY0RPKmUEty3tHcZXqUGFJu
 cvsiEOkj8QWOEZa/VJZwHDO5an33h912y074GLVkCoFCyPJXXmJzu5rEdAX0XMvc
X-Gm-Gg: AYBFou2k0MBClyVfAHEwYswD059tfhoEe3X+UWJkixH/aCQkYzmYJLdEvnFxbGp9Q4M
 O0iBiu476QewHJUhHkiMgyrYcJxAI+u3dZE8FwxU7DoD7Ht+ethG7b7C3Jqex3G145HWHGAtikP
 xKBlj5c/dL6GtYbN+bOwM+i70xlZ55m+hJeGR43LWeuzEKwanFhZTOOWvshqn3mZsJZFC5kMaVq
 YQv7youROOq/5k8aqHDP1/w/NvskayJDhNnXaBgGXpL78zXDH1b3/wYGz8wpeI3NXhupq4KfIAO
 ehHpuF1rm6PEpT3EYpv1AYS5PjL0WSXQwQLLxcPbFcMsV2DSgRrw7TxyMIADfGW81KxtP/bb/56
 TP1eiS7iipjAllG+d4AWEZ2S782NI0sQpooN1R1H5bVR1KMIBddWTfoC8j1z+9AfmR3pE6Adbtm
 0OsGPHEza4M+oDBMfr9VsyhzG97cLe9H6FQR9DzNpI1KjcunZAeEz/iOxde0zasx1L+6JjLfatl
 eGKPBzGRvC2YCXx1Ih/S5nP3Epn6q+/pKuvVpDjv/m3zmyJFL9ILcegfJIesx0bNoeo885WNJQc
 yO4J8QeGpybUn4abYqv26rd4zx9sQHaXoljyEQyEgfXEYsT12Cwg4VyCBJ8C4a6dhRjpYp1Z07f
 VvGBZjK9lkaBy7hhq2JDL2D/ieeO+CF6+3/Sr4ZB+r0lfyXlNhsoeyl7zoWvGjNVuIyUY8FNd6z
 rIFfVtjTFnFAbN6SoQxD63rc9mwELxDXygGP3ZjPpCfCFPY9BDFT3E
X-Received: by 2002:a05:600c:1f94:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a9663995a8mr47229155e9.12.1793189599773; 
 Wed, 28 Oct 2026 05:13:19 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97a093e86sm41139085e9.1.2026.10.28.05.13.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:19 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Sam Day <me@samcday.com>
Subject: [PATCH v2 4/5] arm: Keep --gc-sections with LTO
Date: Wed, 28 Oct 2026 13:13:12 +0100
Message-ID: <20261028121313.814-5-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121313.814-1-pepe.schlehofer@gmail.com>
References: <20261028121313.814-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 34ccadcd3334 ("ARM: don't use --gc-sections with LTO when using
private libgcc") left out --gc-sections for LTO builds that use the
private libgcc. Since commit a55014d09b29 ("Makefile: Allow LTO to be
disabled for a build"), the condition tests LTO_ENABLE, which the top
Makefile sets only after it has read arch/arm/config.mk, so U-Boot
proper has been linked with --gc-sections ever since.

Once the next patch sets LTO_ENABLE in time, the condition would take
effect again. U-Boot proper would then keep the sections that nothing
uses, such as the .discard.addressable section of keep-syms-lto.o. Keep
--gc-sections for all builds. This changes no image on main.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/config.mk | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 7e99e61ca82..6bbc7df3e5e 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -13,9 +13,7 @@ CFLAGS_NON_EFI := -fno-pic $(FIXED_REG) -ffunction-sections -fdata-sections \
 		  -fstack-protector-strong
 CFLAGS_EFI := -fpic -fshort-wchar
 
-ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
 LDFLAGS_FINAL += --gc-sections
-endif
 
 ifneq ($(LTO_ENABLE).$(CONFIG_ARM64)$(CONFIG_SKIP_RELOCATE_CODE),y.)
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
-- 
2.54.0 (Apple Git-157)


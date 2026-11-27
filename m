Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA1606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i6sLwnAM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc/zReih
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4C3E40A49;
	Fri, 27 Nov 2026 06:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56woNRRc64Gx; Fri, 27 Nov 2026 06:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB49240A3F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761408;
	b=DyXF0u4vstjqBk4iFYmcDrr/2VgelrP5tsD3NFhYTwAUkh2tfvX//RaXuHP5Z9WcqxfQ
	 uiTnOfoNUVDGBVErjFN7J8W4uHcjcDw2z8MDbcosHrcuMCKBMuW6zKoYS13ThQso2oAmL
	 +sZvVK+M8MMI9AleobiBEehtsJ5vsUcIKFg4YUubW6r8pO4fD1qosmx3bWlqCpHIqEaER
	 RBCFbCjJVOqOThYLiLEx7sfNTzLCxGFRqX9n3sHLd2ATbasAhKdSlHZ9qB2myn3TQtwOm
	 BiN9N+wHMxuNj6afGVVqW/oql8eCyIwFLJRp+i2GDvFUMwERZ2xaL0rCalueeOtsTnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4Cpr70I1fz/b+uYcWeaYS/CTl6bx7akzBYFYjrvieWo=;
	b=jJcr225YEwivhUH8iYbSgoifnjFIMENpj2bfcf5uFPEq414bRcdzT2I45tiwe6kmqeK2
	 6k4sYBoT2IR94brcR9Eh2lMIhK6liX4UATz2vBwXyi/4ZadeGTQXLvCnHL/NRr9ogNTeY
	 lGOw0HHC8GGzC2tbaAG31476KW7GPmhLJOtrD6KJT5qZY83pi4LlJqzITN3ymkt58vXP4
	 rmWO8DAjxLSrhsPhvzsn8Gchy42MdjeAwS7m1q79Gg290IiYSaxnTS1mmdCkhMoEV39WT
	 CZSzbTjzhHjjblKdoAaJ+plbW5p+LO2yIwXKc25qpKrDPydWAxrvV/6vDLT+H3hiA0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761408;
	bh=4Cpr70I1fz/b+uYcWeaYS/CTl6bx7akzBYFYjrvieWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6sLwnAM8q4PGvFETtdv1b2I/Ui7m873IBRwzmiKAWTm9tV9FwA5DyFcpfhaCyf5z
	 K2BOnpixQ5kUXFNaApkC4XA/pSYVCWZN3aQklGklo+ehLMkGOnEH0d/j8AutTvy9cc
	 qPUvyA8P5MEJg4x5QS5qEgpEuYtTpuaMD0zcDRDzFmBNbj2uEmUKaAHfg5iVyKngZ5
	 tK9B88UjjQWxgHnbb+YEdUWv9jWWp8ABRU8xHg/HZDvy1K6gdXKUEwOyXoGAdR9YvR
	 U36M0i3sS/jFpYmEpYo52qaVelBsyxUaWA//9NLdqeTji/8++2Wq4/PWtxNiiRvAsb
	 7mwrIMONM6o7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB49240A3F;
	Fri, 27 Nov 2026 06:36:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A334E325
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E1A160AB9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6CKgA4tm8sl for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABA6460AB6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Lc/zReih
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABA6460AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:41 +0000 (UTC)
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3863db981d4so10868912eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761400; x=1796366200;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Cpr70I1fz/b+uYcWeaYS/CTl6bx7akzBYFYjrvieWo=;
 b=Lc/zReih+G5hY6aRqbhtzRKEpuI1nNNb8VcSnXWSZJVhViyjKU/2KwnDd2jVwBdbT2
 mG9o8wWCRnwbTptah7QaayoLkX6yiAFafE5vsnl8MaMjyZsODcayHI/GvO44ad4TUNex
 vRMwSotRhOz+fOUdPx/ES7y/xb1L5bn5IoHNetTxO4/oE8f9bGQcx/88dyWcH7xfQAel
 pjcqw5hKgPz2GIBJhefqosCfEq+cmdJnhohpGUfwAZcSJBDqlJ+jKHQdX0mEwj0Jgm9f
 MtA7IZOssj3BsG8cC1dBFVrQuki7Qz3wDid7ass1f5cWn7OFMLwLT0DX+d3ZPHNk3uQX
 MR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761400; x=1796366200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Cpr70I1fz/b+uYcWeaYS/CTl6bx7akzBYFYjrvieWo=;
 b=zIbziB7tro2MFMvBmhNDeqUlJptH7zYsRU5IPwsnjYzPypTBuTJpMr6N2NKAgNxyPl
 vPuQCXGfqRLTEw+8r+enVszPt0+ta0hXt9DkOPPcNF6MhrBkZtdGKaWzN3aAso5xwxIq
 R0X5Kp6fcpDyGZarBXfoo7Pkyz9EpX8n+uQMuxtaAya6J7YRhJZ6qcVlRDjEKijH3iaV
 Q52Z09htCQh6Q2twfg/9fVDlcZ7jsR2uMiPpVfcmuhkvUJ37RygvOvh6fyon9UCZuJ+0
 FZdv7EHuPe44Yue9liSMhB1oZ/cfqXfAMwa8BDgHlm3pKcsNMKx0UlBmnvwAMjylFZcf
 fEMQ==
X-Gm-Message-State: APuU4Z+kLx3zk4an9LG7ZLwonOKRBgbSdk8JKBMDc4unUB8bY08erNSG
 egQ0Sf+yXgtmQhn9Asv3+XEXXVprOHIvjqdA+/Bcna9H7uxZf+mXwJ5T
X-Gm-Gg: AZFdTZeH38si4IkYF6oTBX9F5lLDTvJsuT4ULqV5u34a5YCKT7pem5gH8rYStBl5Hob
 uMqeerScUZ4H9EIpK0fAx/+eAAOJy9FulfQahs5O5jlLRCZqc9yd2fEMsRAcVSBuSWBXzkTS7bl
 +CfEVP9AhakOYRVnuaNqf2rwg3tXURGLFw2QJtiAv/EuSOT//ViF1YPgSJ84D9/KInKrd8mzpty
 4KEVLYzJcbWsKxjDssjm9F04udpEsu/RDbe7QZsiwJ88WiD++FuZT6hlpaoeb/V3h3E69Sgq3vc
 7xHGlzPCvvK+UodlM7KvVmHEuEruZ38DmOjNpEFhoevNAZ/co142P/4ExCYG1gFu02IgPl0sPKr
 B5CntYfP6DuWcs84whoRCO7ochuOfQxu0jlODMG9qkhGkCq4tgT28W+vlgAPC4jdWkDxjcYUZl/
 XCXKGN0ZfrweeyINRv5BqHh3WK5DS38M4rdO3G380D1vtUWodJYfbJmJfAbHIjUDOQ9T/T44piw
 bnurKxoTy4LT9fAwWN0W7MWTi7pugc6FUflQMSvFdzMXj9AKXtXHeHS4OaBjVSuQuGDKmcaADyV
 GPLEjWpluQtkFFdTPHirPTchFzEKL0WlMwD0SFNOOWFFo5Yf2dbqrQk2FTUeubsLopBGKcNzjFM
 r4lgWvjaWom1F2CI1mb7ig9krejUuOXKK1/2JJkz02o/c
X-Received: by 2002:a05:7300:f68e:b0:386:240c:19d6 with SMTP id
 5a478bee46e88-386241b6d72mr20481424eec.6.1795761400503; 
 Thu, 26 Nov 2026 22:36:40 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:40 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 4/8] arm: Add Google Tensor SoC architecture support
Date: Fri, 27 Nov 2026 06:36:16 +0000
Message-ID: <20261127063620.399391-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
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

The first four Google Tensor SoCs were offshoots of Samsung Exynos
SoCs. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
Google Tensor SoCs are of Google's own design. Add ARCH_GOOGLE and
the mach-google directory to support this SoC family.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  6 ++++++
 arch/arm/Kconfig             | 21 +++++++++++++++++++++
 arch/arm/mach-google/Kconfig |  8 ++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 arch/arm/mach-google/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 23711e5c41d..af52a4f60e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -356,6 +356,12 @@ F:	arch/arm/cpu/arm1136/mx*/
 F:	arch/arm/cpu/arm926ejs/mx*/
 F:	arch/arm/include/asm/arch-mx*/
 
+ARM GOOGLE TENSOR SOC SUPPORT
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	arch/arm/mach-google/
+K:	[gG]oogle.?[tT]ensor
+
 ARM HISILICON
 M:	Peter Griffin <peter.griffin@linaro.org>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93a0c663043..0305d296eaf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2257,6 +2257,25 @@ config ARCH_GXP
 	select OF_CONTROL
 	imply CMD_DM
 
+config ARCH_GOOGLE
+	bool "Google-Designed SoC family"
+	select ARM64
+	select DM
+	select DM_SERIAL
+	select OF_CONTROL
+	select OF_UPSTREAM
+	select POSITION_INDEPENDENT
+	select SYSRESET
+	select SYSRESET_PSCI
+	select SYS_NS16550
+	select SYS_NS16550_MEM32
+	imply CMD_DM
+	help
+	  This enables support for Google Tensor SoCs starting at the
+	  Google Tensor G5 (Laguna) found in Pixel 10 and later phones.
+	  Tensor G1 to G4 are offshoots of the Exynos family and are
+	  enabled via ARCH_EXYNOS.
+
 endchoice
 
 config SUPPORT_PASSING_ATAGS
@@ -2361,6 +2380,8 @@ source "arch/arm/mach-davinci/Kconfig"
 
 source "arch/arm/mach-exynos/Kconfig"
 
+source "arch/arm/mach-google/Kconfig"
+
 source "arch/arm/mach-hpe/gxp/Kconfig"
 
 source "arch/arm/mach-highbank/Kconfig"
diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kconfig
new file mode 100644
index 00000000000..bb74890b457
--- /dev/null
+++ b/arch/arm/mach-google/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+if ARCH_GOOGLE
+
+config SYS_VENDOR
+	default "google"
+
+endif
-- 
2.56.1.839.g22a8290db9-goog


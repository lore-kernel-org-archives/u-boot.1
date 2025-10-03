Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CCDCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AEFA83929;
	Fri,  3 Oct 2025 22:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RAhslrlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9862583939; Fri,  3 Oct 2025 22:39:35 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88273838EC
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-42594fb2fe9so7485525ab.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523972; x=1760128772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWjaWe5aFCQXSxlq2P7TegQxeRVDecSFr/IuntwW9wo=;
 b=RAhslrljIlOiicLF++2fwDpbiMjU8Pgz9UC9SGH3avUOyopkbeM2mJsYDEieSBCadp
 tW/EIvAASiwAo38j/ZRWZQVrQVSDtTQeOrsdeT/AFjA+u107G0QDcRzCDCYm2XvZ68V9
 9gwUPbfYmN1NzJOmIpvZABOlhlCkQla99cfNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523972; x=1760128772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWjaWe5aFCQXSxlq2P7TegQxeRVDecSFr/IuntwW9wo=;
 b=RjKJXOKunHHjHiVjnjCqeJGTxhZiLV+6Q3BBFqL/vu9Ca1s/KrxXmjzcdLCrm9VQHO
 kP2H+17HMLd9uZ8sitBgpDG5rbDp0p+KGrqibw9fMvM3SIcoJZq1H8N96bClueXjzbJZ
 m1Eyc9JK6tbqh+22N1rWvMwfYd3rCP8vWmhSGpyUJiIWBtnfUYL3iO3eq7SFlzeq0JZ4
 ga9Z6pHtSWQTML5X+unO2egOBTA6JJpmRWNsb++G7i4MY6cOTNtqGohjRZ0HdFah92sA
 p0peIIh/HY2iNSGCMprvl+p+7eMQnlCpcjyTkaKzpYrvjSIPosIPkGTAaTMUlrKEGVz9
 IRuA==
X-Gm-Message-State: AOJu0YxHd9hsR4mVtxiPr2l1tz9nDpKcdh34M6QRDvWRYCwGYcqoCJ7Y
 5loZgCkXHI5laMKos45DbTqSP0VtewJL7J+rtclJVIzQDZznUSp4XNCXyyB+exgGW2nnLgj6jYN
 cn2IFxrk=
X-Gm-Gg: ASbGncstfuLjJ3dmrt/cKOXPOZ09IUojcfNbEheeCx4Oo6X7DjkwDUh3h7CwpWcLCtn
 SkFsHFqGfF4d3PTOfQKVzmrFbo14HLtd2g800eOj2lLTCY+xQm9PVPi0jmOa5EvRJTrjf/BFcIA
 hVCyJvzu0iZr8aqLJfY5lGXtdaufjh+l1/qc/She+ElR+Zd7Ul2kgImhLSDm38o3hjCDfRJ86LO
 o0RaKIWmhkLp26z0HYEeUXL+b1nVIpu3jh2vN95nbd3a7bnzyyq6rc1+69n/caYlmpG97v/isUK
 Nj56/56rno+Q+vHh4gj7fMXQ1l/WDFjbf+HCS5pT9FILOik4Gif169gsaICiV4XrUsO1a0j3QEG
 ny5oMVKxHSGl2h/65nDMb8VgrurKYcfbsqE34Ezs3Dl+dWnH9CW61xKDFb0TqKkgOH6+LxZwd/W
 IKStpiZSDteY6MA1NUibPl0No=
X-Google-Smtp-Source: AGHT+IGGEAruY9Gcgl62i3UAZ7Lz6U5uDVYo1Fc3AEWtochy1jidpZ9/IVNuUMhSQmsP1W5jM9tOrA==
X-Received: by 2002:a05:6e02:2293:b0:426:9b42:24c6 with SMTP id
 e9e14a558f8ab-42e7ad18eeemr60841265ab.10.1759523972294; 
 Fri, 03 Oct 2025 13:39:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42e77bc6893sm15140455ab.29.2025.10.03.13.39.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Make REMAKE_ELF depend on !COMPILE_TEST
Date: Fri,  3 Oct 2025 14:39:30 -0600
Message-ID: <20251003203930.1030078-1-trini@konsulko.com>
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

The REMAKE_ELF flag is something that should be selected by the
platforms which need it, and not prompted for. Start by making this
depend on !COMPILE_TEST.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index b68420022e8a..1d6003426855 100644
--- a/Kconfig
+++ b/Kconfig
@@ -511,6 +511,7 @@ config SPL_IMAGE
 
 config REMAKE_ELF
 	bool "Recreate an ELF image from raw U-Boot binary"
+	depends on !COMPILE_TEST
 	help
 	  Enable this to recreate an ELF image (u-boot.elf) from the raw
 	  U-Boot binary (u-boot.bin), which may already have been statically
-- 
2.43.0


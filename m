Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F68C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 20:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADEF588458;
	Thu, 16 May 2024 22:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ITkB7IHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451A0883EE; Thu, 16 May 2024 22:34:23 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F232288453
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 22:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-792b8bf806fso671521285a.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715891659; x=1716496459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3GUT9fuBM3qeECHLPBdiEk0soYRMwgMa9Le6gnIuuQ=;
 b=ITkB7IHTCt6cx+zpu3UTbDRSWOjfuDguCmtyC/6GCwPhte+CiiFY2mzb5EyTh2ihXu
 GoQW7cGxRPcVobatjpXA+UN9U2e4DVjWItm8PPh86UEmUD42o5uu2wh8qv4Cj2XzMj//
 DaGPmMQTY+rapzA65o2UPYObrBKJMwQzq/vpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715891659; x=1716496459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3GUT9fuBM3qeECHLPBdiEk0soYRMwgMa9Le6gnIuuQ=;
 b=aMKFOh+j7tctSEdwWwZZXrLF3yxETvHT8PwToZlrp6ocDkfzajYU1w5V/GMr2LZOpU
 RVTaiGZWW3/ZXBNHI4wkr3OraXjGPHKcO+ru3FT9LOVAyirSd6P7uZvJ2XHNpYeIlxwj
 K+5b8aZXMYNIg4p4WgD23mX1aWuIDJKLe8CBmTte78pJROcw3LjHht4I0Q89tddlCish
 V/+u7z7nGWWMh1E+Uuh7J3O6ZGBOZJto1tWhlPdUUeyFuJkDEEMrJEHaAJJjnDAaWxBR
 fcOsKHdwhWm2oqBguB+7hcemYfNR+szMyejwETo0uNoHwsufDdL1u4SI204eDR/gIP0k
 yUtw==
X-Gm-Message-State: AOJu0YwNmRF0pFluMEDV374RnuYPe5+Uciqq7wgvRiGec7XEXuGdjfHZ
 /tbqPuY8XOAeNMJsg8RR+7LTavlLj3heXT9suopkDQmeQ/8JI1lSvbSMAVjhAlf/g/MEcbk4lb9
 vRXc=
X-Google-Smtp-Source: AGHT+IFrSNCPxviXHCZ/brvJeeogHiPZSajrNV9VirqWyMGGcwV+hSy2s1NjB9+ROIPy/UT9BdgjFg==
X-Received: by 2002:a05:6214:5909:b0:6a0:5a42:9626 with SMTP id
 6a1803df08f44-6a1681a15e5mr232651116d6.31.1715891659499; 
 Thu, 16 May 2024 13:34:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f20570bsm78234346d6.140.2024.05.16.13.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 13:34:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/2] doc: process.rst: Document device tree resync rules
Date: Thu, 16 May 2024 14:34:16 -0600
Message-Id: <20240516203416.928567-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516203416.928567-1-trini@konsulko.com>
References: <20240516203416.928567-1-trini@konsulko.com>
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

Document the logic of when we do a full resync of the device trees used
by OF_UPSTREAM as well as that cherry-picking is allowed as needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/develop/process.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index a66540a698c1..0542b3fc1245 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -108,6 +108,19 @@ Differences to the Linux Development Process
   In U-Boot, ``"-rc1"`` will only be released after all (or at least most of
   the) patches that were submitted during the merge window have been applied.
 
+Resyncing of the device tree subtree
+------------------------------------
+
+As explained in :doc:`devicetree/control` some platforms make use of device tree
+files which come from a git subtree that mirrors the Linux Kernel sources
+itself. For our purposes, we only track releases and not release candidates for
+merging in our tree. These merges follow the normal merge window rules.
+
+In the case of specific changes, such as bug fixes or new platform support,
+these can be "cherry-picked" and are subject to the normal merge rules. For
+example, a bug fix can come in later in the window but a full re-sync only
+happens within the merge window itself.
+
 .. _custodians:
 
 Custodians
-- 
2.34.1


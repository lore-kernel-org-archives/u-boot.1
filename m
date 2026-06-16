Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9457DCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9A884968;
	Wed, 17 Jun 2026 01:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BY8mKWUP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sgSwlVds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE8C84968; Wed, 17 Jun 2026 01:20:09 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F2F78493A
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gg2yY6Rj4z9t9n;
 Wed, 17 Jun 2026 01:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fEONG8PqEOWFK8FoarFmJZuP5dBvcd4RxBJNOnb8M8=;
 b=BY8mKWUPRCpbXUzgiwGBz5SLMvWJvuTa4sJqzUw8AhFGWaPbP//KiHq7CSrMm4X8BZKeW4
 f+7MVGZ5pFNVcEMQtJAlxiLKOKpdAkM+NH5rd9FigCTyfdCdblBTzZFd8StjrfO0dG17y7
 qG4Y6kGu12TFLwAbO2xhzHtdEo+HZSk554imzrwUjTg7IdlKjL4kd9qiK6tXOirf2xvYQT
 KvVQub2moBNqMF5cTL4RvHjW9BN23HZ5dXvB1/aJwL+161usZZiwqNftUOrRbAfnKOjFn2
 PaYrYcsTKf/93sqbNvZry5SkowyYOlLKBmwTpxx4YszahI4Y/3B88/xlg0Oqmg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sgSwlVds;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fEONG8PqEOWFK8FoarFmJZuP5dBvcd4RxBJNOnb8M8=;
 b=sgSwlVdscm/Abj8Qt9cQfv+X/qqyQsbdyubmZ97h5bRC5EL7KwHv/zlSY8o1qm1Nx6u4Ej
 7nOOj1ahvCnx9HIb9C5PFv/imz5ZO5uL5Kh2Wl9q16nwRLJhwxvDfKvfgXzNDgvVK9Xukp
 AAftiCx7n7AKzQjOfyOKnVvOnLaxG9H5gvLzDnCjNnLy2J4K6ODDN0hC+LASfGx+W7fRrn
 gfp/w6BqYMxNGWHJCrpQzMK3/u4Ujsf08/D3fDXsVeOMrf90kJvmS8PIAV6fVexCkiAamc
 QPqu4ysGvNsm/VAqyVNF2Zb/cZIZupIhXXO05+8Lu8XuxoDk54vh0F2NaCFrpw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] doc: board: renesas: Document Aarch32 toolchain setup
 in RZ/N1
Date: Wed, 17 Jun 2026 01:18:43 +0200
Message-ID: <20260616231933.44392-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jj3wc8jy1jpekwnqqtkujk3rdet8jb71
X-MBO-RS-ID: beb49a0252e6837d16a
X-Rspamd-Queue-Id: 4gg2yY6Rj4z9t9n
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

Reference Aarch64 toolchain setup in RZ/N1 documentation.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/rzn1.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/renesas/rzn1.rst b/doc/board/renesas/rzn1.rst
index e6d636b89e8..5f054e8c674 100644
--- a/doc/board/renesas/rzn1.rst
+++ b/doc/board/renesas/rzn1.rst
@@ -10,6 +10,8 @@ This document describes how to build and flash U-Boot for the RZ/N1.
 
 U-Boot
 ^^^^^^
+Please follow :doc:`Renesas 32-bit ARM SoC build environment setup <build-env-aarch32>`
+to correctly set up the build environment before attempting to build U-Boot.
 
 Clone the U-Boot repository and build it as follows:
 
-- 
2.53.0


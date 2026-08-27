Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF9C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A87C780EDB;
	Thu, 27 Aug 2026 19:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsJCZAZoot2i; Thu, 27 Aug 2026 19:54:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860455;
	bh=Ygsh8LsrRD9oxYLJTUEwLoPhl54A1MUKG8OxD1v+QMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AIDIeQJWMF2DJI/SwtrT90ZuobZWXdtNYsgime7bMGljK2XYzr2yIQHhAcrR2wfAw
	 6OF2Z5+abUMWepS9L1+ULlJMAAXH7NEKoY5h0MIZDuVtFqD2le9jiw6w6pHcI/Z8xx
	 3M3cHDgYMwj63ltikX9Tl+C82EMt27j6umvak0oApiUlAvGbbYM40AGFTEnxGW0CEC
	 WMznjIuI4RUOBZTmoSubbdeH7r0wRKy0yqP28mybfzJrMYVpn095A10ILliLjVNzSN
	 qHWrJsdmVmc9ea8wDed+kQNS1KdlQVPuc6c9FMAl3CTvEYBfV2kFlGumZ4ENHTFpq5
	 1DWI22SjTNIJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C869F80EE9;
	Thu, 27 Aug 2026 19:54:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82EC075
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74E4580EFE
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4J0ykZwGkMRF for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::190c; helo=smtp-190c.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=hyjFjBJf
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 009A280EF4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:03 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzY1mMFz10Th;
 Thu, 27 Aug 2026 21:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860440;
 bh=Ygsh8LsrRD9oxYLJTUEwLoPhl54A1MUKG8OxD1v+QMk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hyjFjBJfwew7e6m8U7zb2EUZdkViMJvMk4rCGXmqm6YT+QAQcX6PMupn2qXvOX0VA
 A/6b5T0poI67C9l9c0mv+BUoXK7RxioZNUxw2z9bR+F0IMBODD2I29OLBlqh35w4Z0
 +nSzgHDRQcJJsXE6Xh1H1GAblabIjtpS9TJRTyj/70o8sK/gxC/3r+cXKW3O2hv0Yv
 5qD1IQyeBeqXajcYh4kIFK3OT1t+5R4wYYQCVO9jpCgM3Fb6GDFRaLs+YlY0qx8fyg
 OA2ZzB97F5CBkgCFqQRHXmv6z2aCCOP9lFv0DflpqaQgnHzJ5JSp1tA/+ZcNZD9C+7
 jEmAspjRhz3ug==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzW4FQkzQ7D; Thu, 27 Aug 2026 21:53:59 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 35/45] doc: develop/tests_writing: update links to new GitLab
Date: Thu, 27 Aug 2026 21:53:03 +0200
Message-ID: <20260827195313.129994-14-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

The GitLab is now hosted at git.u-boot-project.org so let's update those
old links that weren't migrated in the previous relocation from
gitlab.denx.de to source.denx.de.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/tests_writing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 1a020caa4111..1a6d13f6c7c4 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -236,7 +236,7 @@ Include ``test/ut.h`` defines a number of macros to check values and to return
 from the test function if the assertion fails. See :doc:`../api/test`
 for details.
 
-[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
+[1] https://git.u-boot-project.org/u-boot/u-boot/-/commit/9fe064646d
 
 
 Add a new driver model test
@@ -282,7 +282,7 @@ implementations work as expected.
 
 Example commit: c48cb7ebfb4 ("sandbox: add ADC unit tests") [1]
 
-[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/c48cb7ebfb4
+[1] https://git.u-boot-project.org/u-boot/u-boot/-/commit/c48cb7ebfb4
 
 
 Add a new test suite

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD47E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543E8803C6;
	Fri, 20 Dec 2024 11:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B1zrurWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870988036E; Fri, 20 Dec 2024 11:38:11 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 224968021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B3961A418B1;
 Fri, 20 Dec 2024 10:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D26DDC4CED4;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734691084;
 bh=8iwWRzHBmbxiyuEudCd+zXdnWm/6uX4bONJ0TBYx+1Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=B1zrurWyUnVpZbiRPJHQ2PgyLUZE/w3n3IZkkXg75DVDm8eZ3uIM9OZlDLRTWQYfv
 8N2CDNzgQxwzIN2kimC7k/DJE+mvNAAr5TUte0M7VH3FmcnRL6DJ0YHfq/gejcQ1d3
 v0229DHl868X4oiEfojvR6COuSmZWp9J7ODktOf2KI1rSZQItJK3ybrLuawvYIzE4j
 iPgsfaXp1QEu5Kqnyp1nc8WFetE7AaNdN8aQnA9D5DORApg7CpG6XRCYjlRKH8L/aI
 /UQevShFeflxF7y/Ed6PjxeJ2OHxU4bcZ56uEbdbasrd684jX4DaAsOdZz648MDSXf
 UXYsiCw+EPOVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C7261E7718C;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 20 Dec 2024 11:37:52 +0100
Subject: [PATCH v2 2/4] powerpc: mpc83xx: Allow including initreg.h into
 multiple files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-mpc83xx-misc-v2-2-ff4c17ee5fa4@posteo.net>
References: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
In-Reply-To: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734691081; l=1760;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=q1aGlwVySHapcSK9VkUtvogioI7EimJ3UdYBFYbqTVw=;
 b=1UyAoOOe3iik9JLSooPLHOgljL7NDG4YSHeMXytOB004rA1hRqqMjEnhEnF3qWlqHhLmdjlEi
 gagVHVbFGVgDdrOZUg2dc+aEeWwJO7h5Xg6oZ/nymqO/cJHCcz7slSv
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

Globals defined in headers can result in multiple-definition errors
while linking, if they are visible beyond the current translation unit.

This hasn't been a problem for initreg.h so far, but would become a
problem in the next patch, where I use a constant from initreg.h in a
second C file.

Reviewed-by: Sinan Akman <sinan@writeme.com>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- Clarify when the visibility issue becomes a problem
---
 arch/powerpc/cpu/mpc83xx/initreg/initreg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h b/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
index 63aa5c946696ee0368bb3453b40ff0110f0fbcfd..ea1176e7fe10dbb549125ab6b2706fee05a92734 100644
--- a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
+++ b/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
@@ -13,7 +13,7 @@
 #define SPCR_TSECBDP_MASK	0x00000C00
 #define SPCR_TSECEP_MASK	0x00000300
 
-	const __be32 spcr_mask =
+	static const __be32 spcr_mask =
 #if defined(CONFIG_SPCR_OPT) && !defined(CONFIG_SPCR_OPT_UNSET)
 		SPCR_OPT_MASK |
 #endif
@@ -27,7 +27,7 @@
 		SPCR_TSEC2EP_MASK |
 #endif
 		0;
-	const __be32 spcr_val =
+	static const __be32 spcr_val =
 #if defined(CONFIG_SPCR_OPT) && !defined(CONFIG_SPCR_OPT_UNSET)
 		CONFIG_SPCR_OPT |
 #endif
@@ -42,7 +42,7 @@
 #endif
 		0;
 
-	const __be32 lcrr_mask =
+	static const __be32 lcrr_mask =
 #if defined(CONFIG_LCRR_DBYP) && !defined(CONFIG_LCRR_DBYP_UNSET)
 		LCRR_DBYP |
 #endif
@@ -60,7 +60,7 @@
 #endif
 		0;
 
-	const __be32 lcrr_val =
+	static const __be32 lcrr_val =
 #if defined(CONFIG_LCRR_DBYP) && !defined(CONFIG_LCRR_DBYP_UNSET)
 		CONFIG_LCRR_DBYP |
 #endif

-- 
2.45.2



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD40F99C88
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 17:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2162783B99;
	Sat, 18 Apr 2026 19:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HAA8J5iS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E133784258; Sat, 18 Apr 2026 19:58:18 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E56836AC
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 19:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DDA2740D39; 
 Sat, 18 Apr 2026 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776535096;
 bh=Dzp5TQRpVAj1ZBqnDo0RqE0wxJP4qf/V1QQ6PJo+iHI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HAA8J5iSlD2KhjqV3kctMPSXl26Tebhe6EKcFPXl4daZmEmQaxsi+XdkkKDmaVMe5
 qvplG8FJtG6EMxEyJmuG1uPzOzgmmoMjLi4nNFlbh/zZDB7Jch/FhbWMimmFvMkub9
 jfkq+YSjuU67YI+y5/EsFncV/Xp4DWuDDi5BoH9b0h0EzKpvCXmwQsNigMk0O94l2K
 H0uAxehEjGWqvH08EO3fyUnnWDv+kmRyzYitR6bfgPoSKN9W0pcWFFt9r0DE7icLcM
 0rR7t6xRj0MT+FTWKLUtBOd6RCrvqmLLx7yv7198gBvrShvaLmZcPJZ2n3OojhoSxF
 +ezDqwo3EaHHZgJZHjcVLXJDPHYQduAWY2xpW8NSt1XfBeCC2wPuz+vhn+C67K+JKn
 owbSjXFVf1YLO70akYe8HxITMnf9rMLcBvqEUP3qQ7cyGNkiGD6TNRCaOFX047h3hu
 FNRmdFn4FRegBQrFp6eiSTnhvwYM4L2jgX08Zcp0L+s52wQAnXE8/8AO4x3lGJ/NRm
 Jhbrq5u/3bHBY2IXR7oeIxWJ9ucJVjCW9Nw146tqalu5ZKBmC18GSGbaU6KoR+7Xws
 yFblCNSxrurgO2VSswfUNnJ8POCDNS+HtTO0vcd6Y2mseeCBkqLFcSLP7W4+Ff2bKd
 HYLDqgrAT+LK1C4j9OEtyqtI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Adriano Cordova <adrianox@gmail.com>, Javier Tia <floss@jetm.me>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] efi_loader: centralize messaging for efi_init_obj_list
Date: Sat, 18 Apr 2026 19:58:12 +0200
Message-ID: <20260418175814.5731-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

If efi_init_obj_list() fails we cannot use the UEFI sub-system.

* Instead of having messages for this everywhere write an error message
  in efi_init_obj_list().
* Always use (ret =! EFI_SUCCESS) when checking the return value of
  efi_init_obj_list().
* Remove the return code from the error message as it does not help
  users to understand which initialization went wrong.

In do_bootefi() move the check to the start of the function.

Heinrich Schuchardt (2):
  cmd/bootefi: move efi_init_obj_list() to the start of do_bootefi
  efi_loader: centralize messaging for efi_init_obj_list

 boot/bootmeth_efi_mgr.c      |  4 ++--
 cmd/bootefi.c                | 13 +++++--------
 cmd/bootmenu.c               |  6 +-----
 cmd/eficonfig.c              |  6 +-----
 cmd/efidebug.c               |  5 +----
 cmd/nvedit_efi.c             | 10 ++--------
 lib/efi_loader/efi_bootbin.c |  5 +----
 lib/efi_loader/efi_bootmgr.c |  5 +----
 lib/efi_loader/efi_setup.c   |  2 ++
 9 files changed, 16 insertions(+), 40 deletions(-)

-- 
2.53.0


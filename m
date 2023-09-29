Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2BFE743D5
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 00:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0927E86E33;
	Fri, 29 Sep 2023 02:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jR4nKS6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A9C86E74; Fri, 29 Sep 2023 02:47:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4269A86E30
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 02:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ED0DB3F6F0; 
 Fri, 29 Sep 2023 00:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695948440;
 bh=MWaobMqtGUBBVpf3jvZLMYwQ2LLAG2nb1FbYWUxv87U=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=jR4nKS6baglMzzg1QcDJvuD4/9VY9kzStVkM0vFa2rMJW9zhwDXOEhpNfEUVP8UXO
 DYnbf9nL1ZkE/K4H9i1g9R/8NGBRx/6cIMbLVib3k7ApqrlwEC2o0+3xbVpF466R+j
 whHfI/nNRXQ4tWLwJg4z4AuZJQZxAwskMtxUT/te5UOjNEZm4NRL6nIJ2BxrEwNYGq
 IQZqQYqJyiOS6rxbuVwkaI0CEykEUcMcpY0R8pPakdlMoBf+tV1UVduRaNuOsquktq
 h+6PANO4/LkhdncaJ4lI2itue8UOEJkJfoENK356Bbasl2UiXMsEG45YeSCXbtVTQg
 LCAJ9EINU7mYQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] stdio: fix stdio_deregister_dev()
Date: Fri, 29 Sep 2023 02:47:15 +0200
Message-Id: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

When setting or copying the name field of a stdio device we must ensure
that the target field is NUL terminated.

Avoid truncation in stdio_deregister_dev().

Heinrich Schuchardt (2):
  dm: serial: fix serial_post_probe()
  stdio: fix stdio_deregister_dev()

 common/stdio.c                 | 6 +++---
 drivers/serial/serial-uclass.c | 2 +-
 include/stdio_dev.h            | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.40.1


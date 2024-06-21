Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C129C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 07:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1100880A5;
	Fri, 21 Jun 2024 09:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="q6bfY6ze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B54598839C; Fri, 21 Jun 2024 09:47:32 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C966F88047
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3452714835D6; Fri, 21 Jun 2024 09:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1718956050; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=ybmPF+n2NftapE2vNqhLbXIZC/QYlzczIp76EsxNBE0=;
 b=q6bfY6ze20Ovkgud2nA9yK6fV0LPhx8+cxBj1gRkIDBex8AVO2RWfRoOG4VwIYfuDzE+yZ
 +OvmxO0z01vktyeynv0l/xUxLoP9LbDyHHzz8+hwDiP56Tn1OjoN3iJSJcfCq0b5iR5piv
 dybyJGF0tADe27XydJghyJFQggUqDFxHwiVQEhXf/HPwTMCzjGxeKtJ9fXhVL+Dp9aEL9X
 DJLkAFkLnwHmq0IGhNP3nvVMdjExzGORZ9PFn167ZtMNEZJeieRMvNRgdFkSpfVWX4veJe
 E1uX2BJqZVfAc+bKknF5Am0RtfBkc6DsXP1idcTEjWe9clQ7qpJcVgF3ZqlmzA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/2] doc: develop: testing: Fix more reference links
Date: Fri, 21 Jun 2024 09:47:18 +0200
Message-Id: <20240621074720.203001-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Found some more broken reference links when reading the documentation.

Greets
Alex

Alexander Dahl (2):
  doc: develop: testing: Fix broken reference to pytest suite help
  doc: develop: testing: Fix reference to test writing section

 doc/develop/testing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: fe2ce09a0753634543c32cafe85eb87a625f76ca
-- 
2.39.2


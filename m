Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD982E677EB
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 05:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06E888C05;
	Sat,  2 Nov 2024 06:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=use.startmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=startmail.com header.i=@startmail.com header.b="CGH2ZFi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D3F788E14; Fri,  1 Nov 2024 21:28:40 +0100 (CET)
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6462288D9A
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 21:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=use.startmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mason1920@use.startmail.com
From: mason1920 <mason1920@use.startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2020-07; t=1730492918;
 bh=Av1xp7qulWj0ICG5r7njtYdPwFJt67IMXQXYqK7/GEk=;
 h=From:To:Subject:Date:Message-ID:Mime-Version:
 Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
 Content-Transfer-Encoding:Content-Disposition:Mime-Version:
 Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
 b=CGH2ZFi3YxI+e4bXDzlmWk2D7bs+7X0+vPQ5m2wrYT83ifVv8ptJT2blhrl4FpOst
 EH5tWu1784frqwyGOgxsbzk8CRsAOp0RZ0KisVAhuY5FprQgz5fmn2nhNxkvaBve74
 Sg9sS4VceeW4Rpjhwwybv7IkhNn8pzXG7tM923XdX0I2UUqbzP6S/EQkCNo/KXfkHw
 BQpue2Gia0htX2RRgp7wB2f6zgJ3BPqN/jJpktVXW12hqc5yjd76P9MLFiEp56ms9c
 atxVyXT3pjXxGtAtpLm+dGqzNjN0Z5LaBrE2yH6rT0uCJZPNPZr0e9BnKXaZj2OUYe
 ZpYnG7C1tEKfg==
To: u-boot@lists.denx.de
Cc: mason1920 <mason1920@use.startmail.com>
Subject: [PATCH] doc: Clean up cum fork
Date: Fri,  1 Nov 2024 16:27:25 -0400
Message-ID: <20241101202812.47016-1-mason1920@use.startmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 02 Nov 2024 06:22:30 +0100
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

---
 doc/develop/devicetree/control.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 211f7e4909..0233945f8b 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -89,7 +89,7 @@ Failing that, you could write one from scratch yourself!
 Resyncing with devicetree-rebasing
 ----------------------------------
 
-The `devicetree-rebasing repository`_ maintains a fork cum mirror copy of
+The `devicetree-rebasing repository`_ maintains a mirror copy of
 devicetree files along with the bindings synced at every Linux kernel major
 release or intermediate release candidates. The U-Boot maintainers regularly
 sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
-- 
2.47.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F95BCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0045584AF1;
	Fri,  8 May 2026 14:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B5h0APnI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NIVoDQ9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCC584C95; Fri,  8 May 2026 14:22:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C9B8488B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBpDF235Cz9vGg;
 Fri,  8 May 2026 14:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ifAnUw5JIG/MVYhiSEWtjeB4xJoXFtwAbRpx6Lsf7ps=;
 b=B5h0APnI9y/XfMx9RPzrUzDDrGjWGMxp5e/KZYcmaFvYq/fWLlQ9I0vsoaTP2ruaIKw3ub
 H6C3NK2687Ld/cmsfOu4bxwzMf26YuTMwjKZ+wWqXeqzqOHtZJq37GhKGW+NB4/x2NmNMJ
 A5bZ9huVYYAUDMu4/bwQ+7ika5hHVqLo9Z2Re04+fGzUOEqiFy4ETxl9AkFTm2ohFarhl5
 uvTjbpSH6sgr5WSKHi8Ls+cCl9wM5qcIFrN9aHeU8QMQEuERqMt6rqwSdRi9N+gLznEx4Y
 geyH0qH0bBIsnnQ8AbDOMAfiZJWNlYPMMQCfgf4gV9oppj7yJRy0io8YyQOgZQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NIVoDQ9p;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ifAnUw5JIG/MVYhiSEWtjeB4xJoXFtwAbRpx6Lsf7ps=;
 b=NIVoDQ9pjzy87R0Wkp0o0NKlXAqpi9BnRXhio6OoqOkVIJsr4lEon0g2rxjcnY7XpgF/3s
 1dX5EjxsEfaq9r15w3wXfMBC7l3Fl63ygOF9fSoQJXrHcNT7MfIG8iyhOg1Saw9bEqNmtM
 PRkaRGDJ6QGQd1jgSH/wqzIDgnqeSFCgMRpKYd4plio5gV39gobHsMmO+RJnJs/XdsfTCA
 b81h1ouLEN452hQEGqaT4agQi43t2DRJ++4cc30C9jHukOwU6k+mow4Y+S7oanTbsAA3X2
 2KzDCaKLDXB/wf/QVQUFChsmgJMZ5iVuKdAY+A08ZmvUdm6JV93HtX+OQBMZfg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/14] power: domain: apple: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:22:01 +0200
Message-ID: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n1q38qtmykpgk4tbgx6q6jkooarafoiy
X-MBO-RS-ID: a13ea9157848ffd184a
X-Rspamd-Queue-Id: 4gBpDF235Cz9vGg
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/apple-pmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/domain/apple-pmgr.c b/drivers/power/domain/apple-pmgr.c
index bf9940621ee..37fac815242 100644
--- a/drivers/power/domain/apple-pmgr.c
+++ b/drivers/power/domain/apple-pmgr.c
@@ -67,7 +67,7 @@ static int apple_reset_deassert(struct reset_ctl *reset_ctl)
 	return 0;
 }
 
-struct reset_ops apple_reset_ops = {
+static const struct reset_ops apple_reset_ops = {
 	.of_xlate = apple_reset_of_xlate,
 	.rst_assert = apple_reset_assert,
 	.rst_deassert = apple_reset_deassert,
@@ -138,7 +138,7 @@ static int apple_pmgr_probe(struct udevice *dev)
 	return 0;
 }
 
-struct power_domain_ops apple_pmgr_ops = {
+static const struct power_domain_ops apple_pmgr_ops = {
 	.on = apple_pmgr_on,
 	.of_xlate = apple_pmgr_of_xlate,
 };
-- 
2.53.0


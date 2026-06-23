Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88EBCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950A9849EF;
	Tue, 23 Jun 2026 03:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mXqnBVqL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NOZ7UK9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3150B848DC; Tue, 23 Jun 2026 03:39:41 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB0B849BB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gknmq0MGwz9vGw;
 Tue, 23 Jun 2026 03:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjEVIzGI2Mv/biORwb7iJbKDMs7DVTf6jACmO+SCxIw=;
 b=mXqnBVqLpg43z9KRIhxvPYypoV54tEcf34niToitru3UfU/y8IRxRsJl2CjVwW4AbjsARx
 2KckYAmVQJusV8YnNSSYnWKZEtY0djYBQBmdpnol/xjYlre2+nI1ot2xao4ewEg/N60Lmp
 6E+aXQaO8I4HsH/yjV8ydPajX0Kk7gxPn2I1pkRx8K5UrgZHHW2tZCVZ4LUJkAxibkr1XL
 STSiU/wmA5LHkvQ8mLsrNcYsML5Ei6vOkCyCiy0P9J/uq2jNkvfLIERLtQV/03Q5wbdcZm
 kburG7zp2QntgO62aYPnY933jE9KXrB/RhjhFFSBHFxLrFgj/mAXAtOFM8Q33A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NOZ7UK9Q;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjEVIzGI2Mv/biORwb7iJbKDMs7DVTf6jACmO+SCxIw=;
 b=NOZ7UK9QVekg2T+9apJ8wq/LH4XSJBPXAz7oS2t0fCnGSVmnpJgZZmja/bFySBnyeJe74c
 FsltVcgTjBaQqy9q7nffVox5ClS1YFLvB2i4BiLzNB2FIRp17o3WIcdlYmVCavzwOjTmLt
 R8Fd8amETaZD0mHL4JbgnEKlFfqWXAbztIkW111zxu9FIUpCeBnnQMZRIQH+m/t4ZVUrxz
 FCmfHU7+XMHAoZ5d3sksg8XjDuXAtrFfRF4rVrEDMYv6b0yDfoyUzpR5YIQpW44zL/FOkT
 p1O52EKEaKvINnl64DidpzTfPrU1AOL4JypJTIQkCJnxF8UCkDv+rcyeplZG+A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/11] doc: board: renesas: Document Aarch32 toolchain
 setup in RZ/N1
Date: Tue, 23 Jun 2026 03:38:28 +0200
Message-ID: <20260623013929.114641-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 917o4qgp7rdxw3k6ap5911i1k9uawrnp
X-MBO-RS-ID: d3b89a3fc492343122e
X-Rspamd-Queue-Id: 4gknmq0MGwz9vGw
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACCFC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8928587720;
	Sat, 16 Dec 2023 19:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hZzfisFK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f1/2plwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE06C876E4; Sat, 16 Dec 2023 19:08:20 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1775876E4
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SsvG9220kz9sc2;
 Sat, 16 Dec 2023 19:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702750097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CMyFk0VMDQHQcL2Ywrfwai1E5HEu5e5Xd0iSD/5qOkg=;
 b=hZzfisFKPIvTROU1LoHFUz8fttcszaK3ZqpLE8Sv7ADFBWpNWmliic05Ta/UNuynOC8asM
 1f4AjcwS5qhoR7Yk5ezRs1p4pzvjZrN2LXqAimWH978jBA6TvPGUiq15cFkMrTckeo9nzZ
 ylpV6nSgDP8bR1okKE1vWVT7OYd1XimhYao27upUAOy8mmVS0CZ5BYPp85X+IiuSPIVKbi
 IkAsZ0NWQTO8C2kE42iNit+ZVZ9UZY91nx1SD6ftggONngur5KgVuY530gtNW5hS6qFP2U
 aA7btbi2XyZED4ufLR70QCcFhr2R53C+yQA2GD1f5QUmnyem2WwAd8nvdfU++g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702750095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CMyFk0VMDQHQcL2Ywrfwai1E5HEu5e5Xd0iSD/5qOkg=;
 b=f1/2plwA4zK3m9xkcajOqRrqr9b9sn/fckwH9p5RTRsjUfe6KfEBr8YPBXUUiFQlMs1Y4Z
 ou9VKVFq5scNh9adXNQEK/iGoaZfe7g61wRdiBNz3uBHQkGyXVetV4Q/sDDxuJgXc9OfG/
 JLvG+rSZMSjYBSxy+pPgvrIOlf2iQTN5jntPxsxLzvXQ4RTCFJtTG1FbxvSZLDr6fwkITQ
 PH4IjDbuax7MVg3RXUOpclrq07SoXYYit9Odr+w3MlAZFiu8i8Jhk+DEJ5Ec+N3SqppFYe
 KT57wMq4J2uQe+lODFVdSGx6fxcDa0OKzpLxJoO6mHBxemmLBK4AK/onhqmfRA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] get_maintainer.pl: Add --git to look up CCed in git history
Date: Sat, 16 Dec 2023 19:07:52 +0100
Message-ID: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gsp9j87xyfjdjk5s5c5hj4jq4bi3fcdx
X-MBO-RS-ID: f6b048cc2bbe7dc783f
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

Add the --git parameter, else recent contributors are left out of the CC list.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 .get_maintainer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.get_maintainer.conf b/.get_maintainer.conf
index df595f5420d..f916cfbe480 100644
--- a/.get_maintainer.conf
+++ b/.get_maintainer.conf
@@ -1 +1 @@
---find-maintainer-files --maintainer-path=.
+--find-maintainer-files --git --maintainer-path=.
-- 
2.43.0


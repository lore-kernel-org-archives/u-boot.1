Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BABDCDB466
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771E4849D1;
	Tue, 23 Jun 2026 03:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bh6/LStw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lDNx9odj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5DF84A1C; Tue, 23 Jun 2026 03:39:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71431848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gknn01yqCz9twZ;
 Tue, 23 Jun 2026 03:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQp/QeXg3oy7eB1RG0J8WS/F93FMiPHWGQ+BEUMsyrw=;
 b=Bh6/LStwRnbXqqmdfrZpslWvLOeCFMRsVgem+jT3SMuif9VcMfvMD0jPxJxqYF8Mpd9kAD
 vvJnDS41zVNCpVlRXAzhu9mxNYggnFUUYJ5LxpJpy6XAnAlLPhvJ48OM4KfDQ9eRlJ7mJa
 3j+A6szcthaIK6O2g5tL4pgoQBz+xw4xHNk4XG3VQoBmOh8o0WnVqNkqJu8isA7FEFPuQH
 EAg9gj5gkT4Ji5NHqGYfApluT7Fmuw+mvbFAfJyzB/0kcBO+64yGgcmZ3LxxePqlNrbVMK
 9SjnDVGA5puYkdDZQUqEKrM3McMIlO+/xbLitvcLOYJzcMKSvpBmAc7tN9V/bA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lDNx9odj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782178787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQp/QeXg3oy7eB1RG0J8WS/F93FMiPHWGQ+BEUMsyrw=;
 b=lDNx9odjhpvPYXXFmfKumJj1YcacqMY6IZrFX8Ee/nw4W0zJJhKHq8mSrP2IWYHxrU+G/k
 jqtaa5TWUFgUa69X6yk0+5PuPghOxkMIM3dgFOu+y60zXzygG+Zrv0SkH4bNWyq4X0j3wu
 Z776MBS3Tht56k+2nO693D5WITjI7u7UAwTTeZxViG9zEduRtFKuG5QaVoYXJVIC/mFngJ
 KcZgn0l9OFNFt5gTkncyKt/Gus/t6W2BSrjKZhuVKJmAUbtGYlkl1SN9jdJ5mSsIksWGnn
 fWnNKF/Jnjc6K+uozv1Re2enK+sO+tgybIvfQx/LcCrKE9aYYMNy3fl7y5Dp+w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/11] doc: board: renesas: Update Renesas generic build
 section
Date: Tue, 23 Jun 2026 03:38:36 +0200
Message-ID: <20260623013929.114641-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
References: <20260623013929.114641-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g71a618ht196ydinxto3ebhz1rp9wmot
X-MBO-RS-ID: 38ddb399a53a773791a
X-Rspamd-Queue-Id: 4gknn01yqCz9twZ
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

Update the Build section and note that it is only applicable
in case the table above does not contain any board specific
instructions. Include information that the Architecture column
now contains toolchain setup instruction links.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 doc/board/renesas/renesas.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index ef04a4478e1..41272c6e32a 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -264,11 +264,18 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - :doc:`arm <build-env-aarch32>`
      - rzn1_snarc_defconfig
 
-Build
------
+Generic build procedure
+-----------------------
 
-Locate the appropriate defconfig in the table above. Then apply standard build
-procedure::
+This procedure applies only unless the ``Board`` column in
+the table above does not contain a link to board specific
+details.
+
+Locate the appropriate defconfig in the table above.
+Follow toolchain setup procedure in ``Architecture`` column.
+Finally, apply standard build procedure:
+
+.. code-block:: console
 
     make <board_defconfig>
     make
-- 
2.53.0


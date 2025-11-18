Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A8CEE351
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A792883623;
	Tue, 18 Nov 2025 21:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Xqd4TDnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EBC838A0; Tue, 18 Nov 2025 21:17:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB77835B3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 473A03FF0B; 
 Tue, 18 Nov 2025 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763497062;
 bh=DiXCV+PF8T5K5BWEzFZqF2YPOpr0fIYa7FQ/E0YgpmY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Xqd4TDnuBliyYJM5eI+Y4B/X3EVWkmFS8QHFV8bxxITfSmBnpdBrBTAhNWOsIPJAk
 0JEFzhmnMMU3lZ1qBVx/lN8BhPX6IONZAQzT1YMul5w3zemt//L7p+P5mQOnZUDQ6B
 es6/DCmWUcMLN3zhLolJsMvil6M+XMR10R7Xpj3K+CV4a5Wt+w3vjwoGE9GNPjD2iy
 8y8WTRGxSKvYrhCPxCk07cYD9wxsLsbk/i9NOiCBeQqkgEfPFjU12FOUmCH8ZU6uGz
 nSFdwl7rGkW/u0U+q5JiyyE+wHptWhhtYPa/uvDmbO4CnrdjRMFKhWm0gkPWamUSGA
 2Vj4TCISrfwHUEzpm9Bvehtn2O/bIZj1tH40otlqyPla03fuZfAdDPl0zqvHqYbBbq
 uLhptpSyovXhvFXGKZf/R50BxHUFfQ7RYTon0NFxFFXKBHg4DZBYJvE0LU52tRdDxx
 6KL+1Uww+xJh2LN832GSasHxDNKvnxAl4/YQq7wpujx4yaaoOgA7aKqt3Ks5hxRZGb
 qAjKmqzjznburB9NNheJ1Jg0rTZ3nicx/uck1Ow4BrWONaZKmrb+5Hp5Hm2bjiNyZp
 aewNOqCt2UhVlv0pRBXT0SuPwXE1i3Zdx5UVur5Zd07lcrQzdBPvDxvib9oQBIf6qN
 R8tZbqK4ZSrWAtxkuhD6UXzI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] doc: improve C test documentation
Date: Tue, 18 Nov 2025 21:17:29 +0100
Message-ID: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

* Add missing Sphinx comments in include/test.ut.h.
* Add include/test.ut.h to the HTML documentation.
* Describe C test return values

Heinrich Schuchardt (4):
  doc: make writing DM test subsection of writing C test
  test: document ut.h
  doc: add include/test/ut.h to HTML documentation
  doc: describe return values of C tests

 doc/api/index.rst             |   1 +
 doc/api/test.rst              |  11 +++
 doc/develop/tests_writing.rst |  63 ++++++++------
 include/test/ut.h             | 159 ++++++++++++++++++++++++++++------
 4 files changed, 181 insertions(+), 53 deletions(-)
 create mode 100644 doc/api/test.rst

-- 
2.51.0


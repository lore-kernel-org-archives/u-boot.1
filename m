Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC723C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B478744F;
	Sat,  9 Dec 2023 19:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QtKm5Fpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B1D87645; Sat,  9 Dec 2023 19:54:17 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B7487215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CE2D43F6B8; 
 Sat,  9 Dec 2023 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702148054;
 bh=A+3v2/2CYaJNUJn3CyN5GVYeuH9mN2bRB0AVpKdx+vs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=QtKm5FpzM/ZDfMKoKy6WZ4rzXlVHzO+W94BcdV/HBJkLeEWR+WxHRJ6RhBvVAgMVY
 vWkpTWBBRi3EQTuI0H3skaq7PYr6SkHDUQZteQVidYkVafv8kPEAT9eZlwrd9cSoLr
 udHG24XLQqHBiIUPAZD3c9gG0n3jLkcBpLAlACcoA5iUP41LayiHgaXOpLmgWks5yc
 MOWhw7TChvvea+U3Rs5jFh1oBsN4o5CoTEL+eoN8l3G8mWyLd4cWdMnNHXyjjtV6mC
 cFQ9FOTfvZpQFvIE5Qlr7oHW+5t5pRY6xgMJ4PuwkXaEiIqL402LUKp0GSpxBqfY/0
 xkYzkcLI3E7dg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] test: Using variable 'old_dtb' before assignment
Date: Sat,  9 Dec 2023 19:54:09 +0100
Message-Id: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
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

Avoid errors reported by 'make pylint_err.

Heinrich Schuchardt (2):
  test: fit: Using variable 'old_dtb' before assignment
  test: vboot: Using variable 'old_dtb' before assignment

 test/py/tests/test_fit.py   | 6 +++---
 test/py/tests/test_vboot.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.40.1


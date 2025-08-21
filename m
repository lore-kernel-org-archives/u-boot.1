Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F390BCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 17:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78DA680548;
	Thu, 21 Aug 2025 19:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T+eRPrVU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W41pmEMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C91E80B9B; Thu, 21 Aug 2025 19:24:18 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008E480422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 19:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c79Cy5RlLz9trC;
 Thu, 21 Aug 2025 19:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755797054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=id75Q+AfaBZu5dgF5TEAJ2vijOI8tB4zAhF9rHL1MXQ=;
 b=T+eRPrVUqNf7erQR4ufYDA2PF8NqD0vSGDtYVloaWQ53bgW0koNmDiFr9zzo4+PGvPfzPE
 MUjlKsdNB+rVLw/A0d1k9kOSy9JY/gpyrKjxInKv/yBbSaE9tEa5KZelJixkSAycsl+72m
 jsDiCiQDXnVJLzz9UOATaifbU+Nm0QPtb0KP0zhPjr1A7f6pqM1Muy4NTD5ByqCC89Hxja
 Kc+W2t7LTRLw8phYvzWx6GbsKNXpey2yfniFC7Z9SfbOJ79uQr5H7uOjJhhdQS8WUPwixS
 K/u4Y5BRqUJp/IuYfiuyUBMts1T3vG6FTB0MzGWD8o+iNMzc9bqXt0k7ZILdXA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755797051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=id75Q+AfaBZu5dgF5TEAJ2vijOI8tB4zAhF9rHL1MXQ=;
 b=W41pmEMu0Fj/t9i4pNIKaIclfymsU44DrzfjxmRBQdH+Gzj1kS1PMIxyjPnHqJuG30Z4kI
 4YiMx3D5/GNqjTsfkOCjDqVdtKIVhu16aEdEBCpSbRz/Z1+/keHnyVFUmp9ZU2r9zc0nTV
 9vzeoWh9iaOjkiCMyJ4Q0PTPLGwaXupdP9wCX5piEEbwluq3bVl2rZPtl+tBloPAdzXWbW
 vCFdCScfVpG21RGuKukdF8eLD0mNljd//HQrNFG35kgiGyWMtW4qSWOLqzuf8m6sK38XSf
 xhHoVeaClJAQz0nri82k/21QUbKbB2zBkdy2ax4t463m3IQn7PX/vrNDSSDvsg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PULL] u-boot-sh/master
Date: Thu, 21 Aug 2025 19:23:44 +0200
Message-ID: <20250821172359.154970-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: scdcp9w1c3pr73x1syx9uaq75mr1u78r
X-MBO-RS-ID: f81bf81c114f4728760
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

DRAM controller driver off-by-one error fix.

The following changes since commit 54fbdd408873413af86d86de03a490c5abf280f1:

  Merge tag 'net-20250818' of https://source.denx.de/u-boot/custodians/u-boot-net (2025-08-18 10:54:44 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to b34b18a2c936c02c42c1c66bee274fcc96e25c57:

  ram: renesas: dbsc5: Fix off by 1 errors (2025-08-20 23:02:55 +0200)

----------------------------------------------------------------
Andrew Goodbody (1):
      ram: renesas: dbsc5: Fix off by 1 errors

 drivers/ram/renesas/dbsc5/dram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05037F53D90
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 20:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B050841B8;
	Mon, 16 Mar 2026 21:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="JcdCXdJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1164F841BD; Mon, 16 Mar 2026 21:02:33 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D6D84197
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 21:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=Ah1jJKyri6LCAhsDy8YyVtZwFvsp30PFiq6GKEXMmho=;
 b=JcdCXdJpB/HuWiTjKPZbgIZlcjilktgW3MeJyUGB51oTbuUyTyNsOtghVMh7ZGygjOvHqsOUl2zKBhymnKyrOFcsHdX4T5DBqhcrrMvRcJzjxS6xEGf04y4oI6uUtrntVMAlUY10XmdAIbZ5LST1CaopnDiLY6gzRVkgXHtJShLqmr/HkoLrp9oGoE2EEibII6oKa8aPqXfj0BwP9KcTHURtgSLkaaTHJ1ZVxpbRRX7Z0ygKd3hSEzC0xh
 1p5WrRFHLF8MARpak6mSxtygsRPq1W6hmW5ACTL2DamSr5O7c7t/a7sFPuznEz6Na36Y8stPmZ21aJ4FUE/bQZvxEfjA==
Received: from TkB (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 16 Mar 2026 20:02:21 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH resend 0/1] Timers: prevent conflict between ARM Generic Timer
 and Timer drivers
Date: Mon, 16 Mar 2026 22:03:53 +0200
Message-ID: <20260316200751.3024-1-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.52.0
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

This patch was previously sent 2025-08-01. There was some private discussion
but no decision to accept it or reject it was reached.

Marius Dinu (1):
  Timers: prevent conflict between ARM Generic Timer and Timer drivers

 arch/arm/Kconfig      | 2 ++
 drivers/timer/Kconfig | 5 +++++
 2 files changed, 7 insertions(+)

-- 
2.52.0



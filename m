Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0700CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8D3846E7;
	Thu, 14 May 2026 16:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=l4re.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=l4re.org header.i=@l4re.org header.b="W7Q/qzjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3923184683; Thu, 14 May 2026 16:06:46 +0200 (CEST)
Received: from os.inf.tu-dresden.de (os.inf.tu-dresden.de [141.76.48.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4E68467C
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 16:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=l4re.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adam@l4re.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=l4re.org;
 s=mx; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
 Content-Transfer-Encoding:References:In-Reply-To:Cc:Reply-To:Content-ID:
 Content-Description; bh=kWJjJt+N/7aMYpV2BdsrMBugDPjETzTtU+TLhVDJg8E=; b=W7Q/q
 zjglTdjrTULoxpJpC4zLuOMpgfO03Kb0oLyFz9QRrPtrX9VJHsQ9UwkMkWP/BsorM2E02E532q5xe
 CuEmJyhTsjLlpHs2yJnhr8m1NWb1j6UZhEqpvR9bAJIPdjksi/ucZftYnWfZAy9CQZ/wuh3S6URtS
 Fl/Cb4AU7iSbb/nneUc6ZP3En2z+2zyo+7Lc5rQ0KX63PNneASrT9xsgbuDKu24TREUbWgEMMOSMP
 J5E9movQBdDSIj6XeiSU37LhX/U/Emv0aTAGWwKYim923OwTG8+5br7IQP7NVDfSuANpz0fDOu4P9
 mDBmjkLEvdfZv1ZGWHo7/U803rXQA==;
Received: from erwin.inf.tu-dresden.de ([141.76.48.80]
 helo=os.inf.tu-dresden.de)
 by os.inf.tu-dresden.de with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256) (Exim
 4.99.2) id 1wNWi3-0000000CAlJ-43Co; Thu, 14 May 2026 16:06:44 +0200
Date: Thu, 14 May 2026 16:06:41 +0200
From: Adam Lackorzynski <adam@l4re.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: [PATCH] common/command.c: Avoid NULL pointer use in cmd_auto_complete
Message-ID: <agXW8eM2DdZLEqt4@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Avoid putting a potential NULL pointer to strcmp, which would lead to a
load at address 0.

Signed-off-by: Adam Lackorzynski <adam@l4re.org>
---
 common/command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/command.c b/common/command.c
index 0f9dd06d72b..55bd9e44b1f 100644
--- a/common/command.c
+++ b/common/command.c
@@ -373,7 +373,7 @@ int cmd_auto_complete(const char *const prompt, char *buf, int *np, int *colp)
 	const char *ps_prompt = CONFIG_SYS_PROMPT;
 #endif
 
-	if (strcmp(prompt, ps_prompt) != 0)
+	if (ps_prompt && strcmp(prompt, ps_prompt) != 0)
 		return 0;	/* not in normal console */
 
 	cnt = strlen(buf);
-- 
2.53.0


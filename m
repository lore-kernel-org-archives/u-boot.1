Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144CFD2F7E1
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A5789139;
	Fri, 18 Oct 2024 10:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="i6kdcqYa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7vBrOzXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B526589214; Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A5B8912B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tP65yqoXC5ug+kjr1rsDorleg2ROn1OuiXvKxc7T+ng=;
 b=i6kdcqYacDwrPHoJc9hDMk6oJ+jLDEbeL688FU/hVk4V3iTnh+c2UvVmFWK6ZFHCYJeq5C
 sDhBCn4JSzHUwkFirWX95N92LB5CPLoAxjFWbHDXaLDIaYWhBiKEP3J7W1sI4vfrsFAhqv
 /aU1jzzp9Y5X527MKXHod0/hU/HH9NIqaCQRslitmsR4YF8PGGyHHErJzm2z3MppA93CmB
 lyF6Ly3cLQfV2xlgCnasWFdU0tgUl0dk1Gdr5wokiMQS6T05R4ih/o6uL7YRf/yBrJspBr
 0S3wcomNnuxmCDNctLxIUam3mgjMvgY8dn2YGIEkhE3+DqsuvA6zCq+iCmh+4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tP65yqoXC5ug+kjr1rsDorleg2ROn1OuiXvKxc7T+ng=;
 b=7vBrOzXYExSaJ7M2bXk6NUehfHcnz7dS0vg4eT9O4dLQV86+C0xzWVxQ2v+RX7il6UsKHF
 YD+s/fk3DAC2DWAw==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/5] tiny-printf: Handle NULL pointer argument to %s
Date: Fri, 18 Oct 2024 10:30:02 +0200
Message-ID: <20241018083006.10349-3-b.spranger@linutronix.de>
In-Reply-To: <20241018083006.10349-1-b.spranger@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
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

A NULL pointer argument to %s causes a NULL pointer dereference in the
fixed width numerical printout code, since p is overwritten with NULL.
In case of %s width is 0. Check width before dereferencing the pointer.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 lib/tiny-printf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 9a70c6095b3..b2f31c4004a 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -311,7 +311,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 
 			*info->bf = 0;
 			info->bf = p;
-			while (*info->bf++ && width > 0)
+			while (width > 0 && info->bf && *info->bf++)
 				width--;
 			while (width-- > 0)
 				info->putc(info, lz ? '0' : ' ');
-- 
2.45.2


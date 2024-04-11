Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A843CCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 05:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D870887861;
	Thu, 11 Apr 2024 07:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="jReI4t0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526E687F52; Thu, 11 Apr 2024 07:03:37 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8E887150
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712811813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rz6G6lulTKX0bZCXO358d3VfKIraDSF/CiY6Zq9IT9s=;
 b=jReI4t0+MH/5WtpPIDgu6g21M03BEBDhZu4seTLSLmuoEAhIWPGW2redpW/L6xcIMgrWur
 RCpt1RUlp2fdSysvaQ0+i+JTphl8PY+XAu67LNkUij3e0pTehSpsUiMdKvogNEiXXm4SB9
 Io/dGqEkouEOcI4qt9SF+m07VUPXcPsYhRzVQz8Krvih6COe1EdUkeAneR8aV/kBA959I1
 K9OP9jb2aGzgflisxuUusLLnkOg4XDNTiOAxA8VFV8v2+7pxAxSMRCkuFC7oUCnY3ui//e
 P1RXgzvuUgmawTbOxXZW0yqwwNSknp5NtGyysNpaLGH/0cCCMC8HIl6ZL8yc9w==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 15:03:20 +1000
Subject: [PATCH] boot: Pass baud rate to stdout-path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-stdout-v1-1-66ebe5bb152f@jookia.org>
X-B4-Tracking: v=1; b=H4sIABdvF2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3eKSlPzSEl2TNEvDJFMzs0SDNCMloOKCotS0zAqwQdGxtbUAvkB
 AuVgAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712811800; l=1243;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=PBzIiRJvURzUdzKwPgAUizG81jtcZvhqhpNIiwY81WM=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAvbPd/p2oX/MmRaPaeap5sel
 ev1gDCaw1eguHlQhRvhUTiM7x7wTTlnlOrTta691/LuHH/hsP2h5hU9kJFQCEAAUAAOmT
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

Linux might use the wrong baud rate such as 9600 by default, make sure
to specify it when passing the serial port over.

Signed-off-by: John Watts <contact@jookia.org>
---
On my board at least (a sunxi T113) the serial console will initialize
as 9600 baud instead of the set baud. Pass the baud with the serial
device to Linux to solve this issue.
---
 boot/fdt_support.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 090d82ee80..83e62f47b5 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -153,9 +153,9 @@ static int fdt_fixup_stdout(void *fdt, int chosenoff)
 	}
 
 	/* fdt_setprop may break "path" so we copy it to tmp buffer */
-	memcpy(tmp, path, len);
+	len = sprintf(tmp, "%.*s:%d", len, (char *)path, CONFIG_BAUDRATE);
 
-	err = fdt_setprop(fdt, chosenoff, "linux,stdout-path", tmp, len);
+	err = fdt_setprop(fdt, chosenoff, "linux,stdout-path", tmp, len + 1);
 	if (err < 0)
 		printf("WARNING: could not set linux,stdout-path %s.\n",
 		       fdt_strerror(err));

---
base-commit: 777c28460947371ada40868dc994dfe8537d7115
change-id: 20240411-stdout-4f91b566a0f2

Best regards,
-- 
John Watts <contact@jookia.org>


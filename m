Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB53CF8856
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 13:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8767383935;
	Thu, 20 Nov 2025 14:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="UhXS2Y/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AC383935; Thu, 20 Nov 2025 14:32:10 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F44D83923
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 14:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso1277084a12.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 05:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1763645527; x=1764250327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P+hgn7vVQdTrmkbvyHVNn4BNq0QLk28M2hFESyXJaAk=;
 b=UhXS2Y/T0FJZt94rJMHld+sBgIMPCKKs4BANjAkqHAFDFy94dbBM0UXHFRb53dsz/h
 agLXbYqBEdP6d023wZO/fPCPbUjTyeukaegexXVmHt2tWsunzujGThu9EMLIq4izyyXg
 7C+hpB4suMyr0G+fS2FRfrV9v5jv+cLUKNxQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763645527; x=1764250327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+hgn7vVQdTrmkbvyHVNn4BNq0QLk28M2hFESyXJaAk=;
 b=F7JMyZmw7lSBXYpYFWiWGX5Gz7z4mQYyOfIeInWHgFgRAjvPDaeayOnrXsEe+eMoZs
 IK/Aq1eItU1bLMmdCl0P9sORUMO+mUUWPLkrG07Brx6CCOfclXlH/+15dMKanPV1Ar5H
 o+YPTJKHLfHtgvkSieM/OnA6LMgkcEqu0GRJrRy5S3EA50QnisEjYC2nG8V0HoQQORFQ
 NddA7LC3LDDdNd++JIUmgtugHTigixhR8MFvPXyjSOZxSYAhPLWkQowXSxTW+Wlq3tE7
 7v7frbWCfVM3k5FTdbhRkDNUh3d/8gmyHrEgjYhN/T9zxHnp57whQxtimgrLNRDY++72
 4uTw==
X-Gm-Message-State: AOJu0YxU3907pkevdebZ6ypQNrcrXXRQ3yEJzArv7R1IM/D9Xff2yqBB
 IN35fZxjMWZauC4FHod+CUStnHWHvXMikEi8vs1rO0ZMVnIkj3iEozcF+JX0Ad+wkibZy37+9Kp
 D9jREA7GusSP9KQ4ojgik3tRyhgDVBkZHaqpWFXxuc6auUyDINAM+b5bu/QoZMAc=
X-Gm-Gg: ASbGncsPoK1nQu0rEwUTTj7P3pHEFWpnYGgZM0BlJhNor6iJlHhtwQuccg02AQBorOx
 2LO/Tqz7ShuxyRCMY2NaD4iwQLPDOh2T9PwL1zSoDsVyLhqFW5etiIbv2hS58ZHHJjGLkNzCqqf
 XH1Qx0MfT7OgMP2Gf/OfPyseeO4FnLdUkEJQPwQBCa9hPOr19pmrmPRwG88zPi+wE1Ly3RP+47o
 zUjs6Yx3ZxJb12HMxO1p+Wvv1yWVWHlKI+p8lwP+9XspbsQmtIZv/o7cNkUg2p/eSW8L2kYtoPd
 6YowSTC8Nn9/+vyQsrKMjdvIPorIY0bhjjwA1rEcbXXWVZdzVML6Tn61nlXwqpOKynhQaAN1nHA
 kXKhEmAMls1PWmow3I7kvrgbWRh16fK13cyE1Xm5N3kcNCUc6TgxTuWEzhZOfIe3MP7bP5sfkQN
 3Oo9H3snlrLCBIgsK5Nvfg51TPpfxT
X-Google-Smtp-Source: AGHT+IGwNJU+KQXLlYR5CNtxI7ztKExwwyYbs5NWytBVx9Ijs2YO7gBABq1R8jxzMpw+m4vD9NQ8FQ==
X-Received: by 2002:a17:907:d92:b0:b72:8e31:4354 with SMTP id
 a640c23a62f3a-b7654d610f6mr322592666b.25.1763645527311; 
 Thu, 20 Nov 2025 05:32:07 -0800 (PST)
Received: from cibil-Precision-5570.. ([217.111.51.126])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7655051625sm209834366b.65.2025.11.20.05.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 05:32:07 -0800 (PST)
From: Cibil Pankiras <cibil.pankiras@egym.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] reboot-mode: Correct macro name from U_BOOT_DEVICE to
 U_BOOT_DRVINFO
Date: Thu, 20 Nov 2025 14:32:00 +0100
Message-ID: <20251120133201.263725-1-cibil.pankiras@egym.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
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

The macro U_BOOT_DEVICE has been renamed to U_BOOT_DRVINFO.
This patch updates the reference in reboot-mode-gpio.h.

Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
---
 include/reboot-mode/reboot-mode-gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/reboot-mode/reboot-mode-gpio.h b/include/reboot-mode/r=
eboot-mode-gpio.h
index 16b1185c698..e862d94fadf 100644
--- a/include/reboot-mode/reboot-mode-gpio.h
+++ b/include/reboot-mode/reboot-mode-gpio.h
@@ -9,7 +9,7 @@
 #include <asm/gpio.h>
=20
 /*
- * In case of initializing the driver statically (using U_BOOT_DEVICE macr=
o),
+ * In case of initializing the driver statically (using U_BOOT_DRVINFO mac=
ro),
  * we can use this struct to declare the pins used.
  */
=20
--=20
2.43.0


--=20
EGYM SE, Einsteinstra=DFe 172, 81677 M=FCnchen
Gesch=E4ftsf=FChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=FCnchen | Amtsgericht M=FCnchen HRB 303509=A0|=A0USt.-Id. DE275313632

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1DCCD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 11:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58CEA839A8;
	Tue,  9 Jun 2026 13:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="DD+4zsjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B014A8405A; Tue,  9 Jun 2026 11:35:10 +0200 (CEST)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB8783FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nia.su@sifive.com
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-304d7f31215so4601127eec.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1780997707; x=1781602507; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OtXinAI1cYG7ZkouidBGI9kZTd2+ZVEF5BK36+PF0Lc=;
 b=DD+4zsjjno1hDJugZ1UOJ6s2XiNWW2/T9Bpt7wJQZodt7OK4tcRVfvm9Y5n4fZhE/c
 8edtJ1IBiWZtSWuN4j+DFXJS7U2rxWOH30jb96xTfGV9/T4r9HSN2TsyKKn98yBc/qCZ
 qDiF6GLfqyUlBJI27A/Q7OZggq9feXleufiHDITO7i6qOdbX+29ON3N6bQHO9pU41yun
 m2VTfhGr8YgZDX4UehMPUKKliwm3J98rYRzn5JK2+FEbp0zw/Rh5crepUzmb2THu4P1J
 sUP6E8Ml0QiEmpVj/NBx7DvGGus3Wb7pyg9nau8tc6q2cWTGd7ryKo8019wu0G/28Tlk
 w+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780997707; x=1781602507;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtXinAI1cYG7ZkouidBGI9kZTd2+ZVEF5BK36+PF0Lc=;
 b=fAQ8QK2bbfQGuYLG++X3XAkffLQ2OBfg5ZiW9C7rluOb6MtxL9V5T/mFrjrQMyJBCp
 RIDyNoJgVTNyGP3wkf9rNfeAf9zpmYZXnMznwr+SgaGz6v6h7k2LIOet+8Dm3rkIA6bs
 R+COxi/zW72b851Y8pJw2S36Rwe69Xv4w4Cbc5O8deuFY3UUUnoq3UXNs401o4ZZ0ORa
 w6RmmWwIFa82mKa0pUfhglpliEXf4iqyjxcx6xJLghAUU/M3t8WSq1VbwmZKRDfHjzVE
 gzCe2QnYJld/5JwS1Kpq/xMS7jj0dtUaW0rRcc8viZyJeJQrOn4j6MlLhg+PAa9rLZV4
 ANcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ywbRRxWc2f8Y0xUj6t1Qn++r3dnizp02KJ3ykX9uaArM2J9bKv2nsruvjIIKn/yWavgGRdFw=@lists.denx.de
X-Gm-Message-State: AOJu0YwoUbdYpvMK1pWqA3gPH1xBwrlrIuTviGezUUqgNeTOkicPTkzn
 m43iJr8nWxHb4st9VaiEEturcn0kBge+55kgvWUlC0laL0+pVn1yxxSsQIMH9cCLDkI=
X-Gm-Gg: Acq92OGIDWhf+h65F7uwpEx+K6iozD0Lm8S8HxsDPJszqM8l4WvfiHQSkddC1BNxMHk
 4JMxK+2yJc2IHnqEsTxHiXKs3T/BEH4xTTI8GtMau523cJUtX+HNOO0v1E4EXRgsorX5SEbAA5g
 lMCbaDxoZSQKLHIkO7RUYpdhW6+ZGNDfrmLOmX11flHsSsen43OmVAsUUWkce1xUMri6lmyYyL+
 QUwQ3zrPjeOg9xUF9BTlgLhElekik2X8n4B2gaNCkoHzZWkUWelcF0Sky53AlqRVHT30bN0e1AT
 jKTEMrEKfUZMURjZZsNrXv1XzGTNt+pcZ79B51/NYE+yPi+Y2lvECaI6g19V2ddyfQdv5SALomF
 3a1XJkONohmzTb7Wq5e/dmfX4Vl9imDYd9LQX3qKRun4ngb2gD9UDKetXWo0eO/xCAuQDejfVTA
 qZs0mq9rHRlr7TQWuR3XLO/o2cgKdFEFrSzUG5TlnXQyBt
X-Received: by 2002:a05:693c:374a:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-3077b25d11fmr11403143eec.1.1780997706824; 
 Tue, 09 Jun 2026 02:35:06 -0700 (PDT)
Received: from sw05.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dba046esm18544559eec.9.2026.06.09.02.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:35:06 -0700 (PDT)
From: Nia Su <nia.su@sifive.com>
Date: Tue, 09 Jun 2026 02:35:06 -0700
Subject: [PATCH] cmd: sf: fix sf probe using non-flash device as flash handle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-sf-validate-uclass-v1-1-263ae3619b75@sifive.com>
X-B4-Tracking: v=1; b=H4sIAEneJ2oC/x3MSwqAMAwA0atI1gZq/XsVcVHbVAOi0qgI4t0tL
 t9i5gGhwCTQJQ8Eulh4WyOyNAE7m3UiZBcNWulKVapB8XiZhZ05CE+7GBEsxqKtc1vmSo8Qwz2
 Q5/uf9sP7frobQhBkAAAA
X-Change-ID: 20260608-sf-validate-uclass-4b4973c5302b
To: Jagan Teki <jagannadh.teki@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ye Li <ye.li@nxp.com>, Nia Su <nia.su@sifive.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Tue, 09 Jun 2026 13:02:02 +0200
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

`sf probe` calls spi_flash_probe_bus_cs() which returns whatever device
matches the given chip select, regardless of its type. On boards where
a non-flash device (e.g. MMC) shares the SPI bus at cs 0, `sf probe 0`
would silently use that device as a flash handle, causing undefined
behavior.

Check that the returned device belongs to UCLASS_SPI_FLASH before
dereferencing its uclass private data.

Fixes: fbb099183e3a ("dm: Convert spi_flash_probe() and 'sf probe' to use driver model")
Signed-off-by: Nia Su <nia.su@sifive.com>
---
 cmd/sf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index b5b7f671fb972b7bfe9ef60283b4c06431ce1ac0..ec9ebde2aaf032f2a2f435e0d95f1805603afb0e 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -137,8 +137,14 @@ static int do_spi_flash_probe(int argc, char *const argv[])
 	flash = NULL;
 	if (use_dt) {
 		ret = spi_flash_probe_bus_cs(bus, cs, &new);
-		if (!ret)
-			flash = dev_get_uclass_priv(new);
+		if (!ret) {
+			if (device_get_uclass_id(new) == UCLASS_SPI_FLASH) {
+				flash = dev_get_uclass_priv(new);
+			} else {
+				printf("SF: device at %u:%u is not a SPI flash\n", bus, cs);
+				ret = -ENODEV;
+			}
+		}
 	} else {
 		flash = spi_flash_probe(bus, cs, speed, mode);
 	}

---
base-commit: 1a8b7ad50aed5f5f0a4ccbfd455233919c097293
change-id: 20260608-sf-validate-uclass-4b4973c5302b

--


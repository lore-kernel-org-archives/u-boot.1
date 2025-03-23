Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BCDC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 19:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC8D81CAF;
	Sun, 23 Mar 2025 20:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="Po1y48L5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C162081CFD; Sun, 23 Mar 2025 20:03:26 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532D081B5B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 20:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so6584918a12.0
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1742756604;
 x=1743361404; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FY6p+Yu7A/xW0pTUKDBccTpAafgFlKEGmLi6RJ4XbmI=;
 b=Po1y48L5Z6g7L1vhU3kWd+8XIwRjpuCb7FBZ9gJyuiwxK8iA4V3f/ynmxlqjHryIch
 8TJ1bG407dUWTvd9iKw2lH4H8y5SU/w038NFlx7HR1Y8iksfCLjlkTgUyDcmPR0RSB8C
 iQPaLb0VT7We8UmaXltFlTF/r5qATfUSvJAieBPSFrt9pMtYVjxh4RxDzgiqd/f3JqC9
 iJJENGuDyLyAA+wiThMOU3QNw1Jsa1I/iSzra8wq0MEK2F3PLdMzeMM6knBFtzgk+4VJ
 GXmVlXFifP/s4oI7NX2eYWCf3AIiI6OXTC3fr1ptRPypQ8V0cb8aqo7a//X6TtbJmlur
 w8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742756604; x=1743361404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FY6p+Yu7A/xW0pTUKDBccTpAafgFlKEGmLi6RJ4XbmI=;
 b=vTRuM31YsTZfz5piW0OGmwvkh0QcB7aL6tFjfbXXQyYvcT2MdHgI9YdI1aGPQ0SdND
 YjYPr4c6HFMveaHRXG1OZu3Y4piiPwa7Iyp0ajxvY6IpX5PS7UHJRlFtHhokVOvyFBQ9
 k2RAZdXljLydYeLwvNazouPdEw7QAX8nwxXaGatPW+64kfFUzoc8RHSEwMTyfZAChqbM
 3Mz4ftVkkLm9oiLML+u2bSnJ3z3FZq04I2H81uuWMW9pBHoeaE8ILdZJgXvUWiEgeSNW
 wL/MymrR6DSmXBbnKjB1xxeFI+FzXsv2YNIJGdTOExsNK9Y/cAFManFB5IE+GpQ4XC+G
 tgag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr895PDPnmwkA8dzpQhA6lli9PPsPTcvRD+xqwNo6y9xKk/cCsaoUyA8h5UUY1H9So7cKvKvI=@lists.denx.de
X-Gm-Message-State: AOJu0YyHlwg0CRkTMKc79AYyRDsTKnq6zcFf6Tln1vMJ88Vc95dgFuhK
 ZSoK2ZcyEiMzyiNOlC8NtArUIAqwTeadTmQcz/R00J0LKOinGafr4rAzJ81kkFv6L/kCnbXfk7v
 w
X-Gm-Gg: ASbGnctB/l+Szi4EO/ipLlnjIy7KjKoXz5yertIwOyPk+BOhLqzKgWFRBDajmo5SJe5
 LXaQKv0ek+JmQrl52YdLpym5x0EcufKgb/8uIYefGgWMdo1xBL9bsfyzSY5vIWlWrhOW8/lNotd
 jxznVPnXdGtZBl/5knWeBCgCJjbFJ3MABXDo/1uyEEgCM00nrzR6shgM/z984osxg9bTt9AhWG7
 44eT6G/hah4nu0EiR7D+UyCCTUliWk/2av8nug9lwXfP1DH3vfZrEA0rW531Y0NQ3TQVqOx6Oph
 0A/3wngFB7KYll2/4tt7nZvZ6C7hxKRo1hOlkveuSrOgusmCXrU56CQ6Yn6aUq/j6o4lpTMnNyE
 =
X-Google-Smtp-Source: AGHT+IE8Cp5MYAhfWL68x7nPRPjIZYt2yGGxc1taGteRUqAYjjX3Fnc2BEUX7PvKyh2AB0WoDJOQWw==
X-Received: by 2002:a05:6402:35cc:b0:5e5:bd8d:edb9 with SMTP id
 4fb4d7f45d1cf-5ebcd433b13mr9484465a12.10.1742756603469; 
 Sun, 23 Mar 2025 12:03:23 -0700 (PDT)
Received: from retsina-25g.fritz.box ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccfb4a8fsm4967998a12.48.2025.03.23.12.03.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 12:03:22 -0700 (PDT)
From: =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= <christian@kohlschutter.com>
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 u-boot@lists.denx.de
Subject: [PATCH] efi: Fix efiboot for payloads loaded from memory
Date: Sun, 23 Mar 2025 20:03:03 +0100
Message-ID: <20250323190304.45371-2-christian@kohlschutter.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Calling bootefi on an address that was loaded from memory (e.g., cramfs
or SPI flash via "sf read", etc.), currently results in the EFI binary
not being able to access the EFI image device path.

For example, iPXE would fail with an error "EFI could not get loaded
image's device path: Error 0x7f39e082 (https://ipxe.org/7f39e082)".

This is due to an incomplete special-case in efi_binary_run, where a new
device path was created but not used in all required places.

Fix the in-memory special case, set the "bootefi_device_path" to the
generated "file_path".

iPXE will now boot, and report the device path as
"/MemoryMapped(0x0,0xSTART,0xLEN)"

Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 lib/efi_loader/efi_bootbin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 10ec5e9ada3..f78cf972228 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -268,6 +268,9 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 							       file_path, NULL);
 		if (ret != EFI_SUCCESS)
 			goto out;
+
+		bootefi_device_path = file_path;
+		bootefi_image_path = NULL;
 	} else {
 		log_debug("Loaded from disk\n");
 	}
-- 
2.48.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF78CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D33870AB;
	Wed, 10 Apr 2024 10:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UFOlsoFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2C487572; Wed, 10 Apr 2024 10:38:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C5487073
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B09283F20E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712738318;
 bh=EogsLN88hrGT71MOAOjSCEtNz+fJOqsuhC15NGMUXsM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UFOlsoFYDYOWaR1Ns+nKIX8O/OH0zc1sRCm/qQQBH3ZcVD7vbEsnHep//0nHdwEho
 IkKdXgMfnUdjPV8L8VfSJvIqLDlXPy7j/MUUcZnKVcJVCwBR8l8Bdhe2WVzTvxPR4B
 iTMC8fM5BdJ06SigAXFSrIKzI0R66dB0KOs1jjHpbHN56Q202MOc1aUQ0AifPfCkfP
 6N98KKvCLOJpRSj4/W09IhHIpFrAGeVSGjCjpGdZGpJCKHncEtnLQ8kqixigIZ0lFd
 +HGkfTA9OFkw09USXlr/xND71HtKSKH61laJQ+RRR5EoJ/x5lzdxjWVi3kJSfy+UMZ
 BvbIKeAsiOFKw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343c6a990dbso2746935f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738316; x=1713343116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EogsLN88hrGT71MOAOjSCEtNz+fJOqsuhC15NGMUXsM=;
 b=NQYZ4C7pTLvxIs/yYlPg8Tfrv6Ts9XBK0kRqwT8s6w7zvHHfvHUJ8Spj8V8cLh29T+
 jGuBvFbGhDmnsDyDVeM1uvtPPWOS4qP6GZOGs03NxLU7Nyg30rFK6bVWOh+uChaI9Exn
 MGU4OvpHTgfMqqHATBw8P4EGzfze//pNMdbTzXdrZdIUUkj4nLIwMYbcuPVMhZ+upXuM
 t9HS2yVvXuspPgBILGusInuC/qPX3sN5ZCrePjBVbKl3wXK4gVRBWR+1iA2Vb5idg0Oy
 XnqCjGy71J1DsiDMoOfUBaOJE/w9vhtoPY+jld6nNIioyq31KIVIlYDE+t3UQsFTbtAk
 sHkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEmNxFUrDV9Dgik1k6x1fEvF+egj/w6WKrJ5Q/KnA1oYry2OzTYWvhgt8+l3pjAS75U0ws/wnkbbr20dT4r86LasjSIQ==
X-Gm-Message-State: AOJu0YxWAMrYeCghlGfjIkltaf/Kj+HJsORKwELKV3y1+GzWQ0vEuFT2
 kqLwCRHnPDc8cri4eCpAuJfR2WB15L4ZhTxm8ceqMJ7iFru/iItWpxQ6kkrDdPwruZhLzPZ+RsJ
 l75fVaOqNb7wGx/T5SeSc6o5qr+WN3zrPUL8fGjEMgbsJ5dHOFDM6ufA4LAzUdAtq5y0=
X-Received: by 2002:adf:fa07:0:b0:343:7ed6:765a with SMTP id
 m7-20020adffa07000000b003437ed6765amr1587605wrr.20.1712738315824; 
 Wed, 10 Apr 2024 01:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9o046A4eA1LOzB3RMvEBtJEUsBTWnHb4QKESPmrgnF2k3KCmMJnO74egUdcDqNi10W331gg==
X-Received: by 2002:adf:fa07:0:b0:343:7ed6:765a with SMTP id
 m7-20020adffa07000000b003437ed6765amr1587588wrr.20.1712738315435; 
 Wed, 10 Apr 2024 01:38:35 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020adff182000000b00343e6bec771sm12952050wro.94.2024.04.10.01.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 01:38:34 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Mike Frysinger <vapier@gentoo.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: use sane access rights for files
Date: Wed, 10 Apr 2024 10:38:28 +0200
Message-ID: <20240410083828.20650-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

When writing an executable, allowing other users to modify it introduces
a security issue.

Generally we should avoid giving other users write access to our files by
default.

Replace chmod(777) by chmod(755) and chmod(644).

Fixes: 47f5fcfb4169 ("sandbox: Add os_jump_to_image() to run another executable")
Fixes: d9165153caea ("sandbox: add flags for open() call")
Fixes: 5c2859cdc302 ("sandbox: Allow reading/writing of RAM buffer")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/cpu/os.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index cbae5109e85..1cf41578010 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -109,7 +109,7 @@ int os_open(const char *pathname, int os_flags)
 	 */
 	flags |= O_CLOEXEC;
 
-	return open(pathname, flags, 0777);
+	return open(pathname, flags, 0644);
 }
 
 int os_close(int fd)
@@ -746,7 +746,7 @@ int os_write_ram_buf(const char *fname)
 	struct sandbox_state *state = state_get_current();
 	int fd, ret;
 
-	fd = open(fname, O_CREAT | O_WRONLY, 0777);
+	fd = open(fname, O_CREAT | O_WRONLY, 0644);
 	if (fd < 0)
 		return -ENOENT;
 	ret = write(fd, state->ram_buf, state->ram_size);
@@ -791,7 +791,7 @@ static int make_exec(char *fname, const void *data, int size)
 	if (write(fd, data, size) < 0)
 		return -EIO;
 	close(fd);
-	if (chmod(fname, 0777))
+	if (chmod(fname, 0755))
 		return -ENOEXEC;
 
 	return 0;
-- 
2.43.0


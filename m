Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF410C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1CF82F03;
	Fri,  4 Jul 2025 14:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K976ATmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A625D82ED0; Fri,  4 Jul 2025 14:32:46 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAA2803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450cf214200so6888735e9.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751632364; x=1752237164; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iEltIIjP8+ioXJF5bw39+54r76aFUkiRaCyXWvGat+g=;
 b=K976ATmM9VntzSi9EOT1PrCjmhlM3hvnSQI6Fkd6gvB0f0gORTziEyU1JFFTOh8bqH
 EwWbyH8ciMH0mxKN6VZeS7YV5b3ByJTuIZc7LB6cO3I4ffeTj2PkOXgS4P91Hujyr12n
 XO02q+kJSiX9heN8w/2mx+mJ7OumqpwoxGItwqvt8OVEBEzBtLq/K37D61DQ6Wy8nswS
 g3iirUcVsenVj/RWkKTQh7k+Ec/npDPhJBxB5s2w3NEo1ttyvq7dmKdXwKfy0agQgpOs
 CaiBmg7BuiAz63mp6jO0v7tg4wOBcjVa+fTJGWZlwml0friUg4r+Ey2n1aWAZI7xiRLW
 6dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751632364; x=1752237164;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEltIIjP8+ioXJF5bw39+54r76aFUkiRaCyXWvGat+g=;
 b=kHU6YMZFZr7p08TFfT6/198EFZTHWyC/fFOLB1DBVWVYaMi/3aevZXWoW/CiL8F/hM
 vf8S1VvB0ohyzuLXJ1HoBt1mepA4PWej9pL9hcBzSKDcOtjOV5cdZZ5M+tyH1sQho2V1
 z9bLUl02M5DP6EFagxBwfngxRtOTVWJkTxOgosghbOXAQ4VbN2zIx7hw2MgtnF2ULVRP
 UaTb48RtSfXtulTLptN1/d57oO15n0qAZhI2Uz7UCQSvVf1ASjmek96sEKmJRCQNrXQy
 Wfus37oc1iXJRDOJspu0X7btKT21cZbB8Osf/zD67+Mg6fR5X4hMh+g8rA6zY7YRvdit
 IXXQ==
X-Gm-Message-State: AOJu0YwgygILRlg5u6B+m14bL6SSsU8dPvZ2J4nHK/tZl2hNLE59nsep
 AuBERdUO4MByx9i6iqDvf3/h1qKFkqdpVBf0IT4MzxRdzYgl+bkYSbl166CHondlQo4=
X-Gm-Gg: ASbGncshMYoc2lZhailm4I1tD3ilrNxGAUgUQ6DH7toUIlcZEp1gEHjsX8vejm8u6Zo
 nezOmh813KKD5n7KywukhJnRYXRyrs1sNzTjY8WgoPNDc3gyWz65zs3dLTgDiRoUb5Pg/XjEwvV
 NXzzLCYSHs3ICeT0DZ5FxGKy7oedDW9G+sxCiICjTn7UzV4PM8NTlrCB7B104D4ji1UHqdf7jIo
 baQdusB9ZluNHwjmDJJFVDvr9V5LW51ADQNNRIw9Z+OFPvgsvW5qCEN9ZqpEIflGIjK6mVrhYFj
 MHjkHAp3x66DpeHsrYbGEDbQ+cNvlNnBxXomVpWR5oqd5HEfN7jcMiSU+KFR2rS27g/7j2g5Q+Y
 wP4VdRxkKl9ZAwA==
X-Google-Smtp-Source: AGHT+IEqFo36nOCl2DX9cX3Cnqj/2uh/tERBrNp42O6nVJXcGnfMMF+Hwp/sHzJjei+YlFnw1qeQCQ==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed62:c7e1 with SMTP id
 ffacd0b85a97d-3b4964f4d29mr2152475f8f.12.1751632364079; 
 Fri, 04 Jul 2025 05:32:44 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bc5asm2367760f8f.20.2025.07.04.05.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 05:32:43 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 04 Jul 2025 13:32:42 +0100
Subject: [PATCH 1/3] fs: ext4fs: Do not negate error before returning it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-ext4fs_fix-v1-1-5c6acf4bf839@linaro.org>
References: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
In-Reply-To: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In ext4fs_readdir it calls ext4fs_read_file and checks the return value
for non-zero to detect an error. This return value should be returned as
is rather than being negated.

This issue found by Smatch

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/ext4/ext4fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 1727da2dc6d..7fb4c1b755b 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -272,7 +272,7 @@ int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 				       sizeof(struct ext2_dirent),
 				       (char *)&dirent, &actread);
 		if (ret < 0)
-			return -ret;
+			return ret;
 
 		if (!dirent.direntlen)
 			return -EIO;

-- 
2.39.5


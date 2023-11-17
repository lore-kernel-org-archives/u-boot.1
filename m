Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB30CC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7D2874F9;
	Fri, 17 Nov 2023 22:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="p8Sd4WBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A453874FB; Fri, 17 Nov 2023 22:22:00 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C5F8708C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so1568302f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700256117; x=1700860917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7kksgcUCA1iCjzeWaVzK6/jbeKMR2yq1yL0ae4KGI8=;
 b=p8Sd4WBTsKkCTYRoMmjqVg7DVT8Tg92D4cCialM+OrW46MM8Plb7lAhWihonWur76B
 1zf31wvNFHahwKKgyHjF8xeSEVBbTxw/m+TZ0aIUxiAUellx+2i5meox0a+e/EXifmaa
 pozp12Q8crkyL4zgpZCVGFoUYQt5vAb4E44SDuz8mcVq9vbuyypFAeFHV5nKsI2Dz3Yy
 tsROi40V/1pqNs0MuWIWjZz5s7ToC0RlFHTbaIlsmvGx68q/DSZnk9c8UVg8YeZGAR7u
 Imn7R3HGb3j8YXizvvuScjbrskafzy7A2itkW+FBD6a7jZaN26TwRb6Sbrxyoq/oqKAg
 KI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700256117; x=1700860917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7kksgcUCA1iCjzeWaVzK6/jbeKMR2yq1yL0ae4KGI8=;
 b=i8oAQeIJ4PaAW2jNtpeIxuGOGk+XhtRQ5ugDwI3uDaMHXwCIJQ8OHDB8yergfA1lUA
 5yPalMCIKMNpPhaumJ2PIznE+nXmGvioytW56Cg9hu6R6KvljhkScqXGZdSINahFfuXp
 TZLgEDFSWKOSkAgHekdsGoolyMmHWC91pT893y/pmYW93IKfmmBRqTa68mZYLBnhrF3J
 j7PuPg7SsoDdwGk2yT/3WkyObKjpysDH60KE8QLgRBYC/3AaArq5pWWZ9jKb6Z8l/FZv
 2+uVLpscVebCOS7wdGhHsvBshVNQmySj6jGWBYE13F6KkdC+iX1hBcgZEIgA1bTvtfew
 6CoA==
X-Gm-Message-State: AOJu0Yxw9nglfG+BrZ+KZfmO+ZMbGXTPrN69DtevHyhE9Stias0X8ysS
 HtDBtwIX1iTSWadisx74lfN9E6HRFezCVhXAoZRf8CPL3Ps=
X-Google-Smtp-Source: AGHT+IHOaPlH9SH7qERrRkBNTnRVrWXUKcgGLVtWEaFZV4BOeuQgJjJP11PYfXQsK2xJM4udzie49Q==
X-Received: by 2002:a5d:6d0a:0:b0:32f:c5ea:72ac with SMTP id
 e10-20020a5d6d0a000000b0032fc5ea72acmr176289wrq.46.1700256117501; 
 Fri, 17 Nov 2023 13:21:57 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 t6-20020adff046000000b0032d9a1f2ec3sm3393540wro.27.2023.11.17.13.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:21:57 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 1/4] bootflow: bootmeth_efi: Set bootp_arch as hex
Date: Fri, 17 Nov 2023 21:20:36 +0000
Message-Id: <20231117212039.1210784-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117212039.1210784-1-i@shantur.com>
References: <20231117212039.1210784-1-i@shantur.com>
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

bootmeth_efi sets up bootp_arch which is read later in bootp.c
Currently bootp_arch is being set as integer string and being
read in bootp.c as hex, this sends incorrect arch value to dhcp server
which in return sends wrong file for network boot.

For ARM64 UEFI Arch value is 0xb (11), here we set environment as 11
and later is read as 0x11 and 17 is sent to dhcp server.

Setting it as hex string fixes the problem.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 9ba7734911..682cf5b23b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -339,7 +339,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	ret = env_set("bootp_vci", str);
 	if (ret)
 		return log_msg_ret("vcs", ret);
-	ret = env_set_ulong("bootp_arch", arch);
+	ret = env_set_hex("bootp_arch", arch);
 	if (ret)
 		return log_msg_ret("ars", ret);
 
-- 
2.40.1


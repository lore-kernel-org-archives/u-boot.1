Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A85C5ACB3
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21FB87507;
	Fri, 17 Nov 2023 22:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="J/Y74QMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E47A87506; Fri, 17 Nov 2023 22:22:07 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C139887503
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so1568320f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700256120; x=1700860920;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcrCnrlAyn28uz1pzm0eyVplUwkaxsOouZOIOXDvc2M=;
 b=J/Y74QMqv4a68fjFnWhoLKhbCT2Ht4xAvDu7XErkIQISwZuQDcT+59MXFa1lO7Qbvz
 Fx5uUUnmxZGzzUJ/XyXY1POephrqUNkAAVFlhF3qMjjgfzuOYR0CT5RZkfGSZR+CtCZJ
 R2MD+xHFLpvSYhip9r03bIBGP1UJO4uXgjBIBxInFL44b9Qj6ZnKXNyPK0mmYNbRZ8Do
 3+zBKMkuAj22/dKUZmDVCkGDr6FWCYVdYTBiYp7D+eCTeUhqkWimpkQ2zvRorTjHCEPN
 cgvL5lFmjlbQelY1ThSrie8ZbFnExJmkxoUcQCDO7HqqRPNqZtOwpUmyhD+C+Qv/wFek
 aq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700256120; x=1700860920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcrCnrlAyn28uz1pzm0eyVplUwkaxsOouZOIOXDvc2M=;
 b=jNBqOH7OT22As9tcf3rp+S9uP2hCQSYWnXecivlD1oQ8tv31kaT+PaEQMI4ldeYMBu
 Sz+G7PT3U9KKpz1wsQvyUyF+iz2A9oqlCnrHIOzVk1htLJWIZn1RIHXRNsjANwmNmGoM
 tFKkyzX4a/CMaVPeqLlL1bV3wGeaA5gviSB1Xj9rLRy1Qxi/EsBVIU+ldvS/qsfL0pHe
 QZqAhUgpLbc7xtCPDc6H7oiofSK8J2jvcoM3oOXBZEaWU2s6hsIrd6gwM1wvrgKMGiEt
 bBT4MqsJl3PeRwcGTeBurUQaelj2aii+oaNtFPEKknSzE/lVwLVZIKLp5IArm9Uqr6Gg
 zrZw==
X-Gm-Message-State: AOJu0YyMbaDo8Gfq5LB9Ai06R3S5Xq9VW8XpJeX6WyocQ2O//KWhLfPr
 uNAOIG8CZS3hnrC5B+n2VlcDItIk2/yaIFpPeHW0I5HLgy8=
X-Google-Smtp-Source: AGHT+IG1GM50hZzxvvf23jYcLc/Ok6jUpFG5HTWMXwaQ3f9H8h3wx4s4RcU9nMTHy6I4LI4hfJPhfA==
X-Received: by 2002:a5d:49c6:0:b0:331:3a9e:b021 with SMTP id
 t6-20020a5d49c6000000b003313a9eb021mr124605wrs.51.1700256119935; 
 Fri, 17 Nov 2023 13:21:59 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 t6-20020adff046000000b0032d9a1f2ec3sm3393540wro.27.2023.11.17.13.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:21:59 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, xypron.glpk@gmx.de,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 4/4] bootflow: bootmeth_efi: don't free buffer
Date: Fri, 17 Nov 2023 21:20:39 +0000
Message-Id: <20231117212039.1210784-5-i@shantur.com>
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

bootmeth_efi doesn't allocate any buffer to load efi in any case.
enable static buffer flag for all cases.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 5e67afed88..045e9ac543 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -160,7 +160,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 	if (ret)
 		return log_msg_ret("read", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
-	bflow->flags |= BOOTFLOWF_STATIC_BUF;
 
 	set_efi_bootdev(desc, bflow);
 
@@ -395,6 +394,12 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
 
+	/* 
+	 * bootmeth_efi doesn't allocate any buffer neither for bulk nor net device
+	 * set flag to avoid freeing static buffer.
+	 */
+	bflow->flags |= BOOTFLOWF_STATIC_BUF;
+
 	if (bootmeth_uses_network(bflow)) {
 		/* we only support reading from one device, so ignore 'dev' */
 		ret = distro_efi_read_bootflow_net(bflow);
-- 
2.40.1


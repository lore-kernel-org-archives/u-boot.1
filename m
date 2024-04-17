Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76457C001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 14:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8220988461;
	Wed, 17 Apr 2024 16:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S/IXAvkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8D18832B; Wed, 17 Apr 2024 16:01:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E9788453
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 16:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B37B73F85F
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713362497;
 bh=etiLwtN9k5I8v14/D57KiDOAEEvCuZRMA2C+XjrBCrM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=S/IXAvkNc4qe8eWmBnP/Z/ZItJs2yR/KoNxioLb/s3pspj5o14g44MIGwqT8bYXIq
 9bbfiRkrQeCRqn+Rglulc1TcwIdrefWjFsxkhlBs7wYSjNRpvI97ODO8/WKeU5psxH
 QbQQI/lUBuujPLrGtwms91hjqT74BNkGKXtS/Ctk7esvELbMBKJS5B0ljaAkSaMoeu
 4BdqPWohjS5eQ2mLFrHl7Te7wCdVV9ViBeE5EtNeb1bzUbMVsfQCnnty7hWWySR4n7
 DAjZFtDcuwe+QUJbfmqHmT5NiHVP0loiI8kWxhrKNZwnWVrvFmj/ADMyekqFmyOl9k
 cbXmD+IHs2fvQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-349d779625eso331101f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 07:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713362497; x=1713967297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etiLwtN9k5I8v14/D57KiDOAEEvCuZRMA2C+XjrBCrM=;
 b=A6CxDky3uaSjQBBasrYlx1rSgMGo3U8f/xBPY7oEiTETngva9MHqhOY9lMPS/twzbj
 SVe28u0PS9EH5B8WEzVHQswGaVExG4ZJ0FAtswwZOP2GrHtG+4F9kZ7hS+FK5x8wN3fh
 XyF7fuGYyew5iyVHcMqxCS79CejUWjqZsA+Veshs0adWX1lZ4c3wezbElMYIht++JaDq
 7Zfq5bytNxt3irY+mi8zhGotnIJIyTtLaRpT2SHqvo6VxTpqeTwpP8DXo2xjORJSMF23
 vb9ulhg+uKrAi1clDUb7bSBAEcOe3VDv9TXEuTkRvph/Qsf4jFt72Fasu+RD+o6XWeiZ
 Pi6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQOl173Oac0zT53riBqHy+zL7E75u7sbAOcSAHrFvTIzPzlWtB3KL15Ci0soNdzqCT79693HLN9CRyLhPwMDvPXk0U9A==
X-Gm-Message-State: AOJu0YzVCE6YtUpWbUD8WvpEBhRDPm9U6D0Zbs6du/UTS/yYqCGDKLhR
 NzAowf6RJMgTtdtXG1OgSouGw9cE9jQdCnlqmtpI2B9kFVn19ZQSGByYKjiIBoXV5N/o8uIqGYV
 +8MTj+j73aGLTej1DmAgE6x5l/vpwzILszbtlAeGykDUhJpfxQoIiD3RxNkAwAx6AVc4=
X-Received: by 2002:a5d:6da5:0:b0:343:ef1b:9f68 with SMTP id
 u5-20020a5d6da5000000b00343ef1b9f68mr18792164wrs.50.1713362497315; 
 Wed, 17 Apr 2024 07:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2M569ZWTUhp6ZpO51Zf3OwvlWrkbppGlZQLGwnX/+0TsnfV/3FSoYTl4xwUpr/FSdaaHAdQ==
X-Received: by 2002:a5d:6da5:0:b0:343:ef1b:9f68 with SMTP id
 u5-20020a5d6da5000000b00343ef1b9f68mr18792095wrs.50.1713362496570; 
 Wed, 17 Apr 2024 07:01:36 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cg17-20020a5d5cd1000000b0033e7a102cfesm14723908wrb.64.2024.04.17.07.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 07:01:36 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] cmd: sbi: add coreboot and oreboot implementation IDs
Date: Wed, 17 Apr 2024 16:01:28 +0200
Message-ID: <20240417140128.100372-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417140128.100372-1-heinrich.schuchardt@canonical.com>
References: <20240417140128.100372-1-heinrich.schuchardt@canonical.com>
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

Let the sbi command detect the coreboot and oreboot SBI Implementation IDs
defined in SBI specification v2.0.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/sbi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index 55507b0aa63..2d8ee7e5bbb 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -29,6 +29,8 @@ static struct sbi_imp implementations[] = {
 	{ 6, "Coffer" },
 	{ 7, "Xen Project" },
 	{ 8, "PolarFire Hart Software Services" },
+	{ 9, "coreboot" },
+	{ 10, "oreboot" },
 };
 
 static struct sbi_ext extensions[] = {
-- 
2.43.0


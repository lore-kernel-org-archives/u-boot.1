Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E30C2BA1A
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0DD882EF;
	Tue, 18 Jun 2024 14:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TtgPCXRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E44C88307; Tue, 18 Jun 2024 14:24:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D37B88137
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F15163F4BE
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718713439;
 bh=M1sVyfRU2E6OCF2w3soJnVjkUaRiqONkBNaJod4Xy/0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TtgPCXRByoebSCKx2RV1RpcgUqgDUSS6seWqsXlJV6wI3c5V7EtpW8KhqE4ZKN0L/
 99KdkGjInSJF2IDFshCMF9eX3owOYWNxMQhZhzjjB3tnz8RLpbCIfUXC//hAjJeGkO
 eEu2ZF4ey1ZWDRHWoLSOIJ+bY4eBXm5bKj+KVNXgtw+tmr+PxUXexuqsG7QnhNqW7Q
 QIK2+pVrB3wPBIyXvD2IQvlNiKOctFVWEtOFgvwpBsU2C1cZHHekzW/SC6CNTFriI4
 O836mmmziBSgpWIHKJqZebIp36CpuwY2WA9Yq04S9LlHNWniHGY4Aj49YmmaXIoSZu
 XxgL4ACf46p3w==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52c893408b5so3601210e87.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718713439; x=1719318239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1sVyfRU2E6OCF2w3soJnVjkUaRiqONkBNaJod4Xy/0=;
 b=AD8S/kdihK4mVS0Fe0rJGO7zkUMTJEFJVIg/w2Sqn7e/xpUptxuJImrcpBoEBlE3EG
 ex5KDLBlax/lNZWnDCn0Iy25RUQqupkiwopICvQgAA/5ooMwJL5qbmYrjx9897sXwwlA
 RXJR7AgcRIGEunMlevDDJMgaoIqkO+KBfESPeiwTfoapRfd4VWc3gk7ftE+doMALrZUn
 2Ai2PJDgq0kryH6FP97Zop1icudbqQS/f2xMdnSS5uhiNSOSp/AAQjtONQodeKI5JRWM
 15fqdOe4OITEP8Y90/5heDNTtshNbNOPn1R6HxF9OuhSUQLv42gafbBzDYA3+CcucN4n
 jH7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwM69C4P7z8boQwyWhNXwarf+U7OkHhrh6R7QSzBJln3RA/lWfN8vGqh2OgkMmPq0rRllDXfuXxpaPY5NV8Mmq5PKldg==
X-Gm-Message-State: AOJu0YwNK1JIYM105G54Xn8AJgcXSXfCg8Cwac7P6d2BcLSdOl5ozFqV
 kRQ3QUYh6y5I4NFWPplZYn6gYqpFa51hYWpPxGj7GIjqt63Tqa/rGlK//wJBnVk3YPa9DMplP+K
 9P3IPT+gUk7MvK8qFi8EEK+Q9cAeB9LJHCfTbK/FFEiuhqJp+n0JHEJ5lK5D7ltmn9b0=
X-Received: by 2002:ac2:4a85:0:b0:52c:93d6:9d68 with SMTP id
 2adb3069b0e04-52ca6e5629fmr7027726e87.5.1718713439440; 
 Tue, 18 Jun 2024 05:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwMdchUGYBw6c53BF2o6o6aS+mqFnP8D2sJs8jieFcz7qhFDBIcVbzxKIZiGLQH/wxM7SqKQ==
X-Received: by 2002:ac2:4a85:0:b0:52c:93d6:9d68 with SMTP id
 2adb3069b0e04-52ca6e5629fmr7027715e87.5.1718713439061; 
 Tue, 18 Jun 2024 05:23:59 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33c2dsm187956545e9.10.2024.06.18.05.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 05:23:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: can't have measured device-tree with
 kaslr-seed
Date: Tue, 18 Jun 2024 14:23:48 +0200
Message-ID: <20240618122348.126196-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.1
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

Test that we don't have a /chosen/kaslr-seed property if we measure the
device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_fdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_fdt.c b/lib/efi_selftest/efi_selftest_fdt.c
index aa3b13ae3ab..066d9581432 100644
--- a/lib/efi_selftest/efi_selftest_fdt.c
+++ b/lib/efi_selftest/efi_selftest_fdt.c
@@ -227,6 +227,13 @@ static int execute(void)
 			return EFI_ST_FAILURE;
 		}
 	}
+	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
+		str = get_property(u"kaslr-seed", u"chosen");
+		if (str) {
+			efi_st_error("kaslr-seed with measured fdt\n");
+			return EFI_ST_FAILURE;
+		}
+	}
 	if (IS_ENABLED(CONFIG_RISCV)) {
 		u32 fdt_hartid;
 
-- 
2.45.1


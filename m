Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C09DEFD23E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 09:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9C08366F;
	Wed, 25 Feb 2026 10:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p0xQilco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A387083AA9; Wed, 25 Feb 2026 10:58:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD64982A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 65C533FB70
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772013513;
 bh=8KOzj0b5/V98cHYuLvdhvw85c8OIibFq8+lGb8e54WU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=p0xQilcoEPnzxv6VfmvoKrCIrgZgQh7AckHZnR8Sk2TAKOeR8NgJgxp5Lz/7b7iAZ
 VmvvBrwOvCDhX/FIxyD0ilB5CedO2+2WZ39dki3DevDqJ5FrQQU+gX3wOMspUt8DUs
 Ai8V6ZNjm6lW4nBQ89R6uzyy0LzQ4aqF1V212VqcbEr8wBcEe3+bkAUL0xxSu9yrvl
 hhIwkQQDj1JFnWfctRUMZyXL4wNH0QLGvdgR7Oo3dsZYryhD5S3xL2+uNdOrr+r3L1
 SK178pfKTmD6O1KMcnaGeTgpi+notQGf1Izrq0K9TZPKxIoanhi44me3Y099KtzHgj
 bbJiaaAhgGFmJsjf3ExoMNcglW0el2eAvi0dKCG4K2GyrCuzxNzjKo4OnRTMF0FE9C
 nHSk7yAB7jP1LGm4PLG4jfKw/Ye97BTMnVoi/vZDAniM42pa+bj8WyoxTj36Wj2YBX
 jZ/wQfqzbY5AagISb5L1s2IOeTdLd88EO5AJjoHS8SQg/0npy04tdKfoYmnhRVygw7
 /NoRzo+xE5hEEu25lUO0kV3Dqo0K5kIsXj6yp5kL2GSHkA/ZNBpMzWjRmdrL+dKucl
 dK73c3GOcIz5CqeWTN7OtVubC/GmUfNSDcF/IaeWbQReUtjgG/zV8y5+zoHgjjO/EN
 m5WATplyW7jjNl5lT2hNgLFU=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837246211bso68538605e9.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772013513; x=1772618313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KOzj0b5/V98cHYuLvdhvw85c8OIibFq8+lGb8e54WU=;
 b=A5Nz3IEFWG8KPE2TGX9VoNZXBPiuZVxKSfweaVMookuvyYRmyupmLvetxBJKDlQN4G
 x9d3tHcn8Wvw7LxjRZuxn9obZvlixsrDxh3+9ll/ESwd/4j9nZvz18EfbL58y9/jck0D
 BXFWRrEURpPGqHg4PyTcw402T4Urxop1FoYgR+KH40fE9wvCHmT8yJF9YWWJaCGEKPS0
 oXGOPmMa89Rq2h8g3tK8HkLKMeFvbmuCTIVN8tCFj7/BSEBprIWWGoYxt30iaT56DEOQ
 KGVzZXQZ94tc2vuZ41MlQn+InqNyVaj3ceqaYAQU2OW/KJ2nI9J0Jlm+1votQU43wuHh
 4Cpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBh9j0GYg22IITFjqBsSY/jqT3WFEGccEC8yZmKOUplbHFxr4HPqPAxutwd4DVQJtP+CQTGhg=@lists.denx.de
X-Gm-Message-State: AOJu0YwkvzJfKPqhNoMArx9MQF1CgfA53pmzPflkgdWXM6RMUiisapsY
 oCWRMQu58rVi8z4Sc2Ui2Huqte7186BkKj/KvjdbUAJFbyq4uDPAgKocf4cj8MLiO1n4DvPPTnI
 xXlFHvnlcaaMdxLz01AYnmf2LM3uiddH2ZLE2X5a711+W+czS0cUo87m8mXHbWzfZG0mTews=
X-Gm-Gg: ATEYQzy8x0tS+u+1e5ujiGYIXb/Rp/zRaQJxJsSdPnW0VyJ+VMrFeTF+IkDq/SraoO4
 uvx42dnMmu67aM9B1ASPEZ61YUeIos+ZtCedlPJzn0dN1VXkrJiU/jJsnt4p4erP/K6IQoqTFtt
 Q9x4mwQn+gqf6cGKrVP1UXObSEsLlGkM+lHWMwS1ayt5Ibwek9vRVkh117UxqV0trrI5DFfFyef
 3AqVBOrF/7M/cefXYAeDLv4TKdjLn4luqKy+UAICsl6jogBmcbOHsYuoUsG8aYuv73K7fjTAFC/
 fHs6p5IdT/dgUedzVFnXqwiB/2bVzkW1Sq8KamMrBj2GwaJ0lTUPwEvPioFqBhCLmIK63RW9aWf
 pwtghaTLvRcnDkXJ3VA5M5QLyxN0N0GcNuXzkMxkoAWRm3eBR05P03RWmU1ujQUUwybqrhijAq1
 rx5eHokzr6Gu2DpjmxBSybsTIDAhvtg8m6kglYN7JSbFWE
X-Received: by 2002:a05:600c:3147:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-483a962e3e2mr238947885e9.22.1772013512913; 
 Wed, 25 Feb 2026 01:58:32 -0800 (PST)
X-Received: by 2002:a05:600c:3147:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-483a962e3e2mr238947525e9.22.1772013512496; 
 Wed, 25 Feb 2026 01:58:32 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm59389275e9.1.2026.02.25.01.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:58:32 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: don't imply non-existent CONFIG_KEYBOARD
Date: Wed, 25 Feb 2026 10:58:30 +0100
Message-ID: <20260225095830.45904-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Symbol CONFIG_KEYBOARD does not exist.
Don't imply it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4af0da2485f..30aefa9aae2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -266,7 +266,6 @@ config SANDBOX
 	imply PHY_FIXED
 	imply DM_DSA
 	imply CMD_EXTENSION
-	imply KEYBOARD
 	imply PHYSMEM
 	imply GENERATE_ACPI_TABLE
 	imply BINMAN
-- 
2.51.0


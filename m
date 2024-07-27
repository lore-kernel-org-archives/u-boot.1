Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A904AC3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BF388636;
	Sat, 27 Jul 2024 09:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZUzm0XS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A0188730; Sat, 27 Jul 2024 09:20:22 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BFD886FD
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso401314766b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064820; x=1722669620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJvcKSBLI9vWCce0GdMqM5mt1MSU8S8wGygbaeOcGO8=;
 b=ZUzm0XS2SErM7J6E7DBbR5DJouf8/6jVypEc4vcv2WPvBOO5eS6KA9byJ4WngSTPiT
 DVtFoxXQUlJ9cfgTGjchqXIyv8S+QeB21UR5DLpGDhAyhG++lYBgQYXfm7x+QSOwZolw
 R79Pi8VvlGli1f7QFfV9TiNUVr9wmeFVqemcyvmUWLYQHYIeL3qnvKVcVlGdEiJYz9vo
 14G+ahh3UadNu9DSPkv6LeekBJ/ABCBl4ngSq1o3z/VujgckFVajHTCruo5YEQYiH7ZM
 PaLmC3hV8UaWhe2bdMZ4kCLfv40RZbAPtgw35t+xJzG8Jh9UK/RGkKoBiBxy3VqK3BA0
 yiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064820; x=1722669620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJvcKSBLI9vWCce0GdMqM5mt1MSU8S8wGygbaeOcGO8=;
 b=JjVqgLSVwuF0LF5bRlOTKYRJ/Uuy+HOQXTySIajvKow2iLg4R2VJ2JMCirtbojK6eI
 fZTQFF4lPAKoRdew9l8um+pLQCvwUtM2+m9mkM0q34H99TPWxJob7wF2FF6iecQNgfEq
 IPvF4sd30yy7DZNSV9mvPClAAN4xYuch1wdA9fSGtQ2V02fgEotv8aBeoLEIgw11VQS1
 xPF7Ij6T14Z6RlPfLTqegTnkpvSKJ/K/FX2+xXe90RK5X2g+Dm+hgzHbdIY0pnw9m8gI
 c0Sq5YaoTKy2+o4KFbHOxBCvc+w9LddGOvlGXNTw3Wwz4ER4R9+81qsFmKZwR54pJYT2
 NJGQ==
X-Gm-Message-State: AOJu0YwTNdJ7U2IqoCh/6CacC/Qp9ZGDGC37Y29D0vh0GHzL3pbI3+M2
 h62Zv118FlvM2PcHZbFgHhYKiZG7X7lP7t1B1i+5xPVDHQ/jlIY7lmZrQFnqBdDUywUwlezL+1a
 Tskw=
X-Google-Smtp-Source: AGHT+IHKbMJ1esQGnO1L7Y5sbALP4LLNJv8cTqWBeKDZYB/lzKZi/A8jVSyUbRvEXzNsDLT0Ydq8UA==
X-Received: by 2002:a17:907:3da8:b0:a6f:dd93:7ffb with SMTP id
 a640c23a62f3a-a7d3f8011acmr160806966b.1.1722064820223; 
 Sat, 27 Jul 2024 00:20:20 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:19 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 09/17] acpi: Add ACPITAB for PPTT and GTDT
Date: Sat, 27 Jul 2024 09:17:10 +0200
Message-ID: <20240727071742.1735703-10-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

Return the ACPI table revision in acpi_get_table_revision() for
PPTT and GTDT. Match both to ACPI 6.2.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 lib/acpi/acpi_table.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index cbaac2fcb0..26c5e9f21a 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -809,12 +809,14 @@ enum acpi_tables {
 	ACPITAB_ECDT,
 	ACPITAB_FACS,
 	ACPITAB_FADT,
+	ACPITAB_GTDT,
 	ACPITAB_HEST,
 	ACPITAB_HPET,
 	ACPITAB_IVRS,
 	ACPITAB_MADT,
 	ACPITAB_MCFG,
 	ACPITAB_NHLT,
+	ACPITAB_PPTT,
 	ACPITAB_RSDP,
 	ACPITAB_RSDT,
 	ACPITAB_SLIT,
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index fd8e6e4986..eb3c83ab02 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -107,6 +107,10 @@ int acpi_get_table_revision(enum acpi_tables table)
 		return 1;
 	case ACPITAB_SPCR:
 		return 2;
+	case ACPITAB_PPTT: /* ACPI 6.2: 1 */
+		return 1;
+	case ACPITAB_GTDT: /* ACPI 6.2: 2, ACPI 6.3: 3 */
+		return 2;
 	default:
 		return -EINVAL;
 	}
-- 
2.45.2


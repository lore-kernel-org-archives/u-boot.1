Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B924CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 118D5892F6;
	Fri, 11 Oct 2024 12:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="B6H9hjo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF0A892F9; Fri, 11 Oct 2024 12:34:37 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B918C892FB
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9977360f9fso252668666b.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642875; x=1729247675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=B6H9hjo9g4KUVu5HmuSYcom8ec/as7UQTDx6jVUkd0PUq4pWNoTQm+yHS33Trs2ZoK
 /MYBia1uN05LBcAYXHCaMQjS1yOmDoTDp4vfcXgly+GJBCWEuGDNCFyayTrP6V/HOdJr
 WOKeZFSYBW3KAXlhfXwhofD//70ocsHMPb0USjvM54UYhXkBiXWM2Jjqb/lmL7otHxk7
 2S51dAm28Tr4S0lsidTDG7Rxo235Kgcn6J4sbhtZYX+XC/KuJjqDzWvMv3M760L++eEQ
 hKm7+E1U5TqsA0wUh8+C8jCz7K3gQkvKQ12Apb+rKxR//GsSWiW+X6+tMBWLoT4CfBbg
 XFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642875; x=1729247675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=KFnFPrHI0s2KtrFRJNrYVUJnv6a/L5MhY+jzKwOdd2IFgF8bAT9uW2W7UseJ9QNFWo
 8bqrSXF+EKVGJHOS2hX8iQJDEON29EAhx4uFSLmIYIl9UBDREpJBORvujvvaQmCWb8hV
 G5FA8r9kmhhy0rAtSw4h0xZ+/jk2HznwkuYgSjwl4nPBpH7fUJgtlclYaMcptGn+PJ9D
 4AFLUgJNPg3JW1efMb+P/Y7azZfWdTLbG3zQ9oIx6ydUpS9IyEti+94uCa1UgOqsLceQ
 RZz310/7aUzLS05KWcf8ShoLpAMspIwvc4z5RI8jQlF6b7tnqDjhZWWjWMhx0pKurXJl
 pGYw==
X-Gm-Message-State: AOJu0YzPXN7HpefRl2nq24Q6MnHWkdKREIrXENt0vS4nx09WGUKB7P09
 5EZAkBAt09Kfd8SIXILRx2kZFp1Z8Du2T5acwU3FfFyXVzS9sVEtdZQka6QbiO6I8qDHYdNp05s
 IHik=
X-Google-Smtp-Source: AGHT+IHBeM8KnNiql3FpI1EsonrmAJrGF3ODyEcv15fHrgvu/zvKfste+DBo0MwSescW6nfvlocn/A==
X-Received: by 2002:a17:907:3da7:b0:a77:f2c5:84a9 with SMTP id
 a640c23a62f3a-a99b93f8d23mr161940966b.18.1728642875154; 
 Fri, 11 Oct 2024 03:34:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:34 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 06/37] acpi: Add define for GTDT
Date: Fri, 11 Oct 2024 12:22:47 +0200
Message-ID: <20241011102419.12523-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

Add the interrupt flag used in ACPI GTDT table as define.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index a1bdab7305..c6a3e44a95 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -707,6 +707,8 @@ struct acpi_gtdt {
 	u32 virt_el2_flags;
 } __packed;
 
+#define GTDT_FLAG_INT_ACTIVE_LOW	BIT(1)
+
 /**
  * struct acpi_bgrt -  Boot Graphics Resource Table (BGRT)
  *
-- 
2.46.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C040D65C7E
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD76E895FF;
	Thu, 14 Nov 2024 12:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="R+0axfOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B5F8960E; Thu, 14 Nov 2024 12:51:01 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11641895F5
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53da07b78dfso529185e87.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1731585057; x=1732189857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=30i3fv/upJSlDp3lmNDeS4dvupK9OJB+LZq447+IyYw=;
 b=R+0axfOAfSSMPpXUwlHun89FlHxEd+nUjm07VbROBkfBvv+lRLVQd3lPjE6gp58fRJ
 woq/cHSh0C1vZLD00wlwjcaEA9CLGvcXwNgC1ExBCVIaUef+Lum7Ta3OsUeS+Y6cTZrm
 wImlwE8FptUloVivNqa2g/CMsVYEVKdwHDqYICUc8ru7Hvjg184qQSdSMLeuD+uUhhEW
 8VCfXLvfq2VsInlQFzaAGVUd4a2EERY9Qo1Yol4hgEz5R1PDYmpLb8kAUh8nCuosFagj
 66D+DEfda/3NYEWc0lcjLwl9E88QjCSJNS3WB76gofG/k7NmPCyCeRKmcrWj350B1B1N
 0qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731585057; x=1732189857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30i3fv/upJSlDp3lmNDeS4dvupK9OJB+LZq447+IyYw=;
 b=h/e2ACuPq7Wg4CbcM1y626G11aIsTxQ6qe5n+Z8iFJD3iOOPUc2p2B+v10mq5DL4cm
 +shqY7Qkqijs6XnBarmUcr5sZDzF37Ui3yzOmLDSQu/noJ5vuMQgRfZIMsd4H9ioQ+bG
 B0zbZoZxtmdjw+flQBn9GphOO5XUJvCrACpnqtKi4gQte7LMvcSfhXeZ5Fj7oUJjSTwJ
 Gf86j/OHK0PmAwPvZosNSLgub610z3324u1R0CqYAQXqQHzud0D/iJMYkceLO2DQXvqc
 PejEljO0oD0ghbvV+2JQ0yeF60uWjE/0vr1sl+6IAwAqBT0sS3V1tIyn/ztRXyBXjBlR
 2GyA==
X-Gm-Message-State: AOJu0YyaasAGiFPDC+BFPaCtvUhu9BGXhypy4Lfj6WWa0MvINZQje5Dr
 +1+qYCoaYz9HOhU5blQLb6Im8aYUX/redpE01DT4tEkV/kWUVHbE4qjHZfe25olj3ssF8mWIeJo
 J
X-Google-Smtp-Source: AGHT+IGj7TkMvo5GpRfgtX2a8fk7XXwJPE59ykZJM8E1iMd93BhaUJH7mcd4BFvx4lGzMQ+2qZT19Q==
X-Received: by 2002:a05:6512:3195:b0:53d:a8a5:ba0b with SMTP id
 2adb3069b0e04-53da8a6d716mr740552e87.43.1731585057126; 
 Thu, 14 Nov 2024 03:50:57 -0800 (PST)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab76dafsm17954735e9.10.2024.11.14.03.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 03:50:56 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] acpi: acpi_table: Fix compilation on QFW enabled platforms
Date: Thu, 14 Nov 2024 12:50:43 +0100
Message-ID: <20241114115049.2070780-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
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

On ACPI enabled platforms where QFW passes in the pre-generated
ACPI tables do not attempt to fill MADT and FADT. On all other
platforms MADT and FADT must be filled by SoC or mainboard code.

Fixes a compilation error on QEMU platforms that enable:
- CONFIG_QFW_ACPI

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 150f75027a..e44b6f3800 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -241,6 +241,10 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	struct acpi_table_header *header;
 	struct acpi_fadt *fadt;
 
+	/* On QFW ACPI enabled platforms this is never called */
+	if (IS_ENABLED(CONFIG_QFW_ACPI))
+		return 0;
+
 	fadt = ctx->current;
 	header = &fadt->header;
 
@@ -281,6 +285,10 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	struct acpi_madt *madt;
 	void *current;
 
+	/* On QFW ACPI enabled platforms this is never called */
+	if (IS_ENABLED(CONFIG_QFW_ACPI))
+		return 0;
+
 	madt = ctx->current;
 
 	memset(madt, '\0', sizeof(struct acpi_madt));
-- 
2.46.2


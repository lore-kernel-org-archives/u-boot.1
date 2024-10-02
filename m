Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1070CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00A188FFB;
	Wed,  2 Oct 2024 11:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="HvZ26q3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0851288FEC; Wed,  2 Oct 2024 11:51:42 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1916288FC5
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cdbcb139cso3689833f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862699; x=1728467499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=HvZ26q3gCbeOrpQIfOQyr4ZSeA4dotGi5AP6qE2vUXwNpypKYSKATdlpbpGasLwxJv
 4hAM9YvKnVmL5LDz6g0ELGzYRMvdOIqt5SvCr+1E9giVHNy++mkUAaI+CECadeD23+cP
 fzlCRQsmC0mBlHT9hrt8LweTEaATTR1dsc0kLWwYgdl4caj+t/pfdZg1biLSsUQJAJDa
 z+n8PIRNqK1l5qEkiHxblNmiL66eDhNL5Dc6D3VU45H7fXJT8EQS4bRtnvyuurfUvt+U
 pDOnYlD7E5Xmq+MBc6t8TNoRBjuESG4u9V5vx2Wc/8a60DVx9jbnsk3yDP1w/A8u12zy
 +iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862699; x=1728467499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZE3Q9T5BP6Yd6Zrt+nzATlRAqqpRrDp0DGnyCPfWr0=;
 b=nCxFs+pVSjOcavoz5v+iTIk2zPz9ExNOyXqBnDTApFt1b2hSLib8dqvyGNyB6jXiKG
 GupkPOn7MbG75oLh+fZsxCxk9lzq3VTLMSYD/U2hVkoKUF6zScEPJzNXoivhgetuqzgL
 3Zjxctbd5Mgpl6ZfK//qc0t++opf64PUl7Vn7PwoIZODWI80jRvdkXyalCOPwyutBxhA
 jpTBMyEAsk8Q+DhXVgGhqSW32U2qYJNj5W9GK6PS7aygf0e9gTu1Ua6KLn6PD1Mv91Fx
 ahH4wr3R7PL7z5IBGVJ60j3J6DpSSfZ+YNVvsrWZLJbZ+L4G9CDoA6ZtEGVoKcCwVYRl
 yx7g==
X-Gm-Message-State: AOJu0Yx3KngjzOQU74G0VhFp0EyWVvy2LQc2oiJUcVC2g7AV7zAFz2BN
 0ip18R+izT/PVPcWhXYGVjt/18NaHWNr1zkQLBCMslFGeXzPReILRTSIUgLJjrEAhnqvIK5eYZk
 z
X-Google-Smtp-Source: AGHT+IGzasLxr6zKx7mbhumIem6auSmn4PeynFYc65jOjsHQ0nuup2ztlLoiFL4Q1A5T+Kp+EFnmoQ==
X-Received: by 2002:adf:ff87:0:b0:374:c2f5:38a4 with SMTP id
 ffacd0b85a97d-37cfba19794mr1437000f8f.51.1727862699527; 
 Wed, 02 Oct 2024 02:51:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 06/37] acpi: Add define for GTDT
Date: Wed,  2 Oct 2024 11:46:57 +0200
Message-ID: <20241002094832.24933-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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


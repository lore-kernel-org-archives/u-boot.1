Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F25C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AF087BD4;
	Thu, 26 Oct 2023 20:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPkkbe30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D8087B8C; Thu, 26 Oct 2023 20:32:06 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D114387B8B
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77891c236fcso96614685a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345122; x=1698949922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXXnHgNF6yp20rHXCc7RKXqzjH8jQJDhxQGE0qE6wgE=;
 b=GPkkbe30WBr5zj1YWyMWad6wTicTZZFAqQS/qSuBIsDpxlGXRxwkDVcI13jajtF13P
 GpUZQ4LfU6ohT3vic3s7pkWtl/BZksYrkLk6fXnE/Iz2XAEmcWl5FiLTlXyEEcfVXhxj
 7tUuA/0ZeuLAQjNw//otGOL/nwXSLMU5jAqmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345122; x=1698949922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXXnHgNF6yp20rHXCc7RKXqzjH8jQJDhxQGE0qE6wgE=;
 b=BWyOUlM5PFYiVfu+RfvDlB+sVriF0r2keTX7UX8dVYR+Wyw5FbMcMmcifqt9kboIo1
 /1xXvnPeiVBAk+QEPr/EJzGh+ghuaEuNmx/XVTbc4jNOZItFr5Mo4n/L9HQY3xQkNzp/
 04S2V/ZKryMXgb98Dn3xSTDXfqBLXFdxw/m4FPVz38O2xwQtyQcVmKN7/MivBEM+aRue
 fetSIz0yW0UYfynNCGQbPT9Tpu4ui3GduSj1NJ7pEo3bL5Ipqb6/dVezkOfB+X9/UGyl
 Vizwhj1VO3RNeEpY2PV25lJqJBY4bBrjVPrYhT/XIQOYNBRSyxJkd1zqqW7GPwBLgsA5
 S/NQ==
X-Gm-Message-State: AOJu0YzokXjhuSXDKJhVZTu46BBEBdyaXC6QxAfZIccHTAATP0v4qnEB
 F8mfM++aZTk8dh5BYf64BMCJklyzdR5f7MqrdbfTTQ==
X-Google-Smtp-Source: AGHT+IHqDxCPhr0GGsJyPPJRGwewth84TxidfCZ5zdO96/mJgeO2eqciktnWti2UHuravC++j3t2hg==
X-Received: by 2002:a05:620a:3954:b0:779:dc90:ba1d with SMTP id
 qs20-20020a05620a395400b00779dc90ba1dmr192449qkn.14.1698345122489; 
 Thu, 26 Oct 2023 11:32:02 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:32:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [v5 27/30] sandbox: Add <asm/barrier.h>
Date: Thu, 26 Oct 2023 14:31:35 -0400
Message-Id: <20231026183138.636948-27-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

Add a mostly empty asm/barrier.h file for sandbox where we define nop() to
be an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---
 arch/sandbox/include/asm/barrier.h | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 arch/sandbox/include/asm/barrier.h

diff --git a/arch/sandbox/include/asm/barrier.h b/arch/sandbox/include/asm/barrier.h
new file mode 100644
index 000000000000..0928a78cbf8b
--- /dev/null
+++ b/arch/sandbox/include/asm/barrier.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define nop()
-- 
2.34.1


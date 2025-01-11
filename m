Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B62E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A60F580691;
	Sat, 11 Jan 2025 01:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilJA+txB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A1580691; Sat, 11 Jan 2025 01:01:12 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D7680050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso195601539f.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553666; x=1737158466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=po2aAfbffbEV82CCrdgF7VQpKG0lRJ9swXG8eu3xnYo=;
 b=ilJA+txBciwUCA+tA3+ufj0fxjiTDhcEvGXpN2tZRgxneqlhUg1Avosoz12CM46j2f
 R1AWKfI28F8s1UphbJ7l/m2dBXc3joATCovHt7cpf3jGP8NiTZdf0si0PZ2brwmPH0Bw
 dyUb87vXaOsmk8rqn81+UGd2uRcNafjz3meuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553666; x=1737158466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=po2aAfbffbEV82CCrdgF7VQpKG0lRJ9swXG8eu3xnYo=;
 b=OUeHfJkPSc1aKG6iEc6EZqwXUxlj00bRR0dfFqOrgdT2/FSDWK26xY116cuW56X35Y
 QoahaHGnzXPtEFPrWj3sNr0wxrQde3k4BH93MDzQJZCC+4DpnR5SOlatYYkRID+PF/bD
 IhMwE8zLmURqpSNm/d2Ac5tyBPQm3HMPhuhToLOdn0qzFcjb2irXuXzZAZQwXPRIhLHx
 /nr6sh8jiJCQN1Rulb6ktwT+Ys8ztVdNxswur3sfYElkt2FM8ztCM1rO94YCLYutSZRC
 ls4Iq4bRkNUZWwPXmoXnDgubIJMnT004GeQ+/GYxHxAxrlnHlI973NcnZXeeeAXElzZ1
 CjcA==
X-Gm-Message-State: AOJu0Yx6MF9/915fm0YubrIrB+DWmUFMMXS8iiUJbZaMhsF1cnyu17IW
 aIGv5VJ83S6fs9aK2KCHWKvcXZ4mHHi6E3gocKMRT8GfMBgdhNEJkInVuWFZqEeXvhEdwNChVvw
 =
X-Gm-Gg: ASbGnctpGxlYAs6ryMBO5ZopWwEfmEUCYDFYgGFlvmrd+LIRGBzF8ZqHMXNb14TI8WM
 m5xu3b5uxxlxBdpL2SK+xWU3bwzruq+B2CGNHpVapSUMwBXR5pMUfNCLugZsHArewe9OyhtWtJJ
 pNmcCn/w6AXYQlamAYcrpqWtT0mZpRhYWf/qY54h8OeL37RQC5QDZFPHF2tGSsIiO6QKq7pO88U
 j2mfZ0V/B+MRUWv7y/7JdoSXvweJaflcadd5FQkSwe+f0IYNOYMefK3xtvycyVMM0sYaH7Jkztv
 v50iIQS/PvUUR17TuA==
X-Google-Smtp-Source: AGHT+IEJaSNJ7meo0ezFMWTmWawAIB5cVsbKDXWytv/bYTOaXRb6yrROxIVi3NneCiUlX5Xos7h6Fg==
X-Received: by 2002:a05:6e02:2411:b0:3ce:5af3:79de with SMTP id
 e9e14a558f8ab-3ce5af44a55mr31949405ab.20.1736553665835; 
 Fri, 10 Jan 2025 16:01:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/30] x86: Show the timestamp counter with bdinfo
Date: Fri, 10 Jan 2025 17:00:08 -0700
Message-Id: <20250111000029.245022-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Add a line to the 'bdinfo' command which shows the current value of the
TSC.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bdinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/bdinfo.c b/arch/x86/lib/bdinfo.c
index bd2cf0b9fcb..4b016d4a0fc 100644
--- a/arch/x86/lib/bdinfo.c
+++ b/arch/x86/lib/bdinfo.c
@@ -33,6 +33,8 @@ void arch_print_bdinfo(void)
 	bdinfo_print_num_l(" high start", gd->arch.table_start_high);
 	bdinfo_print_num_l(" high end", gd->arch.table_end_high);
 
+	bdinfo_print_num_ll("tsc", rdtsc());
+
 	if (IS_ENABLED(CONFIG_EFI_STUB))
 		efi_show_bdinfo();
 }
-- 
2.34.1


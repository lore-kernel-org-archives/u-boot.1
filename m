Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEAFE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E058039B;
	Wed,  1 Jan 2025 23:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JqCjBXNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703008031D; Wed,  1 Jan 2025 23:11:17 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4B5803AC
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so101184245ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769473; x=1736374273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RElMRHdYfqAVuAz8m4/TjHEDJWrTY/dyQy7PYMlBLWY=;
 b=JqCjBXNVEptO/eBsnoA0UE7BvneV821+4ac9EmFcUqlwfeOX3KJGBqqWvnKzXXF6Zg
 Bt1/ggoExG29Qk3y9V/n0E9D8G0I1vC0zO2M/9/IYJsc2LJutt8xrNvruhGp1jqXVme+
 YP33xOQuvcppwlGRi1zHg5w0yzS+cxcMas9eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769473; x=1736374273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RElMRHdYfqAVuAz8m4/TjHEDJWrTY/dyQy7PYMlBLWY=;
 b=iS17j8eAQeTEKSmErj3DfI4s4JDerNInAIXK1SC/rI/9/EEIFCpG7u8LN6QGBOF+wR
 WP0uvmVnLeWTMd082waMeEDakNkj9v5L/WcX/lv+zqO8lpZG1VKgXdwi7HUx7yb53qbd
 qNxZBe7Gyj24/zOLrMT9daMvngmVJRsMBZwNAngBfdmgKrSQ3kFaIPTHlEBv34HduTIY
 A2/fMbBIOJ4n+4XIyMnmMZKE0046dlzjYyH/v3V576KbNCObFZj8Wb55yGvhk+m8HMhc
 Bvn406bzzmivjlS+iY9tvT/1mucy6hyGzhPeedFk+fB2fLZa3osBazfqqm9nnUTBOi7O
 HxYw==
X-Gm-Message-State: AOJu0YxAjKVzkEIHWPSo5QbjdFenERJgBDLlcb0J+5hOs814SoeNo3QR
 R/GQotsAkAbO5EGgGrmx5XG0W5GsZCg0inmU4oapza51ULHm7GpTsnAypXS8shjyaq2Wy42erGc
 =
X-Gm-Gg: ASbGncuIroxOT1Tingoj3uJfTvCL79PMXcVQjWz5FsUC4OSZQLgWawFBk8+cSWSIzlE
 5UApYBJhiIKXP9MyLSkUvt6zU1ZNf4a/WNKpR/LbXr6I+Zf7xCPqBQnuD4igdVvbPLwA/bCCVwn
 +9EXnFBZ1bHObhvWgh5Hz+F8mNsZYcHTyWGHRAKZbMcJVdHD5GoQGjNwueUy8sMItQCT7SEX76H
 WY6s0TdpTM3ggwZVFA0dgDjbMxI+9YpnOS0/wursWiwP32OhiBEgAk=
X-Google-Smtp-Source: AGHT+IGffCoSe8lfW6DnD2zEK4Hu0fIKvlRejTFmMfhmaZZTHTTNhTqdWcq9vfmFSHqkTtqCPVbE2g==
X-Received: by 2002:a05:6a21:e96:b0:1e1:ae4a:1d4b with SMTP id
 adf61e73a8af0-1e5e07eff56mr67866254637.34.1735769473173; 
 Wed, 01 Jan 2025 14:11:13 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/67] x86: Show the timestamp counter with bdinfo
Date: Thu,  2 Jan 2025 11:08:55 +1300
Message-ID: <20250101221003.1944600-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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
2.43.0


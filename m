Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475BCC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 116D880F70;
	Sat, 15 Mar 2025 15:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OHAkAk1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722BB81F49; Sat, 15 Mar 2025 15:28:30 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE9581EC5
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so6723445e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048907; x=1742653707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+UMrzanNEKubtDZRRt8rlC1DNa13mIBpIbv6DQ1xMg=;
 b=OHAkAk1CjZ4CCDvVYOR5YJpmEDoVPuxIueN2i74q8jFiMDAYOsshCIEJu6xo/CnqlB
 aSDRTAP9UpNI6L46IbJM/wrLzd1VzmEGhRskOKyTmzRsG2QTiY0payY3FEYMsk08DUJH
 5x9+LS+lXTM2Kyv9uQCLPmmzJE4Ix60fDtY1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048907; x=1742653707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+UMrzanNEKubtDZRRt8rlC1DNa13mIBpIbv6DQ1xMg=;
 b=QOSiIkhj3ExF8QYLI0Z1ufZyS/UAb2WYs7a1166/5oIK3+QxUCry6WY71tPElPudrv
 3b8Ai+O8Jcv5aqOJa5V2G9A+2PHb9BwzLSjs2tJPAhXS4K7V0DkJmKIO2ULdLzOlxsTb
 pWiwqVwvT3o4jzvyS+3eu0XocecRxlCA81jTwgDkWXsju3qe2e3jfCwl6BKvLozkapTe
 Suhg/CwbTdYQY4JqbQUyBdHFZ7Txm0ggxJGtlMsM+o0tmFSgqA9Yu1vgjBUVnTPNP1AH
 qAaZWEKGmNfbhFBsegjo09ZihV8uBGWWpSczklUU27tR9r69Xwgj7jDyHfG4Jaf8Jt0/
 bMmw==
X-Gm-Message-State: AOJu0Yy9h7SWu1zb1IParklujTntCSgezlihux6co2+bEOlDuNCs4nvv
 nZXVPpOjkpiSg0NmNXABtaS8ti+YeQKaoYu2Q7hmwAF6ykulfuOgrM3BhocsbdIKZmiSXmKdHip
 E/g==
X-Gm-Gg: ASbGncssy0WMhnwv+PTVmygncdoJmPGzGtctIEi2pU0AP0hHwvHc7Sz1UOEdKZdgqmp
 Mhwj9bzgIBc3Q9raUGymoXlY9si7Kq1LTh+1aeCO+aZ3TIs9jWq/9pW4jtnOoC3O8VvNO0USFRN
 /hfT7c++Qpj51631P4TlxH2KIWPORL4rz6XdfNq11t+x6yIoMMzkq4uZhfT8V+k9gVrOLxGHhfS
 UXh3UdfKicgFYS+RjUOq6taTkI0ftUW/3H470zAUTvUWRR+TrHXMBxjqOIO1nBkTP1CrBIB0Myr
 5qRrgCAWSqrTKW5tjC0HrsfXmWyzyKzXhdT9tCTB0Q==
X-Google-Smtp-Source: AGHT+IGg2YjQmS1PmGKwLfzayPrZdxoepozDw6pdGEjVu5fEcQ6BuiotYA7JJF1VzIlFsujiEzSvSQ==
X-Received: by 2002:a05:600c:468c:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-43d1ec621f4mr56353225e9.1.1742048907479; 
 Sat, 15 Mar 2025 07:28:27 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 37/46] acpi: Mark struct acpi_rsdp as packed
Date: Sat, 15 Mar 2025 14:25:57 +0000
Message-ID: <20250315142643.2600605-38-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

At present the size of this struct is too large on 64-bit machines.
Annotate it with __packed to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to mark struct acpi_rsdp as packed

 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index b8b1f1338c6..8ef19adc990 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -36,7 +36,7 @@ struct acpi_ctx;
  * RSDP (Root System Description Pointer)
  * Note: ACPI 1.0 didn't have length, xsdt_address, and ext_checksum
  */
-struct acpi_rsdp {
+struct __packed acpi_rsdp {
 	char signature[8];	/* RSDP signature */
 	u8 checksum;		/* Checksum of the first 20 bytes */
 	char oem_id[6];		/* OEM ID */
-- 
2.43.0


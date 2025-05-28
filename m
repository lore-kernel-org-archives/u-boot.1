Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E607C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B9F839DF;
	Wed, 28 May 2025 10:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YZ8NaZ3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECD7839DE; Wed, 28 May 2025 10:26:31 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB6483966
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-861d7a09c88so87363939f.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420787; x=1749025587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NdUz+wH5Zi5EXzBuG1UE46s+QyHNqPzklG7Sm9R1EQ=;
 b=YZ8NaZ3LGdR8gQVwRoVOay/wcyAbnB3eX9Xc9wL/kCJW5Lc+ABOhvU9VYSJY8mq1UV
 WvXl6+1RHGWGFEvCxikMbNzKCZuGBHi0XsMIr4cn4iRzjuOF/VcbODkWclFgFDg9hKJX
 fRnhQn5+zI7SpxKM3CIYgboJmbTBZGCVCWFlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420787; x=1749025587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NdUz+wH5Zi5EXzBuG1UE46s+QyHNqPzklG7Sm9R1EQ=;
 b=lLQnG4CeVe6iGpwcMjNHWGBnQVzDgPtCKdHmcmwogL9xYccNGPMpIrgiz0hirF6/pJ
 MkAq835M9u/EM8ttm80JAnsSh0EyaLgN6ZpPmSXRpezsMsw+tiFpCdbtvpZyUaHDutjJ
 yQ6yv4TXRdJZnxmdY2l55c6Nqejp3+INQ+HNoytL/OQ4sZ8JTQhfXlk3YSqppiWGtr7b
 2CCyEw1lYPRwq1GpwhjXuEjRpc3iyguz09WDQuZUsZhMnegN8RM4FW7Bj0QPFhK7CUeM
 00tJCZsBkc5uuFMVLrjhOFqZ4r0LBMZL4/ZIUhoavdbJE8rsh/clvxlhOThmpKPE4CFv
 qKfg==
X-Gm-Message-State: AOJu0Yyr/pIoZ7Ie9hjmoZFbff22MgkRT1GiA2kzmVcmubchffvN3qc9
 Tcg/rbu9HLSSpA5bMpsXuRuSXy83uz1wxrimPhbYIo3Srhqq2iv/FwQjIdmNsJj83N0zl2fbHEw
 mt0AzYUmM
X-Gm-Gg: ASbGncuGP74HpVGWSPGnqrMyeJ6VRabHsPOuOAchw2D+HRddsNpktaPo7TiYH7k7Kmv
 4rbsaa65/fVu0gKAG/tTLcpmoKvfkubRaHXuQwkBGzwBA6/QADt3yHysEi+XgZRTdD9LQG84YyT
 VlGulxYqM2nZFZ3CjGDtF4CImJ74c6FqdruvOucyxqIqBAs0mXv/Xd/swDL5NWw2Lzm8LFGElqQ
 0Pd86RJO3tTyeDmX7Bads4+67tYEBi/9pGRQLBRqluU/poRmj6mWvyl8CVwFbhbvnQOnMu02hen
 do8PgK4U/fw08scACTf9+m1GS+zf++9mTT3nNZeJZg4KEvBRKojkAO9ov5n8Xwoqdn+4WZV5JmK
 rOGjO71Nr8QOj
X-Google-Smtp-Source: AGHT+IG7P/qCcpHV4Ob+NF1YJKVMFlpRhk9QsWCFF8Rosujh/yVlOv8YLrkGeERUd4IlFjUOvr5Waw==
X-Received: by 2002:a05:6e02:b43:b0:3d8:20fb:f060 with SMTP id
 e9e14a558f8ab-3dc9b6acf08mr169791105ab.4.1748420787208; 
 Wed, 28 May 2025 01:26:27 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/27] x86: efi: Tidy up the link scripts
Date: Wed, 28 May 2025 02:24:46 -0600
Message-ID: <20250528082520.152391-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Mark important sections with KEEP so that the linker will not remove
them when garbage-collection is (later) enabled.

Provide a _end symbol so that this can be accessed in setup_mon_len()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/elf_ia32_efi.lds   | 5 +++--
 arch/x86/lib/elf_x86_64_efi.lds | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/elf_ia32_efi.lds b/arch/x86/lib/elf_ia32_efi.lds
index a3ff0068b40..230df63bb48 100644
--- a/arch/x86/lib/elf_ia32_efi.lds
+++ b/arch/x86/lib/elf_ia32_efi.lds
@@ -51,7 +51,7 @@ SECTIONS
 
 		/* U-Boot lists and device tree */
 		. = ALIGN(8);
-		*(SORT(__u_boot_list*));
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 		*(.dtb*);
 	}
@@ -75,7 +75,7 @@ SECTIONS
 
 	. = ALIGN(4096);
 	.reloc : {	/* This is the PECOFF .reloc section! */
-		*(.reloc)
+		KEEP(*(.reloc))
 	}
 
 	. = ALIGN(4096);
@@ -83,6 +83,7 @@ SECTIONS
 	. = ALIGN(4096);
 	.dynstr : { *(.dynstr) }
 	. = ALIGN(4096);
+	_end = .;
 
 	/DISCARD/ : {
 		*(.rel.reloc)
diff --git a/arch/x86/lib/elf_x86_64_efi.lds b/arch/x86/lib/elf_x86_64_efi.lds
index 5e1e8714351..e5da5a58952 100644
--- a/arch/x86/lib/elf_x86_64_efi.lds
+++ b/arch/x86/lib/elf_x86_64_efi.lds
@@ -21,7 +21,7 @@ SECTIONS
 
 	. = ALIGN(4096);
 	.reloc : {
-		*(.reloc)
+		KEEP(*(.reloc))
 	}
 
 	. = ALIGN(4096);
@@ -44,7 +44,7 @@ SECTIONS
 
 		/* U-Boot lists and device tree */
 		. = ALIGN(8);
-		*(SORT(__u_boot_list*));
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 		*(.dtb*);
 	}
@@ -65,6 +65,7 @@ SECTIONS
 	. = ALIGN(4096);
 	.dynstr : { *(.dynstr) }
 	. = ALIGN(4096);
+	_end = .;
 
 	/DISCARD/ : {
 		*(.rela.reloc)
-- 
2.43.0


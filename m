Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE02E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B5680239;
	Wed, 11 Dec 2024 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e31E1AyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB828802D5; Wed, 11 Dec 2024 14:54:47 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9131C80239
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844c6b3e989so51958839f.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925284; x=1734530084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lk40rRAkNOCiTKbARRH9pnMyf3X6RAqhMHXaALoUa6s=;
 b=e31E1AyDWhbmcIVZ9Yq+eDHH4T2gRpF0at9svG1Q5rLenvft2YqtO1P6a6Hy8N5apR
 /aip/IWJaVSjj1ovVNmtJoLBkWYkdIvkV/shNF0IddzXcF2kNI1AbrvH0a9nIBTQbusV
 9gMJgB+YvdYGAzMKXgqa+SHQ0yTGZ4Ia7aCTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925284; x=1734530084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lk40rRAkNOCiTKbARRH9pnMyf3X6RAqhMHXaALoUa6s=;
 b=KHTtior2aubOra0DYJFjgYw/yz4GxMKRWh8V8Ki1pV3YNzgE071gr7RWUWwPyoA8Hz
 KWN9mdZttEUU+r8HsN+LfeXNDtujkcm7nSzH1TQwd0MV2FUHYYBLE7i/lS6pyBplTaci
 5L8xb4eEAsZwhiSNW0bz6EHKL4NemFXJp0Mo89GDw020/vy7B7nuPAPt4Xm05CGDIK8d
 O7Jvt5ZzUW0rX2SDRA0W714ek2I8rSfrlNkGCX8NBgiFDetKKWCvBahulRewcvRiyBYN
 LH4C3WQATfvBYSU0nN1l2Cr4KLlVcU2qtnJAPIAyFS+OKppvCY/oCXNUaN670Hvkv9iJ
 4IZQ==
X-Gm-Message-State: AOJu0YwbtPudnBjurLk9MyM+jXN9g/hPTu5JuWmjz6P7g5aiOoj+DULO
 hY0D7zevViRYtrLqgLMTo+iN240jQS6NknhEK92Jw6YAX9sgToqcMKwzO+l7G34Z5FPB4UC23sU
 =
X-Gm-Gg: ASbGncs3spyVvRKAisDU+aztoUzEetX4Ahk6MZ8ptY1DFEcGwF2GvNvGjR8yN3piSCW
 AGvhpv72aBULqQU1+p2pSB4ll4n7bLClVIVIens/omURMYDzn9BmPUBvajZq+pXVq+4KgGmnt6a
 L1Smg2H7OElVI3ign4iCKH96kcLfdTcInLcLYXYZSzKu4Zk7wfwmvAF8rTIjjnGiwyuZIbfFiAd
 m/b8OIUKd7poo36llV0xVcE7ocF7vy6UR5ZNMcYs41PRBgtXHAOLoq0JeOom0zbRLVw8gOuMgqT
 Mo3WIHKoLjoD7/c=
X-Google-Smtp-Source: AGHT+IFD9atLF9LJ/+/1lUkmfASZY+i0rbKvEIpl2ZGuUlGhzwyjr8V9pAYx6OpOqcslF/CpPRwLPw==
X-Received: by 2002:a5e:a511:0:b0:844:cbd0:66ca with SMTP id
 ca18e2360f4ac-844cbd068aamr274103339f.1.1733925283766; 
 Wed, 11 Dec 2024 05:54:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 11/23] efi_loader: Use the enum for the memory type in
 priv_mem_desc
Date: Wed, 11 Dec 2024 06:54:05 -0700
Message-Id: <20241211135418.563803-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

We can make use of the enum now, since this struct is not exported to
the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 024361483a0..4c0fd0c5dca 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -34,14 +34,14 @@ efi_uintn_t efi_memory_map_key;
  * EFI application, other than through calls to efi_get_memory_map(), where this
  * internal format is converted to the external struct efi_mem_desc format.
  *
- * @type (enum efi_memory_type): EFI memory-type
+ * @type: EFI memory-type
  * @physical_start: Start address of region in physical memory
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
  * @attribute: Memory attributes (see EFI_MEMORY...)
  */
 struct priv_mem_desc {
-	u32 type;
+	enum efi_memory_type type;
 	efi_physical_addr_t physical_start;
 	u64 num_pages;
 	u64 attribute;
-- 
2.34.1


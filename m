Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066B6C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9A980F98;
	Mon, 24 Feb 2025 06:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YUrLGOVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7761280F16; Mon, 24 Feb 2025 06:56:09 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A237805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2210d92292eso119079955ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376563; x=1740981363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTWfSnXHWQAczOqiHHmany7qLaeSP7V9MPQFl8iHZ5g=;
 b=YUrLGOVDRcW76CKxiE+0KW8a1/4t3Se0XhjgHuJQdf63VZInr5YiwGHkrS+HltVHt3
 vAeX+IY2gHOc3+ipKRAJXczfEWV61oKBWKLT0xVNasjtzT0seaLlpnwNZUcIHHwaCtmh
 oH4Rtp/Wnx2BMAGL/dDcSYSP9haVyK60aIv8uXvYa00sRKP1NyIbwFaTSgcjwcwp70wU
 XtdB5IYTB7/Ow/8DfqvH4tJ2yzn/LvFdKjRPRN/owl9bo4ESQpNUTVTT1nXoLAOquz7Z
 6Zp7KgkaTjs719dTDDUBPMq3ykSeRXDt/nTCcSSuvPzWjXRI53pREr2vbo+L4bHQ4O4p
 5qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376563; x=1740981363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTWfSnXHWQAczOqiHHmany7qLaeSP7V9MPQFl8iHZ5g=;
 b=JwSmF8yU3p/3nY6s1N3mnY8YPBZxk2NSvb6iBEv/pXOCyAV31iblV2fUronxywnKBE
 1ibz9R897ivwVrDxgUbRdZMzY8kjcMuHc0fphrILjQHLYdR0dXshXC0n/TCidYJWkUtW
 x7IYSN6DIkpyZ/DneZf+puNzkgn4iu7kFFR7BS5kjVHwumxY/6gsrtQOUIE37/n8HL/2
 QjCvqx5Xu4zpmVcdEOInR4CGIy4qVLN5YG0JFkHEwVqZMKZzZnj7Qo8ZnSlPrwLvoYZS
 m2Q+QNxmPaRltsoac1hJQuuVFsqpU2ahAxUaTkfhShWQ2UAzxuofSuxYZsbR0qZqHrum
 WR7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7UzyRABMbcUybtHIwrzHrjDcF2Wfza9CfNNAe0rtLAZgpgPlYShyjcIbYt05wou93Az92h7o=@lists.denx.de
X-Gm-Message-State: AOJu0YwRBE80Hsirz2Mb1p9qIDZjGTd7MSP1UovdFUCpqs4FHZ6+kSxk
 q5pQE7CS2ydQqvGZ2BnNAWS7b5XurOCknag//aAQ7nl1AEbJE6dIST0jubsKtVs=
X-Gm-Gg: ASbGncs4byLRh5ANwOCvzcXnIE3NP0aQyq8zvsDp34scJBHx8+XFm7wNECfiibpYcI8
 lQpT2tc5BXQVmYvY23j9FK9nIVgfmnriEk6uuaH5+BYO0A+ylUyBSQJNean6HyqxTa3RxC9IbUS
 twIRFDeac6wklJyODjPZrYXq1GNZhJOWWNlj8bJWaS9gfdaWzKLbSUI3U5ggb18xTZJ+y+PIb7c
 nmBRhhoEoUiMojpb8n2c6eqEJIpA9QVrKxuHesMp9GRgLWydahlWpjC7+yeQfxg1wmVtnGZBFUZ
 lAYoCQ4akIa22JaVW7obP3BFpgUswOVU9AEpOQ==
X-Google-Smtp-Source: AGHT+IEoneYDqUkxIiTxeS7sxRciCg05sB67iryx8/25ZIZSDq9l1HVSL7IsgynwIWatuG6FJwhFGg==
X-Received: by 2002:a05:6a00:4fc4:b0:730:7771:39c6 with SMTP id
 d2e1a72fcca58-73426cab09emr24165624b3a.8.1740376562817; 
 Sun, 23 Feb 2025 21:56:02 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:02 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 05/17] arm: Discard unwanted sections in linker script
Date: Sun, 23 Feb 2025 21:55:12 -0800
Message-ID: <20250224055524.1334929-6-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

There are a handful of sections that are not useful in the U-Boot output
binary. At present, the linker script moves these to the end of the
binary, after the _image_binary_end marker symbol, so that they don't
get loaded.

The linker script syntax supports discarding sections that shouldn't be
included in the output. Switch to this instead, to make the intention
clearer and reduce the ELF sections that have to be handled later in the
build. This is also consistent with the other architectures' linker
scripts.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/cpu/u-boot.lds | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 63e82a09fad..817e7a983ae 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -181,14 +181,14 @@ SECTIONS
 		__bss_end = .;
 	}
 
-	.dynsym _image_binary_end : { *(.dynsym) }
-	.dynbss : { *(.dynbss) }
-	.dynstr : { *(.dynstr*) }
-	.dynamic : { *(.dynamic*) }
-	.plt : { *(.plt*) }
-	.interp : { *(.interp*) }
-	.gnu.hash : { *(.gnu.hash) }
-	.gnu : { *(.gnu*) }
-	.ARM.exidx : { *(.ARM.exidx*) }
-	.gnu.linkonce.armexidx : { *(.gnu.linkonce.armexidx.*) }
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynbss) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu.hash) }
+	/DISCARD/ : { *(.gnu*) }
+	/DISCARD/ : { *(.ARM.exidx*) }
+	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
 }
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDA7E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD038031D;
	Thu,  2 Jan 2025 19:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OG3GXvNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4728034E; Thu,  2 Jan 2025 19:11:48 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A9E8001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 19:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A1CDE3F8E3
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735841504;
 bh=deXMASaF16DGENGmttHe0fFpGFrLaPSpclmblaOJRc8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=OG3GXvNlS0EyS6yJg1sbPqPA+hS5wyyMyjftlc5vNvQamQq0wmP3+69E3WYElT8yk
 Dg+fZgdWi8eUC8r8pQ+XGtWBLMIjr1UBxqPeRSMmYQ9jMkGM/be0P6DgQ9BTUplA6h
 NWdT3gpW2b7gszDSiwg1B+NdMYKnrDNfqsiqaw/HlUmvoJxIfYP8SqfJNvs9E3CnHS
 6tUjR9DPOk/BxWABGWMUqUf1Q1mgLf5PjlKHep7V77hxFJxrddgCJarp1fMIqWiafC
 MvsFycqOitDyUOVRE1NBp0cQzqMA5WHJcFYxq/AbKpS+u0iOpwguoz7Olaiw2sU0OO
 jx6Bu4YFaClQQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436248d1240so58124915e9.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 10:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841504; x=1736446304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=deXMASaF16DGENGmttHe0fFpGFrLaPSpclmblaOJRc8=;
 b=bNL3xYA4TBqbBKLh3YO3Sc/3+SV0gkitknFv/JjsJ9IPQY30pi5r1etgtNOk5YwOfK
 i6x9qjrDETaerBlVqbI7ZesT1VQfMNVB3TgyLu48FAX+6aETYugdNNAVH3oyygtYByL1
 6gDXBJk1qqqA7gs0HJl/p5CpzsuOblb2mUIUYtA0NdIbwoooAFN/zEdWZpJFHQ+ZTOIZ
 AGJNzokl7WFcBbLLwuxo4Ei9BUbDiAzPYDLbIULP0r0mAqmP4Q2HqQY/fYP/E8RrQJrJ
 Mkyu0jNFvmUpuVe50h/nU0s6KMDTE1J7EzO8LRGrsiI7N8iXvtFlQWOBopEqiaYN7gog
 Suug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfLZp/0PL8nsBKV0GFD4YuvSV/MUAJxW3qUL+N23GXt0YILPLSdqxMlry72GiBR21Ys0NFyMg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7Kp4KGS+Mmh8t07lARpo1moVdS98PTk9b8ibqhv2Hzw2r0aIr
 KFKPMXBY3LcpX+Z0ZW7lpzqU85GsvkQuZ7ELQT5qgpa+3yVP9eY1eQx3vorZzNb+GTIIL3EQ2fi
 mb+V7H0l6XAzFfbYfYefBrIPSMbTqkqPsmyJWmHwd9aBwSFxGD6/3PHBjnlrQA7hkFTs=
X-Gm-Gg: ASbGnctrsnBnglJg/EOqYM2/M1Hh9MYjbzO5RQ3JjayMN3JHPMMDV2wZkCVyzNvDJAF
 oiDF219ymRzEe0yrimWvjKPN+RQBTwvJDFI2zuL8xU+lG9IrhWia4MYeQ7X0gYlTBqe3KHTCrX5
 RUHdpuS+/vyzUe/Geblq85dyHqKDAYRlebrhktX3C2BoI3U38jR+YnqiK+1fs1+LAn8FI/lfvmf
 zmUCshDMeGxTjE5aOno2ANAj7+tINbfsvI45flW/eyGtpzPR16+OPvx+LGszs5T0Pu6CCJ3cm1G
 gLPf0or5CtPJAw==
X-Received: by 2002:a05:600c:350b:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-43668643203mr495726455e9.10.1735841504022; 
 Thu, 02 Jan 2025 10:11:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwzxDbwgTxjd8errXZX74PuSpueUToc1fp1zpopUz4XSIsGLB9hLKiIfSNN0lR/YHGX5O5Zg==
X-Received: by 2002:a05:600c:350b:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-43668643203mr495726265e9.10.1735841503629; 
 Thu, 02 Jan 2025 10:11:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:2b1b:688c:df4:9c06:702e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm496278155e9.6.2025.01.02.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:11:42 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] efi_loader: enable running the debug UEFI shell
Date: Thu,  2 Jan 2025 19:11:29 +0100
Message-ID: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Currently running the SCT fails on x86. The EFI shell overrides U-Boot's
Simple Text Output Protocol. When ConsoleLoggerPrintWithPageBreak() is
invoked with ConsoleInfo == NULL a crash occurs.

Debugging requires running the debug version of the UEFI shell.
We can use `add-symbol-file` in gdb to point to
Build/Shell/DEBUG_GCC/X64/ShellPkg/Application/Shell/Shell/DEBUG/Shell.dll
and the load address of Shell.efi.

The debug version of the UEFI shell checks several requirements and
fails to run without them:

* HOB list (only on x86)
* HII configuration protocol
* DXE services table

Implement the missing requirements.

When starting image add the image load address to the debug output.

Heinrich Schuchardt (4):
  efi_loader: implement a HOB list
  efi_loader: build with HII configuration protocol
  efi_loader: install DXE services table
  efi_loader: print image load address in StartImage

 include/efi_dxe.h               |  54 ++++++++++
 include/efi_hob.h               |  32 ++++++
 include/efi_loader.h            |  16 +++
 lib/efi_loader/Kconfig          |  15 +++
 lib/efi_loader/Makefile         |   4 +-
 lib/efi_loader/efi_boottime.c   |   7 +-
 lib/efi_loader/efi_dxe.c        | 176 ++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_hii_config.c |   4 -
 lib/efi_loader/efi_hob.c        |  33 ++++++
 lib/efi_loader/efi_root_node.c  |   3 +
 lib/efi_loader/efi_setup.c      |  13 +++
 11 files changed, 349 insertions(+), 8 deletions(-)
 create mode 100644 include/efi_dxe.h
 create mode 100644 include/efi_hob.h
 create mode 100644 lib/efi_loader/efi_dxe.c
 create mode 100644 lib/efi_loader/efi_hob.c

-- 
2.47.1


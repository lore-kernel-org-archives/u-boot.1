Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C68BC87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CE58338B;
	Mon, 11 Aug 2025 07:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWmrUnd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CA183285; Mon, 11 Aug 2025 01:38:07 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA17683278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so3123507f8f.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869085; x=1755473885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWI5KRBOwEBljYD0QvIpVp9gSD3MHIFcstoJodQZd14=;
 b=TWmrUnd/xTnyMkzmH0o7to9P8axchiUi+YCFD7CufyEdF+qWSLtQLgngGHwAkmv9MN
 qwulo0D4R2OqzX8DS3T8GgeRMsk7ue/UPdQGTYNfPD/t1XYQACkuIlxwpO8CgzSLAbv7
 ejlNSwnUMUcagPcj0IRPv1du46Kkf+lE2atz8rUwtDzPC11gWX4z+LWNReED1mxQMSp4
 P5mX/EmcyIwVcjdit04YSqBnYV+5CPpJcZnPFj7z/XB82H4GCzerknVSzM9dINgEdxYS
 Zo22Is/ll437KUUE4u1aaCp7vOKfXECNfZG6T6PFsMbFv/QtDoRleRmOhA4oY5C9p/oJ
 0sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869085; x=1755473885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWI5KRBOwEBljYD0QvIpVp9gSD3MHIFcstoJodQZd14=;
 b=vXVeMN2WhYjjqoWSNLbg0sl31Kay22OEo5Vm8vaEj2YZ87n4fOA26MVHM54lt88cvu
 0/zwEpViO6hoZ3gFBxg3OTzB8y0M5ZBndle5y9fg73I31w3c0lY8evEcdpye4Qq3Nui5
 JBWbsn9HH6nDFj6lB1fz8M6foSuU73m7HxJGnUZhDdqG27guIwpCXdPVvs+J/VfrYOg9
 pAp+6oXIlj+AuRMejVfei3D0NS1blRcX+rm/+ph1a/mxXr9oa7GVHzE6pNlmaYN5oWdB
 W7nbYCBEKKxvFVA8vPzaIgbkGfM6SqqF/Y0SdzUQuRj8ROh07SlRDMLdJHC88GeqJyK8
 T/iA==
X-Gm-Message-State: AOJu0Yx8C2Zr/Hf3TycqNZ5Uay3fVDGb7+fGy1m0Q3+9mlfbIvXA1SuQ
 Y6b5MiY9oov43luLNnHHQaQlpG1W3iuZNKlqV+1Dl4TU5RjqN9aps8CDufwpow==
X-Gm-Gg: ASbGnctJfVmx2S5XNpniJ6VPdc3zChlgywCJWZpQ7CMj3Wd4zN4017FanKsJs7kwv5M
 Y0ugsvhSYYJ9yZ/zPYFCVzlmLcqTvgU3231KNmkVNmEwfnTzHA9ukLDgaVMzpqRPJCXtjAIrR/L
 cxXdkW5ywRavdgsqLpuo/1ND4K6YaG+7qnr1X4Y0odrnl9XgPLv7i8XkOWyYlOfZgx3Kks58NEs
 Xgx5qA2RkW69/k1HdQ/b+o0RzkWH0DgAzRy2WeEJuDsC00j4rlBfN68B7wYFseagq+oHee2hI1A
 H+iBb5bDT5vlI71BdXJJoWvBl4zGoTPgDwh2e31kn1jMKuDrT2dOpsezKUI7ZjN741ULQBsIxvz
 LBi6bor9ke9ZjxYN8894XiOBprvXXcg==
X-Google-Smtp-Source: AGHT+IFs3E8YyPANzFWHzJ3zjr72z4JWJcPtvihjSqZw46kdnMnARUECDaX307AJuDAD+ZpveKgFLA==
X-Received: by 2002:a5d:5f43:0:b0:3b7:93c3:7d49 with SMTP id
 ffacd0b85a97d-3b900b78b65mr8775318f8f.39.1754869084685; 
 Sun, 10 Aug 2025 16:38:04 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:04 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 01/10] doc: Fix typo in doc/build/clang.rst
Date: Mon, 11 Aug 2025 00:37:32 +0100
Message-ID: <20250810233742.51902-2-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/clang.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/build/clang.rst b/doc/build/clang.rst
index 09bb988e923..7f9b7c266d9 100644
--- a/doc/build/clang.rst
+++ b/doc/build/clang.rst
@@ -46,9 +46,9 @@ It can also be used to compile sandbox:
 FreeBSD 11
 ----------
 
-Since llvm 3.4 is currently in the base system, the integrated assembler as
-is incapable of building U-Boot. Therefore gas from devel/arm-gnueabi-binutils
-is used instead. It needs a symlink to be picked up correctly though:
+Since llvm 3.4 is currently in the base system, the integrated assembler is
+incapable of building U-Boot. Therefore gas from devel/arm-gnueabi-binutils is
+used instead. It needs a symlink to be picked up correctly though:
 
 .. code-block:: bash
 
@@ -64,7 +64,7 @@ The following commands compile U-Boot using the Clang xdev toolchain.
     gmake rpi_2_defconfig
     gmake CC="clang -target arm-freebsd-eabi --sysroot /usr/arm-freebsd" -j8
 
-Given that U-Boot will default to gcc, above commands can be
+Given that U-Boot will default to gcc, the commands above can be
 simplified with a simple wrapper script - saved as
 /usr/local/bin/arm-gnueabi-freebsd-gcc - listed below:
 
-- 
2.48.1


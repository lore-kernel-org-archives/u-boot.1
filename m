Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A95C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9856783531;
	Mon, 11 Aug 2025 07:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5pGr2ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C33783278; Mon, 11 Aug 2025 01:38:29 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C2518327A
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so3312564f8f.0
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869106; x=1755473906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Is3zr3VPyzBigpQBqHdsAWPu35+3o/JK6FeDDRPBCKc=;
 b=c5pGr2eclgFE903PRq5J0bIS51talHi7RG3j1+ZASExNVlNa7wb/zNct/NeMcz6F9K
 CqXdrFj7+h8QSP7K4kcXYzegEUK2Tn3JC7waPxcwZ7oDjG/k7Yd89N49sQT3RXzQfj9w
 HV3y8cphOUhZA5x2bNkXwVu5n0H3GygqbmJH35OJcMKQUSh08ri1VT/KejHdwLwjfnEe
 HcEJcLNH0hu0kqPMNeQJhzbBK4o6Xod2luF1uWkDB2NJ4MahP3EYfqaTI1DDv8qF+zPD
 +o+thZi0MYA/9ML02Tgu1lV8Tpxa+i8j2HEUsICnHiRjzEDWxol14g4yk7tbQlhyP0y5
 +veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869106; x=1755473906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Is3zr3VPyzBigpQBqHdsAWPu35+3o/JK6FeDDRPBCKc=;
 b=ndWVMLREvXH4zABKlg45KXdhNHWwtHuKPDZTQ/AElgb1IMqHeZrYTTX4BuVhxqviM8
 Rg+Elf21oKuDV/+gHBdn/ukIc+UlgcUdyoWWNeILem69V6ZY92aDQZ1xaSo/KovbEmzl
 uf/OTX7qN3n2DyT5P1NflT7/6rY0zEknUgsrZGjVmtwUKvSRvGYJuSYChJJkmdvpaFSH
 zqmgkfd7zaNDVCqxNkbl95TZORxLRhFrqPKvlJjr1HLGKB81qM3g6hrCassxmtck7nSU
 H6ZFL0swMIvVceEHssXym+NpA7dqekUxJ/N6ds69FI4sUwvNNXnADVdliMPYUaUHssH/
 Fvkw==
X-Gm-Message-State: AOJu0YzgHLBsAB4mYQB5e6GwyiJIhT+81A0uixkPZhBbGaOt3ftcD+Xc
 NVSnHBB8gSy+FXeMB8Akfm2EdXrW81dLI/0LjHP6BvOtadG6VxKqJn1jRLdmRg==
X-Gm-Gg: ASbGncvDCGNfZ1utnSKKVePSeCHj5RobE/NUOY22unKYJsrP2QQX84XYLfhCCCV7SsB
 PO/f3liYuW4r1XRTh+QD+dckP8MnkGe5kTpAt3+nmdQhduG9NDT4M5XMc1NUheKGuUW/MCIXXzT
 ZpqgI4pcqBGBt+ERVpMr0ZPOg6rieU4iI3me2WilbchXSqdgVNjZi2unvxCXCvmaT+aWy5Rdruq
 Wqrtpogfb3sFK670Dakji7PR6nEemDOX0iKZr8KVNHyUVFFVph3Ph0CWgKZoRCu8kYuXVly7Ahf
 IdNNDzM5Vmz9jk9iL5EfEKdiJ6Uq0+GScx8CpcGWmL1jXPjUKKe3Vdlk72m4PqW7wxJNUpd3KmB
 At0m1LC2KZ8FBgSLo3fvp+wmrhEPy07guOvw=
X-Google-Smtp-Source: AGHT+IHng8aYvUu/2hQep/4BOmACcjh9rPH+CB6M1zSKmqBiixPDzcK/kpB/y0i5ehP8H5V4rqM9WQ==
X-Received: by 2002:a05:6000:2502:b0:3a6:f2d7:e22b with SMTP id
 ffacd0b85a97d-3b900b4f08fmr7449610f8f.18.1754869106336; 
 Sun, 10 Aug 2025 16:38:26 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:26 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
Date: Mon, 11 Aug 2025 00:37:37 +0100
Message-ID: <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
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
 tools/buildman/buildman.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index d5d22732088..7944adcd867 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -478,7 +478,8 @@ Setting up
 
    At the time of writing, U-Boot has these architectures:
 
-      arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, sh, x86, xtensa
+      arc, arm, m68k, microblaze, mips, nios2, powerpc, riscv, sandbox, sh, x86,
+      xtensa
 
 
 How to run it
-- 
2.48.1


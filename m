Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDD2C54F32
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 12:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F1E82E76;
	Sat, 24 May 2025 14:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GWocpjwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7C4830E9; Sat, 24 May 2025 14:09:54 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A156B81F6B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 14:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so7471185e9.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748088591; x=1748693391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rkaI5aW08vd3extL8l1xDJ235d2pvllt04k41fPocyY=;
 b=GWocpjwc6pHM1UtcL3EaoB8/SUl5knZyTGKHio9f3fbI9G7jpWZmTxiPD1wlV2nBjV
 A+CzRGZKizBeb/63ym3b01+KqaLgK8nP1JmHP3saUgX+zyCuaIABHAetVZHseSU0d5T/
 TnPHmqFauqsOkujuOD3fBTgsiRpEj1Y4sjv6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748088591; x=1748693391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rkaI5aW08vd3extL8l1xDJ235d2pvllt04k41fPocyY=;
 b=H6aYQLPbFvmuX3PhO3fbNTDRpT2yTPeUwCZEArzNNUhOB+PF90TExfL9BAZJHbcH/i
 ZN/v6MXSrMB/oZkcmbmSTOqdp8kVQX4Vu6Ou90PvaIGls6JjDTjj0wf0z6Fraeoh6Ih9
 n4MoatZ9rNi/YQ7ib/uN+BuI3H7qWjr0123WReioRLwC0AFAAQwK3vwhjzCzqMtT4ID4
 VCqx2MopTYP6mDycUQqQ9AyQTZYBWIKJYu+jUsowCao3itNJCbc+jjV65I19ghsXaGLR
 Efmd/O4e2Nnme1cWkUvWGGPlMU9iJJoyfFOIsLAGR8IBFbWEu+inVgGYrIRfdigynx+W
 krnA==
X-Gm-Message-State: AOJu0YxyLNC2Ikx+3IOHCHu140c93UDELCjS+gi39EIFhQSzUmTYtzIQ
 YTAE0r9srYwLdJoh8aoyTUdonOnltzIp3K0aq66/+sKg8afGboZ4VPu9Sq8N0fFNPwJLlAclqDm
 U8/0EG0KYMco=
X-Gm-Gg: ASbGncvSdrI06454FQVW19VYh1iL60fTIAKXzbo27shCoFB0RS0PxlyaD6lA7K5ajnE
 3eS2aL0+TCfT7TeID3D847a/70C2TTNQIRDh2hUh8OWeU58MlkgM41FVLEmRrXHL5hhMj9yHCxm
 dlT2pcUw8jiJnXWdzyp2w5P/6xEr9JH3DuBPR4H3kLZ+nxG6DJ6ld6KbsUTjDUyPBA7EM11hjWA
 ZAJXvpVIrdRMKY68esfLjMkgjHlXW3jy8/lwKvViNDwIoy9VmR8vTUyMdaXCmCqdVMvbdK2eyyw
 WKKQ4R0i41uX/IsqIAQlVNQIHH6jJPhI8dGX8hnSWr7iI/KcLJpdS3YCCpFQKYZlUe1Qs3k=
X-Google-Smtp-Source: AGHT+IFJo8/F3iirLS7Gll3bronMfIj9zzGK7ZtgUe4mGRt5AQqbhIvzcbmbJZ0niv62Xorc/+Ihwg==
X-Received: by 2002:a05:600c:3c94:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-44c932f93f8mr21583385e9.21.1748088591494; 
 Sat, 24 May 2025 05:09:51 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23c07bfsm177028585e9.23.2025.05.24.05.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 05:09:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
Date: Sat, 24 May 2025 13:09:00 +0100
Message-Id: <20250524120904.684977-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

A previously rejected patch to move the EFI public cerificate out of the
devicetree has recently been applied. This series reverts the change,
pending further discussion as to why it was accepted.


Simon Glass (3):
  Revert "efi_loader: Moved the generated ESL file to objtree"
  Revert "efi_loader: Move public cert for capsules to .rodata"
  Revert "doc: Update authenticated capsules documentation"

 .gitignore                         |  1 -
 doc/develop/uefi/uefi.rst          | 15 ++++++++++++
 include/asm-generic/sections.h     |  2 --
 lib/efi_loader/Makefile            | 18 ---------------
 lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++
 lib/efi_loader/efi_capsule.c       | 37 ++++++++++++++++++++++--------
 lib/efi_loader/efi_capsule_key.S   | 17 --------------
 scripts/Makefile.lib               | 27 ++++++++++++++++++++++
 8 files changed, 81 insertions(+), 47 deletions(-)
 create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
 delete mode 100644 lib/efi_loader/efi_capsule_key.S

-- 
2.34.1

base-commit: bab54f5942c428be698216224fd10b91d974d4da
branch: efis-us

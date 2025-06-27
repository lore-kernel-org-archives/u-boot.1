Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394F5C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 19:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928E280C83;
	Fri, 27 Jun 2025 21:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a5der4MW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0120281D5D; Fri, 27 Jun 2025 21:03:10 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC8D806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 21:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62D4B3F91F
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751050959;
 bh=cyCtZHI9veQGGXrdatUJsSJwZ+/mLZQ156MEhjKFPGA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=a5der4MWt6a2lpWY+So9YbMHcrED/sZ2wxXVmvNiqcCgzA6VrwziIg3vKhQY0SipI
 crdHihhS9MLE7GFmrc3XBqMZR63kpEkTpRM8yPNO7G7roCLlkKouk/0jRq4Ulcetcg
 2+NWT/8Rdda4rjRXIlOOmvTJWHWmJ5PqKAwwC291ZjHNBAuW6WB0pZfok4rO/a21Gz
 OPnAUVyu1wfate3eIi9zZpjhRGAylqwxj0TllzBxIxXdwu9xSIlJ2ka5vokU9W9ZBd
 C/VZ4PNSfNdXOA7NnWJsmK8/El5o5tZRw5caaoVAF7vqit2MyvkL5jdIohdnfIDeGW
 Q426Hncj+tcgA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso96066f8f.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751050959; x=1751655759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cyCtZHI9veQGGXrdatUJsSJwZ+/mLZQ156MEhjKFPGA=;
 b=gS26KNWrQkBiyLmAFhMmNCB4u0Whgts8r+IgWOAIChuCEpyZoUtn/EX/aRXte13n0L
 q90mzvdU1YqmfB7sW0y5MyiKKja9Z1LLxFdqlSkPQdg6JY5dAlJU0yqDxvRGEdSNfQtS
 gTxR8F2WrKvJJQ9P+o/B0fMmkcxCjZhPzgmajix8/xhzq47IbWbCpuqe8gg5S/2yHNt1
 mmR4dZzCH9hzJ7uZ9L/+kmEo9gLwfiXUf48t6iXa/El3Mc8uN5Q2d4X8OpZVT1SsmZWF
 0UKtiFYBTITkloW/ffmuCdeOsVvbbnawnSXQ/pL35hp9iEIQr7ITeTGd4ktJe05uC4Ma
 QL6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdDatKTXx3ASbG56ZCYDBxVqRP1y9qtMZ/a8QiTPsnrbSYgpP/H4bzrrWOC7wW/r7s1TDW7Wo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxsl5fwI3Wo8eoRuvttr4hKhR4v1vtGmUWuvGcbOocTWmYAXqEd
 6tllj4gAMGEc/68cY+VmuTb5xT6uPvjRTam+0FEA8D42PSBk9JEoT3qUidBtLuZTy6/rs7FdDcw
 KvzAqMucVxkSp0lRijv+Ppmtgaq64V5yO+eTwuZTZoBYNihMB5kA0uG+OVxaPYHf4bvx9s24fjI
 k6GPw=
X-Gm-Gg: ASbGncvtevzyLVoWbHsxsPLBdto+HWqBF7QF96REol6PDwCwGbOIbECN9m44BQGa+F3
 UAjhzTTJno7glt8iw9cTAwEP65ITk//N/K7vpidDLKXvbShA3UFPXZaJsXy83XIPBfXPoztWspX
 nHe/Zk8/QSyrZjslg8DRoYAjsZz8pezyAg8EKK34eH9rMrxJSQmeifgZUinxofi7nLL5okEcKZe
 D8C5k5qfJmRfmv/OQiyZJrAf2yGIOc92po7OeUE9EkJCvRzOpuUZ4mTzfPvS5VZAwbibFIuzHp6
 I6by07FUnKfL6w/wvBquWDg3iJK1xhIK5vTeFCS2FVCSzC8R48asMvQr
X-Received: by 2002:a05:6000:4186:b0:3a5:57b7:cd7b with SMTP id
 ffacd0b85a97d-3a8f482cf28mr3729678f8f.22.1751050958917; 
 Fri, 27 Jun 2025 12:02:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNuBkIZoeayJcEcHj4yOWvSNO/xt/+m5wM3MItw73gGAmYg4qiUwrPENT6Bz2eZSyDgmMTuA==
X-Received: by 2002:a05:6000:4186:b0:3a5:57b7:cd7b with SMTP id
 ffacd0b85a97d-3a8f482cf28mr3729642f8f.22.1751050958536; 
 Fri, 27 Jun 2025 12:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:8e27:7299:ea64:1f34:a93a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45391c6aa0asm20710695e9.26.2025.06.27.12.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 12:02:37 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: correct references in x86-fit-boot.rst
Date: Fri, 27 Jun 2025 21:02:31 +0200
Message-ID: <20250627190231.13252-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Correct the references for

* the x86 boot protocol description
* the FIT file format

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/fit/x86-fit-boot.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/usage/fit/x86-fit-boot.rst b/doc/usage/fit/x86-fit-boot.rst
index 9e3e32204d5..18704af3bac 100644
--- a/doc/usage/fit/x86-fit-boot.rst
+++ b/doc/usage/fit/x86-fit-boot.rst
@@ -259,11 +259,12 @@ Why Bother?
 References
 ----------
 
-In the Linux kernel, Documentation/x86/boot.txt defines the boot protocol for
+In the Linux kernel, `Documentation/arch/x86/boot.rst
+<https://docs.kernel.org/arch/x86/boot.html>`_ defines the boot protocol for
 the kernel including the setup.bin format. This is handled in U-Boot in
 arch/x86/lib/zimage.c and arch/x86/lib/bootm.c.
 
-Various files in the same directory as this file describe the FIT format.
-
+The FIT file format is described in the `Flattened Image Tree Specification
+<https://fitspec.osfw.foundation/>`_.
 
 .. sectionauthor:: Simon Glass <sjg@chromium.org> 7-Oct-2014
-- 
2.48.1


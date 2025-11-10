Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B05CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6B483A1A;
	Mon, 10 Nov 2025 13:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d7aQvcKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C6F83A84; Mon, 10 Nov 2025 13:50:31 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F3583A2D
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7aace33b75bso3081443b3a.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 04:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762779027; x=1763383827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rjZneO1ABHVCMD35CV6fJQCVw2KRWnXV7yEsVvaL4Fc=;
 b=d7aQvcKjhK3319sqolVN4qq+Jp3pYyuvbZ/x5SIKhmvWu/ECmrad6hbjEsBTEp/BCQ
 Nxz1Xl1QzpUHADndhRMrlr+D7w7Y1OU8kw2Bwvw9vcd91qelyFd12EEfiN8ptPvJKM9q
 pT5Iv/Becjf3o3BpVxTM5nhpK3fBt8alaMHI6Zyhz8sAMbgYPCpiuT6KBnLJp0e+aCef
 yYb8/aeYe93GOJoQ3bH8dkQf/dm9qkFJd3CZ5CODh2rjcN4bdc1fua+ZzivZKSChYJNP
 X03vPh0n2Uoy47HxdJ1g6p7EcR5O2zJmmJhG7V8SXW5tageBS0v8ZVknqG657ZiECrMZ
 B49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762779027; x=1763383827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rjZneO1ABHVCMD35CV6fJQCVw2KRWnXV7yEsVvaL4Fc=;
 b=he6MCNO+KHLqckQgSYAU7Jxy7zE0yM5MR8N/XbMw5sI/2ED3GHkBnd0uKAP1cKms2P
 fAiuYkXAvPvz9Ztj5DMIbTnkKZcezYB/oyb4C1Hi04nNCyxA1ZGsGfFXb0x8FHChU792
 RITg5K6nrCsOiY3ZglsZO6JrLykkPEcDuJ8jb1JTyMjIt9RrQSMkkdtOmjDOO3XoMMvD
 WZP9Syvs+qHm/sQlcedxRs8WpTPig9rGASNcbL2nfAlawMcY7gbZLzMkjASCSf6g2SK6
 Ayy646ObNAcH0huf4c4tXsu9L47KjNrTHZo14m7O/fuy5PT2PJlVAl82eYniVtD5ygXQ
 ykcA==
X-Gm-Message-State: AOJu0Ywv2UiW/+cozzSCqpfVIEcntlVyP5IiNKEtyvAF+rYeb7L2RjMe
 LdeI1OU7cIkw/WxMCGvBSW1EKXdE+Apdi5H2k+U3sHY5ck6jaAUyItnMYI6okUSe
X-Gm-Gg: ASbGncvnxuJdFMxjBURtKlOhoD49PfWK1H7taFx9XEfkVCmhgCaNmQKGwWU9eclBtfS
 Ypb+HbN00fiLDsa1iRkBHMcziwhNU1bAVGZTjYUiK3hoa9OqNiRqGyOnOSw4msKubwClhj3na4i
 ryPmQohpTWDpQf7A2928ew0Q7YdfIl2WfwqBOyH2kF8CXYOFIMvC7gf7FTYrq4+opCb0Rw8XFjy
 ZuB42Y6lxBhpOrVY9wycHJXPgDrssKilhCubnQZPehETzVSHXjMfc6dLgZAacFgpM9sdU/LMq3Q
 p/ihR74JOcOiUXaMQ9eqqGJES1QoSuxwRRP6b/JJELJNjtS4QBjKADfj/0SVjHu54rA9URfuP7C
 +jPulCUDQBg8GLGNkbICU5fPxFz35+b03gUl9SwKwSOIp+5hfbOH94ZTyiquS7tXAfrCzodg=
X-Google-Smtp-Source: AGHT+IE3+U5V69rjj803hCeTxSipcl5uY4YvA0oM4Q7zF7dsM+RSkaAuw7TmXSQ73vUde0pVu2RwVQ==
X-Received: by 2002:a05:6a20:3d25:b0:33e:eb7a:4476 with SMTP id
 adf61e73a8af0-353a1fddd16mr12993431637.23.1762779027003; 
 Mon, 10 Nov 2025 04:50:27 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0ccd4edc3sm11835506b3a.66.2025.11.10.04.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 04:50:26 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 2/2] bin: Rename QEMU arm* conf files
Date: Mon, 10 Nov 2025 20:50:21 +0800
Message-Id: <20251110125021.1642684-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110125021.1642684-1-bmeng.cn@gmail.com>
References: <20251110125021.1642684-1-bmeng.cn@gmail.com>
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

Use a hyphen between "qemu" and the architecture name for the
"board_type" field in the conf file name, and indicate "arm64"
for the ARM SBSA virtual platform.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 bin/ellesmere/conf.qemu-arm64                                    | 1 +
 bin/ellesmere/conf.qemu-arm64_spl_na                             | 1 +
 bin/ellesmere/conf.qemu-arm_na                                   | 1 +
 bin/ellesmere/conf.qemu-arm_spl_na                               | 1 +
 bin/ellesmere/conf.qemu_arm64                                    | 1 -
 bin/ellesmere/conf.qemu_arm64_spl_na                             | 1 -
 bin/ellesmere/conf.qemu_arm_na                                   | 1 -
 bin/ellesmere/conf.qemu_arm_spl_na                               | 1 -
 bin/travis-ci/{conf.qemu_arm64 => conf.qemu-arm64}               | 0
 bin/travis-ci/{conf.qemu-arm-sbsa_na => conf.qemu-arm64-sbsa_na} | 0
 bin/travis-ci/{conf.qemu_arm64_spl_na => conf.qemu-arm64_spl_na} | 0
 bin/travis-ci/{conf.qemu_arm64_tpl_na => conf.qemu-arm64_tpl_na} | 0
 bin/travis-ci/{conf.qemu_arm64be_na => conf.qemu-arm64be_na}     | 0
 bin/travis-ci/{conf.qemu_arm_na => conf.qemu-arm_na}             | 0
 bin/travis-ci/{conf.qemu_arm_spl_na => conf.qemu-arm_spl_na}     | 0
 15 files changed, 4 insertions(+), 4 deletions(-)
 create mode 120000 bin/ellesmere/conf.qemu-arm64
 create mode 120000 bin/ellesmere/conf.qemu-arm64_spl_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_spl_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_spl_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm_na
 delete mode 120000 bin/ellesmere/conf.qemu_arm_spl_na
 rename bin/travis-ci/{conf.qemu_arm64 => conf.qemu-arm64} (100%)
 rename bin/travis-ci/{conf.qemu-arm-sbsa_na => conf.qemu-arm64-sbsa_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64_spl_na => conf.qemu-arm64_spl_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64_tpl_na => conf.qemu-arm64_tpl_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm64be_na => conf.qemu-arm64be_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm_na => conf.qemu-arm_na} (100%)
 rename bin/travis-ci/{conf.qemu_arm_spl_na => conf.qemu-arm_spl_na} (100%)

diff --git a/bin/ellesmere/conf.qemu-arm64 b/bin/ellesmere/conf.qemu-arm64
new file mode 120000
index 0000000..312f519
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm64_spl_na b/bin/ellesmere/conf.qemu-arm64_spl_na
new file mode 120000
index 0000000..112a3d5
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_na b/bin/ellesmere/conf.qemu-arm_na
new file mode 120000
index 0000000..d103ff9
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_spl_na b/bin/ellesmere/conf.qemu-arm_spl_na
new file mode 120000
index 0000000..aee911e
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
deleted file mode 120000
index dee6855..0000000
--- a/bin/ellesmere/conf.qemu_arm64
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_spl_na b/bin/ellesmere/conf.qemu_arm64_spl_na
deleted file mode 120000
index abbbc02..0000000
--- a/bin/ellesmere/conf.qemu_arm64_spl_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_na b/bin/ellesmere/conf.qemu_arm_na
deleted file mode 120000
index aa91a9f..0000000
--- a/bin/ellesmere/conf.qemu_arm_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_spl_na b/bin/ellesmere/conf.qemu_arm_spl_na
deleted file mode 120000
index e171c5a..0000000
--- a/bin/ellesmere/conf.qemu_arm_spl_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm_spl_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu-arm64
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64
rename to bin/travis-ci/conf.qemu-arm64
diff --git a/bin/travis-ci/conf.qemu-arm-sbsa_na b/bin/travis-ci/conf.qemu-arm64-sbsa_na
similarity index 100%
rename from bin/travis-ci/conf.qemu-arm-sbsa_na
rename to bin/travis-ci/conf.qemu-arm64-sbsa_na
diff --git a/bin/travis-ci/conf.qemu_arm64_spl_na b/bin/travis-ci/conf.qemu-arm64_spl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_spl_na
rename to bin/travis-ci/conf.qemu-arm64_spl_na
diff --git a/bin/travis-ci/conf.qemu_arm64_tpl_na b/bin/travis-ci/conf.qemu-arm64_tpl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_tpl_na
rename to bin/travis-ci/conf.qemu-arm64_tpl_na
diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu-arm64be_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64be_na
rename to bin/travis-ci/conf.qemu-arm64be_na
diff --git a/bin/travis-ci/conf.qemu_arm_na b/bin/travis-ci/conf.qemu-arm_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm_na
rename to bin/travis-ci/conf.qemu-arm_na
diff --git a/bin/travis-ci/conf.qemu_arm_spl_na b/bin/travis-ci/conf.qemu-arm_spl_na
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm_spl_na
rename to bin/travis-ci/conf.qemu-arm_spl_na
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78316C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEC7805DA;
	Wed,  5 Feb 2025 01:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mlsj3u67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFA680C96; Wed,  5 Feb 2025 01:07:52 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7F3809A8
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-724a5d0427fso3610022a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714069; x=1739318869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JreIg6ds+IhVTgMM8K4A1/Y4sIAkbVh6Ubp/WBTf0w8=;
 b=Mlsj3u672thvDN/q9Jv0S65Ee0HMLTPx22ymuZQe4NCXmkhs6PHQTAkOavA2252sTW
 16UgEU3x0HHAY2I4yc1o4FdoM1iJOKTSANnBqmRCM2jvWwgmpZbcJ5PhdLLMLjTMFP33
 HjOLh5OYiE2qki4oNVpTh4rhSdfRMNDG38K1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714069; x=1739318869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JreIg6ds+IhVTgMM8K4A1/Y4sIAkbVh6Ubp/WBTf0w8=;
 b=mvwU6P7yVIZGrA9gHTTToIwi1Fj6I9kV7skyPIxK1mdKzhMuceVeJiloc4J1oMwk/d
 kOW9Ml14D+TmVkKFanWGhNEHR4S8RcEHdW9XVM8EyNlA9vKpIKldxDYHgrXIUDVO36Dq
 24dhADanlY8QU6XfQ9tpPNPdLK3pVTa5kcStRGJMHordmMnpnv/zZMFXar2cyfEBQSfY
 v4f9ewocHFDtrA5TCeQqmS2La+e+LVj7lTRKB0dAHoG3ituzhfkUyCSl6uf6Y5QogoFQ
 Y/3lUXrafs+yZdxNySlfGHwZ1mT3EkJfZMfM99U2XRZKo/BBYl15FNuiup0ZwKza/jlj
 zSYw==
X-Gm-Message-State: AOJu0YxYvOglXM5LEERrVck+YQJDlXucGppJkSdlzYejP6dQLsqYS9ev
 j3NE6DWO4fcSQ/ScAR764GTx72rbB5ua22lP/bpRvnydjncuGVN6zyohD+bqn2YJixR9TgJg6wy
 YfRk=
X-Gm-Gg: ASbGnctE1bpSQBWdnDRfzGEzILHe1/DZjc/UzsrPd/J+4qY8NncnHMdwRDQL4oGoL1g
 rL71O41rqGiJ9L6GY3sqWKvMzpQTYLHuVkn3lE8yS0ha0j6pkQha25hNEvpFdQHZhCC36XaudDZ
 jZgeZOg/ZglGsMRrwPwmumc6lTRuaWqZkEu7qaEeNf62DFqUJjQ438YTMiuSMhXH5IZW+t92IZc
 Cfwuc5vMDvkzB5XbuwYEMD08AICv9BTGQ+1ORGZjmwPUg2A9ag5qyMvbn9ZX+vh+02ozonk9GyM
 gCExDBzF2tTEfuAuRw==
X-Google-Smtp-Source: AGHT+IH1naJbcIbln/7Fgc75CN5X3tBHXTy7sW7euNLzqjdOMFUOxPjAUImpRcT5fcx5RrTh/llyOg==
X-Received: by 2002:a05:6830:6189:b0:71d:f4e8:f5ce with SMTP id
 46e09a7af769-726a4237049mr615154a34.18.1738714069585; 
 Tue, 04 Feb 2025 16:07:49 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/6] python: Create requirements.txt files for each "project"
Date: Tue,  4 Feb 2025 17:12:04 -0600
Message-ID: <20250205000743.949790-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000743.949790-1-trini@konsulko.com>
References: <20250205000743.949790-1-trini@konsulko.com>
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

Rather than have a requirements.txt file that's shared between multiple
python projects within U-Boot, create one for each using "pipreqs".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/binman/requirements.txt       | 5 +++++
 tools/patman/requirements.txt       | 5 +++++
 tools/u_boot_pylib/requirements.txt | 1 +
 3 files changed, 11 insertions(+)
 create mode 100644 tools/binman/requirements.txt
 create mode 100644 tools/patman/requirements.txt
 create mode 100644 tools/u_boot_pylib/requirements.txt

diff --git a/tools/binman/requirements.txt b/tools/binman/requirements.txt
new file mode 100644
index 000000000000..f068ef75a304
--- /dev/null
+++ b/tools/binman/requirements.txt
@@ -0,0 +1,5 @@
+importlib_resources==6.5.2
+jsonschema==4.23.0
+pycryptodomex==3.21.0
+pyelftools==0.31
+yamllint==1.35.1
diff --git a/tools/patman/requirements.txt b/tools/patman/requirements.txt
new file mode 100644
index 000000000000..e8cbc6cf0c37
--- /dev/null
+++ b/tools/patman/requirements.txt
@@ -0,0 +1,5 @@
+ConfigParser==7.1.0
+importlib_resources==6.5.2
+pygit2==1.13.3
+Requests==2.32.3
+setuptools==75.8.0
diff --git a/tools/u_boot_pylib/requirements.txt b/tools/u_boot_pylib/requirements.txt
new file mode 100644
index 000000000000..1087e6f2857b
--- /dev/null
+++ b/tools/u_boot_pylib/requirements.txt
@@ -0,0 +1 @@
+concurrencytest==0.1.2
-- 
2.43.0


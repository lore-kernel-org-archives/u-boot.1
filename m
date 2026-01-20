Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D3D262A8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 22:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3448B83B23;
	Tue, 20 Jan 2026 23:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d/ddHFou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A971483A8D; Tue, 20 Jan 2026 23:34:16 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E2883A3B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 23:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7cfd8ca8191so2094730a34.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768948452; x=1769553252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQnDQP/p2yJxZ7/zuIDf70pp+lTjrVpoOK8M9eFw990=;
 b=d/ddHFouR32HmPa9pVLRMRVAF7lgX5svtPTZSvQ8LgjMGfH9PX1HVG+3wKMDup7S3P
 xzukMbArru98/LQjP2FsZ8t8CHHs1uPkl3wZSub//2xFesyLZQXXKsBHR77GVTIb7nm6
 5bqtVhVNLp2yn0D9UizIjimedvNHDsDPCkE7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768948452; x=1769553252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hQnDQP/p2yJxZ7/zuIDf70pp+lTjrVpoOK8M9eFw990=;
 b=o1Id1VTX7u7KIbs6dFigelU9YYSiEtGHM+dN6p9D2l3HBt2YNQ9Xc0x89qkIWqg3Pt
 sardCA2Q78p4NHhRSzQHb152UrVH0ScsTku/r2aSLsDUuKlN3N+A3RG/Ti3cnNe0S7J1
 ye4S6yTKD3p//W3UftK+GOlmuiiaGtbDxvbxN/j4t+n1FTZ1qg23kX7pGGEoCL/HK+Kh
 yVqpzQujkfsO3ChOR21MWE8xqDGCPgBtZDLocOFFsMm67gA1QT5T5rEoAYf98jBF1ms3
 c1TU+eHUYUVpqo7RjLhMlBOW+3TDat4BQN2dH7bt/ljv2Xw6sdSyfx8LU6LuGyPRTyHp
 aTTA==
X-Gm-Message-State: AOJu0Yzqy7b3SNa03srWss7fMqJ6QTl1b52Rwyj+QNns/GuwdjgDaAPV
 Q3uiiAD/Gzx34F7ifcRyFL6IIdaPKbGdxDVbXsy+8r0kTbAZ0ISCgdlVP+tj7oNXni/vZTlKf2e
 OdXfeicLEyA==
X-Gm-Gg: AY/fxX5idIgGsKCMSwkPjFldoS9SwYi3APr1fYmYXZ0QRLyHlOBmSmbhtfAs+0mTYpV
 T2qrUJxCTCzW9VDc2TguRH2xwsxeoUXvHxkgRtqegN2ccsuGWfTAf65e5Jv53EBOOIG4yjzVHLt
 d/x18hr6OZjZyq04BiyzRwT3IQXa1wA413JOTEu62KUEklALXdMdm19v425BkgRj3hzBf+DOVai
 wMW2G1j8PTI+tZ+5GOJLxHtHuaLX4Cv4pSQwFLDOu33WNKV34FqgcdwRrEn6MxHpVQsg+Z5z71B
 9bSdojMJqhRBtIQWK1mUPoGxRf50FlwugfPdwciSmObBJTzNScqXoxwcT+RsaQ3qyhAs3PndUP3
 saxN8MDx8MsuKXfZb/tDgvYUhn7y1Y2j4Zw568nDiRSgiM+7Vyv7MMkm95jpBh5ESgnwjipBfcK
 XAFo9NaKtKw6Jboc287iaH2KybzkcP11nHMylx7jyOZuM8i+xEVHZYg8i3MyAizLoQFlNANRazK
 lIYe3cEKVIZKzzzqTycM2gODRhOUq5Xmm/uscFXrA==
X-Received: by 2002:a05:6830:64cb:b0:7cf:d7ec:1893 with SMTP id
 46e09a7af769-7cfe0229ea0mr6119436a34.25.1768948452263; 
 Tue, 20 Jan 2026 14:34:12 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b59e2sm9705687a34.30.2026.01.20.14.34.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 14:34:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/5] doc: develop: process: Document using b4 and patchwork
 for custodians
Date: Tue, 20 Jan 2026 16:31:46 -0600
Message-ID: <20260120223405.469050-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120223405.469050-1-trini@konsulko.com>
References: <20260120223405.469050-1-trini@konsulko.com>
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

- We already have good custodian documentation for patchwork, add a
  reference and then link to it here.
- Add a reference to the existing b4 documentation, and reference it
  here.
- Note and link to patchwork integration, am/shazam and ty features of
  b4 as these are the most likely useful portions. Be specific about
  keeping the default ${summary} as that includes important information.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/codingstyle.rst     |  2 ++
 doc/develop/process.rst         | 29 +++++++++++++++++++++++++++++
 doc/develop/sending_patches.rst |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 7304eea0056a..2a69162fa95f 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -24,6 +24,8 @@ The following rules apply:
   <https://peps.python.org/pep-0008/>`_. Use `pylint
   <https://github.com/pylint-dev/pylint>`_ for checking the code.
 
+.. _b4_contrib:
+
 * Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and
   send your patches. b4 has become the preferred tool to sending patches for many
   Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index f436a98433a7..fd81d9c5ebd4 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -232,6 +232,35 @@ feedback to the submitter of a patch about what is going on:
     work on an individual submitting a patch when something does not
     apply cleanly.
 
+Tooling
+^^^^^^^
+
+There are a number of tools available to help custodians and
+contributors alike with their contributions. As a project we make use of
+the Patchwork project hosted at `OzLabs <http://patchwork.ozlabs.org/>`__
+and more discussion on how it is used from both a contributor as well as
+custodian point of view can be found :ref:`here <patchwork>`.
+
+Another useful tool is `b4 <https://b4.docs.kernel.org/en/latest/>`__
+and is documented from a contributor point of view :ref:`here
+<b4_contrib>`. It also has a number of useful features from a custodian
+point of view:
+
+* `Integration with patchwork
+  <https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings>`__
+  which allows for automatic state tracking.
+
+* `"am" and "shazam"
+  <https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html>`__
+  for applying a patch or series of patches. Of note is that with
+  ``shazam`` review tags can be applied automatically and cover letters
+  can be integrated as part of merging a series.
+
+* `"ty" <https://b4.docs.kernel.org/en/latest/maintainer/ty.html>`__ for
+  automatically sending emails once patches have been applied. It is
+  strongly encouraged to keep the default ``${summary}`` in the template
+  as that shows what the git commit hash is for a particular patch.
+
 Work flow of a Custodian
 ^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 53c7655b2c34..e29fa175727e 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -322,6 +322,8 @@ Notes
    the memory footprint of the code. Remember: Small is beautiful! When adding
    new features follow the guidelines laid out in :doc:`system_configuration`.
 
+.. _patchwork:
+
 Patch Tracking
 --------------
 
-- 
2.43.0


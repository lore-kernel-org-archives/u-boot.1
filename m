Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5426DEEE25C
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 21:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568CA84154;
	Thu,  1 Jan 2026 22:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="alJ+h5co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E36B83BB1; Thu,  1 Jan 2026 18:55:05 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42D083AAD
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29f102b013fso144979175ad.2
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767290095; x=1767894895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKmRxrk5SztlMqQLLG8Aic1DYtoIF+cq6xTIyG/2RKs=;
 b=alJ+h5co0tUSiZfMzLapYyXlLYrRgQgLlbvdf4pFNlpZwUHmrGhBfN8hw8YKfpNOPi
 r2rux76dqpOK6Di3F4UUgG3x5e85MElETCRx7wwEjlndfRemqXpznqOVWuliOHF/fACi
 m0UiBM7cJbuJg7ZsNnwdtN66U8D4jQ/0yhjUVOT+w/oxiabC2+iFRH0HXToZ85dE8PFX
 BNlugYozNc+RMOAw0BTb5Kz5NswctuQgrEdZSiLZjd5otGoS56eKKDKDpTSmfA9/VMc7
 kW30e7HE0q3fYK5oalC8XwhmTw3vmtjihjM1Gbmb8EopGqbIjO+mPOqWvhz/A1l8ELtS
 BG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767290095; x=1767894895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RKmRxrk5SztlMqQLLG8Aic1DYtoIF+cq6xTIyG/2RKs=;
 b=reET0EATNf01I8r43tC5cs5wQfXLG2fKVY+Ac9oQMPL+4ZjHYMGfaPPQbRLaMBt0IV
 nNZwNOUIoji7MVoMUnnYzTKhrEj3jnhaCgwck6tLORl8rX3LwRvbWVv4InOKK2pPg6mb
 PZuzr4hhE5/cQkcKkhv2S/fE+wQj5QRPLqRKvTx+qpwSdc+bEorgF/LKy07umlJ+H7oa
 xTUXjHrUcepZpwY+CcOQ/5OT7L+gZw327m/Yb7X817AfVE5GWK+CpMYx3I6vFTf2bJYm
 RA4VMWZX3yqBWfa94t0w13r9+hEwvR1vNqOu57zUS6a0YS0Co++iLE02mQXGnfN7lcIW
 sJTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjfxIcI/KMZBcYRtJEvSbbgLp/Ob6oWoFP9KECmWRmPmB94EMkPwY+tVVsMCnvyNJVG0i1gqw=@lists.denx.de
X-Gm-Message-State: AOJu0YyCZT4YUQOh4Pk765B2xzVWIA0XjALPQrC0BerWb377+vWRHgbV
 UiYcO24L4MP52TgLIf+QD7cMvfOJ8srlJxW9Ri/+WRg+c/uqtmuALnjR
X-Gm-Gg: AY/fxX7N0rkrUZrEw7EUkvzyLNfMeaMlg9OrKxwUme9y8jgdP5LMHWjANERNIbU6gY2
 I+JWVtcYF4fUb0Xb7UCFf+SSRtJd2MVTeMVRBklqFhLVt+rbH4WTvHhU1NvmaUSBFlx1ORs6VIh
 U9wYZFw5D6csz6GHw1PCD7Vg2KswcvGitul0FtomOmc1/3G0dz7J6Ahy+/MgUy/XOexQLopE7z7
 IIdnc2HM9csgpI/CxgvWLC4N6hlrxBvdDnVfRwL65MAuXsChNhklmEDjhBmP2/dDL4vRn+vtrot
 oKFK+NhsaBO/PT8eRUm8RjoP6b2aIONQioszPX1lIXXAhB650XAjziAzzUAOqWidGjUGPzKiFSE
 BX/OPImb5PDYxHGppWXYTYq7UtYPpNs42oAz8wpWv3XKLtKa6hU7L3oTDI67Ohv1O7sOFee8Sew
 jJ1SR7Rs8dk+EvqZEnXzSpmkiEhDrcT0t5pAYwJ3rn/VkwGfQS1UoQbqJ8sd4aq5mFDOOOOsa+9
 d3JmAKITODV2DWfjo7qSg==
X-Google-Smtp-Source: AGHT+IEi3eteW28o2OjypdlFCDfo9SWrAbs3VKD+K+bddgYTwtXLjToedhhgOkS1WCdr98B8+BpD1g==
X-Received: by 2002:a17:903:1b65:b0:297:e69d:86ac with SMTP id
 d9443c01a7336-2a2f2836516mr400878185ad.39.1767290095355; 
 Thu, 01 Jan 2026 09:54:55 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3a8770e66sm40000615ad.42.2026.01.01.09.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:54:55 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 6/6] CI: Add test jobs for QEMU m68k virt machine
Date: Thu,  1 Jan 2026 17:54:20 +0000
Message-ID: <20260101175420.4118024-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260101175420.4118024-1-visitorckw@gmail.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Jan 2026 22:15:35 +0100
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

Enable CI testing for the newly introduced QEMU m68k 'virt' board on
both GitLab CI and Azure Pipelines. This ensures the new M68040
architecture support is built and booted correctly in the emulated
environment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
No changes in v4.

 .azure-pipelines.yml | 3 +++
 .gitlab-ci.yml       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e4695f1c55b..f563878b021 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -518,6 +518,9 @@ stages:
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep and not efi"
           OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
+        qemu_m68k_virt:
+          TEST_PY_BD: "qemu-m68k"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_malta:
           TEST_PY_BD: "malta"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e7234e003ea..1fc4d1e656d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -408,6 +408,12 @@ qemu_m68k test.py:
     OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
   <<: *buildman_and_testpy_dfn
 
+qemu_m68k_virt test.py:
+  variables:
+    TEST_PY_BD: "qemu-m68k"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_malta test.py:
   variables:
     TEST_PY_BD: "malta"
-- 
2.52.0.358.g0dd7633a29-goog


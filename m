Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE7CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FAEC8323A;
	Wed, 15 Oct 2025 17:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="geb52SNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86450800D7; Wed, 15 Oct 2025 17:45:28 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A51483700
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-57a960fe78fso7646406e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543124; x=1761147924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ez1HTj/KvP/Dtxg8s6NZH5giwdov+ZQwyldic+gKUxc=;
 b=geb52SNzFSEH4TrtoN0eK+AtUiQPTij9HsK5Oex/GT3Os5K8AQbX5yCDSxwjtbj6AM
 3nQKhg2ma8YsRp8htjfGLYvMH+Tl3Ga0BljF++Xbn51RUlrOV+ErmHrs+s78kJ7O9GTa
 9O+BqHwgYjQeLOcLJRUDIxq2LT8V3nlhrULgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543124; x=1761147924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ez1HTj/KvP/Dtxg8s6NZH5giwdov+ZQwyldic+gKUxc=;
 b=wM0aXx0Lho0SKE+Ji8vIMa/IyANT+QXvJQ6z2lWmoaTncZd9SHcFnkROCw/C8pRTLO
 Qlv2Li8X+kcoxlywpKFpGZ2REThrlePEt8c8gExCbkHhWIepnBi1Y+/3cQtxa7HcDFrP
 XB9lX8zELmXmuw9wEPaBxy7eNPF6gZDy3WQmMkGJpvmq5oyi/1melvfyH3OEFWB1sxH8
 osOdZPXQX5NsLVc0q0iJHvJE/qzzQW9LugJA1sp2QVcKbAc3D7u+X1ghiP4MvphjSsYw
 ykr62WdvyXOWzG4NHg7GdLhn98djLUHdatLi30umbBHjvE7zulSUv14ZZWKW3+ZwBAaA
 nN4A==
X-Gm-Message-State: AOJu0YwHA5YWGv+sxifnQ8qa41N14ayDeG2JUfmbsllBIia6sVeW7x8X
 ZIf802Wc1Qnute5s/vv0XiUpZMsKX4lWBgTw4QqVwwrMt8Mh88s9IBk4zArPrscdyroxSVEeaEX
 yWqjYKVIrXko=
X-Gm-Gg: ASbGnctKnT90gpzgCJhC+DJ0+qGLtgVwS9Qr7lZur/Wx71Lzhigh1NR/cF/NfL35S5G
 WzuFJkoIwipmeTDDp/hR7Sgna6UE9T7UxUCduLxDlD6p0pRLT+64CrAJPRXjB46Hy+ThtgzaMCL
 Muxm1wrth807DKNbXB3qZr9xbi+l/fhq5ytPTHMGqpcASjw3w07oAVuAIn1oECTzlgxWkhUClQ2
 7bMciMmys1tBv5ejIof0HKx9zJC8SCoa8Iw3RwVocBFcS65+VYUma/Rqxyh76A+ScFVtADzD/bX
 rhKCNZ5SucaNOgee+akG0uBjCLB7X5yJqvgCemigF6jKIMYUvWCpyMSBZwbCfXzw3z5jPW9of9G
 CK7Oil3TJ1rSaTqUVzPtwg1F4hJfloPpFj2rAzJY6O3nE6CRO
X-Google-Smtp-Source: AGHT+IEKxRSqzRi2lU40ZihdiY2w62pbdj+9LO51TYMcFje1ISB5GM3qsQG36qxFGytJLDqNdI39PQ==
X-Received: by 2002:a05:6512:3ba0:b0:579:f0fc:46f7 with SMTP id
 2adb3069b0e04-5906de89a6bmr8603600e87.56.1760543124122; 
 Wed, 15 Oct 2025 08:45:24 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:45:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v4 11/11] boot: Run the EFI bootmgr just before network devices
Date: Wed, 15 Oct 2025 16:44:14 +0100
Message-ID: <20251015154423.908468-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
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

At present the EFI bootmgr scans all devices in the system before
deciding which one to boot. Ideally it would use the bootstd iterator
for this, but in the meantime, give it a lower priority, so it runs
just before the network devices.

Note that if there are no hunted network devices hunted, then it will
run at the end, after all bootdevs are exhausted. In other words, it
will always run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update commit message to indicate the bootmeth will always run
- Document how the priority was chosen

 boot/bootmeth_efi_mgr.c | 9 +++++++++
 test/boot/bootflow.c    | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 42b8863815e..05fc35d01a9 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -99,6 +99,15 @@ static int bootmeth_efi_mgr_bind(struct udevice *dev)
 	plat->desc = "EFI bootmgr flow";
 	plat->flags = BOOTMETHF_GLOBAL;
 
+	/*
+	 * bootmgr scans all available devices which can take a while,
+	 * especially for network devices. So choose the priority so that it
+	 * comes just before the 'very slow' devices. This allows systems which
+	 * don't rely on bootmgr to boot quickly, while allowing bootmgr to run
+	 * on systems which need it.
+	 */
+	plat->glob_prio = BOOTDEVP_6_NET_BASE;
+
 	return 0;
 }
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 20297136e3f..cc5eed75d83 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -454,11 +454,11 @@ static int bootflow_system(struct unit_test_state *uts)
 	ut_assertok(device_probe(dev));
 	sandbox_set_fake_efi_mgr_dev(dev, true);
 
-	/* We should get a single 'bootmgr' method at the start */
+	/* We should get a single 'bootmgr' method at the end */
 	bootstd_clear_glob();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
-		"  0  efi_mgr      ready   (none)       0  <NULL>                    ");
+		"  1  efi_mgr      ready   (none)       0  <NULL>                    ");
 	ut_assert_skip_to_line("No more bootdevs");
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 	ut_assert_console_end();
-- 
2.43.0


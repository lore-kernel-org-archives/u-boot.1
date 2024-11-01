Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE0FE6B244
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 11:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A558892E5;
	Fri,  1 Nov 2024 12:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wisybpq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B88A892E1; Fri,  1 Nov 2024 12:50:41 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E237A892A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso296330666b.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730461838; x=1731066638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aR4uu+yBdWM/WK4DWlVdXDM7WElFkpQM2rMuqNYQ8s=;
 b=Wisybpq4KuC2xre6tpDatXp2Eh13sioLSbZuyxDP5c57Ni1Oic46qsHrejzrbnMsab
 qNZ8hRlLKMOIaqMqByPIvRXgZ6DK50MBSY4SyJVZePn2xz4EIkHD9MPSWSM799RYSKVP
 1JIVjnyp77lE91pxcja/0aEAsjsLSM8LaTpfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730461838; x=1731066638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aR4uu+yBdWM/WK4DWlVdXDM7WElFkpQM2rMuqNYQ8s=;
 b=UwhEdfyVb6GusQ4+NNNt2FzjL3AMYUVCjjJm5mILEKTYC/AUCdbGL1163/m9xXeD5e
 Zyxk7eqkc1aH3XhQY+WhAi2slI6Vw2gDhH++mzS0A5giJc+lpCDjO3XEG1PeM7T1dzuA
 d0LaeSh2P10VvurMESptt5x3s5KBAZKwMsHNH42W2OW7nLrO69GZzNB4SJbbCCfhuwKn
 NgP/y5ikBAgipHNm9lLWWRYVvfY+5YFFAFOgubjPlsM09YpQ9X11PmEta4n9QEXFnCGK
 1+nqMBAiz/Vtr8HWXAONwKeaPsVG6PoMFv48qAWLobbgLNIEzYEgJC1MY7A+7rbBdyk5
 vSiQ==
X-Gm-Message-State: AOJu0YzBTZBG7LVp6Tn0rLR0Pxz0j8CYOiLYi0jf5SPEkxIO8bFzRGb/
 ccF0sAcl9Ksg7ni1OaNnWx7oIpSf1Lekf0YwI20mZx3jB6nyZEMKnu2iB2tClXjx5q0gCRZgvgg
 NHA==
X-Google-Smtp-Source: AGHT+IGtbGogAR84Jm9BVsfOFG6a33K8fnkqo517IhNtNnGxBIwrtIhh88u6dcGBM54QwKsgZMcslw==
X-Received: by 2002:a17:907:d29:b0:a99:4b56:cf76 with SMTP id
 a640c23a62f3a-a9de61d6bb6mr2260956566b.47.1730461837842; 
 Fri, 01 Nov 2024 04:50:37 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564cc430sm171616566b.88.2024.11.01.04.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 04:50:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] common: Move autoprobe out to board init
Date: Fri,  1 Nov 2024 12:50:26 +0100
Message-ID: <20241101115028.214678-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101115028.214678-1-sjg@chromium.org>
References: <20241101115028.214678-1-sjg@chromium.org>
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

Rather than doing autoprobe within the driver model code, move it out to
the board-init code. This makes it clear that it is a separate step from
binding devices.

For now this is always done twice, before and after relocation, but we
should discuss whether it might be possible to drop the post-relocation
probe.

For boards with SPL, the autoprobe is still done there as well.

Note that with this change, autoprobe happens after the
EVT_DM_POST_INIT_R/F events are sent, rather than before.

Update the docs a little, for this feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add autoprobe to SPL also
- Leave the function name the same
- Fix 'Prove' typo
- Update cover letter since SPL is now covered also
- Update the documentation too, with a discussion link

 common/board_f.c                    |  4 ++++
 common/board_r.c                    |  4 ++++
 common/spl/spl.c                    |  4 ++++
 doc/develop/driver-model/design.rst | 15 +++++++++++++++
 drivers/core/root.c                 | 13 ++++++++++++-
 include/dm/root.h                   | 10 ++++++++++
 6 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 1e1aa08530a..974eb4f39e9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -822,6 +822,10 @@ static int initf_dm(void)
 	if (ret)
 		return ret;
 
+	ret = dm_autoprobe();
+	if (ret)
+		return ret;
+
 	if (IS_ENABLED(CONFIG_TIMER_EARLY)) {
 		ret = dm_timer_init();
 		if (ret)
diff --git a/common/board_r.c b/common/board_r.c
index 62228a723e1..d1507b06f8d 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -241,6 +241,10 @@ static int initr_dm(void)
 	if (ret)
 		return ret;
 
+	ret = dm_autoprobe();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 #endif
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 1ceb63daf31..c4256f237ee 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -500,6 +500,10 @@ static int spl_common_init(bool setup_malloc)
 			debug("dm_init_and_scan() returned error %d\n", ret);
 			return ret;
 		}
+
+		ret = dm_autoprobe();
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 8c2c81d7ac9..1dcac1408ff 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -842,6 +842,21 @@ steps (see device_probe()):
       cause the uclass to do some housekeeping to record the device as
       activated and 'known' by the uclass.
 
+For some platforms, certain devices must be probed to get the platform into
+a working state. To help with this, drivers marked with
+``DM_FLAG_PROBE_AFTER_BIND`` will be probed immediately after all devices are
+bound. For now, this happens in each xPL build as well as in U-Boot proper,
+both before relocation and after relocation.  See the call to ``dm_autoprobe()``
+for where this is done.
+
+Note that autoprobe happens after the ``EVT_DM_POST_INIT_R`` and
+``EVT_DM_POST_INIT_F`` events are sent, since these events relate to
+device-binding.
+
+See here for discussion of this feature:
+
+:Link: https://patchwork.ozlabs.org/project/uboot/patch/20240626235717.272219-1-marex@denx.de/
+
 Running stage
 ^^^^^^^^^^^^^
 
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 2d4f078f97f..371a37fe752 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -299,6 +299,17 @@ static int dm_probe_devices(struct udevice *dev)
 	return 0;
 }
 
+int dm_autoprobe(void)
+{
+	int ret;
+
+	ret = dm_probe_devices(gd->dm_root);
+	if (ret)
+		return log_msg_ret("pro", ret);
+
+	return 0;
+}
+
 /**
  * dm_scan() - Scan tables to bind devices
  *
@@ -331,7 +342,7 @@ static int dm_scan(bool pre_reloc_only)
 	if (ret)
 		return ret;
 
-	return dm_probe_devices(gd->dm_root);
+	return 0;
 }
 
 int dm_init_and_scan(bool pre_reloc_only)
diff --git a/include/dm/root.h b/include/dm/root.h
index b2f30a842f5..cd240c6a716 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -136,6 +136,16 @@ int dm_scan_other(bool pre_reloc_only);
  */
 int dm_init_and_scan(bool pre_reloc_only);
 
+/**
+ * dm_autoprobe() - Probe devices which are marked for probe-after-bind
+ *
+ * This probes all devices with a DM_FLAG_PROBE_AFTER_BIND flag. It checks the
+ * entire tree, so parent nodes need not have the flag set.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int dm_autoprobe(void);
+
 /**
  * dm_init() - Initialise Driver Model structures
  *
-- 
2.43.0


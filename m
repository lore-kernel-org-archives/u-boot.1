Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55576CF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DA788DD1;
	Sat, 28 Sep 2024 22:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g91bHNyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2677788DCC; Sat, 28 Sep 2024 22:01:18 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0328288DB7
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso254675839f.3
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553669; x=1728158469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WLUXU3kH5V2r0sehxxjW5M2UpQ+BqdanyMT0wqFp7A=;
 b=g91bHNyNuWsUV+2BoehU2HCvIN6XCkEpSP20/OMuKfRoZWKxphKDmynQ0ykW/twhBC
 +Qlf8X96KIK4JkzaERnBcq0HPh7yv7c/uzXaYgnCMqGbBRPoQb7Ib/sQKRVhpEQxbC9Z
 Yb1Zk9hDd1+49//zK416l7nZ51i8x9PBh1CpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553669; x=1728158469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WLUXU3kH5V2r0sehxxjW5M2UpQ+BqdanyMT0wqFp7A=;
 b=J2FJT1cav0/1mykJRxzUaUuaJxiAR5dofWQNnyiUhqwKhCNllyuD3WBXYvEB1dQMiy
 CalXR0W4Cvk+YeowrY9IO5Frf705YdMOcD2SdI9JvLcj+92a6gtBgegzVmiaHrUzC8M+
 hudqj8Gd7f/TAYT6XV9FFs1zZbwIOpkh8vOu4u9lBNeemNGyKDeIG7cYvSYIJQ1eeaVo
 QEwDjDry2Vzha3fgsWL3jojz0f3uNz9ISJpptIP0aCtgjgGkspjrtBINBKoLia0ALdSe
 JyWynlxwtQ9GNg43vWWfncyxU5F7/Ds3Cl03hF8y55c++0oDUsMiBu46ESf1lvmVroIB
 SySA==
X-Gm-Message-State: AOJu0YyvGlSjGRX55numipyXSXkvqfhfLAE5syHAfwyOLBRx5Dg/7Hb7
 /81kRl0lhaV4BmWIqKAf6lkByt1FH5vXwXWeqS3NWAHAKeNfPNbwNZmWjwVpdz7nj5qwJwAt0Nm
 zvw==
X-Google-Smtp-Source: AGHT+IF6o556BR7xM2Vwl1ttQroVaIgFmrmU8htXij9s3cXynSQJi3MIkn1pYZjKLpJEjyiXCuZATA==
X-Received: by 2002:a05:6602:3f87:b0:832:13ce:1fa3 with SMTP id
 ca18e2360f4ac-834931d674cmr603921539f.8.1727553669525; 
 Sat, 28 Sep 2024 13:01:09 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH v2 22/30] xpl: Rename spl_phase to xpl_phase_t
Date: Sat, 28 Sep 2024 14:00:22 -0600
Message-Id: <20240928200030.194546-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

This name fits better with the new naming scheme, so update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/spl.c               |  2 +-
 common/spl/spl.c                     |  2 +-
 doc/device-tree-bindings/bootph.yaml |  2 +-
 include/spl.h                        | 12 ++++++------
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 1c33a520c64..6c6f4fd8c3e 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -91,7 +91,7 @@ static int load_from_image(struct spl_image_info *spl_image,
 			   struct spl_boot_device *bootdev)
 {
 	struct sandbox_state *state = state_get_current();
-	enum u_boot_phase next_phase;
+	enum xpl_phase_t next_phase;
 	const char *fname;
 	ulong pos, size;
 	int full_size;
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 674ab35ede0..81b3501ebaf 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -441,7 +441,7 @@ static inline int write_spl_handoff(void) { return 0; }
  */
 static enum bootstage_id get_bootstage_id(bool start)
 {
-	enum u_boot_phase phase = spl_phase();
+	enum xpl_phase_t phase = spl_phase();
 
 	if (IS_ENABLED(CONFIG_TPL_BUILD) && phase == PHASE_TPL)
 		return start ? BOOTSTAGE_ID_START_TPL : BOOTSTAGE_ID_END_TPL;
diff --git a/doc/device-tree-bindings/bootph.yaml b/doc/device-tree-bindings/bootph.yaml
index a3ccf06efa7..a364b3fe37f 100644
--- a/doc/device-tree-bindings/bootph.yaml
+++ b/doc/device-tree-bindings/bootph.yaml
@@ -83,6 +83,6 @@ properties:
   bootph-all:
     type: boolean
     description:
-      Include this node in all phases (for U-Boot see enum u_boot_phase).
+      Include this node in all phases (for U-Boot see enum xpl_phase_t).
 
 additionalProperties: true
diff --git a/include/spl.h b/include/spl.h
index 01057ee103e..3447a429e87 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -62,7 +62,7 @@ static inline bool xpl_is_first_phase(void)
 	return false;
 }
 
-enum u_boot_phase {
+enum xpl_phase_t {
 	PHASE_NONE,	/* Invalid phase, signifying before U-Boot */
 	PHASE_TPL,	/* Running in TPL */
 	PHASE_VPL,	/* Running in VPL */
@@ -116,7 +116,7 @@ enum u_boot_phase {
  *
  * Return: U-Boot phase
  */
-static inline enum u_boot_phase spl_phase(void)
+static inline enum xpl_phase_t spl_phase(void)
 {
 #ifdef CONFIG_TPL_BUILD
 	return PHASE_TPL;
@@ -150,7 +150,7 @@ static inline bool spl_in_proper(void)
  * Return: the previous phase from this one, e.g. if called in SPL this returns
  *	PHASE_TPL, if TPL is enabled
  */
-static inline enum u_boot_phase spl_prev_phase(void)
+static inline enum xpl_phase_t spl_prev_phase(void)
 {
 #ifdef CONFIG_TPL_BUILD
 	return PHASE_NONE;
@@ -172,7 +172,7 @@ static inline enum u_boot_phase spl_prev_phase(void)
  * Return: the next phase from this one, e.g. if called in TPL this returns
  *	PHASE_SPL
  */
-static inline enum u_boot_phase spl_next_phase(void)
+static inline enum xpl_phase_t spl_next_phase(void)
 {
 #ifdef CONFIG_TPL_BUILD
 	return IS_ENABLED(CONFIG_VPL) ? PHASE_VPL : PHASE_SPL;
@@ -188,7 +188,7 @@ static inline enum u_boot_phase spl_next_phase(void)
  *
  * Return: phase name
  */
-static inline const char *spl_phase_name(enum u_boot_phase phase)
+static inline const char *spl_phase_name(enum xpl_phase_t phase)
 {
 	switch (phase) {
 	case PHASE_TPL:
@@ -211,7 +211,7 @@ static inline const char *spl_phase_name(enum u_boot_phase phase)
  * @phase: Phase to look up
  * Return: phase prefix ("spl", "tpl", etc.)
  */
-static inline const char *spl_phase_prefix(enum u_boot_phase phase)
+static inline const char *spl_phase_prefix(enum xpl_phase_t phase)
 {
 	switch (phase) {
 	case PHASE_TPL:
-- 
2.34.1


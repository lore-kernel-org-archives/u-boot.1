Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D23CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CDF83693;
	Wed, 15 Oct 2025 17:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jnMzfO0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885AA83693; Wed, 15 Oct 2025 17:45:14 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8C5836A3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-58afb2f42e3so8238830e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543110; x=1761147910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7h5QJJcIXVk+kHLKjMPCuigMAJ8Xtcu1FdwDT/xhRsU=;
 b=jnMzfO0CEH5gTfAehY4kO88h3oseoniVnRRON8ahac9xA5rvH3ofmEwDj0fKHbJA3M
 cj+fYmx6MK9gI7S87YSTrVO2TVaQdzQ2gRBYIDPhKdJZjS03CYDyfXljG/j/HXFavFmz
 Bp6mJziv8n7tGf8GYlSoEcSn5ghzGx5e9VoUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543110; x=1761147910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7h5QJJcIXVk+kHLKjMPCuigMAJ8Xtcu1FdwDT/xhRsU=;
 b=wq4xNJc/L4yp23315/BgpcvUUYYe7mE4mWF+1uEmjM+NOtYXXdAzGzQ7ozkvL0i9Vo
 KAWIex6s7Rmrhdt/2f429pAlDrSvc+EU0f5hkds7LFEQmrzktNA3ufKzYIjePmTQ5YQN
 hNZdvwJ0AqdObCaGyoPJegsLvPFAP9ASR0YKUgreTrnFLd4hgRg50tFcfKfEmBTobP41
 lfxcfWK7hfPgcA0V46tCPJ/kAcCMLGJYRiWukZsvDcgP59oCUXZg9S/tDk2U+BHN0KPa
 PB3aSH4NrxwgMoxSqZkpZW+RE8CPFxeB7G9GQxr9BbLmfb56Iqx5fdc2J8uLwgnR19No
 kdAg==
X-Gm-Message-State: AOJu0Yynl3UtTb5OcihvPHOFAiF/opHbLvFEFraHGzaqbcSexF2D732x
 Ze3Bt4AOtUPEfoHsXtTsO7VKfz16tnwW6OMFGHlcK/VvfwI/8FBigUaI7L8Uvm2dA4fWwCzt6fc
 gGnhFJ5V9IOQ=
X-Gm-Gg: ASbGncvtvROyFvxx+jzU0bYovnCcn1h/WjB9V7nfWJ4J+wVb/aPrF9yLhd4kyKdgZ6p
 Ae+J+DMU22hZU5YfRyaO7InVCmtiqDZX+PsQyEX+JNOv9DQHclqNIT+o4XVoeiPwcWE/CvGs/CF
 cbjPjLxABgcOYQLmiA42bo8VRQV8n28wl5N5hI+3mJjUwdboBgt9WQt0Ch8hPXu5H/zxPfspIe4
 LCehPQMCk2Krp9ZZLJj6e1BGzrt7M0l8eaIVcL1fkbR11rnyLms++gi0Q1dZfoxEYVfK1g+kXnd
 fPUy4kWOYtDY26kks0olnYs8jxtgprM3d8IVnVh62YXDOl8hly7ITWC54O1qAOCH4hUDVf4ATea
 o0DrSH+GZnib3jBwGlroV4HPMul0HqcHHPPkd1g==
X-Google-Smtp-Source: AGHT+IGdEYitzzX7FXHJmp4+C8LoNQsXoGswXZ8iKfqMGo63mnGIGfh8uxlJVbpL6ib3xuxsTVzZ2g==
X-Received: by 2002:a05:6512:3a8e:b0:584:8e13:668c with SMTP id
 2adb3069b0e04-5906dd741b0mr9395668e87.42.1760543109904; 
 Wed, 15 Oct 2025 08:45:09 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:45:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 08/11] boot: Implement a priority for global bootmeths
Date: Wed, 15 Oct 2025 16:44:11 +0100
Message-ID: <20251015154423.908468-9-sjg@chromium.org>
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

Allow bootmeths to select when they want to run, using the bootdev
priority. Provide a new bootmeth_glob_allowed() function which checks if
a bootmeth is ready to use.

Fix a comment in bootflow_system() which is a test for global bootmeths.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c    | 15 +++++++++++----
 include/bootflow.h |  2 +-
 include/bootmeth.h |  4 ++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index ca1fe741bab..1a4cd0e28e8 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -191,17 +191,24 @@ static void scan_next_in_uclass(struct udevice **devp)
  * bootmeth_glob_allowed() - Check if a global bootmeth is usable at this point
  *
  * @iter: Bootflow iterator being used
- * Return: true if the global bootmeth has not already been used
+ * Return: true if the global bootmeth has a suitable priority and has not
+ * already been used
  */
 static bool bootmeth_glob_allowed(struct bootflow_iter *iter, int meth_seq)
 {
 	struct udevice *meth = iter->method_order[meth_seq];
 	bool done = iter->methods_done & BIT(meth_seq);
+	struct bootmeth_uc_plat *ucp;
 
-	log_debug("considering glob '%s': done %d\n", meth->name, done);
+	ucp = dev_get_uclass_plat(meth);
+	log_debug("considering glob '%s': done %d glob_prio %d\n", meth->name,
+		  done, ucp->glob_prio);
 
-	/* if this one has already been used, try the next */
-	if (done)
+	/*
+	 * if this one has already been used, or its priority is too low, try
+	 * the next
+	 */
+	if (done || ucp->glob_prio > iter->cur_prio)
 		return false;
 
 	return true;
diff --git a/include/bootflow.h b/include/bootflow.h
index 059d38251b7..1cfdda403ac 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -262,7 +262,7 @@ enum {
  *	appear first, then the global ones, if any
  * @have_global: true if we have global bootmeths in @method_order[]
  * @doing_global: true if we are iterating through the global bootmeths (which
- *	happens before the normal ones)
+ *	generally happens before the normal ones)
  * @method_flags: flags controlling which methods should be used for this @dev
  * (enum bootflow_meth_flags_t)
  * @methods_done: indicates which methods have been processed, one bit for
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 26de593a9a4..2a492dfd73a 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -30,10 +30,14 @@ enum bootmeth_flags {
  *
  * @desc: A long description of the bootmeth
  * @flags: Flags for this bootmeth (enum bootmeth_flags)
+ * @glob_prio: Priority for this bootmeth. If unset (0) the bootmeth is started
+ * before all other bootmeths. Otherwise it is started before the iteration
+ * reaches the given priority.
  */
 struct bootmeth_uc_plat {
 	const char *desc;
 	int flags;
+	enum bootdev_prio_t glob_prio;
 };
 
 /** struct bootmeth_ops - Operations for boot methods */
-- 
2.43.0


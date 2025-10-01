Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D090ECAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D32C83710;
	Wed,  1 Oct 2025 23:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AX8x9BJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E2783775; Wed,  1 Oct 2025 23:29:59 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033F783710
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-42d8a0f09f6so2115905ab.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354195; x=1759958995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nft2V5abBRJAPF165xTwDWEWM9c+/tFibTaXTKXEQIg=;
 b=AX8x9BJm+TMDVwfRgRecmmTBYXWdKZNGBks3y1FJ7QWx4/961/Zmw0OncaQZkDlrfm
 ZjdxfUOBdDMK8inHnhgkWe6HDNBEfgnkMayJmkIu+9yUFHArYG5LHXI9t00JgWRzUkDK
 K6a3+kfAQ2Aw4VK7Xt1VedxLJuv6XlwX9kdMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354195; x=1759958995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nft2V5abBRJAPF165xTwDWEWM9c+/tFibTaXTKXEQIg=;
 b=bcXo0eieVDclYgZNanSE2+NsOUJWjleKou2WfpHhc50kQgXM2DJW84TTZyW0L/ZqJX
 MfG04w/l66E3qcLTiRwT2Pba+xYhyXikAq1NxnJM+OcbU6qJ9fThJocNsTXQqb0HDDuZ
 iUfjK2C/xHq2xHRTs1jaDcVZplkwQbyZ6HccW6cvHBpsHfa3LBsRElimcjrYJ3qauhJO
 R2qBtXLPt28SqDb3R9w+5zhohxoFr8Kfd4frslu14+5RQMw6ZHKnzgFGo0S6+xSxKMP6
 1pLTudQBtT3e1Kw/j5hG8yiwQpT48LKiW2I+akoSzUh9oLIXjSYJnVf8qbOUzdAXoZXB
 1R4A==
X-Gm-Message-State: AOJu0YwQi0v9sw13mGrqL3iIZ7678xgG3H7m3gD4GJKf7IOYhIVMIM1O
 fKHiEQ5FSMNpOST48sQQfiWA0UVoY/Cw1OGJsipde2rOs4EnsoqR1GVdysoAyLsXitryA+TAHZu
 Hk4Exn8rD
X-Gm-Gg: ASbGnctxuKS4g/+Y04m0Td433rkJG69rM2zlkvzdyLAKKB6d2NIqv7fw93joIJgWW6m
 4leZDupamggNgMcbsGt2Iwys9uDtlV2gsX6/tzmz6BqmNgDuIQ6nzlSzyeOIHt99oEMXi3KuStm
 5nbDvtnIUDIkk6211lycoEqvq22CnIJx6PRVGcO16K5RFT0ZLtb0tlEIS4XmeBPYIKotgsON56c
 lLCkYwIOBen8E1TdZ2xOQX2xlXvZj7NGqhM24FybDBG/FM7j06HhIaUUmh7LNvscnczy3nCwXsT
 VroEF37it1J9IQ58t+jp5/pmQZVX1QXdO9/B7gYFnZGvlnKTLb9B9aMNLrRSmdWGSbIX7SfClFh
 PZ2zuXRhgjgtnIYY3JHKC4TfScDTA7Lt4GYpqbWqs
X-Google-Smtp-Source: AGHT+IE2FE18ZWFjwUqtmmGlEX/8Nre/zmTT0yCcMDSD63gQLpLTIm4fnkkQw9kO5ffUrxjU5+ZWNw==
X-Received: by 2002:a05:6e02:190f:b0:424:80f2:2a8 with SMTP id
 e9e14a558f8ab-42d8160110cmr73156885ab.3.1759354195143; 
 Wed, 01 Oct 2025 14:29:55 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/17] boot: Implement a priority for global bootmeths
Date: Wed,  1 Oct 2025 15:26:38 -0600
Message-ID: <20251001212649.3263574-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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
index 5080096cd11..d4c842c00fd 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -249,17 +249,24 @@ static void scan_next_in_uclass(struct udevice **devp)
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
index ec19f8dc436..10c22d15d52 100644
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B2C1091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C42F8405B;
	Thu, 19 Mar 2026 22:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I6QofvnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E7D84090; Thu, 19 Mar 2026 22:36:59 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A385584129
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d7b685faeeso840596a34.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956215; x=1774561015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhlNUjkPsjm4c1jI1BYMMjXbcYB2JoUGrjJ5owZul+s=;
 b=I6QofvnHnY7oY0docN/3zME9B0eRIZrBui2p5D37IWEUxXL+ICmlS3vTMT91VsZJH6
 9Ct8pZ24Nli6+gWyBiDYG+zI8kh46XWTropNJTL4PRbkrF2mL9SIkhv5HznW8aHUtKd0
 dkKU2pCcc4PTW8gWnn6Fgjzb7Uo5m9oGLtUxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956215; x=1774561015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VhlNUjkPsjm4c1jI1BYMMjXbcYB2JoUGrjJ5owZul+s=;
 b=WJ5D0sW/TbFawZh1ve9RyyH54aUiQ9kuMI5/4wS8kxZaNWKPYF5AFJAgw7/rHLcruJ
 MqBPcXAC2+OX7rRPJfJuVtI2Pr5nLc9gjA86rOq7Qs2ZoZ4A47PWTNoRkm23MR9rnUC7
 LSylKvcBRjqOyfKp8Doc+Cfk1/sVXw5ijjp7OhmBqA03beXDhy2VVe6EHTS/5xPGv2YN
 fiO7Z48blpjJiGFmaFSm5c/UXJyrtjUO4/glhjMW1LJZJYCxF0D0+cVNUDzi90dGBPBf
 n3QlqV4CMr2GcaR4Aeh3/kzB6TGik8kqwBKDUDSb8YOmNZGeKTkrjZCBzHH6a9juKto2
 TN/Q==
X-Gm-Message-State: AOJu0Yw3N4j+hOtBeoP7viyUDRK7c8fDd8HZ24euI0oc4+XNMyOaMGm/
 db/g8g9yBYYFM7S9C9W1tuRALBMuUBkWH6xY3kFqDqEyKGRM/8JFw5dgv33JkhlzC/w45jdP2IS
 iengrEQ==
X-Gm-Gg: ATEYQzyzGxNKZE5NE2QgibLny5FOHBWx5uJyUeR+9szvwj2+h6B63Tyw8HO9yJuAS+w
 o/OWIXosOrp9y5PgWHCg05EZBKK4wCMqyk6IiVWmzaKKy/cox/RVOmjLeYLZ3Lfk0v4D+3AT/N2
 SAs3nkOqGi6cIN4pQeVTT8fykpNxt0OSNrBWDOF+yyLxpPjWVan8t5SM8DAMuDswvp8hnASIDV9
 9KDQev1wYxCgWs32UWDP4gNxDIPK5fltUpM5sQG5E4RvDuzSMrFslhrwIH6vb0q6RuFTmM6n+Et
 3rNQgKifxctz/4A+rL4mgN1VceCeO6tOQjmAqqLyNiEdcB/SWZz0swDGSQvJvYAk9nyVEgHF2u9
 /U0E/Yl+GUbhvJf8xusjzvdUWql8N3PJk2akoDkHnJKpwnQeTlz4GBevlElusQt9qzRypnYp4Cc
 YR4VE0E9e2atLqN+flOw==
X-Received: by 2002:a05:6830:4394:b0:7d7:d097:96dc with SMTP id
 46e09a7af769-7d7eaed2bc4mr515774a34.5.1773956214722; 
 Thu, 19 Mar 2026 14:36:54 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 13/15] doc: dm: Document uclass adjunct support
Date: Thu, 19 Mar 2026 15:35:43 -0600
Message-ID: <20260319213551.267031-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

Add a section to the driver model design document describing uclass
adjuncts: what problem they solve, how to register them, and the key
design decisions (probe-time registration, passive lifecycle, shared
iteration lists, automatic data allocation).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/driver-model/design.rst | 134 ++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 633545944d1..f31d63bf026 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -1101,6 +1101,140 @@ While the current implementation is quite simple, it will get evolved
 as the feature is more extensively used in U-Boot subsystems.
 
 
+Uclass Adjuncts
+---------------
+
+In U-Boot's driver model, each device belongs to exactly one uclass. When
+hardware exposes multiple types of functionality (e.g. a Qualcomm clock
+controller that also provides resets and power domains, or a PMIC that also
+provides sysreset), drivers must work around this by creating child devices
+in different uclasses via ``device_bind_driver_to_node()``. This creates
+separate ``U_BOOT_DRIVER`` declarations, ``dev_get_priv(dev->parent)``
+indirection, and scaffolding that has no counterpart in Linux.
+
+Uclass adjuncts (``CONFIG_DM_UC_ADJUNCT``) allow a device to register in
+additional uclasses without creating child devices. Each adjunct carries its
+own ops pointer, per-device uclass private data, and sequence number, just
+like a primary uclass membership.
+
+Adjuncts are declared statically in the driver using a sentinel-terminated
+array of ``struct driver_adjunct``::
+
+   static const struct driver_adjunct my_adjuncts[] = {
+       { UCLASS_RESET, &my_reset_ops },
+       { UCLASS_POWER_DOMAIN, &my_pd_ops },
+       { }
+   };
+
+   U_BOOT_DRIVER(my_driver) = {
+       .name     = "my_driver",
+       .id       = UCLASS_CLK,
+       .adjuncts = my_adjuncts,
+       ...
+   };
+
+Driver model registers static adjuncts automatically at bind time and
+allocates their private data at probe time. Adjuncts may also be
+registered dynamically using ``device_add_uclass_adj()`` for cases where
+membership is conditional (e.g. based on device-tree properties)::
+
+   static int my_driver_probe(struct udevice *dev)
+   {
+       if (dev_read_bool(dev, "has-reset"))
+           device_add_uclass_adj(dev, UCLASS_RESET, &my_reset_ops);
+
+       return 0;
+   }
+
+The device then appears in lookup functions for each adjunct uclass (e.g.
+``uclass_find_device_by_ofnode()`` for ``UCLASS_RESET`` finds this device).
+Subsystem code retrieves the adjunct ops with ``device_get_uclass_ops()``::
+
+   const struct reset_ops *ops = device_get_uclass_ops(dev, UCLASS_RESET);
+
+``device_add_uclass_adj()`` binds the adjunct (allocating uclass platform
+data and a sequence number) and, if the device is already probed, also
+allocates uclass private data. Per-device uclass platform and private data
+are allocated automatically if the adjunct's uclass driver requests them
+via ``per_device_plat_auto`` / ``per_device_auto``. Sequence numbers are
+allocated from the adjunct uclass's namespace to avoid collisions.
+
+Adjunct uclasses participate in lifecycle hooks: ``post_bind`` is called
+when the adjunct is bound, ``post_probe`` when private data is allocated,
+``pre_remove`` when private data is freed, and ``pre_unbind`` when the
+adjunct is torn down. Child hooks (``child_post_bind``, etc.) do not apply
+to adjuncts since they do not change the parent-child relationship.
+
+At remove time, ``device_remove_adjs()`` calls ``pre_remove`` and frees only
+the uclass private data; the adjunct remains bound.
+``device_unbind_adjs()`` at unbind time calls ``pre_unbind`` and fully
+tears down the adjunct memberships.
+
+Primary and adjunct entries share the same ``dev_head`` list on each
+uclass. Adjuncts are full members of their uclass: they have sequence
+numbers, appear in iteration, and are found by lookup functions. This
+means a lookup may return a device whose primary uclass differs from the
+one searched. This is by design: the device genuinely provides that
+uclass's functionality.
+
+All ``uclass_`` lookup and iteration functions include adjuncts:
+
+- Attribute lookups: ``uclass_find_device_by_ofnode()``,
+  ``uclass_find_device_by_name()``, ``uclass_find_device_by_seq()``,
+  ``uclass_find_device_by_phandle()``, ``uclass_get_device_by_driver()``
+- Index-based: ``uclass_find_device()``, ``uclass_id_count()``
+- Iteration: ``uclass_foreach_dev()``, ``uclass_foreach_dev_safe()``,
+  ``uclass_foreach_dev_probe()``
+
+The only exceptions are ``uclass_find_first_device()`` and
+``uclass_find_next_device()``, which use ``struct udevice *`` as the
+iteration cursor. For an adjunct entry, ``dev->ucm.uc_node`` points into
+the primary uclass's list rather than the adjunct uclass's, so there is
+no way to advance to the next member. The following functions all skip
+adjuncts for this reason:
+
+- ``uclass_find_first_device()`` / ``uclass_find_next_device()``
+- ``uclass_first_device()`` / ``uclass_next_device()``
+- ``uclass_first_device_err()`` / ``uclass_next_device_err()``
+- ``uclass_first_device_check()`` / ``uclass_next_device_check()``
+- ``uclass_probe_all()``
+
+Code that needs to iterate all members including adjuncts should use
+``uclass_foreach_dev()`` or the ``ucm_`` API instead.
+
+The ``ucm_`` API provides adjunct-aware iteration and lookup using
+``struct uclass_member *`` as the cursor. Since the cursor sits directly on
+the uclass's member list, it can traverse all entries including adjuncts
+without ambiguity. The API mirrors the existing ``uclass_`` iterator
+functions:
+
+- ``ucm_find_first()`` / ``ucm_find_next()`` -- iterate without probing
+- ``ucm_first()`` / ``ucm_next()`` -- probe and skip failures
+- ``ucm_first_check()`` / ``ucm_next_check()`` -- probe and report errors
+- ``ucm_first_drvdata()`` -- find by driver data
+- ``ucm_try_first()`` -- no probe, NULL on missing uclass
+- ``ucm_find_seq()`` -- find by sequence number
+- ``ucm_find_by_ofnode()`` -- find by device-tree node
+
+Use ``ucm->dev`` to obtain the device from a member pointer.
+
+``device_get_uclass_ops()`` resolves ops for a given uclass ID, searching
+both primary and adjunct memberships. ``device_get_uclass_priv()``
+and ``device_get_uclass_plat()`` do the same for per-device uclass
+private and platform data. Subsystem code should use these instead of the
+plain ``dev_get_uclass_*()`` accessors when the device may have been found
+via an adjunct lookup. When ``CONFIG_DM_UC_ADJUNCT`` is disabled, these map
+to the plain accessors with no overhead.
+
+``dev_get_priv()`` and ``dev_get_plat()`` always return the driver's own
+data, regardless of which uclass the device was found through. This is one
+of the main benefits of adjuncts over child devices: no
+``dev_get_parent()`` indirection is needed.
+
+When ``CONFIG_DM_UC_ADJUNCT`` is disabled, all adjunct functions are
+stubbed as inlines so callers do not need ``#ifdef`` guards.
+
+
 Changes since v1
 ----------------
 
-- 
2.43.0


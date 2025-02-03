Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DEC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C670980562;
	Mon,  3 Feb 2025 16:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q0Iwt7dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD9880391; Mon,  3 Feb 2025 16:10:45 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D20801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D589A3FA59
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738595441;
 bh=iXCBNLFn6IXEjJS9CgnkgN8NjK6iP8q/Qhv1Fm1MCuo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Q0Iwt7dm8K4bGunWgolrVJTtXio7yLLveHZgZZWxC9ij0HceeFnHCnPh1mYraxXKW
 w5hU5eJOMnCgwYz2ETJ0raMG45Lk3c0QvGZWtZ88P1RoJDNxqyg6awBOH7cL/zOMh6
 0eXZTVCiuwz7JHS6CUxk605Hsh3qV3X5hGHaMRrBi8UHZZae/0K1iNID2DUOAaediM
 LEh8sKTyI5Bd+iLeuvHXs0FRDX8PyOPVKRY1ebTBEPRfYE90ErAa0pID+meIHL4Sgm
 lzaG3zMRJvbIsnieW5AkhbkSAH7ZgmaD8iJ4VeyhnLHBjho3aY6UJEwtxmXNKy0SYT
 tqQ6E4+f2niOg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso24106725e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595441; x=1739200241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXCBNLFn6IXEjJS9CgnkgN8NjK6iP8q/Qhv1Fm1MCuo=;
 b=PA7GWqu8UQt4EX0TwaEhOQG5O+EGj9T7PGmFhSuD9cPedqk48b6DmrYtHx+FfOxwxv
 bohg8+rSFmRTZBcO/Px0LSgWizDera0Gq0cnjhXOIqhw0ngG+eK8VOkRZ4pcEphIV/W3
 pWeTkeF1qEADMe+N4ZoD+riwMLALw1ta2HFA386Gb4IeItYpUbvgQ5NEFO3eZSqZRiuQ
 /BGP+vyDXrSD/f9ep3OoLgIt5x9e7pgGAFIGE+AZ7KJbd/5Z5CNf5KezWCAATsKJwy82
 mqGP93FnlM7sI97q4bx3DpmBFAObCUc3XivJUS+1aG/wjwzASwGqhUKcQzulTFHSaViv
 4MBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTh8or1kglC2PM/q8n06ys7qs0r/7CdzG2o7fwtYn0DS86+z+k5P2AyFjw+cfhantbfuNalAM=@lists.denx.de
X-Gm-Message-State: AOJu0YzIdNdoG55KoBMrXfHyNw5ku7bADVzE8A2RuHeySX42Zd+AZe+d
 hkjwJRvy3+AyG70vhzkVeUrdG9jj6sfyBv1VvZc/4TGfiP4KPlA82d4APk7X1nkFHZ+c/TNM6kp
 LW8GQcBjSN1ZkELlBjrz0ogo52+pX5Syue65yXVUBQARm0tFwNbYh0EbDE0fb3ZYRXBo=
X-Gm-Gg: ASbGnctkEbenBb30tD5gsYwzl+hubJDUx1KPDkFkU+vUY1pr1EcmOgAmss2cMXh2FCt
 C6dVgvXLX2qxCIzs4Ph1GFw9XfXd13eKjOCvSmZC265up91xIzYHuOgTAsREy/CpYH+S1pOxD0G
 DdgeZkG/guY60GQCv8TornSomp7q6skChlMlRZLMG0pE+CUUuK+cB4qZSxIBEeGOHY4wvy8X9Sx
 trSHl266sWkNULXMvZ9qoXEcqUoB3FpI7tC6/JHAdp16cWTOGCyqcEuHd3J5b4b5QRT+PF4BqjB
 t8iPB1EUtct8lCGUlyQUIXRJNposd6Q0Uu+wJTY=
X-Received: by 2002:adf:f4d2:0:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-38c51b5d898mr15071071f8f.31.1738595440863; 
 Mon, 03 Feb 2025 07:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXmN5xkzxb7G3cjKQCQoEsjr8/BR8sA3ODoPd1mayR6NeptNxWKhSpw+eIllb7tAo38QyXRg==
X-Received: by 2002:adf:f4d2:0:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-38c51b5d898mr15071032f8f.31.1738595440466; 
 Mon, 03 Feb 2025 07:10:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102f7dsm13235419f8f.30.2025.02.03.07.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 07:10:40 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/4] test: remove available memory check in
 setexpr_test_str()
Date: Mon,  3 Feb 2025 16:10:27 +0100
Message-ID: <20250203151029.60265-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
References: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
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

env_set() frees the previous value after allocating the new value.
As the free() may merge memory chunks the available memory is not
expected to stay constant.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	new patch
---
 test/cmd/setexpr.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index cc2003faab5..519912a8e22 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -297,31 +297,18 @@ SETEXPR_TEST(setexpr_test_backref, UTF_CONSOLE);
 /* Test 'setexpr' command with setting strings */
 static int setexpr_test_str(struct unit_test_state *uts)
 {
-	ulong start_mem;
 	char *buf;
 
 	buf = map_sysmem(0, BUF_SIZE);
 	memset(buf, '\xff', BUF_SIZE);
 
-	/*
-	 * Set 'fred' to the same length as we expect to get below, to avoid a
-	 * new allocation in 'setexpr'. That way we can check for memory leaks.
-	 */
 	ut_assertok(env_set("fred", "x"));
-	start_mem = ut_check_free();
 	ut_asserteq(1, run_command("setexpr.s fred 0", 0));
-	ut_assertok(ut_check_delta(start_mem));
 
 	strcpy(buf, "hello");
 	ut_assertok(env_set("fred", "12345"));
-	start_mem = ut_check_free();
 	ut_assertok(run_command("setexpr.s fred *0", 0));
 	ut_asserteq_str("hello", env_get("fred"));
-	/*
-	 * This fails in CI at present.
-	 *
-	 * ut_assertok(ut_check_delta(start_mem));
-	 */
 
 	unmap_sysmem(buf);
 
-- 
2.47.1


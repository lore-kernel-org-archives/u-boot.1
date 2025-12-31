Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6919EE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED2C84191;
	Wed, 31 Dec 2025 20:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BcFgXmoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89508418A; Wed, 31 Dec 2025 20:11:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 001588408D
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2A303F871
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767208274;
 bh=es97WWMI5G1djZuzuYrn/j48uiSyf02rje+JgYw1WZw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BcFgXmoGPS1+BQ3gJ81tg9HqhrfDVFJmqjfW3ykovDVmlinTBubNwHH7r8Yr/7eDi
 6jFhQZSS/M+8GW318LQ23udde2Wb9PteBWsEoZo8Lzo5N3UOFsiOVzq3TC71+/GJJA
 TjvhGEFlEN5wYnlqMKLhw9tzCwEInH4BMO5LxCMOELia+e0JUAtHtKXbFjNxqeZU0f
 gJVlIVM2+xwte2GtLRo4lQU88jl/77ladIP8EVCw2tkr9YxWt9seST6hNv6m60bIPX
 oAxzec6UKMWH6Ynq4WkuYgQKRw3Qr9a+e8GzIAgRcT1n6cQvu3lzFX8WIw4x/v939i
 tS3yxbDQyKIONRA4LsJS6FsaSIQotLh7dT+ztARPFm87nRSjSDnG/ArhITVf1sRdDX
 gbLcBSdfVrSFdHEW+31cMEgmUIFqyhX682Yri+qdMEqeGIXcW0tBtKCoafgoh+cskQ
 4ikrwjq5eRagesJ4MaKkx5ascNMBQVpkPife3iwJgtdtR9Zmlq6PFYYm59IC0/5tGs
 7BuVVEhhzsw+lOYS0MoLDcJCU/jl2Nnl8SLrFiqXMyG4X3rGBQCMSh1lEXsHe/Ybhr
 B0P3rEpFikQ/i21Bm9cIGeVUOApQ+oj+PmAXh1gG1sURBP+gBvec2cFnTMIMw9/be9
 Rk5abdGPwRSbqGuIRPXi2MJk=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so97828155e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208274; x=1767813074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=es97WWMI5G1djZuzuYrn/j48uiSyf02rje+JgYw1WZw=;
 b=Ke4L4gIz8JqKxIkb0T5R7zNMqKZel/F4PaqSgmmQSj7aDJgVHOPgK+Go2vkBCHISKa
 RzSR7nKufW0PtetQP3MpCld8ta1uKV1+30c8QCfWL2DQXwNxvnFJdBWTF+cQxofeluhR
 HniWcenICZextDcJfYrphR6BPql3lweNTc2zO1d0UrWlQfhe2DUP1d/J+AEcrVqB1zSD
 fU+XJvw0uEkD+CwwH/XRCz13YnII4uVyBBG+P92AyYuzVI4ooV61A9y+Nhp5aXh5Z3Uu
 OEot4SYO1KfSKciUhCa6x0K34Cv9nHX/waSNlqVIJBtm6kHra0p4C655MrlzPMEIOGev
 B8nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT6BnlaG91acQL9/V0wP1Z/02oaav4G1ptNEeBqmI2zBr4yHyfIcemU7y5bPSxZnGYQUT+0Bc=@lists.denx.de
X-Gm-Message-State: AOJu0YwUxEnnxTfGW8r+qm5sgx7/dkSqx5zEFy0LG8zhkPYJgGU6aJcW
 bBYLuLcLI5rxtwZ2Eg/0GyiBIbHwnH1+2lu70/XcRwgz9JMVQJus+NrTQ0JjM6mPA+2Z+qZzi4t
 C5yQK/u1epima/WOdL5vby1ZOU6j4Br9QvvmuwbDbMYduXp+uGVneHO8Kbdco8KG3HyW6ug0=
X-Gm-Gg: AY/fxX4yVPSM8fropDuKdcbHAPu1VDqT9+laksRgBXw0w+TOU0EXQoFYRHty/9jesD6
 5Y5Cmm2qsPfthlrAY9DjGhPHZNi9NwnveVx1S/1yLV34PjSvmSaj1cFj11/fwjTMLLm5FDY4zBa
 5jrrjdUflRT05A8HlENSGi3oNO2kY2FuQN5/SrVCDHhkAeJNHto7JuoDE5EaKiqNNEfBEqVQDDU
 eL2t6KPIIFyM4H+gdl61R1ZgwnrIZOEhaf8c2fs3t7UX2wVDVNk2sBKM3en5auH4kg5a6VYCaNY
 eJ8GO6l0JPKvYqeDOU39C0ZKxcW4R+quXldR1C/Ipzvc8y0Gm0ZAXuYumYvyqqpD0M2rCBwXeH/
 DbWp+7HHPWJdGQMoeL8QZVCu90ndIA31ddom0Xl2IHA0gKjlXTJioGOTpcRSlNb1kDgN1vHAJIO
 Yt
X-Received: by 2002:a05:600c:4e42:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d1956eb65mr355062625e9.2.1767208274184; 
 Wed, 31 Dec 2025 11:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrk/XJ1LSIvnfVU6P15ah+rjdV6KYBuhQ9NbEhruhzeXNAmNUPWPXn3ZDtYNWSN9NK+OU/yg==
X-Received: by 2002:a05:600c:4e42:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d1956eb65mr355062455e9.2.1767208273859; 
 Wed, 31 Dec 2025 11:11:13 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm701685995e9.5.2025.12.31.11.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:11:13 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] test: do not imply os_malloc() outside of the sandbox
Date: Wed, 31 Dec 2025 20:10:52 +0100
Message-ID: <20251231191054.247270-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
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

When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y the C compiler does not
execute all optimization paths and add a reference to os_malloc().

Remove the reference if CONFIG_SANDBOX=n using #ifdef.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/test-main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/test-main.c b/test/test-main.c
index 3254325e8b1..1815d60acf7 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -734,6 +734,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 
 	uts->of_root = gd_of_root();
 	uts->runs_per_test = runs_per_test;
+#ifdef CONFIG_SANDBOX
 	if (fdt_action() == FDTCHK_COPY && gd->fdt_blob) {
 		uts->fdt_size = fdt_totalsize(gd->fdt_blob);
 		uts->fdt_copy = os_malloc(uts->fdt_size);
@@ -743,6 +744,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 		}
 		memcpy(uts->fdt_copy, gd->fdt_blob, uts->fdt_size);
 	}
+#endif
 	uts->force_run = force_run;
 	ret = ut_run_tests(uts, prefix, tests, count, select_name,
 			   test_insert);
-- 
2.51.0


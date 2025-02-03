Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0A5C02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC37805DA;
	Mon,  3 Feb 2025 16:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Socd56cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EC280077; Mon,  3 Feb 2025 16:10:46 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F89880207
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAD413FA56
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738595442;
 bh=FjZIShlPlMEpnqtlsWd0W4BaVv4TVGsqVA8hMtYqeoI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Socd56cpBL1QuzyU4yzNpbbAEXqhriQeHmvmhqOWjLZRuDKNCZFH+bSF0S/Fx7kOz
 wpDbLAHE1dqQSL5gypOsXHx+ZUrw2kYUFYU0/gwZR3ZTFmdAvhLXBJPUBAbIsDVJHB
 1Jf+kKP+p2irYfkBDSmE40uB0GRokSLZ6ib0ZdqhHQfe5bNwEZV8wHKglvgg11oFYk
 U22EKiDhMK5xaOIcO0BYzMt9VNywijk9tFlr4vs/rtCKBAwrCaFK5xBZ/gE435IQHQ
 k100SdQjXexmZ+A3ppv+sKudPztS04q1NRvZMu+MNGvB5VRxl4n5GowZJaEMkMxPsg
 D9cfqfV4fA3Ow==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38c24cd6823so2290143f8f.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595442; x=1739200242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjZIShlPlMEpnqtlsWd0W4BaVv4TVGsqVA8hMtYqeoI=;
 b=um1odVujMtZwNdXJghr/PqL46DGEVbqOKSt49QmzzSQutk+1PeVMuZEUhU5BGHyV82
 YFPUDHZWM9R7sTq4lpp1IjaADIPizUJzGVCegsUElI+1n0YfcOX9Z0BzSxhlxHPkPOWo
 mBcNPzNoyy46y07YYOZrbSMBwRDzYCRND0IEsnJLiZo51wj3gH3gTCmBfg2UC0QoVIV8
 LiHT5+Qqb4es3km6vD3R1ts89lYsDvUHTSOfjtZ+fErBe9DcLWOg/zdrRgnHOolCIfPu
 C57FqbK9gQODg6tjmdQ0zXtWVRRwcdvUEImkh3wWf9Ad7a8GlDUgUrPNnogw2Ecsp/av
 +W7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoUuFwVn0EbD2sFuY4gabOuVtJnJBRrMh0Uq1SkzudraJX3bhhmzExR48OqNIfPLbdfCCCln4=@lists.denx.de
X-Gm-Message-State: AOJu0YxXnfUTXYvaAZXfZ7BNXWINc5bVRvjuAeX1tS4+953BrsKUXU5I
 vAbhnzx30Hv1hEtNpK3BJ7nPONiDZgtQzaMYotuw7iUrDi4IVyQMo2aODh+m08P59qLW1bNSvvx
 vFOajr1xb3Epno4c+VpzmR6RI+xv+qezeGsX5h6q0Uo1xMopT4EEpp7hramMDK5JGehk=
X-Gm-Gg: ASbGncsRI9nsSIYfHBz6FQFXFBMOql6tKS6PMq5U0gWU6englDaGE5R7jHPs1c9n43/
 qf2V45mZ7k6M2j1n+QleUqwMs7w8gpVmhFiQ2F0Kit9lMBgyvdMxDBGFkK8g8dby7N6Jhga3wKm
 zro7ESwUj9RDHfGWvlDhG/IOLOY2Ntj+YOayweYT8GBTgAzBiC7KwUb59zPqo32rJLU7Ks+QEuf
 5NWu2ZSGtTNcrXcjYNrSQYvkqQGPiPMn7XCpJri5KlkgxBX1+1TROEHmSTU9auyUN7H9pamI1VA
 nVPSbqYFZmIi4UthehTf1Mlr63D1B3dKcCTgz/Y=
X-Received: by 2002:a5d:64ec:0:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38c60f657admr12450151f8f.20.1738595442040; 
 Mon, 03 Feb 2025 07:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBM/bBvtimnA54IfLRTXJ60BT7FzEc2DMo2b1OcpfzE/Yd5qwRc00V/WR5e4qctlrGPpb5xw==
X-Received: by 2002:a5d:64ec:0:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38c60f657admr12450116f8f.20.1738595441654; 
 Mon, 03 Feb 2025 07:10:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102f7dsm13235419f8f.30.2025.02.03.07.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 07:10:41 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/4] test: remove available memory check in
 setexpr_test_str_oper()
Date: Mon,  3 Feb 2025 16:10:28 +0100
Message-ID: <20250203151029.60265-4-heinrich.schuchardt@canonical.com>
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
 test/cmd/setexpr.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 519912a8e22..650fbc8ebee 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -319,7 +319,6 @@ SETEXPR_TEST(setexpr_test_str, UTF_CONSOLE);
 /* Test 'setexpr' command with concatenating strings */
 static int setexpr_test_str_oper(struct unit_test_state *uts)
 {
-	ulong start_mem;
 	char *buf;
 
 	buf = map_sysmem(0, BUF_SIZE);
@@ -327,37 +326,14 @@ static int setexpr_test_str_oper(struct unit_test_state *uts)
 	strcpy(buf, "hello");
 	strcpy(buf + 0x10, " there");
 
-	start_mem = ut_check_free();
 	ut_asserteq(1, run_command("setexpr.s fred *0 * *10", 0));
-	ut_assertok(ut_check_delta(start_mem));
 	ut_assert_nextline("invalid op");
 	ut_assert_console_end();
 
-	/*
-	 * Set 'fred' to the same length as we expect to get below, to avoid a
-	 * new allocation in 'setexpr'. That way we can check for memory leaks.
-	 */
 	ut_assertok(env_set("fred", "12345012345"));
-	start_mem = ut_check_free();
 	ut_assertok(run_command("setexpr.s fred *0 + *10", 0));
 	ut_asserteq_str("hello there", env_get("fred"));
 
-	/*
-	 * This check does not work with sandbox_flattree, apparently due to
-	 * memory allocations in env_set().
-	 *
-	 * The truetype console produces lots of memory allocations even though
-	 * the LCD display is not visible. But even without these, it does not
-	 * work.
-	 *
-	 * A better test would be for dlmalloc to record the allocs and frees
-	 * for a particular caller, but that is not supported.
-	 *
-	 * For now, drop this test.
-	 *
-	 * ut_assertok(ut_check_delta(start_mem));
-	 */
-
 	unmap_sysmem(buf);
 
 	return 0;
-- 
2.47.1

